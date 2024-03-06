Return-Path: <linux-kernel+bounces-94446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9EF873FEB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9F97287C25
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A7513E7C8;
	Wed,  6 Mar 2024 18:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T/ck55oP"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C42D13BAD2
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 18:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709750821; cv=none; b=GytvNWGkb1eVrT2zTgMrnZ+z3snR39bSlDXhc498ALgnXiyzLNAz37NyOCjV1SqItaEpGhTY09VXY0QQ2SLrxtIWT8zcxC+BvAQXlpy/m3x2K5NQTqAo/BW/6Kelyh1ks75xanr1IQcC89yXrklta5OWXz3Q3EWMZcAELoXi6/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709750821; c=relaxed/simple;
	bh=kTYuxtfUD2QmfeyUk7cXkobb5wJLRuu/K1Ka7sZHiGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dC+keY/x+Rafag/FtBnTjBAgWLnvy/xaI/R0H76tc20IEYxG5wZ1Vf4vPDad/Fu3UItsxLaGDkfLFKXSdlXiQ4SXnnmWAZXmR3w0hxrdBtAb31PbMA2C6qROQQ7PbPu+Hfo5Wny8X0MjKHs7200+vZiYVfMLWovpqkeR2uOUSHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T/ck55oP; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a44665605f3so10197766b.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 10:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709750818; x=1710355618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kTYuxtfUD2QmfeyUk7cXkobb5wJLRuu/K1Ka7sZHiGo=;
        b=T/ck55oPecKmpCAUV0ljjUrQb9sNcxr9Ue4KgtB560xWzkGciZc2QItrHX7j7UZZUr
         cgfARyJkZy1tQxc9aZo8BlK2qpbZJligVh43ULowm6nBzrsWC8PXV0oISoz1ao8vUYEe
         mIuwwyM4vM8rY83w+DI8JNnqk6jzaAa7n9lI+yquj7YW3wPVnEkcWcRtkQYFnBd2Hgid
         dGPJzJzN7Un1YP3fZkE1u4YxCkmnICYMNkNnCEYMBhZJERBTyaVni+lhJFWYf0JDxEjb
         diz1rbuC3XEl1wsbsGw5HhYtzNMfb2c0e0fI/xaFQa3HSupVwAaU+EO2ux0wxc/s7AkJ
         OfLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709750818; x=1710355618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kTYuxtfUD2QmfeyUk7cXkobb5wJLRuu/K1Ka7sZHiGo=;
        b=ZIplZN6gqa6gNo8+01/xqY4Izble5ltPwadgHSpDJFM7gvJIrrX+TmNgFGLTZmWAqZ
         Eubplg1mYFBxv/Vy5gR1TsozU04mtZ+gjvGdadewg8To4uzMLeWaZ94B5DP/WFFRbp0s
         gxxpzxR0Gq/oXqo8U0J5RFe4lU6r8sWAJYL1Wce7W763iJGfk4JJooHRrTBBmFcXeWE4
         rxzIw1iwg/QpI+/ye+TT81Dg707PtXwgt2wSHgMUnYN1r0QW0SPmZEqYmQotE3WOZNNl
         4E5e9xEriYQvUpi9CEXNDZqQJeSEpOu3mv3LdWy13oPH+OCXvjjm41OsgHZ/Ing4yHSg
         /QkQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2vIgv+1AOYp4s/2YRUioYw8JGGRD4rS+DiJ9ql/W3EYau8e1PXbD00ydjMWPkM++gzyZaoXfXojXkD4uyJKDaNJsLKnvvm447mS3k
X-Gm-Message-State: AOJu0YzNdB70WRctvMlygPKN3mSJhrk5Po1ZxG1OdESvHBsVuObP6zCp
	KgIQChx3tSLWQspbovAvPbLMttUcVfO5Geqht3ycmmJau0QaVVtw79eRtZ1cQJsD/S2jWavn9Cx
	EobX0+nMKFpg9h62CtUMmyANsa1v6vwG7VPgnu6hI8o3wQVdPKPW+uOQ=
