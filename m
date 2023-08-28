Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA3878B7A3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 20:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233228AbjH1Szf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 14:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbjH1Sz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 14:55:28 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C04B0;
        Mon, 28 Aug 2023 11:55:26 -0700 (PDT)
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9B78B2D8;
        Mon, 28 Aug 2023 20:54:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1693248843;
        bh=L6i+vyDkKIxR2C2zutmUk85u6vPKhq7nfUkILoHSQF4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ozxHzgjS3J0ycaCFajsXWRTAUVmRrekDkyMn/RsXzfxbSfRK+zVrNdiOlhBeuRPAD
         1NEp80O9k+4d8iLBedx83rsJo6y1UCe/FSZvjZwvwOyuE9Z9YmOgvc1dpB6TuGJcHl
         E5xyuqiHdaJ/bdWxRoJDBYonIyIZKjRTtuY0RRdg=
Date:   Mon, 28 Aug 2023 21:55:34 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     rfoss@kernel.org, todor.too@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 10/15] media: qcom: camss: Allow clocks vfeN vfe_liteN
 or vfe_lite
Message-ID: <20230828185534.GO14596@pendragon.ideasonboard.com>
References: <20230823104444.1954663-1-bryan.odonoghue@linaro.org>
 <20230823104444.1954663-11-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230823104444.1954663-11-bryan.odonoghue@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 11:44:39AM +0100, Bryan O'Donoghue wrote:
> The number of Video Front End - VFE or Image Front End - IFE supported
> with new SoCs can vary both for the full and lite cases.
> 
> For example sdm845 has one vfe_lite and two vfe interfaces with the vfe
> clock called simply "vfe_lite" with no integer postfix. sc8280xp has four
> vfe and four vfe lite blocks.
> 
> We need to support the following clock name formats
> 
> - vfeN
> - vfe_liteN
> - vfe_lite
> 
> with N being any reasonably sized integer.
> 
> There are two sites in this code which need to do the same thing,
> constructing and matching strings with the pattern above, so encapsulate
> the logic in one function.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  drivers/media/platform/qcom/camss/camss-vfe.c | 22 ++++++++++++++-----
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
> index 8f48401e31cd3..73380e75dbb22 100644
> --- a/drivers/media/platform/qcom/camss/camss-vfe.c
> +++ b/drivers/media/platform/qcom/camss/camss-vfe.c
> @@ -437,6 +437,20 @@ void vfe_isr_reset_ack(struct vfe_device *vfe)
>  	complete(&vfe->reset_complete);
>  }
>  
> +static int vfe_match_clock_names(struct vfe_device *vfe,
> +				 struct camss_clock *clock)
> +{
> +	char vfe_name[CAMSS_RES_MAX];
> +	char vfe_lite_name[CAMSS_RES_MAX];
> +
> +	snprintf(vfe_name, sizeof(vfe_name), "vfe%d", vfe->id);
> +	snprintf(vfe_lite_name, sizeof(vfe_lite_name), "vfe_lite%d", vfe->id);
> +
> +	return (!strcmp(clock->name, vfe_name) ||
> +		!strcmp(clock->name, vfe_lite_name) ||
> +		!strcmp(clock->name, "vfe_lite"));

The code below will match "vfe0", "vfe1" and "vfe_lite", which the code
here matches "vfe%d", "vfe_life%d" and "vfe_lite". The commit message
doesn't explain why you can restrict the clock name to "vfe%d" instead
of matching both "vfe0" and "vfe1". I could try to guess, but it's
better to clarify it in the commit message.

> +}
> +
>  /*
>   * vfe_set_clock_rates - Calculate and set clock rates on VFE module
>   * @vfe: VFE device
> @@ -460,9 +474,7 @@ static int vfe_set_clock_rates(struct vfe_device *vfe)
>  	for (i = 0; i < vfe->nclocks; i++) {
>  		struct camss_clock *clock = &vfe->clock[i];
>  
> -		if (!strcmp(clock->name, "vfe0") ||
> -		    !strcmp(clock->name, "vfe1") ||
> -		    !strcmp(clock->name, "vfe_lite")) {
> +		if (vfe_match_clock_names(vfe, clock)) {
>  			u64 min_rate = 0;
>  			long rate;
>  
> @@ -543,9 +555,7 @@ static int vfe_check_clock_rates(struct vfe_device *vfe)
>  	for (i = 0; i < vfe->nclocks; i++) {
>  		struct camss_clock *clock = &vfe->clock[i];
>  
> -		if (!strcmp(clock->name, "vfe0") ||
> -		    !strcmp(clock->name, "vfe1") ||
> -		    !strcmp(clock->name, "vfe_lite")) {
> +		if (vfe_match_clock_names(vfe, clock)) {
>  			u64 min_rate = 0;
>  			unsigned long rate;
>  

-- 
Regards,

Laurent Pinchart
