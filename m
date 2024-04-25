Return-Path: <linux-kernel+bounces-158064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D77708B1AED
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01A391C212F6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 06:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59FC5A0F9;
	Thu, 25 Apr 2024 06:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1e+X5B3R"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95793EA86;
	Thu, 25 Apr 2024 06:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714026264; cv=fail; b=ZGUUvEX9Zn20hq7RF5Ua8IwZ+cfaXiI8fYUYZfns7SRfPZhYsbjAasG6pKsmhC6nN8riM2K+/wKph8Ml564znr+1o4dmmCZMpcD0eCcQtysXBfcIw8gwpBG+YeMj+/C1X0y6KXWQiyfoMWSVTjwxYaMZ7wKqLRcahE1AqrbtJc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714026264; c=relaxed/simple;
	bh=dJBn5ygrsU0WauqHA1PDu0vSvYI7BGydF25TSeoV6p0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hFmB8s0DeXnDzAWAdeHl2keRSnzq+iLIHrhCENUk383wdZ8DmgN9QacNQ6csaIBJcUVq+BJQJYRsnfxeK1wQBbbzDbwtHW5DLn5kiNNpFpngTrEPjjvu89FURbg6T90N0Z8cyU3cn6oeUQlB0trvfBzksScIxLzmygdppiV1OTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1e+X5B3R; arc=fail smtp.client-ip=40.107.243.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cDdTEO7fwGDcwd0C+DMxKiSNF7lZYBmFiEO/GflwGOoAlbgUWvGMicaZvsh5G6Kl6NLjVcHbjy0/4SzmQCeSmbekHOS7eNj6/BS0SN8BenKpkRl8Gexh4cljmdU1NYe1BIV6sFitw8/jAVqH9uOorX4Sqk0dfFrm7axtI8ABR+EiSqUP6QzaxiDwdpOG5RFWOr8ESSY8m7rvEvT9yY84Po/EOrPucub+8xbU426A6zjGJ/JrsOnDxVxZdEX/EFi3mcaB9XrTK0vY8gvr484zfbs6USI6p0D/lfcQzTIzXS9nV11IHDpCeFLaP8VHnKl7fK0m58O5t29g4l+lUNXJJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/5L4mZ0IMwOJV0Ix8FWwaMTFIIllhTTU65PETX9woqk=;
 b=S+RwQxUawu0yKX3E36YFf1YcZmPNeV3XTDYPRTyQxuaqVScz3n25wJpK3vTsfLi9TQ6mfZBR7ANuPeRhn6G5UHjbB9eiuL4gLhKWwGl9DzGhkYUJtCXD3e6cLZw4TbKhZb8CmUoLskCdEI1O4DU9Wcgk6Sby8oCOch82/kww3qQpAavYvVahSZDERvQRJE54aw7ZKiaPjyEgTvoogNnAdey6dhQ4qjkkrnIVBW5Ofatg62fAvwnFHXfWItCch+Mh+1aSpvjzFugPNqHEal0nL6qM0c2bIlM8kughtR4hJk45ndA2PwOvqYxhxfndjdg9LjNPxp6w74e+oo222AYXug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5L4mZ0IMwOJV0Ix8FWwaMTFIIllhTTU65PETX9woqk=;
 b=1e+X5B3RqNN+Cgf3CzpLAtnTRnfi28OiixpS6CwVFDKvekDI4ckAXMGmDbGMcAEihq/EPmiUkSz+9i5lkDGh6JkuFr4/+ZSRp6I0Q6l2r4rjjkk5CXTbk5gvOcOpSvzP1IL4+5FROwcGVDA2C/Mj0+p9ppwiT6hK2R68ICajAvg=
Received: from SJ0PR03CA0265.namprd03.prod.outlook.com (2603:10b6:a03:3a0::30)
 by DS7PR12MB6237.namprd12.prod.outlook.com (2603:10b6:8:97::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 06:24:17 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::52) by SJ0PR03CA0265.outlook.office365.com
 (2603:10b6:a03:3a0::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22 via Frontend
 Transport; Thu, 25 Apr 2024 06:24:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Thu, 25 Apr 2024 06:24:16 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 25 Apr
 2024 01:24:15 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 25 Apr
 2024 01:24:15 -0500
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 25 Apr 2024 01:24:08 -0500
From: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
To: <git@amd.com>, <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<michal.simek@amd.com>, <p.zabel@pengutronix.de>,
	<laurent.pinchart@ideasonboard.com>, <radhey.shyam.pandey@amd.com>,
	<parth.gajjar@amd.com>, <u.kleine-koenig@pengutronix.de>,
	<tglx@linutronix.de>, <julien.malik@unseenlabs.fr>, <ruanjinjie@huawei.com>,
	<linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <srinivas.goud@amd.com>, <shubhrajyoti.datta@amd.com>,
	<manion05gk@gmail.com>, Manikanta Guntupalli <manikanta.guntupalli@amd.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V3 1/3] dt-bindings: serial: cdns,uart: Add optional reset property
