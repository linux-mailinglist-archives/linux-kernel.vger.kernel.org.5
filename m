Return-Path: <linux-kernel+bounces-67836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40EBC8571A8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 00:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65F941C21A1A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEF6145B03;
	Thu, 15 Feb 2024 23:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHcRD97c"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA7B8833
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 23:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708040232; cv=none; b=lDhrH/orhYsqTbyjcmlmmW2u+WncNtfjK7Ppy08Tn70mnvXE1KYdsQQJNjuJ6UA/oScpWnz7fjIHbLJQzXeBHShPaj40lbnwHPg1KZOL2hMsSSsaMbzSFvdxyCyxX5AGQo9weEdoJjhZT3hXGDRxN5qNMT4OGOdY7zy8d/X96fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708040232; c=relaxed/simple;
	bh=B/hAo1uzM072Re+Od4cH5QQnJTrkRrpSEbrZQySosB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KolBuu2j+EgEA72UCaNcHLw/Q88RPgmK6/59eTDNB0dawTq/R+BwFM8O5H2NTncMeagCpkNvEf8INuz5Am4TquzcBJCMfaiiTnGddEdKLTCYSw7k7tom0ymDZSbI9y257tJu1XIeEb+qSwh5K9gVWZa8l3M6WtupdQwBq+NgIYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cHcRD97c; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33aeb088324so767868f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 15:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708040229; x=1708645029; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yQDAVrbJendrD0pWB1pwZByBGrwgR3/pZmA1p43+9/M=;
        b=cHcRD97c27v4lPyk5Fa1IZ4OdejUevw1UQWXOYIVmH2zfijVzhL9cW55EJ/AwjwW2s
         itFh8wZpOuloEO1rbDvXMiAvYU2J9+f4+8XM9mpiw6yb+NzppkxFxNypUB4fmGggNM4N
         U/XLr+p+eqjW/GnBJ7zi/KsVfg9zLMxxK7CAnwIQ8ceizCAy0b/gG1ghGh0oH0o9e90w
         O+wEwgs07FuWbQE9HQmcA9qQEhTH+tgc2sbIcYCO6nYL5aumvM8B8ioebQ/s9U1ve4VM
         pQBzHc8EfYJErhdYfVp4NaQQjPCtY5qpN7yZHKKoVALb8oOCTYzTTGShXWUwIhRd+vtm
         hK0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708040229; x=1708645029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yQDAVrbJendrD0pWB1pwZByBGrwgR3/pZmA1p43+9/M=;
        b=H3vN7vxuY7owMRkV6XbO7MnCPPNLEv7bCM/oZaGrSkgrqpg82hRx75sdDr5Q4GfMPb
         P1zTPNUJfNjFB8IYdMt8DYGz13t8dhsAa1386CRx5cqRZ1k1j25kRZ7RCKMBKv6J/fbS
         nS16GLl97mOCz3KvdDieo/8CcfGX9Cu00fJh2SyKxByHzC0djDUAiwWGgEj3orpn2aUp
         h8nVwHgD4a1zvvVUdK/XrDmwESSiMmmjtPB0RWelQPlUatwsOpvdsZthX97H8jyJKf06
         6xB232QzelIv9mP/jsQjRmagQX2V/N9O+kY/2DRikfF8XeZr+CVKMUIwyKiSlGTV8k4j
         BLcg==
X-Forwarded-Encrypted: i=1; AJvYcCU9FVflg+36hkby/gYrDPKZtf3CKv9vhhhCi6JR7ZyYFIkkceIiKn7Ve7xd0dzyClRY/LzhOD0QJzBTvdX46IPRfKAy5RyDdDzbrSJr
X-Gm-Message-State: AOJu0YwHGqTPwBEZeyucxBYzTKjf5JMKJMNfINnQoEH4Z4ayYJm0KBBb
	utXZuRpt0u6XOuT09KsS+SnZL/12R5cM9GWav6WK8zHwheZghgfFfgv3J8kby+awB9BU7pvY/bN
	xZYmUMpucQKDsgglB+1hX4TFhXf5wW0fl
X-Google-Smtp-Source: AGHT+IHf8GMDQ7UAbBO4ysbI6i1lbchyJh1F0anpFDrS+ak/u5pMUOJa7DlDhlGz8k11/64RluqhyoCH+rBWmmJbzLU=
X-Received: by 2002:a5d:464e:0:b0:33b:4ebd:144f with SMTP id
 j14-20020a5d464e000000b0033b4ebd144fmr2597271wrs.36.1708040228722; Thu, 15
 Feb 2024 15:37:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215215907.20121-1-osalvador@suse.de> <20240215215907.20121-2-osalvador@suse.de>
