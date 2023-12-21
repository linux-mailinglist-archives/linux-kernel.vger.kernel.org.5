Return-Path: <linux-kernel+bounces-8703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BA381BB44
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE0821F29425
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8476255E59;
	Thu, 21 Dec 2023 15:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="foMQzB4V"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40EE55E41;
	Thu, 21 Dec 2023 15:47:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 028E0C433C9;
	Thu, 21 Dec 2023 15:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703173634;
	bh=1VkNb9SSj6ijZ3M72NIaFsxAoNnYaBQ2VS47upbIECw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=foMQzB4VeCSYCK//dcfGdemiuC7dKk0zuG1BDQxCkZdTqaRrEwvgQCiJ0pXugK9Qa
	 LlUugpTV6s3JWWoRtIg3kD00AvVPEJP5ILsdBTWtHMZDygSEHTpeduzLfOCjCD3mUD
	 K3IOHDR4zp4rOF+qKjzuLt5nVJFScnxaGbvVMet34PxjkKCWbSg2cZHqJJI/e/AMc/
	 /UaclkeRKp4EkIdtq18KfuTuwxLqSAFS+T4dthVtNZ1Tyl0Nwfu6r4+m9FZkW4q9rG
	 X7uiwUiXnuQy4VWUUAkrbx6BAI1wIIVJ2ppeNoQPmqW7SH+zUe85KzXJjgyMQMwOfw
	 FmXjWEdP3pzJQ==
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
Subject: [PATCH V2 1/4] riscv: mm: Fixup compat mode boot failure
Date: Thu, 21 Dec 2023 10:46:58 -0500
Message-Id: <20231221154702.2267684-2-guoren@kernel.org>
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

In COMPAT mode, the STACK_TOP is 0x80000000, but the TASK_SIZE is
0x7fff000. When the user stack is upon 0x7fff000, it will cause a user
segment fault. Sometimes, it would cause boot failure when the whole
rootfs is rv32.

Freeing unused kernel image (initmem) memory: 2236K
Run /sbin/init as init process
Starting init: /sbin/init exists but couldn't execute it (error -14)
Run /etc/init as init process
...

Cc: stable@vger.kernel.org
Fixes: add2cc6b6515 ("RISC-V: mm: Restrict address space for sv39,sv48,sv57")
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/include/asm/pgtable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index ab00235b018f..74ffb2178f54 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -881,7 +881,7 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
 #define TASK_SIZE_MIN	(PGDIR_SIZE_L3 * PTRS_PER_PGD / 2)
 
 #ifdef CONFIG_COMPAT
-#define TASK_SIZE_32	(_AC(0x80000000, UL) - PAGE_SIZE)
+#define TASK_SIZE_32	(_AC(0x80000000, UL))
 #define TASK_SIZE	(test_thread_flag(TIF_32BIT) ? \
 			 TASK_SIZE_32 : TASK_SIZE_64)
 #else
-- 
2.40.1


