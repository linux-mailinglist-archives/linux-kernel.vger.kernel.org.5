Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2D5760CC4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 10:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbjGYIPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 04:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbjGYIPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 04:15:22 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 827DAE57
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 01:15:20 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8AxueqUhL9kCqQJAA--.14527S3;
        Tue, 25 Jul 2023 16:15:16 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxLCOOhL9kAFg6AA--.7611S7;
        Tue, 25 Jul 2023 16:15:15 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
Subject: [PATCH v1 5/6] objtool: Add skipped member in struct reloc
Date:   Tue, 25 Jul 2023 16:15:09 +0800
Message-Id: <1690272910-11869-6-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1690272910-11869-1-git-send-email-yangtiezhu@loongson.cn>
References: <1690272910-11869-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf8CxLCOOhL9kAFg6AA--.7611S7
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxCFWxZFy3tw13Aw1rXrW3twc_yoW5tr4kpF
        4DG3y7KFW8Xr17Gw12qF4UC3y5W3sruFyxJrWUAry0krnrXrn8Jw4ayr1jyFyUWr4YgFW5
        XFyYg34Utr1qvwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
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
        67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0epB3UUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There exist multiple relocation types in one location, such as a pair of
R_LARCH_ADD32 and R_LARCH_SUB32 in section .rela.discard.unreachable and
.rela.discard.reachable on LoongArch.

Here is an example:

$ readelf -rW init/main.o

Relocation section '.rela.discard.unreachable' at offset 0x3e20 contains 2 entries:
    Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
0000000000000000  0000000a00000032 R_LARCH_ADD32          0000000000000000 .init.text + 230
0000000000000000  0000001a00000037 R_LARCH_SUB32          0000000000000000 L0^A + 0

Relocation section '.rela.discard.reachable' at offset 0x4a00 contains 6 entries:
    Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
0000000000000000  0000000a00000032 R_LARCH_ADD32          0000000000000000 .init.text + ae0
0000000000000000  0000002800000037 R_LARCH_SUB32          0000000000000000 L0^A + 0
0000000000000004  0000000a00000032 R_LARCH_ADD32          0000000000000000 .init.text + b88
0000000000000004  0000002b00000037 R_LARCH_SUB32          0000000000000004 L0^A + 0
0000000000000008  0000000200000032 R_LARCH_ADD32          0000000000000000 .text + 23c
0000000000000008  0000002e00000037 R_LARCH_SUB32          0000000000000008 L0^A + 0

In order to silence the related objtool warnings, add skipped member
in struct reloc to record and skip the latter relocation.

Co-developed-by: Jinyang He <hejinyang@loongson.cn>
Signed-off-by: Jinyang He <hejinyang@loongson.cn>
Co-developed-by: Youling Tang <tangyouling@loongson.cn>
Signed-off-by: Youling Tang <tangyouling@loongson.cn>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/objtool/check.c               | 4 ++++
 tools/objtool/elf.c                 | 6 ++++++
 tools/objtool/include/objtool/elf.h | 1 +
 3 files changed, 11 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 9e5e462..602318e 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -594,6 +594,8 @@ static int add_dead_ends(struct objtool_file *file)
 		goto reachable;
 
 	for_each_reloc(rsec, reloc) {
+		if (reloc->skipped)
+			continue;
 
 		if (reloc->sym->type != STT_SECTION) {
 			WARN("unexpected relocation symbol type in %s", rsec->name);
@@ -633,6 +635,8 @@ static int add_dead_ends(struct objtool_file *file)
 		return 0;
 
 	for_each_reloc(rsec, reloc) {
+		if (reloc->skipped)
+			continue;
 
 		if (reloc->sym->type != STT_SECTION) {
 			WARN("unexpected relocation symbol type in %s", rsec->name);
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index d420b5d..bd950d4 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -975,6 +975,12 @@ static int read_relocs(struct elf *elf)
 				return -1;
 			}
 
+			if (!(strcmp(rsec->name, ".rela.discard.unreachable")) ||
+			    !(strcmp(rsec->name, ".rela.discard.reachable"))) {
+				if (reloc->sym->type != STT_SECTION)
+					reloc->skipped = true;
+			}
+
 			elf_hash_add(reloc, &reloc->hash, reloc_hash(reloc));
 			reloc->sym_next_reloc = sym->relocs;
 			sym->relocs = reloc;
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index c532d70..4141837 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -75,6 +75,7 @@ struct reloc {
 	struct section *sec;
 	struct symbol *sym;
 	struct reloc *sym_next_reloc;
+	bool skipped;
 };
 
 struct elf {
-- 
2.1.0

