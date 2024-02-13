Return-Path: <linux-kernel+bounces-64474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70556853EEB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDE8A28F4E5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3626662A0D;
	Tue, 13 Feb 2024 22:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s3IJmPjw"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074C462A06
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 22:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707864008; cv=none; b=KOtziSltlVF+89Bb/gD5uQlDW/97Z1KRojlx2ZKQwqqKNT1f0T+0E0e6CrOCaQdA6Gj8DG16rrwtFZcnAbe00/hUVIHy8gFlApcqRBP8baN6UqeprvvW14RbBr7bdUJfV2zZyGayOyCPx/nDdtIkUl1NjmLRYwgM5FVNkBixwDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707864008; c=relaxed/simple;
	bh=1Wi5DH/ir4PI82MZmr+zZoXQCHLjPrDZTIO/CzzW0e8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hMvfnNkqGVZx8aqp16Pt8VSkra/TUx8dXyuplnWuzkXbf3bX6NhreMLCQeZ4/xMp+7V59UFs6rgxZ0Kwe6FTxxxxV/qrkSSBvU+nRIjKGx4SvWT0640/RQjPHOkijRjS+69MygqBlOFHSkIK/pWNKdAlIMOFywqBNM36sbpWWxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s3IJmPjw; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60790eb0f8fso16896357b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 14:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707864006; x=1708468806; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RC2T9SgmWwA0L5LQ8BYxxpjFIKV4b3AtrMRzB+GqR24=;
        b=s3IJmPjw41p+N5TaFFRJEqbTxy0s6h9vLhaT2+A7kKRrEhx7/6IhYTRKcbSvPqxOp8
         zRX0Exs++orxPqiEyvOB+t7ZrO0JgKJDDm7GECpLLXrB5f86o7RgCRu/ETRx18yNM70m
         38BYtj8x6+KNMew6AF/X4nI3lhmY9JtGQDZbmtORm+zXgkylmO1/tlua4vNls/Q0p/mJ
         SG/vf75vkeQHsUy3HH1lqsczy4mRZN4uxV8GmNLeKOPtxST9Z+X6cMNfLTwF0ejzvlsW
         mGb6pGotyYC7yDNT30yEKCfYQkcUDUQ7qD6uCX20JtF9wuyy0cUdcD92g/X0K5Banxka
         NLqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707864006; x=1708468806;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RC2T9SgmWwA0L5LQ8BYxxpjFIKV4b3AtrMRzB+GqR24=;
        b=enWqewzB6h/5EdeZ6gm1cL4dvP8bYmeAwyPQJRIwAWPLr/o4Wq99TbVeWUj7OaQS12
         OnOkOHJFsuAwRT4ClYsKwrkQRWs2bEAkXdEPNTXzS755g45x2P7m1F3b0HnkxEgAIjgl
         tKDkGQvPqflpDeaY01PFURY8nfLMNGuTxsRf/avDshpnQeEhEbBjqJIXt+0DRWjHKuD+
         lR1KLlzmECITAZ1KheJEQq19GAmEnEBFkpl0Bb0Qye/fl8XclU8OFacoCJlBszQ0tKdO
         wad5Y68ErH4+3zKzyfCzeeJelliIIT5WuibzpQV67/ty0ox8hmyWdb8vKSTU4bl5/sjF
         QT/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUuElhavILzSBIF/vnFqXDyARcouCxYWfNmbHsvZgNWcxHmDIKOn+PQaZBMv+BcKx07Orsd0DDrWhBTge4/1xuEsF6qdmkybEfi+1ju
X-Gm-Message-State: AOJu0YzFYx9XxgtfoJYb5RKfP7XkAucaTY5ORyTS7GAiZFgHWGHOxyDV
	LvC/8g7riTVeJvDrIRPkzEzKpKOBAGc0nU8TXJDeRfRI8H0Lu4dmY7tlXuit+OR1yYbHPlbAzu9
	mRamWHX6uDXUXGu/7IA==
X-Google-Smtp-Source: AGHT+IFspyNz8AOxJhdBQBLPS6L7jDJPIOEu9cDDZN8mFfZR975IQ17DOmZb+TMd+r0yCCes1icpgAHegnssHbv/
X-Received: from ericchancf.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:4139])
 (user=ericchancf job=sendgmr) by 2002:a05:6902:114d:b0:dc6:d2c8:6e50 with
 SMTP id p13-20020a056902114d00b00dc6d2c86e50mr105619ybu.7.1707864006063; Tue,
 13 Feb 2024 14:40:06 -0800 (PST)
Date: Tue, 13 Feb 2024 22:40:00 +0000
In-Reply-To: <20240213223810.2595804-1-ericchancf@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240213223810.2595804-1-ericchancf@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240213224000.2597959-1-ericchancf@google.com>
Subject: [PATCH v5 4/4] riscv/barrier: Resolve checkpatch.pl error
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


