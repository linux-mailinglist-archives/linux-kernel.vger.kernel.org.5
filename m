Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90CE7D01E8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 20:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346471AbjJSSiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 14:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235529AbjJSSiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 14:38:03 -0400
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5A6197
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 11:37:56 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-9c603e2354fso6067466b.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 11:37:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697740675; x=1698345475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SGLP9w8wJBecyYnsI3hAUIRuyH/JjC2DNQCPItft/dI=;
        b=EgUY4X5LsnbGcSy8fmR3t8JZRPh+Hu2/7SqZrifAKOmJN8drtw2f+Lkdy1bmmSkWhd
         Uv1v+VEqKzF8ivaWREVbnv4fG34M2oy6JR5W6yePobdsBaJgH7gLDfsKYQxSrdCJ3ADb
         M3UpApzuiDFmC62iOXZxEaqC931KtyNzGwBjwgyuPh+PLahYjl4jfXqGB2xmDnqrufew
         IbrZGh9V7QNa3EBl7158TiDXqb1kT6a1QJdLOs/VQdVimMmldxicp0FsMj9z+9s5WTVF
         Ax8bs7+pOYZbaHQTjURJzjVodyLCzFag9a4WGsvEjBB/SF6L6QZHxW8iISH4hcdNXX0d
         Y3Eg==
X-Gm-Message-State: AOJu0Yy8FFtxHJr8wqMEBPO935tHcsp9TybvhpHQLHsdcaWj/12lmSIc
        7h9SSfmZQTsFwW3kIKQcdIw=
X-Google-Smtp-Source: AGHT+IHSd9a76MligsQicMBnEDnUXBv1BUKVtfclXH2kMkj/ZNJFgWUSQMv3DTjNpCNqVV5W2zgddA==
X-Received: by 2002:a17:907:7f16:b0:9ad:f60c:7287 with SMTP id qf22-20020a1709077f1600b009adf60c7287mr2268215ejc.28.1697740674787;
        Thu, 19 Oct 2023 11:37:54 -0700 (PDT)
Received: from localhost (fwdproxy-cln-003.fbsv.net. [2a03:2880:31ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id q21-20020a170906a09500b00997cce73cc7sm28657ejy.29.2023.10.19.11.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 11:37:54 -0700 (PDT)
From:   Breno Leitao <leitao@debian.org>
To:     jpoimboe@kernel.org, mingo@redhat.com, tglx@linutronix.de,
        bp@alien8.de, Dave Hansen <dave.hansen@linux.intel.com>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc:     leit@meta.com,
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT))
Subject: [PATCH v5 12/12] x86/bugs: Add a separate config for missing mitigation
Date:   Thu, 19 Oct 2023 11:11:58 -0700
Message-Id: <20231019181158.1982205-13-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019181158.1982205-1-leitao@debian.org>
References: <20231019181158.1982205-1-leitao@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the CONFIG_SPECULATION_MITIGATIONS is halfway populated,
where some mitigations have entries in Kconfig, and they could be
modified, while others mitigations do not have Kconfig entries, and
could not be controlled at build time.

Create an entry for each CPU mitigation under
CONFIG_SPECULATION_MITIGATIONS. This allow users to enable or disable
them at compilation time.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/x86/Kconfig           | 93 ++++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/bugs.c | 39 ++++++++++------
 2 files changed, 117 insertions(+), 15 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index a5cada7443ea..ccdcb1dcdc0c 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2591,6 +2591,99 @@ config MITIGATION_GDS_FORCE
 
 	  If in doubt, say N.
 
