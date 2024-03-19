Return-Path: <linux-kernel+bounces-107457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3F687FCC8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 835261C2259C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422C47EF18;
	Tue, 19 Mar 2024 11:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="SBwoWsV2"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2119.outbound.protection.outlook.com [40.107.7.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8865C54FAB;
	Tue, 19 Mar 2024 11:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710847654; cv=fail; b=Qo1UHwRGnu4yIZ9YHzgjzYMTbwPc2nD09bFLzmXmV0ZF4YQVH477p4D14wwz4ssMTf1D4hiDOaWzr8OYRYV1KWnsVKUmLF7onlSg1nvY2bKHCZjGXfhMIMQiT5xRUvPERu97PwlD8wznp4Yabdy6QHw02i9fn/gHwrncI4PJ7N8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710847654; c=relaxed/simple;
	bh=3UPxZ5pT2Vl7NEHtGSGiwPpwHDXFYG+HzLPT3D2Jifg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Zz3CVSbhXwTbV/zOzAinnqje9RLmfjOoauYUuqe40eJTC5pOWaP8i7Cnej/m6TlunVz37CQVcafOft6X5a5BlNQiG9w4ZaC0bFs7FKV4GzjXgfWKM6W8tNUpZTrql4N0pEjzDtXEnXjsxQ9CjCrTr7n4GPtY4ynvrruce6dn8lo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=SBwoWsV2; arc=fail smtp.client-ip=40.107.7.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gU7G8uSss8X9h3Ya34udjfoPejxRYD2I+y5LDWU+3FEXNSBl61QVJRLydWu5AE9cvekLnGc8qpa6zeBvhz9yC3LuHR9pv79xj+UtHUftC/MLWFyjBmYKH2hMjDZrroC0ow9L9GhTncE2OGu6GhhdJjpamGVNt2xrTcVysTesw/DA2zRj4vuvZwdsKPf9aWgSz6gR/nXLU8C8EaVMrA8AKAb6DbEFGvCabGQakKJpZtlAsz5FqMk+wraVJ1nR+svIcAdeH+N1N7T2PHQg/pWRF1TTYuqz1WBiKkEHhWsnlA8aqCYLgPQRvHUJuR34pGuha5nuA2cIW4fwFTNT4ZPMcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3UPxZ5pT2Vl7NEHtGSGiwPpwHDXFYG+HzLPT3D2Jifg=;
 b=JMi1cifajtjeC/ipze66QLorcHS602Rh+nvYtaHiEz5OA5f/4p394x1eoSAW3csoVPLb40yJK6pUaHU+jfw+uivBvU3Oum0/NLaLbjCk10q7KXVjj4LpjovS9zAXuk2Y0FHl08IWBqxyteUcQERRXDI4+OU/VLT67oNGJRJ0wtMcG9SQH6fuTfyqp3Ttfq1WB/oiYSociYa7jCVCT0JWXF242vg81lJ80EEB4gxoUUbTTwgzq9GM1ytZHfokaCd7VG/cOCzIqr635JzKxnZ5oMF71EZ61KApPztScRCTaQARvd6jF7aENR/RxaZPDUcMbZ3yNCm5cT1m2kPy1EObMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3UPxZ5pT2Vl7NEHtGSGiwPpwHDXFYG+HzLPT3D2Jifg=;
 b=SBwoWsV2ZgD7nU/y4REyqbO3K9b0zVGWO0nrsBZ0jUjbJfHvbkA7FqAO1pCAkMbgY5BnNvAdrvXFM1lGIWYCfuB19o9GpHPLljy++nQ4o/8t+m21JU9umcI2HXuWhHvPdoGcvDV8Dmn4r0zcl+8aK0LbMbAK1pp/XCn8QNhC8CI=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by PA4PR04MB7519.eurprd04.prod.outlook.com (2603:10a6:102:f3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Tue, 19 Mar
 2024 11:27:28 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::57e1:e1cb:74e2:2e9d]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::57e1:e1cb:74e2:2e9d%5]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 11:27:28 +0000
