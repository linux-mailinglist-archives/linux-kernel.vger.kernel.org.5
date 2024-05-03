Return-Path: <linux-kernel+bounces-167273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 838CD8BA6DF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A73171C2205F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 06:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B2D13A25B;
	Fri,  3 May 2024 06:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RCbnTdOJ"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556CD1C6BD;
	Fri,  3 May 2024 06:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714716365; cv=fail; b=F+wQwAb3k5KWHrdmRUcHIn5OZ16e0eZRXG4IuvCzZF8Q7T9R0qUR6hcY6r2GF1Besb2BRrE0Wxbethl3Xhiy5Q+wTAAMz3/nF9D10wtsyD2y/eOSFipB5MKZERAYizjuIYGRejAwU2jVYf/h5GUx9TJ3RbUsUqF+qeSG9gGFlGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714716365; c=relaxed/simple;
	bh=qrZLAH/jiKlSzIvpI64TGe7l6fFpgDeSzRIBoCMHVWo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t0h0KzCzXuxcQS6da6PEgPW9+VsQGlsc9GYhkbBcUurrx0vfUwfV9s1+EA+DPbJs1LkiZMVxU38JCfAe3qhXqZaaLSmy8pVFWpgd6iNhXdENS6v5Yyt7drIfonYtBnZFnEkObxX5oPu5bAPThXvEzDjVZZ6ftWNvAB3s6O6bwsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RCbnTdOJ; arc=fail smtp.client-ip=40.107.94.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZRkXTWRnnTjQxHBtbTKAehoXl7GbaArCM/o1CRtrWYDQbRuBkPhCynsSV9rFmkHqq1hdRdUxpyekZljCelmWiwdO8c5DQ/Yuu3TRgO0SOjId8BVpGT1P1Vgk2pa6q3Km07O7CAw+QBAJKQnk7EyPD+C2ay2Cx6VFLz5XkCpUPtgw1vtNwh8tqZcsSkjEkkg3JxGK6w2Ica1jtFiHw3ZTN3ocKRkpH21cHnlNKQLVF70ZYSKX1gWUGrPeoC+vzJ/2q1dT2f0L5N+P8HThlUHfuUk9XnaBqGmB98I0Sb6VlnkT1/VGSZs1ApWfr83v7m2JpwLiK8/rxLT8a+GIsVTYRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+8nUVmKxeuwyhpVvB84WxAwWjUL1THde6m11WY1YPH8=;
 b=G61yr+YelqUrPUxEwh93qzymzgiwfTD5FuD9ZOsRzP3KknnGzDsvhGE9MKQHOKIa+hd970SWUSk4FgjyOmixZZqhNsvfYz8kiPx5aj9UmhhCp59MR2MyWoMwpc6Rk6sLv6XuU3w+Xv3x19kYtZqUvPNEHeW8R2Z41QLM2cg01Qsbcp41S1Pl/lc7LK5ygKggtivNos6ZksodLTvyWQoNj7DEtm74yy4reYKkMG7IqNobwzsYsbtOeiStU++Eh4nWMRBJa/ggku/gbYstntAg+Hh7oKdgBD3YeOTUzpKlJ9D/5/m8+MvTf27xBD8mSxfdSw40SfuuGsEXXqZx52LlMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+8nUVmKxeuwyhpVvB84WxAwWjUL1THde6m11WY1YPH8=;
 b=RCbnTdOJ6BjKNTFwfqzz0RaLEiO2HCP3bERADqY/hlLQmS0Esytu9k09+Ce62B6ZBMebdehRUma1ygnGN9ChxyOhL/gRpLBrvdk3RNH/mXCFi9pa6MzWBCoCZTLC7tGQOr98Iswlz5RCfHdCB5fImWoawEWJ8S4Miof10kk3jKw=
