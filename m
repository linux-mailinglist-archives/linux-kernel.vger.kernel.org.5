Return-Path: <linux-kernel+bounces-71532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAC985A6CA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DEAE1F216C8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278D5381C4;
	Mon, 19 Feb 2024 15:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="BGiu843C"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2102.outbound.protection.outlook.com [40.107.22.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EF22E821;
	Mon, 19 Feb 2024 15:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708355026; cv=fail; b=FwalaNbL1V0K2bX23rIsnJruA8MNvKlkuLOPF2sw6+9VdELILt36aW8bFmbJJxQ6uK14NN3hP4JTs4Ean7DKmxn1t7zQXiFYE2MNAA3uMmbPZ0JlAvtzHtXaR2mVM2IRtK0c9anBegaKjjoaJ/QjJBeP4PZSfofOGI/d1/jw8P8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708355026; c=relaxed/simple;
	bh=fCctOwpnkyTuLNa7f07oP9d/0hYlNqvUCfFB0917xV8=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=fdrAJ0pCX5gvdos84lA5/W4KaVGzsucQi6zwKgY+uzN3RbJ+yq+hZaxqT5c5fI0g4OnKap0NF8dEv+nmjsJbR1SlmZ5CYebL5OzF2d4mxPl9fR/GX8ZmrL3eN1+8etcNiUpUUq6a1f91wkQC0uCX5arPNWRCMCSDpWrBs4IXN7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=BGiu843C; arc=fail smtp.client-ip=40.107.22.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=amtcXoHFaLeubnBRkoUtbvOSw7rtPdi2RrfFEMrP5FSEd6XJhD3+KXI9NOIrVYyh0LRSEAlePGIkj8wWgE7EpzYTvY1UhXUmALZvXRpR8v8anoG5dxYrx3HwYXjllGytp23EWjmHZRtwYnMXGAMUozp9oSrPDBn6ygApQn3zXiMTw6dQgWJsBfFPoaxcqGYYhTgV1dJk5/m7PEfx5hidnfYiyQvLMalg7rKT7TJTEem1TBCeqIdBZF0Am42iREEXFhcGtemvKhAhfdX3/mCfaG9y1jUPVYWeUEUj2I3i8VN5UyuXTBWI2TC0aAL/lLe1YYXt9INjdkOTAWqiP28fvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fbLIjY/YZhjt6WogzwwhA4LQPHdBIt60t8wcE+X95P8=;
 b=U7BQQRgeKjJGtGbcaApxPfHgjd7xcOMamSZp7LcFOnxHMxWrTsmy/ADqGqXPyvadgd7DVoS4G4N+mcIrxESqJyliA3YQZxIXcPUif173PXvx//RVtinBbLv13GSd3HxonP2dfmab1YqKvKPGbVBfDJVRVYF9566+mn1jGWQmRMV6uAhEWYSTWRTOxbsUQlS2VltJXoU2bbjSQ9UtqFN0JMMGSGCb75H1nXoWOhHzyZFkY+iDvraT0/gIUnpEdU56dbfvG6qy50b8tb1ChG8sQlbkFIlLMb5vcGvAMk9mtTjrOgHFSTnmXzyxMkm0b9T61BPlE75ivSfxjMMrgSDUbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fbLIjY/YZhjt6WogzwwhA4LQPHdBIt60t8wcE+X95P8=;
 b=BGiu843CdGkgNFudRGivHbevBNQcaQq+x9+LHqlXIHppfFmKydbluy5T47COucPiOLrL3emtxpgD4zBR274rBxr4ORwJagtu3G2nM/KJsdXSjWwDpImxO753sw1ACoz/jQzCAb+sz8+zrZqBAg/ke0WwtNBP/zruhNoJexh8K6s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by DB9PR04MB8431.eurprd04.prod.outlook.com (2603:10a6:10:24e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Mon, 19 Feb
 2024 15:03:40 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c%7]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 15:03:40 +0000
From: Josua Mayer <josua@solid-run.com>
Subject: [PATCH v7 0/4] arm64: dts: add description for solidrun am642 som
 and hummingboard evb
Date: Mon, 19 Feb 2024 16:02:59 +0100
Message-Id: <20240219-add-am64-som-v7-0-0e6e95b0a05d@solid-run.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKNt02UC/33Q0UrFMAwG4Fc59NpKk7br5pXvIV50beopuE1WL
 cph727OAXGW4U3gT8hHyEUUWjMV8XC6iJVqLnmZObi7kwhnP7+QzJGzQIVGgQLpY5R+6owsyyQ
 teAjeOIpJC155Wynlzxv39Mz5nMv7sn7d9ArX7g+k/0IVpJIxekgDovOUHsvymqNcP+b7sEzii
 lXcAYANgAyA7i2aLhjswxGgfwEuDaAZwGR4pKNVNBwB5j/AMGBTPwL6ZMnBEWB3ADTPrJYBNyi
 KDhDQHF7Q7YH2go6B0Q4URxxDH3QLbNv2DbtbC1vxAQAA
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Josua Mayer <josua@solid-run.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Suman Anna <s-anna@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, 
 MD Danish Anwar <danishanwar@ti.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: TL2P290CA0016.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::18) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|DB9PR04MB8431:EE_
