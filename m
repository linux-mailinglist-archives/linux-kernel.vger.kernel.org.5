Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E73277F352
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 11:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349633AbjHQJbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 05:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349678AbjHQJbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 05:31:07 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF2F30DB;
        Thu, 17 Aug 2023 02:30:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z2mNPUu/HoK03VggcCXMtv6f7qeaENSTRX1BC42IymjZpeYShd8x6TnocGvthr5TfiVip2pevijsHMFOnn5DNl2jJoUMKq4MfOh+xYd5y+DP+nUL59iV+HFUd+pHtZPVTwZVY4JL6IzqAf9XBC4x18bSAe9gmP0v8WT6MEtDkHd7AxJ3Q80bnMLupgMBSUWkKMNQk6Dg6n3psf7BWOBTHwl0q5mL6dtnM8O6XWRRcIC6/eui1y4jcXb1FCSsvsPMcVJRay5BZlsJIlALoXRXjklZA1e8+dOCLPrF8aDg98s413wHQ+N8zVLod/IfWO3WvzT6V8N6IaqnGWLuantwxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bmq/tNP9GwJbqsckesJAvK54MFOZ5hmOOWJQfN105FI=;
 b=AJFR2uRZSTb2s4t0YNdJYKqTa0Udx+EERfn+EQm39iDmRadhhaqAhfACiznI5ZpKvwAQmRzG/m/fgNxJu9aHpHCOqdMDoZY9IdJVVXHvyUU11dRXjpROm8m1KLBHvH5Ad+sNeqcpJENVxaVvY6jJFfbHcEwL0kQrudU7NC4z9hDGxp1AlTeldclBobYxEoXX56eJ7AclJ0jd3jwCoJNo/ZnMqeQEO57j2/vBvSizrmfWjiltp56ehyjxBZzQNmgAMlQthZdT1Wh8Zp2tZciVNMADyeg0CjaJp5XGxz6tlJFngOZ1PXUwmKAS2OE3p8fxrmxQQw/Z2xG1aWC+k0TvPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bmq/tNP9GwJbqsckesJAvK54MFOZ5hmOOWJQfN105FI=;
 b=QoeJe0hRVORyMO18RVK03TmPMPX44Pscsdpk/f2tTSxiP6rR3AgZ0NmwmVF5pCvtMvmvoy4cqazJj7bEfQNKxFxGVBFtpuLELxbQX6AFP+AdLF/GnI7xdwlgCtZbHoQdVF02i84grCrYXk3D3rR6iHicvVU5/hSGXrtEJIZm1uaz7Kzpc7dJZ2d+oLuLMg6gpIsHgD7Ofs6i7HvZPeH4QJ1iQihjrZc27b03rXKRvxJ4RuV7LfShf8aehfO0qyfX2D88M/ylLvcus197hlYV/CNXY4bFj4WcrU8+NJ1I3CNLYwUkxeQF4CsViiCAY7uDibsKpZf81QNWG8SoJXbkig==
