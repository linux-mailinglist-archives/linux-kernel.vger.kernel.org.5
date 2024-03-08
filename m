Return-Path: <linux-kernel+bounces-97238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 809AD876769
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A45FB1C215EA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1BD1F934;
	Fri,  8 Mar 2024 15:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cwpARn8I"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2089.outbound.protection.outlook.com [40.107.13.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C561DFDE;
	Fri,  8 Mar 2024 15:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709911876; cv=fail; b=Tf7+6KtQ4Z3uQiYBZ6gJ1GO9p/1VGQCD6dszGR79Yu15asYNfVaghBIYN6N78hrlp6zLpJ9dttrDOYjs+Hxk8meQBADM1/g4ALteTJysqg1GNfz/lEwj5PqFL6ycCjpj9yEVjbLvBj6u+I/OYdooOKvDdxgemV+unMEVOug0RlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709911876; c=relaxed/simple;
	bh=PPtZ8QOO7H8F7T7qTWBrFyAwU+dXORNCtR/70UkilWg=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=RpTz0/w8jXzGqtii3bvpN44i6v315dYLzYJQXvHwVbwiNbf7B/rMKsFQb6sx3n581jQB+yWtHdO4T37lJKgV95brRtbHKTtZtSAFjXFYrsXoPZQfB9TkaKA5xrZmsfHmVFFtp9yp8JQl0JJ1f7Z2gPmLxlINPKewK2SngIDjlD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=cwpARn8I; arc=fail smtp.client-ip=40.107.13.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RssAWqFv49R7AwT6KcTa6Et0qzh4FHUh7d6SxXeK98w0Tia/Vvldr9M+m72anhGGWJMULop4uzWY6YB0rDaEBapqcvKLZA/3aelVMfro04go6MzLB0SPVVakbFfYX+VaMGgESBjoI4hkkhJ3wxTZLIY5QRJ/Uw7yftmqQh2SwQNFaD7+eRwZNjfedKLlRnSpJE3A+MW/ckj8CwLt7MtM1VNzIo7SHYbZWsIei9ugsRv4MsmHU24yxtz1FN15T03Yukt71aLkPE4QuDGGoFOeafabI5399USMngtkGcN6B5yJbpWKoevzuUthdds8U+IOeHOl7p6G4i9hFt6bBH9ZxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ie+adMdt9ASFFwojb1zBMzUaqrwHhXGvk8rdmrhws/I=;
 b=FSLhjZCUsHodCNvz6fmzaz/oZ0XOpG5+/wLLzIrytGTg7yTxRk1wEG+nr8shPEH2LnxD3d0srT/s1SMY0EmbO1yK1agenIOPXvdf5Qai5meY95tlTugF6pB4Mff89J11AifY9eHRjndwxyuvTi6YpT5Pd5nS4cAhY0ygR6yOFmVTPnX32iueN8f82Mfp4MAjWkbRA/8ihYxcIyK11+fGvj1q8C+cb0i9v2EGFR8B7GV3N6TqlD1QdhXjx2CfaxTFsBvWKFg/3I0Qn8Opd8FebfWBycWvO+cbHJEgYKGnl60d6ZLkGZkWfWI6SuRiDMVZCt7rvTbdSWdwA732sDrxmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ie+adMdt9ASFFwojb1zBMzUaqrwHhXGvk8rdmrhws/I=;
 b=cwpARn8Io6z/sMrrXGM7nQamtO2th2V0nH3Sakb8DVT78D9F10zGb0dHb5xWGwtmRZefecRf/EdRUzsuK85UFjIDn5XVuATnAPkYAhMY9Ac5mKs1Y/CW/kpY8n4grutTAyrHJAT0WH32DDhpVhf2EzSFTfRo88yDpugiWpwPbtc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8116.eurprd04.prod.outlook.com (2603:10a6:20b:3e7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.29; Fri, 8 Mar
 2024 15:31:11 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 15:31:11 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v6 0/4] arm64: dts: imx8qxp add asrc and sai
