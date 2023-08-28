Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31DE78B5C5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 19:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbjH1RAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 13:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232152AbjH1RAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 13:00:22 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F7BB4;
        Mon, 28 Aug 2023 10:00:19 -0700 (PDT)
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3F9105AA;
        Mon, 28 Aug 2023 18:58:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1693241937;
        bh=wSes04bw3l6N6NXQnvUcioTMnfn9XPGaRGnnPYAbHtw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OkkOMlGu/iZXRT/6zuJNUXS7Tw7LYplCQlhomh9oLQGU7d+dOi1ic+gPdHC+yu2Xh
         +UOfDQAQOk764H0JH9mLdtuClbq+V8Cck6yggWF3qA7EAuTVffQh/iqUU2r1/vjSGR
         r7g3XuVFC+f6db5oBTv+4AYmZwNTRsjhQvcY3QoQ=
Date:   Mon, 28 Aug 2023 20:00:27 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     rfoss@kernel.org, todor.too@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2 1/9] media: qcom: camss: Fix pm_domain_on sequence in
 probe
Message-ID: <20230828170027.GV14596@pendragon.ideasonboard.com>
References: <20230822200626.1931129-1-bryan.odonoghue@linaro.org>
 <20230822200626.1931129-2-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230822200626.1931129-2-bryan.odonoghue@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bryan,

Thank you for the patch.

On Tue, Aug 22, 2023 at 09:06:18PM +0100, Bryan O'Donoghue wrote:
> We need to make sure camss_configure_pd() happens before
> camss_register_entities() as the vfe_get() path relies on the pointer
> provided by camss_configure_pd().
> 
> Fix the ordering sequence in probe to ensure the pointers vfe_get() demands
> are present by the time camss_register_entities() runs.
> 
> In order to facilitate backporting to stable kernels I've moved the
> configure_pd() call pretty early on the probe() function so that
> irrespective of the existence of the old error handling jump labels this
> patch should still apply to -next circa Aug 2023 to v5.13 inclusive.
> 
> Fixes: 2f6f8af67203 ("media: camss: Refactor VFE power domain toggling")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

It seems like the device links and power domains won't be properly
cleaned up if probe fails. The problem predates this patch though, so
even if moving genpd initialization may make it worse, it's not a reason
to block this patch.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Maybe a patch further in the series will fix this :-)

> ---
>  drivers/media/platform/qcom/camss/camss.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
> index f11dc59135a5a..75991d849b571 100644
> --- a/drivers/media/platform/qcom/camss/camss.c
> +++ b/drivers/media/platform/qcom/camss/camss.c
> @@ -1619,6 +1619,12 @@ static int camss_probe(struct platform_device *pdev)
>  	if (ret < 0)
>  		goto err_cleanup;
>  
> +	ret = camss_configure_pd(camss);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to configure power domains: %d\n", ret);
> +		goto err_cleanup;
> +	}
> +
>  	ret = camss_init_subdevices(camss);
>  	if (ret < 0)
>  		goto err_cleanup;
> @@ -1678,12 +1684,6 @@ static int camss_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> -	ret = camss_configure_pd(camss);
> -	if (ret < 0) {
> -		dev_err(dev, "Failed to configure power domains: %d\n", ret);
> -		return ret;
> -	}
> -
>  	pm_runtime_enable(dev);
>  
>  	return 0;

-- 
Regards,

Laurent Pinchart
