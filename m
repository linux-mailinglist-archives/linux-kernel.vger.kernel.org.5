Return-Path: <linux-kernel+bounces-9680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F93C81C988
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 12:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE109286AA5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 11:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD655208B9;
	Fri, 22 Dec 2023 11:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9NA+rgg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A1B1D53B;
	Fri, 22 Dec 2023 11:57:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 453B3C433C7;
	Fri, 22 Dec 2023 11:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703246249;
	bh=/l6avMA7EU8OdaEPKAk6fYnGo8Aj3OZ74KZJkfMi7ro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k9NA+rgguh457yYzw8xXp5ZSYH8I1HoC3z7XcoXIbtLpB/D+HRAQ9UcNBjMluElnH
	 4RUzNAaKXXd53Sy2egoIyBSCVfN0GNLMKj7M3XGHOUXMNdjJ4SgJHjW2/Da9nSYvpj
	 zNiQsEn2KI9bPrHx7VRY1NHyGJPOD5GZlnZDtD7oZZgXwJEma8EIbyEBlFYy+8fhpD
	 lro6yLLsWb0bTPAf0kmFRnRgbyjo3069vahuhziEzw7kS4uw3mP4UL5mRq/gU06ncr
	 pZ1tbjgYFuBjUUVxMg1xYLXYHriQeO06xrHkSHiRN/vO8PT1k96fZgxqxNvHtspWxk
	 3SKGxdrbqPVCA==
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
Subject: [PATCH V3 2/4] riscv: mm: Fixup compat arch_get_mmap_end
Date: Fri, 22 Dec 2023 06:57:01 -0500
Message-Id: <20231222115703.2404036-3-guoren@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231222115703.2404036-1-guoren@kernel.org>
References: <20231222115703.2404036-1-guoren@kernel.org>
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


