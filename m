Return-Path: <linux-kernel+bounces-44276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CCF841FD2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 978DB2919F1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C784F60876;
	Tue, 30 Jan 2024 09:39:03 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934BD605B4;
	Tue, 30 Jan 2024 09:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706607542; cv=none; b=ZzhFk77kHSJ+pW8QFjJQf96HofyfF1VlkBtAj9lGncdYudk8Tnsz2MoQ3KY3hzxe8GSvTCtJhVNT/KAC/DDjb2h7ZU47kzil8K6/OR/5wrtCUPGPcBy84y7yUJI6qYHIRPZoDdcn+rau2CEWY1xVApmNOn4iJSB+8PbhK0fjWqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706607542; c=relaxed/simple;
	bh=6ilFA+aKGdYkOdvN6GF3yMXCTBrOnuRc22DGAYutMJo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M7c9lesCij3XOm6K1mbOgW6DaGdMBbDty4wjTbZiWY0KGqQ6NaM/4AaUXpgLy4BuvP/v3lBuK+PRAk1YyMsy1CRD9ahinOH9aslOf7UmEgYzhTQZV7A+oeRkRT4MRr9BmlxySUyxUysNtgUGBTDqEOm/ke1C6+kBUkDU5bA/lWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TPKlv6Cx1z6HJXr;
	Tue, 30 Jan 2024 17:35:39 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 63C091400D7;
	Tue, 30 Jan 2024 17:38:56 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 30 Jan
 2024 09:38:55 +0000
Date: Tue, 30 Jan 2024 09:38:54 +0000
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
Message-ID: <20240130093854.00000acc@Huawei.com>
In-Reply-To: <alpine.DEB.2.22.394.2401292120260.32795@hadrien>
References: <20240128160542.178315-1-jic23@kernel.org>
	<alpine.DEB.2.22.394.2401281903550.3119@hadrien>
	<20240129114218.00003c34@Huawei.com>
	<alpine.DEB.2.22.394.2401291455430.8649@hadrien>
	<20240129195227.3c3adae1@jic23-huawei>
	<alpine.DEB.2.22.394.2401292120260.32795@hadrien>
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
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 29 Jan 2024 21:29:13 +0100 (CET)
Julia Lawall <julia.lawall@inria.fr> wrote:

> On Mon, 29 Jan 2024, Jonathan Cameron wrote:
> 
> > On Mon, 29 Jan 2024 15:02:19 +0100 (CET)
> > Julia Lawall <julia.lawall@inria.fr> wrote:
> >  
> > > On Mon, 29 Jan 2024, Jonathan Cameron wrote:
> > >  
> > > > On Sun, 28 Jan 2024 19:06:53 +0100 (CET)
> > > > Julia Lawall <julia.lawall@inria.fr> wrote:
> > > >  
> > > > > On Sun, 28 Jan 2024, Jonathan Cameron wrote:
> > > > >  
> > > > > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > > >
> > > > > > +CC includes peopleinterested in property.h equivalents to minimize
> > > > > > duplication of discussion.  Outcome of this discussion will affect:
> > > > > > https://lore.kernel.org/all/20240114172009.179893-1-jic23@kernel.org/
> > > > > > [PATCH 00/13] device property / IIO: Use cleanup.h magic for fwnode_handle_put() handling.
> > > > > >
> > > > > > In discussion of previous approach with Rob Herring we talked about various
> > > > > > ways to avoid a disconnect between the declaration of the __free(device_node)
> > > > > > and the first non NULL assignment. Making this connection clear is useful for 2
> > > > > > reasons:
> > > > > > 1) Avoids out of order cleanup with respect to other cleanup.h usage.
> > > > > > 2) Avoids disconnect between how cleanup is to be done and how the reference
> > > > > >    was acquired in the first place.
> > > > > >
> > > > > > https://lore.kernel.org/all/20240117194743.GA2888190-robh@kernel.org/
> > > > > >
> > > > > > The options we discussed are:
> > > > > >
> > > > > > 1) Ignore this issue and merge original set.
> > > > > >
> > > > > > 2) Always put the declaration just before the for loop and don't set it NULL.
> > > > > >
> > > > > > {
> > > > > > 	int ret;
> > > > > >
> > > > > > 	ret = ... and other fun code.
> > > > > >
> > > > > > 	struct device_node *child __free(device_node);
> > > > > > 	for_each_child_of_node(np, child) {
> > > > > > 	}
> > > > > > }
> > > > > >
> > > > > > This works but careful review is needed to ensure that this unusual pattern is
> > > > > > followed.  We don't set it to NULL as the loop will do that anyway if there are
> > > > > > no child nodes, or the loop finishes without an early break or return.
> > > > > >
> > > > > > 3) Introduced the pointer to auto put device_node only within the
> > > > > >    for loop scope.
> > > > > >
> > > > > > +#define for_each_child_of_node_scoped(parent, child) \
> > > > > > +	for (struct device_node *child __free(device_node) =		\
> > > > > > +	     of_get_next_child(parent, NULL);				\
> > > > > > +	     child != NULL;						\
> > > > > > +	     child = of_get_next_available_child(parent, child))
> > > > > > +
> > > > > >
> > > > > > This series is presenting option 3.  I only implemented this loop out of
> > > > > > all the similar ones and it is only compile tested.
> > > > > >
> > > > > > Disadvantage Rob raised is that it isn't obvious this macro will instantiate
> > > > > > a struct device_node *child.  I can't see a way around that other than option 2
> > > > > > above, but all suggestions welcome.  Note that if a conversion leaves an
> > > > > > 'external' struct device_node *child variable, in many cases the compiler
> > > > > > will catch that as an unused variable. We don't currently run shaddow
> > > > > > variable detection in normal kernel builds, but that could also be used
> > > > > > to catch such bugs.
> > > > > >
> > > > > > All comments welcome.  
> > > > >
> > > > > It looks promising to get rid of a lot of clunky and error-prone
> > > > > error-handling code.  
> > > >
> > > > Absolutely. I think I spotted 2 bugs whilst just looking for places this pattern
> > > > doesn't apply.  Will circle back to those once this discussion is resolved.
> > > > I think I've taken dozen's of fixes for cases where these were missed over the years
> > > > so hoping this means I'll never see another one!
> > > >  
> > > > >
> > > > > I guess that
> > > > >
> > > > > for_each_child_of_node_scoped(parent, struct device_node *, child)
> > > > >
> > > > > would seem too verbose?  
> > > >
> > > > Intent just to make the allocated internal type clear?  Sure we can do that if
> > > > it helps with making it clear something is being allocated.
> > > > I can't think of a way this could be used with anything other than
> > > > a struct device_node * as the second parameter but I guess it still helps
> > > > 'hint' at what is going on..  
> >
> > To touch back on this, I'm still not sure what your intent was in suggesting
> > having the explicit struct device_node *  
> 
> Well, I wanted struct device_node * child, but then there wouldn't be the
> macro argument that would give the variable name.  So perhaps even with
> the comma it would look a little more like a declaration.
> 
> It does seem problematic to have eg two freestanding occurrences of child
> that are not in the same scope, if there is a child in the iterator
> argument list and a use elsewhere in the function.
Hi Julia,


