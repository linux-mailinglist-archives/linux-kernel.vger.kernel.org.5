Return-Path: <linux-kernel+bounces-56544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D7984CB73
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D34A428F30C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398127CF23;
	Wed,  7 Feb 2024 13:22:30 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4606F76C89
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 13:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707312149; cv=none; b=hyEpKzzr/VWbwYbq5u2KtULgFT6eELVS4FXDCGd3Um8Gg9TyDX0qShQW4lptZUeOx9xmCxt+19uDP7yfgu4bc5NoTNe1wfB/MQvSq8BPB1dh4FxvQwZmXZwloM1+wAMnNYHgmeYMJzgBx6ie7q6o448MgOUbcmbpVW3HmfBLOJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707312149; c=relaxed/simple;
	bh=9sQA/BamZ/gFU+FIrWp0JbvXjyjC3gWzVdiNgl4iEWA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kf78IaZUdNzrGOhbE/TnQo/fUm99+qM3xClCHwPkmst2ewqa/0P7HG6ToF+8cIDM0AELy4nJlhiVfBrlEtBbEqxmYV1gdHFvXTxjqTQCgm1m2Y1w4TBJrwfvRwG+cNMDWvK9gAIEabaSnk/Eyc5SkXVlwCTQj+IDj4gd5JEXTag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TVLMc0HTBz1gyb9;
	Wed,  7 Feb 2024 21:20:28 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (unknown [7.193.23.234])
	by mail.maildlp.com (Postfix) with ESMTPS id 83CD218001A;
	Wed,  7 Feb 2024 21:22:24 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 7 Feb 2024 21:22:22 +0800
From: Tong Tiangen <tongtiangen@huawei.com>
To: Mark Rutland <mark.rutland@arm.com>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, James Morse <james.morse@arm.com>, Robin Murphy
	<robin.murphy@arm.com>, Andrey Konovalov <andreyknvl@gmail.com>, Dmitry
 Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko
	<glider@google.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Aneesh
 Kumar K.V <aneesh.kumar@kernel.org>, "Naveen N. Rao"
	<naveen.n.rao@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-mm@kvack.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, Tong Tiangen
	<tongtiangen@huawei.com>, <wangkefeng.wang@huawei.com>, Guohanjun
	<guohanjun@huawei.com>
Subject: [PATCH v11 5/5] arm64: send SIGBUS to user process for SEA exception
Date: Wed, 7 Feb 2024 21:22:04 +0800
Message-ID: <20240207132204.1720444-6-tongtiangen@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240207132204.1720444-1-tongtiangen@huawei.com>
References: <20240207132204.1720444-1-tongtiangen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600017.china.huawei.com (7.193.23.234)

For SEA exception, kernel require take some action to recover from memory
error, such as isolate poison page adn kill failure thread, which are done
in memory_failure().

During the test, the failure thread cannot be killed due to this issue[1],
Here, I temporarily workaround this issue by sending signals to user
processes (!(PF_KTHREAD|PF_IO_WORKER|PF_WQ_WORKER|PF_USER_WORKER)) in
do_sea(). After [1] is merged, this patch can be rolled back or the SIGBUS
will be sent repeated.

[1]https://lore.kernel.org/lkml/20240204080144.7977-1-xueshuai@linux.alibaba.com/

Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
---
 arch/arm64/mm/fault.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 78f9d5ce83bb..a27bb2de1a7c 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -824,9 +824,6 @@ static int do_sea(unsigned long far, unsigned long esr, struct pt_regs *regs)
 	const struct fault_info *inf;
 	unsigned long siaddr;
 
-	if (do_apei_claim_sea(regs))
-		return 0;
-
 	inf = esr_to_fault_info(esr);
 	if (esr & ESR_ELx_FnV) {
 		siaddr = 0;
@@ -838,6 +835,19 @@ static int do_sea(unsigned long far, unsigned long esr, struct pt_regs *regs)
 		 */
 		siaddr  = untagged_addr(far);
 	}
+
+	if (do_apei_claim_sea(regs)) {
+		if (!(current->flags & (PF_KTHREAD |
+					PF_USER_WORKER |
+					PF_WQ_WORKER |
+					PF_IO_WORKER))) {
+			set_thread_esr(0, esr);
+			arm64_force_sig_fault(inf->sig, inf->code, siaddr,
+				"Uncorrected memory error on access to poison memory\n");
+		}
+		return 0;
+	}
+
 	arm64_notify_die(inf->name, regs, inf->sig, inf->code, siaddr, esr);
 
 	return 0;
-- 
2.25.1


