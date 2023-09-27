Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63467B0924
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 17:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbjI0PrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 11:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232552AbjI0PqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:46:17 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5A2272B1;
        Wed, 27 Sep 2023 08:46:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JAl8lRZKWB37NL7hXQCGmX05+TVHtWBfKg/Jh8fukS6NwjC3ytxtfRcRwMMHaLpcwrHxDtkcSbAZU7B50cVBjobcVeJuIC3LLig9+UEWNySfrNbXj0ZIZ8aY+19zrtw8ONi69XHLmiykCmkx4UI4Qbt0ZpVARdo8FOkuQjvF1LfYadEr0MywRJKsu7B25slEUMdr9pkB2YG7LczzBn44uO/2vGWGnXwk7gy9JzQ63cR6cMBWZSho4BZkHIFkIVM5WT2719iNfbGy2VNyL5NMfvPBGdOcEGB+JXOreF06QK6ML8mTrvQtlK/eCKmj+YQrrYZuXGNfbATcwC8vcN5q8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QLa9xgRNurnnIuhIueAEq74713oYm8x7wG5kPBzwQio=;
 b=ofA+Ew2yvWGu/e96ReTBdrBy9lMb/TaMUYi2cPLEgr6qvJZuvh1qQYtf9hme/Rc/A6f0KdKrudvNuLGvO/l3Eh8PolmZAhedb2Ba0yF4fUkqp7IO/Md+XfDjP83rHpJg0EARWQ5e6v2OmDnBSYXORV5Rj5usF4WICfc3LPHLmENCWLs5sMI0cepU4wDlXZ6eg+tCrcOsVjpSzK7AMB6TAvDXb3D7GvNeMS0DtdUKtxr2un0kc3p/6dTRJ+NZWnV7kmho4XrE3nwACMwY3yo8GP++Y98oQHK9p4ekcCUKGzh6JStsfwpJA4M1lV0oxqHxQBwn8fn8NKkH9qMQaPMM6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLa9xgRNurnnIuhIueAEq74713oYm8x7wG5kPBzwQio=;
 b=NLosLyL4vG6gMpBM4XsGw/2crtw7JiXsFdl3xCjnyebzpJ/7+YXBScKun/r/FTag1DsULl9m36eTT5+VgwVmbxZew4faTKnI6BKysdR9SMLgGe5XJbzygQale/eTu1QXe7Ga281g4uB+ZvkLm/hFSnNZ+Bzzz89MYb9QXPCUZWM=
Received: from BL0PR0102CA0038.prod.exchangelabs.com (2603:10b6:208:25::15) by
 DM4PR12MB6160.namprd12.prod.outlook.com (2603:10b6:8:a7::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.23; Wed, 27 Sep 2023 15:46:12 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:25:cafe::91) by BL0PR0102CA0038.outlook.office365.com
 (2603:10b6:208:25::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Wed, 27 Sep 2023 15:46:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 27 Sep 2023 15:46:12 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 10:46:09 -0500
From:   Robert Richter <rrichter@amd.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Terry Bowman <terry.bowman@amd.com>,
        Robert Richter <rrichter@amd.com>
Subject: [PATCH v11 04/20] cxl/port: Rename @comp_map to @reg_map in struct cxl_register_map
Date:   Wed, 27 Sep 2023 17:43:23 +0200
Message-ID: <20230927154339.1600738-5-rrichter@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230927154339.1600738-1-rrichter@amd.com>
References: <20230927154339.1600738-1-rrichter@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|DM4PR12MB6160:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c4072f6-0d70-4e73-df87-08dbbf70e098
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NFJ3UdSks4+uEdb9aHvSFI1g07/cHxPEUIU9RNVacfDG18X+LwIrtf9IAM3zZohWCpsl/Xs/tL1IxeeEfgfYhaXl5Byz5exT6Rx1zmthCLsoazc7eOlTzD42Sl1Ucmc7TkwqwTbUtBzMWll9qm38wmgQDnWAqeqhlKzNoh4I8oqo7gLp77N81esnghoG6MGLfDGuwVQKo+96XUAAlMGnrVZa0D+600kGwZg5Imq+Pqg+Ymxnnp9naQStI396+7WZLUGLAlpxKsegrjk8PypLHN2spSlDhvTfDU8q9x9OWGu3xrYOffLuugI97z+doJxEoKNGT07DoEAbMD6uhqXBGxEtc0xKjJ3rw/9T6bjw/OvlaxbpdtWSjrCuI41LvfRC2Zw6tT13ZUprShuS4cnv0ZO2wyEaTc3BMpKdA029Gao4NgmM8b7yAS0a8v3tEoipo30/1a5/6V3WLo+Os8TZWx0NK0c7Yp3hnKZpCs+KQr3i+dkVD3fXb7uPL3QB/6+/RAgo8dY6/ta9LyEZqFkeWeR3inokUEJkb0wWxfosjcRxLwiD4F3whqinerQctt/qsRDRRGbGr5r2qd84cs8gCq9IxgN7L+pXS9jhvMpJ8IWopExmXU5VCN6cv0+FPFQHinRLYx5j1xh8RFfMNczZH7pRdTrQLJW/+KpsHG1m4habOHyrz0wnxEb8O1bUe6oVKjBbbwAAISa1ICGiY3zZ9lTccD97ia1ix6aSwYTQqLD8/2cJIXmPJB7ixmjtuVhKMwK6JCO0lZH3Il/7WvuMAQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(396003)(346002)(376002)(230922051799003)(82310400011)(186009)(1800799009)(451199024)(40470700004)(46966006)(36840700001)(2906002)(40460700003)(2616005)(40480700001)(6666004)(478600001)(36756003)(70586007)(4326008)(8936002)(82740400003)(47076005)(36860700001)(41300700001)(83380400001)(81166007)(5660300002)(356005)(54906003)(16526019)(1076003)(316002)(26005)(336012)(426003)(8676002)(70206006)(110136005)(7416002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 15:46:12.7945
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c4072f6-0d70-4e73-df87-08dbbf70e098
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6160
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Name the field @reg_map, because @reg_map->host will be used for
mapping operations beyond component registers (i.e. AER registers).
This is valid for all occurrences of @comp_map. Change them all.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/port.c | 2 +-
 drivers/cxl/cxl.h       | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 99df86d72dbc..b993dea61436 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -712,7 +712,7 @@ static int cxl_port_setup_regs(struct cxl_port *port,
 {
 	if (dev_is_platform(port->uport_dev))
 		return 0;
-	return cxl_setup_comp_regs(&port->dev, &port->comp_map,
+	return cxl_setup_comp_regs(&port->dev, &port->reg_map,
 				   component_reg_phys);
 }
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 68abf9944383..3a51b58a66d0 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -572,7 +572,7 @@ struct cxl_dax_region {
  * @regions: cxl_region_ref instances, regions mapped by this port
  * @parent_dport: dport that points to this port in the parent
  * @decoder_ida: allocator for decoder ids
- * @comp_map: component register capability mappings
+ * @reg_map: component and ras register mapping parameters
  * @nr_dports: number of entries in @dports
  * @hdm_end: track last allocated HDM decoder instance for allocation ordering
  * @commit_end: cursor to track highest committed decoder for commit ordering
@@ -592,7 +592,7 @@ struct cxl_port {
 	struct xarray regions;
 	struct cxl_dport *parent_dport;
 	struct ida decoder_ida;
-	struct cxl_register_map comp_map;
+	struct cxl_register_map reg_map;
 	int nr_dports;
 	int hdm_end;
 	int commit_end;
-- 
2.30.2

