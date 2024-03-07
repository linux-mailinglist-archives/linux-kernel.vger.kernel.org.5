Return-Path: <linux-kernel+bounces-94858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70772874609
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 504E5286D8A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 02:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03EBA17BB5;
	Thu,  7 Mar 2024 02:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e2haLrco"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BB415EA6;
	Thu,  7 Mar 2024 02:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709777762; cv=none; b=nLsIkrYbZHkrdlbFfW9jaqZD2KNuEmkYRz94OPiQsSVPFxKKSOoi9ufOUfCzwyXey/radYFcfr86dcER1+JtXupXaEQKC5lWPyl+cp9uw0+bskbOhzADs3DolB5uQ2uwenl9xfPYwK46yAYpUP3E8PiMgdYPVx0rHThD2TGlCZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709777762; c=relaxed/simple;
	bh=Cw89We1aTAVBbcBRos65D+qMVJWNLUVeKILK2DWf540=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T9jx8jzZ3kv1NM891tfP4ujUR+0oxkAKbi0rB577DSa3HnPKRGjmfKmqTrfQI0qyg9cFYMfQqDwCOCza2eUgtEllnJb8Wb7aHwO2oAJVM/a5Xus03Uuexn7X1LkFZC0IvHZABmnYVKFOJJdEX5NLORd/cgBpcoviKhhWubLNzbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e2haLrco; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B1BC43390;
	Thu,  7 Mar 2024 02:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709777761;
	bh=Cw89We1aTAVBbcBRos65D+qMVJWNLUVeKILK2DWf540=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e2haLrcoYyKOlH2ZZ7Rf2CK7O15Lo2E4Oo5/0FMZRY1/4m0vAJc7leeijC1NOZL/Q
	 VFqcSJcgHOooJ/oa6qlbuQ4Ae6kYuqlId0zP2V4BKXfRz7qldYKowGfkO0SC0LHa9b
	 rCUh6zs2WQYuNhvgy05KaFAW3UzmQfdupjgIo4nyNIT6iwWozWi6D0gmspUrvORIPF
	 4Ka4+bjiQR8ADhwLoCSpt3VlxbFfeRlynSh1LA1Ye/sA/O9fu1GmVl63FgJTgZ+6R6
	 gmAm5XzUS7RlaaZi7B16Yg8ARBnUcqZcbvfJC1sTgYhXR4TwttR4QEgZjm8R1Vh/VA
	 O20Ji8xeC+9Kw==
Date: Wed, 6 Mar 2024 18:16:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: Liang Chen <liangchen.linux@gmail.com>, Yunsheng Lin
 <linyunsheng@huawei.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 "davem@davemloft.net" <davem@davemloft.net>, "herbert@gondor.apana.org.au"
 <herbert@gondor.apana.org.au>, Gal Pressman <gal@nvidia.com>,
 "dsahern@kernel.org" <dsahern@kernel.org>, "steffen.klassert@secunet.com"
 <steffen.klassert@secunet.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
 Leon Romanovsky <leonro@nvidia.com>, "edumazet@google.com"
 <edumazet@google.com>, "ian.kumlien@gmail.com" <ian.kumlien@gmail.com>,
 "Anatoli.Chechelnickiy@m.interpipe.biz"
 <Anatoli.Chechelnickiy@m.interpipe.biz>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Subject: Re: [RFC] net: esp: fix bad handling of pages from page_pool
Message-ID: <20240306181600.5af8ef5f@kernel.org>
In-Reply-To: <CAHS8izOoO-EovwMwAm9tLYetwikNPxC0FKyVGu1TPJWSz4bGoA@mail.gmail.com>
References: <20240304094950.761233-1-dtatulea@nvidia.com>
	<20240305190427.757b92b8@kernel.org>
	<7fc334b847dc4d90af796f84a8663de9f43ede5d.camel@nvidia.com>
	<20240306072225.4a61e57c@kernel.org>
	<320ef2399e48ba0a8a11a3b258b7ad88384f42fb.camel@nvidia.com>
	<20240306080931.2e24101b@kernel.org>
	<CAHS8izMw_hxdoNDoCZs8T7c5kmX=0Lwqw_dboSj7z1LqtS-WKA@mail.gmail.com>
	<9a78b37abdf40daafd9936299ea2c08f936ad3d5.camel@nvidia.com>
	<20240306094133.7075c39f@kernel.org>
	<CAHS8izN436pn3SndrzsCyhmqvJHLyxgCeDpWXA4r1ANt3RCDLQ@mail.gmail.com>
	<CAHS8izOoO-EovwMwAm9tLYetwikNPxC0FKyVGu1TPJWSz4bGoA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 Mar 2024 10:46:45 -0800 Mina Almasry wrote:
> Gah, nevermind, skb_pp_frag_ref() actually returns -EINVAL if
> !skb->pp_recycle, and in the call site we do a skb_frag_ref() on this
> error, so all in all we end up doing a get_page/put_page pair. Sorry
> for the noise.
> 
> So we're supposed to:
> - !skb->pp_recycle && is_pp_page()
> ref via get_page
> unref via put_page
> 
> Very subtle stuff (for me at least). I'll try to propose some cleanup
> to make this a bit simpler using helpers that handle all these subtle
> details internally so that the call sites don't have to do this
> special handling.

Sure, although complexity is complexity, we can only do so much to hide
it.

For pp_recycle - the problem is when we added page pool pages, hardly
anything in the upper layers of the stack was made pp aware. So we can
end up with someone doing

	get_page(page);
	skb_fill_page_desc(skb, page);

on a PP page.

You probably inspected a lot of those cases for the ZC work, and they
can be fixed up to do a "pp-aware get()", but until then we need
skb->pp_recycle. pp_recycle kinda denotes whether whoever constructed
the skb was PP aware.

So, yes, definitely a good long term goal, but not in a fix :)

