Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E6B7BC362
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 02:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233979AbjJGAlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 20:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233972AbjJGAl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 20:41:27 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E02BF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 17:41:19 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-690bc3f82a7so2392687b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 17:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1696639279; x=1697244079; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y5ObyqDOjztoDhC5t8E2lz3oLVXfFznkcrpNtj4QO6o=;
        b=TRcFK3deXiDmpw8bhKTyyRPn6RMskkTfg9TQzbQI4yeB5lJ504+1dsKR/Yx1+lEzto
         oiUFuXf82NRasYyZ2PpkrMU4+GpxvCR40bJ1tLxxSRAfgVcxcFcQeUs6c7Tr3nRVNT80
         l+WpVwgZ8q10aEpFzK0+WZJiznzJcM5SyQF2Mr8ad/sj4DssP5+iqXxrTu0CaIj0Nkpc
         JYHfSyprTDKQWlBFVZhZqrdCmQ/xpLP28LpaSayiQCpFkTmuf7rAuyR1kwh7+TOyVQ3x
         uemiUmDlWAoOu1nYABE4xjAHZ+rC4OxppMcQZpcVG2eJh3uA4xDFUac6Oiw+1I9jIFOx
         ke7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696639279; x=1697244079;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y5ObyqDOjztoDhC5t8E2lz3oLVXfFznkcrpNtj4QO6o=;
        b=Tqq+Pc/RLy8JFCk7uRVGsTKtFLhpdMsrtGh0ui16glt7qP39RgBp/UOweAsLc6NhRe
         P4wtqYzlbfrzWf7H02pLkP1QIMzbFiBNuqGPCIxok0Gvt5HmAVCHxU5jkpHER1ByBJZx
         dW3ffqYxzRepU4E9CEOrtzM1b+/vM5eylqRe2sqzlqdiEQHcA0GRTQUAr+LSdxKijNqE
         +yBwGZiiNfzpkUb4qMHiFlvyeu6GQX3bPjjWz5zbyL/f0UW3HJlP8MwauKkgDeKLO7he
         gDwXoquNvSq/pus0fuWxryiylume+Fh1mjA9Upr+T13Sa2SxEi5NsqxuQUn/ENsxRgvo
         G3Xg==
X-Gm-Message-State: AOJu0YzJ4eAwx3sj9q/azfp9hcvqEwOoXUdk3nRX8Zd17iisBVC/hYqZ
        251NU/3ArgXcBrXhh/q57/iOEA==
X-Google-Smtp-Source: AGHT+IHky70QBVvPzgEDItk7mYVORVvgukP/9hhiMTEl2hvCRW/wMJj0Xsi46NbUX0pwqScluqGBnA==
X-Received: by 2002:a05:6a20:144c:b0:14e:a1f0:a8ea with SMTP id a12-20020a056a20144c00b0014ea1f0a8eamr9888603pzi.3.1696639279458;
        Fri, 06 Oct 2023 17:41:19 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id x16-20020a170902ec9000b001c582de968dsm4534540plg.72.2023.10.06.17.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 17:41:19 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
Date:   Fri, 06 Oct 2023 17:41:06 -0700
Subject: [PATCH v2 1/2] riscv: Add remaining module relocations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231006-module_relocations-v2-1-47566453fedc@rivosinc.com>
References: <20231006-module_relocations-v2-0-47566453fedc@rivosinc.com>
In-Reply-To: <20231006-module_relocations-v2-0-47566453fedc@rivosinc.com>
To:     linux-riscv@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add all final module relocations and add error logs explaining the ones
that are not supported.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/uapi/asm/elf.h |   6 +-
 arch/riscv/kernel/module.c        | 247 ++++++++++++++++++++++++++++++++++----
 2 files changed, 227 insertions(+), 26 deletions(-)

