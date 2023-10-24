Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47BEB7D4907
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 09:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233269AbjJXHxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 03:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbjJXHxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 03:53:00 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A226E5;
        Tue, 24 Oct 2023 00:52:58 -0700 (PDT)
Received: from ideasonboard.com (93-61-96-190.ip145.fastwebnet.it [93.61.96.190])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 02F47B53;
        Tue, 24 Oct 2023 09:52:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1698133966;
        bh=LNElzporzpCaYnc+Rp+xusVwCai020KivGn+5e/4bF4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ord7kv3k2vxeOOVOiFf+QDLZTPQWrwSpUUuc9CSCkwirXdoVBGwyo2jvEWf/d7W4a
         LAGjvLuoopSMwUTVf4/2Cbh92qv0vfwSwowLAbEqa0fzghJ26klbK6QVtX0zdod516
         SuW1NPP9Q8spz3S3uizL29f6jSjhXGQa9d/XePjA=
Date:   Tue, 24 Oct 2023 09:52:44 +0200
From:   Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To:     =?utf-8?B?QW5kcsOp?= Apitzsch <git@apitzsch.eu>
Cc:     Ricardo Ribalda <ribalda@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 4/4] media: i2c: imx214: Add sensor's pixel matrix size
Message-ID: <56kgwl7zehsxy2pp7nziwk2gt6joax42qpzs6eywufvcto7qxm@ts4i3ccdokjr>
References: <20231023-imx214-v1-0-b33f1bbd1fcf@apitzsch.eu>
 <20231023-imx214-v1-4-b33f1bbd1fcf@apitzsch.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231023-imx214-v1-4-b33f1bbd1fcf@apitzsch.eu>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andre'

On Mon, Oct 23, 2023 at 11:47:53PM +0200, André Apitzsch wrote:
> Set effictive and active sensor pixel sizes as shown in product

s/effictive/effective

> brief[1].
>
> [1]: https://www.mouser.com/datasheet/2/897/ProductBrief_IMX214_20150428-1289331.pdf
>
> Signed-off-by: André Apitzsch <git@apitzsch.eu>
> ---
>  drivers/media/i2c/imx214.c | 39 ++++++++++++++++++++++++++++++++-------
>  1 file changed, 32 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/media/i2c/imx214.c b/drivers/media/i2c/imx214.c
> index bef8dc36e2d0..a2d441cd8dcd 100644
> --- a/drivers/media/i2c/imx214.c
> +++ b/drivers/media/i2c/imx214.c
> @@ -36,6 +36,14 @@
>  #define IMX214_EXPOSURE_STEP		1
>  #define IMX214_EXPOSURE_DEFAULT		0x0c70
>
> +/* IMX214 native and active pixel array size */
> +#define IMX214_NATIVE_WIDTH		4224U
> +#define IMX214_NATIVE_HEIGHT		3136U
> +#define IMX214_PIXEL_ARRAY_LEFT		8U
> +#define IMX214_PIXEL_ARRAY_TOP		8U
> +#define IMX214_PIXEL_ARRAY_WIDTH	4208U
> +#define IMX214_PIXEL_ARRAY_HEIGHT	3120U
> +

I do get slightly different numbers from the datasheet version I have

The sensor is said to have 4224x3208 total pixels of which 4208x3120
are active ones.

The pixel array diagram shows 64 "OPB" (optically black ?) lines,
followed by 8 dummy lines, followed by 3120 valid lines. There are 8
dummy columns at each side of the 4208 valid ones.

Now, NATIVE which represents the full pixel array size seems to be
4224x3208 (other parts of the datasheet only report 3200 lines though)

BOUNDS represents the readabale array area, which I presume
corresponds to what is named as 'effective area' by the datasheet. It
excludes the OPB lines at the top of the image and seems to be
represented by (0, 64, 4224, 3160).

CROP_DEFAULT represents the default crop rectangle which covers the
active pixel area, so it excludes 8 more lines of dummy pixels and 8
dummy columns, which gives a rectangle (8, 72, 4208, 3120)

Also note that the driver always reports a TGT_CROP rectangle with
top/left points set to 0. If my understanding is correct, V4L2
selection targets are defined from the most external target
(TGT_NATIVE in this case), and the driver should be corrected to
initialize the crop rectangle with a top-left corner at (8, 72).

Does this make sense ?

Thanks
  j


>  static const char * const imx214_supply_name[] = {
>  	"vdda",
>  	"vddd",
> @@ -634,14 +642,31 @@ static int imx214_get_selection(struct v4l2_subdev *sd,
>  {
>  	struct imx214 *imx214 = to_imx214(sd);
>
> -	if (sel->target != V4L2_SEL_TGT_CROP)
> -		return -EINVAL;
> +	switch (sel->target) {
> +	case V4L2_SEL_TGT_CROP:
> +		mutex_lock(&imx214->mutex);
> +		sel->r = *__imx214_get_pad_crop(imx214, sd_state, sel->pad,
> +						sel->which);
> +		mutex_unlock(&imx214->mutex);
> +		return 0;
>
> -	mutex_lock(&imx214->mutex);
> -	sel->r = *__imx214_get_pad_crop(imx214, sd_state, sel->pad,
> -					sel->which);
> -	mutex_unlock(&imx214->mutex);
> -	return 0;
> +	case V4L2_SEL_TGT_NATIVE_SIZE:
> +		sel->r.top = 0;
> +		sel->r.left = 0;
> +		sel->r.width = IMX214_NATIVE_WIDTH;
> +		sel->r.height = IMX214_NATIVE_HEIGHT;
> +		return 0;
> +
> +	case V4L2_SEL_TGT_CROP_DEFAULT:
> +	case V4L2_SEL_TGT_CROP_BOUNDS:
> +		sel->r.top = IMX214_PIXEL_ARRAY_TOP;
> +		sel->r.left = IMX214_PIXEL_ARRAY_LEFT;
> +		sel->r.width = IMX214_PIXEL_ARRAY_WIDTH;
> +		sel->r.height = IMX214_PIXEL_ARRAY_HEIGHT;
> +		return 0;
> +	}
> +
> +	return -EINVAL;
>  }
>
>  static int imx214_entity_init_cfg(struct v4l2_subdev *subdev,
>
> --
> 2.42.0
>
