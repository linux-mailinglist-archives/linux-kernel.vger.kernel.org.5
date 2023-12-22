Return-Path: <linux-kernel+bounces-9957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7612581CDE4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 18:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7D6E1C2248E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE3930D07;
	Fri, 22 Dec 2023 17:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DgAoPUop"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AFE2EAE1;
	Fri, 22 Dec 2023 17:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3368d1c7b23so1336731f8f.0;
        Fri, 22 Dec 2023 09:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703266948; x=1703871748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/kgyib+/6QRevWIU1dtxLSbx62QPgtFJTlVAtzjG6Is=;
        b=DgAoPUopw05zK9RNEJwNjb/El2mEa79NaoPmCy/rE0fsdXn0BGD9h1P/w/rT7G3PU2
         FzctkPprZNuVOnnP9W7d5ud/twRWrQYUfB2hevv3CJ3gAjUtBo175r/HIMV/2qoff1MF
         b6uTg200lAt9UeIhyUfR3fUhr3SVapqkIJavCYsUNnedYwvTH6LnW7Yf1uUNvuUCEWbP
         Dm4z4NU5YwZs94bVARWWUj3Q0JcCtZs6dk3jZVlSu3XwP2Lap8kl6r84TYhpYBioSsMN
         kUuHZpo4nBTuy3Zi/dsOAkhUG9qipUoi2oC6uom+i7qgTMsC5jDynE/wOREk8k2Nqi/c
         Qfvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703266948; x=1703871748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/kgyib+/6QRevWIU1dtxLSbx62QPgtFJTlVAtzjG6Is=;
        b=nO+a6Q2QqOkrVus0lf94nPF0/IN39Vlj5ELcpeJC9H4D3u7hqLxohHCOXI+2aNRwZX
         ERsmGunHFm4oHeprkw3KBVfpi+nNEl3PDdn9EuVZ2QCmlMoldVia6p5ocdz/6tUpu+gi
         JEpwIbdN7bJFFez5hqTxr9LlcvDcwciDJiCMFPEUCeDTFkG67QMoNB7xkLsN581lPUD3
         MeKx+Oi9y7NKtQLavGY0LO/WZgr7CQBwgnDpuMZwThKtelScwMo0e2ef045oidL6mQSd
         QRXniePziw1v7p+ssFRSrXKGx/t+gdxFOn5hBF1DGb9JZSCUwuyPkP6m4UjaOtInpbld
         HgkA==
X-Gm-Message-State: AOJu0YxJ2jArkeOyWv4aVURk+AlJM/7YJDfuHYZFuioETE5u+60mI4u/
	l4evFTZOcWyAtvudO2w6Jw==
X-Google-Smtp-Source: AGHT+IEt/69sUBqxWe1PRE1w6MCXmB6NT4MwzHjZjfhAIB1uVmcCKnZlBEfqCpNWf7fYGOh8JR0yEw==
X-Received: by 2002:adf:e911:0:b0:336:4bfe:5ab2 with SMTP id f17-20020adfe911000000b003364bfe5ab2mr864375wrm.8.1703266948004;
        Fri, 22 Dec 2023 09:42:28 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:f3ae:2788:7e03:f44])
        by smtp.gmail.com with ESMTPSA id w10-20020adfec4a000000b00336670abdcasm4777116wrn.40.2023.12.22.09.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 09:42:27 -0800 (PST)
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
Subject: [PATCH v4 08/29] drm/rockchip: inno_hdmi: no need to store vic
Date: Fri, 22 Dec 2023 18:41:59 +0100
Message-ID: <20231222174220.55249-9-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231222174220.55249-1-knaerzche@gmail.com>
References: <20231222174220.55249-1-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maxime Ripard <mripard@kernel.org>

The mode's VIC is only ever used in the inno_hdmi_setup() function so
there's no need to store it in the main structure.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
Tested-by: Alex Bee <knaerzche@gmail.com>
[made checkpatch happy]
Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
changes in v2:
 - imported patch

changes in v3:
 - none

changes in v4:
 - none

 drivers/gpu/drm/rockchip/inno_hdmi.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index 299770e481b7..d99896f1a73a 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -28,7 +28,6 @@
 #include "inno_hdmi.h"
 
 struct hdmi_data_info {
-	int vic;
 	bool sink_has_audio;
 	unsigned int enc_in_format;
 	unsigned int enc_out_format;
@@ -443,16 +442,15 @@ static int inno_hdmi_setup(struct inno_hdmi *hdmi,
 			   struct drm_display_mode *mode)
 {
 	struct drm_display_info *display = &hdmi->connector.display_info;
-
-	hdmi->hdmi_data.vic = drm_match_cea_mode(mode);
+	u8 vic = drm_match_cea_mode(mode);
 
 	hdmi->hdmi_data.enc_in_format = HDMI_COLORSPACE_RGB;
 	hdmi->hdmi_data.enc_out_format = HDMI_COLORSPACE_RGB;
 
-	if ((hdmi->hdmi_data.vic == 6) || (hdmi->hdmi_data.vic == 7) ||
-	    (hdmi->hdmi_data.vic == 21) || (hdmi->hdmi_data.vic == 22) ||
-	    (hdmi->hdmi_data.vic == 2) || (hdmi->hdmi_data.vic == 3) ||
-	    (hdmi->hdmi_data.vic == 17) || (hdmi->hdmi_data.vic == 18))
+	if (vic == 6 || vic == 7 ||
+	    vic == 21 || vic == 22 ||
+	    vic == 2 || vic == 3 ||
+	    vic == 17 || vic == 18)
 		hdmi->hdmi_data.colorimetry = HDMI_COLORIMETRY_ITU_601;
 	else
 		hdmi->hdmi_data.colorimetry = HDMI_COLORIMETRY_ITU_709;
-- 
2.43.0


