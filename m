Return-Path: <linux-kernel+bounces-30171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FFD831AEF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 14:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4778FB25ABA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 13:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D88425639;
	Thu, 18 Jan 2024 13:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1VOpneTI"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5784250E7
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 13:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705586229; cv=none; b=MY9e0crdOaArIe7TT6STwjSwWxwrx0qOgan2qGu1hr1TDbInPzolh5RLObM91tLpGo29H94zcZUSNzrZOokpUy4x3++rIFcPzRcU7FaLvJC/puLCmG8ukFujVOpYzTYc6+kVU1cqCHdonXwGkIw3sONFq/4V0ZwZilse2USUv8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705586229; c=relaxed/simple;
	bh=rmDgETvZzgz0Wy+BlvQmxNiaIXplxxgYOnwqePWgsyY=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=PKTzOsBoEovy9WtT2K384413XIfPib6K6kbhE9DDpZMBEPKXmuHIVMuSdChdzXGH5p09IlgVo5wn4tLiOsiiblvf3ecRdFnjDUm6Ztz9Sn6zYmd46qycwLsDjQ7chhOuYYj7d9FU31q9SGjiFxP0b1n6c3GD+9M13Nb5gfe9jrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1VOpneTI; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-50ea9e189ebso14230707e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 05:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705586226; x=1706191026; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PwSnx95cO6mFrsPU26AYVuo3uyLppp+SMC5NBDN3TyU=;
        b=1VOpneTIXzicXapRjDe4SG46H4PffWiCHRFzJgiKDXLJCJp+V7OkN/Q8DI5V2fQxEu
         +G42AJeRqBK37Nd6cpcOG/0h0oHQxpZYwgtZ2kyb8BE4pHItGgZEf8kee9ZGJxvFwnhw
         IGamptLkR8sWya67ujpjToN1ZS1oHR/CN0aVeNuU5ZWM3E0GDtiYSuCItMZFnMe6VuRn
         QjlDl38XsqM7n8Oat3JzuxqChND1un5p7LHvQD40473hlVI8VIsQENfLyvIzxKbHUCLJ
         BPjJrsN8JYvGNOKwJ74J9aXsTwC2dP38wdj8Ew7ykb34KHgR1LSF+qM8MZLZHqf6VCIV
         o+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705586226; x=1706191026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PwSnx95cO6mFrsPU26AYVuo3uyLppp+SMC5NBDN3TyU=;
        b=C8XHCKlM0TacCztlq7a7K2cUo9A/BFtzCiw544MHtYb0pSSa0e/gaZ1n/Mkc9KutWh
         I+fxV/HMC37bA2ulTwc5YkYjD0M/i2FEG+czDoYMrF2SJIJFHuLmYcTcm2TU3GCdigsl
         7L42jiqsUwWPKgHkwFkE0Gv/Cqjxi9EEAmSrQeRfkZCtU2KbLB/tRj4B4dqyPUiJvyvx
         9LIetrVrRDh8V217I0UaDqtmumhH2D87kEVIA/cVZ1wLLczNzC2kpwuIT+pIYdjoub1n
         fegCIrCFG3DpfjFwjKag+EUqiEGv3pyypEavYVFvICL/+DGjVtG2tMMCO4MTNUpX1MSp
         pfdw==
X-Gm-Message-State: AOJu0YxlqscmdNiYaoinhAKcHYaUxPp2qwnjzMEwtfMiixZqt8A7l8Zc
	2DufFutsVo/tw+d1u+Oynuw7fqYOZq05w49cfkhIEfKP8PidImpzItU1VlbKYE+7/y28wmIVW6H
	epZ0xtnlB5rylxK6GpMx+bkZeZD16wZe0+lCU
