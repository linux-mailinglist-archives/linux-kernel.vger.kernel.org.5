Return-Path: <linux-kernel+bounces-76792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DA785FCA7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4833E1F2556B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4B515351A;
	Thu, 22 Feb 2024 15:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2kg7YYJL"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90662152E07;
	Thu, 22 Feb 2024 15:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708616361; cv=fail; b=AuEUHeDiU/ViAct/PkBBJ0n0oxB0CqGgwFoWkkdiFkyj2QbP1cAV+hjtQaImCuFnHMEFcf14tWnPnPIqJl6osUZE7pER//gSvVBAdaZOpSt7s1SEnNoUrSN3VOnL4lqZoSj0aeoU1IqX9I1kQVYbhWYAsO6cWhkLQ/SFXA/SgYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708616361; c=relaxed/simple;
	bh=K/JdAhcKRXCA0M0L7U/DYTYlmfjcFhkKyuFSf2KSXp8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XokD20p8OgwhyR70KlhvyLBMmWCjVni/1KKIUwGK9nGiP9Xsfy1KZAnBJ1hV0iZSf+rvMfyT3XI7ewh70WRYLnkZ77/ygv3jWfw+S9otaBAM/WOj/NXgIeyQsF8g5yhh+ghiTXgx/32t2GxDyDSE1TvbPWwqhhe+uxdYSyUm4XQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2kg7YYJL; arc=fail smtp.client-ip=40.107.94.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GOd/04ZEXd7yg50I/HS6vqhWpw4437XEq8V0BudhBMbuXw6ktjigZlaR32AJRqQZ7bllVDIC6Ymw0Wzhmolm88Bwewo+iUXvOJvTUvMsih1qQUqpfLPA88ffTxNXvqifEhnJ2Tpky1BEb+GCStX+FZ+CdIRjNOuEgc3aV71ut7fRP/CgrcLA+Yz7BnBFG1ZlSs4jJbx6vPx5w1n/D6YZOyvq2M4m13Scpwn0eYxZIb4R6FFBgJ9maYl2NxIAgAqkFkUqX5VA/3omq2sIP+X5As3cL0fWrCl2qc8wRrgZEmlZJQ8ibUiurD6sVwAIgVYbopsQpIZy3nA732iQB9i6yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1sY55USOYqGVVfb2BFIg25xYCkPJMmBZ9K5PMjhSSJw=;
 b=Ut1jH8H9Ov9seDSFapclHmPDVOMPSptA3Mutn3Opvf3m46J5EuYs2ydCjMRQG9D7wdDk6rNsnYqtBwG8aFIQhzRzX7IL+K5kwe6r9D1MxJvVhuVkJXMCsA43beRX8KVawGpfMomUfd2ujF549rVxIqifjKCcJ6BCVk7EONt5r+BYPE/6STaYAwlJtJKxnevbr09CSOEocjKi0JdwmL61CBwrWTsY1iAg90Wi96WKFGNLdz0Z8e06LkNnUM0KodZbxAra+EE510tKzkeMHbm9kywBDJdT8jY9NKRieOXSNxJQY2RisL0ydiQcy2ce/XPSxJzm/3r/dLn5eUiAt9XCqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=microchip.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1sY55USOYqGVVfb2BFIg25xYCkPJMmBZ9K5PMjhSSJw=;
 b=2kg7YYJLq4bv74sTlKAkOuk7eRd/UAyF/oY8cAXqMrGJlP9JXpDQjiwNW867Xbl+tObluUMP3XiL7QUVaJQTGzad9+JpDjBIM6nLdHIncwHs3NWC9/lU5oCHBiv+pOaoeboFovp3BSHMPZUJgsMo0NvMOJJGhnMdexJvlSg8ayc=
