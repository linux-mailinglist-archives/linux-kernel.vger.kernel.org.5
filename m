Return-Path: <linux-kernel+bounces-1133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5162D814AF7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 074901F24A74
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05A735F01;
	Fri, 15 Dec 2023 14:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1/gGzI7C"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276EA35882;
	Fri, 15 Dec 2023 14:49:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ABC3C433C8;
	Fri, 15 Dec 2023 14:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702651780;
	bh=ygbe9sj9ZaVDLPoMfc/8+r9ybsCSuXkWWB+EyUhHU1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1/gGzI7CUIwfg0TzD25PR9VBgy/McV+qEodqp2KbRY5za5QW38vgp2V9MF/ik8mF7
	 o3vpHYohorl9+f4/CYBd9mc4bzNWB6so2BRCVV2ReYSeOuKFA9h2wlc8j9vXWxxUzc
	 O9hEVFaF08m9Rk8tCIQgh8t0Mnfk25ADy9mRqukw=
Date: Fri, 15 Dec 2023 15:49:38 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v1 1/3] device property: Implement device_is_big_endian()
Message-ID: <2023121512-breeches-snaking-74ad@gregkh>
References: <20231025184259.250588-1-andriy.shevchenko@linux.intel.com>
 <20231025184259.250588-2-andriy.shevchenko@linux.intel.com>
 <2023102624-moonshine-duller-3043@gregkh>
 <ZTpbMVSdKlOgLbwv@smile.fi.intel.com>
 <ZUPBVMdi3hcTyW2n@smile.fi.intel.com>
 <CAMRc=MeV9ZyOzuQFEE_duPTHYgfmr6UZU6bpjDPhrczZX4PHpg@mail.gmail.com>
 <CAMRc=MdSpk_OszeDCyA5_Sp-w=sL9DHB2gGCOFP+FCiobm2cbA@mail.gmail.com>
 <2023111513-stinky-doorframe-8cd1@gregkh>
 <ZXHUat2Xo1VcAxN2@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZXHUat2Xo1VcAxN2@smile.fi.intel.com>

On Thu, Dec 07, 2023 at 04:19:22PM +0200, Andy Shevchenko wrote:
> On Wed, Nov 15, 2023 at 03:21:29PM -0500, Greg Kroah-Hartman wrote:
> > On Wed, Nov 15, 2023 at 03:58:54PM +0100, Bartosz Golaszewski wrote:
> > > On Fri, Nov 3, 2023 at 10:08 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > > > On Thu, Nov 2, 2023 at 4:33 PM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > On Thu, Oct 26, 2023 at 03:27:30PM +0300, Andy Shevchenko wrote:
> > > > > > On Thu, Oct 26, 2023 at 07:25:35AM +0200, Greg Kroah-Hartman wrote:
> > > > > > > On Wed, Oct 25, 2023 at 09:42:57PM +0300, Andy Shevchenko wrote:
> > > > > > > > Some users want to use the struct device pointer to see if the
> > > > > > > > device is big endian in terms of Open Firmware specifications,
> > > > > > > > i.e. if it has a "big-endian" property, or if the kernel was
> > > > > > > > compiled for BE *and* the device has a "native-endian" property.
> > > > > > > >
> > > > > > > > Provide inline helper for the users.
> > > > > > >
> > > > > > > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > >
> > > > > > Thank you, Greg.
> > > > > >
> > > > > > Bart, would it be still possible to take this into next?
> > > > > > I would like to have at least this patch applied (with the first user)
> > > > > > to allow conversion of others (I have some more users of new API).
> > > > >
> > > > > Okay, seems we missed v6.7 with this, can you then prepare an immutable
> > > > > branch / tag with this, so other maintainers can pull in case it's needed?
> > > > > (I have something against tty already and perhaps something else, let's
> > > > >  see.)
> > > >
> > > > It arrived too late in the cycle, I needed to send my PR earlier this
> > > > time as I was OoO this week.
> > >
> > > Greg, will you take this patch through your tree and provide me with
> > > an immutable tag for this cycle?
> > 
> > Sure, let me catch up with patches after I return from Plumbers next
> > week.
> 
> Hope Plumbers went well!

Sorry for the delay, immutable tag can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git device_is_big_endian-6.8-rc1
for anyone to pull from now.

thanks,

greg k-h

