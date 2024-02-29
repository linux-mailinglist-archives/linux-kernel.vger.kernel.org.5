Return-Path: <linux-kernel+bounces-87441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0844886D472
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF23B1F241C9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086C914EA4D;
	Thu, 29 Feb 2024 20:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DljaU1IV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D9614EA30;
	Thu, 29 Feb 2024 20:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239066; cv=none; b=S9NDbzuMxLmjrulYDAJMouAgqBtUbCCqsB7fjCxZHMRI71CZqik5z5J80f8wPnl3FuKBfz3Ptzgtq716izli3uKbaTgkv02L9mziS5XNSRjXKCQEIbdZwwBEleSMo9g1brI1ouO4V7P7qZ6iamMl4xgrjOkCPBm1JBM03egpkD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239066; c=relaxed/simple;
	bh=w5BdxNjIE7bfEOwDCFFB2lHGJCSTEMlYfCM9CWgPQaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jL2iPMNIDgxEJs8sry2mso99jWgFfdyq1XU/juIpZtx9CwJt8TKR8dNQH5n+p52wrhz5m7wFVwJxOYKPEnfGd/XBmryPmfCejRb+lcWzrid5daN3nFbNSsZnQgyERQftDt1Gh/+AVpmxH18BeGzliNyNbYvVL47N+51OvJ+hEKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DljaU1IV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B379C43394;
	Thu, 29 Feb 2024 20:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709239066;
	bh=w5BdxNjIE7bfEOwDCFFB2lHGJCSTEMlYfCM9CWgPQaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DljaU1IVrcHa0VRjUq6cfd7yg6BXGVD0qyI7Ii9ecNbFsJbM6Oe9n0QAjN+26rad2
	 qxk+Ju1LS6cHAuHnqk+g9EwPTZgfGic/HClHPrcKr+j5Xj30mPdYekjcOjePt6DpHA
	 YPv2J+UO66pe9qm4HlE/OvcnHWVElz0FyDKB66POubaJDOPCekLUtKxMv+cOvhQlOx
	 TFZbIvO1lzMzqfVCLgYHwJORegxFkM7DeK6agx5RM2mTJ9IaoGG+DrcmgGq8EUAmTP
	 1++SlrsUxU5p4A14LqUrpg/Vxb63QFWt47PMRWehZkJ9dFbpt8YinxdfhEGWgYflgC
	 Ra3/MeVTtRXHw==
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
Subject: [PATCH AUTOSEL 6.7 08/24] x86/mm: Move is_vsyscall_vaddr() into asm/vsyscall.h
Date: Thu, 29 Feb 2024 15:36:48 -0500
Message-ID: <20240229203729.2860356-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229203729.2860356-1-sashal@kernel.org>
References: <20240229203729.2860356-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.6
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
index 679b09cfe241c..d6375b3c633bc 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -798,15 +798,6 @@ show_signal_msg(struct pt_regs *regs, unsigned long error_code,
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