Received: from BL0PR0102CA0056.prod.exchangelabs.com (2603:10b6:208:25::33) by
 CY5PR12MB6479.namprd12.prod.outlook.com (2603:10b6:930:34::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.35; Fri, 3 May 2024 06:06:01 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:208:25:cafe::16) by BL0PR0102CA0056.outlook.office365.com
 (2603:10b6:208:25::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36 via Frontend
 Transport; Fri, 3 May 2024 06:06:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Fri, 3 May 2024 06:06:00 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 3 May
 2024 01:05:59 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 3 May
 2024 01:05:59 -0500
Received: from xhdharinik40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 3 May 2024 01:05:56 -0500
From: Harini T <harini.t@amd.com>
To: <mkl@pengutronix.de>, <mailhol.vincent@wanadoo.fr>, <davem@davemloft.ne>,
	<edumazet@google.com>, <pabeni@redhat.com>, <michal.simek@amd.com>,
	<appana.durga.rao@xilinx.com>, <kuba@kernel.org>
CC: <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<srinivas.goud@amd.com>, Harini T <harini.t@amd.com>
Subject: [PATCH 0/2] can: xilinx_can: Document driver description to list all supported IPs
Date: Fri, 3 May 2024 11:35:51 +0530
Message-ID: <20240503060553.8520-1-harini.t@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: harini.t@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|CY5PR12MB6479:EE_
X-MS-Office365-Filtering-Correlation-Id: ccc1a883-294a-45e4-4f73-08dc6b371b25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|376005|1800799015|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PJ+TXalXRhzt/IV5tGMnElf9r0WpE4wXMPnrG2bV8GYvTBOuvF75fFGCiwlP?=
 =?us-ascii?Q?jaPJSiL0ncXee34sa/1CGoPP8KQ9w7XjmssA684pG3bATh24pZIV7T95fkP4?=
 =?us-ascii?Q?GWg93NxRL3c//HTqahwjZpQTg8o37cJbjKpj4xN7Qvb47eA9xGI0IOPfI1nA?=
 =?us-ascii?Q?Kc+P/Cy5ibmwSwLpn+icb92pUB7HyyUygoCQfdRkY4ylBQq0HnHkpliwowPp?=
 =?us-ascii?Q?l3Fa6FPcKBaKGbU/ag5ExYkA34jbsFTjl/yK0kVWzx7IvkR1eaJA9ZL8ZRb4?=
 =?us-ascii?Q?vPxi0BDtCVxxn/PiDUmuEVxaw1Vrmc4M3j6BSblPDpsk+ZQ7dMUvdQC+grln?=
 =?us-ascii?Q?MlTj1YrEqW9vzw1H+TRy3MOpSUd2QwBvBaLP0XnPWOGZDXBw7HG4pDvbAGu/?=
 =?us-ascii?Q?hcp7vSJ4rTR/Ze0TbYy4hNGBnhMWQEBRnXEQ+8euI2e6RzGlBqttADc04jY2?=
 =?us-ascii?Q?X5zLFZNWd+fcmW8ZKDg2DEOPkPB8dXbgXoxFDTEGfDAVchViTAIItZ+X5z4p?=
 =?us-ascii?Q?vvn/LJw+OMjzudf8RFm7DybF/cI/voYqKSxbx2mU1WVYCcqRYdqSBpy4lkLV?=
 =?us-ascii?Q?GPDA/fGU4/Pl1Qt8FMtOyVUmpMCf5ArdGRNJ0gTIw1ZpZK648NfHvl3jIK5Y?=
 =?us-ascii?Q?EHbkTPreUmoDg66n1RyLYZu8f2gJlOBPkB7g3naKFQLwecqSHCqBZIu6PnGf?=
 =?us-ascii?Q?QxbFZTxyvp5tqRvVMwmYmSmntWqbI5rm22ALrL70rN2NMnweR2Nt/UmNeuHn?=
 =?us-ascii?Q?HBzQ8vfm6tQnLYzwwtyiLXZ6X5S64GHfb1Mv+rpHi9Y7c8w5Qky4dmASKPku?=
 =?us-ascii?Q?ymp4hf5Qf80Ee7KcYYRDlHqpnUMwtyAsQS6g+SoNCT8/YqnmTmdcDwo796dE?=
 =?us-ascii?Q?1rlJU+dtxfTh7rEvhjfX9rca9K/2r3RyxhKLj9Ykb9f1gkedGuXD+DJQ2Bw3?=
 =?us-ascii?Q?LFbPUlGhGM1czLm8QltpbXQVsGSnsPgNr2DGkOIF4n4FjU1igarAXQbG9vj4?=
 =?us-ascii?Q?rTnjv3wQwf8HboaLD6ZFSXyE6V7uSaXjWKn+Ooh6ZsLqwAaupNZulYZmJCsQ?=
 =?us-ascii?Q?V1wm3lcE7aFKXhFZUEFZR9OIR6+S2wtfZaI4tKAJx9KObdzt06sZ6v5bUKpL?=
 =?us-ascii?Q?oTkDDyYFejq98KS5b/jlOt8gvmJDwb8vgG7d9v+bo2rRV8gxbLJlhhG1vjnd?=
 =?us-ascii?Q?XOfhhOhq5/vpQVbhjhJRovOQW0NvCmeRKfbbZ+jdFHmPmfqDo1Ud0e9V1opn?=
 =?us-ascii?Q?IRX/wBVxvV/fJQ1c0A4NRJhh6SrWKYdjxLatFM8qwSRjY0x+I9loUW40OCS9?=
 =?us-ascii?Q?vG09HiTieMyeQptcD86jnWXOEXtuI+IvfBOLMkVnBUfgIARIX5eKHbmZeOKV?=
 =?us-ascii?Q?N8cZxTc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 06:06:00.2258
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccc1a883-294a-45e4-4f73-08dc6b371b25
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6479

Xilinx CAN driver supports AXI CAN, AXI CANFD, CANPS and CANFD PS IPs.
1. Modify the dt-bindings title to indicate that both controllers are
supported.
2. Document all supported IPs in driver comment description.

Harini T (2):
  dt-bindings: can: xilinx_can: Modify the title to indicate CAN and
    CANFD controllers are supported
  can: xilinx_can: Document driver description to list all supported IPs

 Documentation/devicetree/bindings/net/can/xilinx,can.yaml | 2 +-
 drivers/net/can/xilinx_can.c                              | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.17.1


