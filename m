Return-Path: <linux-kernel+bounces-133546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E66589A563
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 22:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB0F3282D7B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 20:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EE4174ED7;
	Fri,  5 Apr 2024 20:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AC1BYAJH"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EE9173328
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 20:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712347541; cv=none; b=KHLApA9Mwx9dAqfbG9X6hJO4sqNJ1ELvtXMbVTnLY9r82kjYVye+A7D6ItdMZ/DL7QlMDJqlT/CslopuUbuSEsk8KcQrv1Gmr2V07bAsSvh/TwHnCNw/obzeVyB2TkPDY5HPhNv3ovbleZvApDFYiyfJhc61S8rn2TgfikIzGYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712347541; c=relaxed/simple;
	bh=kVOg6+8kVRoCisrfwR7WOhMe3mNooVqy6FvtcCAm8ro=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HogOyoK1m+y0hqXY1V8rRwU/BAUxwpm9gGALzJtDo/Jd6Sw3Tw/ucJFWCP4ZiQM3BQrDdC693vsBuHby1j1DdrM4/+PKDgSorlKgyR4zayRHBq4HhSvjIQ5y5qft67ixU17eH0PqCmtJnjx0MbrrwHr6ASKXrrXrwJ41goFZGxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AC1BYAJH; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5d8df7c5500so1850229a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 13:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712347539; x=1712952339; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vX/8UUj3bTMhmjE/Pb7I5CpQrbYOm5sxUlxUaaI9t04=;
        b=AC1BYAJHhACGgPOCaUO791leGnGo9WCTlu+iTK2IJSix4fH6foWNsL4TixlW40gG0y
         6OHtoa7OAwgzBIwQRtJ3YW7oaJIuLIdRGIdJlnI46oX93LWZo5ZQSAUFClZ/kRZFt69L
         jwYn3FyeD/p0VQEcrI7nFhWPDSIlLk7PtmETtOwlZF3KZQvuDUtQGdkb0lfQ2K6rkdF/
         pOeIOaGkMa8FFPKg/orio2wMJEqH/1x7+N7fe0ir+4/6D9Yj+mcK3Y727zxtpRbX+xQr
         hTsUD6L5sUzA1Fbk/tL7TrMMYfIngbhQSxpngFuWp1J6jNF/0aCHAXdARzgMr0B4HJ0w
         3Pwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712347539; x=1712952339;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vX/8UUj3bTMhmjE/Pb7I5CpQrbYOm5sxUlxUaaI9t04=;
        b=CntGm5VYnr1hrwIYRRWfSVACpUfPqFb0OJTgLk/S4oBa0kKjGnJfrL6C4gYv8o+eaA
         jUSjPN1rfG3krTD+VuHRW9mYQtJKR7CK6HH2ekXa4JREzjO3zpzTsLMRHiLVxbNGfc/E
         2BWkv41kwpfgFZzkQ/YNTJgR7ynP8nrO3FVdZb097ua3QVb/cfCHxhGrSTGerQzxQLf5
         n90QJ3bV5QxRhiOwrFIBLF5xJ/9OiMVkoBYgm6ODliTJ9FS9oM9BG2Ehs8NVIdW95wBv
         pnvYR59BQs8HSNVpodADRNz5RKx61G0XAM0ZqJGKEjBOwa9ZS0YVIjV608U5gO63O0PJ
         Kp6w==
X-Gm-Message-State: AOJu0YxV+O2De2WNE6uIz/WILWa34d2noFp6tKrwJSrYuGv93p26eQSs
	hdUyKsfySK8qxbB4rnvG9B9IX+EXPiyaSWZD+GoSU/6zXzqhme4fJSDtHEkQgDhfL0GZcsJu335
	vCvH7Pnr4vhZfHNZ2ptdX0qsVLSozhoBYaa12fpOdGE5Wo7B7jfG/G/AItMnh3ZU8t33QuyxQJy
	RN1bQpSaWGIs3mQhu0Nm11lMm39bpn2l5yr3I9NA0oHMF4
X-Google-Smtp-Source: AGHT+IFNkn2QwgxrkI/NGgPh1Q+aCI9+i47Zbn0mtLUIYmwXUsJ0Q0NtLpRDcpMTA6rh/dWxLN5V0I0gOUgx
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a63:5966:0:b0:5d5:ad56:55ee with SMTP id
 j38-20020a635966000000b005d5ad5655eemr7480pgm.4.1712347538468; Fri, 05 Apr
 2024 13:05:38 -0700 (PDT)
Date: Fri,  5 Apr 2024 13:05:26 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240405200535.2239155-1-jstultz@google.com>
Subject: [RFC][PATCH] locking/rwsem: Add __always_inline annotation to
 __down_write_common() and inlined callers
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: John Stultz <jstultz@google.com>, Tim Murray <timmurray@google.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

Apparently despite it being marked inline, the compiler
may not inline __down_write_common() which makes it difficult
to identify the cause of lock contention, as the blocked
function in traceevents will always be listed as
__down_write_common().

So add __always_inline annotation to the common function (as
well as the inlined helper callers) to force it to be inlined
so the blocking function will be listed (via Wchan) in
traceevents.

This mirrors commit 92cc5d00a431 ("locking/rwsem: Add
__always_inline annotation to __down_read_common() and inlined
callers") which did the same for __down_read_common.

I sort of worry that I'm playing wack-a-mole here, and talking
with compiler people, they tell me inline means nothing, which
makes me want to cry a little. So I'm wondering if we need to
replace all the inlines with __always_inline, or remove them
because either we mean something by it, or not.

Cc: Tim Murray <timmurray@google.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: kernel-team@android.com
Fixes: c995e638ccbb ("locking/rwsem: Fold __down_{read,write}*()")
Reported-by: Tim Murray <timmurray@google.com>
Signed-off-by: John Stultz <jstultz@google.com>
---
 kernel/locking/rwsem.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index c6d17aee4209..33cac79e3994 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -1297,7 +1297,7 @@ static inline int __down_read_trylock(struct rw_semaphore *sem)
 /*
  * lock for writing
  */
-static inline int __down_write_common(struct rw_semaphore *sem, int state)
+static __always_inline int __down_write_common(struct rw_semaphore *sem, int state)
 {
 	int ret = 0;
 
@@ -1310,12 +1310,12 @@ static inline int __down_write_common(struct rw_semaphore *sem, int state)
 	return ret;
 }
 
-static inline void __down_write(struct rw_semaphore *sem)
+static __always_inline void __down_write(struct rw_semaphore *sem)
 {
 	__down_write_common(sem, TASK_UNINTERRUPTIBLE);
 }
 
-static inline int __down_write_killable(struct rw_semaphore *sem)
+static __always_inline int __down_write_killable(struct rw_semaphore *sem)
 {
 	return __down_write_common(sem, TASK_KILLABLE);
 }
-- 
2.44.0.478.gd926399ef9-goog


