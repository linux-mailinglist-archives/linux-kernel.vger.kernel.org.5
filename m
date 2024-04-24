Return-Path: <linux-kernel+bounces-156797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B3F8B084D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D4A1289B72
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BCB15A4A5;
	Wed, 24 Apr 2024 11:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="T0N/p32k"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7205213DDD9;
	Wed, 24 Apr 2024 11:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713958194; cv=fail; b=n17x5JPvK8CWONi8JT78cnFJ/IzKJxTQbW6A6x4hFNK7jOvJ0pIM/3XGI8UiMXxenAuFEfM17cIud9Gtwa/PP0Fsbl0sOUJ+MLjB1wBQk546ywSjQNepYyW1hP337tEHuAQ24ky4vr9ArR4PdIEGbKelGpvlL4bL7fdcWGIA+jc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713958194; c=relaxed/simple;
	bh=jsamBX08jd1EraLOdiflxD8v4642xFN8xqYfMQ78JG0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dpwZWRdJDG27NDSAPOk8suotuklMvBlMz3qGiqmQid5XNUxD4Ki3pU6//l59/x2O5aDJBCL0AugifakxDOfF/yWk67k9oT5yMH1vkVFDvinbiylqPPkvFdhwmK/Zb36pKDbsRDk4Og4KHhk5WVwM5BJIIqWuCzeLBnwkDP0KmQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=T0N/p32k; arc=fail smtp.client-ip=40.107.244.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RrMe4rep1EsvBPfhjrhjAxVsM+IMKZwECUKnSjF0TkQnyhKbatmsrmtafI1vBanwliFeXZf0QnmFyhSfbv75ZNFmp4ExtgFJHpSVYRvkIrM71vGNey2XpLz6YQSYfMjE74700nvEDvlON8Xy5ccfxiTyMm3WeBySvfIoCWbW7cFswW92ppU3DeQ7OFKI8zJRAnvs+mvrSRv60SiUiIXJ8ybMnC9VopemyaXWY864obcaQmflf1clyk96+FRUdp88FZk5rhS1kubWuC9rD9s+rECzbwI3MNv6prbpL2n7S3ptJyxhT9Nn2gEt2lRuQFBBPumX+za8010zkKaZ/EDhQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wt5pI4ikjk89DRKN6vnI4USyoQ7HwxtUQYLxNZhCGc4=;
 b=bscoDnQVyYBC6SZQ+xoSeKJEsI46oB+YTrV3rjtGClVM3omUFxjgjYi9uDJd4AjEtAp+XoSADawksgj4d5Xi8WkmAnuBQWTZ5Niv6NdtoxcAeE+pfCe44g4/Shnh8HDafWCi8sHE13P0/Z9+D04oTQ6th10DGZgGjcNpQhKxlH7g984e7kLtTxNS5LLJnKNlBs7lTVuS30u82BuyM8fEI3uEGfLImFFUsNpxMJsX5W7ASXOMk3y/6w28DZl7qmFKnny5z0e/ltjs6CWQgcgVK2j63s8GQFAgEyZj8qO/tl8QDo9dJXozSCjTCSRqR5iOF/ntXxH7sBqYo1QjmUdtJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wt5pI4ikjk89DRKN6vnI4USyoQ7HwxtUQYLxNZhCGc4=;
 b=T0N/p32kqKRqsYtBuT7F2sOdH+d1gziX9HowYDqsE0hyAxaPWi6oDbevyjqfyDkEZi7g54SfVr7gz4UCMlah0SsGrGyQzxi0LXBMkJqsCe/fYw5hMQ4iggmI02ozhGTxHzlZQTgPXLASXvM0D6ppGrjkKrlGbC852a+NA2fE7PU=
