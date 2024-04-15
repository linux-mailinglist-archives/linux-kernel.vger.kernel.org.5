Return-Path: <linux-kernel+bounces-145868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1908F8A5C1B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 22:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BB341C21233
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 20:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B5215686D;
	Mon, 15 Apr 2024 20:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="Y8DTH3ts"
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.111.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A301811E7
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 20:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.104.111.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713212019; cv=none; b=nDOWqZ6hw/eMPvDK+WSqMuM+T4vGHmPhj6ksGedrkN5bQU7J0j4XUrzoPc01mx8eiXuczAIulUhy5Vo4TLM5zwX+Yu5VTlLjqpP0R1jp4xaf5hGuhbM8mq8GjM3b1CIjh2g7h/grFu9R6iqN9mykOxcHkZsy/GNDvTrfjXkOjOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713212019; c=relaxed/simple;
	bh=CDejkLz6T4P1HLzjDjpl2lyTvkERXRBDZtkdFLDkA5I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=sgkhz+Tw25d/DTS8wa47L1PfMw3v0vZWwy4HZbBvjOsb+1z7V/iQp37nnMZaE8CmkQkKymaoLLMsWkRi4r3QT+Yj80t4OQVZixuaLZddNdyKG/z4oYmtMwM8goKyCWccWC6ciPjDSuV2Z2uUMNETgJ6Ubgn2ozas+Cnr6hn4URQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=toradex.com; spf=pass smtp.mailfrom=toradex.com; dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b=Y8DTH3ts; arc=none smtp.client-ip=194.104.111.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toradex.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com; s=toradex-com;
	t=1713212016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CDejkLz6T4P1HLzjDjpl2lyTvkERXRBDZtkdFLDkA5I=;
	b=Y8DTH3ts0h4Q+8y2sMxVpgzjOxw+cv4SJXO1sSc5PVIAq09+6FugVsg0nar0kHeFotKgK4
	usU3+hS307HMJFilXv9OIOu1s+ckqUIUkidr+LcdSfC+iQG04dalcFvPxuopIAnRyDildu
	/Yylp28G2vqE9PvVYuOnmN0BUcOwhUU=
Received: from ZR1P278CU001.outbound.protection.outlook.com
 (mail-switzerlandnorthazlp17012010.outbound.protection.outlook.com
 [40.93.85.10]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-75-8tKaIVizNSC8pbWFyhySqA-1; Mon, 15 Apr 2024 22:07:13 +0200
X-MC-Unique: 8tKaIVizNSC8pbWFyhySqA-1
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 GV0P278MB1143.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:4c::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.50; Mon, 15 Apr 2024 20:07:11 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ff81:7388:f0a:3555]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ff81:7388:f0a:3555%7]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 20:07:11 +0000
From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
To: "vkoul@kernel.org" <vkoul@kernel.org>
CC: "linux-imx@nxp.com" <linux-imx@nxp.com>, "hongxing.zhu@nxp.com"
	<hongxing.zhu@nxp.com>, "robh@kernel.org" <robh@kernel.org>,
	"kishon@kernel.org" <kishon@kernel.org>, "heiko@sntech.de" <heiko@sntech.de>,
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"yang.lee@linux.alibaba.com" <yang.lee@linux.alibaba.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"tharvey@gateworks.com" <tharvey@gateworks.com>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "mkl@pengutronix.de"
	<mkl@pengutronix.de>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "festevam@gmail.com" <festevam@gmail.com>
Subject: Re: [PATCH v1 0/1] phy: freescale: imx8m-pcie: facing pcie link-up
 instability
Thread-Topic: [PATCH v1 0/1] phy: freescale: imx8m-pcie: facing pcie link-up
 instability
