Return-Path: <linux-kernel+bounces-165304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C656F8B8AF2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 15:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFC48B2218A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 13:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA81212FB10;
	Wed,  1 May 2024 13:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Il7xkjo4"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD24112F389
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 13:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714568902; cv=none; b=Wij7XEetGrlmCUhezPqYQMSyyC8PJYQWv4N0oYl/n3mb5TCS6nJjvc7tXikC5PT91n6SX/33RGVkVThJBKd38xTxdE+7L6uVXATkJ86hgKnCdlMl7E79pYOqJydR+XCyeHvj7wDLQarMNj+4jG4RoeS/iXeC8AGJz3WUG34dC/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714568902; c=relaxed/simple;
	bh=yyqc5fgSD9exFQ4GhDz78AnhyoMaV08hu504NdFrDGM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lUFJUCRQ5kH4/Xt3xExc66c1q/OP3D9F+KbGLnrRODP/T4+Jjc7i8ou+ZhkXAvIzLIBQ06kVUUqo9/0vedpwzby+2bMfNy5l1zS7Gfpywg9VPVpTvk1+plAPuytJ6e7gpfr46D2WFe9zuNWug+kZQdPcTPM/HBpn5qdOL+JI9+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Il7xkjo4; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-69b782287f9so32382446d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 06:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714568900; x=1715173700; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fuTS2475wBKHSkCVqPTkc/u+zH5CwzTowAsuQdTWDz8=;
        b=Il7xkjo4lviR6CZvxPSKAMzpF7uSe2GayEgGO1P5jLWKmK3+nNKX4AA8rxJBtPyn6m
         D9TX+Qg/fcuuCYy+qqMK6US1iuatLlBmUkVk2J4SeQRUK8f8sXNbU/ycz8FeFj1uz2xi
         MKPneKs0T3anm107zE9nFjEyRkHPqjGLM9fJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714568900; x=1715173700;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fuTS2475wBKHSkCVqPTkc/u+zH5CwzTowAsuQdTWDz8=;
        b=PcfEdefinB3SjIT7a+pSI4KrZNM4MMmvoI+avhFTxt8Qb1xwb8M/T4LFbiYuTTxMSE
         KwdsB1dfi/S+uLGe3C9Iq0oAEDsdauJW6HClUfw9zKXljv9prBs7z5fTurLp2qJ53kuc
         Prslr4ztSggTmX8Zq71ln2v+jJw4pPh0SEx6VKiHwQgcloryQtvk2A1ZPlT9RW4Z2jV+
         b/ObADb34ZSNmU0Ai1rZYg3xJQQbi/Mfp1DeuZ99uG50Q1Agr9Ta82JZOfRAxzo4kLWT
         ov4xqjl4zqbFPdrGc91ulncWiBuh5BjAJW+QitcclOLDr2i7+u2XsDoJbDPNUBK4RI/j
         DfgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWRdigMJ3igyqLk3qv+JYqT+KqlBKqu204ZgJxL8qZWIqefTPDNVcSr3FohST/7uhIZYAyh++6ssetd6GYbjsRmBPHpw4QpFD8etHK
X-Gm-Message-State: AOJu0Yxwgr2AzJUg8V4MCxt8qHaMCeOE+j1S6I4y1030MpmvISckGsH0
	PfCQsth6algbmrP7Mm72g0zKXjB9naPzE5tAAGZ4qwUaqvDjl27ckb0CBrP9cw==
X-Google-Smtp-Source: AGHT+IGxtLuMsV5IT224KA2ifYps0IBof8gR94o8Jv8PY5+SVS3jtjRCG5zyAZxhnmApUmcG9XpHAg==
X-Received: by 2002:ad4:5cc7:0:b0:6a0:c933:4d7d with SMTP id iu7-20020ad45cc7000000b006a0c9334d7dmr2626974qvb.48.1714568899557;
        Wed, 01 May 2024 06:08:19 -0700 (PDT)
