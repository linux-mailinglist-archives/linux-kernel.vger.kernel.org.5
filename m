Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5A78087AA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 13:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379321AbjLGMYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 07:24:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379288AbjLGMYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 07:24:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E234DD5C
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 04:24:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 753FFC433C9;
        Thu,  7 Dec 2023 12:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701951894;
        bh=/Qy3zG8E9tn/KPpMqCwh71W5AGo9u8gLdNF43wXGlpY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BHXT3Gp6YtSwXjgKhY9VyjB4fFNu4xOUcjKuBZtzYR9B1Bix0JeAo4pRptILBFT3o
         oMy28rqecKS6VJh7sRa+bPrnfoWNGxt6k94ma5nPHTXxVRmQjgixCEYGYXJG29Texl
         rZkIqlukgXqiKcyYgFig0ekPzIycT+XaXacBDr9qEIcoodG6764esxcSzGcc03qYMD
         DbAQ0T9+HXaqSnKfOA+NVeVVtM1ud3KvK5gqwGf+PhhGXk0G/8+lCEDD/+dPzkT3nk
         2XmNmggJJTwIKJEDVigIT7FMq+G8jAEYzs0MaIrm4gGytAEKTfZAP5VLbk6xqrchUh
         k97KEZKOFjDqg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 4/5] accel/habanalabs: add parent_device sysfs attribute
Date:   Thu,  7 Dec 2023 14:24:43 +0200
Message-Id: <20231207122444.50512-4-ogabbay@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231207122444.50512-1-ogabbay@kernel.org>
References: <20231207122444.50512-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

The device debugfs directory was modified to be named as the
device-name.
This name is the parent device name, i.e. either the PCI address in case
of an ASIC, or the simulator device name in case of a simulator.

This change makes it more difficult for a user to access the debugfs
directory for a specific accel device, because he can't just use the
accel minor id, but he needs to do more device-dependent operations to
get the device name.

To make it easier to get this name, add a 'parent_device' sysfs
attribute that the user can read using the minor id before accessing
debugfs.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 Documentation/ABI/testing/sysfs-driver-habanalabs | 6 ++++++
 drivers/accel/habanalabs/common/habanalabs.h      | 3 +++
 drivers/accel/habanalabs/common/sysfs.c           | 9 +++++++++
 3 files changed, 18 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-driver-habanalabs b/Documentation/ABI/testing/sysfs-driver-habanalabs
index 89fe3b09d4ad..4244f5af4b54 100644
--- a/Documentation/ABI/testing/sysfs-driver-habanalabs
+++ b/Documentation/ABI/testing/sysfs-driver-habanalabs
@@ -155,6 +155,12 @@ KernelVersion:  not yet upstreamed
 Contact:        ogabbay@kernel.org
 Description:    Displays the device's module id
 
+What:           /sys/class/accel/accel<n>/device/parent_device
+Date:           Nov 2023
+KernelVersion:  6.8
+Contact:        ttayar@habana.ai
+Description:    Displays the name of the parent device of the accel device
+
 What:           /sys/class/accel/accel<n>/device/pci_addr
 Date:           Jan 2019
 KernelVersion:  5.1
diff --git a/drivers/accel/habanalabs/common/habanalabs.h b/drivers/accel/habanalabs/common/habanalabs.h
index dd3fe3ddc00a..2a900c9941fe 100644
--- a/drivers/accel/habanalabs/common/habanalabs.h
+++ b/drivers/accel/habanalabs/common/habanalabs.h
@@ -3521,6 +3521,9 @@ struct hl_device {
 	u8				heartbeat;
 };
 
+/* Retrieve PCI device name in case of a PCI device or dev name in simulator */
+#define HL_DEV_NAME(hdev)	\
+		((hdev)->pdev ? dev_name(&(hdev)->pdev->dev) : "NA-DEVICE")
 
 /**
  * struct hl_cs_encaps_sig_handle - encapsulated signals handle structure
diff --git a/drivers/accel/habanalabs/common/sysfs.c b/drivers/accel/habanalabs/common/sysfs.c
index c940c5f1d109..8a9f98832157 100644
--- a/drivers/accel/habanalabs/common/sysfs.c
+++ b/drivers/accel/habanalabs/common/sysfs.c
@@ -410,6 +410,13 @@ static ssize_t module_id_show(struct device *dev,
 	return sprintf(buf, "%u\n", le32_to_cpu(hdev->asic_prop.cpucp_info.card_location));
 }
 
+static ssize_t parent_device_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct hl_device *hdev = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%s\n", HL_DEV_NAME(hdev));
+}
+
 static DEVICE_ATTR_RO(armcp_kernel_ver);
 static DEVICE_ATTR_RO(armcp_ver);
 static DEVICE_ATTR_RO(cpld_ver);
@@ -430,6 +437,7 @@ static DEVICE_ATTR_RO(uboot_ver);
 static DEVICE_ATTR_RO(fw_os_ver);
 static DEVICE_ATTR_RO(security_enabled);
 static DEVICE_ATTR_RO(module_id);
+static DEVICE_ATTR_RO(parent_device);
 
 static struct bin_attribute bin_attr_eeprom = {
 	.attr = {.name = "eeprom", .mode = (0444)},
@@ -456,6 +464,7 @@ static struct attribute *hl_dev_attrs[] = {
 	&dev_attr_fw_os_ver.attr,
 	&dev_attr_security_enabled.attr,
 	&dev_attr_module_id.attr,
+	&dev_attr_parent_device.attr,
 	NULL,
 };
 
-- 
2.34.1

