Return-Path: <linux-kernel+bounces-50518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F28A847A27
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1696D1C24EDD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F51312D742;
	Fri,  2 Feb 2024 19:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="m8o4Yiic"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C30E81727;
	Fri,  2 Feb 2024 19:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706903973; cv=fail; b=dhbyO/tmHnA8xpLjzEqnzToG/Xc874R9I3v8Am7gdLhEo2I3etn7cPf/HrCavK0+dEO/8HTDVKynAb4A/ScgUMbmd556PyEzVHENwmrslmbKQsqqDLc733dcVU6+35AfkPEHdRrnvd/uChz/7HJcIHIDwtL45oYvmTGsho/ZNlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706903973; c=relaxed/simple;
	bh=U6xPfMRjJEuLVn/pfcA4LRFtqgl6iM5I1JOTTyqSCzM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fwMzqM9OOBTsaXAdZWMFcNX07yFxXyH9LVJyj+Nf44f3CVXwVPfh+x5/MSkJK7xdGVGrbPf7xkc88RrWqOljbOtG1yg+ubZREf3AcXLZEKr48L1k439Se+aKFI/Ev86PSQZc+HUZA/BhAhSVTqmulPowzdt8vrhj6R7L40BXcek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=m8o4Yiic; arc=fail smtp.client-ip=40.107.243.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l7LeiRyX/Qah/Em+fIOsX19+jdK/MHTwSiEvMvx96T25+KcHqnYiPsrORnXD0WNrmKtqRNfrXZW6TBpSmV2Tl6jW/aJ79iyXLeQxkM+Lq2WpcushAvekIooQQDwA92i8Taywwp36CxlzpHy4XEFKswLlEN7NEWChdR5wvfEql1yzu+L5+54V+WcO6N/ZK3BIk67WkCwRNIUbIGMp4M83eQUHp7YQDjCp+H/YuYVCn1exqE7yzb+/WfgA3IpinQlED/Pmxb2S96KohzvKRTgfCIYUeqDEvE2yDxsavTFwIvdikre60DuLEP+ak0dxI/Ca9IUY7Zi9bRYrGFsO9AXw8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T2Z2QMGoaFhEwOf6ddByjZdN3SIzdKkrE8cQnwvgOZk=;
 b=WcA5rnqg5/1lp1CetlDJEctmPHPfo6mp/kty6XP62Sp0XauRqkSuZc+dO2/+3hvwXd0zo9mOEe5FgPPLgi5MDzWZXKDZwmnWZBAjh/gbKlPUEeS0+ba1ExD/8xdnUutlgBoKlWeS7Oc5jDyhpxE0SVUuZlPMa1QfETlPov3NZatr5lEw31J6mDpjuWLzqWf4FCGAUNVNqk5iPJ7t0fDUnAOSla1hqUboL2Xx31Xqc+NOpANnuDfudr+yh8b29fb8rHq36LxYIBC9f68REZf8unnwm87ekgqIOXh4HuttWSqUTNN6+2yn3+Me7Hh55KAISqXnlQGSEm9Q2rYW2+qmaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T2Z2QMGoaFhEwOf6ddByjZdN3SIzdKkrE8cQnwvgOZk=;
 b=m8o4Yiic2Ooq+wR4oDKYlEXboTTRXVaEWXt00mhQvG0al5Xg42dNGO/wvAGJ8v1JxWi0s6EHEGGfixqr4AuBQvbXilK2bd2HwslS1EUJ3RFydIeYRLb3b91y9T7kJ1un/IstYddzwCbQfnXiGkWaQz5h8LIyWKKuEXoEdWTQfLQ=
Received: from SJ0PR03CA0191.namprd03.prod.outlook.com (2603:10b6:a03:2ef::16)
 by DS0PR12MB8416.namprd12.prod.outlook.com (2603:10b6:8:ff::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.9; Fri, 2 Feb
 2024 19:59:27 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::2b) by SJ0PR03CA0191.outlook.office365.com
 (2603:10b6:a03:2ef::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26 via Frontend
 Transport; Fri, 2 Feb 2024 19:59:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.16 via Frontend Transport; Fri, 2 Feb 2024 19:59:26 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 2 Feb
 2024 13:59:24 -0600
From: Brett Creeley <brett.creeley@amd.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <shannon.nelson@amd.com>, <brett.creeley@amd.com>
Subject: [PATCH net-next 2/4] pds_core: Unmask adminq interrupt in work thread
Date: Fri, 2 Feb 2024 11:59:09 -0800
Message-ID: <20240202195911.65338-3-brett.creeley@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|DS0PR12MB8416:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d651956-6e48-4cb6-7aa6-08dc242975bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zVAC2EA6CKlMDZzHmI/MEViI3ldchARaidasMyfTdl56EEgyE8dsw7d37CzNqCb/GP7DOca8tNwvYjoOdCd0yr3zclYUcgwHkRzcZyhGZAacXZjszn5p9ta6Yf/ZBltlur3rnrNVal60rNbnN6E4J4T0gMaqykzhlhatkNkujwrdYjNwgBrliVIKQSIcZpqLZZlxEIF6CGu5rRg5jAJlQZaRv5/RY/iwdWoyYwpTEQqbb/hYFuRknQ3v9cs4DjoijKriERdQE6OM1v9+6cVqhWdFp1Ks2LbMTbJKvKkULaIKSrcesoOpn/YOFFoqYIbF08Ny6EY7GPdW2357pslhivvlUphsOVUKSJ19ulLK91V3xSN43YQoF3b57B16Y+m1sv6pWTz+RwXqgrsnqZHlbi8WV1BDFuzV0BpxrWPSKwqcM9nQnETJSgex4Jtu3Q0CzkOy5vIerSgTKWwvNe/EIUtMrIB6UWMN9ApA5vk8GGYX0apPvIdCbzPOT0U+lBd7V+olQV7wUXJ1L1W84eyYpiYlVDGe/rSB0IWvjUwYZaNu3hr86x6GAwlf3Q+GdGIThgIheUk54XjQd1KiPUX5Xph7VYT1weXYX2697/HPXQp2EPMSmOkT4tk91kJcsPOx4Ne6sc6LlmV4nSu2HQcMxk0dZhKqAjKUoQZCWyTfwLyzp0jV2ye6fDpsrLmABLz7TD9xWThESArnAhBJ4fjFumbdNEcdtZMLeFE1osy7PUXiGCFD8WvqJxSas51+OlHf3uz7ZbAHHmmPv82e6zR3+Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(451199024)(186009)(64100799003)(82310400011)(1800799012)(36840700001)(46966006)(40470700004)(54906003)(44832011)(2906002)(5660300002)(6666004)(82740400003)(356005)(41300700001)(86362001)(36756003)(478600001)(2616005)(1076003)(16526019)(81166007)(336012)(83380400001)(426003)(36860700001)(26005)(316002)(4326008)(8936002)(47076005)(8676002)(70206006)(70586007)(110136005)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 19:59:26.6128
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d651956-6e48-4cb6-7aa6-08dc242975bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8416

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


