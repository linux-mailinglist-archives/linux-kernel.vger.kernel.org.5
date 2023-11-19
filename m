Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A4F7F080C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 18:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbjKSRPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 12:15:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbjKSRPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 12:15:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F77C0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 09:15:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BEBFC433C9;
        Sun, 19 Nov 2023 17:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700414134;
        bh=YDy2xpgd3SqWOCCdmUAUqNT0vwzIyx0UHeHWEu/iyRc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LjylG+h6XhlGYO3Ub30LrxVW6R/8F/y1CvnVEtKokrXHOcCFNtYWT2iWfNIgY/B4K
         3cS78u1fskzF0FeyFDELRMq5TGWSesXNl4/W3mWmuwYfRQzZCmNw2+gsO/6c275yI9
         lnjz95ZZZsA805p85xdm8l6+tEmOblMYoWkYqyFUbkXTk+r7NIa6hTPjWBd3AZosuH
         LLNMn21EXI7PiMbDrpx86j1jLp87JOZAMKgeIQcRxzMvYWHk33LKX6OR/pCBN4wNAQ
         C0S+WwA3iwQFHhmX4KpoAXFc6YTFVbPHaWIr7m+e21K+AGomVHVN1WYJN3Qvl7KYEG
         MiEfdSmcOp5uw==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, damon@lists.linux.dev,
        linux-mm@kvack.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mm/damon/core-test: test damon_split_region_at()'s access rate copying
Date:   Sun, 19 Nov 2023 17:15:29 +0000
Message-Id: <20231119171529.66863-2-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231119171529.66863-1-sj@kernel.org>
References: <20231119171529.66863-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

damon_split_region_at() should set access rate related fields of the
resulting regions same.  It may forgotten, and actually there was the
mistake before.  Test it with the unit test case for the function.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core-test.h | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
index 649adf91ebc5..e6a01ea2ec54 100644
--- a/mm/damon/core-test.h
+++ b/mm/damon/core-test.h
@@ -122,18 +122,25 @@ static void damon_test_split_at(struct kunit *test)
 {
 	struct damon_ctx *c = damon_new_ctx();
 	struct damon_target *t;
-	struct damon_region *r;
+	struct damon_region *r, *r_new;
 
 	t = damon_new_target();
 	r = damon_new_region(0, 100);
+	r->nr_accesses_bp = 420000;
+	r->nr_accesses = 42;
+	r->last_nr_accesses = 15;
 	damon_add_region(r, t);
 	damon_split_region_at(t, r, 25);
 	KUNIT_EXPECT_EQ(test, r->ar.start, 0ul);
 	KUNIT_EXPECT_EQ(test, r->ar.end, 25ul);
 
-	r = damon_next_region(r);
-	KUNIT_EXPECT_EQ(test, r->ar.start, 25ul);
-	KUNIT_EXPECT_EQ(test, r->ar.end, 100ul);
+	r_new = damon_next_region(r);
+	KUNIT_EXPECT_EQ(test, r_new->ar.start, 25ul);
+	KUNIT_EXPECT_EQ(test, r_new->ar.end, 100ul);
+
+	KUNIT_EXPECT_EQ(test, r->nr_accesses_bp, r_new->nr_accesses_bp);
+	KUNIT_EXPECT_EQ(test, r->nr_accesses, r_new->nr_accesses);
+	KUNIT_EXPECT_EQ(test, r->last_nr_accesses, r_new->last_nr_accesses);
 
 	damon_free_target(t);
 	damon_destroy_ctx(c);
-- 
2.34.1

