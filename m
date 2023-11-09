Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC58F7E7195
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 19:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345015AbjKISeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 13:34:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345010AbjKISeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 13:34:03 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A2C30F9;
        Thu,  9 Nov 2023 10:34:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WBCzISGU+qrafONxdgyIQBWylq1aDz6hsE1ZY/3MBN6OlvfAv2LpCFP/Inmj8EDNxPifWW0yGY8sxL6SBa2FkxUXWm5odMKotDz0eL//na5IvuhmYrr2lRHxr4sdLDAGMOZnc0T3SaE+1F5ZyuXCtaRDvzKjE16ebmY3+UH0VoEoEEL9X3uaEy2qWbgCKWzmfKdTBJH7wuE2bfRL+y4uCHjAfk64p3FTWGFte1iXYOPBE/WOs4t3LdyNSmfwDpLnazp8PbsVsi7WXOg4br53B6QQH9T34EPDfwHyhdxqmpLQKMpimAS48i0TlIuB3y1xm17UORTaINjS3XSGHYFQ7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IDwRqy29fVI85yy0KxapTJAm7gvTNByirk678d44G6Q=;
 b=Crpqvb262W/0xxvfd36g7r2SXH8cJTZBPV+AfUQ6t0oTcT0fQgXIL9pvVhsUfm3aeXPnOjZ3TM2TfgTfB+UID5MC/BP4gERDSfKzHnq/3bb1YdrKtiXAZoKnb/QO/tXa64axl7FrbmgMyGHr/w32Zz8s5f60vymon1C87/1jpwobUsNCUsOAF9zRtS7rXKx/fFgYPQ1J7ZqBdtJmB5xhm8eXYZHgtwxKXY1qBVjxuXy89J9rFBO1Wc8V0pDVa+9kWTcZWAr9fY+I4/ISwJbb92h6g0O3aVFCSoaW2/bPxybKS6vICsAb60vMYoHzdv+m1Z/IgvImUiHeq9eHkGIEWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IDwRqy29fVI85yy0KxapTJAm7gvTNByirk678d44G6Q=;
 b=tz++Opm6tOtFVOHQjY9prK5jhlZcFKW3+K2RHEy9c/U7khDw36LYH1F2gc64tlPBmifbEqcnHO8YHHQagMQyBigP6/1AL3A10MVhE78oaW3Bk793tFo+riPvZUbNPXb8JR2mgegsnFAmC8nYuRjZcrVBlsoREKkMlp4o7TqYSQMhUnAo1U39CxwTVecMzKkmm4XZ8RDmWdTla1bBQBVlyTNESROG/hQomW62AKEy30muuUaw7BkL2CKWuJGbENJ+0xDsPCl1Qh7y4mVDkfI3sZmARlH82qKKC2KMFy08WXXMKZOTFPllvT5+fwwT9q/FG1PpQm6nTRqf1zcpQ2/91A==
