Return-Path: <linux-kernel+bounces-64217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F69C853C10
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89F511F241C7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 20:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9B260B88;
	Tue, 13 Feb 2024 20:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fJCq07nM"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E569E60B85
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 20:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707855138; cv=none; b=C7ZwAhC0jV9RXylantrDQunwo3BaKQDIGQqHWGo5mTgVc77346R3sXuVMowZWi/ivXk+EPuWuQkAs+UjwwNJ4hlLm735SGH64Gq2sbNtEkwwrzoCGMa1jeYFDSZtYzAK0kI6KxUTxlLUdXKJIJFyBCdhBN5ZQo5Jr+89SB9rrLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707855138; c=relaxed/simple;
	bh=xZO8eiP6MIwo4AWe6oTGMv8TWNVTlhLQiNLF+21k4jA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ULKHa+wW1fxqiUQ4NpSxlVuzn9UfPjMjsxU/loR7EYk7mgXUZImaw5snnMmZYXBSE5HfkME04BOS5acatc6pikaGSy+f1YBVKunDCnBQK0DpN1Oh2kOBM3DwZEbvHCwnb0r44EhtvUTzwDgeQei2VUJQRzIWduVopTfPBsVKH54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fJCq07nM; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-604b44e1dc9so69018487b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 12:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707855136; x=1708459936; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AFgYISl4Q1z3z0PFToQVU0sOsmnQCVQDgha0DxwrRnA=;
        b=fJCq07nMI6oVhwOVYSDOz2QP/0V8/UIfLMek/Vr1M/ZWhIMAQO8WJuQGrMt69YZbj9
         0GHWYPqhwkr/cPynPrBbzaGbt+JIqGTX2lIvDvsCW8R4VrRcFRNOCawd2iQJPEJe2H9H
         OreDfDlo+VAeg8UZ+GOuXVSNAacKH3yJg0PD21NLVU8/sWNrgQb5iDwPKJkkUGmKiwwd
         Os6TbiHOdBauXj44658SZVer+OUOTrnenrP8WAHzpwOHrP7MXLgI11X+qZD/1OJOa1GX
         v/GGYWs0pB+iZ49VH29kkx3zRAhzf6JMnjgNKHkNORhUsT4R8VERpkcHzw+88YRdRE7M
         rdsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707855136; x=1708459936;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AFgYISl4Q1z3z0PFToQVU0sOsmnQCVQDgha0DxwrRnA=;
        b=iLMfCIAtzlWOjZ7AagEZIvmHTCp71lE5Dmm6eXL2nDRqDl5WFZG/GPzUA9rBhSZHgy
         LgChZBXp8p25KvH15ckens3p0McAhImhv8kKAm0r/6H/onKVAhOnCzHH4gUBKcv8/c3b
         lHNH3+3A4J/44lEPrZLAqVVOFgtQawy8DJ0bTdIjSTBVcIb0B2lJ43WEH7k+hNdy396Z
         dYBvdmhRZunBIFmU56JitWaUu9v2dXVNEf2KM4VlKppG2f6qZ9cEeCbF4tOjHYirRvre
         YDcqoq/lQqR1OJV/V5tSJqDWJFvCHU58knqqcJ/schyI8HEG4/0CKp2FmwSM7eXUs7/t
         yEAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVN9OXK3Vsce7GA0EnOsG7UEBm0CdWSG4f5xby45SbqfwUgVKC2t5nsmyWcvkE4CRspk9vDq9BcwZb03GrwopSC6SOkD6UsnjNtoNOv
X-Gm-Message-State: AOJu0YwTfR9iPFUA3bukeogAlKkpmqzooFlcpCZhf3aFlbWroZ94SOs9
	v5ppLm1n2QYCWMhu0NtkUVqFdP7qEohVz1RVNzd2QrIYM8BWeSwaHYs5k3ugzUChCEiZ+zdwME7
	lGetFFbNAsYEDOCTKjg==