X-MS-Office365-Filtering-Correlation-Id: 82127d71-995d-42e5-1a2a-08dc315bf51d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Lmk2xJY/ILPfzIpXlKCnEm29lNK/SY882MUryrs87LxNnweMpm5/15nHn3tB5Cr1LHkKTRfHY6pLU1fnMogAeo5iWAD882k1/z783sgzpbeBrMqVvzlf6EdYuNi32M2QsB0ZREIWDUj7JLM1JQZ0p9l7N9hDdYns/dgjiDqunIhuwMKDAiEH0e7B+wRnyVfQhs767UxQeMD2d1HqfhLSgPcKPLqmwJXMvuGk6UZA3finlcQY/qJBUTI3nY9Kl6EcLLvP63Qzqb97T1IM4/Nhl0GvJoePAg0zCqHunqKO6KXLgD8hTOk9v7/j/HOi8ZSvYPsQpfgjglxRe3gQwaen0wyhHallpcb5cMF/dBYTwBnLnELzmr57Wvk+ER9HWpiXXuEGc2j/e2cdNWdsiyPqwmlOiBvwDWzXGJ+c3GN542pi/yF7c+gPB5Di5DlLG9sNI8/PuGyTYqH69uhYdPLCl5DastJSyOlm6gzUpEhUqtan8Nikev2NxYeRu/WjBggbXMlOFZdkr4XUB+79fZA1w1+xhyBkFvwfq0F8lUX1E3M7qNHFNoCNMqk+Eo4rFQ5wCRdf5svsMGNrikFCNtytReGZGsF0rxe22Kor5k5KPEc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UE45L09jRWMyYlU5d3lFMXI1dDFRRDZ0NDZ6c0JVZmlpL2ZVZnRBMnRQdmtU?=
 =?utf-8?B?RlVuOTJPSUh0OFNyckpUbEFQVEtUYytSS2JqOXFnZWRrRGV4T2JsVVV3K1Ew?=
 =?utf-8?B?N2NiZXdkZmZTWFA2SFZabElta0hGMUovditnc2QybFBIZnpUd1d5b2IwVzI2?=
 =?utf-8?B?aEI0alFLSkpoeVpoWWZQLzVERVlPTFV4dVFsUmZKeFhEcmhCTGFRRS9lZzFk?=
 =?utf-8?B?M3lvbUthbHdrS09sRlJ6dFJoRWt6OEFWWkVYSFhlUnRxRTh3NEJia2QrT1pj?=
 =?utf-8?B?OFNoZHJpUTVtSEhOb3ZIQkRSZE53R2U1NVMrTSs5Yk9Cc2E4alF2K3B5dGVG?=
 =?utf-8?B?L1NzbFNJUlh3enFlRUREMWoxY2RxS1NlbDY4WkNZMnlnZ2liTjdrSG9TQUVk?=
 =?utf-8?B?WDZqSDd6SExpZ0RXVTFlQmp0MG9xelNZZmtlNXFteXduNkFia2xsTGdacGlU?=
 =?utf-8?B?V2JZV1Qzem1SeFJQdTBlNXhVY3VjSGRBdDVCUFRlSmxwVVZjM256eGZhdFFt?=
 =?utf-8?B?cTh5bENKUFZMVlFlQVhuSkc1cWlGSWRFUCtUOUpRdmc4S0x0WnpMNWNkSlp0?=
 =?utf-8?B?bk9sMExwcEs5TE0wbWtnT1R1TUhNWTFLNWlCRmJBZWl1SlFHQWxUWnJwNURX?=
 =?utf-8?B?Skx0YmxVUDFLcVI5ZDVndDBnR0tnSVZ6UWRwMldiSzVUcmpZSDBkeEdMaTdY?=
 =?utf-8?B?Y1l1Q2RZeEdEUklwYU9VQzVLTDBzSEFOcXBSenNxRXd1WE1JaVJBTGN3NWhE?=
 =?utf-8?B?TTM1WXkxc3ZBQU9sNGVDUC9DNkZjK1ZwM1VkaE85SVM4M3RNVlpiY0VYcUh6?=
 =?utf-8?B?eTdXZHdETUI3V3M0SEw0NThTemxHU0JLclZKeHJkaU1aTXI5WE1maVVkZFdp?=
 =?utf-8?B?ZzNIeWthd1haRWNxVHJ0VkxoZm0wWjBidDFkQnprTGs4VlVsN3gxN3BleXRr?=
 =?utf-8?B?cFBtdVNYRkRXWU5YLzFwOUtPcU5IR1diTkxrQktUZ0puaXFaVjB3cFE3Mk5E?=
 =?utf-8?B?ZFpEMVBRaGNxY05GM2h2MnJZTFZMYXBaTVVNdFhDWXh1Y1YxZnpZdXBkZ2po?=
 =?utf-8?B?VHhUb2RweVR2OVJWNnQwbWR2c1hDK0thb1pWZ3BwK2dRT3dsTDFvU3ZGa1pk?=
 =?utf-8?B?TWJVRXhvRC96MVJmYkNSR0xGMm1oRGJWNE54MXZFbGJVZWxIVVlBY0JNY2RV?=
 =?utf-8?B?WTVlRVlGWVFPUSt6YkxEZ2o0WEtpZ2t5L2hFdWROdDVxeEs2TC9DMWgxbjVU?=
 =?utf-8?B?RDVtM2NTdVkxSGkwd0MwMU1EOHhSTk5CQnVwWXJ6UEJLVDMyVFFrOXYyTFlm?=
 =?utf-8?B?MjdCazFyb2hKVldsRlpsSk51UENoTjB5WUowYWxFbEplcm5la1Z2amx2R0lC?=
 =?utf-8?B?b0F4azdqckVRYkVwY2l3Qjc3b3JkYkFGWHJ6R2hYbUFuNVQvUkhRS0EzYS82?=
 =?utf-8?B?elNXeGp3eGt0N1FGTzRmUTFjYkcyRXZ0MU9BK2pDTCtaWTRTU2lWcDZYTW5i?=
 =?utf-8?B?WHNxcVNFZFc2RVcyR1FnMUUyWDlzVmFoM09BdjMwZFJXQzVWdEs3TWNCR2Zz?=
 =?utf-8?B?Umt3cld6Qkt2Q2pWbnpTQTBZQmRNWE9mMnhQMUVvUFhSSEs4TzZyQ2U1Tlhs?=
 =?utf-8?B?OGRwU2lIRUlmZXZsWlUvSERwNDNpa3BoZnlncUprWUNyZ2dvbDBpd2Rrd0dX?=
 =?utf-8?B?WWZ5amxQMGc4Q0JnNm9NdGlSdW94S1dSVzNOeG94ME1ITGJmVmQ5eG5CS1JL?=
 =?utf-8?B?dkg0WGhvMVJqdE9sVWc0bUNUN3Y1d3JvU1ZQMjAxYzdESWhYK2FUaFZHbk8y?=
 =?utf-8?B?amhVaWE1VUVUUGhncEZHSTJRcVJ3d0FqbXFadGdOYVV6dElXVU9iK09ETlZi?=
 =?utf-8?B?dmVUSVNWcFV5YUVKYUF0bXFvNkIwK0h1dUdpRVRULzIyWUxlVDNBbVVvelM1?=
 =?utf-8?B?cFpPd0NLMWRlOCs4YzBnNGthdUZtQUNHT1cxRFlUOFhsWklaYU1TSHBVbENH?=
 =?utf-8?B?bENRSEJ1WTlGanU5cDM3K2owRXk3OGxpZ3o3dkZkYktranprd2dyZWMrZ1lw?=
 =?utf-8?B?WmdXSm5pV0VJbzVkbVpPS1lqMXk1bjlDMkVmMmNYalhFelUzVVFaZlQxbzNv?=
 =?utf-8?Q?ebhi3sN0PXRI8j1YAso9ZoSpc?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82127d71-995d-42e5-1a2a-08dc315bf51d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 15:03:40.4929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E9WMuLyuvpbneZ//EiU1g3l2ompSJ0zgssPvl7Gzg60427zUkijOLed/wGOhzGiy2fUw4NAS+8LEN69u9jAz1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8431

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

