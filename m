Return-Path: <linux-kernel+bounces-5062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A9A818628
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C19FB22A42
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 11:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90A8168DE;
	Tue, 19 Dec 2023 11:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1WI21Fj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D97168BD
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 11:17:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3FAAC433C8;
	Tue, 19 Dec 2023 11:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702984627;
	bh=wJ8SoxQvEXo8YD/Otob+P1IPztgR2u77NuTz+L6AVU4=;
	h=From:To:Cc:Subject:Date:From;
	b=H1WI21FjhrRQqg3E1c+b9XLaLpRQ5UnHHpqgayieRpRt9ZtZquOYuPtjRP86oKQxF
	 QmYVT4SUNPFdKdWfcAwGru47rzFe7efebbzWOM8kfA3uyFYYLvHYi42lKwzyV4BMaX
	 8DMf1hrc2dPsEPN0ETih338m/ZAI1oyIa5mARhVFR1xxSk3DrQ7B4Dq5qiNUk/qD+X
	 1Y5PALy2PRFxmxFY+nzUVwaF9WxzI4CDb9/WJfBdQd0Gtyg0i+HgJ2xOddraG6Ui/K
	 osw9FWJ9Kq620lSDCNPxU1xUPMOmddLjeNuF9JbrOJIs2lcOkDzhu1N6hkAWj50lVU
	 IpO1d51vxt2TA==
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
	willy@infradead.org
Cc: linux-riscv@lists.infradead.org,
	Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH] riscv: mm: Fixup compat mode boot failure
Date: Tue, 19 Dec 2023 06:17:01 -0500
Message-Id: <20231219111701.1886903-1-guoren@kernel.org>
X-Mailer: git-send-email 2.40.1
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

Fixes: add2cc6b6515 ("RISC-V: mm: Restrict address space for sv39,sv48,sv57")
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/include/asm/pgtable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index ab00235b018f..d2ec5e6fa331 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -881,7 +881,7 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
 #define TASK_SIZE_MIN	(PGDIR_SIZE_L3 * PTRS_PER_PGD / 2)
 
 #ifdef CONFIG_COMPAT
-#define TASK_SIZE_32	(_AC(0x80000000, UL) - PAGE_SIZE)
+#define TASK_SIZE_32	(UL(1) << (MMAP_VA_BITS - 1))
 #define TASK_SIZE	(test_thread_flag(TIF_32BIT) ? \
 			 TASK_SIZE_32 : TASK_SIZE_64)
 #else
-- 
2.40.1


