Return-Path: <linux-kernel+bounces-40461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FA383E0C7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FA23288520
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC94523759;
	Fri, 26 Jan 2024 17:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vd+klN+x"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDBC22638;
	Fri, 26 Jan 2024 17:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706291004; cv=fail; b=U+WAEY7j8AO8CdMtuOIkfytl0tEySeLGgYehJs64CHs6UR8I6T08npx7s/2yhcYSmACWk7DwDihsQ5gNYFWGEEtuUwWsXalt85u1Ii4j5R+E0OAKxYZ8F7n3x1dMkX+eAkUkSKpwGALA+RR1kg2CqMQnl1jl3CxLkEP9eK0SvmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706291004; c=relaxed/simple;
	bh=ZT3zWW4sUMnqUE1Q4HxG92WEAz4elCEDCDJr9KilCDY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HL6zuZtVROPknpknI8g7y7jJOMICF59aVqlwNW/bD9CqubpFRIWj4MHkHG9PGbrqYlI5O8bBKySbz3P01zjyKaPfwEhtQ4Q3zKhMzwpsKCYGTb3JYIgcPa9rV0aHk+TB7s5e1sJdHCdyVEMinjo/y48nsvP1wRMX2Blz4a5RvVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vd+klN+x; arc=fail smtp.client-ip=40.107.220.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JsBs65pMFo8Anf3as2MRCuAhvfDHx4aUjuZnYyxP0skKSA8/yB7TqZOPX4RJlKzi6YrY2LlAcgIMJpRiqiIxwD8THMn2HwjRC16qFpQ0FcA4Q70Xfl7oPEHuHJC3MG9fZ3QbIDTWQXzY2uz/gxRonNfYwFqocIhYdSIJ1SPzFW61iJFnXTQChuOjZxE8zFyYrTTvtpjb5z/dAbUKPJOF02E22pEURrz2ySmXnlOt8A7H4dA6yHRMk90T1J+cfcyb/xuRd7lmgvzyLXlJlrQcgIjnBuQmPyZ+Zu7BKRMUA9mcJIkO4qygkMS472tSwxhAQqCbK1gnMEsTsVdtSrZmWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XNN3W/sE5pSa2TgPoy2nMr8kiPuQif8o6FDPA+HPwKw=;
 b=fhggeM3is3U5N3a2Jv2BX+gBdG2OMeaHWDV+P4BNCJ7liwWPrIaSwajBbXDhqjuG77xwUZHbttrT+ocmvlAerx+Sh2PJVbvG1ToV0Zdii8vyTm211ihF/E7weF7/cN8OzwmJJnjfZxWbRMPqV1PQLM38LIKyA/PnhXgKR2ZgpPy6GRBqw0AIsYlcO2rWf2TB6rEon5BG6TsuoPMulnz61M+Gifl+QewdHz98rSK2aaCeX870XU7KzUea8xWpLYMIvjaA1sA0nLzAuQdxUbPfoaW7AEklOYbPyOSqo2RbHeSWtXZD/xH4S5fMX8pUF73gZn4OCvg4ieB/DyYNODxU0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNN3W/sE5pSa2TgPoy2nMr8kiPuQif8o6FDPA+HPwKw=;
 b=vd+klN+xXS6AiHZBdUNFsX/rGN1/z3B1TR/pjTFSLwOD4fcqfPcdMOLqwF1bywtdZKrj0Wg87HtamJg3yvuKudMtU9frt743Z2PkbfkJ9hLOfuHYyVrVLACJKFPGX2aenTcwv1B363RhvrIhyyOzDTlkOyzGNrDr7K7K4+TRuSg=
