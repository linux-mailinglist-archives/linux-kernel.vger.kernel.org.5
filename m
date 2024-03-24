Return-Path: <linux-kernel+bounces-116119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D5B88996B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 327561C321EE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44903ABE8B;
	Mon, 25 Mar 2024 03:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/9nmAoR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12C2178CD9;
	Sun, 24 Mar 2024 23:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323643; cv=none; b=XQrVe1FrkgOnnpKecKVxe4bc3BsVuAxmA4Fa3jJYpA6fCy0CFrJn2q855KuNORIdM8oVttkuUcGoVVWmm7UkcVNd891LrkCDJzmBY6OKb+UeVuYMTNVWVV9D97bKNuPY8VmYD7Mbu4spZ3rYhO+VOx+q2AU0+Sse2eeloJ1DaVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323643; c=relaxed/simple;
	bh=HwmkPfGefzMCAlIIte66Zo11gpIVH+oat9lMPqJVMGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f8dINjZ0f4rl6OGFuzF9ofwRkxQPqq+yKgCkehZOkokUd3ebKnykRBQKtPOgIm1oONLG5cQB5WNF/HBSaaZtgDbqCYfGc+T4priileseZmBrR+nlmPwk8J3aVviBYIOrZEeq11fFwu4l7bobl9c/dSk+5/n+y0At7bK+d53iFNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/9nmAoR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 131E9C433C7;
	Sun, 24 Mar 2024 23:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323642;
	bh=HwmkPfGefzMCAlIIte66Zo11gpIVH+oat9lMPqJVMGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d/9nmAoRmZZz0xnhLEIoXXe2ZF0YaKZqimfWD0aCfd7tTsdVHrxW5beCQytTKJDbo
	 EkBX3EVNBh8GqPfepUQZnqD6s5CeRyz5Qs69LxrPECWrq4SPCfm/wG2uLENxMMlBQ9
	 Ub1HeKR6sZYxqp6WEN7urjhgNWE5ZBPQ9uFJMyFEePKzAwNLt3Ty6mR+0HjXd6dCkK
	 q03/AuHhAoWoUgecDw4z6sjeskPGCD556k0g4zLWlb8ewrkgZ7QdoNokidJeQsV01T
	 rRuJ626++4bh6NjYB7iPgddini5vXbW7galFwOspzwihL/VkbRSxtN9E+vKC2i9vcy
	 E43k3mu3W+6kg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hou Tao <houtao1@huawei.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 014/238] x86/mm: Move is_vsyscall_vaddr() into asm/vsyscall.h
Date: Sun, 24 Mar 2024 19:36:42 -0400
Message-ID: <20240324234027.1354210-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 9c1545c376e9b..cdb337cf92bae 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -781,15 +781,6 @@ show_signal_msg(struct pt_regs *regs, unsigned long error_code,
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


