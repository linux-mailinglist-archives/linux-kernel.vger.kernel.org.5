Return-Path: <linux-kernel+bounces-54011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3323284A91D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 23:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF652B277C2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7236241742;
	Mon,  5 Feb 2024 22:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yAud9Hz2"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2086.outbound.protection.outlook.com [40.107.102.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12E74C3B3;
	Mon,  5 Feb 2024 22:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707171407; cv=fail; b=ae3QHCSjGQl506Io0wPZd37lI7W/3mKZruCz+exzntl/FS1hpCpDEJKMOu4T/hiGeHJ0/BJlZY572Ou5cuIld6ddb6qeOpbGfvu9XSc5NFKl2gIkkQqXV31FTTDYb1Q4wV9MtTVneWgL5ZU/CBeX80HNIqg2WtmLNiXxQYo/aMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707171407; c=relaxed/simple;
	bh=mxbP3vBviYrpIx+68K7umWrWxjfcR6b6lDEWecf5kOw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c55YQJPS7fB0KhW5KEwKykcuJtS1w9AkL4iheFIEl26BrtS925QBnL1OobIxCsT9iBT66lt2ypEw7X+ysNNQradeJPjNIe6wnEuOZQqzRdA+gAAmZt1MgqRFkHYqVpb9/Oz6cTdM3//EbAztkA64t3KtUFVum7TL+CYYPxDdFls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yAud9Hz2; arc=fail smtp.client-ip=40.107.102.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OniM0ODB6ux4AVI+BdNgotWO0KRMoX67f2cJjGRKdyeMFEp4VWzDywfov6/N3tDwbuW8SFd808DRy1HOigwgmm08F48iRkaFV/Bjuejh5J951l5W0RGLer8/FnotflPkTWvh/cmuEna/Y7SkqrM9vfireNiu7X5+5WHY5+lGD3c7kxwHw6T3ctI9EjzfpCrZ0TGXRu16Wwhk9ZZQBvYyzb53/hyyU0VUhU1ceQcdfMRFS5Zx8NqP1P0HIdtlP4g3Onib8udSavQoa60Qh11R3mISyrUqIdsN46i+LpPb62Vg//atmC8m08FFdDWVP0KmdyTzNMIvX8sDC46tliRbng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ye7ww5NaX9dwyzgceCVYtHR1cq15Hq41BCuZ6BhLIZ4=;
 b=bfbzWQTnQxlEtULQ1HAyQS49wuWZoJOqhdgyfQIWbEBnpYvpi2bN0M3MhBP+orC80sqOBt6nOmG49P4DnO6nCTNIQRZTU+tggG/dPulbO9iNUvgvlryXHzpXKAmoWBIxnU49KRyIVCN1JHyURiK6q5T3ziaTDZ6YmvJ/zyGwimUJa1RqLiwbvVNumqmh3lUTZf+OSE6ZuVq8O1VsfiMSZc9qPjdLTn5l9xu0mA4ZOFooRF3f4TdbfkZMqdYS8JraMKF8zuuxMyJ1l4dzL5CZQfZCnO3mpx7+1jjoFttaHwTKcMcgAziz19I0Zm6wQK2hnXk1Ed3rZWM96dGWfDGH4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ye7ww5NaX9dwyzgceCVYtHR1cq15Hq41BCuZ6BhLIZ4=;
 b=yAud9Hz2bWs0ad4fn3TLCm6rhO/ryFCcvYYckMWqaumdlLZ9OBzAlAI34M9ygS83zxAvTQ1c9rzYk4rgVjKmP0OajC4IFaC+6qmYdBtJzJlNMk9ZbdBWroibTOyiTrrGxwb/xPbnzL/56rmyokosRsNjKfHHdefueh6ezu2DOaw=
Received: from BN1PR10CA0028.namprd10.prod.outlook.com (2603:10b6:408:e0::33)
 by DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Mon, 5 Feb
 2024 22:16:42 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:408:e0:cafe::a8) by BN1PR10CA0028.outlook.office365.com
 (2603:10b6:408:e0::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34 via Frontend
 Transport; Mon, 5 Feb 2024 22:16:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Mon, 5 Feb 2024 22:16:41 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 5 Feb
 2024 16:16:39 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Stanislav Petrov
	<stanislav.i.petrov@gmail.com>, <stable@vger.kernel.org>
Subject: [PATCH] ASoC: amd: yc: Add DMI quirk for Lenovo Ideapad Pro 5 16ARP8
Date: Mon, 5 Feb 2024 15:48:53 -0600
Message-ID: <20240205214853.2689-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|DM4PR12MB5070:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d838c5c-c7f1-4e77-3aa1-08dc26982162
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7ewkgPlBixfV6Pp4DhQVA5ilgvDCygD1ddh+V/401sbc1PH+yNF4anQPp3uUGvjeJKM0hz6+8RpzXSaG617tvYP/Mu88XcNukUW8H6iLsag1Bh8udNgVhrzbxreRnuFuEwBaI092KDv+nVCqo+uHk3usCkXEQtwy+ew+a614wAFcLZaWFb8IkKWer7RtS3MPD4NkmMaAuhaCinq6Q4v5oBIHI9bYFPYGXk8qjZGpztHJIyolZMFvYqAiL8oUEfQ+d2boDQTPLBZ8bU8dPGcfoSpCHPKXELek0tFyv6vAfCLBYZ1gDpulR+/S7ERuUAmSeL3urnL7O1k28pbQiYvMA3LVSpoe8Z6qvq02+1vur1OnunhVBNPxe9XmJj9X9ZfvXnb5pYPRMvNz/14ESDQ/3i+6uQnpsDcljsS8tT3JFL52AaDV07n3xaT+nLhmUy9Y99O3nTI3L3dryyRTAbHPxUzxLrPOPZvKAKzsUHMKklLCdXNPgqDj11JUvl5DYFK2tfIESo8L/fYm62XhxgRcoDnISINYIU+noHWRTyjkL1uNWMZI8ggMbJ5ad2lBJPDrZ/kZ+2Jpf5uwTBefSYMBh5yT6AcgrMDUQjOfwVrIkQMbAnV+w0jEEMQ3HVwJFg8QcTmyaHPamw+lXo8/QJ04xMV2t0WGHos8Fi6fYkyfhP1R8I0ee4hVX+Dm/QoB6DIbHhLCWEzKBf2xLSk2OzEfpAkKObMtasGGRc4uoqOfqleaYuv2ua2reYAYetQhAmAGOq3DkYsVknYI7u3xAayo8w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(136003)(376002)(39860400002)(230922051799003)(1800799012)(64100799003)(451199024)(82310400011)(186009)(40470700004)(36840700001)(46966006)(40460700003)(40480700001)(36756003)(41300700001)(47076005)(356005)(81166007)(82740400003)(2906002)(6666004)(36860700001)(478600001)(336012)(83380400001)(426003)(26005)(16526019)(1076003)(2616005)(86362001)(7696005)(4744005)(4326008)(316002)(54906003)(966005)(70206006)(70586007)(110136005)(8676002)(44832011)(8936002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 22:16:41.6269
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d838c5c-c7f1-4e77-3aa1-08dc26982162
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5070

The laptop requires a quirk ID to enable its internal microphone. Add
it to the DMI quirk table.

Reported-by: Stanislav Petrov <stanislav.i.petrov@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=216925
Cc: stable@vger.kernel.org
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 23d44a50d815..80ad60d485ea 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -248,6 +248,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "82YM"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "83AS"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.34.1