To avoid introducing new dtbs_check errors, respective patches were
submitted via rtc, mtd and iio trees.

Only one error remains which is common to all k3-am64:

- 'mux-controller' does not match any of the regexes

To: Nishanth Menon <nm@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>
To: Tero Kristo <kristo@kernel.org>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Conor Dooley <conor+dt@kernel.org>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Josua Mayer <josua@solid-run.com>

Changes in v7:
- split rtc, iio, mtd bindings to go via respective trees:
  - iio: https://lore.kernel.org/r/20240219-iio-hdc20x0-interrupt-binding-v7-1-c8ffb39c3768@solid-run.com
  - mtd: https://lore.kernel.org/r/20240219-mtd-flash-interrupt-binding-v7-1-206e30a656fa@solid-run.com
  - rtc: https://lore.kernel.org/r/20240219-rtc-abracon-convert-bindings-v7-1-aca4fc3b8cec@solid-run.com
- Link to v6: https://lore.kernel.org/r/20240212-add-am64-som-v6-0-b59edb2bc8c3@solid-run.com

Changes in v6:
- renamed pinctrl nodes to *-default-pins
  (reported by Vignesh Raghavendra <vigneshr@ti.com>)
  (dropped Reviewed-by: Andrew Davis <afd@ti.com> because all the rename)
