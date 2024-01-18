Return-Path: <linux-kernel+bounces-30493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C60D831F76
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 20:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF1BA1F26D12
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276622E62C;
	Thu, 18 Jan 2024 19:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="N6UgQb/c"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2087.outbound.protection.outlook.com [40.107.101.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEBF2E3FF;
	Thu, 18 Jan 2024 19:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705604918; cv=fail; b=qeTPpcrlSPpv6d9YtP0TU5GXrD+ZbquZ2hYJ1NY4LbFa8g6uIe5/Wu0LODPTFUYaBWDyTD3QNakAuVciSvO5RGocBD7oO9fT2qOiRZqEX3VgJXGQ9fac7A0Ni/CrDTMlLKwLz0ckADoZ+CEZ0vAjzs7UjiD0mur/PrGCEWoz4PA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705604918; c=relaxed/simple;
	bh=JMroQTVzFI1cxsi6CmbYGe4SDDbPHTWrCyskT1r1fm8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OvH+xFT7gevFVzGxxGjzmjY+zIdQLzKH76fe1fpxzPfZbwn40iVQzwXcs1ZNy6+ZEs5eOAFdqHhQMXRLSY/wL4qbpkrFr1T18GQqVerZFx3bM5IQ4kcejoXpF4YsuY9EcFCMdggiu6aOmJLAVd9iFyoGuDor9F0oB/+Xvua9GpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=N6UgQb/c; arc=fail smtp.client-ip=40.107.101.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dKlzlGNkyJxAmDsutZEBn5l8jcamOqY24X3L/gw9bQcaPf253unfVAYYBfzihwIeRPN/pYuGRfuusl1liAruiD8ceV+wEMXzGyDh9nranlqJ2SOEg38FdywUIXEuoZEMdCHWWV65MtbPZB6LYj3UbtIJGBr1vbO74cPXwnbEWhPEK9FHtoDTpOrEjZ25KVazIGV4c7dcs9hzH8y/4k4vGXda9xWgsFY1+DXnm5DikA3lJUwdAZlFcfNz1un3UOUgDN6R0WPaUwdbI0MCKzMGHb2LuU4am645JFeHGNp+J3gDYwaveK97imd5ZnIhRpoo8Jj7RORrZE0DdzpsJcGXBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ya03YOTF7IBEODwehB80OC/zP+2BbgeDg7nI4R2K4Ew=;
 b=A/2ts+Icvx7D4/Re7036TqZJPp5GxclZDn9VHorX0DweHTDI7RTNp/oYmK4kq3tzvTzwjbn8L8Z5kw2wiM9nNl2kYdvk1nPt3C6Ky16JPQL2mv7nTBKIxdpgsYwZnTEBxa0d9A2+nRg9CVmZ0fvuxn/2UMYLTM9zWgXtJum3t/TLFxFfmgq6oGHi2YX4n3bJ3T1tMWhs5MD+889kDBEs+xXokWUDQ3r8+sGvKb0KbT1kiTtCAtiPdDNfaLU5ficzK/LXmw/jTznqVvy+o3TcDLf+sqPSe7EBb3u9I26VSHspA9iy5jeqUHkD6wNKxLK20g7jFXkVbS8pg7YAta9swg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ya03YOTF7IBEODwehB80OC/zP+2BbgeDg7nI4R2K4Ew=;
 b=N6UgQb/cNG2MxwCrWdrDwUHSIR8ol1UtOyOBCjEupXsASGMhNuyZmOCoqmjn5OsNt05IR844JCTQHoTYXv3XEuLLI3Ois/qZ/6ChTFlAteAJyScOH8Z4V01ZbUx8nTl2dPR0yeaYND3AAGdaS0+gG9cRwPYNJK4hwhZrNUECtVE=
Received: from DM6PR01CA0015.prod.exchangelabs.com (2603:10b6:5:296::20) by
 BY5PR12MB4903.namprd12.prod.outlook.com (2603:10b6:a03:1d6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 19:08:33 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:5:296:cafe::58) by DM6PR01CA0015.outlook.office365.com
 (2603:10b6:5:296::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Thu, 18 Jan 2024 19:08:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024 19:08:33 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 13:08:33 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 18 Jan
 2024 11:08:32 -0800
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Thu, 18 Jan 2024 13:08:30 -0600
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <dlemoal@kernel.org>, <cassel@kernel.org>, <richardcochran@gmail.com>,
	<piyush.mehta@xilinx.com>, <axboe@kernel.dk>, <michal.simek@amd.com>
CC: <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<git@amd.com>, Piyush Mehta <piyush.mehta@amd.com>, Radhey Shyam Pandey
	<radhey.shyam.pandey@amd.com>
Subject: [PATCH 1/2] ata: ahci_ceva: fix error handling for Xilinx GT PHY support
Date: Fri, 19 Jan 2024 00:38:23 +0530
Message-ID: <1705604904-471889-2-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1705604904-471889-1-git-send-email-radhey.shyam.pandey@amd.com>
References: <1705604904-471889-1-git-send-email-radhey.shyam.pandey@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|BY5PR12MB4903:EE_
X-MS-Office365-Filtering-Correlation-Id: f6a3aba8-e0a5-4469-4a1c-08dc1858dddd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OPlQ4VSrw8EoZX/yYF7iux5Ckx+w+wM7ZN3RnYZxaNmmX9A9qokEOFEjyQBOkfUcf/i5JTBwOnpRGehd4hQAf7ZLAzsHQ9oeLaWxJ3lTw7Cwsn9WgLHraznX4JFPidOI71NmVjTsj2awb7WfMOSOHVl3hB0svMAwlglBbcgFIBkWO7InVEb8YRQkP4VoCdWqvZg6TwU4rJqNldOPLbcENPhz0sH77344Okvwgwg3OIksUp2jflfjLjSLX/C4Z4dQox4wSHAaqpe+F9wb6XnHVyIq1xvvjrzMg+GntMMBWenbzghzvWvRI7qa6iCv2/5xKgoUq8tKKR5TEM9Jzb9lDbga/uKqzlk1KqU0M96gqb4lbOJpZQ+RyzgwPQcJ5onD8wHnpBgiiKY4VoOlQh21C7ympjsmDnyCj1UhvzoSRwmOPE2XxBMoJgRXVOey2qDcM2qxjft2ipSbciGNYMx0NHTOlCENjo4v+rlf16yHcLzu1M9ddrtKe8x+P5dPIO3FDWAzElOwE1UYV37gkwCI5klaJOwa+XTXC3tZd2y6bm54TcT7Xg/OtA7K3Q8UdxgAK1on/7nQ2SA2q7Q19e34QBiB5stjAo8OIyIlTg4QqPFNewoeaJ5bv3uF3tX7YetzGZDMXGXREoNbrp1VPh7rzo0qaFhwlMWlh+loT2myZXWCVCQ3I+a5A7Ugtxz4CdfOyiDLDdgVfF3uIThzZNX+KQWV8si2TS6Xn6HrvjxU4v+RAX6Rb8e/HyuppcG/vMDLmu9eYSNCuBDKCHvulBjUNg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(39860400002)(396003)(136003)(230922051799003)(64100799003)(82310400011)(1800799012)(186009)(451199024)(46966006)(36840700001)(40470700004)(36860700001)(47076005)(8936002)(8676002)(4326008)(81166007)(36756003)(356005)(2906002)(86362001)(82740400003)(41300700001)(5660300002)(26005)(40460700003)(40480700001)(426003)(336012)(478600001)(6666004)(83380400001)(2616005)(54906003)(316002)(6636002)(70206006)(110136005)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 19:08:33.7442
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6a3aba8-e0a5-4469-4a1c-08dc1858dddd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4903

From: Piyush Mehta <piyush.mehta@amd.com>

Platform clock and phy error resources are not cleaned up in Xilinx GT PHY
error path. To fix introduce error label for ahci_platform_disable_clks and
phy_power_off/exit and call them in error path. No functional change.

Fixes: 9a9d3abe24bb ("ata: ahci: ceva: Update the driver to support xilinx GT phy")
Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
---
 drivers/ata/ahci_ceva.c | 47 +++++++++++++++++++++++++++++------------
 1 file changed, 33 insertions(+), 14 deletions(-)

diff --git a/drivers/ata/ahci_ceva.c b/drivers/ata/ahci_ceva.c
index 64f7f7d6ba84..bfc513f1d0b3 100644
--- a/drivers/ata/ahci_ceva.c
+++ b/drivers/ata/ahci_ceva.c
@@ -196,7 +196,7 @@ static int ceva_ahci_probe(struct platform_device *pdev)
 	struct ahci_host_priv *hpriv;
 	struct ceva_ahci_priv *cevapriv;
 	enum dev_dma_attr attr;
-	int rc;
+	int rc, i;
 
 	cevapriv = devm_kzalloc(dev, sizeof(*cevapriv), GFP_KERNEL);
 	if (!cevapriv)
@@ -219,8 +219,6 @@ static int ceva_ahci_probe(struct platform_device *pdev)
 		if (rc)
 			return rc;
 	} else {
-		int i;
-
 		rc = ahci_platform_enable_clks(hpriv);
 		if (rc)
 			return rc;
@@ -229,8 +227,11 @@ static int ceva_ahci_probe(struct platform_device *pdev)
 
 		for (i = 0; i < hpriv->nports; i++) {
 			rc = phy_init(hpriv->phys[i]);
-			if (rc)
-				return rc;
+			if (rc) {
+				while (--i >= 0)
+					phy_exit(hpriv->phys[i]);
+				goto disable_clks;
+			}
 		}
 
 		/* De-assert the controller reset */
@@ -240,7 +241,7 @@ static int ceva_ahci_probe(struct platform_device *pdev)
 			rc = phy_power_on(hpriv->phys[i]);
 			if (rc) {
 				phy_exit(hpriv->phys[i]);
-				return rc;
+				goto disable_phys;
 			}
 		}
 	}
