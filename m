Return-Path: <linux-kernel+bounces-43638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD5F841713
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 00:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D93D01F22ABD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 23:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BA751C31;
	Mon, 29 Jan 2024 23:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FnYpi42R"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2078.outbound.protection.outlook.com [40.107.100.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCA454679;
	Mon, 29 Jan 2024 23:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706571660; cv=fail; b=jEiblpmsdYz34l0XsMZYB34AstvEcGmXEkqtu0emx4ObBe5/xCBC4yU2Jh40nIwzfYW1YpfK9AEVI/lm9BAz93xS0bWVHuL2Ux50agn2h1AgSq3wAomZPgDngp7WIzKAD2bgYQ7Qn1NZDwuMSBjqWvbdMNOAoqfWYfnB9BC/NyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706571660; c=relaxed/simple;
	bh=TsFwYpFOV65WkgHSuOCbyDtOFGXgbFYysP1sAVDht9E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C0c+3UcBaqYdFavi7irY3ORAXQy0cS92LBHsh9/9JjSmPtB+q2zQJxj21Q2PXCNpaMGgT3qxDn4msD13dHT+3WguA/vv4UK79cRwUXpCU4wN6CP6OiZjpbChPgO+w+pOJN76IsQuqcX6PYQ6xnBJi4PsmN2cRut871zD8K9RQ3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FnYpi42R; arc=fail smtp.client-ip=40.107.100.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TkjGapJtrB0fmyGHCzuIPTOO0K8/JZQTQONPRSmqKvpzivLslKoUM0Xb90240LYFMpyUxsVxD8DnWCGb03iUsQPjxqk2rNWf+CURSbHGsokaSglpOjoxxJ5H4BSvG2PpA9I8mDX9sH/WE8tsMDYR+oLPinRpfeLF0tdTQ2MLWULWbmbkgqRWl/xpdkQGjLUjPnXLQgw+It/SBJBS9h9li7g/ielf75QOIOYs3HWC+jptWddQzoQxyYqP9VjYIS2JXDkRzVFKoWIT6gTosZAcFGLPSuyCSGJqFrPiW1kWhyEl0BFkQXdEuSHHsj/MJnbkcEZm30NhPQ2l1LH4D6xwvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k80hsdxzvIoW3vqyVUQ6xskcO09r9K4MbWAaK93VKhQ=;
 b=YNRPY84tl/qGj9q8Iuki/etqdG+nWlx4OAT8l8wSpksibvy5quOfaCj8o8a7fre7kXZcgY5/E/2tr5DRlSwV30FzPE+m9yKembKwwIePEOf1RJte6NSsxP7+kRiJ6VYzDNaoZWzc+OJUu/PC0Vr7tokLSlJIhDCq8DN3RQvOykwFaKdlRD635zzglKiSTotzT5tRzH16afdALYdnC8PYreFujvlAtdBf4dlMpRPGFXj1wcwZgzGvIMOUo3kgtf2dtW5pdStOOwC/lPA/vpHdoORLuhoOIrHTc2AF88INLZyzK+AL9bz2bhAhHvvrHz48cy9M/MBHqV4p65hSE+osUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k80hsdxzvIoW3vqyVUQ6xskcO09r9K4MbWAaK93VKhQ=;
 b=FnYpi42RAYM5zyQd8sSKSYCWlDy3QMm17ZCZFs84e8GuYGid17MCLACz4ZlL4Sde8xUIAaCmFI4B6bHbDpDSFApsBPJijUW6agJcVdbQP6uLUEZovXp8oSTh7scQOoW0f02tLoveu7UGVA9EaMyYeB4Qoti94AzEIVaSFC5k4gc=
