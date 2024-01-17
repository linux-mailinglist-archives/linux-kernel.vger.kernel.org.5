Return-Path: <linux-kernel+bounces-29300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EC6830C5E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 19:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED9EB2858F9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 18:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5505E22F06;
	Wed, 17 Jan 2024 18:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4zGpkU9b"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB98622EE8
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 18:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705514473; cv=none; b=Nm2yy59sk2K/uw5hSt540Q6Sm3d2I/vUgalJZGBm0BQjx3uKPfak8XkFYHvUxgL0z/ZoJXvegPmHCCInuqqEi6kJrJTQSDTTJtC4ra5/KKWAxNHo45dj3KIBr281+L6CJjkwffPtLh2fzh8/yccwZdCehDt83M0K+OWoKAwwy78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705514473; c=relaxed/simple;
	bh=s9T8+huYkQV4LX5MAw4WwWh3qTHDPgPe4dZl313Xxoo=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=aDzGP7R4D6oLA7nUUtyZe30xO0RDi/stUHq0TxCjvZ1Q9VulHuzxkT9bvFZqvJCXSPPY+tv/bBJc6g4fV8pfqPmfYWX9n7Qw1TMgMURh5NdLgZmXAxMAiARrceaFdHJmpMu7OvudymFVj9ZZJCuKoP5qO1aLWx3l5Rv0Zyvfo5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4zGpkU9b; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a2ece31f5fdso107868666b.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 10:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705514470; x=1706119270; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s9T8+huYkQV4LX5MAw4WwWh3qTHDPgPe4dZl313Xxoo=;
        b=4zGpkU9bG3lEpd84ydZjgq3jM59SZtoU67E1nTPEahah5SAyUR4je9VLa7iNvnaN7B
         IC9a76mZnd4TVpLDO0oP/MHcCoOq2Be8SwF4MyT6PqwWrDHu/qKZ7LFopLPzRcDaWaHp
         NdieO/Bu1x34xgTnLVypQ7F52E5hgfLLMl7g3Kjarv6PZ4FdACFjcDz/LP7hydwXrOGV
         Ghy8Ipy6xJpip2a6LW2nauCEtWmsheC3qEVeLp9vBVvrdWCQll/H18lW5nBTlRIDjyc2
         LbJRzOOf74H/KsRJ9DuXvTG2UgXKdopzCy/3eyIo6J3CRaWgBaF6jtPXOgEJTwclmCt0
         LLDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705514470; x=1706119270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s9T8+huYkQV4LX5MAw4WwWh3qTHDPgPe4dZl313Xxoo=;
        b=PXGsY5vj0IdyEDDPjsM1zstFspBSD4T2RDyC+hY+g1nW1JgZIEUcjy+tztnO5FAXen
         bGAbPg+rZ8ttpvwhuAtJHpvyAQRmkwrjtqloRomyIEVuLbyLORCDvlG5eETC6RN6yl2j
         FFTLjB5/cRgBcFeaxupEJpQJ9Ukhwe3/iZY9GqDWlveRLgQPwHJ4nq95MjiSsg6os7o3
         8YrzzWBzuFCYXxY18y3mHIzm2t2d4GHn4p/ERVnJP8ef9vbIW9qT7LLYiZn+mk4LJ18O
         EFHKMpw+v1MhF23f3bN2FhcEoC23Tk7OxUn37pDpyujCzdpiknPSji87r7XLnpac2rZE
         f8Cw==
X-Gm-Message-State: AOJu0Ywi4zEG6CjUfIhJ28VQy5tWcPe3niBgl0fLoxFUt1VI2Nhqb3rj
	kvNRMEkMokFy+X/W4348oY2Btlf48mqqwiAxmrgBzCTR2U0W
X-Google-Smtp-Source: AGHT+IEcgCFYTo3gSzkKKENWZKwhHSBuhNQViC2TEVlkeUZf94TJjfVYDN08i1bt0NB8RRmuTUfa8jV0G/UE1wVbXWo=
X-Received: by 2002:a17:907:74b:b0:a2a:b777:b357 with SMTP id
 xc11-20020a170907074b00b00a2ab777b357mr4902988ejb.23.1705514469943; Wed, 17
 Jan 2024 10:01:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109011455.1061529-1-almasrymina@google.com>
 <20240109011455.1061529-3-almasrymina@google.com> <5219f2cd-6854-0134-560d-8ae3f363b53f@huawei.com>
 <CAHS8izOtr+jfqQ6xCB3CoN-K_V1-4hPsB4-k5+1z-M3Qy2BbwA@mail.gmail.com>
 <0711845b-c435-251f-0bbc-20b243721c06@huawei.com> <CAHS8izOxvMVGXKpLBvVgyyS5_94WGG8Aca=O_zGMX+db-3gBXg@mail.gmail.com>
 <66bc7b8f-51b6-0d9e-db5b-47e7ee5e9029@huawei.com> <CAHS8izOnhtQGeQ-EFmYjZyZ0eW2LqO0Rrm73eAB2su=UA34yTw@mail.gmail.com>
 <20240116000129.GX734935@nvidia.com> <9c1a6725-c4c3-2bb1-344f-5e71f8ce7e63@huawei.com>
 <20240116121611.GY734935@nvidia.com>
