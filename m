Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32A480DE30
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 23:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjLKWMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 17:12:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345736AbjLKWKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 17:10:47 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A17E3;
        Mon, 11 Dec 2023 14:10:54 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 53AAA922;
        Mon, 11 Dec 2023 23:10:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1702332608;
        bh=VrTyIgpUM/k+qU2dG83GSARqhJhB72+1d672e8YuOxE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cHIjNOp3A6ptDnnGiSAxFtLA2NzdWvnTer1TEtKORcEau2KGFZ1gx2Kuq+fHA/i9G
         V0xHHbM9aL08OXw5b4HQPSRAVcQeR1UvWdQz0TaD0qt6wW3uo0ZjEJlQU3AvXj/jD+
         OOo/8sYxjHMSRdto7bdC+WLfSavGhSIh/QLWdQdE=
Date:   Tue, 12 Dec 2023 00:10:59 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Mikhail Rudenko <mike.rudenko@gmail.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH 11/19] media: i2c: ov4689: Implement vflip/hflip controls
Message-ID: <20231211221059.GJ27535@pendragon.ideasonboard.com>
References: <20231211175023.1680247-1-mike.rudenko@gmail.com>
 <20231211175023.1680247-12-mike.rudenko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231211175023.1680247-12-mike.rudenko@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mikhail,

Thank you for the patch.

On Mon, Dec 11, 2023 at 08:50:14PM +0300, Mikhail Rudenko wrote:
> The OV4689 sensor supports horizontal and vertical flipping. Add
> appropriate controls to the driver. Toggling both array flip and
> digital flip bits allows to achieve flipping while maintaining output
> Bayer order. Note that the default value of hflip control corresponds
> to both bits set, as it was before this patch.

What happens if only hlip or vflip is set, does the bayer pattern change
?

Sakari, I think this patch could use your attention.

> Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
> ---
>  drivers/media/i2c/ov4689.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
> index 67d4004bdcfb..62aeae43d749 100644
> --- a/drivers/media/i2c/ov4689.c
> +++ b/drivers/media/i2c/ov4689.c
> @@ -46,6 +46,14 @@
>  #define OV4689_HTS_DIVIDER		4
>  #define OV4689_HTS_MAX			0x7fff
>  
> +#define OV4689_REG_TIMING_FORMAT1	CCI_REG8(0x3820)
> +#define OV4689_REG_TIMING_FORMAT2	CCI_REG8(0x3821)
> +#define OV4689_TIMING_FLIP_MASK		GENMASK(2, 1)
> +#define OV4689_TIMING_FLIP_ARRAY	BIT(1)
> +#define OV4689_TIMING_FLIP_DIGITAL	BIT(2)
> +#define OV4689_TIMING_FLIP_BOTH		(OV4689_TIMING_FLIP_ARRAY |\
> +					 OV4689_TIMING_FLIP_DIGITAL)
> +
>  #define OV4689_LANES			4
>  #define OV4689_XVCLK_FREQ		24000000
>  
> @@ -183,7 +191,6 @@ static const struct cci_reg_sequence ov4689_2688x1520_regs[] = {
>  	{CCI_REG8(0x3811), 0x08}, /* H_WIN_OFF_L h_win_off[7:0] = 0x08*/
>  	{CCI_REG8(0x3813), 0x04}, /* V_WIN_OFF_L v_win_off[7:0] = 0x04 */
>  	{CCI_REG8(0x3819), 0x01}, /* VSYNC_END_L vsync_end_point[7:0] = 0x01 */
> -	{CCI_REG8(0x3821), 0x06}, /* TIMING_FORMAT2 array_h_mirror = 1, digital_h_mirror = 1 */
>  
>  	/* OTP control */
>  	{CCI_REG8(0x3d85), 0x36}, /* OTP_REG85 OTP_power_up_load_setting_enable = 1,
> @@ -605,6 +612,16 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
>  			  (val + ov4689->cur_mode->width) /
>  			  OV4689_HTS_DIVIDER, &ret);
>  		break;
> +	case V4L2_CID_VFLIP:
> +		cci_update_bits(regmap, OV4689_REG_TIMING_FORMAT1,
> +				OV4689_TIMING_FLIP_MASK,
> +				val ? OV4689_TIMING_FLIP_BOTH : 0, &ret);
> +		break;
> +	case V4L2_CID_HFLIP:
> +		cci_update_bits(regmap, OV4689_REG_TIMING_FORMAT2,
> +				OV4689_TIMING_FLIP_MASK,
> +				val ? 0 : OV4689_TIMING_FLIP_BOTH, &ret);
> +		break;
>  	default:
>  		dev_warn(dev, "%s Unhandled id:0x%x, val:0x%x\n",
>  			 __func__, ctrl->id, val);
> @@ -633,7 +650,7 @@ static int ov4689_initialize_controls(struct ov4689 *ov4689)
>  
>  	handler = &ov4689->ctrl_handler;
>  	mode = ov4689->cur_mode;
> -	ret = v4l2_ctrl_handler_init(handler, 11);
> +	ret = v4l2_ctrl_handler_init(handler, 13);

This should be 12 if my comment on 10/19 is correct. Further patches in
the series may need to be adjusted too.

>  	if (ret)
>  		return ret;
>  
> @@ -673,6 +690,9 @@ static int ov4689_initialize_controls(struct ov4689 *ov4689)
>  				     ARRAY_SIZE(ov4689_test_pattern_menu) - 1,
>  				     0, 0, ov4689_test_pattern_menu);
>  
> +	v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops, V4L2_CID_VFLIP, 0, 1, 1, 0);
> +	v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops, V4L2_CID_HFLIP, 0, 1, 1, 0);
> +
>  	if (handler->error) {
>  		ret = handler->error;
>  		dev_err(ov4689->dev, "Failed to init controls(%d)\n", ret);

-- 
Regards,

Laurent Pinchart