- removed tabs from pinctrl comments to shorten lines
- updated humidity sensor yaml with interrupts property
- updated spi-nor flash yaml with interrupts property
- Link to v5: https://lore.kernel.org/r/20240211-add-am64-som-v5-0-790ed7121249@solid-run.com

Changes in v5:
- abracon,abx80x.yaml:
  - reworded 'compatible' description
  - removed $ref to interrupts.yaml
  - nested example in fake i2c
  - changed maintainer to rtc list
  (reported by Conor Dooley <conor@kernel.org>)
- patch 4/5 dts:
  - re-added status properties for sdhci nodes
    k3-am64-main.dtsi has been changed in-tree since v1
    such that sdhci nodes are explicitly status disabled now.
  - picked up reviewed-by
  (reported by Andrew Davis <afd@ti.com>)
- Link to v4: https://lore.kernel.org/r/20240202-add-am64-som-v4-0-5f8b12af5e71@solid-run.com

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
Josua Mayer (3):
      dt-bindings: arm: ti: Add bindings for SolidRun AM642 HummingBoard-T
      arm64: dts: add description for solidrun am642 som and evaluation board
      arm64: dts: ti: hummingboard-t: add overlays for m.2 pci-e and usb-3

Suman Anna (1):
      arm64: dts: ti: k3-am64-main: Add ICSSG IEP nodes

 Documentation/devicetree/bindings/arm/ti/k3.yaml   |   7 +
 arch/arm64/boot/dts/ti/Makefile                    |   7 +
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi           |  24 +
 .../boot/dts/ti/k3-am642-hummingboard-t-pcie.dtso  |  45 ++
 .../boot/dts/ti/k3-am642-hummingboard-t-usb3.dtso  |  44 ++
 arch/arm64/boot/dts/ti/k3-am642-hummingboard-t.dts | 292 ++++++++++
 arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi        | 594 +++++++++++++++++++++
 7 files changed, 1013 insertions(+)
---
base-commit: 83d0ff463b50d2395e05339a34e35d14ba82043f
change-id: 20240101-add-am64-som-51a1ca47edf3

Best regards,
-- 
Josua Mayer <josua@solid-run.com>


