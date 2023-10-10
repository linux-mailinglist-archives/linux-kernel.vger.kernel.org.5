Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41ED7BF8B0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 12:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjJJKbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 06:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbjJJKbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 06:31:04 -0400
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35483C6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 03:31:01 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-53636f98538so9471410a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 03:31:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696933859; x=1697538659;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jxTTIfEk5BlMQNkqMHPXZYquhIhqz0+wl+jFZPV8KAM=;
        b=LRy2XCy5VWIG9CXQm6oBTq5zisQCLlhpul4vKHDgXAxfz2uL3UOS8JVrAgQZB4AfiM
         aPwIgvAaMCLogtPKXoUcAdwrecr9nporKKO7c0/Gk/pET+66adBh2ghg+er7HS5l9zb8
         Ms2MfvRb9wxScCyJOC9wHfTGhqtUir+DO0MYCr3MXuxm0KPc7S38qtyM5+995fqxAMoG
         YSUM1i9jlyVLDg/6WOyHrkK8QPqpWGlbJ8PouhKo9hMP2d1KEDU1suQ9CPZnZ9bgDEnF
         pBuXFkISH+IqownQCbBtIqUiTv+YUTfAWOpHRTO+4ZrwQgsbfHaWp74Tu0+83MexVVhv
         C3fw==
X-Gm-Message-State: AOJu0YyHQ24rQfBsoz7Y/YTlXpLUUNChtooqoULbHvfp+4PcS5tVCbd+
        +9u2kaGCPit9JbdL541AIks=
X-Google-Smtp-Source: AGHT+IE1kQj8s4zcFdDh5LbpO24ATX5SYr7e7o2f9AbXK8sLr+gqgC7olG7Ehs2lf4MNSXf7aqMQFA==
X-Received: by 2002:a17:906:217:b0:9b2:b46e:8a79 with SMTP id 23-20020a170906021700b009b2b46e8a79mr16162481ejd.30.1696933859459;
        Tue, 10 Oct 2023 03:30:59 -0700 (PDT)
Received: from localhost (fwdproxy-cln-019.fbsv.net. [2a03:2880:31ff:13::face:b00c])
        by smtp.gmail.com with ESMTPSA id a6-20020a170906468600b009a5f7fb51dcsm8143866ejr.42.2023.10.10.03.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 03:30:58 -0700 (PDT)
From:   Breno Leitao <leitao@debian.org>
To:     tglx@linutronix.de, bp@alien8.de, Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc:     leit@meta.com,
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT))
Subject: [PATCH v4] x86/bugs: Add a separate config for each mitigation
Date:   Tue, 10 Oct 2023 03:30:27 -0700
Message-Id: <20231010103028.4192223-1-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create an entry for each CPU mitigation under
CONFIG_SPECULATION_MITIGATIONS. This allow users to enable or disable
them at compilation time.

Currently, the CONFIG_SPECULATION_MITIGATIONS is halfway populated,
where some mitigations have entries in Kconfig, and they could be
modified, while others mitigations do not have Kconfig entries, and
could not be controlled at build time.

The fact of having a fine grained control can help in a few ways:

1) Users can choose and pick only mitigations that are important for
their workloads.

2) Users and developers can choose to disable mitigations that mangle
the assembly code generation, making it hard to read.

3) Separate configs for just source code readability, so that developers
see *which* butt-ugly piece of crap code is for what reason.

Important to say, if a mitigation is disabled at compilation time, it
could be enabled at runtime using kernel command line arguments.

Discussion about this approach:
https://lore.kernel.org/all/CAHk-=wjTHeQjsqtHcBGvy9TaJQ5uAm5HrCDuOD9v7qA9U1Xr4w@mail.gmail.com/

Signed-off-by: Breno Leitao <leitao@debian.org>

---
V1:
	* Creates a way to mitigate all (or none) hardware bugs
V2:
	* Create KCONFIGs entries only some hardware bugs (MDS, TAA, MMIO)
V3:
	* Expand the mitigations KCONFIGs to all hardware bugs that are
	  Linux mitigates.
V4:
	* Patch rebase
	* Better documentation about the reasons of this decision
---
 arch/x86/Kconfig           | 93 ++++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/bugs.c | 50 +++++++++++++++++---
 2 files changed, 137 insertions(+), 6 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index d4a73d12780a..9eeeed4ba0bb 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2585,6 +2585,99 @@ config GDS_FORCE_MITIGATION
 
 	  If in doubt, say N.
 
