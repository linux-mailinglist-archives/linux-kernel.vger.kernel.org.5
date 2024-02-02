Return-Path: <linux-kernel+bounces-50519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 670AC847A29
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA145284753
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D5112D75E;
	Fri,  2 Feb 2024 19:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oALRjsg+"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E94685942;
	Fri,  2 Feb 2024 19:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706903974; cv=fail; b=UsgwzEKDjZesOTkw4jpbQ/+A+KmI1zoXhfsT6O16jd0Xulh26krvXINQGaPWVhtEyv2QVkS4ilkpuuTTo73A/x53bBSO5I3Tbv9eOyVKD6BVLNGEczp/BhPX9vs8tr6/GsVACuO5kxtSlPPSyDIhi9SQZjV9rrQGmWwxI/K8NSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706903974; c=relaxed/simple;
	bh=uGo35Whx6Y4+ut5sS6NbQ8rgo9dS2a6eXkK1ucEqr0Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j2dI1ebuEpH96FqGRUpiQ+IU04p39pULrsLd2f4uz3DxAbRm7Jby+EVhtmEpz1fhBVzL+O/ESngSKGVbtp/XqVLQeTOCk1maoT3pqPghPQgx46uX5WTjkKxBuEfWzgq++981A9WTicsOi1BrlU1EsXCp7UKoal7KLv03/JBDU5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oALRjsg+; arc=fail smtp.client-ip=40.107.94.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kzAbbIJjS+ZmkOxJpayoqX8Gmsav3Db+b7862ZJ+dHYprRdur5msIoQxAB2U5s4ZJLKNTiMxNfD4EShUEA3eP2NPP1e39MUavObK/1pYul6+0f1r/kpGWh4jEcC65jY0CvlRb7oqIOdPpNT9VuScWIFDt579YcYJSpktStzwUhXihEkt1FCezs2wum3s+HFHaBR+c6eftH6xGRLG3jl3ddJP2xzOk3iPeimiysM6wvQdREf1hn0hj7L0UcFgMXg05oQqjqgjDcXXRpDkbSpdptwm7xTdds7+fdrP8x/N2EJLeGBUe71Wil+cm84x7KlrW/BdGhnwMgzCEVlwjgNvKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2HyysoQlDt+oUOFQoVqvcCTWHWt1i7m9VvNPB7D7Ack=;
 b=jzgrIziqJuhRAEK9Gh6x3XHrTIiu6KD0BssGwmDWf5DKBjk5syqsKksdsEiMEbkJdVdSs5ibG9xF8cT3zcRYquBkPzRdVz2Mj6Q2LAaWtt2TbK7NxG11rgUhNKAhP4t+XKB7SCWNJ8kxQ1x69tgwJLit6HAUW6kR+RWBaVlHsViX5l44Dg/bDvC1DEy4MeXgdLrzDZDwZBCo0vateApD3DqGHGsNljn4ZrBEIa1YWvTHAhzJMZnJNI1/rzRThTaBizP6MEwmQL6Fx24Pqd+UmiBBJ1eRGimIxptzi+QbfVzKQ5sxkjWZXmP22Qud7LS3wkPsgKDgt3V4u+QvCXlIpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2HyysoQlDt+oUOFQoVqvcCTWHWt1i7m9VvNPB7D7Ack=;
 b=oALRjsg+KDzO5s//1DYEbwtiFqvbIdsaGaBMGCh5W1Qmrvn/fzzxWwqE9ZZ0epM+DSRJSQOvGL5nVyHPc7sPiaakMHv0YwzV+FKf+XNiYr80suOB7upiuXeIrQQS58xkb4abPPffbwMsIqdumbQ9pNeOdhG3cmchk8fMphDbcro=
