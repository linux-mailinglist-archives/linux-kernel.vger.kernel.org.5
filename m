Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4731B78EB5C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 13:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345317AbjHaLGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 07:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjHaLGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 07:06:33 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2B7CE4;
        Thu, 31 Aug 2023 04:06:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Trn2OPIpV68ovq8uU0pMgzQpIJahoq4742bWURM8kLhrb+Hl4v2K5TGQq4qHdcZyS+XZ5rgYGGR4SIo8rLAfQSuYzmgxFlQIdIy7W3Y/wLiwhqw6dxi9xKNK+YJ3g7GilI6J6bas5EzeuXgm0fQtAM2NQArvdX3oyK3Q5D9AQ/1vbOUNaISFYMWTKtTfeLWBisXwtlBm1wKW5wr6+JFVT7V05kBZjXA82/GjNK7UX6PCqmLdfAs0lL2ZECLZwoQGbUMwk3YPCge0lk9fOppemnwQ9a+XjUpThqWi3sInDeiezbo94x6VqXlAgbtUNu3weJBpQn77yVplWmhkRsIT4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9lQvfTyNrE5YQT6gT4wPxAa2JAa90K6zol19BLBtNNg=;
 b=fmhxRExl/AWu6kgogqid7Nz8yu3iabYg5PnQRYr5bL1cBZdNfqbTSyE451V308Y/Agu5zeHSIhY0ne7KsetY/OHtcupPPiYWW/1+qB7B+lTsHEpLG6lDftX4HKyhDASPqYYJRvA8HgN3Eabu3XGpesgLqw6qhThDmEv6alHLX6Tk97rffbU4JzCwpPrIBluVurKdBtdmCOJRL5bfe8qoaS63ZvsnO4vG288nYWW0CuL/h6YgCGyzg3slySE/8kkdbcSILHT28Ee6RFeHkGOp//mQ/fY140TvmyZaGZUviB+VM+PYrILZzziPL+TTy+V29bylAmO/fyQlUDiI6fxcLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lQvfTyNrE5YQT6gT4wPxAa2JAa90K6zol19BLBtNNg=;
 b=aJ401i1MsL1EI90Oivpe1gidjAg7TMqKtXDFSG1wlkXsznKxTHtQufIke6p0cvgXMgUXRnS1gL+wRd5NS6jErrJ9S1KhSqkQMOybDGR/2MmPUnN1hcfXRTBdDwMG4G0CSwImbc1sBvnteoNVN/+GYQnmECa3nWQCQKCc/2QRweYc/u7oB0ytvtFewbBQXKZNe3tzZ4swWkUUewu6Xp3xa9q+frch8QMwh2+0GTnUdX0wxQ+GkYOyQ6Eze2lO++ClOQfekFV4O9MisXln500OJah9W5v4rb2AeFyZsuHs//1MV3lCnSzy7eSu1iQWVYGBYeuvpsmCPE8mvjezACXLZA==
Received: from CYXPR02CA0077.namprd02.prod.outlook.com (2603:10b6:930:ce::25)
 by SN7PR12MB8770.namprd12.prod.outlook.com (2603:10b6:806:34b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Thu, 31 Aug
 2023 11:06:28 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com (2603:10b6:930:ce::4)
 by CYXPR02CA0077.outlook.office365.com (2603:10b6:930:ce::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.22 via Frontend Transport; Thu, 31 Aug 2023 11:06:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.17 via Frontend Transport; Thu, 31 Aug 2023 11:06:28 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 31 Aug 2023
 04:06:25 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 31 Aug 2023 04:06:25 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 31 Aug 2023 04:06:24 -0700
From:   Shravan Kumar Ramani <shravankr@nvidia.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Vadim Pasternak <vadimp@nvidia.com>,
        David Thompson <davthompson@nvidia.com>
CC:     Shravan Kumar Ramani <shravankr@nvidia.com>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/3] platform/mellanox: mlxbf-pmc: Fix potential buffer overflows
Date:   Thu, 31 Aug 2023 07:06:17 -0400
Message-ID: <fd45a27ebc74c276f7d406d08018f5dd8bf6c667.1693479119.git.shravankr@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1693479119.git.shravankr@nvidia.com>
References: <cover.1693479119.git.shravankr@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|SN7PR12MB8770:EE_
X-MS-Office365-Filtering-Correlation-Id: 73430978-8056-4388-b865-08dbaa12532b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ymO9WG7CBt9TlUzt5mn61cfbo0vbVNJII+ewKUKj32/3AlBixZyQtgvVVTVvgwA4QsHV1331R+CSMOj40ikQtJNPe8LQgOtTSbozUKpwPFZvjFvpDUijis5MroGnsa33WpodiDrihxCVkVDOvmY4xMxJKsAS+AbV16gQyWdlFCg2dvKI8Zq9/gTIUMF78fjtxerMSWu5l2G4wU/m9pYf7923RMxVJuT88RQQehlmnwjE1WHWJXlBjOoxov2LPb8wSh7L8eao9ghNX1CjWau/FN12wkEEMO7C2TxW9RCkBPZZyy8gBoQ3SJbcBM3e2rwKQQv3gn9OuQIx/oSWwV5u7EksMJ0U31C1pbp2qtByR71RBdrhhkZ5pDsQ6ZrtB52TjpEcFQgdYDvEk3h1dTxWsBr5rMc5NO5bW72Ys6hMFS7BLFYAlxNX+9h1Pv+IxTvg0vq4F63PsL5Kkv4dBvhz4JTdaPsUFOv5Hb7Y621gtP/8Xd+0tHQkWnGDj6EVrZp1bTsd6uFL65fmkQRci8TsmzVckDZHAKvDnqqX/yqXFyx9PXnl1VUJ/L6X5hBHNhDZwk8BdoGPBz96RV7yC5xIjCCFk5V0ZDBEvTwI0j7858hnABkpusqVULN72CoWyuvoc2AaPAaZEp0XKXrnDCxpZrcCsntW6O6qT7qQcdQ8s0XO+LYJv5BrWG0ZfdJFMPAJVNxK+5E+gOxpVhJkKElrUSHVSjWSvZONIKNMZyAULiRacKLYVhlZAOE5UD/KQneh
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(136003)(396003)(346002)(1800799009)(186009)(451199024)(82310400011)(40470700004)(36840700001)(46966006)(40480700001)(40460700003)(70206006)(6636002)(54906003)(316002)(70586007)(110136005)(7636003)(478600001)(82740400003)(356005)(2906002)(41300700001)(5660300002)(86362001)(8936002)(8676002)(36860700001)(4326008)(83380400001)(47076005)(26005)(6666004)(426003)(7696005)(336012)(36756003)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 11:06:28.3627
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73430978-8056-4388-b865-08dbaa12532b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8770
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

