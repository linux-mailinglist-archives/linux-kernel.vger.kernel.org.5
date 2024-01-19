Return-Path: <linux-kernel+bounces-31074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E30D832866
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 12:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B509A1F21BA8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B62C4D10C;
	Fri, 19 Jan 2024 11:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="R5oRRDYq"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB26B4CDE0
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 11:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705662534; cv=none; b=q8vr6sIs43X/aHyARYG+6nzQXNnuXgWSpTGiKajAYwi1IcMMRRNNIDaKglwW8jUbQtwRCRNclyaJZik3Ar2+vhkOLQyuFY1tMTpmrKBqzkQ1LpDpygYU/QQ5uilRufmNwT6GxXvyjaI/58Gp01riFGmIkEdwTus73Em3Vi9I8hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705662534; c=relaxed/simple;
	bh=b/1cDuU1FPYFRLGVprzXpiPsw0rIQZ8Z7rTjJT6ZLPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LGVNz7MIORya4Do3JI8BjFZdn17mC7sNVDYVz5vIccEXeOL6z3ThgVA5XztRLl+050FmheUviF6893ujvFfb7mUxVHedBWq4oY5BtlJQudrAwF1Tjier0+aOXK4CM9KDphsqtu5PDE/9OJGdULj39LuR3Uh6oAI/5WHzcSy0q+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=R5oRRDYq; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so62437966b.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 03:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1705662531; x=1706267331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dkXNmIyIg21DM466Px7ATM2iJxIu/N6buiuxFMSlXzc=;
        b=R5oRRDYqeSE6E2BSnEElXqR8Dvbmekn64eyTgNK9+4YS9XqdkfqXfg1EQKmfmZmiJd
         PKhZXvksi2Gx+8vQbyJ+k/LL3PnAlNgW7HSb6L7o0vgDyabgbyT1xtX0o5t5fPk8ybV6
         A8swsJ6ZRcJe/CQPnfBvHOe0YE/EUF6VWMW20Tmqstj9poTWY6Bv7B6i8ZjRpLeLpYVb
         xEQolSJOuVW68fKTCZZCph5/R/1M8It13Sag8UF6YZTRZVMF+7RUWrDJBtD9XBRgDDLd
         ixZ+9AouJ7lDL25FJqauxFbTTGWAPCLekQsYv/B7iZ00BbDuBM2G/f30X/CbRqFsxeca
         cYqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705662531; x=1706267331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dkXNmIyIg21DM466Px7ATM2iJxIu/N6buiuxFMSlXzc=;
        b=SswBEFkjll43JIONyM4bH/i+j/IZmPCUV/zabHyzGpdIZOrtXZzQ1qr+d7M4L9ssnd
         82/njMhjr/B7xO/iQ8PlYIY6jDzC9aGiYsNrf02G3dBsqkJeHSe59e5am5kOydc4azVm
         wyFY82LWlYI9IF9Onc6aEl+ItYc0BHD6JTZXQEMN0iMxqfA2rrlF5CcGESuHyuvqMvaO
         kBMix9E8ByLPJ5J6qR9TNqi8RoqXJjGAfJICHL32BQ4nX4v2KzxatrHiZAUPE3/r50P/
         R9yEwgYecmDKbPBfR/r4hT6pDbTU2EooHrfB04A61FCQxPk1gMQ74fG8hkTS6HXZRyg/
         ABhw==
X-Gm-Message-State: AOJu0YzUTbj6sd3pK1CBn8v5B6oUKwpuly+Air5MdnuB4ps7hODFvaiT
	NDRCzMeJ/hUqe9NBgzv0N26QTsot6RaWv6dU3GhasCMPyrUmMzqABRvRQ46PrUVDBIpH43SCCMO
	1
X-Google-Smtp-Source: AGHT+IEcel0/MRjzIWp/N/wJ0VcDTRpDNsY2OCnzcyjdM0dOAhpKdX8F/+naKtz1jCQ7v01Qmo8KNA==
X-Received: by 2002:a17:906:da04:b0:a2b:55a:9e13 with SMTP id fi4-20020a170906da0400b00a2b055a9e13mr1483087ejb.11.1705662530991;
        Fri, 19 Jan 2024 03:08:50 -0800 (PST)
Received: from blaptop.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id h20-20020a170906261400b00a28d438a1b0sm10091661ejc.83.2024.01.19.03.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 03:08:50 -0800 (PST)
From: Alexandre Bailon <abailon@baylibre.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: rui.zhang@intel.com,
	lukasz.luba@arm.com,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexandre Bailon <abailon@baylibre.com>
