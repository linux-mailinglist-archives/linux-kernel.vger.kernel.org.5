Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3344F79EF4E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 18:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbjIMQsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 12:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbjIMQsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 12:48:15 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7D426A2;
        Wed, 13 Sep 2023 09:47:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QvP3jMOKuZkle46fkqCRasM4DFQNSqfn8tylSfOyhdt8YCjb0qAc1bvM+AkNskAbBcNUJ7RHI+JTh37N1rVzL0M2AsKqhT1RkkiMin9sMuB3lCr1Nm723mEwGFfAnFZSjaDl7AuThNbt9lVc9Oxbt2wYOybF+JAZrdu1uUhvFUvWvmtkr+PrxEhtkpkRJ/BXB18DRCqGFmN771Qs+9ZdCJjDGd9KhRmKGRQnsIQ5rUe4Wdl8FF9k7anefVmnLgbwrzc6D3C2xcDR7T8asnlrIl00Xj1dFYRr5WN3JgF7VBg19quv3QpYdfsGHsIYJefKV+0ls+7zumymup+GehwbCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QxC+smxm1V5z5UrVmC55WExCHcCYQjpoqGTLn5tGql0=;
 b=WLYJW3/0+ZdqO6yVnd29W+gNHVjNeOfkZMd311WCPqj6Zg5gTl4c2xZ3+/qzeF0lijaLcK/6bYXG2ld1q6wGd4NTDf3SRINApmVO8Ui6mhflIwy+LOu+FGLTGMq9YIBTF8oSW2/9Cr+axMP+X42KccG4yV1JyYGkaLPsuXHYtKlwL7/UBQhZ25JkZAciPMVVSSE1eo78KZGtQ/L19r4XiedvR3HSSIlOQXyV0Um4oukd7DKJoe3G0JupdyMR9e95Ev6iE6T/CM3ARXxjSyOFRbG3McmjUR7/S3OsJyWk8c9359nRYFuqZdnTH3hRLGgfHrG9GVXxAn8uU+KRqQWjHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QxC+smxm1V5z5UrVmC55WExCHcCYQjpoqGTLn5tGql0=;
 b=SpZIrqtLsdnyMx9nJSjr6Zd7WuUmrMifb3ohQJ9teplFqRm1XZ59PgN1XEP6k310evSO1FgCi3dZRNU8qMgKzGuFpTf2hAebvKCJe78lh2OvhHa3s8cqI0TsoXvFGCOP140LaggXY2LvWpxehMedgJEiccSjKzJrGEh4fDU6sdCy6ZquIE4/kU4Tc4099I3Zp73vq6kJpYjhb/HlzJeLFSaxwOONV8/LGtTonfI9Hkl5S0QcSxhMpWqwLVwJ+kuu6CD6ir3mC9nCwt2fhQZH3Qm+nxim6gKyLYKZGN6yjRO1HJzbZg7iVIzPcED7l4t6p6MuIm+Kxkrsva84G1Sxxg==
