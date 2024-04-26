Return-Path: <linux-kernel+bounces-160792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD76A8B42F3
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 01:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDC951C20FA0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 23:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6742442059;
	Fri, 26 Apr 2024 23:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TsfvTDoq"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CDA40856
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 23:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714175953; cv=none; b=X2t30j7EKsBSkrwxKHQ96RFGzOzqScTxzhfn77b2+bNK3ahha0DmO10CiuqxR7xx6cNZvlaCwVjfEBC/dvW6d9atx0Q123lz68hbSnotNQOlRanXQpyDx450ml7hi/VnP1nozzns8nq5LZQyZy/mItZXrx556DY//+I0Z/xSlvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714175953; c=relaxed/simple;
	bh=C6xj06k1NcWfIhWMmbNoNRRZycSp5YpvE6fUOBk/JmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b0dtEeB1Cg+BvguBHYyatjEuvCzhwbL61JwHWMhvZ6b2K7JEHPGlmcVKXDvE0ixyY+brwNi7IVvoAypXZIRyt9aF2IIN0IZ0Y5l4yvWm9nc+3kth97+XnhT8rAbbZeArTRI7AxqdTba7CN3xqF3KXr6w9COHEQdbOw6SDhtDqTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TsfvTDoq; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5c66b093b86so2862968a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 16:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714175951; x=1714780751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=olX2nqFQ/HIiDMzF6dlzKwUQwqcWWwyQPZ/a2dqsVIU=;
        b=TsfvTDoq70OwVweycO8NjgSVN6EJ8ilTYp8p0+dvlnwPA4GS6b1fDloY/tCMiBM7F9
         FvCiLKyQHgzbjnLhQj51HDwP/H0+e0q6IlEgldaV83MR9EW/qeFQkrh9PxNCjMyXUSj+
         +yrD6crmzvp98gRa1/9DJaVokZ0Lzw+JNIvvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714175951; x=1714780751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=olX2nqFQ/HIiDMzF6dlzKwUQwqcWWwyQPZ/a2dqsVIU=;
        b=ctRYoMs1HcJKTf8I0m0NqV/ikBBNH/Itj7yXC7JNT5Hjc/ALPO+Gu+cpZwHGhG9LlY
         7SQGoQpyqVu2jKy1dl6wt4lNx0OivsKN5BATGDD9FdKVWtu8fseYLjJpnwwSqrsV4l9j
         5eXdgwPaGkBL+ep2ODgpUERVbiKetYDeBJdYZahNkN9U3MSpAQqcKPTSFMMkQqFigvMu
         /V+Yzlu+IyiRKEFtYNVSPKbZUe90cGx+lKUFSN56luCK5ggUejBFaRbpGSDBWDEqMKv4
         2jfWMeBNqrFq1UkbR+tPcHN6IqNIq4OxLFMl0Nh+aK7/4FYnKk+MIVgO4hnCDrmnp12x
         TT7w==
X-Forwarded-Encrypted: i=1; AJvYcCUNtr8kFX33eq7ukRj0b5Bace/dhLTXZ9JgFhUxbic5fpaAlw1i52rQTCkWMaVkeqD2CdxA5EURL7Ojru3QAk9krvSxNVd3FaxjspQy
X-Gm-Message-State: AOJu0Yy7fNzm7za04BidCg1kG6OEsdE1te94eH+ni4dFvkwdZpRXkSa8
	P1nMdfnCH5JbU4pyMBTaMJ144Rv96IbABljFd03vklCbXeSFrctbtAkz8fIrjw==
X-Google-Smtp-Source: AGHT+IERSyX1MgdxL1cw3vNSzu1k3ve74uWuziWR/EytMBtjf7Aw/D5Xwy6rDaVwR+TQjtAuEB5fNw==
X-Received: by 2002:a17:90a:d916:b0:2af:3b61:318a with SMTP id c22-20020a17090ad91600b002af3b61318amr6231601pjv.9.1714175951177;
        Fri, 26 Apr 2024 16:59:11 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:fca:3ae2:20e6:82bb])
        by smtp.gmail.com with ESMTPSA id n4-20020a17090aab8400b002af41bd563esm5111939pjq.33.2024.04.26.16.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 16:59:10 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: dri-devel@lists.freedesktop.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	lvzhaoxiong@huaqin.corp-partner.google.com,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Hsin-Yi Wang <hsinyi@google.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Joel Selvaraj <jo@jsfamily.in>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Douglas Anderson <dianders@chromium.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/8] drm/mipi-dsi: Reduce driver bloat of mipi_dsi_*_write_seq()
