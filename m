Return-Path: <linux-kernel+bounces-40457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B5283E0BD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 353AB288495
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DB6224CE;
	Fri, 26 Jan 2024 17:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="s+2XPMlQ"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320A6219E0;
	Fri, 26 Jan 2024 17:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706290999; cv=fail; b=rfqPQbedfhMl0m+0oWPSAIp7RjQXQupZ1tyVw5APqsAyHRtHK1y6NJmn51E+E9/8wKfuFG8OpRTakQKnQQB99mvpP9oakcidyTUKEHAM/rFWtgnOgpf5We1fv7L4E0SmNjKQ+7znQxfcvqGMbJM/j9gVyXyDG2Gp5MNOELqWUsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706290999; c=relaxed/simple;
	bh=VqWB1kkSrvJyzbf+GfkH9BEeo9DF45blLgCZVzfVck8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oNHkC0pX1uols7ipNqjhBaLz19J9cdJJ/m9ku6WZ7e3kd/ungssLqDpQ8nLBIHVTCgtRFYvPEYHkTZu/Wzo1jXNn4Ua+XrEkxcRZ5g+OKJ7zsezQVsH4WgWkCVt0bMNcWS1BfFgIbU4KrqQ4hwMeXTF8rzX2DUmzvs9pLEAbAig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=s+2XPMlQ; arc=fail smtp.client-ip=40.107.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AE2rYYuumi1kFBwWF92EgLejgO8lWtdVenoQ8l3TkvOJ0KqZDhnlLvrfuYYQDSdgo9ni7JnyVADwj03sxFOjKpzspzl5d7zURWnt90MSZBpqNVqpEht9brREfhmIO+Ffa0pwq3TzxtPdanEatYfImtcnUxkyeXQEERfekkLge+S22nTWcPOj1TTAP5+XVHgaxLcwfqrdZ5KRqPf+wLb5EH2K7Aopmtvr5R03WelmUGs6B9oi5nA2ISWghUI29XdO8DVZg70saBzRPmy7J3jVWhDWqURSDkhIjmWCvUA6Vm+LiIBimshw07dSqF4eoRqmvXbTKAN8ybejDKcVkRO8Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VK48TDjo5Ij7e6tm+AyS2U+SvbbvXi4xGAc71IdoQKE=;
 b=du1jJcErbUJAH6PgPPIi7DWPY5RsPBf6qzVK82nUGyAjKEqLvweKc6KrLrf+rAXiebmNewL+qrx292k8NrJFsHKKNxpG6Xuub3XCQdjxGNhHYlmgB8YkvlOyXzRfN5xxbaTl5gxqzSL9nvbCQ8+dAMP5GB2zm0GPlWOul6d7cCPcQRNIJVIew63GqfeHRC8XczEm4kiiztZlnML75gCl32Kjcr2P/RX6j2ucrAHBs0JTuZDVU7Jv+5UHXVWE6o43pik7f/RhDGdWMELER4+Y/BkQXvKHiVFq5YuZK6R9dliuoaL/9E3MEIB0/XEeL8DxdzfOAIXHOPLeK9cCvQ6VHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VK48TDjo5Ij7e6tm+AyS2U+SvbbvXi4xGAc71IdoQKE=;
 b=s+2XPMlQEnv+bG01GmZWshIpmuw0gUXUg8s5BGxwl5q4bOWgbLR3BlAy6c/8+ZcEASC9zwPU0Wx3x+GwsQEAvCn5uzCDWlyIuZCN0gWxBPlY9XKjMP6OOlKw5XfMCIKJJsHeW30jJEh49eSuKAsfKRYVM3bnHGmZM9scRjcqdjQ=
