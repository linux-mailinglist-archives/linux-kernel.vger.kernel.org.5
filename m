Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7B776C9C8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 11:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjHBJrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 05:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbjHBJrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 05:47:05 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1000D210D;
        Wed,  2 Aug 2023 02:46:54 -0700 (PDT)
Received: from [192.168.88.20] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5039A2AC;
        Wed,  2 Aug 2023 11:45:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1690969549;
        bh=mWLrVrwIENQP6yWA740jG3Jkt4JmjdTN4/c8G9DqSSI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=uySHVHN5SHkxBg4EUtkJjR8WiiSPxy+vFXV3TL4W/jLBDWIYLH41f/KbGr8snh/Ev
         QvSKJBHF5CRIsybGJ2mgpA15oPU/eI359SFrIIDFHW2GuNr5hgB26ds6TC3MWEc90h
         yiWn8x5hopHZdzBdFenMQR/uPYvmu0H9POvuXw5Q=
Message-ID: <96a8ca70-9957-bb4f-088c-c0895a9e7347@ideasonboard.com>
Date:   Wed, 2 Aug 2023 12:46:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 14/16] media: cadence: csi2rx: Support RAW8 and RAW10
 formats
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
 <20230731-upstream_csi-v8-14-fb7d3661c2c9@ti.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20230731-upstream_csi-v8-14-fb7d3661c2c9@ti.com>
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
> Many CSI-2 sensors (specifically IMX219) send RAW bayer data instead of
> processed YUV or RGB, so add support for 8-bit and 10-bit bayer formats.
> 
> Signed-off-by: Jai Luthra <j-luthra@ti.com>
> ---
> New in v8
> 
>   drivers/media/platform/cadence/cdns-csi2rx.c | 32 ++++++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
> index aec33d28a66f..bac74474841a 100644
> --- a/drivers/media/platform/cadence/cdns-csi2rx.c
> +++ b/drivers/media/platform/cadence/cdns-csi2rx.c
> @@ -122,6 +122,38 @@ static const struct csi2rx_fmt formats[] = {
>   		.code	= MEDIA_BUS_FMT_VYUY8_1X16,
>   		.bpp	= 16,
>   	},
> +	{
> +		.code	= MEDIA_BUS_FMT_SBGGR8_1X8,
> +		.bpp	= 8,
> +	},
> +	{
> +		.code	= MEDIA_BUS_FMT_SGBRG8_1X8,
> +		.bpp	= 8,
> +	},
> +	{
> +		.code	= MEDIA_BUS_FMT_SGRBG8_1X8,
> +		.bpp	= 8,
> +	},
> +	{
> +		.code	= MEDIA_BUS_FMT_SRGGB8_1X8,
> +		.bpp	= 8,
> +	},
> +	{
> +		.code	= MEDIA_BUS_FMT_SBGGR10_1X10,
> +		.bpp	= 10,
> +	},
> +	{
> +		.code	= MEDIA_BUS_FMT_SGBRG10_1X10,
> +		.bpp	= 10,
> +	},
> +	{
> +		.code	= MEDIA_BUS_FMT_SGRBG10_1X10,
> +		.bpp	= 10,
> +	},
> +	{
> +		.code	= MEDIA_BUS_FMT_SRGGB10_1X10,
> +		.bpp	= 10,
> +	},
>   };
>   
>   static const struct csi2rx_fmt *csi2rx_get_fmt_by_code(u32 code)
> 

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

  Tomi

