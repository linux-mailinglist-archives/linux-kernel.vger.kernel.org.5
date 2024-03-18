Return-Path: <linux-kernel+bounces-105718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE2887E362
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 06:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5307B21094
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 05:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C07F21A19;
	Mon, 18 Mar 2024 05:52:42 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01381225D9
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 05:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710741162; cv=none; b=J7WNSBXYedLv8JTAsvQfFrXNPeDfClGXpBE18hTKSnFpfRTP3PVUtOftguuQ6L6JIwL9EPA8KuyASfNnZhM2GLio6R4pO4Ovsma0Ur5ak3ST1iplc007VAbdyO+dfdRItJ9pLsey6jyvlK8ILHgJA4YsSvNLXLG1GYNAMWfdwnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710741162; c=relaxed/simple;
	bh=Cdru3VbuGBH4su+3CQDFPUqFIWOrXQ6ozUcxlHkJ3Uc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K/hjK9ArE2EgAVQhGuXRn+Ml01QiWabg4TYo68UXqPY8GlX+p5urMEOvrbaHNn1ZnsWelj7L+74seJUaIpNv2WldkNgGKDEKDSIBEOfIqzHJBoXatmGxpaEjGNETFXMvllClludDohzGYdKVXSCRkb/2FhQKBoBkzoItnk9JKSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 12a3f0b1020f45548aead598c0b2a1f8-20240318
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:4e005ac0-7851-424b-b53b-c96d1cc989c8,IP:25,
	URL:0,TC:0,Content:-25,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,AC
	TION:release,TS:-15
X-CID-INFO: VERSION:1.1.37,REQID:4e005ac0-7851-424b-b53b-c96d1cc989c8,IP:25,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-15
X-CID-META: VersionHash:6f543d0,CLOUDID:eb000300-c26b-4159-a099-3b9d0558e447,B
	ulkID:240318135226T0EYG1ER,BulkQuantity:0,Recheck:0,SF:17|19|44|66|38|24|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC
	:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: 12a3f0b1020f45548aead598c0b2a1f8-20240318
X-User: gehao@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw
	(envelope-from <gehao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1022669732; Mon, 18 Mar 2024 13:52:25 +0800
From: Hao Ge <gehao@kylinos.cn>
To: dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	bp@alien8.de,
	hpa@zytor.com
Cc: linux-kernel@vger.kernel.org,
	gehao618@163.com,
	Hao Ge <gehao@kylinos.cn>
Subject: [PATCH] mm/fault: make some is_*** function return bool
Date: Mon, 18 Mar 2024 13:52:22 +0800
Message-Id: <20240318055222.34462-1-gehao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

is_*** function can return bool,so we change it

Signed-off-by: Hao Ge <gehao@kylinos.cn>
---
 arch/x86/mm/fault.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index d6375b3c633b..591efd80a3e2 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -415,31 +415,31 @@ static void dump_pagetable(unsigned long address)
  * Note we only handle faults in kernel here.
  * Does nothing on 32-bit.
  */
-static int is_errata93(struct pt_regs *regs, unsigned long address)
+static bool is_errata93(struct pt_regs *regs, unsigned long address)
 {
 #if defined(CONFIG_X86_64) && defined(CONFIG_CPU_SUP_AMD)
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD
 	    || boot_cpu_data.x86 != 0xf)
-		return 0;
+		return false;
 
 	if (user_mode(regs))
-		return 0;
+		return false;
 
 	if (address != regs->ip)
-		return 0;
+		return false;
 
 	if ((address >> 32) != 0)
-		return 0;
+		return false;
 
 	address |= 0xffffffffUL << 32;
 	if ((address >= (u64)_stext && address <= (u64)_etext) ||
 	    (address >= MODULES_VADDR && address <= MODULES_END)) {
 		printk_once(errata93_warning);
 		regs->ip = address;
-		return 1;
+		return true;
 	}
 #endif
-	return 0;
+	return false;
 }
 
 /*
@@ -450,27 +450,27 @@ static int is_errata93(struct pt_regs *regs, unsigned long address)
  * are not reachable. Just detect this case and return.  Any code
  * segment in LDT is compatibility mode.
  */
-static int is_errata100(struct pt_regs *regs, unsigned long address)
+static bool is_errata100(struct pt_regs *regs, unsigned long address)
 {
 #ifdef CONFIG_X86_64
 	if ((regs->cs == __USER32_CS || (regs->cs & (1<<2))) && (address >> 32))
-		return 1;
+		return true;
 #endif
-	return 0;
+	return false;
 }
 
 /* Pentium F0 0F C7 C8 bug workaround: */
-static int is_f00f_bug(struct pt_regs *regs, unsigned long error_code,
+static bool is_f00f_bug(struct pt_regs *regs, unsigned long error_code,
 		       unsigned long address)
 {
 #ifdef CONFIG_X86_F00F_BUG
 	if (boot_cpu_has_bug(X86_BUG_F00F) && !(error_code & X86_PF_USER) &&
 	    idt_is_f00f_address(address)) {
 		handle_invalid_op(regs);
-		return 1;
+		return true;
 	}
 #endif
-	return 0;
+	return false;
 }
 
 static void show_ldttss(const struct desc_ptr *gdt, const char *name, u16 index)
-- 
2.25.1