In-Reply-To: <20240215215907.20121-2-osalvador@suse.de>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Fri, 16 Feb 2024 00:36:57 +0100
Message-ID: <CA+fCnZddd82=Gp2j4sdks+NGpn-GSvZq8isYOwXDO=Y3TyBG1g@mail.gmail.com>
Subject: Re: [PATCH v10 1/7] lib/stackdepot: Fix first entry having a 0-handle
To: Oscar Salvador <osalvador@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Marco Elver <elver@google.com>, Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 10:58=E2=80=AFPM Oscar Salvador <osalvador@suse.de>=
 wrote:
>
> The very first entry of stack_record gets a handle of 0, but this is wron=
g
> because stackdepot treats a 0-handle as a non-valid one.
> E.g: See the check in stack_depot_fetch()
>
> Fix this by adding and offset of 1.
>
> This bug has been lurking since the very beginning of stackdepot,
> but no one really cared as it seems.
> Because of that I am not adding a Fixes tag.
>
> Co-developed-by: Marco Elver <elver@google.com>
> Signed-off-by: Marco Elver <elver@google.com>
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  lib/stackdepot.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> index 4a7055a63d9f..c043a4186bc5 100644
> --- a/lib/stackdepot.c
> +++ b/lib/stackdepot.c
> @@ -45,15 +45,16 @@
>  #define DEPOT_POOL_INDEX_BITS (DEPOT_HANDLE_BITS - DEPOT_OFFSET_BITS - \
>                                STACK_DEPOT_EXTRA_BITS)
>  #define DEPOT_POOLS_CAP 8192
> +/* The pool_index is offset by 1 so the first record does not have a 0 h=
andle. */
>  #define DEPOT_MAX_POOLS \
> -       (((1LL << (DEPOT_POOL_INDEX_BITS)) < DEPOT_POOLS_CAP) ? \
> -        (1LL << (DEPOT_POOL_INDEX_BITS)) : DEPOT_POOLS_CAP)
> +       (((1LL << (DEPOT_POOL_INDEX_BITS)) - 1 < DEPOT_POOLS_CAP) ? \
> +        (1LL << (DEPOT_POOL_INDEX_BITS)) - 1 : DEPOT_POOLS_CAP)
>
>  /* Compact structure that stores a reference to a stack. */
>  union handle_parts {
>         depot_stack_handle_t handle;
>         struct {
> -               u32 pool_index  : DEPOT_POOL_INDEX_BITS;
> +               u32 pool_index  : DEPOT_POOL_INDEX_BITS; /* pool_index is=
 offset by 1 */
>                 u32 offset      : DEPOT_OFFSET_BITS;
>                 u32 extra       : STACK_DEPOT_EXTRA_BITS;
>         };
> @@ -372,7 +373,7 @@ static struct stack_record *depot_pop_free_pool(void =
**prealloc, size_t size)
>         stack =3D current_pool + pool_offset;
>
>         /* Pre-initialize handle once. */
> -       stack->handle.pool_index =3D pool_index;
> +       stack->handle.pool_index =3D pool_index + 1;
>         stack->handle.offset =3D pool_offset >> DEPOT_STACK_ALIGN;
>         stack->handle.extra =3D 0;
>         INIT_LIST_HEAD(&stack->hash_list);
> @@ -483,18 +484,19 @@ static struct stack_record *depot_fetch_stack(depot=
_stack_handle_t handle)
>         const int pools_num_cached =3D READ_ONCE(pools_num);
>         union handle_parts parts =3D { .handle =3D handle };
>         void *pool;
> +       u32 pool_index =3D parts.pool_index - 1;
>         size_t offset =3D parts.offset << DEPOT_STACK_ALIGN;
>         struct stack_record *stack;
>
>         lockdep_assert_not_held(&pool_lock);
>
> -       if (parts.pool_index > pools_num_cached) {
> +       if (pool_index > pools_num_cached) {
>                 WARN(1, "pool index %d out of bounds (%d) for stack id %0=
8x\n",
> -                    parts.pool_index, pools_num_cached, handle);
> +                    pool_index, pools_num_cached, handle);
>                 return NULL;
>         }
>
> -       pool =3D stack_pools[parts.pool_index];
> +       pool =3D stack_pools[pool_index];
>         if (WARN_ON(!pool))
>                 return NULL;
>
> --
> 2.43.0
>

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

