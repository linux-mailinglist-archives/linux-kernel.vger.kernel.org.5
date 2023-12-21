Return-Path: <linux-kernel+bounces-8626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3EA81BA53
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09E551C23E66
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746D34AF75;
	Thu, 21 Dec 2023 15:12:11 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E22405CA
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 15:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 824FB2F4;
	Thu, 21 Dec 2023 07:12:53 -0800 (PST)
Received: from pluto.. (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DEEF93F64C;
	Thu, 21 Dec 2023 07:12:07 -0800 (PST)
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: sudeep.holla@arm.com,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH] firmware: arm_scmi: Add multiple protocols registration support
Date: Thu, 21 Dec 2023 15:11:29 +0000
Message-ID: <20231221151129.325749-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the capability for one SCMI driver to register with the core SCMI stack
to use multiple SCMI protocols: in such a case the SCMI driver probe
function will end up being called once for each registered protocol which
have been also found as implemented on the platform.

This is especially useful in testing scenarios.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/bus.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
index c15928b8c5cc..1f9735dbebec 100644
--- a/drivers/firmware/arm_scmi/bus.c
+++ b/drivers/firmware/arm_scmi/bus.c
@@ -141,6 +141,17 @@ static int scmi_protocol_device_request(const struct scmi_device_id *id_table)
 	return ret;
 }
 
+static int scmi_protocol_table_register(const struct scmi_device_id *id_table)
+{
+	int ret = 0;
+	const struct scmi_device_id *entry;
+
+	for (entry = id_table; entry->name && ret == 0; entry++)
+		ret = scmi_protocol_device_request(entry);
+
+	return ret;
+}
+
 /**
  * scmi_protocol_device_unrequest  - Helper to unrequest a device
  *
@@ -186,6 +197,15 @@ static void scmi_protocol_device_unrequest(const struct scmi_device_id *id_table
 	mutex_unlock(&scmi_requested_devices_mtx);
 }
 
+static void
+scmi_protocol_table_unregister(const struct scmi_device_id *id_table)
+{
+	const struct scmi_device_id *entry;
+
+	for (entry = id_table; entry->name; entry++)
+		scmi_protocol_device_unrequest(entry);
+}
+
 static const struct scmi_device_id *
 scmi_dev_match_id(struct scmi_device *scmi_dev, struct scmi_driver *scmi_drv)
 {
@@ -279,7 +299,7 @@ int scmi_driver_register(struct scmi_driver *driver, struct module *owner,
 	if (!driver->probe)
 		return -EINVAL;
 
-	retval = scmi_protocol_device_request(driver->id_table);
+	retval = scmi_protocol_table_register(driver->id_table);
 	if (retval)
 		return retval;
 
@@ -299,7 +319,7 @@ EXPORT_SYMBOL_GPL(scmi_driver_register);
 void scmi_driver_unregister(struct scmi_driver *driver)
 {
 	driver_unregister(&driver->driver);
-	scmi_protocol_device_unrequest(driver->id_table);
+	scmi_protocol_table_unregister(driver->id_table);
 }
 EXPORT_SYMBOL_GPL(scmi_driver_unregister);
 
-- 
2.43.0


