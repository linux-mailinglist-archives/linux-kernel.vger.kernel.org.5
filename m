Return-Path: <linux-kernel+bounces-44426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C468421ED
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17AAC296470
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD91679F1;
	Tue, 30 Jan 2024 10:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RckPYNw2"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EE066B5B;
	Tue, 30 Jan 2024 10:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706611742; cv=fail; b=ofxF1ZaFu/aA8PxpycsS1Fe76RP7G9yA/BGap1pndsuOgu6gL+w8M8Tgb3TtOcK3C5Va7ohgrGq5Ti1zs6XobR5eHsYRYSgKNMK4i9LjLX1F4my07XLfhSxKeXX4T+Pyb/yhH6FHEtzVavOtvNqInXIYR8XQYothnUh9e4kSdl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706611742; c=relaxed/simple;
	bh=biTXvryiZ3WQTBqxPgXjsX2gkI1slSAyXaVbQ3CBY5o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I5oLYv15Kf6U6Twl/OQDhafa4bKdPJMP2Xcj8MnLtkjHBn/J9tFAi4EBLW7sGJLOX2a/eGl+a16uJzBduCASvF/kO1uW4IrySWDRNhCq5WFQKxjyNd7vn4OoWe7YQWa7UoFsEY759srKdzin8a6qt8Gto8wyt8aRi5y/yuGzzhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RckPYNw2; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O2MVALKGhnbDYhR6d9M1jacRV3C1WEdIcHRnHkFcr2PsG3EJXiNeoOQUzkVV7CHchl1f0E2DnMHRkXoYRt7rpuIzF3nFcWz/5A35+UmDUFQf5WGcZoJWhDC3wyoB392c7lH0oBs9V74Qa1OU7lXsX022iDhHUhgrBqAw9QVI3i2DEk0FvWq2ZiVP5aM+HmEIExOTge2fkecH8y2OidkrBJ+8h3oz8zvSNu7a9DrLGTra8Wkp4JHbsO+qsAZPeWz3VuDYAR1M8NW4Yyz9FXkkr5EpW/WpGeetUk3vh72aX/lCXKC0pc0ZZYQ3owoRT9AHFHsJqrP0Fg28JYPVdQfgKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=obFxm1giMMeF4glfS4zrlTKUuRz9I220oRhmyWlRqcw=;
 b=mHpMaNHtaO/gxmDZ3qpU6kLYifF/qetbTAf3ZLjptrtKjL06gLrKT2p4iFJWYnu1iGEf/EQEZk6Xn6Kxjr477yOEFR/Kl5ZT4uUs/K4FqhGwP77yWJQnwHp5bz02LpkA/huWI9G6RgjdhNuKTUH/qs0zACbryWPTokmggdwadJWv+xvSEHEu21/m5IG574V6YYy3nQaGjr70juETJE6gfXTJBzIbGImeITRJKtYsQiHyQT5ImzCy+YQLnrev1425barAWjJOv9Hur9onxnYjFrXmqDFYI8pcO5X1wwEIIR08a8h4tKCyhOYGuTZAQ81W2FVmjRHgtUOBhMcH2t+huQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=microchip.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=obFxm1giMMeF4glfS4zrlTKUuRz9I220oRhmyWlRqcw=;
 b=RckPYNw2bbxtwVj5ZKRyAKPXxl6EWH1+l2/Q6Rb//xf6kEhBLAj+P8fSk1O3+bmA/HLD47x9eg/Q2kELcGx1GEQP08mNn6shLq9H0sktNjln5pEY3WpAf3KGdrIIhOujllr33G7LaF4iq89hoT/JDhydvV9jkjpEzN30fFATg5o=
Received: from BN9PR03CA0556.namprd03.prod.outlook.com (2603:10b6:408:138::21)
 by PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Tue, 30 Jan
 2024 10:48:58 +0000
