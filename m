Return-Path: <linux-kernel+bounces-88308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A656786DFE5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6190D2879DF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5676F52C;
	Fri,  1 Mar 2024 11:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ZidXnTeW"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2044.outbound.protection.outlook.com [40.107.20.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12B96F09A;
	Fri,  1 Mar 2024 11:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709291420; cv=fail; b=rzXadOJlGd90Ub6glxGRtApW5nSx1Uh91KmiG5frslg9k5FRVWFqSgdOxKdT6z1NMKSouwSaAwApWvKEcyV0+S/+dViqoY4qbqu5rvL91r0PaRa2bnaSWvPLmqlSfVwVgbW9Bun/Zq3+jOmaXEGy844l4POZlKPGv5xwW3rFG88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709291420; c=relaxed/simple;
	bh=rbQZUoncRl7gaqZk9HV/Dk90IdReVdtm7aBz2qhonrw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WZd9VIJGUMFtxPH/r/AL/ddGu7JGhVaRYlbLVgOczvn01HwpC2Ne857rFvH+1v57sSnKr95Ccv89UIAFLGbi8Ee2/qWEjoBoRQR/wTxmIlZQGMnSPm3LRX6NM9OmscRg2omeZEA26qQ7zSdzCfNVHMK+3xRw5C3cCNVuXDATSG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ZidXnTeW; arc=fail smtp.client-ip=40.107.20.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tjlhw8Rx/pwWkyLESJz7WUoj8F59CfVm0qQXnjFDorw09H166kpWxyTZ11J0DfUPpVrqRLEIXC0PHi1XRYe0blIwZRE/hZ/dAF5XtcG4ogyM+TWvPwTJjRtdaoWaJkRyNJeTvnlxVoEJ4xJTt+9ZjKpOlzyYjONd1EFhyKgJ6IfX+T7rKfJUKeZ67QhUivXeiX+kLwLfdRmMJ/CgHkZX/imOGqaS/nH8X++6lQ/92cynbUOvq20PZxL9GR67gRXv+dwGIE8sFEGODk5sJao2DYI6Eb/tsCJeoyiPJ8F7QWe0IoZuMuItGYu+lqRlDCf7HoychFpz4MYptvJJGS6XGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rbQZUoncRl7gaqZk9HV/Dk90IdReVdtm7aBz2qhonrw=;
 b=kNJOAtte9U++R6bhzUliUmt8tBdut/IXgsR9khwdQ2M54I5oT+YoUwfpEkytMgWvaTwQ1smjhNFpRlN4RkdHM10Bk/mYDgo+aWxOPF0GnY3FIyVlDYGPV6qPI8ZpmuF4EdfEF0RbROI+rMG9qq15rPBktUhMx4l5GTQjw7r718zM/0lJB62JH7Xp3//b/d7Ic78LP69MhH4E40vXAmiWWAjLXDgcjaT8AFK7nZO+jAw7YoD2OL7Pb7nIR3oYDa3ij6mLDAdpcr/YFb2wZsKPPuVeL4GrVgPJD690SkMgcNaii6qPg6SmRgxHczZIuiJtfAa45k8ieGZU2KEYZVv7Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rbQZUoncRl7gaqZk9HV/Dk90IdReVdtm7aBz2qhonrw=;
 b=ZidXnTeWrqwOQgVhE0l6sdFhLk7zfCUoL6wIg4d4b8RxxRAraZeXzrPdgIFdufvRvL5iTIMzGHR+GhVwwfoiwP1MrkFRF55Q03dvGRLp54d6W6Qt1YJMBmSSm+CFs5LQv4UI+fy6/nt1+A6Tx2rI3WtgAhIqJ5BaVUY6D6vc50uYKbQ2wCJZjFqsoCJSo4Bc0A3/YUwtczb1ySTR527XMTuNWFYjyQDe0k4Yb/3gBZNq0MeAb9AFxPEq17MUbTJJJGnvIgn8Hc6dMKYlx62EXGOFT0phCsvLb466cjk7u6mtoXT0vM/ccPdnbSLvz1wQ/IoybQviQ/f2hEC7d0kyaQ==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by AS4PR10MB5150.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4c1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Fri, 1 Mar
 2024 11:10:14 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ab67:6d35:16b1:81c8]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ab67:6d35:16b1:81c8%3]) with mapi id 15.20.7339.031; Fri, 1 Mar 2024
 11:10:12 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>
CC: "Stockmann, Lukas" <lukas.stockmann@siemens.com>,
	"linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rtc: pcf85063: do a SW reset after rtc power fail
