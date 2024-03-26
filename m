Return-Path: <linux-kernel+bounces-119457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0064088C934
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA1A71F65BA2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8595B13CA91;
	Tue, 26 Mar 2024 16:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="H7RHzrLp"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372BD13CC51;
	Tue, 26 Mar 2024 16:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711470522; cv=none; b=SJ/QsU2FkeFbZnyBLCa9b/BiwW55B2tihz5rY1aTM/v/yTCmpVzQ3itAmAHR7EK5fi4DILiZw9+Lc2Ori7l3sZLDuuJ9YSgs64ZHS+QpMU0hK/X5GZTpsMjnkp5XW01lPMXaMfLMzbfV3m8TgowCrbZwSId1DXKiF8sEVaVLufo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711470522; c=relaxed/simple;
	bh=V2/V9+ScTzmE+T6ph5QIRM6bSdthiHWfE8ShdVeXhSk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ikRCci/jE9+gaYcI8VS7GD7+rU+aCYnB8w+d+hDZPPLuT2R85v9qq+1TbtLkVAvxrjVgOvQLQpLtkPX0WSTjJNiV9oZj2NRx8Jh3F3u0zB+Nr/41JAoWYfsq9sjnoKWH+m8Y7Pymn7aajBpZekr7YlXfSqeQFG2qm3rAibTvVbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=H7RHzrLp; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A4A4420012;
	Tue, 26 Mar 2024 16:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711470518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ElqEQwFcV4YHaCCBf2EVHYAZ/9/5OX5WYRwZoNy8qxM=;
	b=H7RHzrLpcIz1FZgjuGDrJW16xhCXRGN2tVMfDyCJqunXhhGbmrYRFpO6xcO+mmpydbQL/b
	CtZ4++t5g3HG4fQdJWZEgZfYer4ZgWxSlAkD2OKZl/ZEL32qSY44xO4K0rv0EIp/X9PE6M
	TEmc4auT8ApbB+ufHLY1dcLOpvvEqFwOdTX+EVg/x6rJ4ibJz2sIVThjXgnnW2a46RYMog
	Abe+NN9pwZIxFcG21dVAukmL8Us4EDjUxbbrkeW631FLQitjyRjPJommxGcS/RwLlejMU1
	I3ICtMz7T8xZ6aJ/XEjRlCjClMcmbJC/2f6Nnj9/34AD5mLmHlzTwFb8q8PMBA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 26 Mar 2024 17:28:13 +0100
Subject: [PATCH 3/4] drm/encoder: add drm_encoder_cleanup_from()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-hotplug-drm-bridge-v1-3-4b51b5eb75d5@bootlin.com>
References: <20240326-hotplug-drm-bridge-v1-0-4b51b5eb75d5@bootlin.com>
In-Reply-To: <20240326-hotplug-drm-bridge-v1-0-4b51b5eb75d5@bootlin.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Paul Kocialkowski <contact@paulk.fr>, 
 =?utf-8?q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: luca.ceresoli@bootlin.com

Supporting hardware whose final part of the DRM pipeline can be physically
removed requires the ability to detach all bridges from a given point to
the end of the pipeline.

Introduce a variant of drm_encoder_cleanup() for this.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/drm_encoder.c | 21 +++++++++++++++++++++
 include/drm/drm_encoder.h     |  1 +
 2 files changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/drm_encoder.c b/drivers/gpu/drm/drm_encoder.c
index 8f2bc6a28482..13149447bec8 100644
--- a/drivers/gpu/drm/drm_encoder.c
+++ b/drivers/gpu/drm/drm_encoder.c
@@ -207,6 +207,27 @@ void drm_encoder_cleanup(struct drm_encoder *encoder)
 }
 EXPORT_SYMBOL(drm_encoder_cleanup);
 
+/**
+ * drm_encoder_cleanup_from - remove a given bridge and all the following
+ * @encoder: encoder whole list of bridges shall be pruned
+ * @bridge: first bridge to remove
+ *
+ * Removes from an encoder all the bridges starting with a given bridges
+ * and until the end of the chain.
+ *
+ * This should not be used in "normal" DRM pipelines. It is only useful for
+ * devices whose final part of the DRM chain can be physically removed and
+ * later reconnected (possibly with different hardware).
+ */
+void drm_encoder_cleanup_from(struct drm_encoder *encoder, struct drm_bridge *bridge)
+{
+	struct drm_bridge *next;
+
+	list_for_each_entry_safe_from(bridge, next, &encoder->bridge_chain, chain_node)
+		drm_bridge_detach(bridge);
+}
+EXPORT_SYMBOL(drm_encoder_cleanup_from);
+
 static void drmm_encoder_alloc_release(struct drm_device *dev, void *ptr)
 {
 	struct drm_encoder *encoder = ptr;
diff --git a/include/drm/drm_encoder.h b/include/drm/drm_encoder.h
index 977a9381c8ba..bafcabb24267 100644
--- a/include/drm/drm_encoder.h
+++ b/include/drm/drm_encoder.h
@@ -320,6 +320,7 @@ static inline struct drm_encoder *drm_encoder_find(struct drm_device *dev,
 }
 
 void drm_encoder_cleanup(struct drm_encoder *encoder);
+void drm_encoder_cleanup_from(struct drm_encoder *encoder, struct drm_bridge *bridge);
 
 /**
  * drm_for_each_encoder_mask - iterate over encoders specified by bitmask

-- 
2.34.1


