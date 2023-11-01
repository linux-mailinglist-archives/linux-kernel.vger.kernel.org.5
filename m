Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0224A7DE619
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 19:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344599AbjKASdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 14:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbjKASdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 14:33:10 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC08DB
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 11:33:07 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-586ad15f9aaso38846eaf.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 11:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1698863587; x=1699468387; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bmX47uOjeBLgcqnLG2LWRRnp8TOL9YLBnfsBk3939lI=;
        b=PPX3rKULX/mhbH3lKt4GuPrb5BHtbcwacv/3Wu1uT3rT2YErLaem8LbA9oQdEUNbx9
         ihNsuZERY4i2AIS+QaGmLjceo/qBNUabQRwMGGPNbs89PYCyZbVTPK6l5KjdGcImWH0F
         +j5MFy4gc61Bmf246rRms1J2XxBekHJKvSqJzPnzbqzk197uKRfBWZziclSyUudU9x41
         QnBGz2Y2uQCoisMPMMPUBzQ/Xgzzogsx17KsC+XrVeS+kQ3stifZ0iSTyFBPXOk/lIHY
         NO6lkrRX9WM14VZwRKzlQr3YTBMNpAhC0dm7CvfScrnDXw7UECSJ/MtkxRVaZwvx5ASh
         XHuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698863587; x=1699468387;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bmX47uOjeBLgcqnLG2LWRRnp8TOL9YLBnfsBk3939lI=;
        b=Xy29Yc9QC9Sbb9MCGoIeW6e/sRbSy+BzmG3eYJwtWcoJrNb3pMRH64hdRcRVcYB92T
         YImpGsNK37YKSTv8G3tQ/J/LwxWuVVVtSHp5jhsdpRSHk+Hj4hmR7hVA7O5RhdfkLM0P
         ml4h40HmfOeEWYGxyJIuhevI+H7h3SYANyusrm0gQ9j8y4uzvzK2jlU9i7lCIUQa2gl2
         VdE2L8fMxYE+hHofZ5NfqR7+tOtuycTxm9MJ33JEoeqBhG6fXHyfybvVYix2B798LiCs
         DLFd0JJiSelhoc4cI+RV8d8N0JdQHlKHTd4WbLQqlBH5x3N4+M2NBt+pLKeRRHtWXZND
         HuKw==
X-Gm-Message-State: AOJu0Yxn4jNy/din/fuJwhRaXSO9ywiFj8NU7L8HLnwK+Z724w3S9WEo
        lxLgmg2BxmOQZJrpri/49zgEmw==
X-Google-Smtp-Source: AGHT+IEy6ddaceBESFTSWHP+MOBVo7SllhOU1bINZBrAu1EBzKWDnREAu5ah35KCCWiY3grX8PD/MA==
X-Received: by 2002:a4a:a649:0:b0:582:c8b4:d9df with SMTP id j9-20020a4aa649000000b00582c8b4d9dfmr16068466oom.1.1698863586805;
        Wed, 01 Nov 2023 11:33:06 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id m14-20020a4aab8e000000b00581e090fd1fsm686331oon.8.2023.11.01.11.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 11:33:06 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
Date:   Wed, 01 Nov 2023 11:32:59 -0700
Subject: [PATCH v9 1/3] riscv: Avoid unaligned access when relocating
 modules
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231101-module_relocations-v9-1-8dfa3483c400@rivosinc.com>
References: <20231101-module_relocations-v9-0-8dfa3483c400@rivosinc.com>
In-Reply-To: <20231101-module_relocations-v9-0-8dfa3483c400@rivosinc.com>
To:     linux-riscv@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Samuel Holland <samuel.holland@sifive.com>,
        Nelson Chu <nelson@rivosinc.com>,
        Charlie Jenkins <charlie@rivosinc.com>,
        Emil Renner Berthing <kernel@esmil.dk>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emil Renner Berthing <kernel@esmil.dk>

With the C-extension regular 32bit instructions are not
necessarily aligned on 4-byte boundaries. RISC-V instructions
are in fact an ordered list of 16bit little-endian
"parcels", so access the instruction as such.

This should also make the code work in case someone builds
a big-endian RISC-V machine.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/kernel/module.c | 157 +++++++++++++++++++++++----------------------
 1 file changed, 81 insertions(+), 76 deletions(-)

diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
index 7c651d55fcbd..8286d3bb04f4 100644
--- a/arch/riscv/kernel/module.c
+++ b/arch/riscv/kernel/module.c
@@ -27,68 +27,90 @@ static bool riscv_insn_valid_32bit_offset(ptrdiff_t val)
 #endif
 }
 
-static int apply_r_riscv_32_rela(struct module *me, u32 *location, Elf_Addr v)
+static int riscv_insn_rmw(void *location, u32 keep, u32 set)
+{
+	u16 *parcel = location;
+	u32 insn = (u32)le16_to_cpu(parcel[0]) | (u32)le16_to_cpu(parcel[1]) << 16;
+
+	insn &= keep;
+	insn |= set;
+
+	parcel[0] = cpu_to_le16(insn);
+	parcel[1] = cpu_to_le16(insn >> 16);
+	return 0;
+}
+
+static int riscv_insn_rvc_rmw(void *location, u16 keep, u16 set)
+{
+	u16 *parcel = location;
+	u16 insn = le16_to_cpu(*parcel);
+
+	insn &= keep;
+	insn |= set;
+
+	*parcel = cpu_to_le16(insn);
+	return 0;
+}
+
+static int apply_r_riscv_32_rela(struct module *me, void *location, Elf_Addr v)
 {
 	if (v != (u32)v) {
 		pr_err("%s: value %016llx out of range for 32-bit field\n",
 		       me->name, (long long)v);
 		return -EINVAL;
 	}
-	*location = v;
+	*(u32 *)location = v;
 	return 0;
 }
 
-static int apply_r_riscv_64_rela(struct module *me, u32 *location, Elf_Addr v)
+static int apply_r_riscv_64_rela(struct module *me, void *location, Elf_Addr v)
 {
 	*(u64 *)location = v;
 	return 0;
 }
 
