Return-Path: <linux-kernel+bounces-165508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC818B8D68
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 17:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E497128495E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 15:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA0A12FB37;
	Wed,  1 May 2024 15:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MYqE2+W/"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A620512F5BE
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 15:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714578213; cv=none; b=EqRgmkPykbpbAsJfQj568lYUaucFx7lgIjgn3V4pTlwjiW3Sr6ZwDlvMkmHFPC3KR8e8KjlnnUggBt0bwZZoIJL9bCtDYPLR8lM5u3JDRHJpC61larvY8qvdBjque+Vk6uJmt06SdYMHhUkF9vQxBUwbTCOGDBLna3aNv2TzRP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714578213; c=relaxed/simple;
	bh=iX/2Xz7SgoVhTkI6iA0U9mq9MhmHRTeqAoKISHCNd3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EgeVAwQTxlbrXBLmbOEvTgBkqKosffyvqvusc4buuUQUVHQPrc/3lDw/3Lqe/4kkw14d9Vy0LQEPo84ULwig1oIbypA1vZd2IonkZCnSqI3VxS35COK9YRv1EjLDwH60drQ4Uri1OTTSEloYbA5US6QllQPUKvodY6sxFbH/caQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MYqE2+W/; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6ed627829e6so8178150b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 08:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714578210; x=1715183010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O8K2bD3VSCdKM5fxY8ne7lxaMKISymJY6P8xiQj5Fs0=;
        b=MYqE2+W/5iNTbU/upFNxyKpe9qS4xEl3WDTDmPpr+Uey7NjZ7C1+wr4oWZywmuWCb8
         Sa749FxUcKe/8BRRh8RtMr00NNYQYZl8yIHdsDxOWxG4JB26ujyKx4rxyKXGi7Bt2jSN
         AkOy9bpErBXExj94NRTRM/hOsE8HO2RMXHkB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714578210; x=1715183010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O8K2bD3VSCdKM5fxY8ne7lxaMKISymJY6P8xiQj5Fs0=;
        b=n6DFI+aF/uIsJ8z1uk/IEWqO98/MMi+7iT16O8o9N4A/Gf4bwUp2CoOmXTh7p6XGgK
         QhD3k9g00gALTiKHOS3XIedxx9Y4UzPMVEdby4DIkicmmMjmnHqTt9p3HrcKRkmzN/GK
         pbIScpvZRYCZLiq+QfwOlwEbnmMOdPB0A5pgrjVCh5PchrGQelO6Y4f0cnAZ8ooZoKCD
         R6z5cxD1TInj0fKkOA2PHZv1/wmvoa4jnBDPtZ6BDvI8qaY7uVweqoKCtGOoes8/MvFU
         +sTku+1X2mE/gHiUHTGi10elUs8dJ3PnsGEH6ENTcMo/KsStRErydOoj8U55ja08Pozk
         eRqw==
X-Forwarded-Encrypted: i=1; AJvYcCVFshLC9U7BH3v3FlBo3lfG8/hFeEW8Pqkvc29l+HC0YYpmP1SDx3SuXFz/GP2WH0Oke2Xcp0F16TA7kws5VRPAe270JAyuKvewfbel
X-Gm-Message-State: AOJu0YxYM41dFb6pGAVKvYJNgf0h1khJSKjSdSWe8PxRMVqE4Tgs0Eta
	S9RLdu7MvcGHraGGMYZKkoYZuLQEIZuAuY0cQHfeyS7YjpYFRByVchVXc8M3Fw==
X-Google-Smtp-Source: AGHT+IG8Kd2PCiOfCuYcQSZZv4vbMZ11cB15Vz0uNMp7sIiPbstNdmqih9l8A3cISPQr6ZXTK0Z3tg==
X-Received: by 2002:a05:6a20:1581:b0:1a7:4b3f:a66c with SMTP id h1-20020a056a20158100b001a74b3fa66cmr3384371pzj.49.1714578209974;
        Wed, 01 May 2024 08:43:29 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:e886:8de:19a2:55b0])
        by smtp.gmail.com with ESMTPSA id fb12-20020a056a002d8c00b006f3ec69bc09sm7717924pfb.75.2024.05.01.08.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 08:43:29 -0700 (PDT)
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
	Jonathan Corbet <corbet@lwn.net>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/9] drm/mipi-dsi: Introduce mipi_dsi_*_write_seq_multi()
Date: Wed,  1 May 2024 08:41:08 -0700
Message-ID: <20240501084109.v3.5.Ie94246c30fe95101e0e26dd5f96e976dbeb8f242@changeid>
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
Right now this patch introduces two new functions in drm_mipi_dsi.c.
Alternatively we could have changed the prototype of the "chatty"
functions and made the deprecated macros adapt to the new prototype.
While this sounds nice, it bloated callers of the deprecated functioin
a bit because it caused the compiler to emit less optimal code. It
doesn't seem terrible to add two more functions, so I went that
way. There may be cases where callers who aren't writing many
sequences prefer to use the "chatty" versions anyway.

Changes in v3:
- Add a TODO item for cleaning up the deprecated macros/functions.
- Inline kerneldoc comments for struct mipi_dsi_multi_context.

