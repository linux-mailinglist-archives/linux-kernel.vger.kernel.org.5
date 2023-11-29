Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C52A77FD784
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 14:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233845AbjK2NHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 08:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233384AbjK2NHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 08:07:03 -0500
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F38C610DA
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 05:07:08 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Cxrut7N2dlcqc9AA--.54171S3;
        Wed, 29 Nov 2023 21:07:07 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Axzy91N2dlVtNPAA--.45987S8;
        Wed, 29 Nov 2023 21:07:07 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v5 6/8] objtool: Check local label in add_dead_ends()
Date:   Wed, 29 Nov 2023 21:06:59 +0800
Message-ID: <20231129130701.27744-7-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231129130701.27744-1-yangtiezhu@loongson.cn>
References: <20231129130701.27744-1-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Axzy91N2dlVtNPAA--.45987S8
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxWryUXry8JF1rCw47Gr1fKrX_yoWrXry8pF
        43C343Kr42vr13Zw47tFyxWasxWws7WFnrJ3y7GF1rAry2van0gw12yw15Zas8Gr12vw45
        XayYgay3uryDAwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUU9Fb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
        AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
        tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
        AKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
        6r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
        CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF
        0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
        AIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
        KfnxnUUI43ZEXa7IU8XyCJUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When update the latest upstream gcc and binutils which enables linker
relaxation by default, it generates more objtool warnings on LoongArch,
like this:

  init/main.o: warning: objtool: unexpected relocation symbol type in .rela.discard.unreachable

We can see that the reloc sym name is local label instead of section
in relocation section '.rela.discard.unreachable', in this case, the
reloc sym type is STT_NOTYPE instead of STT_SECTION. Let us check it
to not return -1, then use reloc->sym->offset instead of reloc addend
which is 0 to find the corresponding instruction. At the same time,
replace the variable "addend" with "offset" to reflect the reality.

Here are some detailed info:
[fedora@linux 6.7.test]$ gcc --version
gcc (GCC) 14.0.0 20231127 (experimental)
[fedora@linux 6.7.test]$ as --version
GNU assembler (GNU Binutils) 2.41.50.20231127
[fedora@linux 6.7.test]$ readelf -r init/main.o | grep -A 2 "rela.discard.unreachable"
Relocation section '.rela.discard.unreachable' at offset 0x4b58 contains 1 entry:
  Offset          Info           Type           Sym. Value    Sym. Name + Addend
000000000000  00de00000063 R_LARCH_32_PCREL  0000000000000220 .L467^B1 + 0

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/objtool/check.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 29b3c5495901..395fce41fb81 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -611,7 +611,7 @@ static int add_dead_ends(struct objtool_file *file)
 	struct section *rsec;
 	struct reloc *reloc;
 	struct instruction *insn;
-	s64 addend;
+	unsigned long offset;
 
 	/*
 	 * Check for manually annotated dead ends.
@@ -622,26 +622,28 @@ static int add_dead_ends(struct objtool_file *file)
 
 	for_each_reloc(rsec, reloc) {
 
-		if (reloc->sym->type != STT_SECTION) {
+		if (reloc->sym->type == STT_SECTION) {
+			offset = reloc_addend(reloc);
+		} else if (reloc->sym->local_label) {
+			offset = reloc->sym->offset;
+		} else {
 			WARN("unexpected relocation symbol type in %s", rsec->name);
 			return -1;
 		}
 
-		addend = reloc_addend(reloc);
-
-		insn = find_insn(file, reloc->sym->sec, addend);
+		insn = find_insn(file, reloc->sym->sec, offset);
 		if (insn)
 			insn = prev_insn_same_sec(file, insn);
-		else if (addend == reloc->sym->sec->sh.sh_size) {
+		else if (offset == reloc->sym->sec->sh.sh_size) {
 			insn = find_last_insn(file, reloc->sym->sec);
 			if (!insn) {
 				WARN("can't find unreachable insn at %s+0x%" PRIx64,
-				     reloc->sym->sec->name, addend);
+				     reloc->sym->sec->name, offset);
 				return -1;
 			}
 		} else {
 			WARN("can't find unreachable insn at %s+0x%" PRIx64,
-			     reloc->sym->sec->name, addend);
+			     reloc->sym->sec->name, offset);
 			return -1;
 		}
 
@@ -661,26 +663,28 @@ static int add_dead_ends(struct objtool_file *file)
 
 	for_each_reloc(rsec, reloc) {
 
-		if (reloc->sym->type != STT_SECTION) {
+		if (reloc->sym->type == STT_SECTION) {
+			offset = reloc_addend(reloc);
+		} else if (reloc->sym->local_label) {
+			offset = reloc->sym->offset;
+		} else {
 			WARN("unexpected relocation symbol type in %s", rsec->name);
 			return -1;
 		}
 
-		addend = reloc_addend(reloc);
-
-		insn = find_insn(file, reloc->sym->sec, addend);
+		insn = find_insn(file, reloc->sym->sec, offset);
 		if (insn)
 			insn = prev_insn_same_sec(file, insn);
-		else if (addend == reloc->sym->sec->sh.sh_size) {
+		else if (offset == reloc->sym->sec->sh.sh_size) {
 			insn = find_last_insn(file, reloc->sym->sec);
 			if (!insn) {
 				WARN("can't find reachable insn at %s+0x%" PRIx64,
-				     reloc->sym->sec->name, addend);
+				     reloc->sym->sec->name, offset);
 				return -1;
 			}
 		} else {
 			WARN("can't find reachable insn at %s+0x%" PRIx64,
-			     reloc->sym->sec->name, addend);
+			     reloc->sym->sec->name, offset);
 			return -1;
 		}
 
-- 
2.42.0

