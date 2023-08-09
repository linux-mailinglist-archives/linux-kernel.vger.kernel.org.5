Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD63F77622C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 16:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233190AbjHIOPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 10:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbjHIOPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 10:15:37 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338921FD7
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 07:15:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GJvf4l0tA63BcPtVcZGsWHZq/cCuL3SBzZwHsMcXMjFa2UbYGsOsMU57USN1Eti5acRf8jeQv/ByMsyMxfASpJixk7nIrRWuLEPa3wamEh9EliLxXrr19/vfz1S55otTnmTozoZAvxV3iAsIhP4DyfZAyPeLL2D0URTjaqhL+GJPWo4EWUAHkMDGNLIVDGvnsMYqZw+XxqHcvOKcS017xpXZuXRZ+LOGvFDuWytzaXM9EHcIdG4KXiMRY4pJ888uwtB1SnZDzwQgOwAkjUfpAInE+ed/hsn7bxeok2O/0GJIAFNpSU8uofuw2omkpaAEMIv89WzGBuVwEKOsIEDuyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZpMXIjyR49wt5s6of9J0IzpEovIxnnhOV3RyK8TKIaM=;
 b=aLJ6iayulYOz7nG1cF/AoANkiNGJPgZGuISZixTLjEJ4E3XtGSnK25FuZPKvSI4nAWZMV8JnD4MSIkKj2JMucLnMYAsLa4EuOp/3dmBn2alzpvVd2G6St2M9mFcDT6V8fUOnnVts8OwMXPvub5novRDUauqmzOlJy8wONwhozV5kUEa7O2+cUDvimUUXienC0GQTz/964Ih4gkNH9v46L4xj4JvvTN4VJUEslcAstqJpi+0YtOEfTi80bG7SbXeF/r0fazKOnU6tUaJYaoPoYGQpoUbrgjw9BRcEf922BmTGUVifdl0yhLjlOpmLUC2usPur/UUVBZcwRVOcQRNf/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZpMXIjyR49wt5s6of9J0IzpEovIxnnhOV3RyK8TKIaM=;
 b=EeK7mx8cUV77Q0xbx2DZsEhJGzLX6sQXpm0TSdL8CNsS0GV80TaDd+xss1GoZzjBTap7lb429TaaRt7DwmYOKCrga0MfQdPg6iqLW6JGgquILeZvXu4kTZxsEMnSv8VP3Vkik7BQBRNBDZNZtUYSwaYgmQfba1IhUJRuIzmsgjQYCugy9CaW5RnLt1L5TLLTZGRj/fabLeJrZsjv27gi7+J19/m/rdjbrSKCWTnckhq5xjhKb4v2V4272b0mH3PHLA5TirblbwKQPMhC+MUn9BrU/vv7DoG/xE1oBR3vQlMS5dfgsaZC3+NULh1hml18QTWRzNEurIgpjSov89Ktog==
Received: from MW4PR04CA0171.namprd04.prod.outlook.com (2603:10b6:303:85::26)
 by PH7PR12MB5806.namprd12.prod.outlook.com (2603:10b6:510:1d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 14:15:30 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:303:85:cafe::8f) by MW4PR04CA0171.outlook.office365.com
 (2603:10b6:303:85::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28 via Frontend
 Transport; Wed, 9 Aug 2023 14:15:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Wed, 9 Aug 2023 14:15:30 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 9 Aug 2023
 07:15:20 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 9 Aug 2023 07:15:19 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Wed, 9 Aug 2023 07:15:18 -0700
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     <markgross@kernel.org>, <vadimp@nvidia.com>, <hdegoede@redhat.com>,
        <linux-kernel@vger.kernel.org>
CC:     Asmaa Mnebhi <asmaa@nvidia.com>
Subject: [PATCH v1 1/2] mlxbf-bootctl: Support the large icmc write/read
Date:   Wed, 9 Aug 2023 10:15:12 -0400
Message-ID: <20230809141513.9058-2-asmaa@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20230809141513.9058-1-asmaa@nvidia.com>
References: <20230809141513.9058-1-asmaa@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|PH7PR12MB5806:EE_
X-MS-Office365-Filtering-Correlation-Id: f447dae5-e1a5-4677-ce58-08db98e31696
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tbYg2pUugsHb6yE9CUz92kcSNd8Si2BAC1YnuicdphRPZffEUdecRKJkeVqnoX1dumYbv7pd8LJNsAUa7yc9psV/xK5ysgWYDxfRwWvSUDkhNXLKESJZPcQW4/8oot+lQIs5Ci05jXlNT5Zb76mHIBocS83QxwViZleBvc8+ltwNdvbl3TP+pxGG1Q4HDd25oj8q9eLtAsVVCROHw07CiaoeHIWp0v+gGoULb7u9VwDB2Y+pI6VjQQAIRmjK80AG844LwTTD0H4ODhog3ppdonh4L9LN4CI0spxTTsho+A3AmvVALDXzma7JR5V3zm7d8JH5qeDDfhQQr3C2f4VUI7eMGEM+YTx+V+U3D4B7ujk1codfmS62EG9gj6brbrhQY8Hy93MtozfyOChqyIK4771eVZQa7/zpLeO2vwJmvY5WFH0ygU9PQ+U78i4eSRITyVv9ES3C8+QknypCqjq8RyvYcO5dPxzazHoqRbQ6EJ0zvu2gpdBzNvzCsxnV2+bdrkJbzFF9O4+jdMdfiv+P9InUVW24eosx/MlOxZ6us9RO6zcU7HKhOYdmap+7saQDMI3rXx5AzBWUzes+iks+S/e0I/d3k5gUsByQmmIu2BS6vzEfec/phc/nKC4qkXVtu5DevT60BD7DUAQoq8teD00NHCeHfzydka5/VrEeQ7/bM3GuHPGlCvR1ok5AmLFIaVFO+J1RsSyBkfva9cpFgYF46dSpLbOJ+U82qAKGEAxXCJS9VIhBOqC5Tkxzvx2m
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(136003)(82310400008)(1800799006)(186006)(451199021)(46966006)(36840700001)(40470700004)(41300700001)(40460700003)(82740400003)(7696005)(6666004)(26005)(2616005)(356005)(7636003)(83380400001)(426003)(107886003)(47076005)(1076003)(336012)(36860700001)(40480700001)(316002)(110136005)(2906002)(478600001)(86362001)(70206006)(70586007)(4326008)(36756003)(8936002)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 14:15:30.6256
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f447dae5-e1a5-4677-ce58-08db98e31696
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5806
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
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
 drivers/platform/mellanox/mlxbf-bootctl.c | 42 +++++++++++++++++++++++
 drivers/platform/mellanox/mlxbf-bootctl.h |  9 +++++
 2 files changed, 51 insertions(+)

diff --git a/drivers/platform/mellanox/mlxbf-bootctl.c b/drivers/platform/mellanox/mlxbf-bootctl.c
index fb9f7815c6cd..3ea11250b681 100644
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
+	err = kstrtoul(buf, 16, &icm_data);
+	if (err)
+		return err;
+
+	if (((icm_data != 0) && (icm_data < 0x80)) ||
+	    (icm_data > 0x100000) || (icm_data % 128))
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
index b48243f60a59..75d59ade92be 100644
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
-- 
2.30.1