Received: from denia.c.googlers.com (114.152.245.35.bc.googleusercontent.com. [35.245.152.114])
        by smtp.gmail.com with ESMTPSA id l26-20020a0c979a000000b0069b10d78445sm12430971qvd.142.2024.05.01.06.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 06:08:18 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 01 May 2024 13:08:13 +0000
Subject: [PATCH v2 5/5] media: intel/ipu6: Fix build with !ACPI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240501-fix-ipu6-v2-5-a5629a37a0fb@chromium.org>
References: <20240501-fix-ipu6-v2-0-a5629a37a0fb@chromium.org>
In-Reply-To: <20240501-fix-ipu6-v2-0-a5629a37a0fb@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Bingbu Cao <bingbu.cao@intel.com>, Tianshu Qiu <tian.shu.qiu@intel.com>
Cc: linux-media@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Hans Verkuil <hverkuil@xs4all.nl>, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.4

Modify the code so it can be compiled tested in configurations that do
not have ACPI enabled.

Fixes:
drivers/media/pci/intel/ipu-bridge.c:103:30: error: implicit declaration of function ‘acpi_device_handle’; did you mean ‘acpi_fwnode_handle’? [-Werror=implicit-function-declaration]
drivers/media/pci/intel/ipu-bridge.c:103:30: warning: initialization of ‘acpi_handle’ {aka ‘void *’} from ‘int’ makes pointer from integer without a cast [-Wint-conversion]
drivers/media/pci/intel/ipu-bridge.c:110:17: error: implicit declaration of function ‘for_each_acpi_dev_match’ [-Werror=implicit-function-declaration]
drivers/media/pci/intel/ipu-bridge.c:110:74: error: expected ‘;’ before ‘for_each_acpi_consumer_dev’
drivers/media/pci/intel/ipu-bridge.c:104:29: warning: unused variable ‘consumer’ [-Wunused-variable]
drivers/media/pci/intel/ipu-bridge.c:103:21: warning: unused variable ‘handle’ [-Wunused-variable]
drivers/media/pci/intel/ipu-bridge.c:166:38: error: invalid use of undefined type ‘struct acpi_device’
drivers/media/pci/intel/ipu-bridge.c:185:43: error: invalid use of undefined type ‘struct acpi_device’
drivers/media/pci/intel/ipu-bridge.c:191:30: error: invalid use of undefined type ‘struct acpi_device’
drivers/media/pci/intel/ipu-bridge.c:196:30: error: invalid use of undefined type ‘struct acpi_device’
drivers/media/pci/intel/ipu-bridge.c:202:30: error: invalid use of undefined type ‘struct acpi_device’
drivers/media/pci/intel/ipu-bridge.c:223:31: error: invalid use of undefined type ‘struct acpi_device’
drivers/media/pci/intel/ipu-bridge.c:236:18: error: implicit declaration of function ‘acpi_get_physical_device_location’ [-Werror=implicit-function-declaration]
drivers/media/pci/intel/ipu-bridge.c:236:56: error: invalid use of undefined type ‘struct acpi_device’
drivers/media/pci/intel/ipu-bridge.c:238:31: error: invalid use of undefined type ‘struct acpi_device’
drivers/media/pci/intel/ipu-bridge.c:256:31: error: invalid use of undefined type ‘struct acpi_device’
drivers/media/pci/intel/ipu-bridge.c:275:31: error: invalid use of undefined type ‘struct acpi_device’
drivers/media/pci/intel/ipu-bridge.c:280:30: error: invalid use of undefined type ‘struct acpi_device’
drivers/media/pci/intel/ipu-bridge.c:469:26: error: implicit declaration of function ‘acpi_device_hid’; did you mean ‘dmi_device_id’? [-Werror=implicit-function-declaration]
drivers/media/pci/intel/ipu-bridge.c:468:74: warning: format ‘%s’ expects argument of type ‘char *’, but argument 4 has type ‘int’ [-Wformat=]
drivers/media/pci/intel/ipu-bridge.c:637:58: error: expected ‘;’ before ‘{’ token
drivers/media/pci/intel/ipu-bridge.c:696:1: warning: label ‘err_put_adev’ defined but not used [-Wunused-label]
drivers/media/pci/intel/ipu-bridge.c:693:1: warning: label ‘err_put_ivsc’ defined but not used [-Wunused-label]
drivers/media/pci/intel/ipu-bridge.c:691:1: warning: label ‘err_free_swnodes’ defined but not used [-Wunused-label]
drivers/media/pci/intel/ipu-bridge.c:632:40: warning: unused variable ‘primary’ [-Wunused-variable]
drivers/media/pci/intel/ipu-bridge.c:632:31: warning: unused variable ‘fwnode’ [-Wunused-variable]
drivers/media/pci/intel/ipu-bridge.c:733:73: error: expected ‘;’ before ‘{’ token
drivers/media/pci/intel/ipu-bridge.c:725:24: warning: unused variable ‘csi_dev’ [-Wunused-variable]
drivers/media/pci/intel/ipu-bridge.c:724:43: warning: unused variable ‘adev’ [-Wunused-variable]
drivers/media/pci/intel/ipu-bridge.c:599:12: warning: ‘ipu_bridge_instantiate_ivsc’ defined but not used [-Wunused-function]
drivers/media/pci/intel/ipu-bridge.c:444:13: warning: ‘ipu_bridge_create_connection_swnodes’ defined but not used [-Wunused-function]
drivers/media/pci/intel/ipu-bridge.c:297:13: warning: ‘ipu_bridge_create_fwnode_properties’ defined but not used [-Wunused-function]
drivers/media/pci/intel/ipu-bridge.c:155:12: warning: ‘ipu_bridge_check_ivsc_dev’ defined but not used [-Wunused-function]

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/pci/intel/ipu-bridge.c | 66 +++++++++++++++++++++++++-----------
 1 file changed, 47 insertions(+), 19 deletions(-)

diff --git a/drivers/media/pci/intel/ipu-bridge.c b/drivers/media/pci/intel/ipu-bridge.c
index e994db4f4d91..61750cc98d70 100644
--- a/drivers/media/pci/intel/ipu-bridge.c
+++ b/drivers/media/pci/intel/ipu-bridge.c
@@ -15,6 +15,8 @@
 #include <media/ipu-bridge.h>
 #include <media/v4l2-fwnode.h>
 
+#define ADEV_DEV(adev) ACPI_PTR(&((adev)->dev))
+
 /*
  * 92335fcf-3203-4472-af93-7b4453ac29da
  *
@@ -87,6 +89,7 @@ static const char * const ipu_vcm_types[] = {
 	"lc898212axb",
 };
 
+#if IS_ENABLED(CONFIG_ACPI)
 /*
  * Used to figure out IVSC acpi device by ipu_bridge_get_ivsc_acpi_dev()
  * instead of device and driver match to probe IVSC device.
@@ -100,13 +103,13 @@ static const struct acpi_device_id ivsc_acpi_ids[] = {
 
 static struct acpi_device *ipu_bridge_get_ivsc_acpi_dev(struct acpi_device *adev)
 {
-	acpi_handle handle = acpi_device_handle(adev);
-	struct acpi_device *consumer, *ivsc_adev;
 	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(ivsc_acpi_ids); i++) {
 		const struct acpi_device_id *acpi_id = &ivsc_acpi_ids[i];
+		struct acpi_device *consumer, *ivsc_adev;
 
+		acpi_handle handle = acpi_device_handle(adev);
 		for_each_acpi_dev_match(ivsc_adev, acpi_id->id, NULL, -1)
 			/* camera sensor depends on IVSC in DSDT if exist */
 			for_each_acpi_consumer_dev(ivsc_adev, consumer)
@@ -118,6 +121,12 @@ static struct acpi_device *ipu_bridge_get_ivsc_acpi_dev(struct acpi_device *adev
 
 	return NULL;
 }
+#else
+static struct acpi_device *ipu_bridge_get_ivsc_acpi_dev(struct acpi_device *adev)
+{
+	return NULL;
+}
+#endif
 
 static int ipu_bridge_match_ivsc_dev(struct device *dev, const void *adev)
 {
@@ -163,7 +172,7 @@ static int ipu_bridge_check_ivsc_dev(struct ipu_sensor *sensor,
 		csi_dev = ipu_bridge_get_ivsc_csi_dev(adev);
 		if (!csi_dev) {
 			acpi_dev_put(adev);
-			dev_err(&adev->dev, "Failed to find MEI CSI dev\n");
+			dev_err(ADEV_DEV(adev), "Failed to find MEI CSI dev\n");
 			return -ENODEV;
 		}
 
@@ -182,24 +191,25 @@ static int ipu_bridge_read_acpi_buffer(struct acpi_device *adev, char *id,
 	acpi_status status;
 	int ret = 0;
 
-	status = acpi_evaluate_object(adev->handle, id, NULL, &buffer);
+	status = acpi_evaluate_object(ACPI_PTR(adev->handle),
+				      id, NULL, &buffer);
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
 	obj = buffer.pointer;
 	if (!obj) {
-		dev_err(&adev->dev, "Couldn't locate ACPI buffer\n");
+		dev_err(ADEV_DEV(adev), "Couldn't locate ACPI buffer\n");
 		return -ENODEV;
 	}
 
 	if (obj->type != ACPI_TYPE_BUFFER) {
-		dev_err(&adev->dev, "Not an ACPI buffer\n");
+		dev_err(ADEV_DEV(adev), "Not an ACPI buffer\n");
 		ret = -ENODEV;
 		goto out_free_buff;
 	}
 
 	if (obj->buffer.length > size) {
-		dev_err(&adev->dev, "Given buffer is too small\n");
+		dev_err(ADEV_DEV(adev), "Given buffer is too small\n");
 		ret = -EINVAL;
 		goto out_free_buff;
 	}
@@ -220,7 +230,7 @@ static u32 ipu_bridge_parse_rotation(struct acpi_device *adev,
 	case IPU_SENSOR_ROTATION_INVERTED:
 		return 180;
 	default:
-		dev_warn(&adev->dev,
+		dev_warn(ADEV_DEV(adev),
 			 "Unknown rotation %d. Assume 0 degree rotation\n",
 			 ssdb->degree);
 		return 0;
@@ -230,12 +240,14 @@ static u32 ipu_bridge_parse_rotation(struct acpi_device *adev,
 static enum v4l2_fwnode_orientation ipu_bridge_parse_orientation(struct acpi_device *adev)
 {
 	enum v4l2_fwnode_orientation orientation;
-	struct acpi_pld_info *pld;
-	acpi_status status;
+	struct acpi_pld_info *pld = NULL;
+	acpi_status status = AE_ERROR;
 
+#if IS_ENABLED(CONFIG_ACPI)
 	status = acpi_get_physical_device_location(adev->handle, &pld);
+#endif
 	if (ACPI_FAILURE(status)) {
-		dev_warn(&adev->dev, "_PLD call failed, using default orientation\n");
+		dev_warn(ADEV_DEV(adev), "_PLD call failed, using default orientation\n");
 		return V4L2_FWNODE_ORIENTATION_EXTERNAL;
 	}
 
@@ -253,7 +265,8 @@ static enum v4l2_fwnode_orientation ipu_bridge_parse_orientation(struct acpi_dev
 		orientation = V4L2_FWNODE_ORIENTATION_EXTERNAL;
 		break;
 	default:
-		dev_warn(&adev->dev, "Unknown _PLD panel val %d\n", pld->panel);
+		dev_warn(ADEV_DEV(adev), "Unknown _PLD panel val %d\n",
+			 pld->panel);
 		orientation = V4L2_FWNODE_ORIENTATION_EXTERNAL;
 		break;
 	}
@@ -272,12 +285,12 @@ int ipu_bridge_parse_ssdb(struct acpi_device *adev, struct ipu_sensor *sensor)
 		return ret;
 
 	if (ssdb.vcmtype > ARRAY_SIZE(ipu_vcm_types)) {
-		dev_warn(&adev->dev, "Unknown VCM type %d\n", ssdb.vcmtype);
+		dev_warn(ADEV_DEV(adev), "Unknown VCM type %d\n", ssdb.vcmtype);
 		ssdb.vcmtype = 0;
 	}
 
 	if (ssdb.lanes > IPU_MAX_LANES) {
-		dev_err(&adev->dev, "Number of lanes in SSDB is invalid\n");
+		dev_err(ADEV_DEV(adev), "Number of lanes in SSDB is invalid\n");
 		return -EINVAL;
 	}
 
@@ -465,8 +478,14 @@ static void ipu_bridge_create_connection_swnodes(struct ipu_bridge *bridge,
 						sensor->ipu_properties);
 
 	if (sensor->csi_dev) {
+		const char *device_hid = "";
+
+#if IS_ENABLED(CONFIG_ACPI)
+		device_hid = acpi_device_hid(sensor->ivsc_adev);
+#endif
+
 		snprintf(sensor->ivsc_name, sizeof(sensor->ivsc_name), "%s-%u",
-			 acpi_device_hid(sensor->ivsc_adev), sensor->link);
+			 device_hid, sensor->link);
 
 		nodes[SWNODE_IVSC_HID] = NODE_SENSOR(sensor->ivsc_name,
 						     sensor->ivsc_properties);
@@ -631,11 +650,15 @@ static int ipu_bridge_connect_sensor(const struct ipu_sensor_config *cfg,
 {
 	struct fwnode_handle *fwnode, *primary;
 	struct ipu_sensor *sensor;
-	struct acpi_device *adev;
+	struct acpi_device *adev = NULL;
 	int ret;
 
+#if IS_ENABLED(CONFIG_ACPI)
 	for_each_acpi_dev_match(adev, cfg->hid, NULL, -1) {
-		if (!adev->status.enabled)
+#else
+	while (true) {
+#endif
+		if (!ACPI_PTR(adev->status.enabled))
 			continue;
 
 		if (bridge->n_sensors >= IPU_MAX_PORTS) {
@@ -671,7 +694,7 @@ static int ipu_bridge_connect_sensor(const struct ipu_sensor_config *cfg,
 			goto err_free_swnodes;
 		}
 
-		sensor->adev = acpi_dev_get(adev);
+		sensor->adev = ACPI_PTR(acpi_dev_get(adev));
 
 		primary = acpi_fwnode_handle(adev);
 		primary->secondary = fwnode;
@@ -727,11 +750,16 @@ static int ipu_bridge_ivsc_is_ready(void)
 	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(ipu_supported_sensors); i++) {
+#if IS_ENABLED(CONFIG_ACPI)
 		const struct ipu_sensor_config *cfg =
 			&ipu_supported_sensors[i];
 
 		for_each_acpi_dev_match(sensor_adev, cfg->hid, NULL, -1) {
-			if (!sensor_adev->status.enabled)
+#else
+		while (true) {
+			sensor_adev = NULL;
+#endif
+			if (!ACPI_PTR(sensor_adev->status.enabled))
 				continue;
 
 			adev = ipu_bridge_get_ivsc_acpi_dev(sensor_adev);

-- 
2.45.0.rc0.197.gbae5840b3b-goog


