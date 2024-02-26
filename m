Return-Path: <linux-kernel+bounces-80591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B01BC866A0C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 07:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A9DC28234B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 06:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6A51BC5A;
	Mon, 26 Feb 2024 06:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0XU4xFIF"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F4A1BDC3;
	Mon, 26 Feb 2024 06:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708928952; cv=fail; b=X1dLB9QHXcmOh3L76h/qKvjtJjT7s5S2v/EgMOZdIidl4sjZdvs/i6BzgPPXg/JTeEXO3PJxajsc8YQbfQ8iHGLUYnIg9jnywtiEutPLBIxldNEguHp2ftIjmycQNARDaBWWQjYVTmvWUNmRQZrKKWDekCre+IIOlhm35HDOLuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708928952; c=relaxed/simple;
	bh=8kQEDYEW9v1tqSrqRvEKCnJox9KK2bCHALbmILJsgDE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PT3l1GH16PR8u8yfJP4aw8rg47rw1DCgZiRg/oBTP66313twoIgbf6sO+RjH3o9r7GoX4pJAr7CEqOnqtFU84B4GNV5gzaNoosSvevu16jhNqe0AVQk+ubrSAc7OyZlgjX1dLlyryfJHb6mLKdDVMUssy/epy/60GWSCgsFssmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0XU4xFIF; arc=fail smtp.client-ip=40.107.220.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IzelOFlvLwVDEhp16ESiJXyudldBN/0CJGa4FPd9tKRE7N/tsiAA8P0StrKB6/Ahla8+iEFGR5hjCnrAtIyHCSUEjeAsXu60hHUfJIOquzJ2ltuvyEgdyQoS0/4d7WtjGttoMYTCuLrJYc8G26Zzi3+i8it6RfD/RpvUI+PW7aYHCVozHuSDTWkJl80sCYqibIXd0irVHWnrDoL1s+QHiYHW0pui384KxUhbbBlAIqcyBhkbtEozurRCKOL1qdGqEV9+18W/hrs82l4KLsYEvX1TX/RKQA70lk7bATijAtiPR5/YmyTQ3fXZ/NL6NzzG0uxpBXjk3cLm0OmlVdBUgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lvPmvxP4a/imKBh10t3nC3rSrKRULrn9Gq7KSQ9i+KM=;
 b=WOx+K04rAO7GqAdea55AqiXI+8dDfjNAhWiZQjcQ9Edfy9edGRIa2aDGvVjFCbkte9Wn6E9MMOqAMRHTzCKvOEdttb0vuObnG4xS6XAoVO2F6KNUW8uZZFbPNrN7bF1bxtZnnIRrpsCwvPIcCpHet2/47N3sOxbOhfo86ElCz2HQKgLM88hTplu9tJJ6ua3rluOvAxYaT6lSOMBN5cbJt/RsvMWes7AVRSBWl3YIFC5By9JtvBTRmV5GYmvhFakc5zS47+bKMgZAyM4+CcsCBnjrEd3U7t9vc1QD0i9yLTN7EYjHIgAG/9xEh4S9aMIC6ZHCUSmdpV8o32gFRiC+XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arndb.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvPmvxP4a/imKBh10t3nC3rSrKRULrn9Gq7KSQ9i+KM=;
 b=0XU4xFIFePHlwwBAOJnQ1plEfU/SqNh2EM7s12xmlMkFABC66o8V3hKsWUm5KQLtI+KBEvNxioj8qOOuspJFnrG/X/3pnxL+Y0x+7jTLXD6wuxY5oHtIty2ZkE7e4kDvvSRNz/u4yA2HztgY5phyEkjzFmOGOFXNDtQw2Ap5+/k=
