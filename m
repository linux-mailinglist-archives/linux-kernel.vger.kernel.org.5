Return-Path: <linux-kernel+bounces-124166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E36BA891346
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 06:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E00CC1C230B9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 05:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784B73C47C;
	Fri, 29 Mar 2024 05:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dIp/Ioth"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203513C064;
	Fri, 29 Mar 2024 05:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711690710; cv=fail; b=XTMOLU9mQ8HrHDbiLOpqkEfSSC/7dLkPIGgzCRd+IwcDj/Y2V9lqxnnVRXq3lzk/TRaUjxWm6B4iIdE92QdZl++xAxvFdFJVCdeXLEewcDjpZm4aJsh5LyljSGK88+QkeHpqELB8yKWop6aq5+h7VVrB2En4Tu57eJv7FEAUYTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711690710; c=relaxed/simple;
	bh=mQMuZ0Qo5AG4pxa9fPZlfbcX9gRbL3RMroV69V5Yppg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LsgkfRormcOoyfeuNBdNHPTqgjGgA7JFEgStEz1sUb2ffvDJZBsjRRC6eKsLXuhMPjJJZjyV6WiGHGztzx+STm5Q9oUSjmgQykGl3OnfxmXuzsO2YmlTYi2Z6ayCKv67kUzL/PRcU0icXCrTnmp41sc1dkEsuAugGdCWX7VQHx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dIp/Ioth; arc=fail smtp.client-ip=40.107.93.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kE5rNKUdJS2IVJJSOOBPsJPwcbprKgfm9pwEALlWS2ckVKAv3J1QpQsrMlODSj1qlgIDPEDyfChrm6jmzyuEa5B+rUYLLaG8XxgdXokpQsmvcFYD0hoWfqoxF/uUFTTwQJ6NnbfM/QC7l7OeQHKSm0GZCh8vfh8PGKfHyiRIbi/ST84t1UfKqcBCRpzRUWz9daHeKcGMKyx4UWgwlEsVbXmA/y/YlP/9ozCbROb6mV89K1egfEaB/o5/3FmiPv83UnAsTVll/Gyw1DrGPwrRzGFtg2FbrdoKiCMN1tstgnXFLjZmNSw/ZEnqjCQVuENdUh+OMBcd4V2auJNIhiGvWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2mLrx29e1YrvXhNPqPTYaWzs3am18IJPXmS3Lljm6RA=;
 b=dGRgQW4xnI7ZFDg4TR5Y/rJXpEA1bh4cUlrQy5NypCWCil3ytFqnYewt0LXEAYRaXVG1XqTxlFTx2rh44ozpcCDlNA/d3dC+m6MpZ9lMChBdrQrVQqZE8+aZVt/Hx2j6l+z3qAs6TqDvzACiC4YmFrm4QBAd+WDmYp6su53p/LTUJrqhu0OCbhnVaK0BLaJTd+nDh/RP/JgtueiKcoJL2TQtfzg1v3ntctoi8GtpCDKq3uXKujOYn1NrONOGuKeSu4/47DRYI8eiZrKuI1j4FVqcZ6J4LufcZomn5hbhvPYhe3Pymn4z56Z7zNVAaI4dWsZry8nFKZ66asQyglRMcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2mLrx29e1YrvXhNPqPTYaWzs3am18IJPXmS3Lljm6RA=;
 b=dIp/IothyK+3KYsNfKgsRXYQUvXec/1/lZvgm0+wP3TFoSOPPfk6pya3tIDejDticoHNxDpcA8F9jBDFPGkjt6jd/Iwz6X0obVqUUx3u0loaoKI38UShyoMxFmAG7zkgdX2x0mSYBTqyRV2WDPkZUC/Jb7oyfENTPEvvL6bNOFU=
