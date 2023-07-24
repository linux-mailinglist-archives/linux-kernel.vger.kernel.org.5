Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132D875FD92
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 19:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbjGXRZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 13:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbjGXRZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 13:25:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDEF98;
        Mon, 24 Jul 2023 10:25:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63F8361202;
        Mon, 24 Jul 2023 17:25:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 703E1C433C7;
        Mon, 24 Jul 2023 17:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690219518;
        bh=CZjm9RYFZMSaHB6mPyTkEve9ZmNxeiV0F2M+Zjvbi4A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oGe06vsfsmwgvP/IfpFZ94lwGJm9wzGH1jUsDmJ5fGnRUesVaEGQWrX9amBTX1Xuu
         apGxmHlIhcHKFdmoHYbtqAgISQ6/g0zLULCy96CbBt3ic8YAy+gEditnHyv/DBOoHO
         hYh5R62NMu6BznXSDcKLn5FX96qu3w0JwgSpvuMQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.1.41
Date:   Mon, 24 Jul 2023 19:25:06 +0200
Message-ID: <2023072431-baguette-dragonfly-ea38@gregkh>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <2023072431-resubmit-baffling-d793@gregkh>
References: <2023072431-resubmit-baffling-d793@gregkh>
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

diff --git a/Makefile b/Makefile
index 2bb0c01391a9..6c940cce3656 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 1
-SUBLEVEL = 40
+SUBLEVEL = 41
 EXTRAVERSION =
 NAME = Curry Ramen
 
diff --git a/arch/x86/include/asm/microcode.h b/arch/x86/include/asm/microcode.h
index 79b1d009e34e..19a0b4005ffa 100644
--- a/arch/x86/include/asm/microcode.h
+++ b/arch/x86/include/asm/microcode.h
@@ -5,6 +5,7 @@
 #include <asm/cpu.h>
 #include <linux/earlycpio.h>
 #include <linux/initrd.h>
