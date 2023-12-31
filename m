Return-Path: <linux-kernel+bounces-13654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C179820A62
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 09:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 739BF1C213C3
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 08:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79D5FBFA;
	Sun, 31 Dec 2023 08:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l74aSVZn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F79F9FA
	for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 08:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E492C433C9;
	Sun, 31 Dec 2023 08:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704011424;
	bh=pGyWv9VDcODy3haubtquFUnBMC/QK1gpzpez9PuUJg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l74aSVZnKCkxsU7iG5U39K6snGA5u0zORTgPF1sZDwcJ0bzyhtgB5uUiyzw0HVVsw
	 ek4vZ6ge7ZUHDNrjVflanVu296zbSASdogcEg8Tb6frJ30w/0BZHKH5UJQoV7dXJ97
	 GeKq2Ox/1nR8xHE2+sEscfLFV5ut83FCw7ogbacrRHQq/Sa6Yp0wMU31UFkt+TVHfO
	 u7t5+I8bIvXQjLwJOkgzlanYNs2WAr6AaUEXlmLudcTrbCGUW57Je2lm1kCJ8R/N/F
	 6bJ5FuvlLyeRYYASv8mvFG0yR+qcAblM9nRS23ll9s/RHLDqOvR9fgn3rkJwG5sq7P
	 uFhh6mMktlIiQ==
From: guoren@kernel.org
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	guoren@kernel.org,
	panqinglin2020@iscas.ac.cn,
	bjorn@rivosinc.com,
	conor.dooley@microchip.com,
	leobras@redhat.com,
	peterz@infradead.org,
	keescook@chromium.org,
	wuwei2016@iscas.ac.cn,
	xiaoguang.xing@sophgo.com,
	chao.wei@sophgo.com,
	unicorn_wang@outlook.com,
	uwu@icenowy.me,
	jszhang@kernel.org,
	wefu@redhat.com,
	atishp@atishpatra.org,
	ajones@ventanamicro.com
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V2 3/3] riscv: xchg: Prefetch the destination word for sc.w
Date: Sun, 31 Dec 2023 03:29:53 -0500
Message-Id: <20231231082955.16516-4-guoren@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231231082955.16516-1-guoren@kernel.org>
References: <20231231082955.16516-1-guoren@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guo Ren <guoren@linux.alibaba.com>

The cost of changing a cacheline from shared to exclusive state can be
significant, especially when this is triggered by an exclusive store,
since it may result in having to retry the transaction.

This patch makes use of prefetch.w to prefetch cachelines for write
prior to lr/sc loops when using the xchg_small atomic routine.

This patch is inspired by commit: 0ea366f5e1b6 ("arm64: atomics:
prefetch the destination word for write prior to stxr").

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/include/asm/cmpxchg.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index 26cea2395aae..d7b9d7951f08 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -10,6 +10,7 @@
 
 #include <asm/barrier.h>
 #include <asm/fence.h>
+#include <asm/processor.h>
 
 #define __arch_xchg_masked(prepend, append, r, p, n)			\
 ({									\
@@ -23,6 +24,7 @@
 									\
 	__asm__ __volatile__ (						\
 	       prepend							\
+	       PREFETCHW_ASM(%5)					\
 	       "0:	lr.w %0, %2\n"					\
 	       "	and  %1, %0, %z4\n"				\
 	       "	or   %1, %1, %z3\n"				\
@@ -30,7 +32,7 @@
 	       "	bnez %1, 0b\n"					\
 	       append							\
 	       : "=&r" (__retx), "=&r" (__rc), "+A" (*(__ptr32b))	\
-	       : "rJ" (__newx), "rJ" (~__mask)				\
+	       : "rJ" (__newx), "rJ" (~__mask), "rJ" (__ptr32b)		\
 	       : "memory");						\
 									\
 	r = (__typeof__(*(p)))((__retx & __mask) >> __s);		\
-- 
2.40.1