Date: Fri, 08 Mar 2024 10:30:49 -0500
Message-Id: <20240308-asrc_8qxp-v6-0-e08f6d030e09@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACkv62UC/23Oyw6CMBAF0F8hXVtT+saV/2GM6QvpQsDWNBjCv
 1vYUBKXdzrnTmcQXfAugks1g+CSj37oc+CnCphO9U8Hvc0ZYIQpwlhAFYN5yPc0QsyU4kISSVE
 L8v4YXOunret2z7nz8TOE71ad8Dr915IwRJDhWhsjnK4NuvbTeDbDC6wdiZROlo5kZ6llDWGtJ
 UodHd0dQax0NDvDa91IRDlr6qNjpTv8k633NOFE5Ccu7e6WZfkBdQqe/0gBAAA=
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709911866; l=2336;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=PPtZ8QOO7H8F7T7qTWBrFyAwU+dXORNCtR/70UkilWg=;
 b=efYAzPVAB53gWj/TWTH77Jxxp8xAROCJo6M7eJsyH/ysEezJ5WojU+c2To8nEC9v6RxZfjBAO
 dZrKITFFh3vDArL8+cMhAUZSyZ2HGariSZ4Lu8wOtlhY3wJQjkB1ZG9
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0151.namprd05.prod.outlook.com
 (2603:10b6:a03:339::6) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8116:EE_