Received: from BN8PR15CA0049.namprd15.prod.outlook.com (2603:10b6:408:80::26)
 by SJ0PR12MB7460.namprd12.prod.outlook.com (2603:10b6:a03:48d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 17:43:18 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:408:80:cafe::a3) by BN8PR15CA0049.outlook.office365.com
 (2603:10b6:408:80::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27 via Frontend
 Transport; Fri, 26 Jan 2024 17:43:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.16 via Frontend Transport; Fri, 26 Jan 2024 17:43:17 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 26 Jan
 2024 11:43:15 -0600
From: Brett Creeley <brett.creeley@amd.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <shannon.nelson@amd.com>, <brett.creeley@amd.com>
Subject: [PATCH v2 net-next 09/10] pds_core: Rework teardown/setup flow to be more common
Date: Fri, 26 Jan 2024 09:42:54 -0800
Message-ID: <20240126174255.17052-10-brett.creeley@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240126174255.17052-1-brett.creeley@amd.com>
References: <20240126174255.17052-1-brett.creeley@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|SJ0PR12MB7460:EE_
X-MS-Office365-Filtering-Correlation-Id: 05be430c-7841-445b-0373-08dc1e9647a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ogZiutZ12aVBatXQ35HD1k6ZHpasNPiKl/ClaFikaX3N62CG8IdU392UlEDOE7+VekK8p4JgU2FQnlr7QAsweNnh8NRT1M9yOj3EVIleQ+YCu0v0FIMKaG0P2YXbS3UZ+ZDIa+8Gkfwqynh6/z/2CeFOGwX3jzk6dikSU02Zcrj9d0PwGbhKWVjwv+euxr9+eZPODo+rIpF+Wauc+BTa5he3WfLq/Fbt3kmtB2qhXwn7UfeaJTr57l4xUBUsogwn+XacwDa3u1sU9saGYpuwgeVHQBTA4QHdOCY+cqlCo8bRjvIBwpDQigV9ZwEBuQnv3QIE0bc0Mo3pm9OYvRp6EuM6YkAwdC9i+Jb8XAX2DYMKs1AfThp6KjT1EgqwOTtI4+zI+5wGD/C9X0XYXfzPlUrZGYASy9zF7MCm9NLXZqb2QGdBAx2jKw9MrXW1FbDP/7GbWlfn7vVr+ppCEQvRV44rQurvtLfuUdVyFriU7tiLzCnROuPDgHvimR5cQMyltxBzy6J/ocs/ggEcoozt5utZRXC0LdPh+eaSEzWMMmFQFIxQ7nS9fUybCvgEyVA7pNaTXmt2f/EVRPG4FJvJrd66P09C0GqfqStV7yw2hxUXmdkjhaz2K0nx4pr0G4x7pRlEAMFysmhgmxIjASQlW9/TCzUfYGztvCOyvqxF9QKBv2WAYWCv25muRrHyedct/W71T/6u6rh5VOxiSN80pTlDT6qPwkybWRBu/piGtPo5Lck+LMDx8y5vG5Aa8rkl+xka66zi0XLryt3SiCQGdQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(346002)(136003)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(82310400011)(40470700004)(36840700001)(46966006)(40460700003)(40480700001)(44832011)(426003)(8676002)(4326008)(336012)(1076003)(2616005)(83380400001)(5660300002)(70586007)(110136005)(54906003)(316002)(478600001)(70206006)(8936002)(16526019)(26005)(6666004)(2906002)(36756003)(36860700001)(47076005)(356005)(82740400003)(81166007)(41300700001)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 17:43:17.4961
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05be430c-7841-445b-0373-08dc1e9647a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7460

Currently the teardown/setup flow for driver probe/remove is quite
a bit different from the reset flows in pdsc_fw_down()/pdsc_fw_up().
One key piece that's missing are the calls to pci_alloc_irq_vectors()
and pci_free_irq_vectors(). The pcie reset case is calling
pci_free_irq_vectors() on reset_prepare, but not calling the
corresponding pci_alloc_irq_vectors() on reset_done. This is causing
unexpected/unwanted interrupt behavior due to the adminq interrupt
being accidentally put into legacy interrupt mode. Also, the
pci_alloc_irq_vectors()/pci_free_irq_vectors() functions are being
called directly in probe/remove respectively.

Fix this inconsistency by making the following changes:
  1. Always call pdsc_dev_init() in pdsc_setup(), which calls
     pci_alloc_irq_vectors() and get rid of the now unused
     pds_dev_reinit().
  2. Always free/clear the pdsc->intr_info in pdsc_teardown()
     since this structure will get re-alloced in pdsc_setup().
  3. Move the calls of pci_free_irq_vectors() to pdsc_teardown()
     since pci_alloc_irq_vectors() will always be called in
     pdsc_setup()->pdsc_dev_init() for both the probe/remove and
     reset flows.
  4. Make sure to only create the debugfs "identity" entry when it
     doesn't already exist, which it will in the reset case because
     it's already been created in the initial call to pdsc_dev_init().

Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/amd/pds_core/core.c    | 13 +++++--------
 drivers/net/ethernet/amd/pds_core/core.h    |  1 -
 drivers/net/ethernet/amd/pds_core/debugfs.c |  4 ++++
 drivers/net/ethernet/amd/pds_core/dev.c     |  7 -------
 drivers/net/ethernet/amd/pds_core/main.c    |  2 --
 5 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
index fe7e1d10224c..41507ade3570 100644
--- a/drivers/net/ethernet/amd/pds_core/core.c
+++ b/drivers/net/ethernet/amd/pds_core/core.c
@@ -404,10 +404,7 @@ int pdsc_setup(struct pdsc *pdsc, bool init)
 	int numdescs;
 	int err;
 
-	if (init)
-		err = pdsc_dev_init(pdsc);
-	else
-		err = pdsc_dev_reinit(pdsc);
+	err = pdsc_dev_init(pdsc);
 	if (err)
 		return err;
 
@@ -476,10 +473,9 @@ void pdsc_teardown(struct pdsc *pdsc, bool removing)
 		for (i = 0; i < pdsc->nintrs; i++)
 			pdsc_intr_free(pdsc, i);
 
-		if (removing) {
-			kfree(pdsc->intr_info);
-			pdsc->intr_info = NULL;
-		}
+		kfree(pdsc->intr_info);
+		pdsc->intr_info = NULL;
+		pdsc->nintrs = 0;
 	}
 
 	if (pdsc->kern_dbpage) {
@@ -487,6 +483,7 @@ void pdsc_teardown(struct pdsc *pdsc, bool removing)
 		pdsc->kern_dbpage = NULL;
 	}
 
