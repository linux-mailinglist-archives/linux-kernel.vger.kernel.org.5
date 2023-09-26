Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235317AE2BA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 02:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjIZABH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 20:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjIZABG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 20:01:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4723109
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 17:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695686459; x=1727222459;
  h=from:to:subject:date:message-id:mime-version;
  bh=l6pyYxABvNQSHEhqy4BudcEFwJOHVU6Au7ckJqibC8E=;
  b=PzQ+SQqSmlksCKX870Xn8frS1Ye6mQIdRBu/cqjwzX5ylhdTIEJEUhAH
   M1sYh4Y9zH5Vm0TfrZNlMphZ2ehY/2Psy+WwUHAiIBxMSC24t6SLCBWL/
   NSVl7Ne882QSnkIlzB6GJs6hG1xzFOWQF+6znLM5AbMDMM/0tYT6+oMW1
   1ip2WIQIVp0a/wsitqFvFdfOmxUP1C9AKQWa77zXjKI3+KMPAuz2aayR6
   fr6YROaOhk6lZqFCyor6dyNzB7dPQ5PZm5xObWYBLQrE5dt6nHBY/+GcT
   ODdgZ/R6foke4Xws5qUjlOhzX18hwtiuvFWy3ERtr13jlqeVDbLGvuNO5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="360822986"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="360822986"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 17:00:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="748598791"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="748598791"
Received: from marneani-mobl1.amr.corp.intel.com (HELO jcompost-mobl.amr.corp.intel.com) ([10.212.7.191])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 17:00:58 -0700
From:   "Compostella, Jeremy" <jeremy.compostella@intel.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
Subject: [PATCH v2 2/2] x86/cpu/intel: Clean-up TME code
Date:   Mon, 25 Sep 2023 17:00:57 -0700
Message-ID: <87h6nhu7k6.fsf@jcompost-mobl.amr.corp.intel.com>
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

This patch improves the intel TME code quality by:
1. Moving the TME MSR definition to msr-index.h
2. Making the `mktme_status' variable an enum local to the
   detect_tme() function as this is the only function using it.

Signed-off-by: Jeremy Compostella <jeremy.compostella@intel.com>
---
 arch/x86/include/asm/msr-index.h | 11 +++++++++++
 arch/x86/kernel/cpu/intel.c      | 32 ++++++++++++++++++--------------
 2 files changed, 29 insertions(+), 14 deletions(-)

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
index 17240b96ffda..88c95d919061 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -184,31 +184,34 @@ static bool bad_spectre_microcode(struct cpuinfo_x86 *c)
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
 
-/* Values for mktme_status (SW only construct) */
-#define MKTME_ENABLED			0
-#define MKTME_DISABLED			1
-#define MKTME_UNINITIALIZED		2
-static int mktme_status = MKTME_UNINITIALIZED;
-
 static void detect_tme(struct cpuinfo_x86 *c)
 {
 	u64 tme_activate, tme_policy, tme_crypto_algs;
 	int keyid_bits = 0, nr_keyids = 0;
 	static u64 tme_activate_cpu0 = 0;
+	static enum {
+		MKTME_ENABLED,
+		MKTME_DISABLED,
+		MKTME_UNINITIALIZED
+	} mktme_status = MKTME_UNINITIALIZED;
 
 	rdmsrl(MSR_IA32_TME_ACTIVATE, tme_activate);
 
@@ -225,7 +228,8 @@ static void detect_tme(struct cpuinfo_x86 *c)
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

