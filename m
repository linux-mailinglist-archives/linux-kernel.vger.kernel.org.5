Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83136758034
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 16:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbjGROzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 10:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232225AbjGROzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 10:55:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B39E0;
        Tue, 18 Jul 2023 07:55:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 701E16160E;
        Tue, 18 Jul 2023 14:55:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27BA7C433C7;
        Tue, 18 Jul 2023 14:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689692117;
        bh=min4l/bR2fEVj3vzFg5K0E/Z3Mb/vK8ghVM0zgoNXe0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sj745agqf7fyXuF0t2aNdV9a39HVkdXPFE510iWq6ryKyoLCBuLwAvigXQ5J23FgA
         i510E6TmRWATLgfKQ0QSXrmAWlRl8C3U6mlpsva6nALUH+Iue9+a5fxpj+xmZddTgH
         B6nLwl4CwzMtXLplboRNjxlI7cClbW6wY0WnEtXeV1IBErksi9gBtFCSwzlR2o4/us
         YMosMVZTS6NOB0O28g8fl3pZtFNKKeLkuo6TORAHAoqIHdG1dzjWD3HfuV2EGLaLPo
         G2gHyH8JzzzuVR9PxiFYrUWNzXxoCgs5koa5XMLdN6XuhlNT9//8231Bsjh5ijitlW
         7eVKh8i+cEZxw==
Date:   Tue, 18 Jul 2023 07:58:41 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Taniya Das <quic_tdas@quicinc.com>
Subject: Re: [PATCH 5/8] clk: qcom: lpasscc-sc7280: fix missing resume during
 probe
Message-ID: <xbek6yuldy7ck3zlux76hosn4iqt52ocydovuol7geiwapslrd@j7uyxhrkiyaw>
References: <20230718132902.21430-1-johan+linaro@kernel.org>
 <20230718132902.21430-6-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718132902.21430-6-johan+linaro@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 03:28:59PM +0200, Johan Hovold wrote:
> Drivers that enable runtime PM must make sure that the controller is
> runtime resumed before accessing its registers to prevent the power
> domain from being disabled.
> 

NB: the clock framework will runtime resume the controller surrounding
operations, even so during probe. But this is not done for resets and
gdscs - and in some clock drivers we poke registers directly from
probe...

The one time this really matters is where we associate the ahb clock
with the runtime state, e.g. in qcs404 turingcc. On most other platforms
we just mark these clocks always-on in gcc...

Regards,
Bjorn

> Fixes: 4ab43d171181 ("clk: qcom: Add lpass clock controller driver for SC7280")
> Cc: stable@vger.kernel.org      # 5.16
> Cc: Taniya Das <quic_tdas@quicinc.com>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/clk/qcom/lpasscc-sc7280.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/qcom/lpasscc-sc7280.c b/drivers/clk/qcom/lpasscc-sc7280.c
> index 0df2b29e95e3..e6b815aec46a 100644
> --- a/drivers/clk/qcom/lpasscc-sc7280.c
> +++ b/drivers/clk/qcom/lpasscc-sc7280.c
> @@ -118,9 +118,13 @@ static int lpass_cc_sc7280_probe(struct platform_device *pdev)
>  	ret = pm_clk_add(&pdev->dev, "iface");
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "failed to acquire iface clock\n");
> -		goto destroy_pm_clk;
> +		goto err_destroy_pm_clk;
>  	}
>  
> +	ret = pm_runtime_resume_and_get(&pdev->dev);
> +	if (ret)
> +		goto err_destroy_pm_clk;
> +
>  	if (!of_property_read_bool(pdev->dev.of_node, "qcom,adsp-pil-mode")) {
>  		lpass_regmap_config.name = "qdsp6ss";
>  		lpass_regmap_config.max_register = 0x3f;
> @@ -128,7 +132,7 @@ static int lpass_cc_sc7280_probe(struct platform_device *pdev)
>  
>  		ret = qcom_cc_probe_by_index(pdev, 0, desc);
>  		if (ret)
> -			goto destroy_pm_clk;
> +			goto err_put_rpm;
>  	}
>  
>  	lpass_regmap_config.name = "top_cc";
> @@ -137,11 +141,15 @@ static int lpass_cc_sc7280_probe(struct platform_device *pdev)
>  
>  	ret = qcom_cc_probe_by_index(pdev, 1, desc);
>  	if (ret)
> -		goto destroy_pm_clk;
> +		goto err_put_rpm;
> +
> +	pm_runtime_put(&pdev->dev);
>  
>  	return 0;
>  
> -destroy_pm_clk:
> +err_put_rpm:
> +	pm_runtime_put_sync(&pdev->dev);
> +err_destroy_pm_clk:
>  	pm_clk_destroy(&pdev->dev);
>  
>  	return ret;
> -- 
> 2.41.0
> 
