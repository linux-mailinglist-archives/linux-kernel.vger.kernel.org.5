Return-Path: <linux-kernel+bounces-101798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA8387ABB2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9935CB21BD1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A03B55C0A;
	Wed, 13 Mar 2024 16:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxATb1Hk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA7B679E5;
	Wed, 13 Mar 2024 16:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347653; cv=none; b=p0WBZ2eBQH3bgJSWVsHgah/8dKnBYA93oWC7pq/7O6bsl4YQKyYFSCE/9/uj/L8yvZc9HMn2jeT92j9dCQ6ywrv5b/km6aIJZ5fEb9TfqAV7qFHtMHGPlhE+Jd3HQgeE/mjZlkunz2ye8qASVihRfSVUIgoXhzkVLkLNB0BwloE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347653; c=relaxed/simple;
	bh=ZSH7c0tRBNY1VUnSgllirALDthxqB+zfxFAgGUjdakE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UAHFk8i2eWKYQlsjcEqiJM99DMQZCkWycp10eJcPdnmohI3vdm273IZqbXUUtAUxXer0Cg5paKlop+FuxgKsEHLs66Rh5C83u8PO0+ma08LjC9+NAHs5VZ4Itt1zzBmm7Wi/VoRMrlLn6GHe51yzvP0ah6rV4gJuqpIp0CKrf4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxATb1Hk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A917C433F1;
	Wed, 13 Mar 2024 16:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347653;
	bh=ZSH7c0tRBNY1VUnSgllirALDthxqB+zfxFAgGUjdakE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jxATb1Hk4iFsyAmt+0sj4dXCHDe8GoSXUvoI8TAy6heXRnhvv/vo5Z8vc9xVoU68Z
	 3ceqg+gepzABosVqAbfl+sMqT6uxsVc8wHvDEmT2qkbl8Nhms9UG5a9FEPGF+LIFh/
	 M1LB1kMHhebyVuXoEhEX1+BZXVHzYN5tHVEO8chr/MBpo4yROYyWPTD2fGkjEtFkZ0
	 tL0k9vlngNqBWlxoDx0BlnMt+QBh9UdDF9le8fLYk/Ago7MO7jXJF1aBLGlXgSO1/E
	 yKVuZFncg3rF37Qx9G4M84TBK8IdxZIkuHey5Vl5FSvJBdyrCo0o0uiyc5xojzVExS
	 uDoYGttCWMeyQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Wang Kefeng <wangkefeng.wang@huawei.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 59/61] ARM: 9328/1: mm: try VMA lock-based page fault handling first
Date: Wed, 13 Mar 2024 12:32:34 -0400
Message-ID: <20240313163236.613880-60-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163236.613880-1-sashal@kernel.org>
References: <20240313163236.613880-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.10-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.7.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.7.10-rc1
X-KernelTest-Deadline: 2024-03-15T16:32+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Wang Kefeng <wangkefeng.wang@huawei.com>

[ Upstream commit c16af1212479570454752671a170a1756e11fdfb ]

Attempt VMA lock-based page fault handling first, and fall back to the
existing mmap_lock-based handling if that fails, the ebizzy benchmark
shows 25% improvement on qemu with 2 cpus.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Stable-dep-of: e870920bbe68 ("arch/arm/mm: fix major fault accounting when retrying under per-VMA lock")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/Kconfig    |  1 +
 arch/arm/mm/fault.c | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index f8567e95f98be..8f47d6762ea4b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -35,6 +35,7 @@ config ARM
 	select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT if CPU_V7
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_HUGETLBFS if ARM_LPAE
+	select ARCH_SUPPORTS_PER_VMA_LOCK
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_CMPXCHG_LOCKREF
 	select ARCH_USE_MEMTEST
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index fef62e4a9edde..e96fb40b9cc32 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -278,6 +278,35 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);
 
+	if (!(flags & FAULT_FLAG_USER))
+		goto lock_mmap;
+
+	vma = lock_vma_under_rcu(mm, addr);
+	if (!vma)
+		goto lock_mmap;
+
+	if (!(vma->vm_flags & vm_flags)) {
+		vma_end_read(vma);
+		goto lock_mmap;
+	}
+	fault = handle_mm_fault(vma, addr, flags | FAULT_FLAG_VMA_LOCK, regs);
+	if (!(fault & (VM_FAULT_RETRY | VM_FAULT_COMPLETED)))
+		vma_end_read(vma);
+
+	if (!(fault & VM_FAULT_RETRY)) {
+		count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
+		goto done;
+	}
+	count_vm_vma_lock_event(VMA_LOCK_RETRY);
+
+	/* Quick path to respond to signals */
+	if (fault_signal_pending(fault, regs)) {
+		if (!user_mode(regs))
+			goto no_context;
+		return 0;
+	}
+lock_mmap:
+
 retry:
 	vma = lock_mm_and_find_vma(mm, addr, regs);
 	if (unlikely(!vma)) {
@@ -316,6 +345,7 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	}
 
 	mmap_read_unlock(mm);
+done:
 
 	/*
 	 * Handle the "normal" case first - VM_FAULT_MAJOR
-- 
2.43.0


