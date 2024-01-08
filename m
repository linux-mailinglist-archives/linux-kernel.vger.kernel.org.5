Return-Path: <linux-kernel+bounces-19792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 822B0827403
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89AE31C22DBB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED55524B0;
	Mon,  8 Jan 2024 15:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AJF3my6K"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F1754BE5;
	Mon,  8 Jan 2024 15:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b82sQBECk1vbd5Tv/3WZD+esDxuo6BzeqZhTkLsTMwwf7zAfb1fuvhDcKADeJWIZ6yKAQ4RukFNuOa1Heg6vgE1R3PS21upHpjq5BRcUEbYNVhyqb5BkDIx8Ssk8+ijK3aIH0MVL6BZJKwHsJPaSZs0GVhLnEYV2ArE2CYrBSOuPMGMFgB3/Rdy3YHUPUJRh7b2lQbKdgFEm8mdRk65DF4J5Nk9NcOudDW5QsCHi9Ok0dE60Rc2D/V/iXgbrue/pLrx79tYQELHqu+NfZ0mwu6wbtALg3zuVU4JWRJV/fJzC7cYewbQPSBpseqtWn7WfuWAJK3IspJq08vlvxmZsyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gs/I7jYHsJkyr5YJijZgtQhVoWgc6+0gO7jYvudfN78=;
 b=S1pJgt6/GcN1oHgWKidiFGrPqxtS2mw0fyHGJHciqKP9hMgkuJUVGD6RHK78klm3JIdbGdDdcH5uSoXDMwIVJc1HfS54lsWRYDug94r9N/YT6h6vUeAOt3RpMlsX2wOD2KFF4hUFfi+7JaiXSKWaeT9/a/S/gRmVKJ+82LAaZvApesXbXlgZHwnbgXhY19oI1bd3n6FbAND1dPsMRd51e/BT1gu+NFpmzArm5AQZSGWg1Jg8xsGR9oBkMqUDR9QLtOkZ4poGM7xejp0rc8dzlgeeuNM85M5Xocm5MNQrB1mF76aFQjk2UewH/j1BYgr5LHu418oNS72VhZ3+i21rug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gs/I7jYHsJkyr5YJijZgtQhVoWgc6+0gO7jYvudfN78=;
 b=AJF3my6KTfHsq6owk8EnMQuipJeY8E9P8AQabIRHbUFh+EZzCtlNn+AcKqYd+w2hPWJnpO/Is9ZVc/rUr/KYYM5O/7wFvyAsvsDwlxqlUCoMzb+GPX6Lo1zOnX1Z4biCJ42x5VJr3ZvAO/fGpkt63d+L+LPefTCFL6qNYCJaTkw=
