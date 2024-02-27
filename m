Return-Path: <linux-kernel+bounces-83268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D98D869102
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DF321C24E80
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345801386CF;
	Tue, 27 Feb 2024 12:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ar6lGGLB"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9600135A43
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 12:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709038525; cv=none; b=J+dIawKxntnthfcD9CB5XQZ3opA5dmi5FVg1Uvnw4Syy+kDsJgzg8cLODZpXWjPNIpA/yxmjAJZUmj7O0HE7iSAQJwqFyaf3yeTwNJOXap2lvNaYExqgioD59hhlm4ZFGV9j6T4vS3+YZepKhdJvFJl1NKTmUy/y1tER4MQxejQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709038525; c=relaxed/simple;
	bh=KJz9hRO8fRmQUceWUmOGhb9xcb17Ny+mYe4CX9Me5cU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HJKBQJqS3ZMTfMJVdKIVc0FUigaYTJajguE93h6q92PrPwOk9EHAn94zx50jPXd56TTCOY5ePxy7Iu2vEbI+mlxaOZkvaWZVSF08SPIBYSFhqAC5hCP8CSaJiUMLAE1Xht6C1+bP6k9KE4QWUQU7wcH2RCVhTHWyluGr4mXEDAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ar6lGGLB; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5664623c311so4910a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 04:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709038522; x=1709643322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MLBUJ2xAHGF+c3kUR836B1kJhRUeAGnSjULsaIYn3hI=;
        b=ar6lGGLB3BZJH1YySaUrWaQQTeeMFXzWJQnrfnS+Znqc6Ml3YidGSrAkmsmCaWhMxc
         Sxyi4V28I7T9TM0lm2WDMHriFr6DaHmIBjavhFhwVMk8SRqwFUgpgn42NiYknSRck3zZ
         lo8Esj8glh8+h60/xveXota/tEVY8PvbgMlQ/n1nrtEzaGvIHtXa6wmXTIeO5vH4w4aY
         p6LZsn/BzrUo1/lzE1fGD+Vw7zYHG/HAKolQLYPTZrUythbltLbtdfwU7itOfaSUdYyA
         XejrYLbw7nBrvTQu6eosxRCGa8eFiNOqt+C9ItQDBYIrdcPq7uCmQElE3WsiB52uutAP
         xFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709038522; x=1709643322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MLBUJ2xAHGF+c3kUR836B1kJhRUeAGnSjULsaIYn3hI=;
        b=R/Jlgd/06lRl3e1+RyGfWEg0DN7up99n8WKrFsh8v07nwOaT2R8+Dq0Wel6f14plJx
         YtguhyRGeTQKNnc1/PpKIVwrpXx6RSMcVlvMXlIENWgZhRvipjXeLYpMpd/THxMRRJvO
         Kh6/wmQk/38Y+Dv5vWMwFuB1ecteH3J1PpCTGtl2YdXnF7DsTfhOGgT6/ymAPeI87X9+
         MsYiJRJXAZqMJQZkF+RXZIndYjbid2WO6Jf61awbV+iqSHEgDlbKxPd91hItJwK9UKtL
         t71rdtubg9HEvBNB2SYx7ErQHZtfXYXhdoTDIqfLHeU5jhs/rRgArstjEaPYJeNLMjA0
         eGqw==
X-Forwarded-Encrypted: i=1; AJvYcCW8as3YG7G3QrbmYi6zDYAWA7M1iqc9HtMO1CthTawEqRPehGSujVO9tn5tbn7opyzjUc76bA4s3rfX02LqnDnOP/BOcqOEzxOo+X5I
X-Gm-Message-State: AOJu0Yz7+A7EHQkMHCqW5zFD1sXVCD1DaItZIH0KfSQ/51uPiuRqRjpV
	Oe0YXxcQg8ZaSIozAXMqO/UmKAOzS1v1JzETP/wFPpbljVM/EdwN11IwCJJ3mTl+6YXxdmWXjO7
	MwyxT9qTUpmSjw7E697nCZXKxhMhMK08y7Py3
