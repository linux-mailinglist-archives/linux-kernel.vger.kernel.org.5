Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB66C7814D1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 23:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240850AbjHRVew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 17:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240879AbjHRVej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 17:34:39 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2046.outbound.protection.outlook.com [40.107.212.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F38A2D7D;
        Fri, 18 Aug 2023 14:34:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGQ0/xiYZgnDmZJVpzS2dfPBzfHCr+oSs4dTk5dmQAqTMhoFxLur07TU0D7xHXbunbg7qP4hwTRzFAn8L8p+wnptujRkHUTEQmADYOyHAJw2jlWynl28v/UikoMHlgzCHYqpfjgHUtoohjASifmf2ZzRTjT6ObRejIUEEPQ2qMEUaYGMsIzYQucKGBy4uflgdYlt65Xvzdw287KoxJuZwDpJJTrsq4FhDObtGumsOgTwpCZ/xeliLS/pk8WITIkN8UQPq6CT8QDARLjx5eHzdWjVxFl5Lq0BJfF3V39QorqO8Hn+xl3VOVQaQ1bUjhUYWfMfpkIYXJTiT2msHuv17A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KkzHfyyzaXicq8tnGBcfAQgRleemQ0UKwxYoQOi0FZ8=;
 b=gKutrWXBVC+q9uiaHnfG92/ZLUomV7RQZmGPaahxNFgnUWSihK4Hxf1cJhIoQcql/zj4dh3Rm7DJZmLDuvFN+Jffnh2JmWp5TM01IQkZVjRRvp12JNimnQMPNddExMurom4UBVqZW8f/8vDQM7+JFbU19F3egLhlVk7m9Azu9X9AGrM/etRN3fsTkzfMZgzN2UADCTHmG7/gHCzw1H/NOzWoAQeDrEvDKCxAK93urI4gPFSMm0HcL2/XjHbSLVDBIAGulSMmLoxMlQWTN21W/drRbRg//KB9/9tO8T/9GCbAdbO+W1+0xHCmFYpgGgEVQhB+0GJFLCk8P+s1KH41Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KkzHfyyzaXicq8tnGBcfAQgRleemQ0UKwxYoQOi0FZ8=;
 b=maLg52Sn5NNdxsJJDIW+Hh5nMSwCTGYbbrO2ZUdDQ6mCucuEaqQOn4z7YwL9aOeIAvrV0C5zSDmRAiwKbb7H5xz6fluxlrb0LELWcHHaC1uxFxIyRk5Z5wVObqodCheR2/4xcj28vheVfdYORI5RR7HqziWk9t0S09Np2WQCR6536AydNRPJvPSMyQLUPL1SveRL12grOY9xJU5t40sz7wuIRHvo2Ioz3KOn1Fq9ec1VCtjQEtG/aRMw1Z30SSwlWcDYrDMmbVQ4ywO2CntmNuc24eB6Q6zrWZvYb7E+kznZP/L/6nS7zE4Gd0lvJeSM/px0zH08mIRvrRW7z8uiYA==
Received: from CYZPR02CA0009.namprd02.prod.outlook.com (2603:10b6:930:a1::27)
 by SA1PR12MB5672.namprd12.prod.outlook.com (2603:10b6:806:23c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 21:34:34 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:930:a1:cafe::48) by CYZPR02CA0009.outlook.office365.com
 (2603:10b6:930:a1::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Fri, 18 Aug 2023 21:34:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.15 via Frontend Transport; Fri, 18 Aug 2023 21:34:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 18 Aug 2023
 14:34:21 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 18 Aug
 2023 14:34:21 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Fri, 18 Aug
 2023 14:34:20 -0700
From:   David Thompson <davthompson@nvidia.com>
To:     <hdegoede@redhat.com>, <ilpo.jarvinen@linux.intel.com>,
        <markgross@kernel.org>, <vadimp@nvidia.com>
CC:     <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <shravankr@nvidia.com>,
        David Thompson <davthompson@nvidia.com>
Subject: [PATCH v2] mlxbf-bootctl: Support sysfs entries for MFG fields
Date:   Fri, 18 Aug 2023 17:34:17 -0400
Message-ID: <20230818213417.17942-1-davthompson@nvidia.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|SA1PR12MB5672:EE_
X-MS-Office365-Filtering-Correlation-Id: 80acee06-df02-448a-3e80-08dba032ea8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YLk3r/uqnO8cUuOhU76Pc1ybSR2mxDAnibm4VuSfR62YEP3EbEGhM3hUSmBO5Kb2xhjfpbU9dVjHcu3n1Le2264XG1ayhibhYV6C9Naak/dR0A9x/HQVujlShPh4gFLPjBg724i6cYYg/g9ALV5xOoakKWnOKK+CYSKPF0N6dgpEly0pOUBNdYWw4AeNGkkflimzxYOAGBmcyHvTbUwjzC5q+7rC33XqsSC2kFn6nR+q3GmHELFvpvjhBCaTLboanSJxDn1SvX8pMRAhq90FgiNOptS7GCN8PB+fh+6mZWhposVa0qyqNVhSxZGlRWJpo3+AsguSwI3HWqdbjtryi/vQBDD6vSgVrt5CUHrtyy/+YoUqaanLzgsN819uI6t75arFYmPRm4LFBC1wQPAsK7T+RUclmWq1Ow2Q7Pl481CPmMa60n67ZfHaWTJqfJr32ICyJhYtxvyLc8Ar8ViPWA5aTAZbAHWXNGcOSVwLf4mQ613dS9ennBl9vYx9mHDY50t1iycroZ0AkP47ietqBZNcELSPbJ3v8h25JVyxwDCu4xaa5z4sfqZ21/cN17bSPSzUKDa0b4TqzWVMlLLCnwhjUikNEivFqbfjtiGrkevB3s6rtuTRoHVHP6/HBlWpZLiATzK3Z4FBZHxFTjL88Z2g6o+ekSb/Zh+tBOuH5zZ5HX+/8okgvOa3MtChURg0nt7t+EvZc/eqFBB9P0Xd0yc894/Wc/NVHoTfo9YK6euDMvEhjeYhZSaLqhsWWnb0i/zgMEjjBNZR7yIAEzTB4g==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(39860400002)(376002)(451199024)(1800799009)(82310400011)(186009)(40470700004)(36840700001)(46966006)(7636003)(40480700001)(83380400001)(40460700003)(70206006)(70586007)(6636002)(316002)(54906003)(110136005)(478600001)(356005)(5660300002)(82740400003)(2906002)(30864003)(41300700001)(4326008)(8676002)(8936002)(426003)(36860700001)(47076005)(2616005)(6666004)(1076003)(26005)(107886003)(7696005)(336012)(86362001)(36756003)(21314003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 21:34:34.5610
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80acee06-df02-448a-3e80-08dba032ea8b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5672
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
v1->v2
   - use ETH_ALEN instead of custom #define (MLNX_MFG_OOB_MAC_LEN)
   - changes to xxx_show() methods:
      a) removed unnecessary memcpy() calls, instead use data from xxx_data[]
      b) increment size of xxx_data[] by 1 to ensure null termination
   - changed "byte[]" variable to unsigned int in oob_mac_store()
   - use sysfs_format_mac() in oob_mac_show()
---
 drivers/platform/mellanox/mlxbf-bootctl.c | 438 ++++++++++++++++++++++
 drivers/platform/mellanox/mlxbf-bootctl.h |   8 +
 2 files changed, 446 insertions(+)

diff --git a/drivers/platform/mellanox/mlxbf-bootctl.c b/drivers/platform/mellanox/mlxbf-bootctl.c
index 0bf29eee1e70..4ee7bb431b7c 100644
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
@@ -81,6 +82,49 @@ static const char * const mlxbf_rsh_log_level[] = {
 
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
+	((ETH_ALEN * 2) + (ETH_ALEN - 1))
 
 /* ARM SMC call which is atomic and no need for lock. */
 static int mlxbf_bootctl_smc(unsigned int smc_op, int smc_arg)
@@ -454,6 +498,384 @@ static ssize_t os_up_store(struct device *dev,
 	return count;
 }
 
+static ssize_t oob_mac_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
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
+	return sysfs_format_mac(buf, mac_byte_ptr, ETH_ALEN);
+}
+
+static ssize_t oob_mac_store(struct device *dev,
+			     struct device_attribute *attr,
+			     const char *buf, size_t count)
+{
+	unsigned int byte[MLNX_MFG_OOB_MAC_FORMAT_LEN] = { 0 };
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
+	if (len != ETH_ALEN)
+		return -EINVAL;
+
+	mac_byte_ptr = (u8 *)&mac_addr;
+
+	for (byte_idx = 0; byte_idx < ETH_ALEN; byte_idx++)
+		mac_byte_ptr[byte_idx] = (u8)byte[byte_idx];
+
+	mutex_lock(&mfg_ops_lock);
+	arm_smccc_smc(MLXBF_BOOTCTL_SET_MFG_INFO, MLNX_MFG_TYPE_OOB_MAC,
+		      ETH_ALEN, mac_addr, 0, 0, 0, 0, &res);
+	mutex_unlock(&mfg_ops_lock);
+
+	return res.a0 ? -EPERM : count;
+}
+
+static ssize_t opn_show(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	u64 opn_data[MLNX_MFG_VAL_QWORD_CNT(OPN) + 1] = { 0 };
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
+
+	return snprintf(buf, PAGE_SIZE, "%s", (char *)opn_data);
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
+	u64 sku_data[MLNX_MFG_VAL_QWORD_CNT(SKU) + 1] = { 0 };
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
+
+	return snprintf(buf, PAGE_SIZE, "%s", (char *)sku_data);
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
+	u64 modl_data[MLNX_MFG_VAL_QWORD_CNT(MODL) + 1] = { 0 };
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
+
+	return snprintf(buf, PAGE_SIZE, "%s", (char *)modl_data);
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
+	u64 sn_data[MLNX_MFG_VAL_QWORD_CNT(SN) + 1] = { 0 };
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
+
+	return snprintf(buf, PAGE_SIZE, "%s", (char *)sn_data);
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
+	u64 uuid_data[MLNX_MFG_VAL_QWORD_CNT(UUID) + 1] = { 0 };
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
+
+	return snprintf(buf, PAGE_SIZE, "%s", (char *)uuid_data);
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
+	u64 rev_data[MLNX_MFG_VAL_QWORD_CNT(REV) + 1] = { 0 };
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
+
+	return snprintf(buf, PAGE_SIZE, "%s", (char *)rev_data);
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
@@ -463,6 +885,14 @@ static DEVICE_ATTR_WO(fw_reset);
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
@@ -474,6 +904,14 @@ static struct attribute *mlxbf_bootctl_attrs[] = {
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

