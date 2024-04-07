Return-Path: <linux-kernel+bounces-134294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D8D89B002
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 11:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E0E9B20EEC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 09:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4494618622;
	Sun,  7 Apr 2024 09:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Fr29uEdu"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2109.outbound.protection.outlook.com [40.107.15.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBC5182C5;
	Sun,  7 Apr 2024 09:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712480986; cv=fail; b=Fpr3wB8wjhy4PBbel2IMNBJYfxYcxsmHajEN/xv0nfHLHM/Nv5ib/lGN8m14cnvAo9exxBHvKHmXGOkEBpG63u3R5/cU9VuLCDCMH7ERZ0l9jp4FW2WKDVAAdsOOebWZotM5SxLUS95GjUznabhg4pUd6iOFNXwLMbe22FzEmhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712480986; c=relaxed/simple;
	bh=erSbJal/hRImVyNAaZW0cAevQRUYCbRlXc2PaWPgdqc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B7IyBCQ1PDt+aZ7+jVhYz0/BCIuR3LzhvnbQHLoBRWgy49nqGI7Iew1PG20fWIJ/DcXinEEjNPLr2cnfozn1TbPRPlCcsujq3xf7BFhNDegs/JU75iDCt0ubkGYpRME4+vH9hJWp4DBZ5ELs+fBn3g/V9zoKft2RBlUj976LBW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Fr29uEdu; arc=fail smtp.client-ip=40.107.15.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ksuAbTK8SpllRIBCS92Bnp+2AYntxrz8XajyEX6feGpGPKB9P+fJWpKU2qEz9C4Z7YKoRlf6yzb5sL2wkWE4STvDyNQuRC1s/G4nIq3SLO45c9y8TQHLsApSQB8Xgyfjqfz8EDBkElwHjfLZRmbn48zKnPI/bTwDFq1NW2jNXHL6TRoVRByBuFJRNy98FCXa6R49sKGJaEFgZ9Qv7eqvPev/HvLG7+6XRZPkVjelMTHkH4achbnJk0rGv68AxMEE73F96dCQ6k3MEAY9Ohd3W1xAZEC7CyrrarW+Ft77KjijAJFkj4XEyv+CAn6A91aLZOPVuOPR/onddIXPQOm2FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=erSbJal/hRImVyNAaZW0cAevQRUYCbRlXc2PaWPgdqc=;
 b=mpLCTZbuTb++Flkj5GJXisDi/IlSdZjcNVoKi8U9Os4vgEOSq6Pb45pypUj6LM5/VoyTwhhvW+RXgCi4+hUnEmKinS7Ko+fMKSEb7+h3FGtEJXQo6GLawzH+qxQOMG5i+3Z/GfCy+TTrTHnfU1J7aBTNN8Au05xLNIwfCTUb/n4IsSVi/+BKZqEv7b4rhL4rGrUO+M27uKpbNR5j2JISR7JJYN2U25iioDsJnva3enuJcddyRsVRdYXgS4y+/LRqQWMn2k6/gdDd7BLnLoJxLnsXCOWiiIAD6Z6ZV99+DGIa+c+LW1BdB6GEVR+HY6FWKdiIouSSesNupUiBULlFYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=erSbJal/hRImVyNAaZW0cAevQRUYCbRlXc2PaWPgdqc=;
 b=Fr29uEduqnGwhi5DQO+J6nM17ROyCFLMifPjcbi4W0KswBYwGedWUe7NhzyPZhUJEDC0Av5b+lYugSbstcuypxVG9bHbugeg230ILyWlZBVL4XiAeUkW4elli5UA4kF3DRmc5OcJgshWZOdZ4l4Sj44hQ/IIloUtfrddUaYkRsQ=
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by PAXPR04MB8640.eurprd04.prod.outlook.com (2603:10a6:102:21f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sun, 7 Apr
 2024 09:09:41 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba%7]) with mapi id 15.20.7409.042; Sun, 7 Apr 2024
 09:09:41 +0000
From: Joy Zou <joy.zou@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Jacky Bai
	<ping.bai@nxp.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC: "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, dl-linux-imx <linux-imx@nxp.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v1 1/1] arm64: dts: imx93-11x11-evk: add rtc
 PCF2131 support
