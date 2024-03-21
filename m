Return-Path: <linux-kernel+bounces-110656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E80D8861EC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 21:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE08EB227DE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 20:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A5F13667C;
	Thu, 21 Mar 2024 20:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Brub0Qg7"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B63135A69;
	Thu, 21 Mar 2024 20:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711053846; cv=fail; b=efFLHVjRidqh+YMT0VvbLDV9mCesg3EOgyS+APJpx1HzY+8LmDL9d/ibBS6/I50w2AM28ueErgFHN/SVCqcgfoafqATSRnQrrDdqG+YFGPLaYHWm2UkcHZJIg5hMIIKCiIqNn5w/CP1lWpyA1j+Tao/Kw7sMjdLPnP05i69cjBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711053846; c=relaxed/simple;
	bh=YD5U4rW55UyYG/mOggfLSO3drowUB8UWhkO74248nT4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=WXEjpHzwXYvnTh+YPt/uY63PbddIWvJEHI9SmstxuBIg3lOsQVbn+ryLMzjuW4VCJfSlgVdWV6aU1wKVQT1BIRz8q4Fd4IxjOX5Umw9zArAS6U8Ogv6eM/I7TvW/uOUPh/PezEhpAyb6DJMs5dG4VwR9a1JSXbCmzFuX00zs2qE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Brub0Qg7; arc=fail smtp.client-ip=40.107.92.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mc7+ys6jwt6mpuj+AiPMMNlR7q47xqV5AmJL+jAFtDNWMkNjry4grG8OLLOnKQ8E3BphMRImq0CtKMBvwJ4lQ4P1/fmtS2Z/r8uw5dUSA5O1a2ToibYyYqiI3/vUHlsjoaApxHTB5S3lEvRlSVGKCEDfocLgplVIfFz3f1ghiU5foGSXOzuKVXJnrspzZCzMEOsorW7/7WyFqfO2cRvjSHvAecWZ+coaTY9417HmJF9N7ZilA6BnmGUuScle+vHrlZOFan+GeIdWvjC2xGY+/waSTEreue+k63RxaMTI931C+n7XexDSr2Zpr5nYBwnwjVOclQeagTRGtKreSUSTrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=804TUvVriS611KMmwEEDVOyI7x92wBXQuMFTKBtWJTI=;
 b=eJ/1RzWXmboJf8HLpXYB6UlY6CH/bPhM36FAgm67rM4CK9W80g6c9Kz5boE0QvyaE+kACuTJl+/8T6LjKLMQ9hv/RNCJOq6+yHMswxpwv3qog58NQsSaAesOkhM83DrLyvpWIWUM3mHDoa9vvohHfHitk3SQDm6jKnOZLs3TbFrM6xJw0/67V3lfQba1rG5YH1YtGuDsj1ng1NETf9amhRxR6k8Mo9cse+XisDOJm45GQb4mX1U3ZySZdUCav9LPYGxxaYRcwdny6+q7vn3hfSC8xRDWju8jKOra7bNjhETfHokOccIKxnjr/Nb99xDVKSKgJkTfVILZM6z5xhtWYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=804TUvVriS611KMmwEEDVOyI7x92wBXQuMFTKBtWJTI=;
 b=Brub0Qg7EOR+DddMJtPxJhZJpSVPPNU9nRT0gjFrGcPeDYvVu8MeYoan57CSvq/Jr9uQHBJxvui6XycGTYsTuuQ3oFy8fBzxEBFESU2lNQrMyEyxO2qijN9D1H2LWBOxmQlKHnlR7yy/BLGBZr538DskghWOBzhsmf3Mr3FkffM=
