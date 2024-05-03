Return-Path: <linux-kernel+bounces-168123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A945E8BB402
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 444421F257C2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 19:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EB8158D64;
	Fri,  3 May 2024 19:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ox4P8tfi"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CF215884C
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 19:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714764574; cv=none; b=gBucXxAqzk9sSLxSyv6UAIjj0jyRgiu2e0U3qx1JVNdi3cuaZIRmIWThtR3ut+8OIuNnv+7uSoxUMFDIlTBNV9x7G+jODdap0WkIH4kDRiYq3TftbEG6T/Koo7Sz6fyKkeAadjI6LX6DrgOcbiIi2ge/bLyNVNQUtTqyPi+2Zsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714764574; c=relaxed/simple;
	bh=sCcuwPgsubwyvq5INWC3rtyH9ttsfwPVllVxyHV7pHo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tr+QmDzKtsNa6morONkfaESXWFPmAQuD3ploG2tL7UPmezggPMQ2LbBf4xsbrll5EdeE/hBatojxhJSSe2RY5RLajamd+ZknH4wpF6vmKuOFWClohAdOq4oubXTtV7bzRQJfHmZqS9mIeqds3/3fdtmz5aXOO5Q6jkt5Ge7zj9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ox4P8tfi; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714764571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cQ2e8hgiGDZBXEW1L5MiD7LSuS/VPNYQnMQFa72oN6c=;
	b=ox4P8tfisHwN1tQ6Q/03B6cky9MCK1VFIh6qZjp1uggchco53uKdIr3RxIB4GnJSRDjen8
	g+NgWLVuHX2kgEegdW8767YapfzGdPLJbJV/b48B+NhhlcUVLRpM4t/vcVPIX4OYCVRNSX
	tQ5z+2V8oBStQHHd7l0vbnPFsyaVpTc=
From: Sean Anderson <sean.anderson@linux.dev>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org
Cc: linux-arm-kernel@lists.infradead.org,
	David Airlie <airlied@gmail.com>,
	linux-kernel@vger.kernel.org,
	Daniel Vetter <daniel@ffwll.ch>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Michal Simek <michal.simek@amd.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH v5 01/10] drm: zynqmp_kms: Fix AUX bus not getting unregistered
Date: Fri,  3 May 2024 15:29:13 -0400
Message-Id: <20240503192922.2172314-2-sean.anderson@linux.dev>
In-Reply-To: <20240503192922.2172314-1-sean.anderson@linux.dev>
References: <20240503192922.2172314-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

drm_encoder_cleanup is responsible for calling drm_bridge_detach for
each bridge attached to the encoder. zynqmp_dp_bridge_detach is in turn
responsible for unregistering the AUX bus. However, we never ended up
calling drm_encoder_cleanup in the remove or error paths, so the AUX bus
would stick around after the rest of the driver had been removed.

I don't really understand why drm_mode_config_cleanup doesn't call
drm_encoder_cleanup for us. It will call destroy (which for
simple_encoder is drm_encoder_cleanup) on encoders in the mode_config's
encoder_list.

Should drm_encoder_cleanup get called before or after
drm_atomic_helper_shutdown?

Fixes: 2dfd045c8435 ("drm: xlnx: zynqmp_dpsub: Register AUX bus at bridge attach time")
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

Changes in v5:
- New

 drivers/gpu/drm/xlnx/zynqmp_kms.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_kms.c b/drivers/gpu/drm/xlnx/zynqmp_kms.c
index 43bf416b33d5..f25583ce92e6 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_kms.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_kms.c
@@ -433,23 +433,28 @@ static int zynqmp_dpsub_kms_init(struct zynqmp_dpsub *dpsub)
 				DRM_BRIDGE_ATTACH_NO_CONNECTOR);
 	if (ret) {
 		dev_err(dpsub->dev, "failed to attach bridge to encoder\n");
-		return ret;
+		goto err_encoder;
 	}
 
 	/* Create the connector for the chain of bridges. */
 	connector = drm_bridge_connector_init(&dpsub->drm->dev, encoder);
 	if (IS_ERR(connector)) {
 		dev_err(dpsub->dev, "failed to created connector\n");
-		return PTR_ERR(connector);
+		ret = PTR_ERR(connector);
+		goto err_encoder;
 	}
 
 	ret = drm_connector_attach_encoder(connector, encoder);
 	if (ret < 0) {
 		dev_err(dpsub->dev, "failed to attach connector to encoder\n");
-		return ret;
+		goto err_encoder;
 	}
 
 	return 0;
+
+err_encoder:
+	drm_encoder_cleanup(encoder);
+	return ret;
 }
 
 static void zynqmp_dpsub_drm_release(struct drm_device *drm, void *res)
@@ -529,5 +534,6 @@ void zynqmp_dpsub_drm_cleanup(struct zynqmp_dpsub *dpsub)
 
 	drm_dev_unregister(drm);
 	drm_atomic_helper_shutdown(drm);
+	drm_encoder_cleanup(&dpsub->drm->encoder);
 	drm_kms_helper_poll_fini(drm);
 }
-- 
2.35.1.1320.gc452695387.dirty


