Return-Path: <linux-kernel+bounces-63125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B97852B3E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11D471F23577
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F001182D2;
	Tue, 13 Feb 2024 08:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xU4ZwmkL"
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA29134CB
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 08:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707813064; cv=none; b=X/lU+nNalnfaF4HDX3o48W/C5Pzu+cWk2zhoqw7c9XbtV/a0OvB8u0JrgPoNplvOmEpvER9DKRsiP9PCUJ9uwMB+xbFxosm3Kbv5DPoTwBVKKJZmI/QeMKe2Q1T4RRpb/Nere2+AogX3NgdHtajlJaH3sLUwxXNssxdw/9kSHE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707813064; c=relaxed/simple;
	bh=B488vyl8pabc01O0uX7dySNBwLEZhjtj177lXeqiO+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=stw315jHU+e2eNCGEjY7+FuRIJYsL63klDf5lwln2krzQTXW0KR8LfpRiVr2Dq8kYIungygqKi3/PawGiYf74/Wh8KUkx/2/7+QuqpNav9PoTzonPiq46KXUwXvRoZ0fIPPoYhzSKmE3nqFH9y+Nfs6PdvXoWDMxXn5FdUrkt+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xU4ZwmkL; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-46d7a67d751so232173137.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 00:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707813061; x=1708417861; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EiWyDX8gZQ5GT1eLZA5ntSQqn41f+SSf5JGmboV5GBo=;
        b=xU4ZwmkLT5m6W2lfCsd1HVrjekT3uQRn6v7Be7rVPT6vl6F5a0F6nuAn55jrU+rOxh
         b1R48VQ+NKFgAsSFf0ugFbpXtu8K+dvKfjErMbBM0lO1dV5LDhhBnfWcm6zivqeNtff/
         wvZ/7M1sVz7WvAxhnbi52PeoSjLg70/h2HqH0Uxv7NC+PxN/idb/L9j8IY11ZP/U9Eg7
         kG/l1au5ADcrd2qxfKyKq9QDF3yITpOdhUfL1/K4ML58zIATEIEBnflrSVir5om1dF/H
         FfoPaA95wVd1hIkP2WpMvo3ynKJVaA1oJSERsKtoSKQszbJmjTb4lNt8PDTyoNM1IPYc
         iV0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707813061; x=1708417861;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EiWyDX8gZQ5GT1eLZA5ntSQqn41f+SSf5JGmboV5GBo=;
        b=JItByxhyBtTIrmWyQ/SAPM7IPsAqcdcP1WcM4T/IKltvfCCFXKPnIk5YDw+XRmGSWY
         PZLamMDcD3W8xqDZnWIaTJOFSJDjiKM+sjPpcfH/k2Ayv1xZdYgqmSUZzZVMzR3xC79K
         Um/iR6L/HGQinapgg8J8Ks5lkAEYQi2TYxjaJGVvSoLUqLnX+BEgYJo5y2/e9/2y8MN8
         y1JnPdeOVTNQQLeHPAdNfBebPc0LxVz4CHH07+/Rfx6M8yw8R3e0fEdL0LipEhN351oq
         HP1ktd9zHqtz5oK0sOm5tQ1tV8h3SBDykLikxd92KQd5FG+p3aN7peuu2U8Eqs6knY1w
         Ivpw==
X-Forwarded-Encrypted: i=1; AJvYcCVFxKE0re7S5FcNB4HFqXJU97G01wSVdbgk64JWq2vq7yK3+ywie36m3FVbmidjvMyHIF3vbbGr9Yd13abMt8lsoYQVnK/m+vrv21E8
X-Gm-Message-State: AOJu0YzasoXfe05IIaZ1sNvh5aQInn8oNti/WtAeiTVax4rJ573HwyI7
	lJZCJL9lmDa+YRxHqMay62h6BTHF8ddKnndC8CKc0E5Vb5vbNA/GmYl/IAm6FR3jwJu8ZtNPi3l
	xnt3yKCHPlmQSJpsQw0IxA8i6u6GLUV/keOJ4JJglmx9C4+DcXDkE