Thread-Index: AQHafFngyrWKa5u8Ykil67wkqf0VGLFbDhgAgAJtRYCAByPmgIAFSQeA
Date: Mon, 15 Apr 2024 20:07:10 +0000
Message-ID: <2f3826dccb20d735d8cb450ecf8b6dec7f0a99e6.camel@toradex.com>
References: <20240322130646.1016630-1-marcel@ziswiler.com>
	 <171239511427.352254.8525089049107113141.b4-ty@kernel.org>
	 <ae96ab05b47f9788bce1c8df5a795b35e16a629c.camel@toradex.com>
	 <ZhkZ7R7E9LlfZX-l@matsya>
In-Reply-To: <ZhkZ7R7E9LlfZX-l@matsya>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0683:EE_|GV0P278MB1143:EE_
x-ms-office365-filtering-correlation-id: e6a6f711-be97-4173-bc81-08dc5d87a298
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: Cyi49Z0/tp/sRboNo9OFV1fE8wGsHfTXsXL3FqtUsCxqJ/YutAdfuoZcln9wLCpA2HSBJf4PPwfLuk+vEyjgrGbZcQisJtNyrFDr/TPShDiAt1ooOe3euyyYhT+jDSopBzmc6O7YfhnO6fgCPdBdu8bE27F7NICigy1kO58IiNxu9ZVrx08fYGVGRYyhm/7tYkbF2VrkoYlZ5p7VqPhhV1zkfsAN6AXCsmaQOI9lL/MBK3MNQRoqFMCdAF3myNZ6nkn/EFlBTq/4IZRxdgoCLiGVRslOozmC47QswX63sS+AOCdtr/KtDOz5MlJZ9oyJKP4TrZ35CdfIJeafuQnaBkgSuAPPQYWky06nfUITkrGxLx+cwdmXFLj/shaVwIw1RA/XBJl9UZKqTodH2Ukz7jexikXSE5uNOsZJotGF3rHYTmVlyHR/4TNPe1VzeUeaB/ktvvnG7ek9ZcvkdNjm2mk/KvkzRQvtlIgkxJnzMjl+rw6tqE/PM7hvQudDWstuSfik532YmIVRJedtY8qT200WSigfrIm7gl7Bk6qkFFNYyTLsmfcMbeSbj2WSeMnRbL2A/TyrwQMhfpyyUvy8WiP7iYkGCte3kZScan1QUPyyX59nNJGbS2eD6eQVayXQXlKKuELRhOwnMqLM19d9Kf/s2Lfp2esdmu4D79qk3L0JmE5wker3KwThv9tFWeYummVv2nthanJ/4t0F+zkM7H8GH+W6vG3v95dCmF/07E0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1hwdlBzdWRac2V1czZ4eVFoTmNNSGJ1WjR4S2RNdGY1QjRpL3hmVXJZZWEy?=
 =?utf-8?B?dlRBNGVsYlB3RUN6THczWG10aCtiR0pkSFcrRnBvekk4aXlpRUxlQ2VRcnFP?=
 =?utf-8?B?SFR1TG94czZpZGlXcE1FY05BdUVpMjducHByQVB2Ym1jaGVmZUw0aFNpazEw?=
 =?utf-8?B?V1NtalpyZldOc2VMOWd0Q3lHbDZvK3hXdEtpblNid2dJbWp5em9aQVBtZWp3?=
 =?utf-8?B?SW9TYTFLSENrSjFLYXVjUXlyWWNUcU1oL2c5VmhZQStnWS9BdVJ4L0Y5djho?=
 =?utf-8?B?K1R4R0swUzcvR2dQYkxWYTZYUy9SZG0yKytoVDEwajNmNnQ5MForbXlxTncr?=
 =?utf-8?B?N2Z0WnpUUUZCd01pUndpbTFaaWozTzVXOEVwMUhmcDVZVE5GMlkyb0R3OXRR?=
 =?utf-8?B?N1c0dnZBVDI1emVmbTJFdXkvU2JzSFhoeVQxdDRjbXMzY0JWRWVvSU53a2FZ?=
 =?utf-8?B?R1gwUm9JSk1MYmduVGM5bHlwS3g1ZG1WbFdPcDJBRnhNZy9NaktFbjl1Tkw5?=
 =?utf-8?B?VDhVa2U5MHN2SEMrN1ZXOUk1cFRXWXBCUWZaa2JOVmtXS3VwV29Ua1hZMEVL?=
 =?utf-8?B?ZVVHbDYwSXBSODg2NXV6Vmd0Tzg3QWxCemY1SWx5UHpRalMvSDM1TS9qMlZ0?=
 =?utf-8?B?ZStZSlBqVWFiMUFYMmlESDNhN0hOc1E2M29BTVBwQW15YTZ1QmpUdlJoUVV0?=
 =?utf-8?B?R1F5bHpRdWpWT2RVdC9oYXpWeFNXTVJxY3ZQSTBMWU1Odi9nZCtiYkR4L21x?=
 =?utf-8?B?UW92UUl2a0NZWlhiSkVOSzNWWEd1SEcvN3NyRzJmOGhFZVdmMCtjdm9XRFRm?=
 =?utf-8?B?bm4yVGZob1Z1bUZ0YzF0QnZZbTlIaC9iM2pRVW1kejBZYktqSFRxVzFZRWlu?=
 =?utf-8?B?TlZSMnBrU1gwQmU2N0pOR3RkOTdlcFJNR01NUXkyeXZqSDJVbDZ3Qk52NkdR?=
 =?utf-8?B?b2FlOTJIUEhyaTJIc2pEOEQrdzBlcS9hQXk2SVJIZk94Qk9JRGNuU2NneFV4?=
 =?utf-8?B?UXpiblVob1dYV3NmQ2hQbndybGQ5bloyRlNPeS9jTkVOa1hWRGNldEpyVjJt?=
 =?utf-8?B?ZWtuZUV0YS9lM08wdHlrSklNS3lMYkNpNWVJcm5Tc09WYWJrR3NKVnlzTlVX?=
 =?utf-8?B?Mm9sZ1o4bnZ3V1IxbkY4VW9UUURiR1N0ZkgwNkpvWmhvbkVzckZtWkJvWDk3?=
 =?utf-8?B?SlUvays0MDlBcXIwUnE3b2pkb29na1lObnNGTzVsbWhzblJTUTB6Vmx1dHA2?=
 =?utf-8?B?M25ONEloQllNOTVTcC9HUzhtMXVWQ2xqWFB1cDRsK0VNRnFESFBpN3RJbnJN?=
 =?utf-8?B?UDdRNlNkS1l2cU9YY2hEUkR5b3hOemhiMUcrMTVvUU1ZbTFDL2VCQU9iSWRn?=
 =?utf-8?B?VHMwREM4NVQ4cFN2ODArWmFyNjNkRm90bmpSaSt1L3NXbnJDZGVnUCtxQmdz?=
 =?utf-8?B?NjQ2bHRkRUJ4MTVVNmVPbEFIdk9mVVpIUHo1R3JkTjhLODBQSXZFbitIb1M5?=
 =?utf-8?B?aXYyMTl5cU1sRk8xQ1RjQ2RjcVdsd1AwTzYrN2d5ZHVKUC9VcStiSmJwKzhN?=
 =?utf-8?B?QkhocDFOaHFRbU9BTXlDeG40WVNtbitRcmVxK0o2Y3IySDRnU2owbE9JenVL?=
 =?utf-8?B?bVN2NnJnWElIdEpnTXU5U3JXV2psZ3A0ZXpBQ0hOaDM3VXlKVS81eDZVY29G?=
 =?utf-8?B?WllhbE9ncGFUb0FqSUlwelVGUlBrSU1reEdra3BsRkswWkg2WGNIa2VFOTJ4?=
 =?utf-8?B?NXd4SFlKT3VWcmZ0Q3lVa2Q3MUtJdTlsQ3lPYk81T2gveE1pTXp6T0pNOVUy?=
 =?utf-8?B?dnBHaytqampEa2pRb0pybm5iWXBxV3Y0QSsrZ1pSY1BIdWlnSmUyNjJLZTVp?=
 =?utf-8?B?SGpJd29ONHZFRnJXL3NJN1Z0amVMcXo5ZVJqcEpXQ0V0QUoyNTMvSVhPTVBR?=
 =?utf-8?B?bkhUUldBaVhpdmxTVmdTdmd2WXMrVThsYVFhbXdSMUg4M3ovejk4aGM5Y0tr?=
 =?utf-8?B?L0ZEVmEvZlF0UjBaY1pzZ203RmR2T0JXb1U0SXlXL2VPSEdWa01QYldnZ1NL?=
 =?utf-8?B?REgwOTNURDFrVS9iRTE3Ri9BUGd5dVZQS2U2SUNTQlNFV2k5ZVhzNTFpWjVs?=
 =?utf-8?B?Q3ZZSVpJYmlQcjZWelJRWFhhMFJaNTZQcnNVdlI0NVlIWDJmTHJvYXU2aG01?=
 =?utf-8?B?MkE9PQ==?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e6a6f711-be97-4173-bc81-08dc5d87a298
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2024 20:07:10.9127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1RkcqiserVlBgO7zkKnWkAjbCfbASNMDdPYVrD2OgKCzQazISOLtm7g6v3T2QPy0VoLNlrriLRwJxYE1f+ebM8w/o9W98pat2MIe2ZMi/+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB1143
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <DDEC3B1660CDC74E8DA8C2B9D4C33EB2@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64

