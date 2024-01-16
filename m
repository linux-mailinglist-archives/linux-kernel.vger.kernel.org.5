Return-Path: <linux-kernel+bounces-27050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEAF282E9B7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 07:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14A59B22E26
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 06:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A18410A24;
	Tue, 16 Jan 2024 06:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="xgu97cEO"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2068.outbound.protection.outlook.com [40.107.117.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F4410A12;
	Tue, 16 Jan 2024 06:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LB46yyI8rRp3uPlpuKfIB2V+aqqaobtnLc6dxgAP/h5qV26QzNnK7BfPW8FTTI/Vn9BzLJ4gPgV4NSIPbYPqULpPUm+UupF5br+MNbgLkfK9kN52U6j7HgjgS9LO7Oc16RnH3/r1kFKXQzZ6aHvyGdivGe+46MDToVlreJ9lOD3o9aISOLtYOdqytch1glHH9JlXRSO5w9D9zlSij6oWYhKopcOWwzwAi6Habl1Kx8cK2lF51NcmhEqbptUfqzefzFDchicUm1dJnLBv48b3F/lN5SFplGd+hW5nyozrAcSYpwg3Fvpyn+blYFQumQECngxy964GthiLa3l8AHXNZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7/BmlKr6zLMkGAeF+DWiM7DgLPBo9g0RguDMaR7HcJM=;
 b=O3q+n0wuJYfoR1jjeTW7R6SXw5v6gSbN/uB9ZUgeUXRLFqVnqVZBGcFzQVxtl/nUCGSJ92SHWyFr2SA9eT1W4TjtAipEyaLtG+PQ/V5oZHklJ9ycLxzvLz+1PcWk7bOSekB+3JaeYdYNwiu6X+kBLX/HqP/PGLfwm4niDSPdulSCNk7IMqxL/tIvcCQMDBlTWzUrPGPc8/IgirKyK1JjbeYCW0ZYkjJcRDEeVtkVQAKgncXM1j+UCS8/+6mlS/bNKtv2lE0U52hhFTypttGGKgtybHKmZ6e5KvoQC7iLyHE65B4pxUIfqtyCuGdEQ1m+1MAB08fxHCSBDaRO7qXMDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/BmlKr6zLMkGAeF+DWiM7DgLPBo9g0RguDMaR7HcJM=;
 b=xgu97cEONoS+Es4LqHOSa9YAAhoWThpnWlMuNMRxRCz8whFiowf5WiluVitxfSB5Wc6bD/ln7yJpOEI6AcjEBJmClCqYfPm9fXyoOeRcDHEWJuZ6FGldV1qiHHXKqXDDZZ9fU2xeDvB0cZhwGaz3B+mDqz4X9Ud0waGCFZ2CwvcCP73iFSup8CBqbanhiRIdDBc04uzpe1VfcoVvmNI5EapzNPPojMDc3Yw0IfP9oSDkvceHWDJ7upV2m4jX8rYMRxrA7kFCieAOnywEpgXD+Tee2QfdgM4qu8cyj0KUO69TU7monNGunsRJwPNRf+683HqJGdB43iNwS4BkIPPQAA==
Received: from SG2PR03CA0090.apcprd03.prod.outlook.com (2603:1096:4:7c::18) by
 OS8PR04MB8099.apcprd04.prod.outlook.com (2603:1096:604:284::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.28; Tue, 16 Jan
 2024 06:53:46 +0000
Received: from SG1PEPF000082E6.apcprd02.prod.outlook.com
 (2603:1096:4:7c:cafe::6c) by SG2PR03CA0090.outlook.office365.com
 (2603:1096:4:7c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.22 via Frontend
 Transport; Tue, 16 Jan 2024 06:53:46 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG1PEPF000082E6.mail.protection.outlook.com (10.167.240.9) with Microsoft
 SMTP Server id 15.20.7202.16 via Frontend Transport; Tue, 16 Jan 2024
 06:53:45 +0000
From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] ARM: dts: aspeed: yosemite4: add I3C config for Yosemite 4
Date: Tue, 16 Jan 2024 14:53:42 +0800
Message-Id: <20240116065343.3657378-1-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E6:EE_|OS8PR04MB8099:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c8b114c5-dc99-4c36-d969-08dc165fe296
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wk8p8mOyy66JzuqFQv2nIGna1Q2wcmea5VnplvCxspklwoH8Es3cxDoVsEfgDgnZnPRB8sXXvjUoiEiXt8KyAQ7adWeIP7H2JGl2SxXjvDL9vVbKHOJl7oXmVJ79EVW1og2EQisOOuZyfMbTaL9YhcGokjZnkmrilUx6sT/XzPI33DohF3pUKs6dE1ZTHiBM8kjybspLckRQ5Ap+QmVznL+d5QxFNVZjqZ3xp62AmjdsSxvNbx/m0y3fCpGmtuvNClmWmIo4V8pHdwN5+wsyQ+yCn07/SifpLs5btxl7ejtPjV+RELgylnzl9TTmg/YnLVDgPNywKAip64QLPbv2ihBwKDbOHlTihniq4+9jm3Jmfre2KknUr8AjCighRrwwbcNoOQFLUKGDeBXE40ZU3AYYhvQbv5Y8hpdPgvmwQsm/MMwk4QUHAp8LM6nrXjBW0CsgU3XosQNZQ8VSX2jGGmF8h9MnpuhAWLYntdyQSGG+FQhgBwvN+Vu5ziLOq5CqwnALAVkG+LEfL33x+orQLI69biWvf4/STcPG/epvfZt5I1KEom8CFbi0P4jpR03dkfydSXJfK5YUL7C/Nb8k1nzaWoKvTIrYDe2X8pYCeS112bhJDbINDKM8EKZoDLinwxO6ZoTEzRRQibHq480XI/rAxUyEGGau13tp/ci6y7DUeL8sUDmLf2RNpuj14TC++UC8+JKKh0TidSzOtdQd0A==
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(346002)(376002)(39860400002)(396003)(136003)(230922051799003)(1800799012)(64100799003)(82310400011)(451199024)(186009)(46966006)(36840700001)(40480700001)(2906002)(7416002)(4744005)(5660300002)(4326008)(70206006)(110136005)(316002)(36736006)(82740400003)(6666004)(41300700001)(36860700001)(6506007)(9316004)(8676002)(70586007)(8936002)(81166007)(36756003)(6486002)(356005)(86362001)(478600001)(47076005)(336012)(6512007)(1076003)(26005)(956004)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 06:53:45.2446
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8b114c5-dc99-4c36-d969-08dc165fe296
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E6.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS8PR04MB8099

Add linux device tree of I3C for Yosemite 4 to enable the I3C path
to the I3C hubs between BMC and Sentinel Dome BICs.

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-yosemite4.dts     | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 64075cc41d92..81b1fcca97ff 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -595,6 +595,18 @@ i2c-mux@72 {
 	};
 };
 
+&i3c0 {
+       status = "okay";
+       pinctrl-names = "default";
+       pinctrl-0 = <&pinctrl_i3c1_default>;
+};
+
+&i3c1 {
+       status = "okay";
+       pinctrl-names = "default";
+       pinctrl-0 = <&pinctrl_i3c2_default>;
+};
+
 &adc0 {
 	ref_voltage = <2500>;
 	status = "okay";
-- 
2.25.1


