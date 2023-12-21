Return-Path: <linux-kernel+bounces-8670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6DB81BADA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCBB81C25CD0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98F0539E8;
	Thu, 21 Dec 2023 15:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m7OGigql"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E3E4F20E
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 15:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703172810; x=1734708810;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=07hUfGUIx0uwi7/AroMY4/6/uai4cqC7xYxtzX65ES8=;
  b=m7OGigql41WBeW7YXLEnIhB8JwFdHzSTa1OwxK5oakLove1Nu6W57jy8
   y7lHgxD1Brt+9otLvmWb9T97ndqQQrT2kGiQmTJh3rtvTB2doas+dl6Wx
   jFP1J4icroRYiR1hEkUC/rks3yZCIMjpJqNGk/QGRJEgtApeXQWOVpRfL
   kwa4GRRQCNxEaNYRrLv71G6ES//mXu01Oj4nD1CxHGFEy1n9lTv9gykVi
   YpkzgY+mSNx7ySKuvrdhHIhoFEyjS8gM6AM0Xg9eCUl6EjAB1nR5Ah1hm
   RtGkfScSzNEswMua0D9DLr4DI18gcroEO795sQOqvIijfO52gW3kXKWx5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="3225076"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="3225076"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 07:33:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="810997447"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="810997447"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 07:33:24 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rGL33-00000007spv-1eGB;
	Thu, 21 Dec 2023 17:33:21 +0200
Date: Thu, 21 Dec 2023 17:33:20 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Mark Hasemeyer <markhas@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Raul Rangel <rrangel@chromium.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
	David Gow <davidgow@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Takashi Iwai <tiwai@suse.de>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 21/22] platform: Modify platform_get_irq_optional() to
 use resource
Message-ID: <ZYRawMwhtimA-rkD@smile.fi.intel.com>
References: <20231220235459.2965548-1-markhas@chromium.org>
 <20231220165423.v2.21.Ife9ebad2bbfbab3a05e90040f344d750aa0aac7e@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220165423.v2.21.Ife9ebad2bbfbab3a05e90040f344d750aa0aac7e@changeid>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Dec 20, 2023 at 04:54:35PM -0700, Mark Hasemeyer wrote:
> Unify handling of ACPI, GPIO, devictree, and platform resource
> interrupts in platform_get_irq_optional(). Each of these subsystems
> provide their own APIs which provide IRQ information as a struct
> resource. This simplifies the logic of the function and allows callers
> to get more information about the IRQ by looking at the resource flags.
> For example, whether or not an IRQ is wake capable.

...

>   * For example::
>   *
> - *		int irq = platform_get_irq_optional(pdev, 0);
> + *		int irq = platform_get_irq_resource_optional(pdev, 0, &res);
>   *		if (irq < 0)
>   *			return irq;
>   *
>   * Return: non-zero IRQ number on success, negative error number on failure.

Why do we need the irq to be returned via error code?

...

>  	int ret;

Missing blank line, have you run checkpatch.pl?

> +	if (IS_ERR_OR_NULL(r))
> +		return -EINVAL;

If we ever have an error pointer in r, I prefer to see

	if (!r)
		return -EINVAL;
	if (IS_ERR(r))
		return PTR_ERR(r);

But Q is the same as earlier: when would we have the error pointer in @r?

...

> +	platform_res = platform_get_resource(dev, IORESOURCE_IRQ, num);

I would move this closer to the condition...

>  	/*
>  	 * The resources may pass trigger flags to the irqs that need
>  	 * to be set up. It so happens that the trigger flags for
>  	 * IORESOURCE_BITS correspond 1-to-1 to the IRQF_TRIGGER*
>  	 * settings.
>  	 */

...i.e. here.

> -	if (r && r->flags & IORESOURCE_BITS) {
> +	if (platform_res && platform_res->flags & IORESOURCE_BITS) {

>  	}

...

>  	if (num == 0 && is_acpi_device_node(fwnode)) {
> -		ret = acpi_dev_gpio_irq_get(to_acpi_device_node(fwnode), num);
> +		ret = acpi_dev_get_gpio_irq_resource(to_acpi_device_node(fwnode), NULL, num, r);
>  		/* Our callers expect -ENXIO for missing IRQs. */

> -		if (ret >= 0 || ret == -EPROBE_DEFER)
> +		if (!ret || ret == -EPROBE_DEFER) {

Can we save this and be consistent with above fwnode API return code check?

> +			ret = ret ?: r->start;
>  			goto out;
> +		}
>  	}

...

> -EXPORT_SYMBOL_GPL(platform_get_irq_optional);
> +EXPORT_SYMBOL_GPL(platform_get_irq_resource_optional);
> +

Stray blank line change.

...

>  EXPORT_SYMBOL_GPL(platform_get_irq);
>  
> +

Ditto.

...

> +int platform_get_irq_optional(struct platform_device *dev, unsigned int num)
> +{
> +	struct resource r;

	struct resource r = {};

?

> +	return platform_get_irq_resource_optional(dev, num, &r);
> +}

-- 
With Best Regards,
Andy Shevchenko



