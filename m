Return-Path: <linux-kernel+bounces-37410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D2D83AF6E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3733A1C21717
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1407FBD4;
	Wed, 24 Jan 2024 17:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rN9o9h/K"
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DBF7E798
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 17:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116545; cv=none; b=DqtNjVGpIFOmJnUYiQDG8CulTm3+ktIMk4Dt0a3GlXDltO93K59LmKbVfQNc79g6M9fgOM1OqOaxVJdOEHUt7F3wnjkzbAMWfCnnfVHRQwd02C88/bS5Iw+ataqeNuYMUxCsjPeuQ8QEpUMAgjx7YjNz8o+n5vBENV5ThWaAHBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116545; c=relaxed/simple;
	bh=t5IGydsPTxpNyHN66k8U6CTE14hh9iXkhF9jbwqknaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VffuAvk/lTkfS70HVx3m4QfgeHEarq5Xm6dp3VSfArByiKWMKT0SNVZ3lBav1kgChJi+NA3aKX5T+SW4nzv+r/3b++TIhaCl7XrTJ8Rh8b2Dg1bCsD5iEVifCpKM2X5bjNnaGMqkP0MIULi1kKjGKNmH1UJTtvBtIoudexnZij0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rN9o9h/K; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-7d2e1a0337bso1799125241.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 09:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706116543; x=1706721343; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CBltU6iTnXDDudf22oqs+fdl0wSad9suT+55PGOStXc=;
        b=rN9o9h/KWg1/LpDIV1oRyPEThG4Vbm/Bhd0Ah+DMNma8z7dj6uaNkvM7m9b/beoYD4
         zVn8DUmsITeB285mxYIemklkepUQF5lDsk9oTJsUjtnA3L5+hb7enAm4owR83bLdX3hZ
         nkO7hJXWonqe2Y8N5y50O1KstNRShMe9dJmOymN1awGpbVKXraY0k4T7flWLgVc17Jn5
         84X4eNwq7Df3D6OhFe1KxkSkOOrsKSNGsk7+h0MQcbGxW62JiJXQJV55G0ETo+lZ5jDM
         /syuMInNCnL0IReoLNS4m3ZSbFUZnadG2yJx95bVArOVl4d+mak7IsXHARuSI4wYy2Mp
         9lqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706116543; x=1706721343;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CBltU6iTnXDDudf22oqs+fdl0wSad9suT+55PGOStXc=;
        b=KazASc6XPi+LlZuJp4vnvZJ2Ncn9tRtcU8AhPmHiJgYktULoA2bguXV5hrjc/HvSkO
         qq8eUC2OW1WO2UeoHXPFRjYMdZgw0sd8ISDam1jXKB4d+WEgnUcJiFGOszedWfHdqxru
         8IUsZd7vRv1/EiI7hqw5LzpQMz/1s3lk6CwLn91nL2C4CV4OGDCBwaEpXlKR4cvSNIzU
         h+UvUo0jIyj8XKMd9n7YdQyeyTq+6n6Bt16CN7X3y+B29ScVkxwpeUCyQmy+hTTORX0i
         OiBYOMEe3C2zEo8Tn0aMZr0kGwYiL7tnh1SUPUzed11SZ9kEUy6E4Uzs7+nybqNDmjY+
         s5nQ==
X-Gm-Message-State: AOJu0Yz494av/rcvVXtdxxGaFrNWl7cnz48JZYOCgcQR9JOOvzPVvsrD
	CEEn2zUBE1JJSnTG5VSF+WYklqzJb0ZQ7OEwxI8WmJy4DT2TO5n7RDNokSabTf3rTssaefosd1P
	nkEtEB4TNf2KbHRCKKoLwR9NqRhg2iA3mYS4k
X-Google-Smtp-Source: AGHT+IHXa1B91nQv5quzIFRRmEI+jn6X4HE0E9upQHh7HSHIAVIGfrH1VLoqq6fnvybWVIGkXPToihp/9GWlCaOxZSc=
X-Received: by 2002:a05:6122:181c:b0:4bd:5537:c9bd with SMTP id
 ay28-20020a056122181c00b004bd5537c9bdmr1784548vkb.12.1706116542805; Wed, 24
 Jan 2024 09:15:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124164211.1141742-1-glider@google.com>
In-Reply-To: <20240124164211.1141742-1-glider@google.com>
From: Marco Elver <elver@google.com>
Date: Wed, 24 Jan 2024 18:15:04 +0100
Message-ID: <CANpmjNP-9hV_d3zEHhUSpdUYpM1BAFKmTTzWwe5o5ubtwTvQAQ@mail.gmail.com>
Subject: Re: [PATCH] mm: kmsan: remove runtime checks from kmsan_unpoison_memory()
To: Alexander Potapenko <glider@google.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kasan-dev@googlegroups.com, 
	Dmitry Vyukov <dvyukov@google.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
	Nicholas Miehlbradt <nicholas@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jan 2024 at 17:42, 'Alexander Potapenko' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> Similarly to what's been done in commit ff444efbbb9be ("kmsan: allow
