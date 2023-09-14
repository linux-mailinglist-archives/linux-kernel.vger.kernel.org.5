Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B435D79F862
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 04:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234005AbjINCrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 22:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjINCrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 22:47:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5070B1724;
        Wed, 13 Sep 2023 19:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694659628; x=1726195628;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7AqD5A5iW3EXE8bXRwZVy9z6UDY0KU2vLZ++lAl1CMw=;
  b=U0mDZCYVkizoSA50yIm3OFJ3HO24ja5FLma0OCr7Z3t11wm5M4yjaJ1z
   IJrqq3v7B8425Jeg91Bq4nS+TI//bxDB+tl1niONSdDxApsSxM/BWLcIa
   nXYHkYI6mw1p0M1JOCSkTPf95dfpGYvghXhqdSiPqMr3KGtyNs0UFy5wo
   W8fEIWXtomFoXXnyfHBns2GvdJlH8BYya00j7APjWCZ7gi9CtFP5Zmb+v
   QAje1ohcceG83ZlmCfAkfj8ePIcLJltH2HgJ+8a5WyAMDBs7x+RZhXRrF
   qGGx4TqIHPjwQldUYo+nvVY77l858ILMeHJD2yS4eaSstcGEXPjY4hbDd
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="378760918"
X-IronPort-AV: E=Sophos;i="6.02,144,1688454000"; 
   d="scan'208";a="378760918"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 19:47:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="868067061"
X-IronPort-AV: E=Sophos;i="6.02,144,1688454000"; 
   d="scan'208";a="868067061"
Received: from zhiquan-linux-dev.bj.intel.com ([10.238.156.102])
  by orsmga004.jf.intel.com with ESMTP; 13 Sep 2023 19:47:04 -0700
From:   Zhiquan Li <zhiquan1.li@intel.com>
To:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        bp@alien8.de, tony.luck@intel.com, naoya.horiguchi@nec.com
Cc:     zhiquan1.li@intel.com, Youquan Song <youquan.song@intel.com>
Subject: [PATCH RESEND v2] x86/mce: Set PG_hwpoison page flag to avoid the capture kernel panic
Date:   Thu, 14 Sep 2023 11:05:39 +0800
Message-Id: <20230914030539.1622477-1-zhiquan1.li@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kdump can exclude the HWPosion page to avoid touch the error page
again, the prerequisite is the PG_hwpoison page flag is set.
However, for some MCE fatal error cases, there is no opportunity
to queue a task for calling memory_failure(), as a result,
the capture kernel touches the error page again and panics.

Add function mce_set_page_hwpoison_now() which marks a page as
HWPoison before kernel panic() for MCE error, so that the dump
program can check and skip the error page and prevent the capture
kernel panic.

[Tony: Changed TestSetPageHWPoison() to SetPageHWPoison()]

Co-developed-by: Youquan Song <youquan.song@intel.com>
Signed-off-by: Youquan Song <youquan.song@intel.com>
Signed-off-by: Zhiquan Li <zhiquan1.li@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Naoya Horiguchi <naoya.horiguchi@nec.com>

---
V2 RESEND notes:
- No changes on this, just rebasing as v6.6-rc1 is out.
- Added the tag from Naoya.
  Link: https://lore.kernel.org/all/20230719211625.298785-1-tony.luck@intel.com/#t

Changes since V1:
- Revised the commit message as per Naoya's suggestion.
- Replaced "TODO" comment in code with comments based on mailing list
  discussion on the lack of value in covering other page types.
  Link: https://lore.kernel.org/all/20230127015030.30074-1-tony.luck@intel.com/
---
 arch/x86/kernel/cpu/mce/core.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 6f35f724cc14..2725698268f3 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -156,6 +156,22 @@ void mce_unregister_decode_chain(struct notifier_block *nb)
 }
 EXPORT_SYMBOL_GPL(mce_unregister_decode_chain);
 
+/*
+ * Kdump can exclude the HWPosion page to avoid touch the error page again,
+ * the prerequisite is the PG_hwpoison page flag is set. However, for some
+ * MCE fatal error cases, there are no opportunity to queue a task
+ * for calling memory_failure(), as a result, the capture kernel panics.
+ * This function marks the page as HWPoison before kernel panic() for MCE.
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
@@ -286,6 +302,8 @@ static noinstr void mce_panic(const char *msg, struct mce *final, char *exp)
 	if (!fake_panic) {
 		if (panic_timeout == 0)
 			panic_timeout = mca_cfg.panic_timeout;
+		if (final && (final->status & MCI_STATUS_ADDRV))
+			mce_set_page_hwpoison_now(final->addr >> PAGE_SHIFT);
 		panic(msg);
 	} else
 		pr_emerg(HW_ERR "Fake kernel panic: %s\n", msg);
-- 
2.25.1

