Return-Path: <linux-kernel+bounces-64472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9981F853EE9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEECA1C26E99
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F05626D8;
	Tue, 13 Feb 2024 22:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QtLYEfm8"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D7E627EA
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 22:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707863995; cv=none; b=dX5JDB2yAyucDWuU1QG86ToC+pBzouJmUxOS96uVpdDOFUmNPhf3uxCUY0YQptjQtheYbOJXYtsYCSI642trsF8nxzXLX7YjTQZznAeeIcoYxVAYybq7mVBmKCVs8i4Z9USFKT5Tql5fQu/7O+kzXVV7VUHQbE7iWwl8run9Y14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707863995; c=relaxed/simple;
	bh=Arzgl6pL8qoStNM3EKk4ljjB6ogUsbOSdyqkDHv4CGM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f691VcMBwpeWazIXzy8qNUEQ9c0hErpy40Wx//htLUW+utVlTw89ta9DVEhb8xBLdpyl5FcIxVSjRRmi1wCC1RfOaEv6PI80X4E4zsA6rNQtvomGsxB58PaYwDxWxf+7Nv049hbb3c618NSVytp6oDcULhRyibvX6jgC+IBAQiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QtLYEfm8; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60492d6bfc0so65800537b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 14:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707863993; x=1708468793; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BS7J64xtqNYr0VkPhgpx0WAA/5MaMJzR/9ev/cheMlM=;
        b=QtLYEfm8JgOY5vtyiTJPvl8evIcqlNGm2HUnMjuFKptRU3OSQQ/TUu/zRnm4C4adbr
         rZF01Cf1JvaWGwfTxamdUt1FU7Jg5C7hM/Y8nLk2qGsQr93N1Dvxv7lL6arvmekhmTpC
         YQDxhf/57T+Pue20PUNzyguPXOX1jNg/WBz7p2biAHA++Xcbor4Z2zIWlX5nqYuRrCNJ
         LBrQgXPeIGaPelKc3mvPWKbP9pTct3TlwAC1SD64aNJApF7e16sbN0Pe2Od0a8qaXs0v
         300UvekTUba9FTN9YDCRNakNXxq0gzgnSyltcO729pv8MPocz+Y2JfBeeJxz5YvqFJuG
         d4Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707863993; x=1708468793;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BS7J64xtqNYr0VkPhgpx0WAA/5MaMJzR/9ev/cheMlM=;
        b=HPVNPtdC6T48zq3vEDHElSDfJz3RxQvxzJ+3F7gidCQvGlE7UIEL1sXplHTypdkMh/
         wT09xMnRPCP32B+ntMVG1W2Owkf08cf8gxqGQ3rpa2iGnCSbS/oB6ttUnJjEUYEUoYjf
         ynd2qMhz0lfsBHd3mF4xAwZZ/6ucrQjoXXicf8RZK8/ugixtDnWsQkTI49BvEOnGwO+q
         aKWsFJ/cKp0959C4Sx4/SJqXKnqVD8Tf6z3Jztf/XPQ3X/wBwV+YNqrOy+8AaTMUxO99
         zoI2is3OJ+U+2BFubpfVlc9pTHnn/7TdxHbI5UMA9IggPEWwuvsziO8VuNRSwaYvB/xa
         o0Sg==
X-Forwarded-Encrypted: i=1; AJvYcCWrPLtwdEHB7KJAwodCeUpbwlClGCMoTtwPF3RdnQRqzksrSQS2VUtbBmulCIYCTW/WBp6tq+13REfJkzMN2ZAQwXtYxywMsJNJC/I1
X-Gm-Message-State: AOJu0YwYjnZq91KZpkrlPxEl73MsCNNrCzNzL36mz/wr+NjQBxGfKPvK
	pCIHIN/eLilRDfYmcnOn/hp+i294cYZHMU1/gSi4fw66T8lAd8C6+vAwLQ5iLS7jnwBN2exvWNx
	/tMpUk8QLFQi8BQNlGA==
X-Google-Smtp-Source: AGHT+IEaXBKOsL4J4xH6upCv6tFAD1V6p0ocFCwjkV0OENmkH/QGXmVGVcJGhEqn5+7K3WrIETAickdSYwYsSZ2d
X-Received: from ericchancf.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:4139])
 (user=ericchancf job=sendgmr) by 2002:a0d:e884:0:b0:5ff:a885:65b with SMTP id
 r126-20020a0de884000000b005ffa885065bmr136409ywe.10.1707863992743; Tue, 13
 Feb 2024 14:39:52 -0800 (PST)
Date: Tue, 13 Feb 2024 22:39:41 +0000
In-Reply-To: <20240213223810.2595804-1-ericchancf@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240213223810.2595804-1-ericchancf@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240213223941.2597526-1-ericchancf@google.com>
Subject: [PATCH v5 3/4] riscv/barrier: Consolidate fence definitions
From: Eric Chan <ericchancf@google.com>
To: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	ericchancf@google.com
Content-Type: text/plain; charset="UTF-8"

Disparate fence implementations are consolidated into fence.h.
Also introduce RISCV_FENCE_ASM to make fence macro more reusable.

Signed-off-by: Eric Chan <ericchancf@google.com>
---
v4 -> v5: keep  __atomic_acquire_fence and __atomic_release_fence
omit-the-fence-on-uniprocessor optimization, and fix the typo of RISCV_RELEASE_BARRIER
when spliting the patch in v3.

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
2.43.0.687.g38aa6559b0-goog

