Return-Path: <linux-kernel+bounces-5622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10796818D54
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9E5A1F27142
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA6B3529E;
	Tue, 19 Dec 2023 17:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ta/9uy1/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CD8225B2;
	Tue, 19 Dec 2023 17:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40c31f18274so60641185e9.0;
        Tue, 19 Dec 2023 09:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703005270; x=1703610070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qdMgjNjNBTOoBWK3IcfrwTBNKKERl2lF+r21sur0UJs=;
        b=Ta/9uy1/8PccdVsFFp1ufiSWHMMrCDRdnR40j8GTpc95C86lkETLc0y1fsHnVB/4yv
         Icsi7IHavPDze7bFXxhB1l+TnDUHBl/s2TWMrbBCdmfaKTC0PhRNEu0YzcZohM4uU+/9
         yst7zlz/0TtWgjq5oGFvpFZ22sybHCflwP497ZKYLRsy/JqpuOnBJyrp/8hwrNMzNRal
         ecv3NkcTXOwxsXzMU3DEopYxUXrsCEPwj93Xnm8VnDdOwYav6It/qSRh+vxa0oRMv8t3
         hFpnY+XBFEE/x8bwcL7eRU5d+9mkIQvT4uVqcKGgnclGJroqCaqStGgMPXGfI+bzy6OW
         /7jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703005270; x=1703610070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qdMgjNjNBTOoBWK3IcfrwTBNKKERl2lF+r21sur0UJs=;
        b=olGPu2GsLb6xb7vdwXWtxHCXWtuqgXuYN1trHYdQsil6YYDMC90lGmluGEz+TZI9XE
         1Clu1gJ7WKkHo7ULYIhBitWUHJHt/WjT+SGDBCdY8H8QImVn5cvYDXVfHamRoMN+m1d4
         SZZ1je6Qz0XKaiBzBiONzwMH683ic9rVih/beK6D7LcbUWxUmIf7y88NuLOXFivnrRV3
         0wQXuxQmYUp2P4+BBiktXK8/YUjcOpDa7se57NyQs0satjm85DFcYhCxZDBvFesVh9P2
         ntq4FaK7xtRSx8ZhugTexN65U8GGEpROXOaAI1KwyZSwkXsr59CdX6MszBQVm6CgF9ua
         SjDQ==
X-Gm-Message-State: AOJu0YxxRdrBnB1OdbSNNi/Ajy57qiUvDzICAjxdvMhYKwRTjFA38nsi
	lsx/RDZt5+RJb44VbGRbJg==
X-Google-Smtp-Source: AGHT+IEkfFJDXwsv4Zfxm5NA1za7VpADdznfWYCyodddd8eXDeufpwxwQM+20Je7C3cazgS46y7cEw==
X-Received: by 2002:a1c:7218:0:b0:40c:317e:7cb0 with SMTP id n24-20020a1c7218000000b0040c317e7cb0mr8717116wmc.158.1703005270277;
        Tue, 19 Dec 2023 09:01:10 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:7ae5:3e:d1c6:a138])
        by smtp.gmail.com with ESMTPSA id i7-20020a05600c354700b0040d2805d158sm3225878wmq.48.2023.12.19.09.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 09:01:09 -0800 (PST)
From: Alex Bee <knaerzche@gmail.com>
To: Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v3 04/29] drm/rockchip: inno_hdmi: Remove useless mode_fixup
Date: Tue, 19 Dec 2023 18:00:34 +0100
Message-ID: <20231219170100.188800-5-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231219170100.188800-1-knaerzche@gmail.com>
References: <20231219170100.188800-1-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maxime Ripard <mripard@kernel.org>

The mode_fixup implementation doesn't do anything, so we can simply
remove it.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
Tested-by: Alex Bee <knaerzche@gmail.com>
Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
changes in v2:
 - imported patch

changes in v3:
 - added my SoB

 drivers/gpu/drm/rockchip/inno_hdmi.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index 345253e033c5..0b1740b38c7b 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -517,13 +517,6 @@ static void inno_hdmi_encoder_disable(struct drm_encoder *encoder)
 	inno_hdmi_set_pwr_mode(hdmi, LOWER_PWR);
 }
 
-static bool inno_hdmi_encoder_mode_fixup(struct drm_encoder *encoder,
-					 const struct drm_display_mode *mode,
-					 struct drm_display_mode *adj_mode)
-{
-	return true;
-}
-
 static int
 inno_hdmi_encoder_atomic_check(struct drm_encoder *encoder,
 			       struct drm_crtc_state *crtc_state,
@@ -540,7 +533,6 @@ inno_hdmi_encoder_atomic_check(struct drm_encoder *encoder,
 static struct drm_encoder_helper_funcs inno_hdmi_encoder_helper_funcs = {
 	.enable     = inno_hdmi_encoder_enable,
 	.disable    = inno_hdmi_encoder_disable,
-	.mode_fixup = inno_hdmi_encoder_mode_fixup,
 	.mode_set   = inno_hdmi_encoder_mode_set,
 	.atomic_check = inno_hdmi_encoder_atomic_check,
 };
-- 
2.43.0


