Return-Path: <linux-kernel+bounces-18609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30810825FFE
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 15:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 551D31C2150C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 14:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20697C130;
	Sat,  6 Jan 2024 14:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oCsn6TCE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0950FC12A
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 14:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704552966; x=1736088966;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dXTx/XeIcZvKEX0bwQ0/pKpd2DVP5McBkOgOXRxpbxk=;
  b=oCsn6TCE/N3Y8nsz9YQKjj4i2LXPDvQHLmashJDcB+kffTBajme9A6It
   gaK09X+4GxuxyrWhhFcbqxX569UTNLPzI1mfK2MlekgT0yfqGv+HWjVe8
   Dhe6GX+Fee0hO+mcSm4KFZ6X7HRwmIcQpYLpz/Qptl4xK8Lrpxg/ySQp1
   H7lBG3c6/H9+bjOYgAybvRcKsXDz7Eyvwb9njrN1vV3VIOWUyjNhyUzf/
   uT4vxOGMdf9kpz1umTpxYpWR0SHSivIJLP2hxZvSKGSeyxOMxkoEukyJp
   U7PqyKRLWMYdgVg480GG1EIE8XmQVG6etor26cLN7G1+3vhXqV6gvuvty
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="4429270"
X-IronPort-AV: E=Sophos;i="6.04,337,1695711600"; 
   d="scan'208";a="4429270"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2024 06:56:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="1028013610"
X-IronPort-AV: E=Sophos;i="6.04,337,1695711600"; 
   d="scan'208";a="1028013610"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2024 06:56:00 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rM85d-0000000BvzY-1nd5;
	Sat, 06 Jan 2024 16:55:57 +0200
Date: Sat, 6 Jan 2024 16:55:57 +0200
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
Message-ID: <ZZlp_YszbYTUFC1u@smile.fi.intel.com>
References: <20240102210820.2604667-1-markhas@chromium.org>
 <20240102140734.v4.23.Ife9ebad2bbfbab3a05e90040f344d750aa0aac7e@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102140734.v4.23.Ife9ebad2bbfbab3a05e90040f344d750aa0aac7e@changeid>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Jan 02, 2024 at 02:07:47PM -0700, Mark Hasemeyer wrote:
> Unify handling of ACPI, GPIO, devictree, and platform resource
> interrupts in platform_get_irq_optional(). Each of these subsystems
> provide their own APIs which provide IRQ information as a struct
> resource. This simplifies the logic of the function and allows callers
> to get more information about the IRQ by looking at the resource flags.
> For example, whether or not an IRQ is wake capable.

...

> +	ret = fwnode_irq_get_resource(fwnode, num, r);

I still prefer this not to return positive value. Since you _require_ @r to be
not NULL, i.e. valid, the returning positive value makes no sense.

> +	ret = ret < 0 ? ret : 0;
> +	if (!ret || ret == -EPROBE_DEFER)
> +		goto out;

...

> +	struct resource *platform_res = platform_get_resource(dev, IORESOURCE_IRQ, num);

Same comment, please split definition and assignment.

-- 
With Best Regards,
Andy Shevchenko



