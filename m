Return-Path: <linux-kernel+bounces-3157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D87816803
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8D44B20C7D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7742B111A3;
	Mon, 18 Dec 2023 08:24:30 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19E8101D9;
	Mon, 18 Dec 2023 08:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4SttC80jgpz1Q6sp;
	Mon, 18 Dec 2023 16:24:04 +0800 (CST)
Received: from kwepemm000017.china.huawei.com (unknown [7.193.23.46])
	by mail.maildlp.com (Postfix) with ESMTPS id 33FC9140120;
	Mon, 18 Dec 2023 16:24:18 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm000017.china.huawei.com (7.193.23.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Dec 2023 16:24:16 +0800
From: Tong Tiangen <tongtiangen@huawei.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, <wangkefeng.wang@huawei.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, Tony Luck <tony.luck@intel.com>, Andy Lutomirski
	<luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton
	<akpm@linux-foundation.org>, Naoya Horiguchi <naoya.horiguchi@nec.com>
CC: <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-mm@kvack.org>, Tong Tiangen <tongtiangen@huawei.com>, Guohanjun
	<guohanjun@huawei.com>
Subject: [PATCH -next v3 1/3] x86/mce: remove redundant fixup type EX_TYPE_COPY
Date: Mon, 18 Dec 2023 16:23:58 +0800
Message-ID: <20231218082400.2694698-2-tongtiangen@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231218082400.2694698-1-tongtiangen@huawei.com>
References: <20231218082400.2694698-1-tongtiangen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm000017.china.huawei.com (7.193.23.46)

In commit 034ff37d3407 ("x86: rewrite '__copy_user_nocache' function"),
rewrited __copy_user_nocache() uses EX_TYPE_UACCESS instead of
EX_TYPE_COPY，this change does not broken the MC safe copy for
__copy_user_nocache(), but as a result, there's no place for EX_TYPE_COPY
to use. Therefore, we remove the definition of EX_TYPE_COPY.

Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
---
 arch/x86/include/asm/asm.h                 |  3 ---
 arch/x86/include/asm/extable_fixup_types.h | 23 +++++++++++-----------
 arch/x86/kernel/cpu/mce/severity.c         |  1 -
 arch/x86/mm/extable.c                      |  9 ---------
 4 files changed, 11 insertions(+), 25 deletions(-)

diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index fbcfec4dc4cc..692409ea0c37 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -215,9 +215,6 @@ register unsigned long current_stack_pointer asm(_ASM_SP);
 #define _ASM_EXTABLE_UA(from, to)				\
 	_ASM_EXTABLE_TYPE(from, to, EX_TYPE_UACCESS)
 
-#define _ASM_EXTABLE_CPY(from, to)				\
-	_ASM_EXTABLE_TYPE(from, to, EX_TYPE_COPY)
-
 #define _ASM_EXTABLE_FAULT(from, to)				\
 	_ASM_EXTABLE_TYPE(from, to, EX_TYPE_FAULT)
 
diff --git a/arch/x86/include/asm/extable_fixup_types.h b/arch/x86/include/asm/extable_fixup_types.h
index 991e31cfde94..6126af55b85b 100644
--- a/arch/x86/include/asm/extable_fixup_types.h
+++ b/arch/x86/include/asm/extable_fixup_types.h
@@ -36,18 +36,17 @@
 #define	EX_TYPE_DEFAULT			 1
 #define	EX_TYPE_FAULT			 2
 #define	EX_TYPE_UACCESS			 3
-#define	EX_TYPE_COPY			 4
-#define	EX_TYPE_CLEAR_FS		 5
-#define	EX_TYPE_FPU_RESTORE		 6
-#define	EX_TYPE_BPF			 7
-#define	EX_TYPE_WRMSR			 8
-#define	EX_TYPE_RDMSR			 9
-#define	EX_TYPE_WRMSR_SAFE		10 /* reg := -EIO */
-#define	EX_TYPE_RDMSR_SAFE		11 /* reg := -EIO */
-#define	EX_TYPE_WRMSR_IN_MCE		12
-#define	EX_TYPE_RDMSR_IN_MCE		13
-#define	EX_TYPE_DEFAULT_MCE_SAFE	14
-#define	EX_TYPE_FAULT_MCE_SAFE		15
+#define	EX_TYPE_CLEAR_FS		 4
+#define	EX_TYPE_FPU_RESTORE		 5
+#define	EX_TYPE_BPF			 6
+#define	EX_TYPE_WRMSR			 7
+#define	EX_TYPE_RDMSR			 8
+#define	EX_TYPE_WRMSR_SAFE		 9 /* reg := -EIO */
+#define	EX_TYPE_RDMSR_SAFE		10 /* reg := -EIO */
+#define	EX_TYPE_WRMSR_IN_MCE		11
+#define	EX_TYPE_RDMSR_IN_MCE		12
+#define	EX_TYPE_DEFAULT_MCE_SAFE	13
+#define	EX_TYPE_FAULT_MCE_SAFE		14
 
 #define	EX_TYPE_POP_REG			16 /* sp += sizeof(long) */
 #define EX_TYPE_POP_ZERO		(EX_TYPE_POP_REG | EX_DATA_IMM(0))
diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index c4477162c07d..bca780fa5e57 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -290,7 +290,6 @@ static noinstr int error_context(struct mce *m, struct pt_regs *regs)
 
 	switch (fixup_type) {
 	case EX_TYPE_UACCESS:
-	case EX_TYPE_COPY:
 		if (!copy_user)
 			return IN_KERNEL;
 		m->kflags |= MCE_IN_KERNEL_COPYIN;
diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
index 271dcb2deabc..2354c0156e51 100644
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -163,13 +163,6 @@ static bool ex_handler_uaccess(const struct exception_table_entry *fixup,
 	return ex_handler_default(fixup, regs);
 }
 
-static bool ex_handler_copy(const struct exception_table_entry *fixup,
-			    struct pt_regs *regs, int trapnr)
-{
-	WARN_ONCE(trapnr == X86_TRAP_GP, "General protection fault in user access. Non-canonical address?");
-	return ex_handler_fault(fixup, regs, trapnr);
-}
-
 static bool ex_handler_msr(const struct exception_table_entry *fixup,
 			   struct pt_regs *regs, bool wrmsr, bool safe, int reg)
 {
@@ -267,8 +260,6 @@ int fixup_exception(struct pt_regs *regs, int trapnr, unsigned long error_code,
 		return ex_handler_fault(e, regs, trapnr);
 	case EX_TYPE_UACCESS:
 		return ex_handler_uaccess(e, regs, trapnr, fault_addr);
-	case EX_TYPE_COPY:
-		return ex_handler_copy(e, regs, trapnr);
 	case EX_TYPE_CLEAR_FS:
 		return ex_handler_clear_fs(e, regs);
 	case EX_TYPE_FPU_RESTORE:
-- 
2.25.1