diff --git a/arch/riscv/include/uapi/asm/elf.h b/arch/riscv/include/uapi/asm/elf.h
index d696d6610231..a9307a1c9ceb 100644
--- a/arch/riscv/include/uapi/asm/elf.h
+++ b/arch/riscv/include/uapi/asm/elf.h
@@ -49,6 +49,7 @@ typedef union __riscv_fp_state elf_fpregset_t;
 #define R_RISCV_TLS_DTPREL64	9
 #define R_RISCV_TLS_TPREL32	10
 #define R_RISCV_TLS_TPREL64	11
+#define R_RISCV_IRELATIVE	58
 
 /* Relocation types not used by the dynamic linker */
 #define R_RISCV_BRANCH		16
@@ -81,7 +82,7 @@ typedef union __riscv_fp_state elf_fpregset_t;
 #define R_RISCV_ALIGN		43
 #define R_RISCV_RVC_BRANCH	44
 #define R_RISCV_RVC_JUMP	45
-#define R_RISCV_LUI		46
+#define R_RISCV_RVC_LUI		46
 #define R_RISCV_GPREL_I		47
 #define R_RISCV_GPREL_S		48
 #define R_RISCV_TPREL_I		49
@@ -93,6 +94,9 @@ typedef union __riscv_fp_state elf_fpregset_t;
 #define R_RISCV_SET16		55
 #define R_RISCV_SET32		56
 #define R_RISCV_32_PCREL	57
+#define R_RISCV_PLT32		59
+#define R_RISCV_SET_ULEB128	60
+#define R_RISCV_SUB_ULEB128	61
 
 
 #endif /* _UAPI_ASM_RISCV_ELF_H */
diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
index 7c651d55fcbd..61d5cdbe609d 100644
--- a/arch/riscv/kernel/module.c
+++ b/arch/riscv/kernel/module.c
@@ -7,6 +7,7 @@
 #include <linux/elf.h>
 #include <linux/err.h>
 #include <linux/errno.h>
+#include <linux/kernel.h>
 #include <linux/moduleloader.h>
 #include <linux/vmalloc.h>
 #include <linux/sizes.h>
@@ -253,6 +254,30 @@ static int apply_r_riscv_call_rela(struct module *me, u32 *location,
 	return 0;
 }
 
