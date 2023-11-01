Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D597DE61A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 19:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344783AbjKASdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 14:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344421AbjKASdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 14:33:14 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F09710F
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 11:33:10 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-58441865ffaso45058eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 11:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1698863589; x=1699468389; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FtzZIf8mBJ7+Ey08l6PkxF7Ft7nE+u+N8GihK+Ta5xM=;
        b=qxfwxcI2yFSy5pKn5H4tJKjOdUNu1++kuISXcwsLtmRNx4JQx0vsK9izer3rUdfpi5
         7NUvm4omYzpZiKOCsmEyToHQGLsFT6rhKq0dUkA5QtrTv/TODwiojxDGNEfnKPQF7D6O
         avpGJLRow4mhEcZyM8pcC0wS4C/a0TqwpCMsd5nS451I71BaXT4JfhKQ9V/NMfUBXIxM
         T207bQzMt1G5I/e9VnxQASz1U8YhG4ho3AOAaZprqX+ZyPQ7OtHou5gFlWPkDHsR84QI
         E+jdmwiK7F5bhnyp5/oBSPi3maYufSfSEVgLyzye86FYhpE4I8SiPm1Ie0XHKJiJgBcu
         B3MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698863589; x=1699468389;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FtzZIf8mBJ7+Ey08l6PkxF7Ft7nE+u+N8GihK+Ta5xM=;
        b=vuwcB/P7dSbY2SnB040HpjMjjT0bAYZ7CRnmkzQDHeprpG5llILnynXgEPQWrypupn
         bLJb3BrPUcgykqzRwrlXmaPvwckD8ZqCrDqZrSIKbhi6gXKhkA00UzwLatjqqX7m2zwa
         edpi5zJ7xnH2uN801ACC9hddmI6Ej/QqP6kihlA4e54kGN0R46NftuebVlRLfULb0RYD
         7b/UfXJhLCyZwvI6zJ3iS7lkbGkfHCvwQCIbiC0uE6/XHvIzHWKU1HXUv6vj/RLpviQ3
         VX8Mq9lNoO3q3s4mk9ruxqmp573k9m+dY1oNHDvkqVwjg9ktNnktzFSfJfMBOZ/D0Y28
         u03g==
X-Gm-Message-State: AOJu0YxD1XwJ19H96l1LEf4Pzg/DdEOtGL/Zrt3QYOEVhepd4VgNuU7P
        05NKZ8SaKZe9vRYuKeGu187A9Q==
X-Google-Smtp-Source: AGHT+IGOPe0WC74Ig9kJeU3G4KlQqvKETUNZbt/Zr27obVfknfcp5jVZziY/hDC8A4yjnciu2NhRQg==
X-Received: by 2002:a05:6820:1799:b0:581:ea96:f800 with SMTP id bs25-20020a056820179900b00581ea96f800mr18272643oob.6.1698863589482;
        Wed, 01 Nov 2023 11:33:09 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id m14-20020a4aab8e000000b00581e090fd1fsm686331oon.8.2023.11.01.11.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 11:33:08 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
Date:   Wed, 01 Nov 2023 11:33:00 -0700
Subject: [PATCH v9 2/3] riscv: Add remaining module relocations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231101-module_relocations-v9-2-8dfa3483c400@rivosinc.com>
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
        Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add all final module relocations and add error logs explaining the ones
that are not supported. Implement overflow checks for
ADD/SUB/SET/ULEB128 relocations.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/uapi/asm/elf.h |   5 +-
 arch/riscv/kernel/module.c        | 448 +++++++++++++++++++++++++++++++++++---
 2 files changed, 423 insertions(+), 30 deletions(-)

diff --git a/arch/riscv/include/uapi/asm/elf.h b/arch/riscv/include/uapi/asm/elf.h
index d696d6610231..11a71b8533d5 100644
--- a/arch/riscv/include/uapi/asm/elf.h
+++ b/arch/riscv/include/uapi/asm/elf.h
@@ -49,6 +49,7 @@ typedef union __riscv_fp_state elf_fpregset_t;
 #define R_RISCV_TLS_DTPREL64	9
 #define R_RISCV_TLS_TPREL32	10
 #define R_RISCV_TLS_TPREL64	11
