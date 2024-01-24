Return-Path: <linux-kernel+bounces-37742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BEE83B4B0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 23:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D286CB2444F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6E8135A56;
	Wed, 24 Jan 2024 22:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HOW3hzSH"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DA52C9A
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 22:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706135510; cv=fail; b=bxOOIdbmNksYqiQdUUWRrOtxD3mVAJqQ/timQIidx1dYSdujJc3EVHhlhCLPEbXVl02nT698mwgo6qR1/N8bEAi5Uywfu+wdZxA2E4xp6z7VbK7DpbgoDc/1lYQSCrUu6Z7pfooONUUgheu1joNDKitIrF0NsQNs9yC+W2AevBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706135510; c=relaxed/simple;
	bh=CByfFRMcninYn39PwbeYDRLpKddVcEgALYoRfhHNbMU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M7R/l0SwVs/5o0sTuLWj3mmSGxi+b4UO7ln9TkMCgJfnX/cs17SJUASbbTfZBMcONjpowSmFwNgwTG1sJHh/n/s5kqdLEG0XMCEUrUDa2Z3XUig8/4gDzWpJqF92WA/nUsJOrZhdd/8lsZY2xpuFtoZV8E6cZxs6Fx5ofgj7pfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HOW3hzSH; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=THZY2hyth4M0LSvmcX4W95s5uuRAawEVXOcBDg8N5DpiDL7I0OMK/y2KK53KTxa2XDdVJ8Uhy6f1zqAJHPdoPcefQ43Icl8+ES3+Qsdzka5yENzkD2hHpIUiiTIwkSungEaH3dPMgz5l3mcODqWXX4CY+2skHkR9+TapvJgc0i3X9uCZIjwfnaexD6PI/6YYL6R6JzdUayGH1WECqPXQWdhZuJ2XB6UXuyYE8OJrDxSnITtLmF6GWkKCEMBHFjcVUm7GLXtQG6Vf0wZMWw7Uy2KFjpBr0KCb9njzf1nOTr/XgXp+GNV1ZwW9HWZ34L/lg28mkv6dGVRcmY1tJL2UfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T9xFhtXGgKcOmjnjmtwUM83TZlgQuieJ5XMXZqCI+J4=;
 b=SSEadkwXo5JAtMFxX8rfhgwbg/IbmXEY13fqC8xLryzVe3lqlyfDA8MAU2acN62O3thbCb6Y8BSfc/H4ZaX8BEhXT033ELGDMIok8Y//brxkk8bZ19cr4kHEQpxA3KHsIkeP52uw3vUhwIqPQ2XvMMB+KAMXWbiVSSi8I95bF1xlANLh6sKcEAhuGzRWgcaA3lENBu6t9b3gKhCgRZvbPK97S0M5Nz+so0zKwsOS2DCq/e1/gEUbdpGn3zRrSQpgDmXWC7EDZAHsyEwAbJ5dmyYAF/QsH5KxGZCIkXFleR5c0zqCTCbTTkaM6AbIAOnQSvK/C8lqlSXucbV/0S3sFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T9xFhtXGgKcOmjnjmtwUM83TZlgQuieJ5XMXZqCI+J4=;
 b=HOW3hzSHZTxIxSl20yKcX7aMpi0rljGn7L/YomerO8HaTg2ogzwEvCDIsW3X6FJRZxu37u0tTLKedwK/pYDwoB7sBRlmqrMT4LjwisoZgwR0mgKcqpMKKGsS/xupOfnjRPcnTVdn4u4Ot/UqLUTEeWdbaS9+zXMMu9L6EGcM6BI=
