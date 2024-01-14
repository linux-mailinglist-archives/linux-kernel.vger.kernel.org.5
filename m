Return-Path: <linux-kernel+bounces-25472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A84E482D0CC
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 15:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6943C1C20BC3
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 14:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C7C23BE;
	Sun, 14 Jan 2024 14:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JPZ2Nfb2"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B004C2100
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 14:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705241067; x=1736777067;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=J1JX0Cshhx0Q6weURgRkBspdhkjFTuCCerMLcXl0RyM=;
  b=JPZ2Nfb2LoFixMQTtDXJOIQct/gzgg0GKHYlwdBbbzSXXyER+IVivE6k
   DuRwPGTq4qJqIfOF8tLd9nl1C0Rrw+obq/hV507rFlsRoGLXo75gvlSrg
   pFWdxPg1ArAEMSTrgKsLrPnKQnGNIGXUZnP6c1ArEV1jYWsKR/EsrDhRv
   p8TWyM+QinLbR+BG5BGsILPnwK6GleoxptYqCRRWeknBWaadifBZdSkfS
   J9gRdXuUrN9uc3KS9bE5/FMG1xKnQmA9ZroBAbQhXxIS9H4cmuzkFHBkz
   9iWJCPebC+ws4qD24HBci8jjD51ip2qm6k4IhDG6WCteDjFhKR9ux2EXY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10952"; a="403230112"
X-IronPort-AV: E=Sophos;i="6.04,194,1695711600"; 
   d="scan'208";a="403230112"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2024 06:04:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10952"; a="873847960"
X-IronPort-AV: E=Sophos;i="6.04,194,1695711600"; 
   d="scan'208";a="873847960"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2024 06:04:23 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rP163-0000000DuEH-3ECH;
	Sun, 14 Jan 2024 16:04:19 +0200
Date: Sun, 14 Jan 2024 16:04:19 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Mark Hasemeyer <markhas@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Raul Rangel <rrangel@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>, David Gow <davidgow@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Takashi Iwai <tiwai@suse.de>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v4 23/24] platform: Modify platform_get_irq_optional() to
 use resource
Message-ID: <ZaPp4yVQ44J7HJB2@smile.fi.intel.com>
References: <20240102210820.2604667-1-markhas@chromium.org>
 <20240102140734.v4.23.Ife9ebad2bbfbab3a05e90040f344d750aa0aac7e@changeid>
 <ZZlp_YszbYTUFC1u@smile.fi.intel.com>
 <CANg-bXA1thAjWDeaJs8aO-SmTkgcjx8Cw0nWUHt+CGyCrB5tLA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANg-bXA1thAjWDeaJs8aO-SmTkgcjx8Cw0nWUHt+CGyCrB5tLA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Jan 08, 2024 at 12:09:10PM -0700, Mark Hasemeyer wrote:
> On Sat, Jan 6, 2024 at 7:56 AM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Tue, Jan 02, 2024 at 02:07:47PM -0700, Mark Hasemeyer wrote:

..

> > > +     ret = fwnode_irq_get_resource(fwnode, num, r);
> >
> > I still prefer this not to return positive value. Since you _require_ @r to be
> > not NULL, i.e. valid, the returning positive value makes no sense.
> >
> > > +     ret = ret < 0 ? ret : 0;
> > > +     if (!ret || ret == -EPROBE_DEFER)
> > > +             goto out;
> 
> I agree. But echoing my response from v3 patch 24:
> - The fwnode patch is already reviewed and approved.
> - The fwnode patch uses of_irq_to_resource() which already existed and
> returns the irq number on success. The error handling translation will
> just get pushed to the fwnode subsystem unless of_irq_to_resource() is
> also modified which means updating 8 or so drivers that reference it.
> 
> I can either:
> -Leave it
> -Modify the fwnode subsystem to perform the error translation of
> of_irq_to_resource()
> -Modify the fwnode and OF subsystems and update all driver references
> 
> The fwnode and OF patches are already reviewed. I imagine coding
> changes would imply dropping any Reviewed-by tags and requesting
> another review?
> I'd really prefer to not blow up the patch series anymore, but if you
> feel strongly, we can come up with a solution.

fwnode is quite generic API and I won't fail it from day 1.
Yet we have already some deviations in fwnode/device vs. OF/ACPI cases
(first comes to mind is device_for_each_child_node() which assumes
 "availability").

So, I would prefer fwnode API to not inherit issues/features of OF specific
code. Maybe this can be considered as "yes, please update it".

-- 
With Best Regards,
Andy Shevchenko



