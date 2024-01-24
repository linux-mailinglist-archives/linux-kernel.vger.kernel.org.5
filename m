Return-Path: <linux-kernel+bounces-36361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9906839FA8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 03:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ED8B1F2E8C0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 02:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454D4DDD6;
	Wed, 24 Jan 2024 02:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4ZIbFqKS"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC19BE6C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 02:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706064854; cv=fail; b=dJkkRJKBZxc8ugjnlsvRttwwuRWxGDwNPXIZZvMIZPUzPOMzf0o1/0dauLTl6DoIyfpK9tWRfZMekU32OG2VJw/j9p93Sb0yQl6HgPNkR3mijMzD3M/30928EH+JOJmM9Dt1aT+DKvkD2+5Iy85tCPWTaJshO1RKkOUxJA9teuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706064854; c=relaxed/simple;
	bh=ra7hWVIshtkN8L+Jd7aAe9gka5Q53HlK5E2NVa9ivuw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n1ag5mmqTqmA6zqVbdaNENWqC8I8pWAKPVuVPQGuHznlg6oNxtk7uEK8OvJIbTnKDnmrQl7l1zQL/a2nf3C2PEuAo97QEV6yY56nChhaUNzFDTe5Gt7hME1ytz+Oa78yCGPPOXtBRHRGV2sjo2zRqK76jHXNkcgxHIeAXBl/AWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4ZIbFqKS; arc=fail smtp.client-ip=40.107.223.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J+wbTqG48SuPFZ7BOIGuOJq0Sy+/4Ej7ROUh4xSWr8FEsa293Poihf/yLMS5gQ/XebZ2F4KY1douCWEM1Rtp+izrB2yrLFkXbxORZdLJ4nhS4+nWEk3/Ojlhr4s0h7GMnsvIVDLxkv9O46gSKueXgv/2pqxfzM0hpfcVUl4Hk5uL5OwPYRqTwvTwf7LO0GMd9yDdXLYuXg4gO9Z7dWXHahg3AdJWpW7pba5Qkc8eQ7FJtndlh1tpHfbQWVq6/lLBzYZDrGCSafMP+kHwxRwSuIFyH9/MAEGf2sh00CkMoAZUAW+lOWuzz60CGRcrhvH341zFfl920ij3d8AxXiTbJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F5xjs/9hM8nZIBy2hz4SFYtAqsSXJjAP3hbwy3NWpmw=;
 b=f6frGkoJFhiuFZiDxWjsUIXwFt9Ki2Xc7kh5+8C31jkhuvU41D/x4l/gnF4W2Sb2PcDLGqFsMWO8HA0jpDhXjnK2bRwrmAwAQNh/U1nEgLVd8yd+k96S13TwF5iTX+lUqgS7zCFsxIpxygtAxcJVQwEZVjycCw4NZV1Goz9oGJZdy166yQOBJsmzmQuvnBlIMvGpWhxCTPHaqv+tMINKX+H73PPvZL5puvyVrrQ2kVk/yBYkNhPOG02TgnUEEGWPQiG/pux7ZqTriR1fIW0HWm0YJ+/VAwYcVAacSpYqdqz6OJt5HBqMGZhR8vN/hSUFBOjuwO61WYH2yRDN+1/1sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ideasonboard.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F5xjs/9hM8nZIBy2hz4SFYtAqsSXJjAP3hbwy3NWpmw=;
 b=4ZIbFqKS/PT86x3YIQWfGYprnVMpEl8ASPjp1KU8uQ4b+U4++tWynZuXeMUNC3vvw6LHlAbMcpdb+1e4ppFlVYhCjktINU00dcOR1CVI2+9WkZoWcqh6be9AHqSJrnDDXT2McVsNRO46ap/xXw6QkvpYb2tsqy2Y8CC7FPpmYrI=
Received: from SJ0PR03CA0113.namprd03.prod.outlook.com (2603:10b6:a03:333::28)
 by PH0PR12MB7079.namprd12.prod.outlook.com (2603:10b6:510:21d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 02:54:10 +0000
Received: from SJ5PEPF000001CA.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::3d) by SJ0PR03CA0113.outlook.office365.com
 (2603:10b6:a03:333::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37 via Frontend
 Transport; Wed, 24 Jan 2024 02:54:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CA.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Wed, 24 Jan 2024 02:54:10 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 23 Jan
 2024 20:54:07 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 23 Jan
 2024 20:54:06 -0600
Received: from xsjanatoliy50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Tue, 23 Jan 2024 20:54:06 -0600
From: Anatoliy Klymenko <anatoliy.klymenko@amd.com>
To: <laurent.pinchart@ideasonboard.com>, <maarten.lankhorst@linux.intel.com>,
	<mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
	<daniel@ffwll.ch>, <michal.simek@amd.com>, <dri-devel@lists.freedesktop.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 3/5] drm: xlnx: zynqmp_dpsub: Clear status register ASAP
