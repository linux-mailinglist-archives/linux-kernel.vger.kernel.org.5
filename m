Return-Path: <linux-kernel+bounces-40458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE3D83E0C0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93FB0288495
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C228225AD;
	Fri, 26 Jan 2024 17:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jlyXhMlW"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F209821A1A;
	Fri, 26 Jan 2024 17:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706291000; cv=fail; b=dQv9vf5N+V13DuMDNCU0st3PFA83LIlPRrOtTBYOZA/W/etzfbleaG8hhEXNicUoSyz//68pBXvRXjWLJwEEbYYPB+hTcglw4Xxzw9h5hKIgo4xQGQQ9bI+M4m2gIScl69xn/tCzKyqCjWv3+y6Ldy3hYmdkHldNd3Y+MXJGh7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706291000; c=relaxed/simple;
	bh=U6xPfMRjJEuLVn/pfcA4LRFtqgl6iM5I1JOTTyqSCzM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N+oPBF3/AvJyw4Wi9eUeVeN79TyKAUpV5WHLHPDOpLfPfN5P/+FMhmFy2dXcj4y9ETYyeKu1Lc4CiarNa2ay+PH2a4wKU6ZmWp0/dnuonLMq6cO6THrj1F3edRhISXfo1i/A7u2/xPGyE52Ls2gmIRSgE1LOB0HdxsupYKnn5qM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jlyXhMlW; arc=fail smtp.client-ip=40.107.92.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UJ+sIIw8jVtrH7ZwhYn14P2+1tQ8D/QT0GOnVsXV/w+fEK25CyP2XdbjXV5OHcAk9H4iGvLk4KwuBaYfCDtlmDUXqzvKdo8Vtv4Eye16FVN8TPZmEU7cJ6rG+iyft5mpEdq1PhFAtqIiU6+TRyCf1Ql3iy4ok6IdIuV0lMnWRv9S7rtvyb2A0ExHO9lXUqD5CMZNBORjjyg7K12H1SU8vMmBqBI98Ank9fp4iNJ87poCxUC9wXZGNHBS2L+hhuwFIr9GNa9xum4A8e/wUKJKVAv5C8HR4FYRM9IqTUhfrZ+Dho0CBihbramOFcwUloomXk6ijrIlnssrzkvPMwwScA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T2Z2QMGoaFhEwOf6ddByjZdN3SIzdKkrE8cQnwvgOZk=;
 b=GZV9yK+QQSysRj2PtOgx9/7krbwJ7l7+NyKMD2xK5QeQBcpHVpaMY+uQqGUWeJlvEyhQgPK2uuKtyXQ4ow7qLyd1U2uUlE1MgJTLCV9WzUsVQR9mIcE8KSboL9Kcb5vJIsN6IFS+sWjTHyGFoWBhk4q9Kd6BRUASxbVsAgvN5H9Cyo9RlMvtxwF1fpHYOX7e0s0YzdPZW1v46+zZWNXlyN8VsqBpYyjHdwGV1QHMJjnjVlveKanQd+7z50M2SnA9jeDwDxv+sTUoiL2VAw6rZACmOmG0MOEnSWXFiBWVl82J37yewWqk3EtZIqhEgtscQ/5vO8wHzSlrOloyrKRp2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T2Z2QMGoaFhEwOf6ddByjZdN3SIzdKkrE8cQnwvgOZk=;
 b=jlyXhMlWKttgMs2pPEcgDAZXyKz/IdY8NzN6tfvlh8jlu1AVi2Te/uAIRrbUWivA6jsFselrcQGwCZ499rQ1m2hy9kkuLc/ZEWpNr/Q3RhrdetUrrtao1t+/tJW8UKivFy9phbSmz0lh3BsV3qnArvnbIBO5NM6LcEhmyYaymkc=