Received: from BN3PEPF0000B070.namprd21.prod.outlook.com
 (2603:10b6:408:138:cafe::24) by BN9PR03CA0556.outlook.office365.com
 (2603:10b6:408:138::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34 via Frontend
 Transport; Tue, 30 Jan 2024 10:48:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B070.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7270.0 via Frontend Transport; Tue, 30 Jan 2024 10:48:58 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 30 Jan
 2024 04:48:57 -0600
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Tue, 30 Jan 2024 04:48:54 -0600
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<linux@armlinux.org.uk>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <vineeth.karumanchi@amd.com>, <git@amd.com>
Subject: [PATCH net-next 2/3] dt-bindings: net: cdns,macb: Add wol-arp-packet property
Date: Tue, 30 Jan 2024 16:18:44 +0530
Message-ID: <20240130104845.3995341-3-vineeth.karumanchi@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240130104845.3995341-1-vineeth.karumanchi@amd.com>
References: <20240130104845.3995341-1-vineeth.karumanchi@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B070:EE_|PH0PR12MB5417:EE_
X-MS-Office365-Filtering-Correlation-Id: b20269a0-1106-4709-4747-08dc2181102b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PsGxUehBtKWwkyCxm0s23VoHdCkVIU2/8j8MIZSjfbBYZlMnYiB2V9QwdiI4KViytxugQqYkmiCrnKBgIkz7Y0Ois24zQv5H3v3VjBtYjPRYwR7S2cqKc2RsDiEFXV/Pr6Xv4ljY4/VcQKgOTFlWZB7t7r0Ykef0COxiBD1xln+BTtY4fhF9hyb+Vue+o3W4pYi2+Y2kCTJhmmBXYU25mG9vZ+JAWerChuTY5C8PfZWnxH66eKjerWZte9Be2592NxdCz8uCR1K1tTP8TvX6u5r/mra8EWyIrrXv5SFLpGo4wZWTlG58MJueE7Iq4+gsYDT+qoq08a/rhPytZIhpcxOIQD4flMJVFOGr2dePV4KPuEggViaKrfVEo4upnV5eKbTnU/KDDSQOcxg8zW8lI19ph/SfSuhgb+rUBzhek5x3+Vq8fHwr2YP8FovcxN2xAun/PcIZDbpTfzaSi5bxJwOsRJM0eCToHwiGssgRL2Yn5gY2Tw3ArZvpMEk+hRklngda4s0OEDGwOe6bObYmZuIo04SGSmroMDeFPlhmAVnuUi/5ZdeESX2D64/adPGAIVIP0LYRdVe0o1hgnZECh8j4jY5lqvRf50hVLLI97QdYFmN21qGqCyIDQjMxVkRjSKztPwHegFlPbsiWUlxrjrR/Lqtm1AIH2eQZpJDSE+HDsf0fSF6wZu0MAbF3J+JPIcyDZYZ5UWwX59FJiWkABhDZm1HKCKJajwLNTabO9ayR6zzFxzN4cDYT0sWcktnX5S/KO6YZF98GFueViOf1zv7URr6AOnfdNe6tATEEEx4=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(396003)(376002)(39860400002)(230922051799003)(82310400011)(186009)(64100799003)(1800799012)(451199024)(36840700001)(46966006)(40470700004)(26005)(40480700001)(40460700003)(426003)(336012)(6666004)(1076003)(36756003)(86362001)(82740400003)(356005)(44832011)(4744005)(8936002)(41300700001)(4326008)(5660300002)(36860700001)(478600001)(2616005)(316002)(47076005)(110136005)(70206006)(54906003)(921011)(2906002)(7416002)(81166007)(8676002)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 10:48:58.5068
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b20269a0-1106-4709-4747-08dc2181102b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B070.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5417

"wol-arp-packet" property enables WOL with ARP packet.
It is an extension to "magic-packet for WOL.

Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
---
7c4a1d0cfdc1 net: macb: make magic-packet property generic
which added magic-property support and wol-arp-packet addition
is similar extension.
---
 Documentation/devicetree/bindings/net/cdns,macb.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/cdns,macb.yaml b/Documentation/devicetree/bindings/net/cdns,macb.yaml
index bf8894a0257e..4bea177e85bc 100644
--- a/Documentation/devicetree/bindings/net/cdns,macb.yaml
+++ b/Documentation/devicetree/bindings/net/cdns,macb.yaml
@@ -144,6 +144,11 @@ patternProperties:
         description:
           Indicates that the hardware supports waking up via magic packet.
 
+      wol-arp-packet:
+        type: boolean
+        description:
+          Indicates that the hardware supports waking up via ARP packet.
+
     unevaluatedProperties: false
 
 required:
-- 
2.34.1


