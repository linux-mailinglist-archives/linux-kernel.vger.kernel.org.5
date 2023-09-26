Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780E07AE2B8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 02:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjIZAAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 20:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjIZAAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 20:00:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3348FB
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 17:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695686446; x=1727222446;
  h=from:to:subject:date:message-id:mime-version;
  bh=w+Np2v1Qracjoz2BMdiQxAHRFgxU97urADq8P8mIPcU=;
  b=S+H8gxsEE6VvASxOvj+L5KbfYIDwQPs6TMNroy8MDzDC+R2hkYFgPC9J
   QbGIUGTEM2EISSCNGF1QVhQppTZSxe9BQOaOuXdXK+tlpHQNo/ezDPRTz
   rQQ1ddCZOZm28cxYv3WTnPJRRaONpGNbkn+AGulBHdMiG5GWHSt+xIDi8
   YBKnbJqwrixYLPZcILDxYSHDo80T0uL8Ne8J/L7t4T3v/FlEDe8HIaWVK
   CmWmHyF6QCRjNVR1PXxbkSrTel1HO4P+Ber+7/bWtH5lZdpuzHE3F6jHC
   X/SXgP55hkTOPDrRKQhxeTDbscsH86nXEBzWc+dz5a+9bA3QC35RIuxRZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="378721290"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="378721290"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 17:00:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="1079482682"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="1079482682"
Received: from marneani-mobl1.amr.corp.intel.com (HELO jcompost-mobl.amr.corp.intel.com) ([10.212.7.191])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 17:00:45 -0700
From:   "Compostella, Jeremy" <jeremy.compostella@intel.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
Subject: [PATCH v2 1/2] x86/cpu/intel: Fix MTRR verification for TME enabled
 platforms
Date:   Mon, 25 Sep 2023 17:00:45 -0700
Message-ID: <87il7xu7ki.fsf@jcompost-mobl.amr.corp.intel.com>
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

On TME enabled platform, BIOS publishes MTRR taking into account Total
Memory Encryption (TME) reserved bits.

generic_get_mtrr() performs a sanity check of the MTRRs relying on the
`phys_hi_rsvd' variable which is set using the cpuinfo_x86 structure
`x86_phys_bits' field.  But at the time the generic_get_mtrr()
function is ran the `x86_phys_bits' has not been updated by
detect_tme() when TME is enabled.

Since the x86_phys_bits does not reflect yet the real maximal physical
address size yet generic_get_mtrr() complains by logging the following
messages.

    mtrr: your BIOS has configured an incorrect mask, fixing it.
    mtrr: your BIOS has configured an incorrect mask, fixing it.
    [...]

For `x86_phys_bits' to be updated before generic_get_mtrr() runs, this
patch moves the detect_tme() call from init_intel() to
early_init_intel().

Signed-off-by: Jeremy Compostella <jeremy.compostella@intel.com>
---
 arch/x86/kernel/cpu/intel.c | 178 ++++++++++++++++++------------------
 1 file changed, 91 insertions(+), 87 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index be4045628fd3..17240b96ffda 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -184,6 +184,90 @@ static bool bad_spectre_microcode(struct cpuinfo_x86 *c)
 	return false;
 }
 
