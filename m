Return-Path: <linux-kernel+bounces-77031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC43860046
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25BA7B266F9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42793157E97;
	Thu, 22 Feb 2024 18:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="U9Fm7GXD"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7446157E98
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 18:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708624872; cv=none; b=OwPdgo5CCChlkAuTlR8bs/jzwWANl9mlPiqaWlldpMxp6jaaJqdvt+iMpcsZlgnaga63dIjZ/i5BYAcbItKsZW/AeL+EmncZqbLM7xZvsFHWeXnKEdxGoDX0t4xV4FXwXf2J6qjIe9Ls9U1Zwu6s6gdvEGcfEHRdA/MVRSWQjtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708624872; c=relaxed/simple;
	bh=8vH1zgXiW6sFqWPP7Xe4NUQ+aG1DbdgrOh7Lo67Sva4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VCK4NYMhj4tB7T+UZTFDFUSJiZdUAaI/b5vjoFs0i9Co1Zx00MwKNNAu+t3LtEVvARnULwvW3ItYxeVhs54Dj+oUFnYNevn2lGjjirxksv2C27m4cz3NB78vJwOi15aFavqCSbetVCBIzba7CfPt7oUiIN5XGhwcfSLQvM8SGGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=U9Fm7GXD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41MGqhWC002357;
	Thu, 22 Feb 2024 18:01:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=SK5JcaC6C9sqBLvgnnhZB613+0SPAB8k6+ie79n5RP8=; b=U9
	Fm7GXDXLSEHQXItDlMQ8s3Nd1CvtEVyxQdovXXYWxGzU2zkCdfPK+joy1gOfIT9P
	0XWhKd6rq4vLCHV/GaXSbzPygiNBI474bgDaH1T2pmv9IF3PBLWHz0y+QSrhz/8U
	YD39lSm6V6xm6nlwd756M0cIsbZ5G+qZUZh6t3ZIuonwhNFUEObsPItFA6KGxCXB
	u/Va6H5QCGvDR8rw9Ea/Dc/RN8ohLFDo0ih1nuNnBo8MxFg5zVPmLtaaWxK7dpE1
	QxvhjpJ7FWqQbUqQ3XXkfmZHtahwcLVuLEVtqmmHH7yV91Hf9wv0k0B9dueoEikh
	VGKdDVvJ7Ysxuap91qqA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3we24ahtcm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 18:01:04 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41MI14Mq016160
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 18:01:04 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 22 Feb 2024 10:01:01 -0800
From: Mukesh Ojha <quic_mojha@quicinc.com>
To: <mcgrof@kernel.org>, <russ.weight@linux.dev>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>
CC: <linux-kernel@vger.kernel.org>, Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH vRFC 3/8] treewide: rename firmware_request_platform()
Date: Thu, 22 Feb 2024 23:30:28 +0530
Message-ID: <20240222180033.23775-4-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.43.0.254.ga26002b62827
In-Reply-To: <20240222180033.23775-1-quic_mojha@quicinc.com>
References: <20240222180033.23775-1-quic_mojha@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jQ2WPnQlOa2sprbdRA3R_OWL-liq_1oI
X-Proofpoint-ORIG-GUID: jQ2WPnQlOa2sprbdRA3R_OWL-liq_1oI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_13,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 adultscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402220140

Rename firmware_request_platform() to request_firmware_platform()
to be more concrete and align with the name of other request
firmware family functions.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 Documentation/driver-api/firmware/fallback-mechanisms.rst | 4 ++--
 Documentation/driver-api/firmware/lookup-order.rst        | 2 +-
 Documentation/driver-api/firmware/request_firmware.rst    | 4 ++--
 drivers/base/firmware_loader/main.c                       | 6 +++---
 drivers/input/touchscreen/chipone_icn8505.c               | 2 +-
 drivers/input/touchscreen/silead.c                        | 2 +-
 include/linux/firmware.h                                  | 4 ++--
 lib/test_firmware.c                                       | 2 +-
 8 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/Documentation/driver-api/firmware/fallback-mechanisms.rst b/Documentation/driver-api/firmware/fallback-mechanisms.rst
index 5f04c3bcdf0c..f888fceb65ba 100644
--- a/Documentation/driver-api/firmware/fallback-mechanisms.rst
+++ b/Documentation/driver-api/firmware/fallback-mechanisms.rst
@@ -212,7 +212,7 @@ of firmware for some of the system's integrated peripheral devices and
 the peripheral's Linux device-driver needs to access this firmware.
 
 Device drivers which need such firmware can use the
-firmware_request_platform() function for this, note that this is a
+request_firmware_platform() function for this, note that this is a
 separate fallback mechanism from the other fallback mechanisms and
 this does not use the sysfs interface.
 
@@ -245,7 +245,7 @@ To register this array with the efi-embedded-fw code, a driver needs to:
 
 4. Add "select EFI_EMBEDDED_FIRMWARE if EFI_STUB" to its Kconfig entry.
 
-The firmware_request_platform() function will always first try to load firmware
+The request_firmware_platform() function will always first try to load firmware
 with the specified name directly from the disk, so the EFI embedded-fw can
 always be overridden by placing a file under /lib/firmware.
 
diff --git a/Documentation/driver-api/firmware/lookup-order.rst b/Documentation/driver-api/firmware/lookup-order.rst
index 6064672a782e..c72bc8efb734 100644
--- a/Documentation/driver-api/firmware/lookup-order.rst
+++ b/Documentation/driver-api/firmware/lookup-order.rst
@@ -13,7 +13,7 @@ a driver issues a firmware API call.
 * The ''Direct filesystem lookup'' is performed next, if found we
   return it immediately
 * The ''Platform firmware fallback'' is performed next, but only when
