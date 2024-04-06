Return-Path: <linux-kernel+bounces-134062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C84389ACB4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 20:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DD051F22009
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 18:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807E44C634;
	Sat,  6 Apr 2024 18:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mt+h43s4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04B347F50;
	Sat,  6 Apr 2024 18:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712429664; cv=none; b=OuxkRehyt53h+NDKJRuVcNSTNPNpRHJXmrW6LHVPLNbgTSqx4i4SoXrqM8UGNhq+lnM3PbDDNns4tv+m04Prn48QjIFcFhGVaNJ4St0ru/MLIHxok9I6XUwrCcYulkgpL+VbUJHQ8ctr20uKL9TW4JJ4Xrl0xbrG/0Hkp4anZ8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712429664; c=relaxed/simple;
	bh=x/6LCdwPe9bd7QfSYVBg8tXsBNqlRotB6R1Xk/M09xM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WTAN5nNC+9dXZhqMIlcrUi71R3U5R0NvGI/BNtJZXrKLAf2mvmQwbTWSjhSaosiN28/QeLwdAmIucE8ghAoN81JY7+X/woUma9HefSxHn9msLkd/VVfg+1Ff+AByykm6RqwGirEyzfmzuX9p8orZMZjy/eqhKaLlMZ5RGAEf+18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mt+h43s4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42F49C433C7;
	Sat,  6 Apr 2024 18:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712429664;
	bh=x/6LCdwPe9bd7QfSYVBg8tXsBNqlRotB6R1Xk/M09xM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mt+h43s4WcFJYwx5FDWf/8nIINlT7Q9WhT7RR1uF+LePezACXIWjbT8oDWVgkpvto
	 5X9R1H4AU5DmGdMeLsPuWmbSszD54oa9M2rL4j5OTAEF8JRhMKoGC8syGOY7bLHj88
	 lrp2Hkhbcjce4fLImHkwTWAq1FyoJVi+viLo8gnfKNNeYS1lLF9KlM3lqHuxL+X36K
	 2RTcWQXWWoHOUP17rKuKm8rxMRVrgMHQLjlm1D1MegIEAk+7zd9L6635G/fVjWK000
	 Tqn0a15Wg4tw4tyrh744EEcintalJ9/wlrelWJtfqGiS352qwlElVwHiVm41P08kX1
	 CwkDP06v8Zz9A==
Date: Sat, 6 Apr 2024 20:54:17 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>, Nuno Sa <nuno.sa@analog.com>, Petr Mladek <pmladek@suse.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Olivier Moysan <olivier.moysan@foss.st.com>, 
	Jyoti Bhayana <jbhayana@google.com>, Chris Down <chris@chrisdown.name>, 
	John Ogness <john.ogness@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/4] iio: backend: make use of dev_errp_probe()
Message-ID: <7ejh2r6zcripnptn3nbw2sa3mlfyleg4qg74rryxlut3fysneg@kuqwo5z2l65n>
References: <20240404-dev-add_dev_errp_probe-v1-0-d18e3eb7ec3f@analog.com>
 <20240404-dev-add_dev_errp_probe-v1-3-d18e3eb7ec3f@analog.com>
 <Zg6bsS3WMvp-nY3S@smile.fi.intel.com>
 <9f91388faee750e16021f2c0544e7a158a16202b.camel@gmail.com>
 <Zg7DWQtY6SP9E_1m@smile.fi.intel.com>
 <20240406170717.31ab7e47@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240406170717.31ab7e47@jic23-huawei>

Hi,

On Sat, Apr 06, 2024 at 05:07:17PM +0100, Jonathan Cameron wrote:
> On Thu, 4 Apr 2024 18:12:25 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > On Thu, Apr 04, 2024 at 04:58:27PM +0200, Nuno Sá wrote:
> > > On Thu, 2024-04-04 at 15:23 +0300, Andy Shevchenko wrote:  
> > > > On Thu, Apr 04, 2024 at 01:06:25PM +0200, Nuno Sa wrote:  
> > > > > Using dev_errp_probe() to simplify the code.  
> > 
> > ...
> > 
> > > > > +	if (IS_ERR(fwnode))
> > > > > +		return dev_errp_probe(dev, PTR_ERR(fwnode),
> > > > > +				      "Cannot get Firmware reference\n");  
> > > > 
> > > > ERR_CAST() seems quite good candidate to have here.
> > > > 
> > > > 		return dev_errp_probe(dev, fwnode, "Cannot get Firmware
> > > > reference\n");
> > > > 
> > > > (Assuming dev_errp_probe() magically understands that, note you may have it as
> > > >  a macro and distinguish parameter type with _Generic() or so and behave
> > > >  differently: ERR_PTR() vs. ERR_CAST(), see acpi_dev_hid_uid_match()
> > > >  implementation, but also keep in mind that it doesn't distinguish NULL/0,
> > > > there
> > > >  is a patch available in the mailing list to fix that, though.)  
> > > 
> > > Do we care that much for going with that trouble?  
> > 
> > I don't think we do. We are not supposed to be called with ret == 0/NULL.
> > That's why I pointed out to the current version.
> > 
> > > I understand like this we go
> > > PTR_ERR() to then comeback to ERR_PTR() but this for probe() which is not a
> > > fastpath. So perhaps we could just keep it simple?  
> > 
> > It's not about performance, it's about readability. See the difference between
> > yours and mine.
> > 
> 
> You are suggesting making it transparently take an error ptr or an integer?
> Whilst clever, I'm not seeing that as a good idea for readability / reviewability.
> I expect something that looks like a function to take the same parameters (other vargs)
> always.  _Generic messes with that.
> 
> Maybe I just don't like to learn new things!  If consensus comes down in favour
> of _Generic trickery then I'll get used to it eventually.

the whole point of the dev_err_...() functions is to add trickery
in order to reduce code and brackets.

The way I see this is to have a combination of functions:

 - takes integer, returns integer -> dev_err_probe()
 - takes integer, returns pointer -> dev_errp_probe() (or dev_err_ptr_probe())
 - takes pointer, return integer -> ? dev_ptr_err_probe()
 - takes pointer, returns pointer -> ? dev_ptr_probe()

Thoughts?

Andi

