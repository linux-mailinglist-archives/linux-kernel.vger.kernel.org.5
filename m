Return-Path: <linux-kernel+bounces-89718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A257E86F4A6
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 12:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 403E8B21CB6
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 11:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC405BE6B;
	Sun,  3 Mar 2024 11:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L94S4Hdg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14915BE49;
	Sun,  3 Mar 2024 11:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709467007; cv=none; b=jAXa1O5RW/4kyoRDxhGGwG9XjpynuN/ivTPW7yfcja0YYEkC8JcjvjlUfHnMG1vQUIjjNG4JbzYb5qaAfdr+oJyzWUzCW2+iX326NZaxnfCzVoaesgxzmpBRg+AYYDhErPeWIDolr+ng+ujRTn/IHlWYi3KG3SkyTs+ZET6l4L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709467007; c=relaxed/simple;
	bh=rsWl8E4VnDoBE0w9p8LDB9GFa21nhzS6req7J0ChWt8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gunc1D3mporN6VnXhHcOMqHGZGG+kgxIUWNPCtT/M0eAROGwv4twGWAW2jdJmV9bUQBupIQXpL+doMsJUzVdfbO0yGgrUyshzvEbyKPfCgzqzS98ADVUx+Y5blClITvX1pn3Yf+fJrj64eNnxYJTk6QPr4orl0JRNvsEnZnse7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L94S4Hdg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 862E4C433F1;
	Sun,  3 Mar 2024 11:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709467006;
	bh=rsWl8E4VnDoBE0w9p8LDB9GFa21nhzS6req7J0ChWt8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L94S4Hdg4NOB/gnWF3F3EtBD6SGQZtG8ZR+nZBM8YKXgqzxKsMaKmpYTCDmeH+CFg
	 lSwg35SgBsBeo2QI1hZrm+yPvuZyz6dUO9gm8cb8GoH1EOZju3TU4eMgvVarEq6nfQ
	 pyH+d0bIUJbKalgO4MClmvFkoh799XVpq0JGvUp2H9u/puZefqefWlZBXpw7AMRk7r
	 ZczF3yigRFMJzVusJRBFINZLcu1VIbM3e7liPgLGJMp2mglQ0SVzKjvI52mHvruy9L
	 NYScZMnnN3Gy6jNKMsvlzyhDa8gnymCmMLWxSPGNROBjXyLay2eaYTwdAzXmXENyQY
	 Z6vWuCQOfFbDg==
Date: Sun, 3 Mar 2024 11:56:33 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-iio@vger.kernel.org, Frank Rowand
 <frowand.list@gmail.com>, linux-kernel@vger.kernel.org, Julia Lawall
 <Julia.Lawall@inria.fr>, Peter Zijlstra <peterz@infradead.org>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, marek.vasut@gmail.com, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [RESEND PATCH v2 0/4] of: automate of_node_put() - new approach
 to loops.
Message-ID: <20240303115633.41128a62@jic23-huawei>
In-Reply-To: <20240301223942.GA3179769-robh@kernel.org>
References: <20240225142714.286440-1-jic23@kernel.org>
	<20240301223942.GA3179769-robh@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 1 Mar 2024 16:39:42 -0600
Rob Herring <robh@kernel.org> wrote:

> On Sun, Feb 25, 2024 at 02:27:10PM +0000, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Some discussion occured on previous posting.
> > https://lore.kernel.org/linux-iio/20240223124432.26443-1-Jonathan.Cameron@huawei.com/
> > 
> > Summary:
> > * fwnode conversions should be considered when applying this
> >   infrastructure to a driver. Perhaps better to move directly to
> >   the generic FW property handling rather than improve existing
> >   of specific code.
> > * There are lots of potential places to use this based on detections
> >   from Julia's coccinelle scripts linked below.
> > 
> > The equivalent device_for_each_child_node_scoped() series for
> > fwnode will be queued up in IIO for the merge window shortly as
> > it has gathered sufficient tags. Hopefully the precdent set there
> > for the approach will reassure people that instantiating the
> > child variable inside the macro definition is the best approach.
> > https://lore.kernel.org/linux-iio/20240217164249.921878-1-jic23@kernel.org/
> > 
> > v2: Andy suggested most of the original converted set should move to
> >     generic fwnode / property.h handling.  Within IIO that was
> >     a reasonable observation given we've been trying to move away from
> >     firmware specific handling for some time. Patches making that change
> >     to appropriate drivers posted.
> >     As we discussed there are cases which are not suitable for such
> >     conversion and this infrastructure still provides clear benefits
> >     for them.
> > 
> > Ideally it would be good if this introductory series adding the
> > infrastructure makes the 6.9 merge window. There are no dependencies
> > on work queued in the IIO tree, so this can go via devicetree
> > if the maintainers would prefer. I've had some off list messages
> > asking when this would be merged, as there is interest in building
> > on it next cycle for other parts of the kernel (where conversion to
> > fwnode handling may be less appropriate).  
> 
> I'll let you take it. For the series:
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> I've got some drivers/of/ conversions too, but they are probably next 
> cycle at this point.
> 
> Rob

Thanks Rob,

Whether this makes it for this cycle is probably dependent on whether
Linus does decide to do got to rc8 as hinted at as a possibility
+ whether Greg feels comfortable taking these through his tree
(char-misc is the normal path for IIO).  I know various people
are hoping this series makes it, but if doesn't we can do an immutable
tree early next cycle (though obviously that may reduce speed of adoption).

We are discussing the equivalent pull request for the fwnode version here:

https://lore.kernel.org/linux-iio/2024030239-gift-cabdriver-266b@gregkh/T/#m87e7208820ebf6416a77a2973773b65a087b4796

I've optimistically applied this series to my togreg-cleanup branch
and merged that into the togreg branch of iio.git for linux-next to pick up.

Thanks,

Jonathan

