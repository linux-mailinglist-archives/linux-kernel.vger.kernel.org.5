Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E320762B4C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 08:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjGZGUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 02:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjGZGUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 02:20:17 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6811510B;
        Tue, 25 Jul 2023 23:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690352416; x=1721888416;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1616SoPZSPatTpMsZhCUXl8Yd3XySJvItC30dHWAI8M=;
  b=m964JQlJlpTBx+jPKNeKDqQRx9JQMoDckldAEXRNRLQ2bqDBOrOV7Gm3
   fhJPBUNCUAfN2YKY7DisTXWCf92i1fHSjFbAd15wJUNcqN2oHMxpDJoML
   KiXmcXze3n64ZjrQDeJu9cDeguUPZTVisA5Vl+wSyZF2IvSYrMmApiEBw
   oIzPLanPsB6VRlZktpzoBtrPy3JiBj2+O9Fmigtx/ZSZ6g5yDeuz2CC58
   QpDdqMV5TxmyLRUJmnMIxhSU6Cxk7WmyCN2BgmLszIKVSiKIJsrmFVLnj
   vU9nsVvTJPpgM0DEcO62SDqgrEwQzFENUluPzGoy7zGgk3aX81NFM1Yio
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="352831324"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="352831324"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 23:20:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="726384390"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="726384390"
Received: from igosu-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.35.75])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 23:20:14 -0700
Message-ID: <3ec97a7a-05fe-3a77-bde4-ec37419ce090@intel.com>
Date:   Wed, 26 Jul 2023 09:20:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v2 09/61] mmc: sdhci-pic32: Convert to platform remove
 callback returning void
To:     Yangtao Li <frank.li@vivo.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230726040041.26267-1-frank.li@vivo.com>
 <20230726040041.26267-9-frank.li@vivo.com>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230726040041.26267-9-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/07/23 06:59, Yangtao Li wrote:
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

I already acked a number of patches:

https://lore.kernel.org/linux-mmc/af01d060-dbaa-aa54-8203-3da5fcbc0a79@intel.com/

Also there do not seem to be any changelogs?

> ---
>  drivers/mmc/host/sdhci-pic32.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pic32.c b/drivers/mmc/host/sdhci-pic32.c
> index 6696b6bdd88e..7a0351a9c74e 100644
> --- a/drivers/mmc/host/sdhci-pic32.c
> +++ b/drivers/mmc/host/sdhci-pic32.c
> @@ -210,7 +210,7 @@ static int pic32_sdhci_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> -static int pic32_sdhci_remove(struct platform_device *pdev)
> +static void pic32_sdhci_remove(struct platform_device *pdev)
>  {
>  	struct sdhci_host *host = platform_get_drvdata(pdev);
>  	struct pic32_sdhci_priv *sdhci_pdata = sdhci_priv(host);
> @@ -221,8 +221,6 @@ static int pic32_sdhci_remove(struct platform_device *pdev)
>  	clk_disable_unprepare(sdhci_pdata->base_clk);
>  	clk_disable_unprepare(sdhci_pdata->sys_clk);
>  	sdhci_pltfm_free(pdev);
> -
> -	return 0;
>  }
>  
>  static const struct of_device_id pic32_sdhci_id_table[] = {
> @@ -238,7 +236,7 @@ static struct platform_driver pic32_sdhci_driver = {
>  		.of_match_table = of_match_ptr(pic32_sdhci_id_table),
>  	},
>  	.probe		= pic32_sdhci_probe,
> -	.remove		= pic32_sdhci_remove,
> +	.remove_new	= pic32_sdhci_remove,
>  };
>  
>  module_platform_driver(pic32_sdhci_driver);

