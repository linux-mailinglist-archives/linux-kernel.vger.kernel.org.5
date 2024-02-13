Return-Path: <linux-kernel+bounces-64219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6012D853C13
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 127571F24609
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 20:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D4860DDD;
	Tue, 13 Feb 2024 20:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qXmhTkpz"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3B060B9D
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 20:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707855150; cv=none; b=X0z+eJxnW4AThIEhMIAqVrd5NBA27y/qEpDjj7uWPaP68+zHa4yJBIZweYlM64+2sLCXDpg8Y8SMfPTiMDXXgV2q3cOkZKqJVWjB1TC1Q3jRgKW3/Wuc5IhsDqwAhAUZCcYSQ0Uq2eZLONdLugZWX9V9gzg3zActCRbTwvXRFJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707855150; c=relaxed/simple;
	bh=8Eu7h9h1OltfWiPT9pD0zhhDGm1FG6v6o8ZDtqfFamQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Gd6nnMbp8ADUb8OabC1iCpAYtgN8tyt43BPIRoSVr6BjhtcJCbs7lsNiXLbEBxrZSjfizFLuaQztOzSU2fAwHdwswD6BILS6ymJrmWuiOwAVBC9ZsYfpsThDyF6guR84Pab4Z9pwMA4o+XZM9u/n0IpQj59L9ZzvJIsRyPIh9To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qXmhTkpz; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-604832bcbd0so103063747b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 12:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707855147; x=1708459947; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RC2T9SgmWwA0L5LQ8BYxxpjFIKV4b3AtrMRzB+GqR24=;
        b=qXmhTkpzv1uGTpVWxJVYemmBGEHox5FDh12DktC/WPhSdd6qhnAZ+XWrGRSjnAf25a
         a+Xv4ZX1IkoVWBtkvjkacJkcr5I1tkJu6Cvxx/S4tBtKxVuyzcPjdgj3TjASViO1ykVN
         g6SHZ/SXUNOIf0+7Kple0+yKn190+iNleXKDUSItKgJSkfrbRPcmpU/FNYr0a9RJkpja
         JYiRsLs6qWShLvyCZ7eFxK/GxIFkqgwubQXsb4RqsTp2quFLHzSS3cn2Bjpeegzfgdth
         ideQe6BV4qYo+JCM2Wc64yjsuKsy26RiFGCRVkzWa9srnWIWjfAM9zBw/l0YVpgXv3W0
         +gqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707855147; x=1708459947;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RC2T9SgmWwA0L5LQ8BYxxpjFIKV4b3AtrMRzB+GqR24=;
        b=orih8j4+YmFhR9PPKaF1xllSd687JdaagjqD/Qd3FYrMjwxy0xF3p5ex8yh6MS+wlN
         DftL/bfq9km4RDsc6X9tBDfNYGRtEJwZOe5ssNkIMjyGjH41fEh7ILGYdLYYXHt8SK2d
         YMR6ejC6zYn27UotqmYEyQaVwmC2vqa8pY3f4TMQ9YsZ/pkMAj+hFuksDsM2Kkaq0q1u
         snbBUPWQUe8eeWUrR4rv2EKS5Vmz2Ji13s9YDee5pdIudg+Z1UIN1dJPx6yRSNXRaAv2
         MRLFWn17r+fmOkGGD3N/JSTTBjKX1z2fsePussET6UOHX5H2d6LSyu+GXzYR//4lr1DV
         t+3A==
X-Forwarded-Encrypted: i=1; AJvYcCXaV1QvZ342QLq0JsNIR+EqciGHg66Ozs8+A/MrcG9b/PhTlpDPu3F6aanG0eY1S7QoEAWr02xa7hbHshoTGGOvoS74v5AnF626Hdmr
X-Gm-Message-State: AOJu0Yz8/YOIkhZSxrvCggL2/BRf2faUuRNB031RFPQ3RdIizQcKADNI
	EEA+ymSPK91Syy76pOzV/9hO0B+2NQNVllHWo53Z3rVsQzaoMis8mC/dR90PWCp2dwpmvx2FbuV
	5ORlq3fw2F/CFop03qA==
