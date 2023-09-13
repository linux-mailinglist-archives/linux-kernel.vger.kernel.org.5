Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEC479E890
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 15:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236506AbjIMNFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 09:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbjIMNFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 09:05:49 -0400
Received: from fallback1.i.mail.ru (fallback1.i.mail.ru [79.137.243.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DB219B1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 06:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
        h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=Ze2HLH0McyPAQtzxrEV2xQ2lpvFWukdJRa2lQ2zD8g8=;
        t=1694610345;x=1694700345; 
        b=sNNWeLOxDjbVG4/LciuIg1/ovc05cyBpXi9yyhJNKGtqGADnyC+Z0VxIcbgkv9gRXw4hFdELxZ2Tpewp5NzzC7x+bjJiGLI8gapiGnPx2F6roC4unpHCUCbRn4H2BoU8XzYXdnuQipRveSWhBXMJCscy0uDFcM+M/MGxb7SKYonszREV2SaASllUhyBrqPSHZNooXfUGPsx0XFrq1Vhbqb0T1vRjG7qU0zO1YWsG6rnvSj7+UJp5BbS3SEEWVG/ABU+D/8Qd9dCVxhlG2HGlPnyNsus0oaW6swK2MyFtXPRTd5bRzvoP0XDe0NsiMECieF63avd+man1s9Vdev4NUQ==;
Received: from [10.161.55.49] (port=53716 helo=smtpng1.i.mail.ru)
        by fallback1.i.mail.ru with esmtp (envelope-from <fido_max@inbox.ru>)
        id 1qgPYs-002ytB-Vk
        for linux-kernel@vger.kernel.org; Wed, 13 Sep 2023 16:05:43 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
        h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=Ze2HLH0McyPAQtzxrEV2xQ2lpvFWukdJRa2lQ2zD8g8=;
        t=1694610342;x=1694700342; 
        b=t33IAmTtCCREItGH02cc5RcOzhA6rdz4fTQaXMYxG+/ClvigFXsMK192ViKHA+IITUL+W2Imnt5cnPjp2221EHp/OXDOW7VPkuFdzrey50lxGzea7XgJlYKpzPzUjiTUByaYPhqMwB9mV/J/ASJL8gXpWGvTTk4eu7NVc53BwDiXksx/BB86GuZvji8kE/VjiTTCHe7JnW+4nx/fMv0f9sJO7m/ITSHfV8IGjK18XBZG+pu5ersSoFEciz0b+4tGNZnjqXiyzlVsOp37Ji6pC4CizZkdqieIk8FD3lCr8LH9Z4UzA+yEbrVgfUUlPJycECdKoWuFHmXZ5Esq62NeyQ==;
Received: by smtpng1.m.smailru.net with esmtpa (envelope-from <fido_max@inbox.ru>)
        id 1qgPYg-0004Cg-1M; Wed, 13 Sep 2023 16:05:30 +0300
From:   Maxim Kochetkov <fido_max@inbox.ru>
To:     linux-riscv@lists.infradead.org
Cc:     bigunclemax@gmail.com, Maxim Kochetkov <fido_max@inbox.ru>,
        Amma Lee <lixiaoyun@binary-semi.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/1] riscv: optimize ELF relocation function in riscv
Date:   Wed, 13 Sep 2023 16:05:00 +0300
Message-Id: <20230913130501.287250-1-fido_max@inbox.ru>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: 78E4E2B564C1792B
X-77F55803: 4F1203BC0FB41BD99D78F05E8BF27CBF9A71B2B0462BB11C7FF8B24A7F846C90CD62213F67905E7AEB44CC49BA0AD1A148ACA0D27BB484D13064A4F6BB014158C7997A56A7FEE5D2
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE79145AB6E9E75F07EEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637F1FEB73A813C0D3B8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8A172BA9220CBCB66ECDBDFEB62D220106F9789CCF6C18C3F8528715B7D10C86878DA827A17800CE764603B5C71CE8B8F9FA2833FD35BB23D9E625A9149C048EE26055571C92BF10FE5D25F19253116ADD2E47CDBA5A96583BD4B6F7A4D31EC0BC014FD901B82EE079FA2833FD35BB23D27C277FBC8AE2E8BB37B5D51F58B3735A471835C12D1D977C4224003CC8364762BB6847A3DEAEFB0F43C7A68FF6260569E8FC8737B5C2249EC8D19AE6D49635B68655334FD4449CB9ECD01F8117BC8BEAAAE862A0553A39223F8577A6DFFEA7CB24F08513AFFAC7943847C11F186F3C59DAA53EE0834AAEE
X-C1DE0DAB: 0D63561A33F958A5DBBF4889FAC29140EE6C9CAC128E017D39C64B3C927172EAF87CCE6106E1FC07E67D4AC08A07B9B0A816C540FC8EEC309C5DF10A05D560A950611B66E3DA6D700B0A020F03D25A0997E3FB2386030E77
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFB7389970A08FF33031E888EDC541B151029ADF5AFE66CA857F64BE21F1C5D82A6F890FCD3CEE011BC4B8F2E8CFB8F571CFE287C1F091E157888B94C7A16045B6A866A4CE178307D84C41F94D744909CEE921556F0E976A29E6EC0772259F8F8F8815B87D7EC76CB9
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojoMTWofjSWSTVKYnPE1xbPQ==
X-Mailru-Sender: 689FA8AB762F73930F533AC2B33E986B9097C609C9355DA084D41582C6E7A30C98CC072019C18A892CA7F8C7C9492E1F2F5E575105D0B01ADBE2EF17B331888EEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B48C57FD6B8CC3B424B47D1AD8D31E4A999FB5C61317AC3EFD049FFFDB7839CE9EA21101AE4D7A6B824EC50C663D7087FF6C1477E29A2DD650D1E13914AAD48563
X-7FA49CB5: 0D63561A33F958A5BB2F4E76C254BE82A52F8CCC6834DC19003398D44B157586CACD7DF95DA8FC8BD5E8D9A59859A8B6A096F61ED9298604
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5xhPKz0ZEsZ5k6NOOPWz5QAiZSCXKGQRq3/7KxbCLSB2ESzQkaOXqCBFZPLWFrEGlV1shfWe2EVcxl5toh0c/aCGOghz/frdRhzMe95NxDFdaloFI76w+pL3AWq+uy+JQA==
X-Mailru-MI: C000000000000800
X-Mras: Ok
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
---
Changes in v4:
- use 'while' loop instead of 'for' loop to avoid code duplicate
---
 arch/riscv/kernel/module.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
index 7c651d55fcbd..8c9b644ebfdb 100644
--- a/arch/riscv/kernel/module.c
+++ b/arch/riscv/kernel/module.c
@@ -346,6 +346,7 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
 	Elf_Sym *sym;
 	u32 *location;
 	unsigned int i, type;
+	unsigned int j_idx = 0;
 	Elf_Addr v;
 	int res;
 
@@ -384,9 +385,10 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
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
@@ -415,16 +417,26 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
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
 
 		res = handler(me, location, v);
-- 
2.40.1

