Return-Path: <linux-kernel+bounces-160793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 499518B42F5
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 02:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 979D71F25402
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 00:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FECE44376;
	Fri, 26 Apr 2024 23:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DHksFrWI"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D137241C84
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 23:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714175955; cv=none; b=oJHbK9nAPFAt0BF/Zw0NfkjzrUDqNbEDJEiHOCQvgJrJbKnOSXrDdsiEjzlHNjafeS3UfcajBOV+N1G3dDSWGi9KiAtuJsi2JODzVZvSaApmwB7U6VpLUSUCMRqKcQIlDESN2ppGlIza15JmTeTHwgX+xO3BJKObNrWLSb5A64E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714175955; c=relaxed/simple;
	bh=gm8Btr33gsfZ2Zdb+0CU+2/aCKePFGVDDNH4cIM7I+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s9tG07/kpf3z0YqbKFaLjb58m7b69U2/wWJPPcIy5roNUPnjMgTcBuVXy+0UXroFCfkPEedfd//E4RlBdibeIYa9XoC3hcNFcnXZ2o3rV5HEXtysHuM0lQ6eBkQo1dmDpCSxC9EgUYfvV4GbqJmuCadhNPfFEk5glAtZAXTS2BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DHksFrWI; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2a2d82537efso1933958a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 16:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714175953; x=1714780753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qBjUcIaEc8iGmyPg9mQmkly7c03mHZYaJKm1esFMQxw=;
        b=DHksFrWIMCFpCdXGpD69IYeyu7+GQM5IF3YAnfT4bpcZkwDLgSZtbrEumTyYt5Xtgh
         ukaaUA6EfNOLa25YrRq8t7guX8SKfSyTLi/J6le3o07ssVSb5TXPxaBKIQTHLN8Wte/O
         OhYzO52ogamuE63K5rF/Ws9oei4mNcv6N90zg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714175953; x=1714780753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qBjUcIaEc8iGmyPg9mQmkly7c03mHZYaJKm1esFMQxw=;
        b=jZFXsA+zJ1YIZoEUmldNQp7MKuD2DejAAZAt1fH7ClCL/Yrn6Kc9YT+7HhLJgt5RRH
         jX6eH78xNSUtkX2xXfLI0wLKM2fGLBXR2HMCJwAGY9H4SSYRYd2DZruHr6t8yNW023//
         skf6D48wDltY31WbrpcLg0S+mJbcxKsJ4Gme9RF8vCV6KM1tIbKmIyF7muvCOCQu5ihY
         pEfoQtZ9WjwFq/9fm7fyZx6FIxPhioh8Fv1NWNwejxic7vq8UmQaMUEXus61cLM3qjRn
         TF49VV7NUzvJl7V20zDyiH75YQ0ZPwfRh+8TOIf2wDneyeE6I8Dol3suEqZ0i+aXiiod
         kBGg==
X-Forwarded-Encrypted: i=1; AJvYcCU2c7683NjcXOxWMVDeg10XgstiycNFvG9cdoyAWr5oVjqWbfAcC0HciVArSKr1PKf3xgWO2jecs8En1TKV0E/6x2TpZ50IWQDdqurO
X-Gm-Message-State: AOJu0YxIpKOc670EZKcNnxmwsITlKxg8fhfNqB9agAvNRtsKFoCoB90N
	uSSrDCZIJGUUEJtppPhd9v/lGSLDW7pPYXSsnlCOaqH1OVQv5q6VJR8tKWc5/A==
X-Google-Smtp-Source: AGHT+IH1PhYY3WBPoDEiPEXLueN76WMpx2GULFedhlTBn3BonV/Gtq+GgZYL4BDL2EqdSQTU8oKeBA==
X-Received: by 2002:a17:90b:538f:b0:2ac:5d2d:12ac with SMTP id sv15-20020a17090b538f00b002ac5d2d12acmr5101290pjb.5.1714175953183;
        Fri, 26 Apr 2024 16:59:13 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:fca:3ae2:20e6:82bb])
        by smtp.gmail.com with ESMTPSA id n4-20020a17090aab8400b002af41bd563esm5111939pjq.33.2024.04.26.16.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 16:59:12 -0700 (PDT)
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
Subject: [PATCH v2 4/8] drm/mipi-dsi: Introduce mipi_dsi_*_write_seq_multi()
Date: Fri, 26 Apr 2024 16:58:37 -0700
Message-ID: <20240426165839.v2.4.Ie94246c30fe95101e0e26dd5f96e976dbeb8f242@changeid>
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

The current mipi_dsi_*_write_seq() macros are non-intutitive because
they contain a hidden "return" statement that will return out of the
_caller_ of the macro. Let's mark them as deprecated and instead
introduce some new macros that are more intuitive.