+config MITIGATE_MDS
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
+config MITIGATE_TAA
+	bool "Mitigate TSX Asynchronous Abort (TAA) hardware bug"
+	depends on CPU_SUP_INTEL
+	default y
+	help
+	  Enable mitigation for TSX Asynchronous Abort (TAA). TAA is a hardware
+	  vulnerability that allows unprivileged speculative access to data
+	  which is available in various CPU internal buffers by using
+	  asynchronous aborts within an Intel TSX transactional region.
+
+config MITIGATE_MMIO_STALE_DATA
+	bool "Mitigate MMIO Stale Data hardware bug"
+	depends on CPU_SUP_INTEL
+	default y
+	help
+	  Enable mitigation for MMIO Stale Data hardware bugs.  Processor MMIO
+	  Stale Data Vulnerabilities are a class of memory-mapped I/O (MMIO)
+	  vulnerabilities that can expose data. The vulnerabilities require the
+	  attacker to have access to MMIO.
+
+config MITIGATE_L1TF
+	bool "Mitigate L1 Terminal Fault (L1TF) hardware bug"
+	default y
+	help
+	  Mitigate L1 Terminal Fault (L1TF) hardware bug. L1 Terminal Fault is a
+	  hardware vulnerability which allows unprivileged speculative access to data
+	  which is available in the Level 1 Data Cache when the page table
+	  entry controlling the virtual address.
+
+config MITIGATE_RETBLEED
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
+config MITIGATE_SPECTRE_V1
+	bool "Mitigate SPECTRE V1 hardware bug"
+	default y
+	help
+	  Enable mitigation for Spectre V1 (Bounds Check Bypass). Spectre V1 is a
+	  class of side channel attacks that takes advantage of speculative
+	  execution that bypasses conditional branch instructions used for
+	  memory access bounds check.
+
+config MITIGATE_SPECTRE_V2
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
+config MITIGATE_SRBDS
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
+config MITIGATE_SSB
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
index bb0ab8466b91..64aa77447e4b 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -232,7 +232,11 @@ static void x86_amd_ssb_disable(void)
 #define pr_fmt(fmt)	"MDS: " fmt
 
 /* Default mitigation for MDS-affected CPUs */
+#if IS_ENABLED(CONFIG_MITIGATE_MDS)
 static enum mds_mitigations mds_mitigation __ro_after_init = MDS_MITIGATION_FULL;