X-Google-Smtp-Source: AGHT+IH6MkPF7ngl4VQzeXVPSdHYEQyrluY0n1dW93fSLORUrlZCgRncZdpYZL7kBNBTnstETaYUREEOrmXRjtmJ
X-Received: from ericchancf.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:4139])
 (user=ericchancf job=sendgmr) by 2002:a0d:eac3:0:b0:5ff:b07b:fb83 with SMTP
 id t186-20020a0deac3000000b005ffb07bfb83mr74538ywe.4.1707855135937; Tue, 13
 Feb 2024 12:12:15 -0800 (PST)
Date: Tue, 13 Feb 2024 20:12:10 +0000
In-Reply-To: <20240213200923.2547570-1-ericchancf@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240213200923.2547570-1-ericchancf@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240213201210.2549488-1-ericchancf@google.com>
Subject: [PATCH v4 3/4] riscv/barrier: Consolidate fence definitions
From: Eric Chan <ericchancf@google.com>
To: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	ericchancf@google.com
Content-Type: text/plain; charset="UTF-8"

Disparate fence implementations are consolidated into fence.h.
Also introduce RISCV_FENCE_ASM to make fence macro more reusable.

Signed-off-by: Eric Chan <ericchancf@google.com>
---
v3 -> v4: fix the form that can pass the checking of checkpatch.pl.
 arch/riscv/include/asm/atomic.h  |  8 ++------
 arch/riscv/include/asm/barrier.h |  3 +--
 arch/riscv/include/asm/cmpxchg.h |  1 -
 arch/riscv/include/asm/fence.h   | 10 +++++++---
 arch/riscv/include/asm/io.h      |  8 ++++----
 arch/riscv/include/asm/mmio.h    |  5 +++--
 arch/riscv/include/asm/mmiowb.h  |  2 +-
 7 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
index 31e6e2e7cc18..19050d13b6c1 100644
--- a/arch/riscv/include/asm/atomic.h
+++ b/arch/riscv/include/asm/atomic.h
@@ -17,13 +17,9 @@
 #endif

 #include <asm/cmpxchg.h>
-#include <asm/barrier.h>