+#define R_RISCV_IRELATIVE	58
 
 /* Relocation types not used by the dynamic linker */
 #define R_RISCV_BRANCH		16
@@ -81,7 +82,6 @@ typedef union __riscv_fp_state elf_fpregset_t;
 #define R_RISCV_ALIGN		43
 #define R_RISCV_RVC_BRANCH	44
 #define R_RISCV_RVC_JUMP	45
-#define R_RISCV_LUI		46
 #define R_RISCV_GPREL_I		47
 #define R_RISCV_GPREL_S		48
 #define R_RISCV_TPREL_I		49
@@ -93,6 +93,9 @@ typedef union __riscv_fp_state elf_fpregset_t;
 #define R_RISCV_SET16		55
 #define R_RISCV_SET32		56
 #define R_RISCV_32_PCREL	57
+#define R_RISCV_PLT32		59
+#define R_RISCV_SET_ULEB128	60
+#define R_RISCV_SUB_ULEB128	61
 
 
 #endif /* _UAPI_ASM_RISCV_ELF_H */
diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
index 8286d3bb04f4..4b339729d5ec 100644
--- a/arch/riscv/kernel/module.c
+++ b/arch/riscv/kernel/module.c
@@ -7,6 +7,9 @@
 #include <linux/elf.h>
 #include <linux/err.h>
 #include <linux/errno.h>
+#include <linux/hashtable.h>
+#include <linux/kernel.h>
+#include <linux/log2.h>
 #include <linux/moduleloader.h>
 #include <linux/vmalloc.h>
 #include <linux/sizes.h>
@@ -14,6 +17,38 @@
 #include <asm/alternative.h>
 #include <asm/sections.h>
 
