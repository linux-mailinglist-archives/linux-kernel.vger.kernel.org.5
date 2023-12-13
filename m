Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4EC2811F6B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233726AbjLMTvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:51:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377931AbjLMTvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:51:24 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224F2DC;
        Wed, 13 Dec 2023 11:51:31 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40c46d6784eso34793475e9.3;
        Wed, 13 Dec 2023 11:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702497089; x=1703101889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sSS4lcTIGbMXkzXHnajhTMjU7KSYMMCUlsf0C4cS0VI=;
        b=DA42hTmNzdYhM6vWCT9grgW3ch5sEOkwVO1S8FSagUYe8/k9Aa9WmhvNf6+DjBXdyh
         HgylTwC/8sQrvu3jIVnF9EgFShmflcxWtb5YJRzgCyfvsl7AA/C0vHsUmbuRnLi4VYto
         irewCGYKJUIE2/mQKAN8H1Y11bazIsjjZuXNilp7Z33OxJ4rGC7KZ6s6evK9CUiXLOlq
         UThDYz8PcDJwOFabk1GS0ncwshfGm2Kp3vO1CCP4yXKCzKjanxnkbOdDL8oZluZawjTc
         kVdlUd7LOlRzlqQZbOx7tBgL6Jdok3RsMb91zrJVlU6ZevxbuvjP7kInUPJudEIaj84g
         k07w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702497089; x=1703101889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sSS4lcTIGbMXkzXHnajhTMjU7KSYMMCUlsf0C4cS0VI=;
        b=pAkYRsV4GSbMZ2BK+eG3V6hAqDndufqxC259LQ1NMV5GTp2iNmbk3D+bvCfp4zZVwB
         kAuW+mZkCs3860cqmy9d/CjGPvwbkuiNM7mmNm8je2NLPX3RP/3Vkg61SQwpdUciAFQb
         FNjBSgcGyOF+H0kYz467kKi4NjtM2SheVmf5WXG4GJ8Ez1ofpnWXpUMX1AMKiiaagwRt
         HrgLz27viUxP3DvxYAgJ9mkmnXNhs7W4zBkUvu5GLoMdhXkv2zdsCdZAL9nSSVLZXT8+
         1Hc6/CzdUP68c2zBhcs8Ot2oGG0gd1a/Agfc071GvAj7oQxBY2DluoKV4axN5jBhJCyt
         slww==
X-Gm-Message-State: AOJu0YxI2zBO65DE/4kBiuYigW0GQTt6giMkT+/bln8Rco0fdc7u7Jly
        tTlNpOKXrz72EDMr4dQi7g==
X-Google-Smtp-Source: AGHT+IEL8LZfudHWsCE9Gg/1An8TCTsUvrAJyoygGbQu539fT0PvYfdS0tzUat19DdSrjW62zZZjHw==
X-Received: by 2002:a05:600c:3657:b0:40c:2d85:3a13 with SMTP id y23-20020a05600c365700b0040c2d853a13mr4530961wmq.185.1702497089612;
        Wed, 13 Dec 2023 11:51:29 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:92dc:8b1c:e01c:b93c])
        by smtp.gmail.com with ESMTPSA id fm14-20020a05600c0c0e00b00407b93d8085sm24050698wmb.27.2023.12.13.11.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 11:51:29 -0800 (PST)
From:   Alex Bee <knaerzche@gmail.com>
To:     Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        Andy Yan <andyshrk@163.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH 04/11] drm/rockchip: inno_hdmi: Correctly setup HDMI quantization range
Date:   Wed, 13 Dec 2023 20:51:18 +0100
Message-ID: <20231213195125.212923-5-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231213195125.212923-1-knaerzche@gmail.com>
References: <20231213195125.212923-1-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The display controller will always give full range RGB regardless of the
mode set, but HDMI requires certain modes to be transmitted in limited
range RGB. This is especially required for HDMI sinks which do not support
non-standard quantization ranges.

This enables color space conversion for those modes and sets the
quantization range accordingly in the AVI infoframe.

