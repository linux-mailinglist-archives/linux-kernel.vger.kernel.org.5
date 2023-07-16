Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94DEA754E40
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 12:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjGPKQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 06:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGPKQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 06:16:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A66E46;
        Sun, 16 Jul 2023 03:16:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE5A260C7A;
        Sun, 16 Jul 2023 10:16:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 039A4C433C9;
        Sun, 16 Jul 2023 10:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689502560;
        bh=kZiZwupK7ZTvaNFmw9c7bI3Xs05CRVxQyM0wat98hY8=;
        h=From:To:Cc:Subject:Date:From;
        b=Jnz3Xb5ebL5hyrxDUpKQUIVBc98hhExEcAKUTlazWPnCAykwOiZIfO4ygGOLFhv7p
         x2n5TgzOpy/LtI2zYXI7NqVA/zG7/tnSwYoZ6D8XrSb7BPTeFHrzqVXfd6fZBTz3YO
         MhSPK2JwL4cWdAWszWe/BQJX1oTtllFzXT8iC94MI9tuNQSUiJgqN1U8j+YNE0e2fM
         km7J2o21sYgVxJUkGkfG+e5obh3ScOq6rcV0gLUEo6W3Xsab3vs9itm8I0OIJ9b+i8
         +HoLWTxSgM7sQve0C/4TWVMyRlVp/kmiLLfpMjHm87vHaPaeL0xbp4ImVaCdBk9VYK
         nKUjn82K15BRg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH] linux/export.h: make <linux/export.h> independent of CONFIG_MODULES
Date:   Sun, 16 Jul 2023 19:15:54 +0900
Message-Id: <20230716101554.920701-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
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

Currently, all files with EXPORT_SYMBOL() are rebuilt when CONFIG_MODULES
is flipped due to <linux/export.h> depending on CONFIG_MODULES.

Now that modpost can make a final decision about export symbols,
<linux/export.h> does not need to make EXPORT_SYMBOL() no-op.
Instead, modpost can skip emitting KSYMTAB when CONFIG_MODULES is unset.

This commit will reduce the number of recompilation when CONFIG_MODULES
is toggled.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 include/linux/export.h   | 4 ++--
 scripts/Makefile.modpost | 1 +
 scripts/mod/modpost.c    | 8 ++++++--
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/linux/export.h b/include/linux/export.h
index beed8387e0a4..9911508a9604 100644
--- a/include/linux/export.h
+++ b/include/linux/export.h
@@ -50,7 +50,7 @@ extern struct module __this_module;
 		__EXPORT_SYMBOL_REF(sym)	ASM_NL	\
 	.previous
 
-#if !defined(CONFIG_MODULES) || defined(__DISABLE_EXPORTS)
+#if defined(__DISABLE_EXPORTS)
 
 /*
  * Allow symbol exports to be disabled completely so that C code may
@@ -75,7 +75,7 @@ extern struct module __this_module;
 	__ADDRESSABLE(sym)					\
 	asm(__stringify(___EXPORT_SYMBOL(sym, license, ns)))
 
-#endif /* CONFIG_MODULES */
+#endif
 
 #ifdef DEFAULT_SYMBOL_NAMESPACE
 #define _EXPORT_SYMBOL(sym, license)	__EXPORT_SYMBOL(sym, license, __stringify(DEFAULT_SYMBOL_NAMESPACE))
diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index 39472e834b63..739402f45509 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -41,6 +41,7 @@ include $(srctree)/scripts/Kbuild.include
 MODPOST = scripts/mod/modpost
 
 modpost-args =										\
+	$(if $(CONFIG_MODULES),-M)							\
 	$(if $(CONFIG_MODVERSIONS),-m)							\
 	$(if $(CONFIG_MODULE_SRCVERSION_ALL),-a)					\
 	$(if $(CONFIG_SECTION_MISMATCH_WARN_ONLY),,-E)					\
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index b29b29707f10..8227641dd087 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -24,6 +24,7 @@
 #include "../../include/linux/license.h"
 #include "../../include/linux/module_symbol.h"
 
+static bool module_enabled;
 /* Are we using CONFIG_MODVERSIONS? */
 static bool modversions;
 /* Is CONFIG_MODULE_SRCVERSION_ALL set? */
@@ -1242,7 +1243,7 @@ static void check_section_mismatch(struct module *mod, struct elf_info *elf,
 	const char *tosec = sec_name(elf, get_secindex(elf, sym));
 	const struct sectioncheck *mismatch;
 
-	if (elf->export_symbol_secndx == fsecndx) {
+	if (module_enabled && elf->export_symbol_secndx == fsecndx) {
 		check_export_symbol(mod, elf, faddr, tosec, sym);
 		return;
 	}
@@ -2272,7 +2273,7 @@ int main(int argc, char **argv)
 	LIST_HEAD(dump_lists);
 	struct dump_list *dl, *dl2;
 
-	while ((opt = getopt(argc, argv, "ei:mnT:to:au:WwENd:")) != -1) {
+	while ((opt = getopt(argc, argv, "ei:MmnT:to:au:WwENd:")) != -1) {
 		switch (opt) {
 		case 'e':
 			external_module = true;
@@ -2282,6 +2283,9 @@ int main(int argc, char **argv)
 			dl->file = optarg;
 			list_add_tail(&dl->list, &dump_lists);
 			break;
+		case 'M':
+			module_enabled = true;
+			break;
 		case 'm':
 			modversions = true;
 			break;
-- 
2.39.2

