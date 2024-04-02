Return-Path: <linux-kernel+bounces-128476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D541E895B56
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A2F52862C9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEDD15AAD7;
	Tue,  2 Apr 2024 18:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9WVYOFO"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB0215AAC4;
	Tue,  2 Apr 2024 18:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712081093; cv=none; b=Zh0HIIUvCnM08wSoc8O9o99JIMVL+Zo5FvBn9t8RSKz3idgfeuKJ7Y/vI+D7HrBmCu3wPsXDb8ZMJGHS5fLbcA2Vjif8UUZh7ujbylUF/NdkBRVwfIxFVd5d73wvIAgMCUlErw62rilJNYININaYx3LpEjvkKVdro+HUh1DrojM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712081093; c=relaxed/simple;
	bh=dS7TGGX5JXr89RvdjVc6lghaQPgXBTH4kUUgu5VWZgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UqveXfOV2IRb6LsrR9mJ+8SSvVPxjmVfjeYBWMiOjGcNj6deZa58dwYB6UbkWXdnQmaXpYZNt9JI//hPn1X70VtOLC68rnSmvyLP1cIqQ0AgfpEmcPJ8axcIyr9N80U6Tk/thcGX5PTdp0Mrt6R+1Oup26SX109OLIaV3vYmpQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A9WVYOFO; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5cedfc32250so3410336a12.0;
        Tue, 02 Apr 2024 11:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712081091; x=1712685891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J14JohUzHX0DW16XpSFBM8/aBKrqCOXEeYVRPdaK38c=;
        b=A9WVYOFO0TdHrwUC0iNSwN87t/qircJMC9wD3a6OBiwiXRnBN89PE+iZI0Qydmkcbq
         Jh6S4kI0B+N/SxUV2Tzz8JRE1o8uivI/2F5z2wll5rSbuQ8vt5eI6zexCtdHZB3KBqGn
         bKWYZ8LGo1bkRVde/NPr4DVIyYfPMLkhrG8/XY5tDSFMlE115EYQzcOucaLsJSOu8wEt
         1oG689hve5on18utB/Nc7WvlYPm2rK2S4AnRBHlag4IRgzZePb0kYiGZSb/rrodXJH6R
         C1wFVzcd8EZObBraK+6GylxUHpr+ReovWPxO4CESOHKno+YUCMqdsoGLwP0IdWc/VIGy
         amfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712081091; x=1712685891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J14JohUzHX0DW16XpSFBM8/aBKrqCOXEeYVRPdaK38c=;
        b=D5etv5tjWHnsSJ1l7TtVjET3gMc4kqpgeQAkn5ZqBAOWdQpllK9PXWnEzT9R/vIv5H
         GoW2C80Y0Ns6bLL74wUQ/KPcYRNm98cFPIIuXhyWScbhqVEh7DVnFA2QQP2bsAq4HbcN
         1RngaEWNQUhTYOJIASoOQghZHSAt1NIUdMneLm4/62B8EDXd0O7ideBEQU6HYmnS46eK
         gdn9CqddQKyab52Hh7oNnbDEwHcBjNUUETfTKDUQmwi4OyTRNJqQunRv40ZWUk2/UxOF
         YhOqDaXjdrjWxnR4GAae/9lvv1dDvQzzbuIQ1+d7KvO92T9gSIVnneVRA7tvTBQ1VpGU
         tqWA==
X-Forwarded-Encrypted: i=1; AJvYcCUIBAlPAsEbbqeifdWuHys8pQKNUGpG+mBBnjl4CRpHwt2QEGv4BJQvybEVBX8fZjfLBbNvY0r2dPBDUx8ICJVRKr3GkgIXeHAB0hIyLd7tdAOIQyvioSSxWUpfl57oapLv
X-Gm-Message-State: AOJu0YwOlsvVNDOoakOuiuYTbeh2xksWEWRIcMRXCIM3r2iZnI6j5yLv
	PGLdFGxPwcL/3OFUfdymRUtln9739F/N6rq5NbTOhR3uIVu5WDeU/MhPwhtBSCYnQb9H0Mux/dC
	dYRP3beICWxqDdQPWTP6t44IkZZI=
X-Google-Smtp-Source: AGHT+IHmZ2VOnBkNDQBWiUBoYRpKf88pRXXpaPtg4cyRyO16APTUzV0pxkUw20DKO1HOYFeFK3ZBV5px7iFz94GySiQ=
X-Received: by 2002:a17:90a:2e17:b0:2a1:f27d:7696 with SMTP id
 q23-20020a17090a2e1700b002a1f27d7696mr11650458pjd.38.1712081091115; Tue, 02
 Apr 2024 11:04:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401073159.16668-1-andrea.righi@canonical.com> <20240401073159.16668-3-andrea.righi@canonical.com>