X-Google-Smtp-Source: AGHT+IGnpaVjr1MA0dqAHs0hipRfKx8zMIIxN1GC6HMsoPaQQ0vXmy5DycoKUbw2eTNz3TfD3AGOO+rnsX9WbGnjja4=
X-Received: by 2002:a17:906:409:b0:a45:a390:3232 with SMTP id
 d9-20020a170906040900b00a45a3903232mr4040783eja.29.1709750817406; Wed, 06 Mar
 2024 10:46:57 -0800 (PST)
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
 <20240306094133.7075c39f@kernel.org> <CAHS8izN436pn3SndrzsCyhmqvJHLyxgCeDpWXA4r1ANt3RCDLQ@mail.gmail.com>
In-Reply-To: <CAHS8izN436pn3SndrzsCyhmqvJHLyxgCeDpWXA4r1ANt3RCDLQ@mail.gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 6 Mar 2024 10:46:45 -0800
Message-ID: <CAHS8izOoO-EovwMwAm9tLYetwikNPxC0FKyVGu1TPJWSz4bGoA@mail.gmail.com>
Subject: Re: [RFC] net: esp: fix bad handling of pages from page_pool
To: Jakub Kicinski <kuba@kernel.org>, Liang Chen <liangchen.linux@gmail.com>, 
	Yunsheng Lin <linyunsheng@huawei.com>
Cc: Dragos Tatulea <dtatulea@nvidia.com>, "davem@davemloft.net" <davem@davemloft.net>, 
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

On Wed, Mar 6, 2024 at 10:41=E2=80=AFAM Mina Almasry <almasrymina@google.co=
m> wrote:
>
> On Wed, Mar 6, 2024 at 9:41=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
> >
> > On Wed, 6 Mar 2024 17:09:57 +0000 Dragos Tatulea wrote:
> > > > Does the caller need to check skb->pp_recycle? pp_recycle seems lik=
e a
> > > > redundant bit. We can tell whether the page is pp by checking
> > > > is_pp_page(page). the pages in the frag must be pp pages when
> > > > skb->pp_recycle is set and must be non pp pages when the
> > > > skb->pp_recycle is not set, so it all seems redundant to me.
> > > >
> > > AFAIU we don't have to check for pp_recycle, at least not in this spe=
cific case.
> >
> > Definitely not something we assuming in a fix that needs to go
> > to stable.
> >
> > So far, AFAIU, it's legal to have an skb without skb->pp_recycle
> > set, which holds full page refs to a PP page.
>
> Interesting. I apologize then I did not realize this combination is
> legal. But I have a follow up question: what is the ref code supposed
> to do in this combination? AFAIU:
>
> - skb->pp_recycle && is_pp_page()
> ref via page_pool_ref_page()
> unref via page_pool_unref_page()
>
> - !skb->pp_recycle && !is_pp_page()
> ref via get_page()
> unref via put_page()
>
> - !skb->pp_recycle && is_pp_page()
> ref via ?
> unref via?
>
> Also is this combination also legal you think? and if so what to do?
> - skb->pp_recycle && !is_pp_page()
> ref via ?
> unref via?
>
> I'm asking because I'm starting to wonder if this patch has some issue in=
 it:
> https://patchwork.kernel.org/project/netdevbpf/patch/20231215033011.12107=
-4-liangchen.linux@gmail.com/
>
> Because in this patch, if we have a !skb->pp_recycle & is_pp_page()
> combination we end up doing in skb_try_coalesce():
> ref via page_pool_ref_page()
> unref via put_page() via eventual napi_frag_unref()
>
> which seems like an issue, no?
>

Gah, nevermind, skb_pp_frag_ref() actually returns -EINVAL if
!skb->pp_recycle, and in the call site we do a skb_frag_ref() on this
error, so all in all we end up doing a get_page/put_page pair. Sorry
for the noise.

So we're supposed to:
- !skb->pp_recycle && is_pp_page()
ref via get_page
unref via put_page

Very subtle stuff (for me at least). I'll try to propose some cleanup
to make this a bit simpler using helpers that handle all these subtle
details internally so that the call sites don't have to do this
special handling.


--=20
Thanks,
Mina

