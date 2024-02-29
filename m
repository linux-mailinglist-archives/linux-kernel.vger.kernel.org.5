Return-Path: <linux-kernel+bounces-87522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4A986D574
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 532841F25DE0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCDB16F851;
	Thu, 29 Feb 2024 20:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dwli6KSK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0AE16F847;
	Thu, 29 Feb 2024 20:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239330; cv=none; b=sGNxYTncoSz4xEB/NJ3q0x98a919bq2QSJel7+nAubvM4SnKpLZ6n3LLs2osvmlG2FdzwBppdNSY7m4y7lqx1J50f8pVNzX2OUzQzzkNKI6zJk17VrO7H1uJYdKgbeDf1wGoMSJ/wLI/hBQCYVUSh4siQL7NFGJovYxplQ2ouuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239330; c=relaxed/simple;
	bh=UCJuRUOVfELPHPmdqvQBH3TYlrKZaIPMVJB8Gm7z0TM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=onc2kSDRJFrG3x8XeTgSMqjdxoUhybyJbIe5xk8vAK6oD0FtNa5t0KGWjVBj956w4Gl5+w6VR0BiFL+rDV2A++zB7y3O3s+XDRUBakYf4sjzq5XVxce/b0/Hk7D1q+wB7mprvDM8GSl4u9RSyTJ1qmvV1bOG5ddHywT3Y8rE8UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dwli6KSK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43A1CC433F1;
	Thu, 29 Feb 2024 20:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709239329;
	bh=UCJuRUOVfELPHPmdqvQBH3TYlrKZaIPMVJB8Gm7z0TM=;
	h=From:To:Cc:Subject:Date:From;
	b=Dwli6KSKpx3ntfN71+Oh0KS54RVEmIgMzAI8U76dfsalgxAGVlzjRJGoRzb4wCR0u
	 5Hn3/mALkhADpyxyvXzkWXGz0EQv9nzJJVYK56QuDpOcNbg3UXVe3zuSWeMaI9vky1
	 gAZoXbJ7mOuXqoZP6v3T8zLU7uSazUiEJe0khxo9Mc7u+PqmQmA4Z+/pCGL1Y8MECB
	 87yignP/thPz63P13ETQaqvzyRBpfOHqt59E+o9klmEFycslqXJYLSoC4w4/o8ObdZ
	 Ze+qd/qMn5odW1ufv5F+eteSzezWyZAV+Wc5f4lScJC/sdbp7WWTfVp1W6aUR3Ig/U
	 2WUbrX1M0mhXA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hou Tao <houtao1@huawei.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org
Subject: [PATCH AUTOSEL 4.19 1/4] x86/mm: Move is_vsyscall_vaddr() into asm/vsyscall.h
Date: Thu, 29 Feb 2024 15:42:01 -0500
Message-ID: <20240229204208.2862333-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.307
Content-Transfer-Encoding: 8bit

From: Hou Tao <houtao1@huawei.com>

[ Upstream commit ee0e39a63b78849f8abbef268b13e4838569f646 ]

Move is_vsyscall_vaddr() into asm/vsyscall.h to make it available for
copy_from_kernel_nofault_allowed() in arch/x86/mm/maccess.c.

Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Hou Tao <houtao1@huawei.com>
Link: https://lore.kernel.org/r/20240202103935.3154011-2-houtao@huaweicloud.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/vsyscall.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/include/asm/vsyscall.h b/arch/x86/include/asm/vsyscall.h
index b986b2ca688a0..8154b25cb975a 100644
--- a/arch/x86/include/asm/vsyscall.h
+++ b/arch/x86/include/asm/vsyscall.h
@@ -4,6 +4,7 @@
 
 #include <linux/seqlock.h>
 #include <uapi/asm/vsyscall.h>
+#include <asm/page_types.h>
 
 #ifdef CONFIG_X86_VSYSCALL_EMULATION
 extern void map_vsyscall(void);
@@ -22,4 +23,13 @@ static inline bool emulate_vsyscall(struct pt_regs *regs, unsigned long address)
 }
 #endif
 
+/*
+ * The (legacy) vsyscall page is the long page in the kernel portion
+ * of the address space that has user-accessible permissions.
+ */
+static inline bool is_vsyscall_vaddr(unsigned long vaddr)
+{
+	return unlikely((vaddr & PAGE_MASK) == VSYSCALL_ADDR);
+}
+
 #endif /* _ASM_X86_VSYSCALL_H */
-- 
2.43.0


