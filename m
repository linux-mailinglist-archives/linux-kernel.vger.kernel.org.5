Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0081175FD9B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 19:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbjGXR0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 13:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjGXR0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 13:26:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62AB8100;
        Mon, 24 Jul 2023 10:26:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E50D0612FC;
        Mon, 24 Jul 2023 17:26:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3750C433C8;
        Mon, 24 Jul 2023 17:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690219595;
        bh=3v4j8f1SaDFnE4XVEOxyl2MjXkeKctrcAinL/5ZHXQs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vewtaTZY37+pk3XFf/2rQvyn6PppC4RtEkUAp5Hmn14CKSgXpBZHgfmeF3kWj9dMJ
         WVrR53qE9TJ4R1DBfkz5I0vnfw06mSGAnAsYxKEeX5UAZGIYRVa9EQrep/0m86HpF0
         4uwd1Q41FucBJq7Xdy/YodRQiqhC7CQzz66L04M8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.10.187
Date:   Mon, 24 Jul 2023 19:26:23 +0200
Message-ID: <2023072403-salami-habitant-a504@gregkh>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <2023072403-tacking-esophagus-3b00@gregkh>
References: <2023072403-tacking-esophagus-3b00@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index bb2be0ed9ff2..2aaf3b0b9250 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 10
-SUBLEVEL = 186
+SUBLEVEL = 187
 EXTRAVERSION =
 NAME = Dare mighty things
 
diff --git a/arch/x86/include/asm/microcode.h b/arch/x86/include/asm/microcode.h
index 509cc0262fdc..394605e59f2b 100644
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
index a645b25ee442..403a8e76b310 100644
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
index f71a177b6b18..3fab152809ab 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -497,6 +497,7 @@
 #define MSR_AMD64_DE_CFG		0xc0011029
 #define MSR_AMD64_DE_CFG_LFENCE_SERIALIZE_BIT	 1
 #define MSR_AMD64_DE_CFG_LFENCE_SERIALIZE	BIT_ULL(MSR_AMD64_DE_CFG_LFENCE_SERIALIZE_BIT)
+#define MSR_AMD64_DE_CFG_ZEN2_FP_BACKUP_FIX_BIT 9
 
 #define MSR_AMD64_BU_CFG2		0xc001102a
 #define MSR_AMD64_IBSFETCHCTL		0xc0011030
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 89a9b7754476..3d99a823ffac 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -28,11 +28,6 @@
 
 #include "cpu.h"
 
-static const int amd_erratum_383[];
-static const int amd_erratum_400[];
-static const int amd_erratum_1054[];
-static bool cpu_has_amd_erratum(struct cpuinfo_x86 *cpu, const int *erratum);
-
 /*
  * nodes_per_socket: Stores the number of nodes per socket.
  * Refer to Fam15h Models 00-0fh BKDG - CPUID Fn8000_001E_ECX
@@ -40,6 +35,78 @@ static bool cpu_has_amd_erratum(struct cpuinfo_x86 *cpu, const int *erratum);
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
@@ -968,6 +1035,47 @@ static void init_amd_zn(struct cpuinfo_x86 *c)
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
@@ -1058,6 +1166,8 @@ static void init_amd(struct cpuinfo_x86 *c)
 		msr_set_bit(MSR_K7_HWCR, MSR_K7_HWCR_IRPERF_EN_BIT);
 
 	check_null_seg_clears_base(c);
+
+	zenbleed_check(c);
 }
 
 #ifdef CONFIG_X86_32
@@ -1153,73 +1263,6 @@ static const struct cpu_dev amd_cpu_dev = {
 
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
@@ -1238,3 +1281,15 @@ void set_dr_addr_mask(unsigned long mask, int dr)
 		break;
 	}
 }
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
index e2dee6010846..f41781d06a5f 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2165,6 +2165,8 @@ void microcode_check(struct cpuinfo_x86 *prev_info)
 
 	perf_check_microcode();
 
+	amd_check_microcode();
+
 	store_cpu_caps(&curr_info);
 
 	if (!memcmp(&prev_info->x86_capability, &curr_info.x86_capability,
diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index d3bce6d380ed..936085d819b1 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -700,7 +700,7 @@ static enum ucode_state apply_microcode_amd(int cpu)
 	rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
 
 	/* need to apply patch? */
-	if (rev >= mc_amd->hdr.patch_id) {
+	if (rev > mc_amd->hdr.patch_id) {
 		ret = UCODE_OK;
 		goto out;
 	}
