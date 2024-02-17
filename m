Return-Path: <linux-kernel+bounces-69866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15983858F9C
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 14:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99AFD282F33
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 13:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFC17A737;
	Sat, 17 Feb 2024 13:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XosJaJp0"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B69765BCA
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 13:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708175605; cv=none; b=Ey8hRck+kkxceRA0VtXoYlHvuzpMt7K0n+3e0VCXt7lkfLU8gM4CkTZTBZBIY819Awd/rvYRTFoDgdmMmmwcq12eNY7G010PB5gjUmQfhmhd034I0KOxWgLlCiHqrOx1uq+aYVtgPRC+LM2dr5amXYket+hXLBB5B3KbjR1/BMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708175605; c=relaxed/simple;
	bh=ZwH7Z+7XIzT3dkCuFxGAf7ppNgGS0+rHfHeMC1IFrdE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mKJ275h71GaSzlC6oFFy+gCUbhuaaWsV1VujT0SGq9E4ghPdl9jyYojPWHVbK99MqUYCgeNIR347lclmVoXEAlLeSFhbWqa5DAU9NUkiC0S3ZA9yocqgwsMj/a/W4VKt4srs+jRgAp+PQLuXDr6f+JZwM6cQQBE9Q1TIzJzGcJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XosJaJp0; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60804b369c7so15533867b3.2
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 05:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708175602; x=1708780402; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ANQ9Q8CsOYoivVzOOmmpID2/0jm0rKpHZABT07NfwNQ=;
        b=XosJaJp0gmZqGZ6dRdZ0EzT5cKAt7j9ZeI6OOL8Muydv/rHbAM3geYjNXHGjhHK0nu
         q8+v7lKEg9WRwuW0AQS23SmiV6Rk7jYW27gqLRdT5mYn/S9EihT6RhafckmBRqz17/MQ
         W+7+B4/FGxLiTofW5IxpmHPaVzr9fqZ0zIJYetBoxLkxV4ZUUNkEczJK0LdNRksDou2S
         UWj5vJfmsV2g9DBZ1ufS6ImwdwkmPQd3MZWpiTf4/M3xBBrxspqwumCFV1ZF8zmAqCFK
         bImhGUb+/Jar8bFw8xnwCyWcAqqgB9O3iegSCBZWvvT9Rd3VnR56ef3T+Q8g0Am/r7/k
         1b0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708175602; x=1708780402;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ANQ9Q8CsOYoivVzOOmmpID2/0jm0rKpHZABT07NfwNQ=;
        b=vi53SScL0WrsLsAvh1ITf64pZ0RxQn0xcRmUafhLUf46jGNUlGMQFUObnsUiN5sOzp
         QUE25qu0EwzG5OWOfsoz+1hgvEftUDMXZmw8oD1aekXDg9xiSA3w3PovWyof3IBkSWjA
         tbrTjBOH9LErlKrP1udD5UFV9nzueb+sbu/qEJAyooPaXDMYvsEJpGaPc7vYipYnb2iV
         WuzhMu+INSK90v5O8CSq61dYgEzuF4jqE6+25ZHo5J8gmWMUKxE/RZkvJGIy1mkJd+MA
         0DG2D4Ji8SwomoB89UP6lHc0yJQCYgr3BNPf6X/5U2fC5MtugRjQP/BcqJBtw03Gt3jP
         BnCg==
X-Forwarded-Encrypted: i=1; AJvYcCUT8o2JTLBKJI8LMJRrnievxazwAU5dqxya+BGLvU0nmhyQp3vJnwvRyh1A+PNYoyU7+R7bnmoaNVC8BB+DIWCILLwHMqGYbUx05LBy
X-Gm-Message-State: AOJu0YwejeglWObs60GjIcEUlcb2LLzFehAJnrUk/zC1OKEY7bliEbHY
	uTP3uAt4TWQFHMcYY4TghzFGgJ5TCCCVksCoyMHPu8bvjQ0JzqPCR09gX0CODsJeVyYlJRyeqpK
	0mJTSxE18UMutLZx03Q==
X-Google-Smtp-Source: AGHT+IFut6wtlgAhbVyHcpO0+LKbaT4xj0hzEj2c8AJpczaQ/l9VLPQeacdsPF1ojOT7WlUdtytMx2a+IO/sBEbx
X-Received: from ericchancf.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:4139])
 (user=ericchancf job=sendgmr) by 2002:a0d:d951:0:b0:608:1b39:245c with SMTP
 id b78-20020a0dd951000000b006081b39245cmr149033ywe.9.1708175602463; Sat, 17
 Feb 2024 05:13:22 -0800 (PST)
Date: Sat, 17 Feb 2024 13:13:16 +0000
In-Reply-To: <20240217131206.3667544-1-ericchancf@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240217131206.3667544-1-ericchancf@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240217131316.3668927-1-ericchancf@google.com>
Subject: [PATCH v6 3/4] riscv/barrier: Consolidate fence definitions
From: Eric Chan <ericchancf@google.com>
To: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	ericchancf@google.com, conor.dooley@microchip.com, parri.andrea@gmail.com, 
	emil.renner.berthing@canonical.com, samuel.holland@sifive.com
Content-Type: text/plain; charset="UTF-8"

Disparate fence implementations are consolidated into fence.h.
Also introduce RISCV_FENCE_ASM to make fence macro more reusable.

Signed-off-by: Eric Chan <ericchancf@google.com>
---
v4 -> v5: __atomic_acquire_fence and __atomic_release_fence
omit-the-fence-on-uniprocessor optimization, and fix the typo of
RISCV_RELEASE_BARRIER when spliting the patch in v3.

v3 -> v4 fix the form that can pass the checking of checkpatch.pl.

v1 -> v2: makes compilation pass with allyesconfig instead of
defconfig only, also satisfy scripts/checkpatch.pl.
- (__asm__ __volatile__ (RISCV_FENCE_ASM(p, s) : : : "memory"))
+ ({ __asm__ __volatile__ (RISCV_FENCE_ASM(p, s) : : : "memory"); })

 arch/riscv/include/asm/atomic.h  |  1 -
 arch/riscv/include/asm/barrier.h |  3 +--
 arch/riscv/include/asm/cmpxchg.h |  1 -
 arch/riscv/include/asm/fence.h   | 10 +++++++---
 arch/riscv/include/asm/io.h      |  8 ++++----
 arch/riscv/include/asm/mmio.h    |  5 +++--
 arch/riscv/include/asm/mmiowb.h  |  2 +-
 7 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
index 31e6e2e7cc18..0e0522e588ca 100644
--- a/arch/riscv/include/asm/atomic.h
+++ b/arch/riscv/include/asm/atomic.h
@@ -17,7 +17,6 @@
 #endif

 #include <asm/cmpxchg.h>
-#include <asm/barrier.h>

 #define __atomic_acquire_fence()					\
 	__asm__ __volatile__(RISCV_ACQUIRE_BARRIER "" ::: "memory")
diff --git a/arch/riscv/include/asm/barrier.h b/arch/riscv/include/asm/barrier.h
index 173b44a989f8..15857dbc2279 100644
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
 #define __mb()		RISCV_FENCE(iorw, iorw)
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
index 6c26c44dfcd6..6bcd80325dfc 100644
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
+#define RISCV_RELEASE_BARRIER		RISCV_FENCE_ASM(rw, w)
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
2.44.0.rc0.258.g7320e95886-goog