> using __msan_instrument_asm_store() inside runtime"), it should be safe
> to call kmsan_unpoison_memory() from within the runtime, as it does not
> allocate memory or take locks. Remove the redundant runtime checks.
>
> This should fix false positives seen with CONFIG_DEBUG_LIST=y when
> the non-instrumented lib/stackdepot.c failed to unpoison the memory
> chunks later checked by the instrumented lib/list_debug.c
>
> Also replace the implementation of kmsan_unpoison_entry_regs() with
> a call to kmsan_unpoison_memory().
>
> Signed-off-by: Alexander Potapenko <glider@google.com>
> Cc: Marco Elver <elver@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Ilya Leoshkevich <iii@linux.ibm.com>
> Cc: Nicholas Miehlbradt <nicholas@linux.ibm.com>

Tested-by: Marco Elver <elver@google.com>

Nice - this fixes the false positives I've seen in testing the new
stack depot changes.

But I think this version of the patch wasn't compile-tested, see below.

> ---
>  mm/kmsan/hooks.c | 36 +++++++++++++-----------------------
>  1 file changed, 13 insertions(+), 23 deletions(-)
>
> diff --git a/mm/kmsan/hooks.c b/mm/kmsan/hooks.c
> index 5d6e2dee5692a..8a990cbf6d670 100644
> --- a/mm/kmsan/hooks.c
> +++ b/mm/kmsan/hooks.c
> @@ -359,6 +359,12 @@ void kmsan_handle_dma_sg(struct scatterlist *sg, int nents,
>  }
>
>  /* Functions from kmsan-checks.h follow. */
> +
> +/*
> + * To create an origin, kmsan_poison_memory() unwinds the stacks and stores it
> + * into the stack depot. This may cause deadlocks if done from within KMSAN
> + * runtime, therefore we bail out if kmsan_in_runtime().
> + */
>  void kmsan_poison_memory(const void *address, size_t size, gfp_t flags)
>  {
>         if (!kmsan_enabled || kmsan_in_runtime())
> @@ -371,47 +377,31 @@ void kmsan_poison_memory(const void *address, size_t size, gfp_t flags)
>  }
>  EXPORT_SYMBOL(kmsan_poison_memory);
>
> +/*
> + * Unlike kmsan_poison_memory(), this function can be used from within KMSAN
> + * runtime, because it does not trigger allocations or call instrumented code.
> + */
>  void kmsan_unpoison_memory(const void *address, size_t size)
>  {
>         unsigned long ua_flags;
>
> -       if (!kmsan_enabled || kmsan_in_runtime())
> +       if (!kmsan_enabled)
>                 return;
>
>         ua_flags = user_access_save();
> -       kmsan_enter_runtime();
>         /* The users may want to poison/unpoison random memory. */
>         kmsan_internal_unpoison_memory((void *)address, size,
>                                        KMSAN_POISON_NOCHECK);
> -       kmsan_leave_runtime();
>         user_access_restore(ua_flags);
>  }
>  EXPORT_SYMBOL(kmsan_unpoison_memory);
>
>  /*
> - * Version of kmsan_unpoison_memory() that can be called from within the KMSAN
> - * runtime.
> - *
> - * Non-instrumented IRQ entry functions receive struct pt_regs from assembly
> - * code. Those regs need to be unpoisoned, otherwise using them will result in
> - * false positives.
> - * Using kmsan_unpoison_memory() is not an option in entry code, because the
> - * return value of in_task() is inconsistent - as a result, certain calls to
> - * kmsan_unpoison_memory() are ignored. kmsan_unpoison_entry_regs() ensures that
> - * the registers are unpoisoned even if kmsan_in_runtime() is true in the early
> - * entry code.
> + * Version of kmsan_unpoison_memory() called from IRQ entry functions.
>   */
>  void kmsan_unpoison_entry_regs(const struct pt_regs *regs)
>  {
> -       unsigned long ua_flags;
> -
> -       if (!kmsan_enabled)
> -               return;
> -
> -       ua_flags = user_access_save();
> -       kmsan_internal_unpoison_memory((void *)regs, sizeof(*regs),
> -                                      KMSAN_POISON_NOCHECK);
> -       user_access_restore(ua_flags);
> +       kmsan_unpoison_memory((void *)regs, sizeof(*regs);

missing ')', probably:

+       kmsan_unpoison_memory((void *)regs, sizeof(*regs));

