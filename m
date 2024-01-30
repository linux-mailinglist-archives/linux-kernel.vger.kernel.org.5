Return-Path: <linux-kernel+bounces-44873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F2784285F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 128961C238B9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FA285C62;
	Tue, 30 Jan 2024 15:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="C0qDyFNe"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5694D86AE8;
	Tue, 30 Jan 2024 15:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706629768; cv=fail; b=sx1nhLTGht5WfAWbiDuVD6JMG5d25rH2jDqZK8/R3MTMF0AJ75r3itfcBQGV8yeNCO+fZU5wZocnKzIsIvC/OwS9XTAOmJkUOO5OkBVXZ00crz/tiMBDXTMEuLccgspsAFn8nlOwDFkwTqWyuCG1xWCkHNky+VKkSonyvsh4/DQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706629768; c=relaxed/simple;
	bh=2/L3CMIpD2Q6WTee3CeIHz3X6PEST7CYI3j9OqQiozU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k7Z9CAbERyFYB9i6CopTZqjWN1ujgBewmcmVKIuDyb9FgvBoZavzGyihdWXoIbRuv6kCoXdZLnPgMmcU4P1WrshNBhX8ATbJHGLwliprye6AYKe5jzvIX7VxmE6xJDIe0DyL4nYoLB1tFMXoNGV1W87BHvJuDZ1i0nY81kzkx2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=C0qDyFNe; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oc/gzXyAc/D2cJ0LnZVt1Xfy+kLKIfcimLSZ8+NU6VNV8fCsd7IMG+Npi6BAHkbh86HvaDSHzY2JqfcSuvb8b9bcO/dWiBGXEouEHQ9K5OnuFK6lTI3qJj3HqFSMWWuHJQ0QrkLuUHPiSGlIw06xxyi/E8Tg6UwiUEawscERKSOGE9FttJsTaDtZrorSy6nQzo033PpPA5Szu4tkampkKkp83Umi/lXCfNCksAyYIUrK326DfWS5LecsyP0K/RteoEAAvnoDVIFLN25EySIaw5qfeS0us4JaXABvAXBj30JorVBFGH/hbJm99b2XYCAmZUw7puPYFTmkpQuAJJQEtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5BsRx+5Ng7RgJdjezWuHPR+PBFBF/orE+c2CGbsv9hA=;
 b=Y0+TvSpAH3aZwZVk5xwCRsrrqvaWNIc1avbQeZJ1B8t/zBQcTvLtjaLYY06mUn0UjbFMz5XLTXWbfArYHz6JIUzbEOf5OT7lCzZJZuRoEW2DTlK0pEXqhAK22NdhCrEc2qpg2dnSDmXUGszWUyF681HgqAi+1Tmeh0QkZl4ZzEh8hMXhQAE/mNjJd1+qwgFngdCmBczmYOQtdvpvVTF3JiHgYx4mSkv6lAt/WQ8azcV1buWj6xRFxTByLbldQ4XpRzI+RrAVazhaexNyvC/onpbGuhwf9nFzMqyu5Jrv7+uiccox3+oiiYH0zi1eTn1VmJYncy5c7hj/md67W7Q63g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5BsRx+5Ng7RgJdjezWuHPR+PBFBF/orE+c2CGbsv9hA=;
 b=C0qDyFNe8TPABDNcq32empr29Y3EmGlWIqwtAFIHRI6FkA3G+fiC6F7TS29rLSE2Nq1YdUtaVHoN+VoN+Ezyj/afHJI3EF5jd08A3Sqb/t55rAPiI79NXQbj3bRpfl6dZd3U5/W4/lqCswsq8oTkJz+b14pw/by9EpQk2YZ0WSU=
