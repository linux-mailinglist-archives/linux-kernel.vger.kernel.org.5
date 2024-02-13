Return-Path: <linux-kernel+bounces-63113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB31852B15
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95DE128428F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2751B7EB;
	Tue, 13 Feb 2024 08:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EpZZlrii"
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A4F1B59C
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 08:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707812810; cv=none; b=ogyONe/V+ncc6JVIE1qbGtUBMjxXFe/FgMf3YjqK9dWgTa0uYGtNMVx9iEio8Vna8C6JNpj7PqYeQaTiE/29V0thjzD390v+bFQPy1x8f4fF19dHLDd4hzlWemYK7Kf4RzlQjfC97R04VFI9AzF6psIxEpoJWYrdSbvKj/ZtYbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707812810; c=relaxed/simple;
	bh=DL1fkvDbFAaK7P+C2/wxWDrqxiVea9Y59PrWuI3igvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rug1wFeRhqLNkFHBq2n8f0hab0N7QJwiq+nzhIE4PrEPWzTDbegFs9ZGRnIitfrUpeSTr1RfkTTT3x/5RRbIoCfdxKTnT7c2GhdcEZUC7OpXsf+cS96mqY77CH/tf6MtgwRqxIy27WqYoTCpfgxrSt4fHmeDngd2JKpuVJvkip0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EpZZlrii; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-4c0215837e2so743434e0c.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 00:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707812808; x=1708417608; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sxi4daiMjo969D0hS7+XvRJwRmcr6gtaf2stlPB/TO4=;
        b=EpZZlrii5bjJUxGH/PNo0jDLgrm70s0Xi69jeAAmuyyx1P5WZadF/8Q+MfKl5F2h+0
         j5Y5b0F01a3Ose7eTF9ezGkZcd1GI00dIbNq6Iz1OSMb0Mlx39XAhSP78+ITshj6KIkL
         DLL09jBhtY5k7CQxn4rRrD8ezkSzLYFy0nzB/0udGShZPz7xccqemrnUAtJuBA9ssmXU
         +T48qoPxxqSPM1H4Gj6sthDIbNJPQad0nQjVPgP6sfv7JJWeBFuAl4Yy4DPaugGwv51Y
         RmlwiTipxV/4O60GfCE2a21e7tbav+2+YOiDXb5VljOKu/ToIYXXmjxH+e6ZLCLaEBHw
         QomQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707812808; x=1708417608;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sxi4daiMjo969D0hS7+XvRJwRmcr6gtaf2stlPB/TO4=;
        b=SqYssf8l8TwA3Bp5HRu83plSH/waSx5wienu/5+c4ejdMRY3v5yfl7pK/RMACr1A4l
         i82mTWq921A7Mx27N19Ge8QDYXYEmN9DxL80d+I+/56yRsB1cFHfsIQP3qfQamVY68rL
         0l5zxkzxeF0KlCF66F2BmPWFXVnlD5mTfxp1+u2l0utmZNV/qdKZ1pnYT/RQgVJMazIF
         hkOxIKiCj/ri5V5Jda5f/eSpYnHFWeP4V5c6Ed+xXb3KT5tL2h8ZFSHnmd+0GOHsCoI1
         h+lW6HgEYR9tpNXrgMn7KM2SXXnqY6BPy5mA/ibeLhO5eqnfkYIfAheEwtcj11h1EAk5
         w66A==
X-Gm-Message-State: AOJu0YwH2dIf8eycvaNGSfPyDAbh9tzbMUTN76cQixLLGdAtII9IUZoP
	CVAifTVmEIJoRmsC0uYBy7kBFlpNTDEAIZOVachgoQ8eDsQSTUfSu/5zZI20IVafYBEkgo9RvH9
	Zji5g78vYqXBt2w5J1BC1uMy4gAsDI12oC/95
