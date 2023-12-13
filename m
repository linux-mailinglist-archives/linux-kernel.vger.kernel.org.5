Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2596B811F78
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233881AbjLMTxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233828AbjLMTwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:52:53 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910C51BF0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702497140; x=1734033140;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T5TJvwnwRi0i08EIKJLpAwpErmJA30NCJuJR7D9Z3MU=;
  b=i5yNLO3qHb20Uh667fZ3xb0cgVBfOMsgA3baXEy85IvEvua1KZcuH2Lu
   gD+MQIRExeDjGGnl78JxDKz5vYhSAnywn9Mdnd6XduvpxmaRDSEnDJhqO
   O3AN+wQ51aNElDwLjM1ZfegaF4SUV6Z48FQl62enlkGRqk4fAyCvTMMZ6
   N0umm/TxW9Cxi6oyxqRNxTp9TtLL7S3x1ZvoSFrPwCY4ER2xGpkqDONCq
   9eTENiTvxLYQQUa0W/H/jids1zm+1oG9NB1cTUiJAqa1DoxIb124lOncg
   LgncuSHdAdvY7SMHYewWDYeLImploA1S+2zSNnjUl2S8uOwAZPvpkQSGh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="380005499"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="380005499"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 11:52:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="897450435"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="897450435"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 11:52:17 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1rDVHC-00000005d7Q-1HZz;
        Wed, 13 Dec 2023 21:52:14 +0200
Date:   Wed, 13 Dec 2023 21:52:14 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Mark Hasemeyer <markhas@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Raul Rangel <rrangel@chromium.org>,
        David Gow <davidgow@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Takashi Iwai <tiwai@suse.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v1 5/6] platform: Modify platform_get_irq_optional() to
 use resource
Message-ID: <ZXoLbt7jNrmC0VbQ@smile.fi.intel.com>
References: <20231213110009.v1.1.Ifd0903f1c351e84376d71dbdadbd43931197f5ea@changeid>
 <20231213110009.v1.5.Ife9ebad2bbfbab3a05e90040f344d750aa0aac7e@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213110009.v1.5.Ife9ebad2bbfbab3a05e90040f344d750aa0aac7e@changeid>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 11:00:23AM -0700, Mark Hasemeyer wrote:
> Unify handling of ACPI, GPIO, devictree, and platform resource
> interrupts in platform_get_irq_optional(). Each of these subsystems
> provide their own apis which provide IRQ information as a struct
> resource. This simplifies the logic of the function and allows callers
> to get more information about the irq by looking at the resource flags.

IRQ

> For example, whether or not an irq is wake capable.

IRQ

> Rename the function to platform_get_irq_resource() to better describe
> the function's new behavior.

...

> - * platform_get_irq_optional - get an optional IRQ for a device
> + * platform_get_irq_resource - get an IRQ for a device and populate resource struct
>   * @dev: platform device
>   * @num: IRQ number index
> + * @r: pointer to resource to populate with irq information. It is not modified on failure.

IRQ

It's inconsistent with just a few lines above!

Also same comment about second remark, no need to have it. It's implied.

...

> +		*r = (struct resource)DEFINE_RES_IRQ(ret);

Why is the annotation needed?

...

> -	struct resource *r;
> +	struct resource *platform_res;
>  
>  	if (IS_ENABLED(CONFIG_OF_IRQ) && dev->dev.of_node) {
> -		ret = of_irq_get(dev->dev.of_node, num);
> +		ret = of_irq_to_resource(dev->dev.of_node, num, r);
>  		if (ret > 0 || ret == -EPROBE_DEFER)
>  			goto out;
>  	}


> +	if (has_acpi_companion(&dev->dev)) {
> +		ret = acpi_irq_get(ACPI_HANDLE(&dev->dev), num, r);
> +		if (!ret || ret == -EPROBE_DEFER) {
> +			ret = ret ?: r->start;
> +			goto out;
> +		}
> +	}

Consider combine the above to use fwnode_irq_get() in the separate prerequisite
change.

...

> +	/*
> +	 * The resources may pass trigger flags to the irqs that need
> +	 * to be set up. It so happens that the trigger flags for
> +	 * IORESOURCE_BITS correspond 1-to-1 to the IRQF_TRIGGER*
> +	 * settings.
> +	 */
> +	if (ret > 0 && r->flags & IORESOURCE_BITS) {
> +		struct irq_data *irqd;

> +		irqd = irq_get_irq_data(r->start);
> +		if (!irqd)
> +			ret = -ENXIO;

> +		else

Redundant.

Just return directly from the above.

> +			irqd_set_trigger_type(irqd, r->flags & IORESOURCE_BITS);

NIH resource_type().

> +	}
>  	return ret;

...

What you need to add to all the functions is either
- check that resource pointer is not NULL, and/or
- documentation that explain this requirement or mark it optional
  (but second seems nonsense)

-- 
With Best Regards,
Andy Shevchenko


