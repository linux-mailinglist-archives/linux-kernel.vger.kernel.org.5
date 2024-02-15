Return-Path: <linux-kernel+bounces-66399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9AC0855C2E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76C462835FB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E110134C3;
	Thu, 15 Feb 2024 08:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qdMkWYj2"
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34934BA37
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 08:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707985058; cv=none; b=OGMzykEJL0R+FezsSxmgq2SVK2T84/d8hcMmYf82Hkj8Z3gDftim+tAJLMEeekb0WUFYayz+8yWU1Lawp/LvoF7eotsRcDqOktojR1lw1m6ws1B6qrOtGlQRgacuXE2Xgti/bURBgdLMIrUkqfFcEy/2cbbuDOnXsuRBDdGumRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707985058; c=relaxed/simple;
	bh=ObsUxoGxez0LdKV/Ad1hJnJsNNoaFgbnjlFPLPLghAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xet6sZePrbtUZDjRM47ygVYefHwRtm965GpvH9ShaP2toPCzRnjcmovs/i3a6jj5JfVa85UXI8I/1N5N8TCcpX35+r2BrUVxk4uBdvcWikvJ6ct0wE+iH1kFYx1wlxmUfWMk8Mec5fPszPxd/8TP1q43M9uXX68g9Hpm+cxXDw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qdMkWYj2; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-7d5c257452dso243593241.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 00:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707985056; x=1708589856; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fOVmPP6lQ2riMOBP13temKZcA4Pty/mUrj2ihpJln/U=;
        b=qdMkWYj2tOzzuaZtOQ4VRtMlFbD/cXGV4fsEfKG2TFoeILOJaSJAx5DiZUgteWfrhE
         ojpGVscBVDLdYmFzujAOEpRRyIkaVRrMT2IbHFt6jCzDLnIlFaV/GAgcH44XX8aBItyr
         QlTyyTN4AOwCtPh7KUcrwKL6BwjYwuAQPhs3Xm09gk3pnX1IQjFfpvMXkx2diuwcWflD
         aCgfM2Zf03mzj+1U9fF9ESKw6zKnNcJhiEbqJUmkQBlK5jgf4kd7Fmle4REDRDaKOTPd
         bGasJynCMlkc+fe+fP9RR2EAwJL6B7fQ26+2k6a5fpqz+Kf64k8Ods3XyZK4P+0hOFNc
         bKBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707985056; x=1708589856;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fOVmPP6lQ2riMOBP13temKZcA4Pty/mUrj2ihpJln/U=;
        b=Kg/rOgUZusy/ESq8pyNC9G7r1Gka+1ufwrVaHIIxAVRCkm3xZAvY0W4PW3xkCCvm3S
         Ka4Xm0DnLyW6Mr5nS44McgADOgLjvdXj7nxD0NC6EBYbjtejq+vzDvrcL/COdyeL9ntD
         xFWTdimjvrlLGUe5ny098gXz0PWVm5t4OLiEphM0cpnRX2vn2l6IYAlGjx48OoMT6uDr
         DyfZ1vleGMxbDDPqn8rytkCS/FX/gGnbmtNC4Npd91x0noy8XDIiYUCDjEQKZdhIaMix
         gRzcE/zIH+ARFPTrvisgYTNA9/hkx2uhIb62whvpebzYXxXrMH0Y58SLxpo5sN/+LXyW
         SaWg==
X-Forwarded-Encrypted: i=1; AJvYcCWw13tfROvhqN91hIY2koEDjOPUKffdHZdj9j7b0bW/6Cu+Qstl+YhOzAKLMSpgGWK4djQenaPc0AmNT71Qy9PoCTMLsDE9FYY/a8nY
X-Gm-Message-State: AOJu0YxTBVPsZHhlFMusuzDX5DiONoSVly6R9x9Nm7vmarB+ESoPWQt1
	MAACGVpVddjIVJV0lB+roq3H7rdIOV3wVc3U4s9JO/NFLRnoEeJ0JkvzGb/qZX+WU1TGo9M2T2B
	484qY/J8omPk3L6LTBQ/Jg65x+WpEP21Ric5W
X-Google-Smtp-Source: AGHT+IHwqMAMNut0/kXd7nN2WbGlppHAuHdkJ2b3rdaD3wbBRsbiRq7IfGLC/ircqJtgxyn2SxB+ScFA7uw53jct6jA=
X-Received: by 2002:a05:6102:304c:b0:46c:f977:4f9f with SMTP id
 w12-20020a056102304c00b0046cf9774f9fmr1386243vsa.0.1707985055778; Thu, 15 Feb
 2024 00:17:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214170157.17530-1-osalvador@suse.de> <20240214170157.17530-3-osalvador@suse.de>
In-Reply-To: <20240214170157.17530-3-osalvador@suse.de>
From: Marco Elver <elver@google.com>
Date: Thu, 15 Feb 2024 09:16:58 +0100
Message-ID: <CANpmjNPypJM5icG9M5yP5-psSofbA7D35eaKx+E6NyCsHMa=qg@mail.gmail.com>
Subject: Re: [PATCH v9 2/7] lib/stackdepot: Move stack_record struct
 definition into the header