-static int apply_r_riscv_branch_rela(struct module *me, u32 *location,
+static int apply_r_riscv_branch_rela(struct module *me, void *location,
 				     Elf_Addr v)
 {
-	ptrdiff_t offset = (void *)v - (void *)location;
+	ptrdiff_t offset = (void *)v - location;
 	u32 imm12 = (offset & 0x1000) << (31 - 12);
 	u32 imm11 = (offset & 0x800) >> (11 - 7);
 	u32 imm10_5 = (offset & 0x7e0) << (30 - 10);
 	u32 imm4_1 = (offset & 0x1e) << (11 - 4);
 
-	*location = (*location & 0x1fff07f) | imm12 | imm11 | imm10_5 | imm4_1;
-	return 0;
+	return riscv_insn_rmw(location, 0x1fff07f, imm12 | imm11 | imm10_5 | imm4_1);
 }
 
-static int apply_r_riscv_jal_rela(struct module *me, u32 *location,
+static int apply_r_riscv_jal_rela(struct module *me, void *location,
 				  Elf_Addr v)
 {
-	ptrdiff_t offset = (void *)v - (void *)location;
+	ptrdiff_t offset = (void *)v - location;
 	u32 imm20 = (offset & 0x100000) << (31 - 20);
 	u32 imm19_12 = (offset & 0xff000);
 	u32 imm11 = (offset & 0x800) << (20 - 11);
 	u32 imm10_1 = (offset & 0x7fe) << (30 - 10);
 
-	*location = (*location & 0xfff) | imm20 | imm19_12 | imm11 | imm10_1;
-	return 0;
+	return riscv_insn_rmw(location, 0xfff, imm20 | imm19_12 | imm11 | imm10_1);
 }
 
-static int apply_r_riscv_rvc_branch_rela(struct module *me, u32 *location,
+static int apply_r_riscv_rvc_branch_rela(struct module *me, void *location,
 					 Elf_Addr v)
 {
-	ptrdiff_t offset = (void *)v - (void *)location;
+	ptrdiff_t offset = (void *)v - location;
 	u16 imm8 = (offset & 0x100) << (12 - 8);
 	u16 imm7_6 = (offset & 0xc0) >> (6 - 5);
 	u16 imm5 = (offset & 0x20) >> (5 - 2);
 	u16 imm4_3 = (offset & 0x18) << (12 - 5);
 	u16 imm2_1 = (offset & 0x6) << (12 - 10);
 
-	*(u16 *)location = (*(u16 *)location & 0xe383) |
-		    imm8 | imm7_6 | imm5 | imm4_3 | imm2_1;
-	return 0;
+	return riscv_insn_rvc_rmw(location, 0xe383,
+			imm8 | imm7_6 | imm5 | imm4_3 | imm2_1);
 }
 
-static int apply_r_riscv_rvc_jump_rela(struct module *me, u32 *location,
+static int apply_r_riscv_rvc_jump_rela(struct module *me, void *location,
 				       Elf_Addr v)
 {
-	ptrdiff_t offset = (void *)v - (void *)location;
+	ptrdiff_t offset = (void *)v - location;
 	u16 imm11 = (offset & 0x800) << (12 - 11);
 	u16 imm10 = (offset & 0x400) >> (10 - 8);
 	u16 imm9_8 = (offset & 0x300) << (12 - 11);
@@ -98,16 +120,14 @@ static int apply_r_riscv_rvc_jump_rela(struct module *me, u32 *location,
 	u16 imm4 = (offset & 0x10) << (12 - 5);
 	u16 imm3_1 = (offset & 0xe) << (12 - 10);
 
-	*(u16 *)location = (*(u16 *)location & 0xe003) |
-		    imm11 | imm10 | imm9_8 | imm7 | imm6 | imm5 | imm4 | imm3_1;
-	return 0;
+	return riscv_insn_rvc_rmw(location, 0xe003,
+			imm11 | imm10 | imm9_8 | imm7 | imm6 | imm5 | imm4 | imm3_1);
 }
 
-static int apply_r_riscv_pcrel_hi20_rela(struct module *me, u32 *location,
+static int apply_r_riscv_pcrel_hi20_rela(struct module *me, void *location,
 					 Elf_Addr v)
 {
-	ptrdiff_t offset = (void *)v - (void *)location;
-	s32 hi20;
+	ptrdiff_t offset = (void *)v - location;
 
 	if (!riscv_insn_valid_32bit_offset(offset)) {
 		pr_err(
@@ -116,23 +136,20 @@ static int apply_r_riscv_pcrel_hi20_rela(struct module *me, u32 *location,
 		return -EINVAL;
 	}
 
-	hi20 = (offset + 0x800) & 0xfffff000;
-	*location = (*location & 0xfff) | hi20;
-	return 0;
+	return riscv_insn_rmw(location, 0xfff, (offset + 0x800) & 0xfffff000);
 }
 
-static int apply_r_riscv_pcrel_lo12_i_rela(struct module *me, u32 *location,
+static int apply_r_riscv_pcrel_lo12_i_rela(struct module *me, void *location,
 					   Elf_Addr v)
 {
 	/*
 	 * v is the lo12 value to fill. It is calculated before calling this
 	 * handler.
 	 */
-	*location = (*location & 0xfffff) | ((v & 0xfff) << 20);
-	return 0;
+	return riscv_insn_rmw(location, 0xfffff, (v & 0xfff) << 20);
 }
 
-static int apply_r_riscv_pcrel_lo12_s_rela(struct module *me, u32 *location,
+static int apply_r_riscv_pcrel_lo12_s_rela(struct module *me, void *location,
 					   Elf_Addr v)
 {
 	/*
@@ -142,15 +159,12 @@ static int apply_r_riscv_pcrel_lo12_s_rela(struct module *me, u32 *location,
 	u32 imm11_5 = (v & 0xfe0) << (31 - 11);
 	u32 imm4_0 = (v & 0x1f) << (11 - 4);
 
-	*location = (*location & 0x1fff07f) | imm11_5 | imm4_0;
-	return 0;
+	return riscv_insn_rmw(location, 0x1fff07f, imm11_5 | imm4_0);
 }
 
-static int apply_r_riscv_hi20_rela(struct module *me, u32 *location,
+static int apply_r_riscv_hi20_rela(struct module *me, void *location,
 				   Elf_Addr v)
 {
-	s32 hi20;
-
 	if (IS_ENABLED(CONFIG_CMODEL_MEDLOW)) {
 		pr_err(
 		  "%s: target %016llx can not be addressed by the 32-bit offset from PC = %p\n",
@@ -158,22 +172,20 @@ static int apply_r_riscv_hi20_rela(struct module *me, u32 *location,
 		return -EINVAL;
 	}
 
-	hi20 = ((s32)v + 0x800) & 0xfffff000;
-	*location = (*location & 0xfff) | hi20;
-	return 0;
+	return riscv_insn_rmw(location, 0xfff, ((s32)v + 0x800) & 0xfffff000);
 }
 
-static int apply_r_riscv_lo12_i_rela(struct module *me, u32 *location,
+static int apply_r_riscv_lo12_i_rela(struct module *me, void *location,
 				     Elf_Addr v)
 {
 	/* Skip medlow checking because of filtering by HI20 already */
 	s32 hi20 = ((s32)v + 0x800) & 0xfffff000;
 	s32 lo12 = ((s32)v - hi20);
-	*location = (*location & 0xfffff) | ((lo12 & 0xfff) << 20);
-	return 0;
+
+	return riscv_insn_rmw(location, 0xfffff, (lo12 & 0xfff) << 20);
 }
 
-static int apply_r_riscv_lo12_s_rela(struct module *me, u32 *location,
+static int apply_r_riscv_lo12_s_rela(struct module *me, void *location,
 				     Elf_Addr v)
 {
 	/* Skip medlow checking because of filtering by HI20 already */
@@ -181,20 +193,18 @@ static int apply_r_riscv_lo12_s_rela(struct module *me, u32 *location,
 	s32 lo12 = ((s32)v - hi20);
 	u32 imm11_5 = (lo12 & 0xfe0) << (31 - 11);
 	u32 imm4_0 = (lo12 & 0x1f) << (11 - 4);
-	*location = (*location & 0x1fff07f) | imm11_5 | imm4_0;
-	return 0;
+
+	return riscv_insn_rmw(location, 0x1fff07f, imm11_5 | imm4_0);
 }
 
-static int apply_r_riscv_got_hi20_rela(struct module *me, u32 *location,
+static int apply_r_riscv_got_hi20_rela(struct module *me, void *location,
 				       Elf_Addr v)
 {
-	ptrdiff_t offset = (void *)v - (void *)location;
-	s32 hi20;
+	ptrdiff_t offset = (void *)v - location;
 
 	/* Always emit the got entry */
 	if (IS_ENABLED(CONFIG_MODULE_SECTIONS)) {
-		offset = module_emit_got_entry(me, v);
-		offset = (void *)offset - (void *)location;
+		offset = (void *)module_emit_got_entry(me, v) - location;
 	} else {
 		pr_err(
 		  "%s: can not generate the GOT entry for symbol = %016llx from PC = %p\n",
@@ -202,22 +212,19 @@ static int apply_r_riscv_got_hi20_rela(struct module *me, u32 *location,
 		return -EINVAL;
 	}
 
-	hi20 = (offset + 0x800) & 0xfffff000;
-	*location = (*location & 0xfff) | hi20;
-	return 0;
+	return riscv_insn_rmw(location, 0xfff, (offset + 0x800) & 0xfffff000);
 }
 
-static int apply_r_riscv_call_plt_rela(struct module *me, u32 *location,
+static int apply_r_riscv_call_plt_rela(struct module *me, void *location,
 				       Elf_Addr v)
 {
-	ptrdiff_t offset = (void *)v - (void *)location;
+	ptrdiff_t offset = (void *)v - location;
 	u32 hi20, lo12;
 
 	if (!riscv_insn_valid_32bit_offset(offset)) {
 		/* Only emit the plt entry if offset over 32-bit range */
 		if (IS_ENABLED(CONFIG_MODULE_SECTIONS)) {
-			offset = module_emit_plt_entry(me, v);
-			offset = (void *)offset - (void *)location;
+			offset = (void *)module_emit_plt_entry(me, v) - location;
 		} else {
 			pr_err(
 			  "%s: target %016llx can not be addressed by the 32-bit offset from PC = %p\n",
@@ -228,15 +235,14 @@ static int apply_r_riscv_call_plt_rela(struct module *me, u32 *location,
 
 	hi20 = (offset + 0x800) & 0xfffff000;
 	lo12 = (offset - hi20) & 0xfff;
-	*location = (*location & 0xfff) | hi20;
-	*(location + 1) = (*(location + 1) & 0xfffff) | (lo12 << 20);
-	return 0;
+	riscv_insn_rmw(location, 0xfff, hi20);
+	return riscv_insn_rmw(location + 4, 0xfffff, lo12 << 20);
 }
 
-static int apply_r_riscv_call_rela(struct module *me, u32 *location,
+static int apply_r_riscv_call_rela(struct module *me, void *location,
 				   Elf_Addr v)
 {
-	ptrdiff_t offset = (void *)v - (void *)location;
+	ptrdiff_t offset = (void *)v - location;
 	u32 hi20, lo12;
 
 	if (!riscv_insn_valid_32bit_offset(offset)) {
@@ -248,18 +254,17 @@ static int apply_r_riscv_call_rela(struct module *me, u32 *location,
 
 	hi20 = (offset + 0x800) & 0xfffff000;
 	lo12 = (offset - hi20) & 0xfff;
-	*location = (*location & 0xfff) | hi20;
-	*(location + 1) = (*(location + 1) & 0xfffff) | (lo12 << 20);
-	return 0;
+	riscv_insn_rmw(location, 0xfff, hi20);
+	return riscv_insn_rmw(location + 4, 0xfffff, lo12 << 20);
 }
 
-static int apply_r_riscv_relax_rela(struct module *me, u32 *location,
+static int apply_r_riscv_relax_rela(struct module *me, void *location,
 				    Elf_Addr v)
 {
 	return 0;
 }
 
-static int apply_r_riscv_align_rela(struct module *me, u32 *location,
+static int apply_r_riscv_align_rela(struct module *me, void *location,
 				    Elf_Addr v)
 {
 	pr_err(
@@ -268,49 +273,49 @@ static int apply_r_riscv_align_rela(struct module *me, u32 *location,
 	return -EINVAL;
 }
 
-static int apply_r_riscv_add16_rela(struct module *me, u32 *location,
+static int apply_r_riscv_add16_rela(struct module *me, void *location,
 				    Elf_Addr v)
 {
 	*(u16 *)location += (u16)v;
 	return 0;
 }
 
-static int apply_r_riscv_add32_rela(struct module *me, u32 *location,
+static int apply_r_riscv_add32_rela(struct module *me, void *location,
 				    Elf_Addr v)
 {
 	*(u32 *)location += (u32)v;
 	return 0;
 }
 
-static int apply_r_riscv_add64_rela(struct module *me, u32 *location,
+static int apply_r_riscv_add64_rela(struct module *me, void *location,
 				    Elf_Addr v)
 {
 	*(u64 *)location += (u64)v;
 	return 0;
 }
 
-static int apply_r_riscv_sub16_rela(struct module *me, u32 *location,
+static int apply_r_riscv_sub16_rela(struct module *me, void *location,
 				    Elf_Addr v)
 {
 	*(u16 *)location -= (u16)v;
 	return 0;
 }
 
-static int apply_r_riscv_sub32_rela(struct module *me, u32 *location,
+static int apply_r_riscv_sub32_rela(struct module *me, void *location,
 				    Elf_Addr v)
 {
 	*(u32 *)location -= (u32)v;
 	return 0;
 }
 
-static int apply_r_riscv_sub64_rela(struct module *me, u32 *location,
+static int apply_r_riscv_sub64_rela(struct module *me, void *location,
 				    Elf_Addr v)
 {
 	*(u64 *)location -= (u64)v;
 	return 0;
 }
 
-static int (*reloc_handlers_rela[]) (struct module *me, u32 *location,
+static int (*reloc_handlers_rela[]) (struct module *me, void *location,
 				Elf_Addr v) = {
 	[R_RISCV_32]			= apply_r_riscv_32_rela,
 	[R_RISCV_64]			= apply_r_riscv_64_rela,
@@ -342,9 +347,9 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
 		       struct module *me)
 {
 	Elf_Rela *rel = (void *) sechdrs[relsec].sh_addr;
-	int (*handler)(struct module *me, u32 *location, Elf_Addr v);
+	int (*handler)(struct module *me, void *location, Elf_Addr v);
 	Elf_Sym *sym;
-	u32 *location;
+	void *location;
 	unsigned int i, type;
 	Elf_Addr v;
 	int res;

-- 
2.34.1

