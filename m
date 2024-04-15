Return-Path: <linux-kernel+bounces-145830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 075BE8A5B94
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A1231C2218B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF0115D5BF;
	Mon, 15 Apr 2024 19:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RIeXLVgO"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2076.outbound.protection.outlook.com [40.107.105.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85835156F26;
	Mon, 15 Apr 2024 19:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713210428; cv=fail; b=TLC6S8AZKQiXDCRqH96TnOt91BY/hnUTnwmd04/NkuFbc/sp0xG5Z1Brzx9PVBqI9nsFxyfO6Bj7gbjhOUOpCHlvv7LRXT045vZxXa0u1k0VAcXk4V2nnHx6H6ABYDjTWWQwYVwJKnOtl4WtcNO74q7dGW00SF7a2KeuOPt1G1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713210428; c=relaxed/simple;
	bh=+IipXPW6lSaqT0I72bK6SmwJqrcGND1M+TbsT9IY9+A=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=bmLp/LGDekOkTFTiCaPY9Tx3NFiDmfOrGrBDyesW12Q13GxFhAjics1UqEvQhAoeRzt4/Xk+7nUUTisbfvnSHAUPRjIJe5rpAEMxM+M5dTKTuqLz5UCe68/P1S6tZJ2VnJy67C4uz+ZnimaS55hJGIEbGHrHs6vWIYjs1meTK6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=RIeXLVgO; arc=fail smtp.client-ip=40.107.105.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NMmNBRvGp7LBUFwCcUSRaOxtkDxYqIdeZhJEee2Wz8aZx7mHtaepBntvrYUEapcj7MLKrXyuCV7wdaHVUUJpEaDQV8tCI8UF6XhfnpcO4LAcK78/S8ZBH3gyDjWdNJR6J3oRicbqfn1Y+NmSN3nSv9UUy640O1qpuPpqEbspyWGobuCPjOAQkXfItZ+pkwIYFs36DrwsVCGH3mcfAV0Y5u6t4LfKqt7df0n+eKfTLz4UHk1kvHg2hxPVlWGSa1fsi+AzyDuSEZacRVLoLYOzygqKcyfK3YAx4i0vu110bhDjTkt1785/4FId15Y1oT0M7F2J3L6rcF3u36YBMSTotw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=em3FUi7vC390d3UByANmkxayyA0bRlbrRTmq/9hj7rU=;
 b=WRGbnR9TOlf6qQ+GLZCEZAX+jDsL6ALKvvCGIsNvdmqrIFLPjrer/2nkaOltnlgoGWZ6bNZTvTIDtMIUFsTWASG6z3K7WsAlJbQKTK9HeEq/rhI/YtYHggwa7RsUyPe8lPnsmWXMfIV/5y6NpriLH2M4TY5IYqUa3zQhwOnWAFDsyOmoaWn+nCxvAIrVcvo0ggykfz/zfzAFIBcIAnh5N6qUVCo48qK5YGhyoZpZSin57YfpRcaDPfTJeEkx6IwPVO1wB1TxswR92OPHrwoNeP0B96BV/WWu3AUq0ZlSVEwjXkVrIK5xHjlpF+G5T/2eVMWuo3TTi+KHjXjqz2h1pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=em3FUi7vC390d3UByANmkxayyA0bRlbrRTmq/9hj7rU=;
 b=RIeXLVgOUxt/R9m0EUJF4BpmZKCQXB7cH72yMDWYQq7QbWKpLM+EibDGE8qntWlaLF3qRfT8ocsSTomD2QZH8EzcOhPu8vo8f20FCc3fbWk0OgaCWlFhEhn3q4fH5aUn14Ma4L0qwCu1edbw153mFF6W7+2CPTbrRnolEzZqthE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7290.eurprd04.prod.outlook.com (2603:10a6:102:82::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 19:47:03 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 19:47:03 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 00/10] arm64: dts: imx8qm Add audio\flexcan\i2c\fec1 nodes
 for imx8qm-mek board
