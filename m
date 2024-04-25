Return-Path: <linux-kernel+bounces-157878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF418B17F1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 02:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E78A6B2287D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 00:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A40CA34;
	Thu, 25 Apr 2024 00:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fV8BqA4W"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9477736E
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 00:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714004461; cv=none; b=CR7fLqdAiB5MIZl0m8M7J/MP0zx1nTV93kjQ7Kh7tjchBdGigqLz8me4NJpGpiaQXDaioAGnUL7swPl5C9M/AYJIl0UBJqhG95jUkbI9XPwb6AqJkC9od9agK9HK0uy6YdQqs9LIXIbSuEUAkLAu7Uu+r6pH5LW3UrH21fId2hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714004461; c=relaxed/simple;
	bh=06siyUY10nF0CTm/YK6Y9Ga58CqckhhzWBrmGjY3X24=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sphnuDOp8903xhxMzBdBmPqfrMaDdZLqhlMZ1SFIE7z/cHiL0Z6HQ5ZMff3BsqW4Mvw6Cfir2xJwnzPmsxDm6vFlZtRWNFagiGU0gVRvLkQdw37Q/8rPaC9445H0UNRlvhXVsvFxqKUeUXKREC1xoBLGxY+HYGHm8KMLxTWAX1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fV8BqA4W; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6ea26393116so325586a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 17:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714004458; x=1714609258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4ObhZs+th7g8VscGs2I0yShbfHJZx8oS19i8kCf/KxY=;
        b=fV8BqA4WHvVpKnWSIge2+UgIjcIzEX7TF2Bh+WxKoRMt2yWHDFJ243ROqPs5krfzH9
         8X9f6V/xzFs6KAOUoxIMYT9ICG7trezUrcldIMdQbkaaLSgIc5If355y54sIHEsC5uFn
         v9Ut8bG1q/elxRdqM6ybLutQD6pZoz6fKOOKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714004458; x=1714609258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ObhZs+th7g8VscGs2I0yShbfHJZx8oS19i8kCf/KxY=;
        b=MQ8CBJ0/a/Kj0mIWtpMu/q05Palx04SJqWYV0F3XkWUQzCI2apZm5YqG8REBTC5Vwv
         yGOUxJ5hkJxnh/OqldS0mKqShGrLb4aaJEnbzZ0A4HOhNlXGf1wfLJN8Oxa8SunXDD4N
         PxG1W21cV0HfxBEe3Z9kbxnnA7EhPezAT4uy78UlCjtdh0WWD0e+izM3fFTmCphB8oDR
         ciXv0wVQ3PL1SN7dM2hh8nae7pmWWacHrLMlCn0PtTkbhmjmsh0Z6DG8brQSex8i153g
         YiWuJybppqEPGrZl2eUsYIzMzO2Nb+smhN9QNFzbY0kQkomXw8h4Z/+46ifWVi7fEzD0
         9ipw==
X-Forwarded-Encrypted: i=1; AJvYcCUfgoYPoSjNUEShlb035zy5uloCJKltyrHF5J7lorLi/Q0ZMsfPlQZ8ycY6+UD0x0SvkBPszcU1OQkFODrX4QCFz6krX0fvHis2OztR
X-Gm-Message-State: AOJu0Yy2Vod6KHHtTTZnRT1NwdO42KOnI4J8cdMzbEy5pQ0m9Bv6Bs5I
	wmprjKZBRDXEBeyZS5I5hg5wZgMRTIEwRgB0J6DOe+kbL4cNwLI78HpTre5LVg==
X-Google-Smtp-Source: AGHT+IG5J2R7XHW8gknBTIc0tbqbR6H7suWvgk1m9INcP18Qp3bZh0OHj2EQjYRxMgRNbxalMUB3JQ==
X-Received: by 2002:a05:6870:956f:b0:221:bf34:b15f with SMTP id v47-20020a056870956f00b00221bf34b15fmr3141193oal.25.1714004458468;
        Wed, 24 Apr 2024 17:20:58 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:7c53:2204:2b1d:2152])
        by smtp.gmail.com with ESMTPSA id z17-20020aa78891000000b006ecf217a5e1sm12012311pfe.189.2024.04.24.17.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 17:20:57 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org