+#else
+static enum mds_mitigations mds_mitigation __ro_after_init = MDS_MITIGATION_OFF;
+#endif
 static bool mds_nosmt __ro_after_init = false;
 
 static const char * const mds_strings[] = {
@@ -292,7 +296,11 @@ enum taa_mitigations {
 };
 
 /* Default mitigation for TAA-affected CPUs */
+#if IS_ENABLED(CONFIG_MITIGATE_TAA)
 static enum taa_mitigations taa_mitigation __ro_after_init = TAA_MITIGATION_VERW;
+#else
+static enum taa_mitigations taa_mitigation __ro_after_init = TAA_MITIGATION_OFF;
+#endif
 static bool taa_nosmt __ro_after_init;
 
 static const char * const taa_strings[] = {
@@ -393,7 +401,11 @@ enum mmio_mitigations {
 };
 
 /* Default mitigation for Processor MMIO Stale Data vulnerabilities */
+#if IS_ENABLED(CONFIG_MITIGATE_MMIO_STALE_DATA)
 static enum mmio_mitigations mmio_mitigation __ro_after_init = MMIO_MITIGATION_VERW;
+#else
+static enum mmio_mitigations mmio_mitigation __ro_after_init = MMIO_MITIGATION_OFF;
+#endif
 static bool mmio_nosmt __ro_after_init = false;
 
 static const char * const mmio_strings[] = {
@@ -542,7 +554,11 @@ enum srbds_mitigations {
 	SRBDS_MITIGATION_HYPERVISOR,
 };
 
+#if IS_ENABLED(CONFIG_MITIGATE_SRBDS)
 static enum srbds_mitigations srbds_mitigation __ro_after_init = SRBDS_MITIGATION_FULL;
+#else
+static enum srbds_mitigations srbds_mitigation __ro_after_init = SRBDS_MITIGATION_OFF;
+#endif
 
 static const char * const srbds_strings[] = {
 	[SRBDS_MITIGATION_OFF]		= "Vulnerable",
@@ -810,8 +826,13 @@ enum spectre_v1_mitigation {
 	SPECTRE_V1_MITIGATION_AUTO,
 };
 
+#if IS_ENABLED(CONFIG_MITIGATE_SPECTRE_V1)
 static enum spectre_v1_mitigation spectre_v1_mitigation __ro_after_init =
 	SPECTRE_V1_MITIGATION_AUTO;
+#else
+static enum spectre_v1_mitigation spectre_v1_mitigation __ro_after_init =
+	SPECTRE_V1_MITIGATION_NONE;
+#endif
 
 static const char * const spectre_v1_strings[] = {
 	[SPECTRE_V1_MITIGATION_NONE] = "Vulnerable: __user pointer sanitization and usercopy barriers only; no swapgs barriers",
@@ -925,8 +946,13 @@ static const char * const retbleed_strings[] = {
 
 static enum retbleed_mitigation retbleed_mitigation __ro_after_init =
 	RETBLEED_MITIGATION_NONE;
+#if IS_ENABLED(CONFIG_MITIGATE_RETBLEED)
 static enum retbleed_mitigation_cmd retbleed_cmd __ro_after_init =
 	RETBLEED_CMD_AUTO;
+#else
+static enum retbleed_mitigation_cmd retbleed_cmd __ro_after_init =
+	RETBLEED_CMD_OFF;
+#endif
 
 static int __ro_after_init retbleed_nosmt = false;
 
@@ -1386,7 +1412,11 @@ static void __init spec_v2_print_cond(const char *reason, bool secure)
 
 static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
 {
+#if IS_ENABLED(CONFIG_MITIGATE_SPECTRE_V2)
 	enum spectre_v2_mitigation_cmd cmd = SPECTRE_V2_CMD_AUTO;
+#else
+	enum spectre_v2_mitigation_cmd cmd = SPECTRE_V2_CMD_NONE;
+#endif
 	char arg[20];
 	int ret, i;
 
@@ -1396,7 +1426,7 @@ static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
 
 	ret = cmdline_find_option(boot_command_line, "spectre_v2", arg, sizeof(arg));
 	if (ret < 0)
-		return SPECTRE_V2_CMD_AUTO;
+		return cmd;
 
 	for (i = 0; i < ARRAY_SIZE(mitigation_options); i++) {
 		if (!match_option(arg, ret, mitigation_options[i].option))
@@ -1406,8 +1436,8 @@ static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
 	}
 
 	if (i >= ARRAY_SIZE(mitigation_options)) {
-		pr_err("unknown option (%s). Switching to AUTO select\n", arg);
-		return SPECTRE_V2_CMD_AUTO;
+		pr_err("unknown option (%s). Switching to default mode\n", arg);
+		return cmd;
 	}
 
 	if ((cmd == SPECTRE_V2_CMD_RETPOLINE ||
@@ -1880,7 +1910,11 @@ static const struct {
 
 static enum ssb_mitigation_cmd __init ssb_parse_cmdline(void)
 {
+#if IS_ENABLED(CONFIG_MITIGATE_SSB)
 	enum ssb_mitigation_cmd cmd = SPEC_STORE_BYPASS_CMD_AUTO;
+#else
+	enum ssb_mitigation_cmd cmd = SPEC_STORE_BYPASS_CMD_NONE;
+#endif
 	char arg[20];
 	int ret, i;
 
@@ -1891,7 +1925,7 @@ static enum ssb_mitigation_cmd __init ssb_parse_cmdline(void)
 		ret = cmdline_find_option(boot_command_line, "spec_store_bypass_disable",
 					  arg, sizeof(arg));
 		if (ret < 0)
-			return SPEC_STORE_BYPASS_CMD_AUTO;
+			return cmd;
 
 		for (i = 0; i < ARRAY_SIZE(ssb_mitigation_options); i++) {
 			if (!match_option(arg, ret, ssb_mitigation_options[i].option))
@@ -1902,8 +1936,8 @@ static enum ssb_mitigation_cmd __init ssb_parse_cmdline(void)
 		}
 
 		if (i >= ARRAY_SIZE(ssb_mitigation_options)) {
-			pr_err("unknown option (%s). Switching to AUTO select\n", arg);
-			return SPEC_STORE_BYPASS_CMD_AUTO;
+			pr_err("unknown option (%s). Switching to default mode\n", arg);
+			return cmd;
 		}
 	}
 
@@ -2230,7 +2264,11 @@ EXPORT_SYMBOL_GPL(itlb_multihit_kvm_mitigation);
 #define pr_fmt(fmt)	"L1TF: " fmt
 
 /* Default mitigation for L1TF-affected CPUs */
+#if IS_ENABLED(CONFIG_MITIGATE_L1TF)
 enum l1tf_mitigations l1tf_mitigation __ro_after_init = L1TF_MITIGATION_FLUSH;
+#else
+enum l1tf_mitigations l1tf_mitigation __ro_after_init = L1TF_MITIGATION_OFF;
+#endif
 #if IS_ENABLED(CONFIG_KVM_INTEL)
 EXPORT_SYMBOL_GPL(l1tf_mitigation);
 #endif
-- 
2.34.1

