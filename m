Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93379776503
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 18:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjHIQ3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 12:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjHIQ3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 12:29:21 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B37171D
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 09:29:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j5hgmDUxB5NUXx4FY0/PP7LZLSCjlOPJHhvh+HVk5FHjR6TIApRqXjF2lcZR5eSm0VOQFEKVEgxW/1I5f/Yn9g5D3M7Q94Zv5XbDLmxWHs5uly43Bf9ssVeW1qD0xJ5xb9kbFa63OwpGSikGT+JBF9gGnl7Ays1VoWB0vnskYgK1QMki0G2NCeVhkgqzK0Qlad9hUyQj9kr16fJJhrfd5WnUtijANpeHooI7/+XJFdkl8kf3zDBTqLKuAi86+QNO5fzS/6fsgOhXA+rNoBl7W6KzToLuFuL+ARU/9oP2uoVCdvfW1kj4gBj/Yvm45dS5izb9B1FYiLcMzVyJn2R2iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ADDRG162QtGeuGdancjktB1cSWcGZRUa4/YTrpLOEzs=;
 b=IR7A4otqvWfvIM3oTo3OE6ujDdCV5MPjp0lOe7Fo+mlaRgt5rmBO5VeREAA8SEryI/LIGtaqjfoGwbShp1Q8lVUmRFQIFb4a/rbyESBwA1VRkqihWNOotvR5hnWJkOu8B064Pal39icb5axJ8uV58GlMPbgleI1wqylfmQ2QTAwLkD2ErpdQuLeTvP9QCxTxLqPYqdgiNTyR3jdWKxoj+Axa7ohB5YBDL2qYK4AFFyNrkkoncrKuRmIjNjau0xCZtMtJT7VSSOhhzDFU3w0LobngEl0KJmyFYVXlJNIIcsQ4wCaiwOn7ECLbp9PC4HP7RkuZsuZ9KnfWl0nLmsknOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ADDRG162QtGeuGdancjktB1cSWcGZRUa4/YTrpLOEzs=;
 b=ZIsR9bhBRfi0E2n5LHM60tEntwI1AbLIpFIxhi3JGSjwec5f1n/7sLMruDc+h/ITajsbNU1x6fUg3OgN0XNNKFR6p8gBONGCGiytHf5/U9xxHkMjVnia/JRwRAblnl+SuCif8Pegq5d7rs9I84rTsGyVWQI2c7k5JXl42SLKt/sm25fjB1Bu4HGXqdSKWGvVxblZUhAIW0ijVbIdkdtz3qO9MwY42euO8/lxHwl5efL6efcaZut2eJ5kWHcqRgBHa1RrRX48DK/ZpxpI+i6xNEVH9O1TV80LTTby/Avuj54TnGjRrThZn/BKmljz8lBjDJtcgHM3+ZrSmGfZtUG6Rw==
