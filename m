Return-Path: <linux-kernel+bounces-40452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8FA83E0B1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBF2D1F23E27
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6577820DC8;
	Fri, 26 Jan 2024 17:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DqAiE/ZY"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD17208A7;
	Fri, 26 Jan 2024 17:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706290995; cv=fail; b=EBIKX0zAriVpUeVU7nXAHeptUvZ1WZ30wzeWI9ftHL07WI0L12REm+wCCsyDsdwcqJsiLnDJHTbiggI/QwhdgtDF2CidprYXQv0rFv+S/6DY7zLU55FLiiUxjSLzg0QpqZ7vybHO2fjtBnDEI59CoI6fIVcGu0hfdq6aVggrRDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706290995; c=relaxed/simple;
	bh=XQMiXJfaUtT56COvtVhZxFo1hdhPfoUV/HtoKERZ6Po=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UpglAkFkLIZqYuZJ6AQmCvySTnXyjFGUsyNh4E73Hlb6X3TGF1IGIQrgZ2sJx/qF8sXW9Cb0LkMz15cBBSXvJ8l5PJN897k1jzj8olJgk/g+fW93pon7s4LYIyKxLzZgXj4pH1A4i6YrvwX1lwLrkU8iJ72DiUBsVHoXt2qVdjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DqAiE/ZY; arc=fail smtp.client-ip=40.107.220.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=My5QMyLHGRi/mqDDHr+DeNsNJjtDz4wu5p8uDfbXVBTqW1h16TlHCmfyRNa0ADewmU3mUS2a2ab6vgItc3ZwXJ+sWM2UEl5a2hh2fQngUuo+7ELbl7qxx7daqqVa5g6LOng6aD6asAgTSWxftCgbmqwxyONk5M0BJwb8gYiBFI7/eLGyUvXntmvpGWozb3z7zO3mqWJeY5+SQYuZjPJvsJqEhPWGGJ63wZTY35bg06HLSEjYhCbEV11iV5QNWn7+T4TOrHgBFfturr7yrsdWqKwZll/UObxq7QfmBgyte+pRiB53TRkdWK0jmo+2Diej1QAKiHqSM0gz+TepvFN6sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MxgoXnPkLxGZlU2vaf/rtJlJBaW7MnSbgYX7qyp9DUQ=;
 b=TvYUYUrZGVSXCpiLopyiYbuCSSzMs4h0AMyhdzqkpL1TKaH19IaLfP8MNEFmFJ7S71Qb7fhefOxut8iDAL3SWo1H9a+E6o0uzCCImfP91aLptfrAJJL7Sp+A1FGSYX2Z7bAkW/fXrmNoynSFeeAMapDFWyFA1BF0R/Dja5TBvVfxEtvh6zEVqOGSVqe7tfPgF1Gwm+pgZMJLAeWa8JV+dB2igFH+lBEcngjA4GsxjdkDebAaSxjUq2UFelQvFbqwYh9PqZk9Jn1Yv64bWYbldNoHL+/z5o8mlReMMMlur1tNYuIfWscPSCXRonRkz2Wc+umTlU1tOjRPrWlbng6j7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MxgoXnPkLxGZlU2vaf/rtJlJBaW7MnSbgYX7qyp9DUQ=;
 b=DqAiE/ZY/rJJKXeM1+fc4d+9vqrwLX6f36F2lWU46etOa5jkEAs60hB6lloqCCprlnAbaE5W/vxZWiJWNKyfOjMJh6wvYVPh2DjW74HlaZ9+UJ5/a1YHi98ZT2UZSftZnrC3vBtERlrLc98mJEhs/PoqZkmrQoGVL+jxpp7KHzo=
Received: from BN9PR03CA0633.namprd03.prod.outlook.com (2603:10b6:408:13b::8)
 by MN0PR12MB6197.namprd12.prod.outlook.com (2603:10b6:208:3c6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.39; Fri, 26 Jan
 2024 17:43:09 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:408:13b:cafe::da) by BN9PR03CA0633.outlook.office365.com
 (2603:10b6:408:13b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22 via Frontend
 Transport; Fri, 26 Jan 2024 17:43:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.0 via Frontend Transport; Fri, 26 Jan 2024 17:43:08 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 26 Jan
 2024 11:43:07 -0600
From: Brett Creeley <brett.creeley@amd.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <shannon.nelson@amd.com>, <brett.creeley@amd.com>
Subject: [PATCH v2 net-next 01/10] pds_core: Prevent health thread from running during reset/remove
Date: Fri, 26 Jan 2024 09:42:46 -0800
Message-ID: <20240126174255.17052-2-brett.creeley@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|MN0PR12MB6197:EE_
X-MS-Office365-Filtering-Correlation-Id: db6a6493-ed05-4418-a22d-08dc1e96424f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5UErYTCJmrGAhcW/NXEFc4e7QDxfQZEHU1CR7zxs1OMMbGUZf8QUFrkdR4m+w0PWw+Ete7oTQ/Ura8VI6LMkbEwNYdcvxBQlFSSTdg4vxLGvPlPYOYj/5i87uC3qRemJdu01Tb8X85DSBNswEMUH34ayPJKK4+R0s+gul+WpZXTewqYvy0nzY0fhh4RKzNz8SKT56pT3bIn26qokGEzx072pL2jFkKz9JdHbvN5VSNifslm563Xy6/pwa7QTiegIEF52B0pzdo32uJ2cY/Y3wjzaFZofC49segKPkINvgE/GpBdZYK9kIQXP58v/QPh8JMbPfG8N1glBejZAIRRZIa4SYHccqes/lCoP540K01QSl/JQPITWZCYAVuRjPVgTLwcsHX+PzUMq5MbZgPRHfz+Vimkc60ju8ittETediBmeS6rhkdKcfuV2of4XSZHS0DLnNr63XIdSTUH+st6uVNZmpOXhGMhCkIivwhTzaD9WJeFvg7lzA8GOExf2wAncYDzjomgMepayi5v/XdAErgjRueT7WE5ciiBclcUJDfBZ3oOjkbqz0V3zgbexUfzsQeTzaDl0iVkKpL12e/7x26eCMNkGaUuzoswpu06gnSjrW5CW13Z9yEPYCY/mecvdKMqaAmnjOi6sTpdsu0Jao5tth/3EH25VL4vdg+Bx0CwOK2WgZi4XUz1LbzHEAAyWxImZ8GCaSaoFheGySdqZQsAdUFpa1j0eDJZae0QgtSbb8JadTokj8dPdzUjurVbQyCssxX7Ki5/t+dP0sxGGnQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(346002)(396003)(376002)(230922051799003)(451199024)(1800799012)(82310400011)(64100799003)(186009)(36840700001)(46966006)(40470700004)(40460700003)(41300700001)(83380400001)(2616005)(16526019)(47076005)(1076003)(336012)(426003)(82740400003)(36860700001)(2906002)(8936002)(4326008)(8676002)(5660300002)(316002)(70206006)(6666004)(478600001)(54906003)(110136005)(44832011)(70586007)(26005)(86362001)(356005)(36756003)(81166007)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 17:43:08.5741
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db6a6493-ed05-4418-a22d-08dc1e96424f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6197

The PCIe reset handlers can run at the same time as the
health thread. This can cause the health thread to
stomp on the PCIe reset. Fix this by preventing the
health thread from running while a PCIe reset is happening.

As part of this use timer_shutdown_sync() during reset and
remove to make sure the timer doesn't ever get rearmed.

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


