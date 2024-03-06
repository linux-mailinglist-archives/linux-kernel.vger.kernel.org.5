Return-Path: <linux-kernel+bounces-93751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDBE87341F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41BB61C20B6C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC9D5F84F;
	Wed,  6 Mar 2024 10:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="N1qg+AZh"
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2069.outbound.protection.outlook.com [40.107.113.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225585F848;
	Wed,  6 Mar 2024 10:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.113.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709720728; cv=fail; b=IkcM7TsHra6CoIDfW/zid+UryCLcY7SGk5SXu27yGqPskzrXtJioXOuBjblfStjpMaJNEDJWiuDKd90rHCMCbtrfOrvfOVzszcNRYVmkkIeYLa5fLL+tCdqPXBkdvKY+EI90EVGLUvkZhZe6oVAR/mKzmE2DJX8Q+JV+VMafVFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709720728; c=relaxed/simple;
	bh=UUrzRnXo/jR8oMNF/YQsBHX/OqQpHFepBUY1KWZhauU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=evl9Evex6HI6itm2QhDGY+dbvVbsS/InZF1eKpJl7vX2GyuWd8rVfgxgTXmHoqMUg0QlF/q1y6Xa8BD0ApCmsMbRXcjSDjsHREFzFjR2KanDHxTIA7VIt2aHxa+r1qiC0jlXqONr4qDTkRIcbgOtRyHvoJQcblE/bPRGVJG3iZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=N1qg+AZh; arc=fail smtp.client-ip=40.107.113.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=koJpVoQ6zHe7d0pZu+qp7QZ0knrQRjSKbnJgAwsNwFxYqXt/Eyrj2yz0+mrZDKzbOQbdYaM2HWWOf6rIjs2IjpbrOPdvFy8UtYMNkzbNz+hMOvHDmsb1CusJ07rd4z1ySqG6/K6wLc0KSS2PAFQuU9EG8F2VuNdG4oDzYYWMwL6ViBKT/LUQbQOcQ7vSBUTqYBUCy7UWvToKyC4nJcFJWrKfVJ0SNwprSLqE/JHE3JOLuZqztI7WJq493Onm/eRvhNdRhttJvv3IFQn07c2y/g4qRmjreOPHjRIHhp/edqBdutG6CwGvybL2QE7ibEFkFbnJHWR28XMtS5ZyxYpN2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UUrzRnXo/jR8oMNF/YQsBHX/OqQpHFepBUY1KWZhauU=;
 b=mCX0PIGW2cWFL9U/PuRmaXi6zG3Uvnn3rgaFgyHZeyc3iB3lj0R0mSLx/LWudklpkZ5KgVGs+cWgqz3oEcX+94oaw7EcDXjz6Z4nVKZdWzEsyeG95NLfJXuOABLpmR7f2iZOS92LDa01WenCng6eIRHod1aVR1Pl6dr3qPNvINhGZ8CUgyOkMwBcXDsf9GfaeI9j/JbSXfTh9ZzFtmrnIfnbks4BQq+TL0eSrOkNl4bBk6dR/5lZ/oSapQmW97VhPLPxMjhzgo+zzPzfMkvTuD6ZjPdQh4owxAOKSEianl8fKVhheKfDI7Zxv6/permcbBjRIMrw3DO3h7taP4lggw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UUrzRnXo/jR8oMNF/YQsBHX/OqQpHFepBUY1KWZhauU=;
 b=N1qg+AZhL1AQSa+kO9bkOrGiEwjm1aMh1Rnw05wN41qA1J7tkP3otLqIjk3phHqfjzB8e75oLeBYHnWPqQqOWZI3bW/Qns9D00VXpMfeNnDfX3RGI0NLcVGuVTww+Q45EKlvMnkysJC0VJRgdc+birP/ySRMCMlUBzflajdhenE=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by TY3PR01MB10371.jpnprd01.prod.outlook.com
 (2603:1096:400:253::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 6 Mar
 2024 10:25:21 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::9013:d19:4845:e226]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::9013:d19:4845:e226%4]) with mapi id 15.20.7339.035; Wed, 6 Mar 2024
 10:25:21 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Tim Pambor <tp@osasysteme.de>, Geert Uytterhoeven
	<geert+renesas@glider.be>
CC: Dragan Simic <dsimic@manjaro.org>, AnandMoon <linux.amoon@gmail.com>,
	Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] arm64: dts: r9a07g044: Add complete CPU cache information
