Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F3A7C9442
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 12:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbjJNKy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 06:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbjJNKyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 06:54:54 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CFAEB3;
        Sat, 14 Oct 2023 03:54:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XeTfubWcsOFUUWzWLfE5WSIZ4oP6cRVABXchTpHBYTWfeXofNJXPknodLeGS6IRFqD7MYTYJga4E7J04UnVd4/enCzmMts6qy0KbYkJz+kgQwds7LFxEDg47wj4IF+qDMjc0ka0nJ3JaWE+1tUTJfh+rqYwHp6PcjGz6stp0Kwp/qXJoeAKyHuJF4MD4dw3zzN3nYBvg1fY5t0X7Nued3QTl3pb16gowxa6k8KMocU+l8ZnwlZ18kMlTDIYlgyEsp83vbmhsDlmVsU0eOgQAuIOof/S7d/UDSu0/U16Lzmo4M3AUccYar1169UbZAEXf6HQt1SQ8a8r/Xqgi5xr0AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QvEksMKl0Gi/3IwFUWbN9irRkwwS3xTAwpqnAarGMXo=;
 b=HKhpI4QWb8F93+p24Gndk+4pZPbtJ5JZVYzdy7fmUc/BUziqDs1RzHc3pSeFK7acqvMhGqyJkfPteh2mwZYOUwgHNhcEsIo9KBb/eJg+/ikD0soJwJiy1lVD6gaqpxAJlV0pbYASJxo93B2DAgnz0aTQxCxLkZDhM6Y+mC+LuyPI4eaCM4c47XZ7I98kiPHvA0gQmWPmuca5oOwgNfJGYA5tdk28YqDT/JPzbcBjFiLiJy35eUSgkgY7CZiwz67FsvvJqP7sQ3bu8+MyCCEM+738HyKvCSgq39LbGtJ3zrZ7C0J/PxNfCfaveaJbQPXlMhnK1vv5EZHFjCucemsWjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QvEksMKl0Gi/3IwFUWbN9irRkwwS3xTAwpqnAarGMXo=;
 b=WDGhIWCBTybHJYVFWX4pj0oD7XdgP3oPYoheGCDrW0eWoGNN5edhnCy2nR6CNYow7o0Gi0ULS1uPsih7JzYVFOl9hHUs3D8Pk4thZ6eVUk0ZoxSV4Wonb5vyiVl9JIjqnVK749zVWTfWb/rNdfGH7zS4E4KjFoLvNncDR64fYi+Qh+k1RhPwKNrYfJjOCWWAULOQ1EfzfpiJmkfbzke6AE1L7dt7poXy7lk/nvDFd/PszNVykKr6WFb3+wHPpDgnlZ/bBLK+MSvIvWNd3VcfBqLi2NMWdUeoI5y3Yefa+kXuujYJ+/byvqi4FwNUJIArDskKLTbWczr+hIEUkomkfQ==
