Return-Path: <linux-kernel+bounces-3387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A9D816BAA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82FC21F23569
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51051182C2;
	Mon, 18 Dec 2023 10:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YEkyxcnu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA9B199A6;
	Mon, 18 Dec 2023 10:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702896961; x=1734432961;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=WmiTKax6/Oi/+GDWz9+tzupvjyPTmW0fT29n22A8Ct4=;
  b=YEkyxcnuR1GkxumSqqfl8O29ARe58p9HbutlVLB61lw6xqHNjWGoOJ42
   +480eUJcXNwjGG8lMEszwrDWDE55K+NfQE2IyRxRxLHvIHMF5OI05XOnE
   hcDJr/NJ9ghOKjZIsGsUYxfhLBEpaK5skOsc8WuWd0r0zBabgG5JnCuRt
   j9ehK62n5IyaCOPov63SRcr6VPe1g7TleHeSqYEpZbONOJwwN/ZZGxOCe
   7Hl8uMX4zuYiNbJjk5XRBPpEHqMdqwmjr1sjiYpF9oqKjb5UStGIuUER5
   5qBAiPDFxARABJFwD86NnyXGvDDLBkYrWk/5QyOCIAbuHxxYYuqXBIWO6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="481673732"
X-IronPort-AV: E=Sophos;i="6.04,285,1695711600"; 
   d="scan'208";a="481673732"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 02:56:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="841436174"
X-IronPort-AV: E=Sophos;i="6.04,285,1695711600"; 
   d="scan'208";a="841436174"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 02:55:57 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rFBHu-00000006u3w-301z;
	Mon, 18 Dec 2023 12:55:54 +0200
Date: Mon, 18 Dec 2023 12:55:54 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v1 1/3] device property: Implement device_is_big_endian()
Message-ID: <ZYAlOpjJBuvY-wTR@smile.fi.intel.com>
References: <2023102624-moonshine-duller-3043@gregkh>
 <ZTpbMVSdKlOgLbwv@smile.fi.intel.com>
 <ZUPBVMdi3hcTyW2n@smile.fi.intel.com>
 <CAMRc=MeV9ZyOzuQFEE_duPTHYgfmr6UZU6bpjDPhrczZX4PHpg@mail.gmail.com>
 <CAMRc=MdSpk_OszeDCyA5_Sp-w=sL9DHB2gGCOFP+FCiobm2cbA@mail.gmail.com>
 <2023111513-stinky-doorframe-8cd1@gregkh>
 <ZXHUat2Xo1VcAxN2@smile.fi.intel.com>
 <2023121512-breeches-snaking-74ad@gregkh>
 <ZXxr8LD1P63k-xRV@smile.fi.intel.com>
 <CAMRc=MeBh5Uq1YTvcnGugnvOFYh+rqc7fJpZrSvfmHbwh3SKXw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MeBh5Uq1YTvcnGugnvOFYh+rqc7fJpZrSvfmHbwh3SKXw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Dec 18, 2023 at 11:35:04AM +0100, Bartosz Golaszewski wrote:
> On Fri, Dec 15, 2023 at 4:11 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, Dec 15, 2023 at 03:49:38PM +0100, Greg Kroah-Hartman wrote:
> > > On Thu, Dec 07, 2023 at 04:19:22PM +0200, Andy Shevchenko wrote:
> > > > On Wed, Nov 15, 2023 at 03:21:29PM -0500, Greg Kroah-Hartman wrote:
> > > > > On Wed, Nov 15, 2023 at 03:58:54PM +0100, Bartosz Golaszewski wrote:
> > > > > > On Fri, Nov 3, 2023 at 10:08 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > > > > > > On Thu, Nov 2, 2023 at 4:33 PM Andy Shevchenko
> > > > > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > > > On Thu, Oct 26, 2023 at 03:27:30PM +0300, Andy Shevchenko wrote:
> > > > > > > > > On Thu, Oct 26, 2023 at 07:25:35AM +0200, Greg Kroah-Hartman wrote:
> > > > > > > > > > On Wed, Oct 25, 2023 at 09:42:57PM +0300, Andy Shevchenko wrote:

...

> > > > > > > > > > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > > > > >
> > > > > > > > > Thank you, Greg.
> > > > > > > > >
> > > > > > > > > Bart, would it be still possible to take this into next?
> > > > > > > > > I would like to have at least this patch applied (with the first user)
> > > > > > > > > to allow conversion of others (I have some more users of new API).
> > > > > > > >
> > > > > > > > Okay, seems we missed v6.7 with this, can you then prepare an immutable
> > > > > > > > branch / tag with this, so other maintainers can pull in case it's needed?
> > > > > > > > (I have something against tty already and perhaps something else, let's
> > > > > > > >  see.)
> > > > > > >
> > > > > > > It arrived too late in the cycle, I needed to send my PR earlier this
> > > > > > > time as I was OoO this week.
> > > > > >
> > > > > > Greg, will you take this patch through your tree and provide me with
> > > > > > an immutable tag for this cycle?
> > > > >
> > > > > Sure, let me catch up with patches after I return from Plumbers next
> > > > > week.
> > > >
> > > > Hope Plumbers went well!
> > >
> > > Sorry for the delay, immutable tag can be found at:
> > >       git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git device_is_big_endian-6.8-rc1
> > > for anyone to pull from now.
> >
> > No problem and thank you!
> >
> > Bart, can you pull that? Or should I to my tree and then push with other
> > GPIO patches?
> 
> Ugh, this is rebased on top of 6.7-rc3...
> 
> My tree is based on rc1, if I pull it, then it'll be a mess.

But v6.7-rc3 is something that is already in the upstream.
I don't see how it can be more "mess" with this. Whatever...

> Andy: How badly do you want it in v6.8? Can this wait until after the
> merge window?

I waited for a cycle already with this...

OTOH GPIO part is not anyhow critical from the semantic point of view.
Since the main patch is in Greg's tree I'll survive with GPIO stuff
going next cycle.

-- 
With Best Regards,
Andy Shevchenko



