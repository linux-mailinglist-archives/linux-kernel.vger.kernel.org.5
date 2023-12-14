Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43DC4812981
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 08:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235486AbjLNHhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 02:37:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjLNHhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 02:37:41 -0500
X-Greylist: delayed 3491 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 13 Dec 2023 23:37:46 PST
Received: from fallback20.i.mail.ru (fallback20.i.mail.ru [79.137.243.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3418EA0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 23:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
        h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=MUmKhkzD6Lqw/sRqo4MpOesl2qfmIn0n56k8Dpw1hBc=;
        t=1702539466;x=1702629466; 
        b=qA8IR23UGi4k39sFZ69siviiFi6wU8lrSWCadDbUf9m2j/K1fLKOerr4r51wA/iz7ML3vu+kVwrm9ScIc8tl6K+Zm2v27u2X/b1tvd0ZoKiVtpG8XASOK0Jq1aIuHOEPmix6kpc6FI0lTWI9tvLxbHc1IKwvZ6pa+7M3Wj3b2o6hRPrk5kAEgqIsu/oXxIXEFAm+RkBwbRxpu24uxBVSolW56ImKdyZSmeSEZGuBZOArEwcPXwMINFwsGoBAQu9h9nyf+2XNskC8R0T5Jvga6w1XgUNIv2QL7pW8sOZ9tpMN9V3xHWXUwDOwyueJx2WI8K8eSeiF/R8y13BY6vK1Ug==;
Received: from [10.12.4.1] (port=59058 helo=smtp3.i.mail.ru)
        by fallback20.i.mail.ru with esmtp (envelope-from <fido_max@inbox.ru>)
        id 1rDfNc-000VmM-UQ
        for linux-kernel@vger.kernel.org; Thu, 14 Dec 2023 09:39:33 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru;
        s=mail4; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:
        To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
        X-Cloud-Ids:Disposition-Notification-To;
        bh=MUmKhkzD6Lqw/sRqo4MpOesl2qfmIn0n56k8Dpw1hBc=; t=1702535972; x=1702625972; 
        b=Eyg1D/AN0/7jBvTnwj7Gpc9S+He4t+G8fm6jVdVRjjoZSsB98HwKulPG6FOBDKCtBnASWrk+Eso
        hlRsH47XtZ7usi/hAggSyD5InNW/HsAHYhFAXUY/JbTv/4w70t9WXBr+t9h4BbBLxKYlnnYBUvSxt
        xEbjA4N/wPQW22Q47qTVhH70sflrpXJaGt5pIsRauu4KSSN0Bt0w6fRrDAL+hm5Pj2r3m4ZDVxJ1a
        P5b7y4bEd3IXTQjcGw5wnL9QaYhCUuKNzp/+fv8ci7J9L1rV4PGqWP4nZ5ovjr59kYuTCexyzJDDu
        tkBylX22vQTDrYLKitPyex5mYoya5l3JGM4w==;
Received: by smtp3.i.mail.ru with esmtpa (envelope-from <fido_max@inbox.ru>)
        id 1rDfNN-009naG-1j; Thu, 14 Dec 2023 09:39:18 +0300
From:   Maxim Kochetkov <fido_max@inbox.ru>
To:     linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, charlie@rivosinc.com,
        ajones@ventanamicro.com, conor.dooley@microchip.com,
        jszhang@kernel.org, kernel@esmil.dk,
        Maxim Kochetkov <fido_max@inbox.ru>,
        Amma Lee <lixiaoyun@binary-semi.com>
Subject: [PATCH v5 1/1] riscv: optimize ELF relocation function in riscv
Date:   Thu, 14 Dec 2023 09:39:06 +0300
Message-Id: <20231214063906.13612-1-fido_max@inbox.ru>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD97533543916A0F71AD286D97BFFE3DA5DB7E67E5414E74A44CD62213F67905E7A9584602B0A0B67F79DAC4348BB0AD5402F1DF3D5CE2C97D047EEACAE9851930B
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE70A10A23A3B64B805EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006378B67D2947F927BCB8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D89139C7D2CD1B56E1D787F01A6F3A20516F9789CCF6C18C3F8528715B7D10C86878DA827A17800CE764603B5C71CE8B8F9FA2833FD35BB23D9E625A9149C048EEB1593CA6EC85F86DF6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F79006370BDD70ABAC747F53389733CBF5DBD5E9B5C8C57E37DE458B9E9CE733340B9D5F3BBE47FD9DD3FB595F5C1EE8F4F765FC8C7ADC89C2F0B2A5E2021AF6380DFAD18AA50765F790063735872C767BF85DA227C277FBC8AE2E8BB07C9E286C61B7F975ECD9A6C639B01B4E70A05D1297E1BBCB5012B2E24CD356
X-C1DE0DAB: 0D63561A33F958A5D0916945B0B188A8508253F83738EB50E009ED81786A57A7F87CCE6106E1FC07E67D4AC08A07B9B062B3BD3CC35DA5889C5DF10A05D560A950611B66E3DA6D700B0A020F03D25A0997E3FB2386030E77
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF8C7B53F24711718A4D14E3609780158DF677858F0EEB1B3502793B85883C3870E547CA128C9EF43861E41F2809366B3878243DF2BCB178E1BE19B5793D4E595721BEC6C0C71ED4F84C41F94D744909CEE921556F0E976A29E6EC0772259F8F8F8815B87D7EC76CB9
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojtsCAqtdyux0lKPxRzspCxg==
X-Mailru-Sender: 689FA8AB762F7393590D8C940224AE339267D7193F259203476718A195E4972498CC072019C18A892CA7F8C7C9492E1F2F5E575105D0B01ADBE2EF17B331888EEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
X-7564579A: B8F34718100C35BD
X-77F55803: 6242723A09DB00B4504CF8691E74CC1EE045C20511AAF4EE20659E52C60CB635049FFFDB7839CE9E27692693F3A214146632D4FDD6EF8EF520C337D8FF41615A053D9B0B9A65156E
X-7FA49CB5: 0D63561A33F958A5FE572B1DBC45F354BD1E1CE930F8FC0E293031C103444D49CACD7DF95DA8FC8BD5E8D9A59859A8B6D1AAE889B2A4D82D
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5xhPKz0ZEsZ5k6NOOPWz5QAiZSCXKGQRq3/7KxbCLSB2ESzQkaOXqCBFZPLWFrEGlV1shfWe2EVcxl5toh0c/aCGOghz/frdRhzMe95NxDFdfQ7/oSSXYuSsOysMKPXHPQ==
X-Mailru-MI: C000000000000800
X-Mras: Ok
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch can optimize the running times of insmod command by modify ELF
relocation function.
In the 5.10 and latest kernel, when install the riscv ELF drivers which
contains multiple symbol table items to be relocated, kernel takes a lot
of time to execute the relocation. For example, we install a 3+MB driver
need 180+s.
We focus on the riscv architecture handle R_RISCV_HI20 and R_RISCV_LO20
type items relocation function in the arch\riscv\kernel\module.c and
find that there are two-loops in the function. If we modify the begin
number in the second for-loops iteration, we could save significant time
for installation. We install the same 3+MB driver could just need 2s.

Signed-off-by: Amma Lee <lixiaoyun@binary-semi.com>
Signed-off-by: Maxim Kochetkov <fido_max@inbox.ru>
Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
---
Changes in v5:
- rebase onto latest linux-next

Changes in v4:
- use 'while' loop instead of 'for' loop to avoid code duplicate
---
 arch/riscv/kernel/module.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
index aac019ed63b1..a8a01df1cc17 100644
--- a/arch/riscv/kernel/module.c
+++ b/arch/riscv/kernel/module.c
@@ -779,6 +779,7 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
 	Elf_Sym *sym;
 	void *location;
 	unsigned int i, type;
+	unsigned int j_idx = 0;
 	Elf_Addr v;
 	int res;
 	unsigned int num_relocations = sechdrs[relsec].sh_size / sizeof(*rel);
@@ -829,9 +830,10 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
 		v = sym->st_value + rel[i].r_addend;
 
 		if (type == R_RISCV_PCREL_LO12_I || type == R_RISCV_PCREL_LO12_S) {
-			unsigned int j;
+			unsigned int j = j_idx;
+			bool found = false;
 
-			for (j = 0; j < sechdrs[relsec].sh_size / sizeof(*rel); j++) {
+			do {
 				unsigned long hi20_loc =
 					sechdrs[sechdrs[relsec].sh_info].sh_addr
 					+ rel[j].r_offset;
@@ -860,16 +862,26 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
 					hi20 = (offset + 0x800) & 0xfffff000;
 					lo12 = offset - hi20;
 					v = lo12;
+					found = true;
 
 					break;
 				}
-			}
-			if (j == sechdrs[relsec].sh_size / sizeof(*rel)) {
+
+				j++;
+				if (j > sechdrs[relsec].sh_size / sizeof(*rel))
+					j = 0;
+
+			} while (j_idx != j);
+
+			if (!found) {
 				pr_err(
 				  "%s: Can not find HI20 relocation information\n",
 				  me->name);
 				return -EINVAL;
 			}
+
+			/* Record the previous j-loop end index */
+			j_idx = j;
 		}
 
 		if (reloc_handlers[type].accumulate_handler)
-- 
2.40.1