To: Oscar Salvador <osalvador@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Feb 2024 at 18:00, Oscar Salvador <osalvador@suse.de> wrote:
>
> In order to move the heavy lifting into page_owner code, this one
> needs to have access to the stack_record structure, which right now
> sits in lib/stackdepot.c.
> Move it to the stackdepot.h header so page_owner can access
> stack_record's struct fields.
>
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> Reviewed-by: Marco Elver <elver@google.com>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  include/linux/stackdepot.h | 47 ++++++++++++++++++++++++++++++++++++++
>  lib/stackdepot.c           | 45 +-----------------------------------
>  2 files changed, 48 insertions(+), 44 deletions(-)
>
> diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
> index adcbb8f23600..c4b5ad57c066 100644
> --- a/include/linux/stackdepot.h
> +++ b/include/linux/stackdepot.h
> @@ -30,6 +30,53 @@ typedef u32 depot_stack_handle_t;
>   */
>  #define STACK_DEPOT_EXTRA_BITS 5
>
> +#define DEPOT_HANDLE_BITS (sizeof(depot_stack_handle_t) * 8)
> +
> +#define DEPOT_POOL_ORDER 2 /* Pool size order, 4 pages */
> +#define DEPOT_POOL_SIZE (1LL << (PAGE_SHIFT + DEPOT_POOL_ORDER))
> +#define DEPOT_STACK_ALIGN 4
> +#define DEPOT_OFFSET_BITS (DEPOT_POOL_ORDER + PAGE_SHIFT - DEPOT_STACK_ALIGN)
> +#define DEPOT_POOL_INDEX_BITS (DEPOT_HANDLE_BITS - DEPOT_OFFSET_BITS - \
> +                              STACK_DEPOT_EXTRA_BITS)
> +
> +#ifdef CONFIG_STACKDEPOT
> +/* Compact structure that stores a reference to a stack. */
> +union handle_parts {
> +       depot_stack_handle_t handle;
> +       struct {
> +               /* pool_index is offset by 1 */
> +               u32 pool_index  : DEPOT_POOL_INDEX_BITS;
> +               u32 offset      : DEPOT_OFFSET_BITS;
> +               u32 extra       : STACK_DEPOT_EXTRA_BITS;
> +       };
> +};
> +
> +struct stack_record {
> +       struct list_head hash_list;     /* Links in the hash table */
> +       u32 hash;                       /* Hash in hash table */
> +       u32 size;                       /* Number of stored frames */
> +       union handle_parts handle;      /* Constant after initialization */
> +       refcount_t count;
> +       union {
> +               unsigned long entries[CONFIG_STACKDEPOT_MAX_FRAMES];    /* Frames */
> +               struct {
> +                       /*
> +                        * An important invariant of the implementation is to
> +                        * only place a stack record onto the freelist iff its
> +                        * refcount is zero. Because stack records with a zero
> +                        * refcount are never considered as valid, it is safe to
> +                        * union @entries and freelist management state below.
> +                        * Conversely, as soon as an entry is off the freelist
> +                        * and its refcount becomes non-zero, the below must not
> +                        * be accessed until being placed back on the freelist.
> +                        */
> +                       struct list_head free_list;     /* Links in the freelist */
> +                       unsigned long rcu_state;        /* RCU cookie */
> +               };
> +       };
> +};
> +#endif
> +
>  typedef u32 depot_flags_t;
>
>  /*
> diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> index c043a4186bc5..4a661a6777da 100644
> --- a/lib/stackdepot.c
> +++ b/lib/stackdepot.c
> @@ -36,55 +36,12 @@
>  #include <linux/memblock.h>
>  #include <linux/kasan-enabled.h>
>
> -#define DEPOT_HANDLE_BITS (sizeof(depot_stack_handle_t) * 8)
> -
> -#define DEPOT_POOL_ORDER 2 /* Pool size order, 4 pages */
> -#define DEPOT_POOL_SIZE (1LL << (PAGE_SHIFT + DEPOT_POOL_ORDER))
> -#define DEPOT_STACK_ALIGN 4
> -#define DEPOT_OFFSET_BITS (DEPOT_POOL_ORDER + PAGE_SHIFT - DEPOT_STACK_ALIGN)
> -#define DEPOT_POOL_INDEX_BITS (DEPOT_HANDLE_BITS - DEPOT_OFFSET_BITS - \
> -                              STACK_DEPOT_EXTRA_BITS)
>  #define DEPOT_POOLS_CAP 8192
> -/* The pool_index is offset by 1 so the first record does not have a 0 handle. */
> +/* The pool_index is offset by 1 so the first record does not have a 0 handle */

Why this comment change? We lost the '.' -- for future reference, it'd
be good to ensure unnecessary changes don't creep into the diff. This
is just nitpicking, and I've already reviewed this change, so no need
to send a v+1.

