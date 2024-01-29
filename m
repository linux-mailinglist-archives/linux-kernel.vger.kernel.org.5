Return-Path: <linux-kernel+bounces-43640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D444A841717
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 00:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AA2628748E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 23:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD2715B11C;
	Mon, 29 Jan 2024 23:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sAdhE35i"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9758B15B0E9;
	Mon, 29 Jan 2024 23:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706571665; cv=fail; b=Q+3LMH/16jpGpRx6tlovDkJL0jyiLB31pTg5oILIfdP9Q/SHqxil2O1NqQRDT1IGOunnSvgwCSaagFqjr16CuyFEoyBI+zB7ybokgmJvcTzgSJ6IzbknOENwNpWGX5xeMujcGk1VQeboCyAfr/t03t6uooU+8T63nIy7uhAXGac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706571665; c=relaxed/simple;
	bh=kAbiPAPiUUF1HdZwMDCEif9mPkAv22BEx4ggATOOqWQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z/xqsFDwyFbm1QSjkkglPBNTsbo4U+rJuy3iK5TWYRCq1jLEptLt6nwPFx5DJm76bt+e/GKWh2KsTeE7OZPad1LSnmKDjNgtS9zYS0eDIQS+Q5nBbzGECw8ORASGCEucbuEOKs8N8JAwENZjmPcHe0V3V23jCjEz4v8Bc37WDtw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sAdhE35i; arc=fail smtp.client-ip=40.107.223.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=axUOJaSLkWVRylhnyrd0M/RCFu4Io9EFpUv8Rtm0bqaXVegfZaOJbnFJKsyTz0w3gcl1p24wcrENtTzWhN9Akz4scjgfZT5J/XwMyCR0mHUmN6SojSd8DiUMK4mKvO2yISVSj3OrdIJBR8ph/0o0ood4olY2Hn4SDCqFNY0JS9YSYiOJiFwZDt0zV/Qdtq9O9hHl9IJL1pwf4GH4448qC1zBzHBre0ps2jMO3pMVvFwdh/3nCvgAQbw8Hvv7aGOhB71WTwH5FCvCFxODumAK2dTN0jf9uCpYbZKz839VWziVTfgcScurBxKPTYI1XCc+4wuSz3lkgbRUADM1IkX/Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qlMZ2kmqsrNMYSMuguAx/DnwQHh9k1F0G+qJJCfFcjg=;
 b=iv99nT2GZzTnVF8DnJhdzhnkMK01LsiFUiOeq1nXYbOhMf4rCPjZzpLDnnBjcJ1yu4kL6/rGuNiGgpWmB0l/ufKMQFHubn5qJHaVqO4dieuj6d7QEIOLMn2BonXAsE0YHPkFVxqEDM8Sfti10AuAEsNk9Gmg7sZD+aDbrj8NF2jbr90KYTrf99l5FXZB6gKa+G8r022u24ArKSS6sbHogxb1dMpSnOhXdZIclngtVQ5JWcWA25bU8GsWZbFx9EFshBMTrPrWmWh+K2V5kSXQuc6dakTIZVksbBK/+3xRWGas51/MtNl3t4slKeEk24MKjnumAcSFGJoYTSW8tIohRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlMZ2kmqsrNMYSMuguAx/DnwQHh9k1F0G+qJJCfFcjg=;
 b=sAdhE35ihgp8EXWgYMPqOxGv5acX+16zx1rTnYdqdCqlOszUhesvTChbHMuFzbIqNQD7gXuKvm38l8pEOSZCl/3KXaTTcfs/MXjbr3bqldhhDGDGP2PxGTu1U0mY6RMOuoES3Ru7RVx3LAs2pZ66y147VJi18plAfIgXQdaz9Sk=
