Return-Path: <linux-kernel+bounces-102790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6776087B754
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97850284F0D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 05:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146B3CA6F;
	Thu, 14 Mar 2024 05:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aa1aYvWb"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2077.outbound.protection.outlook.com [40.107.7.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916F1947B;
	Thu, 14 Mar 2024 05:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710394855; cv=fail; b=gfku1mOJf/XHn+YYKDSy2QmXIf/12477sYjI9jDvOV2uSroWWI4KDwy8S0tMy5qXEebChdXrZJKojUMCQoH+G+qvEHCoC5vuphEoO7DFIKjFutSmNKYvsx+XL9WPX5yyGFjqD/aLVkEtFl/qRQB9Dd5HHXGp8RRF05RqJ3AK/qM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710394855; c=relaxed/simple;
	bh=noEsJPxyJz7aEJvNIwrpW7GFv40MRG0nwZ0RaDroAOE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=adptLTFlGEemoildK54QhuTI2RT9RQglh8AL3vynPsVSo9CKDFyM06Ku96C3nK0DgbWR1eWRLkzgGWIoA+IOe5Y62HAQsyW2HOh65UgomYgWmY+XOZ/rfiBc6CecufPacrM+BR7VhSQ/H+j8dZllJn5GCMGYNxD+2lfyyidiics=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=aa1aYvWb; arc=fail smtp.client-ip=40.107.7.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MfU040ZZwFH0nX5rFcHM80XW+gPjO/9CwSTdtxcuRnTLtkPNxBDpKI99+40X2QuhsY95HB6pLHuPjPdWIOHtfPbljfFO37Hxx4JClmFkR0OjTRqc5YFyyPzNd03hctTS1CbEA/A+2oLlhVXOXj3QRDs0cjIVoKAlzwfM9xkMm+ofHizWR9/Qw3Lwxo/CsqrTSjRCqFWmGG925W6bJMCUI3MfvuFdPuybE8smebPGZof8NFV59LIQc1VD1vVrlqZmLR3BFNknOQ9+ofxvpYm/ZtfV0oe75QM5e1oI4uSVty1Zovg9XRcoI2pm5+vmxFAgLYkR3hRPLrJYL9WTAaiN1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=noEsJPxyJz7aEJvNIwrpW7GFv40MRG0nwZ0RaDroAOE=;
 b=eIO+vKZ6nQ4cNo/62oCQqoJykLItEHtxJwEg6xuCJUKtYICGhsQKTNsPDev+2qANw3Q2V2nXB80yHX4hxX/vTVuVqYKWGtkBm6ck7MMt83d3pDQXoi8jLE+kZ652VOvCdYvcZ2BwUHE5OczIHFPyXFu0tOidmWrGr/pcc0n3Ga+LbwIYV+Nuv0ynYJdlfn4UUbwQEt7U9/FwC8QrYzmtvMuM44qIIf72JU7q7tHQ41PLCOOZZ4vmqGTlWHRR6Lb0vRKZlcLivsVyyLMqg0wRW+7dwWJyUzKPJsmYW0rX9hV/13KaMir5srra6qX+M3zuqRcbWfw6jK5gbAImdLzEMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=noEsJPxyJz7aEJvNIwrpW7GFv40MRG0nwZ0RaDroAOE=;
 b=aa1aYvWbgryQEvgnMwYlSkAhxx+jn5SeKN9UqODnDBcn1AWfqQxCVbDelocPd5sWxxHmziJr9tgjiVcydCGHKTu+UQLjmVUrZkksrAx7mr8k2/5vE6TUIPIJ6ATmekTtdXOuMraUfzlN0gmDPdf90X/9Sd7OO0yumYAo6NMTtmM=
