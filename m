Return-Path: <linux-kernel+bounces-78-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B337813BA0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D4111C21B62
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 20:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53AEC6ABB5;
	Thu, 14 Dec 2023 20:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IEIwaPvB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B593BB48
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 20:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6cef5220d07so3732965b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 12:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702586292; x=1703191092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RCuUsFQR6lp6/7dcHWOPjNe2VLvS+gov+CkK1fWJuUI=;
        b=IEIwaPvBlbRN6MlPEIXuK9Cfa3vOfSKOxMZhVd8KOKGTUZxTgWaiX+Y9Yle7QvekcP
         F0Af/TuvFjWVLHiqp1BLhXe8TojCeveAUWU+dm+0c0W9OUtFda2Fte1OvrYv1ugpZymI
         0+SAZSHnPETZtIsl6bYgvtyIc+0yxBEokH7Cc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702586292; x=1703191092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RCuUsFQR6lp6/7dcHWOPjNe2VLvS+gov+CkK1fWJuUI=;
        b=QMuuIhBF4YvNBbPm10WXTrvRDxKmYReFXJmL2zfbvx6VJNkSWdScwepl26oPbw0fp2
         FYiQrrhzmCpGLLTjeChRc09X6Oto1fB1L7RYdwA/K71UaEFcnrMHZY/Etz+IycpU9s9n
         Cvybet6A8m0WvdSSrQkQzlkYQE0sC4L56bTbvqfpBLE4708xFd5MD4+O4n65oo1uizlB
         zZGvTCXaWq3yiNbUuQlVA+FSOC/4t0aocqbT8AMg7aP4gFLaTtRzT6gXEWarKsOECfKb
         xXUkhMEb/kczRo6NOwFHdK8vEBRKr2brNA6dVpwrvQexGxUt43XzpqY0+cXKFdRB4WVQ
         0eYw==
X-Gm-Message-State: AOJu0YzNvxj63UMRQEOmfNaaCa6KhtuvzphUvoQNmz7+M7qtagroLlKr
	ZlYLnY50uDzOONwlqB0m0R+zPw==
X-Google-Smtp-Source: AGHT+IEqBO+G2ecwBpTD5DnxvMh1rm2t6Nq3fzf3H6fhqeSmAfh6caWQ9m9jlmzPR4UB2NwbehmaMA==
X-Received: by 2002:a05:6a21:3398:b0:18c:2287:29cf with SMTP id yy24-20020a056a21339800b0018c228729cfmr6588631pzb.40.1702586292209;
        Thu, 14 Dec 2023 12:38:12 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:9d0c:9bd0:17f6:8236])
        by smtp.gmail.com with ESMTPSA id y18-20020a170902b49200b001cfc2e0a82fsm12799081plr.26.2023.12.14.12.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 12:38:11 -0800 (PST)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org
Cc: Guenter Roeck <groeck@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Stephen Boyd <swboyd@chromium.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] drm/bridge: ti-sn65dsi86: Never store more than msg->size bytes in AUX xfer
Date: Thu, 14 Dec 2023 12:37:52 -0800
Message-ID: <20231214123752.v3.2.I7b83c0f31aeedc6b1dc98c7c741d3e1f94f040f8@changeid>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231214123752.v3.1.I9d1afcaad76a3e2c0ca046dc4adbc2b632c22eda@changeid>
References: <20231214123752.v3.1.I9d1afcaad76a3e2c0ca046dc4adbc2b632c22eda@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For aux reads, the value `msg->size` indicates the size of the buffer
provided by `msg->buffer`. We should never in any circumstances write
more bytes to the buffer since it may overflow the buffer.

In the ti-sn65dsi86 driver there is one code path that reads the
transfer length from hardware. Even though it's never been seen to be
a problem, we should make extra sure that the hardware isn't
increasing the length since doing so would cause us to overrun the
buffer.

Fixes: 982f589bde7a ("drm/bridge: ti-sn65dsi86: Update reply on aux failures")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v2)

Changes in v2:
- Updated patch subject to match ps8640 patch.

 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 9095d1453710..62cc3893dca5 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -527,6 +527,7 @@ static ssize_t ti_sn_aux_transfer(struct drm_dp_aux *aux,
 	u32 request_val = AUX_CMD_REQ(msg->request);
 	u8 *buf = msg->buffer;
 	unsigned int len = msg->size;
+	unsigned int short_len;
 	unsigned int val;
 	int ret;
 	u8 addr_len[SN_AUX_LENGTH_REG + 1 - SN_AUX_ADDR_19_16_REG];
@@ -600,7 +601,8 @@ static ssize_t ti_sn_aux_transfer(struct drm_dp_aux *aux,
 	}
 
 	if (val & AUX_IRQ_STATUS_AUX_SHORT) {
-		ret = regmap_read(pdata->regmap, SN_AUX_LENGTH_REG, &len);
+		ret = regmap_read(pdata->regmap, SN_AUX_LENGTH_REG, &short_len);
+		len = min(len, short_len);
 		if (ret)
 			goto exit;
 	} else if (val & AUX_IRQ_STATUS_NAT_I2C_FAIL) {
-- 
2.43.0.472.g3155946c3a-goog