Received: from BN9PR03CA0365.namprd03.prod.outlook.com (2603:10b6:408:f7::10)
 by DS0PR12MB7828.namprd12.prod.outlook.com (2603:10b6:8:14b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Fri, 26 Jan
 2024 17:43:15 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:408:f7:cafe::97) by BN9PR03CA0365.outlook.office365.com
 (2603:10b6:408:f7::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22 via Frontend
 Transport; Fri, 26 Jan 2024 17:43:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.0 via Frontend Transport; Fri, 26 Jan 2024 17:43:15 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 26 Jan
 2024 11:43:14 -0600
From: Brett Creeley <brett.creeley@amd.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <shannon.nelson@amd.com>, <brett.creeley@amd.com>
Subject: [PATCH v2 net-next 08/10] pds_core: Fix up some minor issues
Date: Fri, 26 Jan 2024 09:42:53 -0800
Message-ID: <20240126174255.17052-9-brett.creeley@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|DS0PR12MB7828:EE_
X-MS-Office365-Filtering-Correlation-Id: 19264248-ac0d-4d1f-dcac-08dc1e96464a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	k7IRl+CjilliTT6of8NxJvZMBAQTfNwZNUP/xXR7AhcvV/p9lyh3IKRkWnnoyCPP3tMrzK1UNr3pOn3epzjXKBkibvDSKyaJ993caUYzrAo6cOyeEIgHOYrhoXQS74eWls0pMiSvQl/JzSba+rwMzwhr2dCBVglQdEsAomwfT/OMOzkFPlj9P62YmPOWm0MI/w9Gn/D4Knb5YeY3bRVnfIjwl2/akUHTWbgkotLjbs+qIGY44ivxkuhthyCD9vNPqFdpidVedPlmBQW+W7ThLqPfRuj8mQM15lSlu1kUX/2/nYTU62AO3OVayQlp4WOKti9q+CZKUcisXiSt/iLUCWmx4lcOTVOJH1qZpts1bwSwpoaN5KnjRzUJwYDtPjM0SGFI6wH9O+Td1SfWbTiAD0+gy9gsALqUgt06ki0V+kpRW2SoVhFLCczlinJcB9O6SjGqZyesEBH6SyHcrHMi8aA/pb0N0LIkYnH+ubPBdoc4X9AxTZiqsaOjsH63gN4un2/QMc+gRTuhs3BVIEEnKPhSCKBXDnNm20h8sxY5UvzpEVj0mdKQC3WoWWHOWJypThvY7kiy7jeG6P9Vmo57XSE9i7zvR1SkLQdgB+LWt+vd41As1gCIsDxXGgT191g9WBhOGSnsKnY4KTZccdk3S5hfRBqNr0cin2/HZOkI80luAdZ52pJk6tlwtrhIA8R8fZ83NAG80oAjdFThA8rGTS+A/A0WJIR2btzsZtlLth0=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(1800799012)(186009)(451199024)(82310400011)(64100799003)(46966006)(36840700001)(40470700004)(40460700003)(40480700001)(41300700001)(83380400001)(36756003)(86362001)(4326008)(36860700001)(81166007)(2616005)(16526019)(1076003)(26005)(426003)(336012)(82740400003)(356005)(110136005)(478600001)(2906002)(8936002)(5660300002)(316002)(70206006)(6666004)(70586007)(54906003)(44832011)(47076005)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 17:43:15.2538
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19264248-ac0d-4d1f-dcac-08dc1e96464a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7828

Running xmastree.py against the driver found some
RCT issues, so fix them.

Also, if allocating pdsc->intr_info in pdsc_dev_init()
fails the driver still tries to free pdsc->intr_info.
Fix this by just returning -ENOMEM since there's
nothing to free at this point of failure.

Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/amd/pds_core/debugfs.c | 5 ++---
 drivers/net/ethernet/amd/pds_core/dev.c     | 6 ++----
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/debugfs.c b/drivers/net/ethernet/amd/pds_core/debugfs.c
index dd6aaeecfe0a..d56fdbb4cdb9 100644
--- a/drivers/net/ethernet/amd/pds_core/debugfs.c
+++ b/drivers/net/ethernet/amd/pds_core/debugfs.c
@@ -32,8 +32,8 @@ void pdsc_debugfs_del_dev(struct pdsc *pdsc)
 
 static int identity_show(struct seq_file *seq, void *v)
 {
-	struct pdsc *pdsc = seq->private;
 	struct pds_core_dev_identity *ident;
+	struct pdsc *pdsc = seq->private;
 	int vt;
 
 	ident = &pdsc->dev_ident;
@@ -102,8 +102,7 @@ static const struct debugfs_reg32 intr_ctrl_regs[] = {
 
 void pdsc_debugfs_add_qcq(struct pdsc *pdsc, struct pdsc_qcq *qcq)
 {
-	struct dentry *qcq_dentry, *q_dentry, *cq_dentry;
-	struct dentry *intr_dentry;
+	struct dentry *qcq_dentry, *q_dentry, *cq_dentry, *intr_dentry;
 	struct debugfs_regset32 *intr_ctrl_regset;
 	struct pdsc_queue *q = &qcq->q;
 	struct pdsc_cq *cq = &qcq->cq;
diff --git a/drivers/net/ethernet/amd/pds_core/dev.c b/drivers/net/ethernet/amd/pds_core/dev.c
index 62a38e0a8454..b237cea65a5e 100644
--- a/drivers/net/ethernet/amd/pds_core/dev.c
+++ b/drivers/net/ethernet/amd/pds_core/dev.c
@@ -348,10 +348,8 @@ int pdsc_dev_init(struct pdsc *pdsc)
 
 	/* Get intr_info struct array for tracking */
 	pdsc->intr_info = kcalloc(nintrs, sizeof(*pdsc->intr_info), GFP_KERNEL);
-	if (!pdsc->intr_info) {
-		err = -ENOMEM;
-		goto err_out;
-	}
+	if (!pdsc->intr_info)
+		return -ENOMEM;
 
 	err = pci_alloc_irq_vectors(pdsc->pdev, nintrs, nintrs, PCI_IRQ_MSIX);
 	if (err != nintrs) {
-- 
2.17.1


