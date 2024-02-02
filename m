Return-Path: <linux-kernel+bounces-50110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7AB84745F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD09F1F2EA0F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3DF1487DF;
	Fri,  2 Feb 2024 16:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="KCQmBTeQ"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2098.outbound.protection.outlook.com [40.107.241.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AC91474CB;
	Fri,  2 Feb 2024 16:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706890260; cv=fail; b=UnwBPJBG4jfmrCbulV8IHnh8Tj/64aRLMJYlix/Or/trA2P5sWrEQuOJUAH4vY6XVOUORP4br5iln58iOUh2eknQXsZc+Lk8k1M/Imng5ptHh+PJzuP+To2FRuew4ldquhuch8mdgb8v/gX9jbJ0VuUZD8dKDH3ED1gL6gJx2BY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706890260; c=relaxed/simple;
	bh=SqKHeumTVKzQsziyHJAfPvghLFWSi7r8Q72VXpbcv4I=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=t4g+RxLwLLc9CTTyrSBycu74quVCg4YatPm/AqQGon/NKITgftACDEpWtXVD10KQoHIKe/7OUZhne8xmQSdjSMFty0v+PFRnR+hRAqwVdRY/Ya6YwuhzMlobk03rwoPiDyXR3ZVzhgnRFwPqTIixw3V+9bKHeqFpUSvWPEL8FL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=KCQmBTeQ; arc=fail smtp.client-ip=40.107.241.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LFQM3/JrBNa8nMbGtuSuxxxx+/9y2rz6s2CWj44s5td1vI4ML3F1OzQL/ZU1aml2Zt1yPAh2aT0ExDmfZMHTAA69+8zQB9L6R2sSnSXhidmbilY4mP9BBfId/flP9KNa+xUOqXMFDqfcl1QzScV47kaWOnX19b2WabNWaBthb3pux2jQKtIyuTWr8dx75mF3UesDTD0zeGn9SvdJmc9D/w0u4DmIHEdvF169dXbHop1Kr/IhaTfkstS7IlDPMWtRhOVf0Ew1EAT8dJir7adgARkCfQODj43lc64LGN/DCfH4WaCRu3yDRh3NXfa2iyvcwz4V7kvtzPfhiw2XM5Expg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JyTwmmXFN6063z9IATwBJw1s7di+nX1rwreDnVMW3HQ=;
 b=K48ywlWifSkkWxQ/iUNA48j1nHW9Eb614Pfz6drIrEKYmexdyGl9EH7x3RMNXit130CVNNtMEFM425cmXy+3BvjJeREoArsMGJtq38MJqgVS3OMMQkhtJ84+M4b3z2wkYlB4FTlzZg3njRcVqCDNNeMALDXJHfwyapT2wpvD3cQ28+rCew8eqHcQND/1p+BnRBVVKb6IZL5efO/Ub4lTiUBOeeyCrZl+Sud6xSWkmfOVED9If8qCS2CFpYcgRmRF1h2cIh+m3HL9L1JVCI79/Zhk+u5PxkVOd7UP3gq2rXNE62OGoKBah8COkqSs9cmnWao0AFcsIyjEyka7VuIwfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JyTwmmXFN6063z9IATwBJw1s7di+nX1rwreDnVMW3HQ=;
 b=KCQmBTeQYwvwn+gIqQJRFwNDw370K+GNsqY7s/8SvHCfrzXLp12vEJlpiR60E+0TOMTVKbR+wbm/+d0tCp0StTheybr49RzBDQr3EA2rjWEqrrNdg5YR5CF2T+TALFR6xTLEho0tdjatm5U/pvo3g0HVBQNOoEYDxcejUr2JbmM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by DU2PR04MB8775.eurprd04.prod.outlook.com (2603:10a6:10:2e2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Fri, 2 Feb
 2024 16:10:51 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c%7]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 16:10:51 +0000
From: Josua Mayer <josua@solid-run.com>
Subject: [PATCH v4 0/5] arm64: dts: add description for solidrun am642 som
 and hummingboard evb
Date: Fri, 02 Feb 2024 17:10:47 +0100
Message-Id: <20240202-add-am64-som-v4-0-5f8b12af5e71@solid-run.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAcUvWUC/23MSwrCMBCA4atI1kYyk/TlynuIi5CHDdhGEi1K6
 d2dFkQtbgb+GeYbWXYpuMz2m5ElN4QcYk+hthtmWt2fHQ+WmqFAJUAA19Zy3ZWK59jxAjQYrSp
 nvWT0ck3Oh8fCHU/Ubci3mJ6LPsC8fUPyFxqAC26tBt8gVtr5Q46XYHm69zsTOzZjA34BgCsAC
 QBZF6hKo7A2/wD5AWisAEkAekUnaQvhmjUwTdMLPeIaui4BAAA=
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org, 
 Josua Mayer <josua@solid-run.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Suman Anna <s-anna@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, 
 MD Danish Anwar <danishanwar@ti.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR0P281CA0158.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::16) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|DU2PR04MB8775:EE_