Received: from BN9PR03CA0649.namprd03.prod.outlook.com (2603:10b6:408:13b::24)
 by PH7PR12MB6563.namprd12.prod.outlook.com (2603:10b6:510:211::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Fri, 26 Jan
 2024 17:43:14 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:408:13b:cafe::f8) by BN9PR03CA0649.outlook.office365.com
 (2603:10b6:408:13b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.24 via Frontend
 Transport; Fri, 26 Jan 2024 17:43:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.0 via Frontend Transport; Fri, 26 Jan 2024 17:43:14 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 26 Jan
 2024 11:43:12 -0600
From: Brett Creeley <brett.creeley@amd.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <shannon.nelson@amd.com>, <brett.creeley@amd.com>
Subject: [PATCH v2 net-next 07/10] pds_core: Unmask adminq interrupt in work thread
Date: Fri, 26 Jan 2024 09:42:52 -0800
Message-ID: <20240126174255.17052-8-brett.creeley@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|PH7PR12MB6563:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f977373-b65b-4525-de6c-08dc1e964596
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EEP393KoWddaXTsEKVUfDglAstH66wN81XmrlHb7cr5xJRoBl4+AagxD7nDUZxpPoyEUXrHfAGv+KROP2oYIIcgUY/nsJfgLVzTf29pDuUBx61zdn1mD3JJuTGty0+Shan8oPT5iX+Tkh46i/zSaOSpkQaJM54mRNB9XMSTEKq0MeoOFE2EO2UwZMPVfbYewYKDe0YUTsXWJB7C3OVl6sA/z84UTqgCFwR1wfQYE68YwUZ5GkCirsmR3H+L2+dJI64yqn/WP5Gld6dJ/IwsKy/yxGtQ5z+IVh3yEP4KJZnQVXu96Q5nxT+wN9ZOx+l7fKnD7OZERY7MfMiXsNUh3d3imh9EkJm7KRXMvYPE3fXpth/EC7rMf1kG+3CHMUaN7GY37SYw7i7k1mUEgH9iiB5Uwg8Dpqu5U4330OslrfHQEfAxpm0GYQz3qg8FDkaDaNSXo5O6rvDLe7OQ2oZdoDJHASPllSwlmNkaCH/II5Dw/Fl4f50KMmnT1mt+LJQuM7pID6kZLKMc6REqd4ttgIgbUwbQgSPexT6JiEHmc/OZMYXSxCguIKVujxMiNFEN9TjLba2sESh4Mpnrc4vi2UA1h9YyXESqoPrSN47MIopg9QNNn6zNzOj+Whf/NfrgcAkLn7d7NSFNC9umQxvPWoqJPc2aoHGdl6drxHIkbBrIuEGjt5ZKi/p0QrRR4e+04gtoWKcd9Q37jP7rrNf/MDAHARG61qsM+hhUjHzgE3s+mnRZn/DUfWx73tBB1g04wxaFkPBrqyuBsuXn6n2Absg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(1800799012)(82310400011)(451199024)(64100799003)(186009)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(336012)(426003)(83380400001)(47076005)(86362001)(1076003)(2906002)(36860700001)(41300700001)(81166007)(16526019)(6666004)(36756003)(2616005)(4326008)(478600001)(82740400003)(8676002)(8936002)(26005)(316002)(54906003)(70206006)(70586007)(44832011)(5660300002)(110136005)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 17:43:14.0741
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f977373-b65b-4525-de6c-08dc1e964596
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6563

Unmasking the interrupt during the pdsc_adminq_isr
is a bit early and could cause unnecessary interrupts.
Instead always unmask after processing the adminq
and notifyq in pdsc_work_thread()->pdsc_process_adminq().
Also, since we are always unmasking, there's no need
for the local credits variable in pdsc_process_adminq().

Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/amd/pds_core/adminq.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/adminq.c b/drivers/net/ethernet/amd/pds_core/adminq.c
index ea773cfa0af6..c83a0a80d533 100644
--- a/drivers/net/ethernet/amd/pds_core/adminq.c
+++ b/drivers/net/ethernet/amd/pds_core/adminq.c
@@ -82,7 +82,6 @@ void pdsc_process_adminq(struct pdsc_qcq *qcq)
 	unsigned long irqflags;
 	int nq_work = 0;
 	int aq_work = 0;
-	int credits;
 
 	/* Don't process AdminQ when it's not up */
 	if (!pdsc_adminq_inc_if_up(pdsc)) {
@@ -128,11 +127,9 @@ void pdsc_process_adminq(struct pdsc_qcq *qcq)
 
 credits:
 	/* Return the interrupt credits, one for each completion */
-	credits = nq_work + aq_work;
-	if (credits)
-		pds_core_intr_credits(&pdsc->intr_ctrl[qcq->intx],
-				      credits,
-				      PDS_CORE_INTR_CRED_REARM);
+	pds_core_intr_credits(&pdsc->intr_ctrl[qcq->intx],
+			      nq_work + aq_work,
+			      PDS_CORE_INTR_CRED_REARM);
 	refcount_dec(&pdsc->adminq_refcnt);
 }
 
@@ -157,7 +154,6 @@ irqreturn_t pdsc_adminq_isr(int irq, void *data)
 
 	qcq = &pdsc->adminqcq;
 	queue_work(pdsc->wq, &qcq->work);
-	pds_core_intr_mask(&pdsc->intr_ctrl[qcq->intx], PDS_CORE_INTR_MASK_CLEAR);
 	refcount_dec(&pdsc->adminq_refcnt);
 
 	return IRQ_HANDLED;
-- 
2.17.1