Thread-Topic: [EXT] Re: [PATCH v1 1/1] arm64: dts: imx93-11x11-evk: add rtc
 PCF2131 support
Thread-Index: AQHaiKoUV5sWK7guV0m5MBzFERT0Z7Fcg9GAgAAA4QA=
Date: Sun, 7 Apr 2024 09:09:41 +0000
Message-ID:
 <AS4PR04MB9386C629F898A8417AE57506E1012@AS4PR04MB9386.eurprd04.prod.outlook.com>
References: <20240407051913.1989364-1-joy.zou@nxp.com>
 <20240407051913.1989364-2-joy.zou@nxp.com>
 <f019690a-2397-4bf8-9472-ec38f4b94c1d@linaro.org>
In-Reply-To: <f019690a-2397-4bf8-9472-ec38f4b94c1d@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9386:EE_|PAXPR04MB8640:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 1rU4hhfW1D/+j6UcW7MmU8DNLKWol/7jA4b1QdJvoT6KPaihLY2cMA+Y0CIkaiLSdt+yZEn5qd3G4t3Zw7+uSG04AKAQT1xZlUC/A/rsTpW8+LHaNdREVNjtHtK2v0CavKDA4tL0C+0IwOlbia3+NlAAWsYL5WQAEMN9Om/wbnWxNOZ4ny0ujSoKSlkDARDy+CjhJZyFonrsRaupXcLhm769OYv9R5amu5R179RR70YpY0Hc2+RfZ4WOFVlPfrr7p85M/o516oKQ8uWkvQqgneQ8zqjz9YSNkwn0AlP5cOZFDRIYfj828twTfN3c/vN2iSwIG2WnNOOk4ZPAXl7umd8ISPXPHOUow69p25Z4GVEMVgruoimq/R6MIT7nKi3fT1NO0QOv/z7kWVSJPhj+aftewZRcIAnYGdquaY4A/JZLyDCHsylN16TLuYEP8uMM2GM3ioDe/DltNITpEiqnmIyFwF0PeGZEhKELI4Ma20c2xI8NhS3GMJN5BLftQTKejOeIVLv8sxJFzG+HK6JhJLmcVciE3YqZmretvyq+jxKEaTEKczcHQe/8gU8TefDR2pwYmw1TgGOym631i+j4d+hDIoYWtdPqRbY5qX6wogAUFnP9LJ2e7lp8oHd64vFMEGuHvfZbclXiDArx0WuWwAWnhloy/g8nQKmaZt6RuYw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a3VnNWhWVlhXenMvSW00QkhCeG5QMkdETnJDL3g2Q1VXQ21VUjlPMVZuQzBY?=
 =?utf-8?B?MzJzRHplNmtKS1c3QjhWVFREUzJPNHFxeWg4WnNMaGRzaDdMWGw1OThYZ2FB?=
 =?utf-8?B?QTh2RG82a09uMnN6eFVsVCtEMDZ5K0ROUnFRM0FoR2FCUmE4bU52R3BNZnZs?=
 =?utf-8?B?dVN0TUJtT3hiakZXWEtZQ1FnenN4WVNBaFFCYUNoQ1A1NUpPZ1NaYTh6cUE4?=
 =?utf-8?B?aS9TNXJxcDRudjFTWmQxdVJxeDI2VlhzeWw4cVBPdTVldi9BS0pwWFZnWXFk?=
 =?utf-8?B?dkNjTnZIUlR5ZXRjSzFnd3F0RkU0MFA4aGx2NWg0OHpma2NYT3NBNGVsWGY5?=
 =?utf-8?B?VG1QLzR3TXhDNWhKaTJmVXVhQm9HZEFOZ2JmR1llTkRoMCsvdXdhQkFhWGN0?=
 =?utf-8?B?OFZKYnN2enZiODRMSXV4eVlCbFZxeHVNdFYvSXdqcFNCeURKT2JXd1dieklO?=
 =?utf-8?B?K2VNWCtZSW1Dd0ZRTW5nSFRDM2MzcnR3WERIeVkwN3dkNmx6UUdLYnpkeEFX?=
 =?utf-8?B?UzhVN3BXRFA2Q0JURmhGNWFpMEJLY2lndUU4ckdnamdtUGFjY3IrRC8wbFFp?=
 =?utf-8?B?ZFpHRGllWEp1MSsvOHVoOUpiSkJGbTJZajE5a201bzljdUNDWXM1WFRST0Vl?=
 =?utf-8?B?Vm9EeWt2QzgzWE9nZENkRTh0eDdWNzRQNGFiL3ZaeXNVNTVzV005UXZuL3hC?=
 =?utf-8?B?b2pzQ2NiK2NocGg2UEpiVTdwWDlyS1l5TXhGTzRQUlZVQVk1NUlTZVRtOWFu?=
 =?utf-8?B?L1YxZEU1UVhWaFk5RFkxR1dyM3FwT1BSN2NUSVlycjJTU3IwcWVrUVpkc1Y1?=
 =?utf-8?B?YU84L3hYTnNIK0xXSDF6V1VlcVZ3SGZSY2N5c3JXTG14dStoTFQrWnZsS2dZ?=
 =?utf-8?B?RFMrRWR4SWNjaWI0TWRoSkxrdlY3SUdWQnVDOEFLcEdJVlM4cCtGZWFQSCs1?=
 =?utf-8?B?SktUYzM1R1lWbHBVSTJWOUlrci80b1AwYkhNSVFTNGdBRXU1QnFQSml0Ny9U?=
 =?utf-8?B?akJjQ2l6b2dwUWhoQVhiTTJhZDZJOUg3Q1RMdzVncWJ2YVFIcjlUdU5xU3Vn?=
 =?utf-8?B?ZDR4U3lxS1JERHh5YzlaNkc1WHBKV0V4NEdicW5rbTE0L0FzdjlXK040bW9S?=
 =?utf-8?B?VlpBaVg1ZFN4S0NyT2l2N3k5WFF5bnhwVHVyNXhYeUpaRlE1SGtwOEdzRkJX?=
 =?utf-8?B?eGNmdWxwQ3RwU0hBSGd0YXlqd1VKQ2kwLzRZcWVoVTVhUVJZWjdBTm42ZUIr?=
 =?utf-8?B?UGMzRHpzbjFsY3RKayswUTJUcWptdE1TVUxsQXdyYlg1ZmsvWkw1cDVkR2xO?=
 =?utf-8?B?U0hodTBEMklyUUNUVmpUMDJDTmRNT0VZbE5uekoxVnZKMytocGd3TXhxdVlF?=
 =?utf-8?B?VUNieEpwOVZkdktnQ0ZYQm10YVhralZkeWxHZ1lPaXhJeG1ObkhSZ3MrTnVI?=
 =?utf-8?B?V09HVEoyOVJMaFZvU2Q3VUoxNWliSklkZWNYL0FwQzM2RHpjdk1jME1Gbkhr?=
 =?utf-8?B?QzFWNmFVK0UyTkdTVjZhSndBb1Nta2d5aTdBNDROaWlMRlp6Z1lwa3JPUmZv?=
 =?utf-8?B?S1VIcHhKQUtsMTMwSzhTbzJVejl6OGhvMlREVE1IdXo3ckJKUXN4am5FSXAr?=
 =?utf-8?B?a2xHSzVBUDJwdzZKKzl2dW9EcnQ0SDNTRDI3SkVqS3lRZGRqUmFSS1FvR21N?=
 =?utf-8?B?SEZPNFRhR3NtQk9xVjg1T3JSbzJpMExxc2swZGNSSzBUTjZ1WjJDb3p3QlhB?=
 =?utf-8?B?RitZUVFDeEFDQk1qZGN2N0xjbVlqclkwd21OWFZvK1ZzL0RMN0N0MnY0c2hF?=
 =?utf-8?B?UE1NS2wwU2RRWk5wSWhrV3lGS25Nc2hzOUZONlZkdnVGMExMaEFoKzlZbldJ?=
 =?utf-8?B?bFF1N1pYaFhOMWpBdEVNdDIrUmw5bUxpNm1LN1ViR0RFVDFpN3lDOFd6a1JD?=
 =?utf-8?B?RDhWV2dORkZzb1VDckVhQjNHRFZYTVIreDhhNmsybW1vL1hSWkdTZjR5Y2Z1?=
 =?utf-8?B?RFFKdENTVndUUXNYV1RPcDUwY2o4MkdGL1B2L1pUQ0UvTDBHQVZCTDVsTW02?=
 =?utf-8?B?aWczckxJdXovM3BPVWxrc1luUEtadjFCdUtLSFFvMHNrRnVnUGJLN0RsUWR0?=
 =?utf-8?Q?FrJI=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec84a673-d2e0-462a-e895-08dc56e275c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2024 09:09:41.7741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0MWadtFS6qbZkPYHDk4KpXwTPbyGXg32HB8Vumq6YaAqbEI1HvYOTsmwNjMzQfFQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8640

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEtyenlzenRvZiBLb3psb3dz
a2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4NCj4gU2VudDogMjAyNOW5tDTmnIg3
5pelIDE3OjA0DQo+IFRvOiBKb3kgWm91IDxqb3kuem91QG54cC5jb20+OyBKYWNreSBCYWkgPHBp
bmcuYmFpQG54cC5jb20+Ow0KPiByb2JoK2R0QGtlcm5lbC5vcmc7IGtyenlzenRvZi5rb3psb3dz
a2krZHRAbGluYXJvLm9yZzsNCj4gY29ub3IrZHRAa2VybmVsLm9yZzsgc2hhd25ndW9Aa2VybmVs
Lm9yZzsgcy5oYXVlckBwZW5ndXRyb25peC5kZQ0KPiBDYzoga2VybmVsQHBlbmd1dHJvbml4LmRl
OyBmZXN0ZXZhbUBnbWFpbC5jb207IGRsLWxpbnV4LWlteA0KPiA8bGludXgtaW14QG54cC5jb20+
OyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgaW14QGxpc3RzLmxpbnV4LmRldjsNCj4gbGlu
dXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnDQo+IFN1YmplY3Q6IFtFWFRdIFJlOiBbUEFUQ0ggdjEgMS8xXSBhcm02NDogZHRzOiBp
bXg5My0xMXgxMS1ldms6IGFkZCBydGMNCj4gUENGMjEzMSBzdXBwb3J0DQo+ID4gKyZscGkyYzMg
ew0KPiA+ICsgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiA+ICsgICAgICNzaXplLWNlbGxz
ID0gPDA+Ow0KPiA+ICsgICAgIGNsb2NrLWZyZXF1ZW5jeSA9IDw0MDAwMDA+Ow0KPiA+ICsgICAg
IHBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCIsICJzbGVlcCI7DQo+ID4gKyAgICAgcGluY3RybC0w
ID0gPCZwaW5jdHJsX2xwaTJjMz47DQo+ID4gKyAgICAgcGluY3RybC0xID0gPCZwaW5jdHJsX2xw
aTJjMz47DQo+ID4gKyAgICAgc3RhdHVzID0gIm9rYXkiOw0KPiA+ICsNCj4gPiArICAgICBwY2Yy
MTMxOiBydGNANTMgew0KPiA+ICsgICAgICAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gIm54
cCxwY2YyMTMxIjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgcmVnID0gPDB4NTM+Ow0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICBpbnRlcnJ1cHQtcGFyZW50ID0gPCZwY2FsNjUyND47DQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgIGludGVycnVwdHMgPSA8MSBJUlFfVFlQRV9FREdFX0ZB
TExJTkc+Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICBzdGF0dXMgPSAib2theSI7DQo+IA0K
PiBSZWFsbHksIGp1c3QgZHJvcC4uLg0KT2ssIHdpbGwgZHJvcCB0aGUgc3RhdHVzIGluIG5leHQg
dmVyc2lvbi4NClRoYW5rcyBmb3IgeW91ciBjb21tZW50IQ0KQlINCkpveSBab3UNCj4gDQo+IA0K
PiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQo=

