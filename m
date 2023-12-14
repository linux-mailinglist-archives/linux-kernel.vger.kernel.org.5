Return-Path: <linux-kernel+bounces-71-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B240A813B8F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 714A41F211D5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 20:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBCEE6A346;
	Thu, 14 Dec 2023 20:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hPwhZdft"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF522112
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 20:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5c21e185df5so7391298a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 12:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702585952; x=1703190752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a2YE6Q1lspxSdRvHtWt0D327Ubgh2oADnGrrLN11Egc=;
        b=hPwhZdftjNU3SNIOMs6IftKYeO622z1vPKalwUeFat7VAalObdzZPaPTjCHSOO5hER
         sggmImn/KDuq5NIYLf+Nj/afKBSOJQFXKJoMwcCrDT+rwIeswCoXR6RArwlfhdQn+pzV
         q4KL/BV6kOBbjUlFtq4yGehl7H+Kcq2Accb7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702585952; x=1703190752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a2YE6Q1lspxSdRvHtWt0D327Ubgh2oADnGrrLN11Egc=;
        b=MaJTUfWyE7MCasu5OPwq+fcQzKN+mMueybERvVPJaH4RYvaWmBNMuxetfb6lgew2WG
         PTFli0SjVP2M42egF3nd9Snn4EZ07r6CsJFjxtmgAlxkZ2MgLDv/2bBOcEJyg3mr8uHR
         RzT+dXEtmN7j2yuuHIQjDApxBZ/57TE/VDh4kJDX6WsPOteEYvPpjr+ZLjA3YkYGhmP3
         6rV/tRrIMBFjVzz3z37g74nGsUk/1qpjKcOYD4vyWzGWsnGl+yWQkksdPuCrQY1zQmVz
         J9PlDnxExJDeMlcMLbROVe86gmJRqYEqnBIwsTIZhHC0F+Jbhg2uHCp9UsqxVPabE8Ih
         mocA==
X-Gm-Message-State: AOJu0Yzebi7XmRPpbDlaOpMoMIo3CCwqVMf8uOrsrL/NYegCDAFDHMak
	axYhmDUM3yVWfP0d5arEyiROFQ==
X-Google-Smtp-Source: AGHT+IGNPg13lWVuRvuzTZ1e20CqXVgpjSGrsj9auMAxG5qBysEZ8PL64spXTG5LUtb8S2nor6ulXg==
X-Received: by 2002:a17:90a:8543:b0:28a:ce23:af33 with SMTP id a3-20020a17090a854300b0028ace23af33mr3823080pjw.42.1702585951955;
        Thu, 14 Dec 2023 12:32:31 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:9d0c:9bd0:17f6:8236])
        by smtp.gmail.com with ESMTPSA id 5-20020a17090a018500b0028658657e9csm14636228pjc.46.2023.12.14.12.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 12:32:31 -0800 (PST)
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
Subject: [PATCH v2 2/2] drm/bridge: ti-sn65dsi86: Never store more than msg->size bytes in AUX xfer
Date: Thu, 14 Dec 2023 12:32:06 -0800
Message-ID: <20231214123205.v2.2.I7b83c0f31aeedc6b1dc98c7c741d3e1f94f040f8@changeid>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231214123205.v2.1.I9d1afcaad76a3e2c0ca046dc4adbc2b632c22eda@changeid>
References: <20231214123205.v2.1.I9d1afcaad76a3e2c0ca046dc4adbc2b632c22eda@changeid>
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


