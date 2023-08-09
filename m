Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8518E77540B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 09:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbjHIH1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 03:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbjHIH04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 03:26:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14FC1BFF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 00:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=YqgHXnfrrD3yX4292tz7J3YuwCLJWffqgz+/6jxutKM=; b=AT+OPRRUf9l4N24UfAU4VHQnlA
        WieHsPH8Mrv3lmuV6MyCCGr58qUwI6voObsd7Il1fhTb/o30NrFaZrHB0JUDXNGkDsI3Vz9YQCRbN
        O5i+cfOfKV4LG5JZiuEaaMUt9g8NOqVpcqX1MgOkG2AQQXshzB538qVMLuRfH/qVGR7NEPEx5FFci
        P6XHh72h2D2OrPFTEVIR7ElxQPhMmCzYQUoWvVI8uRcsxKqiJVC4eM1cizu8X5tFZibfCtTqOpe8f
        zhzUp4kFzKVu9m4Wmq6HlSL4+go1Tr1VW1GSjFlBab4gwSyTnIZz5ABJMFXqcDaoKEfhQx9GLFipN
        TGc+vXgA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qTdag-004olV-74; Wed, 09 Aug 2023 07:26:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A1961301C62;
        Wed,  9 Aug 2023 09:26:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 81C7F2CECA482; Wed,  9 Aug 2023 09:26:44 +0200 (CEST)
Message-ID: <20230809072201.192502969@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 09 Aug 2023 09:12:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        David.Kaplan@amd.com, Andrew.Cooper3@citrix.com,
        jpoimboe@kernel.org, gregkh@linuxfoundation.org
