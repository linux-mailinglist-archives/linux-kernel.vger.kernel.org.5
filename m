Return-Path: <linux-kernel+bounces-43430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D938413C5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAFC81C232C3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A07C7602A;
	Mon, 29 Jan 2024 19:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KRpE21nF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0366F07F;
	Mon, 29 Jan 2024 19:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706557961; cv=none; b=Z/W74ItypzJmj1I8Zm8Q+ig8Nxf8aRFLlJObgz78qKXVJJtaVM2cUKYs9OZjJf5U0pAFPdDGy/Nunoz+kV76A5JjgijqTpvk1Fi/Do82h6QI8TWcKeVLXJkTxBHVIY357EC6XnVS1hUpU9lbJjL2G9S9Qock7lxUsmClOjFlY6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706557961; c=relaxed/simple;
	bh=sHc0fmgS2jXh98pYRazZPVZPqNnFkF0YYo3nUqXRrNY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dfu0un4qT73+B/1XRL5o2v2m6bV0fhsPxguEoV/6uoEqhlvUoQ2KMhWQSeizTFJ7vv6tb5wlDJKXZ1MtUA8K5//Q15LjssEsb77IVat4UQiVgBxUmraUAJM/67Q7HHaAl9l8Gf0Gw2NbVh6wKyP3e34+HX+5bO+wGscpCEdzR7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KRpE21nF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A87B6C433F1;
	Mon, 29 Jan 2024 19:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706557960;
	bh=sHc0fmgS2jXh98pYRazZPVZPqNnFkF0YYo3nUqXRrNY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KRpE21nFawx2gBcry94NPa8aUSsaRT9nqRTIKg+/gZvJtL16A9Nfy3O74ANgqaYaO
	 ox98JUR9z/aPLDTMpdBjDmhbpyL7W81u0dMb7GGvQq8PFQ1RgP+khxWd2Sx4+nHYMB
	 /ui6YW044dVvM7No36ftDT/hDc9/QF42PgvUd+/OKgEiPPKd3sjDnmVGNgUc8OZeyc
	 2ON8ECRKkLuZWT50VmJKCrnOLmJ7hbTYzotgZmCJVrHm1x0gqfyfoMc1rzwX2/BCww
	 AESkyT8tFW70m1RJt2+jfhX3y/cZvOaOrU6mbxzMxyLysCuVMTRHl3CZSBADMhFDzh
	 wtqzAvBHIfDKQ==
Date: Mon, 29 Jan 2024 19:52:27 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 linux-iio@vger.kernel.org, Rob Herring <robh@kernel.org>, Frank Rowand
 <frowand.list@gmail.com>, linux-kernel@vger.kernel.org, Nicolas Palix
 <nicolas.palix@imag.fr>, Sumera Priyadarsini <sylphrenadin@gmail.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 linux-acpi@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: Re: [RFC PATCH 0/5] of: automate of_node_put() - new approach to
 loops.
Message-ID: <20240129195227.3c3adae1@jic23-huawei>
In-Reply-To: <alpine.DEB.2.22.394.2401291455430.8649@hadrien>
References: <20240128160542.178315-1-jic23@kernel.org>
	<alpine.DEB.2.22.394.2401281903550.3119@hadrien>
	<20240129114218.00003c34@Huawei.com>
	<alpine.DEB.2.22.394.2401291455430.8649@hadrien>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jan 2024 15:02:19 +0100 (CET)
Julia Lawall <julia.lawall@inria.fr> wrote:

> On Mon, 29 Jan 2024, Jonathan Cameron wrote:
> 
> > On Sun, 28 Jan 2024 19:06:53 +0100 (CET)
> > Julia Lawall <julia.lawall@inria.fr> wrote:
> >  
> > > On Sun, 28 Jan 2024, Jonathan Cameron wrote:
> > >  
> > > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > >
> > > > +CC includes peopleinterested in property.h equivalents to minimize
> > > > duplication of discussion.  Outcome of this discussion will affect:
> > > > https://lore.kernel.org/all/20240114172009.179893-1-jic23@kernel.org/
> > > > [PATCH 00/13] device property / IIO: Use cleanup.h magic for fwnode_handle_put() handling.
> > > >
> > > > In discussion of previous approach with Rob Herring we talked about various
> > > > ways to avoid a disconnect between the declaration of the __free(device_node)
> > > > and the first non NULL assignment. Making this connection clear is useful for 2
> > > > reasons:
> > > > 1) Avoids out of order cleanup with respect to other cleanup.h usage.
> > > > 2) Avoids disconnect between how cleanup is to be done and how the reference
> > > >    was acquired in the first place.
> > > >
> > > > https://lore.kernel.org/all/20240117194743.GA2888190-robh@kernel.org/
> > > >
> > > > The options we discussed are:
> > > >
> > > > 1) Ignore this issue and merge original set.
> > > >
> > > > 2) Always put the declaration just before the for loop and don't set it NULL.
> > > >
> > > > {
> > > > 	int ret;
> > > >
> > > > 	ret = ... and other fun code.
> > > >
> > > > 	struct device_node *child __free(device_node);
> > > > 	for_each_child_of_node(np, child) {
> > > > 	}
> > > > }
> > > >
> > > > This works but careful review is needed to ensure that this unusual pattern is
> > > > followed.  We don't set it to NULL as the loop will do that anyway if there are
> > > > no child nodes, or the loop finishes without an early break or return.
> > > >
> > > > 3) Introduced the pointer to auto put device_node only within the
> > > >    for loop scope.
> > > >
> > > > +#define for_each_child_of_node_scoped(parent, child) \
> > > > +	for (struct device_node *child __free(device_node) =		\
> > > > +	     of_get_next_child(parent, NULL);				\
> > > > +	     child != NULL;						\
> > > > +	     child = of_get_next_available_child(parent, child))
> > > > +
> > > >
> > > > This series is presenting option 3.  I only implemented this loop out of
> > > > all the similar ones and it is only compile tested.
> > > >
> > > > Disadvantage Rob raised is that it isn't obvious this macro will instantiate
> > > > a struct device_node *child.  I can't see a way around that other than option 2
> > > > above, but all suggestions welcome.  Note that if a conversion leaves an
> > > > 'external' struct device_node *child variable, in many cases the compiler
> > > > will catch that as an unused variable. We don't currently run shaddow
> > > > variable detection in normal kernel builds, but that could also be used
> > > > to catch such bugs.
> > > >
> > > > All comments welcome.  
> > >
> > > It looks promising to get rid of a lot of clunky and error-prone
> > > error-handling code.  
> >
> > Absolutely. I think I spotted 2 bugs whilst just looking for places this pattern
> > doesn't apply.  Will circle back to those once this discussion is resolved.
> > I think I've taken dozen's of fixes for cases where these were missed over the years
> > so hoping this means I'll never see another one!
> >  
> > >
> > > I guess that
> > >
> > > for_each_child_of_node_scoped(parent, struct device_node *, child)
> > >
> > > would seem too verbose?  
> >
> > Intent just to make the allocated internal type clear?  Sure we can do that if
> > it helps with making it clear something is being allocated.
> > I can't think of a way this could be used with anything other than
> > a struct device_node * as the second parameter but I guess it still helps
> > 'hint' at what is going on..

To touch back on this, I'm still not sure what your intent was in suggesting
having the explicit struct device_node *

> >  
> > >
> > > There are a lot of opportunities for device_node loops, but also for some
> > > more obscure loops over other types.  
> >  
> > > And there are a lot of of_node_puts
> > > that could be eliminated independent of loops.  
> >
> > The non loop cases should be handled via the __free(device_node) as provided
> > by patch 1.  We'll need to keep the declaration local and initial assignment
> > together but that is easy enough to do and similar to the many other cleanup.h
> > usecases that are surfacing.  
> 
> I tried the following semantic patch:
> 
> @@
> identifier x,f;
> attribute name __free;
> expression list es;
> expression e;
> statement S;
> @@
> 
> {
> ... when != S
> struct device_node *x
> + __free(device_node)
> ;
> ... when strict
> x = f(es);
> <... when any
>      when != x = e
> -of_node_put(x);
> ...>  
> -of_node_put(x);
> }
> 
Nice.  
> It is written defensively in various ways:
> 
> when != S means tha tthe device_node declaration has t be at the top of
> the block, perhaps with other declarations before it.
> 
> when strict means that all paths must lead from the declaration to the
> initialization.  So there is no need to intiialize the variable to NULL,
> as far as I understand.
> 
> when != x = e means that the declared variable is not reinitialized, which
> would require keeping the previous of_node_put.
> 
> There is an of_node_put at the end of the block, so the use of __free
> doesn't change the lifetime.
> 
> An unfortunate aspect of the last constraint is that some functions may
> declare multiple device_node variables, and only one of the of_not_puts
> can come at the very end of the block.  This can be solved by just running
> the semantic patch again.
> 
> An alternative would be to move the initialization up to the declaration,
> but the result was often a bit ugly, due to the various initialization
> function calls having long names and argument lists.