Date: Mon, 15 Apr 2024 15:46:36 -0400
Message-Id: <20240415-dts_8qm_audio-v1-0-2976c35a0c52@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB2EHWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDEwMj3ZSS4niLwtz4xNKUzHzdVMNUQzNL82TLpDQzJaCegqLUtMwKsHn
 RsbW1AAfc6MFfAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713210420; l=1309;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=+IipXPW6lSaqT0I72bK6SmwJqrcGND1M+TbsT9IY9+A=;
 b=RnRkn0mxjCHagwUN6r+WS9XcwQez1159N9kreDMFLUQcmaV12Apk1oy7Cq7Lgr4m0h7fHmItI
 EdZax4kVWbbDuYHH0i8QDSC3abVekKwHSlWhgaaBt2b5W/nbnJdWsAo
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PR3PR04MB7290:EE_
X-MS-Office365-Filtering-Correlation-Id: 71875dfd-4418-49c4-7123-08dc5d84d311
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qXvykxF3PDiy0+kmNIxee5cYCaTGayTWZxaR113e+TgjhB66g7EU7bivUe4blz4l4iEQTMWiqTzj4NNvhzeePkt4HIZM7Xv0YTuHd43G9apIx4UHqKfc9g3hPzpnS383fOCTb8ASKXGdbw9/eGqrDcJkTgftNV8KRJUFG1WGCHKcO89gynuap3ZZpYQycvU0Np3YQkmlI2D5x/xfWVITRaIxuGXEhJBY1y9hiLgjcJWW8heKg7kd1eOrFdwcI1ZW8hDDrjGACVgN+BiiUkXi3bI/Fyj4i43KLKp7n5ae8V2StlDrLRaAQsVOak6KkcBGQN3MFV7L8RDlxdZ4YyZ4dUdc9RQxDEpxoCdeJp/8e2GnFZWa/L+0GT1HhtnyrayJGZogyYVq8R4oNbumhgnNG/UNByN6RIDmPb6LIwQ3O4baw3HL/PPkhPlQRF4cvkRHIIYhqdzLGgdalJXu8cCTA6wsTEg5srXZrN8Ydh0FE2kgMTzRUbXYdbV3L9qBH25AVnS1eCYRMs4QHGEG1nPnthIG3vg+FprG27Ae2STXrc0l7o/22x7T+AfKBOExZWAKgIu490Ex2lRorIFiDKnUP3vXDplCCAp8G8kyyXSk+QtuI3yqN8TwERBAcRW4Y1oUBfp1I/87zBFrVegzS2WKgI/3WMPjDmdmnJWScZwy/Ii4CpNBUceek47yZIyEhJ4b0cmzcdqihfOaPy21VE/W9JIaxk1HV4TQW/J4UtVCcq8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(52116005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aExFdDBwRlBROTZIcEpaaGJ0eGVheG5KRFBscnpwSkxNMGZlMmQ3UGp5UDB0?=
 =?utf-8?B?TE5MSDhkZW9GTDNsbFYvdmlGWG10SGpUVDRhT2J1RHd2V2RkL3N5WnNaU042?=
 =?utf-8?B?VEpMQnlqSGFQK2xORGt5YTRkV1BUeDQ4Nll6c1JqYzNrOUtCZHpkZGErWitP?=
 =?utf-8?B?WHc3dWNSTWh4OWdocmZPNVc4dTBPeGt6MDJhKzFZa0FwbWhHelg5NU9PaHFX?=
 =?utf-8?B?VXNlNnplbzF3aUorbGhzNTJ0b0c4VWlkMExBQ1BXWlZYTWdIWDZRSWVIbkUx?=
 =?utf-8?B?NDVHTXF4Ny8velR2bWZ3RFhjRU1lYkFJWVZReW9abGRVeW9odFRKaGR5MEJM?=
 =?utf-8?B?VmU3ejdFUitFQUVSbTE0NUZqZHdaMlhNNEFJR3FTY01UcTZLUTQ3UXM0NmpL?=
 =?utf-8?B?Y0FCM3UyeWNXYnVYRTNzcy8xRWRtRzRqamNoS2RRVGxvWElaYmJVYk5QRWRP?=
 =?utf-8?B?VUVEbEhxQllSNXJ2Mlpubm1jT2RUWVVUOUtoeUlSLzJIRFU5eURoK1ZISU92?=
 =?utf-8?B?YnVQcXA1NTV4SUdub3VoOWViZjlHeHB5cjFaVEEzUkx6aUJWZCt4YkVTWE1D?=
 =?utf-8?B?MWhkbUVHS0J3cG90M1BFZ0ZnMTZiaGdxbFJEQTBzei83aE93YTFoSVFDOEtQ?=
 =?utf-8?B?RE01eVd4M3ZRb0xJRGV2bEpmT0xuQjdXZHgxeXpXQ2dhVjJUcWY1VmtqSkxR?=
 =?utf-8?B?ak9PblhpV1ZoMVRWUk1HTDhpMW15cDRIZi9wTGNFelJzcjlqZVBOcnZxWDFk?=
 =?utf-8?B?T3BvNEIrV1BFV2RtZCtZcmFqUGh3a2RMMUNqbXlhSWF4Sks4TnEwQ2ZWUWpO?=
 =?utf-8?B?eG9Jamp5ZmMyTnhOQmtEei9GQm42MXJqZnVBcjZSNlg3ZDBCR3BYRWN1THNr?=
 =?utf-8?B?TlYrYTVqdVNWMmplc1ZNNVp5NjNGMzhBR1YxVzRCRWJ0SkVmNUlWRFRCT0Nn?=
 =?utf-8?B?dU4vTkoyZHlzZEdmNEI1RjRWY1pReEczdkx4UndVeVBKNVJod1hqcUxReXho?=
 =?utf-8?B?WHBSL0VCWlE5TzU4REp0YXVzbWZqRXVyai9PZUY4ZVdGRTN1WWZocHRjR01X?=
 =?utf-8?B?UFJZaDhmOXlNYWtBaHRLUjBiekxKdExBK2owL0hsVzAyNVp6cXN4OVVjdEgr?=
 =?utf-8?B?MVdiR2xPVGFBK1d0bEtLVnZlSEVWREVOSmJLSVRBYXMzS3FsSWZ0RXJVUkJN?=
 =?utf-8?B?ejdqd2ExaTNBWVZEWU1ZYWtOdTlLOG9YQjFqa0dNMWtvT1MyUk5JTXpiYjZ5?=
 =?utf-8?B?bXZYT1F4UEVxL2VCd3N3Y1RkMHR0QjVIVTBVN1Z1ZUZMM1BSb3d6Q2hvWU1G?=
 =?utf-8?B?UUZCbzRqVFhVdWVQa0tBNkxsSEhWbmx2OWJGYTNQK0t3QVluMFR6SWkyaUpE?=
 =?utf-8?B?YjlleGdQZ01BL1BsbnR4VjNhRFpsZXhjbERTN0lYcEZlS0NQMWhkYW1CTU9N?=
 =?utf-8?B?VE9haEd2b3cxL2NxL28xMFQ0V1FCa1VOcmNNRE5BM1NUZXVidVJFSkJpcmRj?=
 =?utf-8?B?TXRNSDdRaEFkc0F2MkFaakRHendXSExKTGRjOWNZZGdreEZncjd3WU5PbFpj?=
 =?utf-8?B?OE5sUXFNVy9QK2s4QWlCdmM5dUswTjIyQ0lKRXVhRW11STU0dVZmeGF2U1Zl?=
 =?utf-8?B?am4zMW93MjdLakVlaTI3b1VMdzNsN3UzdURzZEZsU3pTRFBGcEZ0aWxhNWFq?=
 =?utf-8?B?NHpmaUVPaTVTVGtUcWJSSHF3bW1LSUVGN2FCcGgyT2dWMzlFTUFwY1Uramdi?=
 =?utf-8?B?NjhheVNrYU03NTlMTFhKK2RpQVRuOUhwRCtIMmlvQXArQ29DZEI3ZUhDcnVn?=
 =?utf-8?B?N2tPdUVuTGNXR2FtY1F6Qm9oRzZma1ZsMGIyZjhjYmt5NTlHc0FyNHE3VlQy?=
 =?utf-8?B?TlgvK2k5RnJwcklJRmhqbFVsaGJ6WTA3QlBMTCtJVVk1aDNlZ1pTWVBJcTlY?=
 =?utf-8?B?MjcxZFlCMzVyc3MvVVhpZWtxem9OV1dFeUh3ek5KRjJNYloyODFyRjhrQnlY?=
 =?utf-8?B?dEg3Rkl1ejRQVmxTWDRFYkN2RlVFQ0YvMG1BUUJBeUhGeGZSYndpMlJFRjFR?=
 =?utf-8?B?cE5yM1NIbkIvenkwREo2RHdSeTd0N1JUYTdzcm9wTlJmMkx0MzdJanBlVnZ4?=
 =?utf-8?Q?TiFad8xyH5g7QyPK64CD2X1rg?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71875dfd-4418-49c4-7123-08dc5d84d311
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 19:47:03.8703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mHcsvuDbZNzb4/pIXJmWTG+RfuIlDf4WImVvnHNz0h/TwIAVYvqttbpTJMGlu7hABJcFvQRuZ/9L7qhHwbMyRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7290

No new warning added by 
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8  CHECK_DTBS=y freescale/imx8qm-mek.dtb

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (10):
      arm64: dts: imx8-ss-audio: remove memory-region = <&dsp_reserved>;
      arm64: dts: imx8qm-ss-audio: add audio nodes
      arm64: dts: imx8qm-mek: add sai and wm8960 support
      arm64: dts: imx8x: add cm41 subsystem dtsi
      arm64: dts: imx8qm-mek: add i2c0 and children devices
      arm64: dts: imx8qm-mek: add cm41_i2c and children devices
      arm64: dts: imx8qm-mek: add flexcan support
      arm64: dts: imx8qm-mek: add lsio mu5 and mu6
      arm64: dts: imx8qm: add ocopt and fec_mac[0,1]
      arm64: dts: imx8qm-mek: add fec2 support

 arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi   |   1 -
 arch/arm64/boot/dts/freescale/imx8-ss-cm41.dtsi    |  68 +++
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts       | 345 +++++++++++++++
 arch/arm64/boot/dts/freescale/imx8qm-ss-audio.dtsi | 473 +++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8qm.dtsi          | 102 +++++
 5 files changed, 988 insertions(+), 1 deletion(-)
---
base-commit: eda9714fe6d9e6e5690992ce7dd42b13a5be7803
change-id: 20240402-dts_8qm_audio-e1e1697c9bf6

Best regards,
---
Frank Li <Frank.Li@nxp.com>


