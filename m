Return-Path: <linux-kernel+bounces-150509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B44238AA046
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D925B2179F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E8E17AD84;
	Thu, 18 Apr 2024 16:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QVBgA42/"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2046.outbound.protection.outlook.com [40.107.21.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBA517AD87;
	Thu, 18 Apr 2024 16:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713458247; cv=fail; b=SY04BJHbfXOxQ0kbuoUugc8pb/F3QsX/rdF99zeV94wUe9CiKu7n8ktxGay/Amhfl3M7exgaCOintfXMaFhVbpLkhf9m/WMnrO2wW/f2mxcUn6ZssndUjWoM9HMeeYojgESS++eI1leO3Y15Y+UCJZ3oUejJA1LewBEPngpdBSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713458247; c=relaxed/simple;
	bh=0ZRbRQcNzLlc5p8hNyg69kRtTQG09ucYbKiY+xtKRF8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=WoBmURdbfRlzgB0T4xZbTjSXc8s2mtl7fYYKmcUtNhDBAZHNhO3a42s4zIHQNB74FYf5jlc2ysan7zKzeNH9tNtabQPZPTdBC0olKLJ2bFNvBwCTjszVL4rZNCHK/1bf9DRljDG6nMr+wsYqEVRzIJ8+W81cMLMcKKstzkyWDt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=QVBgA42/; arc=fail smtp.client-ip=40.107.21.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QxL4fD+j3yHkSvf+UCib+bRCSQLv4DoC363cKV+HoG4yVXLaoJB1ZI0OZv3U6SpguanfTJp9CXhNy+pdYB/CF8WeH2RZgboX0sWE0Ky7Hu0Ez89b4P6yi31uRKVkpCfm0C6sX8otrsWcQ/lWw5cNO8LagnnLei5sgVuQU+sHVy/Hailtswe8kAbeqVrqN3XhqlBiYG7VVNb82OxFiPltkP/3EzoA/vEnkSVQnTSncYWWkYR33x0vfCTNQtZHpxqM+KqJk4fGavWpTuk+ujsVdn3T6ePy32qSwBZUamtwBwL5SwOiuw3kfqvRMneYi/yYd79Cg1dlpL+J53I3kOUPQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GtMTD/4S3J402A4i3R4PGR6JLD2G4mFmwxoe0/4aREc=;
 b=Bnmk0lqAzRoGfJBbx4mpreDTcJgMkITZgqf4eBX//BwVZhZSWEhziFfIrTTCSCmyPdlhntlk9XeiFqq0gAvIkP+VjM+K+2Bl3EYor6YQsD/DwvcGl8bJsqRm95Ve1Y/4cvFS4q8GE5u5UQw8TDLViNLZnQMR5+gZ58P7x5RAASpSodWLylgdemnw9QuONhAxV6f6tfUMV/jYmp4TZIXS0jDfiu+mLkfgUzEXNrNBGSlkvMcCqfeGd6VLErhXupp+sMB/mKRh8xwcqxwiI9z+uOa33QlBTh4GauKDJkwfHWLB9Mu5HcK9LeP2i2VU21Deaa4AMUlOwVCsenWW9JJgvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GtMTD/4S3J402A4i3R4PGR6JLD2G4mFmwxoe0/4aREc=;
 b=QVBgA42/R7kdAbMuBsOx7d19OUOmn7TpS6SB+orWQ0KDWV+/SQvtDNRyhYFekGit56hPkTN0CKNDvnPqIXEIoR1JUGzk2kIqouA/LwaHtbig/gyhkkL5mR2MKC5lHrAkYF6Mfn4I7SUq00lOjPQKGifmrzlpQW8mzdx0hTjMA5M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8681.eurprd04.prod.outlook.com (2603:10a6:20b:43c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Thu, 18 Apr
 2024 16:37:23 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 16:37:23 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 18 Apr 2024 12:36:44 -0400
Subject: [PATCH v2 09/10] arm64: dts: imx8qm: add ocopt and fec_mac[0,1]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240418-dts_8qm_audio-v2-9-e40fe76b60a6@nxp.com>
References: <20240418-dts_8qm_audio-v2-0-e40fe76b60a6@nxp.com>
In-Reply-To: <20240418-dts_8qm_audio-v2-0-e40fe76b60a6@nxp.com>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713458209; l=915;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=0ZRbRQcNzLlc5p8hNyg69kRtTQG09ucYbKiY+xtKRF8=;
 b=hBlsGhWSEnc4UucJQGSBqyrJewsB4nL4nNF6hDf5mKLOXKuskjbT0W0PvGMh4TcIZ51CkT1Er
 kmi54+XxMPdAuaTN6iRRy2mWh3h18BRF0VNIJapnif+350JPHAfqiHl
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR05CA0045.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8681:EE_
X-MS-Office365-Filtering-Correlation-Id: 52cf0f1d-0947-4a24-6b12-08dc5fc5d2bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	73YkpyqZAmcDPBaVMLh/P+OhK+lwR1Qnr76tZ/DIQzkZW+M9LmufHqWuAgL1dRuvOv5HBLkGx/iONlKDavulgYNat54BYgLK7F64WU8arhUbVOCOxd6QHblI89qwQQ5LHa3IwZCEaUA4tAi7yHKpflNGCUFRsP0f2q7LhsE8zSvFcnkzeYPzlhsyprF4XIjjNHpZF2F9j4Mkff7J8N1BKd+REqM8WUfHbm1k2s8YuTNOauxIwj+Nnxd+oUVXNjvI2Myx2G5qjN3uI+jKXVldniN8eD99t2Eu8cM2EsaGQdXAPWmQkzVUTeWFmDv0kdk5NuzAnNnSVD7c90Ps5rZKrIn48qGBpQUw7LUJ6Yqc1zUpnnwLeveVutmlPN5AG0xuL7uTo008qGl9Qj1wFFKt9NBUJottIOsH3rktLFNjyfLix9ZmZr4EZnC09kjHHAdXHRuZRdwzEdPgQcOh80X77P1QU7TOLxFvQ7lrX4KA5fmP0yomG1FOXpPwaeNPw4MXYrkpuoJa+EJr+R7vkfs0HY79b69UtQMJP/ZY78M+Qqa0Qu6MrNbygj0r5IdM1hM8o75YtLTw+5Mk6o4e12reFk+327oanHa8rgr0N3doeQthmRpniQUiWdG52VFMgzVkZUbiCRbbaIYBgNj+GGgSvxC0Vxu8Z2n15L/8qA+2uEUBjJ1yH1MRp29R6ZeWhKeGzmmrZ6qAPsbbiM6h1mKstw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(52116005)(376005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?blhWV1RqYmxTVWJyYjdCSDB2UkoxT1I0d2pWK3FtSE5Dc3o5U2pzNzF2eCt5?=
 =?utf-8?B?OWFZN1UwSHNoR1ZxTFdvazduOTNUY0VGY21QeDFkOVBPbzdTVzV5VEE1MzhV?=
 =?utf-8?B?V0JoQU5DaHAwQ0dFWkduZ0dwcDVYVXo2TGtUZzkzclZuN1BxMnJ2QXM1dVE2?=
 =?utf-8?B?cUR3TURqOVM2d0N1NW8zSVJpdzNoQytiNE84aTVtbHdLcGhQQ2xrUDd6Qkow?=
 =?utf-8?B?L3hQV1lXQ2xMUTN1MGpvam1RVkJoOUlodUF1b3FzRjlncWMxSnRFRlg1OVdD?=
 =?utf-8?B?MHlYcDB5TThaY0l6cTA0TWx6SGNKSkRNUHF5WjZsdUJqbnBZWlJWQUJoMVA2?=
 =?utf-8?B?U0o4akZtUXBvSWFwL0YwZnpFNDFHVDNsQ1FtbjAwUWFIUUQvam5hMWxzSWwr?=
 =?utf-8?B?VGNVazd4VkRVQ2NhaVpsOEdJOVp1MkNVZ3hqNkNzSzJrRzQ3OExxalhzU0ZY?=
 =?utf-8?B?WG4zNzgvTWpkdXJlYmY2VFN5aEJDYlBzaVBDeEM3OUt1ZWRNZUpxc2hVV2JY?=
 =?utf-8?B?Y0lPd3dVbzFLb3dLdGgyTEt4Y0Zidy9wdUdONmEwcTRvbEE1VWZxbEpOUzMv?=
 =?utf-8?B?MFF2eWdxeGlDQ2I1ZUJ0dDByTFYvWGVFM1NSWTNrRW41djV3alpSVExsbTZW?=
 =?utf-8?B?ano2d0MwWGQ2Z2pidzc3a3NZSzlOcmJQT2Q2c0JLWFliQzBCV2d3cTdKQ2lS?=
 =?utf-8?B?Q0orcDlXcng5S1g1NHd1bXVseVB0cU1MRU1DQkdPVUJtNVRuanVTbjloLy9q?=
 =?utf-8?B?dVRrRDJzbGhrdUJkR3U5VFh5MTdxZmx3em9ROGhNOTlqR0tVVk43NDdmM2xC?=
 =?utf-8?B?ZGtwUnhFQnVrS2hmVlM3c25adEM0MHlHKzd4RnZBdCtzSnlmTDVaUGZaRmdU?=
 =?utf-8?B?ajZxZmZrL3hMakg5QUNweTEwZXcybm9BZ0tObkRpSmZ0M3RhZmRsNTRtS0tk?=
 =?utf-8?B?THZSOE4wa3N1alU3Z2hrQWdmcDFxcmYxS1dwWU1sd1hTakFEQXBhd0FpaWEy?=
 =?utf-8?B?Z3Z3NWdWaXBockYxWEdoVTdIY2Q2S2lMRk9kZEVmUUNSUzd0bEY5K0oySGRh?=
 =?utf-8?B?QXZvckd5bU4rOTRUZStJaFA5SG5Ka0tzdFJCN0Y0Uy9iYktLVGxPaFFHaERt?=
 =?utf-8?B?b3ozS1J1K3hvRGw1cmo3UXhHaGsybFpyRzBpMUZSaElsVmE1VFgvVjZHRTZV?=
 =?utf-8?B?NVJHZ3M2OTA1WnFoME5NTk9jYmtoRWVVaXp0dzFjRDA3V2dBWldRYkZQWEQ2?=
 =?utf-8?B?R05EWkJiMXhBbFI0Y0JmY3ExU1cxSFZSSHJyNzFqekZHT2Ywb0NOd2ZaVEI2?=
 =?utf-8?B?Mm1URVl2V0lwYnYyQzRsNWZReEMzbEJLTlpmek9ONXhoU09kVjdBcHAwUW9G?=
 =?utf-8?B?QWFyeWU3cjRzblZqLy9qM0w5MTNFQjBTeUxFNHFqRkFqc202ZWVNVjJQaVlI?=
 =?utf-8?B?bjNFMFNoa3VJWFNNTngwZVJISzhieVluTVRHQTZKakNMQm1ic2YxTWlNUUJO?=
 =?utf-8?B?eldkNFFPU0VyR29kRmlPbEVOQzNVTXFYNWkyeW1xalR1d2I2RE9NdHp4by9J?=
 =?utf-8?B?N3o5OUU1QmpNOUptUGZvN2dBY2tmUFZmdWE5SElUekExQmJZVUlxZldEUkNL?=
 =?utf-8?B?cnpBM3BmcW1iNWN3cFhXWlJlaFcvTXJXM0IwQ3loZUJQc2xkNVZWdGFVTGZt?=
 =?utf-8?B?bC9pWGJ1Sk03cXduL2grQnlvaDJnNytVTENhY3JxMWRqTXp2a0FwSUt4Njgx?=
 =?utf-8?B?bm5WNEhaanQ4T0tENXRqd05PaG56SVBsdXV4dWNaYWlTUVhpdXBteGJFQncw?=
 =?utf-8?B?ZkNVb2d0VnRlUk43Y3EycVcxSGg1Tkl1YWFBNUVwaUlhM2hqM1pHbE1mMnRl?=
 =?utf-8?B?cU5FeUFSSmdETnYyQ3ZmTU5Pa1dDcmhyK0RtSTRMNWJvekcrRDJocG1iR1dK?=
 =?utf-8?B?d3ltbm1aN2Q2OHhYL3BCSjB0OUpobzJHWTc2c1hUclhFYTlRVzdZT2dkaWs3?=
 =?utf-8?B?TytTcjJQemJXMXRuMTZMWmFsbFFlRDVYSXJ2NitPZkZyRjRWRi9lSDl5Q25q?=
 =?utf-8?B?T2IzS3lTS1lCU0xsZGtWVnYreHlLYXN3ZHdXbmkzL3RuRXFTblRGVm9UNU1j?=
 =?utf-8?Q?iaHhi/bl7MZYlYOF2ayfjxhjB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52cf0f1d-0947-4a24-6b12-08dc5fc5d2bd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 16:37:22.9459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QGaI8jPYUo9+i+xtBIUgL7VwzyHU330FssmAdOxSeG8793Yb7HpxquDXVmsIiqcljc4HQ4b38jgJV3paX+LVYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8681

add ocotp ad fec_mac[0,1] for imx8qm.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
index 96a940c6046d8..734bee4294dfe 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
@@ -333,6 +333,21 @@ rtc: rtc {
 			compatible = "fsl,imx8qxp-sc-rtc";
 		};
 
+		ocotp: ocotp {
+			compatible = "fsl,imx8qm-scu-ocotp";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			read-only;
+
+			fec_mac0: mac@1c4 {
+				reg = <0x1c4 6>;
+			};
+
+			fec_mac1: mac@1c6 {
+				reg = <0x1c6 6>;
+			};
+		};
+
 		tsens: thermal-sensor {
 			compatible = "fsl,imx8qxp-sc-thermal", "fsl,imx-sc-thermal";
 			#thermal-sensor-cells = <1>;

-- 
2.34.1


