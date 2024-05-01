Return-Path: <linux-kernel+bounces-165507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8028B8D66
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 17:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CE9DB23A71
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 15:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A41C130AD4;
	Wed,  1 May 2024 15:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IR2DmWL3"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BEA12FF78
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 15:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714578209; cv=none; b=SNyyq5Dxzi04V8Wgq0uxb5hLHrPto7DfHHEDJsQ2QS6puei9gx7KrmAmcyL1f3ytCPPQlzNkmb+mCq8Ss9FR5YaBm/gB0l2arbI+KEmITgTh19T5cKcN6TsimFkSMKwab7nog+Dlc1eqOKxNd4SVz1karJMaRTass+H1U/ZlxLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714578209; c=relaxed/simple;
	bh=s/ROZL2++SDA1xmeBzdHiva9tZl6EdColSrPNbERF6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kM+olQWq1At6uctE3KSd8h7b05g3G8Knd+iJCvXvlEGKgGLSOnLW/2WVb1CW0/XFBrxTlxZEsulbGIDyFT5cH1iPqKcK7TnolT0l/BR0puUPM1aAs+VrH/5HU/ha3ktBHXXbW337v2ME8tMEXdy9xumlT9Csf3tVbIHyMIVgIoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IR2DmWL3; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6f26588dd5eso5846432b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 08:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714578207; x=1715183007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PdqLCsG6yH2ylvUtBdK7xRsLXNRPF4P26ZlbxzbdCAs=;
        b=IR2DmWL3w9XnQeTmZaJ5RDatQBWT0nk5a5e9WtJGMjgFAgYz1s8srS6aT2UNey4OxW
         DF27eAYAT3gPPs4ie1eWSM89S9/WIqlBGIkylStWNvHlfbQ59cDuUm6R3DQTo2OsOzNZ
         ugDm0gbFWFr7nT0nbRzz23Row3OEneay0d5c0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714578207; x=1715183007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PdqLCsG6yH2ylvUtBdK7xRsLXNRPF4P26ZlbxzbdCAs=;
        b=hFJX2GMVwCaKGYWLgY4uU3n6JuEyLyUv/IXo2bfy0yv32QdmrvpYf5px3TMrACekYd
         R8uH09PMlOqaCLH2qXJuoO1ibCiDFcqtPoItt5+6hU2NDU1m8NScwaNGoziSiIrlsDOk
         giTz/YyB4AfDOswArD15SCnqD/bugQBQmu+rZRTGx3/EzRwnv9IJpb/4oP98mNgoXqYO
         fZLwuueUuvXmRCSp2nmg98ctA0ZIuFIvE1aQnFnzsvIkHWEQBTfJjEBatSenpne5dq3D
         1U4pfxsAwox2rCtqTrW70L6YJsyRzLO5xq1lBhict4QXSDh/MG/+txGTYgPHlPdswxhh
         cS1A==
X-Forwarded-Encrypted: i=1; AJvYcCUKaSb9GAIhUqlxN6oU0mqFy72H6yXt+Ih2dYJdjMjk/eiif0XXs3qCWq7fdtPwBN8FYYlfQhkk89hYeT5Pdk7X5hBvSl32slG30y2O
X-Gm-Message-State: AOJu0Yx8VKZvEEmLdHRw85BQs6QE7khAGyYOHgHoPJGZUmrd5FLoi3bK
	GO5nHhgE5rNKOosKavdgXxWeCyP/rebTJxzdy9QV128inVpN39WKhgGIFYNT3Q==
X-Google-Smtp-Source: AGHT+IEpb9hu/+w6lC896xSQLLAgZ0Frgtjrm4c/ukurMA4cbUXqvrXhDqtlA1gpxRSC8kZpsrSbVg==
X-Received: by 2002:a05:6a20:9187:b0:1a9:4055:6dce with SMTP id v7-20020a056a20918700b001a940556dcemr2831466pzd.58.1714578206857;
        Wed, 01 May 2024 08:43:26 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:e886:8de:19a2:55b0])
        by smtp.gmail.com with ESMTPSA id fb12-20020a056a002d8c00b006f3ec69bc09sm7717924pfb.75.2024.05.01.08.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 08:43:26 -0700 (PDT)
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
Subject: [PATCH v3 4/9] drm/mipi-dsi: Reduce driver bloat of mipi_dsi_*_write_seq()
Date: Wed,  1 May 2024 08:41:07 -0700
Message-ID: <20240501084109.v3.4.Id15fae80582bc74a0d4f1338987fa375738f45b9@changeid>
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