+config MITIGATION_MDS
+	bool "Mitigate Microarchitectural Data Sampling (MDS) hardware bug"
+	depends on CPU_SUP_INTEL
+	default y
+	help
+	  Enable mitigation for Microarchitectural Data Sampling (MDS). MDS is
+	  a hardware vulnerability which allows unprivileged speculative access
+	  to data which is available in various CPU internal buffer. Deeper
+	  technical information is available in the MDS specific x86 architecture
+	  section: Documentation/arch/x86/mds.rst.
+
+config MITIGATION_TAA
+	bool "Mitigate TSX Asynchronous Abort (TAA) hardware bug"
+	depends on CPU_SUP_INTEL
+	default y
+	help
+	  Enable mitigation for TSX Asynchronous Abort (TAA). TAA is a hardware
+	  vulnerability that allows unprivileged speculative access to data
+	  which is available in various CPU internal buffers by using
+	  asynchronous aborts within an Intel TSX transactional region.
+
+config MITIGATION_MMIO_STALE_DATA
+	bool "Mitigate MMIO Stale Data hardware bug"
+	depends on CPU_SUP_INTEL
+	default y
+	help
+	  Enable mitigation for MMIO Stale Data hardware bugs.  Processor MMIO
+	  Stale Data Vulnerabilities are a class of memory-mapped I/O (MMIO)
+	  vulnerabilities that can expose data. The vulnerabilities require the
+	  attacker to have access to MMIO.
+
+config MITIGATION_L1TF
+	bool "Mitigate L1 Terminal Fault (L1TF) hardware bug"
+	default y
+	help
+	  Mitigate L1 Terminal Fault (L1TF) hardware bug. L1 Terminal Fault is a
+	  hardware vulnerability which allows unprivileged speculative access to data
+	  which is available in the Level 1 Data Cache when the page table
+	  entry controlling the virtual address.
+
+config MITIGATION_RETBLEED
+	bool "Mitigate RETBleed hardware bug"
+	default y
+	help
+	  Enable mitigation for RETBleed (Arbitrary Speculative Code Execution
+	  with Return Instructions) vulnerability.  RETBleed is a speculative
+	  execution attack which takes advantage of microarchitectural behavior
+	  in many modern microprocessors, similar to Spectre v2. An
+	  unprivileged attacker can use these flaws to bypass conventional
+	  memory security restrictions to gain read access to privileged memory
+	  that would otherwise be inaccessible.
+
+config MITIGATION_SPECTRE_V1
+	bool "Mitigate SPECTRE V1 hardware bug"
+	default y
+	help
+	  Enable mitigation for Spectre V1 (Bounds Check Bypass). Spectre V1 is a
+	  class of side channel attacks that takes advantage of speculative
+	  execution that bypasses conditional branch instructions used for
+	  memory access bounds check.
+
+config MITIGATION_SPECTRE_V2
+	bool "Mitigate SPECTRE V2 hardware bug"
+	default y
+	help
+	  Enable mitigation for Spectre V2 (Branch Target Injection). Spectre
+	  V2 is a class of side channel attacks that takes advantage of
+	  indirect branch predictors inside the processor. In Spectre variant 2
+	  attacks, the attacker can steer speculative indirect branches in the
+	  victim to gadget code by poisoning the branch target buffer of a CPU
+	  used for predicting indirect branch addresses.
+
+config MITIGATION_SRBDS
+	bool "Mitigate Special Register Buffer Data Sampling (SRBDS) hardware bug"
+	depends on CPU_SUP_INTEL
+	default y
+	help
+	  Enable mitigation for Special Register Buffer Data Sampling (SRBDS).
+	  SRBDS is a hardware vulnerability that allows Microarchitectural Data
+	  Sampling (MDS) techniques to infer values returned from special
+	  register accesses. An unprivileged user can extract values returned
+	  from RDRAND and RDSEED executed on another core or sibling thread
+	  using MDS techniques.
+
+config MITIGATION_SSB
+	bool "Mitigate Speculative Store Bypass (SSB) hardware bug"
+	default y
+	help
+	  Enable mitigation for Speculative Store Bypass (SSB). SSB is a
+	  hardware security vulnerability and its exploitation takes advantage
+	  of speculative execution in a similar way to the Meltdown and Spectre
+	  security vulnerabilities.
+
 endif
 
 config ARCH_HAS_ADD_PAGES
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 0172bb0f61fe..11ccbadd8800 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -232,7 +232,8 @@ static void x86_amd_ssb_disable(void)
 #define pr_fmt(fmt)	"MDS: " fmt
 
 /* Default mitigation for MDS-affected CPUs */