@@ -252,52 +253,60 @@ static int ceva_ahci_probe(struct platform_device *pdev)
 	if (of_property_read_u8_array(np, "ceva,p0-cominit-params",
 					(u8 *)&cevapriv->pp2c[0], 4) < 0) {
 		dev_warn(dev, "ceva,p0-cominit-params property not defined\n");
-		return -EINVAL;
+		rc = -EINVAL;
+		goto disable_phys;
 	}
 
 	if (of_property_read_u8_array(np, "ceva,p1-cominit-params",
 					(u8 *)&cevapriv->pp2c[1], 4) < 0) {
 		dev_warn(dev, "ceva,p1-cominit-params property not defined\n");
-		return -EINVAL;
+		rc = -EINVAL;
+		goto disable_phys;
 	}
 
 	/* Read OOB timing value for COMWAKE from device-tree*/
 	if (of_property_read_u8_array(np, "ceva,p0-comwake-params",
 					(u8 *)&cevapriv->pp3c[0], 4) < 0) {
 		dev_warn(dev, "ceva,p0-comwake-params property not defined\n");
-		return -EINVAL;
+		rc = -EINVAL;
+		goto disable_phys;
 	}
 
 	if (of_property_read_u8_array(np, "ceva,p1-comwake-params",
 					(u8 *)&cevapriv->pp3c[1], 4) < 0) {
 		dev_warn(dev, "ceva,p1-comwake-params property not defined\n");
-		return -EINVAL;
+		rc = -EINVAL;
+		goto disable_phys;
 	}
 
 	/* Read phy BURST timing value from device-tree */
 	if (of_property_read_u8_array(np, "ceva,p0-burst-params",
 					(u8 *)&cevapriv->pp4c[0], 4) < 0) {
 		dev_warn(dev, "ceva,p0-burst-params property not defined\n");
-		return -EINVAL;
+		rc = -EINVAL;
+		goto disable_phys;
 	}
 
 	if (of_property_read_u8_array(np, "ceva,p1-burst-params",
 					(u8 *)&cevapriv->pp4c[1], 4) < 0) {
 		dev_warn(dev, "ceva,p1-burst-params property not defined\n");
-		return -EINVAL;
+		rc = -EINVAL;
+		goto disable_phys;
 	}
 
 	/* Read phy RETRY interval timing value from device-tree */
 	if (of_property_read_u16_array(np, "ceva,p0-retry-params",
 					(u16 *)&cevapriv->pp5c[0], 2) < 0) {
 		dev_warn(dev, "ceva,p0-retry-params property not defined\n");
-		return -EINVAL;
+		rc = -EINVAL;
+		goto disable_phys;
 	}
 
 	if (of_property_read_u16_array(np, "ceva,p1-retry-params",
 					(u16 *)&cevapriv->pp5c[1], 2) < 0) {
 		dev_warn(dev, "ceva,p1-retry-params property not defined\n");
-		return -EINVAL;
+		rc = -EINVAL;
+		goto disable_phys;
 	}
 
 	/*
@@ -321,6 +330,16 @@ static int ceva_ahci_probe(struct platform_device *pdev)
 
 disable_resources:
 	ahci_platform_disable_resources(hpriv);
+
+disable_phys:
+	while (--i >= 0) {
+		phy_power_off(hpriv->phys[i]);
+		phy_exit(hpriv->phys[i]);
+	}
+
+disable_clks:
+	ahci_platform_disable_clks(hpriv);
+
 	return rc;
 }
 
-- 
2.34.1


