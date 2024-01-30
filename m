Return-Path: <linux-kernel+bounces-44918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B34842912
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F1E12852D5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17A81272C9;
	Tue, 30 Jan 2024 16:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXLkocWH"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0571272AA
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 16:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706631959; cv=none; b=Gjf61kowfkAhEX5DQNt80tAm5jZWHC9n+i5ps8PZiJHPKcm8Dv7iP56MR07Be4WARGFt/4jM0XT+jgHpLCeooYU7Z/CDKgV/CaPDfswCC0qBVY2+lzEArEgK2Z8t6Ej+84Vo3idOwv3oeYMO7aN5xUBjGAyfbZ7gACdtkBjylXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706631959; c=relaxed/simple;
	bh=GBiHYP3LcmEak0kAjpsC1fWhQyZncUYVhDnv+Fc2m5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M6v9JguS8/AkTZZQ1O3507Sv2t/5WxDQfPyFI5xpsiJFZnIcJCMvvUKAEJrId03FkpLsy7c1wfj9NiE4fqymFzc0oM6FTUSegr3Ajnxc1qHKBtJ90VGZUPNEsl/vIxDjXikIqicCeU1WkUCq2CIQblNU1KlZZC3xB1QTMsjSSjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXLkocWH; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3638eb3ead6so2581125ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 08:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706631956; x=1707236756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r0BRSY6JvY8x/OZwlGPGs2UuHvVj6WgXuf7nFnYRB+0=;
        b=VXLkocWHoI/0QpFOAZxMuNyhMKWEmgyTm4s4XG3VGv1Mjj0EtnaYFdzpwaYvleuv9u
         3tD3VvKQ5+SL9qlAZ87LucpidggqtzQevp8BHcIA4LCqsCCzmz2QeAKmcjlVT9wH1bhh
         VVHsm/EXYwgH/9ZfOIrdZVWFVR7eDtL/SQe8pnFqTz8eYd8VNcCOMQluV7W0gObnyXkR
         FNeOfealWxhdcIe2xvPtBR1XqKcfKrUn7YoynsscT4HK4WrUMOW5FMtVelWoATpuR8US
         trBC3WLrB1KKl5nq8ymKsK3+zer4MWj2Le+Rc8qBpJHdZ//lML1z9JjTcTz8iWBgh/0a
         DLPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706631956; x=1707236756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r0BRSY6JvY8x/OZwlGPGs2UuHvVj6WgXuf7nFnYRB+0=;
        b=Ig2CDaME1PsDSS0RmAVoP+KLdWRdf9k52xTocIOEpB9LGPD99Et536lrBedDkNPuRP
         wGrjESETclxCR0PBO6soiMjGv39B26eSdhMBWqmNoRKntdZm4/IR/JibuLpOZVFBgHlQ
         eRUtTJf1RE4fbxAq9lVsca8GDOSk8ojXIIvCRCijutF5BST6saev/a3F+27C/FbT5eUa
         MMk4MIOBHGdjOVzHFhHOpAZYYivby0IzIEdMb1UAH9BSqM2BfQYAjedy5bGUE2wGRZzW
         qUQllqbWil+ovCJ0lSHwvKyfELt+hDBzh0qpNYC1qL/RKMFa+KISNGq4L2rDVDRKF/Me
         JZKQ==
X-Gm-Message-State: AOJu0Yxj+xY0Mk3oPzhvXYP9tvKchR4VzxWtIAqo2um9J0zBijyH9wbn
	POa8F3TBNmYT2q7eGjzBEnuwj+GxVQoAAcLUb+xYBBc+CWkD4dnfYGprUZi2IPVlXum9YsQXzJt
	TvpgTvks9ac1ma8DeCtOqaB7+ksfdRBVpIUw=
X-Google-Smtp-Source: AGHT+IFywg1WtVCG/QYN675Mgz2ed7j5QWae+4Dx2ow8tXYsHFtcA7HgD5amVpd6tE1LJ9gerzTww8YVztR+Uz7yyLw=
X-Received: by 2002:a92:c56d:0:b0:363:76be:a65c with SMTP id
 b13-20020a92c56d000000b0036376bea65cmr10007908ilj.13.1706631956616; Tue, 30
 Jan 2024 08:25:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130014208.565554-1-hannes@cmpxchg.org> <20240130014208.565554-4-hannes@cmpxchg.org>
In-Reply-To: <20240130014208.565554-4-hannes@cmpxchg.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 30 Jan 2024 08:25:45 -0800
Message-ID: <CAKEwX=P2=+NDVFTSVKvxk6Ja9Mn44WRJvKvtY=WFsHxnCuMRJw@mail.gmail.com>
Subject: Re: [PATCH 03/20] mm: zswap: move zswap_invalidate_entry() to related functions
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 5:42=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> Move it up to the other tree and refcounting functions.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  mm/zswap.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index cf864aaa214d..9f05282efe3c 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -559,6 +559,18 @@ static void zswap_entry_put(struct zswap_entry *entr=
y)
>         }
>  }
>
> +/*
> + * If the entry is still valid in the tree, drop the initial ref and rem=
ove it
> + * from the tree. This function must be called with an additional ref he=
ld,
> + * otherwise it may race with another invalidation freeing the entry.
> + */
> +static void zswap_invalidate_entry(struct zswap_tree *tree,
> +                                  struct zswap_entry *entry)

nit? entry_invalidate? There's an entry_put above()

Anyway:
Reviewed-by: Nhat Pham <nphamcs@gmail.com>

> +{
> +       if (zswap_rb_erase(&tree->rbroot, entry))
> +               zswap_entry_put(entry);
> +}
> +
>  /*********************************
>  * shrinker functions
>  **********************************/
> @@ -809,18 +821,6 @@ static struct zswap_pool *zswap_pool_find_get(char *=
type, char *compressor)
>         return NULL;
>  }
>
> -/*
> - * If the entry is still valid in the tree, drop the initial ref and rem=
ove it
> - * from the tree. This function must be called with an additional ref he=
ld,
> - * otherwise it may race with another invalidation freeing the entry.
> - */
> -static void zswap_invalidate_entry(struct zswap_tree *tree,
> -                                  struct zswap_entry *entry)
> -{
> -       if (zswap_rb_erase(&tree->rbroot, entry))
> -               zswap_entry_put(entry);
> -}
> -
>  static enum lru_status shrink_memcg_cb(struct list_head *item, struct li=
st_lru_one *l,
>                                        spinlock_t *lock, void *arg)
>  {
> --
> 2.43.0
>