X-Google-Smtp-Source: AGHT+IGNTtXt2kUxA+0n34KgEgcHDIJnieHa2LH69jAMYeuLQqAzXKRYR4SbtE8rXY9uLIH5xG5rW/ZnsEHPjyOOGQ0=
X-Received: by 2002:a1f:6744:0:b0:4c0:7d26:58da with SMTP id
 m4-20020a1f6744000000b004c07d2658damr4139220vki.2.1707812807507; Tue, 13 Feb
 2024 00:26:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212223029.30769-1-osalvador@suse.de> <20240212223029.30769-2-osalvador@suse.de>
In-Reply-To: <20240212223029.30769-2-osalvador@suse.de>
From: Marco Elver <elver@google.com>
Date: Tue, 13 Feb 2024 09:26:09 +0100
Message-ID: <CANpmjNMnobv_KRnas6pfe0NKUbrOgRocN134yq3-0ODmsc3-nw@mail.gmail.com>
Subject: Re: [PATCH v8 1/5] lib/stackdepot: Move stack_record struct
 definition into the header
To: Oscar Salvador <osalvador@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 12 Feb 2024 at 23:29, Oscar Salvador <osalvador@suse.de> wrote:
>
> In order to move the heavy lifting into page_owner code, this one
> needs to have access to the stack_record structure, which right now
> sits in lib/stackdepot.c.
> Move it to the stackdepot.h header so page_owner can access
> stack_record's struct fields.
>
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  include/linux/stackdepot.h | 44 ++++++++++++++++++++++++++++++++++++++
>  lib/stackdepot.c           | 43 -------------------------------------
>  2 files changed, 44 insertions(+), 43 deletions(-)
>
> diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
> index adcbb8f23600..90274860fd8e 100644
> --- a/include/linux/stackdepot.h
> +++ b/include/linux/stackdepot.h
> @@ -30,6 +30,50 @@ typedef u32 depot_stack_handle_t;
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
> +/* Compact structure that stores a reference to a stack. */
> +union handle_parts {
> +       depot_stack_handle_t handle;
> +       struct {
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
> +
>  typedef u32 depot_flags_t;
>
>  /*
> diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> index 4a7055a63d9f..6f9095374847 100644
> --- a/lib/stackdepot.c
> +++ b/lib/stackdepot.c
> @@ -36,54 +36,11 @@
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
>  #define DEPOT_MAX_POOLS \
>         (((1LL << (DEPOT_POOL_INDEX_BITS)) < DEPOT_POOLS_CAP) ? \
>          (1LL << (DEPOT_POOL_INDEX_BITS)) : DEPOT_POOLS_CAP)
>
> -/* Compact structure that stores a reference to a stack. */
> -union handle_parts {
> -       depot_stack_handle_t handle;
> -       struct {
> -               u32 pool_index  : DEPOT_POOL_INDEX_BITS;
> -               u32 offset      : DEPOT_OFFSET_BITS;
> -               u32 extra       : STACK_DEPOT_EXTRA_BITS;
> -       };
> -};
> -
> -struct stack_record {
> -       struct list_head hash_list;     /* Links in the hash table */
> -       u32 hash;                       /* Hash in hash table */
> -       u32 size;                       /* Number of stored frames */
> -       union handle_parts handle;      /* Constant after initialization */
> -       refcount_t count;
> -       union {
> -               unsigned long entries[CONFIG_STACKDEPOT_MAX_FRAMES];    /* Frames */
> -               struct {
> -                       /*
> -                        * An important invariant of the implementation is to
> -                        * only place a stack record onto the freelist iff its
> -                        * refcount is zero. Because stack records with a zero
> -                        * refcount are never considered as valid, it is safe to
> -                        * union @entries and freelist management state below.
> -                        * Conversely, as soon as an entry is off the freelist
> -                        * and its refcount becomes non-zero, the below must not
> -                        * be accessed until being placed back on the freelist.
> -                        */
> -                       struct list_head free_list;     /* Links in the freelist */
> -                       unsigned long rcu_state;        /* RCU cookie */
> -               };
> -       };
> -};
> -
>  static bool stack_depot_disabled;
>  static bool __stack_depot_early_init_requested __initdata = IS_ENABLED(CONFIG_STACKDEPOT_ALWAYS_INIT);
>  static bool __stack_depot_early_init_passed __initdata;
> --
> 2.43.0
>

