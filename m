Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD27F776504
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 18:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbjHIQ3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 12:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjHIQ3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 12:29:21 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB95D10FE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 09:29:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hbvx11+hNk3YZS6aY/O087kgpGQ6iYrcLsrRd3ABMPf5bWxrmWWI5EQLy3MVvW9GhvBTGG+Ga3h/e0Teuxl/0vXJ6LbCMhwYEAmKDIH4sS3D4qdF/uZI//Mq3i5uFpNDYZ5b2txWtAXW4ksNZiAS/f/ULalbYduNlFfA1rBJL7LX3TPBYBOFfj9ch4K3zU7AhnYUC3iqlDWG2ng7mZKpz03X0oNvPoWB3vgTOP23lhn3O2rcI4Awy4HEsljiou5h4PS6WJYje5v/u3OTvh/Hh4/iLFaVmIlvGg2IgOMWQ9RN/NBO6OoWSkKRb7C0HDJmDsYJ4WPO8no9NTyLJC/m+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WjXYhBovnH+IO9YOBxKJKST1Lm3Sx1iVjBj3rmkuXhE=;
 b=cWFurQuW/JJ+DoyUjxsPrPRMxLkkFSwJeLFkewMyLVn2S0/pp5mD0sKcOuoHCcR6Dmmo6lWwMGFZrx+0u92OlKqq43PWCHtYEL2cyBTrs0fVM72TSGrYc3KCgs5piA1pJXFY8+zRNix7hZM4gc2l33OELd/3Wj5/hJFKWPlA9u7C/rbxQkTmuBjijArtmmmZi1wStyN+3A9T4H3U4n3i8FsHLO/2bv0A2ljlF8Vg43IyqI1v3xXljWs53OMQwlSs8TKsWA7rmhAVvfAlIqdEV9qmLU5C/wy9EdDElFR0Xf7z7OC0PndRCU+ecb7opfutCcmg8JLiA1vLU07QQCHD+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WjXYhBovnH+IO9YOBxKJKST1Lm3Sx1iVjBj3rmkuXhE=;
 b=aAch4T0zdFrAduAXEo5ClURUyJhexOtCwASVyBPkfWoMITaqEkXzs1r3TCviCWGjpVfJATeC8ehv+WWFi8+JhlTbpZA54r+6iLYFoqoXrcAxvSWN6AklfWygg8NPFoj33bKuKdG4SaV33M+rT2frRFjNi8S/VFDhXBLSmncw6bFFT49Hxhc9mBxik/5kBZjvJLaNuSsHKshQG/2gmswFPQwd8X49VfEP7kyHZCGrBw+hLCjk4VYpg74V4NFwrt3UY2xKvVOzHWvqyRP3+niHW3YLpasf3Xxa8sxz/X9itXZnaxTNXP2h+Sqlm4ZxCqNtrm66XBjEE7tI0epltMpSlg==
