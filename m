Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D374375E11F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 12:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjGWKFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 06:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjGWKE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 06:04:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF1910FD;
        Sun, 23 Jul 2023 03:04:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 694EC60C83;
        Sun, 23 Jul 2023 10:04:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0EE0C433CA;
        Sun, 23 Jul 2023 10:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690106694;
        bh=0d38BDz13wpDqB6CjBtTocdL2VBkxIJFEtETsaCSyQ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p9OiizfiJV/r6359v+TPHiE7iOS2q3RulsDyneJfh5yjUuMd4myurP1bmyJQmkZnH
         1G4SaBxeegBNL1ahPctN3YvRhKfGVuR8r+zMhLWouKKEujMHvHzCLcrZVXtub2pwie
         XLKU9xKz0OfeyeMAqkzmLdbvZFortLX+On/4h6JvMOrYPcAez5RPnuORhcHsr2iUo7
         jo5PX3f2ibJ7RNgWcttVGLWRIwJ8dIhr/JZJ1tELaH8Vx5K8m06sNh2UQC1oWdK7yF
         fsQ4d7AOWdWdnPYI6mT0+5rGZMmaTl2v9yB2fhUcp0SS28dOhKg/jUY1YXZSej6yRD
         TAG91rpf3M5Ug==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 3/4] modpost: clean up MIPS64 little endian relocation code
Date:   Sun, 23 Jul 2023 19:04:45 +0900
Message-Id: <20230723100446.3062358-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230723100446.3062358-1-masahiroy@kernel.org>
References: <20230723100446.3062358-1-masahiroy@kernel.org>
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

MIPS64 little endian target has an odd encoding of r_info.

This commit makes the special handling less ugly. It is still ugly,
but #if conditionals will go away, at least.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 76 ++++++++++++++++++++++++-------------------
 scripts/mod/modpost.h | 22 -------------
 2 files changed, 43 insertions(+), 55 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 570a6cb6dd00..ca04b87c1679 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1426,6 +1426,41 @@ static Elf_Addr addend_mips_rel(uint32_t *location, unsigned int r_type)
 #define R_LARCH_SUB32		55
 #endif
 