X-Google-Smtp-Source: AGHT+IHl3eRLQirJ+Tzq8N9tnWQ9WTOjiBOJ2n2gTX0lzr9VJme9YPiGICdk8wHM+SayPFCAc2kPvVUfvyWrMi611qs=
X-Received: by 2002:a05:6512:2382:b0:50e:4389:12c5 with SMTP id
 c2-20020a056512238200b0050e438912c5mr549814lfv.14.1705586225480; Thu, 18 Jan
 2024 05:57:05 -0800 (PST)
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
 <20240116121611.GY734935@nvidia.com> <CAHS8izPa6ostY7qZUAmm4g8N3rfWoVBK6r5z0_MycxfsEVH4jw@mail.gmail.com>
 <CAHS8izO1-+MczzFw_R80uv=aK5A9bUNcKroY=H9Euk+ZPnnGPw@mail.gmail.com> <65a8225348b92_11eb12942c@willemb.c.googlers.com.notmuch>
In-Reply-To: <65a8225348b92_11eb12942c@willemb.c.googlers.com.notmuch>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 18 Jan 2024 05:56:51 -0800
Message-ID: <CAHS8izOiR3zvqCyRdBJchqGe-tYnoCpyYvwxroVFA6-_-i+EyQ@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v5 2/2] net: add netmem to skb_frag_t
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Yunsheng Lin <linyunsheng@huawei.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 10:54=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Mina Almasry wrote:
> > On Wed, Jan 17, 2024 at 10:00=E2=80=AFAM Mina Almasry <almasrymina@goog=
le.com> wrote:
> > >
> > > On Tue, Jan 16, 2024 at 4:16=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.c=
om> wrote:
> > > >
> > > > On Tue, Jan 16, 2024 at 07:04:13PM +0800, Yunsheng Lin wrote:
> > > > > On 2024/1/16 8:01, Jason Gunthorpe wrote:
> > > > > > On Mon, Jan 15, 2024 at 03:23:33PM -0800, Mina Almasry wrote:
> > > > > >>>> You did not answer my question that I asked here, and ignori=
ng this
> > > > > >>>> question is preventing us from making any forward progress o=
n this
> > > > > >>>> discussion. What do you expect or want skb_frag_page() to do=
 when
> > > > > >>>> there is no page in the frag?
> > > > > >>>
> > > > > >>> I would expect it to do nothing.
> > > > > >>
> > > > > >> I don't understand. skb_frag_page() with an empty implementati=
on just
> > > > > >> results in a compiler error as the function needs to return a =
page
> > > > > >> pointer. Do you actually expect skb_frag_page() to uncondition=
ally
> > > > > >> cast frag->netmem to a page pointer? That was explained as
> > > > > >> unacceptable over and over again by Jason and Christian as it =
risks
> > > > > >> casting devmem to page; completely unacceptable and will get n=
acked.
> > > > > >> Do you have a suggestion of what skb_frag_page() should do tha=
t will
> > > > > >> not get nacked by mm?
> > > > > >
> > > > > > WARN_ON and return NULL seems reasonable?
> > > > >
> > >
> > > That's more or less what I'm thinking.
> > >
> > > > > While I am agreed that it may be a nightmare to debug the case of=
 passing
> > > > > a false page into the mm system, but I am not sure what's the poi=
nt of
> > > > > returning NULL to caller if the caller is not expecting or handli=
ng
> > > > > the
> > > >
> > > > You have to return something and NULL will largely reliably crash t=
he
> > > > thread. The WARN_ON explains in detail why your thread just crashed=
.
> > > >
> > >
> > > Agreed.
> > >
> > > > > NULL returning[for example, most of mm API called by the networki=
ng does not
> > > > > seems to handling NULL as input page], isn't the NULL returning w=
ill make
> > > > > the kernel panic anyway? Doesn't it make more sense to just add a=
 BUG_ON()
> > > > > depending on some configuration like CONFIG_DEBUG_NET or CONFIG_D=
EVMEM?
> > > > > As returning NULL seems to be causing a confusion for the caller =
of
> > > > > skb_frag_page() as whether to or how to handle the NULL returning=
 case.
