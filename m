Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C227EC124
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 12:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343577AbjKOLOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 06:14:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234885AbjKOLOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 06:14:45 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56EA0E6;
        Wed, 15 Nov 2023 03:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700046882; x=1731582882;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WQgxSSG423XRPERiwlT6QFzhckBWPkr0uzAzYrsVN3U=;
  b=nJKy6Uz+S/F5isMV6aK/410uSEEUuzr7uDLitJ06djaSSu+EMvq+5/ZS
   IqWUwvM1XP/P+gQKtqj7Y+sMMAq049wAOCZO8WFDgyOG2VQTUCTExk1Td
   ZeIbDxnIBhIV0FK4hBVzxgIYk6V/HlpNi9etW5F7EvHcPrMSI040GjitF
   kX4PLKriAEZvrLvzTVMGn7u2hhjp6g4IuG9JwcOn0IHniZk6nmS1fB/sK
   kkVP2c5a5/h6X3e5Qzgi1IQYeLiu2no8wTE+sI9IXgNOfJGogxjJEc4s1
   uOVq8SB0FwQ1PK4kp5hg7IYGXzhnNOT7NXbfq7cUrQ2b1/GrpWm9RA7wC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="390654631"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; 
   d="scan'208";a="390654631"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 03:14:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="741408395"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; 
   d="scan'208";a="741408395"
Received: from mylly.fi.intel.com (HELO [10.237.72.161]) ([10.237.72.161])
  by orsmga006.jf.intel.com with ESMTP; 15 Nov 2023 03:14:37 -0800
Message-ID: <e299ee44-7de1-4542-828d-a0c86b217fb4@linux.intel.com>
Date:   Wed, 15 Nov 2023 13:14:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/25] i2c: designware: Fix PM calls order in
 dw_i2c_plat_probe()
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jan Dabros <jsd@semihalf.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Hans de Goede <hdegoede@redhat.com>
References: <20231110182304.3894319-1-andriy.shevchenko@linux.intel.com>
 <20231110182304.3894319-3-andriy.shevchenko@linux.intel.com>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
In-Reply-To: <20231110182304.3894319-3-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/23 20:11, Andy Shevchenko wrote:
> We should not mix managed calls with non-managed. This will break
> the calls order at the error path and ->remove() stages. Fix this
> by wrapping PM ops to become managed one.
> 
> Fixes: 36d48fb5766a ("i2c: designware-platdrv: enable RuntimePM before registering to the core")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I fail to see what was broken in above commit and how this patch fixes it?

> ---
>   drivers/i2c/busses/i2c-designware-platdrv.c | 28 ++++++++++++---------
>   1 file changed, 16 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
> index 855b698e99c0..8b0099e1bc26 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -177,14 +177,26 @@ static int txgbe_i2c_request_regs(struct dw_i2c_dev *dev)
>   	return 0;
>   }
>   
> -static void dw_i2c_plat_pm_cleanup(struct dw_i2c_dev *dev)
> +static void dw_i2c_plat_pm_cleanup(void *data)
>   {
> +	struct dw_i2c_dev *dev = data;
> +
>   	pm_runtime_disable(dev->dev);
>   
>   	if (dev->shared_with_punit)
>   		pm_runtime_put_noidle(dev->dev);
>   }
>   
> +static int dw_i2c_plat_pm_setup(struct dw_i2c_dev *dev)
> +{
> +	if (dev->shared_with_punit)
> +		pm_runtime_get_noresume(dev->dev);
> +
> +	pm_runtime_enable(dev->dev);
> +
> +	return devm_add_action_or_reset(dev->dev, dw_i2c_plat_pm_cleanup, dev);
> +}
> +
>   static int dw_i2c_plat_request_regs(struct dw_i2c_dev *dev)
>   {
>   	struct platform_device *pdev = to_platform_device(dev->dev);
> @@ -381,19 +393,12 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
>   	pm_runtime_use_autosuspend(&pdev->dev);
>   	pm_runtime_set_active(&pdev->dev);
>   
> -	if (dev->shared_with_punit)
> -		pm_runtime_get_noresume(&pdev->dev);
> -
> -	pm_runtime_enable(&pdev->dev);
> -
> -	ret = i2c_dw_probe(dev);
> +	ret = dw_i2c_plat_pm_setup(dev);
>   	if (ret)
> -		goto exit_probe;
> +		goto exit_reset;
>   
> -	return ret;
> +	return i2c_dw_probe(dev);
>   
> -exit_probe:
> -	dw_i2c_plat_pm_cleanup(dev);
>   exit_reset:
>   	reset_control_assert(dev->rst);
>   	return ret;

Is it intended change the reset isn't asserted after this patch in case 
i2c_dw_probe() fails?
