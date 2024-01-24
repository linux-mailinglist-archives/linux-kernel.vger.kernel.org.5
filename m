Return-Path: <linux-kernel+bounces-37347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F332D83AE91
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB5A1282183
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA507CF34;
	Wed, 24 Jan 2024 16:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OQ+30pWw"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899697E562
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 16:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706114547; cv=none; b=uZBxZS7Baah2dnAuVpCRjME7BNZSRAB40x25MDJU/AeGgVF8jd3p4JqpCiOv506BC/Fr5cJVHXwWBql03vuDuzR9w14bGhHZgJBSO/TB+OIU67SNI0Gdhy05FEuXcVFWAFCwoyseQ7glj7kenbuC49ZbNpDQ2Oadf5FINd3KCyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706114547; c=relaxed/simple;
	bh=3gkbJDusbQAmzhaAVsHFUeUqAUKGRL4ctUUYeBa0mqE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=CDQCJWRu9D+VbJ4X3+Aj9ef4WcdLFzGIKbrTCGR4nh76ga6YR18sM23T3AHZ8Cg+UTdN5jGWwLT5iRDIPcOStdr7TWl5Fk4ldymCLmckE+sJ3y6R3N5CNaO1G9t5DGFu0o36ix0q8F4tUgA2ofasO2X+Hlg1fxUGVXm1xse4zaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--glider.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OQ+30pWw; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--glider.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5ff82dc16e0so68535577b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 08:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706114544; x=1706719344; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m7Y5l6OToLybSucRHht2qJXpk8kuciDNbQY5osmgoqQ=;
        b=OQ+30pWwADGBxPwp174eCBWRgYyoSswXj9piky7Xu8jldgUIhyby49n1SmuH9pYWQ1
         UZT4s2uRheLBckVMr0/HPV/EidS2o6SCpnrHLuPYEPFVNOhNuc/JBOliK7QS256/Wj/y
         lqFciAl1yttRxLd8KRsUdEbGU7q8xccjRPQacqlMNJotHLdHeS5I/aeuPVPXTAt7K2Cj
         wtgo6dkKAw8UaijsCTqGBsf7Dbq1n5T+Vfqxr2G6IHOIUvIMOfcx6BLfbd5SptmVgAw4
         brs43r4xduQvPaIvd5+4IOu2PN3D1PV6nN4FTlXSCRSVplh9Qg6H9r8FhidInAhedotD
         NxAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706114544; x=1706719344;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m7Y5l6OToLybSucRHht2qJXpk8kuciDNbQY5osmgoqQ=;
        b=c1JpLb9soasvDuZnZiOmM95cn1IAsi/vu2LkgXGvCqiY/GL5yVseGmsaGxwybZek4J
         Ev/eUcP52oK+kmAfZl4DpTYITGw7pyeNyeK/41AVOJMgDmq8pr6QlhRfit2p5MZaPdna
         7B1d/G1vIyrY/+kwtsyPLZ+1hSWwFmkllffI/onaeYlb6/bON3oOh9LTLPD2o5O+He6Q
         b4eJV9Kf10bvJPdwvCRbj/C9II5baQT/W4WXaa+JAHJbistmZ2o7/Aw5mabQlbKqzmms
         fve1zb0iZxgrkEOIzWDlA5OJurpEhDCysIuTTVWCejI4xpjrlxMgRCIwoRLPh++Xkn2c
         JoSw==
X-Gm-Message-State: AOJu0YzYnQp6nTjKmczwpGAgs3e9WxLcDAyMVgY3ffXTBpTlGUw3+L9x
	yQ/ZEFIsJzlV2e8Zb7Qq344//SfUksJQyaJ/oM3rLGteRH8riVYoCzKS1I0YlnKTQsX23h2Tt0Y
	JVw==
X-Google-Smtp-Source: AGHT+IE8G4CSoHGmvsFg4U8Twsy6s+ghNL6n63NA7hAkz/CeB7MqCLzFD9amGXbO14msKZhvzjbQmeFXswY=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:ca56:4222:6893:5055])
 (user=glider job=sendgmr) by 2002:a0d:d708:0:b0:5d4:263e:c819 with SMTP id
 z8-20020a0dd708000000b005d4263ec819mr360803ywd.8.1706114544464; Wed, 24 Jan
 2024 08:42:24 -0800 (PST)
Date: Wed, 24 Jan 2024 17:42:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240124164211.1141742-1-glider@google.com>
Subject: [PATCH] mm: kmsan: remove runtime checks from kmsan_unpoison_memory()
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
Cc: Marco Elver <elver@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Nicholas Miehlbradt <nicholas@linux.ibm.com>
---
 mm/kmsan/hooks.c | 36 +++++++++++++-----------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/mm/kmsan/hooks.c b/mm/kmsan/hooks.c
index 5d6e2dee5692a..8a990cbf6d670 100644
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
+	kmsan_unpoison_memory((void *)regs, sizeof(*regs);
 }
 
 void kmsan_check_memory(const void *addr, size_t size)
-- 
2.43.0.429.g432eaa2c6b-goog