Received: from CH0PR03CA0035.namprd03.prod.outlook.com (2603:10b6:610:b3::10)
 by SA1PR12MB7198.namprd12.prod.outlook.com (2603:10b6:806:2bf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 23:40:58 +0000
Received: from CH2PEPF000000A0.namprd02.prod.outlook.com
 (2603:10b6:610:b3:cafe::e6) by CH0PR03CA0035.outlook.office365.com
 (2603:10b6:610:b3::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34 via Frontend
 Transport; Mon, 29 Jan 2024 23:40:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF000000A0.mail.protection.outlook.com (10.167.244.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Mon, 29 Jan 2024 23:40:57 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 29 Jan
 2024 17:40:53 -0600
From: Brett Creeley <brett.creeley@amd.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <shannon.nelson@amd.com>, <brett.creeley@amd.com>
Subject: [PATCH net 6/6] pds_core: Rework teardown/setup flow to be more common
Date: Mon, 29 Jan 2024 15:40:35 -0800
Message-ID: <20240129234035.69802-7-brett.creeley@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240129234035.69802-1-brett.creeley@amd.com>
References: <20240129234035.69802-1-brett.creeley@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000000A0:EE_|SA1PR12MB7198:EE_
X-MS-Office365-Filtering-Correlation-Id: eb199083-4905-4328-03fa-08dc2123be51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5ro93ffGEhOhf7nUf+yex/VlHz6nw10h6RaPKn61KAqoKbAObutKJnDOElklNPnX0Lxn4icFF0IMvOWg3jdW8DkpYbSlX7DUehr9H0IzyfnOYeKi/qYVtkDMBkwtM6HDV+G6sB0UT7sodZ6Hg3YUUvk8bXRdor93xQ8CRu4+xPyTkIi48EE4noChBkXWTn3diT2+WEgaJSbEujUMXMh5Bf0DfhZNwtCla05dPECyXdZcj0E1+8L1DQnxtR2Z2x7KLilBrqGwCdDtVfcFcMg+4lWW2Szxxm04ySpFo4JVhmweFyA3/X89bPjxl41HwgmyYehMInt2GjJ+71GHw8vFG51KUmHPBT++vfQ3b6S6t5bCrSaXxrbu4apngWVkWX1Q+EBh0IAT6jYqTDoXJJCAZpC34v+Sqj0bljprIb1kHRq4KhquuYEURKTXbJboyYGOB8Xq6XIKJvZb8HoIx/BaHAu+skP6ihHNTdhZ+uAQV9sOuCthbro4KYqSHg9vcyL9v5Y/rVRte1IKsgSpiTu2fKqP28nGaKWaazcJlnTAl8TF2mOAkakqTCLHECjyiNkkf+3Nr81Ow+bf8Q3c9vzitHUngGFJmc2iOA4Kot+RE9MLlMB3eZ3+0kdplNyiQrggb6MdAdEK+fgZlZXayvL1nDCbMjOFJCZspvXcLP2F1M/Wgzdy7vgOC9cu2dXNJV65IIDvxOYMtME9b3Ju33gL/fxdqiMPdu+JgInnXQrTbM9in971Gk33BQtvuvJ3LNn9GVReTC3oEBL9NIVy+z0ZGw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(396003)(376002)(136003)(230922051799003)(64100799003)(451199024)(1800799012)(82310400011)(186009)(36840700001)(40470700004)(46966006)(41300700001)(2906002)(36756003)(1076003)(316002)(47076005)(70586007)(86362001)(110136005)(40480700001)(83380400001)(70206006)(54906003)(478600001)(40460700003)(2616005)(6666004)(426003)(16526019)(5660300002)(356005)(4326008)(8936002)(336012)(44832011)(81166007)(82740400003)(8676002)(36860700001)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 23:40:57.9851
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb199083-4905-4328-03fa-08dc2123be51
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF000000A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7198

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

Fixes: ffa55858330f ("pds_core: implement pci reset handlers")
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
index 65c8a7072e35..7658a7286767 100644
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
 
@@ -479,10 +476,9 @@ void pdsc_teardown(struct pdsc *pdsc, bool removing)
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
@@ -490,6 +486,7 @@ void pdsc_teardown(struct pdsc *pdsc, bool removing)
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
index 8ec392299b7d..4e8579ca1c8c 100644
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
index 62a38e0a8454..e65a1632df50 100644
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


