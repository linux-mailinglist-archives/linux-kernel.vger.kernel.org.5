Return-Path: <linux-kernel+bounces-160794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 989DF8B42F6
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 02:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B56C2B22738
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 00:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748164503C;
	Fri, 26 Apr 2024 23:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d5st/RQc"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5236F4436A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 23:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714175957; cv=none; b=J7Avu4aGCtU2k5twllTdY/qZ0QdOKFCR/TPPpnN5FDrz9JUsaXo/NpGh4tqHkpaR++J+BA6ysQSHKp6ceUgCIHlI1/wMRcBcGJMPDSOk/cn2SMx6ehiy319KsAMTU+Ba5JtccLAXCCX55HVfQhkxDeE4yiInHm1mklM54oat1jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714175957; c=relaxed/simple;
	bh=XjxQ5c3mf77OAJBWrnBr+sPPhFiq5OfHnwgYZ6GKLM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HjoCsCE9y7GdrTGWQQBqbeiwwFf9BhULSCAPEomV+2iIcJFQ77VC8zUiV0Lc5Jf+qwMPzCSjaqZHpW8sBnnug5YVHm5wKrnMGzP646c4HbgoZx2iAaT5D22fb7fDKUSH6pZcYGz7nPzL83Xsyjrd3dDvcplj593bFX2deE+zUKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=d5st/RQc; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ab88634cfaso2236200a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 16:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714175955; x=1714780755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZzSfB/1n9+jedI2oBQjWcrR3uyh08/jlbQ/BhI/Hdw=;
        b=d5st/RQcKHTHcmGIBusEdqgDiUeMzHjsxXZGqQMmw75zct367aA/OcS8pmXpON/mE/
         l5TFDSOXQ59ZMci91zPqjAZnuPyyO0jI++pFNPE4Eok1hbSFUjILs98gxX1ZkmyIOKkU
         EN12jyj8vBJ10xp4ebo5kikUtwMtC77gws3S0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714175955; x=1714780755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hZzSfB/1n9+jedI2oBQjWcrR3uyh08/jlbQ/BhI/Hdw=;
        b=R7B7vboxVyS4tWsERvjqUAF8WD4klKNm1KuLfO+fLtzgNJSDZENhUX7e63sfr99acY
         IDizJrvEJnX/hGfY2SPdy2im2c0owaQWqtgube8JCgUpaOeGuy9CeqFspBGlPOutbyGc
         /APk/wqvM6SRFF4LHEqRGyc7VgqJcfwpm84ZUZo88WmdcgKVnhsVGY8aUvlPfv1/XK6p
         1R60+SFzuxPxOHAnyk0k38TYv5Bf/QgU70cNfS4nd4DEWz3DjXMLW5gGtfQ0UvVlL/X0
         q1iBWLag5gJS5vY/vOLQ62fDFSrVXQmR633abNcBBK07FPInkBKRq6trew7KthKHQWKW
         pATQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1vIzIYrIv1hJKIREk0d1199Wc7n5zeFOtJi5xSC99eCadGV4+i/9G4X4dxFy30osS+DbJqHaPIi1PV/UU6ucgEBZTr+3UP1LIXb9E
X-Gm-Message-State: AOJu0YyJaFEivKh9dlcf5kJ7iHR4geY12DGcJQ0BGbGqXV3R/nEMRaAk
	2uUlc4eoiK6F2xYebYb5W3E0gfGzHZ7qV+lyxILEh+Vpa5J7Zb58ykgFb6vb5A==
X-Google-Smtp-Source: AGHT+IFoJpPKq/WRiQvEti4tzyFjVp2ObidfEpxF1tBEZezg21mRL219dd0QaSSZbuMenSdPDiKAxw==
X-Received: by 2002:a17:90a:f2d0:b0:2ae:ee75:1479 with SMTP id gt16-20020a17090af2d000b002aeee751479mr4274243pjb.25.1714175955634;
        Fri, 26 Apr 2024 16:59:15 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:fca:3ae2:20e6:82bb])
        by smtp.gmail.com with ESMTPSA id n4-20020a17090aab8400b002af41bd563esm5111939pjq.33.2024.04.26.16.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 16:59:15 -0700 (PDT)
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
Subject: [PATCH v2 5/8] drm/mipi-dsi: mipi_dsi_*_write functions don't need to ratelimit prints
Date: Fri, 26 Apr 2024 16:58:38 -0700
Message-ID: <20240426165839.v2.5.I9982cd5d8014de7a4513f5619f66f88da49ce4ec@changeid>
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