Through a cooperative effort between Hsin-Yi Wang and Dmitry
Baryshkov, we have realized the dev_err() in the
mipi_dsi_*_write_seq() macros was causing quite a bit of bloat to the
kernel. Let's hoist this call into drm_mipi_dsi.c by adding a "chatty"
version of the functions that includes the print. While doing this,
add a bit more comments to these macros making it clear that they
print errors and also that they return out of _the caller's_ function.

Without any changes to clients this gives a nice savings. Building
with my build system shows one example:

$ scripts/bloat-o-meter \
  .../before/panel-novatek-nt36672e.ko \
  .../after/panel-novatek-nt36672e.ko
add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-4404 (-4404)
Function                                     old     new   delta
nt36672e_1080x2408_60hz_init               10640    6236   -4404
Total: Before=15055, After=10651, chg -29.25%

Note that given the change in location of the print it's harder to
include the "cmd" in the printout for mipi_dsi_dcs_write_seq() since,
theoretically, someone could call the new chatty function with a
zero-size array and it would be illegal to dereference data[0].
There's a printk format to print the whole buffer and this is probably
more useful for debugging anyway. Given that we're doing this for
mipi_dsi_dcs_write_seq(), let's also print the buffer for
mipi_dsi_generic_write_seq() in the error case.

It should be noted that the current consensus of DRM folks is that the
mipi_dsi_*_write_seq() should be deprecated due to the non-intuitive
return behavior. A future patch will formally mark them as deprecated
and provide an alternative.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v3:
- Rebased upon patch to remove ratelimit of prints.

Changes in v2:
- Add some comments to the macros about printing and returning.
- Change the way err value is handled in prep for next patch.
- Modify commit message now that this is part of a series.
- Rebased upon patches to avoid theoretical int overflow.

 drivers/gpu/drm/drm_mipi_dsi.c | 56 ++++++++++++++++++++++++++++++++++
 include/drm/drm_mipi_dsi.h     | 47 +++++++++++++++-------------
 2 files changed, 82 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index 795001bb7ff1..8593d9ed5891 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -764,6 +764,34 @@ ssize_t mipi_dsi_generic_write(struct mipi_dsi_device *dsi, const void *payload,
 }
 EXPORT_SYMBOL(mipi_dsi_generic_write);
 
