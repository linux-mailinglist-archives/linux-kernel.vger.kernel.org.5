Return-Path: <linux-kernel+bounces-12173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1A081F0EB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 18:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBF7E282AAC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 17:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFE746528;
	Wed, 27 Dec 2023 17:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ShnHw3GT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8DE46459
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 17:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703698247; x=1735234247;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Wy1NLuZqdOXqhCmFW7iRCfp2r7W8SPwyReyYcr2ms80=;
  b=ShnHw3GTZ0YksRj4uRquwwyLlntG31nJmbQ9PUaTjIpI/ialQGGDwH94
   iwMmMqy1cx56zW5ND7G/rf7b8Q4WDB3VSLEp5QVGyP0aPPclrb22cPJ3v
   R/ZLQIn+MyeEa5D7nzkkRvmHfkC6JDphRKqc40N18df296nAez+YIleRK
   U41wqrEz9dmS3IzIxJPET2UNLRAeclrzvUEbRytqtvxVQqiFfeeQHHhaG
   Tw9BPEaODy/qYmwrs47HUQachexZuScJ9QYlpuVx60YqG+tThShAvENvg
   AUP0HHu4s98NiJMf19Soo4EPe/1gKu6hOr+5nqhTM8FpGRlkLe9e9yOmQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="393618408"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="393618408"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 09:30:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="1109690141"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="1109690141"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 09:30:26 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rIXjb-00000009TYB-0ZHy;
	Wed, 27 Dec 2023 19:30:23 +0200
Date: Wed, 27 Dec 2023 19:30:22 +0200
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
Message-ID: <ZYxfLjCzjnocKaTo@smile.fi.intel.com>
References: <20231226192149.1830592-1-markhas@chromium.org>
 <20231226122113.v3.23.Ife9ebad2bbfbab3a05e90040f344d750aa0aac7e@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231226122113.v3.23.Ife9ebad2bbfbab3a05e90040f344d750aa0aac7e@changeid>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Dec 26, 2023 at 12:21:27PM -0700, Mark Hasemeyer wrote:
> Unify handling of ACPI, GPIO, devictree, and platform resource
> interrupts in platform_get_irq_optional(). Each of these subsystems
> provide their own APIs which provide IRQ information as a struct
> resource. This simplifies the logic of the function and allows callers
> to get more information about the IRQ by looking at the resource flags.
> For example, whether or not an IRQ is wake capable.

...

> -	struct resource *r;
	...
> +	struct resource *platform_res = platform_get_resource(dev, IORESOURCE_IRQ, num);

This is quite unusual (as far as cleanup.h is not used and there is no place
for it here).

> +

Unneeded blank line after fixing the above.

> +	if (platform_res && platform_res->flags & IORESOURCE_BITS) {
>  		struct irq_data *irqd;

Otherwise LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>


-- 
With Best Regards,
Andy Shevchenko



