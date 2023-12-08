Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6136B80A9E5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 17:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233708AbjLHQ66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 11:58:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbjLHQ64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 11:58:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3911E98
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 08:59:03 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC84DC433C8;
        Fri,  8 Dec 2023 16:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702054742;
        bh=h0JkAKzYF1eCC3VCUFet/wUloQePgRqJtpyUOwrwHs8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VV9pLQrduCHZxqG1gp2gsdESd89zqUJ8T/ztaw9WJVw7s21G8m8muHVlDot3+Gf40
         65myTt3MriTs13uBBjQtrCxREZctMcuNBTs7qnGtm24UGeLP0ZZIHk1cDe2BqhGoG5
         6n9im+9fMvwh7N5TggcZFvP6o6io3PyaZcgCS1iYmLOW+edW4FBFuzCKI3FXRVqssq
         gBwKneVYebD7Q/ruS5A6bejC3WL/NZroDaT74VKIptNNKVPIXywOlsdC0uq209XkCP
         And+nEwHTfPBhvawAtMy7NfdJGgiRcPQgMJR+qF0p4bLHgxxd7/yjMuh2w1hz5BSiS
         rFmD07v7UUqtw==
Date:   Fri, 8 Dec 2023 16:58:55 +0000
From:   Simon Horman <horms@kernel.org>
To:     Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Yannick Fertre <yannick.fertre@foss.st.com>,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Richard Cochran <richardcochran@gmail.com>,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 3/4] drm/stm: dsi: expose DSI PHY internal clock
Message-ID: <20231208165855.GA8459@kernel.org>
References: <20231204101113.276368-1-raphael.gallais-pou@foss.st.com>
 <20231204101113.276368-4-raphael.gallais-pou@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204101113.276368-4-raphael.gallais-pou@foss.st.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 11:11:12AM +0100, Raphael Gallais-Pou wrote:

...

> @@ -514,18 +675,40 @@ static int dw_mipi_dsi_stm_probe(struct platform_device *pdev)
>  		dsi->lane_max_kbps *= 2;
>  	}
>  
> -	dw_mipi_dsi_stm_plat_data.base = dsi->base;
> -	dw_mipi_dsi_stm_plat_data.priv_data = dsi;
> +	dsi->pdata = *pdata;
> +	dsi->pdata.base = dsi->base;
> +	dsi->pdata.priv_data = dsi;
> +
> +	dsi->pdata.max_data_lanes = 2;
> +	dsi->pdata.phy_ops = &dw_mipi_dsi_stm_phy_ops;
>  
>  	platform_set_drvdata(pdev, dsi);
>  
> -	dsi->dsi = dw_mipi_dsi_probe(pdev, &dw_mipi_dsi_stm_plat_data);
> +	dsi->dsi = dw_mipi_dsi_probe(pdev, &dsi->pdata);
>  	if (IS_ERR(dsi->dsi)) {
>  		ret = PTR_ERR(dsi->dsi);
>  		dev_err_probe(dev, ret, "Failed to initialize mipi dsi host\n");
>  		goto err_dsi_probe;
>  	}
>  
> +	/*
> +	 * We need to wait for the generic bridge to probe before enabling and
> +	 * register the internal pixel clock.
> +	 */
> +	ret = clk_prepare_enable(dsi->pclk);
> +	if (ret) {
> +		DRM_ERROR("%s: Failed to enable peripheral clk\n", __func__);
> +		goto err_dsi_probe;
> +	}
> +
> +	ret = dw_mipi_dsi_clk_register(dsi, dev);
> +	if (ret) {
> +		DRM_ERROR("Failed to register DSI pixel clock: %d\n", ret);

Hi Raphael,

Does clk_disable_unprepare(dsi->pclk) need to be added to this unwind
chain?

Flagged by Smatch.

> +		goto err_dsi_probe;
> +	}
> +
> +	clk_disable_unprepare(dsi->pclk);
> +
>  	return 0;
>  
>  err_dsi_probe:

...
