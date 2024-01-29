Return-Path: <linux-kernel+bounces-42823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E645E840757
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2872283630
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71128657CE;
	Mon, 29 Jan 2024 13:47:06 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9488A62A17
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 13:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706536026; cv=none; b=o6m366Z7LUBwloFxnuS47aCu9bb0xMSVkcYyT+iFGpS1H4AA61D+FmIxD2V/+MMU9Vel4Ef2Dc/q54Wyx7KfKMCtotI4sYOOBUS2pq+fzjwT5C17k8bnpIjd1Ns6pMfqY6yCb05fBLDVhmTAVkwWI587cOGtL9FdoqH/6hnOXKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706536026; c=relaxed/simple;
	bh=7Fx+7yWCwER6zmsWlZoudlXmXGSOaOQZW8f/PvyfCoE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n0K5kwednZXsKKekC/sLuPIBwU1wV0cdww6qImanQIotFbXO0YoasQPR82wYnOWSA4U1Ff8DIQGCrJ/aHMNvJzAamwRxPokVUsbLJWEj0Up9znCMMOHrxFbArw8KxL80qyoBfQo35qVIEM4v5QAhWJjuFG5nlkpZYgcFjih/BWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4TNqMF3pN7zNkcY;
	Mon, 29 Jan 2024 21:46:01 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (unknown [7.193.23.234])
	by mail.maildlp.com (Postfix) with ESMTPS id DA46B18005E;
	Mon, 29 Jan 2024 21:46:59 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 21:46:57 +0800
From: Tong Tiangen <tongtiangen@huawei.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, James Morse <james.morse@arm.com>, Robin
 Murphy <robin.murphy@arm.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Andrey Konovalov <andreyknvl@gmail.com>, Dmitry
 Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>, Michael Ellerman
	<mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy
	<christophe.leroy@csgroup.eu>, Aneesh Kumar K.V <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-mm@kvack.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<kasan-dev@googlegroups.com>, Tong Tiangen <tongtiangen@huawei.com>,
	<wangkefeng.wang@huawei.com>, Guohanjun <guohanjun@huawei.com>
Subject: [PATCH v10 2/6] arm64: add support for machine check error safe
Date: Mon, 29 Jan 2024 21:46:48 +0800
Message-ID: <20240129134652.4004931-3-tongtiangen@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240129134652.4004931-1-tongtiangen@huawei.com>
References: <20240129134652.4004931-1-tongtiangen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600017.china.huawei.com (7.193.23.234)

For the arm64 kernel, when it processes hardware memory errors for
synchronize notifications(do_sea()), if the errors is consumed within the
kernel, the current processing is panic. However, it is not optimal.

Take uaccess for example, if the uaccess operation fails due to memory
error, only the user process will be affected. Killing the user process and
isolating the corrupt page is a better choice.

This patch only enable machine error check framework and adds an exception
fixup before the kernel panic in do_sea().

Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
---
 arch/arm64/Kconfig               |  1 +
 arch/arm64/include/asm/extable.h |  1 +
 arch/arm64/mm/extable.c          | 16 ++++++++++++++++
 arch/arm64/mm/fault.c            | 29 ++++++++++++++++++++++++++++-
 4 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index aa7c1d435139..2cc34b5e7abb 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -20,6 +20,7 @@ config ARM64
 	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
 	select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
 	select ARCH_HAS_CACHE_LINE_SIZE
+	select ARCH_HAS_COPY_MC if ACPI_APEI_GHES
 	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_DEBUG_VIRTUAL
 	select ARCH_HAS_DEBUG_VM_PGTABLE
diff --git a/arch/arm64/include/asm/extable.h b/arch/arm64/include/asm/extable.h
index 72b0e71cc3de..f80ebd0addfd 100644
--- a/arch/arm64/include/asm/extable.h
+++ b/arch/arm64/include/asm/extable.h
@@ -46,4 +46,5 @@ bool ex_handler_bpf(const struct exception_table_entry *ex,
 #endif /* !CONFIG_BPF_JIT */
 
 bool fixup_exception(struct pt_regs *regs);
+bool fixup_exception_mc(struct pt_regs *regs);
 #endif
diff --git a/arch/arm64/mm/extable.c b/arch/arm64/mm/extable.c
index 228d681a8715..478e639f8680 100644
--- a/arch/arm64/mm/extable.c
+++ b/arch/arm64/mm/extable.c
@@ -76,3 +76,19 @@ bool fixup_exception(struct pt_regs *regs)
 
 	BUG();
 }
+
+bool fixup_exception_mc(struct pt_regs *regs)
+{
+	const struct exception_table_entry *ex;
+
+	ex = search_exception_tables(instruction_pointer(regs));
+	if (!ex)
+		return false;
+
+	/*
+	 * This is not complete, More Machine check safe extable type can
+	 * be processed here.
+	 */
+
+	return false;
+}
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 55f6455a8284..312932dc100b 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -730,6 +730,31 @@ static int do_bad(unsigned long far, unsigned long esr, struct pt_regs *regs)
 	return 1; /* "fault" */
 }
 
+static bool arm64_do_kernel_sea(unsigned long addr, unsigned int esr,
+				     struct pt_regs *regs, int sig, int code)
+{
+	if (!IS_ENABLED(CONFIG_ARCH_HAS_COPY_MC))
+		return false;
+
+	if (user_mode(regs))
+		return false;
+
+	if (apei_claim_sea(regs) < 0)
+		return false;
+
+	if (!fixup_exception_mc(regs))
+		return false;
+
+	if (current->flags & PF_KTHREAD)
+		return true;
+
+	set_thread_esr(0, esr);
+	arm64_force_sig_fault(sig, code, addr,
+		"Uncorrected memory error on access to user memory\n");
+
+	return true;
+}
+
 static int do_sea(unsigned long far, unsigned long esr, struct pt_regs *regs)
 {
 	const struct fault_info *inf;
@@ -755,7 +780,9 @@ static int do_sea(unsigned long far, unsigned long esr, struct pt_regs *regs)
 		 */
 		siaddr  = untagged_addr(far);
 	}
-	arm64_notify_die(inf->name, regs, inf->sig, inf->code, siaddr, esr);
+
+	if (!arm64_do_kernel_sea(siaddr, esr, regs, inf->sig, inf->code))
+		arm64_notify_die(inf->name, regs, inf->sig, inf->code, siaddr, esr);
 
 	return 0;
 }
-- 
2.25.1