X-Google-Smtp-Source: AGHT+IHJeM5sDvTlXvVffHHRpIV6W5kCTGGavnEnHCHDrtF2b+J/gj3+DI8aNndCTcTyifNRLqP/JqLU4eJQ/tBr5q4=
X-Received: by 2002:a67:eb42:0:b0:46a:f7e0:e6a3 with SMTP id
 x2-20020a67eb42000000b0046af7e0e6a3mr6755456vso.24.1707813061441; Tue, 13 Feb
 2024 00:31:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212223029.30769-1-osalvador@suse.de> <20240212223029.30769-3-osalvador@suse.de>
In-Reply-To: <20240212223029.30769-3-osalvador@suse.de>
From: Marco Elver <elver@google.com>
Date: Tue, 13 Feb 2024 09:30:25 +0100
Message-ID: <CANpmjNOaUdBOX1z1TST5djOLuL2DWj1Vus=ot_F_e_-8am3qZQ@mail.gmail.com>
Subject: Re: [PATCH v8 2/5] mm,page_owner: Implement the tracking of the
 stacks count
To: Oscar Salvador <osalvador@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 12 Feb 2024 at 23:29, Oscar Salvador <osalvador@suse.de> wrote:
>
> page_owner needs to increment a stack_record refcount when a new allocation
> occurs, and decrement it on a free operation.
> In order to do that, we need to have a way to get a stack_record from a
> handle.
> Implement __stack_depot_get_stack_record() which just does that, and make
> it public so page_owner can use it.
>
> Also implement {inc,dec}_stack_record_count() which increments
> or decrements on respective allocation and free operations, via
> __reset_page_owner() (free operation) and __set_page_owner() (alloc
> operation).
>
> Traversing all stackdepot buckets comes with its own complexity,
> plus we would have to implement a way to mark only those stack_records
> that were originated from page_owner, as those are the ones we are
> interested in.
> For that reason, page_owner maintains its own list of stack_records,
> because traversing that list is faster than traversing all buckets
> while keeping at the same time a low complexity.
> inc_stack_record_count() is responsible of adding new stack_records
> into the list stack_list.
>
> Modifications on the list are protected via a spinlock with irqs
> disabled, since this code can also be reached from IRQ context.
>
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

For the code:

Reviewed-by: Marco Elver <elver@google.com>

But see minor comments below.