Received: from BN1PR12CA0021.namprd12.prod.outlook.com (2603:10b6:408:e1::26)
 by PH7PR12MB5782.namprd12.prod.outlook.com (2603:10b6:510:1d1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.20; Thu, 22 Feb
 2024 15:39:17 +0000
Received: from BN1PEPF00004684.namprd03.prod.outlook.com
 (2603:10b6:408:e1:cafe::f2) by BN1PR12CA0021.outlook.office365.com
 (2603:10b6:408:e1::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.42 via Frontend
 Transport; Thu, 22 Feb 2024 15:39:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN1PEPF00004684.mail.protection.outlook.com (10.167.243.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Thu, 22 Feb 2024 15:39:16 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 22 Feb
 2024 09:39:16 -0600
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 22 Feb 2024 09:39:12 -0600
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<linux@armlinux.org.uk>, <vadim.fedorenko@linux.dev>, <andrew@lunn.ch>
CC: <vineeth.karumanchi@amd.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <git@amd.com>
Subject: [PATCH net-next v2 4/4] dt-bindings: net: cdns,macb: Deprecate magic-packet property
Date: Thu, 22 Feb 2024 21:08:48 +0530
Message-ID: <20240222153848.2374782-5-vineeth.karumanchi@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222153848.2374782-1-vineeth.karumanchi@amd.com>
References: <20240222153848.2374782-1-vineeth.karumanchi@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: vineeth.karumanchi@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004684:EE_|PH7PR12MB5782:EE_
X-MS-Office365-Filtering-Correlation-Id: 41a67c64-c821-40b6-cd25-08dc33bc6dca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IYcLOSFeikfM/vIqYH+c0zvkhuM3vzRg/97OVWjjv5MAx2Jy8MhwI2vVXZ3EilPFF8jUIFe9BWZWKMtKRiiTlBlhOKC3OFRMs/qDUSZuAltpXxTWUu12L2maR6TXXhlmSHNXvqrBrSQnwSVNqL3t2XmrUP5utbLcm6xyR2cs+weis4wnAS3Pi+2gtO6FKp5RROuhqNvdmqkf1sd0XXJ5whcHm9luTO13UFtHZInGrAZaRIFuukbro+nf0cgjGMTslGmq//leXqJ4o6UPNDj1hX+JYET/wR9rld/PxwEdFuLr/+7f585mAO55J69C45cOkGMSpNs5yTiYF4MsyXlV8gmEdtkpc4hdyXLHUjOpRf9BzHx2xDf73xHWi2nf8TtnKoYmEUYZvOw3FP4NGz2kQMpGGi4kuYnsee1JOzFxAPq4pI7IbyrcEk8+lHD0/CmwzuwCQEwqy30OtSIOtJRBuo4zDwaA1IPeeaeVJcsIjv5UiojwaBuTx8/mCoSQ+LIkd1EIBYhEqXgwglHOCR7XO6BRT6dDxU3JmNrqtJY1+9EULeZTgieHV6Cbv0PouyzgAQRc5RkEunEvQjsli2skbPfjoX5BdPcyE/lmLCl8BvA+8C9Bvuwux85+5auUAYvYI/g1y1njcn3zncn8htHsMKtWzLPRSXXlhtv+Rq23TeM=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(46966006)(40470700004)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 15:39:16.8174
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41a67c64-c821-40b6-cd25-08dc33bc6dca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004684.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5782

WOL modes such as magic-packet should be an OS policy.
Leverage MACB_CAPS_WOL on supported devices to advertise
supported modes through ethtool. Use ethtool to activate
the required mode.

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
---
 Documentation/devicetree/bindings/net/cdns,macb.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/cdns,macb.yaml b/Documentation/devicetree/bindings/net/cdns,macb.yaml
index bf8894a0257e..096309bf3235 100644
--- a/Documentation/devicetree/bindings/net/cdns,macb.yaml
+++ b/Documentation/devicetree/bindings/net/cdns,macb.yaml
@@ -141,6 +141,7 @@ patternProperties:
 
       magic-packet:
         type: boolean
+        deprecated: true
         description:
           Indicates that the hardware supports waking up via magic packet.
 
-- 
2.34.1


