Return-Path: <linux-kernel+bounces-43980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0112C841BD6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 07:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABE2E285EA4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 06:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9598738F9D;
	Tue, 30 Jan 2024 06:17:40 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCDF38387
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 06:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706595460; cv=none; b=DcdtIrfQM10+YDEn+1//CIgrQyiFWQfG9ygVfQ92XCSuHVi69An2dJuTytJ9nVc25Yo0QV3pBn9VYa5pOyTWLoNBaXoES/NoBQCR79xW4Hz/u/AkytaihpMhK6y3I+2flKEn55G+wDn7qfDXHU5m34IE+ZhsppF1H3IiE1kD5p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706595460; c=relaxed/simple;
	bh=PWe3VKMGmFc/X53ABV1MfMql4/FLcOy0IPL4W64ZiII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C9ffMxeX5TE4/bZsUG46wiskPGTsGAbn5crvgURxOrn4GLv/X8YD/d8nDQc92N83gM3OrhtL8qQMaPskEg5CE+O1a/Hk5bwEywTLlJ8TmhQO3uAAFuz5Nu3q6Xf8ePWUiQX2GeAJluui59zDdVP6y6jLTzKGtlUc57hdrSqp7iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8AxqvCAlLhlDzYIAA--.25579S3;
	Tue, 30 Jan 2024 14:17:36 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxnhN7lLhlYXQnAA--.34034S7;
	Tue, 30 Jan 2024 14:17:36 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 5/8] objtool: Check local label in add_dead_ends()
Date: Tue, 30 Jan 2024 14:17:27 +0800
Message-ID: <20240130061730.21118-6-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240130061730.21118-1-yangtiezhu@loongson.cn>
References: <20240130061730.21118-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxnhN7lLhlYXQnAA--.34034S7
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW3XFy7WF1kKF1xtFy3Zr1kZwc_yoW7GF45pF
	47C347Kr4jvr13Zw12yF1xWasxWws7WrnrJ39rGryrAFy2vFsIgw1ayw13Zas0grWav3y5
	XayYgry5ur1UA3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
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

When update the latest upstream gcc and binutils, it generates more
objtool warnings on LoongArch, like this:

  init/main.o: warning: objtool: unexpected relocation symbol type in .rela.discard.unreachable

We can see that the reloc sym name is local label instead of section
in relocation section '.rela.discard.unreachable', in this case, the
reloc sym type is STT_NOTYPE instead of STT_SECTION.

As suggested by Peter Zijlstra, add "local_label" member in struct
symbol, then set it as true if symbol type is STT_NOTYPE and symbol
name starts with ".L" string in classify_symbols().

Let us check reloc->sym->local_label to not return -1, and also use
reloc->sym->offset instead of reloc addend which is 0 to find the
corresponding instruction. At the same time, replace the variable
"addend" with "offset" to reflect the reality.

Here are some detailed info:
[fedora@linux 6.8.test]$ gcc --version
gcc (GCC) 14.0.1 20240129 (experimental)
[fedora@linux 6.8.test]$ as --version
GNU assembler (GNU Binutils) 2.42.50.20240129
[fedora@linux 6.8.test]$ readelf -r init/main.o | grep -A 2 "rela.discard.unreachable"
Relocation section '.rela.discard.unreachable' at offset 0x6028 contains 1 entry:
  Offset          Info           Type           Sym. Value    Sym. Name + Addend
000000000000  00d900000063 R_LARCH_32_PCREL  00000000000002c4 .L500^B1 + 0

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/objtool/check.c               | 40 +++++++++++++++++------------
 tools/objtool/include/objtool/elf.h |  1 +
 2 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 548ec3cd7c00..d0e82c729dd9 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -20,6 +20,7 @@
 #include <linux/hashtable.h>
 #include <linux/kernel.h>
 #include <linux/static_call_types.h>
+#include <linux/string.h>
 
 struct alternative {
 	struct alternative *next;
@@ -584,7 +585,7 @@ static int add_dead_ends(struct objtool_file *file)
 	struct section *rsec;
 	struct reloc *reloc;
 	struct instruction *insn;
-	s64 addend;
+	unsigned long offset;
 
 	/*
 	 * Check for manually annotated dead ends.
@@ -594,27 +595,28 @@ static int add_dead_ends(struct objtool_file *file)
 		goto reachable;
 
 	for_each_reloc(rsec, reloc) {
-
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
 
@@ -633,27 +635,28 @@ static int add_dead_ends(struct objtool_file *file)
 		return 0;
 
 	for_each_reloc(rsec, reloc) {
-
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
 
@@ -2522,6 +2525,9 @@ static int classify_symbols(struct objtool_file *file)
 	struct symbol *func;
 
 	for_each_sym(file, func) {
+		if (func->type == STT_NOTYPE && strstarts(func->name, ".L"))
+			func->local_label = true;
+
 		if (func->bind != STB_GLOBAL)
 			continue;
 
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index 9f71e988eca4..2b8a69de4db8 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -67,6 +67,7 @@ struct symbol {
 	u8 profiling_func    : 1;
 	u8 warned	     : 1;
 	u8 embedded_insn     : 1;
+	u8 local_label       : 1;
 	struct list_head pv_target;
 	struct reloc *relocs;
 };
-- 
2.42.0