These new macros are less optimal when an error occurs but should
behave more optimally when there is no error. Specifically these new
macros cause smaller code to get generated and the code size savings
(less to fetch from RAM, less cache space used, less RAM used) are
important. Since the error case isn't something we need to optimize
for and these new macros are easier to understand and more flexible,
they should be used.

After converting to use these new functions, one example shows some
nice savings while also being easier to understand.

$ scripts/bloat-o-meter \
  ...after/panel-novatek-nt36672e.ko \
  ...ctx/panel-novatek-nt36672e.ko
add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-988 (-988)
Function                                     old     new   delta
nt36672e_1080x2408_60hz_init                6236    5248    -988
Total: Before=10651, After=9663, chg -9.28%

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
Right now this patch introduces two new functions in
drm_mipi_dsi.c. Alternatively we could have changed the prototype of
the "chatty" functions and made the deprecated macros adapt to the new
prototype. While this sounds nice, it bloated callers of the
deprecated functioin a bit because it caused the compiler to emit less
optimal code. It doesn't seem terrible to add two more functions, so I
went that way.

Changes in v2:
- New

 drivers/gpu/drm/drm_mipi_dsi.c | 56 +++++++++++++++++++++++++++++++++
 include/drm/drm_mipi_dsi.h     | 57 ++++++++++++++++++++++++++++++++++
 2 files changed, 113 insertions(+)

diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index 1e062eda3b88..b7c75a4396e6 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -792,6 +792,34 @@ int mipi_dsi_generic_write_chatty(struct mipi_dsi_device *dsi,
 }
 EXPORT_SYMBOL(mipi_dsi_generic_write_chatty);
 
+/**
+ * mipi_dsi_generic_write_multi() - mipi_dsi_generic_write_chatty() w/ accum_err
+ * @ctx: Context for multiple DSI transactions
+ * @payload: buffer containing the payload
+ * @size: size of payload buffer
+ *
+ * Like mipi_dsi_generic_write_chatty() but deals with errors in a way that
+ * makes it convenient to make several calls in a row.
+ */
+void mipi_dsi_generic_write_multi(struct mipi_dsi_multi_context *ctx,
+				  const void *payload, size_t size)
+{
+	struct mipi_dsi_device *dsi = ctx->dsi;
+	struct device *dev = &dsi->dev;
+	ssize_t ret;
+
+	if (ctx->accum_err)
+		return;
+
+	ret = mipi_dsi_generic_write(dsi, payload, size);
+	if (ret < 0) {
+		ctx->accum_err = ret;
+		dev_err_ratelimited(dev, "sending generic data %*ph failed: %d\n",
+				    (int)size, payload, ctx->accum_err);
+	}
+}
+EXPORT_SYMBOL(mipi_dsi_generic_write_multi);
+
 /**
  * mipi_dsi_generic_read() - receive data using a generic read packet
  * @dsi: DSI peripheral device
@@ -908,6 +936,34 @@ int mipi_dsi_dcs_write_buffer_chatty(struct mipi_dsi_device *dsi,
 }
 EXPORT_SYMBOL(mipi_dsi_dcs_write_buffer_chatty);
 
+/**
+ * mipi_dsi_dcs_write_buffer_multi - mipi_dsi_dcs_write_buffer_chatty() w/ accum_err
+ * @ctx: Context for multiple DSI transactions
+ * @data: buffer containing data to be transmitted
+ * @len: size of transmission buffer
+ *
+ * Like mipi_dsi_dcs_write_buffer_chatty() but deals with errors in a way that
+ * makes it convenient to make several calls in a row.
+ */
+void mipi_dsi_dcs_write_buffer_multi(struct mipi_dsi_multi_context *ctx,
+				     const void *data, size_t len)
+{
+	struct mipi_dsi_device *dsi = ctx->dsi;
+	struct device *dev = &dsi->dev;
+	ssize_t ret;
+
+	if (ctx->accum_err)
+		return;
+
+	ret = mipi_dsi_dcs_write_buffer(dsi, data, len);
+	if (ret < 0) {
+		ctx->accum_err = ret;
+		dev_err_ratelimited(dev, "sending dcs data %*ph failed: %d\n",
+				    (int)len, data, ctx->accum_err);
+	}
+}
+EXPORT_SYMBOL(mipi_dsi_dcs_write_buffer_multi);
+
 /**
  * mipi_dsi_dcs_write() - send DCS write command
  * @dsi: DSI peripheral device
diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
index 6d68d9927f46..379594649a42 100644
--- a/include/drm/drm_mipi_dsi.h
+++ b/include/drm/drm_mipi_dsi.h
@@ -197,6 +197,22 @@ struct mipi_dsi_device {
 	struct drm_dsc_config *dsc;
 };
 
+/**
+ * struct mipi_dsi_multi_context - Context to call multiple MIPI DSI funcs in a row
+ * @dsi: Pointer to the MIPI DSI device
+ * @accum_err: Storage for the accumulated error over the multiple calls. Init
+ *	to 0. If a function encounters an error then the error code will be
+ *	stored here. If you call a function and this points to a non-zero
+ *	value then the function will be a noop. This allows calling a function
+ *	many times in a row and just checking the error at the end to see if
+ *	any of them failed.
+ */
+
+struct mipi_dsi_multi_context {
+	struct mipi_dsi_device *dsi;
+	int accum_err;
+};
+
 #define MIPI_DSI_MODULE_PREFIX "mipi-dsi:"
 
 #define to_mipi_dsi_device(__dev)	container_of_const(__dev, struct mipi_dsi_device, dev)