Received: from BLAPR03CA0071.namprd03.prod.outlook.com (2603:10b6:208:329::16)
 by PH7PR12MB6418.namprd12.prod.outlook.com (2603:10b6:510:1fe::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 22:31:45 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:329:cafe::ad) by BLAPR03CA0071.outlook.office365.com
 (2603:10b6:208:329::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22 via Frontend
 Transport; Wed, 24 Jan 2024 22:31:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Wed, 24 Jan 2024 22:31:44 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 24 Jan
 2024 16:31:44 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <bp@alien8.de>
CC: <x86@kernel.org>, <dave.hansen@linux.intel.com>, <mingo@redhat.com>,
	<linux-kernel@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] x86/CPU/AMD: Add more models to X86_FEATURE_ZEN5
Date: Wed, 24 Jan 2024 16:07:49 -0600
Message-ID: <20240124220749.2983-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|PH7PR12MB6418:EE_
X-MS-Office365-Filtering-Correlation-Id: 74acbc85-5da3-474c-c7c1-08dc1d2c3ec7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	stZeULCOeCTEGGZ7hv5FcssuJvWiLS4q+Z28+JAX6CFhAq0IVRopVpOUCd0OSeokbB8SLQZuPT9UUVUuVGDe3+4+ZHIpJrGFdn08qAUSLni8HJ+jOHm3I2QMHUiFHW+c9iv5vPc2N0HCK4IEzHsUPZ/lZVgwWStq9sNeNgACHyhviKu51bujuXK5rABGwFMnJ4vvjEoKCfWXN6CEjT5i6A+cGN4w3SHB6Mr0vDo9o/7NHRIOv/lBMnosHk8iGaaZ/5g2f6VnZHytPc9MVMncRJ5kN0a0QNvUVYkWT4aPk53+E9gmKeQrttLCEQktkYUlSsUCN2+Eoq+agZ8QZnBZPLrxg2vE3/OtjF+jDDoc1pzx6bAYmEc9D6YjgD+x9z1XdcLUPGwWSllGfY+f4DOQw49jCkaBLlWs4glR7FqLFfGSvp3asisehWL5zEbkHb/+c6EY2mE1wkADFxQoNTeCWndejMFi7m1dnAs8bew71Mxqk6NtyFxpZiHuwjy8vNKj1bq3z2Xm8m/vaQ9zmOGGh1Tdh0r8tezwm26Hr2Nrb/EY4BkkcXtVPLg8FKKlQpnloWdky5YtuwgVj74JZUD0oBQUC9v18w1g95949rF9/nSwOdub25bnymJWSCjGGB+jj3LlVvAKPQvfCWRLr+heusjgLCEx1MobTDC66HW5AEw8pYT2jcBoM78IDIa2u8o2VPyhKf/9EcEPKu25iyjb7bOLwofml5jLzJ+VNRuf4f4vuQaoAHzO7wNXFEAJVW3L0WTvAtTIZaRFPCskXTzYww==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(230922051799003)(451199024)(1800799012)(82310400011)(186009)(64100799003)(36840700001)(40470700004)(46966006)(41300700001)(1076003)(336012)(16526019)(2616005)(26005)(426003)(356005)(81166007)(36860700001)(8676002)(4326008)(44832011)(5660300002)(8936002)(2906002)(478600001)(54906003)(4744005)(7696005)(6916009)(70206006)(70586007)(316002)(82740400003)(47076005)(36756003)(86362001)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 22:31:44.8345
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74acbc85-5da3-474c-c7c1-08dc1d2c3ec7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6418

Add parts from families 0x20, 0x40 and 0x70 to the synthetic feature
flag X86_FEATURE_ZEN5.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 arch/x86/kernel/cpu/amd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 34e5c2cb8042..310fea1af124 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -573,6 +573,9 @@ static void bsp_init_amd(struct cpuinfo_x86 *c)
 	case 0x1a:
 		switch (c->x86_model) {
 		case 0x00 ... 0x0f:
+		case 0x20 ... 0x2f:
+		case 0x40 ... 0x4f:
+		case 0x70 ... 0x7f:
 			setup_force_cpu_cap(X86_FEATURE_ZEN5);
 			break;
 		default:
-- 
2.34.1