Received: from CY5PR15CA0105.namprd15.prod.outlook.com (2603:10b6:930:7::13)
 by CY8PR12MB7538.namprd12.prod.outlook.com (2603:10b6:930:95::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Thu, 17 Aug
 2023 09:30:49 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:930:7:cafe::bc) by CY5PR15CA0105.outlook.office365.com
 (2603:10b6:930:7::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.17 via Frontend
 Transport; Thu, 17 Aug 2023 09:30:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.14 via Frontend Transport; Thu, 17 Aug 2023 09:30:49 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 17 Aug 2023
 02:30:28 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 17 Aug
 2023 02:30:27 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 17 Aug 2023 02:30:24 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <rafael@kernel.org>, <rui.zhang@intel.com>, <lenb@kernel.org>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <sumitg@nvidia.com>, <sanjayc@nvidia.com>, <ksitaraman@nvidia.com>,
        <srikars@nvidia.com>, <jbrasen@nvidia.com>, <bbasu@nvidia.com>
Subject: [Patch 1/2] ACPI: thermal: Add Thermal fast Sampling Period (_TFP) support
Date:   Thu, 17 Aug 2023 15:00:10 +0530
Message-ID: <20230817093011.1378-2-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230817093011.1378-1-sumitg@nvidia.com>
References: <20230817093011.1378-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|CY8PR12MB7538:EE_
X-MS-Office365-Filtering-Correlation-Id: cab14598-b535-49eb-6561-08db9f04a4b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bXLq4MlL0OKHNr7DVj6wg0y7n3v7uDI1lCdaY6C/hFYwowl8JF9gS3iw46kjYH5Ql4yjd9Ltj9eIhOAq0v0QRUxbN+iTYVNTBEXX6OumQU+QBFkfCun8PeJw4Lrjnt7kCKg+7kfsjyfd9mCkNlT+X8Br9mQP75QqDHDFNxH/eSoOPd+kR/SG+Z1EOcK7UBGPHOn7xs9z5VfmA05u5Rza6xrLp5nTJRSUKIpMcwUzh2ibmBkhUV01XSEloqCkvwipS8eyNP+R33GE/4YqknCeBrG9Mwm+4/byfqFVmWFnbQKOPp0DUh/gBnqgcBysS3tIEAKG2XM5jXby6BIoU++bKrD3T5EpE3Ut9LJAq9VGx8jAhotGqWaeL2E/c0RJ90kMXXrsLBgAia/q5MY694uUK9C6Bk25Y98v4lLx1tXY4OGuldKUBTmcvI7o2/dCwE+ZpjqrBsOaTiqGlPQxdIjH35jvmN18WS5b9ehQgvPECLzOIfATf/oCoq2OCbdcxVEITHxwdiw2zWInS7775vgxze2lTC8Lo3qq0dLeqVfHqotpcjTZ7CUBLK5+yRXKZ+hubzj2wT149RwgBX13Zg3aa9Sl/LVlXxvn51KujR8C8qTFN86x6Dbi5oHcGPpxQLJePWHW+8njPHdtl+0vWOj+3BLLZ+7ILcCo4xHZQNlxdiHoPf/AqO3izJjjJrrlsZC4yklDIRNforrRiSufmdmsskYfQnch+U92Qef6XFIBvYZeaM8D70rdunv1/OYt5onH3LHEHb4h8kXX2WMy6x4TCQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(346002)(376002)(39860400002)(1800799009)(451199024)(186009)(82310400011)(46966006)(40470700004)(36840700001)(40460700003)(2906002)(83380400001)(26005)(86362001)(40480700001)(336012)(478600001)(426003)(36756003)(7696005)(107886003)(2616005)(6666004)(1076003)(5660300002)(36860700001)(41300700001)(54906003)(82740400003)(356005)(7636003)(316002)(70206006)(70586007)(110136005)(4326008)(8676002)(8936002)(47076005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 09:30:49.3934
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cab14598-b535-49eb-6561-08db9f04a4b4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7538
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Brasen <jbrasen@nvidia.com>

Add support for Thermal fast Sampling Period (_TFP) for Passive cooling.
As per UEFI spec, _TFP overrides the "Thermal Sampling Period (_TSP)"
if both are present in a Thermal zone.

Signed-off-by: Jeff Brasen <jbrasen@nvidia.com>
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/acpi/thermal.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index f9f6ebb08fdb..5dee3722509c 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -111,7 +111,7 @@ struct acpi_thermal_passive {
 	unsigned long temperature;
 	unsigned long tc1;
 	unsigned long tc2;
-	unsigned long tsp;
+	unsigned long sampling_period;
 	bool valid;
 };
 
@@ -289,11 +289,18 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 					tz->trips.passive.tc2 = tmp;
 
 				status = acpi_evaluate_integer(tz->device->handle,
-							       "_TSP", NULL, &tmp);
-				if (ACPI_FAILURE(status))
-					tz->trips.passive.valid = false;
-				else
-					tz->trips.passive.tsp = tmp;
+							       "_TFP", NULL, &tmp);
+				if (ACPI_FAILURE(status)) {
+					status = acpi_evaluate_integer(tz->device->handle,
+								       "_TSP", NULL, &tmp);
+					if (ACPI_FAILURE(status))
+						tz->trips.passive.valid = false;
+					else
+						tz->trips.passive.sampling_period = tmp * 100;
+
+				} else {
+					tz->trips.passive.sampling_period = tmp;
+				}
 			}
 		}
 	}
@@ -765,7 +772,7 @@ static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
 	if (tz->trips.passive.valid)
 		tz->thermal_zone = thermal_zone_device_register("acpitz", trips, 0, tz,
 								&acpi_thermal_zone_ops, NULL,
-								tz->trips.passive.tsp * 100,
+								tz->trips.passive.sampling_period,
 								tz->polling_frequency * 100);
 	else
 		tz->thermal_zone =
-- 
2.17.1

