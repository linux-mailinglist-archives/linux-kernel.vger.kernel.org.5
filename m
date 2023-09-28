Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B877B2871
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 00:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbjI1WbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 18:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbjI1WbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 18:31:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBA219F
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 15:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695940262; x=1727476262;
  h=from:to:subject:date:message-id:mime-version;
  bh=fV+RNcytYTnKsC3fIpYn93ivjU0mFBA5Np/yHsA6xkw=;
  b=hI11QjDDWWfthCZmtYlJ8N0xo1vv5SE05sUemd2WxEIChF06R30h7txu
   GImmGIG8MVw4mkvG9u+HTwsaV/CiN9UJkmlrmSDl2BcuFeD7aJQ/EtI9a
   tutTlytIDI6L8JflHQT5S2gu5xBQRJCkKDP9kQP3xo6T1qsZQnXJtvWkb
   kT9Qk2Ujbe6hl3ZN7pEhYvaaMdk5LikpsDwsYmScpqYSYmU6YQfLn0/g4
   3ieD6otxUxJoN+HHtHgCQOa/MXB4qD4ZPIxcItWOZ0SJdIGJKKhLovHTa
   r6YKsM1DXvHawJGoSyKHgxt433P3H4fncmI0GNKSkbTq0pShnwLax+ecX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="381077831"
X-IronPort-AV: E=Sophos;i="6.03,185,1694761200"; 
   d="scan'208";a="381077831"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 15:31:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="840077167"
X-IronPort-AV: E=Sophos;i="6.03,185,1694761200"; 
   d="scan'208";a="840077167"
Received: from htschmid-mobl2.amr.corp.intel.com (HELO jcompost-mobl.amr.corp.intel.com) ([10.213.188.139])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 15:31:02 -0700
From:   "Compostella, Jeremy" <jeremy.compostella@intel.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "Li, Xin3" <xin3.li@intel.com>, "Huang, Kai" <kai.huang@intel.com>
Subject: [PATCH v3 2/2] x86/cpu/intel: Move TME MSR definitions to msr-index.h
Date:   Thu, 28 Sep 2023 15:31:01 -0700
Message-ID: <878r8qylp6.fsf@jcompost-mobl.amr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Organization: Intel Corporation - 2200 Mission College Blvd. Santa Clara, CA
        95052. USA
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MSRs and their bits definitions are usually centralized
in arch/x86/include/asm/msr-index.h.

Changes for v3:
Take review comments into account by focusing only on the MSR
definition move to msr-index.h.

Signed-off-by: Jeremy Compostella <jeremy.compostella@intel.com>
---
 arch/x86/include/asm/msr-index.h | 11 +++++++++++
 arch/x86/kernel/cpu/intel.c      | 21 +++++++++++++--------
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 1d111350197f..25303194cf5a 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -1092,6 +1092,17 @@
 #define VMX_BASIC_MEM_TYPE_WB	6LLU
 #define VMX_BASIC_INOUT		0x0040000000000000LLU
 
+/* Total Memory Encryption */
+#define MSR_IA32_TME_ACTIVATE			0x982
+#define MSR_IA32_TME_ACTIVATE_LOCKED		BIT(0)
+#define MSR_IA32_TME_ACTIVATE_ENABLED		BIT(1)
+#define MSR_IA32_TME_ACTIVATE_POLICY_OFFSET	4
+#define MSR_IA32_TME_ACTIVATE_POLICY_MASK	0xf
+#define MSR_IA32_TME_ACTIVATE_KEYID_BITS_OFFSET	32
+#define MSR_IA32_TME_ACTIVATE_KEYID_BITS_MASK	0xf
+#define MSR_IA32_TME_ACTIVATE_CRYPTO_ALG_OFFSET	48
+#define MSR_IA32_TME_ACTIVATE_CRYPTO_ALG_MASK	0xffff
+
 /* Resctrl MSRs: */
 /* - Intel: */
 #define MSR_IA32_L3_QOS_CFG		0xc81
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 17240b96ffda..19db92b72ece 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -184,18 +184,22 @@ static bool bad_spectre_microcode(struct cpuinfo_x86 *c)
 	return false;
 }
 
-#define MSR_IA32_TME_ACTIVATE		0x982
-
 /* Helpers to access TME_ACTIVATE MSR */
-#define TME_ACTIVATE_LOCKED(x)		(x & 0x1)
-#define TME_ACTIVATE_ENABLED(x)		(x & 0x2)
+#define TME_ACTIVATE_IS_LOCKED(x)	(x & MSR_IA32_TME_ACTIVATE_LOCKED)
+#define TME_ACTIVATE_IS_ENABLED(x)	(x & MSR_IA32_TME_ACTIVATE_ENABLED)
 
-#define TME_ACTIVATE_POLICY(x)		((x >> 4) & 0xf)	/* Bits 7:4 */
+#define TME_ACTIVATE_POLICY(x)	\
+	((x >> MSR_IA32_TME_ACTIVATE_POLICY_OFFSET)	\
+	 & MSR_IA32_TME_ACTIVATE_POLICY_MASK)
 #define TME_ACTIVATE_POLICY_AES_XTS_128	0
 
-#define TME_ACTIVATE_KEYID_BITS(x)	((x >> 32) & 0xf)	/* Bits 35:32 */
+#define TME_ACTIVATE_KEYID_BITS(x)			\
+	((x >> MSR_IA32_TME_ACTIVATE_KEYID_BITS_OFFSET)	\
+	 & MSR_IA32_TME_ACTIVATE_KEYID_BITS_MASK)
 
-#define TME_ACTIVATE_CRYPTO_ALGS(x)	((x >> 48) & 0xffff)	/* Bits 63:48 */
+#define TME_ACTIVATE_CRYPTO_ALGS(x)			\
+	((x >> MSR_IA32_TME_ACTIVATE_CRYPTO_ALG_OFFSET)	\
+	 & MSR_IA32_TME_ACTIVATE_CRYPTO_ALG_MASK)
 #define TME_ACTIVATE_CRYPTO_AES_XTS_128	1
 
 /* Values for mktme_status (SW only construct) */
@@ -225,7 +229,8 @@ static void detect_tme(struct cpuinfo_x86 *c)
 		tme_activate_cpu0 = tme_activate;
 	}
 
-	if (!TME_ACTIVATE_LOCKED(tme_activate) || !TME_ACTIVATE_ENABLED(tme_activate)) {
+	if (!TME_ACTIVATE_IS_LOCKED(tme_activate) ||
+	    !TME_ACTIVATE_IS_ENABLED(tme_activate)) {
 		pr_info_once("x86/tme: not enabled by BIOS\n");
 		mktme_status = MKTME_DISABLED;
 		return;
-- 
2.40.1

