Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271367DDCB6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 07:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344904AbjKAGfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 02:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233580AbjKAGfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 02:35:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3661AB;
        Tue, 31 Oct 2023 23:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698820524; x=1730356524;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fr5CjfNNJuWD21Gksvoo1SJ3ikp34hpSH4bN9RBZPGI=;
  b=jXBvqvzP5R8Bwql4XJOllTOso9Abva/iRfH80pIl/lEAjNgmU/RKitK8
   ZHzdhduEtFNc6A2aUa8RU4hfcAjFFtKOxM7jVY1qhRZvg88tPnslGDDXl
   Fri+FIm/IB1wNzgqQIk6Mtr9J3DjhxU/TovDCVRdmOAKRKjdIfNBkBxCG
   xrwUKLculPD0TQJETw7f0alnn0cmIXNOJXP4WKHPYEE1zW0FpNDjYhyPS
   9Aj50aNZsmXKFT9Dv3k1Zjxna0xyEIuoNXoAoIY8UKkoQ28RHxVnspHkM
   LxHwHOWdAZFvUNzibXAsEHD6EZhMKAmIMy6LbaKyOVKJs2PnWW2WMukW/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="474683706"
X-IronPort-AV: E=Sophos;i="6.03,267,1694761200"; 
   d="scan'208";a="474683706"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 23:35:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="826668267"
X-IronPort-AV: E=Sophos;i="6.03,267,1694761200"; 
   d="scan'208";a="826668267"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 31 Oct 2023 23:35:22 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id CF0D654A; Wed,  1 Nov 2023 08:35:20 +0200 (EET)
Date:   Wed, 1 Nov 2023 08:35:20 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Raag Jadav <raag.jadav@intel.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/1] pinctrl: tangier: Move default strength
 assignment to a switch-case
Message-ID: <20231101063520.GC17433@black.fi.intel.com>
References: <20231030155340.3468528-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231030155340.3468528-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 05:53:40PM +0200, Andy Shevchenko wrote:
> iWhen ->pin_config_set() is called from the GPIO library (assumed
> GpioIo() ACPI resource), the argument can be 1, when, for example,
> PullDefault is provided. In such case we supply sane default in
> the driver. Move that default assingment to a switch-case, so
> it will be consolidated in one place.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/pinctrl/intel/pinctrl-tangier.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pinctrl/intel/pinctrl-tangier.c b/drivers/pinctrl/intel/pinctrl-tangier.c
> index 007bca1cf224..26e34ec0a972 100644
> --- a/drivers/pinctrl/intel/pinctrl-tangier.c
> +++ b/drivers/pinctrl/intel/pinctrl-tangier.c
> @@ -368,14 +368,11 @@ static int tng_config_set_pin(struct tng_pinctrl *tp, unsigned int pin,
>  		break;
>  
>  	case PIN_CONFIG_BIAS_PULL_UP:
> -		/* Set default strength value in case none is given */
> -		if (arg == 1)
> -			arg = 20000;
> -
>  		switch (arg) {
>  		case 50000:
>  			term = BUFCFG_PUPD_VAL_50K;
>  			break;
> +		case 1: /* Set default strength value in case none is given */

The comment is good but I think would it make sense to have constant for
this instead?

>  		case 20000:
>  			term = BUFCFG_PUPD_VAL_20K;
>  			break;
> @@ -394,14 +391,11 @@ static int tng_config_set_pin(struct tng_pinctrl *tp, unsigned int pin,
>  		break;
>  
>  	case PIN_CONFIG_BIAS_PULL_DOWN:
> -		/* Set default strength value in case none is given */
> -		if (arg == 1)
> -			arg = 20000;
> -
>  		switch (arg) {
>  		case 50000:
>  			term = BUFCFG_PUPD_VAL_50K;
>  			break;
> +		case 1: /* Set default strength value in case none is given */
>  		case 20000:
>  			term = BUFCFG_PUPD_VAL_20K;
>  			break;
> -- 
> 2.40.0.1.gaa8946217a0b
