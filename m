Return-Path: <linux-kernel+bounces-87507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA9486D548
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE5F72836C9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C31151CE2;
	Thu, 29 Feb 2024 20:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXRKuZV3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D418169836;
	Thu, 29 Feb 2024 20:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239295; cv=none; b=sCxPUJju4X4BTyzDhsDTpTK3J98fYpS1tfyZh70GvE+amJiKmz5Y5cWAq+Dtsh9tJoix2nf+neCKnHIUYc2uZoVQ4CmCs9R21Om+Mt/PDR6KOgNSZYekWBCZKMJ7128wEjZV1ah4Y1seIpLtX6vjeDQgfGBNnjO3/r+sUq0QVN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239295; c=relaxed/simple;
	bh=HwmkPfGefzMCAlIIte66Zo11gpIVH+oat9lMPqJVMGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AVV79CFBCv/fMmHbPegA3bEHnkhjTGQKtJxN5Yr3M1j2nlx8WAe78ve+8PYa3ljoOeqAUFFKsGmG3HJ03uGtmmPK+hSBvR29s2yYIHg6dpB3jj1Oqmcmd2ZVjBKTKUCXVc36N8E7uv2hU9PJ0fvk+rQaj2m+E/IaE2INs4S5D8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXRKuZV3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF6CC433F1;
	Thu, 29 Feb 2024 20:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709239295;
	bh=HwmkPfGefzMCAlIIte66Zo11gpIVH+oat9lMPqJVMGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nXRKuZV30aEexkPlv/tD+1Eeuh7Eq5mcocw4HRhIyq2+O+ykGEPOKT3vrED72mSb7
	 wJYEGdgI9wxTRW2thIuQNDrgqndreDt5vbznADg8sN8FVX/QhbAQlrRPE7RUYItBcP
	 F9dIHpO2Dqj9YGrhUIK2qOiSQHWn5WnXXrHTvcQcx8U5H0bRriyiAxXYRHL0op4+cR
	 Gqw313TUgjNwVAhJ2/As21u+WvP/AZDH7VnJp873lqN4ZO4ZCHTa40B9pnFlu7aPSy
	 5Elb7G5Ty6zrjnQPZ7U2MvtazsrNaZ4gano8oBTVEhFGPVcJ4I0Gst5H2I6Hx7M+HP
	 J3K7DL7PTUWdg==
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
Subject: [PATCH AUTOSEL 5.10 3/8] x86/mm: Move is_vsyscall_vaddr() into asm/vsyscall.h
Date: Thu, 29 Feb 2024 15:41:20 -0500
Message-ID: <20240229204127.2861980-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229204127.2861980-1-sashal@kernel.org>
References: <20240229204127.2861980-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.210
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