Subject: [PATCH v2 3/3] thermal: Add support of multi sensors to thermal_of
Date: Fri, 19 Jan 2024 12:08:42 +0100
Message-ID: <20240119110842.772606-4-abailon@baylibre.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240119110842.772606-1-abailon@baylibre.com>
References: <20240119110842.772606-1-abailon@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This updates thermal_of to support more than one sensor.
If during the registration we find another thermal zone referencing
this sensors and some other, then we create the multi sensor thermal
zone (if it doesn't exist) and register the sensor to it.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
---
 drivers/thermal/thermal_of.c | 139 +++++++++++++++++++++++++++++++++++
 1 file changed, 139 insertions(+)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 1e0655b63259..3f36d8a3d8e8 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -441,12 +441,146 @@ static void thermal_of_zone_unregister(struct thermal_zone_device *tz)
 	struct thermal_trip *trips = tz->trips;
 	struct thermal_zone_device_ops *ops = tz->ops;
 
+	thermal_multi_sensor_unregister(tz);
 	thermal_zone_device_disable(tz);
 	thermal_zone_device_unregister(tz);
 	kfree(trips);
 	kfree(ops);
 }
 
+int thermal_of_get_sensor_id(struct device_node *tz_np,
+			    struct device_node *sensor_np,
+			    int phandle_index, u32 *id)
+{
+	struct of_phandle_args sensor_specs;
+	int ret;
+
+	ret = of_parse_phandle_with_args(tz_np,
+					 "thermal-sensors",
+					 "#thermal-sensor-cells",
+					 phandle_index,
+					 &sensor_specs);
+	if (ret)
+		return ret;
+
+	if (sensor_specs.np != sensor_np) {
+		of_node_put(sensor_specs.np);
+		return -ENODEV;
+	}
+
+	if (sensor_specs.args_count > 1)
+		pr_warn("%pOFn: too many cells in sensor specifier %d\n",
+			sensor_specs.np, sensor_specs.args_count);
+
+	*id = sensor_specs.args_count ? sensor_specs.args[0] : 0;
+	of_node_put(sensor_specs.np);
+
+	return 0;
+}
+
+static int thermal_of_has_sensor_id(struct device_node *tz_np,
+				    struct device_node *sensor_np,
+				    u32 sensor_id)
+{
+	int count;
+	int i;
+
+	count = of_count_phandle_with_args(tz_np,
+					   "thermal-sensors",
+					   "#thermal-sensor-cells");
+	if (count <= 0)
+		return -ENODEV;
+
+	for (i = 0; i < count; i++) {
+		int ret;
+		u32 id;
+
+		ret = thermal_of_get_sensor_id(tz_np, sensor_np, i, &id);
+		if (ret)
+			return ret;
+
+		if (id == sensor_id)
+			return i;
+
+	}
+
+	return -ENODEV;
+}
+
+static int thermal_of_register_mutli_sensor(struct device_node *sensor, int id,
+					    struct thermal_zone_device *tz,
+					    struct device_node *tz_np)
+{
+	struct device_node *child;
+	u32 *coeff;
+	int ret;
+	int i;
+
+	/*
+	 * Go through all the thermal zone and check if the sensor is
+	 * referenced. If so, find or create a multi sensor thermal zone
+	 * and register the sensor to it.
+	 */
+	for_each_available_child_of_node(of_get_parent(tz_np), child) {
+		int count;
+		int index;
+		int offset;
+
+		/* Skip the tz that is currently registering */
+		if (child == tz_np)
+			continue;
+
+		/* Test if the sensor is referenced by a tz*/
+		index = thermal_of_has_sensor_id(child, sensor, id);
+		if (index < 0)
+			continue;
+
+		/*
+		 * Get the coefficients and offset and assign them to the
+		 * multi sensor thermal zone.
+		 */
+		count = of_count_phandle_with_args(child,
+						   "thermal-sensors",
+						   "#thermal-sensor-cells");
+		coeff = kmalloc_array(count, sizeof(*coeff), GFP_KERNEL);
+		if (!coeff)
+			goto err;
+
+		for (i = 0; i < count; i++) {
+			ret = of_property_read_u32_index(child,
+							 "coefficients",
+							 i, coeff + i);
+			if (ret)
+				coeff[i] = 1;
+		}
+
+		ret = of_property_read_u32_index(child, "coefficients",
+						 count, &offset);
+		if (ret)
+			offset = 0;
+
+		/* Make sure the coeff and offset won't cause an overflow */
+		ret = thermal_multi_sensor_validate_coeff(coeff, count, offset);
+		if (ret)
+			goto err_free_coeff;
+
+		ret = thermal_multi_sensor_register(child->name, tz,
+							 coeff[index]);
+		if (ret)
+			goto err_free_coeff;
+		kfree(coeff);
+	}
+
+	return 0;
+
+err_free_coeff:
+	kfree(coeff);
+err:
+	thermal_multi_sensor_unregister(tz);
+
+	return ret;
+}
+
 /**
  * thermal_of_zone_register - Register a thermal zone with device node
  * sensor
@@ -528,6 +662,11 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
 		return ERR_PTR(ret);
 	}
 
+	/* Register the sensor to all other thermal zone referencing it */
+	ret = thermal_of_register_mutli_sensor(sensor, id, tz, np);
+	if (ret)
+		pr_warn("Failed to register a sensor to a multi sensor tz\n");
+
 	return tz;
 
 out_kfree_trips:
-- 
2.41.0


