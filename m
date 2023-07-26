Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538C3762BA5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 08:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbjGZGkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 02:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbjGZGkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 02:40:16 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA071FEC;
        Tue, 25 Jul 2023 23:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690353615; x=1721889615;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0vVZSfnGXVcFF+8YR1s5wFzSXd2Z9W7maJ0VC+BhlQQ=;
  b=dERrjHtzZTZyhTLmrPNmid3OYDRCqZovwyMX/a79hgRdY+tiTveAACjm
   2GCbmrri/LVKkzBC7Pz++oTKkAaz+tIw5vsdzW5YoasmGylrT2VQ+R7Ar
   ssYV1HSZT6OdOVMsBpFpfClf/O1o4CyawxUD/Qt45GKJaGFfaYKmB7Pbo
   oiZ3d0UWFGANru73aG2tEAFGjj6+LmThSUsq94BpqOkb5PALfePgl1ZWu
   5ZvOH+5l3Q8JGD8PKcYdO+0vqRFEzGlgV6tQet3eo49538VixAkn4VfIh
   PAfJPB64zZQAYt3gfloM4JJ1S/DLrRynyZyUxcGNpJ/sqBc4waBUG8dcQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="434191523"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="434191523"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 23:40:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="816545532"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="816545532"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.35.75])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 23:40:04 -0700
Message-ID: <61b62916-3456-be07-1aa7-a4e14e537445@intel.com>
Date:   Wed, 26 Jul 2023 09:39:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v2 25/61] mmc: f-sdh30: Convert to platform remove
 callback returning void
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230726040041.26267-1-frank.li@vivo.com>
 <20230726040041.26267-25-frank.li@vivo.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230726040041.26267-25-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/07/23 07:00, Yangtao Li wrote:
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
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci_f_sdh30.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci_f_sdh30.c b/drivers/mmc/host/sdhci_f_sdh30.c
> index b01ffb4d0973..840084ee72e6 100644
> --- a/drivers/mmc/host/sdhci_f_sdh30.c
> +++ b/drivers/mmc/host/sdhci_f_sdh30.c
> @@ -206,7 +206,7 @@ static int sdhci_f_sdh30_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> -static int sdhci_f_sdh30_remove(struct platform_device *pdev)
> +static void sdhci_f_sdh30_remove(struct platform_device *pdev)
>  {
>  	struct sdhci_host *host = platform_get_drvdata(pdev);
>  	struct f_sdhost_priv *priv = sdhci_f_sdhost_priv(host);
> @@ -216,8 +216,6 @@ static int sdhci_f_sdh30_remove(struct platform_device *pdev)
>  	clk_disable_unprepare(priv->clk_iface);
>  
>  	sdhci_pltfm_unregister(pdev);
> -
> -	return 0;
>  }
>  
>  #ifdef CONFIG_OF
> @@ -245,8 +243,8 @@ static struct platform_driver sdhci_f_sdh30_driver = {
>  		.acpi_match_table = ACPI_PTR(f_sdh30_acpi_ids),
>  		.pm	= &sdhci_pltfm_pmops,
>  	},
> -	.probe	= sdhci_f_sdh30_probe,
> -	.remove	= sdhci_f_sdh30_remove,
> +	.probe = sdhci_f_sdh30_probe,
> +	.remove_new = sdhci_f_sdh30_remove,
>  };
>  
>  module_platform_driver(sdhci_f_sdh30_driver);

