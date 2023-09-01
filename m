Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C24478F821
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 07:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242403AbjIAFnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 01:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232649AbjIAFnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 01:43:39 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2047.outbound.protection.outlook.com [40.107.100.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9023E7F;
        Thu, 31 Aug 2023 22:43:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=enJ3Ax2VsG36YpB6r0HpPogCJ72L9VpYsAa0ETpkUEKVloQ63YgQrbRIEAn3aMQREa1AIew4vWVIB1wCWqCdrhSYUwbfyoQrL/msEWukzedCDb35rwWtfovJmHtvNrGlv+re3Zknj3PUVtKal7sghQXKEXGvKPA+yMRp8Juyw0OMV0hwEO5vbNw2303k4LtsR/TAHLcI8EVNLguDpg+CmrhTc/W2tKxPf8sUS+TFPQp8iqBMhMbqoDiTGPLchJoMLb2r9YGRFibWJ9YufItklcRae0qNxZsr76UujebatjM6CBc2fQiCrXD/V6O/au66BYTgkRS8G6xFkRKljUtFaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9lQvfTyNrE5YQT6gT4wPxAa2JAa90K6zol19BLBtNNg=;
 b=WnOk7BpCiq9QoXvO03EXAiQS9pMQM7gTCzmtfu9KqhNDK3V+iVYmGops590K4p6Q7D8M3vE3LTvQ109qPTDh3+pRoC40ld78PIgMLwoHZPB4RRAs7r6NeT4LeLOOUAT9sQoH5bhiLfzGMChLUbO70gG3LSwD/2XuhMqRWQk3udtJaFKye3TQt4tqoX38lpJV+8SgLyTu8KZHbQnyL4XZCEakVrTr9ZINAG3xWjNUJm4+W6n38wwy7iwdMABIVk4pNyraAJ/yR2J1WXTLSVuYCxPXM6vp/zReprRDCsVroHa+4LRAHJ5xYPwkIfc7Y7TJbWiHJRbPqeYyOPgUUSsmSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lQvfTyNrE5YQT6gT4wPxAa2JAa90K6zol19BLBtNNg=;
 b=QkFajoxXJDnfAXdqsWfJVuw+EyZkQQdG8toFe/GFbuhL9Bff23XZ6ZmTRo8wpi4LazBGSB2jO9P7LR3pq2a3vsg5t9CSQzB7af7CNLtbV/FKcNGeetbBEmKmMzSvHpdp3H/fCs4PFnrON7iZC3MUSFQEV7YGVRHWCZ558euWxLUsAxo8ZaI746XEJcC7lKcyaYy2Hq0LOOP3YKb3k45hph6lFvyaFw9TxuBY7u3t0k1Co/0Qhhk9RkbxiwI66j2vyqFeTBfz91o+xBY7CrX/swYcc9lctGV6gYJh9+I9Y5TrC6eInz430D5BWD8Uzpua1ViQUL17BWh8q2mm+CLXkg==
Received: from CY5PR22CA0074.namprd22.prod.outlook.com (2603:10b6:930:80::22)
 by SN7PR12MB8104.namprd12.prod.outlook.com (2603:10b6:806:35a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Fri, 1 Sep
 2023 05:43:34 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:930:80:cafe::4) by CY5PR22CA0074.outlook.office365.com
 (2603:10b6:930:80::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.25 via Frontend
 Transport; Fri, 1 Sep 2023 05:43:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.77) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.17 via Frontend Transport; Fri, 1 Sep 2023 05:43:33 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 31 Aug 2023
 22:43:20 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 31 Aug
 2023 22:43:19 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Thu, 31 Aug
 2023 22:43:18 -0700
From:   Shravan Kumar Ramani <shravankr@nvidia.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Vadim Pasternak <vadimp@nvidia.com>,
        David Thompson <davthompson@nvidia.com>
CC:     Shravan Kumar Ramani <shravankr@nvidia.com>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/3] platform/mellanox: mlxbf-pmc: Fix potential buffer overflows
Date:   Fri, 1 Sep 2023 01:43:06 -0400
Message-ID: <fd45a27ebc74c276f7d406d08018f5dd8bf6c667.1693545970.git.shravankr@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1693545970.git.shravankr@nvidia.com>
References: <cover.1693545970.git.shravankr@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|SN7PR12MB8104:EE_
X-MS-Office365-Filtering-Correlation-Id: 690155ef-61d1-4711-51f0-08dbaaae618c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jWmWgDIVMxEG95Ux9rSv8mu5tcecKnWGO8qLWBNvPeB+O1UoY+ckyECC7763MxFhT0yQfYwyfyMLDOQQXJA0qduZmhfrNWwhG9N7l7pYwl1ku86jwff23SGHFUqwFi8dWXAqLmernXXA41/W3X57fXKhg2A/8Bx4qjAczpNdbCNgGaLEOKbhqt2QbAfLT26sdLz+a8qJZNHM/8PstmQ+fZOCjQaqXgJHz+NAmc70hbtqRSDJmLTAlnhs0wnB0sR6iI9N8vVSsn9hUB5tcXhA1swXhYrK4m1S7O4mu0u4gq+gATRdZ3+KXdZ2aAPV3VfEo/A4oSjGqvMLpWKqALVECRM+auDKPFHhFCv6rOrgXs9e0ZFforlgyOy+DApOLhmp489emns98vhBCquTQ9I7seJwCeEUq4aiy9TdMw/WueoxUDRk2/jHh0sVuEcg5G3izeaJeTPYPejhDvnp58VZmOxXyw3Q3OLj2Ak4ZRF/wMkBzt3D83OUcILWYLBkvZcxpCnycq8bPJWQ1b/1oOa0hxErAzYH9QLl6z1xPcKaZZVmZPgmWTvVjC3rkDX/dlvyKtosXuephRDrrmfWTeQd3iPkhauOJfCzPb2XQtMFHf6gmnvM0CzpSmKLYfs+eP2Lzgn+w4nZTlHZBBBsp8kSJE2B3ni6/bIzIzqgpOqme44XkY6ZdFXBf8vNRH89TfHSPCrg9JgUtqalVNIfbwSgG9a2nzl+8GVhmxTeMdRsHjhkcJ7UYOxudhaU2IP1bcS8
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(376002)(346002)(39860400002)(186009)(82310400011)(1800799009)(451199024)(40470700004)(36840700001)(46966006)(41300700001)(336012)(7696005)(2616005)(7636003)(6666004)(82740400003)(478600001)(40460700003)(47076005)(356005)(86362001)(36860700001)(26005)(426003)(40480700001)(70206006)(70586007)(36756003)(110136005)(6636002)(54906003)(316002)(2906002)(5660300002)(83380400001)(4326008)(8676002)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 05:43:33.9580
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 690155ef-61d1-4711-51f0-08dbaaae618c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8104
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace sprintf with sysfs_emit where possible.
Size check in mlxbf_pmc_event_list_show should account for "\0".

