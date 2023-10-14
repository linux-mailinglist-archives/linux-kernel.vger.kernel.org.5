Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97AC17C9738
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 01:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbjJNXQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 19:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjJNXP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 19:15:59 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87724DA;
        Sat, 14 Oct 2023 16:15:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bcYN2x12UQT84MtVKxsuI1Zsykvfmz6BkTsOKsoo92RmnZL+rBZ/Rlim91N/VmkN2nOR/fYX+g4Y316V9Bvg6gXsDkNAKYkHlYhwA8ivuM+OPfzvHccm5+6jhL656w5JoNpB95m1SqVpQbVd1PW8m/Wk/DVNkeJnd7C9l69dwn+e3FAFSK8EWSevwruzz6mI/4JxABQ3ZHbtp2iQvB0u1TPW3tSbDrbL4zsplyBNymQRbT5yOo7rItzIQUkoAnTQgwmMkAK4ZHUNoJfampfn2pm1SQmP4CRN941hMmfzbLBpY7x11JdE5GPlCfx94s05/5dhbrP4XDEM0lxJ8vy1pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nKyt3rijtidOqEX45rDkUQzEbJ1Ci6kitPTPVLT9JlE=;
 b=HYRkjgSwc3u37idcTKvTBs0KXqqESD2qRkNHfA/I2fDMMxpa9y3pvj8x0ATsYh+YzzFnexNnJDWkir1cySWifEBKUnYEil0Ju4dqg0CxzBxeTQ4nDyX09ZZ29kJ/Dt8JnkySoIvtTccRaxcEYSXy4yKEt2FyUUuON8caUU/0MOnnolrhiIbrzMRS3282k7KUyzWhiP5cWru83ZBPY5Hpt4cVRinfqsFiGi4yPMbP0MEigFoI0XLF+dYf2zj04DN6beXjOys+VlYkCfJOtxm8HWHdj/yyvcoVBMs2rJ71O8OkW2aSyiG/6WWugGuKb5Fbv3cfgS1w98vQuBxDTOJu+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nKyt3rijtidOqEX45rDkUQzEbJ1Ci6kitPTPVLT9JlE=;
 b=UPApPKgVPOmhPWQKhhO+m2LK1Z80PyU7OlUVqOx+P3xpiUTrkwhGutzwJ35nHthqOb5LqU/l9aaVg4tVk3EydSMBpb+/3oUNwSJHnaRVwPqhaDVLdr7JMAzx0A6tvNU/Sl/1I8NoW9PcWlyNKbKu0pxuerBis0DsSda0qNvlFcA=
