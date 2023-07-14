Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7577D753394
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 09:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235464AbjGNHvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 03:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233722AbjGNHve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 03:51:34 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC65213F;
        Fri, 14 Jul 2023 00:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689321094; x=1720857094;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cmxZE3r+8v7kGkShku53lm2dagOvRA1bZuZRZS6YJQE=;
  b=n57g7i1LrrMaJ+uisfSDuM85vvPRGbPCVULYAT9gEYCV6nuKSKRPt4Vn
   ftznR37h8CnryBXsFXFwlKPX6ILQ4rcVWBULMXwsWIAI9nHNkicYkVbmD
   Ak4TDMQP95BpY4UhP5txvKaPk3dacywccdIJpGS0wSg4O6NqtbNb7z6/l
   tZ/GoNclhWK5WQJiUk2wl7DZPj0t11UsI26wxgdj90/J61tU1ruitNcLC
   R+jSOxre64rDK0K8BGY3GiKej5eSRlq8F+M92/XgH1GZlPahNNv+mS/qJ
   cL0q4on91OvNwm2KcDaW3jFUnUFVJrZPqPHClZmoRVZztX7XyLccpYBdI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="431587985"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="431587985"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 00:51:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="896326532"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="896326532"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.49.109])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 00:51:31 -0700
Message-ID: <a1d7dcce-99c4-7e6e-7041-749d16fe0c95@intel.com>
Date:   Fri, 14 Jul 2023 10:51:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH 26/58] mmc: f-sdh30: Convert to platform remove callback
 returning void
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230713080807.69999-1-frank.li@vivo.com>
 <20230713080807.69999-26-frank.li@vivo.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230713080807.69999-26-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/07/23 11:07, Yangtao Li wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is (mostly) ignored
> and this typically results in resource leaks. To improve here there is a
> quest to make the remove callback return void. In the first step of this
> quest all drivers are converted to .remove_new() which already returns
> void.
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Doesn't apply anymore.  You can check against the "next" branch in:

	git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git

> ---
>  drivers/mmc/host/sdhci_f_sdh30.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci_f_sdh30.c b/drivers/mmc/host/sdhci_f_sdh30.c
> index a202a69a4b08..6016e183c03c 100644
> --- a/drivers/mmc/host/sdhci_f_sdh30.c
> +++ b/drivers/mmc/host/sdhci_f_sdh30.c
> @@ -208,7 +208,7 @@ static int sdhci_f_sdh30_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> -static int sdhci_f_sdh30_remove(struct platform_device *pdev)
> +static void sdhci_f_sdh30_remove(struct platform_device *pdev)
>  {
>  	struct sdhci_host *host = platform_get_drvdata(pdev);
>  	struct f_sdhost_priv *priv = sdhci_priv(host);
> @@ -222,8 +222,6 @@ static int sdhci_f_sdh30_remove(struct platform_device *pdev)
>  
>  	sdhci_free_host(host);
>  	platform_set_drvdata(pdev, NULL);
> -
> -	return 0;
>  }
>  
>  #ifdef CONFIG_OF
> @@ -252,7 +250,7 @@ static struct platform_driver sdhci_f_sdh30_driver = {
>  		.pm	= &sdhci_pltfm_pmops,
>  	},
>  	.probe	= sdhci_f_sdh30_probe,
> -	.remove	= sdhci_f_sdh30_remove,
> +	.remove_new = sdhci_f_sdh30_remove,
>  };
>  
>  module_platform_driver(sdhci_f_sdh30_driver);