Cc: Javier Martinez Canillas <javierm@redhat.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	linus.walleij@linaro.org,
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
	lvzhaoxiong@huaqin.corp-partner.google.com,
	Hsin-Yi Wang <hsinyi@google.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Douglas Anderson <dianders@chromium.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/mipi-dsi: Reduce driver bloat of mipi_dsi_*_write_seq()
Date: Wed, 24 Apr 2024 17:20:18 -0700
Message-ID: <20240424172017.1.Id15fae80582bc74a0d4f1338987fa375738f45b9@changeid>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The consensus of many DRM folks is that we want to move away from DSI
drivers defining tables of init commands. Instead, we want to move to
init functions that can use common DRM functions. The issue thus far
has been that using the macros mipi_dsi_generic_write_seq() and
mipi_dsi_dcs_write_seq() bloats the driver using them.

Through a cooperative effort between Hsin-Yi Wang and Dmitry
Baryshkov, we have realized that the majority of the bloat is the fact
that we have the dev_err_ratelimited() directly in the macros. Let's
hoist this call into drm_mipi_dsi.c by adding a "chatty" version of
the functions that includes the print.

Without any changes to clients this gives a dramatic savings. Building
with my build system shows one example:

$ scripts/bloat-o-meter \
  .../before/panel-novatek-nt36672e.ko \
  .../after/panel-novatek-nt36672e.ko

add/remove: 0/1 grow/shrink: 1/1 up/down: 6/-19652 (-19646)
Function                                     old     new   delta
__UNIQUE_ID_vermagic520                       64      70      +6
nt36672e_1080x2408_60hz_init               16592    7260   -9332
nt36672e_1080x2408_60hz_init._rs           10320       -  -10320
Total: Before=31503, After=11857, chg -62.36%

Note that given the change in location of the print it's harder to
include the "cmd" in the printout for mipi_dsi_dcs_write_seq() since,
theoretically, someone could call the new chatty function with a
zero-size array and it would be illegal to dereference data[0].
There's a printk format to print the whole buffer and this is probably
more useful for debugging anyway. Given that we're doing this for
mipi_dsi_dcs_write_seq(), let's also print the buffer for
mipi_dsi_generic_write_seq() in the error case.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
The MIPI device I have in front of me (wormdingler) hasn't been
converted to use these functions yet, so this is just compile
tested. It's about my end of day so I'm sending this out since it's
pretty straightforward. Hopefully others can confirm it works well for
them and also saves space under their compilers.

 drivers/gpu/drm/drm_mipi_dsi.c | 54 ++++++++++++++++++++++++++++++++++
 include/drm/drm_mipi_dsi.h     | 31 ++++++++-----------
 2 files changed, 67 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index 795001bb7ff1..5ded6aef38ed 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -764,6 +764,33 @@ ssize_t mipi_dsi_generic_write(struct mipi_dsi_device *dsi, const void *payload,
 }
 EXPORT_SYMBOL(mipi_dsi_generic_write);
 
