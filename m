Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A61A78DE4C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 21:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239716AbjH3TAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243500AbjH3LM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 07:12:56 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C38CD2;
        Wed, 30 Aug 2023 04:12:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AtUTjHRkxaK0htLVZzhFzbT2orziuVzbupIkNIM2QgiegzDIZFkUfCTtWlp+2DOri00ee8GUi1JhQvjynKs3OI2rqI2EWLMC+vel6pN8HgeQ6Owdn/VHyRaCqR7cVeHaBvSXrzIFid1LRQiy0prUAt29F3/8l521PGi46cmfOg8jFfaE19S3lwfRbUiYP03OYkWdDgWsEaanLld/up9YkDjEaZafbrVk3DLuTNHfM1RTu2f9gW10PnqPp/ZHyu1bHPV5BI31ObOl1UNsjO2T5k4HRsX9kacQ4Y10mEorAV9w12m0Q7PiwpLgUn7R6Gxq0d61L48HW+0XDgisXTFf2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9lQvfTyNrE5YQT6gT4wPxAa2JAa90K6zol19BLBtNNg=;
 b=IVTzfd7jY43m7jeISQo9N7bTBKjm5gyyNIAxINJU39b+KEtLSgsFj2gDO8VoMYkSdQ2meX+7eleMErvSmZYKrtbXhWR2cEngriTrwv22s52ZTW1M16RLqILS52aemLcnV5nGR8kitZrKuwv7SIDhBuPOPMAiA8TTo8lavWGz8f02Qg6nXko7HTNwffPpQJngf3VXy+MsNRU19g6l4wxu/NgV0xEjFaAKmjkxkF1E0nQAVI3FHzGeyOAaTIJULoAxSxTuW3/rtA9Lz2hTka1PAARlHmrTEHD+LJxYfxkOnCMLdzSozoDcKcPkjCFYeYKpKl9974TZm2X6VynSZ9IVrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lQvfTyNrE5YQT6gT4wPxAa2JAa90K6zol19BLBtNNg=;
 b=hoKoDbSOgnq6PgX1atkZgDUy5Rd+GkwgUtm06HcfnfMrgeZYmyA1ShB8ih0+i8AKAkNteo/ZO9+Cx69ABnE3FFBSN7AW1eodi1DHAX1CrLUKrgI7koBmOAoM4xbBoW0MOZ/PyukFhGKQ0zhjQTt6JzvbcpwnOoK6uGgeIMsFZCsxkL7B2o2XM6D5H/ptVD03X4MtoESWj4yhJg2bqp1GjNVd2k2miiD1ThHPeWuTwj1JuoLR9rhowk1/SEIOhH27TP2tUcq635lCTdDuFGgN5jwPM61Mb9F34kh5rk0/zj2+sbThjvOIzNmDpV2oVk5XumQzXoHoCf/D2nsED0Z4mA==
Received: from MW2PR2101CA0004.namprd21.prod.outlook.com (2603:10b6:302:1::17)
 by MW3PR12MB4348.namprd12.prod.outlook.com (2603:10b6:303:5f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Wed, 30 Aug
 2023 11:12:51 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:302:1:cafe::e8) by MW2PR2101CA0004.outlook.office365.com
 (2603:10b6:302:1::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.9 via Frontend
 Transport; Wed, 30 Aug 2023 11:12:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.16 via Frontend Transport; Wed, 30 Aug 2023 11:12:51 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 30 Aug 2023
 04:12:40 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 30 Aug 2023 04:12:40 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Wed, 30 Aug 2023 04:12:39 -0700
From:   Shravan Kumar Ramani <shravankr@nvidia.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Vadim Pasternak <vadimp@nvidia.com>,
        David Thompson <davthompson@nvidia.com>
CC:     Shravan Kumar Ramani <shravankr@nvidia.com>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/3] platform/mellanox: mlxbf-pmc: Fix potential buffer overflows
Date:   Wed, 30 Aug 2023 07:12:32 -0400
Message-ID: <fd45a27ebc74c276f7d406d08018f5dd8bf6c667.1693393544.git.shravankr@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1693393544.git.shravankr@nvidia.com>
References: <cover.1693393544.git.shravankr@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|MW3PR12MB4348:EE_
X-MS-Office365-Filtering-Correlation-Id: 92dc49b4-e38d-4f37-0c68-08dba94a0d0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oEEMw/kg/dPd+cf0QTkzT5YcnjTqj/n6dhYtS3YnAzFTTpd8JJh+mLtwxdv2jfm15FTibOSy4o3KoYHKz92CAmN+WfEZKrkGGIDMixtAUFh7xOP0w6mLUz3JauTSHpGNgV1HeSJKHLeT0HBTBc0IbghAP1hOl6QPhOfy5qPzpt5fnRkklx6A8DPKeujWYsfrZNecAbKxmivu7/Km/Rf2Q+4469p4XJPbosDeOwwo83CTID0411QPgmd/skRlvFmLWOKL6CYeCXTGPgpYLxa8+t1vkkFYNkWk78uH1mJ9cXk/ymhSNXO/HD650FMWT0RtX12Y8IGedZCAQ5lCgAqT2wi9g6AbbDGPiIs1mG/c79S2BIGaJD8TuINY6aqd5j4j5eRvCJ8Aa8INsx39GHQq6BqzfgV8pDCWC3JQLwlOwu1dejNuNP4q2v42To77RVheNvzDXPTDZPHb2vnCR7rZ0OIJ8Zf3CHmuWMF92y1wC+hvMyYV9A1bw4w38tT99D5LjIa/CqkMLJSE6YKvDyGhKMZcJ6TPLl/aoTC3hFL0fteasf+o23x2o3GRUjuVvnM5G+ej9YallE5jJ1ZpcpkV+K2KZQ6kA3gt6VQilO8RfcjnsKEuNMyDJcuH/fak0gCxZJ5TK5T2x7J3vtpiTm5U/DjGbB9YXQ0PUwMEKSy/y9pohIdBD+zRxscGCuzUfH+WCtKqlgyTsmsP3U/yFKgcYU6O+WgyBlfIfAcNRLBIGcjj0lrlRl26xEPhYDW+ELzq
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(396003)(346002)(376002)(451199024)(1800799009)(186009)(82310400011)(40470700004)(36840700001)(46966006)(6666004)(40480700001)(7696005)(2616005)(26005)(40460700003)(5660300002)(4326008)(86362001)(2906002)(8676002)(110136005)(41300700001)(8936002)(36756003)(70206006)(70586007)(54906003)(316002)(6636002)(82740400003)(356005)(7636003)(478600001)(83380400001)(36860700001)(47076005)(336012)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 11:12:51.3974
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92dc49b4-e38d-4f37-0c68-08dba94a0d0e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4348
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
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