X-MS-Office365-Filtering-Correlation-Id: 5847c411-7e85-4714-2dd8-08dc240986d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	p3rX+GWK6zHbcrIcfw9mJfRzIkEyMQ9ieD1rJ95iR5x3r6q1PEl2L5pe/h8+96G7p14a62bYRsAZweidoq0EgkZrqhUW6UcpZLttu+svjD7nUS5EgEi3NrKTiAnlgwJADz5ZKfFFGvjq89KfoB/3WO3nM5iPnc5igXJSn/Zhx8dGFVwwYGL9IEZ/Vmf021TxR83bnr/QNvcLswcFnxlj1x7Pgsam05WCFm3PGGuEhUqIONr8mZpu7+tRCI74IobAgrcK+d7ZuIUpbHXCAA0UVyfBrbH+HVTr7mhGh5/IcYjVOvHljNE3xNCsHX9UvJxJnka2+UDk/dLdm8XTryevkNVNB+HlXn9z7rp+34kAiFEVefY6qHRMlqF1iqU/4t4nbpcKTgXIN2yDWeE50NP+Yjzu63fPjbcOZk6fb2DZK3lcEs/wTzxTcK3xeKFEXNGLy/MmYOQLYJ2aCKsqLii20xsDTFWMB791eJ2UQbVtnrtZwR2d34k8Zo3Mu7jmMbWTNh/BtqKQudiD6ugM0zzcpuaCAwcCn13ElyZ5i5eFDQPqPNasTIb1jM79C87rbnPmlI/ccZgl4aAKX8f/Oxty373B+1fsDG42qNg6y76Bw+DljQNLupSkdaU2zya8D8I1MWVyf+7WpDHhGmQyQADvWg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39830400003)(396003)(136003)(346002)(230173577357003)(230273577357003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(6512007)(6666004)(52116002)(26005)(83380400001)(6506007)(2616005)(36756003)(8936002)(8676002)(66556008)(38350700005)(316002)(2906002)(7416002)(66476007)(5660300002)(66946007)(86362001)(4326008)(110136005)(54906003)(41300700001)(478600001)(6486002)(966005)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZlVqM01ncHZveHdFNEV6QThaa1VDVHovc0JIYVZNWHRremc3TXl5aDN3TTJH?=
 =?utf-8?B?eGZ3clZyemNMYXBSZTlGN2duQndnUlpQUENVcGtSN2tBQkU1aExIdmY2ZGZr?=
 =?utf-8?B?cmM1bjdFWGtYTFcrUWhqRjA5NjhuLzZrbHpZdUZBOFBLRTdhTk03dWQyRytB?=
 =?utf-8?B?MVZwSkMvT1pKdlplcW56WTVxTjRXL0NxVDJ6YTlPZGdKMy9XZmkvYXduN0wv?=
 =?utf-8?B?NjZydG5leitES3k3TE42ZFF4dlVjb2xCS1cvOThQVTdJbDJBTVdla09uczMr?=
 =?utf-8?B?UjI5TWV3T1JVTDBKemNjZ2JZV2tmTU1SZ2lhUFg5eWJMZlJCOTJLTENObzEy?=
 =?utf-8?B?UlBjNFY4UDEvY1JpbmVDZmo1ODAyMXkwempEWGdIbTdNK0pMbDI2MHlabEFt?=
 =?utf-8?B?ZWlMN3VTQ0thMENiMUZ2eEdOZHdFK1ZURnF6TWR3T2hPQXE1OCtNODY2OFd6?=
 =?utf-8?B?Smt6RTZ5Um0yT2p0REZ3Z2RocWEySU5rbWw4NzBRWkE1SEtsTXZYUnFGcHlm?=
 =?utf-8?B?MDZwQ2REVkdyRG93cFJCditPcks5NHRoSnNCK2RZTVVBTWJlb0l0QTkxdGZU?=
 =?utf-8?B?OEJuRVhOc3JLb3RXQ2NERzFQVW5WNlkyczRZK3VRSjhLQVJZdXduQTR1Lyt4?=
 =?utf-8?B?UmhMbG9neldhbml2YXZneEo2VElUYU5HRmZMT3ZTb21wOGJmMS9Yem1BRVNE?=
 =?utf-8?B?VFdDb2JpNVU5eGtnV043eVd5UkdBNjQ2N3o2SnBiUXNuVW9MeDRYZjhIVnVT?=
 =?utf-8?B?bXo0OXhmbHRZODdxODlhYmcwY0VuK1R0a0gwNzJ1K1ZuWmRGNDhXVUJXZGli?=
 =?utf-8?B?b0pEMEtyTVZpSHF1ZnR2NUxqMnFsM09lNFlLaTB0ajJlR0s2TFo2S1VGVnNa?=
 =?utf-8?B?V2twLzVscnQ3Vlh5K3RGMHo3Q3FBbHlHdmFBd0o0VkprRldydjV1a2pYNjhI?=
 =?utf-8?B?b1o5T0ZyRmtsdUQ5bTJITSszSHpobDNOTUVCRzFxNFlLTHRpMVJyK2kxQnNJ?=
 =?utf-8?B?RHpLYTcwblQ2aE00L0I3Z0ZYYlRJRmFrczRrckJlQ1d3UmhtQUJ5ZnlzK2Vo?=
 =?utf-8?B?aURpMjNVSXA2WGdjL3pUR0JPT25ENVJ0cUpJNTNMMjhyTmdwTXRyTVpXRTcy?=
 =?utf-8?B?ZTNaOFpoVlZYblNDYWx3L2tFcVVtdlo0cUM4elllaEFVUkZOQ05RTWg0cHZC?=
 =?utf-8?B?SVgwRm5KTlltRllOU3ZKNitvbmgrWUU1clFtRlJlVnZYbHJESytlNllRYzVv?=
 =?utf-8?B?eWN6enpWQWVNOGxTNEdDaThkUW5YZW42YTlwMmJNcWt5dGdLeHh1dzkzSjlR?=
 =?utf-8?B?S3BJK0VjSngrRmQ4U2xIMW9ldWJoaWlMMG92UjhCRFp3RjQzM01uSzdQVVFR?=
 =?utf-8?B?TDgrdUk4UThWMHVIUkRnL1JQQjhKNW9IKy8zSlpUV3oxQy9FVDZESTVHV0pO?=
 =?utf-8?B?NzY2UDlUUVFPM1IzTnF5RnRkTkkwa1p3YUNNbGlsZlFmN1lXQzVrK1NJZm5z?=
 =?utf-8?B?dUcxdGZXbVQzeGVlY0dYd1MwY1RjMXoxMDRiVStJUU9HQjV4VGU1clRYeVBL?=
 =?utf-8?B?MXNSUUgxWmh4c0ZBMm53NEJ1cjNhY3NyejM4VE5TSHBiRkt3L0I4OUp1R0NM?=
 =?utf-8?B?L3dOR3BaVEt5Wm03cU85TVpPRjhmeS9xSzdIS3RjaXRZaGZtaWZPZGxsaHVk?=
 =?utf-8?B?NHNpMUtYMTZ2dkFLcS9qVzZqRkxHdExjZ1prd2hwNWJRaXBDaVgxM0JTSEpO?=
 =?utf-8?B?aGhjaEo2U0d0Zi9FOGNWa2FkeENJSHdxYkRUbnVmbS93WVkraXAyWjFBNW8x?=
 =?utf-8?B?N2JNUUZ3K2tXSUdFaGJyTEQ4RW9GOExON09DK2hsT1pZUmkvTkdFR1RoL1dN?=
 =?utf-8?B?ck0xRGVSdTFJYTBseWFSbEhvNjVVRTFhRGxWd1Y2RG9sckZVaVdGL212R24x?=
 =?utf-8?B?RE52VmJ6VkxVV3dXMHJxdm43Q0VWN2Z4bTk1RUJOZlBiN1dSenhZRnc1U0dj?=
 =?utf-8?B?UzZoUXp2a2NRbUwwWEVTcmNCUFJ4cWdnaXlkSWlpaGhzNUwwb3Z6NkFiQitt?=
 =?utf-8?B?WXI5dFVjeGw5VGtwMnVpQkRYYzh6b29tQUVTVjcvNWREbHNOWk5xU3RsRnZR?=
 =?utf-8?Q?PWFh8z1TfDclWFnbd6T021zMR?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5847c411-7e85-4714-2dd8-08dc240986d1
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 16:10:51.6230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GBT4tyiy99AqSvPDTLDMZhZ4VqULO3ho6uchQe9+ZxsaNBPom+ltrKiaAwW+Jd+qQgoL4JtJEhe/97TJKhwUPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8775

This series adds DT bindings and dts descriptions for SolidRun AM642
based SoM and Hummingboard EVB.

Additionally a commit from downstream vendor kernel are included,
enhancing support for pru based ethernet.
I wasn't sure how to properly annotate it in commit description /
signed-off area ...:

1. add description for "Industrial Ethernet Peripherals" (IEP) to am64
   https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/commit/arch/arm64/boot/dts/ti/k3-am64-main.dtsi?h=ti-linux-6.1.y-cicd&id=5afb73d82a014b59462162d960b350b8c58e5ae6
   IEP is already supported in-tree by a driver, and used in
   k3-am65-main.dtsi.

Unfortunately dtbs_check reported many problems, I put some remarks:

- 'mux-controller' does not match any of the regexes
  The expectation seems to be that a mux-controller at minimum has an
  address, something to put behind an @. However this is a gpio mux, not
  sure how to name it better.

- unevaluated properties: interrupts, interrupt-parent
  sensors and flash yaml are missing interrupt descriptions, but these
  parts definitely have an interrupt signal in this solidrun board.

- wrong names for pinctrl nodes
  Other TI DTSs consistently end with *-pins-default. Should a different
  naming convention be used?

- cdns,phy-type required property
  inherited from k3-am64-main.dtsi
  there is a PHY_NONE value in dt-bindings/phy/phy.h,
  but not allowed in phy-cadence-torrent.yaml

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
Changes in v4:
- abracon,abx80x.yaml: fixed dtc error in example irq reference
- Link to v3: https://lore.kernel.org/r/20240202-add-am64-som-v3-0-2f44023d50e9@solid-run.com

Changes in v3:
- removed lots more status properties, double-checked against soc dtsi
  (reported by Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>)
  (reported by Andrew Davis <afd@ti.com>)
- removed intentionally-disabled pcie node from dts
- rewrote yaml bindings to use enum instead of anyof+const+description
  (reported by Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>)
- abracon yaml
  - added missing maintainer
  - added diode type property type
  - added example
  (reported by Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>)
  - added reference to /schemas/interrupts.yaml#
- use generic name for pru ethernet controller node
  (reported by Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>)
- removed unnamed dmas from pru ethernet controller node
- moved pcie/usb3 features to dtb overlays
- Link to v2: https://lore.kernel.org/r/20240112-add-am64-som-v2-0-1385246c428c@solid-run.com

Changes in v2:
- reordered patchset to drop separate patch adding iep handle to som
- moved dtbs_check warnings to cover letter
- converted abracon abx80x rtc bindings to yaml
- updated dts:
  - remove unnecessary status properties
  - changed non-generic node names
  - use color property for led descriptions,
    they have no default function on evaluation board
  - drop earlycon bootargs from chosen node
  (reported by Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>)
- converted charger node to comment, part not assembled, has no bindings
- picked up acked-by on board bindings patch
- Link to v1: https://lore.kernel.org/r/20240103-add-am64-som-v1-0-dda1f9227aef@solid-run.com

---
Josua Mayer (4):
      dt-bindings: arm: ti: Add bindings for SolidRun AM642 HummingBoard-T
      dt-bindings: rtc: abx80x: convert to yaml
      arm64: dts: add description for solidrun am642 som and evaluation board
      arm64: dts: ti: hummingboard-t: add overlays for m.2 pci-e and usb-3

Suman Anna (1):
      arm64: dts: ti: k3-am64-main: Add ICSSG IEP nodes

 Documentation/devicetree/bindings/arm/ti/k3.yaml   |   7 +
 .../devicetree/bindings/rtc/abracon,abx80x.txt     |  31 --
 .../devicetree/bindings/rtc/abracon,abx80x.yaml    |  74 +++
 arch/arm64/boot/dts/ti/Makefile                    |   7 +
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi           |  24 +
 .../boot/dts/ti/k3-am642-hummingboard-t-pcie.dtso  |  45 ++
 .../boot/dts/ti/k3-am642-hummingboard-t-usb3.dtso  |  44 ++
 arch/arm64/boot/dts/ti/k3-am642-hummingboard-t.dts | 292 ++++++++++
 arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi        | 592 +++++++++++++++++++++
 9 files changed, 1085 insertions(+), 31 deletions(-)
---
base-commit: 861deac3b092f37b2c5e6871732f3e11486f7082
change-id: 20240101-add-am64-som-51a1ca47edf3

Sincerely,
-- 
Josua Mayer <josua@solid-run.com>


