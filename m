Return-Path: <linux-kernel+bounces-37436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 397BE83B00E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD95528CA9D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFC9128399;
	Wed, 24 Jan 2024 17:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JcPagwzg"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990B212838E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 17:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706117504; cv=none; b=ulya1okCgM4j/fG188ImB+QPaNs0fYJFeFVskeej/IVTjXBEh6c5dh8HXHqVf0V2Mit8s7BY82fPhQnhFg0NHKTgpiP0M3toW8NJUI+OdBblYpO2PCqZVo8RIJrxIrJtrj4QrQVaRiXQLlEsg2cT22mnJUcpASrz4grC+/1fMQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706117504; c=relaxed/simple;
	bh=iDYkw01T+ayl2CQJpXE3NjxB2fBVdJ8TjzOtjGt6ed0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UdyUmw9cPstW+YHsDLU+O5DQkyf/IdCTk4Sepg5yL7i0WISYGHUKkjwpiQogdAFUa/3Ei4HJpKpkX6Q4flYNDyae3tEDpizUBN/8/AsDZtgcTzxjCPNnZdU/d8pDpdQm7/vQj2xjDGfDoObHZo3AnU6k0GdT3GajptGypGyIXxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--glider.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JcPagwzg; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--glider.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-55926c118e5so3581962a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 09:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706117501; x=1706722301; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kMQl+PaRJqmy3cHaG1IzDq8AzN3RMVuSbCxHhfx+H/0=;
        b=JcPagwzguQ7sUg4saBEUofAmNW7Lnnib/agx1wZ0cldcn3eKQUdiMC8PNNCQuzy6n/
         Aju363KJ6zAmZAQ7qZimxdB++JurLrbtMQvuWr3fBou9GS5qj7mb16LwTS9hNk+hW1iJ
         hGbxid9hXZ1LnMDamuJFZiNRdYVq4bAJfl6UOfSzfjIo2EZIn1rmCjM9qUzuIH6heB78
         vYXWOFXhqWtI1nvmyouo4+C8s6EqF+rqz0ljjVjjs34Jpt83+mFpQSU5DRHrhgn2CFZM
         Aq2OSbrwkeHjyx7BFoVJOZd2K6RCjtocNauo8L3X4a+TyWAoy/Qz/HbO6hi9Q4UQiXNi
         Z3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706117501; x=1706722301;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kMQl+PaRJqmy3cHaG1IzDq8AzN3RMVuSbCxHhfx+H/0=;
        b=V8zTQuGfdrJ+HPG2gqAjnvqCBt8unvQsTx3hsjUSWNYo0JHS3eCoILvmJkBZu4DhoD
         XxmvLR8GiiQxC52t/sWISTDVuOLDPCIm47n4hHf8ZtE2AYS9ZUolcLaoNWpl6+DXiCfe
         snMDJwVgCBj4qA7ux9ggbLcLVQ03k4yLGk+GFEEQUQAGsyRB6CKqGOhExlPWVaJtw6r1
         7P8/AxTLQ3LQI31KXV8DJH8aFFDKerR4icIQt80ARbAHARRUcOeTuyenPwgPKH9881q9
         FA7eP772Jv8VSejJKio7tT9IghSN7ozQOfPqXx2sLkPjQ71IHU2pKcr26O6libEtL8EK
         qUXA==
X-Gm-Message-State: AOJu0Yykfz4X5t9DcJ8fzF/V1Hs8f1Vcu/z0JK4W9aaCF3+nYr+6tRia
	JzXP4pOFqFIxvDrIj33S+mmJbtA4+x+TOunNwS50gawi+kEL778bZhtXlDPLHUkxVqMedECe2fP
	udA==
X-Google-Smtp-Source: AGHT+IGlOFACEt43WhKtTpDn0s55boHwwfL2w7oDhlo8EQrE3IXloxlTtf+hDKUXP+HJQ1NueuFOrd0k+3M=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:ca56:4222:6893:5055])
 (user=glider job=sendgmr) by 2002:a05:6402:2491:b0:559:6fa1:bbec with SMTP id
 q17-20020a056402249100b005596fa1bbecmr26136eda.6.1706117500691; Wed, 24 Jan
 2024 09:31:40 -0800 (PST)
