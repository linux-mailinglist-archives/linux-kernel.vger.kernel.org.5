Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBE175733E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 07:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjGRFgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 01:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjGRFf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 01:35:59 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8044DE43
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 22:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689658558; x=1721194558;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pwZocxuhvbEdDjmw/S2Egp+TSxBuSC1aQBEepbrfUJ8=;
  b=aHacLJLVyNbrt+FX5DndepfbvHNLAC+Kgv4wtU40bKh+Wa2o3jK06c72
   +a/Okui3vbTE7JJhCb6sV9QVZf0DzzYxGgobh4gj0sq5O3x9TC8XOXm9i
   /bx2pYMuel3sisLTXEDCtfZtt4XolKqo34XcFoUtDbdx2HXRZ2c4rrw67
   jL2Rpsn/bJOYtRmjQuaGBT/wH9CMGWXOv4Fo9YAr8d84540EVt6Pdyttk
   4X8iieY49N0VAa8Iu8LRAE1F4wfhIhcyql9bN5SJo6uQs3v1Gfzabx9Y5
   wZZZPgxj/kQvy4AsSoOh3T8TvT3GXhLgitPNVxdiZ1EYGDlpKQafMefyO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="432293560"
X-IronPort-AV: E=Sophos;i="6.01,213,1684825200"; 
   d="scan'208";a="432293560"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 22:35:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="970104267"
X-IronPort-AV: E=Sophos;i="6.01,213,1684825200"; 
   d="scan'208";a="970104267"
Received: from feng-clx.sh.intel.com ([10.238.200.228])
  by fmsmga006.fm.intel.com with ESMTP; 17 Jul 2023 22:35:56 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Feng Tang <feng.tang@intel.com>
Subject: [PATCH] mm/damon/core-test: Initialise context before test in damon_test_set_attrs()
Date:   Tue, 18 Jul 2023 13:28:11 +0800
Message-Id: <20230718052811.1065173-1-feng.tang@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running kunit test for 6.5-rc1 hits one bug:

        ok 10 damon_test_update_monitoring_result
    general protection fault, probably for non-canonical address 0x1bffa5c419cfb81: 0000 [#1] PREEMPT SMP NOPTI
    CPU: 1 PID: 110 Comm: kunit_try_catch Tainted: G                 N 6.5.0-rc2 #15
    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
    RIP: 0010:damon_set_attrs+0xb9/0x120
    Code: f8 00 00 00 4c 8d 58 e0 48 39 c3 74 ba 41 ba 59 17 b7 d1 49 8b 43 10 4d
    8d 4b 10 48 8d 70 e0 49 39 c1 74 50 49 8b 40 08 31 d2 <69> 4e 18 10 27 00 00
    49 f7 30 31 d2 48 89 c5 89 c8 f7 f5 31 d2 89
    RSP: 0000:ffffc900005bfd40 EFLAGS: 00010246
    RAX: ffffffff81159fc0 RBX: ffffc900005bfeb8 RCX: 0000000000000000
    RDX: 0000000000000000 RSI: 01bffa5c419cfb69 RDI: ffffc900005bfd70
    RBP: ffffc90000013c10 R08: ffffc900005bfdc0 R09: ffffffff81ff10ed
    R10: 00000000d1b71759 R11: ffffffff81ff10dd R12: ffffc90000013a78
    R13: ffff88810eb78180 R14: ffffffff818297c0 R15: ffffc90000013c28
    FS:  0000000000000000(0000) GS:ffff88813bd00000(0000) knlGS:0000000000000000
    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    CR2: 0000000000000000 CR3: 0000000002a1c001 CR4: 0000000000370ee0
    DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
    DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
    Call Trace:
     <TASK>
     damon_test_set_attrs+0x63/0x1f0
     kunit_generic_run_threadfn_adapter+0x17/0x30
     kthread+0xfd/0x130

The problem seems to be related with the damon_ctx was used without
being initialized. Fix it by adding the initialization.

Fixes: aa13779be6b7 ("mm/damon/core-test: add a test for damon_set_attrs()")
Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 mm/damon/core-test.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
index c11210124344..bb07721909e1 100644
--- a/mm/damon/core-test.h
+++ b/mm/damon/core-test.h
@@ -320,25 +320,25 @@ static void damon_test_update_monitoring_result(struct kunit *test)
 
 static void damon_test_set_attrs(struct kunit *test)
 {
-	struct damon_ctx ctx;
+	struct damon_ctx *c = damon_new_ctx();
 	struct damon_attrs valid_attrs = {
 		.min_nr_regions = 10, .max_nr_regions = 1000,
 		.sample_interval = 5000, .aggr_interval = 100000,};
 	struct damon_attrs invalid_attrs;
 
-	KUNIT_EXPECT_EQ(test, damon_set_attrs(&ctx, &valid_attrs), 0);
+	KUNIT_EXPECT_EQ(test, damon_set_attrs(c, &valid_attrs), 0);
 
 	invalid_attrs = valid_attrs;
 	invalid_attrs.min_nr_regions = 1;
-	KUNIT_EXPECT_EQ(test, damon_set_attrs(&ctx, &invalid_attrs), -EINVAL);
+	KUNIT_EXPECT_EQ(test, damon_set_attrs(c, &invalid_attrs), -EINVAL);
 
 	invalid_attrs = valid_attrs;
 	invalid_attrs.max_nr_regions = 9;
-	KUNIT_EXPECT_EQ(test, damon_set_attrs(&ctx, &invalid_attrs), -EINVAL);
+	KUNIT_EXPECT_EQ(test, damon_set_attrs(c, &invalid_attrs), -EINVAL);
 
 	invalid_attrs = valid_attrs;
 	invalid_attrs.aggr_interval = 4999;
-	KUNIT_EXPECT_EQ(test, damon_set_attrs(&ctx, &invalid_attrs), -EINVAL);
+	KUNIT_EXPECT_EQ(test, damon_set_attrs(c, &invalid_attrs), -EINVAL);
 }
 
 static struct kunit_case damon_test_cases[] = {
-- 
2.34.1

