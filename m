Return-Path: <linux-kernel+bounces-142029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E158A266E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C446BB24FD7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 06:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F84937144;
	Fri, 12 Apr 2024 06:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="lcjPlO4Q"
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E330E542;
	Fri, 12 Apr 2024 06:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712902966; cv=none; b=FfiJT/5Fy3/jYFIhKlLwc1v6G+4TWGxfxeXXkt1WJsMwkx+UGXpbSRgZIwYEghFOJwAXB/TajF97x173ia5iZMsxfSTGi92C18iTp1Wwd1dhyFW4TSBbib1WSKPN9aM2oWwf6o7OJjQauSmpp0oxOWCKgJX53hhCXuUT1ImSFU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712902966; c=relaxed/simple;
	bh=I9aBK5dbrhcLKKL/MjbcYuCu6MZvLINSTsHK4HqiwmY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=dNWXPnZ565Mawl3nX738qGtQFFXlG61od5gqDOU6CPYXNfKIpHbY+kRTETREBLfwG1SVCjELtZRfS/07JrkTR201EDOhk/Dy82QWgbmZFDb5rcC68srJP55xCjn0bJVQ1AwQ7MzpREZFhNijSBRPO2GfLRlpAGHTpS1J8/K68Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=lcjPlO4Q; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=I5FV9y1cxUtXTeIw4zxGn7mwJ5/NnPbk/Fu5KJrJVaQ=;
  b=lcjPlO4QuLiofl/z2VrHVX8/JVna8Xe2yfTHpz/M2jvRem9Gw/iW1JyT
   DoXDc45a4ozCnM5br6N3g/NSN4MVWmA22eo4zXtHI1OAziqtWpy5m9+yY
   r9ksScekmVXrDIFKg7Msv1blvJphv8bHCv681m6kli3BkLnW+IZ2xPZsg
   k=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.07,195,1708383600"; 
   d="scan'208";a="161185143"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 08:21:31 +0200
Date: Fri, 12 Apr 2024 08:21:30 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Greg KH <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, 
    Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org
cc: Roman Storozhenko <romeusmeister@gmail.com>, jirislaby@kernel.org, 
    skhan@linuxfoundation.org, javier.carrasco.cruz@gmail.com, 
    linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] sysrq: Auto release device node using __free attribute
In-Reply-To: <2024041211-statistic-reformist-bf70@gregkh>
Message-ID: <alpine.DEB.2.22.394.2404120807400.3229@hadrien>
References: <20240411180256.61001-1-romeusmeister@gmail.com> <2024041111-tummy-boil-a6aa@gregkh> <b6b33aa-faef-6919-7125-c2db11e784ee@inria.fr> <2024041211-statistic-reformist-bf70@gregkh>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

[Adding the OF maintainers and device tree mailing list]

> > Maybe it would be nice to get rid of of_node_puts in the general case?
>
> That's a call for the of maintainer to make, and then if so, to do it
> across the whole tree, right?

Sure.

Rob and Saravana, what do you think about the following:

* Is it ok to use __free(device_tree) directly in a declaration, or is
there some macro that should be used instead?

* If is ok to use __free(device_tree) even in simple cases where a
variable is just declared at the start of the scope and freed at the end,
and there is no internediate error handling code?

Please see for example:

https://lore.kernel.org/lkml/alpine.DEB.2.22.394.2401291455430.8649@hadrien/

But I don't think we can do the whole thing at once, in one patch.  There
are a lot of things that need to be checked, and it don't break anything
to do them one at a time.

>
> > Even though this one is not very annoying, there are some other functions
> > where there are many of_node_puts, and convoluted error handling code to
> > incorporate them on both the success and failure path.  So maybe it would
> > be better to avoid the situation of having them sometimes and not having
> > them other times?  But this is an opinion, and if the general consensus is
> > to only get rid of the cases that currently add complexity, then that is
> > possible too.
>
> Let's keep things simple until it has to be complex please.

I meant that the current code is complex and error prone, and using __free
eliminates code that is ugly and has led to memory leaks in the past (and
a lot of effort to find and fix them in the past).  Even if some instances
don't have that property, they may become more complex in the future, if
some error condition is detected.

julia

