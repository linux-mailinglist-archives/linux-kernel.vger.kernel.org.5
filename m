Return-Path: <linux-kernel+bounces-33342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 507168368A2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42218B2BFE3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA6B482FB;
	Mon, 22 Jan 2024 15:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O63EW5ix"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DED633F9;
	Mon, 22 Jan 2024 15:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935934; cv=none; b=C2zhFqRo2Ph6n8REgKA2bF9XHsektBbK2kO38tXvDT6WEUALMvwZGG3ZwVeytIZuAbDPp+P96qEYS3MSc/7ll/Zlvg+aHc98wRnBkjX/0qW5hLbDIlaSAepYaoDOm6ih27FMLTz1wZnxszXZFtC7qc4APhLQxYMNaFhSgHb7ubg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935934; c=relaxed/simple;
	bh=LcM1J8JXu/WkuyLUAnmbSDWLN8uNldFny21YGjP87KM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nz3g3zPWZjONnqJ4s8neQBLdIlx6pbirBia8PMvBuNXbkctwPQNkHOw62FgDYv4qCodoiXXqbC+pKraVDnCT3evIHO03v2T7In8XzfVbGECBJcKVZuYh7TTguhlE3BYBaqmsOwd5Bz6HgbaPp2xjRVyrQCXORg/+fbX6xPYiQ4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O63EW5ix; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9C14C41674;
	Mon, 22 Jan 2024 15:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935934;
	bh=LcM1J8JXu/WkuyLUAnmbSDWLN8uNldFny21YGjP87KM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O63EW5ixpCwA8rB2F6WGMZ8A3Yt9727KDeRRVtR2M/MVPQMl/2LpR+bqLuuV67hql
	 A5tQPAJQFSFE0LlHCHpBLF2IjDOrwmnIRnTcZCVqX1wteIo5+q3zjeUENtcPLlAivY
	 1YY5JRzSChyQqNa6D7PZUQjyf50lwxYDW2sM9XWTVBFDbh7Va8/S3a9YgVnB4AEATG
	 kYk9pfQg0mqkbbVSJvWD0UO2Fpf9vE2IEQ9yZL3Zor6i6I19MBrdXi2ZCdJACExFnW
	 oeVKyTXFNpmIUfTFTPGnZUsyhkF074jIFScITpNeVeQRXt3Mk2nRxrlbCesJCR2yEd
	 iU/tDxJTJI0RQ==
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
Subject: [PATCH AUTOSEL 6.6 20/73] drm/mipi-dsi: Fix detach call without attach
Date: Mon, 22 Jan 2024 10:01:34 -0500
Message-ID: <20240122150432.992458-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122150432.992458-1-sashal@kernel.org>
References: <20240122150432.992458-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.13
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
index 14201f73aab1..843a6dbda93a 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -347,7 +347,8 @@ static int mipi_dsi_remove_device_fn(struct device *dev, void *priv)
 {
 	struct mipi_dsi_device *dsi = to_mipi_dsi_device(dev);
 
-	mipi_dsi_detach(dsi);
+	if (dsi->attached)
+		mipi_dsi_detach(dsi);
 	mipi_dsi_device_unregister(dsi);
 
 	return 0;
@@ -370,11 +371,18 @@ EXPORT_SYMBOL(mipi_dsi_host_unregister);
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
 
@@ -386,9 +394,14 @@ int mipi_dsi_detach(struct mipi_dsi_device *dsi)
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
index c9df0407980c..c0aec0d4d664 100644
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


