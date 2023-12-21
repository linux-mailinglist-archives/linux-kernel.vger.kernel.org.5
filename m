Return-Path: <linux-kernel+bounces-8368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83DA181B650
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A958D1C20A44
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099A17319C;
	Thu, 21 Dec 2023 12:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="e8l1ENh8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09CF6EB7D;
	Thu, 21 Dec 2023 12:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703162913;
	bh=hcDq139jNITXi7r1QTykVkAgtjt/plMZnUyanP1kC/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e8l1ENh83KKQ/+FT8K1P+/H6Xa+pRFRhXZr8kTT7IWCG83QKpHY8zyph3lc+rP0ZC
	 9QpdiUeZ21PyJLZIZ3eqbqM30af5qZUJLOeRaCPCaLHidHrRHYufkw4CeWtyTnneVm
	 ELdd6MwZ132kX9JyLMM5/w8k1PVLJ8Vxrbo99Nzfq58J3rgeWUGrsce5QFi2cUCjUM
	 MpHYEHRUC4vcyZt7qzP8AxHGgzEWm7pfPVyJhpDtb02hjLAhSWTkHVwFwOAL0uRQKp
	 YGAQmg+AxwSdtnKlmpRkOkXF+QzEZW/FCbZ7mba7xBw2nX4JrH6Ydpk5TmXfy0ZUWT
	 4J0vesx0hvB9w==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 86E773781F84;
	Thu, 21 Dec 2023 12:48:32 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: daniel.lezcano@linaro.org
Cc: rafael@kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	kernel@collabora.com
Subject: [RFC PATCH 01/26] thermal: Introduce thermal_zone_device_register() and params structure
Date: Thu, 21 Dec 2023 13:48:00 +0100
Message-ID: <20231221124825.149141-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221124825.149141-1-angelogioacchino.delregno@collabora.com>
References: <20231221124825.149141-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for extending the thermal zone devices to actually have
a name and disambiguation of thermal zone types/names, introduce a new
thermal_zone_device_params structure which holds all of the parameters
that are necessary to register a thermal zone device, then add a new
function thermal_zone_device_register().

The latter takes as parameter the newly introduced structure and is
made to eventually replace all usages of the now deprecated function
thermal_zone_device_register_with_trips() and of
thermal_tripless_zone_device_register().

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/thermal/thermal_core.c | 27 +++++++++++++++++++++++++++
 include/linux/thermal.h        | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index e5434cdbf23b..6be508eb2d72 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1235,6 +1235,8 @@ EXPORT_SYMBOL_GPL(thermal_zone_get_crit_temp);
  *		   whether trip points have been crossed (0 for interrupt
  *		   driven systems)
  *
+ * This function is deprecated. See thermal_zone_device_register().
+ *
  * This interface function adds a new thermal zone device (sensor) to
  * /sys/class/thermal folder as thermal_zone[0-*]. It tries to bind all the
  * thermal cooling devices registered at the same time.
@@ -1409,6 +1411,7 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
 }
 EXPORT_SYMBOL_GPL(thermal_zone_device_register_with_trips);
 
+/* This function is deprecated. See thermal_zone_device_register(). */
 struct thermal_zone_device *thermal_tripless_zone_device_register(
 					const char *type,
 					void *devdata,
@@ -1420,6 +1423,30 @@ struct thermal_zone_device *thermal_tripless_zone_device_register(
 }
 EXPORT_SYMBOL_GPL(thermal_tripless_zone_device_register);
 
+/**
+ * thermal_zone_device_register() - register a new thermal zone device
+ * @tzdp:	Parameters of the new thermal zone device
+ *		See struct thermal_zone_device_register.
+ *
+ * This interface function adds a new thermal zone device (sensor) to
+ * /sys/class/thermal folder as thermal_zone[0-*]. It tries to bind all the
+ * thermal cooling devices registered at the same time.
+ * thermal_zone_device_unregister() must be called when the device is no
+ * longer needed. The passive cooling depends on the .get_trend() return value.
+ *
+ * Return: a pointer to the created struct thermal_zone_device or an
+ * in case of error, an ERR_PTR. Caller must check return value with
+ * IS_ERR*() helpers.
+ */
+struct thermal_zone_device *thermal_zone_device_register(struct thermal_zone_device_params *tzdp)
+{
+	return thermal_zone_device_register_with_trips(tzdp->type, tzdp->trips, tzdp->num_trips,
+						       tzdp->mask, tzdp->devdata, tzdp->ops,
+						       &tzdp->tzp, tzdp->passive_delay,
+						       tzdp->polling_delay);
+}
+EXPORT_SYMBOL_GPL(thermal_zone_device_register);
+
 void *thermal_zone_device_priv(struct thermal_zone_device *tzd)
 {
 	return tzd->devdata;
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 98957bae08ff..c6ed33a7e468 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -258,6 +258,33 @@ struct thermal_zone_params {
 	int offset;
 };
 
+/**
+ * struct thermal_zone_device_params - parameters for a thermal zone device
+ * @type:		the thermal zone device type
+ * @tzp:		thermal zone platform parameters
+ * @ops:		standard thermal zone device callbacks
+ * @devdata:		private device data
+ * @trips:		a pointer to an array of thermal trips, if any
+ * @num_trips:		the number of trip points the thermal zone support
+ * @mask:		a bit string indicating the writeablility of trip points
+ * @passive_delay:	number of milliseconds to wait between polls when
+ *			performing passive cooling
+ * @polling_delay:	number of milliseconds to wait between polls when checking
+ *			whether trip points have been crossed (0 for interrupt
+ *			driven systems)
+ */
+struct thermal_zone_device_params {
+	const char *type;
+	struct thermal_zone_params tzp;
+	struct thermal_zone_device_ops *ops;
+	void *devdata;
+	struct thermal_trip *trips;
+	int num_trips;
+	int mask;
+	int passive_delay;
+	int polling_delay;
+};
+
 /* Function declarations */
 #ifdef CONFIG_THERMAL_OF
 struct thermal_zone_device *devm_thermal_of_zone_register(struct device *dev, int id, void *data,
@@ -310,6 +337,8 @@ struct thermal_zone_device *thermal_tripless_zone_device_register(
 					struct thermal_zone_device_ops *ops,
 					const struct thermal_zone_params *tzp);
 
+struct thermal_zone_device *thermal_zone_device_register(struct thermal_zone_device_params *tzdp);
+
 void thermal_zone_device_unregister(struct thermal_zone_device *tz);
 
 void *thermal_zone_device_priv(struct thermal_zone_device *tzd);
@@ -372,6 +401,10 @@ static inline struct thermal_zone_device *thermal_tripless_zone_device_register(
 					const struct thermal_zone_params *tzp)
 { return ERR_PTR(-ENODEV); }
 
+static inline struct thermal_zone_device *thermal_zone_device_register(
+					struct thermal_zone_device_params *tzdp)
+{ return ERR_PTR(-ENODEV); }
+
 static inline void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 { }
 
-- 
2.43.0