Changes in v2:
- New

 Documentation/gpu/todo.rst     | 18 ++++++++++
 drivers/gpu/drm/drm_mipi_dsi.c | 56 ++++++++++++++++++++++++++++++
 include/drm/drm_mipi_dsi.h     | 62 ++++++++++++++++++++++++++++++++++
 3 files changed, 136 insertions(+)

diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index fb9ad120b141..45a59c176b06 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -507,6 +507,24 @@ Contact: Douglas Anderson <dianders@chromium.org>
 
 Level: Starter/Intermediate
 
+Transition away from using mipi_dsi_*_write_seq()
+-------------------------------------------------
+
+The macros mipi_dsi_generic_write_seq() and mipi_dsi_dcs_write_seq() are
+non-intuitive because, if there are errors, they return out of the *caller's*
+function. We should move all callers to use mipi_dsi_generic_write_seq_multi()
+and mipi_dsi_dcs_write_seq_multi() macros instead.
+
+Once all callers are transitioned, the macros and the functions that they call,
+mipi_dsi_generic_write_chatty() and mipi_dsi_dcs_write_buffer_chatty(), can
+probably be removed. Alternatively, if people feel like the _multi() variants
+are overkill for some use cases, we could keep the mipi_dsi_*_write_seq()
+variants but change them not to return out of the caller.
+
+Contact: Douglas Anderson <dianders@chromium.org>
+
+Level: Starter
+
 
 Core refactorings
 =================
diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index 8593d9ed5891..d2957cb692d3 100644
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
+		dev_err(dev, "sending generic data %*ph failed: %d\n",
+			(int)size, payload, ctx->accum_err);
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
+		dev_err(dev, "sending dcs data %*ph failed: %d\n",
+			(int)len, data, ctx->accum_err);
+	}
+}
+EXPORT_SYMBOL(mipi_dsi_dcs_write_buffer_multi);
+
 /**
  * mipi_dsi_dcs_write() - send DCS write command
  * @dsi: DSI peripheral device
diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
index 6d68d9927f46..5e9cad541bd6 100644
--- a/include/drm/drm_mipi_dsi.h
+++ b/include/drm/drm_mipi_dsi.h
@@ -197,6 +197,27 @@ struct mipi_dsi_device {
 	struct drm_dsc_config *dsc;
 };
 
+/**
+ * struct mipi_dsi_multi_context - Context to call multiple MIPI DSI funcs in a row
+ */
+struct mipi_dsi_multi_context {
+	/**
+	 * @dsi: Pointer to the MIPI DSI device
+	 */
+	struct mipi_dsi_device *dsi;
+
+	/**
+	 * @accum_err: Storage for the accumulated error over the multiple calls
+	 *
+	 * Init to 0. If a function encounters an error then the error code
+	 * will be stored here. If you call a function and this points to a
+	 * non-zero value then the function will be a noop. This allows calling
+	 * a function many times in a row and just checking the error at the
+	 * end to see if any of them failed.
+	 */
+	int accum_err;
+};
+
 #define MIPI_DSI_MODULE_PREFIX "mipi-dsi:"
 
 #define to_mipi_dsi_device(__dev)	container_of_const(__dev, struct mipi_dsi_device, dev)
@@ -258,6 +279,8 @@ ssize_t mipi_dsi_generic_write(struct mipi_dsi_device *dsi, const void *payload,
 			       size_t size);
 int mipi_dsi_generic_write_chatty(struct mipi_dsi_device *dsi,
 				  const void *payload, size_t size);
+void mipi_dsi_generic_write_multi(struct mipi_dsi_multi_context *ctx,
+				  const void *payload, size_t size);
 ssize_t mipi_dsi_generic_read(struct mipi_dsi_device *dsi, const void *params,
 			      size_t num_params, void *data, size_t size);
 
@@ -283,6 +306,8 @@ ssize_t mipi_dsi_dcs_write_buffer(struct mipi_dsi_device *dsi,
 				  const void *data, size_t len);
 int mipi_dsi_dcs_write_buffer_chatty(struct mipi_dsi_device *dsi,
 				     const void *data, size_t len);
+void mipi_dsi_dcs_write_buffer_multi(struct mipi_dsi_multi_context *ctx,
+				     const void *data, size_t len);
 ssize_t mipi_dsi_dcs_write(struct mipi_dsi_device *dsi, u8 cmd,
 			   const void *data, size_t len);
 ssize_t mipi_dsi_dcs_read(struct mipi_dsi_device *dsi, u8 cmd, void *data,
@@ -319,6 +344,9 @@ int mipi_dsi_dcs_get_display_brightness_large(struct mipi_dsi_device *dsi,
  * This macro will print errors for you and will RETURN FROM THE CALLING
  * FUNCTION (yes this is non-intuitive) upon error.
  *
+ * Because of the non-intuitive return behavior, THIS MACRO IS DEPRECATED.
+ * Please replace calls of it with mipi_dsi_generic_write_seq_multi().
+ *
  * @dsi: DSI peripheral device
  * @seq: buffer containing the payload
  */
@@ -331,12 +359,30 @@ int mipi_dsi_dcs_get_display_brightness_large(struct mipi_dsi_device *dsi,
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
@@ -350,6 +396,22 @@ int mipi_dsi_dcs_get_display_brightness_large(struct mipi_dsi_device *dsi,
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
2.45.0.rc0.197.gbae5840b3b-goog


