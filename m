Return-Path: <linux-kernel+bounces-167619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0503A8BAC0E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 14:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2717B1C21C36
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 12:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0657B153518;
	Fri,  3 May 2024 12:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QacN1a8O"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675701534ED;
	Fri,  3 May 2024 12:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714737805; cv=fail; b=rMvKH9c/txfr9WIoFXh/dSoayITmo4hlHnHAnIijbEq/+DG5Kvt6QtF1yEvLvVB7cYAkgdkDQqpF1L6XzJqy7XxXDY00XdQs7yIr1sDyJNB/tjCVfxmPtLZJFQUUZkNWzZkxyFsgjrSl2ruHDEB4BWMUqDyrz0TuP18IH825PAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714737805; c=relaxed/simple;
	bh=JD7L+elBxsMYCzNWpE2V2IV4xD5KuR8FeTJRcqRA9C8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WpwihOp+pCap/qNCl8IuIncp53f0nq4KR31eoejSlpbRjI1JmrE0uTXPCt6dsO/JFKKctDvVfZOPnSJvqkw3pFmz4kWQdbj3SLCld6ZD0w2GUDJjSUEg3JdPajQnhcbf5eIwFIf7DKg+dlQvVJO0AAEVvZCCwleRsSgBlACHzkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QacN1a8O; arc=fail smtp.client-ip=40.107.237.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fk0hC4ZAoYBqlKEfbz1TgfRUHGpBuyD6t/LD8i7L/fZMTzKlPRmJPTGf7Ezy4LbpOVfdyNqisismhbX1j3MT70t1fTu5kd0+2DeYuOTUHIswQUbU66dMDZTjJCXos/vkoiADtPYhUlqDohyaID831yBYW3c1t1sQ2yY5M1QLmg3vm/gBgT4Fbnf3vzz/XcznRZIzpGrxYPLeVH+c47VkxO5WGSoJQvfHwzUOtMCDeVAS9dRW9XViyK6A3le2EKzHO9dPF3+eFESTrYgkrLAJRV6zW0SjcUP9VWMo5lDmeJn2fun6E4yU1yYGx3pLj7CGhWMTbHNwalrMRbtK7Iy+oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Qbue7grr2bVxgPmLG82CvLiuXBtHrfrsmJyYa1R9AM=;
 b=gUC5TMxLQbwjAk0aikj/1NsvLkz41YnYch1FbQND8SBG2OpdjVLvcNrmwZmTwTovzxsUjYrCvioJaW1M4SudEO1XijxKyMx6cm/zPYqNlvW1PN/iwP1v4xEw/voiU1EaTAh+ufSZb/a5gG6qpxW4eyaBbsaWCpRcF0+oV8vLvy0s9meB/4gJDqrzlbF1iuW/0enxSIkPfGRPdZImeBwoISy/sOS3VHXXkV2zlaz/Te124BNNh1fJpWlH2IXu4tcV0PkQitCZRPROJHMGODbsEF4RFyr3mhhCvvC7/vE5NNPtlJoFK0QyFLczrs9EZEx/nmveQ3uZ1ubXXYggft7VIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Qbue7grr2bVxgPmLG82CvLiuXBtHrfrsmJyYa1R9AM=;
 b=QacN1a8ObmqLB4p0aOqZBFwisJGjzp7wuScLeZTxBV4xCNh0AO0ZRqBNuKdKWMSo05XrcTJKdeMNbJSd8jCaQ3IWyXbt7KgvAtbVtzsggBSuWfvhmJiucLuJaqre8+EnxAp+b3I0mtkNsDDJqG/3IL+gZu0v6eFFfx8Tep4rNus=