Subject: [RFC][PATCH 11/17] x86/cpu: Remove all SRSO interface nonsense
References: <20230809071218.000335006@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that retbleed can do all that the srso knob did, and without the
dubious interactions with retbleed selections, remove it.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/cpu/bugs.c |  188 ++-------------------------------------------
 drivers/base/cpu.c         |    8 -
 include/linux/cpu.h        |    2 
 3 files changed, 10 insertions(+), 188 deletions(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -47,7 +47,6 @@ static void __init taa_select_mitigation
 static void __init mmio_select_mitigation(void);
 static void __init srbds_select_mitigation(void);
 static void __init l1d_flush_select_mitigation(void);
-static void __init srso_select_mitigation(void);
 
 /* The base value of the SPEC_CTRL MSR without task-specific bits set */
 u64 x86_spec_ctrl_base;
@@ -164,7 +163,6 @@ void __init cpu_select_mitigations(void)
 	md_clear_select_mitigation();
 	srbds_select_mitigation();
 	l1d_flush_select_mitigation();
-	srso_select_mitigation();
 }
 
 /*
@@ -2267,164 +2265,6 @@ static int __init l1tf_cmdline(char *str
 early_param("l1tf", l1tf_cmdline);
 
 #undef pr_fmt
-#define pr_fmt(fmt)	"Speculative Return Stack Overflow: " fmt
-
-enum srso_mitigation {
-	SRSO_MITIGATION_NONE,
-	SRSO_MITIGATION_MICROCODE,
-	SRSO_MITIGATION_SAFE_RET,
-	SRSO_MITIGATION_IBPB,
-	SRSO_MITIGATION_IBPB_ON_VMEXIT,
-};
-
-enum srso_mitigation_cmd {
-	SRSO_CMD_OFF,
-	SRSO_CMD_MICROCODE,
-	SRSO_CMD_SAFE_RET,
-	SRSO_CMD_IBPB,
-	SRSO_CMD_IBPB_ON_VMEXIT,
-};
-
-static const char * const srso_strings[] = {
-	[SRSO_MITIGATION_NONE]           = "Vulnerable",
-	[SRSO_MITIGATION_MICROCODE]      = "Mitigation: microcode",
-	[SRSO_MITIGATION_SAFE_RET]	 = "Mitigation: safe RET",
-	[SRSO_MITIGATION_IBPB]		 = "Mitigation: IBPB",
-	[SRSO_MITIGATION_IBPB_ON_VMEXIT] = "Mitigation: IBPB on VMEXIT only"
-};
-
-static enum srso_mitigation srso_mitigation __ro_after_init = SRSO_MITIGATION_NONE;
-static enum srso_mitigation_cmd srso_cmd __ro_after_init = SRSO_CMD_SAFE_RET;
-
-static int __init srso_parse_cmdline(char *str)
-{
-	if (!str)
-		return -EINVAL;
-
-	if (!strcmp(str, "off"))
-		srso_cmd = SRSO_CMD_OFF;
-	else if (!strcmp(str, "microcode"))
-		srso_cmd = SRSO_CMD_MICROCODE;
-	else if (!strcmp(str, "safe-ret"))
-		srso_cmd = SRSO_CMD_SAFE_RET;
-	else if (!strcmp(str, "ibpb"))
-		srso_cmd = SRSO_CMD_IBPB;
-	else if (!strcmp(str, "ibpb-vmexit"))
-		srso_cmd = SRSO_CMD_IBPB_ON_VMEXIT;
-	else
-		pr_err("Ignoring unknown SRSO option (%s).", str);
-
-	return 0;
-}
-early_param("spec_rstack_overflow", srso_parse_cmdline);
-
-#define SRSO_NOTICE "WARNING: See https://kernel.org/doc/html/latest/admin-guide/hw-vuln/srso.html for mitigation options."
-
-static void __init srso_select_mitigation(void)
-{
-	bool has_microcode;
-
-	if (!boot_cpu_has_bug(X86_BUG_SRSO) || cpu_mitigations_off())
-		goto pred_cmd;
-
-	/*
-	 * The first check is for the kernel running as a guest in order
-	 * for guests to verify whether IBPB is a viable mitigation.
-	 */
-	has_microcode = boot_cpu_has(X86_FEATURE_IBPB_BRTYPE) || cpu_has_ibpb_brtype_microcode();
-	if (!has_microcode) {
-		pr_warn("IBPB-extending microcode not applied!\n");
-		pr_warn(SRSO_NOTICE);
-	} else {
-		/*
-		 * Enable the synthetic (even if in a real CPUID leaf)
-		 * flags for guests.
-		 */
-		setup_force_cpu_cap(X86_FEATURE_IBPB_BRTYPE);
-		setup_force_cpu_cap(X86_FEATURE_SBPB);
-
-		/*
-		 * Zen1/2 with SMT off aren't vulnerable after the right
-		 * IBPB microcode has been applied.
-		 */
-		if ((boot_cpu_data.x86 < 0x19) &&
-		    (cpu_smt_control == CPU_SMT_DISABLED))
-			setup_force_cpu_cap(X86_FEATURE_SRSO_NO);
-	}
-
-	if (retbleed_mitigation == RETBLEED_MITIGATION_IBPB) {
-		if (has_microcode) {
-			pr_err("Retbleed IBPB mitigation enabled, using same for SRSO\n");
-			srso_mitigation = SRSO_MITIGATION_IBPB;
-			goto pred_cmd;
-		}
-	}
-
-	switch (srso_cmd) {
-	case SRSO_CMD_OFF:
-		return;
-
-	case SRSO_CMD_MICROCODE:
-		if (has_microcode) {
-			srso_mitigation = SRSO_MITIGATION_MICROCODE;
-			pr_warn(SRSO_NOTICE);
-		}
-		break;
-
-	case SRSO_CMD_SAFE_RET:
-		if (IS_ENABLED(CONFIG_CPU_SRSO)) {
-			/*
-			 * Enable the return thunk for generated code
-			 * like ftrace, static_call, etc.
-			 */
-			setup_force_cpu_cap(X86_FEATURE_RETHUNK);
-
-			if (boot_cpu_data.x86 == 0x19) {
-				setup_force_cpu_cap(X86_FEATURE_SRSO_ALIAS);
-				x86_return_thunk = srso_alias_return_thunk;
-			} else {
-				setup_force_cpu_cap(X86_FEATURE_SRSO);
-				x86_return_thunk = srso_return_thunk;
-			}
-			srso_mitigation = SRSO_MITIGATION_SAFE_RET;
-		} else {
-			pr_err("WARNING: kernel not compiled with CPU_SRSO.\n");
-			goto pred_cmd;
-		}
-		break;
-
-	case SRSO_CMD_IBPB:
-		if (has_microcode) {
-			setup_force_cpu_cap(X86_FEATURE_ENTRY_IBPB);
-			srso_mitigation = SRSO_MITIGATION_IBPB;
-		}
-		break;
-
-	case SRSO_CMD_IBPB_ON_VMEXIT:
-		if (IS_ENABLED(CONFIG_CPU_SRSO)) {
-			if (!boot_cpu_has(X86_FEATURE_ENTRY_IBPB) && has_microcode) {
-				setup_force_cpu_cap(X86_FEATURE_IBPB_ON_VMEXIT);
-				srso_mitigation = SRSO_MITIGATION_IBPB_ON_VMEXIT;
-			}
-		} else {
-			pr_err("WARNING: kernel not compiled with CPU_SRSO.\n");
-			goto pred_cmd;
-                }
-		break;
-
-	default:
-		break;
-	}
-
-	pr_info("%s%s\n", srso_strings[srso_mitigation], (has_microcode ? "" : ", no microcode"));
-
-pred_cmd:
-	if (boot_cpu_has(X86_FEATURE_SRSO_NO) ||
-	    srso_cmd == SRSO_CMD_OFF)
-		x86_pred_cmd = PRED_CMD_SBPB;
-}
-
-#undef pr_fmt
 #define pr_fmt(fmt) fmt
 
 #ifdef CONFIG_SYSFS
