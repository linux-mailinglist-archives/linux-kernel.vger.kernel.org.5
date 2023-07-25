Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5545F761D1E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 17:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbjGYPP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 11:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbjGYPPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 11:15:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569D619A0;
        Tue, 25 Jul 2023 08:15:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC6B6613DC;
        Tue, 25 Jul 2023 15:15:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D457AC433C7;
        Tue, 25 Jul 2023 15:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690298122;
        bh=uXKJ00uasfRVR16k4FOy30lC5u9cvvfPEmi295ROSWo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fTH8UPAM+yn81R7Z0KXVtP8plOMp2TcJp0PSNVyugUwDyax88EbHRxI8m3I4eBcPe
         eCUj3cznRsiQJPalXVlO1yJwcrPx1GgSKlTsZyrW8dttQooC1l9Z3xIxmzxrrkuF7d
         BjQlmEtI/Wl52M+s6tiFDpazwACyKEJ0Coprc0z7wWUm08GqlSodUDVzyJ9fLTfhMe
         v+kB9e1cPeBd6ISw2Tay9SDLaUykUHhD3+pMt7p9WWVOh0uG3TJYYR0fndhiQKwoSR
         Q88j5PyK4KPrdVMx1vKzfwgcsCGmTcSzMiUUODzInRjVYgm/y56VRwPFXwZ6cGFg62
         0vVfY0WzOcw9Q==
Date:   Tue, 25 Jul 2023 23:03:44 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Drew Fustini <dfustini@baylibre.com>
Cc:     Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        Robert Nelson <robertcnelson@beagleboard.org>,
        Jason Kridner <jkridner@beagleboard.org>
Subject: Re: [PATCH RFC 4/4] mmc: sdhci-of-dwcmshc: Add support for T-Head
 TH1520
Message-ID: <ZL/kUPicOEPWz5NP@xhacker>
References: <20230724-th1520-emmc-v1-0-cca1b2533da2@baylibre.com>
 <20230724-th1520-emmc-v1-4-cca1b2533da2@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230724-th1520-emmc-v1-4-cca1b2533da2@baylibre.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 05:59:18PM -0700, Drew Fustini wrote:
> Add basic support for the T-Head TH1520 SoC mmc controller. The new
> compatible "thead,th1520-dwcmshc" enables basic support by:

Hi Drew,

> 
>  - Enabling v4 mode to properly communicate with the mmc device
>  - Setting quirk to disable ADMA
>  - Setting flag to disable SDMA and force PIO mode
>  - Turing .reset op into a no-op as the driver does not yet know how to
>    configure the phy. Rely on the vendor u-boot to have configured the
>    phy and do not reset the controller in Linux.

The last three itmes are not acceptable. The controller supports ADMA
well, can you plz bring in the phy driver? We can't rely on bootloader to
configure phy.

> 
> Signed-off-by: Drew Fustini <dfustini@baylibre.com>
> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 42 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index e68cd87998c8..8573aff25a81 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -337,6 +337,14 @@ static void rk35xx_sdhci_reset(struct sdhci_host *host, u8 mask)
>  	sdhci_reset(host, mask);
>  }
>  
> +static void th1520_sdhci_reset(struct sdhci_host *host, u8 mask)
> +{
> +	/*
> +	 * MMC controller and phy is configured by vendor u-boot so
> +	 * take the simplistic approach of not doing reset in Linux.
> +	 */
> +}
> +
>  static const struct sdhci_ops sdhci_dwcmshc_ops = {
>  	.set_clock		= sdhci_set_clock,
>  	.set_bus_width		= sdhci_set_bus_width,
> @@ -355,6 +363,15 @@ static const struct sdhci_ops sdhci_dwcmshc_rk35xx_ops = {
>  	.adma_write_desc	= dwcmshc_adma_write_desc,
>  };
>  
> +static const struct sdhci_ops sdhci_dwcmshc_th1520_ops = {
> +	.set_clock		= sdhci_set_clock,
> +	.set_bus_width		= sdhci_set_bus_width,
> +	.set_uhs_signaling	= dwcmshc_set_uhs_signaling,
> +	.get_max_clock		= dwcmshc_get_max_clock,
> +	.reset			= th1520_sdhci_reset,
> +	.adma_write_desc	= dwcmshc_adma_write_desc,
> +};
> +
>  static const struct sdhci_pltfm_data sdhci_dwcmshc_pdata = {
>  	.ops = &sdhci_dwcmshc_ops,
>  	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
> @@ -378,6 +395,13 @@ static const struct sdhci_pltfm_data sdhci_dwcmshc_rk35xx_pdata = {
>  		   SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
>  };
>  
> +static const struct sdhci_pltfm_data sdhci_dwcmshc_th1520_pdata = {
> +	.ops = &sdhci_dwcmshc_th1520_ops,
> +	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN | SDHCI_QUIRK_BROKEN_DMA |
> +		  SDHCI_QUIRK_BROKEN_ADMA,
> +	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
> +};
> +
>  static int dwcmshc_rk35xx_init(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
>  {
>  	int err;
> @@ -434,6 +458,10 @@ static void dwcmshc_rk35xx_postinit(struct sdhci_host *host, struct dwcmshc_priv
>  }
>  
>  static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
> +	{
> +		.compatible = "thead,th1520-dwcmshc",
> +		.data = &sdhci_dwcmshc_th1520_pdata,
> +	},
>  	{
>  		.compatible = "rockchip,rk3588-dwcmshc",
>  		.data = &sdhci_dwcmshc_rk35xx_pdata,
> @@ -546,6 +574,20 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  		sdhci_enable_v4_mode(host);
>  #endif
>  
> +	if (pltfm_data == &sdhci_dwcmshc_th1520_pdata) {
> +		/*
> +		 * The controller needs v4 mode enabled to properly
> +		 * communicate with the mmc device.
> +		 */
> +		sdhci_enable_v4_mode(host);
> +
> +		/*
> +		 * Set flag so the SDHCI host core will disable DMA
> +		 * and use PIO mode.
> +		 */
> +		host->flags &= ~SDHCI_USE_SDMA;
> +	}
> +
>  	host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
>  
>  	err = sdhci_setup_host(host);
> 
> -- 
> 2.34.1
> 
