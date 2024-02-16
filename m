Return-Path: <linux-kernel+bounces-69346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6660985879C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCF631F24366
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D9F1482FC;
	Fri, 16 Feb 2024 21:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PBRAKIKu"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2049.outbound.protection.outlook.com [40.107.101.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB36E1482F3;
	Fri, 16 Feb 2024 21:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708117452; cv=fail; b=ReviLudKkk8CVpkVcBOHHta0mAivRB3o3P9iTeulvMib0CtJcbDYfdbYBe3IZRYB1coAHaiE6IpyIlGRkiIxUG45y3MUHUEumbuGFHSXi2VSlWghPluLsvx3Xgu2R+elRHzrVh0clzIS7ateGId0jS4BxGNwmZCN+yL5YvUGCLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708117452; c=relaxed/simple;
	bh=wPPf87GaAxlU1erWX7Yh4/qDP/tlIE6It1JmaT5+px8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tyDX/C7y+z3UrQwPQWnDp1bEjfECFKVIVohtBJhMNFF8fvcfO7BpEeFCwsK3D6O0krabLz0nw+myRy2+dHVCoStEPP19H9A9nMgNcZTu2u9ts744M2S5opr1p+UiaGs+q51KqZ1ySadj8Ax0My41QPC0SRV1KQ0T4eV3llcqseQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PBRAKIKu; arc=fail smtp.client-ip=40.107.101.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R5Kxs+exyCZbEBIp+Dxr1Ee4U+VcEDKmwG74nQhmySXOnHLIyBLqMTB1diZhl55U37J4hn+MNNa8AnpArHn7OO2muQEo5lY7J1PBYvzhmM32ZslN6Hmwmk4TqBjqnhESzcktHHmLiUzfzjvbwtsrGIumSqrECyCPboeDfnB/NpJVvEEqQR3CsCISCob90h2ZQy15U9JQ5WTdapdLBof70BS9vU4GjczcvUSD8L+jBniHS63CQKMnYGuWJVM8sdTrzMAdZMOIE4wUzUSaRDTCUFBOeUt8yqAgIhhXrhvXllGKj5gHgcwfHUbviM6uSg4fc13mcHKgLmVGNMAsNRoR7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3FitRbcNIgTFPearfn9e/GgNIAmweCsks0Olw+q9qHw=;
 b=DcMDaDLQG8pOo7qERAAVEXtLQN1fdmPvlZb5IMSQYIFCLqvXUPhHqlgOnb7CZH19hGYeUpTC/n8IVq0wNkIMJxjZaMgchgzOHSSDy8Un5XsWqQrhfF9zGjexEyutIOHs0ZaE+lgPruQykDi+pGfJ8PxAOW1Ta8Xj9ZJKubI1Gu5fAeklmog8M11EybTbANIjOUZzy10DAyA0mjVDfjmpeTzHd29WxJTOcR5+eVVoRH+viir/9YaldQ4hNy76QVlFsPsJmyCQnF09CNgFy+hNKRrWuXRdLgvjKPAVYrsJvviUgsP0VaLmcwsqYqrA88fxhxl/RU2hzGjYkAJSO/dGHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3FitRbcNIgTFPearfn9e/GgNIAmweCsks0Olw+q9qHw=;
 b=PBRAKIKuLYowRzL0fYtbB52axgFR8glgV6iZV1sr/S0YEvYBqVmo9SNlZSX2Gfo2AqPJFY9UAoAEHmI0fLtoLL1zd8lBHO2IlHYSPLPcQ7QVUyWvG9r60VbKeq2Z4R0XtehrG53og53G0SpeAWF+QiZ0fc+sAwNb4Dp9vF5mqnbN2h7V2Wv+5HM84VoD8ECN12SX22fU9mRsuBx+VW8NyulDqXtf5iqwRyGedQUCHAd2HsnmmUcO9MjSEEk8exetjyd6QJzL//EmCv10lOj8xFRdOAQnXE18we4C+zcAHqvjzEu5DSSlGTFjgNa6aeYOwJ9V0thGZaUl3GSlAk/O/w==