Received: from DB9PR04MB9377.eurprd04.prod.outlook.com (2603:10a6:10:36b::13)
 by GV1PR04MB9133.eurprd04.prod.outlook.com (2603:10a6:150:24::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21; Thu, 14 Mar
 2024 05:40:47 +0000
Received: from DB9PR04MB9377.eurprd04.prod.outlook.com
 ([fe80::b3d4:17c4:91b7:101d]) by DB9PR04MB9377.eurprd04.prod.outlook.com
 ([fe80::b3d4:17c4:91b7:101d%5]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 05:40:47 +0000
From: Joy Zou <joy.zou@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: Jacky Bai <ping.bai@nxp.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
	"broonie@kernel.org" <broonie@kernel.org>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
	dl-linux-imx <linux-imx@nxp.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v4 3/3] arm64: dts: imx93-11x11-evk: add pca9451a support
Thread-Topic: [PATCH v4 3/3] arm64: dts: imx93-11x11-evk: add pca9451a support
Thread-Index: AQHadb68BQqbsjtWwU+xgaNg9wK+j7E2mBkAgAAfRVA=
Date: Thu, 14 Mar 2024 05:40:46 +0000
Message-ID:
 <DB9PR04MB9377986A098C6A1740A9BE52E1292@DB9PR04MB9377.eurprd04.prod.outlook.com>
References: <20240314032923.2360248-1-joy.zou@nxp.com>
 <20240314032923.2360248-4-joy.zou@nxp.com>
 <ZfJyaFUxwMq20XMd@lizhi-Precision-Tower-5810>
In-Reply-To: <ZfJyaFUxwMq20XMd@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB9377:EE_|GV1PR04MB9133:EE_
x-ms-office365-filtering-correlation-id: 71cb1047-c890-4fbc-ef93-08dc43e94c87
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 bZApyHsOoqmvQTsuAkc41QWqXgKyl7VuZXLeAh9xbWiUTaUdDbgOqVgtRSWWfjro+ubZxilnPn82Iu/U/GnPeL5CcNPSuH908LoU3xwP0bOt6UuqQHFC30OdfEBBt2gw5b69F1VrlvLmJZLPOHwkux0VmeA9OFf/pUfBHprupPOm9Ykmi/v4iNXPvlWktRiaa9Cew1oh5GKa6KhamXXYSay2VHb1mvZGplsLre8BTccpiSiWdQDE5x57BKyvIhy93hOEht71efjAhOlckMY+2bhxJ86CbKGOR9g1I2yos/Ho0T4QmYo8kUE7TdeGXbiC/WViwPzLz4r/5Ep0rXCOMBtjc56rL/5+JntBm+yc+4eSP44XI7em3yHxdhWmKoSrb5h+ClbZgNTq6Zr9y6vSiUexQ0ytUAZIfvCFKV/3pbxodTb9ZZjdH2rADbwk5CXoiiWDFuYt9APHnYVHx1x5bqyestVrudqIJAnwORCtEPScYvo0pQh3cAARvwvknlde/CFnK9/thm3Ka6ko8INaUVIm86fKAUVvlAS8bIdmLRnet/tB6UDU+2UyOpdkdFO95ogZ1J6N5v3H+GzEbsiSj/EHm79AOziyIhUE+rSh/tJil3VGfmjWjUwb7FiHjtpaUCBQsNaAHP58EmIcIxPFLoLghUYmA9frrLatfAyn1L7dRojiIODHrLRyf6NqHPMzXXwuZQZo33y4rRJa659QqXiHydU+Co8Di9SbUa2r2vI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9377.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?VHBFMGJjVWtDZTdYc0NPOEVYd21odXZyYnFiRDNqYXJhVTdNdXRhVUttTnVk?=
 =?gb2312?B?K1lMTVJsOXU1ZE5TZUljdWZtclErOFRmMFpEM2xHUGk1NXFCMTgvNVZPbHhn?=
 =?gb2312?B?eUFzWXZTbkZYcDN2Y2pXR0lIWXNyWnRveGxDY1hYYUlZUCt0bkovS2RTUEQ4?=
 =?gb2312?B?cUdGM2dpUWl3TEw3V2RTMHhYOW5iSkw0M0YyVURNRTgrbjZOaDkxNlN2djMy?=
 =?gb2312?B?VS85MDJpbW1IeXR1akdWdGNqUE5BNFZzcGo5ck05b1hQdXFwNVd6RzlvYkpx?=
 =?gb2312?B?QWJlallKZVNtRm9pa05Fc20rTTM1WHZKOTY1VlJLM294YnVIT2o2ckdxODBy?=
 =?gb2312?B?WGlOQlBVeVFZU0xmMXY4TkF2QU9NbGlWMmlsT1VUbHE1elJnaENZUG9DRmFQ?=
 =?gb2312?B?WnFmaE14RmU0ZGoxUjd3cncwbUNtT0QzOW1OcHloY0NkdUZOeDVabVZTaFBF?=
 =?gb2312?B?MVdZWlF3QVF0Yk1JbU1CaWVJU2psTnY2UTl4c2o3RE9YQmE1TTRBTWc1UnZs?=
 =?gb2312?B?V25HbkgvZzF4dHRsSEZHUlI0TGd6aXM5YllBQy9CK1VmdHdGSXYvQjVBUXdC?=
 =?gb2312?B?ZEtjSlVEVUVBTUpydmpsckN3b3VEZVVUaVQ2NkxlOTE4bUxMR0ZydHo0TFNH?=
 =?gb2312?B?Q3JQVjFxVVliSFFnMElHRklrc2Q1SDJ4TEdpVElONTVUa2NhMmtUbGJxR2Va?=
 =?gb2312?B?dnI0MDAvZ21hbTA1NFhsUHdtYktBK1JCQ0o3MVVGRHZiVEZsVStsVEh0NHlU?=
 =?gb2312?B?OThBOWRSMWtkREpZZUR1aGdOcXdaTVBJbWpTdDBKOXQ2bFRmSTNEcy8vZG5Y?=
 =?gb2312?B?Zi9RZmxPNEV4bTdGOUd4OVNOSStIZ2RRc1A4ZWZFK1pva21oTk52VlgrenI5?=
 =?gb2312?B?TkgraTFvdkFvdXhUM1hwTzloaVNuVHZjUEZNRVNYUk1PdlpyM2lNbXhzWGxZ?=
 =?gb2312?B?bDFmdXB5MUQwU3AvbE96OXduUEEzWHROUlJheGcyeXZJeTJOQm1NTWNTQzFL?=
 =?gb2312?B?d3ZEdlJpdWE1WTdKR01SMURLN0EwdncwVW0vZmVWY0JSNGc0QnNpS0s0aWNN?=
 =?gb2312?B?b2I0RDdGQmh0V0o2QS9MOFVOczhMb203aFBrSlVmYWFPZENETXUyNjNHSG1k?=
 =?gb2312?B?c2JTcVUzVWk5Mmc1TVJIa3Ezd05DTlZYaXFVaDE4NGRJYTB3NVVxYTBGcXgy?=
 =?gb2312?B?TU9mdFpZeE0xVm5GTnlBTW5PL1JIRHBRU2c2WVZuYnlSMnRPYU5Mc1BkMytE?=
 =?gb2312?B?S01ZUzd1TEFYQit1MVVGVnlwOU5Dc1NDeDV5ZjE3U2RhUktHN1ZuUVN5alE3?=
 =?gb2312?B?Skh4dktGKzdWUmdTOURFSDdqOGFBb3VvOG94ckZDMkhEVE12OXJ5OGxrSkVD?=
 =?gb2312?B?VUlzV0xidHByYzhmLzJveEFKSXBvZTRJaThmVnUxVi9HVE8vS01oeHlLZWho?=
 =?gb2312?B?OVJQeXNRVnVZTjA1VEtORXlCYWFyQ1hkNHU0ZVVJZjR1V2hOMjNmY3J5VXdF?=
 =?gb2312?B?MzJadFZnRDZpamNTM1E3bGxHNkJqMFZkUUdyRWVmemxKTXlyVmsyQlJ6Qkhj?=
 =?gb2312?B?UDAwdzNrVXBWanpZT1BkUzM4c08vRzg0citHM3lCazArd0V5OHZIMkRvUi9k?=
 =?gb2312?B?QXAvOGZZa2k2ZDB4d21WSDg5Ky84VHM5NWFRQ2ZXMkpQR2FSMFNHaTZ0QlRV?=
 =?gb2312?B?YmhCVy9FODhJMUd1a2FhMFd0VTNHN09YRkhFZzBVOUZVQjdaZFFaNUZKaHNB?=
 =?gb2312?B?VVpINmYyVmJGaUpyclNaNEFaVnRwM3pQUjlWYUYwR00rOXh1NmhhSzBwajAy?=
 =?gb2312?B?RndleGtuMm9aUXhaMkhLMkFVTTk3ek9BcVNjYmc4OFRQbVdWQktvTjZZWFdp?=
 =?gb2312?B?UkVCR29IWWtZS3NUa1lNY0JmRDJtL3dLcFBiTUJrZzRtbmppb2ZRK29kcWRH?=
 =?gb2312?B?MGpoNFdZZDAvNDdTcFV2S0xyTHE4ZnM4QVd4aFl4eDFocGExa2grdFhvdFFt?=
 =?gb2312?B?NXFObzRwQzdYemMyb3JUZEplRmtobkhnWHZ4U2JoZ0crSEN3blc3bVBwR2RP?=
 =?gb2312?B?ZmNIRDlwbURjbGZzWlE2MWlGcW9XaU1aRGtiOExjRHFwcHk0T3g5a3lOVHdS?=
 =?gb2312?Q?VbdY=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9377.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71cb1047-c890-4fbc-ef93-08dc43e94c87
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2024 05:40:46.9743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bV+L+8JXAeLfYYbuGT6sidBdH0iD8GRa0b7Rd1P/NElnRSVIjY1rV6cA2aUT7Ynu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9133

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEZyYW5rIExpIDxmcmFuay5s
aUBueHAuY29tPg0KPiBTZW50OiAyMDI0xOoz1MIxNMjVIDExOjQ0DQo+IFRvOiBKb3kgWm91IDxq
b3kuem91QG54cC5jb20+DQo+IENjOiBKYWNreSBCYWkgPHBpbmcuYmFpQG54cC5jb20+OyBsZ2ly
ZHdvb2RAZ21haWwuY29tOw0KPiBicm9vbmllQGtlcm5lbC5vcmc7IHJvYmgrZHRAa2VybmVsLm9y
Zzsga3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnOw0KPiBjb25vcitkdEBrZXJuZWwu
b3JnOyBzaGF3bmd1b0BrZXJuZWwub3JnOyBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOw0KPiBrZXJu
ZWxAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsgZGwtbGludXgtaW14DQo+IDxs
aW51eC1pbXhAbnhwLmNvbT47IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7DQo+IGlteEBsaXN0cy5saW51eC5kZXYNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCAzLzNd
IGFybTY0OiBkdHM6IGlteDkzLTExeDExLWV2azogYWRkIHBjYTk0NTFhDQo+IHN1cHBvcnQNCj4g
DQo+IE9uIFRodSwgTWFyIDE0LCAyMDI0IGF0IDExOjI5OjIzQU0gKzA4MDAsIEpveSBab3Ugd3Jv
dGU6DQo+ID4gU3VwcG9ydCBwY2E5NDUxYSBvbiBpbXg5My0xMXgxMS1ldmsuDQo+ID4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBKb3kgWm91IDxqb3kuem91QG54cC5jb20+DQo+ID4gLS0tDQo+ID4gQ2hh
bmdlcyBpbiB2NDoNCj4gPiAxLiBtb2RpZnkgdGhlIGNvbW1lbnQgZm9yIHVTREhDIGJ1dCBub3Qg
aTJjLg0KPiA+DQo+ID4gQ2hhbmdlcyBpbiB2MzoNCj4gPiAxLiBtb2RpZnkgdGhlIHZvbHRhZ2Vz
IGNvbnN0cmFpbnRzIGFjY29yZGluZyB0byB0aGUgaW14OTMgZGF0YXNoZWV0Lg0KPiA+IC0tLQ0K
PiA+ICAuLi4vYm9vdC9kdHMvZnJlZXNjYWxlL2lteDkzLTExeDExLWV2ay5kdHMgICAgfCAxMTIN
Cj4gKysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMTIgaW5zZXJ0aW9u
cygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxl
L2lteDkzLTExeDExLWV2ay5kdHMNCj4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9p
bXg5My0xMXgxMS1ldmsuZHRzDQo+ID4gaW5kZXggOTkyMWVhMTNhYjQ4Li41OTc0MGRmYTA1NGMg
MTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OTMtMTF4
MTEtZXZrLmR0cw0KPiA+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDkz
LTExeDExLWV2ay5kdHMNCj4gPiArDQo+ID4gKwlwY2FsNjUyNDogZ3Bpb0AyMiB7DQo+ID4gKwkJ
Y29tcGF0aWJsZSA9ICJueHAscGNhbDY1MjQiOw0KPiA+ICsJCXBpbmN0cmwtbmFtZXMgPSAiZGVm
YXVsdCI7DQo+ID4gKwkJcGluY3RybC0wID0gPCZwaW5jdHJsX3BjYWw2NTI0PjsNCj4gPiArCQly
ZWcgPSA8MHgyMj47DQo+ID4gKwkJZ3Bpby1jb250cm9sbGVyOw0KPiA+ICsJCSNncGlvLWNlbGxz
ID0gPDI+Ow0KPiA+ICsJCWludGVycnVwdC1jb250cm9sbGVyOw0KPiA+ICsJCSNpbnRlcnJ1cHQt
Y2VsbHMgPSA8Mj47DQo+ID4gKwkJaW50ZXJydXB0LXBhcmVudCA9IDwmZ3BpbzM+Ow0KPiA+ICsJ
CWludGVycnVwdHMgPSA8MjcgSVJRX1RZUEVfTEVWRUxfTE9XPjsNCj4gPiArCX07DQo+IA0KPiBJ
dCdkIGJldHRlciBvcmRlciBieSBhZGRyZXNzLiBncGlvQDIyIHNob3VsZCBiZWZvcmUgcG1pY0Ay
NQ0KPiANCk9rYXksIHdpbGwgYWRqdXN0IHRoZSBncGlvQDIyIGxvY2F0aW9uIGluIG5leHQgdmVy
c2lvbi4NClRoYW5rcyBmcmFuayENCkJSDQpKb3kgWm91DQo+IEZyYW5rDQo+IA0KDQo=

