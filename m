Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1435C7D0671
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 04:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346884AbjJTC1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 22:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346841AbjJTC1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 22:27:12 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 45C1112D
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 19:27:08 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Dxl+h65TFlQV8zAA--.63827S3;
        Fri, 20 Oct 2023 10:27:06 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxP9115TFl7r4rAA--.28791S7;
        Fri, 20 Oct 2023 10:27:06 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
Subject: [PATCH v3 5/8] objtool: Check local label about sibling call
Date:   Fri, 20 Oct 2023 10:26:58 +0800
Message-Id: <1697768821-22931-6-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1697768821-22931-1-git-send-email-yangtiezhu@loongson.cn>
References: <1697768821-22931-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf8CxP9115TFl7r4rAA--.28791S7
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW3XFyrCw13GryDKr13uF1xWFX_yoW7tw4kpa
        13G390gr4rXFWxuw47tF4jg3Wa9w4rXFy7GFW5Ga4Skw1Yv3s8Ka1fK3WI9F15JFy5WF43
        Xa1jyryUCF4UAabCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1q6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
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

  init/version.o: warning: objtool: early_hostname+0x20: sibling call from callable instruction with modified stack frame

We can see that the branch and jump operation about local label ".L2"
is not sibling call, because a sibling call is a tail-call to another
symbol. In this case, make is_sibling_call() return false, set dest_sec
and dest_off to calculate jump_dest in add_jump_destinations().

Here are some detailed info:
[fedora@linux 6.6.test]$ gcc --version
gcc (GCC) 14.0.0 20231009 (experimental)
[fedora@linux 6.6.test]$ as --version
GNU assembler (GNU Binutils) 2.41.50.20231009
[fedora@linux 6.6.test]$ objdump -M no-aliases -D init/version.o | grep -A 21 "init.text"
Disassembly of section .init.text:

0000000000000000 <early_hostname>:
   0:	1a00000c 	pcalau12i   	$t0, 0
   4:	02ffc063 	addi.d      	$sp, $sp, -16
   8:	00150085 	or          	$a1, $a0, $zero
   c:	02810406 	addi.w      	$a2, $zero, 65
  10:	02c00184 	addi.d      	$a0, $t0, 0
  14:	29c02061 	st.d        	$ra, $sp, 8
  18:	54000000 	bl          	0	# 18 <early_hostname+0x18>
  1c:	0281000c 	addi.w      	$t0, $zero, 64
  20:	6c001584 	bgeu        	$t0, $a0, 20	# 34 <.L2>
  24:	1a000004 	pcalau12i   	$a0, 0
  28:	02810005 	addi.w      	$a1, $zero, 64
  2c:	02c00084 	addi.d      	$a0, $a0, 0
  30:	54000000 	bl          	0	# 30 <early_hostname+0x30>

0000000000000034 <.L2>:
  34:	28c02061 	ld.d        	$ra, $sp, 8
  38:	00150004 	or          	$a0, $zero, $zero
  3c:	02c04063 	addi.d      	$sp, $sp, 16
  40:	4c000020 	jirl        	$zero, $ra, 0

By the way, it need to move insn_reloc() before is_sibling_call()
to avoid implicit declaration build error.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
---
 tools/objtool/check.c | 69 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 41 insertions(+), 28 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index e308d1b..a9cb224 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -161,12 +161,39 @@ static bool is_jump_table_jump(struct instruction *insn)
 	       insn_jump_table(alt_group->orig_group->first_insn);
 }
 