Received: from SJ0PR03CA0204.namprd03.prod.outlook.com (2603:10b6:a03:2ef::29)
 by BL1PR12MB5780.namprd12.prod.outlook.com (2603:10b6:208:393::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.12; Fri, 2 Feb
 2024 19:59:29 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::a0) by SJ0PR03CA0204.outlook.office365.com
 (2603:10b6:a03:2ef::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.29 via Frontend
 Transport; Fri, 2 Feb 2024 19:59:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.16 via Frontend Transport; Fri, 2 Feb 2024 19:59:28 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 2 Feb
 2024 13:59:26 -0600
From: Brett Creeley <brett.creeley@amd.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <shannon.nelson@amd.com>, <brett.creeley@amd.com>
Subject: [PATCH net-next 3/4] pds_core: Fix up some minor issues
Date: Fri, 2 Feb 2024 11:59:10 -0800
Message-ID: <20240202195911.65338-4-brett.creeley@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240202195911.65338-1-brett.creeley@amd.com>
References: <20240202195911.65338-1-brett.creeley@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|BL1PR12MB5780:EE_
X-MS-Office365-Filtering-Correlation-Id: 84bd7920-05e1-49c1-bcb6-08dc242976e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	F1trIFfBF8mICSpIAoivJNHp+P9uiEzNsQM9a9zmgJX+P9nXy9enUJEeGVh3+vn0M62ukDNZZ19+tOdHPI0x8dAzvxLf7bHHL/GKgHx2mQoanVP+py9pcfRKzlvvR9k2W0TpZw7qdyWhlckLVTr/H0xKhLWALUK6FX5AJR2b0dhwnZPrBxBm1yFQIfwMVcT6748KN5v0Ll7aQMzIb5rXV2tDD06fEdVfXVGZQBQlyUmHYBQaaU0b11Pb9exMEXbmGiHPhQj7LIyfkuVW4TMq5g9/167h8/RdXobAFtJD0e0gYz0zBilcdl77R/69lDZS9K40MKzgVrWtp1Jj8f5qTkk01FEzcSFBN9j98Dmd9q+x3nxAXYf7soWelXAMsEKmsqoMQOmr/6YEIi5f5t3x8k0H+m8H9NvhtdR/p5IGJdCHi/bh8jUG+lhhQtlivQgTSAEOzfBTg530GNoua74tezk6u2mSSEZlLWtWcTo++HZmTQ2hPr0gwZJF3H8aTAH4U7hJGr49Tkc3JUVkyNiobhWtkC38EWOpq8DMHqwRgi0R7/MpwMvPnzLhm44qcRWvXEnmXvUtwh6BPqPVqUrJ6ZR4FNwrP3uUbipGm8cJ4E2jnpiRBOPByW6sQfaaGYMKfHHWrIrPMU+SMRM5XVack7xzo5VPJXh9u404ntYAeNmVvfhngmH2ZPvbRM/18S7Snk3AJjrBZBUMzYyCTBnovDS8xlgDUQdRMWp9rjb96f1Jj0DxEsninWGf1lpu0YJsHO/XtuAUXrDwLpBaOBVWew==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(376002)(346002)(396003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(82310400011)(46966006)(40470700004)(36840700001)(40460700003)(40480700001)(41300700001)(83380400001)(86362001)(36756003)(82740400003)(356005)(81166007)(36860700001)(1076003)(47076005)(16526019)(2616005)(336012)(426003)(26005)(2906002)(478600001)(70206006)(70586007)(54906003)(316002)(110136005)(44832011)(6666004)(5660300002)(8936002)(8676002)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 19:59:28.5347
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84bd7920-05e1-49c1-bcb6-08dc242976e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5780

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
index ba592dbeef14..6bdd02b7aa6d 100644
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
@@ -106,8 +106,7 @@ static const struct debugfs_reg32 intr_ctrl_regs[] = {
 
 void pdsc_debugfs_add_qcq(struct pdsc *pdsc, struct pdsc_qcq *qcq)
 {
-	struct dentry *qcq_dentry, *q_dentry, *cq_dentry;
-	struct dentry *intr_dentry;
+	struct dentry *qcq_dentry, *q_dentry, *cq_dentry, *intr_dentry;
 	struct debugfs_regset32 *intr_ctrl_regset;
 	struct pdsc_queue *q = &qcq->q;
 	struct pdsc_cq *cq = &qcq->cq;
diff --git a/drivers/net/ethernet/amd/pds_core/dev.c b/drivers/net/ethernet/amd/pds_core/dev.c
index e65a1632df50..7dc102a31185 100644
--- a/drivers/net/ethernet/amd/pds_core/dev.c
+++ b/drivers/net/ethernet/amd/pds_core/dev.c
@@ -341,10 +341,8 @@ int pdsc_dev_init(struct pdsc *pdsc)
 
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