Received: from DS7PR07CA0001.namprd07.prod.outlook.com (2603:10b6:5:3af::10)
 by DS0PR12MB6439.namprd12.prod.outlook.com (2603:10b6:8:c9::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.34; Mon, 26 Feb 2024 06:29:07 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:5:3af:cafe::98) by DS7PR07CA0001.outlook.office365.com
 (2603:10b6:5:3af::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.49 via Frontend
 Transport; Mon, 26 Feb 2024 06:29:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Mon, 26 Feb 2024 06:29:07 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 26 Feb
 2024 00:29:02 -0600
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35
 via Frontend Transport; Mon, 26 Feb 2024 00:28:58 -0600
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <venkataprasad.potturu@amd.com>
CC: <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
	<Mario.Limonciello@amd.com>, <arnd@arndb.de>, Vijendar Mukunda
	<Vijendar.Mukunda@amd.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>, Lucas Tanure <lucas.tanure@collabora.com>, Syed Saba Kareem
	<Syed.SabaKareem@amd.com>, Cristian Ciocaltea
	<cristian.ciocaltea@collabora.com>, "open list:SOUND - SOC LAYER / DYNAMIC
 AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: amd: simplify soundwire dependencies for legacy stack
Date: Mon, 26 Feb 2024 11:58:50 +0530
Message-ID: <20240226062853.2100457-1-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Vijendar.Mukunda@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|DS0PR12MB6439:EE_
X-MS-Office365-Filtering-Correlation-Id: 621909ef-ab8d-4102-7d47-08dc36943c2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ef/Ya7jy62fnqtvk8u25X8MY+dfBcekduLeeIEPDh5RbVk1+tXBNg6miTD4Ovo0ket+kWq/fEK9veNBm04Dn5KBv4Yljuej0TcdpPavLapoebPK36sarRdEphjB/MnTDOSvgv9R6RCi9XMFRsNp27fYsCmCM8EzhfQW38FlSbI1iUjxzwDUi32B7ch6+GcoBxaR5WjOX9rvgmO4tUGBiDGFcPP5NW61eAWW25894lkTQYoZ6EXMMVwOHfn71tnOmM8JduK7HAXOmIfaCSAhSLCtZJIoX/gA+V1/rtEDheLuJ5ipW/i0+sUdWOEmijD0eh/I0ptMK2S00i0+GfTSNGuPKStfzCTNgHdFYLHsSfhP0z2hJGv+3G+fhuLTHhu2kX7bQYlsd+GZ/tqHj7w5oF7Mvk0l1miAmN5Ur1V5s6GTIGRHEhDAwPGakIrPdsl2zuCACvgfjTzpdstdZHWP3v1Qgx2bkiDrUuZWinTQyPE9qguEXVawpASnDP0wtts+QJjf8+E9DkQoKnakNUBBzARaKLEemr4G+rXWiPPuZK1rj/rqZc6JQEGW+bIYu/XyG0L4P7NcZOP64Sw7WOouVfbbkAaKzns0tEoRl6TrYWOVsU7TiWJUWi+aOj2liEF8KQdoC6pabaKw6P8vxj8UpE/RN8PfKziZeJIoXu9KDrOL+943kw2FOaa7fv8++2STZ7n//UVf/+7u+5yRV5oVrVO2/5/R8cpQlRUg9R6jPHxnSdIeVFhQGqQ52z1ckm1Iw
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 06:29:07.0995
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 621909ef-ab8d-4102-7d47-08dc36943c2a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6439

The CONFIG_SOUNDWIRE_AMD is a user-visible option, it should be never
selected by another driver.
So replace the extra complexity with a normal Kconfig dependency in
SND_SOC_AMD_SOUNDWIRE.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/Kconfig | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
index fa74635cee08..3508f5a96b75 100644
--- a/sound/soc/amd/Kconfig
+++ b/sound/soc/amd/Kconfig
@@ -134,15 +134,14 @@ config SND_SOC_AMD_RPL_ACP6x
 
 config SND_SOC_AMD_SOUNDWIRE_LINK_BASELINE
 	tristate
-	select SOUNDWIRE_AMD if SND_SOC_AMD_SOUNDWIRE != n
 	select SND_AMD_SOUNDWIRE_ACPI if ACPI
 
 config SND_SOC_AMD_SOUNDWIRE
 	tristate "Support for SoundWire based AMD platforms"
 	default SND_SOC_AMD_SOUNDWIRE_LINK_BASELINE
 	depends on SND_SOC_AMD_SOUNDWIRE_LINK_BASELINE
-	depends on ACPI && SOUNDWIRE
-	depends on !(SOUNDWIRE=m && SND_SOC_AMD_SOUNDWIRE_LINK_BASELINE=y)
+	depends on ACPI
+	depends on SOUNDWIRE_AMD
 	help
 	  This adds support for SoundWire for AMD platforms.
 	  Say Y if you want to enable SoundWire links with SOF.
-- 
2.34.1


