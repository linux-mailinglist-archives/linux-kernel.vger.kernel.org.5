Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC9A7D2937
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 06:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjJWEDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 00:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjJWEDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 00:03:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5670B1A4;
        Sun, 22 Oct 2023 21:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698033823; x=1729569823;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/lm+N1ZG0HevUhMCF+FCwdTjUSlpsEdKmmGgQvx6BS8=;
  b=dDjOIOAYvDl31ejkZRuXAdsPEk+crkRfAGZ3BTZ8r7oK8MoeQHsW3r/d
   mCZSXtAg+hMp9U5kceDoLxAHH4EyK7/DU9XKbh2tHV1YLsyewC7nPrAE5
   BjN/5RLjwovhbqM5bNPzluz6i+u5pxifzgPxtWAo5ec8LWnN/7bJMeCbd
   31QSgjSN3zOyp8SEE5uPD9tEtWFjVNP+nrEUOAryolwCd8ZY7+iJNLTVB
   LQzY8KgK2YRvOUSE9aCKnaj+mqzsqJojQgeOYWxdqvPdYmxShiMUjZCvW
   Kmy9TVmO8KZvWttQKpi2mYNxpX1ZAvdWaKPiqaesIX6tiw+msnPsL+0UY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="377135236"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="377135236"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2023 21:03:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="761617295"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="761617295"
Received: from zhiquan-linux-dev.bj.intel.com ([10.238.156.102])
  by fmsmga007.fm.intel.com with ESMTP; 22 Oct 2023 21:03:39 -0700
From:   Zhiquan Li <zhiquan1.li@intel.com>
To:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        bp@alien8.de, mingo@kernel.org, tony.luck@intel.com,
        naoya.horiguchi@nec.com
Cc:     zhiquan1.li@intel.com, Youquan Song <youquan.song@intel.com>
Subject: [PATCH v4] x86/mce: Set PG_hwpoison page flag to avoid the capture kernel panic
Date:   Mon, 23 Oct 2023 12:22:37 +0800
Message-Id: <20231023042237.173290-1-zhiquan1.li@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory errors don't happen very often, especially the severity is fatal.
However, in large-scale scenarios, such as data centers, it might still
happen.  When there is a fatal machine check Linux calls mce_panic()
without checking to see if bad data at some memory address was reported
in the machine check banks.

If kexec is enabled, check for memory errors and mark the page as
poisoned so that the kexec'ed kernel can avoid accessing the page.

Co-developed-by: Youquan Song <youquan.song@intel.com>
Signed-off-by: Youquan Song <youquan.song@intel.com>
Signed-off-by: Zhiquan Li <zhiquan1.li@intel.com>
Reviewed-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc: Borislav Petkov <bp@alien8.de>

---

V3: https://lore.kernel.org/all/20231014051754.3759099-1-zhiquan1.li@intel.com/

Changes since V3:
- Rebased to v6.6-rc7.
- Added the check if kexec is enabled highlighted by Boris.
- Re-wrote the commit message suggested by Tony.

V2: https://lore.kernel.org/all/20230914030539.1622477-1-zhiquan1.li@intel.com/

Changes since V2:
- Rebased to v6.6-rc5.
- Explained full scenario in commit message per Boris's suggestion.
- Included Ingo's fixes.
  Link: https://lore.kernel.org/all/ZRsUpM%2FXtPAE50Rm@gmail.com/

V1: https://lore.kernel.org/all/20230127015030.30074-1-tony.luck@intel.com/

Changes since V1:
- Revised the commit message as per Naoya's suggestion.
- Replaced "TODO" comment in code with comments based on mailing list
  discussion on the lack of value in covering other page types.
- Added the tag from Naoya.
  Link: https://lore.kernel.org/all/20230327083739.GA956278@hori.linux.bs1.fc.nec.co.jp/
---
 arch/x86/kernel/cpu/mce/core.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 6f35f724cc14..930b1120009b 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -44,6 +44,7 @@
 #include <linux/sync_core.h>
 #include <linux/task_work.h>
 #include <linux/hardirq.h>
+#include <linux/kexec.h>
 
 #include <asm/intel-family.h>
 #include <asm/processor.h>
@@ -233,6 +234,7 @@ static noinstr void mce_panic(const char *msg, struct mce *final, char *exp)
 	struct llist_node *pending;
 	struct mce_evt_llist *l;
 	int apei_err = 0;
+	struct page *p;
 
 	/*
 	 * Allow instrumentation around external facilities usage. Not that it
@@ -286,6 +288,19 @@ static noinstr void mce_panic(const char *msg, struct mce *final, char *exp)
 	if (!fake_panic) {
 		if (panic_timeout == 0)
 			panic_timeout = mca_cfg.panic_timeout;
+		if (kexec_crash_loaded()) {
+			/*
+			 * Kdump can exclude the poisoned page to avoid touching the error
+			 * page again, the prerequisite is that the PG_hwpoison page flag
+			 * is set.  However, for some MCE fatal error cases, there is no
+			 * opportunity to queue a task for calling memory_failure(), and as
+			 * a result, the capture kernel panics.  So mark the page as
+			 * poisoned before kernel panic() for MCE.
+			 */
+			p = pfn_to_online_page(final->addr >> PAGE_SHIFT);
+			if (final && (final->status & MCI_STATUS_ADDRV) && p)
+				SetPageHWPoison(p);
+		}
 		panic(msg);
 	} else
 		pr_emerg(HW_ERR "Fake kernel panic: %s\n", msg);
-- 
2.25.1