Date: Wed, 24 Jan 2024 18:31:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240124173134.1165747-1-glider@google.com>
Subject: [PATCH v2] mm: kmsan: remove runtime checks from kmsan_unpoison_memory()
From: Alexander Potapenko <glider@google.com>
To: glider@google.com, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	kasan-dev@googlegroups.com, Marco Elver <elver@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
	Nicholas Miehlbradt <nicholas@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

Similarly to what's been done in commit ff444efbbb9be ("kmsan: allow
using __msan_instrument_asm_store() inside runtime"), it should be safe
to call kmsan_unpoison_memory() from within the runtime, as it does not
allocate memory or take locks. Remove the redundant runtime checks.

This should fix false positives seen with CONFIG_DEBUG_LIST=y when
the non-instrumented lib/stackdepot.c failed to unpoison the memory
chunks later checked by the instrumented lib/list_debug.c

Also replace the implementation of kmsan_unpoison_entry_regs() with
a call to kmsan_unpoison_memory().

Signed-off-by: Alexander Potapenko <glider@google.com>
Tested-by: Marco Elver <elver@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Nicholas Miehlbradt <nicholas@linux.ibm.com>
---
 mm/kmsan/hooks.c | 36 +++++++++++++-----------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/mm/kmsan/hooks.c b/mm/kmsan/hooks.c
index 5d6e2dee5692a..0b09daa188ef6 100644
--- a/mm/kmsan/hooks.c
+++ b/mm/kmsan/hooks.c
@@ -359,6 +359,12 @@ void kmsan_handle_dma_sg(struct scatterlist *sg, int nents,
 }
 
 /* Functions from kmsan-checks.h follow. */
+
+/*
+ * To create an origin, kmsan_poison_memory() unwinds the stacks and stores it
+ * into the stack depot. This may cause deadlocks if done from within KMSAN
+ * runtime, therefore we bail out if kmsan_in_runtime().
+ */
 void kmsan_poison_memory(const void *address, size_t size, gfp_t flags)
 {
 	if (!kmsan_enabled || kmsan_in_runtime())
@@ -371,47 +377,31 @@ void kmsan_poison_memory(const void *address, size_t size, gfp_t flags)
 }
 EXPORT_SYMBOL(kmsan_poison_memory);
 
+/*
+ * Unlike kmsan_poison_memory(), this function can be used from within KMSAN
+ * runtime, because it does not trigger allocations or call instrumented code.
+ */
 void kmsan_unpoison_memory(const void *address, size_t size)
 {
 	unsigned long ua_flags;
 
-	if (!kmsan_enabled || kmsan_in_runtime())
+	if (!kmsan_enabled)
 		return;
 
 	ua_flags = user_access_save();
-	kmsan_enter_runtime();
 	/* The users may want to poison/unpoison random memory. */
 	kmsan_internal_unpoison_memory((void *)address, size,
 				       KMSAN_POISON_NOCHECK);
-	kmsan_leave_runtime();
 	user_access_restore(ua_flags);
 }
 EXPORT_SYMBOL(kmsan_unpoison_memory);
 
 /*
- * Version of kmsan_unpoison_memory() that can be called from within the KMSAN
- * runtime.
- *
- * Non-instrumented IRQ entry functions receive struct pt_regs from assembly
- * code. Those regs need to be unpoisoned, otherwise using them will result in
- * false positives.
- * Using kmsan_unpoison_memory() is not an option in entry code, because the
- * return value of in_task() is inconsistent - as a result, certain calls to
- * kmsan_unpoison_memory() are ignored. kmsan_unpoison_entry_regs() ensures that
- * the registers are unpoisoned even if kmsan_in_runtime() is true in the early
- * entry code.
+ * Version of kmsan_unpoison_memory() called from IRQ entry functions.
  */
 void kmsan_unpoison_entry_regs(const struct pt_regs *regs)
 {
-	unsigned long ua_flags;
-
-	if (!kmsan_enabled)
-		return;
-
-	ua_flags = user_access_save();
-	kmsan_internal_unpoison_memory((void *)regs, sizeof(*regs),
-				       KMSAN_POISON_NOCHECK);
-	user_access_restore(ua_flags);
+	kmsan_unpoison_memory((void *)regs, sizeof(*regs));
 }
 
 void kmsan_check_memory(const void *addr, size_t size)
-- 
2.43.0.429.g432eaa2c6b-goog


