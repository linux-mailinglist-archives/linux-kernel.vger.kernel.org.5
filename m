Return-Path: <linux-kernel+bounces-120694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DA888DB84
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D34EB231E8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7084524C7;
	Wed, 27 Mar 2024 10:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cR94cfvH"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB1A225D9;
	Wed, 27 Mar 2024 10:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711536439; cv=fail; b=oZQpP4ZOZRhDjEDgcAC4hZvbYdSaRdprenbH8fzV6l75heh7keY2yVD9owNU4Vae+7pN47ZJT2c5U+Tut28hjeLKCzFyBhkEmbhHXoQcd1cmOuNCFC9BDJby+uNIUyFOqF94oeByrNW249OqNtLS9hMF/72k9HY4ZPu6yyOE56w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711536439; c=relaxed/simple;
	bh=kcDtUXGx/vvG8BTczu+tXo8vEF1TtyaYITSj4nK4DoU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a87XH3J4mkXfvzFYjLtPCN+lSVWL6BWgmAlXp/Tne5RnyC0PKVvXY8q3Rd5hlLSVOONC1E2KKpv6TgU1SGW6SXAw1TukTWRuSiE9GNhZ+7xRCg4oAXs90iGVCRcOkM6wVH7QkwBDnDibwwjaNGO16iuOPbxZfq6G7IcHQaXMsZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cR94cfvH; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OXEFYJt1iVjfdb7Qlzb5ItAYqEPLIDckcLlKPxAR9YNKs+7paUagZixx/qJRBCGBRe2SG/BOPs71383X2j1qEz82KptoQ76S48PQMrqPq9k1R/ulj4Gn35Ec0oUGstXMD58HHrZeKC4itTkSC8buvPVlTtqXAg2LAp8SAN3NTZ2vuzoZL+waMSh1ZC72bPzfFkx+BpLFzqxeGSsSjdFhmYhh7OJr/Ql2K7/5Fr2r7U/mTDmNkLk3kIkl3RAx1BadHRNthbC6gqUw922RP9OYxt6poUsZ+KIPqMu3OdeL7Z3v1JAjGAdWXSAWOzYPxWI/09CCT04lLbpiuZa3XznMwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ARXyt6CQVAqAqbC7vnIrk0sXfPRuGtY+EkgiIgVNxEM=;
 b=ZWwF4elVE7f8lMV/EdNI6eoMl5HXNU/hUhHSD2qbw3x4zzNMvw3i7i0FCPbhj8Viv7Iy0EvbZNzrSe6MWHDVgSQ9RIAFe5/kL8Sqp6pEiTp5pVoSKTPu8rneL1Dq2T2t9hi3zRUi/phDPIzdZrH6SvlJZDq8FtCCQYqDnZSAaXrmhHZZg8gBUBhiWz1QVe5vTH8Ttm4vx9tafXYeJGo0E+MKuyRyWqJN89bnWthd159o8aBZ2L42NM+2sTPzC16gxk4ZbmVtjjx7bufwYwziZztosNuKj8I2gZs/fmFrlMZ+OxuFdBFHN+GUOLzw9wNT2sN8XU3ujxkEg3NpKyxVsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ARXyt6CQVAqAqbC7vnIrk0sXfPRuGtY+EkgiIgVNxEM=;
 b=cR94cfvH5FB0K5NFHS519h8lmbXsPJEJi7E/M+eDRp1ni12IsIiqTNkizY+OXKLt34HOPzSNMDe6lG8OVc7iUa9ieWtYyMI/xz5zIY+w/Dsl1U+y5tSxih1eNUh/dLbN0n0GMZQaH4TCYNeIuvud2smDnzPPfD+ZhmctUt/XSDQ=
