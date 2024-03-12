Return-Path: <linux-kernel+bounces-99885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 885A4878EC1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 07:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB8151C21EAC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 06:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1059B58AA9;
	Tue, 12 Mar 2024 06:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="09Fp62vz"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2064.outbound.protection.outlook.com [40.107.215.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B0C6086F;
	Tue, 12 Mar 2024 06:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710224239; cv=fail; b=HN0PoE29mO9Qj8ZEACKy59BsI527roVp5n1CEoaG097SU5Z0ZdzDi/PxFqcFdy5pHMTbQbxe/irYYK73PKvTZawilwoaNV9WZjsPMJrD1SS43XtkyODhnaHh5+kpQ0IsGKxIas7gRyvDFYbT0y7+cQsymtuPRSOiR/kmpIsg34E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710224239; c=relaxed/simple;
	bh=huDWpqifYwaXk57pkbH+EMef93IO/1MUbhbuDMD7oZA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k6c8SHpIEmfR6KSR8tLsQ7lGA2CJG1GUS3kanpY2XzC/WtRYEg7QRChFcJ/SIPT4pfMLlba3FpikV+ZSQFn/VqAaqyRPl2ybMz+k+LErSjmFOPRCqGQorUGZX3cwxU4cazPZ5VDAuplRlZW8p31RaBZPkHqs10Ao9ZosFeXSxAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=09Fp62vz; arc=fail smtp.client-ip=40.107.215.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=StSVDf/nCcqpbpZt/XrKAkjmz+TGcU6PpsPyvOQ+bnkr/NmvQ51N3nuDlJhOw8tlQE7XANc/Jc+76pAQDt11xQ8Ch0do9No9MJzwyRHrPo6EoBojlHpXo8RH56DZdk3kOK0PZV6yC7mJw2yySwBKhMCjERhZBK4FkjTYOqBldytF4XR+rFoZoTgmy++BOj/sql5jIRwUuLLsDO6SHXIhmSdlCjnr37hLM8zCrUlk5y53aUY6CdpIC7Mbc4E0kqJyXuPMtfyr5+A6GwrOSk2FKFOvxZjpxxP0zDeTKp4SIcFPnw+aoZ64MQqbpZ2nd+vBzlc3QikN/lKbOEdPsvu8aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rd3HIM5WyL6SNThkdGueerfKvyKQ76+KUnD7777t0BE=;
 b=ct7Wu7Fz+eazeLW9mXk3uIGP+CnmkBd0Nlq/dP6e11nrHFICwldbHlmGCQQDs16Wi4gKDsT+gwM/OivPDEuhAmnQoTHt3dTGtUDVShXLrX0mpq6m6eROaWeCz1z1vDd/FZZPLy5HMtR5/DtyiyFM2tloLydwAlIMR71GJmxzrrCalJXAGNb0BFQ/1Cgf06iw9755Hgpac+Gvz5IqU7qb565fYldj0LB3PL7u8VVEtYwhHeXG2jKk4XzGiFW2SCuE4djmgluVnc6EdzP2LlrcIolVPGKxC4IRPfv3UFmObePeO/buHkmbdh+bBv6WUNZBQtAlOeltqJMAWuzvBs7EZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rd3HIM5WyL6SNThkdGueerfKvyKQ76+KUnD7777t0BE=;
 b=09Fp62vzEN3WOhYUn+B9ghByBi/8V4hKMVS6U9lemX2PAB2h3vFsAww4osAawFrm2OemyOXjGgLJp71p1hWIBOET9bdCrrcETfcgfvVveJQuMHb46+C/evw322Qi0djiHgk7UjfnAnebBbCaK0JTOBGFt4GSCdyJ5PhPmx9Nm0YgAGvt+SkK0S/QuXNkWkuL9sRFvQVo2qU0M0zgRQmQOQmXK4mVU4cJ+DQG43ujn7eLOfXGy5PFGPDfSBAjEEwGAlImhCRGshcTFFpxw9zUq8igRz2/08ofbSRg7s4P5ol2D3JqTQTqgRIAwfSVatSBEZEjig079M1HoDyYRuG7AQ==
Received: from PS1PR01CA0022.apcprd01.prod.exchangelabs.com
 (2603:1096:300:75::34) by TYSPR04MB7637.apcprd04.prod.outlook.com
 (2603:1096:405:38::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.33; Tue, 12 Mar
 2024 06:17:13 +0000
Received: from HK3PEPF00000220.apcprd03.prod.outlook.com
 (2603:1096:300:75:cafe::ed) by PS1PR01CA0022.outlook.office365.com
 (2603:1096:300:75::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35 via Frontend
 Transport; Tue, 12 Mar 2024 06:17:12 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF00000220.mail.protection.outlook.com (10.167.8.42) with Microsoft SMTP
 Server id 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024 06:17:12
 +0000
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
Subject: [PATCH v6 22/22] ARM: dts: aspeed: yosemite4: Revise i2c duty-cycle
Date: Tue, 12 Mar 2024 14:15:54 +0800
Message-Id: <20240312061556.496605-23-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240312061556.496605-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240312061556.496605-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF00000220:EE_|TYSPR04MB7637:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 417a07e1-91c3-4b54-8de9-08dc425c0e84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aJDAGWvgIafchb9IisdcirFuUVga15rQijMjQYWnQStNjWvDQ3adJ50CcgA8IdIbC1D5yUYzc04b29HBlR4MRZE277/2eJrcdysolkMjPl1+E82AMH/gLYcNnqXvpCr/mA4ByvrwPa59YHKYfi1MB2ahfh5xEpTZUjWRM6w9CEXjkxqWHRp6T2vAquohwcQX2WHIFUrzdY9ydBU5rBFoTW/uDaAba/0KIAXuNeEWmIU91/RXWogA6oyqPTo5lVkq6mXpyQwefRMNfH1qAapcVDO3Fhp/ojZXoZQDrbHwWelqtm3qJEM3fWL7CYGKERvtHVUehQht/8/4zTr28H8Cc3B7sigwH7raZNuPdU9TruDN/DmHjEiJbgO4S55EgboEsUFnV9lTu19org7KIBFjjbmD6TArvFEBsGkVBTz6y1GrCnVIppJQLkAwg5VDe08UZG3BDe/GAkOJiC8YV/b72MF5Rcmuf+un7osVEgm6f+LOOvw6dvsKaIZNN1lb7zJ6ekoYYrXEb26tRIp46Cr7PIEtvLHgM1jBb2Z8RZ5msh0lIxCAQH6sMRpoWq9udmBquviOQO4kC3jXkkOmv/oIfoJ3i14zthXLtfxbq5h/A7xKQolfZUY2Ur0zbgMdvwiF8QH0q5yE0jNnwQoGEnJLm/10ZUSUX7OL2vGLdxuGUAL+izhy2vo23xsJ/4CCgwY82wBJKxq0ixIxrvPMWRVHriFm7UnTVSEW4PUp0oU0Bkxm82czb1QP9I2pvfFM5Ggm
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(36860700004)(376005)(7416005)(1800799015)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 06:17:12.5104
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 417a07e1-91c3-4b54-8de9-08dc425c0e84
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF00000220.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR04MB7637

Revise duty cycle SMB11 and SMB16 to high: 40%, low: 60%,
to meet 400kHz-i2c clock low time spec (> 1.3 us) from EE request

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index c2d184b21567..c86e4a5397c4 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -761,6 +761,7 @@ eeprom@54 {
 &i2c10 {
 	status = "okay";
 	bus-frequency = <400000>;
+	i2c-clk-high-min-percent = <40>;
 	i2c-mux@74 {
 		compatible = "nxp,pca9544";
 		i2c-mux-idle-disconnect;
@@ -1306,6 +1307,7 @@ &i2c15 {
 	mctp-controller;
 	multi-master;
 	bus-frequency = <400000>;
+	i2c-clk-high-min-percent = <40>;
 
 	mctp@10 {
 		compatible = "mctp-i2c-controller";
-- 
2.25.1


