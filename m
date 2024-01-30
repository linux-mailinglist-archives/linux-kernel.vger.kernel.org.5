Return-Path: <linux-kernel+bounces-44043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E109841C8D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E85BC1F26350
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 07:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C049753E3A;
	Tue, 30 Jan 2024 07:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UqDryXnL"
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D97653E1A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 07:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706599614; cv=none; b=LcunP5YeqdrHREuLgXz1G0EpTIVuH3xoLpPMlyo8Sx61DhwGrAACJYJcIWN0G+3Cm7T+rj1wu0/xLxdORUpNFYin/4FicEIvOTbeo+MwotpYqqNhKM5W+EoPS5Ewi/9ouWYMF8aO9bWsp143QnRoAPuTgHc7Z7j3SeswqSSbL7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706599614; c=relaxed/simple;
	bh=yLjQhS64+Wb6ybZ4ZTCbHetSrbH7ZGJpekaaEOc0yS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fkjx3AVYBlKlIhqxS59Wk/mTRIBQ/eYbEVSLxgHvWTo6L5xCm1o3D+/i/Vd4dMFyxsOLv96RiOwOGHcMUpaRjNkImk08Hhq5AMfysW3V0c9RrKW1e1pKayxDNnxVM+9HSWUmfWVEodrpRIRCc1CfROxx/J6TCRWax5NLXKLcdOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UqDryXnL; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4bd87fd64c1so953043e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 23:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706599611; x=1707204411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kO5pTcen7pGGB1LFTLolk2AtehNCG9X/iKJv3c8ZvhM=;
        b=UqDryXnLxFRrZuUZ5TeEv3MWZKBKVgeSOoRfUcQZfn4QiG5tL9eFHD5HxNEO/+4kaY
         6dsIiVoOUQBaHl5G9XL7NZU/19tIe/Jw+0NmCzUxM5+vw1GkjOND2edoj0mU8SF3TB9s
         pkYLA49xoVQwSfEaSsXuOGPz8jsO744IEx7SVLzU6GSpc4lGsid1kvcPW2UMVPNCDArT
         GiKhUympVpsiP9m3tmjVy3ru9/zx2CcB7HV7bU8tkGWpMGB08jEXH58vfhNAMr+WinI8
         IiGvvtO+5xob+xkydKaAzaJWnKdCfGbvxY7yyVnwiGQ0wps0lqRqIldqR/kFcIP7d/0Y
         HJdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706599611; x=1707204411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kO5pTcen7pGGB1LFTLolk2AtehNCG9X/iKJv3c8ZvhM=;
        b=Uv7gYtEJJUODxkcP0E9rJjA1+6u9LXFvj3lrxN/NZ0f3+6f7fYEHCg4tPUpoB/xOda
         tXB/HU4BN0mcewDLXoTW/aJRQnybMv1e1+6AB8KwVUbPfNIE9xfRVzg7acXHs2Q0rqBR
         BRkMyIWyGDIVkIY2KvqJYwt/mFQjCucFKHEwGlpwSrl9WwW2nwk0agBddbSly05bar30
         wSmQr2yqN8MiYSVqUvVFh5aZ8usKTWAq6mHayWnp4HioSMKNe1yn4bevHt3tx1pUnw4q
         MmHdrGa9WbhigJFFKKqXJh4CozxE1iMpMWKc+4HvAOyy6AGqPALdzt3TCEDV4EiUdWv2
         nF3A==
X-Gm-Message-State: AOJu0YyZ4gMCqLsKL48dIoje+gpAC+A2GS1FVYyqzCffsJ3Xc8OkPDHl
	4WNHfxRHRl9EG4bnAPp2u9xVT9qYDkbSITLQssOyrJP7Kyb2OqnnUtTfhQzNTyD0Upncr8sKkRM
	7uy+zJykJmtvvFtF7frcp25ECAxA=
X-Google-Smtp-Source: AGHT+IFrCLFyDmgihu0EY47nwdQr/NUPmIOWYheo96xxW5JiOcIQJhqjPXwnCFS+qPUrt/qWIwfPU5khF2vS1EtDj3I=
X-Received: by 2002:a05:6122:4b1b:b0:4b6:c3ae:97f6 with SMTP id
 fc27-20020a0561224b1b00b004b6c3ae97f6mr3896410vkb.0.1706599611143; Mon, 29
 Jan 2024 23:26:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130013438.565167-1-hannes@cmpxchg.org>
In-Reply-To: <20240130013438.565167-1-hannes@cmpxchg.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 29 Jan 2024 23:26:40 -0800
Message-ID: <CAKEwX=N5A_b7edmqJyoKLvTCS64bpH886SSR_OUm4DZQUdL8Gg@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: fix objcg use-after-free in entry destruction
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 5:34=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> In the per-memcg LRU universe, LRU removal uses entry->objcg to
> determine which list count needs to be decreased. Drop the objcg
> reference after updating the LRU, to fix a possible use-after-free.
>
> Fixes: a65b0e7607cc ("zswap: make shrinking memcg-aware")
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  mm/zswap.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index de68a5928527..7f88b3a77e4a 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -522,10 +522,6 @@ static struct zpool *zswap_find_zpool(struct zswap_e=
ntry *entry)
>   */
>  static void zswap_free_entry(struct zswap_entry *entry)
>  {
> -       if (entry->objcg) {
> -               obj_cgroup_uncharge_zswap(entry->objcg, entry->length);
> -               obj_cgroup_put(entry->objcg);
> -       }
>         if (!entry->length)
>                 atomic_dec(&zswap_same_filled_pages);
>         else {
> @@ -534,6 +530,10 @@ static void zswap_free_entry(struct zswap_entry *ent=
ry)
>                 atomic_dec(&entry->pool->nr_stored);
>                 zswap_pool_put(entry->pool);
>         }
> +       if (entry->objcg) {
> +               obj_cgroup_uncharge_zswap(entry->objcg, entry->length);
> +               obj_cgroup_put(entry->objcg);
> +       }

Nice catch!
Reviewed-by: Nhat Pham <nphamcs@gmail.com>

>         zswap_entry_cache_free(entry);
>         atomic_dec(&zswap_stored_pages);
>         zswap_update_total_size();
> --
> 2.43.0
>