+static void get_rel_type_and_sym(struct elf_info *elf, uint64_t r_info,
+				 unsigned int *r_type, unsigned int *r_sym)
+{
+	typedef struct {
+		Elf64_Word    r_sym;	/* Symbol index */
+		unsigned char r_ssym;	/* Special symbol for 2nd relocation */
+		unsigned char r_type3;	/* 3rd relocation type */
+		unsigned char r_type2;	/* 2nd relocation type */
+		unsigned char r_type;	/* 1st relocation type */
+	} Elf64_Mips_R_Info;
+
+	bool is_64bit = (elf->hdr->e_ident[EI_CLASS] == ELFCLASS64);
+
+	if (elf->hdr->e_machine == EM_MIPS && is_64bit) {
+		Elf64_Mips_R_Info *mips64_r_info = (void *)&r_info;
+
+		*r_type = mips64_r_info->r_type;
+		*r_sym = TO_NATIVE(mips64_r_info->r_sym);
+		return;
+	}
+
+	if (is_64bit) {
+		Elf64_Xword r_info64 = r_info;
+
+		r_info = TO_NATIVE(r_info64);
+	} else {
+		Elf32_Word r_info32 = r_info;
+
+		r_info = TO_NATIVE(r_info32);
+	}
+
+	*r_type = ELF_R_TYPE(r_info);
+	*r_sym = ELF_R_SYM(r_info);
+}
+
 static void section_rela(struct module *mod, struct elf_info *elf,
 			 Elf_Shdr *sechdr)
 {
@@ -1442,32 +1477,21 @@ static void section_rela(struct module *mod, struct elf_info *elf,
 		return;
 
 	for (rela = start; rela < stop; rela++) {
+		unsigned int r_type;
+
 		r.r_offset = TO_NATIVE(rela->r_offset);
-#if KERNEL_ELFCLASS == ELFCLASS64
-		if (elf->hdr->e_machine == EM_MIPS) {
-			unsigned int r_typ;
-			r_sym = ELF64_MIPS_R_SYM(rela->r_info);
-			r_sym = TO_NATIVE(r_sym);
-			r_typ = ELF64_MIPS_R_TYPE(rela->r_info);
-			r.r_info = ELF64_R_INFO(r_sym, r_typ);
-		} else {
-			r.r_info = TO_NATIVE(rela->r_info);
-			r_sym = ELF_R_SYM(r.r_info);
-		}
-#else
-		r.r_info = TO_NATIVE(rela->r_info);
-		r_sym = ELF_R_SYM(r.r_info);
-#endif
+		get_rel_type_and_sym(elf, rela->r_info, &r_type, &r_sym);
+
 		r.r_addend = TO_NATIVE(rela->r_addend);
 		switch (elf->hdr->e_machine) {
 		case EM_RISCV:
 			if (!strcmp("__ex_table", fromsec) &&
-			    ELF_R_TYPE(r.r_info) == R_RISCV_SUB32)
+			    r_type == R_RISCV_SUB32)
 				continue;
 			break;
 		case EM_LOONGARCH:
 			if (!strcmp("__ex_table", fromsec) &&
-			    ELF_R_TYPE(r.r_info) == R_LARCH_SUB32)
+			    r_type == R_LARCH_SUB32)
 				continue;
 			break;
 		}
@@ -1499,25 +1523,11 @@ static void section_rel(struct module *mod, struct elf_info *elf,
 		unsigned int r_type;
 
 		r.r_offset = TO_NATIVE(rel->r_offset);
-#if KERNEL_ELFCLASS == ELFCLASS64
-		if (elf->hdr->e_machine == EM_MIPS) {
-			unsigned int r_typ;
-			r_sym = ELF64_MIPS_R_SYM(rel->r_info);
-			r_sym = TO_NATIVE(r_sym);
-			r_typ = ELF64_MIPS_R_TYPE(rel->r_info);
-			r.r_info = ELF64_R_INFO(r_sym, r_typ);
-		} else {
-			r.r_info = TO_NATIVE(rel->r_info);
-			r_sym = ELF_R_SYM(r.r_info);
-		}
-#else
-		r.r_info = TO_NATIVE(rel->r_info);
-		r_sym = ELF_R_SYM(r.r_info);
-#endif
+
+		get_rel_type_and_sym(elf, rel->r_info, &r_type, &r_sym);
 
 		loc = sym_get_data_by_offset(elf, fsecndx, r.r_offset);
 		tsym = elf->symtab_start + r_sym;
-		r_type = ELF_R_TYPE(r.r_info);
 
 		switch (elf->hdr->e_machine) {
 		case EM_386:
diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
index dfdb9484e325..5f94c2c9f2d9 100644
--- a/scripts/mod/modpost.h
+++ b/scripts/mod/modpost.h
@@ -50,28 +50,6 @@
 #define ELF_R_TYPE  ELF64_R_TYPE
 #endif
 
-/* The 64-bit MIPS ELF ABI uses an unusual reloc format. */
-typedef struct
-{
-	Elf32_Word    r_sym;	/* Symbol index */
-	unsigned char r_ssym;	/* Special symbol for 2nd relocation */
-	unsigned char r_type3;	/* 3rd relocation type */
-	unsigned char r_type2;	/* 2nd relocation type */
-	unsigned char r_type1;	/* 1st relocation type */
-} _Elf64_Mips_R_Info;
-
-typedef union
-{
-	Elf64_Xword		r_info_number;
-	_Elf64_Mips_R_Info	r_info_fields;
-} _Elf64_Mips_R_Info_union;
-
-#define ELF64_MIPS_R_SYM(i) \
-  ((__extension__ (_Elf64_Mips_R_Info_union)(i)).r_info_fields.r_sym)
-
-#define ELF64_MIPS_R_TYPE(i) \
-  ((__extension__ (_Elf64_Mips_R_Info_union)(i)).r_info_fields.r_type1)
-
 #if KERNEL_ELFDATA != HOST_ELFDATA
 
 static inline void __endian(const void *src, void *dest, unsigned int size)
-- 
2.39.2

