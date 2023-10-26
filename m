Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACCBD7D793A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 02:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjJZAU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 20:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJZAUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 20:20:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD20710E;
        Wed, 25 Oct 2023 17:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698279623; x=1729815623;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PbtOIKhqSb9anV/QE8snBXCsQjEd+yqLFJl8YHIKbMg=;
  b=MYik67gzMGoHjI/HNSzfPGk6S7rOYyYb2IVwVEUkVm4PMvHSpKvdCXD3
   sVSN0hvgnQT5JqNM2qoT8qIpHZ/apUDIufQBa0q8Kw8EXelGj40Sleapy
   dqDyxM1cUjd4ULc51zPoGnU/AhvalZrpTFS6krtMmzaOl1fwWHXnvDtB9
   u147oLP42QXVEW5sXRpRm0xBgqNiudB5Z4CAEID5A98JEaj9MMmDVJyqa
   YQmhh2fQhSFA+ZmzVjEaol8X5cP4ywk6pqYFXudwqce/69sj7NwtS0CxO
   Bt4uP3ILZqMH4z4mG8iBnlOSmX3w8ugirp0qsbHulydimk8qfkzfCZ5gK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="6045549"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="6045549"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 17:20:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="788300604"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="788300604"
Received: from zhiquan-linux-dev.bj.intel.com ([10.238.156.102])
  by orsmga008.jf.intel.com with ESMTP; 25 Oct 2023 17:20:05 -0700
From:   Zhiquan Li <zhiquan1.li@intel.com>
To:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        bp@alien8.de, mingo@kernel.org, tony.luck@intel.com,
        naoya.horiguchi@nec.com
Cc:     dan.carpenter@linaro.org, zhiquan1.li@intel.com,
        Youquan Song <youquan.song@intel.com>
Subject: [PATCH v5] x86/mce: Mark fatal MCE's page as poison to avoid panic in the kdump kernel
Date:   Thu, 26 Oct 2023 08:39:03 +0800
Message-Id: <20231026003903.382885-1-zhiquan1.li@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory errors don't happen very often, especially fatal ones. However,
in large-scale scenarios such as data centers, that probability
increases with the amount of machines present.

When a fatal machine check happens, mce_panic() is called based on the
severity grading of that error. The page containing the error is not
marked as poison.

However, when kexec is enabled, tools like makedumpfile understand when
pages are marked as poison and do not touch them so as not to cause
a fatal machine check exception again while dumping the previous
kernel's memory.

Therefore, mark the page containing the error as poisoned so that the
kexec'ed kernel can avoid accessing the page.

Co-developed-by: Youquan Song <youquan.song@intel.com>
Signed-off-by: Youquan Song <youquan.song@intel.com>
Signed-off-by: Zhiquan Li <zhiquan1.li@intel.com>
Reviewed-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dan Carpenter <dan.carpenter@linaro.org>

---

V4: https://lore.kernel.org/all/20231023042237.173290-1-zhiquan1.li@intel.com/

V4 -> V5:
- Fixed the bug reported by Dan Carpenter, that was introduced at V3.
  Link: https://lore.kernel.org/all/12eb6db6-bc24-4e7c-af34-a5c68d49d52a@moroto.mountain/
- Many thanks to Boris for re-writing the commit message and comment.

V3: https://lore.kernel.org/all/20231014051754.3759099-1-zhiquan1.li@intel.com/

V3 -> V4:
- Rebased to v6.6-rc7.
- Added the check if kexec is enabled highlighted by Boris.
- Re-wrote the commit message suggested by Tony.

V2: https://lore.kernel.org/all/20230914030539.1622477-1-zhiquan1.li@intel.com/

V2 -> V3:
- Rebased to v6.6-rc5.
- Moved the logic of function mce_set_page_hwpoison_now() into
  mce_panic().
- Explained full scenario in commit message per Boris's suggestion.
- Included Ingo's fixes.
  Link: https://lore.kernel.org/all/ZRsUpM%2FXtPAE50Rm@gmail.com/

V1: https://lore.kernel.org/all/20230127015030.30074-1-tony.luck@intel.com/

V1 -> V2:
- Revised the commit message as per Naoya's suggestion.
- Replaced "TODO" comment in code with comments based on mailing list
  discussion on the lack of value in covering other page types.
- Added the tag from Naoya.
  Link: https://lore.kernel.org/all/20230327083739.GA956278@hori.linux.bs1.fc.nec.co.jp/
---
 arch/x86/kernel/cpu/mce/core.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 6f35f724cc14..20ab11aec60b 100644
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
@@ -286,6 +288,20 @@ static noinstr void mce_panic(const char *msg, struct mce *final, char *exp)
 	if (!fake_panic) {
 		if (panic_timeout == 0)
 			panic_timeout = mca_cfg.panic_timeout;
+
+		/*
+		 * Kdump skips the poisoned page in order to avoid
+		 * touching the error bits again. Poison the page even
+		 * if the error is fatal and the machine is about to
+		 * panic.
+		 */
+		if (kexec_crash_loaded()) {
+			if (final && (final->status & MCI_STATUS_ADDRV)) {
+				p = pfn_to_online_page(final->addr >> PAGE_SHIFT);
+				if (p)
+					SetPageHWPoison(p);
+			}
+		}
 		panic(msg);
 	} else
 		pr_emerg(HW_ERR "Fake kernel panic: %s\n", msg);
-- 
2.25.1

