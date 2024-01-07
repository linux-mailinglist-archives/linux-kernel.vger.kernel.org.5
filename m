Return-Path: <linux-kernel+bounces-18801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CEA82632D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 07:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 540EB1C213E8
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 06:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C80B12E50;
	Sun,  7 Jan 2024 06:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BEErWvmR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5977B12B66;
	Sun,  7 Jan 2024 06:30:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E87C433C9;
	Sun,  7 Jan 2024 06:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704609044;
	bh=YilEYSeqr0j5pZzspgrqRl75oKMAwPW5xtHbgWvnWkc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BEErWvmRP+NHy/jjchNvIRuWxKTcy8/+6eKXBfdkbcPp5RmlvdvpJZuSYRAfADUyH
	 iwPowOPa0uFKC+9F1I8BFIflxTZw6YrSRjNZpLZc+1JJEd+GKJ4dyCr/Fh9UVosHLz
	 rJseGwNuDC9/0AeWgpkfUPYjZobEHfURx2QM8sF1FmuEjeKf/90d6qRWdNTjyf8ALM
	 HrItqTfrXlLb6Fx4RqUVRWTmnVbvKzpJgtkSWcoyi++ommxiewPcQX+/Kg4mdSC4Gk
	 WrLRAAR2WXpCT6BV2mOsx2YIHnwAEX7S01SJD1fzII4sx+LPxFjgNk6aScaNdcLdZs
	 H724z8mQTXM5g==
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
Subject: [PATCH V4 2/4] riscv: mm: Fixup compat arch_get_mmap_end
Date: Sun,  7 Jan 2024 01:30:23 -0500
Message-Id: <20240107063025.1628475-3-guoren@kernel.org>
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

When the task is in COMPAT mode, the arch_get_mmap_end should be 2GB,
not TASK_SIZE_64. The TASK_SIZE has contained is_compat_mode()
detection, so change the definition of STACK_TOP_MAX to TASK_SIZE
directly.

Cc: stable@vger.kernel.org
Fixes: add2cc6b6515 ("RISC-V: mm: Restrict address space for sv39,sv48,sv57")
Reviewed-by: Leonardo Bras <leobras@redhat.com>
Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/include/asm/processor.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index f19f861cda54..e1944ff0757a 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -16,7 +16,7 @@
 
 #ifdef CONFIG_64BIT
 #define DEFAULT_MAP_WINDOW	(UL(1) << (MMAP_VA_BITS - 1))
-#define STACK_TOP_MAX		TASK_SIZE_64
+#define STACK_TOP_MAX		TASK_SIZE
 
 #define arch_get_mmap_end(addr, len, flags)			\
 ({								\
-- 
2.40.1


