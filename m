Return-Path: <linux-kernel+bounces-115280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2281E88937F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC3831F34187
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A7215E1FC;
	Mon, 25 Mar 2024 02:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FpVtOU+g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345A97F498;
	Sun, 24 Mar 2024 22:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320473; cv=none; b=lwW2QVVsz/p7vJ3kS3yD4uN+FgMfQjnFpJFRUO3oNMxSspJSXl9cd5WHxLGBlHqqnJp4WY1hOHQLMHvfVk7lrElnaLil/VcUPss+hasOaYrylMKLkOoPswMUDXsIxzfCxhzYnzVrMQE07x/KBcA31NJNAURerpxOvSaLSY3jDj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320473; c=relaxed/simple;
	bh=w5BdxNjIE7bfEOwDCFFB2lHGJCSTEMlYfCM9CWgPQaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QW2UL45a0gLb/TgoaV4fMi7TZAqZDbc649uYDcQm//PHhEWs8T2JVQ2D+grxu5JpbyoYHh9bUY+Qr0cUBHTATyCf6fctWWejwsh2NzmWG45goerapGWt2f4zefHN5foT4GoTChQVz82EhgkHiPozMyviy+iCaWTkAQ4tfdQgoxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FpVtOU+g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B3F8C433F1;
	Sun, 24 Mar 2024 22:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320473;
	bh=w5BdxNjIE7bfEOwDCFFB2lHGJCSTEMlYfCM9CWgPQaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FpVtOU+g4mLtAPayMG2qyFLvsM6Bk2VtvjrjrblAWTvuI0BcfcY8CVc3AhUDsZbPb
	 PEi+9Q3HwdFj25ssH5xFHuoh+W7P2gBAZA34MIgOOmVXhSgLnp9pj5pe/vQnNjEATf
	 78nXTMsgdjkoIpIHkDgiU1Achmj3jX55TJSsXA17ls1bLT4CC0ntBgJsYZaRDm0pbh
	 dxLC6TnEHpx4oU7tWvpcD/uavC1d/xXWqngNIlv44dQybT/4lkrrP57p1QsEUQJ01A
	 ajVYdCTn1Vcf57vyywXrAFdLi9OvnHvcXz/0sAFJQnMLW1XU0LZ0fZ3njFamCYKdh1
	 zWhqsYDkYZL2A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hou Tao <houtao1@huawei.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 032/713] x86/mm: Move is_vsyscall_vaddr() into asm/vsyscall.h
Date: Sun, 24 Mar 2024 18:35:58 -0400
Message-ID: <20240324224720.1345309-33-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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


