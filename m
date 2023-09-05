Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB57792BA6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346041AbjIEQ4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354589AbjIEMtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 08:49:52 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A081A8;
        Tue,  5 Sep 2023 05:49:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ImqpnLqeJJM/1GkiZf5d+6n/Ec+cZ0TnEnvIDgsQUhz/OAICOGgvY4wrB2Qw8uszv3OGFw6bbrEWSKkdzDxLlVGX1D0rQ/oqJ1ITSCMMmREY8vsrqG2y+P2EQroERzku1zIMIUMPrNiCRbh06fd/6P1iSCs1YrBPGodCUzpyMqeG7ix91SiJZ5uZef2295TTOH/JiJrKm96SoUWi6uKwecsICh5YTtN0n9zVJXsGZtKEDCVdHLSKP6tlYtdhPQyFhNdUXcuROCznoJN3tOE+o+eROXLA+RRDg63K5QR6vuCweTDFPq3l0KEUV/fBKKboMezYZAIcy6IBp5oYdSUZkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9lQvfTyNrE5YQT6gT4wPxAa2JAa90K6zol19BLBtNNg=;
 b=VBJp4CaAIFVjM9J247juKDKEF5GJDmRAPtI9pd942Q5spaVLomlh5S41MxWRGhU0p9Hl6uhlMMAeSj9A2b28FT9XlSlhDYbVjYj2qLKZR3CP6lD37nQfstbTPIbYofX94Kdz86hUBj8ILmz9bi+6O3VJrnLG7y704ZZED7rkb9aH5tdlu7s4mfxXeHFYpQRJQfDEUOLONsAvtY/vu4N5FbwGywM5ruIuMSW8ciMXLJ6nL1ToEmLd6E3DdxUaXTLFOGhD4WhqnbYYiAzWKrxjSznrsPR8T4RM+tsYuh3l5SMUzGbkir7ICYiEeS+xLQybqgXh38yIvita6cHgzdFugw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lQvfTyNrE5YQT6gT4wPxAa2JAa90K6zol19BLBtNNg=;
 b=Il+IiXYi1Cmfmf28DdMn7sGOHiGjDPVnnvgQGsJ10XGC5rR21p3h0EReriJKvVdRGhF/5vf9hAu56mxbTIk+Glo8L55n/TWi0F9pNSPUrmFkeughHyt7ZfL3B8qzqX9a9Z4pt9lMCfECWwnJtfHk9P9BFp4f/RxcQ8SE/PoqrFWwoDa8IDQqO6oAJCEYXoHKWd72SzY29/IKpKeBe9iI2pf+Beck2KQ1hgal93mAIVF505XUAQBtr/vphsK0N++Bi3/+smqiwy3u7qH7AE7Xw002Fyue/JI4lsGfvA2z6q301NIjLCQKU8JHnWqmp8BgYy3UH1CLn+gt2WhCT7CfWQ==
Received: from DS7PR03CA0205.namprd03.prod.outlook.com (2603:10b6:5:3b6::30)
 by SA0PR12MB4445.namprd12.prod.outlook.com (2603:10b6:806:95::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 12:49:46 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:5:3b6:cafe::f5) by DS7PR03CA0205.outlook.office365.com
 (2603:10b6:5:3b6::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33 via Frontend
 Transport; Tue, 5 Sep 2023 12:49:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.25 via Frontend Transport; Tue, 5 Sep 2023 12:49:46 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 5 Sep 2023
 05:49:40 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 5 Sep 2023 05:49:40 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Tue, 5 Sep 2023 05:49:39 -0700
From:   Shravan Kumar Ramani <shravankr@nvidia.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Vadim Pasternak <vadimp@nvidia.com>,
        David Thompson <davthompson@nvidia.com>
CC:     Shravan Kumar Ramani <shravankr@nvidia.com>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 1/3] platform/mellanox: mlxbf-pmc: Fix potential buffer overflows
Date:   Tue, 5 Sep 2023 08:49:32 -0400
Message-ID: <bef39ef32319a31b32f999065911f61b0d3b17c3.1693917738.git.shravankr@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1693917738.git.shravankr@nvidia.com>
References: <cover.1693917738.git.shravankr@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|SA0PR12MB4445:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fb47f5c-263e-488b-4ba5-08dbae0e95be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0QcVV7hM+Eoppx6loLm7J1n+zAHMGIhrEZ6cmk5tQXc4D+NUI339BKCjuIj7NhWSS4/BOVRPuh1WBNdnQUxoQR6HD8Do2wA9RcrwwHFR6Ao5Ys99sU7DS1EvPLAadJy59DRVwGlCPSqC1nAeIMyEvjmcgprto9vTwx75g9wtUI0OXo8LRLAnDLPCZX0dhTzZU8l2t9qGC2JybmDvrCf3Oya1EZ/N/em1qeGTLXVZ9MxvSEqZ3HdHjdpGShMnL3ivWCC4mBNw/G3OvtIWmXd1pM8xL/ma31gA9aXcFeBlDfmhbkurSxB/gTaP2A6nuUr4oZ8R62aChihcnHp5kKT0JgIDe3XP++h0nDnc1x6tBSeEJISw/UqQ9xGhSakMXJ/hOhLrzJ/8AN7Ww24O+QFheT0ffXXIDPMbNR1dsuxQbd9OFiVz/4GCHcTfxKXsqMub0J/jdf7W0u5oOWw8szytECqJ87effwAkTIU6HqChESHl+O/Exzb5xhR38ypvYATA4De1YHBu+7EZU9tSpRdVnWY3vK7s0So144CoXT+K/LB7mj81LF9wmSry7+kQs9LriWyb80fV0FjGl9TK6Y4L3woOmqeELrv7Ng8tPsccsbMGLZQsLqfJtjmo23sUIcZK7QOlf0sqwUwEvb8URqQqZZzBdLyloImqcFCKTzseEIiVNjgbH4Qv+EsonqJkfy3w7nzns5VflsZaAhWm2+iN0dh9XNA/7WSq2Rg9a/qc7e6NzEAJnzCdNC3EKUD1wtX+
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(136003)(346002)(376002)(82310400011)(451199024)(1800799009)(186009)(36840700001)(40470700004)(46966006)(8676002)(316002)(110136005)(6636002)(54906003)(70206006)(4326008)(2616005)(70586007)(8936002)(82740400003)(40480700001)(356005)(7636003)(7696005)(41300700001)(336012)(26005)(5660300002)(426003)(6666004)(478600001)(2906002)(40460700003)(83380400001)(36860700001)(47076005)(86362001)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 12:49:46.7171
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fb47f5c-263e-488b-4ba5-08dbae0e95be
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4445
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

