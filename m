Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1A2812E63
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443797AbjLNLR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:17:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443730AbjLNLRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:17:55 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE2011D;
        Thu, 14 Dec 2023 03:17:59 -0800 (PST)
Received: from i53875b61.versanet.de ([83.135.91.97] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1rDjii-0002lZ-0Q; Thu, 14 Dec 2023 12:17:36 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Maxime Ripard <mripard@kernel.org>, Alex Bee <knaerzche@gmail.com>
Cc:     Sandy Huang <hjc@rock-chips.com>, Andy Yan <andyshrk@163.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/11] drm/rockchip: inno_hdmi: Correctly setup HDMI quantization
 range
Date:   Thu, 14 Dec 2023 12:17:34 +0100
Message-ID: <3053311.k3LOHGUjKi@diego>
In-Reply-To: <5f4fc919-681f-44ec-bd44-5788e5b718ca@gmail.com>
References: <20231213195125.212923-1-knaerzche@gmail.com>
 <w7cj24se5gjomfynp5yindnh3s2pea4p3f46u6y7lcci7hri32@62i6hg26pheb>
 <5f4fc919-681f-44ec-bd44-5788e5b718ca@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 14. Dezember 2023, 12:12:08 CET schrieb Alex Bee:
> Hi Maxime
> 
> Am 14.12.23 um 08:56 schrieb Maxime Ripard:
> > Hi Alex,
> >
> > Thanks for working on this!
> >
> > On Wed, Dec 13, 2023 at 08:51:18PM +0100, Alex Bee wrote:
> >> The display controller will always give full range RGB regardless of the
> >> mode set, but HDMI requires certain modes to be transmitted in limited
> >> range RGB. This is especially required for HDMI sinks which do not support
> >> non-standard quantization ranges.
> >>
> >> This enables color space conversion for those modes and sets the
> >> quantization range accordingly in the AVI infoframe.
> >>
> >> Fixes: 412d4ae6b7a5 ("drm/rockchip: hdmi: add Innosilicon HDMI support")
> >> Signed-off-by: Alex Bee <knaerzche@gmail.com>
> >> ---
> >>   drivers/gpu/drm/rockchip/inno_hdmi.c | 40 ++++++++++++++++++++++------
> >>   1 file changed, 32 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
> >> index 345253e033c5..32626a75723c 100644
> >> --- a/drivers/gpu/drm/rockchip/inno_hdmi.c
> >> +++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
> >> @@ -33,6 +33,7 @@ struct hdmi_data_info {
> >>   	unsigned int enc_in_format;
> >>   	unsigned int enc_out_format;
> >>   	unsigned int colorimetry;
> >> +	bool rgb_limited_range;
> >>   };
> >>   
> >>   struct inno_hdmi_i2c {
> >> @@ -308,6 +309,18 @@ static int inno_hdmi_config_video_avi(struct inno_hdmi *hdmi,
> >>   	else
> >>   		frame.avi.colorspace = HDMI_COLORSPACE_RGB;
> >>   
> >> +	if (hdmi->hdmi_data.enc_out_format == HDMI_COLORSPACE_RGB) {
> >> +		drm_hdmi_avi_infoframe_quant_range(&frame.avi,
> >> +						   &hdmi->connector, mode,
> >> +						   hdmi->hdmi_data.rgb_limited_range ?
> >> +						   HDMI_QUANTIZATION_RANGE_LIMITED :
> >> +						   HDMI_QUANTIZATION_RANGE_FULL);
> >> +	} else {
> >> +		frame.avi.quantization_range = HDMI_QUANTIZATION_RANGE_DEFAULT;
> >> +		frame.avi.ycc_quantization_range =
> >> +			HDMI_YCC_QUANTIZATION_RANGE_LIMITED;
> >> +	}
> >> +
> >>   	return inno_hdmi_upload_frame(hdmi, rc, &frame, INFOFRAME_AVI, 0, 0, 0);
> >>   }
> >>   
> >> @@ -334,14 +347,22 @@ static int inno_hdmi_config_video_csc(struct inno_hdmi *hdmi)
> >>   	if (data->enc_in_format == data->enc_out_format) {
> >>   		if ((data->enc_in_format == HDMI_COLORSPACE_RGB) ||
> >>   		    (data->enc_in_format >= HDMI_COLORSPACE_YUV444)) {
> >> -			value = v_SOF_DISABLE | v_COLOR_DEPTH_NOT_INDICATED(1);
> >> -			hdmi_writeb(hdmi, HDMI_VIDEO_CONTRL3, value);
> >> -
> >> -			hdmi_modb(hdmi, HDMI_VIDEO_CONTRL,
> >> -				  m_VIDEO_AUTO_CSC | m_VIDEO_C0_C2_SWAP,
> >> -				  v_VIDEO_AUTO_CSC(AUTO_CSC_DISABLE) |
> >> -				  v_VIDEO_C0_C2_SWAP(C0_C2_CHANGE_DISABLE));
> >> -			return 0;
> >> +			if (data->enc_in_format == HDMI_COLORSPACE_RGB &&
> >> +			    data->enc_out_format == HDMI_COLORSPACE_RGB &&
> >> +			    hdmi->hdmi_data.rgb_limited_range) {
> >> +				csc_mode = CSC_RGB_0_255_TO_RGB_16_235_8BIT;
> >> +				auto_csc = AUTO_CSC_DISABLE;
> >> +				c0_c2_change = C0_C2_CHANGE_DISABLE;
> >> +				csc_enable = v_CSC_ENABLE;
> >> +			} else {
> >> +				value = v_SOF_DISABLE | v_COLOR_DEPTH_NOT_INDICATED(1);
> >> +				hdmi_writeb(hdmi, HDMI_VIDEO_CONTRL3, value);
> >> +				hdmi_modb(hdmi, HDMI_VIDEO_CONTRL,
> >> +					  m_VIDEO_AUTO_CSC | m_VIDEO_C0_C2_SWAP,
> >> +					  v_VIDEO_AUTO_CSC(AUTO_CSC_DISABLE) |
> >> +					  v_VIDEO_C0_C2_SWAP(C0_C2_CHANGE_DISABLE));
> >> +				return 0;
> >> +			}
> >>   		}
> >>   	}
> >>   
> >> @@ -458,6 +479,9 @@ static int inno_hdmi_setup(struct inno_hdmi *hdmi,
> >>   	else
> >>   		hdmi->hdmi_data.colorimetry = HDMI_COLORIMETRY_ITU_709;
> >>   
> >> +	hdmi->hdmi_data.rgb_limited_range =
> >> +		drm_default_rgb_quant_range(mode) == HDMI_QUANTIZATION_RANGE_LIMITED;
> >> +
> > This patch conflicts heavily with my inno_hdmi patches here (patches 22 to 38):
> > https://lore.kernel.org/dri-devel/20231207-kms-hdmi-connector-state-v5-0-6538e19d634d@kernel.org/
> I'm aware of that and I mentioned it in the cover letter. Your series is 
> not merged yet and it didn't get much feedback so far. What is the 
> status there? Especially because you are removing things from inno-hdmi 
> driver (which aren't really required to remove there) which will I have 
> to reintroduce.

Sadly I haven't found the time to look closer at Maxime's series so far,
but I got the impression that it separates into multiple cleanup steps
for a number of controllers.

So the sentence below suggests that Maxime wanted you to pick the
appropriate patches from there and incorporate them into your series
(as it looks like you developed a nice working knowledge of the inno-hdmi
driver). So there is no need to first drop and then reintroduce stuff, but
there may be other interesting cleanups there.

> > I would appreciate if you could test and merge them into your series.


Heiko

> > In particular, there's no need to store the range here: enc_out_format
> rgb_limited_range is currently not only used for csc, but also for for 
> infoframe creation. So it makes sense to have this stored  to avoid 
> calling drm_default_rgb_quant_range twice.
> 
> > is always RGB, so you'll always end up calling
> > drm_hdmi_avi_infoframe_quant_range(), and you'll always have the same csc values.
> 
> I don't think that's true. Non-VIC modes like 800x600 or 1024x764 want 
> full range RGB and csc must not be done in those cases.