In-Reply-To: <20240116121611.GY734935@nvidia.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 17 Jan 2024 10:00:55 -0800
Message-ID: <CAHS8izPa6ostY7qZUAmm4g8N3rfWoVBK6r5z0_MycxfsEVH4jw@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v5 2/2] net: add netmem to skb_frag_t
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Shakeel Butt <shakeelb@google.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 4:16=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Tue, Jan 16, 2024 at 07:04:13PM +0800, Yunsheng Lin wrote:
> > On 2024/1/16 8:01, Jason Gunthorpe wrote:
> > > On Mon, Jan 15, 2024 at 03:23:33PM -0800, Mina Almasry wrote:
> > >>>> You did not answer my question that I asked here, and ignoring thi=
s
> > >>>> question is preventing us from making any forward progress on this
> > >>>> discussion. What do you expect or want skb_frag_page() to do when
> > >>>> there is no page in the frag?
> > >>>
> > >>> I would expect it to do nothing.
> > >>
> > >> I don't understand. skb_frag_page() with an empty implementation jus=
t
> > >> results in a compiler error as the function needs to return a page
> > >> pointer. Do you actually expect skb_frag_page() to unconditionally
> > >> cast frag->netmem to a page pointer? That was explained as
> > >> unacceptable over and over again by Jason and Christian as it risks
> > >> casting devmem to page; completely unacceptable and will get nacked.
> > >> Do you have a suggestion of what skb_frag_page() should do that will
> > >> not get nacked by mm?
> > >
> > > WARN_ON and return NULL seems reasonable?
> >

That's more or less what I'm thinking.

> > While I am agreed that it may be a nightmare to debug the case of passi=
ng
> > a false page into the mm system, but I am not sure what's the point of
> > returning NULL to caller if the caller is not expecting or handling
> > the
>
> You have to return something and NULL will largely reliably crash the
> thread. The WARN_ON explains in detail why your thread just crashed.
>

Agreed.

> > NULL returning[for example, most of mm API called by the networking doe=
s not
> > seems to handling NULL as input page], isn't the NULL returning will ma=
ke
> > the kernel panic anyway? Doesn't it make more sense to just add a BUG_O=
N()
> > depending on some configuration like CONFIG_DEBUG_NET or CONFIG_DEVMEM?
> > As returning NULL seems to be causing a confusion for the caller of
> > skb_frag_page() as whether to or how to handle the NULL returning case.
>
> Possibly, though Linus doesn't like BUG_ON on principle..
>
> I think the bigger challenge is convincing people that this devmem
> stuff doesn't just open a bunch of holes in the kernel where userspace
> can crash it.
>

It does not, and as of right now there are no pending concerns from
any netdev maintainers regarding mishandled devmem checks at least.
This is because the devmem series comes with a full audit of
skb_frag_page() callers [1] and all areas in the net stack attempting
to access the skb [2].

[1] https://patchwork.kernel.org/project/netdevbpf/patch/20231218024024.351=
6870-10-almasrymina@google.com/
[2] https://patchwork.kernel.org/project/netdevbpf/patch/20231218024024.351=
6870-11-almasrymina@google.com/

> The fact you all are debating what to do with skb_frag_page() suggests
> to me there isn't confidence...
>

The debate raging on is related to the performance of skb_frag_page(),
not correctness (and even then, I don't think it's related to
perf...). Yunsheng would like us to optimize skb_frag_page() using an
unconditional cast from netmem to page. This in Yunsheng's mind is a
performance optimization as we don't need to add an if statement
checking if the netmem is a page. I'm resistant to implement that
change so far because:

(a) unconditionally casting from netmem to page negates the compiler
type safety that you and Christian are laying out as a requirement for
the devmem stuff.
(b) With likely/unlikely or static branches the check to make sure
netmem is page is a no-op for existing use cases anyway, so AFAIU,
there is no perf gain from optimizing it out anyway.

But none of this is related to correctness. Code calling
skb_frag_page() will fail or crash if it's not handled correctly
regardless of the implementation details of skb_frag_page(). In the
devmem series we add support to handle it correctly via [1] & [2].

--=20
Thanks,
Mina

