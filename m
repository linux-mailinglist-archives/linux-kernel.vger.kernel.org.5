Return-Path: <linux-kernel+bounces-59084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3421284F0FC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 08:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E111B23AA6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 07:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED43A65BAD;
	Fri,  9 Feb 2024 07:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uSpu/J+7"
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85155657DA
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 07:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707464761; cv=none; b=FCJblMPxgsHeM2dvKoTKN0zGrB98yupMZDEEbvfedNyR+gy1S2MsLfRIgl3qXuClwqoWKIXFJz4hlffCNtnGrduazgVl1x3rUknlSfcky2uN8wW9pm61heHTIKPrC7xdgcIAFqt0qlHT+NL8wy/tZ+OInzyKq1jqx7LnRxM/ZBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707464761; c=relaxed/simple;
	bh=eTIwtSQ2nu2DzmbaloUx2RHR94ej1My9IhiHqA1fgvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ukCjmK4EwxBw+M6PMqHNqvCQCHU+gE3Z/7YjEVOpwZ3NayffBwSjApyRZsvEbIacPAhsj4+stGCFe8P6JfbQsFRY5FzNUpN7y1kxneonsMvc9GTPYXVsZgR1S17Ks/DTZFMgkKfPvij6rbUPg2gAMxzdr4fROSq3HkjF4aTGAJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uSpu/J+7; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-4affeacaff9so183436e0c.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 23:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707464758; x=1708069558; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fLYosVJBxJJ3XJbpjWGEbQR6KVWU5Ojl+eaZgpRroOc=;
        b=uSpu/J+7JYrygB5Ct4+U5D7jHWBjGnisYyQlsnBh1b2fvLkFdghoUbizA300y+FSfR
         LHvqFwen0jHN+Pi25lRJo60J3UR0BL4FzFfk+Ei80mkP5nPvFA2Rj9aMvkqYw0MqVIfP
         gHjemRlZMeztlel+72FtNcBrJpyFR0lJsxlPGNjgpOHZ057AWVJPA6zqih3aZ0/+inX+
         A0P59rijQMvqYsuNRbfMy9kQ5D8moFrrROULrsT5DziNPxFb16cp3UW7RHAMYbXhKcvZ
         uv0Qr2g+2vHZDvCDUzKPBuqadqMlxy3/PRLCu5mXGyVIZzz4KWNpKupelr5ZJmRoPPkd
         Vl5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707464758; x=1708069558;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fLYosVJBxJJ3XJbpjWGEbQR6KVWU5Ojl+eaZgpRroOc=;
        b=eW9Ll/I6NUay+SLhfBi8+oTlSOhrT4e/GNxOca48//8uvGChfBMx9UPkeMY4luh9Tr
         kSHuaVulN49sb2RVlsW3mQ+2LwiydFn6CnCk9/woyY3yK0AgyVt1bm/MIvGEIaHtGvkB
         +Cdm6XHpH4XDUG6szN9gbeND4Jeswunmy/qIu2fXeyjRTeqEBz0sJa45QsO0Qfgz5z+I
         jIe2v9cjffwL/P5TNCr/cpTEkDFwTybawLXlIbL4BQH8R3hFXnqvYHVfTfdQDHA1F2/C
         SkSB6H/bBdC9SknsXbC7btityKNST+TFQuSITP04eK7T9h1hs1HQwg1cI/SXKl4qkwzJ
         JT/g==
X-Gm-Message-State: AOJu0YwVNKwkTh9ghv/N25S3jWJqK56Kb/TakcmBFEtmQ54j4yCpc6Xl
	Ub5l/XFOEmoOmw05Q59Ik978ot763TdBcqYtR8i7kl9zPD6dYZMfhOybPFUud4Nq1+zoudXyY11
	gs9y7oHv28rmmuh0tNQwq9zUQ6tWZsBlNcNpNzUge59/EdVe4Cw==
X-Google-Smtp-Source: AGHT+IG32FbFwNpAajblBAmyGjcvhmq3HE+1JiSLTIXXgP0Iu40Y7J10uH9X0as64ONMZiafoGptcDTUb2j4d/y1GRE=
X-Received: by 2002:a1f:ea01:0:b0:4c0:3c09:6f34 with SMTP id
 i1-20020a1fea01000000b004c03c096f34mr939892vkh.2.1707464758253; Thu, 08 Feb
 2024 23:45:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208234539.19113-1-osalvador@suse.de> <20240208234539.19113-2-osalvador@suse.de>
In-Reply-To: <20240208234539.19113-2-osalvador@suse.de>
From: Marco Elver <elver@google.com>
Date: Fri, 9 Feb 2024 08:45:21 +0100
Message-ID: <CANpmjNOHchgjgJbM8OGQTTxE5wiAjt5rJE8UZYJgcF0y1EtBZw@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] lib/stackdepot: Move stack_record struct
 definition into the header
To: Oscar Salvador <osalvador@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 Feb 2024 at 00:45, Oscar Salvador <osalvador@suse.de> wrote:
>
> In order to move the heavy lifting into page_owner code, this one
> needs to have access to the stack_record structure, which right now
> sits in lib/stackdepot.c.
> Move it to the stackdepot.h header so page_owner can access
> stack_record's struct fields.
>
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>  include/linux/stackdepot.h | 44 ++++++++++++++++++++++++++++++++++++++
>  lib/stackdepot.c           | 43 -------------------------------------
>  2 files changed, 44 insertions(+), 43 deletions(-)
>
> diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
> index adcbb8f23600..d0dcf4aebfb4 100644
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
> index 5caa1f566553..16c8a1bf0008 100644
> --- a/lib/stackdepot.c
> +++ b/lib/stackdepot.c
> @@ -35,14 +35,6 @@
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
>  #if IS_ENABLED(CONFIG_KMSAN) && CONFIG_STACKDEPOT_MAX_FRAMES >= 32
>  /*
>   * KMSAN is frequently used in fuzzing scenarios and thus saves a lot of stack

^^ This hunk no longer exists, try to rebase against the version in -next.

Other than that, this looks fine.