@@ -2607,26 +2447,26 @@ static ssize_t srbds_show_state(char *bu
 static ssize_t retbleed_show_state(char *buf)
 {
 	if (retbleed_mitigation == RETBLEED_MITIGATION_UNRET ||
+	    retbleed_mitigation == RETBLEED_MITIGATION_UNRET_SRSO ||
+	    retbleed_mitigation == RETBLEED_MITIGATION_UNRET_SRSO_ALIAS ||
 	    retbleed_mitigation == RETBLEED_MITIGATION_IBPB) {
+
 		if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
 		    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
 			return sysfs_emit(buf, "Vulnerable: untrained return thunk / IBPB on non-AMD based uarch\n");
 
-		return sysfs_emit(buf, "%s; SMT %s\n", retbleed_strings[retbleed_mitigation],
+		return sysfs_emit(buf, "%s; SMT %s%s\n", retbleed_strings[retbleed_mitigation],
 				  !sched_smt_active() ? "disabled" :
 				  spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT ||
 				  spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT_PREFERRED ?
-				  "enabled with STIBP protection" : "vulnerable");
-	}
+				  "enabled with STIBP protection" : "vulnerable",
+				  cpu_has_ibpb_brtype_microcode() ? "" : ", no SRSO microcode");
 
-	return sysfs_emit(buf, "%s\n", retbleed_strings[retbleed_mitigation]);
-}
+	}
 
-static ssize_t srso_show_state(char *buf)
-{
-	return sysfs_emit(buf, "%s%s\n",
-			  srso_strings[srso_mitigation],
-			  (cpu_has_ibpb_brtype_microcode() ? "" : ", no microcode"));
+	return sysfs_emit(buf, "%s%s\n", retbleed_strings[retbleed_mitigation],
+			  (boot_cpu_data.x86_vendor != X86_VENDOR_AMD ||
+			   cpu_has_ibpb_brtype_microcode()) ? "" : ", no SRSO microcode");
 }
 
 static ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr,
@@ -2678,9 +2518,6 @@ static ssize_t cpu_show_common(struct de
 	case X86_BUG_RETBLEED:
 		return retbleed_show_state(buf);
 
-	case X86_BUG_SRSO:
-		return srso_show_state(buf);
-
 	default:
 		break;
 	}
@@ -2745,9 +2582,4 @@ ssize_t cpu_show_retbleed(struct device
 {
 	return cpu_show_common(dev, attr, buf, X86_BUG_RETBLEED);
 }
-
-ssize_t cpu_show_spec_rstack_overflow(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	return cpu_show_common(dev, attr, buf, X86_BUG_SRSO);
-}
 #endif
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -577,12 +577,6 @@ ssize_t __weak cpu_show_retbleed(struct
 	return sysfs_emit(buf, "Not affected\n");
 }
 
-ssize_t __weak cpu_show_spec_rstack_overflow(struct device *dev,
-					     struct device_attribute *attr, char *buf)
-{
-	return sysfs_emit(buf, "Not affected\n");
-}
-
 static DEVICE_ATTR(meltdown, 0444, cpu_show_meltdown, NULL);
 static DEVICE_ATTR(spectre_v1, 0444, cpu_show_spectre_v1, NULL);
 static DEVICE_ATTR(spectre_v2, 0444, cpu_show_spectre_v2, NULL);
@@ -594,7 +588,6 @@ static DEVICE_ATTR(itlb_multihit, 0444,
 static DEVICE_ATTR(srbds, 0444, cpu_show_srbds, NULL);
 static DEVICE_ATTR(mmio_stale_data, 0444, cpu_show_mmio_stale_data, NULL);
 static DEVICE_ATTR(retbleed, 0444, cpu_show_retbleed, NULL);
-static DEVICE_ATTR(spec_rstack_overflow, 0444, cpu_show_spec_rstack_overflow, NULL);
 
 static struct attribute *cpu_root_vulnerabilities_attrs[] = {
 	&dev_attr_meltdown.attr,
@@ -608,7 +601,6 @@ static struct attribute *cpu_root_vulner
 	&dev_attr_srbds.attr,
 	&dev_attr_mmio_stale_data.attr,
 	&dev_attr_retbleed.attr,
-	&dev_attr_spec_rstack_overflow.attr,
 	NULL
 };
 
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -70,8 +70,6 @@ extern ssize_t cpu_show_mmio_stale_data(
 					char *buf);
 extern ssize_t cpu_show_retbleed(struct device *dev,
 				 struct device_attribute *attr, char *buf);
-extern ssize_t cpu_show_spec_rstack_overflow(struct device *dev,
-					     struct device_attribute *attr, char *buf);
 
 extern __printf(4, 5)
 struct device *cpu_device_create(struct device *parent, void *drvdata,