> ---
>  include/linux/stackdepot.h |  9 +++++
>  lib/stackdepot.c           |  8 +++++
>  mm/page_owner.c            | 73 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 90 insertions(+)
>
> diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
> index 90274860fd8e..f3c2162bf615 100644
> --- a/include/linux/stackdepot.h
> +++ b/include/linux/stackdepot.h
> @@ -175,6 +175,15 @@ depot_stack_handle_t stack_depot_save_flags(unsigned long *entries,
>  depot_stack_handle_t stack_depot_save(unsigned long *entries,
>                                       unsigned int nr_entries, gfp_t gfp_flags);
>
> +/**
> + * __stack_depot_get_stack_record - Get a pointer to a stack_record struct
> + * This function is only for internal purposes.

I think the body of the kernel doc needs to go after argument declarations.

> + * @handle: Stack depot handle
> + *
> + * Return: Returns a pointer to a stack_record struct
> + */
> +struct stack_record *__stack_depot_get_stack_record(depot_stack_handle_t handle);
> +
>  /**
>   * stack_depot_fetch - Fetch a stack trace from stack depot
>   *
> diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> index 6f9095374847..fdb09450a538 100644
> --- a/lib/stackdepot.c
> +++ b/lib/stackdepot.c
> @@ -685,6 +685,14 @@ depot_stack_handle_t stack_depot_save(unsigned long *entries,
>  }
>  EXPORT_SYMBOL_GPL(stack_depot_save);
>
> +struct stack_record *__stack_depot_get_stack_record(depot_stack_handle_t handle)
> +{
> +       if (!handle)
> +               return NULL;
> +
> +       return depot_fetch_stack(handle);
> +}
> +
>  unsigned int stack_depot_fetch(depot_stack_handle_t handle,
>                                unsigned long **entries)
>  {
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index 5634e5d890f8..7d1b3f75cef3 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -36,6 +36,14 @@ struct page_owner {
>         pid_t free_tgid;
>  };
>
> +struct stack {
> +       struct stack_record *stack_record;
> +       struct stack *next;
> +};
> +
> +static struct stack *stack_list;
> +static DEFINE_SPINLOCK(stack_list_lock);
> +
>  static bool page_owner_enabled __initdata;
>  DEFINE_STATIC_KEY_FALSE(page_owner_inited);
>
> @@ -61,6 +69,57 @@ static __init bool need_page_owner(void)
>         return page_owner_enabled;
>  }
>
> +static void add_stack_record_to_list(struct stack_record *stack_record)
> +{
> +       unsigned long flags;
> +       struct stack *stack;
> +
> +       stack = kmalloc(sizeof(*stack), GFP_KERNEL);
> +       if (stack) {

It's usually more elegant to write

if (!stack)
  return;

If the rest of the function is conditional.

> +               stack->stack_record = stack_record;
> +               stack->next = NULL;
> +
> +               spin_lock_irqsave(&stack_list_lock, flags);
> +               if (!stack_list) {
> +                       stack_list = stack;
> +               } else {
> +                       stack->next = stack_list;
> +                       stack_list = stack;
> +               }
> +               spin_unlock_irqrestore(&stack_list_lock, flags);
> +       }
> +}
> +
> +static void inc_stack_record_count(depot_stack_handle_t handle)
> +{
> +       struct stack_record *stack_record = __stack_depot_get_stack_record(handle);
> +
> +       if (stack_record) {
> +               /*
> +                * New stack_record's that do not use STACK_DEPOT_FLAG_GET start
> +                * with REFCOUNT_SATURATED to catch spurious increments of their
> +                * refcount.
> +                * Since we do not use STACK_DEPOT_FLAG_{GET,PUT} API, let us

I think I mentioned this in the other email, there is no
STACK_DEPOT_FLAG_PUT, only stack_depot_put().

> +                * set a refcount of 1 ourselves.
> +                */
> +               if (refcount_read(&stack_record->count) == REFCOUNT_SATURATED) {
> +                       refcount_set(&stack_record->count, 1);
> +
> +                       /* Add the new stack_record to our list */
> +                       add_stack_record_to_list(stack_record);
> +               }
> +               refcount_inc(&stack_record->count);
> +       }
> +}
> +
> +static void dec_stack_record_count(depot_stack_handle_t handle)
> +{
> +       struct stack_record *stack_record = __stack_depot_get_stack_record(handle);
> +
> +       if (stack_record)
> +               refcount_dec(&stack_record->count);
> +}
> +
>  static __always_inline depot_stack_handle_t create_dummy_stack(void)
>  {
>         unsigned long entries[4];
> @@ -140,6 +199,7 @@ void __reset_page_owner(struct page *page, unsigned short order)
>         int i;
>         struct page_ext *page_ext;
>         depot_stack_handle_t handle;
> +       depot_stack_handle_t alloc_handle;
>         struct page_owner *page_owner;
>         u64 free_ts_nsec = local_clock();
>
> @@ -147,6 +207,9 @@ void __reset_page_owner(struct page *page, unsigned short order)
>         if (unlikely(!page_ext))
>                 return;
>
> +       page_owner = get_page_owner(page_ext);
> +       alloc_handle = page_owner->handle;
> +
>         handle = save_stack(GFP_NOWAIT | __GFP_NOWARN);
>         for (i = 0; i < (1 << order); i++) {
>                 __clear_bit(PAGE_EXT_OWNER_ALLOCATED, &page_ext->flags);
> @@ -158,6 +221,15 @@ void __reset_page_owner(struct page *page, unsigned short order)
>                 page_ext = page_ext_next(page_ext);
>         }
>         page_ext_put(page_ext);
> +       if (alloc_handle != early_handle)
> +               /*
> +                * early_handle is being set as a handle for all those
> +                * early allocated pages. See init_pages_in_zone().
> +                * Since their refcount is not being incremented because
> +                * the machinery is not ready yet, we cannot decrement
> +                * their refcount either.
> +                */
> +               dec_stack_record_count(alloc_handle);
>  }
>
>  static inline void __set_page_owner_handle(struct page_ext *page_ext,
> @@ -199,6 +271,7 @@ noinline void __set_page_owner(struct page *page, unsigned short order,
>                 return;
>         __set_page_owner_handle(page_ext, handle, order, gfp_mask);
>         page_ext_put(page_ext);
> +       inc_stack_record_count(handle);
>  }
>
>  void __set_page_owner_migrate_reason(struct page *page, int reason)
> --
> 2.43.0
>

