Return-Path: <linux-kernel+bounces-94331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 585EA873D82
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4378B239AB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D9E13BADE;
	Wed,  6 Mar 2024 17:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZnOX00fc"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29C8135401
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 17:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709746081; cv=none; b=qXZdqwdNjyOuPgcL1HVv3ThKQofu7mv6oSJS9AifccKAkZpCFZNdtAvKnF/jv8l4qJMVf6JFSHnmORm7G0XSoah69bdoRQi/BCSWOLiMWqp5+hJjuudU5TEw2RVxZ7QiMmLn6jZ2pyxVJ19+TXxtamhxLDX6hHYQfUBqf4AdPng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709746081; c=relaxed/simple;
	bh=eX3/X50p4A7OOA8htCEucfM7TcgCP6daHV9nlBfFHEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gSQ5Niido9gy6+Cla+jMpNcDX8LUwx1UcO490mKtZyhjvcSRiS99zvqqU0M2o2tdNzvE2pUgDfrESWfL1GUiw6LB9Bu7EPjxygMVel5SB5CeuLTOcXPvmHVi3nwOYOXkt/PIC022zk7yj71giS7CFt5bQvKyLM4ThUamkQbSmsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZnOX00fc; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-563cb3ba9daso1332156a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 09:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709746078; x=1710350878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w94diZ9iNEVg6u9UwjKj2DUh++QG9DmeQZBnfcZOhW8=;
        b=ZnOX00fc9GvzypiOvC+omM8G+kx9tS08LA0Xd7fF6vEC4CtUQ5R/JecEBJl8DfDho7
         ACUKMLpS1o4Bs2X4pKduni6AfwVIXN3ijkJrmqFGcJrjJZlpR3MzeyB1HJVUqZB3Pr/J
         UhSkYKKRXuPTkCCMNNeYf4C0W3G5EfUQpK5fyxMKPHtFYHboYLSnJZ0twFOSuIy1t36i
         yerD9rhU1nyYW5P7IltH1utiKMehW1J8S4JTx+eEK5EIeITVvV/zvwhyP6SsGjpOiN8y
         EDFrAXHPZ84unqUWuO1PUWUbNASJgiHVhCI7+dEWJFVNGP+0/QLWkfVFJ2exuZLh2BD2
         gbBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709746078; x=1710350878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w94diZ9iNEVg6u9UwjKj2DUh++QG9DmeQZBnfcZOhW8=;
        b=k7i1gZiOjgC8grtWnSuhZleIyunD1NPQixDgvf65muzJB0nyRJ3oTiUceSvBTUW9oq
         vwuNfn6tKyPrj8K+QJkmCcWSvStFmBeTGbnoRDP/D2r1Au9/N6BVgtZo4KKfWofwhw+E
         JAHJ6hwHm5kOut8RX68oMIf2ExSJnlnfBI3WKgq8UGILUuXOtIPqhv3nzUDqZGg62E+Y
         M4kg2qSng5bDYPQrcpyH+2UGp3o7znQ5C/y3c5vyMpk1j7Ezq1d7f4aTxaJny0R5jmV5
         Tt6a0m7tpX5p4ri0ZgAwRJHphX7bkVC24cWp0aN7FlNTdaR5U7k7qhHVI2oBWYgWB12H
         SXuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXb3C9V3V0Y0Cx02zZ2ywT8wVaGSJjwsZBvnqqH+uFOcjGHrrm2TqbJMCM4b4fWsYnC7UJler1Ho/LxeVHN99dhDWmnNs+6cPvd2vpx
X-Gm-Message-State: AOJu0YxxRTU+Fi20W/K2vbBdRGb4z05l8DD+vhZwHMaDCBFazJTz/p/C
	Mn/u9g2XSMrPvFjqyO57yecDhRsgoBkIjuJ7rdD4DySfFDCaJIgIa8UMk8h6PLxFqaBiCMy4dUk
	AcHHZCymDom7Y0LI0kH2tq9OteS0nUKS4T1CP
X-Google-Smtp-Source: AGHT+IEBkMzksp0NHQ8swQKzOv58zFZ3WYJCQCTWJNk2pd57sW7vdPk0BysnKSIsx8vreleNP/wzinem9L/gnOwQfU8=
X-Received: by 2002:a17:906:1c81:b0:a45:98f3:997e with SMTP id
 g1-20020a1709061c8100b00a4598f3997emr4847806ejh.7.1709746077588; Wed, 06 Mar
 2024 09:27:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304094950.761233-1-dtatulea@nvidia.com> <20240305190427.757b92b8@kernel.org>
 <7fc334b847dc4d90af796f84a8663de9f43ede5d.camel@nvidia.com>
 <20240306072225.4a61e57c@kernel.org> <320ef2399e48ba0a8a11a3b258b7ad88384f42fb.camel@nvidia.com>
 <20240306080931.2e24101b@kernel.org> <CAHS8izMw_hxdoNDoCZs8T7c5kmX=0Lwqw_dboSj7z1LqtS-WKA@mail.gmail.com>
 <9a78b37abdf40daafd9936299ea2c08f936ad3d5.camel@nvidia.com>