Date: Tue, 23 Jan 2024 18:54:00 -0800
Message-ID: <20240124025402.373620-4-anatoliy.klymenko@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240124025402.373620-1-anatoliy.klymenko@amd.com>
References: <20240124025402.373620-1-anatoliy.klymenko@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CA:EE_|PH0PR12MB7079:EE_
X-MS-Office365-Filtering-Correlation-Id: 93895552-df44-4d6e-d085-08dc1c87bd6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1205liwW61G2sjzowYbc1cl96pfYPBPUlhtinsO8WX3rnDmYMFyXNVpDOhbSOAQdRc1t9Ncxs3IF9yMXkJU7nqeVpYjV8Mgzmql/+kkkj4daQe1L1ChdSqsrLwPCPGIBQ4Qq1ev3xrUrlQzOg6RLaYhrwaMciEIUGDzItBRLdXpqmWgDiRJa/vbobXVitvwTL2hMPDCu99NHDh7byjwmfTq+iwmb06ckxIDYEvEiuUSZlMOYOXUVFuWWpN/fjB8u9X/6p3WnNfjxe0IoGDBB8xv1375qHj1NB0x0/Ln0wsv/g9PUCBjZWcXMNW9vxoKOrXgppn55NNuKS8GZa5cYdtVHRG3AaQvekuFm14dv7pwnYj/1NxPZ44xN/7qhIqG35C4/SR0w32pFxfcSYLYyV9S3Pdky7NWDevZ6J/yhSzlshTIz555M69cElZSErjT86LC5ce46uqzVCjH7nRFqC5zGCY4HTYU78qdinsyWqowvNndV8skjfjrwXe0l1UDPBfeBgzXN8FhNrEy8Rh3Py+QThdyWFY9gQdzj4+vPuKaDjGKW7qyN/XlFCYjD+FWkjWVWasOwiuOefDmtJ4JYagIhCGgwEWx275YLxUvnmi9fJrej9HYIbF5z6X3E7W4EHaEGvzmrF2M9rpwy/UKHDFIk0J8jx/Ov55dnYjsmmNZWseXLkd8Kqb2yW7UafajdUhp40pA/C5M8Zpk1mC8TzvfimLDNlx2yT8nqUz6qFa5KGl4nqNLCJ7O3j8HU3uNnF+Jnbe56edsokL1Y4hkW8FyRPpC27n3PhdjyhiZ7BeyrkkpJf2kLNG4gtXFoeOri1sfQIN+4IlMRZwctigLEBQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(136003)(346002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(82310400011)(36840700001)(40470700004)(46966006)(966005)(426003)(36860700001)(82740400003)(356005)(2906002)(86362001)(41300700001)(36756003)(47076005)(81166007)(70586007)(70206006)(110136005)(8936002)(6666004)(316002)(478600001)(5660300002)(2616005)(336012)(8676002)(83380400001)(26005)(1076003)(44832011)(921011)(40480700001)(40460700003)(2101003)(83996005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 02:54:10.2705
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93895552-df44-4d6e-d085-08dc1c87bd6c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7079

Clear status register as soon as we read it.

Addressing comments from
https://lore.kernel.org/dri-devel/beb551c7-bb7e-4cd0-b166-e9aad90c4620@ideasonboard.com/

Signed-off-by: Anatoliy Klymenko <anatoliy.klymenko@amd.com>
---
 drivers/gpu/drm/xlnx/zynqmp_dp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
index d60b7431603f..5a3335e1fffa 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
@@ -1624,6 +1624,8 @@ static irqreturn_t zynqmp_dp_irq_handler(int irq, void *data)
 	u32 status, mask;
 
 	status = zynqmp_dp_read(dp, ZYNQMP_DP_INT_STATUS);
+	/* clear status register as soon as we read it */
+	zynqmp_dp_write(dp, ZYNQMP_DP_INT_STATUS, status);
 	mask = zynqmp_dp_read(dp, ZYNQMP_DP_INT_MASK);
 	if (!(status & ~mask))
 		return IRQ_NONE;
@@ -1634,8 +1636,6 @@ static irqreturn_t zynqmp_dp_irq_handler(int irq, void *data)
 	if (status & ZYNQMP_DP_INT_CHBUF_OVERFLW_MASK)
 		dev_dbg_ratelimited(dp->dev, "overflow interrupt\n");
 
-	zynqmp_dp_write(dp, ZYNQMP_DP_INT_STATUS, status);
-
 	if (status & ZYNQMP_DP_INT_VBLANK_START)
 		zynqmp_dpsub_drm_handle_vblank(dp->dpsub);
 
-- 
2.25.1