X-MS-Office365-Filtering-Correlation-Id: b40510c5-7f0a-42ba-ec53-08dc3f84c844
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/grHWlUNqny0AssRVeHKAYEYvZIx3X5+rVqC7WQ4ic8V9Z7AEwoPa9d0r3wwSZV5c47707HnWbnEqNm2ocSNBVm/Za2tNwoQ/ePg9NiL+HL1c0WGPL+erqDqXPcTMfib8tLKLbKviOWrtp+Z26lTM89cZqVOfjK3Q4vT+sQpsEESfs/jnxihstfyPF/JBAduAP8WhKg9cFyxfJjTT3gjwcQyCd365P1DZby9dLMltYBvPXyvGNsWiFeFAsrmY+i9ydSRFfHbP0yYr4ZGx6xoLqU4ev4mTKu4d769s+C7U/dCkzfTze3nQ3ITnJv1fL1kVviwvDZAsSp7NKf/6l30r9JPgJSWAry2+ZmKJ32ABVsPJYtm+TH7e6UaKEkoDj62x1ieSePcQHwNNdTR7BwPlIqMgG9w3+y5Po9ofxGvLFEebWF/wbqzoTJKsFMhA7yDmLmmKwKzXsgscOuD6TvWRg4KARGTrWjt3xNJCOeJg1rNVSNJZWl9VbrF8AtHUTWq9zmwStegU2o+rX+uNljpEEJM0oGjWWPN6WGDJkrstjQa+gRHDKNu77AsEYcogTs6aI9tGkHSPoR6ftamEQlrnDwD/z7yDHBDa2sAZMAnPhuRGe71wp39Fa8fNT5jMhJz+F8e1oCKgN85xSaMS7X1wg+98UsdXK7iiRhRrsiicG9W/1jJv1jiBY2hdUXFJXOf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(7416005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d1lYYVBtTmFtZzhYREJMTWUxMW5aYVRpdm5iZUVHM0FkeFd5ZkxRaEJSTW9T?=
 =?utf-8?B?ZmVCYS8xNmZ0RW1PZHVGd1NEV3U1Q0tVSmUxM2N2VDNwM3M0UHM1aUlsWEFZ?=
 =?utf-8?B?TXgxc1JpNU5IVHh5K2RBWFM5NEcrM3lGYnlHY0RQOE5MSm1RcjlpRmE1d0dT?=
 =?utf-8?B?ZVVFN2piRUZPUGIwWENqQkttZWIyeHorc01JUGh3aEFkK3FuejMwbUFnRFNn?=
 =?utf-8?B?RHJma2UxUk5MTjFkeU9vbWFuTVVrdHVRdG1Ddk9MR3Z6dHFqQmNqci9RT09T?=
 =?utf-8?B?U3MrUC93anE0S1NNa3lNZ3pUOU1mTER2UlNaZ3A2NlViajdMWWlFSDJ4QTVR?=
 =?utf-8?B?cCtmcnpyVDAyK2VUb0t2WUp0Yi8xekl4c0lLK3Q3aEpERGkzVThCSFBLTy94?=
 =?utf-8?B?ekNjbUd0ZHJXbWhsbHRacDVPNFNGL2lyamFqUVFlR1g1NmZIRWZNN3NLY1or?=
 =?utf-8?B?aEFwY1JtcXc4VUhTZ3lSUE4rRnhjS3dQWW8rOXYzbTAzczhkdG9WaUVpWHdP?=
 =?utf-8?B?UDhSNGovU2RpMWFOV28waWY5UG4rREhhRXc1V1lxZkpGOGVPS2hyeDZ3d3Rn?=
 =?utf-8?B?VWx1VUFPNitJNEdDZi9LMXlYTG5aSTdaZFM3d3lja0kyRENSVmpjRVFFcHJF?=
 =?utf-8?B?VFpwbjhpQlUrRFAxSkZ3YlN2ejc1NjBEKzFEOWhWeDRtb1lpY2wxUWtLK0Fw?=
 =?utf-8?B?UWFuYW5nSjA5L1Q2Ly9UMGUzOTJ3TjE1WkEwYm5CVXRhdE9OL1FXVlN6RjdG?=
 =?utf-8?B?dnY1Z3grSE95UmhnK1J4dmx2Sks0OU9yd1Q0cFhLV3NETDRxM0JiZVV2REN5?=
 =?utf-8?B?SS9LTFNuaGt5UXo3eEdPL3lIL2Z1T3NpVGZnaWJGK2NKQTRvYllMVVlWS2Vi?=
 =?utf-8?B?RUNXeDhWRFJvTnFFc2FTSE9uanI0aSt4b2s0dUhnVXRsWW84cjJNa2xEWGhF?=
 =?utf-8?B?VjE5dm9RNUhXT3FncG8wYzBuYUpTQ3lWbWV1b0VHK2hlV2xWL3YvRU1aVFR6?=
 =?utf-8?B?THRXaDlSbkYrd2l6ZFZRajU2OUZzdkNUckM2ci8rKzd2UE1sUXR6S1JjQlJv?=
 =?utf-8?B?bnRnSGJFVFEzZ05tMkVYUzJDVzMyVlZwenA2bXZSZGlTTEd3WUptZzB5ekRC?=
 =?utf-8?B?MG1OTnJDZlMzWDEzWkE3VnR5SEJtb3J4cE04MVZ2b3ZqaGQydHN5aERGRWR5?=
 =?utf-8?B?b3ltVFp1L1dGMHpUUTFBaTBRYlJEL2ljMmxjWkFqMmhmZ2xnYnRjNEtIQ2RN?=
 =?utf-8?B?VFZTNlNlVFJpYk9iU0kyNlRXa1hlWmNIMEpUeGkzRzkvemtyYU5CV1d2OFJr?=
 =?utf-8?B?M2h6YVRiY3l3ekpCUDlRVm42YUZRekdqL0EzaGh6Wk51citjYmVZNEhBS3lU?=
 =?utf-8?B?aTRvTUtYOXBGZzA2Yi9PVnhlK0dDUnBEOWFXeVd6M3NYUkF3bDNET2RRb0ln?=
 =?utf-8?B?UUwzd3U4VVlndTc4MG8zemtnb3ZWOVNNZnk3eURXbkZCeXE0eUdTeEJYVG9H?=
 =?utf-8?B?V1FXM1dYdmZnVC80VG1RSEZsdEdOTk1CVGhZR1p1SzBhTWhzdkFvMzhtTGZn?=
 =?utf-8?B?SjE5eGM3QS9yRTNucE1sdkNMNzVsSDA1cDE2TkVkaUlmdkVOWnRubGE5TmYx?=
 =?utf-8?B?ckdYT1pMMDhZeHdQNGQxVkFiV3B2WjlHWTZLUzg5ZGlKMENGZDlQcFdZWktH?=
 =?utf-8?B?a1E2YlpUbTlqWWF6eGVrcnlsQmREREhsQlBsZG81TlMwZU03SDc4NjVJTzkr?=
 =?utf-8?B?RUxRYk8vWE45RFNlT1Y5blVjSGJXblBtYzJhb0dmbGd0WklsQUtuTXk1Ukxy?=
 =?utf-8?B?dzNIU2pUTWVlZWJZRmlPaE9OV2FhZC9oMXViUWhPQXJxSUlHU1RBTzAya0pu?=
 =?utf-8?B?dnd1bGRuQW9QSjF1MFQrN3FjMFd2aEFRTTRJcWdHMXo2L3Y4WGFWWEpGSHFp?=
 =?utf-8?B?QVJEekN1VmU1V2lDaStiWDVMK0VvcGhzaWZmbWtwbldwZ3JZUURSL0ZHd1RZ?=
 =?utf-8?B?NnpQamNIM1FnNnR3aXk3eVhnR2Y1RlE3WGxYbFlBRXVNMWRXMXQ5WFVVZjlo?=
 =?utf-8?B?RFdhVzVNdDJzWk5SM29aMjd5Rm5mdC9ZN3ZVNUdlNy9hbFZZMXI3eENvZC91?=
 =?utf-8?Q?JWqk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b40510c5-7f0a-42ba-ec53-08dc3f84c844
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 15:31:10.9568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fHo/k9j1fHyawy9KWVGrqYseJbX7lXj4X59MDMq2nJY3+hWIDKawtris+M4P7sAAj7u6mzy3GHf3ntaZ5Ojwuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8116

Update binding doc to avoid warning.
Change from v1 to v2
- Fixed dts DTB_CHECK warning

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v6:
- Add interrupt description in binding doc according to rob suggestion
- Link to v5: https://lore.kernel.org/r/20240307-asrc_8qxp-v5-0-db363740368d@nxp.com

Changes in v5:
- using rob's suggest logic after fix maxItems.
- sort dts nodes.
- remove spdif1. Add later when do 8qm upstream
- Link to v4: https://lore.kernel.org/r/20240305-asrc_8qxp-v4-0-c61b98046591@nxp.com

Changes in v4:
Combine comments' from v2 and v3. I hope I address everythings.

- Krzysztof's comments
  - add reson about why change

- rob's comments
  using rob's suggest logic to restrict interrupt number
  but for dma-names, still need use oneOf to cover 3 case
  - [rx, tx]
  - [rx]
  - [tx]

  oneOf
    - items:
        - tx
        - rx
    - enums: [rx, tx]

- Conor's comments
  - add power-domains required for imx8qxp and imx8qm
  - remove dmas descript, not allow use index to get dma-channel. Current
no user using this method.

- Link to v3: https://lore.kernel.org/r/20240228-asrc_8qxp-v3-0-d4d5935fd3aa@nxp.com

Changes in v3:
- Fixed dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/fsl,spdif.example.dtb: spdif@2004000: interrupts: [[0, 52, 4]] is too short
	from schema $id: http://devicetree.org/schemas/sound/fsl,spdif.yaml#

- Link to v2: https://lore.kernel.org/r/20240227-asrc_8qxp-v2-0-521bcc7eb1c0@nxp.com

---
Frank Li (4):
      ASoC: dt-bindings: fsl,imx-asrc/spdif: Add power-domains property
      ASoC: dt-bindings: fsl,imx-asrc: update max interrupt numbers
      ASoC: dt-bindings: fsl-sai: allow only one dma-names
      arm64: dts: imx8qxp: add asrc[0,1], esai0, spdif0 and sai[4,5]

 .../devicetree/bindings/sound/fsl,imx-asrc.yaml    |  14 ++
 .../devicetree/bindings/sound/fsl,sai.yaml         |   8 +-
 .../devicetree/bindings/sound/fsl,spdif.yaml       |  36 ++-
 arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi   | 267 +++++++++++++++++++++
 4 files changed, 319 insertions(+), 6 deletions(-)
---
base-commit: ca301cf599a4eeafed8e3dd87bf8d2fe810e075e
change-id: 20240227-asrc_8qxp-25aa6783840f

Best regards,
-- 
Frank Li <Frank.Li@nxp.com>


