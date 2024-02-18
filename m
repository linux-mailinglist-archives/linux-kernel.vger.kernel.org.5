Return-Path: <linux-kernel+bounces-70224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9031D859502
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 07:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45A12283B4F
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 06:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2878C6AA1;
	Sun, 18 Feb 2024 06:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="gFGnZauS"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2075.outbound.protection.outlook.com [40.107.20.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF681103;
	Sun, 18 Feb 2024 06:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708237863; cv=fail; b=RKeomrxaPIxaSja+NVDpcPfBmy6ORjf238BJT4S3WXCBAfo8Zf7V+kSAs1kEiVExAAWSKrn8JL4l/24QGS2J5v/Gl19tqLdb9uO0yA9zgLBpwFXTqAkztT4+4fkIMVlNN4FjRdU7qlUBbAqAwb0nvznC9eIMu26Xza+XyA7wDUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708237863; c=relaxed/simple;
	bh=BdIuzApF0drNHymebM3+MGSL4gdEkAHXeYMtBWQB04k=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=JUck2G3n7cW6sk7In145mv+1kX86Z6OCRHccIN7dsEKPb3z9wo5SmOsQ6qVloT2sxEASc0DWj+xsaogfaBUqa+LJbmsYgb3lu3GVa4UreF/6mtxnaZFMwBPkysHS3MrITnPNCpf3Uq0udWJcKGe8VKSRUUVPvriv1r8y81LheDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=gFGnZauS; arc=fail smtp.client-ip=40.107.20.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FhZ5m9swLMtYJgPsHHXodzHiD/6+YJ7r2vat0J3mUdsAPpP4hqAznerxbbBYs+qli3Ga0T8xi6BBVmz1py0GePf9b/HzGIaC9qHzllDCZDBHaCsI9Q9bwuhHEB0VIZhLQHmHHO4XwMXOn7qq0WA/ySdLVui6k0/93BSjlI/7hWSKjzJt3xDcRFgulVHybw+MQbWOCxRzdmY/lnJHTgwsoPdWNjRyIlVMkighLORCgE4mDlZ/wi7ku5kMITuCs8pwGtndm1KFl657q8BtNXX6iXIt5ojugElc7/nySm43aTjOXXgO5uGpnlRKA8xNRdLqjV7eK05E5gk26PK4TaO5DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=efWPxUiduYvZWTRpH1Db1WBkLb681SR7mwR31cRerD0=;
 b=ZBabUdKfr46VzqMpwuthk8kU/zaflQK9s1w2MIsgcAH9R2k/NwJ5AShUw9HDjP+pib95030IS5+uuL3RpES0cPcCaPjfndiQU+pYrhwSB3Xo4ocfIPy++6dvBXWMPsMZl8UiprHFbKbeOHYmjcjtP8oBSfqQvXodax/u1lpnmCZMII1zzrWamkSyY36+lAQOAQmM4rKVDdDIGzkDdGo5cUA3QyWpFpReJ/aG108axqR4pQmG0QHpMI3/P/suj8sbzegWsRidCVBbtNpf7vCDdno5ChPN8FTlT3Gna2JdvxB7qWCfQ0FgBQFux21i5rLYpUCKWMzoUfYMXqlyFHfKDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=efWPxUiduYvZWTRpH1Db1WBkLb681SR7mwR31cRerD0=;
 b=gFGnZauSH1LdvRzu1QOPqnqQluk9wOYsfD6NDJC8KP+/voG9PlFD4OBSjN+7oK+rc1wocezYVbv7Buxi+bHFYIA0It4aQllmn8rA05d5TPOgl+sfsaZi8heBvKbnr3KGH2USCiqzCRP0I59wKf9GnyjrxCnRFHjCflicNEaZoqY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8321.eurprd04.prod.outlook.com (2603:10a6:20b:3ed::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.34; Sun, 18 Feb
 2024 06:30:52 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::4ac3:3559:4200:38e1]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::4ac3:3559:4200:38e1%4]) with mapi id 15.20.7292.033; Sun, 18 Feb 2024
 06:30:51 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH 0/3] arm64: dts: add i.MX95 and EVK board
Date: Sun, 18 Feb 2024 14:38:50 +0800
Message-Id: <20240218-imx95-dts-v1-0-2959f89f2018@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPql0WUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDI0ML3czcCktT3ZSSYt3ExFQTY0MzM3PDRHMloPqCotS0zAqwWdGxtbU
 AHDdgo1sAAAA=
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Li Yang <leoyang.li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708238355; l=1139;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=BdIuzApF0drNHymebM3+MGSL4gdEkAHXeYMtBWQB04k=;
 b=HwUjY56OQHU0Z0z4nzSe0WF3BZulf/bq6VS2oqtvxKe6R749TvE1+lzh+J9A3pYYMb2TfxGTF
 fFoz1ph+7N2CsmpXaqdtO6Aw1qVvTPVpkhnTobJX8bJdJkL/bpDQADs
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR03CA0127.apcprd03.prod.outlook.com
 (2603:1096:4:91::31) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB8321:EE_