Received: from BL0PR0102CA0010.prod.exchangelabs.com (2603:10b6:207:18::23) by
 PH0PR12MB7095.namprd12.prod.outlook.com (2603:10b6:510:21d::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.23; Mon, 8 Jan 2024 15:40:55 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:207:18:cafe::65) by BL0PR0102CA0010.outlook.office365.com
 (2603:10b6:207:18::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23 via Frontend
 Transport; Mon, 8 Jan 2024 15:40:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Mon, 8 Jan 2024 15:40:55 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 8 Jan
 2024 09:40:53 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>, "open
 list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>, "moderated list:ARM/ZYNQ ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 10/14] arm64: zynqmp: Remove incorrect comment from kv260s
Date: Mon, 8 Jan 2024 16:39:21 +0100
Message-ID: <0bd166345ce78097a1ff8d4307545f5026c92267.1704728353.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1704728353.git.michal.simek@amd.com>
References: <cover.1704728353.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1772; i=michal.simek@amd.com; h=from:subject:message-id; bh=Wg4xsmapR4Iz2VQM0OzcCO7F1L1tAjf22hfJRnyqj0A=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtQ54hpvLkd5FB89eUioNZrPnasgictPTn+61ETPXuFn2 bu6A653xLIwCDIxyIopskjbXDmzt3LGFOGLh+Vg5rAygQxh4OIUgIl43GFYMOlq3aq6A4s/7O4V up+5b9kfq80zuBjmGTGtrvg9cWfySTaD2sMeqXc9p9geAAA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|PH0PR12MB7095:EE_
X-MS-Office365-Filtering-Correlation-Id: 340280a6-2e80-43b1-3fe0-08dc106033d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AlESu6R8eZyMFlmdnp216kV5KeSSUWSzXiwQXlwDjF/o2NFD6tnN9GtNqZazWuplxrQ8MUAI/3tNvUdFHeNw8OOU6sjgRGdwBNa/g8w2gmPyhP4lRcKLlZSGrgH2shW6VaGWfiQ727iIVxhKx+6wUPyMdAxBCQfPgUFp235WtAuHP+Kq8OsKzVzGWL38CVLyRCA+U3GBfFNbgxo3LnTQ7aORR3HwX+dnLiYLtmGdfG9CrFFlRAALx6R4MDz1qHvGIq0Na6NcOoVjHS8bRbTmnnimnIGwki9EuTvVTppEE3hSoxbXi6N/mUI39RcaBGh4IWhNCZ146gFuIMMkcK+rYPNUYXhi9Mu5M6HqghJeIpvQw3jqJQwlEAT4p3uryzTvcoPErMjToqy+Yls3UXAN95JO9sqmafspdvKQj81C85l7tCgXxFbVWs0emmjcNWvZb59S8d4uARnepJkEIoScMzFQOBnjGxSFmIUJ2yTq3GGV46bS3wNPVlt+aBVkSYRB4OdX1pVjUQqZrMBPrSWzLfcNJU2rtoEFm8zwMYEi5Ur9UyUUqPBP46g+BPxQ5YH/6pXj5uQvdBgv0B72lXBiJtzut15E2OyoZ8F6FoWZ5iXenwBU73mpGPJhraVtOrZC6hIhcHghgIu3CrOcdxnd5kCRdv08gJREc+c0oH9pnN7/l+yJIEA7xFVZCyyag12WLW4H/6V3xdV56CeqoSMaqWfnig/rr2dku/CpIBOxIj+qh8zofB3tYXpPL7CBJpIY5hZVSkVkIU+8PcnzNMyqJGO+ULb9b8xmzjpZX1FaZhI=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(346002)(136003)(39860400002)(230922051799003)(451199024)(64100799003)(1800799012)(82310400011)(186009)(40470700004)(36840700001)(46966006)(8936002)(2616005)(8676002)(110136005)(316002)(54906003)(26005)(336012)(16526019)(426003)(83380400001)(70586007)(70206006)(41300700001)(86362001)(6666004)(478600001)(40460700003)(36756003)(5660300002)(82740400003)(40480700001)(36860700001)(81166007)(356005)(2906002)(47076005)(4326008)(44832011)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 15:40:55.2014
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 340280a6-2e80-43b1-3fe0-08dc106033d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7095

Remove incorrect comment about required nodes by spec. In past gem3 was the
part of SOM specification but it has been revisit by introducting KR260.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso | 4 ++--
 arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
index e7940067ff3c..b7b94254cc09 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
@@ -139,7 +139,7 @@ &sdhci1 { /* on CC with tuned parameters */
 	bus-width = <4>;
 };
 
-&gem3 { /* required by spec */
+&gem3 {
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_gem3_default>;
@@ -166,7 +166,7 @@ phy0: ethernet-phy@1 {
 	};
 };
 
-&pinctrl0 { /* required by spec */
+&pinctrl0 {
 	status = "okay";
 
 	pinctrl_uart1_default: uart1-default {
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
index f72312926299..1446c2b19de7 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
@@ -122,7 +122,7 @@ &sdhci1 { /* on CC with tuned parameters */
 	bus-width = <4>;
 };
 
-&gem3 { /* required by spec */
+&gem3 {
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_gem3_default>;
@@ -149,7 +149,7 @@ phy0: ethernet-phy@1 {
 	};
 };
 
-&pinctrl0 { /* required by spec */
+&pinctrl0 {
 	status = "okay";
 
 	pinctrl_uart1_default: uart1-default {
-- 
2.36.1