Received: from BLAPR03CA0023.namprd03.prod.outlook.com (2603:10b6:208:32b::28)
 by PH7PR12MB7793.namprd12.prod.outlook.com (2603:10b6:510:270::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36; Wed, 13 Sep
 2023 16:47:27 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:208:32b:cafe::5) by BLAPR03CA0023.outlook.office365.com
 (2603:10b6:208:32b::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19 via Frontend
 Transport; Wed, 13 Sep 2023 16:47:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.20 via Frontend Transport; Wed, 13 Sep 2023 16:47:27 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 13 Sep 2023
 09:47:18 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 13 Sep 2023 09:47:18 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Wed, 13 Sep 2023 09:47:15 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <rafael@kernel.org>, <rui.zhang@intel.com>, <lenb@kernel.org>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
CC:     <sumitg@nvidia.com>, <sanjayc@nvidia.com>, <ksitaraman@nvidia.com>,
        <srikars@nvidia.com>, <jbrasen@nvidia.com>, <bbasu@nvidia.com>
Subject: [Patch v2 1/2] ACPI: thermal: Add Thermal fast Sampling Period (_TFP) support
Date:   Wed, 13 Sep 2023 22:16:58 +0530
Message-ID: <20230913164659.9345-2-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230913164659.9345-1-sumitg@nvidia.com>
References: <20230913164659.9345-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|PH7PR12MB7793:EE_
X-MS-Office365-Filtering-Correlation-Id: a3398da1-ee4f-45be-a3b0-08dbb4791ce5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JgMl9KCvvsym52RU66n30tVCBVAlmH8rIIh66maPvz5FS1PpagVA/uAQ5f7FPtg7cJfsZdxjc1U+Sk/wCHRz9kHnl+k6xUggKgfC/SNa64iAXCoI7wHjkS/Qz40iZVTcejuiTQyEGv4HEo10SGFrpiNZRGxHz8KqUWNhDZp/9knyLiqBhYmN9DTujCE5f29bfgMnhn6PfeiSc5d2MninkK5JSpRRUSPlYvJNiWXQyX1WKrAEWPmWZOHypIZuLMT8zH1Rm6OfbKIBP+NBOMu46cQOSG4FPERKSxrXSA2IWOzKnZ1E1shrekjTEjg7rn4hXp5QVUr5psRhsmSzvVncDYx3rzVfrj0HEME55zZO9dEwYBkMuTT9YxroLNEGczOFZg/ssnXtvlD7XjUJQf4erDjM94/juq6r1X+KDkESo0lqhaGdspj+DEevjkSyBWbATM43ew9qtW4suKtY5nfjX3rHwMDOTSqo3XeKkGtBlsL/6RJqwhCEYEKJ/CwD1HM4vZ+jZ7boNpKdczzhGyUq+qJdSX7YJoscv9mF27oA122HEnWnT+KiW4l7iB+MHSQ2eBPvSHXZxgHEf6LSNx7RDjJPX70s3qt1P1+uPWvJvqP4PGW+xSSIbsL4fyPuY8cxYlUB9SngmNGlOL4PPlsTLif0fe42bV9XrEAUTr3vGa8du5BbSYFleGJdQmeD5pGKOMVXqaCQIMoMbIJdg6bKystGca7STuA6BIWI7DT3MOlg8EaAMYhRT/fpwMTPD2ssNRwggRRaW4J13TVS6OtUtQ==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(346002)(396003)(39860400002)(186009)(1800799009)(451199024)(82310400011)(36840700001)(46966006)(40470700004)(40460700003)(36860700001)(2906002)(47076005)(36756003)(86362001)(356005)(7636003)(82740400003)(40480700001)(8936002)(8676002)(4326008)(1076003)(2616005)(5660300002)(26005)(70206006)(7696005)(70586007)(107886003)(54906003)(110136005)(316002)(41300700001)(6666004)(336012)(426003)(478600001)(83380400001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 16:47:27.0036
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3398da1-ee4f-45be-a3b0-08dbb4791ce5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7793
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Brasen <jbrasen@nvidia.com>

Add support of "Thermal fast Sampling Period (_TFP)" for Passive cooling.
As per [1], _TFP overrides the "Thermal Sampling Period (_TSP)" if both
are present in a Thermal zone.

[1] ACPI Specification 6.4 - section 11.4.17. _TFP (Thermal fast Sampling
    Period)"

Signed-off-by: Jeff Brasen <jbrasen@nvidia.com>
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/acpi/thermal.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index f14e68266ccd..d0bbf42cae9c 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -102,7 +102,7 @@ struct acpi_thermal_passive {
 	struct acpi_handle_list devices;
 	unsigned long tc1;
 	unsigned long tc2;
-	unsigned long tsp;
+	unsigned long passive_delay;
 };
 
 struct acpi_thermal_active {
@@ -287,11 +287,17 @@ static void __acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 					tz->trips.passive.tc2 = tmp;
 
 				status = acpi_evaluate_integer(tz->device->handle,
-							       "_TSP", NULL, &tmp);
-				if (ACPI_FAILURE(status))
-					tz->trips.passive.trip.valid = false;
-				else
-					tz->trips.passive.tsp = tmp;
+							       "_TFP", NULL, &tmp);
+				if (ACPI_FAILURE(status)) {
+					status = acpi_evaluate_integer(tz->device->handle,
+								       "_TSP", NULL, &tmp);
+					if (ACPI_FAILURE(status))
+						tz->trips.passive.trip.valid = false;
+					else
+						tz->trips.passive.passive_delay = tmp * 100;
+				} else {
+					tz->trips.passive.passive_delay = tmp;
+				}
 			}
 		}
 	}
@@ -683,7 +689,6 @@ static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
 {
 	struct acpi_thermal_trip *acpi_trip;
 	struct thermal_trip *trip;
-	int passive_delay = 0;
 	int trip_count = 0;
 	int result;
 	int i;
@@ -694,10 +699,8 @@ static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
 	if (tz->trips.hot.valid)
 		trip_count++;
 
-	if (tz->trips.passive.trip.valid) {
+	if (tz->trips.passive.trip.valid)
 		trip_count++;
-		passive_delay = tz->trips.passive.tsp * 100;
-	}
 
 	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE && tz->trips.active[i].trip.valid; i++)
 		trip_count++;
@@ -746,7 +749,7 @@ static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
 								   0, tz,
 								   &acpi_thermal_zone_ops,
 								   NULL,
-								   passive_delay,
+								   tz->trips.passive.passive_delay,
 								   tz->polling_frequency * 100);
 	if (IS_ERR(tz->thermal_zone)) {
 		result = PTR_ERR(tz->thermal_zone);
-- 
2.17.1

