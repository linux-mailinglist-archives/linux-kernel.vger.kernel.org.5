Return-Path: <linux-kernel+bounces-94942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 183908746FC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 04:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76B92B21C77
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FC514AB2;
	Thu,  7 Mar 2024 03:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NpIiOPLI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D6C17EF;
	Thu,  7 Mar 2024 03:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709783642; cv=none; b=jzsuN1X3RJXhLIno9uzzqXl0Fm8tXI0MqQI6s7hHa2j8Bcv/3Hmqvk4Z6HksR+249FbF44h0MZNnTC1q3hbFdsu3/9KIgvbrovuwxqMO5BQuomHUWB+bm+WPZGAC+JqIloMNL530EgBXUfRSZlau8Ug5UEmW1v3ZqtEKimqtmrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709783642; c=relaxed/simple;
	bh=iSpHqEag2Fld1WLfW4PXYjSa646zc+x1ABtd6XNLjsU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H6D6UIi7IPuXa5cBwYPoZtVszo/A+ordgVP5hZhX/BLOjDdwpjI+l2hMikeCQH95fGa8LkkCuPx5dY0896p8khqAfoEEr2tvvFOg5PQCs4W9gVcQulybPJvLohh02zup7J5fxkIxKydzR48zvws35ljOOJNnVIClNnvkdjYmDy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NpIiOPLI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2CABC433C7;
	Thu,  7 Mar 2024 03:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709783641;
	bh=iSpHqEag2Fld1WLfW4PXYjSa646zc+x1ABtd6XNLjsU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NpIiOPLI/8nsHeQhmmwcc6IgmuKb/seG+hgs5nmxnNsIaX8JeS0rW7/fzwPSOK+tO
	 r2amgOahfzA9gG9tDDHCffVjSjI4XJurNCxyxqxMMn8HoC4A/4vaZy+0t3HJwEkMhk
	 UPQM/VcK3PFuT/G+6itsuu0V0L2QYzzWmq1GkbafHtDaqcDX15EGC3afepvt0gT8vs
	 XQ7HXyl/8sXobX5PpbbYtRzrPmeTxag8y0dNwcbI+kQaAz8tstVuE+ppweiFmUdF9K
	 I0I6fWZu2OVkEsI3UZ0qP0t9ALRFE0y8nbzJfF0D+TvlvcJu4n5zQx1Kstq7h4LE1q
	 g/MawhybuI/kQ==
Date: Wed, 6 Mar 2024 19:53:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>,
 "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
 "dsahern@kernel.org" <dsahern@kernel.org>, "steffen.klassert@secunet.com"
 <steffen.klassert@secunet.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "edumazet@google.com" <edumazet@google.com>, "almasrymina@google.com"
 <almasrymina@google.com>, Leon Romanovsky <leonro@nvidia.com>, Gal Pressman
 <gal@nvidia.com>, "Anatoli.Chechelnickiy@m.interpipe.biz"
 <Anatoli.Chechelnickiy@m.interpipe.biz>, "ian.kumlien@gmail.com"
 <ian.kumlien@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2] net: esp: fix bad handling of pages from
 page_pool
Message-ID: <20240306195359.1afb26d2@kernel.org>
In-Reply-To: <9ac9ffa9d11907dcb4a300bf4e81545b7acc40d6.camel@nvidia.com>
References: <20240306190822.390086-1-dtatulea@nvidia.com>
	<9ac9ffa9d11907dcb4a300bf4e81545b7acc40d6.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 Mar 2024 19:09:58 +0000 Dragos Tatulea wrote:
> > Changes in v2:
> > - Added napi_page_unref api based on discussion in v1 [0].
> > 
> > [0]https://lore.kernel.org/netdev/CAHS8izOoO-EovwMwAm9tLYetwikNPxC0FKyVGu1TPJWSz4bGoA@mail.gmail.com/T/#t
> >   
> Jakub, are you sure that it is ok to have all this in a single patch?

Yup.

> > ---
> >  include/linux/skbuff.h | 10 +++++++---
> >  net/ipv4/esp4.c        | 16 ++++++++++------
> >  net/ipv6/esp6.c        | 16 ++++++++++------
> >  3 files changed, 27 insertions(+), 15 deletions(-)
> > 
> > diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > index 696e7680656f..009603db2a43 100644
> > --- a/include/linux/skbuff.h
> > +++ b/include/linux/skbuff.h
> > @@ -3453,10 +3453,8 @@ int skb_cow_data_for_xdp(struct page_pool *pool, struct sk_buff **pskb,
> >  bool napi_pp_put_page(struct page *page, bool napi_safe);
> >  
> >  static inline void
> > -napi_frag_unref(skb_frag_t *frag, bool recycle, bool napi_safe)
> > +napi_page_unref(struct page *page, bool recycle, bool napi_safe)

I'd call it skb_page_unref()

The napi_ prefix will just confuse people, because we don't have to be
in NAPI context at all when calling this. As long as "napi_safe" is
correctly set to false.  So let's use skb_ as the prefix.

And I'd pass skb to this, not "bool recycle" so that the caller doesn't
have to know the weird details..