Thread-Topic: [PATCH] rtc: pcf85063: do a SW reset after rtc power fail
Thread-Index: AQHaaX8AVt2JFt0PzEGKX0717h7j8LEh5IgAgADaiQA=
Date: Fri, 1 Mar 2024 11:10:12 +0000
Message-ID: <f882d7964d2d905288bcb7d01421b5eb5bd1b6f2.camel@siemens.com>
References: <20240227131436.3342807-1-alexander.sverdlin@siemens.com>
	 <2024022922080217cbe165@mail.local>
In-Reply-To: <2024022922080217cbe165@mail.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|AS4PR10MB5150:EE_
x-ms-office365-filtering-correlation-id: 433779f1-9f94-4b55-db66-08dc39e02a70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 VfPE3oQKYxbQlGvs4jiRpibBsABkmlj9GhRr1z5uFaELle+V9F7L0wqD8UkoDEIjG8DQiBF1r8Z/gvHuTEQGyIzHsWA/cj1CVOrSgjoQJs5X7hM+uj72xPaKyaAcsuShOwiwDfUvyL2EJoI60Knu4zUdy6Z3m43IwTsY57LfHyxHfokMHZcvScUukqOniiF1A/SFKrhdEnewE8qF5PNBIn1dc3TyP/QrVcwYPZZ0XC3T0yUiW6VjYq3HirEm/QPk4vbEXCH8dyRBYU94YRzvSMzw+HJU6nTUAUY5G1syFqISvgQ5aRzs8lvwvTjTXcaMrQfhiDMVPif24QrGokiYzpCof0Yc295RMGzHuLHve5y9ZXhB6Y+j1UYQwm8YQ0JF8rOKwuHPRhSIGl14wmzNQpft0TeUpH/pFtNy6ogblHTts08F8cK+CF7xzrPoeq/zgXmPHZfBj3TcSRGzK6G9e2fr27gFwRKKyXhHmhSpQE5s7kRP95kjSD8v/hnqJ5vR15X8JDmBtSI/BGu3g5rVjRMvUuvKUlM2bZebOAbjuK1lVhM0yqQD4SZGsbor4pLZwypeIIV0If3aWpiMUemgf4uR4DhI8ONXYTsYGbk7YX210ugkQHLhJqZt7OyRFwdAOOAjMOuiVPvcHR7tU1EXpxfQq+YYQHfVrTsLtAJrr3I=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SHczdms5My83c3F6WStuNWt6Zm5pQVNNVmRVVHFLaXAvaVNNVDE5dmp4MW82?=
 =?utf-8?B?U0pUSUF6Uk5BMlhMaXpJazN4dWtUaWVMYzBqZzZDY0JjamxXaGlvTlFPZzlS?=
 =?utf-8?B?QU5yL3Rha3JPTFpaWVByS1JmNCtGZ1BNQkd4S1puVFhBeCtlRXdJdE1MVEdD?=
 =?utf-8?B?Y2U3d09Cd05Oa05tb3dOSmZFaHVJZXZjY29oYVFqejZBVHhtMVlybU82VGxX?=
 =?utf-8?B?YWZKRml3TTBLbmdWS3p6cjhoS3Zkd09aNFRjQzRiSXdDQkJhUFA5UE9DZHBG?=
 =?utf-8?B?TkUyMHBGeE9nbmE5VGtrN0JHbG9HWUFaSU1qajVrTjlMT2s0SDZwZHZwcVJm?=
 =?utf-8?B?WVpoc3VXdjhOU2RtMzF6UW1kZC9NeDdGd3NaNWJmVmlhdGZpOXJKZnNLYzBE?=
 =?utf-8?B?b1lDcXlhTFdDRTUzb2tCSWtZUDJzNDBjeXlzcW5CY1EzUThUS01MN0ZEMkE0?=
 =?utf-8?B?c3V4V25SbHpRWHd4VW5NK2p2aHJtTHczVmhQemVwSDJKOXd6L0dNakR6Tm9r?=
 =?utf-8?B?aEZHTUw3eTFjbDlVMjBIT2JoSFhyTzNORzhtcGtFK2VlU2doUTcrdk45UW9h?=
 =?utf-8?B?d1FyZFdkZVhWMWVGdUZ2RTc5bW1IeUVsZFZvanJBem1ldTdlRCtvWVZjbGYz?=
 =?utf-8?B?U2Npd1lZS2F4RGI0dW9PZzRLU2t4Ky9JZjJZNnBqRTVnRU9SdDRnUGZLdndN?=
 =?utf-8?B?S3oxWUtpdGxMQTZSbFlCei81Szg1LzFKUW4xYUNUM3hkOW5rTU1sY2dCbWRv?=
 =?utf-8?B?dTBmelBnWkNGcldZbzAwd1ZvaC9icWRIR1RTUnhheERNdkxFYVFha0hGU094?=
 =?utf-8?B?dmtodHdkbjVUMFd2UWlJcFdyaXZjYi96cVBiZ0V6ZkVMMTEzV3VuVDZTVlBN?=
 =?utf-8?B?S3JwQzBMd2dxcm0zdXB2R3A1bS9BcGtiVDlsUld5UytJN09MRG4zMGIwVE9u?=
 =?utf-8?B?bFhEdDY5QzlyRDdEOW9XYUZNNGQwVE01RnE4ZHdzNmxTZ1VTN2lRd2dvRTN3?=
 =?utf-8?B?aEdxRjZrdk12WU1WUkRvME1JbTY1K1N5SkhPZkRzR201ZnVGZDlJSHZkcGsz?=
 =?utf-8?B?MVNTelZOZi9qQlZ4OGhla3lPdjNSMHVYbitiT0dwK3oybTRjdGdOTlJVWHZj?=
 =?utf-8?B?RWR0U0lQVU9mQmlHNy9ybW9HZ2dQTGVkeklhS01BbkZab3BhK3IrRGM5MWhl?=
 =?utf-8?B?b3lFb2RQSFRCK3FBNVZEb080b2FsYmtER2NCcmV2L3NreC9ZY3VjWnVYamx4?=
 =?utf-8?B?VXN3bWhJUjdrRjU2emhvTXpHL3hyQThUZExkNURrMlhCeXphZFhCSndhREh6?=
 =?utf-8?B?RDEzRTNLUitoZk9FVXY5TlpQVEZGMFhuOE1teSs3OENLVjNIR3JScnZJR1lO?=
 =?utf-8?B?WStnZS9wQmRDb0FBeXFpcGZTRjkyd2l1VFRRWDB3ejFJNTdKYmZSejdvaXJy?=
 =?utf-8?B?eTFTS1hET09neGR1WGJNQTQ2SjlNWi83UGY2UDh4cWpjOGFOTSttQkFkQkpv?=
 =?utf-8?B?NWFGSUdTZU5UNEx0enU1UTZRQnM4WDFsVzZ3dWVrU2FVNHRZZ3Ezc1Jjakdi?=
 =?utf-8?B?WTAzSDNDSERCRlJWOTFDQm5HVVYrdWhEaFkrREs1ekV5S00zVEZDbGlxNnhj?=
 =?utf-8?B?cUpzYlFIemtNUjFrMHZLQi85WThHMGtVNGt3YXNubVBSTyt4Um9rcXptRW1O?=
 =?utf-8?B?SlJHYnhyZnpYa1IyYytCclFXYnFlNnkrd1ZaMGJrMEVQYlVRVTVlNFE1cnFP?=
 =?utf-8?B?aGZGMEl6QktnVVFrV2w1OTc1SFI1N1pPTmEvbTk0cnlxd0JUSENORXJMUWVM?=
 =?utf-8?B?TXFzZnZUcXZRVk5lekIzTzhmUzRTUUtEYkwvM0daN2k5Ym5OYkgreTlDZitU?=
 =?utf-8?B?bzFWbS8wRjFWSVZjb0VxcERXK3k3NUxVUU1aTGxzSU55SGN1ZUFxTnlBL014?=
 =?utf-8?B?aFFheWJZNFpJUFpLbEtjUVFzeGFRbE40d1VRcWJlazhPN0JuMTJQMnhQeDRJ?=
 =?utf-8?B?cGQ0YWU4ZU9FUEx2TzY0eWhzdFdQMDEvTkZ4aWI2YXkxcDNndXdNLzdzNWo4?=
 =?utf-8?B?K21qVVE5Tlc0MWpMN21XZXltcVRNV3FreWNzQkVOeHY4YnlpcTJ2KzE1RXZs?=
 =?utf-8?B?dTVYaXZITG5GNStKRE92akEwVFFzQVZuTHB0KzUvQkZCc2JIc3VaaGVSRmww?=
 =?utf-8?B?bFZXY0ptY0p3dU1Dck84WE55cHV6UGtYSFlNK0hPNi84UWdHZ3htcVRjRDlu?=
 =?utf-8?Q?O6J5Zh/3ucCbf38tXOX945ypQI7+UhQje4MNvxP4jY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <866BDE1BE1338049B737133F1C0F1C16@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 433779f1-9f94-4b55-db66-08dc39e02a70
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2024 11:10:12.7218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X1HdBnfjnworr246CEL4xBsGWK4/t9bw9y9YSIxKHmbXs1ZpHNuS4MltGRGmcLRdesV/tgcd2uH6kxnOP2McmGqTSp7us/FIQNF/H723BA4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5150

