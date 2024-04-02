Return-Path: <linux-kernel+bounces-128471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B372E895B40
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D66A41C21DDE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF1015AAD2;
	Tue,  2 Apr 2024 17:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="er8760qY"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B2215AABA;
	Tue,  2 Apr 2024 17:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712080728; cv=none; b=YNCD6oS/KB8esx8wtTailQnHp/TtMasd/bBl/umF+Q0l9mVPdwHrRIG6CSXKtEN+uw6zQxkqRwUNhJOzI6DvB5IuLqjk1riPMQD/NHw6tb5xrhMURVRC+gdJy6cJZtF59r5qXS22ZYaBVj1lXdliwF73NSNf2Zqv3HKBF2wVfNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712080728; c=relaxed/simple;
	bh=CckikFIEdka9zckJdLB6X9WogvFT5kc+ADx3ZTqUgSw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p/HnpoHWaNRleN0Xz9XpckIvvBTDZz5ClB+WHb8n1qUTslstQ6hsj9h0AgFe8Hvlbr0BsSwZRSHGQv025OLgVYSzQmbrsbsh4F26B2Us81/5LAp0hhNFjQmN7CGnPta6CCl0dhz9bCrsHnUoGZSebBWF6aZkTVq5rG3izm6eNzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=er8760qY; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e244c7cbf8so23258395ad.0;
        Tue, 02 Apr 2024 10:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712080726; x=1712685526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E+eeJaOo2zbz2WTbCF4Si6uwF5B92wp+mvI31Obgdqw=;
        b=er8760qYfH0a5PhmgOhiseQXy7e6PZ4NpjCOWvntt0y4YG1ATppHrjIlmHD7K5lKXS
         1HHfAyz/Xu2A5+ZP79V/JuAPdzeJRG8l2EzBI+vrOOapSzTU3rj8P3lFjg56Tl7HfcaM
         3+cuViVlruX+4UZflTt3nN6wTxPAmfmnTd5YsEu9s58hac7jj+g1iLiwG0qYlqgcthU2
         D4FS1MsElurmDuD3M5Mb4noO6bU3V5NXt84uGOx/yruecYQzQ3Wmrmwq5zXmB1WjzF27
         ufnR76aQJKoZ+33m6u7bAlMi7lGVRlYyuW80kQlSVV8jZsK30xxfBFEubGdU/H+ksdDF
         7tJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712080726; x=1712685526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E+eeJaOo2zbz2WTbCF4Si6uwF5B92wp+mvI31Obgdqw=;
        b=WoyBfM0Q77HRUPIGtLSbRQgG0uK1yCGVcrMwFlcyFhTUH53IxSwB3JeVJzMGEBencW
         KOccZJKR/pzBKMHGXyrKy0daULX/i4FLTCmoUqbwobmxauafRHQT/iwBWXBmKaj5tGus
         KwPgSlBbIGYsXh/pmX2q6/LDvMotCQ+JRg/xnypFoaWXpfBR9GdwQIXRtnXrGaktRU3c
         8XQHVXE8j6XN34jNvKDqIr5hsiG/jX3fH61SLJyZQsh/0zb5pNHRyX7Sku89CLFCTTIz
         o1dabC2yW1eJVtoHpY2JyCElbcqpRWBI0/zsUTHARt9lx+X0PMNg8NLaiemzouMy2YYM
         fkSg==
X-Forwarded-Encrypted: i=1; AJvYcCXTjDZCbqUrN3FdudjRaX2RGWei4GVOHXsUQBqqBUc2C7zmmKVK0Tvsafd5B0FxXh4zAhwSl214aidCWO+WlL4+B/O+jqatxhtXOcRZt6Nxpvi3b2FeXO5XFsj2GbXO5u3x
X-Gm-Message-State: AOJu0YzW/M3sWR6UxfCYgJ7h0gPByIXgn5pdrb+2yH1gyQyWzoip4kVz
	wNg47n31yrmFfajaPzu9f1SSQTn4xG0WDRRJsPRFu59412/kO5AK4J1AMtsN98LQDa7zsx5ZBz+
	Icodn2LPS3tBoxTipkJHBU48bZak=
