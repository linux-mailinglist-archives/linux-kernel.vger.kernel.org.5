Return-Path: <linux-kernel+bounces-5440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A7E818AB1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2714E1F290FF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802A11C69E;
	Tue, 19 Dec 2023 14:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g7A2r5Mx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65B51C6B4
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 14:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702997894; x=1734533894;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8ZStjGtj5WfBfCDkqls/ScpqPireTYPCCD16wOglLws=;
  b=g7A2r5Mx7zkY00qInmFd9v9ireqcxeZA2z2l0XMkWSkHVHK6cgubavJ2
   Vxo9lnWEJGbbyBWY02YUTT02ALsvYG4vjXD9Tqm7ZjXMrEb9ttt95sq+V
   3Xv7wh66gZDi2qTfhpzPrptSqPyijPzQx8s5jduAecGOJPNGxfa1mNwH3
   iqUYGJBH5kAZAXLDwrznYsSc3t9Tq5N4w/RkW8t7imV1NaFGyoFZFwvAP
   kfwe7depu+UEuN26zbiHD2qexrJMqH/w8pGfNbvtFwZIaJmED1Sh3Rm4X
   SJvxP+6C3OxQHaQrFBoto9iH1h9xcF09Amm9XFoGEL075dgHE0Eqj4gUb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="460011100"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="460011100"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 06:58:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="866662131"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="866662131"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 06:58:11 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rFbXs-00000007I42-1EG5;
	Tue, 19 Dec 2023 16:58:08 +0200
Date: Tue, 19 Dec 2023 16:58:07 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Mark Hasemeyer <markhas@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Raul Rangel <rrangel@chromium.org>,
	David Gow <davidgow@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Takashi Iwai <tiwai@suse.de>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v1 5/6] platform: Modify platform_get_irq_optional() to
 use resource
Message-ID: <ZYGvf0kH9EHfJKUc@smile.fi.intel.com>
References: <20231213110009.v1.1.Ifd0903f1c351e84376d71dbdadbd43931197f5ea@changeid>
 <20231213110009.v1.5.Ife9ebad2bbfbab3a05e90040f344d750aa0aac7e@changeid>
 <ZXoLbt7jNrmC0VbQ@smile.fi.intel.com>
 <CANg-bXDUxMvm2tmHZVz4Mh=o3VMmO2ZTT2547RZEcwDkn2FUeQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANg-bXDUxMvm2tmHZVz4Mh=o3VMmO2ZTT2547RZEcwDkn2FUeQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Dec 18, 2023 at 01:23:35PM -0700, Mark Hasemeyer wrote:

...

> > Consider combine the above to use fwnode_irq_get() in the separate prerequisite
> > change.
> 
> I like the idea. It doesn't look like 'struct fwnode_operations'
> provides a way to retrieve information in a 'struct resource' format.

It can be added, but it's orthogonal to this series. What I suggest is
to unify them here followed by your patch in this series. I.o.w. add
one more patch as a prerequisite.

> Perhaps this could be followed up on in a separate patch train?

Definitely, but again, not (directly) related to this series.

...

> > > +                     irqd_set_trigger_type(irqd, r->flags & IORESOURCE_BITS);
> >
> > NIH resource_type().
> >
> > > +     }
> > >       return ret;
> 
> Does NIH mean "not invented here"?

Yes.

> resource_type() masks
> IORESOURCE_TYPE_BITS, not IORESOURCE_BITS. I'm not quite sure what you
> mean here.

Ah, my bad, indeed, you are right.

-- 
With Best Regards,
Andy Shevchenko



