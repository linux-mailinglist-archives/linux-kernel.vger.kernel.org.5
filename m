Return-Path: <linux-kernel+bounces-18802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA8E82632E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 07:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40B3A1C213B1
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 06:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D9B134B1;
	Sun,  7 Jan 2024 06:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3HfLCNV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63AF134AB
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 06:30:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D09CC433CA;
	Sun,  7 Jan 2024 06:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704609049;
	bh=vzAUwHIH1r+/fUC34Yyxdlm+3Xgnktg3iqTJcmMW334=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G3HfLCNVX2P6JME1CRwoKlII+8fekB61j+wxGk8SBt44Z+PfP5xWipdBEl9SxyI9Y
	 JgxqN1nqfT4weGIevxsCwJfRZPerhMFS+oG5jbTx/vZuhAnfMu12xrhRCeIG/06IwF
	 Bk8QKbobbXzKmmotNNZNuDEivbp/qqUTEjT9as7W3FFlow/6A8Dlf6bQ+7Lv79Xj29
	 qI3yqZu1Co4UPztVZ/4IB6kUle6SbZ0cZnzACHAADsQ+kx8jhSA2MQD62USMr6VF8n
	 C8SbqZ3VnLGwKPRpcYLP68+Gvb7UX/pK6Z0V/zF4xaR5q4yBaZ7hJTKsLIxyrUABmP
	 vleOZdLP7cfzw==
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
	Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V4 3/4] riscv: mm: Remove unused TASK_SIZE_MIN
Date: Sun,  7 Jan 2024 01:30:24 -0500
Message-Id: <20240107063025.1628475-4-guoren@kernel.org>
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

Remove TASK_SIZE_MIN because it's not used anymore.

Reviewed-by: Leonardo Bras <leobras@redhat.com>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/include/asm/pgtable.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 74ffb2178f54..e415582276ec 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -878,7 +878,6 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
  */
 #ifdef CONFIG_64BIT
 #define TASK_SIZE_64	(PGDIR_SIZE * PTRS_PER_PGD / 2)
-#define TASK_SIZE_MIN	(PGDIR_SIZE_L3 * PTRS_PER_PGD / 2)
 
 #ifdef CONFIG_COMPAT
 #define TASK_SIZE_32	(_AC(0x80000000, UL))
@@ -890,7 +889,6 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
 
 #else
 #define TASK_SIZE	FIXADDR_START
-#define TASK_SIZE_MIN	TASK_SIZE
 #endif
 
 #else /* CONFIG_MMU */
-- 
2.40.1