Received: from SJ0PR03CA0042.namprd03.prod.outlook.com (2603:10b6:a03:33e::17)
 by DS0PR12MB8320.namprd12.prod.outlook.com (2603:10b6:8:f8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.40; Fri, 29 Mar
 2024 05:38:27 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::18) by SJ0PR03CA0042.outlook.office365.com
 (2603:10b6:a03:33e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Fri, 29 Mar 2024 05:38:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Fri, 29 Mar 2024 05:38:26 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 29 Mar
 2024 00:38:24 -0500
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35
 via Frontend Transport; Fri, 29 Mar 2024 00:38:21 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <Sunil-kumar.Dommati@amd.com>,
	<Basavaraj.Hiregoudar@amd.com>, <venkataprasad.potturu@amd.com>, "Vijendar
 Mukunda" <Vijendar.Mukunda@amd.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "Syed Saba
 Kareem" <Syed.SabaKareem@amd.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, "open list:SOUND - SOC LAYER /
 DYNAMIC AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH V2] ASoC: amd: acp: fix for acp_init function error handling
Date: Fri, 29 Mar 2024 11:08:12 +0530
Message-ID: <20240329053815.2373979-1-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|DS0PR12MB8320:EE_
X-MS-Office365-Filtering-Correlation-Id: cfdbf79f-d577-467b-59f4-08dc4fb27506
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cdC76e/zMrOLIIqHXCfYO74/4rc/DeXKiUZHZM16gtc4INtp1wBl39LIVWE1stdcGQIkX6eC8J9qita4OKH0gJ24T9Vq64JH1Om/AcDL41Z4j9ygA79sUCZNopnwr0HCHS07TrGa9ed9u1AUYBlbvaxygS4SOokr27D8RrW4VA4jV/1tzJ/wstkcoCI+kgTpVArFX99FyXpK1sfkxBZpGSnIKjvYJKpITziD8bQpxHzO61tfZbZBqmsXTe8+tyWTocJlgr6X+l6WWzO3/ie9Rn3XdMGdJNiRn9c0vGFkM5hT6ZmOOext1oR+YkT0z49DWScsXKYgArzCzwvzFHhy37K53BIL4KDzX+I0xfYvO2cG1uOxqoLx6Vo/sxqurfBZ4ZZm2TY6R2F/UhfS943jTQSeSKlpou1lL95/1PoT6xkzCLueF2GL5H+Gqzxs7cqa+PtQZkGCWSlROEYUsAfpUiUqLtUHRHTlgKgkEjq31LJWrA3ISt5wXI3H1LVHLjDXtg87MrNqRz0hW8hLWCXcpCHBPfJMVqPefXo9J/UScvd7cJr/LxqMnJpANqztuA1KUBRiv3TCUgX/rVRucm5HFKJKjRn60S/0fIcoego5b3ZG/xE+lKOJF1RESPiNpWSzAz+bpNAfitKncS1TYKGPAWn2jESM6vTut7J2RT59kx/kM+o4toz4Ox+pKpV6ijsF6UPGiPpV81m1blDadZcu6SHuCO1y+G1A2fjM7OmTqQ5wRhUSiAT7zJ8ZxMaV8uLi
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(376005)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 05:38:26.4172
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfdbf79f-d577-467b-59f4-08dc4fb27506
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8320

If acp_init() fails, acp pci driver probe should return error.
Add acp_init() function return value check logic.

Fixes: e61b415515d3 ("ASoC: amd: acp: refactor the acp init and de-init sequence")
Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---

changes from v1->v2:
	- handle clean up sequence instead of returning error directly

 sound/soc/amd/acp/acp-pci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp/acp-pci.c b/sound/soc/amd/acp/acp-pci.c
index 440b91d4f261..5f35b90eab8d 100644
--- a/sound/soc/amd/acp/acp-pci.c
+++ b/sound/soc/amd/acp/acp-pci.c
@@ -115,7 +115,10 @@ static int acp_pci_probe(struct pci_dev *pci, const struct pci_device_id *pci_id
 		goto unregister_dmic_dev;
 	}
 
-	acp_init(chip);
+	ret = acp_init(chip);
+	if (ret)
+		goto unregister_dmic_dev;
+
 	res = devm_kcalloc(&pci->dev, num_res, sizeof(struct resource), GFP_KERNEL);
 	if (!res) {
 		ret = -ENOMEM;
-- 
2.34.1