Would be nice to have shadow variable detection enabled (QEMU did
that recently and it caught various bugs).

I'm not sure if this helps or not with readability and get the feeling
that people will perpetually send patches to remove the pointless
macro argument. I guess a comment on why it is there might avoid that
well enough though.


> 
> >  
> > > >  
> > > > >
> > > > > There are a lot of opportunities for device_node loops, but also for some
> > > > > more obscure loops over other types.  
> > > >  
> > > > > And there are a lot of of_node_puts
> > > > > that could be eliminated independent of loops.  
> > > >
> > > > The non loop cases should be handled via the __free(device_node) as provided
> > > > by patch 1.  We'll need to keep the declaration local and initial assignment
> > > > together but that is easy enough to do and similar to the many other cleanup.h
> > > > usecases that are surfacing.  
> > >
> > > I tried the following semantic patch:
> > >
> > > @@
> > > identifier x,f;
> > > attribute name __free;
> > > expression list es;
> > > expression e;
> > > statement S;
> > > @@
> > >
> > > {
> > > ... when != S
> > > struct device_node *x
> > > + __free(device_node)
> > > ;
> > > ... when strict
> > > x = f(es);
> > > <... when any
> > >      when != x = e
> > > -of_node_put(x);  
> > > ...>  
> > > -of_node_put(x);
> > > }
> > >  
> > Nice.  
> > > It is written defensively in various ways:
> > >
> > > when != S means tha tthe device_node declaration has t be at the top of
> > > the block, perhaps with other declarations before it.
> > >
> > > when strict means that all paths must lead from the declaration to the
> > > initialization.  So there is no need to intiialize the variable to NULL,
> > > as far as I understand.
> > >
> > > when != x = e means that the declared variable is not reinitialized, which
> > > would require keeping the previous of_node_put.
> > >
> > > There is an of_node_put at the end of the block, so the use of __free
> > > doesn't change the lifetime.
> > >
> > > An unfortunate aspect of the last constraint is that some functions may
> > > declare multiple device_node variables, and only one of the of_not_puts
> > > can come at the very end of the block.  This can be solved by just running
> > > the semantic patch again.
> > >
> > > An alternative would be to move the initialization up to the declaration,
> > > but the result was often a bit ugly, due to the various initialization
> > > function calls having long names and argument lists.  
> >
> > You have to do that in order to ensure there is no window for someone to
> > easily insert code that leaves them uninitialized.
> >
> > Linus had some rather specific comments on that being the only right way to
> > do it.  
> 
> OK, the semantic patch can be changed to do that.  It would have to be a
> bit more complex or a bit more defensive, to be sure that no variables are
> used between the declaration and the current call site.
> 
> >  
> > >
> > > The output is below.  I have looked quickly through all of the changes and
> > > they all look reasonable, but have not tried compiling anything (which I
> > > guess wouldn't currently work anyway).
> > >
> > > julia
> > >  
> >
> > I picked a couple from the end.  They show the sort of things that
> > would want cleaning up.  The script is great for finding low hanging
> > fruit but as you've identified there is often some stuff that isn't
> > easy to automate.
> >  
> > > diff -u -p a/drivers/clk/clk-nomadik.c b/drivers/clk/clk-nomadik.c
> > > --- a/drivers/clk/clk-nomadik.c
> > > +++ b/drivers/clk/clk-nomadik.c
> > > @@ -87,7 +87,7 @@ static const struct of_device_id nomadik
> > >
> > >  static void __init nomadik_src_init(void)
> > >  {
> > > -	struct device_node *np;
> > > +	struct device_node *np __free(device_node);
> > >  	u32 val;
> > >
> > >  	np = of_find_matching_node(NULL, nomadik_src_match);
> > > @@ -134,7 +134,6 @@ static void __init nomadik_src_init(void
> > >  	register_reboot_notifier(&nomadik_clk_reboot_notifier);
> > >
> > >  out_put:  
> > Can avoid the label given nothing to do any more.  
> 
> Indeed.
> 
> > > -	of_node_put(np);
> > >  }
> > >
> > >  /**
> > > diff -u -p a/arch/powerpc/platforms/chrp/setup.c b/arch/powerpc/platforms/chrp/setup.c
> > > --- a/arch/powerpc/platforms/chrp/setup.c
> > > +++ b/arch/powerpc/platforms/chrp/setup.c
> > > @@ -99,7 +99,7 @@ static void chrp_show_cpuinfo(struct seq
> > >  {
> > >  	int i, sdramen;
> > >  	unsigned int t;
> > > -	struct device_node *root;
> > > +	struct device_node *root __free(device_node);  
> >
> > Same as next 2.
> >  
> > >  	const char *model = "";
> > >
> > >  	root = of_find_node_by_path("/");
> > > @@ -152,7 +152,6 @@ static void chrp_show_cpuinfo(struct seq  
> > >  			   gg2_cachetypes[(t>>2) & 3],  
> > >  			   gg2_cachemodes[t & 3]);
> > >  	}
> > > -	of_node_put(root);
> > >  }
> > >
> > >  /*
> > > @@ -195,7 +194,7 @@ static void __init sio_fixup_irq(const c
> > >
> > >  static void __init sio_init(void)
> > >  {
> > > -	struct device_node *root;
> > > +	struct device_node *root __free(device_node);  
> >
> > As below needs to be
> > 	struct device_node *root __free(device_node) = of_find_node_by_path("/");
> > so there is no space for code to be added inbetween that might return before
> > this is set.  
> 
> OK
> 
> > >  	const char *model;
> > >
> > >  	root = of_find_node_by_path("/");
> > > @@ -209,8 +208,6 @@ static void __init sio_init(void)
> > >  		/* select logical device 1 (KBC/Mouse) */
> > >  		sio_fixup_irq("mouse", 1, 12, 2);
> > >  	}
> > > -
> > > -	of_node_put(root);
> > >  }
> > >
> > >
> > > @@ -364,7 +361,7 @@ static void chrp_8259_cascade(struct irq
> > >   */
> > >  static void __init chrp_find_openpic(void)
> > >  {
> > > -	struct device_node *np, *root;
> > > +	struct device_node *np __free(device_node), *root;  
> >
> > This one looks dangerous because of the chance of other code
> > getting added between here and the point where it is set.
> >
> > Better to move that down so we have
> >
> > struct device_node *np __free(device_node) = of_find_node_by_type(NULL, "open-pic");
> >
> > Also there is a nicer use in:
> > https://elixir.bootlin.com/linux/v6.8-rc2/source/arch/powerpc/platforms/chrp/setup.c#L217  
> 
> So the point is that we now allow declarations at random places, and not
> only at the top of a function?

yes.

https://lore.kernel.org/all/CAHk-=wgRHiV5VSxtfXA4S6aLUmcQYEuB67u3BJPJPtuESs1JyA@mail.gmail.com/
And onwards in that thread.

Linus was pretty clear that constructor and destructor should come together
and gave an example at the end of that email 

+	lines = gpio_sim_count_lines(bank);
+	char **line_names __free(kfree) = kcalloc(lines, sizeof(*line_names), GFP_KERNEL);

Reality was that the cleanup.h macros were doing this anyway it just was
somewhat hidden in guard() and friends.

> 
> >  
> > >  	int len, i, j;
> > >  	int isu_size;
> > >  	const unsigned int *iranges, *opprop = NULL;
> > > @@ -438,7 +435,6 @@ static void __init chrp_find_openpic(voi
> > >  	ppc_md.get_irq = mpic_get_irq;
> > >   bail:
> > >  	of_node_put(root);  
> > With root covered this can return early.  
> 
> Yes, this could be addressed by running the rule more than once.
> 
> Thanks for the feedback!

Thanks for putting together a script so quickly.

Jonathan

> 
> julia
> 
> >  
> > > -	of_node_put(np);
> > >  }
> > >  
> >
> >  


