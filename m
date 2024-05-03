Return-Path: <linux-kernel+bounces-167274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 936C98BA6E6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A976DB21A78
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 06:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE2813A863;
	Fri,  3 May 2024 06:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ArF+uDKH"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F47D13A27E;
	Fri,  3 May 2024 06:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714716369; cv=fail; b=mg6DmnXnKPR0p4LVOBVRmbq7l2FbMVlPxLYXnR98b65tT/gDxD42cU8NZbueXwcTLRNpfxrVbc2EjiCDB81pSusSJupBPxbqojztfi9tvnCSdS8jPSRjqwG6kzViA+qLwqr0O752xAhRBC6oec8yiMY8oNJ+/L5mCoQmZqj5vg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714716369; c=relaxed/simple;
	bh=TS1Pu5ycwQTJbFejcBe/O2DzY15arEbJL+65xOrPhgQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nTIaWaj6AyqpjOhHs5M5Z/BdZ1UemEp9LP+dzbcdHEHW5O4DKPnzlj6czwUsx8NVhj/NvzkeIytHiBBDwlgTaSu+Xu9SO+Dsbb4LQXTJuMzfD6RMxd5CYEhuFvr/ODyRKw6G8DLAZVmgmuSKTI22mAuhk+trak5uPEtk+35isUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ArF+uDKH; arc=fail smtp.client-ip=40.107.237.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dMkgcQBwZJEXPKd8S+KRgAycjYAwshv+0r9m1pBl1OdyrZaSSASu3ki2PrgqLWXr7VaqDgU6ju4ZzONBOEe56B3DPn9l00jSE6tkN6x6MK6nQ0sgb1Lq7aAjViUUZqySJxP7xMZRVJU7bXm0vysckr8mw2ZV5wvKS1XUDEgXIuyi5KSz9/xm+9dfqG2YPNHyz6W4tHWdJBQ8lrcnJ/18hkRqCgf9qsPapSzAgD76FzYsPIHIIBfJqPt68jDSAwROunJ1D6VK6f/Sv6jqUjFS1wGJfxSwBI1mfjGRWaH2bRSZdkJz4aS4Tb7Jdw3b/9ezHAQpwT13TkyPMVd3X8FuYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4615YPFlAiJJGLv39oeejZkZBYW9IdkN4OA68/HY11s=;
 b=YONVI9CQeNI/TlklDH74GccyrnomvpQiO7D2G+KbOU1M1yyDeyDsUo5iGPH6/HPxuy5AhdN3F7nTpNIpCcxUyChs55ztn81moN8LPRMGbIPuAiPJcy/XS/+9KSBduxNBYvHrxB1ek/XlFEnCA5v4/yk6p0pPlraxG8DKeFckXVyVSJsEG6wrFfoiVcJ+Utl1oI1IqtIEAayo4GO8sIB+Ao6P0RxnxYc/1ptQYN4tJMa8y07UGIF2HdwG83anfuFIbRlO3qQqQw3n/n5++Ml7lHikWCauNKQZgo9nF/jIFKaVyniId0pjNrPR0RCCDtGbdJFbzGBaZT5IeYS/lpOzrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4615YPFlAiJJGLv39oeejZkZBYW9IdkN4OA68/HY11s=;
 b=ArF+uDKHnWIAxLQeVV+hBtoHBe6zZUQCRFlkQWaJn1KCMDtLpPXZ4KQLCV3UpzgpcrVxbmLUNysvg7FNEgb4V8WRJbi6YAVsY3qG1Vx9JNl5aHUvX5BM1iZAQqK0YIHtsBMHlz/18DBLrsQJSyNylRiuIShu5OOGHWC17s0iOdk=