@@ -258,6 +274,8 @@ ssize_t mipi_dsi_generic_write(struct mipi_dsi_device *dsi, const void *payload,
 			       size_t size);
 int mipi_dsi_generic_write_chatty(struct mipi_dsi_device *dsi,
 				  const void *payload, size_t size);
+void mipi_dsi_generic_write_multi(struct mipi_dsi_multi_context *ctx,
+				  const void *payload, size_t size);
 ssize_t mipi_dsi_generic_read(struct mipi_dsi_device *dsi, const void *params,
 			      size_t num_params, void *data, size_t size);
 
@@ -283,6 +301,8 @@ ssize_t mipi_dsi_dcs_write_buffer(struct mipi_dsi_device *dsi,
 				  const void *data, size_t len);
 int mipi_dsi_dcs_write_buffer_chatty(struct mipi_dsi_device *dsi,
 				     const void *data, size_t len);
+void mipi_dsi_dcs_write_buffer_multi(struct mipi_dsi_multi_context *ctx,
+				     const void *data, size_t len);
 ssize_t mipi_dsi_dcs_write(struct mipi_dsi_device *dsi, u8 cmd,
 			   const void *data, size_t len);
 ssize_t mipi_dsi_dcs_read(struct mipi_dsi_device *dsi, u8 cmd, void *data,
@@ -319,6 +339,9 @@ int mipi_dsi_dcs_get_display_brightness_large(struct mipi_dsi_device *dsi,
  * This macro will print errors for you and will RETURN FROM THE CALLING
  * FUNCTION (yes this is non-intuitive) upon error.
  *
+ * Because of the non-intuitive return behavior, THIS MACRO IS DEPRECATED.
+ * Please replace calls of it with mipi_dsi_generic_write_seq_multi().
+ *
  * @dsi: DSI peripheral device
  * @seq: buffer containing the payload
  */
@@ -331,12 +354,30 @@ int mipi_dsi_dcs_get_display_brightness_large(struct mipi_dsi_device *dsi,
 			return ret;                                            \
 	} while (0)
 
+/**
+ * mipi_dsi_generic_write_seq_multi - transmit data using a generic write packet
+ *
+ * This macro will print errors for you and error handling is optimized for
+ * callers that call this multiple times in a row.
+ *
+ * @ctx: Context for multiple DSI transactions
+ * @seq: buffer containing the payload
+ */
+#define mipi_dsi_generic_write_seq_multi(ctx, seq...)                \
+	do {                                                         \
+		static const u8 d[] = { seq };                       \
+		mipi_dsi_generic_write_multi(ctx, d, ARRAY_SIZE(d)); \
+	} while (0)
+
 /**
  * mipi_dsi_dcs_write_seq - transmit a DCS command with payload
  *
  * This macro will print errors for you and will RETURN FROM THE CALLING
  * FUNCTION (yes this is non-intuitive) upon error.
  *
+ * Because of the non-intuitive return behavior, THIS MACRO IS DEPRECATED.
+ * Please replace calls of it with mipi_dsi_dcs_write_seq_multi().
+ *
  * @dsi: DSI peripheral device
  * @cmd: Command
  * @seq: buffer containing data to be transmitted
@@ -350,6 +391,22 @@ int mipi_dsi_dcs_get_display_brightness_large(struct mipi_dsi_device *dsi,
 			return ret;                                            \
 	} while (0)
 
+/**
+ * mipi_dsi_dcs_write_seq_multi - transmit a DCS command with payload
+ *
+ * This macro will print errors for you and error handling is optimized for
+ * callers that call this multiple times in a row.
+ *
+ * @ctx: Context for multiple DSI transactions
+ * @cmd: Command
+ * @seq: buffer containing data to be transmitted
+ */
+#define mipi_dsi_dcs_write_seq_multi(ctx, cmd, seq...)                  \
+	do {                                                            \
+		static const u8 d[] = { cmd, seq };                     \
+		mipi_dsi_dcs_write_buffer_multi(ctx, d, ARRAY_SIZE(d)); \
+	} while (0)
+
 /**
  * struct mipi_dsi_driver - DSI driver
  * @driver: device driver model driver
-- 
2.44.0.769.g3c40516874-goog


