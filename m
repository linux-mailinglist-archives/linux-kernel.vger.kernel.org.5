Return-Path: <linux-kernel+bounces-114730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 290228890CF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8E1B298D39
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40AE31A4361;
	Mon, 25 Mar 2024 00:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JVHSe2I8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761B2174977;
	Sun, 24 Mar 2024 23:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323316; cv=none; b=tgz2TSOWzdDL9PV5eaKcljSsYdaAGbeCeph9peVBCIt5JzHpATJ2W65nC2uxRJVBDdaLD7RY9QeEsvFR+PGAW4OpDvekuJGcBEhc8jvB5K25V8anmjZij/nT84gCDaON2rMhSgOK7WMGuB1v+67EzTIupo75BU1XVIsl7WG4Vf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323316; c=relaxed/simple;
	bh=Ifa5IzyFNPy2F0ERf9CRSKVTAjr0fTtnABmLN3lY9NA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gffia+PTWp6YKBitvRSM2lIde5k1jrX+vBDrVQSdKCOvw6xvIAf3vm8QlpNH4bmm4IEUGH2gz26y07iYDNrKpri3LPFWQNJUlabH9Mxu1RIdamhmb3eW2MmIY8/2Z1xg57zGOoaqaO4PJ7YMlPo7ABoAM7+m7jY2f6ib8FsdG3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JVHSe2I8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F920C43394;
	Sun, 24 Mar 2024 23:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323315;
	bh=Ifa5IzyFNPy2F0ERf9CRSKVTAjr0fTtnABmLN3lY9NA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JVHSe2I81X1EQwf0YL+moc/IdJkikpeR7aljbedAGhIJETOAmhslXFhAr60KMtJC6
	 wmPv496cBUVLxg/3HFExfB9WUOOhjSgloUzDqnH1kBgywMD6AVyeG0QQInjJGr4hUP
	 ivpyrXbJAAltybhwvB+kC7IUu07TeMm10USCqaM3QTR/Yt9ML2sZosk2+9aCwpvBB5
	 /mDTdPFDk7PbLDcaaVoWHzp+1fLm0dapFbH6JfWLwLCxCCJItUXzp07nWkx71o+cvb
	 7d4K+JYLMacGKmdLZiLtGkwmZKhcAG92eaG5h3sI3WdImMDm+RYgjXVfMOIq8U0Nj1
	 uqrOpmTVGRTjA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hou Tao <houtao1@huawei.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 015/317] x86/mm: Move is_vsyscall_vaddr() into asm/vsyscall.h
Date: Sun, 24 Mar 2024 19:29:55 -0400
Message-ID: <20240324233458.1352854-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index 4bfed53e210ec..abc6fbc3d5f21 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -787,15 +787,6 @@ show_signal_msg(struct pt_regs *regs, unsigned long error_code,
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