-  firmware_request_platform() is used, if found we return it immediately
+  request_firmware_platform() is used, if found we return it immediately
 * If no firmware has been found and the fallback mechanism was enabled
   the sysfs interface is created. After this either a kobject uevent
   is issued or the custom firmware loading is relied upon for firmware
diff --git a/Documentation/driver-api/firmware/request_firmware.rst b/Documentation/driver-api/firmware/request_firmware.rst
index 0201334bc308..3d6df9922c4b 100644
--- a/Documentation/driver-api/firmware/request_firmware.rst
+++ b/Documentation/driver-api/firmware/request_firmware.rst
@@ -25,10 +25,10 @@ request_firmware_nowarn
 .. kernel-doc:: drivers/base/firmware_loader/main.c
    :functions: request_firmware_nowarn
 
-firmware_request_platform
+request_firmware_platform
 -------------------------
 .. kernel-doc:: drivers/base/firmware_loader/main.c
-   :functions: firmware_request_platform
+   :functions: request_firmware_platform
 
 request_firmware_direct
 -----------------------
diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index cb681f4069b8..9411ad7968cb 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -1016,7 +1016,7 @@ int request_firmware_direct(const struct firmware **firmware_p,
 EXPORT_SYMBOL_GPL(request_firmware_direct);
 
 /**
- * firmware_request_platform() - request firmware with platform-fw fallback
+ * request_firmware_platform() - request firmware with platform-fw fallback
  * @firmware: pointer to firmware image
  * @name: name of firmware file
  * @device: device for which firmware is being loaded
@@ -1025,13 +1025,13 @@ EXPORT_SYMBOL_GPL(request_firmware_direct);
  * direct filesystem lookup fails, it will fallback to looking for a copy of the
  * requested firmware embedded in the platform's main (e.g. UEFI) firmware.
  **/
-int firmware_request_platform(const struct firmware **firmware,
+int request_firmware_platform(const struct firmware **firmware,
 			      const char *name, struct device *device)
 {
 	return _request_firmware(firmware, name, device, NULL, 0, 0,
 				 FW_OPT_UEVENT | FW_OPT_FALLBACK_PLATFORM);
 }
-EXPORT_SYMBOL_GPL(firmware_request_platform);
+EXPORT_SYMBOL_GPL(request_firmware_platform);
 
 /**
  * firmware_request_cache() - cache firmware for suspend so resume can use it
diff --git a/drivers/input/touchscreen/chipone_icn8505.c b/drivers/input/touchscreen/chipone_icn8505.c
index b56954830b33..be1d7530a968 100644
--- a/drivers/input/touchscreen/chipone_icn8505.c
+++ b/drivers/input/touchscreen/chipone_icn8505.c
@@ -288,7 +288,7 @@ static int icn8505_upload_fw(struct icn8505_data *icn8505)
 	 * we may need it at resume. Having loaded it once will make the
 	 * firmware class code cache it at suspend/resume.
 	 */
-	error = firmware_request_platform(&fw, icn8505->firmware_name, dev);
+	error = request_firmware_platform(&fw, icn8505->firmware_name, dev);
 	if (error) {
 		dev_err(dev, "Firmware request error %d\n", error);
 		return error;
diff --git a/drivers/input/touchscreen/silead.c b/drivers/input/touchscreen/silead.c
index 52477e450b02..e3fb27eeca40 100644
--- a/drivers/input/touchscreen/silead.c
+++ b/drivers/input/touchscreen/silead.c
@@ -428,7 +428,7 @@ static int silead_ts_load_fw(struct i2c_client *client)
 	 */
 	error = request_firmware_nowarn(&fw, data->fw_name, dev);
 	if (error) {
-		error = firmware_request_platform(&fw, data->fw_name, dev);
+		error = request_firmware_platform(&fw, data->fw_name, dev);
 		if (error) {
 			dev_err(dev, "Firmware request error %d\n", error);
 			return error;
diff --git a/include/linux/firmware.h b/include/linux/firmware.h
index 5523c9fdc92d..93e6a37352a8 100644
--- a/include/linux/firmware.h
+++ b/include/linux/firmware.h
@@ -99,7 +99,7 @@ int request_firmware(const struct firmware **fw, const char *name,
 		     struct device *device);
 int request_firmware_nowarn(const struct firmware **fw, const char *name,
 			    struct device *device);
-int firmware_request_platform(const struct firmware **fw, const char *name,
+int request_firmware_platform(const struct firmware **fw, const char *name,
 			      struct device *device);
 int request_firmware_nowait(
 	struct module *module, bool uevent,
@@ -129,7 +129,7 @@ static inline int request_firmware_nowarn(const struct firmware **fw,
 	return -EINVAL;
 }
 
-static inline int firmware_request_platform(const struct firmware **fw,
+static inline int request_firmware_platform(const struct firmware **fw,
 					    const char *name,
 					    struct device *device)
 {
diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index 9cfdcd6d21db..4aeb25bea3b4 100644
--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -730,7 +730,7 @@ static ssize_t trigger_request_platform_store(struct device *dev,
 	efi_embedded_fw_checked = true;
 
 	pr_info("loading '%s'\n", name);
-	rc = firmware_request_platform(&firmware, name, dev);
+	rc = request_firmware_platform(&firmware, name, dev);
 	if (rc) {
 		pr_info("load of '%s' failed: %d\n", name, rc);
 		goto out;
-- 
2.43.0.254.ga26002b62827