Received: from MW4PR04CA0355.namprd04.prod.outlook.com (2603:10b6:303:8a::30)
 by MW4PR12MB7120.namprd12.prod.outlook.com (2603:10b6:303:222::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Fri, 3 May
 2024 12:03:19 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:303:8a:cafe::8) by MW4PR04CA0355.outlook.office365.com
 (2603:10b6:303:8a::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30 via Frontend
 Transport; Fri, 3 May 2024 12:03:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Fri, 3 May 2024 12:03:19 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 3 May
 2024 07:03:18 -0500
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35
 via Frontend Transport; Fri, 3 May 2024 07:03:14 -0500
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
Subject: [PATCH V2 2/2] ASoC: amd: acp: move chip->flag variable assignment
Date: Fri, 3 May 2024 17:32:53 +0530
Message-ID: <20240503120306.4300-2-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240503120306.4300-1-Vijendar.Mukunda@amd.com>
References: <20240503120306.4300-1-Vijendar.Mukunda@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|MW4PR12MB7120:EE_
X-MS-Office365-Filtering-Correlation-Id: aaea397b-cab6-4eea-d4b8-08dc6b6905ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AOUQeCcQT0ZjNy7ZLBMNQEwKqaLeKq6tSKq6Cnt/UQ5E8z8seaICVg7uTiN8?=
 =?us-ascii?Q?BZ2rGOi2pbh8HR8ojZlDBieuNjG08Z78ne9JXfU1n7d2Ni1Ffs2HhUqdhATN?=
 =?us-ascii?Q?bU1snpw+P0aAlTTqvofAjn+wduWWyzzm0nHOY5d18hF58+MpCTIdj1hlbrZa?=
 =?us-ascii?Q?FRJSs6ZgoFWT/Ltvw9DGVQ0DWz5Dyc8c5gTQeSWtL1cfrmz3sQmV5YpDVj0v?=
 =?us-ascii?Q?YSuhi55H+zVyh18GlR9pPHbvdXl++RG33kh73FkSpnir1mReLLNwPoaxVad3?=
 =?us-ascii?Q?J8EFywJaPdcgnSd/f5eNyxa0L/ggFXfJlvc3woSwZp8DHmixHRI0RLbmG4Fo?=
 =?us-ascii?Q?jnpYBnYavBWqtMbJmyooZYIhP/JcJiCKA2pgLS1HMUwXpDBWpJs4VIwp2w/n?=
 =?us-ascii?Q?NHldop8hv+EiiPPd8dFerhKEkp0hHyfDr5YlQZzP8iI12lg+evXa7HtQ5BTF?=
 =?us-ascii?Q?mq3ABk+dZgyW0DoJmBeAFlSu7U7tP6lFM3q+prlTo4+wEtemewpnTxeedFI+?=
 =?us-ascii?Q?zuK8+nFF3bYTE4hSfPSoErwmJbPgjgSCkzJmPR6QxT31M9oZHF8RQRr8l+YV?=
 =?us-ascii?Q?h6Nc+MsfVPmw/gpGr2IGk1j/UGIuCoPk0flM+JZ22M26TajGsj4vbeooD7mB?=
 =?us-ascii?Q?YTJ2uHTemVqdEDtK4wUcsagnArSyTIYxNyXCjqk0iYGiKyTe69xv6b07L0Iy?=
 =?us-ascii?Q?/pX1YeOT/+Gzc8SEa1wvRi53hqIkam8GdUKwN1CUSeDHVT/vVQZDS9a+Isde?=
 =?us-ascii?Q?GESgIp6z3SlOiJfSb/+34uvX49Haoh2BMrmZUy5QMpV+WxS9n18S3LbydA0l?=
 =?us-ascii?Q?6wnZiH1GBk+jIswJ+sJFfs7ixn2x76yGyl7QF2chO+Po4fJgHxX/u01TISRa?=
 =?us-ascii?Q?0Q6abQkj4tbxfiwDnirhk+aWNh+A8vB7P+pNeF/QFtWb9EYcRyk8KUTmZ09z?=
 =?us-ascii?Q?I450P7FlBIMEhc8uN60FP7Wdq6BJvqOGVwIfTyvDZqCKDcfG5e2pwmGLuWRw?=
 =?us-ascii?Q?6ZNvbgjZGBno/lqlVBj04TyxcKL8b/AQbrSQjXwhjHUgfo2bvEX7l3q2U9xy?=
 =?us-ascii?Q?uk08HUuZzIGXwzaU6Jf3Jm8w7KClY+fl9MeVeaEibvCooLhGXYMajyTMZoEs?=
 =?us-ascii?Q?hOBbL8Gy4Li7Dw5rjm1yWtQsDam6T/JpFZ3OSwBAWNGPyQAuc5Yo9Jkw34Cl?=
 =?us-ascii?Q?wBi+H968aVMiQ5PhSI5UZXd8HQYMruuYqsHw5tMAu+zJw9nTaN0B1uXaMV37?=
 =?us-ascii?Q?8clHEnUzKiSmk5C15hd9EhwNvfeUanWVL3yT1xqwMOLXkDRZIUrmQwhoXkGr?=
 =?us-ascii?Q?2FsB2hmMypgE9ldL9N62AmBsDQ3EjC8o7WjCH6u25D0nlNvon6ABsEwIZAiz?=
 =?us-ascii?Q?slPMCXCbD9Eaf1RnG6PNbzwG4Yy/?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 12:03:19.4595
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aaea397b-cab6-4eea-d4b8-08dc6b6905ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7120

chip->flag variable should be assigned along with other structure
variables for 'chip' structure. Move the variable assignment.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp/acp-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp/acp-pci.c b/sound/soc/amd/acp/acp-pci.c
index d8314d2b331b..b70b3ae33df7 100644
--- a/sound/soc/amd/acp/acp-pci.c
+++ b/sound/soc/amd/acp/acp-pci.c
@@ -101,6 +101,7 @@ static int acp_pci_probe(struct pci_dev *pci, const struct pci_device_id *pci_id
 		goto release_regions;
 	}
 
+	chip->flag = flag;
 	dmic_dev = platform_device_register_data(dev, "dmic-codec", PLATFORM_DEVID_NONE, NULL, 0);
 	if (IS_ERR(dmic_dev)) {
 		dev_err(dev, "failed to create DMIC device\n");
@@ -140,7 +141,6 @@ static int acp_pci_probe(struct pci_dev *pci, const struct pci_device_id *pci_id
 		}
 	}
 
-	chip->flag = flag;
 	memset(&pdevinfo, 0, sizeof(pdevinfo));
 
 	pdevinfo.name = chip->name;
-- 
2.34.1


