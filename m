Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C52E477D550
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 23:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240279AbjHOVkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 17:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237374AbjHOVj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 17:39:58 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031B4269F;
        Tue, 15 Aug 2023 14:39:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QeYQvVK51c7Of3SSeBJkQBM2NFDISTM7twY0U/cMf1EQ85SwuEXZvDKTR4d8oXF2W6oEBHXz/8EZRDaHwZ4hnpv9symqeYFPQgPotdNQwHLZTPWTRml/zwWV7e/6be6+Bb8hmPzf6ato5eqwzn2D1mwudJKeAn1GlxvcsAKSG3py/jAuX/t2PXpnSaVOo9Axqr91Rs63cvzWHnWJymTN3Se8M1RjIYBIi2iaPugemxJ+QvGKZ75xImlmfT84WPX2L3u6Qps5PZ2uuJUJbUHGbvPn/tA2d8V5uFdOjwzYaPoIgW82sd+AtRdODQQ8w314nXVHbao+3P39JOu13WnJlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wDZp5XrtrolYJahgr763QMLbR/oJqhHkJ4r/UIoa5i8=;
 b=K3bn66aHQjhn9vlqWUpCHq17MlaINRZ82gJjX6RnDSdVv/4SrriH4hJZLlVDQmJuWdRl9y4ymD2j1/wkOli8CUiDw/dA/TDOUZxNAnp9wBODMycBaohPs210uckoxnkKDc6PwpJkgDshKKu03eC1m6C3GaJwFyGh6p5ThDz5ymMFJ8jIamjTifdz5eaRVufsKx918BfuScUZBDaazsls3VD3KY82k4XjVqEOnuD0h981bIbzfFixXXlQ8BOM3NDCSWYbqCvyrHV3UdDmPpqopgO90exiw3V465ez23vONcdDBZaS8j4jH+ZOBVi8OX5G+J3tW3ZNK5oRQqsQ9XyQ5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDZp5XrtrolYJahgr763QMLbR/oJqhHkJ4r/UIoa5i8=;
 b=Kcc7oMx5RjdLuABXoYvlWxIPt9PBW2RBUYHm9Ke5Ztw9lTZfuk/+UwmobzRuq5HLktG19YgR+AwzZc6LewwrZefx8F71LeoyKY88QzgCp04t/nUVnVLYZ3QoIMsPydIin6JsiT2mXcFyNe+Fmaa0OnQ98/EgSyyXb3MNCzdVJd2aDTAhzLRKTrmI9GBfIENXj7QjkVLU5dYusuAlRuwoWzNH9N9iCjYyEFUdtblhPAGX63bu4HGEIi1k2DxdBn5wuz+uypBIeuwLX3hE4TANgVx7mBjpVGaH0pdxfFQ+1FqPwFnwwIw17lDBXgE0NjQqQjN9l8e6jvqY1BtHsddPLQ==