X-Google-Smtp-Source: AGHT+IH3IQ/mT0lIUZt3b8aZuEy7cWkvdU0smiGeBheUVDNMUPfGxC78Td9jrmYMFkkzwF7GIe3mlZek3QW6+7nr
X-Received: from ericchancf.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:4139])
 (user=ericchancf job=sendgmr) by 2002:a0d:d752:0:b0:5ff:6623:be27 with SMTP
 id z79-20020a0dd752000000b005ff6623be27mr93462ywd.3.1707855147567; Tue, 13
 Feb 2024 12:12:27 -0800 (PST)
Date: Tue, 13 Feb 2024 20:12:21 +0000
In-Reply-To: <20240213200923.2547570-1-ericchancf@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240213200923.2547570-1-ericchancf@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240213201221.2549924-1-ericchancf@google.com>
Subject: [PATCH v4 4/4] riscv/barrier: Resolve checkpatch.pl error
From: Eric Chan <ericchancf@google.com>
To: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	ericchancf@google.com
Content-Type: text/plain; charset="UTF-8"

The past form of RISCV_FENCE would cause checkpatch.pl to issue
error messages, the example is as follows:
ERROR: space required after that ',' (ctx:VxV)
+#define __atomic_acquire_fence()       RISCV_FENCE(r,rw)
                                                     ^
fix the remaining of RISCV_FENCE.

Signed-off-by: Eric Chan <ericchancf@google.com>
---
 arch/riscv/include/asm/barrier.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/include/asm/barrier.h b/arch/riscv/include/asm/barrier.h
index 4f4743d7440d..880b56d8480d 100644
--- a/arch/riscv/include/asm/barrier.h
+++ b/arch/riscv/include/asm/barrier.h
@@ -19,19 +19,19 @@


 /* These barriers need to enforce ordering on both devices or memory. */
-#define __mb()		RISCV_FENCE(iorw,iorw)
-#define __rmb()		RISCV_FENCE(ir,ir)
-#define __wmb()		RISCV_FENCE(ow,ow)
+#define __mb()		RISCV_FENCE(iorw, iorw)
+#define __rmb()		RISCV_FENCE(ir, ir)
+#define __wmb()		RISCV_FENCE(ow, ow)

 /* These barriers do not need to enforce ordering on devices, just memory. */
-#define __smp_mb()	RISCV_FENCE(rw,rw)
-#define __smp_rmb()	RISCV_FENCE(r,r)
-#define __smp_wmb()	RISCV_FENCE(w,w)
+#define __smp_mb()	RISCV_FENCE(rw, rw)
+#define __smp_rmb()	RISCV_FENCE(r, r)
+#define __smp_wmb()	RISCV_FENCE(w, w)

 #define __smp_store_release(p, v)					\
 do {									\
 	compiletime_assert_atomic_type(*p);				\
-	RISCV_FENCE(rw,w);						\
+	RISCV_FENCE(rw, w);						\
 	WRITE_ONCE(*p, v);						\
 } while (0)

@@ -39,7 +39,7 @@ do {									\
 ({									\
 	typeof(*p) ___p1 = READ_ONCE(*p);				\
 	compiletime_assert_atomic_type(*p);				\
-	RISCV_FENCE(r,rw);						\
+	RISCV_FENCE(r, rw);						\
 	___p1;								\
 })

@@ -68,7 +68,7 @@ do {									\
  * instances the scheduler pairs this with an mb(), so nothing is necessary on
  * the new hart.
  */
-#define smp_mb__after_spinlock()	RISCV_FENCE(iorw,iorw)
+#define smp_mb__after_spinlock()	RISCV_FENCE(iorw, iorw)

 #include <asm-generic/barrier.h>

--
2.43.0.687.g38aa6559b0-goog

