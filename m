Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA298807699
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 18:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378496AbjLFR2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 12:28:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjLFR2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 12:28:46 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFEA3122
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 09:28:51 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40b35199f94so65e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 09:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701883730; x=1702488530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0Pho+JigyWSfjbsyzcWGR4QQI/ZeVfpkWc6n+/N4l5g=;
        b=YtsxyhMfQjJWTi4XJmP5GchF4JJtIAdMg6wOdAczGK1DU5lsOzRbcrcVxXC9SLjTfe
         912UYsvYywmzQ1NAcYO70lGarCoUU5AtLAyTTm53TeZq7Jaf2pQbJBM4pE60+Y4UggGx
         CHBfq8BymVVyJssCKdygeNxkGmMeFTwFV1c1JzxnBwg2AO5hbf9+aBKpjcUcYCu84yM2
         GuPsNN25EjIaNqqmD+5KTovM4MoyUWlQM4Q5dsdZOY5/iEkZPM7XK34J7b+/Lye5o1Zu
         JExkRobILaJp5EQTk+fe/6iN1z+UNJ3dH+ElBwjWOjfQ/BMDwBJXoICfCgYUeaMTjq3K
         CYbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701883730; x=1702488530;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Pho+JigyWSfjbsyzcWGR4QQI/ZeVfpkWc6n+/N4l5g=;
        b=Kz+0vPxnDKRi3oxEGgJdZB5DYqD9VE9l7yuezTjF4DBPiHJkP9JYJDPXZMVCROW/92
         fiZZADbNBKXVjrNkzjlsiy/fBgVkQ25NgiAtlXKr+FqWu7aMNWZVAnb+hSW6X/X0oGZy
         WPPdP0+6Cv4DaeTXm4KJro0LiImgJ45PwkvbIV/Kl4iY4/5NtXBOdzgkwEad6smGeYgK
         I2GQAA1EAbKmv7byiw0q50YcwVVOTqBqz2kTr0lu5fqdPXT0ZQsUC0MsaI4hkPEUQ+i5
         z2sYZzCxp2asOrJdt7GQzFQGwpK7OMsGj1uVxaagCNGrPNajlLfoiO4+Kw8ZnVgDP6Hn
         dTuA==
X-Gm-Message-State: AOJu0YzpvuEaBYB4RPMDhqI+YD2PdN/6JS8JRYdVjyZsD3XlUnZ7FMDQ
        5hkZ1ID3UOuoKY+rVCux0ISV8ztf+InNOTGt3jz+bVNJ
X-Google-Smtp-Source: AGHT+IFPUrf2caI78tGRmnve66A6+fATnulHHffqEw3/ZjbB6p6GzWayD2Hi8mAAA+eFPbTlpBbnng==
X-Received: by 2002:a05:600c:1d29:b0:40c:1c33:5016 with SMTP id l41-20020a05600c1d2900b0040c1c335016mr76515wms.3.1701883730162;
        Wed, 06 Dec 2023 09:28:50 -0800 (PST)
Received: from localhost ([2a00:79e0:9d:4:d591:b37c:bf19:f4bd])
        by smtp.gmail.com with ESMTPSA id d12-20020a05600c3acc00b0040b5377cf03sm338586wms.1.2023.12.06.09.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 09:28:49 -0800 (PST)
From:   Jann Horn <jannh@google.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/microcode: Be more verbose, especially about loading errors
Date:   Wed,  6 Dec 2023 18:28:44 +0100
Message-ID: <20231206172844.1756871-1-jannh@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AMD ucode loader contains several checks for corrupted ucode blobs that
only log with pr_debug(); make them pr_err(), corrupted ucode blobs are
bad.

Also make both microcode loaders a bit more verbose about whether they
found ucode blobs at all and whether they found ucode for the specific CPU.

