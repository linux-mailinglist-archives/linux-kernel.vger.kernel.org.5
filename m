Return-Path: <linux-kernel+bounces-42209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AAF683FDDF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 06:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6547281CFF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 05:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB2547F50;
	Mon, 29 Jan 2024 05:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="riy/A8lR"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055084F1E4;
	Mon, 29 Jan 2024 05:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706507637; cv=fail; b=Nkhj+pNfjrPKiCeb/02fi3wFGd0YTcNOUC6nsrSTEUbdGTVCNYVXMxkvJUvdObJFO2oCGEMZ/7Gs3BmX3bvTgYbTRoe1VgwvEv68GuwfmelBO/zt05SU5jE5wiHo0hiTRCQc84phsgJOC2QqZP43NGilO0bXuWRCcE83sg+nYGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706507637; c=relaxed/simple;
	bh=Ry0H129l7q0hv1pjs+h8ycQ9d7RRzP/o20mIdnuNtvE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tSLiXbeWM1/jDwd6a88uvF6FHnA180uK37dr9pmta4EczUikOc44bTJhu9jO/khpIbjuhH3FLnbcub52D+e+xgoUrnD6+KEJhYr9fbQQpJ4jis1O367EsS3pMg5zt4SxsKbGz5Hf0CjoogNqhtvQuSi4gXKaE6vE9DXptJ1jBMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=riy/A8lR; arc=fail smtp.client-ip=40.107.94.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P2bg7NsC222/wr0eIVq/4xjvXKBw6UH+yuXSS4u59JrOgb1dikekp3YkOZrVYnLCwDjoaxEto7q6QOB0G32YzHGV5xEiYiOrA54LFrzTaXLFM1LVUToweoUSu1YimvX8vSt+oggI24XSKEhKYLuXPLnvCusRtaQgK6e23OZDT0gsA2ezj7yOt3X+Om4NkeoNisF/hMXLDKGdXhdqk46S6Faxfkr8ZD8nbX/obDdta8wNpRPfD6muB/1ze1c3GZ/ha4j6sv21RNrhO+VPozqLPybYUQeOKYvNozCjON/uMuhaibD0//CmoKVJian1Eq33HLBNiuF7g6INvKHaQ4f21Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TM5IfcLFOV5I+4SsS+sfeBeWW0qVpPfMyKw8GVqZb7k=;
 b=N4S4W/C5VINg6JwB6j1a1ta8oA4DN+US9SiUCk/w63WbIJoOkaJY+D7vrxr8ITZCXGhFsYc7MlwwwduDlARc0QFxtLThiIXLJxbPnYAsrVbFTNB4AdIedmfWsg9l0fT9cfM7GAUrrU6vgyJ0lkFtn87CqrYZBKm+mvQMY5xUH04IjrMehvEJoVk8kg/c5XuuIUy/mLGfTuFk7sPNFKg65NKtQd/Z/07VcUi7zwPeG9Dkfq+drgy/fPHQaeez3VtbDlfDcxbI3KDzywXXAaQfuTzqs7VOgET61Mxh1yOJgVwsrUSnUfzCwc0tVZD2QFCoFJRqcEiI777DDsRl2BGkXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TM5IfcLFOV5I+4SsS+sfeBeWW0qVpPfMyKw8GVqZb7k=;
 b=riy/A8lRCKo1IVDoT0KGZeTxvsPOxd/XUjUGJX/KfNXsJgLQG4MoOwbQwYAAB8yddp3JPc7DeFSeRI1QxftvtMnEAaW6pyObE/V73dDEZFiJesWyY235bNtNWnouiyLezYkxuPoARZ9iDu8NnnSvVc+NI16BAUuXIh3K+pe6bao=
