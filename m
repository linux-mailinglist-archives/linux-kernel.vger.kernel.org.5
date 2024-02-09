Return-Path: <linux-kernel+bounces-59078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4797E84F0E7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 08:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF6101F25BF7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 07:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A4B657DE;
	Fri,  9 Feb 2024 07:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fMlUX4ke"
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7971F657D4
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 07:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707464307; cv=none; b=Iji74tH3oItRMGryWDUJCWWZBXRR9jHaSDM1wk3mq09tNyfR/T/EA07z+Jmqcr6/QN6mpV8CdBlX6iMW4Sb3zSHAUKyrScAWvNoQgk+CVkwqhDzhlC6LEqZ0R+F4AZHQbbCPP/NZ4XKrmF1XOgo+wqvF8UKhYyrxWk1L2xTE3WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707464307; c=relaxed/simple;
	bh=lSCOLULtnZ9nIeeeVwpRw5P25YMreiv80ftFqd+arzY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cvSZTCCQyylnuRNa2TtOamTJJ0PW8hdB7QMOMEyZrbjyQcX2MVs3vy4782xi+38ghUro+0XTShqedP45rMzUc3ikHWMYe61yWBCGQMjFbGGcFCRW08V1ffghQuONXFr++HFXsSfkHDrtwsQYvMD7xJj2znJLYW6gmDBBEg4KXGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fMlUX4ke; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-4c022adaa88so152951e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 23:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707464304; x=1708069104; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SRlv7V7FElgbzeYr1VtPdkh39UXXVbDIkm1KlhC6yfU=;
        b=fMlUX4ke3f4szTQ62suYgxtKx/I+2wp1prFcEz4+/0jWaLAykMerQL9sUgpYVJ32F8
         o7YtH3wCgIeSxHgO7lrXLmbFSRrEZY5L8od/g8Gf3gU2ziLYUu4gwRWPx1wZGIsJGvt/
         h1eFgKogtoGKvJBxv2xRt3B8bgyw10mLOenobjJvImeiNWA5ZTeK8NdS3+8SehTbuQ+m
         T+jDVf+GZKjYQ+F3QdJE4SmswrKNt2rYdIW81QIkRdJaLrs06FUSawY9vOcNW7r+K5uB
         DknHmXIQuu+YruleIGY6TqdTThlba3nHTNYj/VJyrUrd2sR/QDdCcM6+SMWEx4lo6nj4
         PgpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707464304; x=1708069104;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SRlv7V7FElgbzeYr1VtPdkh39UXXVbDIkm1KlhC6yfU=;
        b=AqrKHqDOqv1kn8Oa/RysM0w8ueAB7o5KCm+oh7oRQAvKxBwsG7kdrGXydXXYkSvU6p
         BWW+1ik+pNYY5YcxbztMNVnTPIkjQm3jjqmy5BbiWTni/eGwVNuhOxrYm22tA+Mvwr5W
         b3VAPQULBPeXqGZk2RymEaCSYdxOni/pF730vudfi1ZEan1YbZT76yQW+4p3sbUocJwY
         ShpmYpBKYDWvbG/Jqim2B6cMDOCBRXmH5n7xRorh6Ip5oKgoDD4xBp1B/o972XEtG7kr
         rXriI9yo9Rg4hH8+LfS6fTRts1pFzFVzriTvQh8a2KkatFNrl9ygn9WSb7uUOjbTg3+1
         9WXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHY3uSbUYUqNAaooMroihw4Ic5J00ylykxZc0zMTv+ULiafhe1SIdwONO4h7ZKWmosM2djKskNWNnWVOKZlcXy/h1LnQ2EFPM2L6N3
X-Gm-Message-State: AOJu0Yw0/nDIsH34qrGJSdQ2E/8pfAtXDHJGmeW84aRjoinpqqf4Nrl0
	e3FwQjMCNkk+9XUxjkuvD3Kv0z07QtFYtp0/zf4S4dKwSnvzH0k9rUpbeiCKSl/LgZEsx6+SGd0
	EuIJrFXsykIOu8LU+6BLFo9irFI8XkY6DuA8PTooVWcOUh7WXFA==
X-Google-Smtp-Source: AGHT+IEu6DIN2XhxMjFllmU69QGQ/h0eOIqex2NbtE8sfnoKt/074UjDwM+94GUpewb+4IJMg+ZYlcNa2TU+Ehh+Qng=
X-Received: by 2002:a05:6102:21d0:b0:46d:3208:aec9 with SMTP id
 r16-20020a05610221d000b0046d3208aec9mr406460vsg.8.1707464304111; Thu, 08 Feb
 2024 23:38:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208234539.19113-1-osalvador@suse.de> <20240208234539.19113-3-osalvador@suse.de>
