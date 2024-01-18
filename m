Return-Path: <linux-kernel+bounces-30494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 573FC831F78
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 20:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC032B23C51
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78712E400;
	Thu, 18 Jan 2024 19:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1faBJUsi"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F7E2E643;
	Thu, 18 Jan 2024 19:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705604924; cv=fail; b=UMt+oHspPrwAxTiDODk1WR5UPrzYqcmruXRV3baVkjn3KNVZ9J4cfWiuFN3toK/xT/BWetYB4LKe62cuAm4kzXaqXrBYTfmv+Tub08abUlIrpImDfaa+575zGH5fW2s+YWaeHtjkwqhUlgE8M8L6EIE5CTaMGEWXtlpK7ISfVbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705604924; c=relaxed/simple;
	bh=LziV6RK2xAVDFPaOwyCXUtlx5FdkkpX57NY9/1c+4oQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e0W78nLJBdcZc60yK4Tk298lMeLQi/lYpdAQnVt3LWGFo0kri8SqFpZQGeiXiGiH8NlSUHjXPMBhTSnTAZLmol4/+GmolwVq10lzyUtSq79Fcj0ckx3a+zlKfsFMwUvUTOxF9zHbde+rcNqaouiwTc9PsD7ADjYaofKo4t7oQ9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1faBJUsi; arc=fail smtp.client-ip=40.107.244.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ikx82a0UVD1ba4O1dNYP1Yfh+3fG4Pn4X66sicgBr2AD0cYoYeq1Jv1U51JoaVNZ003k2BczJ78JmIkyX1ayZNPKu7CfkckIb9sNmPN+y5V0Q5knDq/g5iyYPhehQsRkBOgFbI+w26unlO9mJTBQXt0xhHlr3OXO+WBHEOeA7/H6M2AquL0kHpFtPhRna9Zm0KqRbCjp7C/Or9pJkNnBPNlNzmMtrvrhicqE95C6Ykqfnb6pG5PcjGzFy7lsKZUQzJ0Pbs3P2+C0JsqN5KgDm++iT9JtrlN0DZx4lRtblh2a6qTFlxwTp6zY+w8Z0G79qnI5eIA3BPGgstGf8c4tbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TT6aqESmVjzsLXiOvMdOF97y4bZP0Gy6gOWt4/wE80g=;
 b=Zef8ycUdsp+NKpNtGCdobux13/q9k5ZAzxKVMc2LbEiu/OeUU/dggEwsFef9sHg/7nAQ5SvSylLdUBx268oVqNAAxUKphVLsZdLERQDtoK1bw5Li/gOcq9Lmdp8+J3Bpm01WM8fbO9yuZWdRSaTGdwExDjPIJkfpzeVB6WmEiIWfMPzm8s886wNnvgsqYZH+e7zvowazOhFakFPKy11JgCLHYOYysBD8IFTuVZt8hQzbfdSRHrmEriuztRYsuZrcz0wf3ZvzxChhgU19uZHZCYcGLt1wYzI7l53BwpQ8q6pRDAKJihZcvOgaGsr5ZzWjFUSdqzVbS8JE0YR9bYaBkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TT6aqESmVjzsLXiOvMdOF97y4bZP0Gy6gOWt4/wE80g=;
 b=1faBJUsiIgD0rXl3jCJXplOdc6Rv29ukK7+zvNhIJ7wTzXRh8XU2LZvA7/XJj41RJOsg6ia7HrqAdjHuCVLZsMccs/46FmEETZK4u0cbJx9wXP9idL8JjxDr/HrSe2RiBJ36pZjZ16ZBOpAVk5nyx058QLHMOFu3b/ndW2ebUIQ=