Received: from BN9PR03CA0181.namprd03.prod.outlook.com (2603:10b6:408:f9::6)
 by MW6PR12MB7087.namprd12.prod.outlook.com (2603:10b6:303:238::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 11:29:44 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:408:f9:cafe::69) by BN9PR03CA0181.outlook.office365.com
 (2603:10b6:408:f9::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.32 via Frontend
 Transport; Wed, 24 Apr 2024 11:29:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 11:29:44 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 06:29:43 -0500
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 06:29:37 -0500
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
	<manion05gk@gmail.com>, Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Subject: [PATCH V2 0/3] Add support for uartps controller reset
Date: Wed, 24 Apr 2024 16:59:30 +0530
Message-ID: <20240424112933.3528590-1-manikanta.guntupalli@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: manikanta.guntupalli@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|MW6PR12MB7087:EE_
X-MS-Office365-Filtering-Correlation-Id: c16bc185-0f14-44f4-44de-08dc6451d746
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C/w90pwK22rEehZ7XiyctMJfdOToXu8ftQsYzoeejUApKeMpMNonCDyQxSGb?=
 =?us-ascii?Q?KjvEeFJDHemWvtCloeglzYC/0vZ79gf+NHraLlzf3OenhThJftwlmzKrUthK?=
 =?us-ascii?Q?FHilErKNMEo7X6DCkALtr8QaHOfcN6jtZry08rijLnnS0dT5fpsaqv3EAw0A?=
 =?us-ascii?Q?QasiREoNdHRlCG9q8eCQLecif4Kzd5CPDAkSv8nZ3ctqpdA0wS9F/rs1a6CC?=
 =?us-ascii?Q?T2yrernvjm2Odsox6DSdMdWq86pvD6Qa/KV85OfREiPY/5dnWlAxGMKtUASw?=
 =?us-ascii?Q?q+lfg42fD8XSBUoMAbm0P28RjXtk1EYZsU4DhDlW4aMYiXkYQHJWUv3XJLg8?=
 =?us-ascii?Q?HmvyWZcAWpFm69ZOkhlAev3I6BKu2jAba3FWCRSxcqDytdi2XCltMuxsI8UJ?=
 =?us-ascii?Q?jfgrBAwQlcBVPOB5hwW6gkpzGJPdl/Te9Do3zNW/tDdMnXnaEYKyETI9cTP3?=
 =?us-ascii?Q?IxYQLQOjEkzFLs+IJzHzHBUnr94FtALDQH7GZQ+NRmsrky55cj0e3O4S6iGG?=
 =?us-ascii?Q?oRCnp9Sh2nI6ujPMgjfXNXb9afpHshtAvqEasJx+lPzv9FgxoRnbghiUuc0k?=
 =?us-ascii?Q?xNP6WZfVrlWlrcXPSNy/xDGDRuj/AGVaiqDN4Avzxh9DQX/bkNeVWzpWrPlZ?=
 =?us-ascii?Q?LSIcsoyk1s0XNNnH2z08nQB8nMtriRRPIRBzdphPVpJeD16YTEnwYfcrRqjK?=
 =?us-ascii?Q?UxjV5SQXJct53XIigco+6okspoLfq2wtS136H6NWhrZdZ3sVeHkvy7YFNvaG?=
 =?us-ascii?Q?Bicjwq9EezR72OeLhEDMOhdrFuhpViUMWPHAUzaTfFiq3ZK/u4bfHruF5lDC?=
 =?us-ascii?Q?+EKLWqjZhbCFZgWXDsETHDcoHEQ7CIthQsb8LhIDfIYD06FUWnH8Hjq+tMbb?=
 =?us-ascii?Q?X3d1bzIHgl5f5kJhfxluL/GKSkRSy2iLFF+dgA57rUmzTdSWtpzv0Jy4MSBM?=
 =?us-ascii?Q?dqkcwILFQqaOh1420q5+z5a4mPQiaBb+Elbua5f34LQmXMz5kbpRpPz8UvhK?=
 =?us-ascii?Q?tBvM7KMmvSe/Zg5Q55urNSlzmasosNJtidcJl9uwJriWrMRh5EgYMRMLHxKd?=
 =?us-ascii?Q?+xGusmfzbjIku+nOCM51HlBluKvkEIt9jv2e78RjwWFOgMoGmljYZ9FNKPjO?=
 =?us-ascii?Q?MlGq/E2Zky2AkD2WVjEOlSHl9kL309g+zJTpQ6e4eDsyoYxmrsndbesl9p8N?=
 =?us-ascii?Q?PpcY1fSOAm7qzy7EiuDttqOF9bpRwkhUaTPNnBxitwAfb5VUTo+nY1YEcXOO?=
 =?us-ascii?Q?iO/eZtqAPEwshCkY7CHu0PCpUmgvRNgU1dqigq3zJU4NxVWShiosOLESMQlk?=
 =?us-ascii?Q?VtulpTp5XIdS+wfnrS4b3o01oLtm6t+u9ggM1afq46OG8iIsyNps9u527jZZ?=
 =?us-ascii?Q?c5h/70YkAcV+PbulAT+9rJGJZ5gR?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(36860700004)(82310400014)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 11:29:44.6134
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c16bc185-0f14-44f4-44de-08dc6451d746
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7087

Add optional resets property for UART nodes.
Add support for uartps controller reset.
---
Changes for V2:
Added ack signature for binding patch.
Remove check for reset_control_deassert, as reset_control_deassert
function internally has NULL check.

Manikanta Guntupalli (3):
  dt-bindings: serial: cdsn,uart: Add optional reset property
  arm64: zynqmp: Add resets property for UART nodes
  tty: serial: uartps: Add support for uartps controller reset

 .../devicetree/bindings/serial/cdns,uart.yaml     |  3 +++
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi            |  2 ++
 drivers/tty/serial/xilinx_uartps.c                | 15 +++++++++++++++
 3 files changed, 20 insertions(+)

-- 
2.25.1


