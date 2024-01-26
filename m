Return-Path: <linux-kernel+bounces-40453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EF183E0B7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95B601F24AC1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DAC421106;
	Fri, 26 Jan 2024 17:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Zrh6AGUl"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2086.outbound.protection.outlook.com [40.107.100.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CD8208BD;
	Fri, 26 Jan 2024 17:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706290996; cv=fail; b=e8Poy03pIiDblsnKcuL+XFXNNFeGic2+avxAKi//f75GG1/jmoJkq2o4B4gN/NLGFn2A5Hob/M1II4mynt7bVLdsxnYUy8L/5heftNkWkWMXZQk416v0nfNY0LKHJw1OvZPVlEX6BDyBhKGg87NskhB5SZV2Fq9xMWZcAV6Io4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706290996; c=relaxed/simple;
	bh=nbXDOebMxEMoAvk/jKfMqXGFruDw5Uh7NJQ7ZmUvQw8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JPigCTNrfVppF47NEB82ypjq9WdIKO/eidcxyzohNUTMMk+PKNtY7DORbe3MgS7N2QfJpSzeWQ4aJwoaJxO/131i00bk/HLRQt5FwdRe+YfSKyYcxXaSXu43EyySD3UG6ja68T0LZUnqGuJsN8KsAkAtGdWuLFpaQOqvIyYHqis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Zrh6AGUl; arc=fail smtp.client-ip=40.107.100.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ArEUWOLBIzai38G/NN1dG8JbBa2FTRhZ6b2BZ1ZbEjB2foPpCEPrvnK0Zw24zGLPofCUoVAYCpyvxbOBd82spnuLwqz7qs81kXB+M+O6EDMKu38G/Be1mvJiOg5u3E2MM0dBdJ/8clriN0xr6NABtRLI4kVkNBixmoijtjhSSILGZfXN9frTqoDc5YXcPbj81B4wA9JV4mxfgPcvZ9jntspmBnfN1r2Rlk3Z4iAAb68X53T6gXYDBzW2AJ3GfufIdhpTqsqbNOksQ02s4JdUUlPPvhaUTO3NnqY/Fw+3bs5T1yKzyvDfGIk5hATm+6TPuyUh4oaMH3XW1DCwYvi9qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CKoOIUEnMgqqw4s8GRzKeUTAwwzf8cGWK8hq0P6QnZk=;
 b=P98Km5cjMGn4UvMeTbTnTnCGEwLXHaMNmFCPP+O+FcjdXaKlLHc2DuvvhicN3hMT4UmL1sCZD5umc7jsptuwXl9234SI6g1NZHyMUeWzBFnuwPI/u2W7LIrwvS/9QZJzX8XfxU9HSF76izIq38VQ2D92qO+UBBOOz/EhOmWuMZ9ezzYkHSQqdA+RHVAso76GDSGEHrh7wIpKbZTIVlpdI2D5NExctQJ6C0zONvV/nSaIGqGItL1JHrjzUoAg0qWVrYKFRicFlKPVMxVnYHAXNhakZSmAL2W99WmwqdNuuv2ow7LQH2J3rrw/BOxb1Wdtm0StthcoZTw1LxU3P868cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKoOIUEnMgqqw4s8GRzKeUTAwwzf8cGWK8hq0P6QnZk=;
 b=Zrh6AGUlrUdsaqZICGDnuxzJ3/jkvHPW33WBauWEOyEQXMV01KBFMN90HnI9iXagAHywSp5socz3eTEZISTN/hTvJNg/xdpnLVH4EYgu9Gmm9oxEoL0wN3QKWqN2ypQB2P3IJnJNywWiYILXPolmwoPvIcOTtbtiSlIiIppcQAQ=
Received: from BN9PR03CA0637.namprd03.prod.outlook.com (2603:10b6:408:13b::12)
 by DM6PR12MB4466.namprd12.prod.outlook.com (2603:10b6:5:2ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 17:43:12 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:408:13b:cafe::31) by BN9PR03CA0637.outlook.office365.com
 (2603:10b6:408:13b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22 via Frontend
 Transport; Fri, 26 Jan 2024 17:43:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.0 via Frontend Transport; Fri, 26 Jan 2024 17:43:11 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 26 Jan
 2024 11:43:09 -0600
From: Brett Creeley <brett.creeley@amd.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <shannon.nelson@amd.com>, <brett.creeley@amd.com>
Subject: [PATCH v2 net-next 03/10] pds_core: Use struct pdsc for the pdsc_adminq_isr private data
Date: Fri, 26 Jan 2024 09:42:48 -0800
Message-ID: <20240126174255.17052-4-brett.creeley@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|DM6PR12MB4466:EE_
X-MS-Office365-Filtering-Correlation-Id: d26ebde7-1caa-48b8-1507-08dc1e964449
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6XxT2zWjzeJnTltDBAuFlJQiks+8VypwEaxOUevwrtM7ETheZGVZ0Wvtn9iRC5BCq1/zU80sAlJhfjyxAdr7wjEjEkzJcRkDsE6TOuxodg7+VX8WMxbDUvV9FZLJQWQ8aFG7zQVGgREkK+k5iw77RhsxmYEOY1q3Obbx7CWFoufQdjEyu0VrRqsf2x+uRRS3O+GtfQTmi7/CD5s+OF097nS0ZzQCaDykhvcxj0wQL99pzpc7atZ0eBFkSuMUsD/ffES00ld1td+/PYGEVmYn/SXyWaMgnYXhPzhyBheVW3SlmfFEBY2XSqJIgTRYtk+yU163K4PHb0CbQ1T0WwxkDUmNqNVMrnsDVxHXsCGlMi6yvjwF02XqwkYsMNGiYNiEsvN1ep7aytHK3Uqx/gfggSq62s6uv4BRLP4eIVL/Udanupe9pGJZB2DmGfRmsuVYz/kxLsKpWhgKh2wnmqFBtNc5CZi8P40TeCK8yT4+Wc/J0IQFD2/A1WirZ6L+y5Ov472y1mY02h5PS+E8qA/F6CL25KM6B6PuKajtWm4wopXa4i3LHXbCu2UPSoy6aX1KIMKiMIfwOr8qy83zh50m11MzTQkXDbnpT7T/Lf77uJwvQooY4eR2K2z3maqSWpLED4s2DSzctaZ+yx8sAulXY9sGh45iGlHJMfoO/3zbzMNYZUXzBWvlDo5ikLy3jT8Exdk+cnb360RJIaYtHbundBGuB1FDmJkFiTAOlWYNKQIhdjnFzphT54MPpARUPMxUYJsAqUY/0jYToXlc9dEKkg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(396003)(346002)(230922051799003)(1800799012)(451199024)(82310400011)(186009)(64100799003)(40470700004)(46966006)(36840700001)(83380400001)(47076005)(2616005)(16526019)(426003)(336012)(1076003)(26005)(44832011)(81166007)(36860700001)(4326008)(5660300002)(8936002)(8676002)(478600001)(54906003)(2906002)(70206006)(82740400003)(70586007)(316002)(6666004)(110136005)(41300700001)(86362001)(36756003)(356005)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 17:43:11.8866
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d26ebde7-1caa-48b8-1507-08dc1e964449
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4466

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


