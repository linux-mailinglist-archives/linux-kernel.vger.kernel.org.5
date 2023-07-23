Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D761275E121
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 12:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjGWKFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 06:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjGWKE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 06:04:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4D710FD;
        Sun, 23 Jul 2023 03:04:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E778C60C85;
        Sun, 23 Jul 2023 10:04:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CB3EC433C8;
        Sun, 23 Jul 2023 10:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690106696;
        bh=mkPBv8kLdnRfYxcYlj3UPW+Mclfkhj7WW4z0JfDd0ww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qPjKNyaZ4XAjt58yoGipfGQpvEDbZ654wQHRPEBcP2uzoRZRnXTOhGAVAP3iCDd69
         Jaatzn89i/fiA6lHNym3WV7lYlOiuQrwGKlp23qI6KaKm82qF9FljqStOLXo5LPvrL
         hfyuXSgfsiCnO1B/IUSll627bcEpj9pbe8AxZ9h4yVx8uz1eOaUOVeUNCTF38R1wIo
         JMLJGtbOaGwzWhYQmkheFlLf8dCkZ0XLRx4/KnZvKhf2oxVsXhSMpf9//JOKpuRO3T
         /2vlkdtsWnYoKAcEEUyJ7Sa71k3C0XvOaigLo70h7dcZ7KyJeSOdFUr/uAQVz3Br5G
         3lcaCyhu9wXbQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 4/4] modpost: remove ElF_Rela variables from for-loop in section_rel(a)
Date:   Sun, 23 Jul 2023 19:04:46 +0900
Message-Id: <20230723100446.3062358-4-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230723100446.3062358-1-masahiroy@kernel.org>
References: <20230723100446.3062358-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the Elf_Rela variables used in the for-loop in section_rel().

This makes the code consistent; section_rel() only uses Elf_Rel,
section_rela() only uses Elf_Rela.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index ca04b87c1679..9761f9d0eec0 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1465,8 +1465,6 @@ static void section_rela(struct module *mod, struct elf_info *elf,
 			 Elf_Shdr *sechdr)
 {
 	Elf_Rela *rela;
-	Elf_Rela r;
-	unsigned int r_sym;
 	unsigned int fsecndx = sechdr->sh_info;
 	const char *fromsec = sec_name(elf, fsecndx);
 	Elf_Rela *start = (void *)elf->hdr + sechdr->sh_offset;
@@ -1477,12 +1475,14 @@ static void section_rela(struct module *mod, struct elf_info *elf,
 		return;
 
 	for (rela = start; rela < stop; rela++) {
-		unsigned int r_type;
+		Elf_Addr taddr, r_offset;
+		unsigned int r_type, r_sym;
 
-		r.r_offset = TO_NATIVE(rela->r_offset);
+		r_offset = TO_NATIVE(rela->r_offset);
 		get_rel_type_and_sym(elf, rela->r_info, &r_type, &r_sym);
 
-		r.r_addend = TO_NATIVE(rela->r_addend);
+		taddr = TO_NATIVE(rela->r_addend);
+
 		switch (elf->hdr->e_machine) {
 		case EM_RISCV:
 			if (!strcmp("__ex_table", fromsec) &&
@@ -1497,7 +1497,7 @@ static void section_rela(struct module *mod, struct elf_info *elf,
 		}
 
 		check_section_mismatch(mod, elf, elf->symtab_start + r_sym,
-				       fsecndx, fromsec, r.r_offset, r.r_addend);
+				       fsecndx, fromsec, r_offset, taddr);
 	}
 }
 
@@ -1505,8 +1505,6 @@ static void section_rel(struct module *mod, struct elf_info *elf,
 			Elf_Shdr *sechdr)
 {
 	Elf_Rel *rel;
-	Elf_Rela r;
-	unsigned int r_sym;
 	unsigned int fsecndx = sechdr->sh_info;
 	const char *fromsec = sec_name(elf, fsecndx);
 	Elf_Rel *start = (void *)elf->hdr + sechdr->sh_offset;
@@ -1518,15 +1516,14 @@ static void section_rel(struct module *mod, struct elf_info *elf,
 
 	for (rel = start; rel < stop; rel++) {
 		Elf_Sym *tsym;
-		Elf_Addr taddr = 0;
+		Elf_Addr taddr = 0, r_offset;
+		unsigned int r_type, r_sym;
 		void *loc;
-		unsigned int r_type;
-
-		r.r_offset = TO_NATIVE(rel->r_offset);
 
+		r_offset = TO_NATIVE(rel->r_offset);
 		get_rel_type_and_sym(elf, rel->r_info, &r_type, &r_sym);
 
-		loc = sym_get_data_by_offset(elf, fsecndx, r.r_offset);
+		loc = sym_get_data_by_offset(elf, fsecndx, r_offset);
 		tsym = elf->symtab_start + r_sym;
 
 		switch (elf->hdr->e_machine) {
@@ -1544,7 +1541,7 @@ static void section_rel(struct module *mod, struct elf_info *elf,
 		}
 
 		check_section_mismatch(mod, elf, tsym,
-				       fsecndx, fromsec, r.r_offset, taddr);
+				       fsecndx, fromsec, r_offset, taddr);
 	}
 }
 
-- 
2.39.2