Received: from BL1PR13CA0027.namprd13.prod.outlook.com (2603:10b6:208:256::32)
 by IA1PR12MB8539.namprd12.prod.outlook.com (2603:10b6:208:446::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Sat, 14 Oct
 2023 23:15:52 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:208:256:cafe::a1) by BL1PR13CA0027.outlook.office365.com
 (2603:10b6:208:256::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.16 via Frontend
 Transport; Sat, 14 Oct 2023 23:15:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Sat, 14 Oct 2023 23:15:52 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 14 Oct
 2023 18:15:52 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 14 Oct
 2023 18:15:51 -0500
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Sat, 14 Oct 2023 18:15:51 -0500
From:   Tanmay Shah <tanmay.shah@amd.com>
To:     <andersson@kernel.org>, <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Ben Levinsky" <ben.levinsky@xilinx.com>,
        Ben Levinsky <ben.levinsky@amd.com>
Subject: [RESEND PATCH v3 1/2] remoteproc: Make rproc_get_by_phandle() work for clusters
Date:   Sat, 14 Oct 2023 16:15:47 -0700
Message-ID: <20231014231548.637303-2-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231014231548.637303-1-tanmay.shah@amd.com>
References: <20231014231548.637303-1-tanmay.shah@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|IA1PR12MB8539:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cb0c298-749c-4423-714b-08dbcd0b82cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sjbz7UpSbQ30t6s38j+asV4pDafyEj2tBUT28xlIm1HlQNrgBXBbZ+VlOL4WJMW4+XXeK+9oYWUsEozBRWPSWy86GjDZRjG69/7rM2kuSTbJMCtblwdxoMRKcb3OfEp6TauEBqHUA06aZkxQG5MR0f4GQQfd4vbdtv6sjb5PrGRPc+pM9zr3rMS7fEeTfiL/alWEAgagH3IpIBK1MZm/7RNUoTpl7eOrUjs3bKt092XksZYTIoxwAtgMHxShZpPhLS9dwulPL3CHJ2vClYLPmh1/mfcaLKwh++RzuZeo8TEwWRu3ExSm90QVJLn/FmmIdKJNbtkvr+BkTQTkTTR8cd9bYxLtR2oO2K1Rtxtpm6YCNhCBxywJ19we2aR9LqK1EaWGZnJ0Nk+On4QrkvIqNiQ1zrLJzVz9FgjjSNDZ9RlAQRh6y45MzzfAIFBitBNpQ+nc9LUDO4Z7/sdy1ltuTYyu+9ZF+zHraMDjMnsARbgg2358CNdrM4gRRS4oxkysfbEp7/AJYPZY8KZAoCrrqRezHszaOEXBTw/nEHhdZ6lyY8a18EKi+30wfgMKQxe2OUS35zLxBMM3Xyf8allFejyiH1XeKIA7usSYOdXA4qVpU8BYkf/dVN+XD/mpGIWb9A9veeWGS/Sqow4MmxXLbgV/dZh+DkYCE2yVoRoAxh7iy9q+sW8sdW9nfmQQIn2CLRkEarCvNHR0ySGo41R60mwWYIoUxkUUWknu1X04y6bUe/sVc5U8qwK6NKC8yf5wHkm5WFT9EXJXzuYWy/ZMMw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(346002)(136003)(396003)(230922051799003)(64100799003)(451199024)(82310400011)(1800799009)(186009)(36840700001)(40470700004)(46966006)(40460700003)(6666004)(36860700001)(110136005)(8936002)(54906003)(70206006)(70586007)(316002)(82740400003)(356005)(81166007)(478600001)(2616005)(26005)(1076003)(47076005)(8676002)(336012)(426003)(83380400001)(4326008)(40480700001)(36756003)(2906002)(5660300002)(41300700001)(44832011)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2023 23:15:52.5359
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cb0c298-749c-4423-714b-08dbcd0b82cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8539
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

Multi-cluster remoteproc designs typically have the following DT
declaration:

	remoteproc_cluster {
		compatible = "soc,remoteproc-cluster";

                core0: core0 {
			compatible = "soc,remoteproc-core"
                        memory-region;
                        sram;
                };

                core1: core1 {
			compatible = "soc,remoteproc-core"
                        memory-region;
                        sram;
                }
        };

A driver exists for the cluster rather than the individual cores
themselves so that operation mode and HW specific configurations
applicable to the cluster can be made.

Because the driver exists at the cluster level and not the individual
core level, function rproc_get_by_phandle() fails to return the
remoteproc associated with the phandled it is called for.

This patch enhances rproc_get_by_phandle() by looking for the cluster's
driver when the driver for the immediate remoteproc's parent is not
found.

Reported-by: Ben Levinsky <ben.levinsky@xilinx.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Tested-by: Ben Levinsky <ben.levinsky@amd.com>
---
 drivers/remoteproc/remoteproc_core.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 695cce218e8c..3a8191803885 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -33,6 +33,7 @@
 #include <linux/idr.h>
 #include <linux/elf.h>
 #include <linux/crc32.h>
+#include <linux/of_platform.h>
 #include <linux/of_reserved_mem.h>
 #include <linux/virtio_ids.h>
 #include <linux/virtio_ring.h>
@@ -2111,7 +2112,9 @@ EXPORT_SYMBOL(rproc_detach);
 #ifdef CONFIG_OF
 struct rproc *rproc_get_by_phandle(phandle phandle)
 {
+	struct platform_device *cluster_pdev;
 	struct rproc *rproc = NULL, *r;
+	struct device_driver *driver;
 	struct device_node *np;
 
 	np = of_find_node_by_phandle(phandle);
@@ -2122,7 +2125,30 @@ struct rproc *rproc_get_by_phandle(phandle phandle)
 	list_for_each_entry_rcu(r, &rproc_list, node) {
 		if (r->dev.parent && device_match_of_node(r->dev.parent, np)) {
 			/* prevent underlying implementation from being removed */
-			if (!try_module_get(r->dev.parent->driver->owner)) {
+
+			/*
+			 * If the remoteproc's parent has a driver, the
+			 * remoteproc is not part of a cluster and we can use
+			 * that driver.
+			 */
+			driver = r->dev.parent->driver;
+
+			/*
+			 * If the remoteproc's parent does not have a driver,
+			 * look for the driver associated with the cluster.
+			 */
+			if (!driver) {
+				cluster_pdev = of_find_device_by_node(np->parent);
+				if (!cluster_pdev) {
+					dev_err(&r->dev, "can't get parent\n");
+					break;
+				}
+
+				driver = cluster_pdev->dev.driver;
+				put_device(&cluster_pdev->dev);
+			}
+
+			if (!try_module_get(driver->owner)) {
 				dev_err(&r->dev, "can't get owner\n");
 				break;
 			}
-- 
2.25.1

