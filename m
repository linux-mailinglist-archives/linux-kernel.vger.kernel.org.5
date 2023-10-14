Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8917C92D0
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 06:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbjJNE7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 00:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJNE7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 00:59:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966BBC0;
        Fri, 13 Oct 2023 21:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697259560; x=1728795560;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/mdnpue4Nciffio8GLONGA7omAPMeo1KzhFrOJHbT50=;
  b=IdG/eDlyXiJdn5TnWybYDn5od4OulhefWGyHHV1KPCFQTDVni5u4HI5K
   tZEXaqSS9SDkRTrQQOx6ARjhgOZzYShkt+N3r87D67+TCH0yyxDaLVbeD
   oVlmk7bHnxtpvIwgAow6FOQPyR9+piBkF3HC/pmHEgxtG2ZjDdgzB3pDf
   AQl3VLR6cI9lOK9oXcetx1qUkVlHih5TI1sqY63ec9/++OYylTLLynYsI
   wvqXawSWThEQbilOpaVhNIF/g7xTzuFvoKP7fGv7h45UbTRZD31Ix9wG7
   xXL8zOOp0QyZZg+blG1nSK16d86MYf630I6pfMW45WNwksIQO6yyz9EbC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="3912769"
X-IronPort-AV: E=Sophos;i="6.03,224,1694761200"; 
   d="scan'208";a="3912769"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 21:59:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="871363248"
X-IronPort-AV: E=Sophos;i="6.03,224,1694761200"; 
   d="scan'208";a="871363248"
Received: from zhiquan-linux-dev.bj.intel.com ([10.238.156.102])
  by fmsmga002.fm.intel.com with ESMTP; 13 Oct 2023 21:58:57 -0700
From:   Zhiquan Li <zhiquan1.li@intel.com>
To:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        bp@alien8.de, mingo@kernel.org, tony.luck@intel.com,
        naoya.horiguchi@nec.com
Cc:     zhiquan1.li@intel.com, Youquan Song <youquan.song@intel.com>
Subject: [PATCH v3] x86/mce: Set PG_hwpoison page flag to avoid the capture kernel panic
Date:   Sat, 14 Oct 2023 13:17:54 +0800
Message-Id: <20231014051754.3759099-1-zhiquan1.li@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory errors don't happen very often, especially the severity is fatal.
However, in large-scale scenarios, such as data centers, it might still
happen.  For some MCE fatal error cases, the kernel might call
mce_panic() to terminate the production kernel directly, thus there is
no opportunity to queue a task for calling memory_failure() which will
try to make the kernel survive via memory failure handling.

Unfortunately, the capture kernel will panic for the same reason if it
touches the error memory again.  The consequence is that only an
incomplete vmcore is left for sustaining engineers, it's a big headache
for them to make clear what happened in the past.

The main task of kdump kernel is providing a "window" - /proc/vmcore,
for the dump program to access old memory.  A dump program running in
userspace determines the "policy".  Which pages need to be dumped is
determined by the configuration of dump program, it reads out the pages
that the sustaining engineer is interested in and excludes the rest.

Likewise, the dump program can exclude the poisoned page to avoid
touching the error page again, the prerequisite is the PG_hwpoison page
flag is set correctly by kernel.  The de facto dump program
(makedumpfile) already supports this function in a decade ago.  To set
the PG_hwpoison flag in the production kernel just before it panics is
the only missing step to make everything work.

And it would not introduce additional overhead in capture kernel or
conflict with other hwpoision-related code in production kernel.  It
leverages the already existing mechanisms to fix the issue as much as
possible, so the code changes are lightweight.

[ Tony: Changed TestSetPageHWPoison() to SetPageHWPoison() ]
[ mingo: Fixed the comments & changelog ]

Co-developed-by: Youquan Song <youquan.song@intel.com>
Signed-off-by: Youquan Song <youquan.song@intel.com>
Signed-off-by: Zhiquan Li <zhiquan1.li@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc: Borislav Petkov <bp@alien8.de>
Link: https://lore.kernel.org/all/20230719211625.298785-1-tony.luck@intel.com/#t

---

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
 arch/x86/kernel/cpu/mce/core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 6f35f724cc14..905e80c776b8 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -233,6 +233,7 @@ static noinstr void mce_panic(const char *msg, struct mce *final, char *exp)
 	struct llist_node *pending;
 	struct mce_evt_llist *l;
 	int apei_err = 0;
+	struct page *p;
 
 	/*
 	 * Allow instrumentation around external facilities usage. Not that it
@@ -286,6 +287,17 @@ static noinstr void mce_panic(const char *msg, struct mce *final, char *exp)
 	if (!fake_panic) {
 		if (panic_timeout == 0)
 			panic_timeout = mca_cfg.panic_timeout;
+		/*
+		 * Kdump can exclude the HWPoison page to avoid touching the error
+		 * page again, the prerequisite is that the PG_hwpoison page flag is
+		 * set.  However, for some MCE fatal error cases, there is no
+		 * opportunity to queue a task for calling memory_failure(), and as a
+		 * result, the capture kernel panics.  So mark the page as HWPoison
+		 * before kernel panic() for MCE.
+		 */
+		p = pfn_to_online_page(final->addr >> PAGE_SHIFT);
+		if (final && (final->status & MCI_STATUS_ADDRV) && p)
+			SetPageHWPoison(p);
 		panic(msg);
 	} else
 		pr_emerg(HW_ERR "Fake kernel panic: %s\n", msg);
-- 
2.25.1