+#define MSR_IA32_TME_ACTIVATE		0x982
+
+/* Helpers to access TME_ACTIVATE MSR */
+#define TME_ACTIVATE_LOCKED(x)		(x & 0x1)
+#define TME_ACTIVATE_ENABLED(x)		(x & 0x2)
+
+#define TME_ACTIVATE_POLICY(x)		((x >> 4) & 0xf)	/* Bits 7:4 */
+#define TME_ACTIVATE_POLICY_AES_XTS_128	0
+
+#define TME_ACTIVATE_KEYID_BITS(x)	((x >> 32) & 0xf)	/* Bits 35:32 */
+
+#define TME_ACTIVATE_CRYPTO_ALGS(x)	((x >> 48) & 0xffff)	/* Bits 63:48 */
+#define TME_ACTIVATE_CRYPTO_AES_XTS_128	1
+
+/* Values for mktme_status (SW only construct) */
+#define MKTME_ENABLED			0
+#define MKTME_DISABLED			1
+#define MKTME_UNINITIALIZED		2
+static int mktme_status = MKTME_UNINITIALIZED;
+
+static void detect_tme(struct cpuinfo_x86 *c)
+{
+	u64 tme_activate, tme_policy, tme_crypto_algs;
+	int keyid_bits = 0, nr_keyids = 0;
+	static u64 tme_activate_cpu0 = 0;
+
+	rdmsrl(MSR_IA32_TME_ACTIVATE, tme_activate);
+
+	if (mktme_status != MKTME_UNINITIALIZED) {
+		if (tme_activate != tme_activate_cpu0) {
+			/* Broken BIOS? */
+			pr_err_once("x86/tme: configuration is inconsistent between CPUs\n");
+			pr_err_once("x86/tme: MKTME is not usable\n");
+			mktme_status = MKTME_DISABLED;
+
+			/* Proceed. We may need to exclude bits from x86_phys_bits. */
+		}
+	} else {
+		tme_activate_cpu0 = tme_activate;
+	}
+
+	if (!TME_ACTIVATE_LOCKED(tme_activate) || !TME_ACTIVATE_ENABLED(tme_activate)) {
+		pr_info_once("x86/tme: not enabled by BIOS\n");
+		mktme_status = MKTME_DISABLED;
+		return;
+	}
+
+	if (mktme_status != MKTME_UNINITIALIZED)
+		goto detect_keyid_bits;
+
+	pr_info("x86/tme: enabled by BIOS\n");
+
+	tme_policy = TME_ACTIVATE_POLICY(tme_activate);
+	if (tme_policy != TME_ACTIVATE_POLICY_AES_XTS_128)
+		pr_warn("x86/tme: Unknown policy is active: %#llx\n", tme_policy);
+
+	tme_crypto_algs = TME_ACTIVATE_CRYPTO_ALGS(tme_activate);
+	if (!(tme_crypto_algs & TME_ACTIVATE_CRYPTO_AES_XTS_128)) {
+		pr_err("x86/mktme: No known encryption algorithm is supported: %#llx\n",
+				tme_crypto_algs);
+		mktme_status = MKTME_DISABLED;
+	}
+detect_keyid_bits:
+	keyid_bits = TME_ACTIVATE_KEYID_BITS(tme_activate);
+	nr_keyids = (1UL << keyid_bits) - 1;
+	if (nr_keyids) {
+		pr_info_once("x86/mktme: enabled by BIOS\n");
+		pr_info_once("x86/mktme: %d KeyIDs available\n", nr_keyids);
+	} else {
+		pr_info_once("x86/mktme: disabled by BIOS\n");
+	}
+
+	if (mktme_status == MKTME_UNINITIALIZED) {
+		/* MKTME is usable */
+		mktme_status = MKTME_ENABLED;
+	}
+
+	/*
+	 * KeyID bits effectively lower the number of physical address
+	 * bits.  Update cpuinfo_x86::x86_phys_bits accordingly.
+	 */
+	c->x86_phys_bits -= keyid_bits;
+}
+
 static void early_init_intel(struct cpuinfo_x86 *c)
 {
 	u64 misc_enable;
@@ -335,6 +419,13 @@ static void early_init_intel(struct cpuinfo_x86 *c)
 	 */
 	if (detect_extended_topology_early(c) < 0)
 		detect_ht_early(c);
+
+	/*
+	 * detect_tme() must be called early as it updates the number of
+	 * physical address bits which is used during the MTRR sanity check.
+	 */
+	if (cpu_has(c, X86_FEATURE_TME))
+		detect_tme(c);
 }
 
 static void bsp_init_intel(struct cpuinfo_x86 *c)
@@ -495,90 +586,6 @@ static void srat_detect_node(struct cpuinfo_x86 *c)
 #endif
 }
 
