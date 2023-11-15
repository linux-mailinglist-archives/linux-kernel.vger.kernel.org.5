Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6C77EC8D8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 17:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbjKOQjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 11:39:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbjKOQjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 11:39:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9254CD41
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:39:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD95C43391;
        Wed, 15 Nov 2023 16:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700066373;
        bh=wOmG8PDmT8IoBbpblxv4EyHg4BsAIEU5myf7iJkEAf4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tG1JjIESXhgem7YL40BoLqvVLLBpiZiTFvfhAzCaJckzDN8YdcmAXG6rrUcp3Gq7R
         PQSD5AwfHkGMlqo5jC1R2WuFFz9YDIlSnEcGKJzD+fQCuArIHPvdCMk1vTIq9i32G4
         K9IWtLQHyoZWhRiOCdoTOjENqYn5gRd13xU6nLT1elzvJV4IpfMhaID9iKeH1fs4Tv
         KLBX2RZ6JMw9WWfS99INqHknnSUV3WJZkBtlZZzA1TQe6BifHRiu3//DeFjXsEkJ2L
         8fsEtbfBWS+dzAOovZOuHxFfifvcUPTLp8aL93uWxPTk55z2RLhU8V0yodEl9VpEHg
         RtCQVs+NP6x5w==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Dani Liberman <dliberman@habana.ai>
Subject: [PATCH 10/10] accel/habanalabs: expose module id through sysfs
Date:   Wed, 15 Nov 2023 18:39:12 +0200
Message-Id: <20231115163912.1243175-10-ogabbay@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231115163912.1243175-1-ogabbay@kernel.org>
References: <20231115163912.1243175-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dani Liberman <dliberman@habana.ai>

Module ID exposes the physical location of the device in the server,
from the pov of the devices in regard to how they are connected by
internal fabric.

This information is already exposed in our INFO ioctl, but there are
utilities and scripts running in data-center which are already
accessing sysfs for topology information and it is easier for them
to continue getting that information from sysfs instead of opening
a file descriptor.

Signed-off-by: Dani Liberman <dliberman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 Documentation/ABI/testing/sysfs-driver-habanalabs |  6 ++++++
 drivers/accel/habanalabs/common/sysfs.c           | 10 ++++++++++
 2 files changed, 16 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-driver-habanalabs b/Documentation/ABI/testing/sysfs-driver-habanalabs
index c63ca1ad500d..89fe3b09d4ad 100644
--- a/Documentation/ABI/testing/sysfs-driver-habanalabs
+++ b/Documentation/ABI/testing/sysfs-driver-habanalabs
@@ -149,6 +149,12 @@ Contact:        ogabbay@kernel.org
 Description:    Displays the current clock frequency, in Hz, of the MME compute
                 engine. This property is valid only for the Goya ASIC family
 
+What:           /sys/class/accel/accel<n>/device/module_id
+Date:           Nov 2023
+KernelVersion:  not yet upstreamed
+Contact:        ogabbay@kernel.org
+Description:    Displays the device's module id
+
 What:           /sys/class/accel/accel<n>/device/pci_addr
 Date:           Jan 2019
 KernelVersion:  5.1
diff --git a/drivers/accel/habanalabs/common/sysfs.c b/drivers/accel/habanalabs/common/sysfs.c
index 278606373055..8d2164691d81 100644
--- a/drivers/accel/habanalabs/common/sysfs.c
+++ b/drivers/accel/habanalabs/common/sysfs.c
@@ -386,6 +386,14 @@ static ssize_t security_enabled_show(struct device *dev,
 	return sprintf(buf, "%d\n", hdev->asic_prop.fw_security_enabled);
 }
 
+static ssize_t module_id_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct hl_device *hdev = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%u\n", le32_to_cpu(hdev->asic_prop.cpucp_info.card_location));
+}
+
 static DEVICE_ATTR_RO(armcp_kernel_ver);
 static DEVICE_ATTR_RO(armcp_ver);
 static DEVICE_ATTR_RO(cpld_ver);
@@ -405,6 +413,7 @@ static DEVICE_ATTR_RO(thermal_ver);
 static DEVICE_ATTR_RO(uboot_ver);
 static DEVICE_ATTR_RO(fw_os_ver);
 static DEVICE_ATTR_RO(security_enabled);
+static DEVICE_ATTR_RO(module_id);
 
 static struct bin_attribute bin_attr_eeprom = {
 	.attr = {.name = "eeprom", .mode = (0444)},
@@ -430,6 +439,7 @@ static struct attribute *hl_dev_attrs[] = {
 	&dev_attr_uboot_ver.attr,
 	&dev_attr_fw_os_ver.attr,
 	&dev_attr_security_enabled.attr,
+	&dev_attr_module_id.attr,
 	NULL,
 };
 
-- 
2.34.1