Fixes: 412d4ae6b7a5 ("drm/rockchip: hdmi: add Innosilicon HDMI support")
Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 drivers/gpu/drm/rockchip/inno_hdmi.c | 40 ++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index 345253e033c5..32626a75723c 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -33,6 +33,7 @@ struct hdmi_data_info {
 	unsigned int enc_in_format;
 	unsigned int enc_out_format;
 	unsigned int colorimetry;
+	bool rgb_limited_range;
 };
 
 struct inno_hdmi_i2c {
@@ -308,6 +309,18 @@ static int inno_hdmi_config_video_avi(struct inno_hdmi *hdmi,
 	else
 		frame.avi.colorspace = HDMI_COLORSPACE_RGB;
 
+	if (hdmi->hdmi_data.enc_out_format == HDMI_COLORSPACE_RGB) {
+		drm_hdmi_avi_infoframe_quant_range(&frame.avi,
+						   &hdmi->connector, mode,
+						   hdmi->hdmi_data.rgb_limited_range ?
+						   HDMI_QUANTIZATION_RANGE_LIMITED :
+						   HDMI_QUANTIZATION_RANGE_FULL);
+	} else {
+		frame.avi.quantization_range = HDMI_QUANTIZATION_RANGE_DEFAULT;
+		frame.avi.ycc_quantization_range =
+			HDMI_YCC_QUANTIZATION_RANGE_LIMITED;
+	}
+
 	return inno_hdmi_upload_frame(hdmi, rc, &frame, INFOFRAME_AVI, 0, 0, 0);
 }
 
@@ -334,14 +347,22 @@ static int inno_hdmi_config_video_csc(struct inno_hdmi *hdmi)
 	if (data->enc_in_format == data->enc_out_format) {
 		if ((data->enc_in_format == HDMI_COLORSPACE_RGB) ||
 		    (data->enc_in_format >= HDMI_COLORSPACE_YUV444)) {
-			value = v_SOF_DISABLE | v_COLOR_DEPTH_NOT_INDICATED(1);
-			hdmi_writeb(hdmi, HDMI_VIDEO_CONTRL3, value);
-
-			hdmi_modb(hdmi, HDMI_VIDEO_CONTRL,
-				  m_VIDEO_AUTO_CSC | m_VIDEO_C0_C2_SWAP,
-				  v_VIDEO_AUTO_CSC(AUTO_CSC_DISABLE) |
-				  v_VIDEO_C0_C2_SWAP(C0_C2_CHANGE_DISABLE));
-			return 0;
+			if (data->enc_in_format == HDMI_COLORSPACE_RGB &&
+			    data->enc_out_format == HDMI_COLORSPACE_RGB &&
+			    hdmi->hdmi_data.rgb_limited_range) {
+				csc_mode = CSC_RGB_0_255_TO_RGB_16_235_8BIT;
+				auto_csc = AUTO_CSC_DISABLE;
+				c0_c2_change = C0_C2_CHANGE_DISABLE;
+				csc_enable = v_CSC_ENABLE;
+			} else {
+				value = v_SOF_DISABLE | v_COLOR_DEPTH_NOT_INDICATED(1);
+				hdmi_writeb(hdmi, HDMI_VIDEO_CONTRL3, value);
+				hdmi_modb(hdmi, HDMI_VIDEO_CONTRL,
+					  m_VIDEO_AUTO_CSC | m_VIDEO_C0_C2_SWAP,
+					  v_VIDEO_AUTO_CSC(AUTO_CSC_DISABLE) |
+					  v_VIDEO_C0_C2_SWAP(C0_C2_CHANGE_DISABLE));
+				return 0;
+			}
 		}
 	}
 
@@ -458,6 +479,9 @@ static int inno_hdmi_setup(struct inno_hdmi *hdmi,
 	else
 		hdmi->hdmi_data.colorimetry = HDMI_COLORIMETRY_ITU_709;
 
+	hdmi->hdmi_data.rgb_limited_range =
+		drm_default_rgb_quant_range(mode) == HDMI_QUANTIZATION_RANGE_LIMITED;
+
 	/* Mute video and audio output */
 	hdmi_modb(hdmi, HDMI_AV_MUTE, m_AUDIO_MUTE | m_VIDEO_BLACK,
 		  v_AUDIO_MUTE(1) | v_VIDEO_MUTE(1));
-- 
2.43.0

