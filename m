Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F60776230
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 16:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbjHIOQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 10:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbjHIOQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 10:16:04 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8801FDE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 07:16:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NAcTeT4a6qQrEXsKDcO/+2XMiJyklQgh67G3QFc2CSy5X+sfnZFRWOGzsV5OwcCVwI5GrLNV9CKhtnA7DQwKBLqtMgF1Qaxrp/guNgzn/hnl/rMxB75GTe/cKW7MiMLdGjKuu5nmT8f04nIdexr79AyzwusNw8Qn4XbNUUZ57TSZ7TFJ2XrfxRQhkVpHMrID9u2QewDtp/bbV0YHkDVHhmuev+G/VHS/NG6TE0CLtP7Nxi3x1GUulVp4QRNI0tGOoSU8UBY+jroYGanVrRNTU10CbBNwAD6XMOHvULUvFacVEz7VLUkmKQFlPDZi2HcNqmiEtHTnH/oYK7XJapAV/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z4MmuNLFPri2fvivAeMRtnGy/HT2rKReSxZ3t+ITmpk=;
 b=oBLUGP6bSMNqoLKPmXhoUILMPqFYZDi3sZOAghNu94/j6r4GgcK0f9BeQ0xnXyeC7V0JbRfkBeuMtsNuzgDLQRYxwu6DYfVYUO1yQjN903ZVGgoAphni5EDvzkF76d6RPe/KEuRIlsOiRF+N6elBNNtplfIPNwWOmZFztpBq1LhjVovPgaEN0tz5AY4psPSbHxnDfIfsVfGwMU1qA/okueBVhmSgdB+uQSlU90YAEAj7V3bsk3Cbz1fNvllZ8gQAf1vpGny4aLG/pISR0xoxmolspAv+L0IQm11o3/VBGvejlCJkKVMx/AT/MW53vf0L6xfs4iqNi4OKhOLi/5q8kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4MmuNLFPri2fvivAeMRtnGy/HT2rKReSxZ3t+ITmpk=;
 b=t0rtV5JlraYYliXmMxkmX3C5iDsy+LU2Ok37tbnXjE/qzHFZVdNiHid+Js5QBVKNbrPHIcN0rdJGAWSEvFPRKaDXLQ94vEn3taaKWBGTP7CCN9+Hq2ggRVYGMIq6sYLTIlEeKAj+snoDazdKUaTaY+RNUxWUJ0mpUL2yijkzjG26O3x+6OMqfqa4q5BKyzSg7fS8w+5X6rArPLTx5zpqNgpbVBT4Dss8zN+MxRQk84YgwD+ERbUANxrM7yTfr6ls4p8VgMYBXPwJW/1RWVuKps3cj1Stlb/ZQpWph7BZMhU3VHQxJcgWtPrgaNnnLu8X6zYbwLdL3t5vzsd6cMNnTQ==
Received: from MW4PR04CA0130.namprd04.prod.outlook.com (2603:10b6:303:84::15)
 by DM4PR12MB6207.namprd12.prod.outlook.com (2603:10b6:8:a6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 14:16:02 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:303:84:cafe::b0) by MW4PR04CA0130.outlook.office365.com
 (2603:10b6:303:84::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28 via Frontend
 Transport; Wed, 9 Aug 2023 14:16:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.0 via Frontend Transport; Wed, 9 Aug 2023 14:16:01 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 9 Aug 2023
 07:15:21 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 9 Aug 2023 07:15:21 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Wed, 9 Aug 2023 07:15:20 -0700
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     <markgross@kernel.org>, <vadimp@nvidia.com>, <hdegoede@redhat.com>,
        <linux-kernel@vger.kernel.org>
CC:     Asmaa Mnebhi <asmaa@nvidia.com>
Subject: [PATCH v1 2/2] mlxbf-bootctl: Support setting the ARM boot state to "OS up"
Date:   Wed, 9 Aug 2023 10:15:13 -0400
Message-ID: <20230809141513.9058-3-asmaa@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20230809141513.9058-1-asmaa@nvidia.com>
References: <20230809141513.9058-1-asmaa@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|DM4PR12MB6207:EE_
X-MS-Office365-Filtering-Correlation-Id: 867f9170-7c00-48dc-07e7-08db98e32936
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yIdLP7eJYRQTiL0UzDUdv5UU+wwqR1m9QfCsVSEpyfiP8vCJOHeScwsa47QQtzWhEDdmwxXXJpLZZJb3aDUho20KGL6GcCwwrcFd1s3fF8PSImcqsGhIussaJRxpHwoyLBvp0vWibIbzQu/Yww52x+k/wM4Fnuz/pj0sMPVZ500SrefZnSp/3u2vE4J3f1aGFN42jLTUllfP/WvZU4uukyoMFVdatuTnL9cxJD0NhPf/mrCDtOpoKNlhG3VsFHBz01ydV+ZrgN2REWHxxyaHK3DCA/40zNU8SDsrg58WjU74ffNm1BZxYiqWri44XxKIKLum8d+1FnHGPkTTOHDA/jyQxpFROMR8De7uDdz755lHV2UhdlRSklXEq8PjyGsIOiDgf3JyGZbJ6MMXfOcsEkd04zqhh7611PxVzCpIdDv1UdiFm+IvXZgAOv5VVxxy9KjHmb6EccOdKB5WzyXAs7rdm8V+5RAkUHycsoQAVzfUzEjhzwIUKkjkX4epPrUy2U5cKg/YuOH8JDhWfiM49ARfG0s5dTQcal0CqxzZXnAblH3wKzcCm2CKkpwsu/jNOxXbWTLNdgT5CkMoDNpi2iPT8aXTNWFR5hKQFZcPJFNVPM1OIyNGokO1EFoUiqSwuzfNpwcQsbs6UUp7SbiAFD+w53OhsYFg046ePZGHxnMi2BC5FvEx9zN+DMcJcdEwl1j0a7/FO6PzADgxk1O0refgvw/qDcoItT8sNcbyyEgWksi4A5JgCOA6Ip8/gpDO
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(346002)(376002)(1800799006)(82310400008)(451199021)(186006)(36840700001)(46966006)(40470700004)(426003)(8936002)(8676002)(5660300002)(4326008)(316002)(41300700001)(47076005)(86362001)(83380400001)(40480700001)(40460700003)(2906002)(36860700001)(107886003)(6666004)(7696005)(2616005)(1076003)(26005)(36756003)(336012)(70206006)(70586007)(7636003)(356005)(478600001)(110136005)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 14:16:01.8055
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 867f9170-7c00-48dc-07e7-08db98e32936
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6207
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BlueField has internal registers to store the ARM boot states.
Support setting the BlueField ARM boot state to "OS up".

Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>
---
 drivers/platform/mellanox/mlxbf-bootctl.c | 25 +++++++++++++++++++++++
 drivers/platform/mellanox/mlxbf-bootctl.h |  5 +++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/platform/mellanox/mlxbf-bootctl.c b/drivers/platform/mellanox/mlxbf-bootctl.c
index 3ea11250b681..7a67fcc6dd98 100644
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
index 75d59ade92be..19142cc71312 100644
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

