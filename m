Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF6477D9EA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 07:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241951AbjHPFom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 01:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233880AbjHPFoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 01:44:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76CC794;
        Tue, 15 Aug 2023 22:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692164654; x=1723700654;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=q1rLXMfNhA86Oqf+JuzD2DKK1IUJcDcRuCV7MEPq4NI=;
  b=T/aUkB00J1k2uryqt8GOP9wdEfi3NhIzLnqV3N+EGqB2iNZdkJeUL/Gn
   dLJLNVhJeP+JBCIgXbT1b3/DbQeq2YK1UfKuY9LODaIQT/TUi1+zhCTZ0
   Ai716zxgFmNhhSpUR+OELBAzsix3XSeX25ujqq7hcSG8EKUzQyIZXmKt8
   FE8hxei65uqdDr4oRkeSxYanDj5g7YkcfdZr/ObBNl9kIcA5pRIi5kU6k
   ArjtT6L7uuftYsDtCflv4mKfwehWYhfSo0yFu1dsBYD7ImR1TycW8KGRE
   ETvfBpqY6F5mHFRs1CPn2XY+7T5DU7faFdFc23FT1jTWJBeRJximlP8df
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="436347649"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="436347649"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 22:44:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="980607475"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="980607475"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.52.105])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 22:44:09 -0700
Message-ID: <6d750d71-b5b8-ef35-c4bc-76f12f3215e2@intel.com>
Date:   Wed, 16 Aug 2023 08:44:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: improve ESDHC_FLAG_ERR010450
To:     Giulio Benetti <giulio.benetti@benettiengineering.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jim Reinhart <jimr@tekvox.com>,
        James Autry <jautry@tekvox.com>,
        Matthew Maron <matthewm@tekvox.com>
References: <20230811214853.8623-1-giulio.benetti@benettiengineering.com>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230811214853.8623-1-giulio.benetti@benettiengineering.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/08/23 00:48, Giulio Benetti wrote:
> Errata ERR010450 only shows up if voltage is 1.8V, but if the device is
> supplied by 3v3 the errata can be ignored. So let's check for if quirk
> SDHCI_QUIRK2_NO_1_8_V is defined or not before limiting the frequency.
> 
> Sponsored by: Tekvox Inc.
> Cc: Jim Reinhart <jimr@tekvox.com>
> Cc: James Autry <jautry@tekvox.com>
> Cc: Matthew Maron <matthewm@tekvox.com>
> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index eebf94604a7f..cddecc1e1ac2 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -171,8 +171,8 @@
>  #define ESDHC_FLAG_HS400		BIT(9)
>  /*
>   * The IP has errata ERR010450
> - * uSDHC: Due to the I/O timing limit, for SDR mode, SD card clock can't
> - * exceed 150MHz, for DDR mode, SD card clock can't exceed 45MHz.
> + * uSDHC: At 1.8V due to the I/O timing limit, for SDR mode, SD card
> + * clock can't exceed 150MHz, for DDR mode, SD card clock can't exceed 45MHz.
>   */
>  #define ESDHC_FLAG_ERR010450		BIT(10)
>  /* The IP supports HS400ES mode */
> @@ -961,7 +961,8 @@ static inline void esdhc_pltfm_set_clock(struct sdhci_host *host,
>  		| ESDHC_CLOCK_MASK);
>  	sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
>  
> -	if (imx_data->socdata->flags & ESDHC_FLAG_ERR010450) {
> +	if ((imx_data->socdata->flags & ESDHC_FLAG_ERR010450) &&
> +	    (!(host->quirks2 & SDHCI_QUIRK2_NO_1_8_V))) {
>  		unsigned int max_clock;
>  
>  		max_clock = imx_data->is_ddr ? 45000000 : 150000000;