-#define __atomic_acquire_fence()					\
-	__asm__ __volatile__(RISCV_ACQUIRE_BARRIER "" ::: "memory")
-
-#define __atomic_release_fence()					\
-	__asm__ __volatile__(RISCV_RELEASE_BARRIER "" ::: "memory");
+#define __atomic_acquire_fence()	RISCV_FENCE(r, rw)
+#define __atomic_release_fence()	RISCV_FENCE(rw, r)

 static __always_inline int arch_atomic_read(const atomic_t *v)
 {
diff --git a/arch/riscv/include/asm/barrier.h b/arch/riscv/include/asm/barrier.h
index 4c49a8ff2c68..4f4743d7440d 100644
--- a/arch/riscv/include/asm/barrier.h
+++ b/arch/riscv/include/asm/barrier.h
@@ -11,13 +11,12 @@
 #define _ASM_RISCV_BARRIER_H

 #ifndef __ASSEMBLY__
+#include <asm/fence.h>

 #define nop()		__asm__ __volatile__ ("nop")
 #define __nops(n)	".rept	" #n "\nnop\n.endr\n"
 #define nops(n)		__asm__ __volatile__ (__nops(n))

-#define RISCV_FENCE(p, s) \
-	__asm__ __volatile__ ("fence " #p "," #s : : : "memory")

 /* These barriers need to enforce ordering on both devices or memory. */
 #define __mb()		RISCV_FENCE(iorw,iorw)
diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index a608e4d1a0a4..2fee65cc8443 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -8,7 +8,6 @@

 #include <linux/bug.h>

-#include <asm/barrier.h>
 #include <asm/fence.h>

 #define __xchg_relaxed(ptr, new, size)					\
diff --git a/arch/riscv/include/asm/fence.h b/arch/riscv/include/asm/fence.h
index 6c26c44dfcd6..5b46f96a3ec8 100644
--- a/arch/riscv/include/asm/fence.h
+++ b/arch/riscv/include/asm/fence.h
@@ -1,10 +1,14 @@
 #ifndef _ASM_RISCV_FENCE_H
 #define _ASM_RISCV_FENCE_H

+#define RISCV_FENCE_ASM(p, s)		"\tfence " #p "," #s "\n"
+#define RISCV_FENCE(p, s) \
+	({ __asm__ __volatile__ (RISCV_FENCE_ASM(p, s) : : : "memory"); })
+
 #ifdef CONFIG_SMP
-#define RISCV_ACQUIRE_BARRIER		"\tfence r , rw\n"
-#define RISCV_RELEASE_BARRIER		"\tfence rw,  w\n"
-#define RISCV_FULL_BARRIER		"\tfence rw, rw\n"
+#define RISCV_ACQUIRE_BARRIER		RISCV_FENCE_ASM(r, rw)
+#define RISCV_RELEASE_BARRIER		RISCV_FENCE_ASM(rw, r)
+#define RISCV_FULL_BARRIER		RISCV_FENCE_ASM(rw, rw)
 #else
 #define RISCV_ACQUIRE_BARRIER
 #define RISCV_RELEASE_BARRIER
diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
index 42497d487a17..1c5c641075d2 100644
--- a/arch/riscv/include/asm/io.h
+++ b/arch/riscv/include/asm/io.h
@@ -47,10 +47,10 @@
  * sufficient to ensure this works sanely on controllers that support I/O
  * writes.
  */
-#define __io_pbr()	__asm__ __volatile__ ("fence io,i"  : : : "memory");
-#define __io_par(v)	__asm__ __volatile__ ("fence i,ior" : : : "memory");
-#define __io_pbw()	__asm__ __volatile__ ("fence iow,o" : : : "memory");
-#define __io_paw()	__asm__ __volatile__ ("fence o,io"  : : : "memory");
+#define __io_pbr()	RISCV_FENCE(io, i)
+#define __io_par(v)	RISCV_FENCE(i, ior)
+#define __io_pbw()	RISCV_FENCE(iow, o)
+#define __io_paw()	RISCV_FENCE(o, io)

 /*
  * Accesses from a single hart to a single I/O address must be ordered.  This
diff --git a/arch/riscv/include/asm/mmio.h b/arch/riscv/include/asm/mmio.h
index 4c58ee7f95ec..06cadfd7a237 100644
--- a/arch/riscv/include/asm/mmio.h
+++ b/arch/riscv/include/asm/mmio.h
@@ -12,6 +12,7 @@
 #define _ASM_RISCV_MMIO_H

 #include <linux/types.h>
+#include <asm/fence.h>
 #include <asm/mmiowb.h>

 /* Generic IO read/write.  These perform native-endian accesses. */
@@ -131,8 +132,8 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
  * doesn't define any ordering between the memory space and the I/O space.
  */
 #define __io_br()	do {} while (0)
-#define __io_ar(v)	({ __asm__ __volatile__ ("fence i,ir" : : : "memory"); })
-#define __io_bw()	({ __asm__ __volatile__ ("fence w,o" : : : "memory"); })
+#define __io_ar(v)	RISCV_FENCE(i, ir)
+#define __io_bw()	RISCV_FENCE(w, o)
 #define __io_aw()	mmiowb_set_pending()

 #define readb(c)	({ u8  __v; __io_br(); __v = readb_cpu(c); __io_ar(__v); __v; })
diff --git a/arch/riscv/include/asm/mmiowb.h b/arch/riscv/include/asm/mmiowb.h
index 0b2333e71fdc..52ce4a399d9b 100644
--- a/arch/riscv/include/asm/mmiowb.h
+++ b/arch/riscv/include/asm/mmiowb.h
@@ -7,7 +7,7 @@
  * "o,w" is sufficient to ensure that all writes to the device have completed
  * before the write to the spinlock is allowed to commit.
  */
-#define mmiowb()	__asm__ __volatile__ ("fence o,w" : : : "memory");
+#define mmiowb()	RISCV_FENCE(o, w)

 #include <linux/smp.h>
 #include <asm-generic/mmiowb.h>
--
2.43.0.687.g38aa6559b0-goog

