Return-Path: <linux-kernel+bounces-18800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BEDD82632A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 07:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C58C1C213B1
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 06:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C24E12B80;
	Sun,  7 Jan 2024 06:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mn3TOmiv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7568712B92;
	Sun,  7 Jan 2024 06:30:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB07AC433C9;
	Sun,  7 Jan 2024 06:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704609040;
	bh=umVU6nCEokwPLk3HrZTDkXejHPDj2htP73GTdyKh3eo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mn3TOmivgPCO/CP1FPDa6+UeC0fG+YnB1vlkpqGB06WykzQhSPZgfEWRjWSnOLOyA
	 vMv2q9+q2So6X8m3t5rWgEmAeIzV70HxK/hLtzArezOr1DDRxdqK57bJxRZ9A2UZVt
	 en517NGqSEQ4HCxaEi4MWz4wELJfFmGewjf/sZeuFmANs6890megy/uRZa6AkhAhVF
	 gs3uALG2rQfQyz9hK92vN8lQ+4zCiJxZW8JyJWF7kNE6ZZxxZpg6su2usEZEr4lw4V
	 CiABSujfXFQHpYjkSPuLmB9DMaSM4+RCGMYYHjxyal5c2Q2HJ46XoLt/5O6ZcWx10y
	 0wNlHmlwdEJiw==
From: guoren@kernel.org
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	alexghiti@rivosinc.com,
	charlie@rivosinc.com,
	guoren@kernel.org,
	panqinglin2020@iscas.ac.cn,
	bjorn@rivosinc.com,
	conor.dooley@microchip.com,
	leobras@redhat.com,
	cleger@rivosinc.com,
	willy@infradead.org
Cc: linux-kernel@vger.kernel.org,
	Guo Ren <guoren@linux.alibaba.com>,
	stable@vger.kernel.org
Subject: [PATCH V4 1/4] riscv: mm: Fixup compat mode boot failure
Date: Sun,  7 Jan 2024 01:30:22 -0500
Message-Id: <20240107063025.1628475-2-guoren@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240107063025.1628475-1-guoren@kernel.org>
References: <20240107063025.1628475-1-guoren@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guo Ren <guoren@linux.alibaba.com>

In COMPAT mode, the STACK_TOP is DEFAULT_MAP_WINDOW (0x80000000), but
the TASK_SIZE is 0x7fff000. When the user stack is upon 0x7fff000, it
will cause a user segment fault. Sometimes, it would cause boot
failure when the whole rootfs is rv32.

Freeing unused kernel image (initmem) memory: 2236K
Run /sbin/init as init process
Starting init: /sbin/init exists but couldn't execute it (error -14)
Run /etc/init as init process
...

Increase the TASK_SIZE to cover STACK_TOP.

Cc: stable@vger.kernel.org
Fixes: add2cc6b6515 ("RISC-V: mm: Restrict address space for sv39,sv48,sv57")
Reviewed-by: Leonardo Bras <leobras@redhat.com>
Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
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


