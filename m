Return-Path: <linux-kernel+bounces-43634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5872D84170C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 00:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2353EB224E4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 23:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB21253805;
	Mon, 29 Jan 2024 23:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="h4PmcMTs"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2080.outbound.protection.outlook.com [40.107.212.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1942C6B0;
	Mon, 29 Jan 2024 23:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706571655; cv=fail; b=u3DrRheY6raUrZW+VArEmGlKAlgrHRFQwphoLkve97XasX4Axayipbuna32aR4ulZmjahLAB7KTqz+5Opm7Qi7+/LYKW+huQgQOGJnS/G+5BTFz7uuTanSrHR27AMWkqV35Be8/VQmi9x+3UOLBZDehn87fWHMMtKIBf4h4VR3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706571655; c=relaxed/simple;
	bh=7/ucZpcRNdOrnhVPrdwqXpsmiAfysoeMNYzxUexZnNI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tJKyGqPpMHROEa9ikoRtfZdT9qQJk+bR46aKoGMgElmhyxQoPVOhUBgn1akxQxgAb4AjgSbCcKiGhAGaOFvDA3FbiHAV1gjeWfvlRrJ1G4iQpoxGJ0L0fEjYjbYUoxVs3RvBIledVoaqS9A8TWUa8BqdgehEmFG1iMdxUgPY9Xc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=h4PmcMTs; arc=fail smtp.client-ip=40.107.212.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ldB4qT6wDjafy7OKCPD9WqgAN5quRc2j/uQxzhCF+TIqd7TaYc0Hc8tqUiLZYflUVjnwSxhj58lsTMIwhBZnKjrFE23X6lOg7RH3joIkxU3xdgGAkiuQxqXNplO3HL7hFaDiZGdlqDQbLmUZ6TI/MRbDcGx2PiJrwDCi1BwTOukZGjFdLZ4dMVEGjrGyqjORv9IV2tGEZn9KKyDYhoAi47xnhRe8cWI07K5lW4rb84oRyhaVL2XJUi25cFZ8tIMOioEZRAwcfO6j68lL0vgbMveqkP/NPp2x64NMcD0uX0KNk0FKNiziv+Y31oZ5+gEbPpZAbLCYNbLaZnAnpMFX4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8p169SCjE2MOc00pmBU11pERn8QW/VgQ3FaB6nmUSY=;
 b=g55S3kDJWVxi/AwW7hU8XxhfPQqkNK5vcM/sadX3OLakApYT8FbW3kE1suvQro+zzse50kx15LwxYTuhNdRUIvSEPa6sKLFkGNOyU7hwg5eqe9vuHO4BWOAKgAsJvb432ak+25y37zuEo3p/GfFPmyi0uFXOOxdHnCy3Cie/T94G8JHUJ3LxC6NOF7O3SIGLxPbppE1Uws+mzSPDXQ3TNmrHp4BCdxDCl5TQxjH3M/naLpT+Qb+fbNy824V3TMdFB+W68HFFC1ia0nWeX4u4FTGSF+VL45T13zSMGd/9hpQuKGCSCnqyFGYjFq+DZ2CCUJCk8uyd58O773Xrt+syEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8p169SCjE2MOc00pmBU11pERn8QW/VgQ3FaB6nmUSY=;
 b=h4PmcMTsNSDE+UUlrrPvaTZMR8VEWCcD5eNHcRZSKZQIW0hXzslRzdSkATmo/60+YdUSL8YeNyzkMWZNNVQ9tUfx0lpFQ2ZfUjuEOc/1DsKyBM6PKFatA2cDxortv1IF/JGxM4+rX3uxlZgCk/F90t/2Ux3Xmi5izTHAD+Z/cSA=
Received: from CH2PR19CA0001.namprd19.prod.outlook.com (2603:10b6:610:4d::11)
 by MN2PR12MB4536.namprd12.prod.outlook.com (2603:10b6:208:263::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Mon, 29 Jan
 2024 23:40:50 +0000
Received: from CH2PEPF00000099.namprd02.prod.outlook.com
 (2603:10b6:610:4d:cafe::57) by CH2PR19CA0001.outlook.office365.com
 (2603:10b6:610:4d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32 via Frontend
 Transport; Mon, 29 Jan 2024 23:40:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000099.mail.protection.outlook.com (10.167.244.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Mon, 29 Jan 2024 23:40:49 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 29 Jan
 2024 17:40:48 -0600
From: Brett Creeley <brett.creeley@amd.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <shannon.nelson@amd.com>, <brett.creeley@amd.com>
Subject: [PATCH net 1/6] pds_core: Prevent health thread from running during reset/remove
Date: Mon, 29 Jan 2024 15:40:30 -0800
Message-ID: <20240129234035.69802-2-brett.creeley@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000099:EE_|MN2PR12MB4536:EE_
X-MS-Office365-Filtering-Correlation-Id: 1023f4a2-c05d-4ca1-ca72-08dc2123b98b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PR2esT3wn4SfeYUn8NWznb5Fha9h/HIPaQTRjQiemmrcP5Kd3bBtLj8LxW4FRXnmxvS3JKZDYWE4AYEisoSnPfLMQ0uhwGrEdNaMmC5hTLQm+TG/Q8f0xyIls4SA+NIzO3ScDqJ5LjgSla+nexBjs1mq95kKG2d95PRzo4bjFiPZcmNq/CAQ+fxrr1R8bkEdPyWGijmid1s/Uv5mw2Ienm0g8R10N/Qyia2Wyh+eaKIuKQqyJoUV8Mo2vZ7lZ0mnoSipE+JDRND7cQLgzwfpwoPaJs18bla9pxRb6w3oRx9OKsGRwwca8DeAnQ00QDbBs5XPTN0C8KoARlydNNg+Xj6mI7jNeoU8Xgp8l0Tjd+jpUcJPbSq0S0vDfxi17GATTFvjNz1ryPic4zxJE8DNT50XRA3GVCf/CImW6wx+VVIg6i3j26gH1p91HnmtyPXxTuFEWOkyvoBnqNI8AZz5Qhkd64suciuykPCpYVVa74JaQtP/eVfKwKht/aRMARuB1WhDtKgNIcphveNxlbuX/TUcEzR7r50ck7EeDDLFf1RahTNrkmKCmKubYfVKqDuv5niXLXV0KBYI5NBUluXXN6RUogNuu5MvAVvCITNe4c8wbBYwzbAwQhmiJsxCU9UhSCtBVn5oYmnFGGxliRhA6DP9B35hgHSiAdB4yOVNVjnH83VfAt7VYAxzwCtYqlXsBEH+XhhYe7gawN9W3pfYwIFDhEHdm5f4RieDdsYfFw/dsasUo6Ug+4/uOFrYaxMBr5C55mDBPZPMzWQecBZgNA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(39860400002)(396003)(346002)(230922051799003)(451199024)(82310400011)(1800799012)(64100799003)(186009)(46966006)(40470700004)(36840700001)(26005)(6666004)(1076003)(2616005)(336012)(426003)(36860700001)(83380400001)(47076005)(5660300002)(2906002)(4326008)(44832011)(41300700001)(478600001)(70586007)(8676002)(110136005)(54906003)(316002)(8936002)(70206006)(36756003)(81166007)(356005)(82740400003)(86362001)(16526019)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 23:40:49.9817
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1023f4a2-c05d-4ca1-ca72-08dc2123b98b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000099.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4536

The PCIe reset handlers can run at the same time as the
health thread. This can cause the health thread to
stomp on the PCIe reset. Fix this by preventing the
health thread from running while a PCIe reset is happening.

As part of this use timer_shutdown_sync() during reset and
remove to make sure the timer doesn't ever get rearmed.

Fixes: ffa55858330f ("pds_core: implement pci reset handlers")
Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/amd/pds_core/main.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/main.c b/drivers/net/ethernet/amd/pds_core/main.c
index 3080898d7b95..5172a5ad8ec6 100644
--- a/drivers/net/ethernet/amd/pds_core/main.c
+++ b/drivers/net/ethernet/amd/pds_core/main.c
@@ -293,7 +293,7 @@ static int pdsc_init_pf(struct pdsc *pdsc)
 err_out_teardown:
 	pdsc_teardown(pdsc, PDSC_TEARDOWN_REMOVING);
 err_out_unmap_bars:
-	del_timer_sync(&pdsc->wdtimer);
+	timer_shutdown_sync(&pdsc->wdtimer);
 	if (pdsc->wq)
 		destroy_workqueue(pdsc->wq);
 	mutex_destroy(&pdsc->config_lock);
@@ -420,7 +420,7 @@ static void pdsc_remove(struct pci_dev *pdev)
 		 */
 		pdsc_sriov_configure(pdev, 0);
 
-		del_timer_sync(&pdsc->wdtimer);
+		timer_shutdown_sync(&pdsc->wdtimer);
 		if (pdsc->wq)
 			destroy_workqueue(pdsc->wq);
 
@@ -445,10 +445,24 @@ static void pdsc_remove(struct pci_dev *pdev)
 	devlink_free(dl);
 }
 
+static void pdsc_stop_health_thread(struct pdsc *pdsc)
+{
+	timer_shutdown_sync(&pdsc->wdtimer);
+	if (pdsc->health_work.func)
+		cancel_work_sync(&pdsc->health_work);
+}
+
+static void pdsc_restart_health_thread(struct pdsc *pdsc)
+{
+	timer_setup(&pdsc->wdtimer, pdsc_wdtimer_cb, 0);
+	mod_timer(&pdsc->wdtimer, jiffies + 1);
+}
+
 void pdsc_reset_prepare(struct pci_dev *pdev)
 {
 	struct pdsc *pdsc = pci_get_drvdata(pdev);
 
+	pdsc_stop_health_thread(pdsc);
 	pdsc_fw_down(pdsc);
 
 	pci_free_irq_vectors(pdev);
@@ -486,6 +500,7 @@ void pdsc_reset_done(struct pci_dev *pdev)
 	}
 
 	pdsc_fw_up(pdsc);
+	pdsc_restart_health_thread(pdsc);
 }
 
 static const struct pci_error_handlers pdsc_err_handler = {
-- 
2.17.1


