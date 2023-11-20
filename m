Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288B77F195F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 18:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbjKTRHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 12:07:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbjKTRHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 12:07:02 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDEB2D6A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 09:06:47 -0800 (PST)
Received: from [194.95.143.137] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1r57jP-0000mH-3V; Mon, 20 Nov 2023 18:06:43 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     hjc@rock-chips.com, Johan Jonker <jbx6244@gmail.com>
Cc:     airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/4] drm/rockchip: rk3066_hdmi: Remove useless output format
Date:   Mon, 20 Nov 2023 18:06:42 +0100
Message-ID: <4308014.ejJDZkT8p0@phil>
In-Reply-To: <bb5cac77-a705-738e-13ae-667ea87f1cb1@gmail.com>
References: <cda574be-4f33-b66d-eb14-92c2b31d241e@gmail.com>
 <bb5cac77-a705-738e-13ae-667ea87f1cb1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

Am Donnerstag, 2. November 2023, 14:42:19 CET schrieb Johan Jonker:
> The Rk3066 hdmi output format is hard coded to RGB. Remove
> all useless code related to colorimetry and enc_out_format.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

I guess my first question is, is the hardcoding happening just because
of missing functionality in the driver, or does the hardware only
support RGB?


> ---
>  drivers/gpu/drm/rockchip/rk3066_hdmi.c | 20 +-------------------
>  1 file changed, 1 insertion(+), 19 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/rk3066_hdmi.c b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
> index 0e7aae341960..f2b1b2faa096 100644
> --- a/drivers/gpu/drm/rockchip/rk3066_hdmi.c
> +++ b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
> @@ -23,8 +23,6 @@
> 
>  struct hdmi_data_info {
>  	int vic; /* The CEA Video ID (VIC) of the current drm display mode. */
> -	unsigned int enc_out_format;
> -	unsigned int colorimetry;
>  };
> 
>  struct rk3066_hdmi_i2c {
> @@ -200,14 +198,7 @@ static int rk3066_hdmi_config_avi(struct rk3066_hdmi *hdmi,
>  	rc = drm_hdmi_avi_infoframe_from_display_mode(&frame.avi,
>  						      &hdmi->connector, mode);
> 
> -	if (hdmi->hdmi_data.enc_out_format == HDMI_COLORSPACE_YUV444)
> -		frame.avi.colorspace = HDMI_COLORSPACE_YUV444;
> -	else if (hdmi->hdmi_data.enc_out_format == HDMI_COLORSPACE_YUV422)
> -		frame.avi.colorspace = HDMI_COLORSPACE_YUV422;
> -	else
> -		frame.avi.colorspace = HDMI_COLORSPACE_RGB;
> -
> -	frame.avi.colorimetry = hdmi->hdmi_data.colorimetry;
> +	frame.avi.colorspace = HDMI_COLORSPACE_RGB;
>  	frame.avi.scan_mode = HDMI_SCAN_MODE_NONE;
> 
>  	return rk3066_hdmi_upload_frame(hdmi, rc, &frame,
> @@ -329,15 +320,6 @@ static int rk3066_hdmi_setup(struct rk3066_hdmi *hdmi,
>  	struct drm_display_info *display = &hdmi->connector.display_info;
> 
>  	hdmi->hdmi_data.vic = drm_match_cea_mode(mode);
> -	hdmi->hdmi_data.enc_out_format = HDMI_COLORSPACE_RGB;
> -
> -	if (hdmi->hdmi_data.vic == 6 || hdmi->hdmi_data.vic == 7 ||
> -	    hdmi->hdmi_data.vic == 21 || hdmi->hdmi_data.vic == 22 ||
> -	    hdmi->hdmi_data.vic == 2 || hdmi->hdmi_data.vic == 3 ||
> -	    hdmi->hdmi_data.vic == 17 || hdmi->hdmi_data.vic == 18)
> -		hdmi->hdmi_data.colorimetry = HDMI_COLORIMETRY_ITU_601;
> -	else
> -		hdmi->hdmi_data.colorimetry = HDMI_COLORIMETRY_ITU_709;

while I can understand the RGB output format, why does the colorimetry
also get removed? This looks like it is dependent on the mode itself
and not the output format?

Thanks
Heiko


