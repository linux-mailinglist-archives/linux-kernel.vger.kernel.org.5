Return-Path: <linux-kernel+bounces-42625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DAD8403FD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEE5B1F2148D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4E55C8E9;
	Mon, 29 Jan 2024 11:42:26 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9A15FB89;
	Mon, 29 Jan 2024 11:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706528545; cv=none; b=nSBoauFCHyIl+ZlD6qqx66T/KlZz3amt31uv3hAkpi0ycak3laZssmspYXiXvJVtviQQmuxjP00VHZt0Z4Z53u28fTtnxX+bdwqGfy+Xxyl9Hodz0lMFCAIbrv350IBlKlIviUns/X12jwX7swB2U5RxiF2P651WCBq1zv0/0qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706528545; c=relaxed/simple;
	bh=wi/L5u6UksBicgM0z20X3NazESWce9mpAytR7nH+eS0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oTJGUH76ir7JsgRgJvkHd3Kmxz0EO8/SR3/EFyUfNOO+uwnTIcdYiMEfDCxpXWKNXTJ9aFCgKhagUUYyGtLSGtWbjl+xr8m9bUEMSv3Dr+9Ev9IkBdCKgZ15TTVa9LVkM3cNi8fg0/xen/LscUkhx6l6QSW8nV8M6Yio1VFXto0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TNmXp0fSyz6JB7G;
	Mon, 29 Jan 2024 19:39:06 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 063AE1400CD;
	Mon, 29 Jan 2024 19:42:20 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Jan
 2024 11:42:19 +0000
Date: Mon, 29 Jan 2024 11:42:18 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Julia Lawall <julia.lawall@inria.fr>
CC: Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>, "Rob
 Herring" <robh@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
	<linux-kernel@vger.kernel.org>, Nicolas Palix <nicolas.palix@imag.fr>,
	"Sumera Priyadarsini" <sylphrenadin@gmail.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	<linux-acpi@vger.kernel.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Subject: Re: [RFC PATCH 0/5] of: automate of_node_put() - new approach to
 loops.
Message-ID: <20240129114218.00003c34@Huawei.com>
In-Reply-To: <alpine.DEB.2.22.394.2401281903550.3119@hadrien>
References: <20240128160542.178315-1-jic23@kernel.org>
	<alpine.DEB.2.22.394.2401281903550.3119@hadrien>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Sun, 28 Jan 2024 19:06:53 +0100 (CET)
Julia Lawall <julia.lawall@inria.fr> wrote:

> On Sun, 28 Jan 2024, Jonathan Cameron wrote:
> 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > +CC includes peopleinterested in property.h equivalents to minimize
> > duplication of discussion.  Outcome of this discussion will affect:
> > https://lore.kernel.org/all/20240114172009.179893-1-jic23@kernel.org/
> > [PATCH 00/13] device property / IIO: Use cleanup.h magic for fwnode_handle_put() handling.
> >
> > In discussion of previous approach with Rob Herring we talked about various
> > ways to avoid a disconnect between the declaration of the __free(device_node)
> > and the first non NULL assignment. Making this connection clear is useful for 2
> > reasons:
> > 1) Avoids out of order cleanup with respect to other cleanup.h usage.
> > 2) Avoids disconnect between how cleanup is to be done and how the reference
> >    was acquired in the first place.
> >
> > https://lore.kernel.org/all/20240117194743.GA2888190-robh@kernel.org/
> >
> > The options we discussed are:
> >
> > 1) Ignore this issue and merge original set.
> >
> > 2) Always put the declaration just before the for loop and don't set it NULL.
> >
> > {
> > 	int ret;
> >
> > 	ret = ... and other fun code.
> >
> > 	struct device_node *child __free(device_node);
> > 	for_each_child_of_node(np, child) {
> > 	}
> > }
> >
> > This works but careful review is needed to ensure that this unusual pattern is
> > followed.  We don't set it to NULL as the loop will do that anyway if there are
> > no child nodes, or the loop finishes without an early break or return.
> >
> > 3) Introduced the pointer to auto put device_node only within the
> >    for loop scope.
> >
> > +#define for_each_child_of_node_scoped(parent, child) \
> > +	for (struct device_node *child __free(device_node) =		\
> > +	     of_get_next_child(parent, NULL);				\
> > +	     child != NULL;						\
> > +	     child = of_get_next_available_child(parent, child))
> > +
> >
> > This series is presenting option 3.  I only implemented this loop out of
> > all the similar ones and it is only compile tested.
> >
> > Disadvantage Rob raised is that it isn't obvious this macro will instantiate
> > a struct device_node *child.  I can't see a way around that other than option 2
> > above, but all suggestions welcome.  Note that if a conversion leaves an
> > 'external' struct device_node *child variable, in many cases the compiler
> > will catch that as an unused variable. We don't currently run shaddow
> > variable detection in normal kernel builds, but that could also be used
> > to catch such bugs.
> >
> > All comments welcome.  
> 
> It looks promising to get rid of a lot of clunky and error-prone
> error-handling code.

Absolutely. I think I spotted 2 bugs whilst just looking for places this pattern
doesn't apply.  Will circle back to those once this discussion is resolved.
I think I've taken dozen's of fixes for cases where these were missed over the years
so hoping this means I'll never see another one!

> 
> I guess that
> 
> for_each_child_of_node_scoped(parent, struct device_node *, child)
> 
> would seem too verbose?

Intent just to make the allocated internal type clear?  Sure we can do that if
it helps with making it clear something is being allocated.
I can't think of a way this could be used with anything other than
a struct device_node * as the second parameter but I guess it still helps
'hint' at what is going on..

> 
> There are a lot of opportunities for device_node loops, but also for some
> more obscure loops over other types.  

> And there are a lot of of_node_puts
> that could be eliminated independent of loops.

The non loop cases should be handled via the __free(device_node) as provided
by patch 1.  We'll need to keep the declaration local and initial assignment
together but that is easy enough to do and similar to the many other cleanup.h
usecases that are surfacing.

Jonathan

> 
> julia
> 
> >
> > Jonathan Cameron (5):
> >   of: Add cleanup.h based auto release via __free(device_node) markings.
> >   of: Introduce for_each_child_of_node_scoped() to automate
> >     of_node_put() handling
> >   of: unittest: Use __free(device_node)
> >   iio: adc: fsl-imx25-gcq: Use for_each_child_node_scoped()
> >   iio: adc: rcar-gyroadc: use for_each_child_node_scoped()
> >
> >  drivers/iio/adc/fsl-imx25-gcq.c | 13 +++----------
> >  drivers/iio/adc/rcar-gyroadc.c  | 21 ++++++---------------
> >  drivers/of/unittest.c           | 11 +++--------
> >  include/linux/of.h              |  8 ++++++++
> >  4 files changed, 20 insertions(+), 33 deletions(-)
> >
> > --
> > 2.43.0
> >
> >  