Received: from BN8PR07CA0002.namprd07.prod.outlook.com (2603:10b6:408:ac::15)
 by DM8PR12MB5397.namprd12.prod.outlook.com (2603:10b6:8:38::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.22; Tue, 30 Jan 2024 15:49:23 +0000
Received: from BN3PEPF0000B069.namprd21.prod.outlook.com
 (2603:10b6:408:ac:cafe::e4) by BN8PR07CA0002.outlook.office365.com
 (2603:10b6:408:ac::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22 via Frontend
 Transport; Tue, 30 Jan 2024 15:49:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B069.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7270.0 via Frontend Transport; Tue, 30 Jan 2024 15:49:23 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 30 Jan
 2024 09:49:23 -0600
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Tue, 30 Jan 2024 09:49:22 -0600
From: Tanmay Shah <tanmay.shah@amd.com>
To: <andersson@kernel.org>, <mathieu.poirier@linaro.org>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Ben
 Levinsky" <ben.levinsky@xilinx.com>, Tarak Reddy <tarak.reddy@amd.com>,
	"Tanmay Shah" <tanmay.shah@amd.com>
Subject: [PATCH v5] remoteproc: Make rproc_get_by_phandle() work for clusters
Date: Tue, 30 Jan 2024 07:48:49 -0800
Message-ID: <20240130154849.1018666-1-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B069:EE_|DM8PR12MB5397:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c4eadac-ab17-4353-4501-08dc21ab07fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	z7P33WArlmURc0lD5x0jq+BPbMEwBKBPb+gmDaUKestaQ1R4CgS+IuDdJDFfpW1kudHER+K8KlGQG6u3rfi+5fNh8IZmfU9JrN1Japws2yCVLyXKfYODwt4Oe78JNHQ3vFlL8CN+rCK8VFSrhjDcRqRB6+gqzOWZDBqxotVaoNKhwZgSDRsNCwaK3o2b1XmHBjrXjlo+uRIzwxnueam6/4wWhlq+KQXH5dwYQpCeIeZF5GIpq7v93oMq7Vq2XCnf5xrf3zLTT2eaFZYSfT0ahfUli/q9D8BCvUuKfJdL3bcPrANOdRuoVEJ2z0QCptqoGCPTnK88yQTNs1R5yZzHs2W4eFq6O7UgaF0hIK7rqOSEcECdRGSPqy1AXuVLoUEo5jxaHDH9YjR4XEi3zAYrfE/+i/pL3zgQzxm0x2DzMwtsOrKE1oaaAEylJGvwuQxglvyjDumsqdxZPDKr/rC+eV/CgfCklLGOoL2b15pw9Lg4HDBSKd2yYy+ghlUodn5G3f4vJYBgFQGwa57CTLsPcyxzgl0yOzuqVO0ylXZ7k3uLHiJ6IxPn/cUlDuqiadESBb3rQBvaCkBqQ5uS9Br1EzQIHMNfw10yFCDrA78uZ0/gyzxbS0qgj9Qmzd5vuzF9lOtfdFEKVbRtk1zF3icpVxmKsBNDW+xyp0QUj/OhM+zkgu+uXfwo3UPaUDdgYkdtasuHN2B+sKQhJ75AZiztigimTfUESqzQHyzhnyF34RZ5VO3OpNS2pDa2F8VmBZMQ0sMvs/Je9zPXnc9JXe6e7g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(396003)(39860400002)(376002)(230922051799003)(1800799012)(186009)(82310400011)(451199024)(64100799003)(46966006)(40470700004)(36840700001)(426003)(336012)(2616005)(1076003)(41300700001)(40460700003)(40480700001)(36756003)(47076005)(36860700001)(110136005)(26005)(6666004)(478600001)(83380400001)(81166007)(82740400003)(356005)(54906003)(86362001)(2906002)(5660300002)(4326008)(70206006)(316002)(44832011)(70586007)(8676002)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 15:49:23.6396
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c4eadac-ab17-4353-4501-08dc21ab07fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B069.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5397

From: Mathieu Poirier <mathieu.poirier@linaro.org>

Multi-cluster remoteproc designs typically have the following DT
declaration:

        remoteproc-cluster {
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
Co-developed-by: Tarak Reddy <tarak.reddy@amd.com>
Signed-off-by: Tarak Reddy <tarak.reddy@amd.com>
Co-developed-by: Tanmay Shah <tanmay.shah@amd.com>
Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
---
 drivers/remoteproc/remoteproc_core.c | 29 ++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 695cce218e8c..f276956f2c5c 100644
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
@@ -2112,6 +2113,7 @@ EXPORT_SYMBOL(rproc_detach);
 struct rproc *rproc_get_by_phandle(phandle phandle)
 {
 	struct rproc *rproc = NULL, *r;
+	struct device_driver *driver;
 	struct device_node *np;
 
 	np = of_find_node_by_phandle(phandle);
@@ -2122,7 +2124,26 @@ struct rproc *rproc_get_by_phandle(phandle phandle)
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
+				if (r->dev.parent->parent)
+					driver = r->dev.parent->parent->driver;
+				if (!driver)
+					break;
+			}
+
+			if (!try_module_get(driver->owner)) {
 				dev_err(&r->dev, "can't get owner\n");
 				break;
 			}
@@ -2533,7 +2554,11 @@ EXPORT_SYMBOL(rproc_free);
  */
 void rproc_put(struct rproc *rproc)
 {
-	module_put(rproc->dev.parent->driver->owner);
+	if (rproc->dev.parent->driver)
+		module_put(rproc->dev.parent->driver->owner);
+	else
+		module_put(rproc->dev.parent->parent->driver->owner);
+
 	put_device(&rproc->dev);
 }
 EXPORT_SYMBOL(rproc_put);

base-commit: 99f59b148871dadb9104366e3d25b120a97f897b
-- 
2.25.1