Received: from CH0PR03CA0035.namprd03.prod.outlook.com (2603:10b6:610:b3::10)
 by BN9PR12MB5113.namprd12.prod.outlook.com (2603:10b6:408:136::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 23:40:54 +0000
Received: from CH2PEPF000000A0.namprd02.prod.outlook.com
 (2603:10b6:610:b3:cafe::e6) by CH0PR03CA0035.outlook.office365.com
 (2603:10b6:610:b3::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34 via Frontend
 Transport; Mon, 29 Jan 2024 23:40:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF000000A0.mail.protection.outlook.com (10.167.244.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Mon, 29 Jan 2024 23:40:54 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 29 Jan
 2024 17:40:50 -0600
From: Brett Creeley <brett.creeley@amd.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <shannon.nelson@amd.com>, <brett.creeley@amd.com>
Subject: [PATCH net 3/6] pds_core: Use struct pdsc for the pdsc_adminq_isr private data
Date: Mon, 29 Jan 2024 15:40:32 -0800
Message-ID: <20240129234035.69802-4-brett.creeley@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF000000A0:EE_|BN9PR12MB5113:EE_
X-MS-Office365-Filtering-Correlation-Id: 09b57fb8-bc0b-43b6-0b19-08dc2123bc10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DOJ38Qo8n8Dw84NXsfnSQ4Tn2YivYt/n8THLzbNTXLJQj8E3Pfdb9yCwr+dqdsUyhmoBq86afwiolf7p6PWFNLJtIjNgtbM2tgg+XgDOzD26Zosku4Xy2ybBd3jZ4K2zumAClACV2rUsCE92icPhstafk69F90TEUIYQWIgz99QOz21tZV969URRSaWeOYAb6rY8GexpVshUSL1MsPUP+rnOe4b5LXEFYKHNw3bZVVVvxzXJsQBFq/Dq96wH5Hx5oB85nkfeUK7dyt7CjA/KSFqVneqNHozFDhGf7Gl+/bdf6AmzzxtWNGsf0E7xyzy5Alp2ug96V/Lc3Rff0rFC5sGSXpuYmmjVTfRp1k4iH/IEfTUuhXRv0N+pj92BHoDr/KhuBfRAlvXECD1xqO/OH4f76AZv1mtLJx1IfRT48aeDrhdXqZeYeiiamUKPt0OXQTfhmAdJ9lgnQrR+SCBG3PbzGkmE22udpmzcwlyVOKSPAZ9T9ypa7FccTMxSu5OR6WK8YUmtZzWTRwL4zJVnT7qhvvUkSL8XcJTbEseKDWZ9zRxqgWBKGhTiSIZNi9vK6EmM4EVyfGKQS7viqbYMkjt4e+se7+fm13gK/2v+SOe5skpLEgTpGayh2UOKq00wVUyWAK+7gHhnvbip11w8F8VpDT2gzh5iwFn/ET/sl5aKHXHWEn4+/FJdKc6/82HwpWVVJ6JmaE59CXA+7yqkQFW5y/0+l2+LW+94tGs05jzYbIpem/JtDyuVsOtlrA4keK5N415dZV0uFoRTslO1tA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39860400002)(346002)(376002)(230922051799003)(82310400011)(451199024)(186009)(1800799012)(64100799003)(46966006)(40470700004)(36840700001)(36860700001)(47076005)(316002)(83380400001)(36756003)(54906003)(110136005)(70586007)(70206006)(86362001)(8676002)(8936002)(26005)(4326008)(478600001)(1076003)(16526019)(6666004)(2906002)(336012)(426003)(44832011)(5660300002)(2616005)(41300700001)(40480700001)(40460700003)(82740400003)(81166007)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 23:40:54.1882
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09b57fb8-bc0b-43b6-0b19-08dc2123bc10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF000000A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5113

The initial design for the adminq interrupt was done based
on client drivers having their own adminq and adminq
interrupt. So, each client driver's adminq isr would use
their specific adminqcq for the private data struct. For the
time being the design has changed to only use a single
adminq for all clients. So, instead use the struct pdsc for
the private data to simplify things a bit.

This also has the benefit of not dereferencing the adminqcq
to access the pdsc struct when the PDSC_S_STOPPING_DRIVER bit
is set and the adminqcq has actually been cleared/freed.

Fixes: 01ba61b55b20 ("pds_core: Add adminq processing and commands")
Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/amd/pds_core/adminq.c | 5 +++--
 drivers/net/ethernet/amd/pds_core/core.c   | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/adminq.c b/drivers/net/ethernet/amd/pds_core/adminq.c
index 5beadabc2136..68be5ea251fc 100644
--- a/drivers/net/ethernet/amd/pds_core/adminq.c
+++ b/drivers/net/ethernet/amd/pds_core/adminq.c
@@ -135,8 +135,8 @@ void pdsc_work_thread(struct work_struct *work)
 
 irqreturn_t pdsc_adminq_isr(int irq, void *data)
 {
-	struct pdsc_qcq *qcq = data;
-	struct pdsc *pdsc = qcq->pdsc;
+	struct pdsc *pdsc = data;
+	struct pdsc_qcq *qcq;
 
 	/* Don't process AdminQ when shutting down */
 	if (pdsc->state & BIT_ULL(PDSC_S_STOPPING_DRIVER)) {
@@ -145,6 +145,7 @@ irqreturn_t pdsc_adminq_isr(int irq, void *data)
 		return IRQ_HANDLED;
 	}
 
+	qcq = &pdsc->adminqcq;
 	queue_work(pdsc->wq, &qcq->work);
 	pds_core_intr_mask(&pdsc->intr_ctrl[qcq->intx], PDS_CORE_INTR_MASK_CLEAR);
 
diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
index b582729331eb..0356e56a6e99 100644
--- a/drivers/net/ethernet/amd/pds_core/core.c
+++ b/drivers/net/ethernet/amd/pds_core/core.c
@@ -125,7 +125,7 @@ static int pdsc_qcq_intr_alloc(struct pdsc *pdsc, struct pdsc_qcq *qcq)
 
 	snprintf(name, sizeof(name), "%s-%d-%s",
 		 PDS_CORE_DRV_NAME, pdsc->pdev->bus->number, qcq->q.name);
-	index = pdsc_intr_alloc(pdsc, name, pdsc_adminq_isr, qcq);
+	index = pdsc_intr_alloc(pdsc, name, pdsc_adminq_isr, pdsc);
 	if (index < 0)
 		return index;
 	qcq->intx = index;
-- 
2.17.1