+#include <asm/microcode_amd.h>
 
 struct ucode_patch {
 	struct list_head plist;
diff --git a/arch/x86/include/asm/microcode_amd.h b/arch/x86/include/asm/microcode_amd.h
index e6662adf3af4..9675c621c1ca 100644
--- a/arch/x86/include/asm/microcode_amd.h
+++ b/arch/x86/include/asm/microcode_amd.h
@@ -48,11 +48,13 @@ extern void __init load_ucode_amd_bsp(unsigned int family);
 extern void load_ucode_amd_ap(unsigned int family);
 extern int __init save_microcode_in_initrd_amd(unsigned int family);
 void reload_ucode_amd(unsigned int cpu);
+extern void amd_check_microcode(void);
 #else
 static inline void __init load_ucode_amd_bsp(unsigned int family) {}
 static inline void load_ucode_amd_ap(unsigned int family) {}
 static inline int __init
 save_microcode_in_initrd_amd(unsigned int family) { return -EINVAL; }
 static inline void reload_ucode_amd(unsigned int cpu) {}
+static inline void amd_check_microcode(void) {}
 #endif
 #endif /* _ASM_X86_MICROCODE_AMD_H */
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 117e4e977b55..846067e1ee8b 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -543,6 +543,7 @@
 #define MSR_AMD64_DE_CFG		0xc0011029
 #define MSR_AMD64_DE_CFG_LFENCE_SERIALIZE_BIT	 1
 #define MSR_AMD64_DE_CFG_LFENCE_SERIALIZE	BIT_ULL(MSR_AMD64_DE_CFG_LFENCE_SERIALIZE_BIT)
+#define MSR_AMD64_DE_CFG_ZEN2_FP_BACKUP_FIX_BIT 9
 
 #define MSR_AMD64_BU_CFG2		0xc001102a
 #define MSR_AMD64_IBSFETCHCTL		0xc0011030
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index d2dbbc50b3a7..7f4eb8b027cc 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -27,11 +27,6 @@
 
 #include "cpu.h"
 
-static const int amd_erratum_383[];
-static const int amd_erratum_400[];
-static const int amd_erratum_1054[];
-static bool cpu_has_amd_erratum(struct cpuinfo_x86 *cpu, const int *erratum);
-
 /*
  * nodes_per_socket: Stores the number of nodes per socket.
  * Refer to Fam15h Models 00-0fh BKDG - CPUID Fn8000_001E_ECX
@@ -39,6 +34,78 @@ static bool cpu_has_amd_erratum(struct cpuinfo_x86 *cpu, const int *erratum);
  */
 static u32 nodes_per_socket = 1;
 
+/*
+ * AMD errata checking
+ *
+ * Errata are defined as arrays of ints using the AMD_LEGACY_ERRATUM() or
+ * AMD_OSVW_ERRATUM() macros. The latter is intended for newer errata that
+ * have an OSVW id assigned, which it takes as first argument. Both take a
+ * variable number of family-specific model-stepping ranges created by
+ * AMD_MODEL_RANGE().
+ *
+ * Example:
+ *
+ * const int amd_erratum_319[] =
+ *	AMD_LEGACY_ERRATUM(AMD_MODEL_RANGE(0x10, 0x2, 0x1, 0x4, 0x2),
+ *			   AMD_MODEL_RANGE(0x10, 0x8, 0x0, 0x8, 0x0),
+ *			   AMD_MODEL_RANGE(0x10, 0x9, 0x0, 0x9, 0x0));
+ */
+
+#define AMD_LEGACY_ERRATUM(...)		{ -1, __VA_ARGS__, 0 }
+#define AMD_OSVW_ERRATUM(osvw_id, ...)	{ osvw_id, __VA_ARGS__, 0 }
+#define AMD_MODEL_RANGE(f, m_start, s_start, m_end, s_end) \
+	((f << 24) | (m_start << 16) | (s_start << 12) | (m_end << 4) | (s_end))
+#define AMD_MODEL_RANGE_FAMILY(range)	(((range) >> 24) & 0xff)
+#define AMD_MODEL_RANGE_START(range)	(((range) >> 12) & 0xfff)
+#define AMD_MODEL_RANGE_END(range)	((range) & 0xfff)
+
+static const int amd_erratum_400[] =
+	AMD_OSVW_ERRATUM(1, AMD_MODEL_RANGE(0xf, 0x41, 0x2, 0xff, 0xf),
+			    AMD_MODEL_RANGE(0x10, 0x2, 0x1, 0xff, 0xf));
+
+static const int amd_erratum_383[] =
+	AMD_OSVW_ERRATUM(3, AMD_MODEL_RANGE(0x10, 0, 0, 0xff, 0xf));
+
+/* #1054: Instructions Retired Performance Counter May Be Inaccurate */
+static const int amd_erratum_1054[] =
+	AMD_LEGACY_ERRATUM(AMD_MODEL_RANGE(0x17, 0, 0, 0x2f, 0xf));
+
+static const int amd_zenbleed[] =
+	AMD_LEGACY_ERRATUM(AMD_MODEL_RANGE(0x17, 0x30, 0x0, 0x4f, 0xf),
+			   AMD_MODEL_RANGE(0x17, 0x60, 0x0, 0x7f, 0xf),
+			   AMD_MODEL_RANGE(0x17, 0xa0, 0x0, 0xaf, 0xf));
+
+static bool cpu_has_amd_erratum(struct cpuinfo_x86 *cpu, const int *erratum)
+{
+	int osvw_id = *erratum++;
+	u32 range;
+	u32 ms;
+
+	if (osvw_id >= 0 && osvw_id < 65536 &&
+	    cpu_has(cpu, X86_FEATURE_OSVW)) {
+		u64 osvw_len;
+
+		rdmsrl(MSR_AMD64_OSVW_ID_LENGTH, osvw_len);
+		if (osvw_id < osvw_len) {
+			u64 osvw_bits;
+
+			rdmsrl(MSR_AMD64_OSVW_STATUS + (osvw_id >> 6),
+			    osvw_bits);
+			return osvw_bits & (1ULL << (osvw_id & 0x3f));
+		}
+	}
+
+	/* OSVW unavailable or ID unknown, match family-model-stepping range */
+	ms = (cpu->x86_model << 4) | cpu->x86_stepping;
+	while ((range = *erratum++))
+		if ((cpu->x86 == AMD_MODEL_RANGE_FAMILY(range)) &&
+		    (ms >= AMD_MODEL_RANGE_START(range)) &&
+		    (ms <= AMD_MODEL_RANGE_END(range)))
+			return true;
+
+	return false;
+}
+
 static inline int rdmsrl_amd_safe(unsigned msr, unsigned long long *p)
 {
 	u32 gprs[8] = { 0 };
@@ -916,6 +983,47 @@ static void init_amd_zn(struct cpuinfo_x86 *c)
 	}
 }
 