Signed-off-by: Jann Horn <jannh@google.com>
---
compile-tested only since I don't have an easy setup for booting test
kernels on bare metal

 arch/x86/kernel/cpu/microcode/amd.c   | 34 +++++++++++++++++----------
 arch/x86/kernel/cpu/microcode/intel.c | 24 ++++++++++++++++---
 2 files changed, 42 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 13b45b9c806d..2312ddb031b5 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -136,13 +136,13 @@ static bool verify_container(const u8 *buf, size_t buf_size)
 	u32 cont_magic;
 
 	if (buf_size <= CONTAINER_HDR_SZ) {
-		pr_debug("Truncated microcode container header.\n");
+		pr_err("Truncated microcode container header.\n");
 		return false;
 	}
 
 	cont_magic = *(const u32 *)buf;
 	if (cont_magic != UCODE_MAGIC) {
-		pr_debug("Invalid magic value (0x%08x).\n", cont_magic);
+		pr_err("Invalid magic value (0x%08x).\n", cont_magic);
 		return false;
 	}
 
@@ -163,7 +163,7 @@ static bool verify_equivalence_table(const u8 *buf, size_t buf_size)
 
 	cont_type = hdr[1];
 	if (cont_type != UCODE_EQUIV_CPU_TABLE_TYPE) {
-		pr_debug("Wrong microcode container equivalence table type: %u.\n",
+		pr_err("Wrong microcode container equivalence table type: %u.\n",
 			 cont_type);
 		return false;
 	}
@@ -173,7 +173,7 @@ static bool verify_equivalence_table(const u8 *buf, size_t buf_size)
 	equiv_tbl_len = hdr[2];
 	if (equiv_tbl_len < sizeof(struct equiv_cpu_entry) ||
 	    buf_size < equiv_tbl_len) {
-		pr_debug("Truncated equivalence table.\n");
+		pr_err("Truncated equivalence table.\n");
 		return false;
 	}
 
@@ -194,7 +194,7 @@ __verify_patch_section(const u8 *buf, size_t buf_size, u32 *sh_psize)
 	const u32 *hdr;
 
 	if (buf_size < SECTION_HDR_SIZE) {
-		pr_debug("Truncated patch section.\n");
+		pr_err("Truncated patch section.\n");
 		return false;
 	}
 
@@ -203,13 +203,13 @@ __verify_patch_section(const u8 *buf, size_t buf_size, u32 *sh_psize)
 	p_size = hdr[1];
 
 	if (p_type != UCODE_UCODE_TYPE) {
-		pr_debug("Invalid type field (0x%x) in container file section header.\n",
+		pr_err("Invalid type field (0x%x) in container file section header.\n",
 			 p_type);
 		return false;
 	}
 
 	if (p_size < sizeof(struct microcode_header_amd)) {
-		pr_debug("Patch of size %u too short.\n", p_size);
+		pr_err("Patch of size %u too short.\n", p_size);
 		return false;
 	}
 
@@ -284,13 +284,13 @@ verify_patch(u8 family, const u8 *buf, size_t buf_size, u32 *patch_size)
 	 * size sh_psize, as the section claims.
 	 */
 	if (buf_size < sh_psize) {
-		pr_debug("Patch of size %u truncated.\n", sh_psize);
+		pr_err("Patch of size %u truncated.\n", sh_psize);
 		return -1;
 	}
 
 	ret = __verify_patch_size(family, sh_psize, buf_size);
 	if (!ret) {
-		pr_debug("Per-family patch size mismatch.\n");
+		pr_err("Per-family patch size mismatch.\n");
 		return -1;
 	}
 
@@ -423,8 +423,10 @@ static int __apply_microcode_amd(struct microcode_amd *mc)
 
 	/* verify patch application was successful */
 	native_rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
-	if (rev != mc->hdr.patch_id)
+	if (rev != mc->hdr.patch_id) {
+		pr_err("CPU did not accept microcode update!\n");
 		return -1;
+	}
 
 	return 0;
 }
@@ -451,14 +453,18 @@ static bool early_apply_microcode(u32 cpuid_1_eax, u32 old_rev, void *ucode, siz
 	scan_containers(ucode, size, &desc);
 
 	mc = desc.mc;
-	if (!mc)
+	if (!mc) {
+		pr_info("Found no patches for this CPU model in the microcode file\n");
 		return ret;
+	}
 
 	/*
 	 * Allow application of the same revision to pick up SMT-specific
 	 * changes even if the revision of the other SMT thread is already
 	 * up-to-date.
 	 */
+	pr_info("CPU had microcode revision 0x%x, latest available patch is 0x%x\n",
+		old_rev, mc->hdr.patch_id);
 	if (old_rev > mc->hdr.patch_id)
 		return ret;
 
@@ -507,8 +513,10 @@ void __init load_ucode_amd_bsp(struct early_load_data *ed, unsigned int cpuid_1_
 	ucode_cpu_info[0].cpu_sig.sig = cpuid_1_eax;
 
 	find_blobs_in_containers(cpuid_1_eax, &cp);
-	if (!(cp.data && cp.size))
+	if (!(cp.data && cp.size)) {
+		pr_info("Unable to find any microcode blob for early loading\n");
 		return;
+	}
 
 	if (early_apply_microcode(cpuid_1_eax, ed->old_rev, cp.data, cp.size))
 		native_rdmsr(MSR_AMD64_PATCH_LEVEL, ed->new_rev, dummy);
@@ -883,7 +891,7 @@ static enum ucode_state request_microcode_amd(int cpu, struct device *device)
 		snprintf(fw_name, sizeof(fw_name), "amd-ucode/microcode_amd_fam%.2xh.bin", c->x86);
 
 	if (request_firmware_direct(&fw, (const char *)fw_name, device)) {
-		pr_debug("failed to load file %s\n", fw_name);
+		pr_err("failed to load file %s\n", fw_name);
 		goto out;
 	}
 
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 070426b9895f..c56819dc6730 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -266,6 +266,7 @@ static __init struct microcode_intel *scan_microcode(void *data, size_t size,
 	struct microcode_intel *patch = NULL;
 	u32 cur_rev = uci->cpu_sig.rev;
 	unsigned int mc_size;
+	bool any_matches = false;
 
 	for (; size >= sizeof(struct microcode_header_intel); size -= mc_size, data += mc_size) {
 		mc_header = (struct microcode_header_intel *)data;
@@ -277,6 +278,7 @@ static __init struct microcode_intel *scan_microcode(void *data, size_t size,
 
 		if (!intel_find_matching_signature(data, &uci->cpu_sig))
 			continue;
+		any_matches = true;
 
 		/*
 		 * For saving the early microcode, find the matching revision which
@@ -296,7 +298,21 @@ static __init struct microcode_intel *scan_microcode(void *data, size_t size,
 		cur_rev = mc_header->rev;
 	}
 
-	return size ? NULL : patch;
+	if (size) {
+		pr_err("Unable to parse microcode blob!\n");
+		return NULL;
+	}
+
+	if (!save) {
+		if (patch)
+			pr_info("Found microcode update\n");
+		else if (any_matches)
+			pr_info("Found microcode update but it's not newer\n");
+		else
+			pr_info("Found no microcode update for this CPU\n");
+	}
+
+	return patch;
 }
 
 static enum ucode_state __apply_microcode(struct ucode_cpu_info *uci,
@@ -373,8 +389,10 @@ static __init struct microcode_intel *get_microcode_blob(struct ucode_cpu_info *
 	if (!load_builtin_intel_microcode(&cp))
 		cp = find_microcode_in_initrd(ucode_path);
 
-	if (!(cp.data && cp.size))
+	if (!(cp.data && cp.size)) {
+		pr_info("Unable to find any microcode blob for early loading\n");
 		return NULL;
+	}
 
 	intel_collect_cpu_info(&uci->cpu_sig);
 
@@ -612,7 +630,7 @@ static enum ucode_state request_microcode_fw(int cpu, struct device *device)
 		c->x86, c->x86_model, c->x86_stepping);
 
 	if (request_firmware_direct(&firmware, name, device)) {
-		pr_debug("data file %s load failed\n", name);
+		pr_info("data file %s load failed\n", name);
 		return UCODE_NFOUND;
 	}
 

base-commit: bee0e7762ad2c6025b9f5245c040fcc36ef2bde8
-- 
2.43.0.472.g3155946c3a-goog