Received: from DM6PR02CA0104.namprd02.prod.outlook.com (2603:10b6:5:1f4::45)
 by BL1PR12MB5946.namprd12.prod.outlook.com (2603:10b6:208:399::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 19:08:37 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:5:1f4:cafe::92) by DM6PR02CA0104.outlook.office365.com
 (2603:10b6:5:1f4::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Thu, 18 Jan 2024 19:08:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024 19:08:36 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 13:08:36 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 13:08:35 -0600
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Thu, 18 Jan 2024 13:08:33 -0600
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <dlemoal@kernel.org>, <cassel@kernel.org>, <richardcochran@gmail.com>,
	<piyush.mehta@xilinx.com>, <axboe@kernel.dk>, <michal.simek@amd.com>
CC: <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<git@amd.com>, Piyush Mehta <piyush.mehta@amd.com>, Radhey Shyam Pandey
	<radhey.shyam.pandey@amd.com>
Subject: [PATCH 2/2] ata: ahci_ceva: add missing enable regulator API for Xilinx GT PHY support
Date: Fri, 19 Jan 2024 00:38:24 +0530
Message-ID: <1705604904-471889-3-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1705604904-471889-1-git-send-email-radhey.shyam.pandey@amd.com>
References: <1705604904-471889-1-git-send-email-radhey.shyam.pandey@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|BL1PR12MB5946:EE_
X-MS-Office365-Filtering-Correlation-Id: 428e0b88-ecfc-406e-1d3b-08dc1858dfc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CJGwbspyX6asroc+hUIFMMEC9Rq0xbXIct7ivczmALxOJhd72A8fwQmMm0lJ+SFShwAU4k5jw2O+NCi8373u+wabQrwKEwOjqEizo6l6hU9cG9RBUl5y8D817jWJk+/myUK6wTBQyKZqEyafzEUJqVPeiwIjQo2JLNEOI50jG8SzJfoNDUXVhEKC2ZqIoAJbz/SYQAI1PzA+R9DG1G+iNTO2Nf/fNmDCn2zdnHrjGoke7Z/ULgUK0NbrtMzsBAu7y054wMV//pA2+NCcN16Cwfkw/2pMq/CDaslbxa+rSARw/6j/SH2PVpbjBIvGWwsAOXLdbonkGaayNkKgoUxSVMF18D6GiaeuwSXkQGuJsUqWZwdZtjBDEYWiYkoGe/iog2PT1nt6Jw6JhdGHE7PLLlM8pHGlI+ktKfqAPx6LTrpz7l8oBQRAABff4Ifay0Vrr0pimzzxJ/17Nmk5N31UPM3gelPbZt7Wtso5RfsS3S/3ioKZFKKZ5GvtxUhaxDEH3K9sdF/sFFqSkSnxg9UQEvL8yIqmapsRJgRr54POsfOAqI/kiLeQwXwN4AIuuStjFV+74f7Z1tuxRTtCSZdIZ0mrbToaqKeuHnQZiiXEHFOs+gj2bQXg+mGfKRUQQGg78ZmvMIKiNQNcSAokm/SCvn5BaYImurYnihhQ2TcUhzkFnI17beTsDFafBqGMOGEZV7LtBOeOHcGn8tZQ84MsJAPCO0PwN3nrCPIIypoh1DrGcccXZ0lDD2JdSRvW0ntmT5zZbrsYw6mjREbw4+nRYKtIhBfuyUTGIXfvBVoXJnw3MJDcZg17kQUVUS7CjS//
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(346002)(396003)(39860400002)(230922051799003)(230173577357003)(230273577357003)(451199024)(1800799012)(64100799003)(186009)(82310400011)(40470700004)(36840700001)(46966006)(336012)(83380400001)(426003)(26005)(2616005)(82740400003)(47076005)(36860700001)(8676002)(5660300002)(4326008)(41300700001)(54906003)(2906002)(6666004)(110136005)(478600001)(316002)(6636002)(8936002)(70586007)(70206006)(81166007)(36756003)(356005)(86362001)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 19:08:36.9346
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 428e0b88-ecfc-406e-1d3b-08dc1858dfc4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5946

From: Piyush Mehta <piyush.mehta@amd.com>

The regulators API are disabled and enabled, during suspend and resume,
respectively. The following warning notice shows up on the initial suspend
because the enable regulators API is unaddressed in the probe:

regulator-dummy: Underflow of regulator enable count

Added the ahci_platform_enable_regulators API in probe to maintain the
regulator enabled and disabled ref count.

Fixes: 9a9d3abe24bb ("ata: ahci: ceva: Update the driver to support xilinx GT phy")
Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
 drivers/ata/ahci_ceva.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/ahci_ceva.c b/drivers/ata/ahci_ceva.c
index bfc513f1d0b3..1c56f0cabb11 100644
--- a/drivers/ata/ahci_ceva.c
+++ b/drivers/ata/ahci_ceva.c
@@ -219,9 +219,14 @@ static int ceva_ahci_probe(struct platform_device *pdev)
 		if (rc)
 			return rc;
 	} else {
-		rc = ahci_platform_enable_clks(hpriv);
+		rc = ahci_platform_enable_regulators(hpriv);
 		if (rc)
 			return rc;
+
+		rc = ahci_platform_enable_clks(hpriv);
+		if (rc)
+			goto disable_regulator;
+
 		/* Assert the controller reset */
 		reset_control_assert(cevapriv->rst);
 
@@ -340,6 +345,9 @@ static int ceva_ahci_probe(struct platform_device *pdev)
 disable_clks:
 	ahci_platform_disable_clks(hpriv);
 
+disable_regulator:
+	ahci_platform_disable_regulators(hpriv);
+
 	return rc;
 }
 
-- 
2.34.1


