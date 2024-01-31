Return-Path: <linux-kernel+bounces-47407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 125E2844D8D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C633928484B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41491810;
	Thu,  1 Feb 2024 00:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nuvoton.onmicrosoft.com header.i=@nuvoton.onmicrosoft.com header.b="NIeaCGe5"
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazrln10221004.outbound.protection.outlook.com [52.103.192.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87085374;
	Thu,  1 Feb 2024 00:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.192.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706745733; cv=fail; b=KtRPqNihwiN5ZnubUFLo0w2bX5y5t/6cnczB6wSHjgh8+rhCQJ9lge+i3Af0UdMWdp0xAt5FW1x+eoaukA4YTGdAi6xVaCrJi4mX2oOK+k/UULw8fp6I++2mMS0Pv5kzXJWc6YwKf4mqvAPcu4ostgDum/qVNGUYLlfk2HqESKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706745733; c=relaxed/simple;
	bh=twGOCv2sLL7PlJgLqKiOvz2g1h7SVcSt3Ya4Lc6Ax10=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cpCiSkr1+wxHAkU/VdCp6SLPI8uDl64OAFQwvYl0E7cTyHB/htWqebD6uxe87pN7eNXO5YZvlvCWuAKfWe5bt0KGfsA2UR+KoadcmxK6v/rHJ+NjTFvt+1BWJaDSJd1cLIfWf7CZB2pOV39sjeJMTDP9SJuQsu60rM9qli+1vIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=none smtp.mailfrom=taln60.nuvoton.co.il; dkim=pass (1024-bit key) header.d=nuvoton.onmicrosoft.com header.i=@nuvoton.onmicrosoft.com header.b=NIeaCGe5; arc=fail smtp.client-ip=52.103.192.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=taln60.nuvoton.co.il
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JqIQLZSxAaNlY3bcLoTOg/KRlIR0NKIt8+X2508j9m5rVBWO1aoTPpMenGbRX7DC8VU9kKIkEd2BAJFjpdlYbzWMKNSGwCvs+Kb80jyi8yqNszl110Pu+D4dJFQNnfGz8mlFv987ufM3QvavAM3s2iC1ZVV2IwsEDnb89LmsCmQDgPUNDkFVThKdN8t1KRHhgp0IDEGMw+Go9ulagjWw1su2+pCL/FXGrjQ6xUEEtc/pTK6YPDceIcEi5299FhM/fWVd2IommD5XMrBc7ZxCc0rOeyArgf/2P6mzmrOU0vu08S2Zw70IL5e72CyCP46pOuvCS5TjWv1Fq+kfmzUYZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CGiKXgSVTZNnrzUQUaNHk6vY2hRMV7LvlsQtcNhSu5Y=;
 b=DusZMQRGeMaEVobPwB6z5LhvWtFzW+h/Xxa1cazVcPRVqwblDll4z8riju7MTnenZOQC69035wMTwans7tTX0g7LiGloqGqr31fStf53gKq3u2e7KHB8wpOcz26ywMOrQ81xXzg3QlJDMahYDR8bsSdxRB90eKmR5so5RXBQKxkGX81YOxVieFMepbwURoBQI30roQfb1W1ccuT0/3NrCd9XAwUBqPomJxTMbf+ssLSRxjSOtM24rXyxGDQAik5x7wy2lNtwceul+AIyq4YD3QCRQluZy8/j4BWcSmljEguFkWoCwrW/P5O4sZRMhLOJqTYPQNr7zTtw/VXTjd9Ryg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 175.98.123.7) smtp.rcpttodomain=baylibre.com
 smtp.mailfrom=taln60.nuvoton.co.il; dmarc=fail (p=none sp=quarantine pct=100)
 action=none header.from=gmail.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CGiKXgSVTZNnrzUQUaNHk6vY2hRMV7LvlsQtcNhSu5Y=;
 b=NIeaCGe5BCi6GSxvCGSuG+KplCwp+q00r4iwE2SfVV5aqibcQtwqxpqKWx+sQyZ9K+DtEwlIUSexd393BSv17ZESBtM1ioBMn/THomlz/SNz/w/eFMso4D4LdtSpxKzZ/53Uk8I1l9Wx/yjlI4xE8dmi2L9MVAK6Ksb9KPTuXHc=
