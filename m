Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6619B7BF1E6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 06:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442045AbjJJEQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 00:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376812AbjJJEQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 00:16:31 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543E892;
        Mon,  9 Oct 2023 21:16:29 -0700 (PDT)
Received: from [IPV6:2405:201:2033:3002:3848:5d20:59c9:c87c] (unknown [IPv6:2405:201:2033:3002:3848:5d20:59c9:c87c])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7D1A53D9;
        Tue, 10 Oct 2023 06:16:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1696911386;
        bh=ZcJzu6ksG69iS2FLKK/1KRw++ChuE2tVK7aDih6JTTw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jBMe1UzfaxXx75cf/I/3tsKbaQ8ktA3FBcW3UP6qbZ3UF9w27EzQYj83MnDM31mtp
         bbJv3m9LcHJr6+mgPpMoE6sekE1bYAHoODmSnT/4rXZLAgkXVy/RXz476/7JcppOZl
         cRhlaAD2rnkePy/yWLK/wYQu5XcKd+zyPCBXOIGU=
Message-ID: <67bb5809-5bf4-5f10-de9d-b7aee4f80117@ideasonboard.com>
Date:   Tue, 10 Oct 2023 09:46:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 3/5] media: i2c: imx335: Implement get selection API
Content-Language: en-US
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org
Cc:     "Paul J. Murphy" <paul.j.murphy@intel.com>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20231010005126.3425444-1-kieran.bingham@ideasonboard.com>
 <20231010005126.3425444-4-kieran.bingham@ideasonboard.com>
From:   Umang Jain <umang.jain@ideasonboard.com>
In-Reply-To: <20231010005126.3425444-4-kieran.bingham@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran

On 10/10/23 6:21 AM, Kieran Bingham wrote:
> Support reporting of the Sensor Native and Active pixel array areas
> through the Selection API.
>
> The implementation reports a single target crop only for the mode that
> is presently exposed by the driver.
>
> Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>

LGTM,

Reviewed-by: Umang Jain <umang.jain@ideasonboard.com>

> ---
>   drivers/media/i2c/imx335.c | 44 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 44 insertions(+)
>
> diff --git a/drivers/media/i2c/imx335.c b/drivers/media/i2c/imx335.c
> index bf12b9b69fce..026777eb362e 100644
> --- a/drivers/media/i2c/imx335.c
> +++ b/drivers/media/i2c/imx335.c
> @@ -55,6 +55,14 @@
>   #define IMX335_REG_MIN		0x00
>   #define IMX335_REG_MAX		0xfffff
>   
> +/* IMX335 native and active pixel array size. */
> +#define IMX335_NATIVE_WIDTH		2616U
> +#define IMX335_NATIVE_HEIGHT		1964U
> +#define IMX335_PIXEL_ARRAY_LEFT		12U
> +#define IMX335_PIXEL_ARRAY_TOP		12U
> +#define IMX335_PIXEL_ARRAY_WIDTH	2592U
> +#define IMX335_PIXEL_ARRAY_HEIGHT	1944U
> +
>   /**
>    * struct imx335_reg - imx335 sensor register
>    * @address: Register address
> @@ -651,6 +659,41 @@ static int imx335_init_pad_cfg(struct v4l2_subdev *sd,
>   	return imx335_set_pad_format(sd, sd_state, &fmt);
>   }
>   
> +/**
> + * imx335_get_selection() - Selection API
> + * @sd: pointer to imx335 V4L2 sub-device structure
> + * @sd_state: V4L2 sub-device configuration
> + * @sel: V4L2 selection info
> + *
> + * Return: 0 if successful, error code otherwise.
> + */
> +static int imx335_get_selection(struct v4l2_subdev *sd,
> +				struct v4l2_subdev_state *sd_state,
> +				struct v4l2_subdev_selection *sel)
> +{
> +	switch (sel->target) {
> +	case V4L2_SEL_TGT_NATIVE_SIZE:
> +		sel->r.top = 0;
> +		sel->r.left = 0;
> +		sel->r.width = IMX335_NATIVE_WIDTH;
> +		sel->r.height = IMX335_NATIVE_HEIGHT;
> +
> +		return 0;
> +
> +	case V4L2_SEL_TGT_CROP:
> +	case V4L2_SEL_TGT_CROP_DEFAULT:
> +	case V4L2_SEL_TGT_CROP_BOUNDS:
> +		sel->r.top = IMX335_PIXEL_ARRAY_TOP;
> +		sel->r.left = IMX335_PIXEL_ARRAY_LEFT;
> +		sel->r.width = IMX335_PIXEL_ARRAY_WIDTH;
> +		sel->r.height = IMX335_PIXEL_ARRAY_HEIGHT;
> +
> +		return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +
>   /**
>    * imx335_start_streaming() - Start sensor stream
>    * @imx335: pointer to imx335 device
> @@ -864,6 +907,7 @@ static const struct v4l2_subdev_pad_ops imx335_pad_ops = {
>   	.init_cfg = imx335_init_pad_cfg,
>   	.enum_mbus_code = imx335_enum_mbus_code,
>   	.enum_frame_size = imx335_enum_frame_size,
> +	.get_selection = imx335_get_selection,
>   	.get_fmt = imx335_get_pad_format,
>   	.set_fmt = imx335_set_pad_format,
>   };