SGkgVmlub2QNCg0KT24gRnJpLCAyMDI0LTA0LTEyIGF0IDE2OjU0ICswNTMwLCBWaW5vZCBLb3Vs
IHdyb3RlOg0KPiBPbiAwNy0wNC0yNCwgMjI6MjIsIE1hcmNlbCBaaXN3aWxlciB3cm90ZToNCj4g
PiBIaSBWaW5vZA0KPiA+IA0KPiA+IE9uIFNhdCwgMjAyNC0wNC0wNiBhdCAxNDo0OCArMDUzMCwg
Vmlub2QgS291bCB3cm90ZToNCj4gPiA+IA0KPiA+ID4gT24gRnJpLCAyMiBNYXIgMjAyNCAxNDow
NjozMSArMDEwMCwgTWFyY2VsIFppc3dpbGVyIHdyb3RlOg0KPiA+ID4gPiBJbiBvdXIgYXV0b21h
dGVkIHRlc3Rpbmcgc2V0dXAsIHdlIHVzZSBEZWxvY2sgTWluaS1QQ0llIFNBVEEgY2FyZHMgWzFd
Lg0KPiA+ID4gPiBXaGlsZSB0aGlzIHNldHVwIGhhcyBwcm92ZW4gdmVyeSBzdGFibGUgb3ZlcmFs
bCB3ZSBub3RpY2VkIHVwc3RyZWFtIG9uDQo+ID4gPiA+IHRoZSBpLk1YOE0gTWluaSBmYWlscyBx
dWl0ZSByZWd1bGFybHkgKGFib3V0IDUwLzUwKSB0byBicmluZyB1cCB0aGUgUENJZQ0KPiA+ID4g
PiBsaW5rIHdoaWxlIHdpdGggTlhQJ3MgZG93bnN0cmVhbSBCU1AgNS4xNS43MV8yLjIuMiBpdCBh
bHdheXMgd29ya3MuIEFzDQo+ID4gPiA+IHRoYXQgb2xkIGRvd25zdHJlYW0gc3R1ZmYgd2FzIHF1
aXRlIGRpZmZlcmVudCwgSSBmaXJzdCBhbHNvIHRyaWVkIE5YUCdzDQo+ID4gPiA+IGxhdGVzdCBk
b3duc3RyZWFtIEJTUCA2LjEuNTVfMi4yLjAgd2hpY2ggZnJvbSBhIFBDSWUgcG9pbnQgb2Ygdmll
dyBpcw0KPiA+ID4gPiBmYWlybHkgdmFuaWxsYSwgaG93ZXZlciwgYWxzbyB0aGVyZSB0aGUgUENJ
ZSBsaW5rLXVwIHdhcyBub3Qgc3RhYmxlLg0KPiA+ID4gPiBDb21wYXJpbmcgYW5kIGRlYnVnZ2lu
ZyBJIG5vdGljZWQgdGhhdCB1cHN0cmVhbSBleHBsaWNpdGx5IGNvbmZpZ3VyZXMNCj4gPiA+ID4g
dGhlIEFVWF9QTExfUkVGQ0xLX1NFTCB0byBJX1BMTF9SRUZDTEtfRlJPTV9TWVNQTEwgd2hpbGUg
d29ya2luZw0KPiA+ID4gPiBkb3duc3RyZWFtIFsyXSBsZWF2aW5nIGl0IGF0IHJlc2V0IGRlZmF1
bHRzIG9mIEFVWF9JTiAoUExMIGNsb2NrKS4NCj4gPiA+ID4gVW5mb3J0dW5hdGVseSwgdGhlIFRS
TSBkb2VzIG5vdCBtZW50aW9uIGFueSBmdXJ0aGVyIGRldGFpbHMgYWJvdXQgdGhpcw0KPiA+ID4g
PiByZWdpc3RlciAoYm90aCBmb3IgdGhlIGkuTVggOE0gTWluaSBhcyB3ZWxsIGFzIHRoZSBQbHVz
KS4gTWF5YmUgc29tZWJvZHkNCj4gPiA+ID4gZnJvbSBOWFAgY291bGQgZnVydGhlciBjb21tZW50
IG9uIHRoaXM/DQo+ID4gPiA+IA0KPiA+ID4gPiBbLi4uXQ0KPiA+ID4gDQo+ID4gPiBBcHBsaWVk
LCB0aGFua3MhDQo+ID4gPiANCj4gPiA+IFsxLzFdIHBoeTogZnJlZXNjYWxlOiBpbXg4bS1wY2ll
OiBmaXggcGNpZSBsaW5rLXVwIGluc3RhYmlsaXR5DQo+ID4gPiDCoMKgwqDCoMKgIGNvbW1pdDog
M2ExNjEwMTdmMWRlNTVjYzQ4YmU4MWY2MTU2MDA0YzE1MWYzMjY3Nw0KPiA+IA0KPiA+IFNvcnJ5
LCBidXQgaXQgaXMgc2xpZ2h0bHkgY29uZnVzaW5nIHdoZXRoZXIgdjEgb3IgdjIgbm93IGdvdCBh
cHBsaWVkLiBJIGJlbGlldmUgdjEgYnV0IHRoZW4gb25seSB0aGUgY29tbWl0DQo+ID4gbWVzc2Fn
ZXMgZGlmZmVyLiBIb3dldmVyLCBwbGVhc2Ugbm90ZSB0aGF0IG9ubHkgdjIgaW5jbHVkZWQgaW5m
b3JtYXRpb24gb24gaG93IHRvIHByb2NlZWQgY29uY2VybmluZw0KPiA+IGJhY2twb3J0aW5nIHRv
IHN0YWJsZSA2LjEueC4NCj4gDQo+IFYyIHdhcyBwaWNrZWQsIHlvdSBjYW4gY2hlY2sgcGh5IHRy
ZWUNCg0KT2theSwgaG93ZXZlciBpdCB1c2VzIHRoZSBjb21taXQgbWVzc2FnZSBvZiB2MSB3aGlj
aCBpcyByYXRoZXIgc3RyYW5nZS4NCg0KPiBTb21laG93IGI0IHNlbnQgZW1haWwgZm9yIHYxIGFz
IHdlbGwNCg0KQ2hlZXJzDQoNCk1hcmNlbA0K


