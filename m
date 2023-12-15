Return-Path: <linux-kernel+bounces-1184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8991814B6A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FC7AB233FA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D1F364D7;
	Fri, 15 Dec 2023 15:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AWXLJsKt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775643EA81;
	Fri, 15 Dec 2023 15:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702653077; x=1734189077;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Sook6ADwecKC9ZJSEtb7hbbRbghZbLoEQUg8mNVwp3o=;
  b=AWXLJsKtIIigDkB5qBudXJN8z/Y6ew4sUxxzxdbxIgVQTv7Z07LKZdOg
   wllEcolyWPDYLkWgjCR0GyisrtHquo/r9knswtWebQy5ZnK9S5pXCII7e
   T9cNFCnjlVCFPFFwU6ANIFkXH+2klhNCeB89V95KW1pWijYHSI/Y3IOcT
   2JipEJjQpHlby8EhH5DhBIeYpmMtIAfVNf1gJN4bbxlyoFELlBAa0rFAR
   EO0xyS98O/yuLJzCbRCjwUP0XB70QxoAGa323imNk5ra6c6SJ1E11cPVJ
   Fg9ZFxTC8hZmkY/xzfpgximEYy+B635TszgAPUvy1mG2o7jSWXqhgNCR5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="394161415"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="394161415"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 07:08:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="803736114"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="803736114"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 07:08:35 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rE9nk-000000069VM-2TzQ;
	Fri, 15 Dec 2023 17:08:32 +0200
Date: Fri, 15 Dec 2023 17:08:32 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v1 1/3] device property: Implement device_is_big_endian()
Message-ID: <ZXxr8LD1P63k-xRV@smile.fi.intel.com>
References: <20231025184259.250588-1-andriy.shevchenko@linux.intel.com>
 <20231025184259.250588-2-andriy.shevchenko@linux.intel.com>
 <2023102624-moonshine-duller-3043@gregkh>
 <ZTpbMVSdKlOgLbwv@smile.fi.intel.com>
 <ZUPBVMdi3hcTyW2n@smile.fi.intel.com>
 <CAMRc=MeV9ZyOzuQFEE_duPTHYgfmr6UZU6bpjDPhrczZX4PHpg@mail.gmail.com>
 <CAMRc=MdSpk_OszeDCyA5_Sp-w=sL9DHB2gGCOFP+FCiobm2cbA@mail.gmail.com>
 <2023111513-stinky-doorframe-8cd1@gregkh>
 <ZXHUat2Xo1VcAxN2@smile.fi.intel.com>
 <2023121512-breeches-snaking-74ad@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2023121512-breeches-snaking-74ad@gregkh>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Dec 15, 2023 at 03:49:38PM +0100, Greg Kroah-Hartman wrote:
> On Thu, Dec 07, 2023 at 04:19:22PM +0200, Andy Shevchenko wrote:
> > On Wed, Nov 15, 2023 at 03:21:29PM -0500, Greg Kroah-Hartman wrote:
> > > On Wed, Nov 15, 2023 at 03:58:54PM +0100, Bartosz Golaszewski wrote:
> > > > On Fri, Nov 3, 2023 at 10:08 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > > > > On Thu, Nov 2, 2023 at 4:33 PM Andy Shevchenko
> > > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > On Thu, Oct 26, 2023 at 03:27:30PM +0300, Andy Shevchenko wrote:
> > > > > > > On Thu, Oct 26, 2023 at 07:25:35AM +0200, Greg Kroah-Hartman wrote:
> > > > > > > > On Wed, Oct 25, 2023 at 09:42:57PM +0300, Andy Shevchenko wrote:

...

> > > > > > > > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > > >
> > > > > > > Thank you, Greg.
> > > > > > >
> > > > > > > Bart, would it be still possible to take this into next?
> > > > > > > I would like to have at least this patch applied (with the first user)
> > > > > > > to allow conversion of others (I have some more users of new API).
> > > > > >
> > > > > > Okay, seems we missed v6.7 with this, can you then prepare an immutable
> > > > > > branch / tag with this, so other maintainers can pull in case it's needed?
> > > > > > (I have something against tty already and perhaps something else, let's
> > > > > >  see.)
> > > > >
> > > > > It arrived too late in the cycle, I needed to send my PR earlier this
> > > > > time as I was OoO this week.
> > > >
> > > > Greg, will you take this patch through your tree and provide me with
> > > > an immutable tag for this cycle?
> > > 
> > > Sure, let me catch up with patches after I return from Plumbers next
> > > week.
> > 
> > Hope Plumbers went well!
> 
> Sorry for the delay, immutable tag can be found at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git device_is_big_endian-6.8-rc1
> for anyone to pull from now.

No problem and thank you!

Bart, can you pull that? Or should I to my tree and then push with other
GPIO patches?

-- 
With Best Regards,
Andy Shevchenko