-static bool is_sibling_call(struct instruction *insn)
+static struct reloc *insn_reloc(struct objtool_file *file, struct instruction *insn)
+{
+	struct reloc *reloc;
+
+	if (insn->no_reloc)
+		return NULL;
+
+	if (!file)
+		return NULL;
+
+	reloc = find_reloc_by_dest_range(file->elf, insn->sec,
+					 insn->offset, insn->len);
+	if (!reloc) {
+		insn->no_reloc = 1;
+		return NULL;
+	}
+
+	return reloc;
+}
+
+static bool is_sibling_call(struct objtool_file *file, struct instruction *insn)
 {
 	/*
 	 * Assume only STT_FUNC calls have jump-tables.
 	 */
 	if (insn_func(insn)) {
+		struct reloc *reloc = insn_reloc(file, insn);
+
+		/* Disallow sibling calls into STT_NOTYPE if it is local lable */
+		if (reloc && reloc->sym->type == STT_NOTYPE &&
+		    strncmp(reloc->sym->name, ".L", 2) == 0)
+			return false;
+
 		/* An indirect jump is either a sibling call or a jump to a table. */
 		if (insn->type == INSN_JUMP_DYNAMIC)
 			return !is_jump_table_jump(insn);
@@ -232,7 +259,7 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 	 * of the sibling call returns.
 	 */
 	func_for_each_insn(file, func, insn) {
-		if (is_sibling_call(insn)) {
+		if (is_sibling_call(file, insn)) {
 			struct instruction *dest = insn->jump_dest;
 
 			if (!dest)
@@ -743,7 +770,7 @@ static int create_static_call_sections(struct objtool_file *file)
 		if (!elf_init_reloc_data_sym(file->elf, sec,
 					     idx * sizeof(*site) + 4,
 					     (idx * 2) + 1, key_sym,
-					     is_sibling_call(insn) * STATIC_CALL_SITE_TAIL))
+					     is_sibling_call(file, insn) * STATIC_CALL_SITE_TAIL))
 			return -1;
 
 		idx++;
@@ -1315,26 +1342,6 @@ __weak bool arch_is_embedded_insn(struct symbol *sym)
 	return false;
 }
 
-static struct reloc *insn_reloc(struct objtool_file *file, struct instruction *insn)
-{
-	struct reloc *reloc;
-
-	if (insn->no_reloc)
-		return NULL;
-
-	if (!file)
-		return NULL;
-
-	reloc = find_reloc_by_dest_range(file->elf, insn->sec,
-					 insn->offset, insn->len);
-	if (!reloc) {
-		insn->no_reloc = 1;
-		return NULL;
-	}
-
-	return reloc;
-}
-
 static void remove_insn_ops(struct instruction *insn)
 {
 	struct stack_op *op, *next;
@@ -1577,8 +1584,14 @@ static int add_jump_destinations(struct objtool_file *file)
 			 * External sibling call or internal sibling call with
 			 * STT_FUNC reloc.
 			 */
-			add_call_dest(file, insn, reloc->sym, true);
-			continue;
+			if (reloc->sym->type == STT_NOTYPE &&
+			    strncmp(reloc->sym->name, ".L", 2) == 0) {
+				dest_sec = insn->sec;
+				dest_off = arch_jump_destination(insn);
+			} else {
+				add_call_dest(file, insn, reloc->sym, true);
+				continue;
+			}
 		} else if (reloc->sym->sec->idx) {
 			dest_sec = reloc->sym->sec;
 			dest_off = reloc->sym->sym.st_value +
@@ -3674,7 +3687,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 
 		case INSN_JUMP_CONDITIONAL:
 		case INSN_JUMP_UNCONDITIONAL:
-			if (is_sibling_call(insn)) {
+			if (is_sibling_call(file, insn)) {
 				ret = validate_sibling_call(file, insn, &state);
 				if (ret)
 					return ret;
@@ -3695,7 +3708,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 
 		case INSN_JUMP_DYNAMIC:
 		case INSN_JUMP_DYNAMIC_CONDITIONAL:
-			if (is_sibling_call(insn)) {
+			if (is_sibling_call(file, insn)) {
 				ret = validate_sibling_call(file, insn, &state);
 				if (ret)
 					return ret;
@@ -3859,7 +3872,7 @@ static int validate_unret(struct objtool_file *file, struct instruction *insn)
 
 		case INSN_JUMP_UNCONDITIONAL:
 		case INSN_JUMP_CONDITIONAL:
-			if (!is_sibling_call(insn)) {
+			if (!is_sibling_call(file, insn)) {
 				if (!insn->jump_dest) {
 					WARN_INSN(insn, "unresolved jump target after linking?!?");
 					return -1;
-- 
2.1.0