From: Josua Mayer <josua@solid-run.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>, Philipp Zabel
	<p.zabel@pengutronix.de>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: net: rfkill-gpio: add reset-gpio property
Thread-Topic: [PATCH] dt-bindings: net: rfkill-gpio: add reset-gpio property
Thread-Index: AQHaeeYnKrApPuesZEKzBgTF5sfoSbE+29+AgAARLQA=
Date: Tue, 19 Mar 2024 11:27:28 +0000
Message-ID: <32c291e3-8b2c-46e7-bf3e-bdcdf46e3346@solid-run.com>
References:
 <20240319-rfkill-reset-gpio-binding-v1-1-a0e3f1767c87@solid-run.com>
 <d096d9ea-39db-4a15-9c4d-ae228db970cb@linaro.org>
In-Reply-To: <d096d9ea-39db-4a15-9c4d-ae228db970cb@linaro.org>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|PA4PR04MB7519:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 qzCiyPWh1ljuQgYHAFyYlYd1K9jhsenz8CTvavgnzdj1ESZh9qP+Px720YL9xL1Nbj3+29Sxge5pFzfnSCkk0el82j/3yIEPOEdSPjZpUbJaIs6Jmj245Q4BVqr/HpUIZ+OwePBQqQORVojQ6SOLKk29Qatiir4v/BCXj+A71Ib0YLGqKrcN1aAIvZ7S6vT46vlE7YqdKxvzeXAArevkEp/SIPtnnoKJJofS7OUCnxA0/gUZQXm9HPqDyidds1Pv+5Yp2M+bRDKs32ZXbUCSFXWayn2u1SxSxPfBlBrvi0dbwmHI7qb0JQNPCQZbCrNIOhL7CKUShV3Wbc/Cx4Do7imx+Cm70usXe3NUe6ycCb277SK5XvM1EoyuXW1hx3R9DCo0dG4I7B+vIK+KlhzVEBucoKWmkUPZ92x/bdxA3rOUm3nejHlBm1sg/8WqMUs3sSF+ObS06saTzLtI2i7fl3Dd7Q0cOnsTqGHtHPwNtirCLie3JrRVoJexboNF017joyXKJZNbSlNOLWuxsxTr7rqKOfqaOGZbEWL3cuEc1LIInLMYk7fKncOhoI98drkIx01ZQ1Ov+OcgmpspmfFqvxJ6bqU3YLNR0Unb1rLD+gzfq3hAamgcdt+a+eTkSql5skcmAPgJc9Nd1U6prt1+RDrwt/x4zuc+DRlpDeziJA/8q2BegLvptKEXBqX1QxHbq2yKPgOfIjK3Z89NaSPI6w==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(1800799015)(921011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cExhR1pWMlRkWjVBczl4Mkd3TXhLT0NYSVRvcE9zdGQ2L3UxbjZSTW1qY05C?=
 =?utf-8?B?V2ROMHlld24zN2UwWnlSTE1yanI5TFZ2dlk2Z2VzdlY4cHhYbTNNanUrVEN2?=
 =?utf-8?B?L016VEhUYTVicEovMFRyRXZHMDFmN0tGTUpCTlZjV0Z6VFY1WVNVSGQxTzBB?=
 =?utf-8?B?MEs1UnR1dWNzNEVqMjZTWHJIT3AwWjVyYnJwMDhFMnhHZGVGT2FMbHd1emR4?=
 =?utf-8?B?aXdzMURUR1Y1UCtMdndTb3JIaUcxeXJzMk5VYTdzN0tmVDJMZGRQOVMyUDB1?=
 =?utf-8?B?VTQrZVJMZ0QzZHZDM0RIS2l6S2VJRkRGY3dCQ2kvZkdwRjEyWnhnbjFmWCtx?=
 =?utf-8?B?anlPTnZiSUxKOU5SKzVVcTNPR1NxOEVub2psVk9WZE92QWpsalJDZDZzZk5L?=
 =?utf-8?B?QS81NU1QN2tTUGZFUllxdys3b0FIQ1lyU1BSa1E1N003STZTOVJkZWZiSzFY?=
 =?utf-8?B?MzFDeERsa2JQUmZnbnpEalpMc0R2dEhqdGJFcXc4MUZPLzJLTEZJN1E4TCtL?=
 =?utf-8?B?OTYxVnNaaHN0SG9zdGxVY2JDVFRmYW0vRG5Oem5zWlFhbEl3R0JsR2pJemgz?=
 =?utf-8?B?eStRWmdZS3psVDBEUlJReUNtMXQzZjR6d0NuU3h4ckU2WXNzZG9BSnNuYWI0?=
 =?utf-8?B?ODNHQWhUelhjSjNEU1JNYXVKdVF2MzkvaFVWcVowakdldFZOZkk1dmhtOGs3?=
 =?utf-8?B?RzhFZ0FONXdiSXBkaGlQWGxSZHFxMVo2MXZXMnJicnJEOC9ja3lueTNBb1BP?=
 =?utf-8?B?Z2ozUm1DcmQyU0hBVC93NGZadnd4NFFqU0Y3NWZWOUsydFNReEo5bmR6bHQ1?=
 =?utf-8?B?dGZSZVRDMEE0ZkpsYStQcmdvdzVtQmdoNUx4UmRxbXZvRFBwazN4UzJlb2hp?=
 =?utf-8?B?WEhETmJqUmpNem5CakxPSGRVUjdWNW4zM09keFZEVzM5Ui96czZFLzVsL1Fs?=
 =?utf-8?B?d3ZWNGl5RFY1ZUhuMldRQzlBZE0vS1FGK1ZMeEJNQkd4WFUrWGY4UHhSdVJj?=
 =?utf-8?B?dU5DaTJFUitWSEhZSjEvZ0NzWFBwZTNKOWJCUDkxMnFsa1FTWDlxVWJQdHVl?=
 =?utf-8?B?cDhrMXJEQm5nL05ua1lsT05qQ2tLOVJtRVR3ekpYRmVjWUxKRmFLVnEwczVF?=
 =?utf-8?B?Nmw2NDR2L1hTMGYzQndtWWhZMktEK2lnNDFZK29CckpteUh4S0ZkK3FYZVhV?=
 =?utf-8?B?ZzZkYW54cjF0Tmo3S252ZVFQME1SZWQ1WmY2T1BTRjQyK3VMa0VoU2taS0Zr?=
 =?utf-8?B?ck5KTE9ZSVRHMHdqdU8wb1dFOVhYdWNTVWh1dHBrb2JpUGJ2MHVEZEN5Tzd6?=
 =?utf-8?B?RGtlVDMzM0wxWHBzRXpMcm16TXBJa3lPa1ZGRTJBa0RXSUEwdnFwV2Y0ZlVV?=
 =?utf-8?B?c3BpNXJKUi9CN2JrWmNjMlg4VnpISmxUTWpkbUY1S0xFM1lsejg4RVFSMGFm?=
 =?utf-8?B?T2k2WElEc2VvNUJEZkhpQ0NtY1JvQWw5dkJkYTV3aDhCTEsreUszczRqVVl0?=
 =?utf-8?B?TlUrUm8wbms2dGN4Ym43VGpKa3c2clU2czJ5SXk0b3FtamtxbVlYazN4bit3?=
 =?utf-8?B?NUdmY1FXSnVvdFBlVm5QeUorZ3BlVGhTdU1XRkN6T2x4Z096MVcrMTh6WTJz?=
 =?utf-8?B?VEpjcDl3Tkwyb3d5ZlhyN0ZrWTZ3TlcvTEZMYnQzM1hJSXFJKzcyMEZNUFAw?=
 =?utf-8?B?WHAyd3pydFpidENnZUNTMHhIRW5hdEpiMGNlZnAxNUljcENuVFRaU2JmdVJI?=
 =?utf-8?B?bnZpY0FtK2t1MVlDTFhNSTNUcXpXOXczdy93V212K2w2NTNrWGx2UEpiRnVx?=
 =?utf-8?B?ZE1ZR1VnTnh3bHJUNFBCL1ZBWGdEcUdER1ZHY2wwVFMxMU1FRHFwTWx5N2JQ?=
 =?utf-8?B?RGMveXhGVXVMR3RRTG8rK2hRWVBlYTdjeVorNGwraGxKN2FhaWJHSHo2Z3d5?=
 =?utf-8?B?OGdydGtYSFZ6NzdlUStOUllGYktMYWNIc3RVYWdieTNZQVFoN1hYUzF4ME1O?=
 =?utf-8?B?eGEyd3A4Q1Z3OW5UdUkxMXRPcXRoSUdPOVlXTUhDSHp6bHQ0M0MxeGZhNFRu?=
 =?utf-8?B?L1JyQktsNnJXcmlxbXR5Q2xJSU9sMk9laHcxbkpBVWExTEJvbEl6TWluSGtp?=
 =?utf-8?Q?KjxY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4BB6CADD3B4E0D4981897F7DD526E620@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9966be8-6634-4c0c-9a3f-08dc48078f58
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2024 11:27:28.6426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PjhSqlIXqmsibD5nKHEJALdtMzaE67u8oUpg5uq1wIzgFa/txrV8WW4ZJkni28XPkJNFlxeHFyHdNjvjZufaBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7519

QW0gMTkuMDMuMjQgdW0gMTE6MjUgc2NocmllYiBLcnp5c3p0b2YgS296bG93c2tpOg0KPiBPbiAx
OS8wMy8yMDI0IDExOjEzLCBKb3N1YSBNYXllciB3cm90ZToNCj4+IHJma2lsbC1ncGlvIGRyaXZl
ciBzdXBwb3J0cyBtYW5hZ2VtZW50IG9mIHR3byBncGlvczogcmVzZXQsIHNodXRkb3duLg0KPj4g
UmVzZXQgc2VlbXMgdG8gaGF2ZSBiZWVuIG1pc3NlZCB3aGVuIGJpbmRpbmdzIHdlcmUgYWRkZWQu
DQo+IE5vLCB5b3UgZG8gbm90IGFkZCBwcm9wZXJ0aWVzIGp1c3QgYmVjYXVzZSBkcml2ZXIgc3Vw
cG9ydHMgdGhlbS4NCj4gQmluZGluZ3MgYXJlIGZvciBoYXJkd2FyZSwgbm90IGZvciBkcml2ZXJz
Lg0KPg0KPiBZb3Ugbm93IHJldmVydCBhbGwgdGhlIGNvbW1lbnRzIGZyb20gdjEsIHdpdGhvdXQg
YWN0dWFsbHkgYWRkcmVzc2luZyB0aGVtLg0KIlJlc2V0IG9mIHJma2lsbD8gSXQgc2VlbXMgZW50
aXJlIGJpbmRpbmcgaXMgYSB3b3JrYXJvdW5kIG9mIG1pc3NpbmcNCnJlc2V0IGluIHlvdXIgZGV2
aWNlLiBJIGRvbid0IHRoaW5rIHRoaXMgaXMgc3VpdGFibGUgZm9yIGJpbmRpbmcuIg0KPiBOQUsu
DQpBY2suIEkgcHJvdmlkZSByYXRpb25hbGUgYmVsb3csIGJ1dCB1bHRpbWF0ZWx5IGFncmVlIHdp
dGggeW91ciBOQUsuDQo+IE9yIHByb3ZpZGUgcmF0aW9uYWxlIHdoeSBteSBwcmV2aW91cyBjb21t
ZW50cywgZnJvbSBhZGRpbmcgdGhlDQo+IGJpbmRpbmcsIHNob3VsZCBiZSByZXZlcnNlZC9pZ25v
cmVkL292ZXJydWxlZC4NCkFzIG1lbnRpb25lZCBieSBQaGlsaXBwLCByZXNldCBzaWduYWwgbWln
aHQgYmUgdXNlZCB0byByYWRpby1zaWxlbmNlDQphIGRldmljZSBpbiBjYXNlIG1vcmUgYXBwcm9w
cmlhdGUgc2lnbmFscyBhcmUgbm90IGF2YWlsYWJsZSBvciB3aXJlZC4NCg0KTS4yIGNvbm5lY3Rv
ciBoYXMgdHdvIGludGVyZXN0aW5nIHNpZ25hbHMgdGhhdCBmaXQgc3VycHJpc2luZ2x5IHdlbGwN
CnRvIHRoZSByZmtpbGwtZ3BpbyBkcml2ZXIncyBzaWduYWwgbmFtZXM6DQoNCkZVTExfQ0FSRF9Q
T1dFUl9PRkYjIGFuZCBSRVNFVCMuDQoNCklmIGZvciBzb21lIHJlYXNvbiBib3RoIHNpZ25hbHMg
YXJlIHVuZGVyIHNvZnR3YXJlIGNvbnRyb2wsDQphbmQgYSBzcGVjaWZpYyByYWRpbyBjYXJkIGlz
IGtub3duIHRvIGJlIGNvbm5lY3RlZCwNCnRoZW4gaXQgd291bGQgc2VlbSBjb3JyZWN0IHRvIGRl
c2NyaWJlIGJvdGggcmVzZXQgYW5kIHNodXRkb3duIGdwaW9zLg0KDQoNCkhvd2V2ZXIgeW91ciBy
ZW1hcmsNCigiSXQgc2VlbXMgZW50aXJlIGJpbmRpbmcgaXMgYSB3b3JrYXJvdW5kIG9mIG1pc3Np
bmcgcmVzZXQgaW4geW91ciBkZXZpY2UiKQ0Kc3RpbGwgc3RhbmRzOg0KDQpXaGVuIHdlIGhhdmUg
YSBzdGFuZGFyZCBtLjIgY29ubmVjdG9yLCB1c2VycyBtaWdodCBjb25uZWN0IGFueQ0KY29tcGF0
aWJsZSBjYXJkLCBhbmQgd2Uga25vdyBjYXJkcyBhcmUgb2Z0ZW4gY29tcG9zaXRlIGRldmljZXMN
CnV0aWxpemluZyBtdWx0aXBsZSBidXNlcy4NCg0KQWZ0ZXIgdGhpbmtpbmcgdGhpcyB0aHJvdWdo
IEkgYWdyZWUgdGhhdCBjb21iaW5pbmcgcmVzZXQtIGFuZCBzaHV0ZG93bi1ncGlvDQppbiByZmtp
bGwgaXMgYSB3b3JrYXJvdW5kIHRvIGEgZGlmZmVyZW50IHByb2JsZW06DQpXZSBhcmUgdW5hYmxl
IHRvIGRlc2NyaWJlIGNvbnRyb2wgc2lnbmFscyBzaGFyZWQgYnkgbXVsdGlwbGUgY29tcG9uZW50
cw0KZnJvbSBkaWZmZXJlbnQgYnVzZXMsIGkuZS4gdXNiLCBpMmMsIHBjaS1lLCBzYXRhLg0KDQpQ
ZXJoYXBzIGFuIG0uMiBjb25uZWN0b3Igc2hvdWxkIGJlIGl0cyBvd24gZW50aXR5LCB3aXRoIHZh
cmlvdXMNCmdwaW9zIGFuZCBidXNlcyBsaW5rZWQgdG8gaXQuDQpTdWNoIGEgc3RydWN0dXJhbCBj
aGFuZ2UgaXMgY3VycmVudGx5IGJleW9uZCBteSBjYXBhYmlsaXRpZXMuDQoNCnNpbmNlcmVseQ0K
Sm9zdWEgTWF5ZXINCg==

