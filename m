Return-Path: <linux-kernel+bounces-87516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB8886D562
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC7D11C224F1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBB9143739;
	Thu, 29 Feb 2024 20:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yn4EFSTV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C5814372B;
	Thu, 29 Feb 2024 20:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239315; cv=none; b=l0CF5iirkpDdljnZVAsO7lVJF2wyGjjWLZbnsTRLItUQBj9SxY9/BJfpFD64rq7cJve6A1ohdSzg9gasa81AYzCBVcWhDYkUSoi4QfrwY5zE8VihYsIpUy2abcdYIf8xrd1kgrjpglYmmre+5PLf7fjTM5bkkuewOnk5+J4emBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239315; c=relaxed/simple;
	bh=F+AdCZ1zPpXuCR3PFJRaPWix4/L1kyIbcRn6BWE6gcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ODj3EdlDaUibNY36TswcoIDD6kLvF84uMs/HA80Bvm0uIkkk/mfNdQAWl98IYAXoQbX9OMwH0cUHAr0LQIDlAdjNzRCPvAeKvgpZntkTafZP4BPXsLT3bLR7BDoKw4JndJcNc/4jqzgbsTpH8dq3TJ867gBZNAgz6K9NoEPjeFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yn4EFSTV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 318D2C43390;
	Thu, 29 Feb 2024 20:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709239314;
	bh=F+AdCZ1zPpXuCR3PFJRaPWix4/L1kyIbcRn6BWE6gcw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yn4EFSTVWR+yob4YkrwF+Y/zHHLTFKB/ld6FVGT2UdzMg5M3+6Tkr3LZg/jR37VTY
	 M7qQ7bRheH67SJ1IEUjdozUQaY84Arfb1PfhITYoGyWpy31zhIxnQ75fLEsWtGLkl4
	 4q3wCCaMADIBsJScbf3VdZay4ujXZVzu/7qgO/tT5gZ8EvfEQQSEMOf4bzcwW0EzuR
	 oqp/vbWGUOIeWy2/uW+DZfVSkHbLE4HmVahvOp7lktIJbbtcMgQVnMht43AzlcSa9G
	 goGA2AQ9Oa+qh2NQrIwT/tLqAbyNFqBMWeLGj8PdnvGqF4tgEYaE4n1XA/d46U0N/E
	 vx8zC9ynCN21g==
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
	x86@kernel.org,
	luto@kernel.org,
	peterz@infradead.org
Subject: [PATCH AUTOSEL 5.4 2/6] x86/mm: Move is_vsyscall_vaddr() into asm/vsyscall.h
Date: Thu, 29 Feb 2024 15:41:42 -0500
Message-ID: <20240229204150.2862196-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229204150.2862196-1-sashal@kernel.org>
References: <20240229204150.2862196-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.269
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
 arch/x86/mm/fault.c             |  9 ---------
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/vsyscall.h b/arch/x86/include/asm/vsyscall.h
index ab60a71a8dcb9..472f0263dbc61 100644
--- a/arch/x86/include/asm/vsyscall.h
+++ b/arch/x86/include/asm/vsyscall.h
@@ -4,6 +4,7 @@
 
 #include <linux/seqlock.h>
 #include <uapi/asm/vsyscall.h>
+#include <asm/page_types.h>
 
 #ifdef CONFIG_X86_VSYSCALL_EMULATION
 extern void map_vsyscall(void);
@@ -24,4 +25,13 @@ static inline bool emulate_vsyscall(unsigned long error_code,
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
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index c494c8c058241..a8b0c678bb096 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -875,15 +875,6 @@ show_signal_msg(struct pt_regs *regs, unsigned long error_code,
 	show_opcodes(regs, loglvl);
 }
 
-/*
- * The (legacy) vsyscall page is the long page in the kernel portion
- * of the address space that has user-accessible permissions.
- */
-static bool is_vsyscall_vaddr(unsigned long vaddr)
-{
-	return unlikely((vaddr & PAGE_MASK) == VSYSCALL_ADDR);
-}
-
 static void
 __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
 		       unsigned long address, u32 pkey, int si_code)
-- 
2.43.0