Received: from MW4PR04CA0182.namprd04.prod.outlook.com (2603:10b6:303:86::7)
 by DM4PR12MB5723.namprd12.prod.outlook.com (2603:10b6:8:5e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.26; Tue, 15 Aug 2023 21:38:54 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:303:86:cafe::95) by MW4PR04CA0182.outlook.office365.com
 (2603:10b6:303:86::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Tue, 15 Aug 2023 21:38:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6723.5 via Frontend Transport; Tue, 15 Aug 2023 21:38:54 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 15 Aug 2023
 14:38:36 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 15 Aug
 2023 14:38:35 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Tue, 15 Aug
 2023 14:38:34 -0700
From:   David Thompson <davthompson@nvidia.com>
To:     <hdegoede@redhat.com>, <markgross@kernel.org>, <vadimp@nvidia.com>
CC:     <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <shravankr@nvidia.com>,
        David Thompson <davthompson@nvidia.com>
Subject: [PATCH v1] mlxbf-bootctl: Support sysfs entries for MFG fields
Date:   Tue, 15 Aug 2023 17:38:32 -0400
Message-ID: <20230815213832.16698-1-davthompson@nvidia.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|DM4PR12MB5723:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cb96eba-dee4-4e0c-cbe3-08db9dd80624
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rKFMjALESeke7fCu15mfZ4By40CBoALOkVxYf2qw+l5xGagpuAJLpHqy4NyNAnTI0ygj9WoQCcHfn05hA5mlM69YKeOZ+qXFW9PlynKAhY+tI55eSEmPRjvxVPOk85Ls3M6ISjaNNdUEoMoaTH5yxWIewdM+URv9J9vLajHnWv01KCtDucoszwVh8rCijse057SaATxFszAwQIw//Bf0oEGpuxfjdAFd2p1YH1Xty2wlGgxwJtDQYGHEmpjguArJXsxZshg09X7ZrL8hKHcH3sqlJWuwU5n7G0MSLjWwALbfhq0EF9RL4pUZZcQdWhSGRi/waN+HD6g8pC7YMlfs52opH6yESgpEoEkRuzx+UJwvvIg1Q4Ze62R7Vn106qzynHc+GYkin6ubtmIqrizvl4cVAPMbE5PlacnQH0V1QSDJlcCYDj213S/enSoRWv4t1RWvxrKguSLT2k0n2staqosfAszSpanCGDC/QnvdAnxmwLBGkugJsN0s2BW2J1Z2IHlCFCAcLr8HFbWO2fWf5ka2YyC+1pJhzkqP7GgnXPtTrrfW+ag25R1fW+VCOxvkOIzCi9Jd/5JyZFu984BsMReE9EAEY5jBDGLmEyerZJPxAxbm2q//LfOt0GK5km6gpQ8xuw7gVD5iOqQJMoMndPczTe0DKuefVAkBMwCMfrIkcptl/RM4uEdNhuMBJaZ3cG2yB0qJPjw3NTul4gwF85obj83ruCCc9SNg60EeCTJLWBqXwnO97stg4ZeO+IaI
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(39860400002)(346002)(136003)(1800799009)(82310400011)(186009)(451199024)(46966006)(40470700004)(36840700001)(7636003)(110136005)(70206006)(316002)(70586007)(2616005)(40460700003)(336012)(7696005)(36756003)(1076003)(30864003)(26005)(41300700001)(6636002)(426003)(83380400001)(54906003)(5660300002)(107886003)(47076005)(4326008)(8936002)(82740400003)(86362001)(8676002)(40480700001)(2906002)(478600001)(36860700001)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 21:38:54.3222
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cb96eba-dee4-4e0c-cbe3-08db9dd80624
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5723
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch extends the mlxbf-bootctl driver's sysfs entries
to support read and write access for the manufacturing (MFG)
fields in the board-level EEPROM.  The MFG fields are set
once during the board manufacturing phase, and then the MFG
fields are write-protected.

Signed-off-by: David Thompson <davthompson@nvidia.com>
Reviewed-by: Shravan Kumar Ramani <shravankr@nvidia.com>
---
 drivers/platform/mellanox/mlxbf-bootctl.c | 456 ++++++++++++++++++++++
 drivers/platform/mellanox/mlxbf-bootctl.h |   8 +
 2 files changed, 464 insertions(+)

diff --git a/drivers/platform/mellanox/mlxbf-bootctl.c b/drivers/platform/mellanox/mlxbf-bootctl.c
index 0bf29eee1e70..bf6ce37e3dbb 100644
--- a/drivers/platform/mellanox/mlxbf-bootctl.c
+++ b/drivers/platform/mellanox/mlxbf-bootctl.c
@@ -11,6 +11,7 @@
 #include <linux/acpi.h>
 #include <linux/arm-smccc.h>
 #include <linux/delay.h>
+#include <linux/if_ether.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
@@ -81,6 +82,50 @@ static const char * const mlxbf_rsh_log_level[] = {
 
 static DEFINE_MUTEX(icm_ops_lock);
 static DEFINE_MUTEX(os_up_lock);
+static DEFINE_MUTEX(mfg_ops_lock);
+
+/*
+ * Objects are stored within the MFG partition per type.
+ * Type 0 is not supported.
+ */
+enum {
+	MLNX_MFG_TYPE_OOB_MAC = 1,
+	MLNX_MFG_TYPE_OPN_0,
+	MLNX_MFG_TYPE_OPN_1,
+	MLNX_MFG_TYPE_OPN_2,
+	MLNX_MFG_TYPE_SKU_0,
+	MLNX_MFG_TYPE_SKU_1,
+	MLNX_MFG_TYPE_SKU_2,
+	MLNX_MFG_TYPE_MODL_0,
+	MLNX_MFG_TYPE_MODL_1,
+	MLNX_MFG_TYPE_MODL_2,
+	MLNX_MFG_TYPE_SN_0,
+	MLNX_MFG_TYPE_SN_1,
+	MLNX_MFG_TYPE_SN_2,
+	MLNX_MFG_TYPE_UUID_0,
+	MLNX_MFG_TYPE_UUID_1,
+	MLNX_MFG_TYPE_UUID_2,
+	MLNX_MFG_TYPE_UUID_3,
+	MLNX_MFG_TYPE_UUID_4,
+	MLNX_MFG_TYPE_REV,
+};
+
+#define MLNX_MFG_OOB_MAC_LEN         ETH_ALEN
+#define MLNX_MFG_OPN_VAL_LEN         24
+#define MLNX_MFG_SKU_VAL_LEN         24
+#define MLNX_MFG_MODL_VAL_LEN        24
+#define MLNX_MFG_SN_VAL_LEN          24
+#define MLNX_MFG_UUID_VAL_LEN        40
+#define MLNX_MFG_REV_VAL_LEN         8
+#define MLNX_MFG_VAL_QWORD_CNT(type) \
+	(MLNX_MFG_##type##_VAL_LEN / sizeof(u64))
+
+/*
+ * The MAC address consists of 6 bytes (2 digits each) separated by ':'.
+ * The expected format is: "XX:XX:XX:XX:XX:XX"
+ */
+#define MLNX_MFG_OOB_MAC_FORMAT_LEN \
+	((MLNX_MFG_OOB_MAC_LEN * 2) + (MLNX_MFG_OOB_MAC_LEN - 1))
 
 /* ARM SMC call which is atomic and no need for lock. */
 static int mlxbf_bootctl_smc(unsigned int smc_op, int smc_arg)
@@ -454,6 +499,401 @@ static ssize_t os_up_store(struct device *dev,
 	return count;
 }
 
+static ssize_t oob_mac_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	char mac_str[MLNX_MFG_OOB_MAC_FORMAT_LEN + 1] = { 0 };
+	struct arm_smccc_res res;
+	u8 *mac_byte_ptr;
+
+	mutex_lock(&mfg_ops_lock);
+	arm_smccc_smc(MLXBF_BOOTCTL_GET_MFG_INFO, MLNX_MFG_TYPE_OOB_MAC, 0, 0, 0,
+		      0, 0, 0, &res);
+	mutex_unlock(&mfg_ops_lock);
+	if (res.a0)
+		return -EPERM;
+
+	mac_byte_ptr = (u8 *)&res.a1;
+
+	sprintf(mac_str, "%02X:%02X:%02X:%02X:%02X:%02X",
+		mac_byte_ptr[0], mac_byte_ptr[1], mac_byte_ptr[2],
+		mac_byte_ptr[3], mac_byte_ptr[4], mac_byte_ptr[5]);
+
+	return snprintf(buf, PAGE_SIZE, "%s", mac_str);
+}
+
+static ssize_t oob_mac_store(struct device *dev,
+			     struct device_attribute *attr,
+			     const char *buf, size_t count)
+{
+	int byte[MLNX_MFG_OOB_MAC_FORMAT_LEN] = { 0 };
+	struct arm_smccc_res res;
+	int byte_idx, len;
+	u64 mac_addr = 0;
+	u8 *mac_byte_ptr;
+
+	if ((count - 1) != MLNX_MFG_OOB_MAC_FORMAT_LEN)
+		return -EINVAL;
+
+	len = sscanf(buf, "%02x:%02x:%02x:%02x:%02x:%02x",
+		     &byte[0], &byte[1], &byte[2],
+		     &byte[3], &byte[4], &byte[5]);
+	if (len != MLNX_MFG_OOB_MAC_LEN)
+		return -EINVAL;
+
+	mac_byte_ptr = (u8 *)&mac_addr;
+
+	for (byte_idx = 0; byte_idx < MLNX_MFG_OOB_MAC_LEN; byte_idx++)
+		mac_byte_ptr[byte_idx] = (u8)byte[byte_idx];
+
+	mutex_lock(&mfg_ops_lock);
+	arm_smccc_smc(MLXBF_BOOTCTL_SET_MFG_INFO, MLNX_MFG_TYPE_OOB_MAC,
+		      MLNX_MFG_OOB_MAC_LEN, mac_addr, 0, 0, 0, 0, &res);
+	mutex_unlock(&mfg_ops_lock);
+
+	return res.a0 ? -EPERM : count;
+}
+
+static ssize_t opn_show(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	u64 opn_data[MLNX_MFG_VAL_QWORD_CNT(OPN)] = { 0 };
+	char opn[MLNX_MFG_OPN_VAL_LEN + 1] = { 0 };
+	struct arm_smccc_res res;
+	int word;
+
+	mutex_lock(&mfg_ops_lock);
+	for (word = 0; word < MLNX_MFG_VAL_QWORD_CNT(OPN); word++) {
+		arm_smccc_smc(MLXBF_BOOTCTL_GET_MFG_INFO,
+			      MLNX_MFG_TYPE_OPN_0 + word,
+			      0, 0, 0, 0, 0, 0, &res);
+		if (res.a0) {
+			mutex_unlock(&mfg_ops_lock);
+			return -EPERM;
+		}
+		opn_data[word] = res.a1;
+	}
+	mutex_unlock(&mfg_ops_lock);
+	memcpy(opn, opn_data, MLNX_MFG_OPN_VAL_LEN);
+
+	return snprintf(buf, PAGE_SIZE, "%s", opn);
+}
+
+static ssize_t opn_store(struct device *dev,
+			 struct device_attribute *attr,
+			 const char *buf, size_t count)
+{
+	u64 opn[MLNX_MFG_VAL_QWORD_CNT(OPN)] = { 0 };
+	struct arm_smccc_res res;
+	int word;
+
+	if (count > MLNX_MFG_OPN_VAL_LEN)
+		return -EINVAL;
+
+	memcpy(opn, buf, count);
+
+	mutex_lock(&mfg_ops_lock);
+	for (word = 0; word < MLNX_MFG_VAL_QWORD_CNT(OPN); word++) {
+		arm_smccc_smc(MLXBF_BOOTCTL_SET_MFG_INFO,
+			      MLNX_MFG_TYPE_OPN_0 + word,
+			      sizeof(u64), opn[word], 0, 0, 0, 0, &res);
+		if (res.a0) {
+			mutex_unlock(&mfg_ops_lock);
+			return -EPERM;
+		}
+	}
+	mutex_unlock(&mfg_ops_lock);
+
+	return count;
+}
+
+static ssize_t sku_show(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	u64 sku_data[MLNX_MFG_VAL_QWORD_CNT(SKU)] = { 0 };
+	char sku[MLNX_MFG_SKU_VAL_LEN + 1] = { 0 };
+	struct arm_smccc_res res;
+	int word;
+
+	mutex_lock(&mfg_ops_lock);
+	for (word = 0; word < MLNX_MFG_VAL_QWORD_CNT(SKU); word++) {
+		arm_smccc_smc(MLXBF_BOOTCTL_GET_MFG_INFO,
+			      MLNX_MFG_TYPE_SKU_0 + word,
+			      0, 0, 0, 0, 0, 0, &res);
+		if (res.a0) {
+			mutex_unlock(&mfg_ops_lock);
+			return -EPERM;
+		}
+		sku_data[word] = res.a1;
+	}
+	mutex_unlock(&mfg_ops_lock);
+	memcpy(sku, sku_data, MLNX_MFG_SKU_VAL_LEN);
+
+	return snprintf(buf, PAGE_SIZE, "%s", sku);
+}
+
+static ssize_t sku_store(struct device *dev,
+			 struct device_attribute *attr,
+			 const char *buf, size_t count)
+{
+	u64 sku[MLNX_MFG_VAL_QWORD_CNT(SKU)] = { 0 };
+	struct arm_smccc_res res;
+	int word;
+
+	if (count > MLNX_MFG_SKU_VAL_LEN)
+		return -EINVAL;
+
+	memcpy(sku, buf, count);
+
+	mutex_lock(&mfg_ops_lock);
+	for (word = 0; word < MLNX_MFG_VAL_QWORD_CNT(SKU); word++) {
+		arm_smccc_smc(MLXBF_BOOTCTL_SET_MFG_INFO,
+			      MLNX_MFG_TYPE_SKU_0 + word,
+			      sizeof(u64), sku[word], 0, 0, 0, 0, &res);
+		if (res.a0) {
+			mutex_unlock(&mfg_ops_lock);
+			return -EPERM;
+		}
+	}
+	mutex_unlock(&mfg_ops_lock);
+
+	return count;
+}
+
+static ssize_t modl_show(struct device *dev,
+			 struct device_attribute *attr, char *buf)
+{
+	u64 modl_data[MLNX_MFG_VAL_QWORD_CNT(MODL)] = { 0 };
+	char modl[MLNX_MFG_MODL_VAL_LEN + 1] = { 0 };
+	struct arm_smccc_res res;
+	int word;
+
+	mutex_lock(&mfg_ops_lock);
+	for (word = 0; word < MLNX_MFG_VAL_QWORD_CNT(MODL); word++) {
+		arm_smccc_smc(MLXBF_BOOTCTL_GET_MFG_INFO,
+			      MLNX_MFG_TYPE_MODL_0 + word,
+			      0, 0, 0, 0, 0, 0, &res);
+		if (res.a0) {
+			mutex_unlock(&mfg_ops_lock);
+			return -EPERM;
+		}
+		modl_data[word] = res.a1;
+	}
+	mutex_unlock(&mfg_ops_lock);
+	memcpy(modl, modl_data, MLNX_MFG_MODL_VAL_LEN);
+
+	return snprintf(buf, PAGE_SIZE, "%s", modl);
+}
+
+static ssize_t modl_store(struct device *dev,
+			  struct device_attribute *attr,
+			  const char *buf, size_t count)
+{
+	u64 modl[MLNX_MFG_VAL_QWORD_CNT(MODL)] = { 0 };
+	struct arm_smccc_res res;
+	int word;
+
+	if (count > MLNX_MFG_MODL_VAL_LEN)
+		return -EINVAL;
+
+	memcpy(modl, buf, count);
+
+	mutex_lock(&mfg_ops_lock);
+	for (word = 0; word < MLNX_MFG_VAL_QWORD_CNT(MODL); word++) {
+		arm_smccc_smc(MLXBF_BOOTCTL_SET_MFG_INFO,
+			      MLNX_MFG_TYPE_MODL_0 + word,
+			      sizeof(u64), modl[word], 0, 0, 0, 0, &res);
+		if (res.a0) {
+			mutex_unlock(&mfg_ops_lock);
+			return -EPERM;
+		}
+	}
+	mutex_unlock(&mfg_ops_lock);
+
+	return count;
+}
+
+static ssize_t sn_show(struct device *dev,
+		       struct device_attribute *attr, char *buf)
+{
+	u64 sn_data[MLNX_MFG_VAL_QWORD_CNT(SN)] = { 0 };
+	char sn[MLNX_MFG_SN_VAL_LEN + 1] = { 0 };
+	struct arm_smccc_res res;
+	int word;
+
+	mutex_lock(&mfg_ops_lock);
+	for (word = 0; word < MLNX_MFG_VAL_QWORD_CNT(SN); word++) {
+		arm_smccc_smc(MLXBF_BOOTCTL_GET_MFG_INFO,
+			      MLNX_MFG_TYPE_SN_0 + word,
+			      0, 0, 0, 0, 0, 0, &res);
+		if (res.a0) {
+			mutex_unlock(&mfg_ops_lock);
+			return -EPERM;
+		}
+		sn_data[word] = res.a1;
+	}
+	mutex_unlock(&mfg_ops_lock);
+	memcpy(sn, sn_data, MLNX_MFG_SN_VAL_LEN);
+
+	return snprintf(buf, PAGE_SIZE, "%s", sn);
+}
+
+static ssize_t sn_store(struct device *dev,
+			struct device_attribute *attr,
+			const char *buf, size_t count)
+{
+	u64 sn[MLNX_MFG_VAL_QWORD_CNT(SN)] = { 0 };
+	struct arm_smccc_res res;
+	int word;
+
+	if (count > MLNX_MFG_SN_VAL_LEN)
+		return -EINVAL;
+
+	memcpy(sn, buf, count);
+
+	mutex_lock(&mfg_ops_lock);
+	for (word = 0; word < MLNX_MFG_VAL_QWORD_CNT(SN); word++) {
+		arm_smccc_smc(MLXBF_BOOTCTL_SET_MFG_INFO,
+			      MLNX_MFG_TYPE_SN_0 + word,
+			      sizeof(u64), sn[word], 0, 0, 0, 0, &res);
+		if (res.a0) {
+			mutex_unlock(&mfg_ops_lock);
+			return -EPERM;
+		}
+	}
+	mutex_unlock(&mfg_ops_lock);
+
+	return count;
+}
+
+static ssize_t uuid_show(struct device *dev,
+			 struct device_attribute *attr, char *buf)
+{
+	u64 uuid_data[MLNX_MFG_VAL_QWORD_CNT(UUID)] = { 0 };
+	char uuid[MLNX_MFG_UUID_VAL_LEN + 1] = { 0 };
+	struct arm_smccc_res res;
+	int word;
+
+	mutex_lock(&mfg_ops_lock);
+	for (word = 0; word < MLNX_MFG_VAL_QWORD_CNT(UUID); word++) {
+		arm_smccc_smc(MLXBF_BOOTCTL_GET_MFG_INFO,
+			      MLNX_MFG_TYPE_UUID_0 + word,
+			      0, 0, 0, 0, 0, 0, &res);
+		if (res.a0) {
+			mutex_unlock(&mfg_ops_lock);
+			return -EPERM;
+		}
+		uuid_data[word] = res.a1;
+	}
+	mutex_unlock(&mfg_ops_lock);
+	memcpy(uuid, uuid_data, MLNX_MFG_UUID_VAL_LEN);
+
+	return snprintf(buf, PAGE_SIZE, "%s", uuid);
+}
+
+static ssize_t uuid_store(struct device *dev,
+			  struct device_attribute *attr,
+			  const char *buf, size_t count)
+{
+	u64 uuid[MLNX_MFG_VAL_QWORD_CNT(UUID)] = { 0 };
+	struct arm_smccc_res res;
+	int word;
+
+	if (count > MLNX_MFG_UUID_VAL_LEN)
+		return -EINVAL;
+
+	memcpy(uuid, buf, count);
+
+	mutex_lock(&mfg_ops_lock);
+	for (word = 0; word < MLNX_MFG_VAL_QWORD_CNT(UUID); word++) {
+		arm_smccc_smc(MLXBF_BOOTCTL_SET_MFG_INFO,
+			      MLNX_MFG_TYPE_UUID_0 + word,
+			      sizeof(u64), uuid[word], 0, 0, 0, 0, &res);
+		if (res.a0) {
+			mutex_unlock(&mfg_ops_lock);
+			return -EPERM;
+		}
+	}
+	mutex_unlock(&mfg_ops_lock);
+
+	return count;
+}
+
+static ssize_t rev_show(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	u64 rev_data[MLNX_MFG_VAL_QWORD_CNT(REV)] = { 0 };
+	char rev[MLNX_MFG_REV_VAL_LEN + 1] = { 0 };
+	struct arm_smccc_res res;
+	int word;
+
+	mutex_lock(&mfg_ops_lock);
+	for (word = 0; word < MLNX_MFG_VAL_QWORD_CNT(REV); word++) {
+		arm_smccc_smc(MLXBF_BOOTCTL_GET_MFG_INFO,
+			      MLNX_MFG_TYPE_REV + word,
+			      0, 0, 0, 0, 0, 0, &res);
+		if (res.a0) {
+			mutex_unlock(&mfg_ops_lock);
+			return -EPERM;
+		}
+		rev_data[word] = res.a1;
+	}
+	mutex_unlock(&mfg_ops_lock);
+	memcpy(rev, rev_data, MLNX_MFG_REV_VAL_LEN);
+
+	return snprintf(buf, PAGE_SIZE, "%s", rev);
+}
+
+static ssize_t rev_store(struct device *dev,
+			 struct device_attribute *attr,
+			 const char *buf, size_t count)
+{
+	u64 rev[MLNX_MFG_VAL_QWORD_CNT(REV)] = { 0 };
+	struct arm_smccc_res res;
+	int word;
+
+	if (count > MLNX_MFG_REV_VAL_LEN)
+		return -EINVAL;
+
+	memcpy(rev, buf, count);
+
+	mutex_lock(&mfg_ops_lock);
+	for (word = 0; word < MLNX_MFG_VAL_QWORD_CNT(REV); word++) {
+		arm_smccc_smc(MLXBF_BOOTCTL_SET_MFG_INFO,
+			      MLNX_MFG_TYPE_REV + word,
+			      sizeof(u64), rev[word], 0, 0, 0, 0, &res);
+		if (res.a0) {
+			mutex_unlock(&mfg_ops_lock);
+			return -EPERM;
+		}
+	}
+	mutex_unlock(&mfg_ops_lock);
+
+	return count;
+}
+
+static ssize_t mfg_lock_store(struct device *dev,
+			      struct device_attribute *attr,
+			      const char *buf, size_t count)
+{
+	struct arm_smccc_res res;
+	unsigned long val;
+	int err;
+
+	err = kstrtoul(buf, 10, &val);
+	if (err)
+		return err;
+
+	if (val != 1)
+		return -EINVAL;
+
+	mutex_lock(&mfg_ops_lock);
+	arm_smccc_smc(MLXBF_BOOTCTL_LOCK_MFG_INFO, 0, 0, 0, 0, 0, 0, 0, &res);
+	mutex_unlock(&mfg_ops_lock);
+
+	return count;
+}
+
 static DEVICE_ATTR_RW(post_reset_wdog);
 static DEVICE_ATTR_RW(reset_action);
 static DEVICE_ATTR_RW(second_reset_action);
@@ -463,6 +903,14 @@ static DEVICE_ATTR_WO(fw_reset);
 static DEVICE_ATTR_WO(rsh_log);
 static DEVICE_ATTR_RW(large_icm);
 static DEVICE_ATTR_WO(os_up);
+static DEVICE_ATTR_RW(oob_mac);
+static DEVICE_ATTR_RW(opn);
+static DEVICE_ATTR_RW(sku);
+static DEVICE_ATTR_RW(modl);
+static DEVICE_ATTR_RW(sn);
+static DEVICE_ATTR_RW(uuid);
+static DEVICE_ATTR_RW(rev);
+static DEVICE_ATTR_WO(mfg_lock);
 
 static struct attribute *mlxbf_bootctl_attrs[] = {
 	&dev_attr_post_reset_wdog.attr,
@@ -474,6 +922,14 @@ static struct attribute *mlxbf_bootctl_attrs[] = {
 	&dev_attr_rsh_log.attr,
 	&dev_attr_large_icm.attr,
 	&dev_attr_os_up.attr,
+	&dev_attr_oob_mac.attr,
+	&dev_attr_opn.attr,
+	&dev_attr_sku.attr,
+	&dev_attr_modl.attr,
+	&dev_attr_sn.attr,
+	&dev_attr_uuid.attr,
+	&dev_attr_rev.attr,
+	&dev_attr_mfg_lock.attr,
 	NULL
 };
 
diff --git a/drivers/platform/mellanox/mlxbf-bootctl.h b/drivers/platform/mellanox/mlxbf-bootctl.h
index 613963d448f2..1299750a8661 100644
--- a/drivers/platform/mellanox/mlxbf-bootctl.h
+++ b/drivers/platform/mellanox/mlxbf-bootctl.h
@@ -81,6 +81,14 @@
  */
 #define MLXBF_BOOTCTL_FW_RESET  0x8200000D
 
+/*
+ * SMC function IDs to set, get and lock the manufacturing information
+ * stored within the eeprom.
+ */
+#define MLXBF_BOOTCTL_SET_MFG_INFO    0x8200000E
+#define MLXBF_BOOTCTL_GET_MFG_INFO    0x8200000F
+#define MLXBF_BOOTCTL_LOCK_MFG_INFO   0x82000011
+
 /*
  * SMC function IDs to set and get the large ICM carveout size
  * stored in the eeprom.
-- 
2.30.1