Received: from BL0PR0102CA0044.prod.exchangelabs.com (2603:10b6:208:25::21) by
 MN2PR12MB4453.namprd12.prod.outlook.com (2603:10b6:208:260::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.34; Fri, 3 May 2024 06:06:04 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:208:25:cafe::6a) by BL0PR0102CA0044.outlook.office365.com
 (2603:10b6:208:25::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.25 via Frontend
 Transport; Fri, 3 May 2024 06:06:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Fri, 3 May 2024 06:06:04 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 3 May
 2024 01:06:03 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 3 May
 2024 01:06:03 -0500
Received: from xhdharinik40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 3 May 2024 01:06:00 -0500
From: Harini T <harini.t@amd.com>
To: <mkl@pengutronix.de>, <mailhol.vincent@wanadoo.fr>, <davem@davemloft.ne>,
	<edumazet@google.com>, <pabeni@redhat.com>, <michal.simek@amd.com>,
	<appana.durga.rao@xilinx.com>, <kuba@kernel.org>
CC: <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<srinivas.goud@amd.com>, Harini T <harini.t@amd.com>
Subject: [PATCH 1/2] dt-bindings: can: xilinx_can: Modify the title to indicate CAN and CANFD controllers are supported
Date: Fri, 3 May 2024 11:35:52 +0530
Message-ID: <20240503060553.8520-2-harini.t@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240503060553.8520-1-harini.t@amd.com>
References: <20240503060553.8520-1-harini.t@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|MN2PR12MB4453:EE_
X-MS-Office365-Filtering-Correlation-Id: 180e3407-90db-4ae6-e5c2-08dc6b371d7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|7416005|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dCmGu4ha5XAJyfasePrwJA3UGv1ibp2CkUHKowthIia8BgDUk7ezTw+5NNtl?=
 =?us-ascii?Q?4u5JvllwVO0wmbsKD0eFBPyyfK3OcMwEEBeCMbZbeMoyfgqBggF9q5qPSC1N?=
 =?us-ascii?Q?Q58EkM/MTsJSI2LIMEeOjB81vdw8UZrOsA9QcyyDMhXKg7gV0c1X75JmWpbu?=
 =?us-ascii?Q?z3AqH3B/oMGBpCZwbur+V4c/MsvaFxuwB3SUIv8d6f4jDfxn3h1qbsLLlzA6?=
 =?us-ascii?Q?gRIfrH7B7LWMLxdxXT1/Yra5TNdk9YCgYNTJaccykNkj3QnvdIjBkChUqdsY?=
 =?us-ascii?Q?bEvzwENlgBNjat2JduenlViYQOmobwMFO8zbDWHSkB0A6yW6HZt2MBKsP5wH?=
 =?us-ascii?Q?B37Pm0HJzITpMSNWSs6PWJHmH8Kz4DQs+SrKCrDPErxP743IdlPnLLswQDh5?=
 =?us-ascii?Q?hk8EB3dx9nRQvQePtBaoSKfSh+f2Z2XKzltcMp61mvFDLtzIrz5Q2dMrhww2?=
 =?us-ascii?Q?hgfAb/xlI/HM+G6LjTVq/HRQLkHCDXjaFUivtWTdFy0YHdVN61WeRsnB6ZGR?=
 =?us-ascii?Q?nV+tOIXM22ae6PekDR8WM6BI+eg+R/d1A3iiZmbt6ff/bu7pAl1muWpRWPR+?=
 =?us-ascii?Q?uagLW+REYdZHE85tEVkLD1UnnWbZjDilsXz8qiu1VRPM+/n5KEnvqk5vKQgf?=
 =?us-ascii?Q?SLF3UPXEzrKLUy155cJaHoHM9AON/hQVdHy9e9H8zWjMEzJOasSTZPAnJ/9S?=
 =?us-ascii?Q?eAFu/yJWmu5QtOBYizrRgfGaXUsjUptBm/9v8VSfH+bhWiKMSUheF0XJ/Q44?=
 =?us-ascii?Q?9V8XxTS+sFIqZQNUpfcCKWLWlAfFfE6BDOpfTADZsr5wNXymWQrDlwftlMJt?=
 =?us-ascii?Q?Ru1mb5oDn8cDBEZjYW4K2uyrnRekku6MIzRZjj2f6ebQt6MBYV5CWxa/Mm1a?=
 =?us-ascii?Q?qT4gQuKgwRFdjDQzer0I+KB34cF58zO0FmWarLUFFbY7/Vu1wtsJY3Q3dMtB?=
 =?us-ascii?Q?jGN7N0L6GwL971qim72x8OTwt0dNuFZ/fUVUmz26K1BM1hsxCSH2B3czu0ne?=
 =?us-ascii?Q?7Pd9s8t1ggRURkTyMaYUqi7kfrQOHV00W4B/0Pgr0P+jImA/K3Hgvbb7VY2O?=
 =?us-ascii?Q?ovQl1IR0DgGVrfqbRk6pXLrcjm84TXgDd3jU5sBR+7G2P0P8yW+L7oDNAZrG?=
 =?us-ascii?Q?jxeQ0cM7R8Ef1SrybR4egp1keiBB0FyKJO+40dMOayyIYs8G2H059QQmfnL/?=
 =?us-ascii?Q?NwoLpQ3ln6yz+s+9Ywzyn4dFgLbQ37NVtb7qsUIUS0ZUAboEgWal9NTSJMQn?=
 =?us-ascii?Q?P2Ix00/bmsJKINWPkTbPDFjYh5ievj6p9PlKiscUgM3JzwrEtk+I9yDUEELb?=
 =?us-ascii?Q?yK0346qXYEMaOjJ/z/PW/wl6?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 06:06:04.1618
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 180e3407-90db-4ae6-e5c2-08dc6b371d7d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4453

Xilinx CAN binding documentation supports CAN and CANFD controllers.
Modify the title to indicate that both controllers are supported.

Signed-off-by: Harini T <harini.t@amd.com>
---
 Documentation/devicetree/bindings/net/can/xilinx,can.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/can/xilinx,can.yaml b/Documentation/devicetree/bindings/net/can/xilinx,can.yaml
index 8d4e5af6fd6c..40835497050a 100644
--- a/Documentation/devicetree/bindings/net/can/xilinx,can.yaml
+++ b/Documentation/devicetree/bindings/net/can/xilinx,can.yaml
@@ -5,7 +5,7 @@ $id: http://devicetree.org/schemas/net/can/xilinx,can.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title:
-  Xilinx Axi CAN/Zynq CANPS controller
+  Xilinx CAN and CANFD controller
 
 maintainers:
   - Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
-- 
2.17.1