+/**
+ * mipi_dsi_generic_write_chatty() - mipi_dsi_generic_write() w/ an error log
+ * @dsi: DSI peripheral device
+ * @payload: buffer containing the payload
+ * @size: size of payload buffer
+ *
+ * Just like mipi_dsi_generic_write() but includes a dev_err_ratelimited()
+ * call for you.
+ *
+ * Return: The number of bytes transmitted on success or a negative error code
+ * on failure.
+ */
+ssize_t mipi_dsi_generic_write_chatty(struct mipi_dsi_device *dsi,
+				      const void *payload, size_t size)
+{
+	struct device *dev = &dsi->dev;
+	int ret;
+
+	ret = mipi_dsi_generic_write(dsi, payload, size);
+	if (ret < 0)
+		dev_err_ratelimited(dev, "sending generic data %*ph failed: %d\n",
+				    (int)size, payload, ret);
+
+	return ret;
+}
+EXPORT_SYMBOL(mipi_dsi_generic_write_chatty);
+
 /**
  * mipi_dsi_generic_read() - receive data using a generic read packet
  * @dsi: DSI peripheral device
@@ -852,6 +879,33 @@ ssize_t mipi_dsi_dcs_write_buffer(struct mipi_dsi_device *dsi,
 }
 EXPORT_SYMBOL(mipi_dsi_dcs_write_buffer);
 
+/**
+ * mipi_dsi_dcs_write_buffer_chatty - mipi_dsi_dcs_write_buffer() w/ an error log
+ * @dsi: DSI peripheral device
+ * @data: buffer containing data to be transmitted
+ * @len: size of transmission buffer
+ *
+ * Just like mipi_dsi_dcs_write_buffer() but includes a dev_err_ratelimited()
+ * call for you.
+ *
+ * Return: The number of bytes successfully transmitted or a negative error
+ * code on failure.
+ */
+ssize_t mipi_dsi_dcs_write_buffer_chatty(struct mipi_dsi_device *dsi,
+					 const void *data, size_t len)
+{
+	struct device *dev = &dsi->dev;
+	int ret;
+
+	ret = mipi_dsi_dcs_write_buffer(dsi, data, len);
+	if (ret < 0)
+		dev_err_ratelimited(dev, "sending dcs data %*ph failed: %d\n",
+				    (int)len, data, ret);
+
+	return ret;
+}
+EXPORT_SYMBOL(mipi_dsi_dcs_write_buffer_chatty);
+
 /**
  * mipi_dsi_dcs_write() - send DCS write command
  * @dsi: DSI peripheral device
diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
index 82b1cc434ea3..784e425dc4c8 100644
--- a/include/drm/drm_mipi_dsi.h
+++ b/include/drm/drm_mipi_dsi.h
@@ -256,6 +256,8 @@ int mipi_dsi_picture_parameter_set(struct mipi_dsi_device *dsi,
 
 ssize_t mipi_dsi_generic_write(struct mipi_dsi_device *dsi, const void *payload,
 			       size_t size);
+ssize_t mipi_dsi_generic_write_chatty(struct mipi_dsi_device *dsi,
+				      const void *payload, size_t size);
 ssize_t mipi_dsi_generic_read(struct mipi_dsi_device *dsi, const void *params,
 			      size_t num_params, void *data, size_t size);
 
@@ -279,6 +281,8 @@ enum mipi_dsi_dcs_tear_mode {
 
 ssize_t mipi_dsi_dcs_write_buffer(struct mipi_dsi_device *dsi,
 				  const void *data, size_t len);
+ssize_t mipi_dsi_dcs_write_buffer_chatty(struct mipi_dsi_device *dsi,
+					 const void *data, size_t len);
 ssize_t mipi_dsi_dcs_write(struct mipi_dsi_device *dsi, u8 cmd,
 			   const void *data, size_t len);
 ssize_t mipi_dsi_dcs_read(struct mipi_dsi_device *dsi, u8 cmd, void *data,
@@ -317,14 +321,10 @@ int mipi_dsi_dcs_get_display_brightness_large(struct mipi_dsi_device *dsi,
 #define mipi_dsi_generic_write_seq(dsi, seq...)                                \
 	do {                                                                   \
 		static const u8 d[] = { seq };                                 \
-		struct device *dev = &dsi->dev;                                \
 		int ret;                                                       \
-		ret = mipi_dsi_generic_write(dsi, d, ARRAY_SIZE(d));           \
-		if (ret < 0) {                                                 \
-			dev_err_ratelimited(dev, "transmit data failed: %d\n", \
-					    ret);                              \
+		ret = mipi_dsi_generic_write_chatty(dsi, d, ARRAY_SIZE(d));    \
+		if (ret < 0)                                                   \
 			return ret;                                            \
-		}                                                              \
 	} while (0)
 
 /**
@@ -333,18 +333,13 @@ int mipi_dsi_dcs_get_display_brightness_large(struct mipi_dsi_device *dsi,
  * @cmd: Command
  * @seq: buffer containing data to be transmitted
  */
-#define mipi_dsi_dcs_write_seq(dsi, cmd, seq...)                           \
-	do {                                                               \
-		static const u8 d[] = { cmd, seq };                        \
-		struct device *dev = &dsi->dev;                            \
-		int ret;                                                   \
-		ret = mipi_dsi_dcs_write_buffer(dsi, d, ARRAY_SIZE(d));    \
-		if (ret < 0) {                                             \
-			dev_err_ratelimited(                               \
-				dev, "sending command %#02x failed: %d\n", \
-				cmd, ret);                                 \
-			return ret;                                        \
-		}                                                          \
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
2.44.0.769.g3c40516874-goog


