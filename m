Return-Path: <linux-kernel+bounces-143851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 842908A3E34
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 21:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 970BC1C2084D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 19:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9D253E30;
	Sat, 13 Apr 2024 19:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="WM5DiaCD"
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2556D2901;
	Sat, 13 Apr 2024 19:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713035739; cv=none; b=L5KdZR+6eFdX8x6m8bqPcknUY9k2/46gXCx1bcbBbavlACzbVbpfSi3Z/ej5wwS+d1E/r6wM4X2q6GqBRe7/z+UCOkZMxBrxFXMcvXfa8ljD3YcQVS3GnzHhbzwgsqWPoZH+gQcnJIFlYjdjxM/pfb/dKKPRccbe0TwPBIrylmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713035739; c=relaxed/simple;
	bh=4cGjbS7oZv3MqXnUHAus2v7DZuTRY4ghBpQ6dnNDpM8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BS6+L7DEH6i0gqjzjpk6OyrHWzJpawxv82e1t7Hl/pTFa6o/CYxORDbUHg8NI5G+4oocM3UCmAplMFXMr0FLBACYRrZT6xGG1KbPX7uf+QmiHI7aBFLgj5B0PIkX/pRUOmFLwSyVpib8f68wTQIGj74fChFh2imS773k9L5rQhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=WM5DiaCD; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=asONdpdArG+MOBmLcsAmo2WXpEy8zk0Cigt+bZtUvK0=;
  b=WM5DiaCDP5zKrAzdddx2gwE7da09vEs/ZhFfDa9ODud/54fsUFCHc+1B
   U18Xu+0URGYPS7lpuYwiiSxTvz2UKreKJiPM0w2n75urw2vOSy1HTDCPG
   SANAZK/M4JG5+mgXU+dPtUj+zVWtg93ivk3lTr+oOpsKbQZrgTbwBXrEL
   s=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.07,199,1708383600"; 
   d="scan'208";a="84712531"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2024 21:15:26 +0200
Date: Sat, 13 Apr 2024 21:15:25 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Greg KH <gregkh@linuxfoundation.org>
cc: Julia Lawall <julia.lawall@inria.fr>, Rob Herring <robh@kernel.org>, 
    Roman Storozhenko <romeusmeister@gmail.com>, jirislaby@kernel.org, 
    skhan@linuxfoundation.org, javier.carrasco.cruz@gmail.com, 
    linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] sysrq: Auto release device node using __free attribute
In-Reply-To: <2024041211-statistic-reformist-bf70@gregkh>
Message-ID: <alpine.DEB.2.22.394.2404132106281.3446@hadrien>
References: <20240411180256.61001-1-romeusmeister@gmail.com> <2024041111-tummy-boil-a6aa@gregkh> <b6b33aa-faef-6919-7125-c2db11e784ee@inria.fr> <2024041211-statistic-reformist-bf70@gregkh>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Fri, 12 Apr 2024, Greg KH wrote:

> On Thu, Apr 11, 2024 at 08:17:07PM +0200, Julia Lawall wrote:
> >
> >
> > On Thu, 11 Apr 2024, Greg KH wrote:
> >
> > > On Thu, Apr 11, 2024 at 08:02:56PM +0200, Roman Storozhenko wrote:
> > > > Add a cleanup function attribute '__free(device_node)' to the device node
> > > > pointer initialization statement and remove the pairing cleanup function
> > > > call of 'of_node_put' at the end of the function.
> > > > The '_free()' attrubute is introduced by scope-based resource management
> > > > in-kernel framework implemented in 'cleanup.h'. A pointer marked with
> > > > '__free()' attribute makes a compiler insert a cleanup function call
> > > > to the places where the pointer goes out of the scope. This feature
> > > > allows to get rid of manual cleanup function calls.
> > > >
> > > > Suggested-by: Julia.Lawall <Julia.Lawall@inria.fr>
> > > > Signed-off-by: Roman Storozhenko <romeusmeister@gmail.com>
> > > > ---
> > > > This patch targets the next tree:
> > > > tree: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> > > > tag: next-20240411
> > > > ---
> > > >  drivers/tty/sysrq.c | 7 +++----
> > > >  1 file changed, 3 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
> > > > index 02217e3c916b..1d1261f618c0 100644
> > > > --- a/drivers/tty/sysrq.c
> > > > +++ b/drivers/tty/sysrq.c
> > > > @@ -758,11 +758,12 @@ static void sysrq_detect_reset_sequence(struct sysrq_state *state,
> > > >  static void sysrq_of_get_keyreset_config(void)
> > > >  {
> > > >  	u32 key;
> > > > -	struct device_node *np;
> > > >  	struct property *prop;
> > > >  	const __be32 *p;
> > > >
> > > > -	np = of_find_node_by_path("/chosen/linux,sysrq-reset-seq");
> > > > +	struct device_node *np __free(device_node) =
> > > > +		of_find_node_by_path("/chosen/linux,sysrq-reset-seq");
> > > > +
> > > >  	if (!np) {
> > > >  		pr_debug("No sysrq node found");
> > > >  		return;
> > > > @@ -781,8 +782,6 @@ static void sysrq_of_get_keyreset_config(void)
> > > >
> > > >  	/* Get reset timeout if any. */
> > > >  	of_property_read_u32(np, "timeout-ms", &sysrq_reset_downtime_ms);
> > > > -
> > > > -	of_node_put(np);
> > > >  }
> > > >  #else
> > > >  static void sysrq_of_get_keyreset_config(void)
> > >
> > > Also, this change really makes no sense at all, the pointer never goes
> > > out of scope except when the function is over, at the bottom.  So why
> > > make this complex change at all for no benefit?
> > >
> > > In other words, properly understand the change you are making and only
> > > make it if it actually makes sense.  It does not make any sense here,
> > > right?
> >
> > Maybe it would be nice to get rid of of_node_puts in the general case?
>
> That's a call for the of maintainer to make, and then if so, to do it
> across the whole tree, right?
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

Jonathan Cameron pointed me to the following series from Rob Herring:

https://lore.kernel.org/linux-devicetree/20240409-dt-cleanup-free-v2-0-5b419a4af38d@kernel.org/

The patch for of_node_put is:

https://lore.kernel.org/linux-devicetree/20240409-dt-cleanup-free-v2-3-5b419a4af38d@kernel.org/

It uses __free directy. The cases in the file drivers/of/property.c have
quite simple structure, with for each get just one put at the end of the
scope in most cases.

julia


>
> thanks,
>
> greg k-h
>