SGVsbG8gQWxleGFuZHJlIQ0KDQpUaGFuayB5b3UgZm9yIHlvdXIgcmV2aWV3IQ0KDQpPbiBUaHUs
IDIwMjQtMDItMjkgYXQgMjM6MDggKzAxMDAsIEFsZXhhbmRyZSBCZWxsb25pIHdyb3RlOg0KPiA+
ICJUaGVyZSBpcyBhIGxvdyBwcm9iYWJpbGl0eSB0aGF0IHNvbWUgZGV2aWNlcyB3aWxsIGhhdmUg
Y29ycnVwdGlvbiBvZiB0aGUNCj4gPiByZWdpc3RlcnMgYWZ0ZXIgdGhlIGF1dG9tYXRpYyBwb3dl
ci1vbiByZXNldCBpZiB0aGUgZGV2aWNlIGlzIHBvd2VyZWQgdXANCj4gPiB3aXRoIGEgcmVzaWR1
YWwgVkREIGxldmVsLiBJdCBpcyByZXF1aXJlZCB0aGF0IHRoZSBWREQgc3RhcnRzIGF0IHplcm8g
dm9sdHMNCg0KLi4uDQoNCj4gRG9pbmcgdGhpcyBpbiBwcm9iZSBpcyBwdXR0aW5nIGEgYmFuZC1h
aWQgb24gYSB3b29kZW4gbGVnIGFzIHlvdSBhcmUgbm90DQo+IGd1YXJhbnRlZWQgeW91IHdpbGwg
aGF2ZSBhIHByb2JlIHRvIGNhdGNoIHRoaXMgY2FzZS4gVGhpcyBzaG91bGQgYmUNCj4gcmF0aGVy
IGRvbmUgaW4gcGNmODUwNjNfcnRjX3NldF90aW1lIGJ1dCBpdCBjb21lcyB3aXRoIGl0cyBvd24g
c2V0IG9mDQoNCkFzIEkgcmVhZCB0aGUgZGF0YXNoZWV0IChxdW90ZWQgYWJvdmUpIHRoZSBkZXZp
Y2UgaGFzICJwZWN1bGlhcml0aWVzIiBpbg0KUG93ZXItT24tUmVzZXQgaW1wbGVtZW50YXRpb24s
IG5hbWVseSBpdCdzIG5vdCBhbHdheXMgZGV0ZWN0ZWQuIEluIG91cg0KYXBwbGljYXRpb25zIChh
bmQgcHJvYmFibHkgbW9zdCBvdGhlciBkZXNpZ25zKSBpdCdzIHRoZSBzdGFydHVwIG9mIExpbnV4
DQp3aXRoIGRyaXZlciBwcm9iZSwgd2hpY2ggaW1tZWRpYXRlbHkgZm9sbG93cyB0aGUgUG93ZXIt
T24gZXZlbnQNCih3aGljaCBoYWQgc29tZSByZXNpZHVlIHZvbHRhZ2UgYmVjYXVzZSBvZiBsYXJn
ZSBjYXBhY2l0b3JzLCB3aGF0c29ldmVyKS4NCg0KSXQgaXMgYW4gaXNzdWUgd2UgcmVhbGx5IG9i
c2VydmVkIGFuZCBzb2x2ZWQgaW4gMTAwJSBjYXNlcyBmb3Igb3VyIGRlc2lnbi4NCkkganVzdCB0
aG91Z2h0IGl0IG1pZ2h0IGJlIHVzZWZ1bCBmb3Igb3RoZXJzIGJlY2F1c2UgaXQncyBhbHNvIGRv
Y3VtZW50ZWQNCmJ5IE5YUC4gTWF5YmUgbm90IGFzIHNlcGFyYXRlIGVycmF0YSBkb2N1bWVudCBh
bmQgaXQncyBhIGJpdCBoaWRkZW4gaW4NCmRhdGFzaGVldCBidXQgSSdkIHVsdGltYXRlbHkgY29u
c2lkZXIgaXQgYSBQT1IgZXJyYXRhLg0KDQotLSANCkFsZXhhbmRlciBTdmVyZGxpbg0KU2llbWVu
cyBBRw0Kd3d3LnNpZW1lbnMuY29tDQo=