Thread-Topic: [PATCH] arm64: dts: r9a07g044: Add complete CPU cache
 information
Thread-Index: AQHabw/kpjnAM2gjZU23vtSxor3NMbEqbAcAgAAS+4CAAAPBsA==
Date: Wed, 6 Mar 2024 10:25:21 +0000
Message-ID:
 <TYCPR01MB11269094C9E68404DE8A474A686212@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <20240305151336.144707-1-tp@osasysteme.de>
	 <TYCPR01MB112696A947F31C31FE3A3AFF586212@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <db77fa78e75b9712ebba1dfd7e4340603cae4fe3.camel@osasysteme.de>
In-Reply-To: <db77fa78e75b9712ebba1dfd7e4340603cae4fe3.camel@osasysteme.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|TY3PR01MB10371:EE_
x-ms-office365-filtering-correlation-id: 7ee93042-96e6-41e3-c181-08dc3dc7ba67
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 nXcFX+78TINZAG7i1/r5n2K05fS0SbFG5Cce2ZE/1nwkVKQ8vSKms1ZA5rPtxFRlG3j6+69PaqMPa9Lm49qzRDJLoPJaEpCbNklbWylRoivwzF9jTFsF3xU6A8m77aFHyQ0H6wpEpPB8B+HsMNQ5nwkBxRY0E2sdXzdJuJtGj5zSsQ5XBFwPX82wxWAmadOxbHQErYrbHvleyFud4/vGAbHq07G51T7Pwq3wf9bKPVN5ab6Og2QgyINo31t5M44I2BQF0MXrEqhchd9YDT2I51D5cHDjFUnVwHMl9WbkoPkxmS92PMB/j0eAIzdFSiPYXNs+YXvbcjvWgvvh26q221s/frrhJI0jukmaU6hKXa8E7jBNIjOVKJo+v/jg5mg+RFhb3q1zLA7r61xustNP/e+3lnBQpHaIgSSkF22VDrx82FVKbu0YjjZiXjK4WFaD1y7D2Ot0xFWnV7qdg+OWwkk4MbfNh/206UVpcafdJB2Y01pGXayEERTssee4srVcpMAZx40cxRFLbJ4r479QexTvsslyLif4/2+dl93XxrrXSjhJorU3SptESAmEccQs1YV/TRZuvW7gahfFDwPZL4Hy7fedjHJBQg+Xf0x+LMeXyhk2iJDGW5DSAfoda6lgi2gPOWUOyF5NygRZD19S/beGvP3NQuLjZWcFTXjf+B4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Mks5SFdJdUhYWC9xUU50VjlRbkxZRnpWK0dyUnZpV3FSdXU2MitVZTF5cnBx?=
 =?utf-8?B?MkpKU1VtbkFNaDRDMlZNSm1keW04OTNFNFNNSCs3VnRDWnVtcDNLRTllZmxW?=
 =?utf-8?B?Q21mWitGMG9vdmRlSEJ0U2JWRVBDa2NZeGozQ3dOU1pEWmptV093TS9DTXpB?=
 =?utf-8?B?Z3hnRkdQbXRwR0xiZmRibytPSTUvTmhvV1d4UFlMK0MrWlhJNk51UkMzc24v?=
 =?utf-8?B?V1VkRkkzOGxjdDNPNFZOTDBIek5tQUt1NHlVREZhSGVXdnY5dVFkMHQwWGt4?=
 =?utf-8?B?cnJzQVNBWG5FL09zVW82QktwWnduelMyQk5jVFhEaXNRa24zVnZVVWJ0MWVZ?=
 =?utf-8?B?eGthNzdkdXJ2S2xtSTF0MWFMR2RnNjZVbTZHSWs1bWRGb29Vajg2S2J1aDJz?=
 =?utf-8?B?TXFkUEU4bEVjUFpTQkNmaXlnQ2xPa3ljM1BXdklZZjFQMmJESlZHKy92Smpu?=
 =?utf-8?B?dmNEdmNpSzZNOVRBSXkyMWExUDZuSHQvck14MXZBNGlNU0xBM3lHM3FLZVc3?=
 =?utf-8?B?V1ZqRnNYd3BTSmJhd2JERFlpRTFYZlRrUG1VTjNyR0JTdUlCZWsyL0J3MDJG?=
 =?utf-8?B?WXFQNXI0d1JpdXl4RnJOVGdhMUl5NXlqRzlhcFB3dTYvaFoyWW9PWk5HU1FS?=
 =?utf-8?B?YXhuMGdxUS83R1kzQjk2UHczQ3RNNjRYaHIwVEJDSmVYOG14VFV1RjRUaTR1?=
 =?utf-8?B?ZHl3Z21PeDdEUlBFKytQcmNrZ0NKUjB5MzJ5aXNiTWxEcWNlWSthczdsZzFV?=
 =?utf-8?B?R0xKQTJNczZnV1Y0NVhKM1NRL2UzVk8zR1h0N1VPL2RGNEJhdGVUeUtIS3M1?=
 =?utf-8?B?Q0JFbEczVmlvU1Q2azlYSUJqTWJIb05ZOUx2S3FjUExuZ0k0OFErUTZsYW9m?=
 =?utf-8?B?UCswc3JNdlVNeEYraG44RlFUM3Q4WnJ3WXdiUTJHMmdOM1h3V1Y2UXhxdU5u?=
 =?utf-8?B?UE9ka24zRmthRncvOW5zK3ZOR3dteXBBMFJxVnVSNVVXZTVBYUF6K0Z3V0sw?=
 =?utf-8?B?cld2M0REaHhxUEwwa1BiWG4wWjFSNGVndDdJTGpVOUJodjNYSjhRY3g2YVgv?=
 =?utf-8?B?cG5RQUh4UC9YNUhqbnpTbXBMRW0vd3p5RDliV2dzWXFjTS9SMWRYTW1XUUxZ?=
 =?utf-8?B?WHVyWVBYZVlMTDJhR1RvUk1NNVU0N2ZVTlZpcW90YlJQa0Nxb3E3S3RpZVo3?=
 =?utf-8?B?ZXFOaTRkZTRHN0w5QU4rbldOYzlEY0swU0xzUHh5UzJETXhZeUl5c1ZFRnFE?=
 =?utf-8?B?WlpGTkd2T1pqMUhFOGV0Qlk5QU4wQzhwRy80aXNwZ1AxQXVPSUhsbHZsMVlt?=
 =?utf-8?B?OG40QkpUdjVySEdtVnJ2a3JWU25xcVZjSHpvR3BjaGZLQWMxTlBHL0FMWm5x?=
 =?utf-8?B?VkhwczNmYlZKVDJzRHYvaGlCOXI2ZUh3aVlBdUFTRXd0Q2E1c0NKWXBDVTVI?=
 =?utf-8?B?dmNJZnJxZzdLTlBOS05YZmVWaVFLbzB4Mmg2VjhjbVByUE12SXIrTTNEODRk?=
 =?utf-8?B?Y1NoZElPT0ZpTFRNdGVPc3hucERWVElqb0RQNEJlMktMQ3Z1VlluZ2kyVW5W?=
 =?utf-8?B?Y2w1Z0hRRktiR0tlTnFOTk1xby80L2xuSU85WW16Z2t0SlhneURzVVZmcGRZ?=
 =?utf-8?B?QjFqdy9PdXlWeUpIMFdCWG9jM3NDenBNVjFXUFYxdis5V3BBUVJkQlV3RExN?=
 =?utf-8?B?OFQ0N1JOOFp1R3pDNnVPZGtkek5SUVpOamE3dGZWcy91aTFlUTVGeHRmd1E0?=
 =?utf-8?B?SG4vMVhEcyt4Uk9laUt2R3pjaUM2VmR5b3cva1pkQ09XN216UTJLdE1TUjNS?=
 =?utf-8?B?em1DWURRN1F3cGRtTjZOOU9kd1ZCZ01hQ3ZWVUdPckRRd0dqQ1MvYzRidFAv?=
 =?utf-8?B?NWlJMDMzWUo1alZ2bDdRSW9NQ2MwZFoxYWhjWHFnWE4zMlYvcGF0U09wTUtx?=
 =?utf-8?B?T3dYN0ZCUnhJQ1lnWlMvemxkSFVGZ2hRR05OKzdXZUhYL1NVdUFQWW50dDk4?=
 =?utf-8?B?enJaWVhyQUtaZHVTdXo2SEwzOU5yTU9odTVrcHdOdG1wVXI2SmpxTmdlU0pG?=
 =?utf-8?B?Rm9LM3hBdm9pRFNNbmJuVWgyUnVnbXJQWmR5SmFSZmh4M2J2bnlkbEVnWEpj?=
 =?utf-8?B?S3Y1SWdoV0J3WUxDdkMybjRpZ3cwclRScG9uKzkwYndqdmhlRVRXZ3ZGTHN3?=
 =?utf-8?B?cHc9PQ==?=
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
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11269.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ee93042-96e6-41e3-c181-08dc3dc7ba67
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2024 10:25:21.4302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qe4MCrODQwKMJiZxuy44ZJHERMmg036EFHy0oSMPs6hABHDC/fad/2TJL+ceJE2/M3d7uK0SgELVZSnT+ppaMEWbVazhtw9N+LhJ6bMPtkk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10371

SGkgVGltIFBhbWJvciwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBU
aW0gUGFtYm9yIDx0cEBvc2FzeXN0ZW1lLmRlPg0KPiBTZW50OiBXZWRuZXNkYXksIE1hcmNoIDYs
IDIwMjQgMTA6MTEgQU0NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gYXJtNjQ6IGR0czogcjlhMDdn
MDQ0OiBBZGQgY29tcGxldGUgQ1BVIGNhY2hlIGluZm9ybWF0aW9uDQo+IA0KPiBIaSBCaWp1LA0K
PiANCj4gdGhhbmtzIGZvciB0aGUgcmV2aWV3Lg0KPiANCj4gPiBIaSBUaW0gUGFtYm9yLA0KPiA+
DQo+ID4gVGhhbmtzIGZvciB0aGUgcGF0Y2guDQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBUaW0gUGFtYm9yIDx0cEBvc2FzeXN0ZW1lLmRlPg0KPiA+
ID4gU2VudDogVHVlc2RheSwgTWFyY2ggNSwgMjAyNCAzOjE0IFBNDQo+ID4gPiBTdWJqZWN0OiBb
UEFUQ0hdIGFybTY0OiBkdHM6IHI5YTA3ZzA0NDogQWRkIGNvbXBsZXRlIENQVSBjYWNoZQ0KPiA+
ID4gaW5mb3JtYXRpb24NCj4gPiA+DQo+ID4gPiBCYXNlZCBvbiBBUk0gQ29ydGV4LUE1NSBUUk0g
YW5kIFJaRzIvTCB1c2VyJ3MgbWFudWFsLCBlYWNoIENvcnRleC0NCj4gPiA+IEE1NSBoYXMNCj4g
Pg0KPiA+IFJaL0cyTA0KPiA+DQo+ID4gPiAtIDMyIEtCIG9mIEwxIDQtd2F5LCBzZXQtYXNzb2Np
YXRpdmUgaW5zdHJ1Y3Rpb24gY2FjaGUNCj4gPiA+IC0gMzIgS0Igb2YgTDEgNC13YXksIHNldC1h
c3NvY2lhdGl2ZSBkYXRhIGNhY2hlDQo+ID4gPg0KPiA+ID4gRWFjaCBjYWNoZSBoYXMgYSBjYWNo
ZSBsaW5lIGxlbmd0aCBvZiA2NEIgYW5kIHRoZXJlZm9yZSB0aGVyZSBhcmUNCj4gPiA+IDMyNzY4
Qi8oNCAqIDY0Qik9MTI4IHNldHMgZm9yIGVhY2ggY2FjaGUuDQo+ID4gPg0KPiA+ID4gUlpHMi9M
IGFyZSBub3QgY29uZmlndXJlZCB3aXRoIHRoZSBvcHRpb25hbCBwZXItY29yZSBMMiBjYWNoZSBi
dXQNCj4gPiA+IG9ubHkgaGF2ZSBhIEwzIGNhY2hlIHNoYXJlZCBhbW9uZyBhbGwNCj4gPiBSWi9H
MkwNCj4gPiA+IGNvcmVzLiBJbiB0aGlzIGNhc2UsIHRoZSBMMyBjYWNoZSBhcHBlYXJzIGFzIGEg
TDIgY2FjaGUgdG8gdGhlDQo+ID4gPiBzeXN0ZW0uIFRoZXJlZm9yZSwgc3BlY2lmeSAiY2FjaGUt
bGV2ZWwgPSA8Mj4iIGZvciB0aGUgTDMgY2FjaGUuDQo+ID4NCj4gDQo+IEkgd2lsbCBzZW5kIGEg
djIgd2l0aCB0aGUgY29tbWl0IG1lc3NhZ2UgY29ycmVjdGVkLg0KPiANCj4gPiBZb3UgbWVhbiBm
b3IgTDMgQ2FjaGUsIGNhY2hlLWxldmVsID0gPDI+IGlmIHRoZXJlIGlzIG5vIEwyIENhY2hlIG9u
DQo+ID4gdGhlIHN5c3RlbT8gRG9lcyBpdCBuZWVkIGFueSB1cGRhdGUgb24gZHQtYmluZGluZ3Mg
dG8gbWFrZSB0aGlzIGNsZWFyPw0KPiANCj4gSSBmb2xsb3dlZCB0aGUgYXBwcm9hY2ggY2hvc2Vu
IGZvciB0aGUgUm9ja2NoaXAgUkszNTZ4LCB3aGljaCBhbHNvIGhhcyBhIENvcnRleC1BNTUgd2l0
aCBhbiBMMyBjYWNoZQ0KPiBidXQgbm8gTDIgY2FjaGUgWzFdLiBJIGNhbiBhZGQgYSBjb21tZW50
IHRvIHRoZSBkZXZpY2UgdHJlZSBleHBsYWluaW5nIHRoYXQgdGhlcmUgaXMgbm8gTDIgY2FjaGUg
YW5kDQo+IHRoYXQgdGhlcmVmb3JlIHRoZSBMMyBjYWNoZSBhcHBlYXJzIGFzIGEgTDIgY2FjaGUg
dG8gdGhlIHN5c3RlbS4gRG8geW91IGNvbnNpZGVyIHRoYXQgc3VmZmljaWVudD8NCg0KSSBhbSBs
ZWF2aW5nIHRoaXMgdG8gR2VlcnQgYW5kIG90aGVyIERUIG1haW50YWluZXIncyBmb3IgdGhlaXIg
dmlldyBvbiB0aGlzIHRvcGljLg0KDQpDaGVlcnMsDQpCaWp1DQoNCj4gDQo+IA0KPiBDdXJyZW50
bHksIGhhdmluZyBjYWNoZS1sZXZlbCA9IDwzPiBhbHNvIGNhdXNlcyBhIG91dC1vZi1ib3VuZHMg
YWNjZXNzIGluIHBvcHVsYXRlX2NhY2hlX2xlYXZlcy4NCj4gDQo+IFsgICAgMC4wNjYyMTddID09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PQ0KPiBbICAgIDAuMDY2MzY5XSBCVUc6IEtBU0FOOiBzbGFiLW91dC1vZi1ib3VuZHMg
aW4gcG9wdWxhdGVfY2FjaGVfbGVhdmVzKzB4MjVjLzB4MmQwDQo+IFsgICAgMC4wNjY0OTVdIFdy
aXRlIG9mIHNpemUgNCBhdCBhZGRyIGZmZmYwMDAwMDgyMzcwZGMgYnkgdGFzayBzd2FwcGVyLzAv
MQ0KPiBbICAgIDAuMDY2NTgwXQ0KPiBbICAgIDAuMDY2NjE5XSBDUFU6IDAgUElEOiAxIENvbW06
IHN3YXBwZXIvMCBOb3QgdGFpbnRlZCA2LjguMC1yYzItMDAwMTYtZzMwZDVhNjg1YzY1ZCAjNg0K
PiBbICAgIDAuMDY2NzE5XSBIYXJkd2FyZSBuYW1lOiBNWUMtWUcyTFggKERUKQ0KPiBbICAgIDAu
MDY2NzkzXSBDYWxsIHRyYWNlOg0KPiBbICAgIDAuMDY2ODM2XSAgZHVtcF9iYWNrdHJhY2UrMHg5
OC8weDExOA0KPiBbICAgIDAuMDY2OTAwXSAgc2hvd19zdGFjaysweDE4LzB4MjQNCj4gWyAgICAw
LjA2Njk1OV0gIGR1bXBfc3RhY2tfbHZsKzB4NjAvMHhhYw0KPiBbICAgIDAuMDY3MDI5XSAgcHJp
bnRfcmVwb3J0KzB4ZjgvMHg1ZDgNCj4gWyAgICAwLjA2NzA5Nl0gIGthc2FuX3JlcG9ydCsweGMw
LzB4MTAwDQo+IFsgICAgMC4wNjcxNTldICBfX2FzYW5fcmVwb3J0X3N0b3JlNF9ub2Fib3J0KzB4
MjAvMHgyYw0KPiBbICAgIDAuMDY3MjM1XSAgcG9wdWxhdGVfY2FjaGVfbGVhdmVzKzB4MjVjLzB4
MmQwDQo+IFsgICAgMC4wNjczMDhdICBkZXRlY3RfY2FjaGVfYXR0cmlidXRlcysweDM0Yy8weDE5
OTgNCj4gWyAgICAwLjA2NzM4NF0gIHVwZGF0ZV9zaWJsaW5nc19tYXNrcysweDMwLzB4NTU0DQo+
IFsgICAgMC4wNjc0NjBdICBzdG9yZV9jcHVfdG9wb2xvZ3krMHhlOC8weDE4OA0KPiBbICAgIDAu
MDY3NTI4XSAgc21wX3ByZXBhcmVfY3B1cysweDVjLzB4MjM4DQo+IFsgICAgMC4wNjc2MDJdICBr
ZXJuZWxfaW5pdF9mcmVlYWJsZSsweDI1OC8weGIxOA0KPiBbICAgIDAuMDY3NjczXSAga2VybmVs
X2luaXQrMHgzMC8weDIwOA0KPiBbICAgIDAuMDY3NzM2XSAgcmV0X2Zyb21fZm9yaysweDEwLzB4
MjANCj4gWyAgICAwLjA2NzgwMl0NCj4gWyAgICAwLjA2NzgzNV0gQWxsb2NhdGVkIGJ5IHRhc2sg
MToNCj4gWyAgICAwLjA2Nzg4OV0gIGthc2FuX3NhdmVfc3RhY2srMHgzYy8weDY0DQo+IFsgICAg
MC4wNjc5NTZdICBrYXNhbl9zYXZlX3RyYWNrKzB4MjAvMHgzYw0KPiBbICAgIDAuMDY4MDIwXSAg
a2FzYW5fc2F2ZV9hbGxvY19pbmZvKzB4NjgvMHg3OA0KPiBbICAgIDAuMDY4MDkwXSAgX19rYXNh
bl9rbWFsbG9jKzB4ZDQvMHhkOA0KPiBbICAgIDAuMDY4MTU0XSAgX19rbWFsbG9jKzB4MWMwLzB4
NDMwDQo+IFsgICAgMC4wNjgyMTVdICBhbGxvY2F0ZV9jYWNoZV9pbmZvKzB4YTgvMHgyMDQNCj4g
WyAgICAwLjA2ODI4NF0gIGZldGNoX2NhY2hlX2luZm8rMHhjNC8weDIwMA0KPiBbICAgIDAuMDY4
MzQ5XSAgaW5pdF9jcHVfdG9wb2xvZ3krMHgzNDgvMHg0NWMNCj4gWyAgICAwLjA2ODQyM10gIHNt
cF9wcmVwYXJlX2NwdXMrMHgxYy8weDIzOA0KPiBbICAgIDAuMDY4NDkyXSAga2VybmVsX2luaXRf
ZnJlZWFibGUrMHgyNTgvMHhiMTgNCj4gWyAgICAwLjA2ODU2MV0gIGtlcm5lbF9pbml0KzB4MzAv
MHgyMDgNCj4gWyAgICAwLjA2ODYyMl0gIHJldF9mcm9tX2ZvcmsrMHgxMC8weDIwDQo+IFsgICAg
MC4wNjg2ODVdDQo+IFsgICAgMC4wNjg3MTldIFRoZSBidWdneSBhZGRyZXNzIGJlbG9uZ3MgdG8g
dGhlIG9iamVjdCBhdCBmZmZmMDAwMDA4MjM3MDAwDQo+IFsgICAgMC4wNjg3MTldICB3aGljaCBi
ZWxvbmdzIHRvIHRoZSBjYWNoZSBrbWFsbG9jLTI1NiBvZiBzaXplIDI1Ng0KPiBbICAgIDAuMDY4
ODQ5XSBUaGUgYnVnZ3kgYWRkcmVzcyBpcyBsb2NhdGVkIDQgYnl0ZXMgdG8gdGhlIHJpZ2h0IG9m
DQo+IFsgICAgMC4wNjg4NDldICBhbGxvY2F0ZWQgMjE2LWJ5dGUgcmVnaW9uIFtmZmZmMDAwMDA4
MjM3MDAwLCBmZmZmMDAwMDA4MjM3MGQ4KQ0KPiBbICAgIDAuMDY4OTg0XQ0KPiBbICAgIDAuMDY5
MDE4XSBUaGUgYnVnZ3kgYWRkcmVzcyBiZWxvbmdzIHRvIHRoZSBwaHlzaWNhbCBwYWdlOg0KPiBb
ICAgIDAuMDY5MDg5XSBwYWdlOihfX19fcHRydmFsX19fXykgcmVmY291bnQ6MSBtYXBjb3VudDow
IG1hcHBpbmc6MDAwMDAwMDAwMDAwMDAwMCBpbmRleDoweDANCj4gcGZuOjB4NDgyMzYNCj4gWyAg
ICAwLjA2OTIwMV0gaGVhZDooX19fX3B0cnZhbF9fX18pIG9yZGVyOjEgZW50aXJlX21hcGNvdW50
OjAgbnJfcGFnZXNfbWFwcGVkOjAgcGluY291bnQ6MA0KPiBbICAgIDAuMDY5Mjk3XSBmbGFnczog
MHg4NDAoc2xhYnxoZWFkfHpvbmU9MCkNCj4gWyAgICAwLjA2OTM2Nl0gcGFnZV90eXBlOiAweGZm
ZmZmZmZmKCkNCj4gWyAgICAwLjA2OTQzMF0gcmF3OiAwMDAwMDAwMDAwMDAwODQwIGZmZmYwMDAw
MDgwMDFiNDAgZGVhZDAwMDAwMDAwMDEyMiAwMDAwMDAwMDAwMDAwMDAwDQo+IFsgICAgMC4wNjk1
MjZdIHJhdzogMDAwMDAwMDAwMDAwMDAwMCAwMDAwMDAwMDgwMTAwMDEwIDAwMDAwMDAxZmZmZmZm
ZmYgMDAwMDAwMDAwMDAwMDAwMA0KPiBbICAgIDAuMDY5NjE2XSBwYWdlIGR1bXBlZCBiZWNhdXNl
OiBrYXNhbjogYmFkIGFjY2VzcyBkZXRlY3RlZA0KPiBbICAgIDAuMDY5Njg0XQ0KPiBbICAgIDAu
MDY5NzE3XSBNZW1vcnkgc3RhdGUgYXJvdW5kIHRoZSBidWdneSBhZGRyZXNzOg0KPiBbICAgIDAu
MDY5NzgxXSAgZmZmZjAwMDAwODIzNmY4MDogZmMgZmMgZmMgZmMgZmMgZmMgZmMgZmMgZmMgZmMg
ZmMgZmMgZmMgZmMgZmMgZmMNCj4gWyAgICAwLjA2OTg3MF0gIGZmZmYwMDAwMDgyMzcwMDA6IDAw
IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwDQo+IFsgICAgMC4w
Njk5NThdID5mZmZmMDAwMDA4MjM3MDgwOiAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAw
MCBmYyBmYyBmYyBmYyBmYw0KPiBbICAgIDAuMDcwMDQyXSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXg0KPiBbICAgIDAuMDcwMTE2XSAgZmZmZjAw
MDAwODIzNzEwMDogZmMgZmMgZmMgZmMgZmMgZmMgZmMgZmMgZmMgZmMgZmMgZmMgZmMgZmMgZmMg
ZmMNCj4gWyAgICAwLjA3MDIwNF0gIGZmZmYwMDAwMDgyMzcxODA6IGZjIGZjIGZjIGZjIGZjIGZj
IGZjIGZjIGZjIGZjIGZjIGZjIGZjIGZjIGZjIGZjDQo+IFsgICAgMC4wNzAyOTBdID09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PQ0KPiANCj4gWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LQ0KPiByb2NrY2hpcC8y
Mjg1ZWU0MWUxNjU4MTMwMTEyMjBmOTQ2OWUyODY5NzkyM2FhNmUwLjE3MDk0OTExMDguZ2l0LmRz
aW1pY0BtYW5qYXJvLm9yZy8NCj4gDQo+ID4NCj4gPiBDaGVlcnMsDQo+ID4gQmlqdQ0KPiA+DQo=

