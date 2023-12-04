Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6BDD803469
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbjLDNWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:22:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjLDNWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:22:23 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87AC895;
        Mon,  4 Dec 2023 05:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701696149; x=1733232149;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NYPKGC2pJ0ArIelYDLqnzlFWuyYkGLKzfqxiiz2YBUk=;
  b=lEPhtXh5Tt7OlLt6x4C7dQanMkA2Inf989xGOH2MuSteAyjmjIQEOLJo
   L9ZePuCO6G34i2vizqXxjcE2fxy+2iysNmUjjuyWF6ou0S3VL9GxGIQkm
   BDeTAkPUYhcdV2nhvzjpj0hrHnBbZJaBUVdfDV8OWzp22P2tKo7l+2/Mc
   UVlZKTWHyWW5QKPIfJVNH7Sw4mnvLTgpPSLjGBE40dVwi1Y9UBi3oAoHb
   yX2GFp/252umX5x46RalKkceLWfNwIIWRTSVV0fcJS5V7LnJdQSfs+7Ii
   RmCezbSacVSrxnYIV8Q/zOOUrHTwaSxxA18nT4eo0iQih8fWrxLzWM/GQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="580801"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="580801"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 05:22:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="894007072"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="894007072"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 05:22:27 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1rA8u0-00000001l3y-1M4F;
        Mon, 04 Dec 2023 15:22:24 +0200
Date:   Mon, 4 Dec 2023 15:22:24 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v3 10/10] gpiolib: remove gpiochip_is_requested()
Message-ID: <ZW3SkKp9KrXvaa2o@smile.fi.intel.com>
References: <20231204093509.19225-1-brgl@bgdev.pl>
 <20231204093509.19225-11-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204093509.19225-11-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 10:35:09AM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> We have no external users of gpiochip_is_requested(). Let's remove it
> and replace its internal calls with direct testing of the REQUESTED flag.

...

>  char *gpiochip_dup_line_label(struct gpio_chip *gc, unsigned int offset)
>  {
> -	const char *label;
> -	char *copy;
> +	struct gpio_desc *desc;
> +	char *label;
>  
> -	label = gpiochip_is_requested(gc, offset);
> -	if (!label)
> +	desc = gpiochip_get_desc(gc, offset);
> +	if (IS_ERR(desc))
>  		return NULL;
>  
> -	copy = kstrdup(label, GFP_KERNEL);
> -	if (!copy)
> +	guard(spinlock_irqsave)(&gpio_lock);
> +
> +	if (!test_bit(FLAG_REQUESTED, &desc->flags))
> +		return NULL;
> +
> +	label = kstrdup(desc->label, GFP_KERNEL);
> +	if (!label)
>  		return ERR_PTR(-ENOMEM);
>  
> -	return copy;
> +	return label;
>  }

My gosh, maybe we take better naming to reduce churn here?
Whatever, let's stop bikeshedding :-)

-- 
With Best Regards,
Andy Shevchenko


