Return-Path: <linux-kernel+bounces-18594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D301825FD4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 15:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2DA1B22096
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 14:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA4C8485;
	Sat,  6 Jan 2024 14:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fBU+SB2N"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3762C847B
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 14:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704550714; x=1736086714;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IZCz/MZA6E72BOm/MHR3k5Pv0uD88Tp+9lsZbl+gfxE=;
  b=fBU+SB2NBr1tdqCcUwOsk+6L5l5BGvOP78Vx/U4+reWKnXzobxUWmOKg
   O34iLDPlOtAj9HtZbcbqav0C+ViTa3Dbbzk6lklAyu4DclZhZhdg0Hso1
   Z0sBwfDb1bzclkCqpYUmhEbwjBqXL0MWOupC7p5iiaffLc/y3QDKSnDoR
   4ao4akMu4Dd20n0nAIMYvUAlJKfTkV/+m5GuoWcVcVQgJi7hyw5LtXG0r
   4pc2F2Hn5meexpU+L+OoVX2ASJvVUKeOe9qQ3k4qYPoS7isMRUZ6u6xQh
   KWWdHZZ5RcwebekPgBTMV1JBMsdI/U4SS7K3My8E3EL9mqRyyHXlYI60f
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="16266400"
X-IronPort-AV: E=Sophos;i="6.04,337,1695711600"; 
   d="scan'208";a="16266400"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2024 06:18:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="954223935"
X-IronPort-AV: E=Sophos;i="6.04,337,1695711600"; 
   d="scan'208";a="954223935"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2024 06:18:28 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rM7MG-0000000BvMv-1HXB;
	Sat, 06 Jan 2024 16:09:04 +0200
Date: Sat, 6 Jan 2024 16:09:04 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Hasemeyer <markhas@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Raul Rangel <rrangel@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>, David Gow <davidgow@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Takashi Iwai <tiwai@suse.de>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v3 23/24] platform: Modify platform_get_irq_optional() to
 use resource
Message-ID: <ZZlfADa5_-NnK4UI@smile.fi.intel.com>
References: <20231226192149.1830592-1-markhas@chromium.org>
 <20231226122113.v3.23.Ife9ebad2bbfbab3a05e90040f344d750aa0aac7e@changeid>
 <ZYxfLjCzjnocKaTo@smile.fi.intel.com>
 <CANg-bXAPrhS9iYASSSXFJguYEvejL_NcgMCWCHU=6mvP9AstLA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANg-bXAPrhS9iYASSSXFJguYEvejL_NcgMCWCHU=6mvP9AstLA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Dec 27, 2023 at 01:33:14PM -0700, Mark Hasemeyer wrote:
> > > -     struct resource *r;
> >         ...
> > > +     struct resource *platform_res = platform_get_resource(dev, IORESOURCE_IRQ, num);
> >
> > This is quite unusual (as far as cleanup.h is not used and there is no place
> > for it here).
> 
> Sorry, what's unusual? The declaration of a separate 'platform_res'?
> If so, I introduced it because I wanted to avoid setting 'r' if
> 'irq_get_irq_data()' fails below.

Defining the variable in the depth of the code.
There are exceptions, but usually we follow the style that definitions are
grouped at the top of the {} scope(s).


-- 
With Best Regards,
Andy Shevchenko



