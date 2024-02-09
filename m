Return-Path: <linux-kernel+bounces-59083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1235484F0FB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 08:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8880D2840DC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 07:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E9D65BA4;
	Fri,  9 Feb 2024 07:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="evfNTXsM"
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA22657CA
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 07:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707464739; cv=none; b=UbjHeu6IknntQUuw7lzbjIbFrT8Za2L+HbNDOKzYtFX/oc8NTDGYtQRU+qlMJk5q0CbCiLC92N8FuwDAjlotzP4nQNpxNSSZ6mzepAiteSJ2oP7ooqnTUZYzc4yx5XVcbxkmCYCAwCczipv6PFwZF4cFYK9qoem2AzdkYZ9eKtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707464739; c=relaxed/simple;
	bh=LXIhGDJdpN24GA1EQPDtSZXl8Z1b0LQ0pvmd24qKkgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qiokLKirOe/cVBUefulq9MEx73znlGMTrUL62vvTCGBiZezm1MD8RTcT7jhHD9ek97Wuq54DiDD7o7xbFDnwqHoCc2IeAFJObHw7Z8tKZ0K+R+XO+qg0tzPk4KAz766tT0fOSHJXjAnJKliMmnlzkKUcoTgdL0rT9JuT44QJI00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=evfNTXsM; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-7d5c40f874aso285775241.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 23:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707464736; x=1708069536; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0ySHx2nX99jANk38wSw2X6YUAqeLte8C5K6rXWwBJss=;
        b=evfNTXsMaMmloCZZMNaac6RVmYkWO9NNB7v3KhQg11COQ0fB3sjLLwpn1tS0a3prS8
         AI0IxdNqvUBxzSoVi2KzBXe07+n2mHYPTHDfuR2ligNeaalvSPDqMXn/TfDPJsgLJPos
         bvwq/cEPyCfV0MUbBsJHM6Vgibtr89hT9iyrDv/FRN7hlR8FF/qvCreIUKnE7sCo0Vdr
         rFJfdoEyL8VpNaVzyfxemb+gB4lXjF5Ksges4kIZOL6tHKGTFnp33/FpB3pc+c73aUTI
         fENSZW8owfM/XqEoiPCgml6p3g2I7NJmxCdvGM7k8MYHCrMYDCQV1/Gn26wq/XO5BuqO
         c67g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707464736; x=1708069536;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0ySHx2nX99jANk38wSw2X6YUAqeLte8C5K6rXWwBJss=;
        b=p3qbSfVEO/aWgvtntXiS7qZIufO/EyvAvIyNPBeCbACcrAJbym9vSErjxLTWVMgnwn
         +lc56pxGkskL6CEyu1Ss8tpOM1Aiyy42HurWX3Ugelw3K7hESmMIr3r1PFSawTWplMyO
         P5Yf1RPY5XYMKK2eYdyXheNU9wHjFz4xWmfl64EVFfvRyLUOopJ/kiivQxX9ExjCZX3x
         UMZ23OzrLv3yMATPXm+QDUdYuxZAc+quEdXauFj9Dn6+qvFcOH4aX6f2PEdqWrgRiZK3
         RfbAWwg+PS3xXmEZvuDQXFhZbWEwx3dPe/qzFc76334eXqC6bVKs0Y1CU6XGQOny33Uy
         Ow3g==
X-Forwarded-Encrypted: i=1; AJvYcCW9kqxVdHdXSaw/iIkluWd4ALZu5N79liuphWVxPD9LhKJpcKOQzY/WxTtDoQDcFqe3cbjN6C3V5PH9kQxlEfUA9VqytL2Ve+hsHCUX
X-Gm-Message-State: AOJu0YxlXNylHSTFaMnZDe3+QvTOOEg0T2uGK4qF9ndY7JkIgXXzzVE0
	2pBlMlTNNopWtGzAgRTs4E2pU6sJsyHGDLeApBSdSexRQyvPkElWEQ1FtDhtqXNIAi3AsrxNcR8
	SFy5admxgrEQNkrMc9ocmO5Vv7wIKkxenaRsh
X-Google-Smtp-Source: AGHT+IE/bOWjTKOfxopm+i5SliWnQ844cTtmltS+m8uqJnBwiElhddYM8CtAG6EvXsaEYiZQi+AbzxJ6cwp1cdw7ehc=
X-Received: by 2002:a05:6102:5590:b0:46d:2121:6939 with SMTP id
 dc16-20020a056102559000b0046d21216939mr780588vsb.23.1707464736329; Thu, 08
 Feb 2024 23:45:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208234539.19113-1-osalvador@suse.de> <20240208234539.19113-3-osalvador@suse.de>
In-Reply-To: <20240208234539.19113-3-osalvador@suse.de>
From: Marco Elver <elver@google.com>
Date: Fri, 9 Feb 2024 08:45:00 +0100
Message-ID: <CANpmjNOoYC93dt5hNmWsC2N8-7GuSp2L6Lb7mNOKxTGhreceUg@mail.gmail.com>
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

Typo: "depo" -> depot

I would also write "stack_record struct", because "stack struct" does not exist.

> + * @handle: Stack depot handle
> + *
> + * Return: Returns a pointer to a stack struct
> + */
> +struct stack_record *stack_depot_get_stack(depot_stack_handle_t handle);

I don't know what other usecases there are for this, but I'd want to
make make sure we give users a big hint to avoid unnecessary uses of
this function.

Perhaps we also want to mark it as somewhat internal, e.g. by
prefixing it with __. So I'd call it __stack_depot_get_stack_record().

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

In the latest stackdepot version in -next, the count is initialized to
REFCOUNT_SATURATED to warn if a non-refcounted entry is suddenly used
as a refcounted one. In your case this is intentional and there is no
risk that the entry will be evicted, so that's ok. But you need to set
the refcount to 1 somewhere here on the initial stack_depot_save().

