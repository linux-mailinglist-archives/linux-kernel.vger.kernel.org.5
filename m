Return-Path: <linux-kernel+bounces-137020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C37FF89DB34
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63E8C1F2183F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576E2130494;
	Tue,  9 Apr 2024 13:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eflFdtuC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E67212C531;
	Tue,  9 Apr 2024 13:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712670393; cv=none; b=IuDXuTFuFaeD/bz/nk23VLlTGN8TYAMta292vnRH+e63qM19c0ZBFMacjjT0VcZueWQfqlGoVyW0kif/g8XEJ6sqvLxQ0Wg6s29B1XgAgN2vEONBzjn3zS8HmbsI6FUU06RGRL99dPR/XJw/bR0kKcYCfaWgvZ5GZDO0DI4Wnk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712670393; c=relaxed/simple;
	bh=zDbyBb/9hhPVBbG3X7C1YdT4HO4jlTdu1qvdQ+VHvJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bBfQezPsBLgp3LiXrM9rfqYTPrqM9zr+GhR5XcisQ56vX9I8CnG/fMBqluiYmJyFjzcZ1thE8xa7o9bzoqwSwhOjQMkXovcCpWVPv/k8Xt45OxAllCXHmy3iQPdalqaAfXqP4Z+Ze5+0nATJydmu2ESjTujElCStSumh5wE1ltk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eflFdtuC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF194C433C7;
	Tue,  9 Apr 2024 13:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712670393;
	bh=zDbyBb/9hhPVBbG3X7C1YdT4HO4jlTdu1qvdQ+VHvJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eflFdtuCE7meJNtJ0Hp2+gGmaAnDIiIBQS7CUgKkcvnDVwoxUWPdC7Nku33lL47Rw
	 OyqoX1knSwghzlxHbL9UGhzngUjdFVkI3M0ZWK8ae8BnOir9NLz88MADXEczliGDrP
	 sjLZM0S9BvPXV+eXIdtqLbO5a7RPrnTho2LNLK7c=
Date: Tue, 9 Apr 2024 15:46:30 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [PATCH v1 0/3] serial: Do not count XON/XOFF in the statistics
Message-ID: <2024040926-whinny-coil-4c15@gregkh>
References: <20240403144722.860258-1-andriy.shevchenko@linux.intel.com>
 <Zg3VHs-LVxHFdi8V@surfacebook.localdomain>
 <573aac92-9c9b-427b-a76f-3c0b7c3b6ce6@kernel.org>
 <Zg7NPnpFXkQWJ-Ks@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zg7NPnpFXkQWJ-Ks@smile.fi.intel.com>

On Thu, Apr 04, 2024 at 06:54:38PM +0300, Andy Shevchenko wrote:
> On Thu, Apr 04, 2024 at 07:16:55AM +0200, Jiri Slaby wrote:
> > On 04. 04. 24, 0:15, Andy Shevchenko wrote:
> > > Wed, Apr 03, 2024 at 05:46:14PM +0300, Andy Shevchenko kirjoitti:
> > > > Some drivers count XON/XOFF in the Tx statistics, some do not.
> > > > I actually a bit uncertain, but I _think_ the correct way is not
> > > > to count them, hence this series.
> > > 
> > > Okay, it seems there are much more drivers doing that. Perhaps we need
> > > to add that to the rest in this case (i.o.w. invert the series from removal
> > > to addition)?
> > 
> > Interesting, perhaps cut & paste?
> > 
> > XON and XOFF are overhead IMO. So should not be counted. When they are, they
> > mangle statistics as in transmitted (real) bytes per second.
> > 
> > How are they handled on the RX side?
> 
> It took me a while.
> 
> All serial drivers accept everything and those that care, update statics for
> anything they receive. This is because of layering. The Rx XON/XOFF seems
> (note I am completely unfamiliar with mysterious ways of TTY layers) to be
> handled on TTY level by n_tty_receive_char_flow_ctrl(), i.o.w. we may not
> skip counting it easily.
> 
> Now the question is, shall we count the control characters on output or not?
> Whatever decision we made, we should document (if not yet) and align drivers
> accordingly.
> 
> Another Q is what do books / other OS / projects usually do with them
> WRT statistics?

It depends on where you are measuring stuff.

If you want "raw" bytes on the wire, you count them.  If you want to see
what the port sends based on what userspace sent/recieved, you don't.

> If we count everything on a wire, then we must count them, otherwise
> it depends on how we treat them.

Agreed.  We need to pick one and stick with it.

I think, at the driver level, we should count it, as it's a ldisc thing,
not a driver thing, right?

thanks,

greg k-h

