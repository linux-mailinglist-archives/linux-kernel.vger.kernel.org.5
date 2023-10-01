Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB987B4572
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 07:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234326AbjJAFru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 01:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjJAFrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 01:47:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA651C6;
        Sat, 30 Sep 2023 22:47:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF09CC433C8;
        Sun,  1 Oct 2023 05:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696139264;
        bh=88KKkoAPRDO23nRFoIefVOhrftazGGYp+0IoLxHUnW0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hmQ/1YooZLswpEixBNq286dO6GF8BLA9gFrJZfBsiUw8SWMJTOYaDd7K1wHFVpGDf
         0wJrqILpcxhWPakn1KOvo6ewMQ4Q7F9XMdENYBmEO+b/mFM6qFcEj8k9DXSIsv02Js
         WLoejLmTkxMnFQDAZsL6d89Ku2Tn4yzLGxpngKraRf5gXurOnIOJqC3b+Ynf1E4FNs
         pX4SwLayvaVM2pzHJgml05npjdbicunDFhv+b8sTxNhP1FgpinUPcVNkVRbKoPkBzg
         /rqAE/uovPfnn8GzT4dUbEEnfdEg/LhouUleLGO7ZelUVqfqfgyhdEO4fqjjmvr6kX
         Ns/lX/DRhhA9Q==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 2/2] modpost: factor out the common boilerplate of section_rel(a)
Date:   Sun,  1 Oct 2023 14:47:36 +0900
Message-Id: <20231001054736.1586001-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231001054736.1586001-1-masahiroy@kernel.org>
References: <20231001054736.1586001-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first few lines of section_rel() and section_rela() are the same.
They both retrieve the index of the section to which the relocaton
applies, and skip known-good sections. This common code should be moved
to check_sec_ref().

Avoid ugly casts when computing 'start' and 'stop', and also make the
Elf_Rel and Elf_Rela pointers const.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 50 ++++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 15d78fe152ac..0e18fe617ed1 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1425,17 +1425,10 @@ static void get_rel_type_and_sym(struct elf_info *elf, uint64_t r_info,
 }
 
 static void section_rela(struct module *mod, struct elf_info *elf,
-			 Elf_Shdr *sechdr)
+			 unsigned int fsecndx, const char *fromsec,
+			 const Elf_Rela *start, const Elf_Rela *stop)
 {
-	Elf_Rela *rela;
-	unsigned int fsecndx = sechdr->sh_info;
-	const char *fromsec = sec_name(elf, fsecndx);
-	Elf_Rela *start = (void *)elf->hdr + sechdr->sh_offset;
-	Elf_Rela *stop  = (void *)start + sechdr->sh_size;
-
-	/* if from section (name) is know good then skip it */
-	if (match(fromsec, section_white_list))
-		return;
+	const Elf_Rela *rela;
 
 	for (rela = start; rela < stop; rela++) {
 		Elf_Addr taddr, r_offset;
@@ -1465,17 +1458,10 @@ static void section_rela(struct module *mod, struct elf_info *elf,
 }
 
 static void section_rel(struct module *mod, struct elf_info *elf,
-			Elf_Shdr *sechdr)
+			unsigned int fsecndx, const char *fromsec,
+			const Elf_Rel *start, const Elf_Rel *stop)
 {
-	Elf_Rel *rel;
-	unsigned int fsecndx = sechdr->sh_info;
-	const char *fromsec = sec_name(elf, fsecndx);
-	Elf_Rel *start = (void *)elf->hdr + sechdr->sh_offset;
-	Elf_Rel *stop  = (void *)start + sechdr->sh_size;
-
-	/* if from section (name) is know good then skip it */
-	if (match(fromsec, section_white_list))
-		return;
+	const Elf_Rel *rel;
 
 	for (rel = start; rel < stop; rel++) {
 		Elf_Sym *tsym;
@@ -1530,10 +1516,26 @@ static void check_sec_ref(struct module *mod, struct elf_info *elf)
 
 		check_section(mod->name, elf, sechdr);
 		/* We want to process only relocation sections and not .init */
-		if (sechdr->sh_type == SHT_RELA)
-			section_rela(mod, elf, sechdr);
-		else if (sechdr->sh_type == SHT_REL)
-			section_rel(mod, elf, sechdr);
+		if (sechdr->sh_type == SHT_REL || sechdr->sh_type == SHT_RELA) {
+			/* section to which the relocation applies */
+			unsigned int secndx = sechdr->sh_info;
+			const char *secname = sec_name(elf, secndx);
+			const void *start, *stop;
+
+			/* If the section is known good, skip it */
+			if (match(secname, section_white_list))
+				continue;
+
+			start = sym_get_data_by_offset(elf, i, 0);
+			stop = start + sechdr->sh_size;
+
+			if (sechdr->sh_type == SHT_RELA)
+				section_rela(mod, elf, secndx, secname,
+					     start, stop);
+			else
+				section_rel(mod, elf, secndx, secname,
+					    start, stop);
+		}
 	}
 }
 
-- 
2.39.2

