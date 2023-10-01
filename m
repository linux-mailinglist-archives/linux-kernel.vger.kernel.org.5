Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1DAD7B4571
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 07:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234313AbjJAFrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 01:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjJAFro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 01:47:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C332BC6;
        Sat, 30 Sep 2023 22:47:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD3EC433C7;
        Sun,  1 Oct 2023 05:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696139262;
        bh=wpvIGU5VRh0aLzts3nR6Eb0HVzCKCwV3FII71xUcIno=;
        h=From:To:Cc:Subject:Date:From;
        b=eVz10E99d6u3N/nZRwcX3d1OsgJPODBYCZq4MeF7hBgMYYPXVgqWTCtqgguXgeGME
         2GYu/bgt2hoEWjIm/iPVD1xK0E62jCL/eCYW+JHWPUeLPKdE4hlSQycih4P+TSmiwx
         wX8sKV4Eke6EEBiXWbaOz9ccGCvHI4vnaS6NDdpMlP7ZmpOd2kwUvZTOXoTattXVNk
         S6HTYuOVNtbJS9SLzijp9qhfMSuSA9SX7qwv7ShRKGiYnSe20fKhACJH6rAdY3PTah
         MiiUCUs2fnrBm2hP/RqAFcrRBJr/KV/RKbY/UpbDz4SjB0i/9GeYKIAw8qfzyxiGaV
         QFjAt6xXE3iIA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 1/2] modpost: refactor check_sec_ref()
Date:   Sun,  1 Oct 2023 14:47:35 +0900
Message-Id: <20231001054736.1586001-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
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
---

 scripts/mod/modpost.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 2f3b0fe6f68d..15d78fe152ac 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1523,16 +1523,17 @@ static void section_rel(struct module *mod, struct elf_info *elf,
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

