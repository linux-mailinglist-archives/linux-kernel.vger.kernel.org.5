Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9087F4A72
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 16:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235194AbjKVPdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 10:33:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344420AbjKVPdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 10:33:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DC7D66;
        Wed, 22 Nov 2023 07:32:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90940C433C8;
        Wed, 22 Nov 2023 15:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700667168;
        bh=fWiSFMfDLokE0fHpF4fY2qrcsRxAWpAbxo0BBd3jFug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bi4xC82UvOxmgWDSddxzp+EZzsxihguuFoKXKYYw+Yr/iI8oxUNDaekSuwfNXmZdD
         gqb/0AjGTrRRTwr2ixtT45nG7LfpEPbnuOdwD/33C4SA/NpoIOIKZdoGpuqc5Duy35
         u5MfaZqzAh9pqa8HEgw+7OpTwitCRBmYDLkoSAyG6Ziz5kgTMvaj3GuXBpqEJZ1bQx
         NMdXunVfPA6pFVKCNOAz2Afaehz5Ks2G2l64v01LUop4QrVxIcuR5FJaSRfC7dOYZJ
         Uc0h86kTCUrsG3vr4Sb6jC+hC9vF/G5opttEvmHJ1xWzncvsbBmLLt+c3SjYey6fHa
         CQ9r8VWdLZVlw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sasha Levin <sashal@kernel.org>, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        linux-kbuild@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 11/17] modpost: fix section mismatch message for RELA
Date:   Wed, 22 Nov 2023 10:31:40 -0500
Message-ID: <20231122153212.852040-11-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122153212.852040-1-sashal@kernel.org>
References: <20231122153212.852040-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.2
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <masahiroy@kernel.org>

[ Upstream commit 1c4a7587d1bbee0fd53b63af60e4244a62775f57 ]

The section mismatch check prints a bogus symbol name on some
architectures.

[test code]

  #include <linux/init.h>

  int __initdata foo;
  int get_foo(void) { return foo; }

If you compile it with GCC for riscv or loongarch, modpost will show an
incorrect symbol name:

  WARNING: modpost: vmlinux: section mismatch in reference: get_foo+0x8 (section: .text) -> done (section: .init.data)

To get the correct symbol address, the st_value must be added.

This issue has never been noticed since commit 93684d3b8062 ("kbuild:
include symbol names in section mismatch warnings") presumably because
st_value becomes zero on most architectures when the referenced symbol
is looked up. It is not true for riscv or loongarch, at least.

With this fix, modpost will show the correct symbol name:

  WARNING: modpost: vmlinux: section mismatch in reference: get_foo+0x8 (section: .text) -> foo (section: .init.data)

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/mod/modpost.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index b3dee80497cb2..ac4ef3e206bbd 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1496,13 +1496,15 @@ static void section_rela(struct module *mod, struct elf_info *elf,
 		return;
 
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
@@ -1517,7 +1519,7 @@ static void section_rela(struct module *mod, struct elf_info *elf,
 			break;
 		}
 
-		check_section_mismatch(mod, elf, elf->symtab_start + r_sym,
+		check_section_mismatch(mod, elf, tsym,
 				       fsecndx, fromsec, r_offset, taddr);
 	}
 }
-- 
2.42.0

