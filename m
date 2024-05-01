Return-Path: <linux-kernel+bounces-165505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 220F78B8D64
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 17:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2CDA1F219D2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 15:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEC91304AB;
	Wed,  1 May 2024 15:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WVW8hAar"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAF412FF6B
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 15:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714578204; cv=none; b=tcLTiigOXyjWBRx7WIGMKa4MRqvaXEmKF3qMCXmRyQFbLTPrLKcY13CYqpuwbUFT/li+RE6Riv/FDw4yMMGfzSVvp3nQUOjaMmX6nGpbJSQ83kM6sRHm4ru50lJ+zbYcWi/Ncgw4n782NUhExugxgRx+MNINk+V93USMVSERKqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714578204; c=relaxed/simple;
	bh=CYR1Lt2oNa7TYosn8CI8zZqG21j+rZjw836XfyyRaoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n2mG2m4vDxsN754qFimrle/wab8Y3CRyl46CzrfA9SX+aosAyAieR2B5w9zsnHL4Skoxmc04VMyjt2xJ/F2e8vuadMHWGnJhW0eYCwdB+VPnbAYFNAOpBdT/Rvepcx6jNtBB8GYzcy8r0FUxLHVG1FMG8MoGEy2zMVFqNn3FtdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WVW8hAar; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e46dcd8feaso3845680b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 08:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714578203; x=1715183003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VAsbnoEFJrVyDtHtft3iEaFOAYRSD9aeoc8eSw4uTv0=;
        b=WVW8hAarJwy+dH3Pr9UCsuSGwp+6DVMwW9Sp3pPquJKctBu4ktdy1J0vpIpcU0yw45
         JrLhflTpAMnPOf18g3+JzuLZlaPe7ZiTFcvMypf70d5XO6TXrkSma4yMNQVo3LJnC9B3
         ki5etsd4RN8KreeZ6UFcrIeevZ9PAzVmXz+Oo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714578203; x=1715183003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VAsbnoEFJrVyDtHtft3iEaFOAYRSD9aeoc8eSw4uTv0=;
        b=MkxUy3lSaS2RH8z8Uf67k/m27I64w0ocSFMfl0c81koL2r24rRJAUZdnb3DSK4H35P
         osQPxKMgqxceDqMr/YUqgqWq4BGteWbh2McUZic7Nics4iZUxUUkbOhZiWkxBfpAl0v5
         qFPDpNm6eCVJlrIVcjLrwxpTY+96yVkZ1FpNxheMX7rGtizi3tbK+eQow6mnXSZXsfw9
         J+8h01IE27WXsqRlkxNrs1oUksfB+3g0wWb9zxrcBmXCD9WRKIdCiWdmGg3rQ+dnRobL
         DXADzCOp43w5dgsmPADOplwQbacq5Yz1SW0+sa6lZLaYtRYrbjC5Lsn7OyUpMFzhrc3g
         c2jg==
X-Forwarded-Encrypted: i=1; AJvYcCWWjWP1agIyqh2QmZa6o1BKPa68723O2HVE9iv6TYXwk/lNLOXHNsc23mqPwIceBQ7UCnguGlWp9UvwPBRxKLNBKl1R61INPlKCZLZm
X-Gm-Message-State: AOJu0YzH647dofBwBrB9hD+GP+jxJUev9ZN1GH/yQsCZ4z+fbB/k9Ys+
	BpGAFbZpXt9jV0OKCWq4hUXPDVfjOJo1Ppa8MICH1Wkj6BSLUcEaBlfVD3IFXw==
X-Google-Smtp-Source: AGHT+IGSKEwdMoXg4YQC0tdFdeDZpeNvFEZH6s4FpOFcIZ1h0R2eymsxfQdRAtcIk9RK1dzbsMyh1g==
X-Received: by 2002:a05:6a20:5512:b0:1af:6911:ddf3 with SMTP id ko18-20020a056a20551200b001af6911ddf3mr2223520pzb.7.1714578202897;
        Wed, 01 May 2024 08:43:22 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:e886:8de:19a2:55b0])
        by smtp.gmail.com with ESMTPSA id fb12-20020a056a002d8c00b006f3ec69bc09sm7717924pfb.75.2024.05.01.08.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 08:43:22 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
	Hsin-Yi Wang <hsinyi@google.com>,
	Brian Norris <briannorris@chromium.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Joel Selvaraj <jo@jsfamily.in>,
	lvzhaoxiong@huaqin.corp-partner.google.com,
	Douglas Anderson <dianders@chromium.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/9] drm/mipi-dsi: Fix theoretical int overflow in mipi_dsi_generic_write_seq()
Date: Wed,  1 May 2024 08:41:05 -0700
Message-ID: <20240501084109.v3.2.Iadb65b8add19ed3ae3ed6425011beb97e380a912@changeid>
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
In-Reply-To: <20240501154251.3302887-1-dianders@chromium.org>
References: <20240501154251.3302887-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mipi_dsi_generic_write_seq() macro makes a call to
mipi_dsi_generic_write() which returns a type ssize_t. The macro then
stores it in an int and checks to see if it's negative. This could
theoretically be a problem if "ssize_t" is larger than "int".

To see the issue, imagine that "ssize_t" is 32-bits and "int" is
16-bits, you could see a problem if there was some code out there that
looked like:

  mipi_dsi_generic_write_seq(dsi, <32768 bytes as arguments>);

..since we'd get back that 32768 bytes were transferred and 32768
stored in a 16-bit int would look negative.

Though there are no callsites where we'd actually hit this (even if
"int" was only 16-bit), it's cleaner to make the types match so let's
fix it.

Fixes: a9015ce59320 ("drm/mipi-dsi: Add a mipi_dsi_dcs_write_seq() macro")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v3:
- Use %zd in print instead of casting errors to int.

Changes in v2:
- New

 include/drm/drm_mipi_dsi.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
index 70ce0b8cbc68..e0f56564bf97 100644
--- a/include/drm/drm_mipi_dsi.h
+++ b/include/drm/drm_mipi_dsi.h
@@ -314,17 +314,17 @@ int mipi_dsi_dcs_get_display_brightness_large(struct mipi_dsi_device *dsi,
  * @dsi: DSI peripheral device
  * @seq: buffer containing the payload
  */
-#define mipi_dsi_generic_write_seq(dsi, seq...)                                \
-	do {                                                                   \
-		static const u8 d[] = { seq };                                 \
-		struct device *dev = &dsi->dev;                                \
-		int ret;                                                       \
-		ret = mipi_dsi_generic_write(dsi, d, ARRAY_SIZE(d));           \
-		if (ret < 0) {                                                 \
-			dev_err_ratelimited(dev, "transmit data failed: %d\n", \
-					    ret);                              \
-			return ret;                                            \
-		}                                                              \
+#define mipi_dsi_generic_write_seq(dsi, seq...)                                 \
+	do {                                                                    \
+		static const u8 d[] = { seq };                                  \
+		struct device *dev = &dsi->dev;                                 \
+		ssize_t ret;                                                    \
+		ret = mipi_dsi_generic_write(dsi, d, ARRAY_SIZE(d));            \
+		if (ret < 0) {                                                  \
+			dev_err_ratelimited(dev, "transmit data failed: %zd\n", \
+					    ret);                               \
+			return ret;                                             \
+		}                                                               \
 	} while (0)
 
 /**
-- 
2.45.0.rc0.197.gbae5840b3b-goog


