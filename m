Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9557678B7D5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 21:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbjH1TH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 15:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233217AbjH1Srg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 14:47:36 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAEC1AA;
        Mon, 28 Aug 2023 11:47:14 -0700 (PDT)
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1013A2D8;
        Mon, 28 Aug 2023 20:45:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1693248346;
        bh=gVvmU76kknIwWC7IkiRDPkM1JXVIOmaVSiqt1exNYfY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hhYK2Emzm+nPvs0DBQyvKoaRFW8B5Sp4Ae/7YYqcr2PpVJcQ3QR6nOPWP5/WAJnCd
         mhco2RQMrmIfCRS6IxN9Og/lnvcHSeng8G10oJKxVTpuNyVPd+90tLAUw7BrIocVfq
         JjORoolmLQwtcEmGMsljFYKVpfVrNJBcXQ0Bc5fc=
Date:   Mon, 28 Aug 2023 21:47:16 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     rfoss@kernel.org, todor.too@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 07/15] media: qcom: camss: Capture VFE CSID dependency
 in a helper function
Message-ID: <20230828184716.GM14596@pendragon.ideasonboard.com>
References: <20230823104444.1954663-1-bryan.odonoghue@linaro.org>
 <20230823104444.1954663-8-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230823104444.1954663-8-bryan.odonoghue@linaro.org>
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

On Wed, Aug 23, 2023 at 11:44:36AM +0100, Bryan O'Donoghue wrote:
> From sdm845 onwards we need to ensure the VFE is powered on prior to
> switching on the CSID.

Based on the discussions with Konrad in the mail thread, I would record
here the reason for this requirement.

What happens if you unconditionally power up the VFE prior to switching
the CSID on ? Will this break something on platforms older than SDM845 ?

> Alternatively we could model up the GDSCs and clocks the CSID needs
> without the VFE but, there's a real question of the legitimacy of such a
> use-case.
> 
> For now drawing a line at sdm845 and switching on the associated VFEs is
> a perfectly valid thing to do.
> 
> Rather than continually extend out this clause for at least two new SoCs
> with this same model - making the vfe_get/vfe_put path start to look
> like spaghetti we can encoded the dependency in a helper function.
> 
> Use csid_depends_vfe() for this purpose.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  .../media/platform/qcom/camss/camss-csid.c    | 20 +++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss-csid.c b/drivers/media/platform/qcom/camss/camss-csid.c
> index 08991b070bd61..fd04ed112b564 100644
> --- a/drivers/media/platform/qcom/camss/camss-csid.c
> +++ b/drivers/media/platform/qcom/camss/camss-csid.c
> @@ -146,6 +146,22 @@ static int csid_set_clock_rates(struct csid_device *csid)
>  	return 0;
>  }
>  
> +static bool csid_depends_vfe(u32 version)
> +{
> +	bool ret = false;
> +
> +	switch (version) {
> +	case CAMSS_845:
> +	case CAMSS_8250:
> +		ret = true;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
>  /*
>   * csid_set_power - Power on/off CSID module
>   * @sd: CSID V4L2 subdevice
> @@ -163,7 +179,7 @@ static int csid_set_power(struct v4l2_subdev *sd, int on)
>  	int ret = 0;
>  
>  	if (on) {
> -		if (version == CAMSS_8250 || version == CAMSS_845) {
> +		if (csid_depends_vfe(version)) {
>  			ret = vfe_get(vfe);
>  			if (ret < 0)
>  				return ret;
> @@ -217,7 +233,7 @@ static int csid_set_power(struct v4l2_subdev *sd, int on)
>  		regulator_bulk_disable(csid->num_supplies,
>  				       csid->supplies);
>  		pm_runtime_put_sync(dev);
> -		if (version == CAMSS_8250 || version == CAMSS_845)
> +		if (csid_depends_vfe(version))
>  			vfe_put(vfe);
>  	}
>  

-- 
Regards,

Laurent Pinchart