-#define MSR_IA32_TME_ACTIVATE		0x982
-
-/* Helpers to access TME_ACTIVATE MSR */
-#define TME_ACTIVATE_LOCKED(x)		(x & 0x1)
-#define TME_ACTIVATE_ENABLED(x)		(x & 0x2)
-
-#define TME_ACTIVATE_POLICY(x)		((x >> 4) & 0xf)	/* Bits 7:4 */
-#define TME_ACTIVATE_POLICY_AES_XTS_128	0
-
-#define TME_ACTIVATE_KEYID_BITS(x)	((x >> 32) & 0xf)	/* Bits 35:32 */
-
-#define TME_ACTIVATE_CRYPTO_ALGS(x)	((x >> 48) & 0xffff)	/* Bits 63:48 */
-#define TME_ACTIVATE_CRYPTO_AES_XTS_128	1
-
-/* Values for mktme_status (SW only construct) */
-#define MKTME_ENABLED			0
-#define MKTME_DISABLED			1
-#define MKTME_UNINITIALIZED		2
-static int mktme_status = MKTME_UNINITIALIZED;
-
-static void detect_tme(struct cpuinfo_x86 *c)
-{
-	u64 tme_activate, tme_policy, tme_crypto_algs;
-	int keyid_bits = 0, nr_keyids = 0;
-	static u64 tme_activate_cpu0 = 0;
-
-	rdmsrl(MSR_IA32_TME_ACTIVATE, tme_activate);
-
-	if (mktme_status != MKTME_UNINITIALIZED) {
-		if (tme_activate != tme_activate_cpu0) {
-			/* Broken BIOS? */
-			pr_err_once("x86/tme: configuration is inconsistent between CPUs\n");
-			pr_err_once("x86/tme: MKTME is not usable\n");
-			mktme_status = MKTME_DISABLED;
-
-			/* Proceed. We may need to exclude bits from x86_phys_bits. */
-		}
-	} else {
-		tme_activate_cpu0 = tme_activate;
-	}
-
-	if (!TME_ACTIVATE_LOCKED(tme_activate) || !TME_ACTIVATE_ENABLED(tme_activate)) {
-		pr_info_once("x86/tme: not enabled by BIOS\n");
-		mktme_status = MKTME_DISABLED;
-		return;
-	}
-
-	if (mktme_status != MKTME_UNINITIALIZED)
-		goto detect_keyid_bits;
-
-	pr_info("x86/tme: enabled by BIOS\n");
-
-	tme_policy = TME_ACTIVATE_POLICY(tme_activate);
-	if (tme_policy != TME_ACTIVATE_POLICY_AES_XTS_128)
-		pr_warn("x86/tme: Unknown policy is active: %#llx\n", tme_policy);
-
-	tme_crypto_algs = TME_ACTIVATE_CRYPTO_ALGS(tme_activate);
-	if (!(tme_crypto_algs & TME_ACTIVATE_CRYPTO_AES_XTS_128)) {
-		pr_err("x86/mktme: No known encryption algorithm is supported: %#llx\n",
-				tme_crypto_algs);
-		mktme_status = MKTME_DISABLED;
-	}
-detect_keyid_bits:
-	keyid_bits = TME_ACTIVATE_KEYID_BITS(tme_activate);
-	nr_keyids = (1UL << keyid_bits) - 1;
-	if (nr_keyids) {
-		pr_info_once("x86/mktme: enabled by BIOS\n");
-		pr_info_once("x86/mktme: %d KeyIDs available\n", nr_keyids);
-	} else {
-		pr_info_once("x86/mktme: disabled by BIOS\n");
-	}
-
-	if (mktme_status == MKTME_UNINITIALIZED) {
-		/* MKTME is usable */
-		mktme_status = MKTME_ENABLED;
-	}
-
-	/*
-	 * KeyID bits effectively lower the number of physical address
-	 * bits.  Update cpuinfo_x86::x86_phys_bits accordingly.
-	 */
-	c->x86_phys_bits -= keyid_bits;
-}
-
 static void init_cpuid_fault(struct cpuinfo_x86 *c)
 {
 	u64 msr;
@@ -715,9 +722,6 @@ static void init_intel(struct cpuinfo_x86 *c)
 
 	init_ia32_feat_ctl(c);
 
-	if (cpu_has(c, X86_FEATURE_TME))
-		detect_tme(c);
-
 	init_intel_misc_features(c);
 
 	split_lock_init();
-- 
2.40.1