Date: Thu, 25 Apr 2024 11:53:56 +0530
Message-ID: <20240425062358.1347684-2-manikanta.guntupalli@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240425062358.1347684-1-manikanta.guntupalli@amd.com>
References: <20240425062358.1347684-1-manikanta.guntupalli@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|DS7PR12MB6237:EE_
X-MS-Office365-Filtering-Correlation-Id: d1bde0dd-7825-4d0d-b369-08dc64f05529
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jMwCIH24GUmXJg4A3WfuxwwpNvcLuAzl0JFDFdupp0uGoSLXpD2p+JGA0IE1?=
 =?us-ascii?Q?8V3ZDmvjtoC9dC6PpFhrWDTe9hdphoxwKchzXeeX5Mio3wSmB8QetMviWnOD?=
 =?us-ascii?Q?hV51vCquGd9UQICvumeTz0ZUItz2etGAbiVasbyHU7GchWWM+Kj4ggNTkvh4?=
 =?us-ascii?Q?x1QmmpMpvv9FUvsdWkBQ8WQXpOHkBbtQS1l3gQxpCeNpVzzfC2ezNdLjr8J9?=
 =?us-ascii?Q?ezaXFWZGYzbwCKTVdEnoUC48fgY1J606tH+D3bWkKFgS8Yn1/dufpA4/Q/MD?=
 =?us-ascii?Q?GwX0N1Kc0uOZZ81S86dJOr0no1Q76GQrEG9uZgMyMGAf6EogK5bHi8vv3aK2?=
 =?us-ascii?Q?cjn3kZDWZFnsXkXo7fmTsoDxCQvu2HPssFr8MF0h3KKJYO6X4347SRFNka3U?=
 =?us-ascii?Q?tYl1gVNnnSJPCl67JnI4RZrGC/0tFRIueBJtk0mLJ5Z1dl1N+t+/ZOpL0Nwb?=
 =?us-ascii?Q?DLUGhj/82+aPivm4SqMu3Cibzih78egSvNTmA1EFyiAIrjX7Vub+ebsW2rQf?=
 =?us-ascii?Q?kqDiKzd3xy8Cza9Vkcn82M5IIINqWWCgP44spvHEQZ6cMA6LG/sGptyzY0nZ?=
 =?us-ascii?Q?58Xy2a3gr+NMXH7aqKlXnfbr4NEXclEEdXrNvuGWCU5FGO6l083iQc/1zMkE?=
 =?us-ascii?Q?hKcSjWsuodPi2BCurqac3c3LCMHGfXMmO8MorRa731WGNxSPc1qrcfHFEecq?=
 =?us-ascii?Q?EdH0KgwIrxh2MhNB/zs/32F0sVvqcf4hRBilHO9SMFy6sXN+00kkR4Q718a6?=
 =?us-ascii?Q?oRGomu9HVTh/Elzf6ZLdE+JWpqPuhlOqil18llxqCvcf8QpwPK8Gi4w9Pzql?=
 =?us-ascii?Q?98ohHghtlBW6HJJFNeXyy6LKIaqUZETYEHdXv/COibgBIUssVJYGhg0rosUY?=
 =?us-ascii?Q?oe8wXCTlL7Je97ubI9HvjowTtsXziTy59WvSrrh+ECQJYFumPvGszIy2D3Qk?=
 =?us-ascii?Q?Qqs0Eeh3dnxQn/Ua3u3hAUb07Nz/9gUpuTDRpu6+z71fsHIjNa1yOzMSrYnM?=
 =?us-ascii?Q?/Th2iHwTCViWSl/9RELq3M9s1eie+v1PMPgQqPWhEyQGWNvN/RgrGEWo5oea?=
 =?us-ascii?Q?DX0XoFJQjX7fHeruNiRzfx5ndTYbIlWRUWRI7bS1GkiAOqv1nfL52aYPGURT?=
 =?us-ascii?Q?8B0xBsq5tIa5g4z+1A+Zm5HTHuoMlz52bQrMG1PQhkgj6P0IGq3XrqT2DbjR?=
 =?us-ascii?Q?LXOckTA/TOcCmNIg4BmoYjRfMRa4IGtjPn95yPUgwa0H1tGugpBG/SfurxTr?=
 =?us-ascii?Q?ZKK+Bm3f8mvHm9t4LDDNxcOPmtLCL+x1c5td5Ax2E6I52de/f6p7mPF3cEIh?=
 =?us-ascii?Q?6k+/YqzuKZ0RhxPeM46PuaEqiQJ6YJm+1YmWQJZZcy2mcpd5XHHOui0EYA3C?=
 =?us-ascii?Q?EtRVc6/d+McNG+NKtT2LbAYOm7NU?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(1800799015)(7416005)(376005)(36860700004)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 06:24:16.1930
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1bde0dd-7825-4d0d-b369-08dc64f05529
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6237

Add optional reset device-tree property to the uartps controller.

Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes for V2:
Added ack signature.
Changes for V3:
Corrected typo in subject.
---
 Documentation/devicetree/bindings/serial/cdns,uart.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/cdns,uart.yaml b/Documentation/devicetree/bindings/serial/cdns,uart.yaml
index 2129247d7c81..d7f047b0bf24 100644
--- a/Documentation/devicetree/bindings/serial/cdns,uart.yaml
+++ b/Documentation/devicetree/bindings/serial/cdns,uart.yaml
@@ -46,6 +46,9 @@ properties:
   power-domains:
     maxItems: 1
 
+  resets:
+    maxItems: 1
+
 required:
   - compatible
   - reg
-- 
2.25.1