X-Google-Smtp-Source: AGHT+IEok5isFVFKmsQdGq2BkvHNiNZArRXmmLtHuhQhirxy9paVnrknUWcindrLjLmMS4jDaxct0el+kIfHgvRll+Y=
X-Received: by 2002:a17:902:f606:b0:1e2:88fd:c220 with SMTP id
 n6-20020a170902f60600b001e288fdc220mr425236plg.44.1712080725946; Tue, 02 Apr
 2024 10:58:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401073159.16668-1-andrea.righi@canonical.com> <20240401073159.16668-2-andrea.righi@canonical.com>
In-Reply-To: <20240401073159.16668-2-andrea.righi@canonical.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 2 Apr 2024 10:58:33 -0700
Message-ID: <CAEf4BzbJE-Y72VqYXCDfwRXjhknVK+GHYjRfxdajzAEwjUkwUg@mail.gmail.com>
Subject: Re: [PATCH 1/2] libbpf: ringbuf: allow to consume up to a certain
 amount of items
To: Andrea Righi <andrea.righi@canonical.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, David Vernet <void@manifault.com>, Tejun Heo <tj@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 12:32=E2=80=AFAM Andrea Righi <andrea.righi@canonica=
l.com> wrote:
>
> In some cases, instead of always consuming all items from ring buffers
> in a greedy way, we may want to consume up to a certain amount of items,
> for example when we need to copy items from the BPF ring buffer to a
> limited user buffer.
>
> This change allows to set an upper limit to the amount of items consumed
> from one or more ring buffers.
>
> Link: https://lore.kernel.org/lkml/20240310154726.734289-1-andrea.righi@c=
anonical.com/T
> Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
> ---
>  tools/lib/bpf/ringbuf.c | 29 +++++++++++++++++------------
>  1 file changed, 17 insertions(+), 12 deletions(-)
>
> diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> index aacb64278a01..81df535040d1 100644
> --- a/tools/lib/bpf/ringbuf.c
> +++ b/tools/lib/bpf/ringbuf.c
> @@ -231,7 +231,7 @@ static inline int roundup_len(__u32 len)
>         return (len + 7) / 8 * 8;
>  }
>
> -static int64_t ringbuf_process_ring(struct ring *r)
> +static int64_t ringbuf_process_ring(struct ring *r, int64_t max_items)
>  {
>         int *len_ptr, len, err;
>         /* 64-bit to avoid overflow in case of extreme application behavi=
or */
> @@ -264,7 +264,14 @@ static int64_t ringbuf_process_ring(struct ring *r)
>                                                           cons_pos);
>                                         return err;
>                                 }
> -                               cnt++;
> +                               if (++cnt >=3D max_items) {
> +                                       /* update consumer pos and return=
 the
> +                                        * total amount of items consumed=
.
> +                                        */
> +                                       smp_store_release(r->consumer_pos=
,
> +                                                         cons_pos);

Does this fit on a single line under 100 characters? If yes, please
keep it as a single line

but actually it seems cleaner to keep cnt++ intact, let
smp_store_release() below happen, and then check the exit condition.
Were you afraid to do unnecessary checks on discarded samples? I
wouldn't worry about that.

> +                                       goto done;
> +                               }
>                         }
>
>                         smp_store_release(r->consumer_pos, cons_pos);
> @@ -281,19 +288,18 @@ static int64_t ringbuf_process_ring(struct ring *r)
>   */
>  int ring_buffer__consume(struct ring_buffer *rb)
>  {
> -       int64_t err, res =3D 0;
> +       int64_t err, res =3D 0, max_items =3D INT_MAX;

I'm wondering if it might be better to have a convention that zero
means "no limit", which might allow the compiler to eliminate the
condition in ringbuf_process_ring altogether due to constant
propagation. WDYT?

>         int i;
>
>         for (i =3D 0; i < rb->ring_cnt; i++) {
>                 struct ring *ring =3D rb->rings[i];
>
> -               err =3D ringbuf_process_ring(ring);
> +               err =3D ringbuf_process_ring(ring, max_items);
>                 if (err < 0)
>                         return libbpf_err(err);
>                 res +=3D err;
> +               max_items -=3D err;
>         }
> -       if (res > INT_MAX)
> -               return INT_MAX;
>         return res;
>  }

[...]

