Return-Path: <linux-kernel+bounces-3413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D47AE816BF4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82B032842D5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92CE199C1;
	Mon, 18 Dec 2023 11:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FEit6f+/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE8F18EC8;
	Mon, 18 Dec 2023 11:08:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C771C433C9;
	Mon, 18 Dec 2023 11:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702897686;
	bh=7GBQve1dpE300PCo1mbPDRImN6sHcUIY2BVQldVsS0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FEit6f+/+GOpj/NbQbO9USeVoM0K1afvDYFMg9zwiAD37Bd2sKuEBFeLlRYDFkSad
	 zRElqqZgsW9C0bu6JBPIOABUrBAJZTntFRyJaQVFXTXm8DkgmeW5/flYH1dDCDkbMN
	 gsaY98znPIwxrLrUXTgOmOzCpnJ7scBu9gUTXJHA=
Date: Mon, 18 Dec 2023 12:08:03 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v1 1/3] device property: Implement device_is_big_endian()
Message-ID: <2023121831-humped-favorably-0b7a@gregkh>
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

On Mon, Dec 18, 2023 at 11:35:04AM +0100, Bartosz Golaszewski wrote:
> On Fri, Dec 15, 2023 at 4:11 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
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
> >
> > ...
> >
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
> >
> 
> Ugh, this is rebased on top of 6.7-rc3...
> 
> My tree is based on rc1, if I pull it, then it'll be a mess.

What would make it a "mess"?  It's all upstream already, taking a merge
from a point further in time will work just fine, git is nice :)

thanks,

greg k-h

