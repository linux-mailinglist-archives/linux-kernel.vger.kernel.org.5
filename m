Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7D57D0673
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 04:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346875AbjJTC1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 22:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346847AbjJTC1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 22:27:12 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 90ADD130
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 19:27:08 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Cx5_F75TFlR18zAA--.33877S3;
        Fri, 20 Oct 2023 10:27:07 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxP9115TFl7r4rAA--.28791S8;
        Fri, 20 Oct 2023 10:27:06 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
Subject: [PATCH v3 6/8] objtool: Check local label in add_dead_ends()
Date:   Fri, 20 Oct 2023 10:26:59 +0800
Message-Id: <1697768821-22931-7-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1697768821-22931-1-git-send-email-yangtiezhu@loongson.cn>
References: <1697768821-22931-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf8CxP9115TFl7r4rAA--.28791S8
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxWryUXryUtryDKF1DCw48GrX_yoWrWr15pF
        43C343Kr42yr13Zw47tF1kWasxWw4kGFnrJ39rKF1rAryIvanxKw1ayw15uas8Wr12vw45
        Xay5Kay3uryDA3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1a6r1DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
        AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
        tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
        AKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
        6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
        xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
        jxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
        0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
        67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1mii3UUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
[fedora@linux 6.6.test]$ gcc --version
gcc (GCC) 14.0.0 20231009 (experimental)
[fedora@linux 6.6.test]$ as --version
GNU assembler (GNU Binutils) 2.41.50.20231009
[fedora@linux 6.6.test]$ readelf -r init/main.o | grep -A 2 "rela.discard.unreachable"
Relocation section '.rela.discard.unreachable' at offset 0x4b70 contains 1 entry:
  Offset          Info           Type           Sym. Value    Sym. Name + Addend
000000000000  00de00000063 R_LARCH_32_PCREL  0000000000000228 .L466^B1 + 0

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/objtool/check.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index a9cb224..eee5621 100644
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
@@ -622,26 +622,29 @@ static int add_dead_ends(struct objtool_file *file)
 
 	for_each_reloc(rsec, reloc) {
 
-		if (reloc->sym->type != STT_SECTION) {
+		if (reloc->sym->type == STT_SECTION) {
+			offset = reloc_addend(reloc);
+		} else if ((reloc->sym->type == STT_NOTYPE) &&
+			    strncmp(reloc->sym->name, ".L", 2) == 0) {
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
 
@@ -661,26 +664,29 @@ static int add_dead_ends(struct objtool_file *file)
 
 	for_each_reloc(rsec, reloc) {
 
-		if (reloc->sym->type != STT_SECTION) {
+		if (reloc->sym->type == STT_SECTION) {
+			offset = reloc_addend(reloc);
+		} else if ((reloc->sym->type == STT_NOTYPE) &&
+			    strncmp(reloc->sym->name, ".L", 2) == 0) {
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
2.1.0