In-Reply-To: <20240208234539.19113-3-osalvador@suse.de>
From: Marco Elver <elver@google.com>
Date: Fri, 9 Feb 2024 08:37:46 +0100
Message-ID: <CANpmjNO-WUWZS+FDePsUFeAAEZw-=oMgV4EVCZgGtYzQVfNcsQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/4] mm,page_owner: Implement the tracking of the
 stacks count
To: Oscar Salvador <osalvador@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 Feb 2024 at 00:45, Oscar Salvador <osalvador@suse.de> wrote:
>
> page_owner needs to increment a stack_record refcount when a new allocation
> occurs, and decrement it on a free operation.
> In order to do that, we need to have a way to get a stack_record from a
> handle.
> Implement stack_depot_get_stack() which just does that, and make it public
> so page_owner can use it.
>
> Also implement {inc,dec}_stack_record_count() which increments
> or decrements on respective allocation and free operations, via
> __reset_page_owner() (free operation) and __set_page_owner() (alloc
> operation).
>
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>  include/linux/stackdepot.h |  8 ++++++++
>  lib/stackdepot.c           |  8 ++++++++
>  mm/page_owner.c            | 30 ++++++++++++++++++++++++++++++
>  3 files changed, 46 insertions(+)
>
> diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
> index d0dcf4aebfb4..ac62de4d4999 100644
> --- a/include/linux/stackdepot.h
> +++ b/include/linux/stackdepot.h
> @@ -175,6 +175,14 @@ depot_stack_handle_t stack_depot_save_flags(unsigned long *entries,
>  depot_stack_handle_t stack_depot_save(unsigned long *entries,
>                                       unsigned int nr_entries, gfp_t gfp_flags);
>
> +/**
> + * stack_depo_get_stack - Get a pointer to a stack struct
> + * @handle: Stack depot handle
> + *
> + * Return: Returns a pointer to a stack struct
> + */



> +struct stack_record *stack_depot_get_stack(depot_stack_handle_t handle);
> +
>  /**
>   * stack_depot_fetch - Fetch a stack trace from stack depot
>   *
> diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> index 16c8a1bf0008..197c355601f9 100644
> --- a/lib/stackdepot.c
> +++ b/lib/stackdepot.c
> @@ -681,6 +681,14 @@ depot_stack_handle_t stack_depot_save(unsigned long *entries,
>  }
>  EXPORT_SYMBOL_GPL(stack_depot_save);
>
> +struct stack_record *stack_depot_get_stack(depot_stack_handle_t handle)
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
> index 5634e5d890f8..0adf41702b9d 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -61,6 +61,22 @@ static __init bool need_page_owner(void)
>         return page_owner_enabled;
>  }
>
> +static void inc_stack_record_count(depot_stack_handle_t handle)
> +{
> +       struct stack_record *stack = stack_depot_get_stack(handle);
> +
> +       if (stack)
> +               refcount_inc(&stack->count);
> +}
> +
> +static void dec_stack_record_count(depot_stack_handle_t handle)
> +{
> +       struct stack_record *stack = stack_depot_get_stack(handle);
> +
> +       if (stack)
> +               refcount_dec(&stack->count);
> +}
> +
>  static __always_inline depot_stack_handle_t create_dummy_stack(void)
>  {
>         unsigned long entries[4];
> @@ -140,6 +156,7 @@ void __reset_page_owner(struct page *page, unsigned short order)
>         int i;
>         struct page_ext *page_ext;
>         depot_stack_handle_t handle;
> +       depot_stack_handle_t alloc_handle;
>         struct page_owner *page_owner;
>         u64 free_ts_nsec = local_clock();
>
> @@ -147,6 +164,9 @@ void __reset_page_owner(struct page *page, unsigned short order)
>         if (unlikely(!page_ext))
>                 return;
>
> +       page_owner = get_page_owner(page_ext);
> +       alloc_handle = page_owner->handle;
> +
>         handle = save_stack(GFP_NOWAIT | __GFP_NOWARN);
>         for (i = 0; i < (1 << order); i++) {
>                 __clear_bit(PAGE_EXT_OWNER_ALLOCATED, &page_ext->flags);
> @@ -158,6 +178,15 @@ void __reset_page_owner(struct page *page, unsigned short order)
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
> @@ -199,6 +228,7 @@ noinline void __set_page_owner(struct page *page, unsigned short order,
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

