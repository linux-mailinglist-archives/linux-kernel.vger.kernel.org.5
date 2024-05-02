Return-Path: <linux-kernel+bounces-166892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB738BA169
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 22:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D25881C20E52
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 20:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34772181301;
	Thu,  2 May 2024 20:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g87r6rca"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3535180A82
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 20:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714680519; cv=none; b=ewLAyrjprQtKBy2SJKKk+QX2Ww4xT4/aA8kKnie6bt1IDEUXCWCm5KSCAqWp1xjvXPg9CqaLMvNYnHTCj6lbaDWGhEZrIEFusCgALVSpDwVes4CLEWI5zV/Jw5j1ewJgAcdUya45cE3Q0aKYDef8He6WbI4VHMlNhhaL9cMo1mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714680519; c=relaxed/simple;
	bh=3IYp4lRTQzmLzgGC9pmgdaaE/T9wslCBCEEl1047Fdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c13H1vlzX6SAxCYzGxiz31vyGQmbgMWRxoIqOthPed8sdDe1zcso0JukjM6CQ87nII446tauYHX8whBMJ1nFaq8oyizHyBhSzRO3lUxn5xH93r/lDXuiVyY1COqutYGts1FxOI+d8L9oK5WG5c61vmsiHaG4iRQBOTCZk9L10Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g87r6rca; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a595199cb9bso323860566b.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 13:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714680516; x=1715285316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w7bHDLJ7ExWZnW/zCrBxpFgsWVLK4EooXDm/uirDOi4=;
        b=g87r6rcaroN6m6Ha3jE6mL6bgDXBYxYsfo8/2VrEd0v3QO/baPSi9d6kGq2alrLXqK
         Whenv6Qasq7HMnibi7bt9aprjuUJ4a1ZE+7xffxwGb6sn7kPtEj8YL/InK7F868n7XRu
         564jfcJF9mhv0C4vdVUTwWYmgFCYBqiXUma/UInYCZGsnK/W++FXvPrN8cnGyHJd4YIe
         GTgiTIcypwld51rG0k4vF/vxkQf/JkTy7FuM3JSWqAzt0d1AEBwZQrItvXBZXRgUMWsl
         uqzibryvsK14x4TsmhE6SRvVmbqqkG7N+u/HdsPimJiIRZjsiGJ+i/smreDmPeqhD4v7
         M9uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714680516; x=1715285316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w7bHDLJ7ExWZnW/zCrBxpFgsWVLK4EooXDm/uirDOi4=;
        b=Hi8979Qa7ZplFxtjYbkr7Ksu7+lngQx8S7asSsvZh9E4MGX6fIYTnmzW4e9Q1jti8h
         /gOXCygDrxrpWRF+pdIEAiOQ8SNrJZBStqO03ytr6UFdZ4N54bIukm0CRZ02lynHcK9j
         VFem/xEe8+dYIt9yQ8PuyKatopusHi/oVjvZjFpE4zUPcTlvd9no+nSLM+AvYWWI0HnL
         H7lARpOUPzVaCdG99oraZlUa/XtIubncARDQOYHPPb3QzKfndzbpjF/PLMfE6SC7mtFT
         jRonNamwVrO3sb3+D/IrO+eotaBcaZm8awnjMJPYdj8hze3UC2H+htatZLeWrF65u6cS
         t99w==
X-Forwarded-Encrypted: i=1; AJvYcCWNt2JV+0I4myoBpWM3vptQPsdFaBYoD9HTYr5F9Q6ENl6qad2o1j6sRj/BQRGN8EshU8XsL7G/9ojS3Hhm26q8K8+GSi88klBSZzsa
X-Gm-Message-State: AOJu0YxIbbCmxC6db5+1RbQQdXbUbzln64s77T/h5m/8UUZTgfrZgDMr
	7Iwtks3Y0p5YvDWIgCgAVwxicn8aI5POU92/a06xcC5/vvYKWot1jQ/FPWPKDPkRqhf/JvaAet7
	H15PnTqVESmiKZSQrq28D3jp7RbWTXzxfpKgX
