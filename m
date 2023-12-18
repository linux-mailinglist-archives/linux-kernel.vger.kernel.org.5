Return-Path: <linux-kernel+bounces-3759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7588170A9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 001E81C222BF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6881115AC0;
	Mon, 18 Dec 2023 13:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i4i5PDqG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB80129EE3;
	Mon, 18 Dec 2023 13:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702906840; x=1734442840;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=o+zE+sjrn3v1eFh6D59oFX7RAmbPwzBszxq/pKNAJRw=;
  b=i4i5PDqGwVBUdWlKAwNwfEXmc+jDPzJ4Dsb5LjnaVtdvNKH+UQQFMSFB
   IUsFAOfNu0kfxz1pTrV9v38wZGndCTAE8EItky/mvdl3grHh2NsvbPzev
   ZxPaEk8V+4bA6mHWYgZm7FjGLqpdZy88vjSZxYyiqfPmsf4kY+kvJzzaK
   kmIrgDPAl6SXAuxyLrjCVq3qogEg7YWR0/FMtfjfKJAEnEJ3EjiA7K2Y9
   v5FKf2ZPJACmQHWFsIg+qUTTxOELWj1eXLtHbtFEqpHR3bNVBiDuTHmDN
   Wqm9MtaIGBgwXDoRBspTWi2eA9U+c/L0fZcxRJWDl+V125nBxax3Ucgdp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="8957355"
X-IronPort-AV: E=Sophos;i="6.04,285,1695711600"; 
   d="scan'208";a="8957355"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 05:40:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="845954022"
X-IronPort-AV: E=Sophos;i="6.04,285,1695711600"; 
   d="scan'208";a="845954022"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 05:40:36 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rFDrF-00000006x5g-335i;
	Mon, 18 Dec 2023 15:40:33 +0200
Date: Mon, 18 Dec 2023 15:40:33 +0200
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
Message-ID: <ZYBL0Y9VaWeVFbg5@smile.fi.intel.com>
References: <CAMRc=MdSpk_OszeDCyA5_Sp-w=sL9DHB2gGCOFP+FCiobm2cbA@mail.gmail.com>
 <2023111513-stinky-doorframe-8cd1@gregkh>
 <ZXHUat2Xo1VcAxN2@smile.fi.intel.com>
 <2023121512-breeches-snaking-74ad@gregkh>
 <ZXxr8LD1P63k-xRV@smile.fi.intel.com>
 <CAMRc=MeBh5Uq1YTvcnGugnvOFYh+rqc7fJpZrSvfmHbwh3SKXw@mail.gmail.com>
 <ZYAlOpjJBuvY-wTR@smile.fi.intel.com>
 <CAMRc=MeJgJj7ikp85vj9KMxgh6Rfx5BrCa3uq52Rj+iDFmQunQ@mail.gmail.com>
 <2023121834-exuberant-visibly-329f@gregkh>
 <CAMRc=MfUNaBcsxGstAk3Y1To2AMGvDY6EoQYcyBALDQuA=QGdg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MfUNaBcsxGstAk3Y1To2AMGvDY6EoQYcyBALDQuA=QGdg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Dec 18, 2023 at 01:38:18PM +0100, Bartosz Golaszewski wrote:
> On Mon, Dec 18, 2023 at 12:18 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Mon, Dec 18, 2023 at 12:05:54PM +0100, Bartosz Golaszewski wrote:
> > > On Mon, Dec 18, 2023 at 11:56 AM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Mon, Dec 18, 2023 at 11:35:04AM +0100, Bartosz Golaszewski wrote:
> > > > > On Fri, Dec 15, 2023 at 4:11 PM Andy Shevchenko
> > > > > <andriy.shevchenko@linux.intel.com> wrote:

...

> > > > > Ugh, this is rebased on top of 6.7-rc3...
> > > > >
> > > > > My tree is based on rc1, if I pull it, then it'll be a mess.
> > > >
> > > > But v6.7-rc3 is something that is already in the upstream.
> > > > I don't see how it can be more "mess" with this. Whatever...
> > >
> > > My for-next branch is based on v6.7-rc1 (as it should IIUC) and if I
> > > now pull Greg's tag, I will be sending rc1-rc3 stuff to Linus Torvalds
> > > in addition to the GPIO changes for v6.8. I bet he will not appreciate
> > > it.
> >
> > No, you will not be sending him -rc1-rc3 stuff at all, that's not how
> > git works.
> >
> > Try it yourself and see.  Git does a "what's the changesets that are
> > in this pull request and not already in mine" when determining this.
> > You can see it when doing a 'git request-pull', it will only show you
> > the diff of what will be sent.
> >
> > Also look at the 'git merge-base' output, it will show the point where
> > things will start to be sent, and that will not have all of the -rc1
> > through -rc3 changes in it.
> >
> > > Greg: Is it too late to have this rebased on top of v6.7-rc1 instead?
> >
> > Sorry, but yes.  But don't worry, again, git can handle all of this
> > easily!  Try it locally and see.  Don't fear the 'fast-forward' :)
> 
> Sorry for the noise. I did try it locally and noticed that a bunch of
> commits that were merged before rc3 moved "before it" in git log and
> figured this is what the PR would look like. However the PR is correct
> and I should have generated it before sending the email.

Right.

What Linus can rant on is when one rebases his stuff on newer rcX,
the merges on contrary are pretty much okay as long as they are
justified.

> Thanks for a lesson in git.

-- 
With Best Regards,
Andy Shevchenko