Received: from SN7PR04CA0233.namprd04.prod.outlook.com (2603:10b6:806:127::28)
 by LV8PR12MB9419.namprd12.prod.outlook.com (2603:10b6:408:206::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 16:29:19 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:127:cafe::d7) by SN7PR04CA0233.outlook.office365.com
 (2603:10b6:806:127::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28 via Frontend
 Transport; Wed, 9 Aug 2023 16:29:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Wed, 9 Aug 2023 16:29:18 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 9 Aug 2023
 09:29:05 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 9 Aug 2023
 09:29:04 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Wed, 9 Aug
 2023 09:29:04 -0700
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     <markgross@kernel.org>, <vadimp@nvidia.com>, <hdegoede@redhat.com>,
        <linux-kernel@vger.kernel.org>
CC:     Asmaa Mnebhi <asmaa@nvidia.com>
Subject: [PATCH v2 2/2] mlxbf-bootctl: Support setting the ARM boot state to "OS up"
Date:   Wed, 9 Aug 2023 12:28:57 -0400
Message-ID: <20230809162857.21243-3-asmaa@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20230809162857.21243-1-asmaa@nvidia.com>
References: <20230809162857.21243-1-asmaa@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|LV8PR12MB9419:EE_
X-MS-Office365-Filtering-Correlation-Id: d756f3cd-71eb-4fc2-f7fa-08db98f5c7e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iaoUKUPB80c0O8RT1V45vkZMqf1dW3+vF9SbJ2ItocjHELgwTpeYISs2q+I4oscZ/kfLvniFZbO3qlzn5CanYS+SFZceKBNicnIt29yO6JYngvhUlZ3//vFD2ljPW/6pZ8bM2FP4xtidfV6xIpVw2TqCh5+c5+Kk3NLsIGFf+0PS07qXp4bdyX0PpRFUH+hhuRc2Wpak/Oi5DzaCs9ibLu4408j4F/iItEFsj016+Ke4dHmzuBhu7sj2TCz/VQKOIqELACzR5gdj9nKODpNaibl4XSTej3EN3tW4Vg2Hgn2L8zhjY+sKMlEtzFbIMIvRPGQsqrnRvEwNkHPlwtHiZjQWjxt6cJAliz/bIIcIKWWfFNP8YTJ8MgdDjkOYFMI3w6WroHMNzZ7fiVi8uUR1hAzSTlXdAvvmtBZ5lFytcQdt8pnNSE1beZ5kbTECFk54Y4BTqFkfmIDcwhbDFpQstck7YM4lZoFU21Rm7mEy+6tckZz658/+QYORPb1V8uMLg0D58NRRtDFVnEFW9W3GIQkWyKgESyZPDcj3E8B3N0Yboa6h89ZCJVIzEPMUfDc9aLRJUtjQZJG/rjTVAA8Q0HUTMBfQ8iOBO9lteb3JmoKe7yWN1uA/rcUO2RciQpVnGEHG0/q2+RVBNq8NXytuNS+va/H0RNfBVmjiBtWwq7QNv+IVnT30WBaN2V9541UKU5wri+Y4T5M2Euc3Dj52UP0GLmFkcBiD6RKUjSupFfLxUOw/jgEa49XXsuuvF1sV
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(136003)(346002)(186006)(1800799006)(451199021)(82310400008)(36840700001)(40470700004)(46966006)(70206006)(4326008)(2906002)(70586007)(36756003)(8676002)(8936002)(5660300002)(478600001)(86362001)(41300700001)(40460700003)(316002)(110136005)(36860700001)(40480700001)(7636003)(356005)(7696005)(82740400003)(6666004)(2616005)(1076003)(26005)(426003)(83380400001)(336012)(47076005)(107886003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 16:29:18.9903
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d756f3cd-71eb-4fc2-f7fa-08db98f5c7e9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9419
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BlueField has internal registers to store the ARM boot states.
Support setting the BlueField ARM boot state to "OS up".

Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>
Reviewed-by: Vadim Pasternak <vadimp@nvidia.com>
---
v1->v2:
- No changes made to this patch. It has already been approved.
  This is just to update [PATCH v2 1/2]

 drivers/platform/mellanox/mlxbf-bootctl.c | 25 +++++++++++++++++++++++
 drivers/platform/mellanox/mlxbf-bootctl.h |  5 +++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/platform/mellanox/mlxbf-bootctl.c b/drivers/platform/mellanox/mlxbf-bootctl.c
index 52d1272478a4..0bf29eee1e70 100644
--- a/drivers/platform/mellanox/mlxbf-bootctl.c
+++ b/drivers/platform/mellanox/mlxbf-bootctl.c
@@ -80,6 +80,7 @@ static const char * const mlxbf_rsh_log_level[] = {
 	"INFO", "WARN", "ERR", "ASSERT"};
 
 static DEFINE_MUTEX(icm_ops_lock);
+static DEFINE_MUTEX(os_up_lock);
 
 /* ARM SMC call which is atomic and no need for lock. */
 static int mlxbf_bootctl_smc(unsigned int smc_op, int smc_arg)
@@ -431,6 +432,28 @@ static ssize_t large_icm_store(struct device *dev,
 	return res.a0 ? -EPERM : count;
 }
 
+static ssize_t os_up_store(struct device *dev,
+			   struct device_attribute *attr,
+			   const char *buf, size_t count)
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
+	mutex_lock(&os_up_lock);
+	arm_smccc_smc(MLNX_HANDLE_OS_UP, 0, 0, 0, 0, 0, 0, 0, &res);
+	mutex_unlock(&os_up_lock);
+
+	return count;
+}
+
 static DEVICE_ATTR_RW(post_reset_wdog);
 static DEVICE_ATTR_RW(reset_action);
 static DEVICE_ATTR_RW(second_reset_action);
@@ -439,6 +462,7 @@ static DEVICE_ATTR_RO(secure_boot_fuse_state);
 static DEVICE_ATTR_WO(fw_reset);
 static DEVICE_ATTR_WO(rsh_log);
 static DEVICE_ATTR_RW(large_icm);
+static DEVICE_ATTR_WO(os_up);
 
 static struct attribute *mlxbf_bootctl_attrs[] = {
 	&dev_attr_post_reset_wdog.attr,
@@ -449,6 +473,7 @@ static struct attribute *mlxbf_bootctl_attrs[] = {
 	&dev_attr_fw_reset.attr,
 	&dev_attr_rsh_log.attr,
 	&dev_attr_large_icm.attr,
+	&dev_attr_os_up.attr,
 	NULL
 };
 
diff --git a/drivers/platform/mellanox/mlxbf-bootctl.h b/drivers/platform/mellanox/mlxbf-bootctl.h
index fc5019c90fc5..613963d448f2 100644
--- a/drivers/platform/mellanox/mlxbf-bootctl.h
+++ b/drivers/platform/mellanox/mlxbf-bootctl.h
@@ -90,6 +90,11 @@
 
 #define MAX_ICM_BUFFER_SIZE 10
 
+/*
+ * SMC function ID to set the ARM boot state to up
+ */
+#define MLNX_HANDLE_OS_UP    0x82000014
+
 /* SMC function IDs for SiP Service queries */
 #define MLXBF_BOOTCTL_SIP_SVC_CALL_COUNT	0x8200ff00
 #define MLXBF_BOOTCTL_SIP_SVC_UID		0x8200ff01
-- 
2.30.1