Received: from BLAPR05CA0036.namprd05.prod.outlook.com (2603:10b6:208:335::17)
 by DS7PR12MB8370.namprd12.prod.outlook.com (2603:10b6:8:eb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Wed, 27 Mar
 2024 10:47:14 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:208:335:cafe::dc) by BLAPR05CA0036.outlook.office365.com
 (2603:10b6:208:335::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12 via Frontend
 Transport; Wed, 27 Mar 2024 10:47:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 27 Mar 2024 10:47:14 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 27 Mar
 2024 05:47:13 -0500
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35
 via Frontend Transport; Wed, 27 Mar 2024 05:47:10 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <venkataprasad.potturu@amd.com>,
	<Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>, "Vijendar
 Mukunda" <Vijendar.Mukunda@amd.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "Syed Saba
 Kareem" <Syed.SabaKareem@amd.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Jarkko Nikula <jarkko.nikula@bitmer.com>, "open list:SOUND - SOC LAYER /
 DYNAMIC AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] ASoC: amd: acp: fix for acp pdm configuration check
Date: Wed, 27 Mar 2024 16:16:53 +0530
Message-ID: <20240327104657.3537664-2-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240327104657.3537664-1-Vijendar.Mukunda@amd.com>
References: <20240327104657.3537664-1-Vijendar.Mukunda@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Vijendar.Mukunda@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|DS7PR12MB8370:EE_
X-MS-Office365-Filtering-Correlation-Id: c4d7adf3-c516-472e-83a3-08dc4e4b43a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gkL8QZIY0tAuvqgeHE27MkClNrzEn9PARuJ+lyN2NAYRRK190I2BSVGyth1DbykzRZDllQFno84lZYd6zWqHS5CowJOXcjaWGJb+P0RrDSnxOG21QbtsaG1CXg6RQkE8MHtzeSht4O4aTSTY2m41Poiudiwzlmaz561HIVxXVc2AzP4UY628OZbqXEul/f8c1Qv2OFukLnIBJdijUMAEZX4n1GyYCCfOtuNL7UDkrSlBGHe2LyWNCUjpsLK0LLJedOCLppXyv5S9yD10rO9cQKS/Wn7PZKjAtWNoXTjy4490ytzNPuckjrYiYE+PhBr70qBJ2JBfNy5M3xG90+LslTf6uULgl7HMwzBswLCzOxr6WAemGP49THtmTrwI5mkm3epuloo4TuDouyWKcqJf9Ns1021EA4+Mx6WwPopqHOcy6vg2bjp91y1XUHy+hsoGC5AVBeoSVWYz714H1cKAtCvHoRKvZfEiZ/PVecbEdqAJzyPXiJgdAHbJ+wHUl9mMctQC0el8jt6ycvUsSjZrlgGQXzkp/kFhdkaz6wSNHBd04X6QU2Ku72AJ7VJGsSs7lGLb4RZRzhAKFdhXxCqbxqcR7kXbFy5+dYrQfrdBb9FrQBVU8n83+t8SBeYrpi4Z6nS3Lz2sGAE+YUudF2FauQZ1CnoEfgsViaEkMduiy8WMciyajCg4NIvTXwHRxCLw0vyFACuTjxM8BJZ06u4/vjnzvpEQeXKsPdjZTtXGIB455D0E9zas/ek6w8UFaO3I
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 10:47:14.3602
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4d7adf3-c516-472e-83a3-08dc4e4b43a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8370

ACP PDM configuration has to be verified for all combinations.
Remove FLAG_AMD_LEGACY_ONLY_DMIC check.

Fixes: 3a94c8ad0aae ("ASoC: amd: acp: add code for scanning acp pdm controller")

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp/acp-pci.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/sound/soc/amd/acp/acp-pci.c b/sound/soc/amd/acp/acp-pci.c
index c1d4140f0746..21574cfaa136 100644
--- a/sound/soc/amd/acp/acp-pci.c
+++ b/sound/soc/amd/acp/acp-pci.c
@@ -136,11 +136,9 @@ static int acp_pci_probe(struct pci_dev *pci, const struct pci_device_id *pci_id
 		}
 	}
 
-	if (flag == FLAG_AMD_LEGACY_ONLY_DMIC) {
-		ret = check_acp_pdm(pci, chip);
-		if (ret < 0)
-			goto skip_pdev_creation;
-	}
+	ret = check_acp_pdm(pci, chip);
+	if (ret < 0)
+		goto skip_pdev_creation;
 
 	chip->flag = flag;
 	memset(&pdevinfo, 0, sizeof(pdevinfo));
-- 
2.34.1