You have to do that in order to ensure there is no window for someone to
easily insert code that leaves them uninitialized.

Linus had some rather specific comments on that being the only right way to
do it.

> 
> The output is below.  I have looked quickly through all of the changes and
> they all look reasonable, but have not tried compiling anything (which I
> guess wouldn't currently work anyway).
> 
> julia
> 

I picked a couple from the end.  They show the sort of things that
would want cleaning up.  The script is great for finding low hanging
fruit but as you've identified there is often some stuff that isn't
easy to automate.

> diff -u -p a/drivers/clk/clk-nomadik.c b/drivers/clk/clk-nomadik.c
> --- a/drivers/clk/clk-nomadik.c
> +++ b/drivers/clk/clk-nomadik.c
> @@ -87,7 +87,7 @@ static const struct of_device_id nomadik
> 
>  static void __init nomadik_src_init(void)
>  {
> -	struct device_node *np;
> +	struct device_node *np __free(device_node);
>  	u32 val;
> 
>  	np = of_find_matching_node(NULL, nomadik_src_match);
> @@ -134,7 +134,6 @@ static void __init nomadik_src_init(void
>  	register_reboot_notifier(&nomadik_clk_reboot_notifier);
> 
>  out_put:
Can avoid the label given nothing to do any more. 
> -	of_node_put(np);
>  }
> 
>  /**
> diff -u -p a/arch/powerpc/platforms/chrp/setup.c b/arch/powerpc/platforms/chrp/setup.c
> --- a/arch/powerpc/platforms/chrp/setup.c
> +++ b/arch/powerpc/platforms/chrp/setup.c
> @@ -99,7 +99,7 @@ static void chrp_show_cpuinfo(struct seq
>  {
>  	int i, sdramen;
>  	unsigned int t;
> -	struct device_node *root;
> +	struct device_node *root __free(device_node);

Same as next 2.

>  	const char *model = "";
> 
>  	root = of_find_node_by_path("/");
> @@ -152,7 +152,6 @@ static void chrp_show_cpuinfo(struct seq
>  			   gg2_cachetypes[(t>>2) & 3],  
>  			   gg2_cachemodes[t & 3]);
>  	}
> -	of_node_put(root);
>  }
> 
>  /*
> @@ -195,7 +194,7 @@ static void __init sio_fixup_irq(const c
> 
>  static void __init sio_init(void)
>  {
> -	struct device_node *root;
> +	struct device_node *root __free(device_node);

As below needs to be 
	struct device_node *root __free(device_node) = of_find_node_by_path("/");
so there is no space for code to be added inbetween that might return before
this is set.

>  	const char *model;
> 
>  	root = of_find_node_by_path("/");
> @@ -209,8 +208,6 @@ static void __init sio_init(void)
>  		/* select logical device 1 (KBC/Mouse) */
>  		sio_fixup_irq("mouse", 1, 12, 2);
>  	}
> -
> -	of_node_put(root);
>  }
> 
> 
> @@ -364,7 +361,7 @@ static void chrp_8259_cascade(struct irq
>   */
>  static void __init chrp_find_openpic(void)
>  {
> -	struct device_node *np, *root;
> +	struct device_node *np __free(device_node), *root;

This one looks dangerous because of the chance of other code
getting added between here and the point where it is set.

Better to move that down so we have

struct device_node *np __free(device_node) = of_find_node_by_type(NULL, "open-pic");

Also there is a nicer use in:
https://elixir.bootlin.com/linux/v6.8-rc2/source/arch/powerpc/platforms/chrp/setup.c#L217

>  	int len, i, j;
>  	int isu_size;
>  	const unsigned int *iranges, *opprop = NULL;
> @@ -438,7 +435,6 @@ static void __init chrp_find_openpic(voi
>  	ppc_md.get_irq = mpic_get_irq;
>   bail:
>  	of_node_put(root);
With root covered this can return early.

> -	of_node_put(np);
>  }
> 