Received: from PU1PR06CA0011.apcprd06.prod.outlook.com (2603:1096:803:2a::23)
 by TYSPR03MB8591.apcprd03.prod.outlook.com (2603:1096:405:85::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23; Wed, 31 Jan
 2024 18:27:12 +0000
Received: from HK2PEPF00006FB0.apcprd02.prod.outlook.com
 (2603:1096:803:2a:cafe::e) by PU1PR06CA0011.outlook.office365.com
 (2603:1096:803:2a::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23 via Frontend
 Transport; Wed, 31 Jan 2024 18:27:12 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 175.98.123.7)
 smtp.mailfrom=taln60.nuvoton.co.il; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: None (protection.outlook.com: taln60.nuvoton.co.il does not
 designate permitted sender hosts)
Received: from NTHCCAS04.nuvoton.com (175.98.123.7) by
 HK2PEPF00006FB0.mail.protection.outlook.com (10.167.8.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.7181.14 via Frontend Transport; Wed, 31 Jan 2024 18:27:12 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.14; Thu, 1
 Feb 2024 02:27:08 +0800
Received: from taln58.nuvoton.co.il (10.191.1.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 1 Feb 2024 02:27:08 +0800
Received: from taln60.nuvoton.co.il (taln60 [10.191.1.180])
	by taln58.nuvoton.co.il (Postfix) with ESMTP id 5D5205F645;
	Wed, 31 Jan 2024 20:27:07 +0200 (IST)
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
	id 59985DC08DB; Wed, 31 Jan 2024 20:27:07 +0200 (IST)
From: Tomer Maimon <tmaimon77@gmail.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <tali.perry1@gmail.com>,
	<joel@jms.id.au>, <venture@google.com>, <yuenn@google.com>,
	<benjaminfair@google.com>
CC: <openbmc@lists.ozlabs.org>, <linux-clk@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, Tomer Maimon
	<tmaimon77@gmail.com>
Subject: [PATCH v23 2/3] arm64: dts: nuvoton: npcm8xx: add reference 25m clock
Date: Wed, 31 Jan 2024 20:26:52 +0200
Message-ID: <20240131182653.2673554-3-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240131182653.2673554-1-tmaimon77@gmail.com>
References: <20240131182653.2673554-1-tmaimon77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB0:EE_|TYSPR03MB8591:EE_
X-MS-Office365-Filtering-Correlation-Id: b515c7c7-1ccc-4933-c31b-08dc228a3e27
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HoNugubfSx0TpUptqrku93oZBHXoJ2faZ2BOcCIaoN3KVI8GMMGC09tvHt9dYIVsvRdh67/yMkBNCKRKR8qA+DHqcIBdCMUqKXZOvGyGDFG6RgpHRoIXwIv2X2LV4Kvj6QD4A+WgNMQTgmN8hdp0mX8kHd3uwQ4Z0y0gPcCuhjhl5u/O48roxPmrXWDExtJwQos9mWjBrIokaVF+kha2brHeVCA+UpLqUDfh+uUeBEvnE9dyh4YCDAoGIx62dkGng5yIiky8Ca3qA2gK6T2OCl2XoS5H+ByEI5bSzozjSp/KH4+rJzNWSDVX40T/5lJhEkS1NTCTDUBwEC1zpOjxqelpNYsMIbvivd2G8azlPfELzV0B+ZiOHrLLPjFP2DTpuC2ZqmvuOlppexuGSl0BVr7Sc3qH/aY/3+whXAHVVpVNcs0AbE9SKWPjNGGeN+u80+Q3ifs1eTIOmbmznVSF/qjTgVCDUaSrg5zwKiq/jXfhSNuEsLfkjfANsuMfXh0GGTb804q9Qq2mGjazStSo2lhvOsUk4GU21uVaMjFd7awN9qnVOzkKJOTfkFGK76CFDK4f7oeWV8xTG/DaSKzbZL+SjNFYkS+YGj/mck7V98PVBk0qfYJZnnBIWRt6V+trRUntX1DnNILeTiswY+PcPNe0I4HV+UCDvO2EgAfNoVKLevZFbdUUOwsbC0vTQZ8ILDF4+X8ohVIm/4IzzU1bzV5DhofVMy7Msd/DigyaeF93yOK1fXTdvG7WMqc7bRgm5EXWja5x0ZcRKm9V+gEomIeEtdOE74PM+6Xacjz6BYnfY1skcP0XjSOwqxriv3D9586EH9ywowD7Pm9iAaLPJQ==
X-Forefront-Antispam-Report:
	CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS04.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(39860400002)(136003)(376002)(230922051799003)(64100799003)(61400799012)(451199024)(82310400011)(48200799006)(46966006)(40470700004)(40480700001)(40460700003)(42186006)(83380400001)(73392003)(70586007)(316002)(6266002)(70206006)(54906003)(2906002)(5660300002)(7416002)(110136005)(8676002)(8936002)(4326008)(336012)(76482006)(42882007)(82202003)(2616005)(6666004)(1076003)(26005)(498600001)(47076005)(356005)(83170400001)(82740400003)(81166007)(35950700001)(36756003)(55446002)(41300700001)(45356006)(32563001)(35450700002);DIR:OUT;SFP:1022;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 18:27:12.2923
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b515c7c7-1ccc-4933-c31b-08dc228a3e27
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS04.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB0.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8591

Add 25Mhz reference clock that to the clock node since the reference
clock in not a part of Nuvoton BMC NPCM8XX SoC.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi | 2 ++
 arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dts     | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi b/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi
index ecd171b2feba..f10027c14e63 100644
--- a/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi
+++ b/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi
@@ -58,6 +58,8 @@ clk: clock-controller@f0801000 {
 			compatible = "nuvoton,npcm845-clk";
 			#clock-cells = <1>;
 			reg = <0x0 0xf0801000 0x0 0x1000>;
+			clocks = <&refclk>;
+			clock-names = "refclk";
 		};
 
 		apb {
diff --git a/arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dts b/arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dts
index a5ab2bc0f835..722a46d78d23 100644
--- a/arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dts
+++ b/arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dts
@@ -19,6 +19,12 @@ chosen {
 	memory {
 		reg = <0x0 0x0 0x0 0x40000000>;
 	};
+
+	refclk: refclk-25mhz {
+		compatible = "fixed-clock";
+		clock-frequency = <25000000>;
+		#clock-cells = <0>;
+	};
 };
 
 &serial0 {
-- 
2.34.1