> > > >
> > > > Possibly, though Linus doesn't like BUG_ON on principle..
> > > >
> > > > I think the bigger challenge is convincing people that this devmem
> > > > stuff doesn't just open a bunch of holes in the kernel where usersp=
ace
> > > > can crash it.
> > > >
> > >
> > > It does not, and as of right now there are no pending concerns from
> > > any netdev maintainers regarding mishandled devmem checks at least.
> > > This is because the devmem series comes with a full audit of
> > > skb_frag_page() callers [1] and all areas in the net stack attempting
> > > to access the skb [2].
> > >
> > > [1] https://patchwork.kernel.org/project/netdevbpf/patch/202312180240=
24.3516870-10-almasrymina@google.com/
> > > [2] https://patchwork.kernel.org/project/netdevbpf/patch/202312180240=
24.3516870-11-almasrymina@google.com/
> > >
> > > > The fact you all are debating what to do with skb_frag_page() sugge=
sts
> > > > to me there isn't confidence...
> > > >
> > >
> > > The debate raging on is related to the performance of skb_frag_page()=
,
> > > not correctness (and even then, I don't think it's related to
> > > perf...). Yunsheng would like us to optimize skb_frag_page() using an
> > > unconditional cast from netmem to page. This in Yunsheng's mind is a
> > > performance optimization as we don't need to add an if statement
> > > checking if the netmem is a page. I'm resistant to implement that
> > > change so far because:
> > >
> > > (a) unconditionally casting from netmem to page negates the compiler
> > > type safety that you and Christian are laying out as a requirement fo=
r
> > > the devmem stuff.
> > > (b) With likely/unlikely or static branches the check to make sure
> > > netmem is page is a no-op for existing use cases anyway, so AFAIU,
> > > there is no perf gain from optimizing it out anyway.
> > >
> >
> > Another thought, if anyone else is concerned about the devmem checks
> > performance,  potentially we could introduce CONFIG_NET_DEVMEM which
> > when disabled prevents the user from using devmem at all (disables the
> > netlink API).
> >
> > When that is disabled, skb_frag_page(), netmem_to_page() & friends can
> > assume netmem is always a page and do a straight cast between netmem &
> > page. When it's enabled, it will check that netmem =3D=3D page before
> > doing a cast, and return NULL if it is not a page.
> >
> > I think this is technically viable and I think preserves the compiler
> > type safety requirements set by mm folks. From my POV though, bloating
> > the kernel with a a new CONFIG just to optimize out no-op checks seems
> > unnecessary, but if there is agreement that the checks are a concern,
> > adding CONFIG_NET_DEVMEM should address it while being acceptable to
> > mm maintainers.
>
> I agree. A concern with CONFIGs is that what matters in practice is
> which default the distros compile with. In this case, adding hurdles
> to using the feature likely for no real reason.
>
> Static branches are used throughout the kernel in performance
> sensitive paths, exactly because they allow optional paths effectively
> for free. I'm quite surprised that this issue is being raised so
> strongly here, as they are hardly new or controversial.
>
> But perhaps best is to show with data. Is there a representative page
> pool benchmark that exercises the most sensitive case (XDP_DROP?) that
> we can run with and without a static branch to demonstrate that any
> diff is within the noise?
>

Yes, Jesper has a page_pool benchmark that he pointed me to in RFC v2:

https://github.com/netoptimizer/prototype-kernel/blob/master/kernel/lib/ben=
ch_page_pool_simple.c

When running the results on RFCv2, the results were:

net-next @ b44693495af8
https://pastebin.com/raw/JuU7UQXe

+ devmem TCP changes:
https://pastebin.com/raw/mY1L6U4r

On RFC v2 the benchmark showed only a single instruction regression in
the page_pool fast path & the change deemed acceptable to Jesper from
a performance POV [1].

I have not run the benchmark continually on follow up iterations of
the RFC, but I think I'll start doing so in the future.

[1] https://lore.kernel.org/netdev/7aedc5d5-0daf-63be-21bc-3b724cc1cab9@red=
hat.com/

> > > But none of this is related to correctness. Code calling
> > > skb_frag_page() will fail or crash if it's not handled correctly
> > > regardless of the implementation details of skb_frag_page(). In the
> > > devmem series we add support to handle it correctly via [1] & [2].
> > >
> > > --
> > > Thanks,
> > > Mina
> >
> >
> >
> > --
> > Thanks,
> > Mina
>
>


--=20
Thanks,
Mina

