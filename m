Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF7178B7BB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 20:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233238AbjH1S7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 14:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233243AbjH1S7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 14:59:16 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E3BBF;
        Mon, 28 Aug 2023 11:59:13 -0700 (PDT)
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1F36B2D8;
        Mon, 28 Aug 2023 20:57:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1693249071;
        bh=lj9zY3kfb/0sPuanCW50QZKhu0uw+ImuMXKaFbQem7Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S0pH0O3u9gv9E88/GC6EqYtLTIoqY5ea9/xRc5xfKSvk9Iwm4ELM3/hdRSxb5g3dE
         vQPBETXbcBr229rfpH8Tj4TdfH+V4sOaLDNnNXUkuRYq1eIaD92OUA7OqnTRW2rCq8
         ZYlp6diRIhxA9ABdfGPIbn60RmtOGvillPyvdUIo=
Date:   Mon, 28 Aug 2023 21:59:21 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     rfoss@kernel.org, todor.too@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 11/15] media: qcom: camss: Functionally decompose
 CSIPHY clock lookups
Message-ID: <20230828185921.GP14596@pendragon.ideasonboard.com>
References: <20230823104444.1954663-1-bryan.odonoghue@linaro.org>
 <20230823104444.1954663-12-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230823104444.1954663-12-bryan.odonoghue@linaro.org>
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

On Wed, Aug 23, 2023 at 11:44:40AM +0100, Bryan O'Donoghue wrote:
> The csiphyX_timer and csiX_phy values need not be hard-coded. We can
> functionally decompose the string matching inside of a loop.
> 
> Static string values are brittle, difficult to extend and not required
> anyway since the camss->res->csiphy_num value informs us of the number
> of CSIPHYs and hence the set of potential clocks for a given CSIPHY.
> 
> In simple terms if we have five CSIPHYs we can have no more and no less
> than five csiphy_timer clocks. Similarly csi_phy core clocks have a 1:1
> relationship with the PHY they clock.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  .../media/platform/qcom/camss/camss-csiphy.c  | 37 ++++++++++++-------
>  1 file changed, 23 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss-csiphy.c b/drivers/media/platform/qcom/camss/camss-csiphy.c
> index 0e8c2a59ea241..baf78c525fbfc 100644
> --- a/drivers/media/platform/qcom/camss/camss-csiphy.c
> +++ b/drivers/media/platform/qcom/camss/camss-csiphy.c
> @@ -536,6 +536,15 @@ static int csiphy_init_formats(struct v4l2_subdev *sd,
>  	return csiphy_set_format(sd, fh ? fh->state : NULL, &format);
>  }
>  
> +static bool csiphy_match_clock_name(const char *clock_name, const char *format,
> +				    int index)
> +{
> +	char name[CAMSS_RES_MAX];
> +
> +	snprintf(name, sizeof(name), format, index);
> +	return !strcmp(clock_name, name);

This is very error-prone. You hide the buffer size from the caller,
which will make it prone to buffer overflows.

> +}
> +
>  /*
>   * msm_csiphy_subdev_init - Initialize CSIPHY device structure and resources
>   * @csiphy: CSIPHY device
> @@ -550,7 +559,7 @@ int msm_csiphy_subdev_init(struct camss *camss,
>  {
>  	struct device *dev = camss->dev;
>  	struct platform_device *pdev = to_platform_device(dev);
> -	int i, j;
> +	int i, j, k;
>  	int ret;
>  
>  	csiphy->camss = camss;
> @@ -666,19 +675,19 @@ int msm_csiphy_subdev_init(struct camss *camss,
>  		for (j = 0; j < clock->nfreqs; j++)
>  			clock->freq[j] = res->clock_rate[i][j];
>  
> -		if (!strcmp(clock->name, "csiphy0_timer") ||
> -		    !strcmp(clock->name, "csiphy1_timer") ||
> -		    !strcmp(clock->name, "csiphy2_timer") ||
> -		    !strcmp(clock->name, "csiphy3_timer") ||
> -		    !strcmp(clock->name, "csiphy4_timer") ||
> -		    !strcmp(clock->name, "csiphy5_timer"))
> -			csiphy->rate_set[i] = true;
> -
> -		if (camss->res->version == CAMSS_660 &&
> -		    (!strcmp(clock->name, "csi0_phy") ||
> -		     !strcmp(clock->name, "csi1_phy") ||
> -		     !strcmp(clock->name, "csi2_phy")))
> -			csiphy->rate_set[i] = true;
> +		for (k = 0; k < camss->res->csiphy_num; k++) {
> +			csiphy->rate_set[i] = csiphy_match_clock_name(clock->name,
> +								      "csiphy%d_timer", k);
> +			if (csiphy->rate_set[i])
> +				break;
> +
> +			if (camss->res->version == CAMSS_660) {
> +				csiphy->rate_set[i] = csiphy_match_clock_name(clock->name,
> +									      "csi%d_phy", k);
> +				if (csiphy->rate_set[i])
> +					break;
> +			}
> +		}
>  	}
>  
>  	return 0;

-- 
Regards,

Laurent Pinchart
