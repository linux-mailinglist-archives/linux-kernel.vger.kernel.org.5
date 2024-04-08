Return-Path: <linux-kernel+bounces-135794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD16289CB6C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 20:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83D9BB2521B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC56144300;
	Mon,  8 Apr 2024 18:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4hd5qruZ"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC293143C7D;
	Mon,  8 Apr 2024 18:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712599369; cv=fail; b=EuNhSEtk4LvptKutRrg/79KC17/ZeCEdBVr6y1oQb9ItET4vNjnYTj60IJy7vY4P09U71CksxIyTXf3RxsJLTk4yiN4uSm19+x/SkeWMXiVBrbgt8d3IeziXYeKvVYKr2qyPPM+pUygjfeI+4rlJVJSxSuifrIBk+6Tg4PPU7V0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712599369; c=relaxed/simple;
	bh=8IC6AsgV+sSctxGk3R4/3Zg85XkOACeyjxZRS4gFavc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eCkTn5I4iLQOfyfCqopKoJc68UE1BdJeiEStG6O3t3YD++heBu6uz2wN8PqvFqUAbjaGNchk7bTuqZqRG9bNeVe95A1v1amrh61BRwNp3VWxLhp0XSRt0TVHut9UfpLESh86wSPr2q0k3RKFmvq/UPslTtanqnPdYesiQ1lDoH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4hd5qruZ; arc=fail smtp.client-ip=40.107.220.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nPevfOVFiBNTUaVhO6Pyfhx4djTV3yALIR8AOWo+pXGaySgMKL9Cu/YR5Vnq39fbmpf8ECndrUJX0mkrmyrmP0aeJYWEYT/nYnL4sDf8ApZpDT9IqYygDKyv8EWmbV011/C60kk9Km6i6boO0TF8Xpqz99GyKWS2SYo8LFakXn6VDxJJMES3MtNnnaygjkq0aQvxzwxaL8c6WzXxOS18HpoljDJWdRvGP+hU7mfFArda5shtBiy2SglYgL40Q/EfYMxcPqK0VFsgnLMb8pDXzC1WvGSIR2bnqlrn0aC6njrzB8yQAZu70uA2gxhTxXvgMHEggo7I0fW/2abDzcXjiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i2femoaYcJJamd6wwIdA3to6ZmvP++teISEfbILJZgg=;
 b=AZwlCaojye2w0eVlWTpB7y5fcNPpRUWrVq4VXd9QkQz3nPWIfiJ8PQWiOd8NFHKcYzJJUc0rjhFQlWRppe3CEVMdRIdhIJDCMBI4+sOXjHzhk7Zw2SLg5E/OHXIT8DFaoRDyR2mMxNgAJHqDUnDBQKX3ufEth43ptroCeDK7ahyVoiAqwIM9sCnchSL5EzD/y4W+bs2U8w87xcFm31kPOiXUv23mjC2iBoiDnaBuvQAjkUokpnwkSXYvUT5w/SwnMJULIR7JfJci/f0b+9XmsiXFKJtYnBvgL1wKpofmzYMMJzotHnsKfpulk2R+S3fd9W4a0NgvtN2U2nfPCZ0yRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2femoaYcJJamd6wwIdA3to6ZmvP++teISEfbILJZgg=;
 b=4hd5qruZ3MJOQ9WPaufQoD2vCrZGD85zMWcCo2MZ7BtFBjDVfVg4WmMIJCr9fwqN794sKoPcWmbdk5J6UwSDRI6EPe82pDh6rPiMq2xJEz4Df2MMRf9YHIAwIYQC41pN+k4UCsoZbkM8BKbwzeUYUVY9YJx0Q1y8SIjFEuG3miM=