Fixes: 1a218d312e65 ("platform/mellanox: mlxbf-pmc: Add Mellanox BlueField PMC driver")
Signed-off-by: Shravan Kumar Ramani <shravankr@nvidia.com>
Reviewed-by: Vadim Pasternak <vadimp@nvidia.com>
Reviewed-by: David Thompson <davthompson@nvidia.com>
---
 drivers/platform/mellanox/mlxbf-pmc.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/mellanox/mlxbf-pmc.c b/drivers/platform/mellanox/mlxbf-pmc.c
index be967d797c28..95afcae7b9fa 100644
--- a/drivers/platform/mellanox/mlxbf-pmc.c
+++ b/drivers/platform/mellanox/mlxbf-pmc.c
@@ -1008,7 +1008,7 @@ static ssize_t mlxbf_pmc_counter_show(struct device *dev,
 	} else
 		return -EINVAL;
 
-	return sprintf(buf, "0x%llx\n", value);
+	return sysfs_emit(buf, "0x%llx\n", value);
 }
 
 /* Store function for "counter" sysfs files */
@@ -1078,13 +1078,13 @@ static ssize_t mlxbf_pmc_event_show(struct device *dev,
 
 	err = mlxbf_pmc_read_event(blk_num, cnt_num, is_l3, &evt_num);
 	if (err)
-		return sprintf(buf, "No event being monitored\n");
+		return sysfs_emit(buf, "No event being monitored\n");
 
 	evt_name = mlxbf_pmc_get_event_name(pmc->block_name[blk_num], evt_num);
 	if (!evt_name)
 		return -EINVAL;
 
-	return sprintf(buf, "0x%llx: %s\n", evt_num, evt_name);
+	return sysfs_emit(buf, "0x%llx: %s\n", evt_num, evt_name);
 }
 
 /* Store function for "event" sysfs files */
@@ -1139,9 +1139,9 @@ static ssize_t mlxbf_pmc_event_list_show(struct device *dev,
 		return -EINVAL;
 
 	for (i = 0, buf[0] = '\0'; i < size; ++i) {
-		len += sprintf(e_info, "0x%x: %s\n", events[i].evt_num,
-			       events[i].evt_name);
-		if (len > PAGE_SIZE)
+		len += snprintf(e_info, sizeof(e_info), "0x%x: %s\n",
+				events[i].evt_num, events[i].evt_name);
+		if (len >= PAGE_SIZE)
 			break;
 		strcat(buf, e_info);
 		ret = len;
@@ -1168,7 +1168,7 @@ static ssize_t mlxbf_pmc_enable_show(struct device *dev,
 
 	value = FIELD_GET(MLXBF_PMC_L3C_PERF_CNT_CFG_EN, perfcnt_cfg);
 
-	return sprintf(buf, "%d\n", value);
+	return sysfs_emit(buf, "%d\n", value);
 }
 
 /* Store function for "enable" sysfs files - only for l3cache */
-- 
2.30.1

