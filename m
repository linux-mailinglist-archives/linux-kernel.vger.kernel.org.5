Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3EA75A06F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 23:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjGSVQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 17:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjGSVQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 17:16:42 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EAB81FC1;
        Wed, 19 Jul 2023 14:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689801401; x=1721337401;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KOlYhSQQf0n27vCrrgt8YCZyUuX7bCxCVC7N0wOP1Jw=;
  b=C1jv2hadUjV4P8vdlE5j63P43iT5wbq3KrOr5iSZPg/jDmtaE6PtFAk5
   PN1JUvB3JS9FGyLn99UUnE6R/b7tM3m9SsB9JcrJ/8fipJkpqQupzwAyn
   PdtNqOfLo5/wKe1mF7oY//ABwmd4g/HEzv4kKCm3NAQLGYkQiqj/PCTwA
   gUhHBHmmSpt8xsvEQd9RXsORmbQhsKzDzBohk0RaL/LnHOoWH7K8RPM1u
   MgeQ4WIAZp8rgcoCtKxyxNunF/xW6PQnbkpCKRAKg5KWHjfp1EHKpmSlp
   u2FxFx6PvnuedpPR2ebe4XZoTl6z5MUbwiMkhPFLIN2dE3Ev/aOSbhwKo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="351435329"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="351435329"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 14:16:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="724150548"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="724150548"
Received: from agluck-desk3.sc.intel.com ([172.25.222.74])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 14:16:40 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        "Li, Zhiquan1" <zhiquan1.li@intel.com>,
        "Song, Youquan" <youquan.song@intel.com>, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Tony Luck <tony.luck@intel.com>
Subject: [PATCH v2] x86/mce: Set PG_hwpoison page flag to avoid the capture kernel panic
Date:   Wed, 19 Jul 2023 14:16:25 -0700
Message-Id: <20230719211625.298785-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230127015030.30074-1-tony.luck@intel.com>
References: <20230127015030.30074-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhiquan Li <zhiquan1.li@intel.com>

Kdump can exclude the HWPosion page to avoid touch the error page
again, the prerequisite is the PG_hwpoison page flag is set.
However, for some MCE fatal error cases, there are no opportunity
to queue a task for calling memory_failure(), as a result,
the capture kernel touches the error page again and panics.

Add function mce_set_page_hwpoison_now() which mark a page as
HWPoison before kernel panic() for MCE error, so that the dump
program can check and skip the error page and prevent the capture
kernel panic.

[Tony: Changed TestSetPageHWPoison() to SetPageHWPoison()]

Co-developed-by: Youquan Song <youquan.song@intel.com>
Signed-off-by: Youquan Song <youquan.song@intel.com>
Signed-off-by: Zhiquan Li <zhiquan1.li@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---

v2: Replaced "TODO" comment in code with comments based on mailing
list discussion on the lack of value in covering other page types

 arch/x86/kernel/cpu/mce/core.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 89e2aab5d34d..766f64fade51 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -156,6 +156,30 @@ void mce_unregister_decode_chain(struct notifier_block *nb)
 }
 EXPORT_SYMBOL_GPL(mce_unregister_decode_chain);
 
+/*
+ * Kdump can exclude the HWPosion page to avoid touch the error page again,
+ * the prerequisite is the PG_hwpoison page flag is set. However, for some
+ * MCE fatal error cases, there are no opportunity to queue a task
+ * for calling memory_failure(), as a result, the capture kernel panic.
+ * This function mark the page as HWPoison before kernel panic() for MCE.
+ *
+ * This covers normal 4KByte pages. There is little/no value in covering
+ * other page types. E.g.
+ * SGX: These cannot be dumped.
+ * PMEM: Pointless to dump these. Persistent memory contents remain
+ * available across reboots.
+ * HugeTLB: These are user pages. Generally filtered out of the kdump
+ * to keep size small. Not helpful to debug kernel issues.
+ */
+static void mce_set_page_hwpoison_now(unsigned long pfn)
+{
+	struct page *p;
+
+	p = pfn_to_online_page(pfn);
+	if (p)
+		SetPageHWPoison(p);
+}
+
 static void __print_mce(struct mce *m)
 {
 	pr_emerg(HW_ERR "CPU %d: Machine Check%s: %Lx Bank %d: %016Lx\n",
@@ -286,6 +310,8 @@ static noinstr void mce_panic(const char *msg, struct mce *final, char *exp)
 	if (!fake_panic) {
 		if (panic_timeout == 0)
 			panic_timeout = mca_cfg.panic_timeout;
+		if (final && (final->status & MCI_STATUS_ADDRV))
+			mce_set_page_hwpoison_now(final->addr >> PAGE_SHIFT);
 		panic(msg);
 	} else
 		pr_emerg(HW_ERR "Fake kernel panic: %s\n", msg);
-- 
2.40.1

