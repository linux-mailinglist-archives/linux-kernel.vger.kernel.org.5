Return-Path: <linux-kernel+bounces-123348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F21C8906F8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD8DFB25B84
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED0B59B4E;
	Thu, 28 Mar 2024 17:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JELJL5bi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FBC1CD24;
	Thu, 28 Mar 2024 17:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711645855; cv=none; b=tiKzBUI5sd7YLUEoqXt51P55k5X0Ak9ZG/FoHoWKBQ10cheB281zePyKBclTFyNYLNBzH1M0qYuw+E1NqP/zkp8kca4D8cIlafhCfJfG/EhinutqA9rQ3UK5Q/pOcxBiq98SKralnA7GkFpXmHD3iOd0omLRFO7aiyk9GJpRk7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711645855; c=relaxed/simple;
	bh=R8LpNjl8m4fubf+pY59w77ALbveltFnOc5DHBVdn/08=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IrufnF3cBqCw8an148n/s/s8kx5J1wVzDdbtTb1GsK8sbcRFk63dbe3Vytve3G3/mnJekgL/hD61qAm2GMh9jdYDC/PUU50D+uIvLGLFaPGo889nIPmEFiP19w8NTEs8FBRft4Ke2O5V4EvSHaOt5/P/DfuxSMg/LnXk60ZwZy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JELJL5bi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A6FC43390;
	Thu, 28 Mar 2024 17:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711645855;
	bh=R8LpNjl8m4fubf+pY59w77ALbveltFnOc5DHBVdn/08=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JELJL5biHYV9q1YEvBoGXM2gCd44ho1PIKaxqhn+7X3Na5tue1FvPcWVDknuu2lrA
	 gbyj1UXAxEMAvtd/3/ydrcp2cHV/45zjhGh1qYcVHG/CBdpgZfZ5btt+/YSY7d8oXH
	 Kkm2E2Rck7d5sz+y9LYoMMDfY3TmxLUrutcP5ZDY58ez0E/yEVL2zNHuYT2/KPwi29
	 U+k2AUYv3B6oxuRLfsYLzW5V3hGXRDjJbT6qYvN2j2BR7pQUltvrDqPtE9ehKNOUrF
	 puqLKyxESL0/eyelmzhhwLzztquc01WxLX9p9xoYUvTP8v9Qin8wfVT2tcrB5uVQKy
	 01meEHIh0Kb3w==
Date: Thu, 28 Mar 2024 10:10:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Breno Leitao <leitao@debian.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Paolo Abeni"
 <pabeni@redhat.com>, <quic_jjohnson@quicinc.com>, <kvalo@kernel.org>,
 <leon@kernel.org>, <dennis.dalessandro@cornelisnetworks.com>, Jiri Pirko
 <jiri@resnulli.us>, Simon Horman <horms@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Lorenzo Bianconi <lorenzo@kernel.org>, Coco Li
 <lixiaoyan@google.com>, "open list:NETWORKING DRIVERS"
 <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: create a dummy net_device allocator
Message-ID: <20240328101053.69a968ec@kernel.org>
In-Reply-To: <10d89693-21af-4560-a088-d58d16cbb9dd@intel.com>
References: <20240327200809.512867-1-leitao@debian.org>
	<10d89693-21af-4560-a088-d58d16cbb9dd@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Mar 2024 16:02:12 +0100 Alexander Lobakin wrote:
> > +/**
> > + * alloc_netdev_dummy - Allocate and initialize a dummy net device.
> > + * @sizeof_priv: size of private data to allocate space for
> > + * @name: device name format string
> > + */
> > +struct net_device *alloc_netdev_dummy(int sizeof_priv, const char *name)  
> 
> Since the users of init_dummy_netdev embed &net_device into their
> private structures, do we need sizeof_priv here at all? Or maybe we
> could unconditionally pass 0?

FWIW similar thing could be said about @name, if we never intend to
register the device - it will never have a legitimate (user visible)
name. So we may be better off naming them "dummy#" or some such.
No strong preference, tho. Adding params back later may be a bit
of a pain.

> > +{
> > +	return alloc_netdev(sizeof_priv, name, NET_NAME_UNKNOWN,
> > +			    init_dummy_netdev_core);
> > +}
> > +EXPORT_SYMBOL_GPL(alloc_netdev_dummy);
> > +
> >  /**
> >   *	synchronize_net -  Synchronize with packet receive processing
> >   *  
> 
> As Jakub mentioned, you need to introduce consumers of the functionality
> you add within the same series. Personally, I'd like to see a series
> with agressive conversion of all the affected drivers from
> init_dummy_netdev() to alloc_dummy_netdev() and final removal of
> init_dummy_netdev() :D

We can, and put it on a shared branch so other trees can also pull in
the conversions. No preference on my side, tho. I think that Breno
doesn't have any of the HW in question, so starting with one and making
sure it works could be more "work conserving", than redoing all
patches..