+static bool cpu_has_zenbleed_microcode(void)
+{
+	u32 good_rev = 0;
+
+	switch (boot_cpu_data.x86_model) {
+	case 0x30 ... 0x3f: good_rev = 0x0830107a; break;
+	case 0x60 ... 0x67: good_rev = 0x0860010b; break;
+	case 0x68 ... 0x6f: good_rev = 0x08608105; break;
+	case 0x70 ... 0x7f: good_rev = 0x08701032; break;
+	case 0xa0 ... 0xaf: good_rev = 0x08a00008; break;
+
+	default:
+		return false;
+		break;
+	}
+
+	if (boot_cpu_data.microcode < good_rev)
+		return false;
+
+	return true;
+}
+
+static void zenbleed_check(struct cpuinfo_x86 *c)
+{
+	if (!cpu_has_amd_erratum(c, amd_zenbleed))
+		return;
+
+	if (cpu_has(c, X86_FEATURE_HYPERVISOR))
+		return;
+
+	if (!cpu_has(c, X86_FEATURE_AVX))
+		return;
+
+	if (!cpu_has_zenbleed_microcode()) {
+		pr_notice_once("Zenbleed: please update your microcode for the most optimal fix\n");
+		msr_set_bit(MSR_AMD64_DE_CFG, MSR_AMD64_DE_CFG_ZEN2_FP_BACKUP_FIX_BIT);
+	} else {
+		msr_clear_bit(MSR_AMD64_DE_CFG, MSR_AMD64_DE_CFG_ZEN2_FP_BACKUP_FIX_BIT);
+	}
+}
+
 static void init_amd(struct cpuinfo_x86 *c)
 {
 	early_init_amd(c);
@@ -1005,6 +1113,8 @@ static void init_amd(struct cpuinfo_x86 *c)
 		msr_set_bit(MSR_K7_HWCR, MSR_K7_HWCR_IRPERF_EN_BIT);
 
 	check_null_seg_clears_base(c);
+
+	zenbleed_check(c);
 }
 
 #ifdef CONFIG_X86_32
