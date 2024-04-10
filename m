Return-Path: <linux-kernel+bounces-138819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0475589FABF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E535A1C22BE6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F50B16F914;
	Wed, 10 Apr 2024 14:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="bg+U/A2R"
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2119.outbound.protection.outlook.com [40.107.114.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F60116F28B;
	Wed, 10 Apr 2024 14:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.114.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712760896; cv=fail; b=R1fN5ShZ0KdlbQ1Ta3MxpsQWg4jiHrHoah3L/YGkI+VDeAjJO+/pcfB6fh6YAmB+2BhXGKDIhiZLvh5NJoA1X2EIl0xUiGF40ynNju/3mp8WVkYSqEhbP1oCyUR4l7JArJsdEAPYf0RtMKhWq7jr8yjDKtmGW+ratrFdYJStNko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712760896; c=relaxed/simple;
	bh=r/tPlVGQyVR2Io74HPvQexlM2GqDZZBEf6aYjyNrQrs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aDzHTqXVWEiJnpdDnzjaJ5fO91726I1tTrTkfdRFMIj+8o62cvpjc47sLXwXCTZgLq7LRt7WSQfBXFZ+FlGY+O09k7oihl/w+lRvm9mzCWxOfG6FGWjMJhQ2perdc9NsomTO10ksRfJvJrY9DZi+KKPgECLxqQ+UZW3gyerieAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=bg+U/A2R; arc=fail smtp.client-ip=40.107.114.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J9lDWQd09GcyNH+4yzeMsG9kie650QRrnjcfiC6rS9Bttk/bv+69oz9AxyxW0nywYfBHxMypqh5c+FTyoOiXSbktExHDQgtx/VomR7RzY5JeJA3I9NIgLu7lNfLXYKFar6KY8PXdLmCN6Z+kP389lXH/MHOSlhkl4LrhZRBcD2tAVlYRmuOM/hk6pv+3rkZw1kuwHYAHROigaRVMu1UGRBRb21UWsHkhIOrT0Pl4nac+Eg9zTa9ejzBZE528sqTYC0wWX4dtMErkhFEkpZathT1H1zZBx/3dVo4VRmRWG6hRAHSD9WJgQ2Uk7O1N9l6gbQ+QouHBkO1/pB92e/6oDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/tPlVGQyVR2Io74HPvQexlM2GqDZZBEf6aYjyNrQrs=;
 b=SHelefKjgIwxPvL9DJp+FkRW/2VyUcNU/jwhUz3t1cub9ewumDRUNBcnismkAPXK/3xmHuIBfU13dipvwG2JSjsCky4XIQyNwQyJPYrrxeBQgLBxFU4RsmUZ/qpezkgTG8Sp+E89df69oh3rCzbVX/jqbrL1PEIGeAI45P5PhStFE3YUWMK6AKYrUrlmXtRR4QRCD+0OKo5XTaJbtJ2BffEFgyUn9i1tjR/wrySp5/HOkrHocVYqa7CiJh497gr3v+3yz/PgduuWBUF640vbdvknqgwUxLXoIQ86ILOTUf5/q/iszwKEFuYJe8qxBt9xQ65WojaScNwkF9SSgXaOQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/tPlVGQyVR2Io74HPvQexlM2GqDZZBEf6aYjyNrQrs=;
 b=bg+U/A2Rmk0MzUme9Mr+VCUfZx36KQ5G7ylKHkEbA0C9t+RnPePlmecEuubwKGwkUZBEma9YySF3migaunvDG3voko7C/YuYoDUXzONCjneiin+N9IwWzr/2BSp+tNKYK1FpCfzZsa2fiwSJOiCpUAGGiZKFU4JTwlQbE8HdMOA=
Received: from OSAPR01MB1587.jpnprd01.prod.outlook.com (2603:1096:603:2e::16)
 by OS7PR01MB11869.jpnprd01.prod.outlook.com (2603:1096:604:236::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 14:54:49 +0000
Received: from OSAPR01MB1587.jpnprd01.prod.outlook.com
 ([fe80::fda5:45f9:f1b2:cbce]) by OSAPR01MB1587.jpnprd01.prod.outlook.com
 ([fe80::fda5:45f9:f1b2:cbce%3]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 14:54:48 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Claudiu.Beznea <claudiu.beznea@tuxon.dev>, "wim@linux-watchdog.org"
	<wim@linux-watchdog.org>, "linux@roeck-us.net" <linux@roeck-us.net>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "geert+renesas@glider.be"
	<geert+renesas@glider.be>, "magnus.damm@gmail.com" <magnus.damm@gmail.com>
CC: "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH RESEND v8 03/10] watchdog: rzg2l_wdt: Use
 pm_runtime_resume_and_get()
Thread-Topic: [PATCH RESEND v8 03/10] watchdog: rzg2l_wdt: Use
 pm_runtime_resume_and_get()
Thread-Index: AQHai0zBWu2V0gpeGk2Rf6eyLae+ArFhiuxggAAK64CAAABuQA==
Date: Wed, 10 Apr 2024 14:54:48 +0000
Message-ID:
 <OSAPR01MB1587065352A1AF2922DD6B4186062@OSAPR01MB1587.jpnprd01.prod.outlook.com>
References: <20240410134044.2138310-1-claudiu.beznea.uj@bp.renesas.com>
 <20240410134044.2138310-4-claudiu.beznea.uj@bp.renesas.com>
 <OSAPR01MB158744E15B527496A8ABA4CE86062@OSAPR01MB1587.jpnprd01.prod.outlook.com>
 <4bbddd59-0bb4-4084-9968-139b88dc2c86@tuxon.dev>
In-Reply-To: <4bbddd59-0bb4-4084-9968-139b88dc2c86@tuxon.dev>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB1587:EE_|OS7PR01MB11869:EE_
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 17bABpDKHBkgQDuiLkUeL2WMZ0KXlqvsUO2FNAPvQ7VE6UphYRliBjtwhiyREUGAUVrbiCJXP7OANOtJN4TgnDkVlBYJedFvJil2SejqnG1Yxp4Ej1lOoGTanXWaqeo+uVH5pwX2iEPuaTjC2G6+VUde12mficGMjTYr4yRZ1L/f4Bwkdcka1BcZKNbiGnGgcCn/fwai5e2k3EvTkvIQEH20Ofr94Cd2nbpYTJdthLbsGndEQ/t8l+aw9m/VA6yzX/upMWs/CDYNk7TVJsSoMJbn1QKdA8ReK30xGIzDvBdiaDSXniALKqie7Fn4ZXEut2wvavkmd/E3MHT78MdLf5EBxTFQVV5gnI1Pf8x8KHg+dfTRdTEn5BanGkw7aCGCbGcbICEC7wCeEhjq2yaZ40c1KoYHZ9mQWNdxt4yhYCUzLGmF33pSS+UdIBiwO0Ta79X4e4F2d2ypWxcSRbtooEXgaRm1u+UYScZWVKYNTfrYV6SzfXfVeMJV0P9cQCmVm5rL17lqOs1L6z84ipeWdvqgsb5ss1IM+k/4cPdArgZ/krE9N6y2lCCVoXsX3zuDcVkV1OjlQkEYa5oalqKRjdAzIJCZAGt8KunRvJfGh8HNZhiBBJ6iq9CT0Z3UI20DhaurG3PqRYNvAdHTvZ/jhOGlqvNcQXp89hIjSep1c1c=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB1587.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YmdqMm10bWZXeE5jRlhOa2hjMFovYTBXYVdGOTBuYkl6K0tWTTJhNGN4NlM5?=
 =?utf-8?B?TEhud09jU0t0RFMrQkxUbEtIWXNZTi82RkpxREl6aklPWGFTZTZuemZ1bEhP?=
 =?utf-8?B?eWFQbDkzSVNhTVBEY2lQQmhFRE4zT3NIRE9UUkFFN2ZZUUdOMklmL2FqZVdv?=
 =?utf-8?B?ckFNWWJsRnhRdXJ0Vi84Vk8vYWoxUmJqd2hEZUNlUWtFaGV5SmhyQ1B6ZGx3?=
 =?utf-8?B?WVBJaS9xaEFyZW04RDJwNFN3MVhTQjRwUm9rMStkSytFYTFDd3ZsZ0xhQ1Bn?=
 =?utf-8?B?UHJJUXhlQ2tKbkVUK2t6T1Q0SXJOT0VtbzJFdnV4dWt6djBZaDNTZmNQNkxY?=
 =?utf-8?B?VUo0N0pxRmRKR2tCY0FLRk15Mk5weHNmekZRTzBNdG1IWmxhci9WSU5SNnY3?=
 =?utf-8?B?RXEvVlc5Yk9YOW1vN2cxVE42SjZzZTRZSkdPR1QvMnlMVmlIcXI1bDFQcXpu?=
 =?utf-8?B?M0YwR2U4cFNSOHowVFdFcjErWDBjV2RCeWp3QW5MNFRPcVV2MGMwLzFvbFdB?=
 =?utf-8?B?amFVaWhXdVNLVGRCYVdaait5dGpubjFxSDd3ZVVBd09PYStwT0J4T0cveWtZ?=
 =?utf-8?B?TUVkdFpNUFl3VjNhaHhJTkRZZUkvdkdhL1dxREtwNWhDY3VhcjJJUVQwNHN0?=
 =?utf-8?B?endjTSt3Y0E0bHBoRW5zSy96a0ZJVVlTdE5yWHQwZlovZ0RwdEtvaS80R01X?=
 =?utf-8?B?TFVRUGo3N1ZjY3FDSnphMnFpTDJoRG9JWXRlcEN0OHpUTVdOMDFKRlV0U1hj?=
 =?utf-8?B?SkgvbTFSeXlVRkFyUkpXWTloR21mWkNYYmxoc3BvT1pVMzcwVFdpVUkxWk4r?=
 =?utf-8?B?Z2d4QndIS016aXFKdkRvdWR4eVg5bC9TQTUvWmpNaTBZMzVndFhTSXVoQW9y?=
 =?utf-8?B?Wk1wSjlKUktBdUZ1SDlHNDV6cVM2RVBreGJyRUF2Q2pIdVEvanVqYzZQTkVO?=
 =?utf-8?B?dXg2M25GRDg5QUNrcHRIR3JVUUNBd0dPNHpuQ1poZW1kVHhsd2RFelluMnMr?=
 =?utf-8?B?VVpScWFDTEJqVDhDajN1d0ppUDl3YTQ2WlpOVVdqNG14aUZsNlpZbS9lWFh0?=
 =?utf-8?B?VnhPQU8yRktWdUhqdlhHSWJrcjZnc1pQMlJvQXhWWHJ2K252Q3U5dnBERzMv?=
 =?utf-8?B?THBpYkJxMjZ5Sk1VeFZFSWpIQm9tQUlNeVpPdm5iMGNtT05sWlY1YlJnMlI2?=
 =?utf-8?B?bEhvb1FiVFdRQVJ3dVQ4R3R3M0F0ZzdwVVkzajBONHptZ3BRNTB6Ukp2cVU0?=
 =?utf-8?B?TW5VdDFuN1BjenRaZ3ZubFRNaloyMENiZ1A0ZjE3bHVlcjZvZTZMZ3hTRmVX?=
 =?utf-8?B?MlRFNDFHaHBFOHZsNmlTYWRzKzRkYTdQQmw5dFdraUdFNmRGUmN1WTAyMGRF?=
 =?utf-8?B?SmRtS0F6OGU0QlR2UFV4TFdMVHA2dzNwc2hZRHcxVGc4THdMRkltdW9Fc0Nj?=
 =?utf-8?B?dWx2SXJOeC9VODUweEpLc0RHKzFtdEZGT21ZZGVRMHZqc2RSQlBmYUVqbWFo?=
 =?utf-8?B?L2l6Ky9OOEFkQmxaMWJXbUZ1dG1zSkJmdG85bDM1L0V1MmVlZjl5WGhla0or?=
 =?utf-8?B?NTdKVFUwdlBqcG13SWdDeHppdTBOTU5ISnZ1bTlZd0xnaFRreGRhalNqV05R?=
 =?utf-8?B?ZGYvOWxXQ3RxUTFISWNTZkM1M2xDRWY1UHhnaWpDVW03VU1CK1RqM2lPMWti?=
 =?utf-8?B?dlFFdEMrMmFRV0wrcnBOS3hqTHY2OFYrU1JCUUl2NWYxQytyeUNJRjhlR0li?=
 =?utf-8?B?MGJ0V29MSFVaVllQTk9QWlF1ajJ6eEQ1SXV0M1N5NDNLOE1ZdU5rWmp3a2JI?=
 =?utf-8?B?LytWVm9mTUxIV3RUUGR1ZTBjeVhLNzgwZHJSMkVzQ2NJZUo0dlU3K3ZWRXFI?=
 =?utf-8?B?Tzl2TmJsMk8wb0tkektUQ3Z6dHZGNFZSVVRSNXR4bDErNDFoSkxKOFlkTzFq?=
 =?utf-8?B?eGdvV1lIQ3JKYTU5b3hyK3F5dFNCMHF5VklTRVh0ZTNDcVV2YmY2RzI1cHVp?=
 =?utf-8?B?dTlhc0hwUGN6VTk5WHVrRUdxcXo2bUk3NStWWDlYTDdmUU90N1pYT2xtM3V5?=
 =?utf-8?B?UjVtUkRnMHh3dW53S3gzKzNwS0h5bnNYKzdNdTh2Z0Y2VXZOOHg1aGZ5VmYz?=
 =?utf-8?B?L2I1NDA4VldtUXpkSzYwNzMvNnd2OHJTWjQ5Ky9oVFZ6cEFLOElhMGFtVy8z?=
 =?utf-8?B?aHc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ac5b9dd-89b8-4617-8128-08dc596e2b51
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2024 14:54:48.7221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X/L8IaIW7RP3SvxZictq3rDuuo5GfdZnYsXfQ5EdgEoQmvnO8P9PGu0gRV+3Zw5QKAo4KZYybiFAUWPHtMYURNA8k6DFti3lUe3oqCmc0C8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11869

SGkgQ2xhdWRpdSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBjbGF1
ZGl1IGJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAdHV4b24uZGV2Pg0KPiBTZW50OiBXZWRuZXNkYXks
IEFwcmlsIDEwLCAyMDI0IDM6NDkgUE0NCj4gU3ViamVjdDogUmU6IFtQQVRDSCBSRVNFTkQgdjgg
MDMvMTBdIHdhdGNoZG9nOiByemcybF93ZHQ6IFVzZSBwbV9ydW50aW1lX3Jlc3VtZV9hbmRfZ2V0
KCkNCj4gDQo+IA0KPiANCj4gT24gMTAuMDQuMjAyNCAxNzoxMywgQmlqdSBEYXMgd3JvdGU6DQo+
ID4gSGkgQ2xhdWRpdSwNCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+
PiBGcm9tOiBDbGF1ZGl1IDxjbGF1ZGl1LmJlem5lYUB0dXhvbi5kZXY+DQo+ID4+IFNlbnQ6IFdl
ZG5lc2RheSwgQXByaWwgMTAsIDIwMjQgMjo0MSBQTQ0KPiA+PiBTdWJqZWN0OiBbUEFUQ0ggUkVT
RU5EIHY4IDAzLzEwXSB3YXRjaGRvZzogcnpnMmxfd2R0OiBVc2UNCj4gPj4gcG1fcnVudGltZV9y
ZXN1bWVfYW5kX2dldCgpDQo+ID4+DQo+ID4+IEZyb206IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1
LmJlem5lYS51akBicC5yZW5lc2FzLmNvbT4NCj4gPj4NCj4gPj4gcG1fcnVudGltZV9nZXRfc3lu
YygpIG1heSByZXR1cm4gd2l0aCBlcnJvci4gSW4gY2FzZSBpdCByZXR1cm5zIHdpdGgNCj4gPj4g
ZXJyb3INCj4gPj4gZGV2LT5wb3dlci51c2FnZV9jb3VudCBuZWVkcyB0byBiZSBkZWNyZW1lbnRl
ZC4NCj4gPj4gZGV2LT5wbV9ydW50aW1lX3Jlc3VtZV9hbmRfZ2V0KCkNCj4gPj4gdGFrZXMgY2Fy
ZSBvZiB0aGlzLiBUaHVzIHVzZSBpdC4NCj4gPj4NCj4gPj4gQWxvbmcgd2l0aCBpdCB0aGUgcnpn
Mmxfd2R0X3NldF90aW1lb3V0KCkgZnVuY3Rpb24gd2FzIHVwZGF0ZWQgdG8NCj4gPj4gcHJvcGFn
YXRlIHRoZSByZXN1bHQgb2YNCj4gPj4gcnpnMmxfd2R0X3N0YXJ0KCkgdG8gaXRzIGNhbGxlci4N
Cj4gPj4NCj4gPj4gRml4ZXM6IDJjYmM1Y2QwYjU1ZiAoIndhdGNoZG9nOiBBZGQgV2F0Y2hkb2cg
VGltZXIgZHJpdmVyIGZvcg0KPiA+PiBSWi9HMkwiKQ0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBDbGF1
ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWEudWpAYnAucmVuZXNhcy5jb20+DQo+ID4+IC0tLQ0K
PiA+Pg0KPiA+PiBDaGFuZ2VzIGluIHY4Og0KPiA+PiAtIG5vbmUNCj4gPj4NCj4gPj4gQ2hhbmdl
cyBpbiB2NzoNCj4gPj4gLSBub25lDQo+ID4+DQo+ID4+IENoYW5nZXMgaW4gdjY6DQo+ID4+IC0g
bm9uZQ0KPiA+Pg0KPiA+PiBDaGFuZ2VzIGluIHY1Og0KPiA+PiAtIG5vbmUNCj4gPj4NCj4gPj4g
Q2hhbmdlcyBpbiB2NDoNCj4gPj4gLSBub25lDQo+ID4+DQo+ID4+IENoYW5nZXMgaW4gdjM6DQo+
ID4+IC0gbm9uZQ0KPiA+Pg0KPiA+PiBDaGFuZ2VzIGluIHYyOg0KPiA+PiAtIHByb3BhZ2F0ZSB0
aGUgcmV0dXJuIGNvZGUgb2YgcnpnMmxfd2R0X3N0YXJ0KCkgdG8gaXQncyBjYWxsZXJzDQo+ID4+
DQo+ID4+DQo+ID4+ICBkcml2ZXJzL3dhdGNoZG9nL3J6ZzJsX3dkdC5jIHwgMTEgKysrKysrKyst
LS0NCj4gPj4gIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0p
DQo+ID4+DQo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3dhdGNoZG9nL3J6ZzJsX3dkdC5jDQo+
ID4+IGIvZHJpdmVycy93YXRjaGRvZy9yemcybF93ZHQuYyBpbmRleCAxNzQxZjk4Y2E2N2MuLmQ4
N2Q0ZjUwMTgwYw0KPiA+PiAxMDA2NDQNCj4gPj4gLS0tIGEvZHJpdmVycy93YXRjaGRvZy9yemcy
bF93ZHQuYw0KPiA+PiArKysgYi9kcml2ZXJzL3dhdGNoZG9nL3J6ZzJsX3dkdC5jDQo+ID4+IEBA
IC0xMjMsOCArMTIzLDExIEBAIHN0YXRpYyB2b2lkIHJ6ZzJsX3dkdF9pbml0X3RpbWVvdXQoc3Ry
dWN0DQo+ID4+IHdhdGNoZG9nX2RldmljZSAqd2RldikgIHN0YXRpYyBpbnQgcnpnMmxfd2R0X3N0
YXJ0KHN0cnVjdCB3YXRjaGRvZ19kZXZpY2UgKndkZXYpICB7DQo+ID4+ICAJc3RydWN0IHJ6ZzJs
X3dkdF9wcml2ICpwcml2ID0gd2F0Y2hkb2dfZ2V0X2RydmRhdGEod2Rldik7DQo+ID4+ICsJaW50
IHJldDsNCj4gPj4NCj4gPj4gLQlwbV9ydW50aW1lX2dldF9zeW5jKHdkZXYtPnBhcmVudCk7DQo+
ID4+ICsJcmV0ID0gcG1fcnVudGltZV9yZXN1bWVfYW5kX2dldCh3ZGV2LT5wYXJlbnQpOw0KPiA+
DQo+ID4gRG8gd2UgbmVlZCB0aGlzIGNoYW5nZSBhdCBhbGw/DQo+IA0KPiBJIGhhdmVuJ3QgZW5j
b3VudGVyZWQgaXNzdWVzIHcvbyB0aGlzIHBhdGNoLCB0aG91Z2ggSSd2ZSBkaWQgYWxsIG15IHRl
c3RpbmcgKGluY2x1ZGluZyBzdXNwZW5kIHRvDQo+IFJBTSkgd2l0aCB0aGlzIHBhdGNoIG9uIG15
IHRyZWUuDQo+IA0KPiA+IElmIHdlIGhhdmUgYmFsYW5jZWQgdXNhZ2UgdGhlbg0KPiA+IHRoaXMg
d29uJ3QgYmUgYSBpc3N1ZS4NCj4gDQo+IEkgdGhpbmsgd2Ugc2hvdWxkIGp1c3QgdXNlIHRoZSBw
cm9wZXIgQVBJcyB3L28gbWFraW5nIGFzc3VtcHRpb25zLg0KDQpDdXJyZW50bHkgbWFueSBzdWJz
eXN0ZW1zIGluIGxpbnV4IGtlcm5lbCB1c2UgcG1fcnVudGltZV9nZXRfc3luYygpIA0Kd2l0aG91
dCBhbnkgZXJyb3IgY2hlY2tzIGFuZCBpdCBpcyBmaW5lIHRvIHVzZSBhcyBsb25nIGFzIHRoZSB1
c2FnZSBpcyBiYWxhbmNlZC4NCg0KTW9yZW92ZXIsIGN1cnJlbnRseSB5b3UgYXJlIG5vdCBhYmxl
IHRvIHJlcHJvZHVjZSBhbiBlcnJvciBjb25kaXRpb24NCmhlbmNlIGNoZWNraW5nIGRvIHdlIG5l
ZWQgdGhpcyBjaGFuZ2U/DQoNCkNoZWVycywNCkJpanUNCg0KPiANCj4gPiBEaWQgYW55IHVuYmFs
YW5jZWQgdXNhZ2UgY291bnQgcG9wdXANCj4gPiBkdXJpbmcgdGhlIHRlc3Rpbmc/DQo+ID4NCj4g
PiBDaGVlcnMsDQo+ID4gQmlqdQ0KPiA+DQo+ID4+ICsJaWYgKHJldCkNCj4gPj4gKwkJcmV0dXJu
IHJldDsNCj4gPj4NCj4gPj4gIAkvKiBJbml0aWFsaXplIHRpbWUgb3V0ICovDQo+ID4+ICAJcnpn
Mmxfd2R0X2luaXRfdGltZW91dCh3ZGV2KTsNCj4gPj4gQEAgLTE1MCw2ICsxNTMsOCBAQCBzdGF0
aWMgaW50IHJ6ZzJsX3dkdF9zdG9wKHN0cnVjdCB3YXRjaGRvZ19kZXZpY2UNCj4gPj4gKndkZXYp
DQo+ID4+DQo+ID4+ICBzdGF0aWMgaW50IHJ6ZzJsX3dkdF9zZXRfdGltZW91dChzdHJ1Y3Qgd2F0
Y2hkb2dfZGV2aWNlICp3ZGV2LA0KPiA+PiB1bnNpZ25lZCBpbnQgdGltZW91dCkgIHsNCj4gPj4g
KwlpbnQgcmV0ID0gMDsNCj4gPj4gKw0KPiA+PiAgCXdkZXYtPnRpbWVvdXQgPSB0aW1lb3V0Ow0K
PiA+Pg0KPiA+PiAgCS8qDQo+ID4+IEBAIC0xNTksMTAgKzE2NCwxMCBAQCBzdGF0aWMgaW50IHJ6
ZzJsX3dkdF9zZXRfdGltZW91dChzdHJ1Y3QNCj4gPj4gd2F0Y2hkb2dfZGV2aWNlICp3ZGV2LCB1
bnNpZ25lZCBpbnQgdGltZQ0KPiA+PiAgCSAqLw0KPiA+PiAgCWlmICh3YXRjaGRvZ19hY3RpdmUo
d2RldikpIHsNCj4gPj4gIAkJcnpnMmxfd2R0X3N0b3Aod2Rldik7DQo+ID4+IC0JCXJ6ZzJsX3dk
dF9zdGFydCh3ZGV2KTsNCj4gPj4gKwkJcmV0ID0gcnpnMmxfd2R0X3N0YXJ0KHdkZXYpOw0KPiA+
PiAgCX0NCj4gPj4NCj4gPj4gLQlyZXR1cm4gMDsNCj4gPj4gKwlyZXR1cm4gcmV0Ow0KPiA+PiAg
fQ0KPiA+Pg0KPiA+PiAgc3RhdGljIGludCByemcybF93ZHRfcmVzdGFydChzdHJ1Y3Qgd2F0Y2hk
b2dfZGV2aWNlICp3ZGV2LA0KPiA+PiAtLQ0KPiA+PiAyLjM5LjINCj4gPg0K