+struct used_bucket {
+	struct list_head head;
+	struct hlist_head *bucket;
+};
+
+struct relocation_head {
+	struct hlist_node node;
+	struct list_head *rel_entry;
+	void *location;
+};
+
+struct relocation_entry {
+	struct list_head head;
+	Elf_Addr value;
+	unsigned int type;
+};
+
+struct relocation_handlers {
+	int (*reloc_handler)(struct module *me, void *location, Elf_Addr v);
+	int (*accumulate_handler)(struct module *me, void *location,
+				  long buffer);
+};
+
+unsigned int initialize_relocation_hashtable(unsigned int num_relocations);
+void process_accumulated_relocations(struct module *me);
+int add_relocation_to_accumulate(struct module *me, int type, void *location,
+				 unsigned int hashtable_bits, Elf_Addr v);
+
+struct hlist_head *relocation_hashtable;
+
+struct list_head used_buckets_list;
+
 /*
  * The auipc+jalr instruction pair can reach any PC-relative offset
  * in the range [-2^31 - 2^11, 2^31 - 2^11)
@@ -273,6 +308,12 @@ static int apply_r_riscv_align_rela(struct module *me, void *location,
 	return -EINVAL;
 }
 
+static int apply_r_riscv_add8_rela(struct module *me, void *location, Elf_Addr v)
+{
+	*(u8 *)location += (u8)v;
+	return 0;
+}
+
 static int apply_r_riscv_add16_rela(struct module *me, void *location,
 				    Elf_Addr v)
 {
@@ -294,6 +335,12 @@ static int apply_r_riscv_add64_rela(struct module *me, void *location,
 	return 0;
 }
 
+static int apply_r_riscv_sub8_rela(struct module *me, void *location, Elf_Addr v)
+{
+	*(u8 *)location -= (u8)v;
+	return 0;
+}
+
 static int apply_r_riscv_sub16_rela(struct module *me, void *location,
 				    Elf_Addr v)
 {
@@ -315,33 +362,369 @@ static int apply_r_riscv_sub64_rela(struct module *me, void *location,
 	return 0;
 }
 
-static int (*reloc_handlers_rela[]) (struct module *me, void *location,
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
+static int dynamic_linking_not_supported(struct module *me, void *location,
+					 Elf_Addr v)
+{
+	pr_err("%s: Dynamic linking not supported in kernel modules PC = %p\n",
+	       me->name, location);
+	return -EINVAL;
+}
+
+static int tls_not_supported(struct module *me, void *location, Elf_Addr v)
+{
+	pr_err("%s: Thread local storage not supported in kernel modules PC = %p\n",
+	       me->name, location);
+	return -EINVAL;
+}
+
+static int apply_r_riscv_sub6_rela(struct module *me, void *location, Elf_Addr v)
+{
+	u8 *byte = location;
+	u8 value = v;
+
+	*byte = (*byte - (value & 0x3f)) & 0x3f;
+	return 0;
+}
+
+static int apply_r_riscv_set6_rela(struct module *me, void *location, Elf_Addr v)
+{
+	u8 *byte = location;
+	u8 value = v;
+
+	*byte = (*byte & 0xc0) | (value & 0x3f);
+	return 0;
+}
+
+static int apply_r_riscv_set8_rela(struct module *me, void *location, Elf_Addr v)
+{
+	*(u8 *)location = (u8)v;
+	return 0;
+}
+
+static int apply_r_riscv_set16_rela(struct module *me, void *location,
+				    Elf_Addr v)
+{
+	*(u16 *)location = (u16)v;
+	return 0;
+}
+
+static int apply_r_riscv_set32_rela(struct module *me, void *location,
+				    Elf_Addr v)
+{
+	*(u32 *)location = (u32)v;
+	return 0;
+}
+
+static int apply_r_riscv_32_pcrel_rela(struct module *me, void *location,
+				       Elf_Addr v)
+{
+	*(u32 *)location = v - (uintptr_t)location;
+	return 0;
+}
+
+static int apply_r_riscv_plt32_rela(struct module *me, void *location,
+				    Elf_Addr v)
+{
+	ptrdiff_t offset = (void *)v - location;
+
+	if (!riscv_insn_valid_32bit_offset(offset)) {
+		/* Only emit the plt entry if offset over 32-bit range */
+		if (IS_ENABLED(CONFIG_MODULE_SECTIONS)) {
+			offset = (void *)module_emit_plt_entry(me, v) - location;
+		} else {
+			pr_err("%s: target %016llx can not be addressed by the 32-bit offset from PC = %p\n",
+			       me->name, (long long)v, location);
+			return -EINVAL;
+		}
+	}
+
+	*(u32 *)location = (u32)offset;
+	return 0;
+}
+
+static int apply_r_riscv_set_uleb128(struct module *me, void *location, Elf_Addr v)
+{
+	*(long *)location = v;
+	return 0;
+}
+
+static int apply_r_riscv_sub_uleb128(struct module *me, void *location, Elf_Addr v)
+{
+	*(long *)location -= v;
+	return 0;
+}
+
+static int apply_6_bit_accumulation(struct module *me, void *location, long buffer)
+{
+	u8 *byte = location;
+	u8 value = buffer;
+
+	if (buffer > 0x3f) {
+		pr_err("%s: value %ld out of range for 6-bit relocation.\n",
+		       me->name, buffer);
+		return -EINVAL;
+	}
+
+	*byte = (*byte & 0xc0) | (value & 0x3f);
+	return 0;
+}
+
+static int apply_8_bit_accumulation(struct module *me, void *location, long buffer)
+{
+	if (buffer > U8_MAX) {
+		pr_err("%s: value %ld out of range for 8-bit relocation.\n",
+		       me->name, buffer);
+		return -EINVAL;
+	}
+	*(u8 *)location = (u8)buffer;
+	return 0;
+}
+
+static int apply_16_bit_accumulation(struct module *me, void *location, long buffer)
+{
+	if (buffer > U16_MAX) {
+		pr_err("%s: value %ld out of range for 16-bit relocation.\n",
+		       me->name, buffer);
+		return -EINVAL;
+	}
+	*(u16 *)location = (u16)buffer;
+	return 0;
+}
+
+static int apply_32_bit_accumulation(struct module *me, void *location, long buffer)
+{
+	if (buffer > U32_MAX) {
+		pr_err("%s: value %ld out of range for 32-bit relocation.\n",
+		       me->name, buffer);
+		return -EINVAL;
+	}
+	*(u32 *)location = (u32)buffer;
+	return 0;
+}
+
+static int apply_64_bit_accumulation(struct module *me, void *location, long buffer)
+{
+	*(u64 *)location = (u64)buffer;
+	return 0;
+}
+
+static int apply_uleb128_accumulation(struct module *me, void *location, long buffer)
+{
+	/*
+	 * ULEB128 is a variable length encoding. Encode the buffer into
+	 * the ULEB128 data format.
+	 */
+	u8 *p = location;
+
+	while (buffer != 0) {
+		u8 value = buffer & 0x7f;
+
+		buffer >>= 7;
+		value |= (!!buffer) << 7;
+
+		*p++ = value;
+	}
+	return 0;
+}
+
+/*
+ * Relocations defined in the riscv-elf-psabi-doc.
+ * This handles static linking only.
+ */
+static const struct relocation_handlers reloc_handlers[] = {
+	[R_RISCV_32] = { apply_r_riscv_32_rela },
+	[R_RISCV_64] = { apply_r_riscv_64_rela },
+	[R_RISCV_RELATIVE] = { dynamic_linking_not_supported },
+	[R_RISCV_COPY] = { dynamic_linking_not_supported },
+	[R_RISCV_JUMP_SLOT] = { dynamic_linking_not_supported },
+	[R_RISCV_TLS_DTPMOD32] = { dynamic_linking_not_supported },
+	[R_RISCV_TLS_DTPMOD64] = { dynamic_linking_not_supported },
+	[R_RISCV_TLS_DTPREL32] = { dynamic_linking_not_supported },
+	[R_RISCV_TLS_DTPREL64] = { dynamic_linking_not_supported },
+	[R_RISCV_TLS_TPREL32] = { dynamic_linking_not_supported },
+	[R_RISCV_TLS_TPREL64] = { dynamic_linking_not_supported },
+	/* 12-15 undefined */
+	[R_RISCV_BRANCH] = { apply_r_riscv_branch_rela },
+	[R_RISCV_JAL] = { apply_r_riscv_jal_rela },
+	[R_RISCV_CALL] = { apply_r_riscv_call_rela },
+	[R_RISCV_CALL_PLT] = { apply_r_riscv_call_plt_rela },
+	[R_RISCV_GOT_HI20] = { apply_r_riscv_got_hi20_rela },
+	[R_RISCV_TLS_GOT_HI20] = { tls_not_supported },
+	[R_RISCV_TLS_GD_HI20] = { tls_not_supported },
+	[R_RISCV_PCREL_HI20] = { apply_r_riscv_pcrel_hi20_rela },
+	[R_RISCV_PCREL_LO12_I] = { apply_r_riscv_pcrel_lo12_i_rela },
+	[R_RISCV_PCREL_LO12_S] = { apply_r_riscv_pcrel_lo12_s_rela },
+	[R_RISCV_HI20] = { apply_r_riscv_hi20_rela },
+	[R_RISCV_LO12_I] = { apply_r_riscv_lo12_i_rela },
+	[R_RISCV_LO12_S] = { apply_r_riscv_lo12_s_rela },
+	[R_RISCV_TPREL_HI20] = { tls_not_supported },
+	[R_RISCV_TPREL_LO12_I] = { tls_not_supported },
+	[R_RISCV_TPREL_LO12_S] = { tls_not_supported },
+	[R_RISCV_TPREL_ADD] = { tls_not_supported },
+	[R_RISCV_ADD8] = { apply_r_riscv_add8_rela, apply_8_bit_accumulation },
+	[R_RISCV_ADD16] = { apply_r_riscv_add16_rela,
+			    apply_16_bit_accumulation },
+	[R_RISCV_ADD32] = { apply_r_riscv_add32_rela,
+			    apply_32_bit_accumulation },
+	[R_RISCV_ADD64] = { apply_r_riscv_add64_rela,
+			    apply_64_bit_accumulation },
+	[R_RISCV_SUB8] = { apply_r_riscv_sub8_rela, apply_8_bit_accumulation },
+	[R_RISCV_SUB16] = { apply_r_riscv_sub16_rela,
+			    apply_16_bit_accumulation },
+	[R_RISCV_SUB32] = { apply_r_riscv_sub32_rela,
+			    apply_32_bit_accumulation },
+	[R_RISCV_SUB64] = { apply_r_riscv_sub64_rela,
+			    apply_64_bit_accumulation },
+	/* 41-42 reserved for future standard use */
+	[R_RISCV_ALIGN] = { apply_r_riscv_align_rela },
+	[R_RISCV_RVC_BRANCH] = { apply_r_riscv_rvc_branch_rela },
+	[R_RISCV_RVC_JUMP] = { apply_r_riscv_rvc_jump_rela },
+	/* 46-50 reserved for future standard use */
+	[R_RISCV_RELAX] = { apply_r_riscv_relax_rela },
+	[R_RISCV_SUB6] = { apply_r_riscv_sub6_rela, apply_6_bit_accumulation },
+	[R_RISCV_SET6] = { apply_r_riscv_set6_rela, apply_6_bit_accumulation },
+	[R_RISCV_SET8] = { apply_r_riscv_set8_rela, apply_8_bit_accumulation },
+	[R_RISCV_SET16] = { apply_r_riscv_set16_rela,
+			    apply_16_bit_accumulation },
+	[R_RISCV_SET32] = { apply_r_riscv_set32_rela,
+			    apply_32_bit_accumulation },
+	[R_RISCV_32_PCREL] = { apply_r_riscv_32_pcrel_rela },
+	[R_RISCV_IRELATIVE] = { dynamic_linking_not_supported },
+	[R_RISCV_PLT32] = { apply_r_riscv_plt32_rela },
+	[R_RISCV_SET_ULEB128] = { apply_r_riscv_set_uleb128,
+				  apply_uleb128_accumulation },
+	[R_RISCV_SUB_ULEB128] = { apply_r_riscv_sub_uleb128,
+				  apply_uleb128_accumulation },
+	/* 62-191 reserved for future standard use */
+	/* 192-255 nonstandard ABI extensions  */
 };
 