Received: from MW4P223CA0009.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::14)
 by PH0PR12MB7469.namprd12.prod.outlook.com (2603:10b6:510:1e9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.14; Fri, 16 Feb
 2024 21:04:07 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:80:cafe::be) by MW4P223CA0009.outlook.office365.com
 (2603:10b6:303:80::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.40 via Frontend
 Transport; Fri, 16 Feb 2024 21:04:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.0 via Frontend Transport; Fri, 16 Feb 2024 21:04:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 16 Feb
 2024 13:03:48 -0800
Received: from pohsuns-pegasus.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Fri, 16 Feb 2024 13:03:46 -0800
From: Pohsun Su <pohsuns@nvidia.com>
To: <daniel.lezcano@linaro.org>, <tglx@linutronix.de>,
	<thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC: <sumitg@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, Pohsun Su <pohsuns@nvidia.com>
Subject: [PATCH v2 2/2] clocksource/drivers/timer-tegra186: fix watchdog self-pinging.
Date: Sat, 17 Feb 2024 05:02:58 +0800
Message-ID: <20240216210258.24855-3-pohsuns@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240216210258.24855-1-pohsuns@nvidia.com>
References: <20240216210258.24855-1-pohsuns@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|PH0PR12MB7469:EE_
X-MS-Office365-Filtering-Correlation-Id: d42dcc06-f3f9-41a9-ea3e-08dc2f32d049
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EEKsYmdNNyqYCGXgvbqa2pz4rFHDNJyS8kSga45k8yhbk7IXAmh7yHhegZFq0WiCXWLRXfCkEo450ajUi3WPCpxAJj6aQhpc2Mayf7alOuvHqvGre6W/vm7QC94qKjUXdObT7QARTsbwmU1HUPoyVQW1vRCuVcPY0HoWGPCqffmelVm4A6PFl/BIh+NfHhllynqqHwHiu3sw7bCkibcjnw97w/uK5kWM/wnGOiMamzydijJOthzBPIMNJn1E/DcIGHUpsbIKiqgssCt62ednhFxk308gLeH/cFIHz3lXcJ64To+VRB+n4OwR4t7kjKR9P+SMmrkR70cSOxXISXmR0d1+vm0I1Og7CyjX+kLCttjNhGagLXRu2pJbNfHuW8QxrLtbvqNS9JFD8/UGMbE+XML/h25QJbxjuKMaV80uCX5Fxes7XlupZpvQZjU8ytCtr0FCY4FGEGahw9zt71R7/Z3/QMga+wDQO2Y8PFiDPTBbUxz51EgxnmRaO2dFXAVy2Nu1znKTXuS6qbSgxBTQQm88GydoupGIBCeo03VcZKvYHGrV3tfpiuO5Gpx6LGjA0aXHkZl+lETbfAySCMR92iitzMk+6MQOaRWkv6EzkIADQPC2V3+xRCZIShzFodmPLH1zergUK0ep1F8tNjsI6Mlwsp8A1EV+9VNpzAIEZZI=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(39860400002)(376002)(136003)(230922051799003)(82310400011)(451199024)(64100799003)(186009)(1800799012)(36860700004)(46966006)(40470700004)(83380400001)(7636003)(356005)(70586007)(70206006)(82740400003)(8676002)(8936002)(4326008)(2906002)(5660300002)(426003)(107886003)(336012)(2616005)(26005)(1076003)(316002)(16526019)(110136005)(41300700001)(6636002)(54906003)(6666004)(478600001)(7696005)(86362001)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 21:04:06.7736
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d42dcc06-f3f9-41a9-ea3e-08dc2f32d049
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7469

This change removes watchdog self-pinging behavior.

The timer irq handler is triggered due to the 1st expiration,
the handler disables and enables watchdog but also implicitly
clears the expiration count so the count can only be 0 or 1.

Since this watchdog supports opened, configured, or pinged by
systemd, We remove this behavior or the watchdog may not bark
when systemd crashes since the 5th expiration never comes.

Signed-off-by: Pohsun Su <pohsuns@nvidia.com>
---
 drivers/clocksource/timer-tegra186.c | 27 ++-------------------------
 1 file changed, 2 insertions(+), 25 deletions(-)

diff --git a/drivers/clocksource/timer-tegra186.c b/drivers/clocksource/timer-tegra186.c
index 8f516366da86..acff97da138a 100644
--- a/drivers/clocksource/timer-tegra186.c
+++ b/drivers/clocksource/timer-tegra186.c
@@ -175,7 +175,8 @@ static void tegra186_wdt_enable(struct tegra186_wdt *wdt)
 		value |= WDTCR_PERIOD(1);
 
 		/* enable local interrupt for WDT petting */
-		value |= WDTCR_LOCAL_INT_ENABLE;
+		if (0)
+			value |= WDTCR_LOCAL_INT_ENABLE;
 
 		/* enable local FIQ and remote interrupt for debug dump */
 		if (0)
@@ -407,23 +408,10 @@ static int tegra186_timer_usec_init(struct tegra186_timer *tegra)
 	return clocksource_register_hz(&tegra->usec, USEC_PER_SEC);
 }
 
-static irqreturn_t tegra186_timer_irq(int irq, void *data)
-{
-	struct tegra186_timer *tegra = data;
-
-	if (watchdog_active(&tegra->wdt->base)) {
-		tegra186_wdt_disable(tegra->wdt);
-		tegra186_wdt_enable(tegra->wdt);
-	}
-
-	return IRQ_HANDLED;
-}
-
 static int tegra186_timer_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct tegra186_timer *tegra;
-	unsigned int irq;
 	int err;
 
 	tegra = devm_kzalloc(dev, sizeof(*tegra), GFP_KERNEL);
@@ -442,8 +430,6 @@ static int tegra186_timer_probe(struct platform_device *pdev)
 	if (err < 0)
 		return err;
 
-	irq = err;
-
 	/* create a watchdog using a preconfigured timer */
 	tegra->wdt = tegra186_wdt_create(tegra, 0);
 	if (IS_ERR(tegra->wdt)) {
@@ -470,17 +456,8 @@ static int tegra186_timer_probe(struct platform_device *pdev)
 		goto unregister_osc;
 	}
 
-	err = devm_request_irq(dev, irq, tegra186_timer_irq, 0,
-			       "tegra186-timer", tegra);
-	if (err < 0) {
-		dev_err(dev, "failed to request IRQ#%u: %d\n", irq, err);
-		goto unregister_usec;
-	}
-
 	return 0;
 
-unregister_usec:
-	clocksource_unregister(&tegra->usec);
 unregister_osc:
 	clocksource_unregister(&tegra->osc);
 unregister_tsc:
-- 
2.17.1