Received: from CYZPR14CA0012.namprd14.prod.outlook.com (2603:10b6:930:8f::7)
 by DS7PR12MB6358.namprd12.prod.outlook.com (2603:10b6:8:95::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.53; Mon, 8 Apr
 2024 18:02:36 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:930:8f:cafe::de) by CYZPR14CA0012.outlook.office365.com
 (2603:10b6:930:8f::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Mon, 8 Apr 2024 18:02:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Mon, 8 Apr 2024 18:02:35 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 8 Apr
 2024 13:02:34 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 8 Apr
 2024 13:02:34 -0500
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35
 via Frontend Transport; Mon, 8 Apr 2024 13:02:30 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <Sunil-kumar.Dommati@amd.com>,
	<Basavaraj.Hiregoudar@amd.com>, <venkataprasad.potturu@amd.com>, "Vijendar
 Mukunda" <Vijendar.Mukunda@amd.com>, kernel test robot <lkp@intel.com>, "Liam
 Girdwood" <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, "Takashi
 Iwai" <tiwai@suse.com>, Arnd Bergmann <arnd@arndb.de>, Lucas Tanure
	<lucas.tanure@collabora.com>, Cristian Ciocaltea
	<cristian.ciocaltea@collabora.com>, Syed Saba Kareem
	<Syed.SabaKareem@amd.com>, "open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER
 MANAGEM..." <linux-sound@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: amd: fix for soundwire build dependencies for legacy stack
Date: Mon, 8 Apr 2024 23:32:26 +0530
Message-ID: <20240408180229.3287220-1-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|DS7PR12MB6358:EE_
X-MS-Office365-Filtering-Correlation-Id: 77f35211-f809-4832-a1ce-08dc57f6126e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eNkKzUykRlJsD/KqLThGVoEKuUANvVHXla9j50Xt1nA1RE18H6YDWn9aiT1BcM+BtMyapm/q+FiQteKwji56xM/NQNbF0ewb/q9uEKvc86JYmOCIwNCIFUU4IE2/iLijYQuwVbKk64VauaXYzSkznWJHwUnWoHaYVkpgBPdWxVPgF8qT4ibD1rH1rYnhqdQojX5rxf6s1Ny3MJlWvynaHxYspB36BU6XtXadtqiOPNJhwPIE69qQJQ4bdQTl5pnK/kdqrdmlTz9Qx6AOrZ8y9V+pDj5rdKSboPPwZ/nIxCeNVMaBWfFxdvi5jnnUDd8aE4cjye/MiVWTG8IGrX12bZl8njRhIjGnI3p+XDdOo6zHlQK/1luuSJF4TFr4nmPjR0E9q820f1VDdUkvZA4tugBPuHzOUScxU5vOhNobERbd7pPEsyNAce+WKPrPGTWAI9GESEXD17gKCYaPLZoqiEiiw48lyHeRFYeBUi7MeV7eRIS/ZkFLv9qjGP3vVV4fdI8FmFpArshOGH/0RoaFoRA/67c67W46PXF/WoLQX01/ZWFnku09ih4xYQGmGJ1yHjVnvT+Noe2KdYVS2gp1X6sGMTchZOogbCGUxmFS4h1/W49w2Y1bFWFVbwYIt6VDbO58dcxDeP8RG8sZs1IKbWngdU2ja/SI7U7UIADFQYWckMDt6MP5oTpgfw+i9BaM
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(376005)(1800799015)(7416005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 18:02:35.9141
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77f35211-f809-4832-a1ce-08dc57f6126e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6358

The SND_SOC_AMD_SOUNDWIRE Kconfig symbol has build dependency on
SOUNDWIRE_AMD. It gets it wrong for a configuration involving
SND_SOC_AMD_SOUNDWIRE_LINK_BASELINE=y,SND_SOC_AMD_PS=y and SOUNDWIRE_AMD=m,
which results in a link failure:

ld: vmlinux.o: in function `amd_sdw_probe':
>> sound/soc/amd/ps/pci-ps.c:271:(.text+0x1d51eff):
	undefined reference to `sdw_amd_probe'
ld: vmlinux.o: in function `acp63_sdw_machine_select':
>> sound/soc/amd/ps/pci-ps.c:294:(.text+0x1d525d5):
	undefined reference to `sdw_amd_get_slave_info'
ld: vmlinux.o: in function `amd_sdw_exit':
>> sound/soc/amd/ps/pci-ps.c:280:(.text+0x1d538ce):
	undefined reference to `sdw_amd_exit'

Add a top level check config that forbids any of the AMD ACP drivers
with version >= 6.3 from being built-in with CONFIG_SOUNDWIRE_AMD=m.
Move SND_AMD_ACP_CONFIG common dependency config to
SND_SOC_AMD_ACP63_TOPLEVEL config.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202404061257.khJml82D-lkp@intel.com/
Fixes: a806793f231e ("ASoC: amd: simplify soundwire dependencies for legacy stack")
Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/Kconfig | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
index 3508f5a96b75..6dec44f516c1 100644
--- a/sound/soc/amd/Kconfig
+++ b/sound/soc/amd/Kconfig
@@ -132,6 +132,19 @@ config SND_SOC_AMD_RPL_ACP6x
           Say m if you have such a device.
           If unsure select "N".
 
+config SND_SOC_AMD_ACP63_TOPLEVEL
+	tristate "support for AMD platforms with ACP version >= 6.3"
+	default SND_AMD_ACP_CONFIG
+	depends on SND_AMD_ACP_CONFIG
+	depends on SOUNDWIRE_AMD || !SOUNDWIRE_AMD
+	depends on X86 || COMPILE_TEST
+	help
+	  This adds support for AMD platforms with ACP version >= 6.3.
+	  Say Y if you have such a device.
+	  If unsure select "N".
+
+if SND_SOC_AMD_ACP63_TOPLEVEL
+
 config SND_SOC_AMD_SOUNDWIRE_LINK_BASELINE
 	tristate
 	select SND_AMD_SOUNDWIRE_ACPI if ACPI
@@ -149,7 +162,6 @@ config SND_SOC_AMD_SOUNDWIRE
 
 config SND_SOC_AMD_PS
         tristate "AMD Audio Coprocessor-v6.3 Pink Sardine support"
-	select SND_AMD_ACP_CONFIG
 	select SND_SOC_AMD_SOUNDWIRE_LINK_BASELINE
         depends on X86 && PCI && ACPI
         help
@@ -170,3 +182,5 @@ config SND_SOC_AMD_PS_MACH
           DMIC can be connected directly to ACP IP.
           Say m if you have such a device.
           If unsure select "N".
+
+endif
-- 
2.34.1


