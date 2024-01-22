Return-Path: <linux-kernel+bounces-33418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B41FF836974
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4217B1F22B49
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3620A811ED;
	Mon, 22 Jan 2024 15:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ivr1AMMP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6855781210;
	Mon, 22 Jan 2024 15:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936240; cv=none; b=fEXxlQzEQciXWnrWtY+GO0QKhGu52jEB12HMpdmXjC5Og0M4mMXxsy0gDMc6bG5uujWcDW9y6TKp0mqN1sJCAmhdH9i0IDIla5FZEOSXHeh9yV93vr5Z3oQOY30Jn81QfUBdZFXmmdhHctbAafw9HKk1186W4TaYHpO7NFtSbhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936240; c=relaxed/simple;
	bh=m1hhC6O3FfDsgvksyZIqzT8MW670HL6ndDqTDkono/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=llEyZQSz5oEm7J4VF065u0oM16SEx9skMb2+odnAPxgAd5qbvjMWtG8UeXl808uFiNBs0I2KHpMKTSZTwU/q1v8DljQM/pliGzz/ZH6ZlIzOj+sU+uk0Rpz9dAC93l2/JPdIbh6IW9qIFy+yvM5oguJJo3yRcBnC5FqhGveNw2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ivr1AMMP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A43DFC433B1;
	Mon, 22 Jan 2024 15:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936240;
	bh=m1hhC6O3FfDsgvksyZIqzT8MW670HL6ndDqTDkono/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ivr1AMMPN6ROG9YBfJrLitNKX9C+jM6PxVMBh3hAUgRaqszUlAqpKR5iwSCZ1rC/R
	 yi3KsShcGXqbrUlNxTBVwY8RWeWSGRYGKVVC/y4XqZwaTAqtdg9owD54jIT5gK+p3h
	 Ka1ggsLRTBPYQK/eW6Wx+gmKv3Iyo6wwoFGPZ0hUTGo3Z8qtdJy7mmtL7FK8HDlUxR
	 XMFIoeytH6x5BRKpjMEBaK1En70OsvnZQ7UzeGlz+/B6ViZWPrtKycZcMva7lDiG9I
	 kjpJ9lpQuGcNUqgFhdItWUOtMNesGXvqaduIUPIi/sCiH59xXl/v0F3EiC4BAgJ8NX
	 1VzHXWKoiUeYw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	Maxime Ripard <mripard@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Tony Lindgren <tony@atomide.com>,
	Sasha Levin <sashal@kernel.org>,
	maarten.lankhorst@linux.intel.com,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 18/53] drm/mipi-dsi: Fix detach call without attach
Date: Mon, 22 Jan 2024 10:08:19 -0500
Message-ID: <20240122150949.994249-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122150949.994249-1-sashal@kernel.org>
References: <20240122150949.994249-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.74
Content-Transfer-Encoding: 8bit

From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

[ Upstream commit 90d50b8d85834e73536fdccd5aa913b30494fef0 ]

It's been reported that DSI host driver's detach can be called without
the attach ever happening:

https://lore.kernel.org/all/20230412073954.20601-1-tony@atomide.com/

After reading the code, I think this is what happens:

We have a DSI host defined in the device tree and a DSI peripheral under
that host (i.e. an i2c device using the DSI as data bus doesn't exhibit
this behavior).

The host driver calls mipi_dsi_host_register(), which causes (via a few
functions) mipi_dsi_device_add() to be called for the DSI peripheral. So
now we have a DSI device under the host, but attach hasn't been called.

Normally the probing of the devices continues, and eventually the DSI
peripheral's driver will call mipi_dsi_attach(), attaching the
peripheral.

However, if the host driver's probe encounters an error after calling
mipi_dsi_host_register(), and before the peripheral has called
mipi_dsi_attach(), the host driver will do cleanups and return an error
from its probe function. The cleanups include calling
mipi_dsi_host_unregister().

mipi_dsi_host_unregister() will call two functions for all its DSI
peripheral devices: mipi_dsi_detach() and mipi_dsi_device_unregister().
The latter makes sense, as the device exists, but the former may be
wrong as attach has not necessarily been done.

To fix this, track the attached state of the peripheral, and only detach
from mipi_dsi_host_unregister() if the peripheral was attached.

Note that I have only tested this with a board with an i2c DSI
peripheral, not with a "pure" DSI peripheral.

However, slightly related, the unregister machinery still seems broken.
E.g. if the DSI host driver is unbound, it'll detach and unregister the
DSI peripherals. After that, when the DSI peripheral driver unbound
it'll call detach either directly or using the devm variant, leading to
a crash. And probably the driver will crash if it happens, for some
reason, to try to send a message via the DSI bus.

But that's another topic.

Tested-by: H. Nikolaus Schaller <hns@goldelico.com>
Acked-by: Maxime Ripard <mripard@kernel.org>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Tested-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230921-dsi-detach-fix-v1-1-d0de2d1621d9@ideasonboard.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_mipi_dsi.c | 17 +++++++++++++++--
 include/drm/drm_mipi_dsi.h     |  2 ++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index 853208e8dd73..ef7ec68867df 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -346,7 +346,8 @@ static int mipi_dsi_remove_device_fn(struct device *dev, void *priv)
 {
 	struct mipi_dsi_device *dsi = to_mipi_dsi_device(dev);
 
-	mipi_dsi_detach(dsi);
+	if (dsi->attached)
+		mipi_dsi_detach(dsi);
 	mipi_dsi_device_unregister(dsi);
 
 	return 0;
@@ -369,11 +370,18 @@ EXPORT_SYMBOL(mipi_dsi_host_unregister);
 int mipi_dsi_attach(struct mipi_dsi_device *dsi)
 {
 	const struct mipi_dsi_host_ops *ops = dsi->host->ops;
+	int ret;
 
 	if (!ops || !ops->attach)
 		return -ENOSYS;
 
-	return ops->attach(dsi->host, dsi);
+	ret = ops->attach(dsi->host, dsi);
+	if (ret)
+		return ret;
+
+	dsi->attached = true;
+
+	return 0;
 }
 EXPORT_SYMBOL(mipi_dsi_attach);
 
@@ -385,9 +393,14 @@ int mipi_dsi_detach(struct mipi_dsi_device *dsi)
 {
 	const struct mipi_dsi_host_ops *ops = dsi->host->ops;
 
+	if (WARN_ON(!dsi->attached))
+		return -EINVAL;
+
 	if (!ops || !ops->detach)
 		return -ENOSYS;
 
+	dsi->attached = false;
+
 	return ops->detach(dsi->host, dsi);
 }
 EXPORT_SYMBOL(mipi_dsi_detach);
diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
index 9054a5185e1a..31171914990a 100644
--- a/include/drm/drm_mipi_dsi.h
+++ b/include/drm/drm_mipi_dsi.h
@@ -168,6 +168,7 @@ struct mipi_dsi_device_info {
  * struct mipi_dsi_device - DSI peripheral device
  * @host: DSI host for this peripheral
  * @dev: driver model device node for this peripheral
+ * @attached: the DSI device has been successfully attached
  * @name: DSI peripheral chip type
  * @channel: virtual channel assigned to the peripheral
  * @format: pixel format for video mode
@@ -184,6 +185,7 @@ struct mipi_dsi_device_info {
 struct mipi_dsi_device {
 	struct mipi_dsi_host *host;
 	struct device dev;
+	bool attached;
 
 	char name[DSI_DEV_NAME_SIZE];
 	unsigned int channel;
-- 
2.43.0