Date: Fri, 26 Apr 2024 16:58:36 -0700
Message-ID: <20240426165839.v2.3.Id15fae80582bc74a0d4f1338987fa375738f45b9@changeid>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
In-Reply-To: <20240426235857.3870424-1-dianders@chromium.org>
References: <20240426235857.3870424-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Through a cooperative effort between Hsin-Yi Wang and Dmitry
Baryshkov, we have realized the dev_err_ratelimited() in the
mipi_dsi_*_write_seq() macros was causing quite a bit of bloat to the
kernel. Let's hoist this call into drm_mipi_dsi.c by adding a "chatty"
version of the functions that includes the print. While doing this,
add a bit more comments to these macros making it clear that they
print errors and also that they return out of _the caller's_ function.

Without any changes to clients this gives a dramatic savings. Building
with my build system shows one example:

$ scripts/bloat-o-meter \
  .../before/panel-novatek-nt36672e.ko \
  .../after/panel-novatek-nt36672e.ko

add/remove: 0/1 grow/shrink: 0/1 up/down: 0/-21496 (-21496)
Function                                     old     new   delta
nt36672e_1080x2408_60hz_init._rs           10320       -  -10320
nt36672e_1080x2408_60hz_init               17412    6236  -11176
Total: Before=32147, After=10651, chg -66.87%

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

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Add some comments to the macros about printing and returning.
- Modify commit message now that this is part of a series.
- Change the way err value is handled in prep for next patch.
- Rebased upon patches to avoid theoretical int overflow.

 drivers/gpu/drm/drm_mipi_dsi.c | 56 ++++++++++++++++++++++++++++++++++
 include/drm/drm_mipi_dsi.h     | 41 +++++++++++++------------
 2 files changed, 78 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index 795001bb7ff1..1e062eda3b88 100644
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
+		dev_err_ratelimited(dev, "sending generic data %*ph failed: %d\n",
+				    (int)size, payload, (int)ret);
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
+		dev_err_ratelimited(dev, "sending dcs data %*ph failed: %d\n",
+				    (int)len, data, (int)ret);
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
index 5de2bd62448b..6d68d9927f46 100644
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
@@ -311,40 +315,39 @@ int mipi_dsi_dcs_get_display_brightness_large(struct mipi_dsi_device *dsi,
 
 /**
  * mipi_dsi_generic_write_seq - transmit data using a generic write packet
+ *
+ * This macro will print errors for you and will RETURN FROM THE CALLING
+ * FUNCTION (yes this is non-intuitive) upon error.
+ *
  * @dsi: DSI peripheral device
  * @seq: buffer containing the payload
  */
 #define mipi_dsi_generic_write_seq(dsi, seq...)                                \
 	do {                                                                   \
 		static const u8 d[] = { seq };                                 \
-		struct device *dev = &dsi->dev;                                \
-		ssize_t ret;                                                   \
-		ret = mipi_dsi_generic_write(dsi, d, ARRAY_SIZE(d));           \
-		if (ret < 0) {                                                 \
-			dev_err_ratelimited(dev, "transmit data failed: %d\n", \
-					    (int)ret);                         \
+		int ret;                                                       \
+		ret = mipi_dsi_generic_write_chatty(dsi, d, ARRAY_SIZE(d));    \
+		if (ret < 0)                                                   \
 			return ret;                                            \
-		}                                                              \
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
-#define mipi_dsi_dcs_write_seq(dsi, cmd, seq...)                           \
-	do {                                                               \
-		static const u8 d[] = { cmd, seq };                        \
-		struct device *dev = &dsi->dev;                            \
-		ssize_t ret;                                               \
-		ret = mipi_dsi_dcs_write_buffer(dsi, d, ARRAY_SIZE(d));    \
-		if (ret < 0) {                                             \
-			dev_err_ratelimited(                               \
-				dev, "sending command %#02x failed: %d\n", \
-				cmd, (int)ret);                            \
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