+/**
+ * mipi_dsi_generic_write_chatty() - mipi_dsi_generic_write() w/ an error log
+ * @dsi: DSI peripheral device
+ * @payload: buffer containing the payload
+ * @size: size of payload buffer
+ *
+ * Like mipi_dsi_generic_write() but includes a dev_err_ratelimited()
+ * call for you and returns 0 upon success, not the number of bytes sent.
+ *
+ * Return: 0 on success or a negative error code on failure.
+ */
+int mipi_dsi_generic_write_chatty(struct mipi_dsi_device *dsi,
+				  const void *payload, size_t size)
+{
+	struct device *dev = &dsi->dev;
+	ssize_t ret;
+
+	ret = mipi_dsi_generic_write(dsi, payload, size);
+	if (ret < 0) {
+		dev_err(dev, "sending generic data %*ph failed: %zd\n",
+			(int)size, payload, ret);
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(mipi_dsi_generic_write_chatty);
+
 /**
  * mipi_dsi_generic_read() - receive data using a generic read packet
  * @dsi: DSI peripheral device
@@ -852,6 +880,34 @@ ssize_t mipi_dsi_dcs_write_buffer(struct mipi_dsi_device *dsi,
 }
 EXPORT_SYMBOL(mipi_dsi_dcs_write_buffer);
 
+/**
+ * mipi_dsi_dcs_write_buffer_chatty - mipi_dsi_dcs_write_buffer() w/ an error log
+ * @dsi: DSI peripheral device
+ * @data: buffer containing data to be transmitted
+ * @len: size of transmission buffer
+ *
+ * Like mipi_dsi_dcs_write_buffer() but includes a dev_err_ratelimited()
+ * call for you and returns 0 upon success, not the number of bytes sent.
+ *
+ * Return: 0 on success or a negative error code on failure.
+ */
+int mipi_dsi_dcs_write_buffer_chatty(struct mipi_dsi_device *dsi,
+				     const void *data, size_t len)
+{
+	struct device *dev = &dsi->dev;
+	ssize_t ret;
+
+	ret = mipi_dsi_dcs_write_buffer(dsi, data, len);
+	if (ret < 0) {
+		dev_err(dev, "sending dcs data %*ph failed: %zd\n",
+			(int)len, data, ret);
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(mipi_dsi_dcs_write_buffer_chatty);
+
 /**
  * mipi_dsi_dcs_write() - send DCS write command
  * @dsi: DSI peripheral device
diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
index 67967be48dbd..6d68d9927f46 100644
--- a/include/drm/drm_mipi_dsi.h
+++ b/include/drm/drm_mipi_dsi.h
@@ -256,6 +256,8 @@ int mipi_dsi_picture_parameter_set(struct mipi_dsi_device *dsi,
 
 ssize_t mipi_dsi_generic_write(struct mipi_dsi_device *dsi, const void *payload,
 			       size_t size);
+int mipi_dsi_generic_write_chatty(struct mipi_dsi_device *dsi,
+				  const void *payload, size_t size);
 ssize_t mipi_dsi_generic_read(struct mipi_dsi_device *dsi, const void *params,
 			      size_t num_params, void *data, size_t size);
 
@@ -279,6 +281,8 @@ enum mipi_dsi_dcs_tear_mode {
 
 ssize_t mipi_dsi_dcs_write_buffer(struct mipi_dsi_device *dsi,
 				  const void *data, size_t len);
+int mipi_dsi_dcs_write_buffer_chatty(struct mipi_dsi_device *dsi,
+				     const void *data, size_t len);
 ssize_t mipi_dsi_dcs_write(struct mipi_dsi_device *dsi, u8 cmd,
 			   const void *data, size_t len);
 ssize_t mipi_dsi_dcs_read(struct mipi_dsi_device *dsi, u8 cmd, void *data,
@@ -311,38 +315,39 @@ int mipi_dsi_dcs_get_display_brightness_large(struct mipi_dsi_device *dsi,
 
 /**
  * mipi_dsi_generic_write_seq - transmit data using a generic write packet
+ *
+ * This macro will print errors for you and will RETURN FROM THE CALLING
+ * FUNCTION (yes this is non-intuitive) upon error.
+ *
  * @dsi: DSI peripheral device
  * @seq: buffer containing the payload
  */
-#define mipi_dsi_generic_write_seq(dsi, seq...)                           \
-	do {                                                              \
-		static const u8 d[] = { seq };                            \
-		struct device *dev = &dsi->dev;                           \
-		ssize_t ret;                                              \
-		ret = mipi_dsi_generic_write(dsi, d, ARRAY_SIZE(d));      \
-		if (ret < 0) {                                            \
-			dev_err(dev, "transmit data failed: %zd\n", ret); \
-			return ret;                                       \
-		}                                                         \
+#define mipi_dsi_generic_write_seq(dsi, seq...)                                \
+	do {                                                                   \
+		static const u8 d[] = { seq };                                 \
+		int ret;                                                       \
+		ret = mipi_dsi_generic_write_chatty(dsi, d, ARRAY_SIZE(d));    \
+		if (ret < 0)                                                   \
+			return ret;                                            \
 	} while (0)
 
 /**
  * mipi_dsi_dcs_write_seq - transmit a DCS command with payload
+ *
+ * This macro will print errors for you and will RETURN FROM THE CALLING
+ * FUNCTION (yes this is non-intuitive) upon error.
+ *
  * @dsi: DSI peripheral device
  * @cmd: Command
  * @seq: buffer containing data to be transmitted
  */
-#define mipi_dsi_dcs_write_seq(dsi, cmd, seq...)                            \
-	do {                                                                \
-		static const u8 d[] = { cmd, seq };                         \
-		struct device *dev = &dsi->dev;                             \
-		ssize_t ret;                                                \
-		ret = mipi_dsi_dcs_write_buffer(dsi, d, ARRAY_SIZE(d));     \
-		if (ret < 0) {                                              \
-			dev_err(dev, "sending command %#02x failed: %zd\n", \
-				cmd, ret);                                  \
-			return ret;                                         \
-		}                                                           \
+#define mipi_dsi_dcs_write_seq(dsi, cmd, seq...)                               \
+	do {                                                                   \
+		static const u8 d[] = { cmd, seq };                            \
+		int ret;                                                       \
+		ret = mipi_dsi_dcs_write_buffer_chatty(dsi, d, ARRAY_SIZE(d)); \
+		if (ret < 0)                                                   \
+			return ret;                                            \
 	} while (0)
 
 /**
-- 
2.45.0.rc0.197.gbae5840b3b-goog