Received: from SA1P222CA0055.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::7)
 by SA3PR12MB8761.namprd12.prod.outlook.com (2603:10b6:806:312::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Sat, 14 Oct
 2023 10:54:50 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:806:2c1:cafe::b) by SA1P222CA0055.outlook.office365.com
 (2603:10b6:806:2c1::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.47 via Frontend
 Transport; Sat, 14 Oct 2023 10:54:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Sat, 14 Oct 2023 10:54:50 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sat, 14 Oct
 2023 03:54:41 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sat, 14 Oct
 2023 03:54:40 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Sat, 14 Oct 2023 03:54:37 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <rafael@kernel.org>, <rui.zhang@intel.com>, <lenb@kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <treding@nvidia.com>, <jonathanh@nvidia.com>, <bbasu@nvidia.com>,
        <sumitg@nvidia.com>, <sanjayc@nvidia.com>, <ksitaraman@nvidia.com>,
        <srikars@nvidia.com>, <jbrasen@nvidia.com>
Subject: [Patch v5 1/2] ACPI: thermal: Add Thermal fast Sampling Period (_TFP) support
Date:   Sat, 14 Oct 2023 16:24:25 +0530
Message-ID: <20231014105426.26389-2-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231014105426.26389-1-sumitg@nvidia.com>
References: <20231014105426.26389-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|SA3PR12MB8761:EE_
X-MS-Office365-Filtering-Correlation-Id: dc99b930-54f1-4c38-7901-08dbcca3fd4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0CGyNgZ2oWQKLO7N8pCXwu5/+JgO9ULQHZLH5TOL165SLve/r5qPQPqAMUxEG0wCqIf9f61kUfkr0fxAZ8IhYnqvJ+dqU0JcD3gPgcJlRLFKpN8ivUSU+rInEDQ9YIviVEmvkSY7WCXKMd+HD7Ng+z+5K6ys6qvtePHy4iEjB8E8nRjxgV4x8wBRovBQt4MDAjqOBD3c9BUXSJPzK0uZ+BNXsKK8vZqyEu99TVt+fjIyBtko2mEDwSSnHthKIV1o8txsUVzL9zWHvxVq+pTCzvYoxZmuBI2VRzIwTFmLJ3hhjylj8vy/jRydKTfN4AershanVhIqDx3veJZzteM9ZL7a3vpfubbbt8MXHIOvGxJxF2tkPrI+jeo85+XHPdOOEX4Y0Pna2REOEURZ2H/js+ZW8TZioCmHHUGHScF+IuvaEZOgE70SKyP2rPe3Ur4G3U2/e729KTbSV8eG11L5ZZ4z2FWGjiUeFHB+UGUjiS8ZRcVfPDw3Nxe6Hw9LsNY5gb28RJbUMNMBh//zz6NUFdT+Fy1w2QEGpfe0aWZ7j1h5CLlXwzZvbt3ry2R7JlQo/3GTPUonBTy5GYEqBs8FazxJPcmHJeUEuiSVA2ScRJbdA7nAv/9Anl/QxG7vnbduyZlymA13omWCEOle472g1qnIHoDoSjZSgmyKgARoHBc+XCJl4IfafGFhSmDO5ND2uhnUxKH3EsJ9G/E9f5Pb0u8MUSpYOa1y6YARNafBdpGiyjL+fnnJOWJT9FxDVDVIClPWdUc4ENhe45ILgCbaig==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(39860400002)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(82310400011)(46966006)(40470700004)(36840700001)(54906003)(70206006)(70586007)(316002)(110136005)(8936002)(4326008)(36756003)(336012)(41300700001)(426003)(8676002)(5660300002)(7636003)(82740400003)(356005)(36860700001)(2906002)(47076005)(478600001)(2616005)(26005)(40460700003)(6666004)(7696005)(40480700001)(1076003)(83380400001)(86362001)(107886003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2023 10:54:50.2968
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc99b930-54f1-4c38-7901-08dbcca3fd4b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8761
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 drivers/acpi/thermal.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index d98ff69303b3..a91e3d566858 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -90,7 +90,7 @@ struct acpi_thermal_passive {
 	struct acpi_thermal_trip trip;
 	unsigned long tc1;
 	unsigned long tc2;
-	unsigned long tsp;
+	unsigned long passive_delay;
 };
 
 struct acpi_thermal_active {
@@ -404,11 +404,16 @@ static bool passive_trip_params_init(struct acpi_thermal *tz)
 
 	tz->trips.passive.tc2 = tmp;
 
-	status = acpi_evaluate_integer(tz->device->handle, "_TSP", NULL, &tmp);
-	if (ACPI_FAILURE(status))
-		return false;
+	status = acpi_evaluate_integer(tz->device->handle, "_TFP", NULL, &tmp);
+	if (ACPI_FAILURE(status)) {
+		status = acpi_evaluate_integer(tz->device->handle, "_TSP", NULL, &tmp);
+		if (ACPI_FAILURE(status))
+			return false;
 
-	tz->trips.passive.tsp = tmp;
+		tz->trips.passive.passive_delay = tmp * 100;
+	} else {
+		tz->trips.passive.passive_delay = tmp;
+	}
 
 	return true;
 }
@@ -904,7 +909,7 @@ static int acpi_thermal_add(struct acpi_device *device)
 
 	acpi_trip = &tz->trips.passive.trip;
 	if (acpi_thermal_trip_valid(acpi_trip)) {
-		passive_delay = tz->trips.passive.tsp * 100;
+		passive_delay = tz->trips.passive.passive_delay;
 
 		trip->type = THERMAL_TRIP_PASSIVE;
 		trip->temperature = acpi_thermal_temp(tz, acpi_trip->temp_dk);
-- 
2.17.1