-static enum mds_mitigations mds_mitigation __ro_after_init = MDS_MITIGATION_FULL;
+static enum mds_mitigations mds_mitigation __ro_after_init =
+	IS_ENABLED(CONFIG_MITIGATION_MDS) ? MDS_MITIGATION_FULL : MDS_MITIGATION_OFF;
 static bool mds_nosmt __ro_after_init = false;
 
 static const char * const mds_strings[] = {
@@ -292,7 +293,8 @@ enum taa_mitigations {
 };
 
 /* Default mitigation for TAA-affected CPUs */
-static enum taa_mitigations taa_mitigation __ro_after_init = TAA_MITIGATION_VERW;
+static enum taa_mitigations taa_mitigation __ro_after_init =
+	IS_ENABLED(CONFIG_MITIGATION_TAA) ? TAA_MITIGATION_VERW : TAA_MITIGATION_OFF;
 static bool taa_nosmt __ro_after_init;
 
 static const char * const taa_strings[] = {
@@ -393,7 +395,8 @@ enum mmio_mitigations {
 };
 
 /* Default mitigation for Processor MMIO Stale Data vulnerabilities */
-static enum mmio_mitigations mmio_mitigation __ro_after_init = MMIO_MITIGATION_VERW;
+static enum mmio_mitigations mmio_mitigation __ro_after_init =
+	IS_ENABLED(CONFIG_MITIGATION_MMIO_STALE_DATA) ? MMIO_MITIGATION_VERW : MMIO_MITIGATION_OFF;
 static bool mmio_nosmt __ro_after_init = false;
 
 static const char * const mmio_strings[] = {
@@ -542,7 +545,8 @@ enum srbds_mitigations {
 	SRBDS_MITIGATION_HYPERVISOR,
 };
 
-static enum srbds_mitigations srbds_mitigation __ro_after_init = SRBDS_MITIGATION_FULL;
+static enum srbds_mitigations srbds_mitigation __ro_after_init =
+	IS_ENABLED(CONFIG_MITIGATION_SRBDS) ? SRBDS_MITIGATION_FULL : SRBDS_MITIGATION_OFF;
 
 static const char * const srbds_strings[] = {
 	[SRBDS_MITIGATION_OFF]		= "Vulnerable",
@@ -812,7 +816,8 @@ enum spectre_v1_mitigation {
 };
 
 static enum spectre_v1_mitigation spectre_v1_mitigation __ro_after_init =
-	SPECTRE_V1_MITIGATION_AUTO;
+	IS_ENABLED(CONFIG_MITIGATION_SPECTRE_V1) ?
+		SPECTRE_V1_MITIGATION_AUTO : SPECTRE_V1_MITIGATION_NONE;
 
 static const char * const spectre_v1_strings[] = {
 	[SPECTRE_V1_MITIGATION_NONE] = "Vulnerable: __user pointer sanitization and usercopy barriers only; no swapgs barriers",
@@ -927,7 +932,7 @@ static const char * const retbleed_strings[] = {
 static enum retbleed_mitigation retbleed_mitigation __ro_after_init =
 	RETBLEED_MITIGATION_NONE;
 static enum retbleed_mitigation_cmd retbleed_cmd __ro_after_init =
-	RETBLEED_CMD_AUTO;
+	IS_ENABLED(CONFIG_MITIGATION_RETBLEED) ? RETBLEED_CMD_AUTO : RETBLEED_CMD_OFF;
 
 static int __ro_after_init retbleed_nosmt = false;
 
@@ -1388,17 +1393,18 @@ static void __init spec_v2_print_cond(const char *reason, bool secure)
 
 static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
 {
-	enum spectre_v2_mitigation_cmd cmd = SPECTRE_V2_CMD_AUTO;
+	enum spectre_v2_mitigation_cmd cmd;
 	char arg[20];
 	int ret, i;
 
+	cmd = IS_ENABLED(CONFIG_MITIGATION_SPECTRE_V2) ?  SPECTRE_V2_CMD_AUTO : SPECTRE_V2_CMD_NONE;
 	if (cmdline_find_option_bool(boot_command_line, "nospectre_v2") ||
 	    cpu_mitigations_off())
 		return SPECTRE_V2_CMD_NONE;
 
 	ret = cmdline_find_option(boot_command_line, "spectre_v2", arg, sizeof(arg));
 	if (ret < 0)
-		return SPECTRE_V2_CMD_AUTO;
+		return cmd;
 
 	for (i = 0; i < ARRAY_SIZE(mitigation_options); i++) {
 		if (!match_option(arg, ret, mitigation_options[i].option))
@@ -1408,8 +1414,8 @@ static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
 	}
 
 	if (i >= ARRAY_SIZE(mitigation_options)) {
-		pr_err("unknown option (%s). Switching to AUTO select\n", arg);
-		return SPECTRE_V2_CMD_AUTO;
+		pr_err("unknown option (%s). Switching to default mode\n", arg);
+		return cmd;
 	}
 
 	if ((cmd == SPECTRE_V2_CMD_RETPOLINE ||
@@ -1882,10 +1888,12 @@ static const struct {
 
 static enum ssb_mitigation_cmd __init ssb_parse_cmdline(void)
 {
-	enum ssb_mitigation_cmd cmd = SPEC_STORE_BYPASS_CMD_AUTO;
+	enum ssb_mitigation_cmd cmd;
 	char arg[20];
 	int ret, i;
 
+	cmd = IS_ENABLED(CONFIG_MITIGATION_SSB) ?
+		SPEC_STORE_BYPASS_CMD_AUTO : SPEC_STORE_BYPASS_CMD_NONE;
 	if (cmdline_find_option_bool(boot_command_line, "nospec_store_bypass_disable") ||
 	    cpu_mitigations_off()) {
 		return SPEC_STORE_BYPASS_CMD_NONE;
@@ -1893,7 +1901,7 @@ static enum ssb_mitigation_cmd __init ssb_parse_cmdline(void)
 		ret = cmdline_find_option(boot_command_line, "spec_store_bypass_disable",
 					  arg, sizeof(arg));
 		if (ret < 0)
-			return SPEC_STORE_BYPASS_CMD_AUTO;
+			return cmd;
 
 		for (i = 0; i < ARRAY_SIZE(ssb_mitigation_options); i++) {
 			if (!match_option(arg, ret, ssb_mitigation_options[i].option))
@@ -1904,8 +1912,8 @@ static enum ssb_mitigation_cmd __init ssb_parse_cmdline(void)
 		}
 
 		if (i >= ARRAY_SIZE(ssb_mitigation_options)) {
-			pr_err("unknown option (%s). Switching to AUTO select\n", arg);
-			return SPEC_STORE_BYPASS_CMD_AUTO;
+			pr_err("unknown option (%s). Switching to default mode\n", arg);
+			return cmd;
 		}
 	}
 
@@ -2232,7 +2240,8 @@ EXPORT_SYMBOL_GPL(itlb_multihit_kvm_mitigation);
 #define pr_fmt(fmt)	"L1TF: " fmt
 
 /* Default mitigation for L1TF-affected CPUs */
-enum l1tf_mitigations l1tf_mitigation __ro_after_init = L1TF_MITIGATION_FLUSH;
+enum l1tf_mitigations l1tf_mitigation __ro_after_init =
+	IS_ENABLED(CONFIG_MITIGATION_L1TF) ? L1TF_MITIGATION_FLUSH : L1TF_MITIGATION_OFF;
 #if IS_ENABLED(CONFIG_KVM_INTEL)
 EXPORT_SYMBOL_GPL(l1tf_mitigation);
 #endif
-- 
2.34.1

