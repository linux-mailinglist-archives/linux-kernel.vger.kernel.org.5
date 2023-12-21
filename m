Return-Path: <linux-kernel+bounces-8704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAF881BB46
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 346711C25F26
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B86353A08;
	Thu, 21 Dec 2023 15:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cDlxg7WA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A625455E41;
	Thu, 21 Dec 2023 15:47:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8972C433C8;
	Thu, 21 Dec 2023 15:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703173638;
	bh=dOGyrLopRgWASgaIZLAx6CNRKKRLi1o/fzWOzw5hikY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cDlxg7WA1eBIwKV7bwZmyHXskjpiO8H0zm7M2Ghzhr/xJdhhL6Xl5kRI6BWyYA5lD
	 VBxAhJBQbB+9gO3Ag/gZJDFb+yKcYSbIwQNpD0ma517/zmjRtZImkNo7sEdHNxRaMo
	 1gXtByNw8LvPKTENtE7Eyo0fI2WALLGGdtPJwJF36c/Jju3NFsv75uhnr92pS3Mkxz
	 9QYAV4nD600gK2ZN6ikxvxtty6vjKnY3kXSgadf2i6U5AbJDy8ZsKxPN1iBVipFQBV
	 fplnF8mxIeIWVezxJQwQjGSA/khdXnqsTghUjHSyjZpLYbroFFW3LkjSldkXwKqcCY
	 8N6jkGpF6/EHQ==
From: guoren@kernel.org
To: linux-kernel@vger.kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	alexghiti@rivosinc.com,
	charlie@rivosinc.com,
	xiao.w.wang@intel.com,
	guoren@kernel.org,
	david@redhat.com,
	panqinglin2020@iscas.ac.cn,
	rick.p.edgecombe@intel.com,
	willy@infradead.org,
	bjorn@rivosinc.com,
	conor.dooley@microchip.com,
	cleger@rivosinc.com,
	leobras@redhat.com
Cc: linux-riscv@lists.infradead.org,
	Guo Ren <guoren@linux.alibaba.com>,
	stable@vger.kernel.org
Subject: [PATCH V2 2/4] riscv: mm: Fixup compat arch_get_mmap_end
Date: Thu, 21 Dec 2023 10:46:59 -0500
Message-Id: <20231221154702.2267684-3-guoren@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231221154702.2267684-1-guoren@kernel.org>
References: <20231221154702.2267684-1-guoren@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guo Ren <guoren@linux.alibaba.com>

When the task is in COMPAT mode, the arch_get_mmap_end should be 2GB,
not TASK_SIZE_64. The TASK_SIZE has contained is_compat_mode()
detection, so change the definition of STACK_TOP_MAX to TASK_SIZE
directly.

Cc: stable@vger.kernel.org
Fixes: add2cc6b6515 ("RISC-V: mm: Restrict address space for sv39,sv48,sv57")
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/include/asm/processor.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index f19f861cda54..1f538fc4448d 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -16,15 +16,13 @@
 
 #ifdef CONFIG_64BIT
 #define DEFAULT_MAP_WINDOW	(UL(1) << (MMAP_VA_BITS - 1))
-#define STACK_TOP_MAX		TASK_SIZE_64
+#define STACK_TOP_MAX		TASK_SIZE
 
 #define arch_get_mmap_end(addr, len, flags)			\
 ({								\
 	unsigned long mmap_end;					\
 	typeof(addr) _addr = (addr);				\
-	if ((_addr) == 0 || (IS_ENABLED(CONFIG_COMPAT) && is_compat_task())) \
-		mmap_end = STACK_TOP_MAX;			\
-	else if ((_addr) >= VA_USER_SV57)			\
+	if ((_addr) == 0 || (_addr) >= VA_USER_SV57)		\
 		mmap_end = STACK_TOP_MAX;			\
 	else if ((((_addr) >= VA_USER_SV48)) && (VA_BITS >= VA_BITS_SV48)) \
 		mmap_end = VA_USER_SV48;			\
-- 
2.40.1