Received: from SN7PR04CA0235.namprd04.prod.outlook.com (2603:10b6:806:127::30)
 by MN2PR12MB4205.namprd12.prod.outlook.com (2603:10b6:208:198::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 16:29:17 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:127:cafe::10) by SN7PR04CA0235.outlook.office365.com
 (2603:10b6:806:127::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28 via Frontend
 Transport; Wed, 9 Aug 2023 16:29:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Wed, 9 Aug 2023 16:29:17 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 9 Aug 2023
 09:29:02 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 9 Aug 2023
 09:29:02 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Wed, 9 Aug
 2023 09:29:01 -0700
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     <markgross@kernel.org>, <vadimp@nvidia.com>, <hdegoede@redhat.com>,
        <linux-kernel@vger.kernel.org>
CC:     Asmaa Mnebhi <asmaa@nvidia.com>
Subject: [PATCH v2 1/2] mlxbf-bootctl: Support the large icmc write/read
Date:   Wed, 9 Aug 2023 12:28:56 -0400
Message-ID: <20230809162857.21243-2-asmaa@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20230809162857.21243-1-asmaa@nvidia.com>
References: <20230809162857.21243-1-asmaa@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|MN2PR12MB4205:EE_
X-MS-Office365-Filtering-Correlation-Id: 69d18e89-f7da-4d38-3d8a-08db98f5c6ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W8QhhWlaCIxRwM31PUv5Ps+rObk5vflxHhIGQoZjfRkWGqswHG8BJUXJyO2ylXfiMntHHpJp35kFb+yrPIxZi5dZzFshKIU6xyMspML+pRSOP9h2iR7MX3psAJG6YYdAo3UDYcExZP8ABLTjHttYQoNftOdme5AQ+aNqJ1ugrqo3z0BXJv+aNiYRZjg2k7lUzdg5tm8hIw4aFpmBysMfA7vs7rZ5UIUVXyrpX2i6ctuzw228k+uhNqO0rGglM0T8jA3XC0c/vG+Bkc1WBenPvMxTF5CTB9KmFLsbvnox/uEQlwhp3hKEP564Nl9iTm4pv4+ixVtLNDeH5HGSiqS1PHCT7vQq0yzbRMJXJLVhUqCkhjrrSf3FPQ+gJvLvfJXx2unox69z53rHaCaZ5cc/Zt2jcTNbvIfyakuGRvJvPvM12S430A/Tb+DctB5JjwTFg6BNxj6kTabDj2MCWsy+Y3OdOKcdnYawgtMEllPrzksQBG+LzrggF5RAVhizEGUq73m/nzNEZi//+dvojzFUMW2gklVxuDREtpiUySVke2q4p7ILorDok+etxsSB9mzE3GzlbRTB2OfPl1TyGev5e/+vmrfIVzB2lxdIRH8qx2VStp4pLOLga2nz4E0Vq53jWWo5iV+xOy7OO33z0aZF+8ayu77VVJ1G/cf/YJx4wWFbL3WstzlKQL3mooexqpnNg4fkkCNl+rw/5H9Bc3RdfrJUioY56jwS32WXTof81R+X7Ot9fLLrVwypG9UN5iPA
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(396003)(82310400008)(451199021)(186006)(1800799006)(36840700001)(40470700004)(46966006)(82740400003)(356005)(2616005)(107886003)(336012)(6666004)(7636003)(83380400001)(426003)(47076005)(478600001)(1076003)(26005)(36860700001)(7696005)(110136005)(41300700001)(316002)(40460700003)(5660300002)(8676002)(8936002)(4326008)(70206006)(70586007)(2906002)(40480700001)(36756003)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 16:29:17.3340
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69d18e89-f7da-4d38-3d8a-08db98f5c6ed
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4205
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable reading and writing the size of the memory region associated
with the large ICM carveout.
The max size of the large ICM carveout is 1TB, has a granularity
of 128MB and will be passed and printed in hex. The size unit is MB.

Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>
---
v1->v2:
- added defines for icmc related integers
- removed unnecessary parentheses.

 drivers/platform/mellanox/mlxbf-bootctl.c | 42 +++++++++++++++++++++++
 drivers/platform/mellanox/mlxbf-bootctl.h | 14 ++++++++
 2 files changed, 56 insertions(+)

diff --git a/drivers/platform/mellanox/mlxbf-bootctl.c b/drivers/platform/mellanox/mlxbf-bootctl.c
index fb9f7815c6cd..52d1272478a4 100644
--- a/drivers/platform/mellanox/mlxbf-bootctl.c
+++ b/drivers/platform/mellanox/mlxbf-bootctl.c
@@ -79,6 +79,8 @@ static void __iomem *mlxbf_rsh_scratch_buf_data;
 static const char * const mlxbf_rsh_log_level[] = {
 	"INFO", "WARN", "ERR", "ASSERT"};
 
+static DEFINE_MUTEX(icm_ops_lock);
+
 /* ARM SMC call which is atomic and no need for lock. */
 static int mlxbf_bootctl_smc(unsigned int smc_op, int smc_arg)
 {
@@ -391,6 +393,44 @@ static ssize_t rsh_log_store(struct device *dev,
 	return count;
 }
 
+static ssize_t large_icm_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct arm_smccc_res res;
+
+	mutex_lock(&icm_ops_lock);
+	arm_smccc_smc(MLNX_HANDLE_GET_ICM_INFO, 0, 0, 0, 0,
+		      0, 0, 0, &res);
+	mutex_unlock(&icm_ops_lock);
+	if (res.a0)
+		return -EPERM;
+
+	return snprintf(buf, PAGE_SIZE, "0x%lx", res.a1);
+}
+
+static ssize_t large_icm_store(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t count)
+{
+	struct arm_smccc_res res;
+	unsigned long icm_data;
+	int err;
+
+	err = kstrtoul(buf, MLXBF_LARGE_ICMC_MAX_STRING_SIZE, &icm_data);
+	if (err)
+		return err;
+
+	if ((icm_data != 0 && icm_data < MLXBF_LARGE_ICMC_SIZE_MIN) ||
+	    icm_data > MLXBF_LARGE_ICMC_SIZE_MAX || icm_data % MLXBF_LARGE_ICMC_GRANULARITY)
+		return -EPERM;
+
+	mutex_lock(&icm_ops_lock);
+	arm_smccc_smc(MLNX_HANDLE_SET_ICM_INFO, icm_data, 0, 0, 0, 0, 0, 0, &res);
+	mutex_unlock(&icm_ops_lock);
+
+	return res.a0 ? -EPERM : count;
+}
+
 static DEVICE_ATTR_RW(post_reset_wdog);
 static DEVICE_ATTR_RW(reset_action);
 static DEVICE_ATTR_RW(second_reset_action);
@@ -398,6 +438,7 @@ static DEVICE_ATTR_RO(lifecycle_state);
 static DEVICE_ATTR_RO(secure_boot_fuse_state);
 static DEVICE_ATTR_WO(fw_reset);
 static DEVICE_ATTR_WO(rsh_log);
+static DEVICE_ATTR_RW(large_icm);
 
 static struct attribute *mlxbf_bootctl_attrs[] = {
 	&dev_attr_post_reset_wdog.attr,
@@ -407,6 +448,7 @@ static struct attribute *mlxbf_bootctl_attrs[] = {
 	&dev_attr_secure_boot_fuse_state.attr,
 	&dev_attr_fw_reset.attr,
 	&dev_attr_rsh_log.attr,
+	&dev_attr_large_icm.attr,
 	NULL
 };
 
diff --git a/drivers/platform/mellanox/mlxbf-bootctl.h b/drivers/platform/mellanox/mlxbf-bootctl.h
index b48243f60a59..fc5019c90fc5 100644
--- a/drivers/platform/mellanox/mlxbf-bootctl.h
+++ b/drivers/platform/mellanox/mlxbf-bootctl.h
@@ -81,6 +81,15 @@
  */
 #define MLXBF_BOOTCTL_FW_RESET  0x8200000D
 
+/*
+ * SMC function IDs to set and get the large ICM carveout size
+ * stored in the eeprom.
+ */
+#define MLNX_HANDLE_SET_ICM_INFO    0x82000012
+#define MLNX_HANDLE_GET_ICM_INFO    0x82000013
+
+#define MAX_ICM_BUFFER_SIZE 10
+
 /* SMC function IDs for SiP Service queries */
 #define MLXBF_BOOTCTL_SIP_SVC_CALL_COUNT	0x8200ff00
 #define MLXBF_BOOTCTL_SIP_SVC_UID		0x8200ff01
@@ -106,4 +115,9 @@
 /* Additional value to disable the MLXBF_BOOTCTL_SET_SECOND_RESET_ACTION. */
 #define MLXBF_BOOTCTL_NONE	0x7fffffff /* Don't change next boot action */
 
+#define MLXBF_LARGE_ICMC_MAX_STRING_SIZE 16
+#define MLXBF_LARGE_ICMC_SIZE_MIN        0x80
+#define MLXBF_LARGE_ICMC_SIZE_MAX        0x100000
+#define MLXBF_LARGE_ICMC_GRANULARITY     MLXBF_LARGE_ICMC_SIZE_MIN
+
 #endif /* __MLXBF_BOOTCTL_H__ */
-- 
2.30.1

