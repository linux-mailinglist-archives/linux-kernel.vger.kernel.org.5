Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B1F76C9A4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 11:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234060AbjHBJl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 05:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbjHBJlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 05:41:24 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C56BE5C;
        Wed,  2 Aug 2023 02:41:18 -0700 (PDT)
Received: from [192.168.88.20] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 783BA2AC;
        Wed,  2 Aug 2023 11:40:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1690969213;
        bh=OAZY/19CTlqPP0Po9xr2dlATluluHR+ylQdYRwV7qgM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=oXyB2PEJPgOjhv2stk7iMnBmBKYvMZq+s4k4XcpIc5dGamQrTwE0ptCojoPEAK8vH
         HX+XgVAZeFsuGsayshThWRHNSyJDSrzGno3HRa5zGtCIK7J77FA98ycQ/3wmH6kKpc
         HlZ/U23wo3W8yR+5nEcZebzJNWdGv35qwgjWET5I=
Message-ID: <5264c7f8-5af4-fe5c-7a79-cc56150bca82@ideasonboard.com>
Date:   Wed, 2 Aug 2023 12:41:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 08/16] media: cadence: csi2rx: Configure DPHY using
 link freq
Content-Language: en-US
To:     Jai Luthra <j-luthra@ti.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        niklas.soderlund+renesas@ragnatech.se,
        Benoit Parrot <bparrot@ti.com>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, nm@ti.com,
        devarsht@ti.com
References: <20230731-upstream_csi-v8-0-fb7d3661c2c9@ti.com>
 <20230731-upstream_csi-v8-8-fb7d3661c2c9@ti.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20230731-upstream_csi-v8-8-fb7d3661c2c9@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/07/2023 11:29, Jai Luthra wrote:
> From: Pratyush Yadav <p.yadav@ti.com>
> 
> Some platforms like TI's J721E can have the CSI2RX paired with an
> external DPHY. Use the generic PHY framework to configure the DPHY with
> the correct link frequency.
> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> Co-authored-by: Jai Luthra <j-luthra@ti.com>
> Signed-off-by: Jai Luthra <j-luthra@ti.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
> v7->v8
> - Drop original patch in-lieu of already merged
>    https://lore.kernel.org/linux-media/20230523085626.3295-5-jack.zhu@starfivetech.com/
> - Add a new patch to configure DPHY using link_freq control from the
>    source
> 
>   drivers/media/platform/cadence/cdns-csi2rx.c | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
> index 4f9654366485..2a80c66fb547 100644
> --- a/drivers/media/platform/cadence/cdns-csi2rx.c
> +++ b/drivers/media/platform/cadence/cdns-csi2rx.c
> @@ -149,8 +149,33 @@ static void csi2rx_reset(struct csi2rx_priv *csi2rx)
>   static int csi2rx_configure_ext_dphy(struct csi2rx_priv *csi2rx)
>   {
>   	union phy_configure_opts opts = { };
> +	struct phy_configure_opts_mipi_dphy *cfg = &opts.mipi_dphy;
> +	struct v4l2_subdev_format sd_fmt = {
> +		.which	= V4L2_SUBDEV_FORMAT_ACTIVE,
> +		.pad	= CSI2RX_PAD_SINK,
> +		.stream	= 0,

I would drop the above line, as this doesn't support streams yet.

> +	};
> +	const struct csi2rx_fmt *fmt;
> +	s64 link_freq;
>   	int ret;
>   
> +	ret = v4l2_subdev_call_state_active(&csi2rx->subdev, pad, get_fmt,
> +					    &sd_fmt);
> +	if (ret < 0)
> +		return ret;
> +
> +	fmt = csi2rx_get_fmt_by_code(sd_fmt.format.code);
> +
> +	link_freq = v4l2_get_link_freq(csi2rx->source_subdev->ctrl_handler,
> +				       fmt->bpp, 2 * csi2rx->num_lanes);
> +	if (link_freq < 0)
> +		return link_freq;
> +
> +	ret = phy_mipi_dphy_get_default_config_for_hsclk(link_freq,
> +							 csi2rx->num_lanes, cfg);
> +	if (ret)
> +		return ret;
> +
>   	ret = phy_power_on(csi2rx->dphy);
>   	if (ret)
>   		return ret;
> 

I think this is fine, but a few things to think about:

Here you lock and unlock the active state for the duration of the 
get_fmt call (and you call it for this same subdev). If the driver 
supports active state, and you need to get the fmt of the driver's 
subdev, I think it usually makes more sense to just use the state and 
get the format from there.

And you might want to keep the active state locked for the duration of 
the s_stream operation, in which case the state would already be locked 
when csi2rx_configure_ext_dphy() gets called.

And if you implement enable_streams/disable_streams, then the state has 
already been locked by the framework. However, I think 
enable_streams/disable_streams only works if the driver actually 
supports streams.

But maybe you have already done all these with the out-of-tree streams 
support?

Anyway, I think this is fine for now:

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

  Tomi

