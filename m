Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2A075E11E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 12:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjGWKE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 06:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjGWKEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 06:04:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8991700;
        Sun, 23 Jul 2023 03:04:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1C7160C4D;
        Sun, 23 Jul 2023 10:04:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 293D2C433C9;
        Sun, 23 Jul 2023 10:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690106693;
        bh=UiQB6Q+u02aPXjGF4YJytujOiAQWjDqnNFi9tEQ8cUk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pqJJX/7bg7b0E4wiPkh/N95OF9mwwuRN1Wa6aS9YHWFE8pQpawXz7MHOX+FbsmZ/w
         leVX55FGVI4n/uhpOU3uE59IGFNYp1Bmt3pHwyz/tcYUinwiOiU7Vl8XHvWG84Ib3F
         PvNxQRzjh1PPZxw/ib9LyEBkjdDj+SmK1R/X4uPDyAi3JPTaeZYpO4kgVPX78PO8Aq
         rQJBH85M4UuDLANTMcMPTnpOBdTRujVoQqDamlS2Eghru2gS357SWZIdEwQpkxgDq0
         XQExhiBeFwdjjUtbXa/Va5+sYIWva1SblPyam0wdSzi3SqqEVsT+tPlKzJ7oRKs3Zp
         HBhvOfv5BSPGA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 2/4] modpost: pass r_type to addend_*_rel()
Date:   Sun, 23 Jul 2023 19:04:44 +0900
Message-Id: <20230723100446.3062358-2-masahiroy@kernel.org>
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

All of addend_*_rel() need the Elf_Rela pointer just for calculating
ELF_R_TYPE(r->r_info).

You can do it on the caller to de-duplicate the code.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index a8e85b7cc0da..570a6cb6dd00 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1257,11 +1257,9 @@ static void check_section_mismatch(struct module *mod, struct elf_info *elf,
 				 tosec, taddr);
 }
 
-static Elf_Addr addend_386_rel(uint32_t *location, Elf_Rela *r)
+static Elf_Addr addend_386_rel(uint32_t *location, unsigned int r_type)
 {
-	unsigned int r_typ = ELF_R_TYPE(r->r_info);
-
-	switch (r_typ) {
+	switch (r_type) {
 	case R_386_32:
 		return TO_NATIVE(*location);
 	case R_386_PC32:
@@ -1312,13 +1310,12 @@ static int32_t sign_extend32(int32_t value, int index)
 	return (int32_t)(value << shift) >> shift;
 }
 
-static Elf_Addr addend_arm_rel(void *loc, Elf_Sym *sym, Elf_Rela *r)
+static Elf_Addr addend_arm_rel(void *loc, Elf_Sym *sym, unsigned int r_type)
 {
-	unsigned int r_typ = ELF_R_TYPE(r->r_info);
 	uint32_t inst, upper, lower, sign, j1, j2;
 	int32_t offset;
 
-	switch (r_typ) {
+	switch (r_type) {
 	case R_ARM_ABS32:
 	case R_ARM_REL32:
 		inst = TO_NATIVE(*(uint32_t *)loc);
@@ -1397,13 +1394,12 @@ static Elf_Addr addend_arm_rel(void *loc, Elf_Sym *sym, Elf_Rela *r)
 	return (Elf_Addr)(-1);
 }
 
-static Elf_Addr addend_mips_rel(uint32_t *location, Elf_Rela *r)
+static Elf_Addr addend_mips_rel(uint32_t *location, unsigned int r_type)
 {
-	unsigned int r_typ = ELF_R_TYPE(r->r_info);
 	uint32_t inst;
 
 	inst = TO_NATIVE(*location);
-	switch (r_typ) {
+	switch (r_type) {
 	case R_MIPS_LO16:
 		return inst & 0xffff;
 	case R_MIPS_26:
@@ -1500,6 +1496,7 @@ static void section_rel(struct module *mod, struct elf_info *elf,
 		Elf_Sym *tsym;
 		Elf_Addr taddr = 0;
 		void *loc;
+		unsigned int r_type;
 
 		r.r_offset = TO_NATIVE(rel->r_offset);
 #if KERNEL_ELFCLASS == ELFCLASS64
@@ -1520,16 +1517,17 @@ static void section_rel(struct module *mod, struct elf_info *elf,
 
 		loc = sym_get_data_by_offset(elf, fsecndx, r.r_offset);
 		tsym = elf->symtab_start + r_sym;
+		r_type = ELF_R_TYPE(r.r_info);
 
 		switch (elf->hdr->e_machine) {
 		case EM_386:
-			taddr = addend_386_rel(loc, &r);
+			taddr = addend_386_rel(loc, r_type);
 			break;
 		case EM_ARM:
-			taddr = addend_arm_rel(loc, tsym, &r);
+			taddr = addend_arm_rel(loc, tsym, r_type);
 			break;
 		case EM_MIPS:
-			taddr = addend_mips_rel(loc, &r);
+			taddr = addend_mips_rel(loc, r_type);
 			break;
 		default:
 			fatal("Please add code to calculate addend for this architecture\n");
-- 
2.39.2