X-Google-Smtp-Source: AGHT+IE2+Ej3/Nzu1vJ6UiU7hZuhdo81g+ZGSxhMX8BMWjH4e6YCP8LJLOEDjj+HkMUb1JU2+0PSwHSIwjl3lFKtGDI=
X-Received: by 2002:a50:a448:0:b0:565:abf9:1974 with SMTP id
 v8-20020a50a448000000b00565abf91974mr191729edb.2.1709038521727; Tue, 27 Feb
 2024 04:55:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANn89iJoHDzfYfhcwVvR4m7DiVG-UfFNqm+D1WD-2wjOttk6ew@mail.gmail.com>
 <20240227062833.7404-1-shijie@os.amperecomputing.com>
In-Reply-To: <20240227062833.7404-1-shijie@os.amperecomputing.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 27 Feb 2024 13:55:07 +0100
Message-ID: <CANn89iL2a2534d8QU9Xt6Gjm8M1+wWH03+YPdjSPQCq_Q4ZGxw@mail.gmail.com>
Subject: Re: [PATCH v2] net: skbuff: set FLAG_SKB_NO_MERGE for skbuff_fclone_cache
To: Huang Shijie <shijie@os.amperecomputing.com>
Cc: kuba@kernel.org, patches@amperecomputing.com, davem@davemloft.net, 
	horms@kernel.org, ast@kernel.org, dhowells@redhat.com, linyunsheng@huawei.com, 
	aleksander.lobakin@intel.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, cl@os.amperecomputing.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 7:29=E2=80=AFAM Huang Shijie
<shijie@os.amperecomputing.com> wrote:
>
> Since we do not set FLAG_SKB_NO_MERGE for skbuff_fclone_cache,
> the current skbuff_fclone_cache maybe not really allocated, it maybe
> used an exist old kmem_cache. In NUMA, the fclone allocated by
> alloc_skb_fclone() maybe in remote node.

Why is this happening in the first place ? Whab about skb->head ?

Jesper patch [1] motivation was not about NUMA., but about
fragmentation and bulk allocations/freeing.

TCP fclones are not bulk allocated/freed, so I do not understand what
your patch is doing.
You need to give more details, and experimental results.

Using SLAB_NO_MERGE does not help, I am still seeing wrong allocations
on a dual socket
host with plenty of available memory.
(either sk_buff or skb->head being allocated on the other node).

fclones might be allocated from a cpu running on node A, and freed
from a cpu running on node B.
Maybe SLUB is not properly handling this case ?

SLAB_NO_MERGE will avoid merging fclone with kmalloc-512, it does not
really help.

I think we need help from mm/slub experts, instead of trying to 'fix'
networking stacks.

Perhaps we could augment trace_kmem_cache_alloc() to record/print the nodes
of the allocated chunk (we already have the cpu number giving us the
local node).
That would give us more confidence on any fixes.

BTW SLUB is gone, time to remove FLAG_SKB_NO_MERGE and simply use SLAB_NO_M=
ERGE

[1]
commit 0a0643164da4a1976455aa12f0a96d08ee290752
Author: Jesper Dangaard Brouer <hawk@kernel.org>
Date:   Tue Aug 15 17:17:36 2023 +0200

    net: use SLAB_NO_MERGE for kmem_cache skbuff_head_cache



>
> So set FLAG_SKB_NO_MERGE for skbuff_fclone_cache to fix it.
>
> Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
> ---
> v1 --> v2:
>        set FLAG_SKB_NO_MERGE for skbuff_fclone_cache in initialization.
>
> v1: https://lkml.org/lkml/2024/2/20/121
> ---
>  net/core/skbuff.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 1f918e602bc4..5e3e130fb57a 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -5013,7 +5013,8 @@ void __init skb_init(void)
>         skbuff_fclone_cache =3D kmem_cache_create("skbuff_fclone_cache",
>                                                 sizeof(struct sk_buff_fcl=
ones),
>                                                 0,
> -                                               SLAB_HWCACHE_ALIGN|SLAB_P=
ANIC,
> +                                               SLAB_HWCACHE_ALIGN|SLAB_P=
ANIC|
> +                                               FLAG_SKB_NO_MERGE,
>                                                 NULL);
>         /* usercopy should only access first SKB_SMALL_HEAD_HEADROOM byte=
s.
>          * struct skb_shared_info is located at the end of skb->head,
> --
> 2.40.1
>