In-Reply-To: <20240401073159.16668-3-andrea.righi@canonical.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 2 Apr 2024 11:04:39 -0700
Message-ID: <CAEf4BzYuMxF6JDi4gG+cfikXqrOsBqiZRw8Ur4K5=YwQKAqKXg@mail.gmail.com>
Subject: Re: [PATCH 2/2] libbpf: Add ring__consume_max / ring_buffer__consume_max
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
> Introduce a new API to consume items from a ring buffer, limited to a
> specified amount, and return to the caller the actual number of items
> consumed.
>
> Link: https://lore.kernel.org/lkml/20240310154726.734289-1-andrea.righi@c=
anonical.com/T
> Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
> ---
>  tools/lib/bpf/libbpf.h   | 13 +++++++++++++
>  tools/lib/bpf/libbpf.map |  2 ++
>  tools/lib/bpf/ringbuf.c  | 35 +++++++++++++++++++++++++++++++++--
>  3 files changed, 48 insertions(+), 2 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index f88ab50c0229..85161889efd4 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -1293,6 +1293,8 @@ LIBBPF_API int ring_buffer__add(struct ring_buffer =
*rb, int map_fd,
>                                 ring_buffer_sample_fn sample_cb, void *ct=
x);
>  LIBBPF_API int ring_buffer__poll(struct ring_buffer *rb, int timeout_ms)=
;
>  LIBBPF_API int ring_buffer__consume(struct ring_buffer *rb);
> +LIBBPF_API int ring_buffer__consume_max(struct ring_buffer *rb,
> +                                       size_t max_items);
>  LIBBPF_API int ring_buffer__epoll_fd(const struct ring_buffer *rb);
>
>  /**
> @@ -1367,6 +1369,17 @@ LIBBPF_API int ring__map_fd(const struct ring *r);
>   */
>  LIBBPF_API int ring__consume(struct ring *r);
>
> +/**
> + * @brief **ring__consume_max()** consumes up to a certain amount of ite=
ms from

nit: certain -> requested ?

> + * a ringbuffer without event polling.
> + *
> + * @param r A ringbuffer object.
> + * @param max_items Maximum amount of items to consume.
> + * @return The number of items consumed (or max_items, whichever is less=
), or a

if we reach max_items, we did consume max_items, so I think "number of
items consumed" is right and I'd drop the part in parenthesis

> + * negative number if any of the callbacks return an error.
> + */
> +LIBBPF_API int ring__consume_max(struct ring *r, size_t max_items);

I'm bikeshedding here, of course, but I prefer `ring__consume_n` and
max_items -> n.

> +
>  struct user_ring_buffer_opts {
>         size_t sz; /* size of this struct, for forward/backward compatibi=
lity */
>  };
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 51732ecb1385..bb3ed905119d 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -415,4 +415,6 @@ LIBBPF_1.4.0 {
>                 bpf_token_create;
>                 btf__new_split;
>                 btf_ext__raw_data;
> +               ring__consume_max;
> +               ring_buffer__consume_max;

we are in 1.5 cycle now, please add another section that inherits from
LIBBPF_1.4.0

>  } LIBBPF_1.3.0;
> diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> index 81df535040d1..c8123e326b1a 100644
> --- a/tools/lib/bpf/ringbuf.c
> +++ b/tools/lib/bpf/ringbuf.c
> @@ -281,6 +281,32 @@ static int64_t ringbuf_process_ring(struct ring *r, =
int64_t max_items)
>         return cnt;
>  }
>
> +/* Consume available ring buffer(s) data without event polling up to max=
_items.
> + *
> + * Returns number of records consumed across all registered ring buffers=
 (or
> + * max_items, whichever is less), or negative number if any of the callb=
acks
> + * return error.
> + */
> +int ring_buffer__consume_max(struct ring_buffer *rb, size_t max_items)
> +{
> +       int64_t err, res =3D 0;
> +       int i;
> +
> +       for (i =3D 0; i < rb->ring_cnt; i++) {
> +               struct ring *ring =3D rb->rings[i];
> +
> +               err =3D ringbuf_process_ring(ring, max_items);
> +               if (err < 0)
> +                       return libbpf_err(err);
> +               res +=3D err;
> +               max_items -=3D err;
> +
> +               if (!max_items)

please use `=3D=3D 0`, it's not a bool and not a pointer

> +                       break;
> +       }
> +       return res;
> +}
> +
>  /* Consume available ring buffer(s) data without event polling.
>   * Returns number of records consumed across all registered ring buffers=
 (or
>   * INT_MAX, whichever is less), or negative number if any of the callbac=
ks
> @@ -376,17 +402,22 @@ int ring__map_fd(const struct ring *r)
>         return r->map_fd;
>  }
>
> -int ring__consume(struct ring *r)
> +int ring__consume_max(struct ring *r, size_t max_items)
>  {
>         int64_t res;

hm.. we can probably change this to int, can you do that as part of
your changes?

>
> -       res =3D ringbuf_process_ring(r, INT_MAX);
> +       res =3D ringbuf_process_ring(r, max_items);
>         if (res < 0)
>                 return libbpf_err(res);
>
>         return res;
>  }
>
> +int ring__consume(struct ring *r)
> +{
> +       return ring__consume_max(r, INT_MAX);
> +}
> +
>  static void user_ringbuf_unmap_ring(struct user_ring_buffer *rb)
>  {
>         if (rb->consumer_pos) {
> --
> 2.43.0
>