+void process_accumulated_relocations(struct module *me)
+{
+	/*
+	 * Only ADD/SUB/SET/ULEB128 should end up here.
+	 *
+	 * Each bucket may have more than one relocation location. All
+	 * relocations for a location are stored in a list in a bucket.
+	 *
+	 * Relocations are applied to a temp variable before being stored to the
+	 * provided location to check for overflow. This also allows ULEB128 to
+	 * properly decide how many entries are needed before storing to
+	 * location. The final value is stored into location using the handler
+	 * for the last relocation to an address.
+	 *
+	 * Three layers of indexing:
+	 *	- Each of the buckets in use
+	 *	- Groups of relocations in each bucket by location address
+	 *	- Each relocation entry for a location address
+	 */
+	struct used_bucket *bucket_iter;
+	struct relocation_head *rel_head_iter;
+	struct relocation_entry *rel_entry_iter;
+	int curr_type;
+	void *location;
+	long buffer;
+
+	list_for_each_entry(bucket_iter, &used_buckets_list, head) {
+		hlist_for_each_entry(rel_head_iter, bucket_iter->bucket, node) {
+			buffer = 0;
+			location = rel_head_iter->location;
+			list_for_each_entry(rel_entry_iter,
+					    rel_head_iter->rel_entry, head) {
+				curr_type = rel_entry_iter->type;
+				reloc_handlers[curr_type].reloc_handler(
+					me, &buffer, rel_entry_iter->value);
+				kfree(rel_entry_iter);
+			}
+			reloc_handlers[curr_type].accumulate_handler(
+				me, location, buffer);
+			kfree(rel_head_iter);
+		}
+		kfree(bucket_iter);
+	}
+
+	kfree(relocation_hashtable);
+}
+
+int add_relocation_to_accumulate(struct module *me, int type, void *location,
+				 unsigned int hashtable_bits, Elf_Addr v)
+{
+	struct relocation_entry *entry;
+	struct relocation_head *rel_head;
+	struct hlist_head *current_head;
+	struct used_bucket *bucket;
+	unsigned long hash;
+
+	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
+	INIT_LIST_HEAD(&entry->head);
+	entry->type = type;
+	entry->value = v;
+
+	hash = hash_min((uintptr_t)location, hashtable_bits);
+
+	current_head = &relocation_hashtable[hash];
+
+	/* Find matching location (if any) */
+	bool found = false;
+	struct relocation_head *rel_head_iter;
+
+	hlist_for_each_entry(rel_head_iter, current_head, node) {
+		if (rel_head_iter->location == location) {
+			found = true;
+			rel_head = rel_head_iter;
+			break;
+		}
+	}
+
+	if (!found) {
+		rel_head = kmalloc(sizeof(*rel_head), GFP_KERNEL);
+		rel_head->rel_entry =
+			kmalloc(sizeof(struct list_head), GFP_KERNEL);
+		INIT_LIST_HEAD(rel_head->rel_entry);
+		rel_head->location = location;
+		INIT_HLIST_NODE(&rel_head->node);
+		if (!current_head->first) {
+			bucket =
+				kmalloc(sizeof(struct used_bucket), GFP_KERNEL);
+			INIT_LIST_HEAD(&bucket->head);
+			bucket->bucket = current_head;
+			list_add(&bucket->head, &used_buckets_list);
+		}
+		hlist_add_head(&rel_head->node, current_head);
+	}
+
+	/* Add relocation to head of discovered rel_head */
+	list_add_tail(&entry->head, rel_head->rel_entry);
+
+	return 0;
+}
+
+unsigned int initialize_relocation_hashtable(unsigned int num_relocations)
+{
+	/* Can safely assume that bits is not greater than sizeof(long) */
+	unsigned long hashtable_size = roundup_pow_of_two(num_relocations);
+	unsigned int hashtable_bits = ilog2(hashtable_size);
+
+	/*
+	 * Double size of hashtable if num_relocations * 1.25 is greater than
+	 * hashtable_size.
+	 */
+	int should_double_size = ((num_relocations + (num_relocations >> 2)) > (hashtable_size));
+
+	hashtable_bits += should_double_size;
+
+	hashtable_size <<= should_double_size;
+
+	relocation_hashtable = kmalloc_array(hashtable_size,
+					     sizeof(*relocation_hashtable),
+					     GFP_KERNEL);
+	__hash_init(relocation_hashtable, hashtable_size);
+
+	INIT_LIST_HEAD(&used_buckets_list);
+
+	return hashtable_bits;
+}
+
 int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
 		       unsigned int symindex, unsigned int relsec,
 		       struct module *me)
