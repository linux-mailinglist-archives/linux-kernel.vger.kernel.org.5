Return-Path: <linux-kernel+bounces-145843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EEB8A5BB5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B0311C20BAB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E987161302;
	Mon, 15 Apr 2024 19:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GFS2yy/T"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2083.outbound.protection.outlook.com [40.107.105.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACB1160873;
	Mon, 15 Apr 2024 19:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713210454; cv=fail; b=s6qt6MPEns7Upy6h9nWluDgSgPROuI12AF8pr7wN/bYCKInUB9H/G8Cc5Wt4RSGIro26tIpzQoNj61UTh/g8OKuYosr+Ms6opx8IpvkbwFrQoLKoP1nLA9x/rQPVDBmNcQlHE5T94Q6HeZop37bS0pc1CrdZ0xjoLVC8RQAItUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713210454; c=relaxed/simple;
	bh=0ZRbRQcNzLlc5p8hNyg69kRtTQG09ucYbKiY+xtKRF8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=asfbg2n/ycF86XTLtDorQBAkxQaFiXumGMEp5ZbV4Iq/GFLM1itamCb49rISvsp12SNXXbK0EnOkAQFdYLARwSSt7ZR72gcRyiu481xN9XJgqlNHHNpIDXoDbJALRT/BdFTa+Blpnq6Pq0eOpUrfjCOu7IIAGZPnZZrbFGsi96g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=GFS2yy/T; arc=fail smtp.client-ip=40.107.105.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D8H9UL4/HDdfEBDsvpN1Q1j0hTQlC3CXzaBe/QPCrxlY8bKYOlZ9GloubkAKyMUwsS2vA2narP4HNidYjb6iBFhfR0zxMIvf2kvtKYxItaFuCr1Sg+g5W727F87BdGb5aZKiMLPWbTRUEat2CnebwAlUiG64MutOs7s3/pkO/dGFHxIQ+kPmc2p4f8CHYb3pA6LIM+k9uKTi8wmrhdWrX2pLuPhGlNnN0aMflgdVh+yDV3pS9R1ZPU/B4aBRVVr7hf+e40iHb8GPMvaccigGct3gAXnv3lKvhLKmNr+3aPu6Gm8mtKgGiA5gT8xzkSc3F0km39dB0uBOUasQnTm2fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GtMTD/4S3J402A4i3R4PGR6JLD2G4mFmwxoe0/4aREc=;
 b=CIA6YBPaiIZCliM9XlFk3vSYStFnAuC7qMeA/W1/isFcQqHqDkXkfQJqqzfNmDD+2xKbcYWaU+1yh/fTWr9zAqvzQH0ItvkJVJFsgKBYNC37TglSxmpPJwHd3dR4xd/gIT/8ZjrEInokdN4n4LZFzohN6+voa0B9uvDE/UJpbu3AGGUvRW1NdhLn5HedO8q/3JAAln9FBptevbCyRUvv8ak/R+cbeO8IXvyytdp42/asZriBn/9/Etu5RjSgE933c8lleMOPQxLmw5UVNO9knptoK5ADGgLn+O/ezPKdLGhlqT+G5C+R6pjcvhcd7v5DoBYEpfuyYIgkFON3dEizYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GtMTD/4S3J402A4i3R4PGR6JLD2G4mFmwxoe0/4aREc=;
 b=GFS2yy/TMVZKQmFVFulHAOkFTQA2e2baXjLt2SgDZUp9pbnpo3I73jHCfi7ctSl3pXEivgqASFnk2aEf1T9lsTdpTAE8KChCO3FpFhsy4Tt/cad3zzG98OBF4wz8D74ymYc8CnrsWXJotEPyayw+ahwjbRpt8FJBdXkc7bi4Kbo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VE1PR04MB7328.eurprd04.prod.outlook.com (2603:10a6:800:1a5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 19:47:30 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 19:47:30 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 15 Apr 2024 15:46:45 -0400
Subject: [PATCH 09/10] arm64: dts: imx8qm: add ocopt and fec_mac[0,1]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240415-dts_8qm_audio-v1-9-2976c35a0c52@nxp.com>
References: <20240415-dts_8qm_audio-v1-0-2976c35a0c52@nxp.com>
In-Reply-To: <20240415-dts_8qm_audio-v1-0-2976c35a0c52@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713210421; l=915;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=0ZRbRQcNzLlc5p8hNyg69kRtTQG09ucYbKiY+xtKRF8=;
 b=MtZ0Cnt1SwJBuzFhhtO0S96dFPyR4Z6IEoRay2AsWEM1vMNYVvRq8A0uRNE+J39CNrnIgPLAJ
 C27InkTuUB5D/Htaob27A+LvGuPDAABPzhXHopGeqc0rOSE/41DjHH1
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR05CA0061.namprd05.prod.outlook.com
 (2603:10b6:a03:74::38) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VE1PR04MB7328:EE_
X-MS-Office365-Filtering-Correlation-Id: 35f31911-73bb-4d46-2239-08dc5d84e317
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fYGbl7rElJ/2N4O2r7Iohx6cQ8fhf62yL8T6xuNDYSRCQhUShjitmOaVNB+x5itQRvZQd126lH4iPVswJaSi0PuJutBvdP0pdYQ6HVzR/TdA4GA9IYpwWJLZY24gsqGxFw+inj3vUxmpNHlIkrYL/9UsLqGkSZ10ZHzrVJZG0NiN9TN1UfcGE8yfBOkkH86m98d+uFN22uS6OQObwX2iKDMAi/aTWp7hAta4JdkASJNHNxkkCaybPBM5qLqT/Xy/Sve/E1ywtYjxrNZLgkchxck2vMOFOF3P6onkQvmBqbW6lPjBHZsGgCwiWIt4ShDmZUpuGiVVSo8duoIZXrZq2PC6YgOKu+hka3Pm6+JYevmgucuOZ8M8G+1fV/t3+y2IsiVwwGxdQQdzo2eFHsV2OEW+bvUHZQhN3dpKL5ZkvoYemAiKyXz4U9Js0thu1LzvRExb6LroHciLDAW7GsWyrCuTy79xRa8X9HX4JPd8zhxMkwhsZQfeXGQ6XWXH7AbPtVh5Sj6DxXqMkrzvBN24pjrNewMm/Np1+lRWNfHjsfNAuxTlzWUF1BzqdkKmxspNzZbEm9QLZ36fpeN57kOjuKUlJ9vMMaMpt6DHtBb/3/OeckIkI2r+7me/Zqgv8P0uLv3oJl3mMRyFtkBolCI5UPhyM7PJm5J5X9lhmKNNSDnwvPsq7xU6m59y1bao7Ouu+vsKVIybHLHJmkgVUpTHbw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(52116005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WnVFdEtwbDBzdzhmVmxrdlhBaFZ4UUV3cFo5V0ZJamtIbFpLL2xWTEM0b0pp?=
 =?utf-8?B?SHZqeTRsVUxaRFNZa0txODU0MVlGSkgrVk5Oa3FVYVdXYzZhVmlaM1BDSjY4?=
 =?utf-8?B?SVlxL29yMm9CUDhpUWtwbXIwZVhRKzg3TDIwcjJxODF1OEVINGJ1ZUNuNUV3?=
 =?utf-8?B?UlNhbHZzZDh0bVdBdXZCYmljTHBmdXFYVk5MNFRhU3ZZOURtTFBjdWF4TVVr?=
 =?utf-8?B?bzJ4V2pEckFjWGNxUDdCV3pETmtJWENacmsxNkxKTUFzdCs5S29QQlJJLzhK?=
 =?utf-8?B?UEhGSVduck14QThRemhrS2JZYnJ3VjByb0R3MG9RNlJPbXR2aW5CRVBaQnRp?=
 =?utf-8?B?MUxGd2pkU3Y3M0tod0srejF4UEt3QkNzV1pzbjMzWUdWRlZvLzV1cy9JTGNy?=
 =?utf-8?B?QzJLTU0xYjRFWlBUY3h6Ui9ucmJ2NE8rZkRLL0l2VzluRERMdStOWkhaSDJj?=
 =?utf-8?B?RlNLajQzRUltMVBLWk4wWDdGRDhYMTcyTWpDVVNKVFRvdTYzc2lCcHNxWWtR?=
 =?utf-8?B?aVlKa0pZVnFXWHJxTURBOGZLV3p1R21YRHJ5ZVUrOVdTSWRFbHM5UzRDUkw2?=
 =?utf-8?B?elFzSlEyR1dERVJTRVZnL1dIbFN4eWh3dXdkQzhyNFFzMlpyL1lqaFh4bzdM?=
 =?utf-8?B?eW4rdS9HUFdaTTh6TC80SzVpbEdKWkhQNjh3bHhZM2VndHlpSVg0UDJ3Ylor?=
 =?utf-8?B?aUhOZkVNUStQakxUYWNZNTNrY2R4ZVYzV1ViMDdlSFA2UlZKR3E4STJVNTNU?=
 =?utf-8?B?L2tsMEJWb0NrUHd3ZDRKU0QyR2ZiU0ErZFA3QllLQXpxYWY0Q3ZvakJoSDVZ?=
 =?utf-8?B?ZXNsSGFjSlI4QVRyTHp1ZU43STlCejk5ZlN6Q2VJbzEyNWE1enowWDVXam9O?=
 =?utf-8?B?MERJaFVXc3I1ZFNJQytWOElxM0ExcGJPRVpQaXpQV2NlK1BUY1FrS25CKzJr?=
 =?utf-8?B?ZHpkbW5xRlltdEZReUxaRWNiUWtpMlZuL1JZaHUwcGhZUG1vQ1JZaDhYbWFZ?=
 =?utf-8?B?S0JzSVpDZ1kxRnJ4NWU2S25IUXVwbEFmeG9hUmZzMUl4VVBjZkp5Q01ORmpD?=
 =?utf-8?B?MTFibklEVlRiQkZHdGpNcE9VTHhMODBiRnc0Ykp0eFdpRHFtSXBzMSs0QzV1?=
 =?utf-8?B?S241WHd4cC94VnhXdy9MSzYyY1ZzYzRJd3BVMFd6RW11eHBRTVZqMFRPZmlj?=
 =?utf-8?B?VCtKRjBmRW04Q2FxRE9vbzQxTWdMazc5SW1IQi9Scm9NRE9TR2pMOUdNQWxz?=
 =?utf-8?B?eU40VDBsTjBCZDkyVjB0Y1dRQ3pIb0VPQldyK3o3TWJGWEkyNmp1ZFhNQm5O?=
 =?utf-8?B?Ty96Y2lBS2ZLV0ZxNE4yN0VQaDgwaTZrMkV4bENwYlBWdzl2clM0a1A1dEln?=
 =?utf-8?B?SjcxSnQycVNJb0wwd0NKSlhkT3JTdlNESFRYYlNVVlU3UHlHME9jOFg4Y0E4?=
 =?utf-8?B?Z3V3NVkycUozV29zWGhNZmdLMmhWdXVBcmsyUjhLbzdBYUt6NWl4ZDFKMHNO?=
 =?utf-8?B?cDduby9pSk9EU2tXMEFQR0JxN3ErT25pMWxvK0VSWFJoa2RCSWkwbEZmK2px?=
 =?utf-8?B?K0RUcnpzS08xOVFOVGM3dE5IdkY3ODJUVXJEa0Q5UGNMOHZKaERjUjc3L3RB?=
 =?utf-8?B?QThWNytRRkFLdTFncUdlOUFLcWEwMHErdHNwczhvRnlKQWNJL0JIcWRaMzZs?=
 =?utf-8?B?amprYzBKL2wrUDZuUzd5bHZsanpaV1dZT0lGWjZlMTRtU05jTmNocExYWU1H?=
 =?utf-8?B?TTB0bUpNenJ6blhHNXlYN1VzRTdWbjZ2MEhxWFRMbjg2c0VDbVc2aEFOZ1pB?=
 =?utf-8?B?Ykk1cnFXR1UzNXNwd2NIUkliZ24wNVlpdTZLSk9MbHBqcjMxMlUvRFlpLzZD?=
 =?utf-8?B?ZFZsN0pYMjNFMTBKWVF2RkdPM0d3U0cwaVJYM1NMZXBENjNJZzk3T29DMmw4?=
 =?utf-8?B?S0MwTzM2WXZJaFFSN3hQcW84RE9ZU0ZTYkQxTCt5cDZTMXk2REFBK1FUd3J3?=
 =?utf-8?B?WEVKNExpNVZMdElXZVhrblp4dllWUWxNQnVrUmFtcmVIdjE5dVVOMDFhc3Bu?=
 =?utf-8?B?eVNuSDhlU21zaEpqaTBTNkNmMTBWQWJBSnBnMUl5U2Q3UUZVZTJNVUFvcWlH?=
 =?utf-8?Q?n3L1k0H8m22XW4omTLPQnB/CI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35f31911-73bb-4d46-2239-08dc5d84e317
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 19:47:30.7795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hA1aBtXbZx/bR0fC4eA1kcmYiTn+ma6nbmUBZozGPKa01OAFDboFnhxBHTsl8OwMwFAI5G03nEft3I156Qi2pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7328

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


