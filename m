Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7242765569
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 15:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbjG0N4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 09:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbjG0N4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 09:56:46 -0400
Received: from mgamail.intel.com (unknown [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102F62D7E;
        Thu, 27 Jul 2023 06:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690466205; x=1722002205;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gbtgp8Hyb72ND8UPiEC/bB0KsvSvo7b2AMpln79bkuw=;
  b=KU46MLP5t/TMnazmTT3iq5ry47h45OF2xQagC9nD/fePSV5ZAHrx5/NW
   +9TI8lbPNxoDEGBnxGrNWu9pQj2wx32TFklD96pI5GAxELFiaymfsvfng
   u++IRXX9P3oCQo3a3nRHJkmCf48vV9TTEW2HjDaYmG9GcHh5ubysosHUm
   1TNqwg+9dFxYUSJRCKnG67M/5s2V+4kHGwzkV+0OCOidy4bbxkgdIICre
   LEhy+wAGdwl+R4ne7PChGfTkgZO7fCEuCG8wdOjieJIUonX7q4Gm3HvYK
   pf7kiY2Hmk4hN5KfkONM9RexnLXPnxt1fVEaFP89CbWqqECeDZP9Cucg6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="348592316"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; 
   d="scan'208";a="348592316"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 06:56:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="973574620"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; 
   d="scan'208";a="973574620"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.37.252])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 06:56:43 -0700
Message-ID: <f47dcc9f-408d-baf3-a08e-e2d02014b61e@intel.com>
Date:   Thu, 27 Jul 2023 16:56:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.1
Subject: Re: [PATCH v3 59/62] mmc: sdhci_am654: Properly handle failures in
 .remove()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230727070051.17778-1-frank.li@vivo.com>
 <20230727070051.17778-59-frank.li@vivo.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230727070051.17778-59-frank.li@vivo.com>
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
> Returning an error code in a platform driver's remove function is wrong
> most of the time and there is an effort to make the callback return
> void. To prepare this rework the function not to exit early.
> 
> Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci_am654.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index 7cdf0f54e3a5..1cc84739ef2f 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -870,16 +870,17 @@ static int sdhci_am654_remove(struct platform_device *pdev)
>  {
>  	struct sdhci_host *host = platform_get_drvdata(pdev);
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct device *dev = &pdev->dev;
>  	int ret;
>  
> -	ret = pm_runtime_resume_and_get(&pdev->dev);
> +	ret = pm_runtime_get_sync(dev);
>  	if (ret < 0)
> -		return ret;
> +		dev_err(dev, "pm_runtime_get_sync() Failed\n");
>  
>  	sdhci_remove_host(host, true);
>  	clk_disable_unprepare(pltfm_host->clk);
> -	pm_runtime_disable(&pdev->dev);
> -	pm_runtime_put_noidle(&pdev->dev);
> +	pm_runtime_disable(dev);
> +	pm_runtime_put_noidle(dev);
>  	sdhci_pltfm_free(pdev);
>  	return 0;
>  }

