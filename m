Return-Path: <linux-kernel+bounces-46049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6618439BB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B201B28F99
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25AB128388;
	Wed, 31 Jan 2024 08:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="MpZEh1/E"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2063.outbound.protection.outlook.com [40.107.255.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50A21272BB;
	Wed, 31 Jan 2024 08:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706690575; cv=fail; b=hvFYoeI0aHVneLq/gbkUJIeDeu2WjDblSZVUZ0gZKHbQjVdblwbVLewqBcRVxPu1XnrGxCFma4Ce+Fr29VRYapz+5duEpLN/6Q/R2rqVz82H8qV9t4niIVYvy880mHaNX0lGUudBeNDfPrDeaY8qSelBi5YEkmDZxm8wGZczWvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706690575; c=relaxed/simple;
	bh=LbXFfDWLKoQqpbwqVrnkJqB+oR8szOqYLY2bEKR171E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r6LQR1B8Na8RUhFfm2CLSX7hraR0a0XAs79PPgXgX+xbpfu034aHI9cbeaCvsQKZy7/z4pHZfCsbS3dmkwmf299YRmbs4c3n5Q+33WaMwyjbwo+6e+ypTbWoHfDToR4oecqnGJylEKRuQDq9p6hbrHYf3HFXueneYhgaVBh+XMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=MpZEh1/E; arc=fail smtp.client-ip=40.107.255.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WYbpnJLI+mkV8/fJNzpPs6LHlNX92hLRATdPG+dpZ3yYMoZYisJ5bEKINz5Mdt+0G9vdlWLp5FzdiIbtZdsmqseTQ84OKyDcr6CVAPqfEVNTT7kxz0MeeTNjKKvxzWjJj+ET+YNZ7NZqT8qNqgYZAh1mL12Q0u0JcDyRtBfSp6nwPYlVyvt+bB9ntHBmzOEnX0yuqp69SuzLdHKV7gr0QhdTAorZMkRE6En8Px92nV+l44JsXIjYtwhU8wp7Gxsk+hVh7MAZcOMr1sw/po2oJezO4SL1OUnFegaIYUgD7dlVG2UVPjSebcUfHaOUY73+oCC4Nt0DYPBjP87gQ9Dbpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A7TGzZaT4IGiRau+OMtguKj9VNC7x7C8nzhapjKeiOk=;
 b=X15OxKohVdn+Nik2ipzE3hlIxxRR6HXpiMci1j01XGKnGVYuRY5q5WSsaxyB0KKw0ujXreBLtjMJZx7tN/o4iouHinBLUwJE6UYXk+10Z7gSeupgjb6nZoHW1pMpdhfUgTG1wVqjED5OJqXlCqE6XbW89WULR+AgWjAkm5OCn535wkiVFLSz/4wPgi0PzTj5C1GT7Vi3wD3YeqCUGJeJPILjaIe/7PeGof0uLWo1/hoCdqkiBzrhfDqf0WVxTKiuDxRrbLIJasZkFLqnH6NRzZfcrA86Xt0VL2y2J6p5HIdc4fengYGIymZVlM0o3+64DfiZtJnM2hyShEgumDvEoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A7TGzZaT4IGiRau+OMtguKj9VNC7x7C8nzhapjKeiOk=;
 b=MpZEh1/EsvpyzpFO0l2lLaIolF/eIR6MnLzY8obEN3M1H3Azo7PHWQfQuHqhnpxhuX+vsn7rrhKhGNKWIbVqWbgf3FlZL7NNXFmes0OBhCXvtfD7IhpXg4aiRMAsbOt8FRObucS36LerCvuruvz3zGTfEjGBRiqjAb1t8ZRAh4ETYOIsCS8YafKomQcNu4ePjJv4zSGymxVCNgtHiG9oQf63ucu8z5jcpttO54nEsUjrdKdhw0iJxt73o7Ak68MyBeVoKHgVULe/f53DIIbNBdmzkOHp6AyDKonUn5kDsICgNYi41bqDjvP7G3PV40EiIrMhspbhZdMzylUXIhZyCA==
Received: from SG2P153CA0030.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::17) by
 KL1PR04MB7435.apcprd04.prod.outlook.com (2603:1096:820:f4::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.34; Wed, 31 Jan 2024 08:42:49 +0000
Received: from HK2PEPF00006FB2.apcprd02.prod.outlook.com
 (2603:1096:4:c7:cafe::6f) by SG2P153CA0030.outlook.office365.com
 (2603:1096:4:c7::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.8 via Frontend
 Transport; Wed, 31 Jan 2024 08:42:49 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB2.mail.protection.outlook.com (10.167.8.8) with Microsoft SMTP
 Server id 15.20.7228.16 via Frontend Transport; Wed, 31 Jan 2024 08:42:48
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
Subject: [PATCH v5 17/21] ARM: dts: aspeed: yosemite4: Revise mx31790 fan tach config
Date: Wed, 31 Jan 2024 16:41:28 +0800
Message-Id: <20240131084134.328307-18-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240131084134.328307-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240131084134.328307-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB2:EE_|KL1PR04MB7435:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ffb33155-2ff2-4f13-ca72-08dc22389ae1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cZBovZBhA1NzE65fwUz8xfjs1+ydZH7g2PAsmZBiF72Xajz2VnskPkia8AvCQTKtbJX+EHlur/LFgDYVMVAtBNI7Gq+4oepM5vl7+eW4HHlLgdEggsKgCPFCzF/oR4eJjCqKt0WuxyW9UgJSQNCRWrBc4ZNgaQTPpeLJ/sH9NBskDPH4a68c+VuZNVtsMZan4rIYMEX/Ghe0gHcflkui0917sdi1jUt2osqYr1gr3c+hmjLJfzSPKWZEfv2T9RPn99UTlXqOqMbMXksFZ1HoRHU6jEWNzp7nlXSjaoT6FPfNo1AXTF6CA9LLMNqIEUtX93ngLgEPiHvcpjhToKN5Ed+5ZTskPmyXTjdxyf4KHHWetaJ9GGJ0SQEswUqReejQ2rfExpXLkX78deE6n8lILJXU4+pqnLBIp3Wwx9ATKIGAGuNsbipBI44UhLsWEHWbYNGbR5Z9DYP0LAzNStks3gPnrw/X2tqElksmi9wqh2nTXcuqnXe9KOZ2fdyEyRTYJm0QGqrHfLrGhwELbC39l7sVkzXnOWWbguIfzslFkvw+982s5MkDVBKq4eUPatCxODottE8MJTCs7kzSsjZNpeJsoUZX6OmOAj08aBXGGF2KiPtvzN5tKhge/xAOGsExzXA99Gn9xC+CtsZaW7dFhEyEe402LXvf4eTuoT6ouQyKDp7UU3tNyyQ4UiPuOAWv8AQeFjaYqFrON/aQNHnT3Q==
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(39860400002)(396003)(136003)(346002)(376002)(230922051799003)(64100799003)(82310400011)(186009)(451199024)(1800799012)(46966006)(36840700001)(70206006)(36860700001)(47076005)(36756003)(83380400001)(356005)(82740400003)(478600001)(86362001)(81166007)(41300700001)(70586007)(8676002)(6486002)(110136005)(36736006)(26005)(316002)(7416002)(2616005)(6666004)(6512007)(5660300002)(1076003)(6506007)(336012)(956004)(8936002)(4326008)(2906002)(40480700001)(9316004);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 08:42:48.0988
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffb33155-2ff2-4f13-ca72-08dc22389ae1
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB2.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB7435

Revise fan tach config for max31790 driver change

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 48 +++++++++++++++++--
 1 file changed, 44 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index bce739f2a081..7c7c9e85bb92 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -1095,8 +1095,18 @@ adc@1f {
 
 			pwm@20{
 				compatible = "maxim,max31790";
-				pwm-as-tach = <4 5>;
+				#address-cells = <1>;
+				#size-cells = <0>;
 				reg = <0x20>;
+				channel@4 {
+					reg = <4>;
+					sensor-type = "TACH";
+				};
+
+				channel@5 {
+					reg = <5>;
+					sensor-type = "TACH";
+				};
 			};
 
 			gpio@22{
@@ -1108,8 +1118,18 @@ gpio@22{
 
 			pwm@2f{
 				compatible = "maxim,max31790";
-				pwm-as-tach = <4 5>;
+				#address-cells = <1>;
+				#size-cells = <0>;
 				reg = <0x2f>;
+				channel@4 {
+					reg = <4>;
+					sensor-type = "TACH";
+				};
+
+				channel@5 {
+					reg = <5>;
+					sensor-type = "TACH";
+				};
 			};
 
 			adc@33 {
@@ -1145,8 +1165,18 @@ adc@1f {
 
 			pwm@20{
 				compatible = "maxim,max31790";
-				pwm-as-tach = <4 5>;
+				#address-cells = <1>;
+				#size-cells = <0>;
 				reg = <0x20>;
+				channel@4 {
+					reg = <4>;
+					sensor-type = "TACH";
+				};
+
+				channel@5 {
+					reg = <5>;
+					sensor-type = "TACH";
+				};
 			};
 
 			gpio@22{
@@ -1158,8 +1188,18 @@ gpio@22{
 
 			pwm@2f{
 				compatible = "maxim,max31790";
-				pwm-as-tach = <4 5>;
+				#address-cells = <1>;
+				#size-cells = <0>;
 				reg = <0x2f>;
+				channel@4 {
+					reg = <4>;
+					sensor-type = "TACH";
+				};
+
+				channel@5 {
+					reg = <5>;
+					sensor-type = "TACH";
+				};
 			};
 
 			adc@33 {
-- 
2.25.1


