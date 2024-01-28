Return-Path: <linux-kernel+bounces-41872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B494783F90A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 19:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69F941F229AB
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 18:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2083F2E84D;
	Sun, 28 Jan 2024 18:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="AYCFLT/I"
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663523C68E;
	Sun, 28 Jan 2024 18:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706465226; cv=none; b=EIR0FlTTo2NXXkFAro1szq1Ob/oeyyhIPZ51h8nM03EGMU5kVHV80YBpJe1hro1WFHzJ+UM0CAVxk0sjie7c3R03Y/PFGkAXV1OuTnmbg6XvZ1OKeaGVW6u5P+1dS4a8FfjzHPtz9FF08O1z1haaNWJJ2fPAltHSY8kNLDoo1r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706465226; c=relaxed/simple;
	bh=RE/lIIXw1HUFiTUbURfk40Dz/JKqy6Y13D3dwiStEFs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fRWv0kcIbEC2cpUyX2RS7LAsPHejLPM+/2lSSYz92DYAXOWujjlAqD5uhSD69SuEejkBvTz2m/xIkZc/B0CZqFVpzwo+XNQPzrr9qUsemcrcPbXH7dlOFuZSvChIIB8a7AZq7YvwzZfp/k7yGbXviy0QdJmwETtDF21M/yyu4FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=AYCFLT/I; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=T8Fb/8aad+T46cz/f1A2BiH6WpbnashX2LTB/R/1lbQ=;
  b=AYCFLT/IA0sLODwl7exVF9hcAqXLFNXTCadBo9hp7raSLLCJ8cmsh5M2
   ALdFlljuZbaHCs2MK7Xl9pnpp/2fkhqfzSob97pjYPXXcLs79N4M6ASJR
   t9ntiTdid8Cu66ApA2/98Llz91LwV/ny62i0uL+OPfd+K58pqbWrymqc/
   8=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.05,220,1701126000"; 
   d="scan'208";a="78039727"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 19:06:54 +0100
Date: Sun, 28 Jan 2024 19:06:53 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Jonathan Cameron <jic23@kernel.org>
cc: linux-iio@vger.kernel.org, Rob Herring <robh@kernel.org>, 
    Frank Rowand <frowand.list@gmail.com>, linux-kernel@vger.kernel.org, 
    Julia Lawall <Julia.Lawall@inria.fr>, 
    Nicolas Palix <nicolas.palix@imag.fr>, 
    Sumera Priyadarsini <sylphrenadin@gmail.com>, 
    "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
    linux-acpi@vger.kernel.org, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    =?ISO-8859-15?Q?Nuno_S=E1?= <nuno.sa@analog.com>, 
    Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [RFC PATCH 0/5] of: automate of_node_put() - new approach to
 loops.
In-Reply-To: <20240128160542.178315-1-jic23@kernel.org>
Message-ID: <alpine.DEB.2.22.394.2401281903550.3119@hadrien>
References: <20240128160542.178315-1-jic23@kernel.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Sun, 28 Jan 2024, Jonathan Cameron wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> +CC includes peopleinterested in property.h equivalents to minimize
> duplication of discussion.  Outcome of this discussion will affect:
> https://lore.kernel.org/all/20240114172009.179893-1-jic23@kernel.org/
> [PATCH 00/13] device property / IIO: Use cleanup.h magic for fwnode_handle_put() handling.
>
> In discussion of previous approach with Rob Herring we talked about various
> ways to avoid a disconnect between the declaration of the __free(device_node)
> and the first non NULL assignment. Making this connection clear is useful for 2
> reasons:
> 1) Avoids out of order cleanup with respect to other cleanup.h usage.
> 2) Avoids disconnect between how cleanup is to be done and how the reference
>    was acquired in the first place.
>
> https://lore.kernel.org/all/20240117194743.GA2888190-robh@kernel.org/
>
> The options we discussed are:
>
> 1) Ignore this issue and merge original set.
>
> 2) Always put the declaration just before the for loop and don't set it NULL.
>
> {
> 	int ret;
>
> 	ret = ... and other fun code.
>
> 	struct device_node *child __free(device_node);
> 	for_each_child_of_node(np, child) {
> 	}
> }
>
> This works but careful review is needed to ensure that this unusual pattern is
> followed.  We don't set it to NULL as the loop will do that anyway if there are
> no child nodes, or the loop finishes without an early break or return.
>
> 3) Introduced the pointer to auto put device_node only within the
>    for loop scope.
>
> +#define for_each_child_of_node_scoped(parent, child) \
> +	for (struct device_node *child __free(device_node) =		\
> +	     of_get_next_child(parent, NULL);				\
> +	     child != NULL;						\
> +	     child = of_get_next_available_child(parent, child))
> +
>
> This series is presenting option 3.  I only implemented this loop out of
> all the similar ones and it is only compile tested.
>
> Disadvantage Rob raised is that it isn't obvious this macro will instantiate
> a struct device_node *child.  I can't see a way around that other than option 2
> above, but all suggestions welcome.  Note that if a conversion leaves an
> 'external' struct device_node *child variable, in many cases the compiler
> will catch that as an unused variable. We don't currently run shaddow
> variable detection in normal kernel builds, but that could also be used
> to catch such bugs.
>
> All comments welcome.

It looks promising to get rid of a lot of clunky and error-prone
error-handling code.

I guess that

for_each_child_of_node_scoped(parent, struct device_node *, child)

would seem too verbose?

There are a lot of opportunities for device_node loops, but also for some
more obscure loops over other types.  And there are a lot of of_node_puts
that could be eliminated independent of loops.

julia

>
> Jonathan Cameron (5):
>   of: Add cleanup.h based auto release via __free(device_node) markings.
>   of: Introduce for_each_child_of_node_scoped() to automate
>     of_node_put() handling
>   of: unittest: Use __free(device_node)
>   iio: adc: fsl-imx25-gcq: Use for_each_child_node_scoped()
>   iio: adc: rcar-gyroadc: use for_each_child_node_scoped()
>
>  drivers/iio/adc/fsl-imx25-gcq.c | 13 +++----------
>  drivers/iio/adc/rcar-gyroadc.c  | 21 ++++++---------------
>  drivers/of/unittest.c           | 11 +++--------
>  include/linux/of.h              |  8 ++++++++
>  4 files changed, 20 insertions(+), 33 deletions(-)
>
> --
> 2.43.0
>
>