Received: from BY5PR13CA0031.namprd13.prod.outlook.com (2603:10b6:a03:180::44)
 by SJ2PR12MB9209.namprd12.prod.outlook.com (2603:10b6:a03:558::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Thu, 9 Nov
 2023 18:33:58 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:a03:180:cafe::9a) by BY5PR13CA0031.outlook.office365.com
 (2603:10b6:a03:180::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19 via Frontend
 Transport; Thu, 9 Nov 2023 18:33:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.16 via Frontend Transport; Thu, 9 Nov 2023 18:33:57 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 9 Nov 2023
 10:33:39 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 9 Nov 2023
 10:33:38 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Thu, 9 Nov 2023 10:33:34 -0800
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <rafael@kernel.org>, <rui.zhang@intel.com>, <lenb@kernel.org>,
        <lpieralisi@kernel.org>, <guohanjun@huawei.com>,
        <sudeep.holla@arm.com>, <linux-acpi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <treding@nvidia.com>, <jonathanh@nvidia.com>, <bbasu@nvidia.com>,
        <sumitg@nvidia.com>, <sanjayc@nvidia.com>, <ksitaraman@nvidia.com>,
        <srikars@nvidia.com>, <jbrasen@nvidia.com>
Subject: [Patch v6 1/2] ACPI: thermal: Add Thermal fast Sampling Period (_TFP) support
Date:   Fri, 10 Nov 2023 00:03:21 +0530
Message-ID: <20231109183322.28039-2-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231109183322.28039-1-sumitg@nvidia.com>
References: <20231109183322.28039-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|SJ2PR12MB9209:EE_
X-MS-Office365-Filtering-Correlation-Id: 37e854d9-db12-4d28-bf2b-08dbe1526f45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gpMtmHYUnNGf57io0LT3YH/mXihVdu7vdOos8EoCvasfZf8xYve5QeHaFUYHlkXYksh08OUMXIzLzXB8qkXoa/2N5FrXXWrcYC6305EOnllzan008mPAfPE7hiA4XrmfiQqa3IFkvzsYwcxRy549iHTtABqpTaYeI2YROjljpAI2aw2zykg+utwxArttmYaQODfuWAygOEORLZkU+fO3Ryp8Gs3qwbl1NIuUHwSg04uMr5ge987ant08/Ol0VYF2lgjokk9g/c03c7o3NEKevN6tAoA8aJY1PVx2QBzmKHZBGSavZJhamLn9CH6vHYmjlLnUFS10UM465xICQEAVDvNEf4vNpYROjbHg9nAl6xJ4OQusWgERokdbd5DxT/2Ts8MWJLx4pAY940rP6oJyE5ZN9Ic8VtvK6jt9hP+y/8HDIBlM52VoOla7+84OYqFnn2lDMkhWqy6vn/88dhJkZbLDy+IylMBvAmUhKLPoYVj8+xH40fZRhNiU5z4iw30HZ9b7FWyhVqX5RoEuf1j+dymaq/h6DkdOOPki1KjzbIe7tW6aTDP/3q9L9pQjKwR5JMUMyPzt/qYaeGuhDGeuVL3hxZAppTeqtb0dbv34Z07mzMBmXNmqPKg7z6RbTvktobMz9FyLZAu9r2Yg0FGu5cn5dqSei7aO1k6SnaO0+l4I/fqJYWYBThZoKgoxINTg6Ief4Bjt0nR+m5haHE5P0Du3FTaT78fk5vXwuHJRP7hzo3yKLdOA6kwGFM9uku1p2SJ1r9RP0bDKKiOtnuRqIl9xCk6qEuWjYC7fP4tRby16g6Pmx1NC/PCat0flszX8
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(376002)(396003)(136003)(230922051799003)(82310400011)(186009)(1800799009)(451199024)(64100799003)(46966006)(36840700001)(40470700004)(7416002)(2906002)(2616005)(47076005)(41300700001)(426003)(54906003)(36860700001)(336012)(5660300002)(4326008)(8676002)(8936002)(86362001)(7636003)(82740400003)(356005)(1076003)(110136005)(107886003)(26005)(70206006)(70586007)(316002)(83380400001)(478600001)(36756003)(40480700001)(921008)(40460700003)(7696005)(6666004)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 18:33:57.2060
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37e854d9-db12-4d28-bf2b-08dbe1526f45
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9209
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
Co-developed-by: Sumit Gupta <sumitg@nvidia.com>
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/acpi/thermal.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index f74d81abdbfc..3b75eb2260d7 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -90,7 +90,7 @@ struct acpi_thermal_passive {
 	struct acpi_thermal_trip trip;
 	unsigned long tc1;
 	unsigned long tc2;
-	unsigned long tsp;
+	unsigned long delay;
 };
 
 struct acpi_thermal_active {
@@ -404,11 +404,17 @@ static bool passive_trip_params_init(struct acpi_thermal *tz)
 
 	tz->trips.passive.tc2 = tmp;
 
+	status = acpi_evaluate_integer(tz->device->handle, "_TFP", NULL, &tmp);
+	if (ACPI_SUCCESS(status)) {
+		tz->trips.passive.delay = tmp;
+		return true;
+	}
+
 	status = acpi_evaluate_integer(tz->device->handle, "_TSP", NULL, &tmp);
 	if (ACPI_FAILURE(status))
 		return false;
 
-	tz->trips.passive.tsp = tmp;
+	tz->trips.passive.delay = tmp * 100;
 
 	return true;
 }
@@ -904,7 +910,7 @@ static int acpi_thermal_add(struct acpi_device *device)
 
 	acpi_trip = &tz->trips.passive.trip;
 	if (acpi_thermal_trip_valid(acpi_trip)) {
-		passive_delay = tz->trips.passive.tsp * 100;
+		passive_delay = tz->trips.passive.delay;
 
 		trip->type = THERMAL_TRIP_PASSIVE;
 		trip->temperature = acpi_thermal_temp(tz, acpi_trip->temp_dk);
-- 
2.17.1

