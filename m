Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72DAB7DDCCE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 07:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345167AbjKAGnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 02:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbjKAGnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 02:43:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1672DA;
        Tue, 31 Oct 2023 23:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698820984; x=1730356984;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nAwPIoJmuW9RyohaWpXq+Jn0IoGknEJRHHmxWEMdOMc=;
  b=WXTaCptifnz6muoQ82xTXEF1wRthFzZfm1DBNBBBIG+7OwBZV4W6HJZv
   EKMUSOE/cTjGCzqkbaaP+4s0Gr869BrTgtoBm7tr0wnU045zkM1AB5RkH
   /Au+aOtHXMFIUd2pgbXnVboDNs7JPBtwNbIrmy8LUe1lLOy4fvFFzzWtA
   pawotHwPfxCPDmfak2bdk1fSNGttpCvGC3bocC/9Az6h3emvd/M5bPlYQ
   bdQVmC+YWiKGTpFSa2i9CZxriRcPsaJzBNLEjif+4lc2ZGa4/izf2rtHG
   zL/U6b12cxrafxgjZfwdeD9rMxUDblBwfhau9qZly5NnWTNCSzmEev7ku
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="452731710"
X-IronPort-AV: E=Sophos;i="6.03,267,1694761200"; 
   d="scan'208";a="452731710"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 23:43:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="831270920"
X-IronPort-AV: E=Sophos;i="6.03,267,1694761200"; 
   d="scan'208";a="831270920"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 31 Oct 2023 23:43:00 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 922F554A; Wed,  1 Nov 2023 08:35:48 +0200 (EET)
Date:   Wed, 1 Nov 2023 08:35:48 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/1] pinctrl: intel: Move default strength assignment
 to a switch-case
Message-ID: <20231101063548.GD17433@black.fi.intel.com>
References: <20231030155432.3468704-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231030155432.3468704-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 05:54:32PM +0200, Andy Shevchenko wrote:
> iWhen ->pin_config_set() is called from the GPIO library (assumed
> GpioIo() ACPI resource), the argument can be 1, when, for example,
> PullDefault is provided. In such case we supply sane default in
> the driver. Move that default assingment to a switch-case, so
> it will be consolidated in one place.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/pinctrl/intel/pinctrl-intel.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
> index fb3e0e1e0a0e..3e8010607d32 100644
> --- a/drivers/pinctrl/intel/pinctrl-intel.c
> +++ b/drivers/pinctrl/intel/pinctrl-intel.c
> @@ -677,10 +677,6 @@ static int intel_config_set_pull(struct intel_pinctrl *pctrl, unsigned int pin,
>  	u32 term = 0, up = 0, value;
>  	void __iomem *padcfg1;
>  
> -	/* Set default strength value in case none is given */
> -	if (arg == 1)
> -		arg = 5000;
> -
>  	switch (param) {
>  	case PIN_CONFIG_BIAS_DISABLE:
>  		break;
> @@ -690,6 +686,7 @@ static int intel_config_set_pull(struct intel_pinctrl *pctrl, unsigned int pin,
>  		case 20000:
>  			term = PADCFG1_TERM_20K;
>  			break;
> +		case 1: /* Set default strength value in case none is given */

Same comment here about constant.

>  		case 5000:
>  			term = PADCFG1_TERM_5K;
>  			break;
> @@ -716,6 +713,7 @@ static int intel_config_set_pull(struct intel_pinctrl *pctrl, unsigned int pin,
>  		case 20000:
>  			term = PADCFG1_TERM_20K;
>  			break;
> +		case 1: /* Set default strength value in case none is given */
>  		case 5000:
>  			term = PADCFG1_TERM_5K;
>  			break;
> -- 
> 2.40.0.1.gaa8946217a0b
