Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F487BC934
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 19:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344122AbjJGRFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 13:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344105AbjJGRFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 13:05:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB12BA;
        Sat,  7 Oct 2023 10:05:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D892FC433CB;
        Sat,  7 Oct 2023 17:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696698301;
        bh=TTLYNPGjyBivwozdoa07Smf/suztpzKvRG2LWS6FNas=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b8HZlTL4Afo59CcwyOtgb4Y93r5LNHEiDZEKyeCjOhuDNWTEokl9GgaNHBDGyQl1m
         k98Volk7bHlMt8cG0kuf/X3YROh35Oz+RhlBeaNSQvs0X0nifaBb4BxkSA5iNpwmTK
         9iW+aoM6iguuZVAIQnuN2KeXyNwMyiaGCWXPNG+Sn/NlT+R4sOQLgIvk6685gIjDdx
         63f1dugnXyAhbGubHI/ZKunvbkiuu32lOajBgwSdiDrzzZilDkZDZybvabEJOA5Rnc
         w/pf5cUTLzYO+89crg7fWJMZBsp5CI260rVEUWjRUaoVlTxz8GdyxUWnty3p5PH4Z6
         uocIjpipmOmtQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 4/5] modpost: refactor check_sec_ref()
Date:   Sun,  8 Oct 2023 02:04:47 +0900
Message-Id: <20231007170448.505487-4-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231007170448.505487-1-masahiroy@kernel.org>
References: <20231007170448.505487-1-masahiroy@kernel.org>
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

We can replace &elf->sechdrs[i] with &sechdrs[i] to slightly shorten
the code because we already have the local variable 'sechdrs'.

However, defining 'sechdr' instead shortens the code further.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
---

 scripts/mod/modpost.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 99476a9695c5..441d57ee3275 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1518,16 +1518,17 @@ static void section_rel(struct module *mod, struct elf_info *elf,
 static void check_sec_ref(struct module *mod, struct elf_info *elf)
 {
 	int i;
-	Elf_Shdr *sechdrs = elf->sechdrs;
 
 	/* Walk through all sections */
 	for (i = 0; i < elf->num_sections; i++) {
-		check_section(mod->name, elf, &elf->sechdrs[i]);
+		Elf_Shdr *sechdr = &elf->sechdrs[i];
+
+		check_section(mod->name, elf, sechdr);
 		/* We want to process only relocation sections and not .init */
-		if (sechdrs[i].sh_type == SHT_RELA)
-			section_rela(mod, elf, &elf->sechdrs[i]);
-		else if (sechdrs[i].sh_type == SHT_REL)
-			section_rel(mod, elf, &elf->sechdrs[i]);
+		if (sechdr->sh_type == SHT_RELA)
+			section_rela(mod, elf, sechdr);
+		else if (sechdr->sh_type == SHT_REL)
+			section_rel(mod, elf, sechdr);
 	}
 }
 
-- 
2.39.2