We really don't expect these errors to be printed over and over
again. When a driver hits the error it should bail out. Just use a
normal error print.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- New

 drivers/gpu/drm/drm_mipi_dsi.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index b7c75a4396e6..8bc2db971e93 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -770,7 +770,7 @@ EXPORT_SYMBOL(mipi_dsi_generic_write);
  * @payload: buffer containing the payload
  * @size: size of payload buffer
  *
- * Like mipi_dsi_generic_write() but includes a dev_err_ratelimited()
+ * Like mipi_dsi_generic_write() but includes a dev_err()
  * call for you and returns 0 upon success, not the number of bytes sent.
  *
  * Return: 0 on success or a negative error code on failure.
@@ -783,8 +783,8 @@ int mipi_dsi_generic_write_chatty(struct mipi_dsi_device *dsi,
 
 	ret = mipi_dsi_generic_write(dsi, payload, size);
 	if (ret < 0) {
-		dev_err_ratelimited(dev, "sending generic data %*ph failed: %d\n",
-				    (int)size, payload, (int)ret);
+		dev_err(dev, "sending generic data %*ph failed: %d\n",
+			(int)size, payload, (int)ret);
 		return ret;
 	}
 
@@ -814,8 +814,8 @@ void mipi_dsi_generic_write_multi(struct mipi_dsi_multi_context *ctx,
 	ret = mipi_dsi_generic_write(dsi, payload, size);
 	if (ret < 0) {
 		ctx->accum_err = ret;
-		dev_err_ratelimited(dev, "sending generic data %*ph failed: %d\n",
-				    (int)size, payload, ctx->accum_err);
+		dev_err(dev, "sending generic data %*ph failed: %d\n",
+			(int)size, payload, ctx->accum_err);
 	}
 }
 EXPORT_SYMBOL(mipi_dsi_generic_write_multi);
@@ -914,7 +914,7 @@ EXPORT_SYMBOL(mipi_dsi_dcs_write_buffer);
  * @data: buffer containing data to be transmitted
  * @len: size of transmission buffer
  *
- * Like mipi_dsi_dcs_write_buffer() but includes a dev_err_ratelimited()
+ * Like mipi_dsi_dcs_write_buffer() but includes a dev_err()
  * call for you and returns 0 upon success, not the number of bytes sent.
  *
  * Return: 0 on success or a negative error code on failure.
@@ -927,8 +927,8 @@ int mipi_dsi_dcs_write_buffer_chatty(struct mipi_dsi_device *dsi,
 
 	ret = mipi_dsi_dcs_write_buffer(dsi, data, len);
 	if (ret < 0) {
-		dev_err_ratelimited(dev, "sending dcs data %*ph failed: %d\n",
-				    (int)len, data, (int)ret);
+		dev_err(dev, "sending dcs data %*ph failed: %d\n",
+			(int)len, data, (int)ret);
 		return ret;
 	}
 
@@ -958,8 +958,8 @@ void mipi_dsi_dcs_write_buffer_multi(struct mipi_dsi_multi_context *ctx,
 	ret = mipi_dsi_dcs_write_buffer(dsi, data, len);
 	if (ret < 0) {
 		ctx->accum_err = ret;
-		dev_err_ratelimited(dev, "sending dcs data %*ph failed: %d\n",
-				    (int)len, data, ctx->accum_err);
+		dev_err(dev, "sending dcs data %*ph failed: %d\n",
+			(int)len, data, ctx->accum_err);
 	}
 }
 EXPORT_SYMBOL(mipi_dsi_dcs_write_buffer_multi);
-- 
2.44.0.769.g3c40516874-goog


