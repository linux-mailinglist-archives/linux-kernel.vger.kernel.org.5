Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5987DE36C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbjKAPFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 11:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232591AbjKAPFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 11:05:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2E9138;
        Wed,  1 Nov 2023 08:05:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20955C433CC;
        Wed,  1 Nov 2023 15:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698851104;
        bh=G5IEU13BAIg0z0NXW6uKOCp7ssGljo/FCvyBke8OHsQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uE+WrCb7M6EmKJdxJmKMrN/sRX3Hp6ydLqFVsn6B3tVKj8NG2/4jzEs8XIw6a0fn1
         Sp4SujkKHUgM1mUPTI1vhmZXJie9QgjC5tsgQTfXGtoRnPoYLKfY0EAwkEN6wm9JhJ
         8N9Ynm2p232u7jxkHH2RclCoFG9YeI5YsPWyvR6CaeSbCgzuM7Nc0iL3PRUYk3XlRf
         ruf8hY+VoJRLNBPpnEbP90M9csUCKeNRsODr4zHU/3xDNcw8icqhRK9rXOYyGVDbwo
         MPzL1vCOvE+IQ/x0tzgJO84VwgjEbssQ2IwyFcdPMm727TADppazOgsb1Nc16MPV4b
         TknK6oyhPTzUA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Greg Ungerer <gerg@kernel.org>,
        Jack Brennen <jbrennen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 7/7] modpost: look up the correct symbol in check_export_symbol()
Date:   Thu,  2 Nov 2023 00:04:04 +0900
Message-Id: <20231101150404.754108-8-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231101150404.754108-1-masahiroy@kernel.org>
References: <20231101150404.754108-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Ungerer reported modpost produced false-positive
"local symbol '...' was exported" errors when m68k-uclinux-gcc is used.

I had assumed ELF_R_SYM(Elf_Rela::r_info) pointed to the exported symbol
itself if it is in the global scope. This assumption worked for many
toolchains, but as it turned out, it was not true for m68k-uclinux-gcc,
at least.

If the 'sym' argument passed to check_export_symbol() is not the
exported symbol, look up the correct one in the symbol table. It incurs
a search cost, but since we know its section index and address, we can
exploit the binary search.

Reported-by: Greg Ungerer <gerg@kernel.org>
Closes: https://lore.kernel.org/all/1fac9d12-2ec2-4ccb-bb81-34f3fc34789e@westnet.com.au/
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 896ecfa8483f..ee67bc6d71ee 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1021,6 +1021,18 @@ static Elf_Sym *find_tosym(struct elf_info *elf, Elf_Addr addr, Elf_Sym *sym)
 				      true, 20);
 }
 
+static Elf_Sym *find_tosym_with_name(struct elf_info *elf, Elf_Addr addr,
+				     Elf_Sym *sym, const char *name)
+{
+	/* If the supplied symbol has the expected name, return it. */
+	if (!strcmp(sym_name(elf, sym), name))
+		return sym;
+
+	/* Look up a symbol with the given name. */
+	return symsearch_find_with_name(elf, addr, get_secindex(elf, sym),
+					true, 20, name);
+}
+
 static bool is_executable_section(struct elf_info *elf, unsigned int secndx)
 {
 	if (secndx >= elf->num_sections)
@@ -1079,7 +1091,7 @@ static void default_mismatch_handler(const char *modname, struct elf_info *elf,
 
 static void check_export_symbol(struct module *mod, struct elf_info *elf,
 				Elf_Addr faddr, const char *secname,
-				Elf_Sym *sym)
+				Elf_Sym *sym, Elf_Addr taddr)
 {
 	static const char *prefix = "__export_symbol_";
 	const char *label_name, *name, *data;
@@ -1096,6 +1108,14 @@ static void check_export_symbol(struct module *mod, struct elf_info *elf,
 		return;
 	}
 
+	name = label_name + strlen(prefix);
+	sym = find_tosym_with_name(elf, taddr, sym, name);
+	if (!sym) {
+		error("%s: could not find the the export symbol '%s'\n",
+		      mod->name, name);
+		return;
+	}
+
 	if (ELF_ST_BIND(sym->st_info) != STB_GLOBAL &&
 	    ELF_ST_BIND(sym->st_info) != STB_WEAK) {
 		error("%s: local symbol '%s' was exported\n", mod->name,
@@ -1103,13 +1123,6 @@ static void check_export_symbol(struct module *mod, struct elf_info *elf,
 		return;
 	}
 
-	name = sym_name(elf, sym);
-	if (strcmp(label_name + strlen(prefix), name)) {
-		error("%s: .export_symbol section references '%s', but it does not seem to be an export symbol\n",
-		      mod->name, name);
-		return;
-	}
-
 	data = sym_get_data(elf, label);	/* license */
 	if (!strcmp(data, "GPL")) {
 		is_gpl = true;
@@ -1156,7 +1169,7 @@ static void check_section_mismatch(struct module *mod, struct elf_info *elf,
 	const struct sectioncheck *mismatch;
 
 	if (module_enabled && elf->export_symbol_secndx == fsecndx) {
-		check_export_symbol(mod, elf, faddr, tosec, sym);
+		check_export_symbol(mod, elf, faddr, tosec, sym, taddr);
 		return;
 	}
 
-- 
2.40.1

