Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457477D02C3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 21:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346549AbjJSTtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 15:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346477AbjJSTtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 15:49:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD157CA;
        Thu, 19 Oct 2023 12:49:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01A42C433CB;
        Thu, 19 Oct 2023 19:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697744971;
        bh=mCKYxJG6okaaxTlaAJiDWBfMeecgvhed2+n6U1OL4CI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DIpRll2dkGyuM/W1HY/OtCJ0rVq9bgajq0d8Ehg4VUWQ+lGFeTkQxBJjxh7927Hi9
         uKHjKJjL5AQ5O6adkHXP684YQsUouzmOfAujbPozk8M3KHgXEKdIzLfxfiwsDdnxES
         boqYYS+F2Jcj+R1reI40WC6tfNeK0UiQnh1EFUyCvLYx6pyLPpEbJJGzu46FKY0IoY
         Fvl84swfOFhwCdZh9ZJzhO3w35UPmexJuKUte56Gfe7CwJJGB/j0sX3xffpEeDHNmN
         6bP2glF0upzkOFUED5Q+3MUI51uFt0C67sqqVbo4OutJCy735/57FsWLl7U5qaOmjD
         A31VZ5YTiz7Jg==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH 2/5] mm/damon/core: avoid divide-by-zero during monitoring results update
Date:   Thu, 19 Oct 2023 19:49:21 +0000
Message-Id: <20231019194924.100347-3-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019194924.100347-1-sj@kernel.org>
References: <20231019194924.100347-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When monitoring attributes are changed, DAMON updates access rate of the
monitoring results accordingly.  For that, it divides some values by the
maximum nr_accesses.  However, due to the type of the related variables,
simple division-based calculation of the divisor can return zero.  As a
result, divide-by-zero is possible.  Fix it by using
damon_max_nr_accesses(), which handles the case.

Fixes: 2f5bef5a590b ("mm/damon/core: update monitoring results for new monitoring attributes")
Cc: <stable@vger.kernel.org> # 6.3.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 9f4f7c378cf3..e194c8075235 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -500,20 +500,14 @@ static unsigned int damon_age_for_new_attrs(unsigned int age,
 static unsigned int damon_accesses_bp_to_nr_accesses(
 		unsigned int accesses_bp, struct damon_attrs *attrs)
 {
-	unsigned int max_nr_accesses =
-		attrs->aggr_interval / attrs->sample_interval;
-
-	return accesses_bp * max_nr_accesses / 10000;
+	return accesses_bp * damon_max_nr_accesses(attrs) / 10000;
 }
 
 /* convert nr_accesses to access ratio in bp (per 10,000) */
 static unsigned int damon_nr_accesses_to_accesses_bp(
 		unsigned int nr_accesses, struct damon_attrs *attrs)
 {
-	unsigned int max_nr_accesses =
-		attrs->aggr_interval / attrs->sample_interval;
-
-	return nr_accesses * 10000 / max_nr_accesses;
+	return nr_accesses * 10000 / damon_max_nr_accesses(attrs);
 }
 
 static unsigned int damon_nr_accesses_for_new_attrs(unsigned int nr_accesses,
-- 
2.34.1

