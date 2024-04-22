Return-Path: <linux-kernel+bounces-152774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A37C58AC414
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 324471F213D1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 06:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B5B3FB94;
	Mon, 22 Apr 2024 06:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Lpx7wE/9"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2067.outbound.protection.outlook.com [40.107.6.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD03210EE;
	Mon, 22 Apr 2024 06:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713766663; cv=fail; b=KTOj8W9VCo9W+5AZrffQUaeDebXb1S4wwk6J6YoaXpvYNsqYRY5NuxDI9jrp83zM+ZLsYc7SdXNDCf6lI1aDFHXmYeZIOPYK/ysXm+Jz2HWihODkigMV74gr7aYh+04q5h7AV/7HBSYJiG/qUpzFWkNX2cRdZSASpuf/7tunU3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713766663; c=relaxed/simple;
	bh=zLBVGVPFlSFpCMIGW+Jn3QC3czre3rCx4lfkcY/m1Hs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GwlxTUDgCt5kP30goxKBuBQ0YTg5gcTH9T4YwUxoyq9mcpma1Q9TGXMza1J8BLd+lK3C0P/JxKlURqiUu26SKwH1BdgEKrQgoA9xyl2bQpVaVd2MA4W0JJ0b1ssKHWbiStszXg1ZBhfV6bIfh9YLZ3JBCaZ4drx913dQy4IUqRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Lpx7wE/9; arc=fail smtp.client-ip=40.107.6.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WK1nEHWl4xj2KUoLq8Bw7d8aFHUtym0RPFOxM2rxOTApgOnExpenuH7G12rYL3Q+3e/WEE9Ca1hArdt69+hrGDgZkqxowHsfaJ3JjX9uMqh/fEtixixwkbR59QVUVzqyJp7WWttqI95zRHtI0gfv1408ViARgocc14OtNUHZVUW5tYfLDhJ5qw57ZMUOVHDE4AjP4Aw5QhROhGn0zXcQgyPUQgjU12iqRtP0IsRErxDoFdvCWy3wvEg2bY09HtyuBBswdrpX8IUg3g+zygqhMNTkEtoLeP4iFPZQPPF2UzhucUV+het712SNojIkcBfGedPXSenMTCIRmneyCvFZHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zLBVGVPFlSFpCMIGW+Jn3QC3czre3rCx4lfkcY/m1Hs=;
 b=LbaYXhUwjYLjjw8V4OMDbNXhY2GRMIQKnUYh2Fvzl77FuLW6ubrWzdinIg63z3t3rkns3ZZTTYG6FoZA6RfVltXYFc1adYrp5hK+zHK+dnHDASQOA4QaR06sRuJBdqdT3lBxqYI2kAokXg1cgBc5U4THlkn3N4e4m3EQu2XcaCaE9uWjztBb2j97YvXMxWXfM9ILqbC860S7pkW54oukavs4HZVJEs/oz22MxtptV3dB6qcX9YK/G0+Lq2VL1KEiRe6NA4IwvMREnumtArdh4QwSahWvsIepxCAhN0uOvUZ346LEVrTQ2MBH5Tz7c7NLGbIRuHY08BQbZhT2F+vWBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zLBVGVPFlSFpCMIGW+Jn3QC3czre3rCx4lfkcY/m1Hs=;
 b=Lpx7wE/9kbSaWzR0Br1pywdOZxZ3kH0EamWvakwyzUwjiGgO4XgfCg5KwAHd3W8mOHehTe4BtWCm9IX0iydDmbhOQ0ZNq71YLCcxbYS/UsVOarXuvya++uKX4i8qVSKlXVDWU0hgd3xFT74IZ4twLfHcliOgCq7bvN+ugusPcI4=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM8PR04MB7428.eurprd04.prod.outlook.com (2603:10a6:20b:1d5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Mon, 22 Apr
 2024 06:17:38 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7452.049; Mon, 22 Apr 2024
 06:17:38 +0000
From: Peng Fan <peng.fan@nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Bough Chen <haibo.chen@nxp.com>, Sherry Sun
	<sherry.sun@nxp.com>, Luke Wang <ziniu.wang_1@nxp.com>, Wei Fang
	<wei.fang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>
Subject: RE: [PATCH v2 00/12] arm64: dts: imx93: various update
Thread-Topic: [PATCH v2 00/12] arm64: dts: imx93: various update
Thread-Index: AQHakgm9RgO/4kmrQUiJDQ8LKtDUmrFz1XYQ
Date: Mon, 22 Apr 2024 06:17:38 +0000
Message-ID:
 <DU0PR04MB9417A3F465F9C4801FDC013188122@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240419-imx93-dts-4-13-v2-0-9076e1d7d399@nxp.com>
In-Reply-To: <20240419-imx93-dts-4-13-v2-0-9076e1d7d399@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM8PR04MB7428:EE_
x-ms-office365-filtering-correlation-id: d54a3d17-8659-45e9-6c02-08dc6293e8d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 =?utf-8?B?d3pPRk1GcEkvUEN5eGhkVlVpQ3hUNERpTE9qaHJDSDl0RnhCNk5GWk1qSjE4?=
 =?utf-8?B?eVZlUXFZSFhWVHBaREZPUFg5VDBGa3VGL05iN0JUaE5NRzVPT2dCdkZMZ2R1?=
 =?utf-8?B?TXRmT0htaWRHVEdiWUF4TUJqMW0rdy9zRXFlblh0TUpwRlJmNXp4ODdIQ1NE?=
 =?utf-8?B?STlDdGxJNFVTekFwSzlheXIzMHhkUWkrWE9yb0wrWGNZYmNLb3ZKY3ZSYXlv?=
 =?utf-8?B?d0ZrTUVLMUthSEFneTRRU3J0L0dBTzluNHdDZnlnT3gzYlp4R0M5U3U4eWhQ?=
 =?utf-8?B?N1U4dkRlZWRNcERXcVExVFQySGc1QUpYMnNreFpkMzVsSmNYbGdxWXdpaXNE?=
 =?utf-8?B?aitYREJ6SXNOUVpWcEk0YTNTaGtRTEdIdDhTVm1RKzA0S0N4MVREMWE2MjFp?=
 =?utf-8?B?M0ZxQlZnUHRNQjg0UFM5V2FuS2tsRXVTZk5ENDJCeFUzMTVmcjRuTi9qcWE0?=
 =?utf-8?B?NFlTaUVGY2JCdGlvcnVqdGd3YjZtSXlzSTJRM2VpYVRoSHVFNlBTRm5pM3lY?=
 =?utf-8?B?UDk1bFJPNTFLbU1SZUl4STRaZGdXSHU2Q3dsN05ybnVlL3NZNFMxYWF1Q2U1?=
 =?utf-8?B?b1NjK00rU1YyQmd2QnYvc01kcFpSa1Z1alJiWk1BNllTbW9LMVVpRmx4eExC?=
 =?utf-8?B?UktvcGVNdnAxQS9nMFhMMWozNGNZWE1lanZkdTZUSCt2UG5qUFJndDNHdGor?=
 =?utf-8?B?MmVndnpmMkViVkRrWjZJUU9yL2EyZDVTOVU3UUFvL1QrRkxvaVQvWTgyV002?=
 =?utf-8?B?MzVSSmxEbGh3cS9ubWR1cW5Xb0NtQ2tnV2NEc0FMbWVXTSt3NHdIUURBM25w?=
 =?utf-8?B?ZXJ2TVNTU2EyK1A1Mi9rQmM4Y0pZa29HK1pqaWhuUWo2akFoSTdBYXRtRzJq?=
 =?utf-8?B?bVl2S3dCeUVPZjhkTm8xdWVRSFhBclFlMk9EempDeWxwaytma2U3d2lidlVp?=
 =?utf-8?B?YmFxRG9YTjVHM2k0RG40emlnS3IzRWxkYlBuMmNmME9pS2pOOVNpRmVVaWpR?=
 =?utf-8?B?TXVjTFUrMjUwVi95a0l2dFVGNmdaalFDenZPU2Y5TlJ3UkJJYVJjNERCZ005?=
 =?utf-8?B?RjNNWHhhK2RYaUN0ZjBKeVg3bjBaSkQ5b05QVWNSbHlneEdPNVJoSHhUcG8r?=
 =?utf-8?B?ZlpzQmREOG1TdkFuV2lxZ0dLVm9XeXFscmRzRDlBT2g1OW5URGN2WXlUOWMz?=
 =?utf-8?B?c1lKeFpUZWhma3MyU3BOVEM1NHAvSjBoTWpBQ2ZMTURmQWxYdHpiemVsbGdt?=
 =?utf-8?B?TlZ0YUFNUmxvU1BHNGFxdG5IajBNcTB0NmlXempFRUxUWlJHZWM4TmdVaWp0?=
 =?utf-8?B?VUhCNDV6UkdJbnF1NUdyT3hVcXdQUmVKMkdWU0hSdDRBanRmMGRHODNRbldC?=
 =?utf-8?B?TTNnK3dNNmR5dG5LbjB2UkVVUS84eW5VTC9LMDJWemlPVVhzeUNGUWU5M3RG?=
 =?utf-8?B?TmppVFkwMXQ4RnozMEowSE9Cb3M2bHhPZ2x6VXlBSEErVDgxT2pMVTY3SFZJ?=
 =?utf-8?B?RnJkZjc3R3RQMUxJb3hwM0dnajkvTzloQ3RlSk5vM2lpVmhPZkJDdytwOU05?=
 =?utf-8?B?aEt5UERUbWc2ZFNLZHZ1K004ZUkwUjZDbVBsWUpFRS9EY1lsTXdBVkdWa2Ra?=
 =?utf-8?B?NEJpdzNvRis4azJjdGFOSkhrOVVldUFaMEtqenIxVkwxbkxqNTBQeU11WHFF?=
 =?utf-8?B?a3JJZDRpZW9HUE1VMXQ3aVh4b2RtNlB1UFlzZHZBWmNQcWhQdjZnbHlwMDMx?=
 =?utf-8?B?UlVqOXF0Nk50aWh1QnhJVlladHpEcUdMRXJ5blBUSk9LZnRZZEJVdFAvenhO?=
 =?utf-8?B?RFRUMVdnL00zWlRGbytMdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SldBTFJNeEYwZW9UOGNpTzR4NmVZSVAxbVdobGtISVhCVXRRM0JKWlRyaE1v?=
 =?utf-8?B?VWlaelptejdyclNDOWpkMnhCU1ZiZndFVVRHM2MxUVg2RUcxcXNmNzM1cC9J?=
 =?utf-8?B?U3RhbjAwWkZtNVU3d1lydThXRDBIY3VQdDE5U1NuczMreUdvS1RlRFc1NzZo?=
 =?utf-8?B?dSsrZ1pYbjUxb3pPM09iR0c1dGE5ckVzUHoxZy9zb1FxOVh5dFNRb0o0S1Mx?=
 =?utf-8?B?MzJtREpNeWJFSm4wdkNIMUZTc2VBVjB0V2dGTDdXN043M1ZueXFXYnpOb0s2?=
 =?utf-8?B?dkxBQ2JoQU1pQUc5VFR3RXQrRFdVekJONVhIcjBXdyt4NzNCTk04bjdYWGts?=
 =?utf-8?B?a1FJdWtveW1RMkliZmI1ZjhOQ3lGZEkrekY2MXBaVzl1dmU2SHBsQjkwNS9V?=
 =?utf-8?B?Nmp2TytSVmR4RWRSSkVtODVQOXA1REZMSWFQWjh4QXc0elgyeE9qeHFVaG5R?=
 =?utf-8?B?bUhCc21UYVdLUEx1ZWd6VytDVlhuNVFld3JGbWhqVlpCS3Bza0FUQTV3b3BY?=
 =?utf-8?B?cDN6WGRDQUh6dGw3SWVlSkFjYk9VSlkyRmppUWhEaS9SQ2UvRGNOQzNrUTBu?=
 =?utf-8?B?WmQ1UjJjSzNoVlYxeXBFbUwvQjU0Y3ZmOFBFOHo0TnBNM1hXTmNoNVB5dyth?=
 =?utf-8?B?Z1B6Y3BPWnJ5KytDVG43ajFZejlnQm1CU2IzbUxXT0F6ckNHZUdhMHpzMC9i?=
 =?utf-8?B?OGFkTkR1V0NKRGI5OW5QZGw2MGpKd3lIS3RqN1lKZVNHQ044MFpGSmVDV050?=
 =?utf-8?B?KzZXamk2MG9WM0M4SEJ0aCtPRExYNG1RbG51dlI3SzBwUm9wSjRyOU94RXBy?=
 =?utf-8?B?ZHBKTDJpL3kyOFNVOXpDUyt2S2dmZmNqYkR3cHo2d2RSUlBydDlzeU5PK1Fl?=
 =?utf-8?B?bTFlRVVsU1N4MExYRXJjc1NPOGVKTm8vMm85NVRqQTR6OXI5aVd0OS81NWty?=
 =?utf-8?B?cy9vTXRjRWxYYjdHeEw0emRGNjdkWFBSMHZ0cW1NbWRwTmhQUEFwV2h1OUhn?=
 =?utf-8?B?SXpBM2loRFBrR3VBbnYrYUpSbVFNWERQQitTZ2QrMTE0aDB6MmVGcHVvRGl6?=
 =?utf-8?B?NEI5YkNsTnN6Y29DcE50TUlFTWlxUVBzbWg3UFRUYUxobFhiNFJTWWJMNXhv?=
 =?utf-8?B?QnQ1bkJTU29qc21NaUVqcFFWTnhRMlpPbjEySUpLM1hpcUQ4OHQyc0V4N3k5?=
 =?utf-8?B?Snp1RlZMSUl4MWVHWjN4Qy9LRitVT241SzdndE9pQXBOa0pWNi9vMHdncnNS?=
 =?utf-8?B?Q01BK2NKQVBoMUl1Q1dOZHR4QTZ0L2pUSWNySmJOaHpGMENRVVJKYUlpOGQy?=
 =?utf-8?B?eERmcXBMWEd2YjFhblJBRy9KYy8rcWxmblM5S1l6VGdpeEpTeDVzcjJmLzdL?=
 =?utf-8?B?V3N3dUwzRGNvTFczTW9ETWhUeHpvVnQ1emdCWDVLdFk0Ti9LVkxWWVJvc2VS?=
 =?utf-8?B?SCtrS1hUYUc5VzRvdHhEajF3VUY2MFFTUnY0VzE3WFYwZ2Fkc2R6cmhYOUJu?=
 =?utf-8?B?ZHd2R1ZDemdjM01iVjJieXpaYWFIT2lscWMrRzhNZDlndVJsQlVVcEZmTnhO?=
 =?utf-8?B?OTBtKzhNY2RuMnVPQllqQVM1bm0xRWo4cXU0YUppbHpicVRzSGorSDA2b3hO?=
 =?utf-8?B?OEhJZkhSM0xTb05DRno1ZGpWTHpwS1NIbVdRZkYxaWlsMUpUSi9DNlorL1g4?=
 =?utf-8?B?QTBZUlZacFRMbkxEU2xHZ3pkeUlEZlpFdEZLN05EdU1lYmxUb3hzTlpFanFx?=
 =?utf-8?B?QnBJekhjR1JnQ1ljOWE3QW9KbmhVY3pwNU1xTEViQnNqMG1XYTd5bXk1eXVV?=
 =?utf-8?B?R0RLbjZuZmhkZEFFbDJuMXRJMnFQUzVrQlRaTm13VVBEendrMUQ4cHhDRi9n?=
 =?utf-8?B?di9Bd283clVTM3FRQjlibVFrYXJPOWduOElNRndBeVIvN0N3Mm5tWmNONGFi?=
 =?utf-8?B?dEhZMHZHS1lLYVVYNjFYNmlhMWl6T0xpUVMwa1ZFcnJpYnQ1dnJsTUthTUNk?=
 =?utf-8?B?aGRhWGY2R0VEMDZkT2d3dzlwSHkyVlZTL1d0cFFDL0VjdS9HUXQrRDVTcDRM?=
 =?utf-8?B?U2h5Zm9NcHBKVHByaEI5TWtZam5BMU9oeTJDK2k0UGpnL1VUOFpySkVPeWxt?=
 =?utf-8?Q?YGGU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d54a3d17-8659-45e9-6c02-08dc6293e8d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2024 06:17:38.4960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FZ4qVlhDZoi0arQxXNjH6KQyXuNzjMNImzlYRnRJP7uVcNpgBdUE/QCqyoia+K/62/GpptQkkg+jahuroIptbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7428

SGkgU2hhd24sDQoNCj4gU3ViamVjdDogW1BBVENIIHYyIDAwLzEyXSBhcm02NDogZHRzOiBpbXg5
MzogdmFyaW91cyB1cGRhdGUNCg0KU29ycnkgZm9yIGVhcmx5IGFza2luZy4gRG8geW91IG5lZWQg
bWUgdG8gcmVzZW5kIHYyIGlmIGp1c3QgZHJvcHBpbmcNCnBhdGNoIDEyPw0KDQpUaGFua3MsDQpQ
ZW5nLg0KDQo+IA0KPiBUaGlzIHBhdGNoc2V0IGhhcyBzZXZlcmFsIHVwZGF0ZXMgaW4gaW14OTMg
ZHRzaSBhbmQgaW14OTMtMTF4MTEtZXZrIGR0cw0KPiAtIGFkZCBkbWEgZm9yIGxwc3BpL2xwaTJj
DQo+IC0gYWRkIG52bWVtIGZvciBmZWMvZXFvcw0KPiAtIHVwZGF0ZSBzZGhjIGFzc2lnbmVkIGNs
b2Nrcw0KPiAtIHVwZGF0ZSByZXNvdXJjZSB0YWJsZSBmb3IgbTMzDQo+IC0gYWRkIHNsZWVwIHBp
bmN0cmwNCj4gLSBhZGQgcmVzZXQgZ3Bpb3MgZm9yIG5ldHdvcmsgcGh5cw0KPiAtIGluY2x1ZGVz
IGEgZGVmY29uZmlnIHBhdGNoIHRvIGJ1aWxkIGluIE9DT1RQIEVMRS4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiAtLS0NCj4gQ2hhbmdlcyBpbiB2
MjoNCj4gLSBBZGQgbmV3IHBhdGNoIDEgdG8gY29udmVydCBkbWEgYml0IG1hc2sgdG8gRlNMX0VE
TUFfUlgNCj4gLSBVc2UgRlNMX0VETUFfUlggZm9yIHBhdGNoIDIsMw0KPiAtIFVwZGF0ZSBjb21t
aXQgbG9nIGZvciBwYXRjaCA3LiBBZGQgRml4ZXMgdGFnIGZvciBwYXRjaCA3Lg0KPiAtIExpbmsg
dG8gdjE6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNDA0MTYtaW14OTMtZHRzLTQtMTMt
djEtMC0NCj4gZGE4YWMwMmU4NDEzQG54cC5jb20NCj4gDQo+IC0tLQ0KPiBIYWlibyBDaGVuICgx
KToNCj4gICAgICAgYXJtNjQ6IGR0czogaW14OTM6IGFzc2lnbiB1c2RoY1sxLi4zXSByb290IGNs
b2NrIHRvIDQwME1Ieg0KPiANCj4gTHVrZSBXYW5nICgxKToNCj4gICAgICAgYXJtNjQ6IGR0czog
aW14OTMtMTF4MTEtZXZrOiBhZGQgZGlmZmVyZW50IHVzZGhjIHBpbmN0cmwgZm9yIGRpZmZlcmVu
dA0KPiB0aW1pbmcgdXNhZ2UNCj4gDQo+IFBlbmcgRmFuICg5KToNCj4gICAgICAgYXJtNjQ6IGR0
czogaW14OTM6IHVzZSBGU0xfRURNQV9SWCBmb3IgcnggY2hhbm5lbA0KPiAgICAgICBhcm02NDog
ZHRzOiBpbXg5MzogYWRkIGRtYSBzdXBwb3J0IGZvciBscGkyY1sxLi44XQ0KPiAgICAgICBhcm02
NDogZHRzOiBpbXg5MzogYWRkIGRtYSBzdXBwb3J0IGZvciBscHNwaVsxLi44XQ0KPiAgICAgICBh
cm02NDogZHRzOiBpbXg5MzogYWRkIG52bWVtIHByb3BlcnR5IGZvciBmZWMxDQo+ICAgICAgIGFy
bTY0OiBkdHM6IGlteDkzOiBhZGQgbnZtZW0gcHJvcGVydHkgZm9yIGVxb3MNCj4gICAgICAgYXJt
NjQ6IGR0czogaW14OTMtMTF4MTEtZXZrOiB1cGRhdGUgcmVzb3VyY2UgdGFibGUgYWRkcmVzcw0K
PiAgICAgICBhcm02NDogZHRzOiBpbXg5My0xMXgxMS1ldms6IGFkZCBzbGVlcCBwaW5jdHJsIGZv
ciBlcW9zIGFuZCBmZWMNCj4gICAgICAgYXJtNjQ6IGR0czogaW14OTMtMTF4MTEtZXZrOiBhZGQg
c2xlZXAgcGluY3RybCBmb3Igc2RoYzINCj4gICAgICAgYXJtNjQ6IGRlZmNvbmZpZzogYnVpbGQg
aW4gT0NPVFAgRUxFDQo+IA0KPiBXZWkgRmFuZyAoMSk6DQo+ICAgICAgIGFybTY0OiBkdHM6IGlt
eDkzLTExeDExLWV2azogYWRkIHJlc2V0IGdwaW9zIGZvciBldGhlcm5ldCBQSFlzDQo+IA0KPiAg
YXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OTMtMTF4MTEtZXZrLmR0cyB8IDE0Ng0K
PiArKysrKysrKysrKysrKysrKysrKy0tDQo+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2Fs
ZS9pbXg5My5kdHNpICAgICAgICAgIHwgIDc5ICsrKysrKysrKystLQ0KPiAgYXJjaC9hcm02NC9j
b25maWdzL2RlZmNvbmZpZyAgICAgICAgICAgICAgICAgICAgICB8ICAgMiArLQ0KPiAgMyBmaWxl
cyBjaGFuZ2VkLCAyMDQgaW5zZXJ0aW9ucygrKSwgMjMgZGVsZXRpb25zKC0pDQo+IC0tLQ0KPiBi
YXNlLWNvbW1pdDogOWVkNDZkYTE0YjliOWIyYWQ0ZWRiM2IwYzU0NWI2ZGJlNWMwMGQzOQ0KPiBj
aGFuZ2UtaWQ6IDIwMjQwNDEzLWlteDkzLWR0cy00LTEzLTYwZDkzYzlmMWNiMg0KPiANCj4gQmVz
dCByZWdhcmRzLA0KPiAtLQ0KPiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCg0K