@@ -353,11 +736,13 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
 	unsigned int i, type;
 	Elf_Addr v;
 	int res;
+	unsigned int num_relocations = sechdrs[relsec].sh_size / sizeof(*rel);
+	unsigned int hashtable_bits = initialize_relocation_hashtable(num_relocations);
 
 	pr_debug("Applying relocate section %u to %u\n", relsec,
 	       sechdrs[relsec].sh_info);
 
-	for (i = 0; i < sechdrs[relsec].sh_size / sizeof(*rel); i++) {
+	for (i = 0; i < num_relocations; i++) {
 		/* This is where to make the change */
 		location = (void *)sechdrs[sechdrs[relsec].sh_info].sh_addr
 			+ rel[i].r_offset;
@@ -375,8 +760,8 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
 
 		type = ELF_RISCV_R_TYPE(rel[i].r_info);
 
-		if (type < ARRAY_SIZE(reloc_handlers_rela))
-			handler = reloc_handlers_rela[type];
+		if (type < ARRAY_SIZE(reloc_handlers))
+			handler = reloc_handlers[type].reloc_handler;
 		else
 			handler = NULL;
 
@@ -432,11 +817,16 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
 			}
 		}
 
-		res = handler(me, location, v);
+		if (reloc_handlers[type].accumulate_handler)
+			res = add_relocation_to_accumulate(me, type, location, hashtable_bits, v);
+		else
+			res = handler(me, location, v);
 		if (res)
 			return res;
 	}
 
+	process_accumulated_relocations(me);
+
 	return 0;
 }
 

-- 
2.34.1