Received: from BN9PR03CA0199.namprd03.prod.outlook.com (2603:10b6:408:f9::24)
 by BL1PR12MB5160.namprd12.prod.outlook.com (2603:10b6:208:311::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 05:53:51 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:408:f9:cafe::9f) by BN9PR03CA0199.outlook.office365.com
 (2603:10b6:408:f9::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32 via Frontend
 Transport; Mon, 29 Jan 2024 05:53:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Mon, 29 Jan 2024 05:53:51 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sun, 28 Jan
 2024 23:53:51 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Sun, 28 Jan
 2024 21:53:51 -0800
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34
 via Frontend Transport; Sun, 28 Jan 2024 23:53:46 -0600
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>, <vkoul@kernel.org>
CC: <alsa-devel@alsa-project.org>, <yung-chuan.liao@linux.intel.com>,
	<pierre-louis.bossart@linux.intel.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <vinod.koul@intel.com>,
	<venkataprasad.potturu@amd.com>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi
	<peter.ujfalusi@linux.intel.com>, Ranjani Sridharan
	<ranjani.sridharan@linux.intel.com>, Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>, Jaroslav Kysela
	<perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, V sujith kumar Reddy
	<Vsujithkumar.Reddy@amd.com>, "moderated list:SOUND - SOUND OPEN FIRMWARE
 (SOF) DRIVERS" <sound-open-firmware@alsa-project.org>, "open list:SOUND - SOC
 LAYER / DYNAMIC AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>, "open
 list" <linux-kernel@vger.kernel.org>
Subject: [PATCH V4 12/13] ASoC: SOF: amd: select soundwire dependency flag for acp6.3 based platform
Date: Mon, 29 Jan 2024 11:21:46 +0530
Message-ID: <20240129055147.1493853-13-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129055147.1493853-1-Vijendar.Mukunda@amd.com>
References: <20240129055147.1493853-1-Vijendar.Mukunda@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|BL1PR12MB5160:EE_
X-MS-Office365-Filtering-Correlation-Id: 0831b682-8783-4e2e-c221-08dc208eabb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6lM7YqBNlTqOcC6G7EDGRdxSGE8N1dmTXhZfxFNbiiPqtH7hxhoCXBYaNzYf5uP8vdLZh9XXfYiyti7i8A97CkApWRR9s1mbmTgrsGSV2/zJRXWB4TlWc+ZxkemfKaHChs8UO1blJIRw0R5XBJYlizDkHqSkCmgM2jxd7E0RosZKUJ2QMZ3HalziXVTllIp1GE6WkibRETl7r3dVmN35QhH2OUWQPTw25XFP491Q4kWCwsKHmKG/Qb5CjjPbQn0usPPmrTMrwMQCbLnIrVeV6Jml41t+SOdgk+H3VmGzXbknS7TlMwnJFBHLafgKJ0xws57o29wJn1/e9B58knb6Z869ZL3kabWjGIvVoc8WHVjqyHrFmPYqGjqaYGB8npnIBOpa5uJjypN9FNs2+4ycw/0xL2i5tvB96B/ys6gStf2c7X/sYY3SFn0sXZpxLcdIBv/1tqojrOC4axQIhjhVgTZZtc3FClqLQW8GmMA9qotYMZmIo3esur0qZ4eqPw0Ya/DtT21kNJTipfMniA9nJrn2mD4n9YpyyaZxZi2rsMT6b6HK+eqWY4KkF9OrPYv3eqgY0BM6uONXmvdNHvHiRwpLhd5fXJWsEOmGrKbRr5eMnAd4OOOPkaGQF3o7Id4BOB4xhZ14CjBmJQ/LebT9sQc7CC8PmaseRf9E9ZTMDhz0S6Q+KCSPfC30a2LrBn6uLgl3tvEiPJl2mD6js3vBZ5J6s2W2CTPxzDfJ9QFZQN3XlM0kKdmGIHvW/4Gta7g2HpctXZ6z3EvgLrcanuhViQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(186009)(64100799003)(82310400011)(451199024)(1800799012)(46966006)(36840700001)(40470700004)(36860700001)(47076005)(86362001)(41300700001)(36756003)(82740400003)(356005)(81166007)(478600001)(8936002)(8676002)(4326008)(70206006)(70586007)(110136005)(316002)(54906003)(26005)(336012)(426003)(1076003)(2616005)(7416002)(4744005)(2906002)(7696005)(5660300002)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 05:53:51.7428
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0831b682-8783-4e2e-c221-08dc208eabb3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5160

Select SoundWire dependency flag for acp6.3 based platform for SoundWire
configuration.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/sof/amd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sof/amd/Kconfig b/sound/soc/sof/amd/Kconfig
index 1cea1d75130c..c3bbe6c70fb2 100644
--- a/sound/soc/sof/amd/Kconfig
+++ b/sound/soc/sof/amd/Kconfig
@@ -81,6 +81,7 @@ config SND_SOC_SOF_AMD_ACP63
 	tristate "SOF support for ACP6.3 platform"
 	depends on SND_SOC_SOF_PCI
 	select SND_SOC_SOF_AMD_COMMON
+	select SND_SOC_SOF_AMD_SOUNDWIRE_LINK_BASELINE
 	help
 	  Select this option for SOF support on
 	  AMD ACP6.3 version based platforms.
-- 
2.34.1


