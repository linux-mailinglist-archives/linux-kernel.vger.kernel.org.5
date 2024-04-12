Return-Path: <linux-kernel+bounces-141977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2ED8A25B0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39045286118
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5DC1798C;
	Fri, 12 Apr 2024 05:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RAznAcCa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7311BC20;
	Fri, 12 Apr 2024 05:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712899383; cv=none; b=KNZWAPWevF9tv64XuAvrnWXnk6LyS3ib1hNTmyIFoAmRHViOjHBtGUpvb0HxTb7z59ETXXc82CcEjsWoZ7EX2s2e1UDGnqr5/FpT6IT0om35xm8wU3b8bWeNWyLqJpdZHovGrIFx6E50yYLsd4RVFyogD42/4bBDoWZrbOwaKrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712899383; c=relaxed/simple;
	bh=Be1HIkMk4Xq+RofQvGmPKjjQ46/GPbpbgN3h/Gu/xYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rqvLnmasUaE4nFZlG4Ax5vNQm9Yf5RusvAUoFsyB3+chBoSW36BXVDq9Pfn+1HfHxW/aJ0d5+mU0PflnJCMitXPlaPVnL/7+ZQx880aSNrjwhx7cuXfy9Qbj50BwmurH5mtpac08GuAFfA0ESg5e5zI9C4w1/9jwiQLiepVTPm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RAznAcCa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33FE1C2BBFC;
	Fri, 12 Apr 2024 05:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712899382;
	bh=Be1HIkMk4Xq+RofQvGmPKjjQ46/GPbpbgN3h/Gu/xYE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RAznAcCa4v1zg+MWzZPzsKyWCIAMFob1sqkC/qAYvAT4bbAdeaK7Z5adZuvxx2zQe
	 mVuwk+5aFsqnHO0utprwDvV0HPWWhTcOUXLl/m5ZMuX4ScVgz8HVnhig60mB8I2D4o
	 Jw+D4uIXpWgHsz0r78lzv8B/xsqae2s9Ab8nlt0A=
Date: Fri, 12 Apr 2024 07:22:59 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Roman Storozhenko <romeusmeister@gmail.com>, jirislaby@kernel.org,
	skhan@linuxfoundation.org, javier.carrasco.cruz@gmail.com,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] sysrq: Auto release device node using __free attribute
Message-ID: <2024041211-statistic-reformist-bf70@gregkh>
References: <20240411180256.61001-1-romeusmeister@gmail.com>
 <2024041111-tummy-boil-a6aa@gregkh>
 <b6b33aa-faef-6919-7125-c2db11e784ee@inria.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6b33aa-faef-6919-7125-c2db11e784ee@inria.fr>

On Thu, Apr 11, 2024 at 08:17:07PM +0200, Julia Lawall wrote:
> 
> 
> On Thu, 11 Apr 2024, Greg KH wrote:
> 
> > On Thu, Apr 11, 2024 at 08:02:56PM +0200, Roman Storozhenko wrote:
> > > Add a cleanup function attribute '__free(device_node)' to the device node
> > > pointer initialization statement and remove the pairing cleanup function
> > > call of 'of_node_put' at the end of the function.
> > > The '_free()' attrubute is introduced by scope-based resource management
> > > in-kernel framework implemented in 'cleanup.h'. A pointer marked with
> > > '__free()' attribute makes a compiler insert a cleanup function call
> > > to the places where the pointer goes out of the scope. This feature
> > > allows to get rid of manual cleanup function calls.
> > >
> > > Suggested-by: Julia.Lawall <Julia.Lawall@inria.fr>
> > > Signed-off-by: Roman Storozhenko <romeusmeister@gmail.com>
> > > ---
> > > This patch targets the next tree:
> > > tree: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> > > tag: next-20240411
> > > ---
> > >  drivers/tty/sysrq.c | 7 +++----
> > >  1 file changed, 3 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
> > > index 02217e3c916b..1d1261f618c0 100644
> > > --- a/drivers/tty/sysrq.c
> > > +++ b/drivers/tty/sysrq.c
> > > @@ -758,11 +758,12 @@ static void sysrq_detect_reset_sequence(struct sysrq_state *state,
> > >  static void sysrq_of_get_keyreset_config(void)
> > >  {
> > >  	u32 key;
> > > -	struct device_node *np;
> > >  	struct property *prop;
> > >  	const __be32 *p;
> > >
> > > -	np = of_find_node_by_path("/chosen/linux,sysrq-reset-seq");
> > > +	struct device_node *np __free(device_node) =
> > > +		of_find_node_by_path("/chosen/linux,sysrq-reset-seq");
> > > +
> > >  	if (!np) {
> > >  		pr_debug("No sysrq node found");
> > >  		return;
> > > @@ -781,8 +782,6 @@ static void sysrq_of_get_keyreset_config(void)
> > >
> > >  	/* Get reset timeout if any. */
> > >  	of_property_read_u32(np, "timeout-ms", &sysrq_reset_downtime_ms);
> > > -
> > > -	of_node_put(np);
> > >  }
> > >  #else
> > >  static void sysrq_of_get_keyreset_config(void)
> >
> > Also, this change really makes no sense at all, the pointer never goes
> > out of scope except when the function is over, at the bottom.  So why
> > make this complex change at all for no benefit?
> >
> > In other words, properly understand the change you are making and only
> > make it if it actually makes sense.  It does not make any sense here,
> > right?
> 
> Maybe it would be nice to get rid of of_node_puts in the general case?

That's a call for the of maintainer to make, and then if so, to do it
across the whole tree, right?

> Even though this one is not very annoying, there are some other functions
> where there are many of_node_puts, and convoluted error handling code to
> incorporate them on both the success and failure path.  So maybe it would
> be better to avoid the situation of having them sometimes and not having
> them other times?  But this is an opinion, and if the general consensus is
> to only get rid of the cases that currently add complexity, then that is
> possible too.

Let's keep things simple until it has to be complex please.

thanks,

greg k-h