+	pci_free_irq_vectors(pdsc->pdev);
 	set_bit(PDSC_S_FW_DEAD, &pdsc->state);
 }
 
diff --git a/drivers/net/ethernet/amd/pds_core/core.h b/drivers/net/ethernet/amd/pds_core/core.h
index cbd5716f46e6..110c4b826b22 100644
--- a/drivers/net/ethernet/amd/pds_core/core.h
+++ b/drivers/net/ethernet/amd/pds_core/core.h
@@ -281,7 +281,6 @@ int pdsc_devcmd_locked(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
 		       union pds_core_dev_comp *comp, int max_seconds);
 int pdsc_devcmd_init(struct pdsc *pdsc);
 int pdsc_devcmd_reset(struct pdsc *pdsc);
-int pdsc_dev_reinit(struct pdsc *pdsc);
 int pdsc_dev_init(struct pdsc *pdsc);
 
 void pdsc_reset_prepare(struct pci_dev *pdev);
diff --git a/drivers/net/ethernet/amd/pds_core/debugfs.c b/drivers/net/ethernet/amd/pds_core/debugfs.c
index d56fdbb4cdb9..6bdd02b7aa6d 100644
--- a/drivers/net/ethernet/amd/pds_core/debugfs.c
+++ b/drivers/net/ethernet/amd/pds_core/debugfs.c
@@ -64,6 +64,10 @@ DEFINE_SHOW_ATTRIBUTE(identity);
 
 void pdsc_debugfs_add_ident(struct pdsc *pdsc)
 {
+	/* This file will already exist in the reset flow */
+	if (debugfs_lookup("identity", pdsc->dentry))
+		return;
+
 	debugfs_create_file("identity", 0400, pdsc->dentry,
 			    pdsc, &identity_fops);
 }
diff --git a/drivers/net/ethernet/amd/pds_core/dev.c b/drivers/net/ethernet/amd/pds_core/dev.c
index b237cea65a5e..7dc102a31185 100644
--- a/drivers/net/ethernet/amd/pds_core/dev.c
+++ b/drivers/net/ethernet/amd/pds_core/dev.c
@@ -316,13 +316,6 @@ static int pdsc_identify(struct pdsc *pdsc)
 	return 0;
 }
 
-int pdsc_dev_reinit(struct pdsc *pdsc)
-{
-	pdsc_init_devinfo(pdsc);
-
-	return pdsc_identify(pdsc);
-}
-
 int pdsc_dev_init(struct pdsc *pdsc)
 {
 	unsigned int nintrs;
diff --git a/drivers/net/ethernet/amd/pds_core/main.c b/drivers/net/ethernet/amd/pds_core/main.c
index 05fdeb235e5f..cdbf053b5376 100644
--- a/drivers/net/ethernet/amd/pds_core/main.c
+++ b/drivers/net/ethernet/amd/pds_core/main.c
@@ -438,7 +438,6 @@ static void pdsc_remove(struct pci_dev *pdev)
 		mutex_destroy(&pdsc->config_lock);
 		mutex_destroy(&pdsc->devcmd_lock);
 
-		pci_free_irq_vectors(pdev);
 		pdsc_unmap_bars(pdsc);
 		pci_release_regions(pdev);
 	}
@@ -470,7 +469,6 @@ void pdsc_reset_prepare(struct pci_dev *pdev)
 	pdsc_stop_health_thread(pdsc);
 	pdsc_fw_down(pdsc);
 
-	pci_free_irq_vectors(pdev);
 	pdsc_unmap_bars(pdsc);
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
-- 
2.17.1