X-MS-Office365-Filtering-Correlation-Id: 16a63122-b214-4357-673a-08dc304b265a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jvPKb490EMRws+sNyCzpDNJ8nJkssfhtHMnS336I7Q4U09gRT8NS5M/Minwf4cFrKsiOtx8mw7sxNdoZqXcgpevPi4dghy6R/WrHzmzCu9XIUEU1348oXBlzJy3/YxbgEIbsrglcQzY6dYtR2JMFXcIG3XcOTFW7CzRntcFRkVxhGkHHznga5d3jolycNtMweZs5elwGxWydXNLd2srVodHftTJcKhbLaLEJv7BWf+GEk6T1bwb7fJb0y3GW/agcW4XEvfc7ZfHMu+HKeaBPg9Xkek1sQD5JrzypYzTQQFmS6lcyME9N+HEmD/lljqwvo15psUFK7ffxfSkyWqrXI5ApA3UK+j+VffRTOHd1Hman2cGTEEofjSejHbpFY0dfQsuHUB63yiPHss9UxOcd8CTAywPTEUpBxPE6gpyOWcCGeBC0yc6xmfkWY4DqcEf26pREvWEYCZLms40AnqY8ZR5fZG14oO7CX44v+RX/zhCjorhpebUWB+gqRHhfYJUhtA83bqVZybDeHzfe9RgUAsyfV3CrN9b1tsQWteD6R5OiuUzh+uQ/ypajl8E4oebd3E7mTKU1BM2yQWFN4ya+IJZ6sVlkoI7DtWvgLOgRhSuOM80MjI2M4glUrZ3xDptv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(396003)(346002)(376002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(38100700002)(2906002)(7416002)(5660300002)(4326008)(8676002)(8936002)(86362001)(41300700001)(316002)(66556008)(66476007)(66946007)(6486002)(6512007)(9686003)(478600001)(110136005)(6506007)(52116002)(83380400001)(38350700005)(36756003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmRUdUw4ejRiS2VweTZpYXhIeGRjZ2ZKcUJRcGtVUHlLMzFhVmRmSUJmaGpl?=
 =?utf-8?B?TVVSSDFjUWJ0SnBDUytYM1BnT0VhdHVNRG5VS2xENTRjWU5iR3ZoK1FzaWdi?=
 =?utf-8?B?WmU1b3pUMkJXWEl5REt1L1FBUSs1b0Njc3AwU3JKMGJ0Vlppa1piL1o0NVhK?=
 =?utf-8?B?ZWlBL0JHM2ErNWxrRkYzMGFMZnY5YWdmZVptRzYxWlpjY3pYNm12Sm4vMHZv?=
 =?utf-8?B?dUVJeFR2V25uNGExa1Nmd2xnQ2w4RkdnWjZwbFg5aldWSWg0RVR1cW00RlZV?=
 =?utf-8?B?ekVSMlVFYzBUL05xM1RyMm1ucVZPR3RXQlBYbmd5U3JIQllveE4xSWxPWHE0?=
 =?utf-8?B?NHNTOVNQZkRsY2lVVzkzOUJtZEZPT2VBZE00YW4rc0pENGNFdjlNbFZBNXdS?=
 =?utf-8?B?SlladC94TWp4ajBzNzdGanpqaC9Bb2xObTQxbzlWY0pSTzZaZzc4L21PcmxC?=
 =?utf-8?B?RTdWRFJjV3FtbnlFTFkvR3daT2tiU3BkMW9vNVlVZkZFb0hqNURvYkRadWp6?=
 =?utf-8?B?L0pSbk5WSi93VGMyUTNaendlNDFtdnJQZS9sVmJweElvelhlZ2NpVmVqZHN4?=
 =?utf-8?B?OERoNHNEYkc4RHlvWHZjNm9GUVgxTTB5SDR6bU52SmZOd2F0dTVvWEdaVEpw?=
 =?utf-8?B?ejR3Qm5LOVQ2NktuZ3RGUFJvRy9rWkZPeldSaDF3ZWF5VHdwT25EWk9pVFgw?=
 =?utf-8?B?dW1zYlFzc0RqdVE3emdSRCtZYjM4bUZ3eXA4ZkluL0tteG00ZkIwajZhTHEz?=
 =?utf-8?B?dmZuek1mRm92ZkdXTGVDdmg2QTdac3lZQ0dIZCszMWdPMUJSaEd4VDhuRHZn?=
 =?utf-8?B?SDlyR2Y3bElROEFzS3lzcTZOejEwMDJHN2FPQ2dHTXRDdDFZU3BpdVJraHd1?=
 =?utf-8?B?RUFUTklZZ3hYZU5sNXJNd1h5ZStxZ09iY3hselE5cWE5Rlk5a3dwNkpuTFJK?=
 =?utf-8?B?KzVYamNucjhXMndvQUZxbGdZSEV2cWJ6RStWajlsSGxweDQvM3ZhdWN5R24v?=
 =?utf-8?B?SHpNeWYvdDRYcERXYXJmVFdxeXJ1YzZ6SDR4UDN0ZXd2aFIyc0ZDUVFiU0Fz?=
 =?utf-8?B?L3duTm11QjBGTk5sNTNQaUZSOEVEZ0lqL0NSRXJMYkppUDNOTi9Xd2NiUkY1?=
 =?utf-8?B?akFHcWxib0xsakNiWlVkRUVuTTVJQ3VnYzRIV2dyZUYzckZqdVNMQWtKWDIz?=
 =?utf-8?B?Yzc5TkpjTGNiNm1GckFZR2JOS0NTaWhMRWloYlNzVWZFZU5wdkZYenJZODJi?=
 =?utf-8?B?MzVWT2w2R3k4RFBKYTFjZ1ZyS0xCUHJFSENMWTQ2Z1pROWJDMFdVZy9tVXFx?=
 =?utf-8?B?UlBreHBCRHRQSmUzS0daU1I2R3Q4LytxRU1UbXYrcGpTUm9jV0dLa3NwQkdx?=
 =?utf-8?B?a2tJN29aazNvaVZ6dGVhVnRtdlpLK0VsT2Y4Vjc1emtWOGNqMUJQdGxKSzJr?=
 =?utf-8?B?akt1bU5GSVliRkd0SWkvdXZiVmp1S3V5K2xKelZQT0NpWUh5RzJvVTg1SVZE?=
 =?utf-8?B?YjhlOGREVEk4M3dsbWxnL3pvVnpUZVVqTmlaTXlxZ2VEVDIvcy8rU2hzQkw3?=
 =?utf-8?B?dzVmV3RncURyL0xNUjFOOWxlTE5xQmdURzJsUnJTZ0NOOFJQNHpXK21hMElL?=
 =?utf-8?B?VG15aERnNksxWVpSU1Q0VVoxdUI1WXdJRCt5Y3pWT0NSODdQejYxWHk4aDdM?=
 =?utf-8?B?emVCRkhWUnBzTUFaaE5ZNWd2TktZT2VOVGl5VkhFa3FoeGNHN2ViQm5CdE5M?=
 =?utf-8?B?SU93bS95K0prVVhhQ2R6S1h2M3lrTG9kazN6SjVubXdneUpuU1hrZzFYUXA0?=
 =?utf-8?B?ellud2k3WUxOTHk1bVkrNm1YczM4Yzk4OXhpY21qUUhzU2Q0ZkFsZ2NvUzZt?=
 =?utf-8?B?V2x4bnV3UHgzelhSeWNlemdURlRjb2FnUjBOc1ZVOFlUK0NqNXFQcUwwSE9V?=
 =?utf-8?B?OHRDempHN1AzR1VPcEs0S1BMSDJXWmNxUmlzZjU2TW1pcDdZSlM1cERwMWln?=
 =?utf-8?B?RnVNYTVGTXR2V0lwR3JjQWtPSjJzRDVwSGJvTXNJRWZxL3A1Zlk5Q050dmFM?=
 =?utf-8?B?bWMrQ2gyS0U5RklUTk5zazhGQU04K0tDdDU3UnM0VVRDQ0lUTnJpbFgvMXRI?=
 =?utf-8?Q?7RuS2GN8DV7Y3iqhN0TK8B494?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16a63122-b214-4357-673a-08dc304b265a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2024 06:30:51.5325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QQsngA1tUwh09ufaqXdOvS5Z3Gv2wahBGpH9eq56VhWGAmQDrXFXEJJOBHgRSy5Bb1fQR5fF0K45JUYoa+45cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8321

Add a minimal i.MX95 dtsi and EVK board dts.
i.MX95 has a M33 running SCMI firmware, but as of now, the scmi pinctrl
driver still not ready for i.MX95, so we count on bootloader to
configure the pinctrl for lpuart and sdhc and it boots well. After pinctrl
driver ready, we could move to use scmi pinctrl.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (3):
      dt-bindings: arm: fsl: add i.MX95 19x19 EVK board
      arm64: dts: freescale: add i.MX95 basic dtsi
      arm64: dts: freescale: add i.MX95 19x19 EVK minimal board dts

 Documentation/devicetree/bindings/arm/fsl.yaml    |    6 +
 arch/arm64/boot/dts/freescale/Makefile            |    1 +
 arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts |   88 ++
 arch/arm64/boot/dts/freescale/imx95-clock.h       |  187 ++++
 arch/arm64/boot/dts/freescale/imx95-power.h       |   55 +
 arch/arm64/boot/dts/freescale/imx95.dtsi          | 1215 +++++++++++++++++++++
 6 files changed, 1552 insertions(+)
---
base-commit: d37e1e4c52bc60578969f391fb81f947c3e83118
change-id: 20240218-imx95-dts-aae4316671a7

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


