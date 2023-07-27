Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C2D76556B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 15:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbjG0N5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 09:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbjG0N5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 09:57:05 -0400
Received: from mgamail.intel.com (unknown [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E53A2D7E;
        Thu, 27 Jul 2023 06:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690466225; x=1722002225;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xDBxuEmT97jGkXDFT4P+QdcK82UIjAQxMene2QdjLwU=;
  b=bFEg5UmwRA7w/aDMJjfYFQ3XyImZwXiUDfEny4TQP+ObXH7PS6ORLmnT
   I1qeZl6CHygHaSaVoLeZk1GW8Nx8NW2gaKhpm19hZXm8VdXuwoz0yYUyZ
   dzVKec/xz5v4yU8MyCuXrH06um8DFlU35bfMccC1aXXjCIDU8DjnosCEg
   oPr1X8KaiwuQZj+KvY8YbGU0panTIVbbkKeG8+TG3TJ5Dzr9c1wka9W4r
   +kISP33XYfMkqWbYsUlgKoPcWTxIFs7hjXU9yqcDn2JoSb7gErTR8GOpD
   f+RiaPvPciJEY8czzyAc1XuRvSbhPNUnGfGKaCeRGW2PPIUMK5H9sMyHL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="347929263"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; 
   d="scan'208";a="347929263"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 06:57:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="850835262"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; 
   d="scan'208";a="850835262"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.37.252])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 06:57:01 -0700
Message-ID: <ec463ccb-904e-3ccd-817a-48454d2d3419@intel.com>
Date:   Thu, 27 Jul 2023 16:56:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.1
Subject: Re: [PATCH v3 60/62] mmc: sdhci_am654: Convert to platform remove
 callback returning void
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230727070051.17778-1-frank.li@vivo.com>
 <20230727070051.17778-60-frank.li@vivo.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230727070051.17778-60-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/23 10:00, Yangtao Li wrote:
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

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci_am654.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index 1cc84739ef2f..c125485ba80e 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -866,7 +866,7 @@ static int sdhci_am654_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> -static int sdhci_am654_remove(struct platform_device *pdev)
> +static void sdhci_am654_remove(struct platform_device *pdev)
>  {
>  	struct sdhci_host *host = platform_get_drvdata(pdev);
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> @@ -882,7 +882,6 @@ static int sdhci_am654_remove(struct platform_device *pdev)
>  	pm_runtime_disable(dev);
>  	pm_runtime_put_noidle(dev);
>  	sdhci_pltfm_free(pdev);
> -	return 0;
>  }
>  
>  #ifdef CONFIG_PM
> @@ -994,7 +993,7 @@ static struct platform_driver sdhci_am654_driver = {
>  		.of_match_table = sdhci_am654_of_match,
>  	},
>  	.probe = sdhci_am654_probe,
> -	.remove = sdhci_am654_remove,
> +	.remove_new = sdhci_am654_remove,
>  };
>  
>  module_platform_driver(sdhci_am654_driver);

