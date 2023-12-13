Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3E1811DF0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442028AbjLMTDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:03:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379292AbjLMTDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:03:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9126595
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:03:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC743C433C8;
        Wed, 13 Dec 2023 19:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702494229;
        bh=gjBQjP/YI+pvMOKNh4ddMdbLJ3KLmfM9HXn1Dp4kPVs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gh6j4zF8l93bobVI7GSErZD+7LyrzAOafaTw/R+gygXqiWV4CRdqWwXQ4WHnfcO5A
         ntCVTNa3MG2BjUATa9SvAKwQAfINk5MJbH1cQsimTz2xBRm2XyU16JA/pkCDCVZBLM
         tYqx26QhH06nd6+RI/CnV0NU7hK5ynOAW+Z0EaxqXgVK7aTJLDK+cN15J+KLBe+wGl
         FPY1GTm8dlM/DZ8CdH2eMVZ9cww7cSXDsMBAbUrukA7Khyyau/bnOZiSGqHIhpwnXk
         UQuZluFbU+/gS0nN3hGdfFYeZSaojRVgc0zs0RTAEI3p5ZqKWxiCp7cU9I6UkJIWWW
         PXaXBm0veoOYA==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] mm/damon/core-test: test max_nr_accesses overflow caused divide-by-zero
Date:   Wed, 13 Dec 2023 19:03:34 +0000
Message-Id: <20231213190338.54146-3-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213190338.54146-1-sj@kernel.org>
References: <20231213190338.54146-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 35f5d94187a6 ("mm/damon: implement a function for max nr_accesses
safe calculation") has fixed an overflow bug that could cause
divide-by-zero.  Add a kunit test for the bug to ensure similar bugs are
not introduced again.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core-test.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
index 876e398557b0..0cee634f3544 100644
--- a/mm/damon/core-test.h
+++ b/mm/damon/core-test.h
@@ -302,6 +302,16 @@ static void damon_test_set_regions(struct kunit *test)
 	damon_destroy_target(t);
 }
 
+static void damon_test_nr_accesses_to_accesses_bp(struct kunit *test)
+{
+	struct damon_attrs attrs = {
+		.sample_interval = 10,
+		.aggr_interval = ((unsigned long)UINT_MAX + 1) * 10
+	};
+
+	KUNIT_EXPECT_EQ(test, damon_nr_accesses_to_accesses_bp(123, &attrs), 0);
+}
+
 static void damon_test_update_monitoring_result(struct kunit *test)
 {
 	struct damon_attrs old_attrs = {
@@ -487,6 +497,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_split_regions_of),
 	KUNIT_CASE(damon_test_ops_registration),
 	KUNIT_CASE(damon_test_set_regions),
+	KUNIT_CASE(damon_test_nr_accesses_to_accesses_bp),
 	KUNIT_CASE(damon_test_update_monitoring_result),
 	KUNIT_CASE(damon_test_set_attrs),
 	KUNIT_CASE(damon_test_moving_sum),
-- 
2.34.1

