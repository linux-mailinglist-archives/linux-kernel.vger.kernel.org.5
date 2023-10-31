Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38CA37DD511
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 18:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376392AbjJaRqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 13:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376372AbjJaRqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 13:46:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3968EDA;
        Tue, 31 Oct 2023 10:46:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A0AFC433C8;
        Tue, 31 Oct 2023 17:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698774392;
        bh=4IzIyIgoH1lhjy2rL7R+B3ys+T2C5XdwhNqqqjhol4E=;
        h=From:To:Cc:Subject:Date:From;
        b=iZzl3i4u3Z4lHJziJsiFVp5CwjwRspRy/Sn6vpFB+jZ1C6Y3IZKIMT0lu8bY/i68v
         ttEgti0JQn33NvLIaRZZmxZcXakyseqtAJl+aOMbKjipWvIx9SuwF0rDROuRJLGa94
         IECn7mdOuW4SbNsQdlr3hDYkcLgbxybb6fITn+CQ0epFyuWBJTtY0TyiO7skwSzaC7
         2UwIFVeVYPU096QD4cjtdjY6XbOvTJNIuuy3K3E54BB7vKPXev7+lYlWnylZ8Iur02
         d0gCSEL7LvdChiSs9S3Qi7gibTd2Nblxp+BG8aDtJsiMl6bZH3qjsfO+9gXYzaldhf
         SkdMlijOmtqXQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org
Subject: [PATCH] modpost: fix section mismatch message for RELA
Date:   Wed,  1 Nov 2023 02:46:27 +0900
Message-Id: <20231031174627.684576-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The section mismatch check prints a bogus symbol name on some
architectures.

[test code]

  #include <linux/init.h>

  int __initdata foo;
  int get_foo(void) { return foo; }

If you compile it with GCC for riscv or loongarch, modpost will show an
incorrect symbol name:

  WARNING: modpost: vmlinux: section mismatch in reference: get_foo+0x8 (section: .text) -> done (section: .init.data)

To get the correct symbol address, st_value must be added

This issue has never been noticed since commit 93684d3b8062 ("kbuild:
include symbol names in section mismatch warnings") presumably because
st_value becomes zero on most architectures when the referenced symbol
is looked up. It is not true for riscv or loongarch, at least.

With this fix, modpost will show the correct symbol name:

  WARNING: modpost: vmlinux: section mismatch in reference: get_foo+0x8 (section: .text) -> foo (section: .init.data)

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 973b5e5ae2dd..cb6406f485a9 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1383,13 +1383,15 @@ static void section_rela(struct module *mod, struct elf_info *elf,
 	const Elf_Rela *rela;
 
 	for (rela = start; rela < stop; rela++) {
+		Elf_Sym *tsym;
 		Elf_Addr taddr, r_offset;
 		unsigned int r_type, r_sym;
 
 		r_offset = TO_NATIVE(rela->r_offset);
 		get_rel_type_and_sym(elf, rela->r_info, &r_type, &r_sym);
 
-		taddr = TO_NATIVE(rela->r_addend);
+		tsym = elf->symtab_start + r_sym;
+		taddr = tsym->st_value + TO_NATIVE(rela->r_addend);
 
 		switch (elf->hdr->e_machine) {
 		case EM_RISCV:
@@ -1404,7 +1406,7 @@ static void section_rela(struct module *mod, struct elf_info *elf,
 			break;
 		}
 
-		check_section_mismatch(mod, elf, elf->symtab_start + r_sym,
+		check_section_mismatch(mod, elf, tsym,
 				       fsecndx, fromsec, r_offset, taddr);
 	}
 }
-- 
2.40.1