Received: from BN1PR14CA0017.namprd14.prod.outlook.com (2603:10b6:408:e3::22)
 by IA1PR12MB7661.namprd12.prod.outlook.com (2603:10b6:208:426::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.23; Thu, 21 Mar
 2024 20:44:01 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:408:e3:cafe::fa) by BN1PR14CA0017.outlook.office365.com
 (2603:10b6:408:e3::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Thu, 21 Mar 2024 20:44:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7430.0 via Frontend Transport; Thu, 21 Mar 2024 20:44:01 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 21 Mar
 2024 15:44:00 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 21 Mar
 2024 15:43:59 -0500
Received: from xsjanatoliy50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 21 Mar 2024 15:43:58 -0500
From: Anatoliy Klymenko <anatoliy.klymenko@amd.com>
Date: Thu, 21 Mar 2024 13:43:40 -0700
Subject: [PATCH v3 2/9] drm: xlnx: zynqmp_dpsub: Update live format defines
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240321-dp-live-fmt-v3-2-d5090d796b7e@amd.com>
References: <20240321-dp-live-fmt-v3-0-d5090d796b7e@amd.com>
In-Reply-To: <20240321-dp-live-fmt-v3-0-d5090d796b7e@amd.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>, Michal Simek <michal.simek@amd.com>, Andrzej
 Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>, Jernej
 Skrabec <jernej.skrabec@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>
CC: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	<dri-devel@lists.freedesktop.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-media@vger.kernel.org>, Anatoliy Klymenko <anatoliy.klymenko@amd.com>
X-Mailer: b4 0.13.0
Received-SPF: None (SATLEXMB05.amd.com: anatoliy.klymenko@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|IA1PR12MB7661:EE_
X-MS-Office365-Filtering-Correlation-Id: a7f8a6bf-4b6b-4982-a85c-08dc49e7a3ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RLY6kE8xPWrN7bEWMNzk8BPZjv2rb6gPAfqDDfE/pnD+Yt7l2sPI4e9wrWHnd41Eqae9+7nhncb+52KMFGG9JBzexBRfE2wxFD1hgQylkQcENb8CfbPPGv9L0g6NC9dttmCAM+2RtKgkXOVi4Gx9VuoZyNnL0s3AH1R2BnCtLOleGUQl76CSYMG/5pQns1qQT2k6Re+wu4AjT148a+SDgQCk5E9bm2NLKDixabPgHkszWZlD5UeAhZKRcXmtzoyERHyIR2rY5yMdhtJ9ejWXloFmZ6Iqv81H72LFEdcj/0JKHjpMonU6aaVbQW0AnGoMds/5yV+0hckvCBFgWvNU9VCQ5IFfhdtajMbD0ByG4Urd6Auha/GH3YPoTjpqc9Ef+HMiqNsWIq0kfFnSVMPryoo6ceeIkvb5W0462J9R3IwmnioV2U3TzzOps3F1HNfKfFn/Ba3fB1sAFqvcHldOD1YvYVfVyG1Di3MOCawro0AWzU5+pn78fNfubjoxL8+gKf3b9dyhJBN9pDBsdXY4CUEzmivXSxmcqS+xk8KWpul1QvyQfafslhe8a/GSDPsjmD/BK0UhAbfUgI14UeklQ3Wv7nEKGCRosPBAHc6cs8tMa3ikDF3EQE15jKWmlBwnpaaoEdy10C+Ca2TmOYETMHXgs1BRoq6wAxyJdpJgQ6TWfMzgy+xD929v5pRx37qHYx7ILC46pnDvlu0W6+wjk15/Wq6qc95Mvs/lG7Tfk5LL1lbAKJeMsKDeQw+WDOwNRjMARt0XEuFCSxsjPOk1iA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(376005)(1800799015)(36860700004)(7416005)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 20:44:01.4739
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7f8a6bf-4b6b-4982-a85c-08dc49e7a3ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7661

Update live format defines to match DPSUB AV_BUF_LIVE_VID_CONFIG register
layout.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Anatoliy Klymenko <anatoliy.klymenko@amd.com>
---
 drivers/gpu/drm/xlnx/zynqmp_disp_regs.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp_regs.h b/drivers/gpu/drm/xlnx/zynqmp_disp_regs.h
index f92a006d5070..fa3935384834 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_disp_regs.h
+++ b/drivers/gpu/drm/xlnx/zynqmp_disp_regs.h
@@ -165,10 +165,10 @@
 #define ZYNQMP_DISP_AV_BUF_LIVE_CONFIG_BPC_10		0x2
 #define ZYNQMP_DISP_AV_BUF_LIVE_CONFIG_BPC_12		0x3
 #define ZYNQMP_DISP_AV_BUF_LIVE_CONFIG_BPC_MASK		GENMASK(2, 0)
-#define ZYNQMP_DISP_AV_BUF_LIVE_CONFIG_FMT_RGB		0x0
-#define ZYNQMP_DISP_AV_BUF_LIVE_CONFIG_FMT_YUV444	0x1
-#define ZYNQMP_DISP_AV_BUF_LIVE_CONFIG_FMT_YUV422	0x2
-#define ZYNQMP_DISP_AV_BUF_LIVE_CONFIG_FMT_YONLY	0x3
+#define ZYNQMP_DISP_AV_BUF_LIVE_CONFIG_FMT_RGB		(0x0 << 4)
+#define ZYNQMP_DISP_AV_BUF_LIVE_CONFIG_FMT_YUV444	(0x1 << 4)
+#define ZYNQMP_DISP_AV_BUF_LIVE_CONFIG_FMT_YUV422	(0x2 << 4)
+#define ZYNQMP_DISP_AV_BUF_LIVE_CONFIG_FMT_YONLY	(0x3 << 4)
 #define ZYNQMP_DISP_AV_BUF_LIVE_CONFIG_FMT_MASK		GENMASK(5, 4)
 #define ZYNQMP_DISP_AV_BUF_LIVE_CONFIG_CB_FIRST		BIT(8)
 #define ZYNQMP_DISP_AV_BUF_PALETTE_MEMORY		0x400

-- 
2.25.1