In-Reply-To: <9a78b37abdf40daafd9936299ea2c08f936ad3d5.camel@nvidia.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 6 Mar 2024 09:27:45 -0800
Message-ID: <CAHS8izO-dWP3sHdZYjsEZfF3XS8Qt8jhWAXmx6LU=O9PWtzoqg@mail.gmail.com>
Subject: Re: [RFC] net: esp: fix bad handling of pages from page_pool
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "kuba@kernel.org" <kuba@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, 
	"herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>, Gal Pressman <gal@nvidia.com>, 
	"dsahern@kernel.org" <dsahern@kernel.org>, 
	"steffen.klassert@secunet.com" <steffen.klassert@secunet.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	Leon Romanovsky <leonro@nvidia.com>, "edumazet@google.com" <edumazet@google.com>, 
	"ian.kumlien@gmail.com" <ian.kumlien@gmail.com>, 
	"Anatoli.Chechelnickiy@m.interpipe.biz" <Anatoli.Chechelnickiy@m.interpipe.biz>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 9:10=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.com>=
 wrote:
>
> On Wed, 2024-03-06 at 08:40 -0800, Mina Almasry wrote:
> > On Wed, Mar 6, 2024 at 8:09=E2=80=AFAM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> > >
> > > On Wed, 6 Mar 2024 16:00:46 +0000 Dragos Tatulea wrote:
> > > > > Hm, that's a judgment call.
> > > > > Part of me wants to put it next to napi_frag_unref(), since we
> > > > > basically need to factor out the insides of this function.
> > > > > When you post the patch the page pool crowd will give us
> > > > > their opinions.
> > > >
> > > > Why not have napi_pp_put_page simply return false if CONFIG_PAGE_PO=
OL is not
> > > > set?
> > >
> > > Without LTO it may still be a function call.
> > > Plus, subjectively, I think that it's a bit too much logic to encode =
in
> > > the caller (you must also check skb->pp_recycle, AFAIU)
> > > Maybe we should make skb_pp_recycle() take struct page and move it to
> > > skbuff.h ? Rename it to skb_page_unref() ?
> > >
> >
> > Does the caller need to check skb->pp_recycle? pp_recycle seems like a
> > redundant bit. We can tell whether the page is pp by checking
> > is_pp_page(page). the pages in the frag must be pp pages when
> > skb->pp_recycle is set and must be non pp pages when the
> > skb->pp_recycle is not set, so it all seems redundant to me.
> >
> AFAIU we don't have to check for pp_recycle, at least not in this specifi=
c case.
>
> > My fix would be something like:
> >
> > diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > index d577e0bee18d..cc737b7b9860 100644
> > --- a/include/linux/skbuff.h
> > +++ b/include/linux/skbuff.h
> > @@ -3507,17 +3507,25 @@ int skb_cow_data_for_xdp(struct page_pool
> > *pool, struct sk_buff **pskb,
> >  bool napi_pp_put_page(struct page *page, bool napi_safe);
> >
> >  static inline void
> > -napi_frag_unref(skb_frag_t *frag, bool recycle, bool napi_safe)
> > +napi_page_unref(struct page *page, bool napi_safe)
> >  {
> > -       struct page *page =3D skb_frag_page(frag);
> > -
> >  #ifdef CONFIG_PAGE_POOL
> > -       if (recycle && napi_pp_put_page(page, napi_safe))
> > +       if (napi_pp_put_page(page, napi_safe))
> >                 return;
> >  #endif
> >         put_page(page);
> >  }
> >
> > +static inline void
> > +napi_frag_unref(skb_frag_t *frag, bool recycle, bool napi_safe)
> > +{
> > +       struct page *page =3D skb_frag_page(frag);
> > +
> > +       DEBUG_NET_WARN_ON(recycle !=3D is_pp_page(page));
> > +
> > +       napi_page_unref(page);
> > +}
> > +
> >
> > And then use napi_page_unref() in the callers to handle page pool &
> > non-page pool gracefully without leaking page pool internals to the
> > callers.
> >
> We'd also need to add is_pp_page() in the header with the changes above..=
.
>

Gah, I did not realize skbuff.h doesn't have is_pp_page(). Sorry!

> On that line of thought, unless these new APIs are useful for other use-c=
ases,
> why not keep it simple:
> - Move is_pp_page() to skbuff.h.

I prefer this. is_pp_page() is a one-liner anyway.

> - Do a simple is_pp_page(page) ? page_pool_put_full_page(page):put_page(p=
age) in
> the caller? Checking skb->pp_recycle would not be needed.
>

IMHO page pool internals should not leak to the callers like this.
There should be a helper that does the right thing for pp & non-pp
pages so that the caller can use it without worrying about subtle pp
concepts that they may miss at some callsites, but I'm fine either way
if there is strong disagreement from others.

> Thanks,
> Dragos
>
> > > > Regarding stable would I need to send a separate fix that does the =
raw pp page
> > > > check without the API?
> > >
> > > You can put them in one patch, I reckon.
> >
>


--=20
Thanks,
Mina