X-Google-Smtp-Source: AGHT+IFc79OoA6cHdMREvw/F5+U+f5TUvfpAw59eNfwjV/TrZ+jI0Si/9Dzy8J7JFxVy8yrrTpCSw98BqmRTC+TzxDI=
X-Received: by 2002:a17:906:387:b0:a58:bce5:9b49 with SMTP id
 b7-20020a170906038700b00a58bce59b49mr315966eja.44.1714680515692; Thu, 02 May
 2024 13:08:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424165646.1625690-2-dtatulea@nvidia.com> <4ba023709249e11d97c78a98ac7db3b37f419960.camel@nvidia.com>
 <CAHS8izMbAJHatnM6SvsZVLPY+N7LgGJg03pSdNfSRFCufGh9Zg@mail.gmail.com>
 <4c20b500c2ed615aba424c0f3c7a79f5f5a04171.camel@nvidia.com>
 <CAHS8izPkRJyLctmyj+Ppc5j3Qq5O1u3aPe5h9mnFNHDU2OxA=A@mail.gmail.com>
 <20240426160859.0d85908e@kernel.org> <CAHS8izNs-LV=6FE39sjF3V7qVfveOsOAOJ_X62TSzWpvamsS0Q@mail.gmail.com>
 <20240429080022.214a9df9@kernel.org>
In-Reply-To: <20240429080022.214a9df9@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 2 May 2024 13:08:23 -0700
Message-ID: <CAHS8izPBhZ1USvSoDdR-Xwg3jNL5ppRXTzc3FEM9gjx6B1fJAw@mail.gmail.com>
Subject: Re: [RFC PATCH] net: Fix one page_pool page leak from skb_frag_unref
To: Jakub Kicinski <kuba@kernel.org>
Cc: Dragos Tatulea <dtatulea@nvidia.com>, "davem@davemloft.net" <davem@davemloft.net>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, 
	"ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"jacob.e.keller@intel.com" <jacob.e.keller@intel.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jianbo Liu <jianbol@nvidia.com>, 
	"edumazet@google.com" <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 8:00=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 26 Apr 2024 21:24:09 -0700 Mina Almasry wrote:
> > On Fri, Apr 26, 2024 at 4:09=E2=80=AFPM Jakub Kicinski <kuba@kernel.org=
> wrote:
> > >
> > > On Thu, 25 Apr 2024 12:20:59 -0700 Mina Almasry wrote:
> > > > -       if (recycle && napi_pp_get_page(page))
> > > > +       if (napi_pp_get_page(page))
> > >
> > > Pretty sure you can't do that. The "recycle" here is a concurrency
> > > guarantee. A guarantee someone is holding a pp ref on that page,
> > > a ref which will not go away while napi_pp_get_page() is executing.
> >
> > I don't mean to argue, but I think the get_page()/put_page() pair we
> > do in the page ref path is susceptible to the same issue. AFAIU it's
> > not safe to get_page() if another CPU can be dropping the last ref,
> > get_page_unless_zero() should be used instead.
>

I uploaded a revert for review, but to reland I perhaps need to
understand a bit more the concern here. AFAICT that diff you're
responding to is safe and it works very well with devmem so it would
be my preferred approach to reland (but there are other options if you
are convinced it's bad). FWIW my thoughts:

> Whoever gave us the pointer to operate on has a reference, so the page
> can't disappear. get_page() is safe.

Agreed.

> The problem with pp is that we
> don't know whether the caller has a pp ref or a page ref. IOW the pp
> ref may not be owned by whoever called us.
>

OK, this is where I'm not sure anymore. The diff you're replying to
attempts to enforce the invariant: "if anyone wants a reference on an
skb_frag, skb_frag_ref will be a pp ref on pp frags
(is_pp_page=3D=3Dtrue), and page refs on non-pp frags
(is_pp_page=3D=3Dfalse)".

Additionally the page doesn't transition from pp to non-pp and vice
versa while anyone is holding a pp ref, because
page_pool_set_pp_info() is called right after the page is obtained
from the buddy allocator (before released from the page pool) and
page_pool_clear_pp_info() is called only after all the pp refs are
dropped.

So:

1. We know the caller has a ref (otherwise get_page() wouldn't be safe
in the non-pp case).
2. We know that the page has not transitioned from pp to non-pp or
vice versa since the caller obtained the ref (from code inspection, pp
info is not changed until all the refs are dropped for pp pages).
3. AFAICT, it follows that if the page is pp, then the caller has a pp
ref, and if the page is non-pp, then the caller has a page ref.
4. So, if is_pp_page=3D=3Dtrue, then the caller has a pp ref, then
napi_pp_get_page() should be concurrently safe.

AFAICT the only way my mental model is broken is if there is code
doing a raw get_page() rather than a skb_frag_ref() in core net stack.
I would like to get rid of these call sites if they exist. They would
not interact well with devmem I think (but could be made to work with
some effort).

--
Thanks,
Mina

