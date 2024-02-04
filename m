Return-Path: <linux-kernel+bounces-51520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0941B848C23
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 09:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B25DE1F23DC2
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 08:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BC8125B7;
	Sun,  4 Feb 2024 08:26:40 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5302512B87;
	Sun,  4 Feb 2024 08:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707035199; cv=none; b=Bz5W+aaiTboPF4ijT9v4gI4LdyRkMFsfqL0VSAWgvx7fng8vhHSHljHa69ZVjV6REz/pxsIoxId6WsjoaFMoXgwAZbDsW7pr5I9ZgaNMlTG8lNy8DIbfpf9KA0CqZh8Ju4bhH1RPwQI0T66Nviz0zJ3zXfFGPz3hk0Y0NSxC8Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707035199; c=relaxed/simple;
	bh=YjOazet17udlSB/hXsciOQX5vFpcDQxolOh3Op7toD4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K7soT5uY+L2vRJvGubzudqyNAbJS9sjvJR4th6sSQnwx0eUXqGm6FXLEfTfTwG0OuxdkPKnLHykZMt5wssCZaSASaDDwtCpb5ZlX72sqIgt5hiQjnrRJDGbaOXfR7Whp/jY9QiLQvYcNJ3Ubq+uozf+PGcGjdP9+KtJl1L8pvXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TSMyd6KVnz1xmyC;
	Sun,  4 Feb 2024 16:25:29 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (unknown [7.193.23.234])
	by mail.maildlp.com (Postfix) with ESMTPS id 0FA311A016C;
	Sun,  4 Feb 2024 16:26:34 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 4 Feb 2024 16:26:32 +0800
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
Subject: [PATCH -next v5 1/3] x86/mce: remove redundant fixup type EX_TYPE_COPY
Date: Sun, 4 Feb 2024 16:26:25 +0800
Message-ID: <20240204082627.3892816-2-tongtiangen@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240204082627.3892816-1-tongtiangen@huawei.com>
References: <20240204082627.3892816-1-tongtiangen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600017.china.huawei.com (7.193.23.234)

Since commit 034ff37d3407 ("x86: rewrite '__copy_user_nocache' function")
rewrited __copy_user_nocache() uses EX_TYPE_UACCESS instead of
EX_TYPE_COPY, there is no user for EX_TYPE_COPY, so remove it.

Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
---
 arch/x86/include/asm/asm.h                 | 3 ---
 arch/x86/include/asm/extable_fixup_types.h | 2 +-
 arch/x86/kernel/cpu/mce/severity.c         | 1 -
 arch/x86/mm/extable.c                      | 9 ---------
 4 files changed, 1 insertion(+), 14 deletions(-)

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
index 7acf0383be80..906b0d5541e8 100644
--- a/arch/x86/include/asm/extable_fixup_types.h
+++ b/arch/x86/include/asm/extable_fixup_types.h
@@ -36,7 +36,7 @@
 #define	EX_TYPE_DEFAULT			 1
 #define	EX_TYPE_FAULT			 2
 #define	EX_TYPE_UACCESS			 3
-#define	EX_TYPE_COPY			 4
+/* unused, was: #define EX_TYPE_COPY	 4 */
 #define	EX_TYPE_CLEAR_FS		 5
 #define	EX_TYPE_FPU_RESTORE		 6
 #define	EX_TYPE_BPF			 7
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
index b522933bfa56..51986e8a9d35 100644
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -164,13 +164,6 @@ static bool ex_handler_uaccess(const struct exception_table_entry *fixup,
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
@@ -341,8 +334,6 @@ int fixup_exception(struct pt_regs *regs, int trapnr, unsigned long error_code,
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