@@ -1100,73 +1210,6 @@ static const struct cpu_dev amd_cpu_dev = {
 
 cpu_dev_register(amd_cpu_dev);
 
-/*
- * AMD errata checking
- *
- * Errata are defined as arrays of ints using the AMD_LEGACY_ERRATUM() or
- * AMD_OSVW_ERRATUM() macros. The latter is intended for newer errata that
- * have an OSVW id assigned, which it takes as first argument. Both take a
- * variable number of family-specific model-stepping ranges created by
- * AMD_MODEL_RANGE().
- *
- * Example:
- *
- * const int amd_erratum_319[] =
- *	AMD_LEGACY_ERRATUM(AMD_MODEL_RANGE(0x10, 0x2, 0x1, 0x4, 0x2),
- *			   AMD_MODEL_RANGE(0x10, 0x8, 0x0, 0x8, 0x0),
- *			   AMD_MODEL_RANGE(0x10, 0x9, 0x0, 0x9, 0x0));
- */
-
-#define AMD_LEGACY_ERRATUM(...)		{ -1, __VA_ARGS__, 0 }
-#define AMD_OSVW_ERRATUM(osvw_id, ...)	{ osvw_id, __VA_ARGS__, 0 }
-#define AMD_MODEL_RANGE(f, m_start, s_start, m_end, s_end) \
-	((f << 24) | (m_start << 16) | (s_start << 12) | (m_end << 4) | (s_end))
-#define AMD_MODEL_RANGE_FAMILY(range)	(((range) >> 24) & 0xff)
-#define AMD_MODEL_RANGE_START(range)	(((range) >> 12) & 0xfff)
-#define AMD_MODEL_RANGE_END(range)	((range) & 0xfff)
-
-static const int amd_erratum_400[] =
-	AMD_OSVW_ERRATUM(1, AMD_MODEL_RANGE(0xf, 0x41, 0x2, 0xff, 0xf),
-			    AMD_MODEL_RANGE(0x10, 0x2, 0x1, 0xff, 0xf));
-
-static const int amd_erratum_383[] =
-	AMD_OSVW_ERRATUM(3, AMD_MODEL_RANGE(0x10, 0, 0, 0xff, 0xf));
-
-/* #1054: Instructions Retired Performance Counter May Be Inaccurate */
-static const int amd_erratum_1054[] =
-	AMD_LEGACY_ERRATUM(AMD_MODEL_RANGE(0x17, 0, 0, 0x2f, 0xf));
-
-static bool cpu_has_amd_erratum(struct cpuinfo_x86 *cpu, const int *erratum)
-{
-	int osvw_id = *erratum++;
-	u32 range;
-	u32 ms;
-
-	if (osvw_id >= 0 && osvw_id < 65536 &&
-	    cpu_has(cpu, X86_FEATURE_OSVW)) {
-		u64 osvw_len;
-
-		rdmsrl(MSR_AMD64_OSVW_ID_LENGTH, osvw_len);
-		if (osvw_id < osvw_len) {
-			u64 osvw_bits;
-
-			rdmsrl(MSR_AMD64_OSVW_STATUS + (osvw_id >> 6),
-			    osvw_bits);
-			return osvw_bits & (1ULL << (osvw_id & 0x3f));
-		}
-	}
-
-	/* OSVW unavailable or ID unknown, match family-model-stepping range */
-	ms = (cpu->x86_model << 4) | cpu->x86_stepping;
-	while ((range = *erratum++))
-		if ((cpu->x86 == AMD_MODEL_RANGE_FAMILY(range)) &&
-		    (ms >= AMD_MODEL_RANGE_START(range)) &&
-		    (ms <= AMD_MODEL_RANGE_END(range)))
-			return true;
-
-	return false;
-}
-
 void set_dr_addr_mask(unsigned long mask, int dr)
 {
 	if (!boot_cpu_has(X86_FEATURE_BPEXT))
@@ -1201,3 +1244,15 @@ u32 amd_get_highest_perf(void)
 	return 255;
 }
 EXPORT_SYMBOL_GPL(amd_get_highest_perf);
+
+static void zenbleed_check_cpu(void *unused)
+{
+	struct cpuinfo_x86 *c = &cpu_data(smp_processor_id());
+
+	zenbleed_check(c);
+}
+
+void amd_check_microcode(void)
+{
+	on_each_cpu(zenbleed_check_cpu, NULL, 1);
+}
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index c34bdba57993..d298d70f74ce 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2346,6 +2346,8 @@ void microcode_check(struct cpuinfo_x86 *prev_info)
 
 	perf_check_microcode();
 
+	amd_check_microcode();
+
 	store_cpu_caps(&curr_info);
 
 	if (!memcmp(&prev_info->x86_capability, &curr_info.x86_capability,
