Return-Path: <linux-kernel+bounces-63731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 271698533C4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC1FCB28129
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861E45FBB4;
	Tue, 13 Feb 2024 14:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h8WEbRNY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308CA5FB8E
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 14:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707836134; cv=none; b=EMOEVfCMmZ7YnZbnKfMW7dTub1JVttaxOAMxhnMqPFmy8KmOKM/xJdEcQfa9h8MH/lHEA3sSZa1EN1PHU0grk3PzQrVbSFW4WhLAkFsALk/YELBga6MN79SupuP/8Y/DzONr1NMv676EREtONWqGd/aGZ0rMH+NfjdULmYo+Glo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707836134; c=relaxed/simple;
	bh=MoHdc6EF3z9cqmLP2aU52le9p1v/TRksfdQWzUA0huw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I7vUjkGZOoen41fOYAvz14XMZeKIUWG6Y1OtT3um45NGOwQqbMHsOt0Uekvt+ItZ76haLPLwstqZgowtTiasr+2G6mkP5gwBiw6dyhNm/4PUNqQYtm/Guyb9WA7md1HGqt9gCOWyzhEUcgtjWM3NGiSBOkwnUXxmrsHuWZIDAEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h8WEbRNY; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707836133; x=1739372133;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MoHdc6EF3z9cqmLP2aU52le9p1v/TRksfdQWzUA0huw=;
  b=h8WEbRNYZNFPyapR4wVcwpvElPQFcGi9rjx11D9l3XGKKx8KPunJ7G9b
   EVTJX1UQJ6ha6n36Jk6seI44E6uc4ysM2CckhL2VVpLAMkJIOqICtkIke
   5OVWaPUMJS2MZ6ZQnLNNFzWZyq+pfhOGgxbjm9FPN4uK0HGSJ3JBnlw/D
   cMfKIrI+RUWJRE+xnVoROBCZFaFzrDjSxo8OHscjdiJe07seh8btJh3wr
   uQcwx3ER1vcTesr1eyRo3b0ZUltsFqZMK/iu4cUYBDKok0RdD/dl83b0p
   EdDKCmn7Q5jiUd5tUc7JSu2oD/uFZfEo8dPCq2pkt/LSV43x2NQcWCdMU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="4809025"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="4809025"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 06:55:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="911804273"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="911804273"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 06:55:28 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rZuBz-00000004FFD-0S6x;
	Tue, 13 Feb 2024 16:55:27 +0200
Date: Tue, 13 Feb 2024 16:55:26 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 1/3] auxdisplay: Take over maintainership, but in Odd
 Fixes mode
Message-ID: <ZcuC3jGSVI4MqDeN@smile.fi.intel.com>
References: <20240212132515.2660837-2-andriy.shevchenko@linux.intel.com>
 <20240212132515.2660837-3-andriy.shevchenko@linux.intel.com>
 <9c7df0e5-31a9-4c86-b996-4cba82c4ea2f@suse.de>
 <ZcpKh_EgNM5IaV-P@smile.fi.intel.com>
 <ZcpKwz8J8OoODMYl@smile.fi.intel.com>
 <87sf1wkcmv.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sf1wkcmv.fsf@minerva.mail-host-address-is-not-set>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 13, 2024 at 09:10:48AM +0100, Javier Martinez Canillas wrote:
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
> > On Mon, Feb 12, 2024 at 06:42:48PM +0200, Andy Shevchenko wrote:
> >> On Mon, Feb 12, 2024 at 05:33:39PM +0100, Thomas Zimmermann wrote:
> >> > Am 12.02.24 um 14:23 schrieb Andy Shevchenko:

..

> >> > > I have no time for this, but since it looks like I'm the main
> >> > > contributor for the last few years to the subsystem, I'll take
> >> > > it for now. Geert agreed to help me with as a designated reviwer.
> >> > > Let's see how it will go...
> 
> AFAICT Miguel Ojeda is quite responsive and is still doing reviews/acks
> for auxdisplay patches. Can you elaborate why the maintainership change
> has to be made?
> 
> You can still be listed as co-maintainer of course, and maybe Miguel is
> on board to drop this but then I think that should be mentioned in your
> commit message (and have an ack from him).

He answered you in a separate email. I have nothing to add.

..

> >> > A few days ago, I talked to Javier about how auxdisplay is a hotchpodge of
> >> > various drivers that seem to belong into other subsystems. Could we attempt
> >> > to move all drivers into other places and then remove the auxdisplay
> >> > subsystem?
> >> 
> >> Can you be more precise on how it can be done? We have at least two clusters of
> >> the displays: line-display and HD44780-based ones. Moreover, the latter might
> >> use the former in the future (in some cases).
> 
> For line-display and 7-segment display I'm less sure, and it may be that
> we do need a specific subsystem for those. But then maybe it has to be
> renamed to text-based or character based displays instead ?

"text" is incorrect term here, as 7-segment LEDs can only emulate text to some
extent. Poorly TBH. HD44780 can hold the overrides for the font, which makes
it not so text either (yes, the old xGA [x = C,E,V,...] display controllers
already can do the same in some text modes).

> I wonder though if these can be modeled as an output only tty instead.
> 
> There are though more than these two types of display, for example the
> cfag12864bfb driver is a FB_VISUAL_MONO10 fbdev driver:
> 
> https://elixir.bootlin.com/linux/latest/source/drivers/auxdisplay/cfag12864bfb.c
> 
> Now that we have better support in DRM/KMS for monochrome displays, it
> seems to me that could be even ported and be a modesetting driver. I've
> mentioned this to a colleague who wants to get start with Linux graphics
> as a good learning exercise.

I believe you are too much focused on the _exceptional_ drivers, most of which
are _not_ FB ones.

> I believe the problem is that auxdisplay is too vague of a term, so anything
> could be an "auxdisplay". Even tiny I2C/SPI panels could be defined as that.

I understand the term well, SPI/I2C display, when it's the main one can't be
aux. The latter one, e.g., is an LCD on the server panel, or 7-segment LEDs
on the motherboard for debug.

Definitely, as a maintainer, I would not accept the driver that belongs to
FB/DRM if it's clear that it has no tights to the 7-seg/N-seg / line or its
main usage is display panels.

> > Btw, I have no time for major things here, if you wish, please take over,
> > I will be happy to get rid of this.

-- 
With Best Regards,
Andy Shevchenko



