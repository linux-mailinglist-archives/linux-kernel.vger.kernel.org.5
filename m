Return-Path: <linux-kernel+bounces-12175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B41D481F0EE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 18:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBE1D1C219B3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 17:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4635C4652B;
	Wed, 27 Dec 2023 17:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ChGeEBvx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D8A46522
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 17:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703698507; x=1735234507;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xgw6Rx1xyiu9/c4fqxAyWEIp8q2MXXE0eNzx2fpq55Q=;
  b=ChGeEBvxgrXzqyiRzZLFCTmhek0sRxg4jmILlzEWaJAxBBj9gXpeI8yi
   apgHwfXuFSS38Ds89j1HldS3BMAlCr8J5IRT6bP+4c6XJVvCRT1skNSFi
   Pt2EFvA+Ps/k7Ajs5bvd8t8zWEVj4ukRUZCvR6M/y/RDBtqPiWfJ30xBm
   BMbmFeLBisYWgrYhulG06/kdQs9gSl14UBsY+xEHJftRV695mW/y8ki3m
   C8VP7vbvFAIiNV7Gqklz1/y9ias5wJZREa6jXGAFW8lbFR6mspW5ZQYIu
   dhh3QXxSOsfEwQ+vJ7fh0F2AhO7UceRrwdDYcIUeSJZz+0IVLfPRbPjL2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="399256031"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="399256031"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 09:35:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="921884517"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="921884517"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 09:35:02 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rIXo3-00000009Tbk-0hcN;
	Wed, 27 Dec 2023 19:34:59 +0200
Date: Wed, 27 Dec 2023 19:34:58 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Mark Hasemeyer <markhas@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Raul Rangel <rrangel@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Bhanu Prakash Maiya <bhanumaiya@chromium.org>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Guenter Roeck <groeck@chromium.org>, Lee Jones <lee@kernel.org>,
	Prashant Malani <pmalani@chromium.org>,
	Rob Barnes <robbarnes@google.com>,
	Stephen Boyd <swboyd@chromium.org>, chrome-platform@lists.linux.dev
Subject: Re: [PATCH v3 24/24] platform/chrome: cros_ec: Use PM subsystem to
 manage wakeirq
Message-ID: <ZYxgQn8L7ENkc0AJ@smile.fi.intel.com>
References: <20231226192149.1830592-1-markhas@chromium.org>
 <20231226122113.v3.24.Ieee574a0e94fbaae01fd6883ffe2ceeb98d7df28@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231226122113.v3.24.Ieee574a0e94fbaae01fd6883ffe2ceeb98d7df28@changeid>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Dec 26, 2023 at 12:21:28PM -0700, Mark Hasemeyer wrote:
> The cros ec driver is manually managing the wake IRQ by calling
> enable_irq_wake()/disable_irq_wake() during suspend/resume.
> 
> Modify the driver to use the power management subsystem to manage the
> wakeirq.
> 
> Rather than assuming that the IRQ is wake capable, use the underlying
> firmware/device tree to determine whether or not to enable it as a wake
> source. Some Chromebooks rely solely on the ec_sync pin to wake the AP
> but do not specify the interrupt as wake capable in the ACPI _CRS. For
> LPC/ACPI based systems a DMI quirk is introduced listing boards whose
> firmware should not be trusted to provide correct wake capable values.
> For device tree base systems, it is not an issue as the relevant device
> tree entries have been updated and DTS is built from source for each
> ChromeOS update.

...

>  	acpi_status status;
>  	struct cros_ec_device *ec_dev;
> +	struct resource irqres;

	struct resource irqres = {};

?

>  	u8 buf[2] = {};
>  	int irq, ret;

...

> -	irq = platform_get_irq_optional(pdev, 0);
> -	if (irq > 0)
> +	irq = platform_get_irq_resource_optional(pdev, 0, &irqres);
> +	if (irq > 0) {
>  		ec_dev->irq = irq;
> -	else if (irq != -ENXIO) {
> +		if (should_force_irq_wake_capable())
> +			ec_dev->irq_wake = true;
> +		else
> +			ec_dev->irq_wake = irqres.flags & IORESOURCE_IRQ_WAKECAPABLE;
> +	} else if (irq != -ENXIO) {
>  		dev_err(dev, "couldn't retrieve IRQ number (%d)\n", irq);
>  		return irq;
>  	}

Still I do not like ambiguity behind irq > 0 vs. irqres.start.

For this, and if needed others, return plain error.
Seems I gave the tag for the previous patch, consider
that tag conditional (it seems I missed this).

...

>  	u16 proto_version;
>  	void *priv;
>  	int irq;
> +	bool irq_wake;
>  	u8 *din;
>  	u8 *dout;
>  	int din_size;
>  	int dout_size;
> -	bool wake_enabled;
>  	bool suspended;
>  	int (*cmd_xfer)(struct cros_ec_device *ec,
>  			struct cros_ec_command *msg);

Have you run pahole on this (before and after)?

-- 
With Best Regards,
Andy Shevchenko