+static int apply_r_riscv_rvc_lui_rela(struct module *me, u32 *location,
+				      Elf_Addr v)
+{
+	// Get high 6 bits of 18 bit absolute address
+	s32 imm = ((s32)v + 0x800) >> 12;
+
+	if (v != sign_extend32(v, 6)) {
+		pr_err("%s: target %016llx can not be addressed by the 6-bit offset from PC = %p\n",
+		       me->name, (long long)v, location);
+		return -EINVAL;
+	}
+
+	if (imm == 0) {
+		// imm = 0 is invalid for c.lui, convert to c.li
+		*location = (*location & 0x0F83) | 0x4000;
+	} else {
+		u16 imm17 = ((((s32)v + 0x800) & 0x20000) >> (17 - 12));
+		u16 imm16_12 = ((((s32)v + 0x800) & 0x1f000) >> (12 - 2));
+		*location = (*location & 0xef83) | imm17 | imm16_12;
+	}
+
+	return 0;
+}
+
 static int apply_r_riscv_relax_rela(struct module *me, u32 *location,
 				    Elf_Addr v)
 {
@@ -268,6 +293,12 @@ static int apply_r_riscv_align_rela(struct module *me, u32 *location,
 	return -EINVAL;
 }
 
+static int apply_r_riscv_add8_rela(struct module *me, u32 *location, Elf_Addr v)
+{
+	*(u8 *)location += (u8)v;
+	return 0;
+}
+
 static int apply_r_riscv_add16_rela(struct module *me, u32 *location,
 				    Elf_Addr v)
 {
@@ -289,6 +320,12 @@ static int apply_r_riscv_add64_rela(struct module *me, u32 *location,
 	return 0;
 }
 
+static int apply_r_riscv_sub8_rela(struct module *me, u32 *location, Elf_Addr v)
+{
+	*(u8 *)location -= (u8)v;
+	return 0;
+}
+
 static int apply_r_riscv_sub16_rela(struct module *me, u32 *location,
 				    Elf_Addr v)
 {
@@ -310,31 +347,150 @@ static int apply_r_riscv_sub64_rela(struct module *me, u32 *location,
 	return 0;
 }
 
-static int (*reloc_handlers_rela[]) (struct module *me, u32 *location,
-				Elf_Addr v) = {
-	[R_RISCV_32]			= apply_r_riscv_32_rela,
-	[R_RISCV_64]			= apply_r_riscv_64_rela,
-	[R_RISCV_BRANCH]		= apply_r_riscv_branch_rela,
-	[R_RISCV_JAL]			= apply_r_riscv_jal_rela,
-	[R_RISCV_RVC_BRANCH]		= apply_r_riscv_rvc_branch_rela,
-	[R_RISCV_RVC_JUMP]		= apply_r_riscv_rvc_jump_rela,
-	[R_RISCV_PCREL_HI20]		= apply_r_riscv_pcrel_hi20_rela,
-	[R_RISCV_PCREL_LO12_I]		= apply_r_riscv_pcrel_lo12_i_rela,
-	[R_RISCV_PCREL_LO12_S]		= apply_r_riscv_pcrel_lo12_s_rela,
-	[R_RISCV_HI20]			= apply_r_riscv_hi20_rela,
-	[R_RISCV_LO12_I]		= apply_r_riscv_lo12_i_rela,
-	[R_RISCV_LO12_S]		= apply_r_riscv_lo12_s_rela,
-	[R_RISCV_GOT_HI20]		= apply_r_riscv_got_hi20_rela,
-	[R_RISCV_CALL_PLT]		= apply_r_riscv_call_plt_rela,
-	[R_RISCV_CALL]			= apply_r_riscv_call_rela,
-	[R_RISCV_RELAX]			= apply_r_riscv_relax_rela,
-	[R_RISCV_ALIGN]			= apply_r_riscv_align_rela,
-	[R_RISCV_ADD16]			= apply_r_riscv_add16_rela,
-	[R_RISCV_ADD32]			= apply_r_riscv_add32_rela,
-	[R_RISCV_ADD64]			= apply_r_riscv_add64_rela,
-	[R_RISCV_SUB16]			= apply_r_riscv_sub16_rela,
-	[R_RISCV_SUB32]			= apply_r_riscv_sub32_rela,
-	[R_RISCV_SUB64]			= apply_r_riscv_sub64_rela,
+static int dynamic_linking_not_supported(struct module *me, u32 *location,
+					 Elf_Addr v)
+{
+	pr_err("%s: Dynamic linking not supported in kernel modules PC = %p\n",
+	       me->name, location);
+	return -EINVAL;
+}
+
+static int tls_not_supported(struct module *me, u32 *location, Elf_Addr v)
+{
+	pr_err("%s: Thread local storage not supported in kernel modules PC = %p\n",
+	       me->name, location);
+	return -EINVAL;
+}
+
+static int apply_r_riscv_sub6_rela(struct module *me, u32 *location, Elf_Addr v)
+{
+	*(u8 *)location -= (u8)v & 0x3F;
+	return 0;
+}
+
+static int apply_r_riscv_set6_rela(struct module *me, u32 *location, Elf_Addr v)
+{
+	*(u8 *)location = (*(u8 *)location & 0xc0) | ((u8)v & 0x3F);
+	return 0;
+}
+
+static int apply_r_riscv_set8_rela(struct module *me, u32 *location, Elf_Addr v)
+{
+	*(u8 *)location = (u8)v;
+	return 0;
+}
+
+static int apply_r_riscv_set16_rela(struct module *me, u32 *location,
+				    Elf_Addr v)
+{
+	*(u16 *)location = (u16)v;
+	return 0;
+}
+
+static int apply_r_riscv_set32_rela(struct module *me, u32 *location,
+				    Elf_Addr v)
+{
+	*(u32 *)location = (u32)v;
+	return 0;
+}
+
+static int apply_r_riscv_32_pcrel_rela(struct module *me, u32 *location,
+				       Elf_Addr v)
+{
+	*(u32 *)location = (u32)v;
+	return 0;
+}
+
+static int apply_r_riscv_plt32_rela(struct module *me, u32 *location,
+				    Elf_Addr v)
+{
+	*(u32 *)location = (u32)v;
+	return 0;
+}
+
+static int apply_r_riscv_set_uleb128(struct module *me, u32 *location, Elf_Addr v)
+{
+	/*
+	 * Relocation is only performed if R_RISCV_SET_ULEB128 is followed by
+	 * R_RISCV_SUB_ULEB128 so do computation there
+	 */
+	return 0;
+}
+
+static int apply_r_riscv_sub_uleb128(struct module *me, u32 *location, Elf_Addr v)
+{
+	if (v >= 128) {
+		pr_err("%s: uleb128 must be in [0, 127] (not %ld) at PC = %p\n",
+		       me->name, (unsigned long)v, location);
+		return -EINVAL;
+	}
+
+	*location = v;
+	return 0;
+}
+
+/*
+ * Relocations defined in the riscv-elf-psabi-doc.
+ * This handles static linking only.
+ */
+static int (*reloc_handlers_rela[])(struct module *me, u32 *location,
+				    Elf_Addr v) = {
+	[R_RISCV_32] =			apply_r_riscv_32_rela,
+	[R_RISCV_64] =			apply_r_riscv_64_rela,
+	[R_RISCV_RELATIVE] =		dynamic_linking_not_supported,
+	[R_RISCV_COPY] =		dynamic_linking_not_supported,
+	[R_RISCV_JUMP_SLOT] =		dynamic_linking_not_supported,
+	[R_RISCV_TLS_DTPMOD32] =	dynamic_linking_not_supported,
+	[R_RISCV_TLS_DTPMOD64] =	dynamic_linking_not_supported,
+	[R_RISCV_TLS_DTPREL32] =	dynamic_linking_not_supported,
+	[R_RISCV_TLS_DTPREL64] =	dynamic_linking_not_supported,
+	[R_RISCV_TLS_TPREL32] =		dynamic_linking_not_supported,
+	[R_RISCV_TLS_TPREL64] =		dynamic_linking_not_supported,
+	/* 12-15 undefined */
+	[R_RISCV_BRANCH] =		apply_r_riscv_branch_rela,
+	[R_RISCV_JAL] =			apply_r_riscv_jal_rela,
+	[R_RISCV_CALL] =		apply_r_riscv_call_rela,
+	[R_RISCV_CALL_PLT] =		apply_r_riscv_call_plt_rela,
+	[R_RISCV_GOT_HI20] =		apply_r_riscv_got_hi20_rela,
+	[R_RISCV_TLS_GOT_HI20] =	tls_not_supported,
+	[R_RISCV_TLS_GD_HI20] =		tls_not_supported,
+	[R_RISCV_PCREL_HI20] =		apply_r_riscv_pcrel_hi20_rela,
+	[R_RISCV_PCREL_LO12_I] =	apply_r_riscv_pcrel_lo12_i_rela,
+	[R_RISCV_PCREL_LO12_S] =	apply_r_riscv_pcrel_lo12_s_rela,
+	[R_RISCV_HI20] =		apply_r_riscv_hi20_rela,
+	[R_RISCV_LO12_I] =		apply_r_riscv_lo12_i_rela,
+	[R_RISCV_LO12_S] =		apply_r_riscv_lo12_s_rela,
+	[R_RISCV_TPREL_HI20] =		tls_not_supported,
+	[R_RISCV_TPREL_LO12_I] =	tls_not_supported,
+	[R_RISCV_TPREL_LO12_S] =	tls_not_supported,
+	[R_RISCV_TPREL_ADD] =		tls_not_supported,
+	[R_RISCV_ADD8] =		apply_r_riscv_add8_rela,
+	[R_RISCV_ADD16] =		apply_r_riscv_add16_rela,
+	[R_RISCV_ADD32] =		apply_r_riscv_add32_rela,
+	[R_RISCV_ADD64] =		apply_r_riscv_add64_rela,
+	[R_RISCV_SUB8] =		apply_r_riscv_sub8_rela,
+	[R_RISCV_SUB16] =		apply_r_riscv_sub16_rela,
+	[R_RISCV_SUB32] =		apply_r_riscv_sub32_rela,
+	[R_RISCV_SUB64] =		apply_r_riscv_sub64_rela,
+	/* 41-42 reserved for future standard use */
+	[R_RISCV_ALIGN] =		apply_r_riscv_align_rela,
+	[R_RISCV_RVC_BRANCH] =		apply_r_riscv_rvc_branch_rela,
+	[R_RISCV_RVC_JUMP] =		apply_r_riscv_rvc_jump_rela,
+	[R_RISCV_RVC_LUI] =		apply_r_riscv_rvc_lui_rela,
+	/* 47-50 reserved for future standard use */
+	[R_RISCV_RELAX] =		apply_r_riscv_relax_rela,
+	[R_RISCV_SUB6] =		apply_r_riscv_sub6_rela,
+	[R_RISCV_SET6] =		apply_r_riscv_set6_rela,
+	[R_RISCV_SET8] =		apply_r_riscv_set8_rela,
+	[R_RISCV_SET16] =		apply_r_riscv_set16_rela,
+	[R_RISCV_SET32] =		apply_r_riscv_set32_rela,
+	[R_RISCV_32_PCREL] =		apply_r_riscv_32_pcrel_rela,
+	[R_RISCV_IRELATIVE] =		dynamic_linking_not_supported,
+	[R_RISCV_PLT32] =		apply_r_riscv_plt32_rela,
+	[R_RISCV_SET_ULEB128] =		apply_r_riscv_set_uleb128,
+	[R_RISCV_SUB_ULEB128] =		apply_r_riscv_sub_uleb128,
+	/* 62-191 reserved for future standard use */
+	/* 192-255 nonstandard ABI extensions  */
 };
 
 int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
@@ -425,6 +581,47 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
 				  me->name);
 				return -EINVAL;
 			}
+		} else if (type == R_RISCV_SUB_ULEB128) {
+			unsigned long set_loc;
+			u32 set_type;
+			unsigned long set_sym_val;
+
+			bool has_corresponding_relocation = false;
+
+			/* R_RISCV_SET_ULEB128 must appear before the SUB  */
+			for (unsigned int j = i; j >= 0; j--) {
+				set_loc = sechdrs[sechdrs[relsec].sh_info]
+						  .sh_addr +
+					  rel[j].r_offset;
+				set_type = ELF_RISCV_R_TYPE(rel[j].r_info);
+
+				/*
+				 * Find the SET relocation that is targeting the
+				 * same position as the SUB
+				 */
+				if (set_type == R_RISCV_SET_ULEB128 &&
+				    set_loc == (unsigned long)location) {
+					Elf_Sym *corresponding_sym =
+						(Elf_Sym *)sechdrs[symindex]
+							.sh_addr +
+						ELF_RISCV_R_SYM(rel[j].r_info);
+
+					set_sym_val =
+						corresponding_sym->st_value +
+						rel[j].r_addend;
+					has_corresponding_relocation = true;
+					break;
+				}
+			}
+
+			if (has_corresponding_relocation) {
+				/* Calculate set and subtraction */
+				v = set_sym_val - v;
+			} else {
+				pr_err("%s: R_RISCV_SUB_ULEB128 must always be paired with a R_RISCV_SET_ULEB128 that comes before it. PC = %p\n",
+				       me->name, location);
+				return -EINVAL;
+			}
 		}
 
 		res = handler(me, location, v);

-- 
2.34.1

