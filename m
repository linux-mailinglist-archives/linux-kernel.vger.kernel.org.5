Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5352B765567
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 15:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbjG0Nzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 09:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbjG0Nzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 09:55:49 -0400
Received: from mgamail.intel.com (unknown [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFD130CD;
        Thu, 27 Jul 2023 06:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690466139; x=1722002139;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6GGb97b/A0230i5HJ/7/pyyHsonfnW2KVsnlAov1NPc=;
  b=KwF0gdDMovOevo6Wkb6i4Wk5jfpRHSpvzWSmxXdr7xuzijHmWyRWnRNE
   Ply58ns+lhv1/BX8DPLY7CJMz/7riEt0OaVXNoG2gEvk7RIQVWrIDwVrF
   tLoDfysjKRhFYWfCNpjoZmaL8kDYJ58qt0X36xv6jOKR1225vbg4GV/4N
   kZUHN86goYLp5l7/gyjKULOHDKKx++kbLvhcPUBF+LhkonK8KPOspZvBD
   esiCsX55gO8iGorX/1Y1JH+84yuibN19R9imHiN1csKKfvHvZhgWt7T17
   zIrflJagQa/8YDGER7699ezK6Ym8ibkLICREbpdsEo2ng/3qZpNaZd6E3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="348592124"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; 
   d="scan'208";a="348592124"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 06:55:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="973573668"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; 
   d="scan'208";a="973573668"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.37.252])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 06:55:37 -0700
Message-ID: <90febfa5-b520-05f5-53ca-af0e1f3fc7c4@intel.com>
Date:   Thu, 27 Jul 2023 16:55:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.1
Subject: Re: [PATCH v3 62/62] mmc: f-sdh30: fix order of function calls in
 sdhci_f_sdh30_remove
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230727070051.17778-1-frank.li@vivo.com>
 <20230727070051.17778-62-frank.li@vivo.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230727070051.17778-62-frank.li@vivo.com>
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
> The order of function calls in sdhci_f_sdh30_remove is wrong,
> let's call sdhci_pltfm_unregister first.
> 
> Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Fixes: 5def5c1c15bf ("mmc: sdhci-f-sdh30: Replace with sdhci_pltfm")
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  drivers/mmc/host/sdhci_f_sdh30.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci_f_sdh30.c b/drivers/mmc/host/sdhci_f_sdh30.c
> index 840084ee72e6..964fa18a61a4 100644
> --- a/drivers/mmc/host/sdhci_f_sdh30.c
> +++ b/drivers/mmc/host/sdhci_f_sdh30.c
> @@ -211,11 +211,11 @@ static void sdhci_f_sdh30_remove(struct platform_device *pdev)
>  	struct sdhci_host *host = platform_get_drvdata(pdev);
>  	struct f_sdhost_priv *priv = sdhci_f_sdhost_priv(host);
>  
> +	sdhci_pltfm_unregister(pdev);

That also frees priv

> +
>  	reset_control_assert(priv->rst);
>  	clk_disable_unprepare(priv->clk);
>  	clk_disable_unprepare(priv->clk_iface);
> -
> -	sdhci_pltfm_unregister(pdev);
>  }
>  
>  #ifdef CONFIG_OF

