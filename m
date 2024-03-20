Return-Path: <linux-kernel+bounces-108870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1252C881120
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75BB3B2254A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D203EA8A;
	Wed, 20 Mar 2024 11:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="mXDXGYvz"
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2065.outbound.protection.outlook.com [40.107.114.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFAF3FE2D;
	Wed, 20 Mar 2024 11:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.114.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710934803; cv=fail; b=nSK1Cg8xgWdLYJYUYvggvBY3IaioKFeKytPUvy5vHlnvvor7a8Uhw526Mlaggr22qmG/MBS2hHho0NRQJNbyYF8Sg8LxLU4e8iYaqrix5aoECq2l7VyYvDZvsKa+pYISysujQzWoCEsyyMvhXt01WIOj1qgvx8cgugnCQS75v/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710934803; c=relaxed/simple;
	bh=Vsa1ZB+yDSUaCKPgYs27k7siZLbTha1YTrSoLVCuZSw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qVlkarJoGSiK64E1VpJp/PAGAp8VVhATwuED1Jjcge+lEWxPkCS8+jnYBm/VpUI1bzwJaj178l6qrSXqTO8HbtBFN4zccJ22ZCAMmEIUzXLRegTHZGdy36b17VbOnB0rHqhuqcg/lc7SbiLAio7cVlEtfBaEadChI5yRbbVLi4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=mXDXGYvz; arc=fail smtp.client-ip=40.107.114.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iqL9VFxsb47KQ0LD3nH8ahyJNIzkQB68OaTY8X7XkOTv1+dAMHc1ClgTNzymWnE7IU1rZsaQa+3nrTmwjoxGlvYvaeVKUtViXMgg0v27BaAiYo2OBfL52uiwULyLWxs6zOXnCWFeWlP4q3njtazOImBoQLpuV3CQFOkHaf+lJRppqzzTkA9J5rFME35BxUP6JIeywaLkumSBRT/Q/0m3fNteRHXx8C3uDg1jQm+X1nGj7Vf87VzFP4TMJO3gsZ3PO4MqKVziBAPJgZQA6MUtGmLDVA2/hHrKFnxRKtg0V1I5hPSfpK1Yv/n1GYeBUCCQ+Y539SpSAcqgXJpyXFVWlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vsa1ZB+yDSUaCKPgYs27k7siZLbTha1YTrSoLVCuZSw=;
 b=LpkxKbwIDtRysUyc1W4+PVaoAwEs7grcVJAI2A47r/w7Npy7aWS35iUSswXFMITrrbYEwabNX0dHhJ1N9sb7wE2k9PApXEykEOO2eK8cRSGnxwnnr2otCUiqC4PXzqB7S1mcoVaNzDyr4NUpyhm2kY5zCT4d/o1nmjmTe9TdQpGaxcvbpyx1yWzXQpS8MgPCciUlqG7lrHxmPoIyQCaPVDETNSjODyYbon1Y5G+Y1+C4SBdB0BtxKBaO42n8rjNCNtahSm7aKNXc5gY7ghijyuSZANKgjszEeFIvvopILqhPKv1e2qFP+XO8BgR7DX0i5HrF6fmDKTNqNA1b4H1DGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vsa1ZB+yDSUaCKPgYs27k7siZLbTha1YTrSoLVCuZSw=;
 b=mXDXGYvz+Nxsz2SiTVWSali7+ViJymNt5lDQCGtZEwxqN46OKt5otUvu7wbVekjCseGCRJY/TPVrjSKxjWFYWOGKBdhyVvoipKPMv0Ee8l9azpSlm+RjciiSs+7TaIoEsE/xFn7Iod1pSblrpQ9S5veJkl7qSGRZVYEP/MAiA4I=
Received: from OSAPR01MB1587.jpnprd01.prod.outlook.com (2603:1096:603:2e::16)
 by TYWPR01MB10019.jpnprd01.prod.outlook.com (2603:1096:400:1e3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Wed, 20 Mar
 2024 11:39:56 +0000
Received: from OSAPR01MB1587.jpnprd01.prod.outlook.com
 ([fe80::aef6:c35b:b90d:2e3f]) by OSAPR01MB1587.jpnprd01.prod.outlook.com
 ([fe80::aef6:c35b:b90d:2e3f%5]) with mapi id 15.20.7386.023; Wed, 20 Mar 2024
 11:39:56 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Claudiu.Beznea <claudiu.beznea@tuxon.dev>, "geert+renesas@glider.be"
	<geert+renesas@glider.be>, "linus.walleij@linaro.org"
	<linus.walleij@linaro.org>, "tglx@linutronix.de" <tglx@linutronix.de>
CC: "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH v3 2/2] pinctrl: renesas: rzg2l: Configure the interrupt
 type on resume
Thread-Topic: [PATCH v3 2/2] pinctrl: renesas: rzg2l: Configure the interrupt
 type on resume
Thread-Index: AQHaerN1t0zmC78ia0+OQ9W2eqNy9bFAd/ZQgAAGFICAAAG7oA==
Date: Wed, 20 Mar 2024 11:39:56 +0000
Message-ID:
 <OSAPR01MB158792B061005CB104B7018386332@OSAPR01MB1587.jpnprd01.prod.outlook.com>
References: <20240320104230.446400-1-claudiu.beznea.uj@bp.renesas.com>
 <20240320104230.446400-3-claudiu.beznea.uj@bp.renesas.com>
 <OSAPR01MB158778802C8AAF3F9230259286332@OSAPR01MB1587.jpnprd01.prod.outlook.com>
 <dfc130d9-2995-4ebc-b164-758c40cff749@tuxon.dev>
In-Reply-To: <dfc130d9-2995-4ebc-b164-758c40cff749@tuxon.dev>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB1587:EE_|TYWPR01MB10019:EE_
x-ms-office365-filtering-correlation-id: 06915e9d-5de7-44e5-ea2e-08dc48d2775b
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 n+Qs+54hrI01F9LLKzrZAAIWGdgqc7u8KvdYsynybIc30VKaM8SOuHoLipPwHtaBpoQRLjN8MHb3D4WwjiSFFOmytl2dnNjZUAX+rS1FlUzoZR13eaGrBdhnUHw/CBXxAkwke5TFt1kVRCRzGVffyIYoqVGV7S7qsnThED2etEdBjV3ncoLtzJOvBsa3MSz5xc5NrXXIybUkbHaFgoSzvNWcP1BhqdfiMyTdtXMHHqoeJHZwXTSaTq3MF8Zjo7qN6Nx0YGBue19tpMSJ4L0vv/SGHnCs8N0++5pDcf/0KCvKJZLyPqT6WPlyrfiH8t/XgWGOUNy9mLG3k87TxFilYKwotGFZHtu6EDfjUDg3tIlADD7x5TqDwLOazJlV4/3agcdUWCLLRuxvT4WCUIjINahMcPGqrHZHIV7onj7HUsWRiKH59G1dxVZQsppfzUls7o3/x9rOPJDvNMUer2IySwRrWzrn7c/i8L6QiMAMgd9C5THbc/pJa/ic209iC5fzJEEEiA28YMFbgRtV1z43UxBMvyqEqjP0Y93chFtAT3dWQVQYtB/icSLW3bBjuAtaxG9Mf+KO5sY9ld43TyufRlyjOEXyZaBc+XFayD6QGMT0XBIrma3mwC5k9XDPlB1i0y6ys1GdtBycTNhnrp/4xAgCWfKpVHhxrmbUyYXxSND+7tP49Zii1ZBC9HCFIKkOMtM4qLYyo16Rhvoe92AYpaswWkKavNWRShOyykUk8rA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB1587.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OEZTRHlUNUlRd254TVFzaVVkdEFvbkRvNG16VzRFWkdHTGducnhMbURaVy96?=
 =?utf-8?B?VFgxcFNZbmkwSnpKamJ4QmpkYzlKa253TEs2dmNZMCtZWXJHbVQzSTBGTUNL?=
 =?utf-8?B?S2lybUlzL0NVNStTZTlrM0JnUDdJWUZTQmJEclk4SkdobWc0a2p4OFB5eXVE?=
 =?utf-8?B?WElsMEpzQVdNaS9KeElEVmdQNlJicmg3am8wUWJzZWNtRmpSTXhBZ3JGUXMx?=
 =?utf-8?B?bWJUOVUwaDRpL3BCaElsREVyWU5ZSUwyOS8zSWQ2VU45b1QxMS9HSWZkZ0FM?=
 =?utf-8?B?eXoxMDdOMFZjOXF6b0plS3JxYUtxNVVpckd6dndQMXpoN1BrOG5COXZJNHRT?=
 =?utf-8?B?VUoyb1VwaFA1M2JETXlETlhoWmd5WHZTUjdiQ25TcXBiZXJhaTBLRTBqRXRw?=
 =?utf-8?B?SWppcUJTbytJdDQwMXdqNWZFUlVnYTJZamUyZFd0azBDRUxCK1B0YlJWbU1U?=
 =?utf-8?B?N08ybHNzbWEra0lzVDNuQ05aQ1NTeTk5RjQ0OHFTbk5SeTBsbG9QdzdvVFIr?=
 =?utf-8?B?UjNtMWpyU3ZPMURWRjduMlJvcFBCR2plS1VhTldnbnZvczhVeUtQQnk1ZTVt?=
 =?utf-8?B?QTQ4azBrTTZYQWt2TTh6dVFFTXpSdzJtUFZZUmQrUlFGTmkzc1gxVWh6dEZD?=
 =?utf-8?B?ZHMwZExIOVdQN2xnSHFMWFl1aUppakFRTVlCVjVkTmo1RXdXdDhOL2VWTkRz?=
 =?utf-8?B?ZmN0UEg5azVWSU4zZS9EWHZudUZiSVBlR2hXdEc3ZklLY1FBZmxmSUIxVFNE?=
 =?utf-8?B?Mythb09qdTZaVWdNOHphK0FmeS82bHFVL1d5b2pBRjRqdHJYaVd2cGc1LzZt?=
 =?utf-8?B?Z2N3UzJkVk1naVQ5QTl6V0Irb0VTQTZqeXlQWE9CclZYZ1g2MFpDOVFpWnJs?=
 =?utf-8?B?eWh2RXNVRmVVVmlhMmV1SE5yU2lxWWxid1JtTFVYR0pkc1psYUdYUndGSlhL?=
 =?utf-8?B?RjdEbDNyTHphblRQb29TMVJ1c3lnWHF6dDlOV3dyZGJGVDVkQ0VBT08rcVFo?=
 =?utf-8?B?RUdLaTMxck5iSUxoRkdQUjZTZGZoWm9pSjk1Y3A1Nk5Wdit5TnY3dlpOQUdT?=
 =?utf-8?B?SWF2bFBCTW15MlRGYTI2bUlBNi80YVQvZ0JiSnRVUkdES3lkRGdlQlBsWXJ5?=
 =?utf-8?B?TnZUdnF3OG44bm9BTTNqTGo2czNMTlVubGZTU1VBTWdXUXJNdlI1d2lieVdF?=
 =?utf-8?B?OCtlR2FoYUs1TGVBc0JPRmFtZTIvS1ppOVlYemhGc2NSNlR1VTd1VTc4RDRR?=
 =?utf-8?B?T1NjUmN4L0szaTJKajlQOHFKTlNzT2pCeXFVMDJ1bWhFVjVCWVRmeGE2ZkRq?=
 =?utf-8?B?bjRyQ0NLZ2FJVXZpQzN5QWQ5cVdkM0NWK2FPZzdKQWZ5ZlJ3RUlOWi9seTYx?=
 =?utf-8?B?MGNJeXNtM1lHWG5rR3czWS95LzlqMUQrV2h3SHZKWVAxY3pZa1RTc3hzVlJ0?=
 =?utf-8?B?RHduamhQN2gxZzMwaEdrTy9Yb2Y1YUlyd2tPNnZ1RDlUc2xLSDlXYTZIbUpP?=
 =?utf-8?B?aFAyWlpzdENYaVozcW13TVY2aC9GT1p1MUxTbStFQ2tKcGNVa0JERTRVajVC?=
 =?utf-8?B?alpXVHlpL0hvWm5qdDczYWE5akRVc3dtTDNHVVQ1UmMrVjdsN01vUXBqWEd5?=
 =?utf-8?B?WXFwMjlQcGpDM1RMUWUyRjhJWnBqamJjdTUvQkExVGZqNFJBTUhad3UrNjZ5?=
 =?utf-8?B?MCtRWkttWVpCMVdBb2J5OFFLMTl4b1lmTy83ZXdOT2k1bVMzV2Y0eHFTcTlB?=
 =?utf-8?B?UnpRUGNzUWhnZTFIdDR0Z3ZBdG5NTmlna3M3ZFhqQ1BrbjVqbGRCa3RhRU5v?=
 =?utf-8?B?RTdrSWljRjczWFhZdFB2K0J3VGFDT1hlU2hLejlVMXpBbjlURkt2dzh0WnVN?=
 =?utf-8?B?YWlRYnZHU21DWVJ4aVhlY3VrU2J5V1F0SStvdjFoWjd1c0pGSWt1bkFTck1N?=
 =?utf-8?B?Qkx5RzZFdytBdGhTYXNXTzRZQ0pPVXozUlU4cm9KT0I3d0U0aXlSbmE5K256?=
 =?utf-8?B?U3NsYmJyVGNabHoyQUVQcjFPTVlTakd6NDRFOUpnbGF1cHZPbytsQXk2eVFx?=
 =?utf-8?B?eGFuMXpoWFZ5NklXREdQbmVIVU5OYmowOUJVSHVrUi9lNkROTlJUam04VG82?=
 =?utf-8?B?d2F5M0tidE55VHhCaGM2VlBwRDROdjRSeCtLem5Sd29HNWZoUUNVaU56NjdG?=
 =?utf-8?B?bHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB1587.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06915e9d-5de7-44e5-ea2e-08dc48d2775b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2024 11:39:56.2060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UspYG9/2LdPSB4cA4OLYcuwjGYQ8i5LqFM6IeegTdXGgkTlCne7ndaWdzL1kbHGYuCEhWfSkq2FEKuqyd4/Cc3PQocMPCRlwV3VjnxE6BXI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10019

SGkgQ2xhdWRpdSwNCiANCj4gDQo+IE9uIDIwLjAzLjIwMjQgMTM6MDgsIEJpanUgRGFzIHdyb3Rl
Og0KPiA+IEhpIENsYXVkaXUsDQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4gPj4gRnJvbTogQ2xhdWRpdSA8Y2xhdWRpdS5iZXpuZWFAdHV4b24uZGV2Pg0KPiA+PiBTZW50
OiBXZWRuZXNkYXksIE1hcmNoIDIwLCAyMDI0IDEwOjQzIEFNDQo+ID4+IFN1YmplY3Q6IFtQQVRD
SCB2MyAyLzJdIHBpbmN0cmw6IHJlbmVzYXM6IHJ6ZzJsOiBDb25maWd1cmUgdGhlDQo+ID4+IGlu
dGVycnVwdCB0eXBlIG9uIHJlc3VtZQ0KPiA+Pg0KPiA+PiBGcm9tOiBDbGF1ZGl1IEJlem5lYSA8
Y2xhdWRpdS5iZXpuZWEudWpAYnAucmVuZXNhcy5jb20+DQo+ID4+DQo+ID4+IENvbW1pdCBkY2Uw
OTE5YzgzYzMgKCJpcnFjaGlwL3JlbmVzYXMtcnpnMmw6IERvIG5vdCBzZXQgVElFTiBhbmQgVElO
VA0KPiA+PiBzb3VyY2UgYXQgdGhlIHNhbWUgdGltZSIpIHJlbW92ZWQgdGhlIHNldHVwIG9mIFRJ
TlQgZnJvbQ0KPiA+PiByemcybF9pcnFjX2lycV9lbmFibGUoKS4gVG8gYWRkcmVzcyB0aGUgc3Bv
dXJpb3VzIGludGVycnVwdCBpc3N1ZSB0aGUNCj4gPj4gc2V0dXAgb2YgVElOVCBoYXMgYmVlbiBt
b3ZlZCBpbiByemcybF90aW50X3NldF9lZGdlKCkgdGhvdWdoDQo+ID4+IHJ6ZzJsX2Rpc2FibGVf
dGludF9hbmRfc2V0X3RpbnRfc291cmNlKCkuIFdpdGggdGhpcywgdGhlIGludGVycnVwdHMgYXJl
IG5vdCBwcm9wZXJseSByZS1jb25maWd1cmVkDQo+IGFmdGVyIGEgc3VzcGVuZC10by1SQU0gY3lj
bGUuIFRvIGFkZHJlc3MgdGhpcyBpc3N1ZSBhbmQgYXZvaWQgc3B1cmlvdXMgaW50ZXJydXB0cyB3
aGlsZSByZXN1bW1pbmcgc2V0DQo+IHRoZSBpbnRlcnJ1cHQgdHlwZSBiZWZvcmUgZW5hYmxpbmcg
aXQuDQo+ID4NCj4gPiBKdXN0IGEgcXVlc3Rpb24sDQo+ID4NCj4gPiBQcmV2aW91c2x5IHlvdSBk
b24ndCBzYXZlL3Jlc3RvcmUgaXJxX3R5cGUoKSByZWdpc3RlciBkdXJpbmcgc3VzcGVuZC9yZXN1
bWUoKT8/DQo+ID4gQWZ0ZXIgU1RSLCBhbnkgd2F5IHdlIHdpbGwgbG9zZSB0aGF0IGluZm9ybWF0
aW9uLg0KPiANCj4gUGFydCBvZiBJQTU1IHJlZ2lzdGVycyBhcmUgc2F2ZWQvcmVzdG9yZWQgaW4g
SUE1NSBzdXNwZW5kL3Jlc3VtZSBmdW5jdGlvbnMuDQo+IA0KPiBUaGUgcmVzdCBvZiBjb25maWd1
cmF0aW9uIChlbmFibGUgYW5kIFRJTlQpIHdhcyBkb25lIHRob3VnaCBwaW5jdHJsIGRyaXZlciBi
ZWNhdXNlIElBNTUgaXMgcmVzdW1lZA0KPiBiZWZvcmUgcGluY3RybCBkcml2ZXIgYW5kIGlmIHdl
IGVuYWJsZSB0aGUgaW50ZXJydXB0IGF0IHRoYXQgcG9pbnQgdGhlIHBpbiBtYXkgYmUgaW4gdW53
YW50ZWQgc3RhdGUgYW5kDQo+IElBNTUgbWF5IHJlcG9ydCBpbnZhbGlkIGludGVycnVwdHMuDQo+
IA0KPiBBcyBUSU5UIHdhcyByZW1vdmVkIGZyb20gZW5hYmxlIHdlIG5lZWQgdG8gaGFuZGxlIGl0
IG5vdy4NCg0KT0sgZ290IGl0LCBTbyBwcmV2aW91c2x5IHlvdSBhcmUgbm90IHN0b3JpbmcvcmVz
dG9yaW5nIFRJTlQgc291cmNlIGFsb25nIHdpdGggaW50ZXJydXB0IHR5cGUoKWluIElBNTUuDQoN
CkJ1dCBkZXBlbmQgdXBvbiB0aGUgcGluY3RybCgpIHdoaWNoIGp1c3QgY2FsbCBlbmFibGUoKSB3
aXRob3V0IGlycV9zZXRfdHlwZSgpLg0KTm93IHRoZSBpc3N1ZSBpcyBmaXhlZCBieSBjYWxsaW5n
IHNldF90eXBlKCkgKyBlbmFibGUoKS4NCg0KQ2hlZXJzLA0KQmlqdQ0KDQoNCj4gPg0KPiA+DQo+
ID4+DQo+ID4+IEZpeGVzOiBkY2UwOTE5YzgzYzMgKCJpcnFjaGlwL3JlbmVzYXMtcnpnMmw6IERv
IG5vdCBzZXQgVElFTiBhbmQgVElOVA0KPiA+PiBzb3VyY2UgYXQgdGhlIHNhbWUgdGltZSIpDQo+
ID4+IFNpZ25lZC1vZmYtYnk6IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYS51akBicC5y
ZW5lc2FzLmNvbT4NCj4gPj4gLS0tDQo+ID4+ICBkcml2ZXJzL3BpbmN0cmwvcmVuZXNhcy9waW5j
dHJsLXJ6ZzJsLmMgfCAyMiArKysrKysrKysrKystLS0tLS0tLS0tDQo+ID4+ICAxIGZpbGUgY2hh
bmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pDQo+ID4+DQo+ID4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3BpbmN0cmwvcmVuZXNhcy9waW5jdHJsLXJ6ZzJsLmMNCj4gPj4gYi9k
cml2ZXJzL3BpbmN0cmwvcmVuZXNhcy9waW5jdHJsLXJ6ZzJsLmMNCj4gPj4gaW5kZXggOTM5MTY1
NTNiY2M3Li40ZmVlM2IwZTZjNWUgMTAwNjQ0DQo+ID4+IC0tLSBhL2RyaXZlcnMvcGluY3RybC9y
ZW5lc2FzL3BpbmN0cmwtcnpnMmwuYw0KPiA+PiArKysgYi9kcml2ZXJzL3BpbmN0cmwvcmVuZXNh
cy9waW5jdHJsLXJ6ZzJsLmMNCj4gPj4gQEAgLTIwNDUsNyArMjA0NSw5IEBAIHN0YXRpYyB2b2lk
IHJ6ZzJsX2dwaW9faXJxX3Jlc3RvcmUoc3RydWN0DQo+ID4+IHJ6ZzJsX3BpbmN0cmwgKnBjdHJs
KQ0KPiA+Pg0KPiA+PiAgCWZvciAodW5zaWduZWQgaW50IGkgPSAwOyBpIDwgUlpHMkxfVElOVF9N
QVhfSU5URVJSVVBUOyBpKyspIHsNCj4gPj4gIAkJc3RydWN0IGlycV9kYXRhICpkYXRhOw0KPiA+
PiArCQl1bnNpZ25lZCBsb25nIGZsYWdzOw0KPiA+PiAgCQl1bnNpZ25lZCBpbnQgdmlycTsNCj4g
Pj4gKwkJaW50IHJldDsNCj4gPj4NCj4gPj4gIAkJaWYgKCFwY3RybC0+aHdpcnFbaV0pDQo+ID4+
ICAJCQljb250aW51ZTsNCj4gPj4gQEAgLTIwNjMsMTcgKzIwNjUsMTcgQEAgc3RhdGljIHZvaWQg
cnpnMmxfZ3Bpb19pcnFfcmVzdG9yZShzdHJ1Y3QgcnpnMmxfcGluY3RybCAqcGN0cmwpDQo+ID4+
ICAJCQljb250aW51ZTsNCj4gPj4gIAkJfQ0KPiA+Pg0KPiA+PiAtCQlpZiAoIWlycWRfaXJxX2Rp
c2FibGVkKGRhdGEpKSB7DQo+ID4+IC0JCQl1bnNpZ25lZCBsb25nIGZsYWdzOw0KPiA+PiAtDQo+
ID4+IC0JCQkvKg0KPiA+PiAtCQkJICogVGhpcyBoYXMgdG8gYmUgYXRvbWljYWxseSBleGVjdXRl
ZCB0byBwcm90ZWN0IGFnYWluc3QgYSBjb25jdXJyZW50DQo+ID4+IC0JCQkgKiBpbnRlcnJ1cHQu
DQo+ID4+IC0JCQkgKi8NCj4gPj4gLQkJCXJhd19zcGluX2xvY2tfaXJxc2F2ZSgmcGN0cmwtPmxv
Y2sucmxvY2ssIGZsYWdzKTsNCj4gPj4gKwkJLyoNCj4gPj4gKwkJICogVGhpcyBoYXMgdG8gYmUg
YXRvbWljYWxseSBleGVjdXRlZCB0byBwcm90ZWN0IGFnYWluc3QgYSBjb25jdXJyZW50DQo+ID4+
ICsJCSAqIGludGVycnVwdC4NCj4gPj4gKwkJICovDQo+ID4+ICsJCXJhd19zcGluX2xvY2tfaXJx
c2F2ZSgmcGN0cmwtPmxvY2sucmxvY2ssIGZsYWdzKTsNCj4gPj4gKwkJcmV0ID0gcnpnMmxfZ3Bp
b19pcnFfc2V0X3R5cGUoZGF0YSwgaXJxZF9nZXRfdHJpZ2dlcl90eXBlKGRhdGEpKTsNCj4gPj4g
KwkJaWYgKHJldCkNCj4gPj4gKwkJCWRldl9jcml0KHBjdHJsLT5kZXYsICJGYWlsZWQgdG8gc2V0
IElSUSB0eXBlIGZvciB2aXJxPSV1XG4iLCB2aXJxKTsNCj4gPj4gKwkJZWxzZSBpZiAoIWlycWRf
aXJxX2Rpc2FibGVkKGRhdGEpKQ0KPiA+PiAgCQkJcnpnMmxfZ3Bpb19pcnFfZW5hYmxlKGRhdGEp
Ow0KPiA+PiAtCQkJcmF3X3NwaW5fdW5sb2NrX2lycXJlc3RvcmUoJnBjdHJsLT5sb2NrLnJsb2Nr
LCBmbGFncyk7DQo+ID4+IC0JCX0NCj4gPj4gKwkJcmF3X3NwaW5fdW5sb2NrX2lycXJlc3RvcmUo
JnBjdHJsLT5sb2NrLnJsb2NrLCBmbGFncyk7DQo+ID4+ICAJfQ0KPiA+PiAgfQ0KPiA+Pg0KPiA+
PiAtLQ0KPiA+PiAyLjM5LjINCj4gPg0K

