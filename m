Return-Path: <linux-kernel+bounces-89672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B2D86F3FD
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 09:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D7DA2827FB
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 08:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B1F9468;
	Sun,  3 Mar 2024 08:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="On0dcdbA"
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2063.outbound.protection.outlook.com [40.107.113.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70143A94C
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 08:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.113.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709454575; cv=fail; b=jMM0xNOHmZTJE/fBSyBUG6LpxGXZcLEBXEjA4r4Lua8J3qcsf56aCGFDwKsuSlOzyhtYjDQCbMZbzDB1QqkW4rzYggYYFec2AbtiyD0u7hN3FwBOfsnLGtXoaqfpn5vEv1mBqs7yOCSa/WKMXWNJXyE/oj4Dq81LokBXjkBHbaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709454575; c=relaxed/simple;
	bh=DZx+XmpGVFBbECjyqinreSQQ1xAiL+fWztsHHr0Vzpo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R57cTICP5yLZCLUUgiLZc6zFc7QTUslH6YWtUQi7jlnVYB80DFUy+i35VyhjndzJG/xOx3zmd/fMyAbFeMN+2HtOM/THrnpP7HWxbyhJ06IJo4RdURDJvZDTc+jKDptt8gFBITmx7UZc+bZE4y9JjFjxZgkUKf251RcgnJgPmYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=On0dcdbA; arc=fail smtp.client-ip=40.107.113.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FqpopNVY9bDs5HaTv3Oo56U5YYTG9L+jAfnDmhkOmHD+bA/dXbUZAr9A+oJJwzS162TMNCPhoeFs4FIcJfgDRX4IbmKqsq8FEh/C/99easd3GYCtzK+jrM0wSLQ/M6i5+v2rUBr1cngt6JjRmuzKdtHI81KTEC9Wu2/7Q9peEHCaPq7LmYTTvBa/C8ipRIVX0pfXA4nrxdRzCSn1XktUrcN+zlVsoGXWkgX1ia8ysq8Pdttkwa1fTsZZ2WxAA18ewLwAHZdGxydVb1ka3IKbjA4S/X3FSWOtqmn3qImRAw+Ff5lHaVtfRbsMjjlD3LLuUf27WKguCqnPnUKg1VQUVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZx+XmpGVFBbECjyqinreSQQ1xAiL+fWztsHHr0Vzpo=;
 b=HVahcslbyRpDOfeGEMljqoDqgeF41LjCgHfNHDiMt4me9MCxWjHl8Fb1UxfNWVOIhNXe16wJplGTbr0/mqsVFcoqwJBzEhbHlFPD2KV6HZ35xzMWWY6FHMP80DCDqVNmf4zvUAYHSvbglhnbHrwUEZnUHRE9YGSpl4vBkwtyq0O7g8hzHIKr0ubmMM+6Oc/DuAIhlpOaXO3vH5sUd6/YaYWb0dzcjmfWN/5mOsz5sab/50bZTHdn1EbUHBqEWxkLAh2C/KFFXu2+3RKJB1nUA/yX0GYvEfizZL4GGuaJzXMvrz/TxvHDsQEJI984v4FBFu6tGPc3kM5RRG+UkZc9Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZx+XmpGVFBbECjyqinreSQQ1xAiL+fWztsHHr0Vzpo=;
 b=On0dcdbAOprcmKQNNpnqad2mndbC/6ixrrFbIH6MqiDKhr4/dkJ0Kz789LsDdvy+nkZbj1agRHVm6e8ozGBN8xIn7ey6DOgvLjCuPWeCOjkkXAKzQE9WCmMmBPq1X8w0KTcwjhW0FIITDO3Y7TPFm199LstZ8K5ERQTdAFcAf2o=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by OS3PR01MB5574.jpnprd01.prod.outlook.com
 (2603:1096:604:c5::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.37; Sun, 3 Mar
 2024 08:29:26 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::6719:535a:7217:9f0]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::6719:535a:7217:9f0%3]) with mapi id 15.20.7316.039; Sun, 3 Mar 2024
 08:29:26 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [PATCH] mul_u64_u64_div_u64: Increase precision by conditionally
 swapping a and b
Thread-Topic: [PATCH] mul_u64_u64_div_u64: Increase precision by conditionally
 swapping a and b
Thread-Index: AQHabOPaylnxq7fpEkOamgBZySc32bElr1hg
Date: Sun, 3 Mar 2024 08:29:26 +0000
Message-ID:
 <TYCPR01MB112694AA0FB223130DB1644D2865C2@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <20240302205426.639205-2-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20240302205426.639205-2-u.kleine-koenig@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|OS3PR01MB5574:EE_
x-ms-office365-filtering-correlation-id: f8e5e14d-b108-4a9b-b507-08dc3b5c0991
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 J5MpjjhuOVjpNiaQlB1P9BE+tm2yEAfao1iwHaAH+gGoV4cnr2r2sPaZrO8ZqZigEJsjG+Z4YFcSc3qeV5BhyId7riIVzlNyd9MqnS/6ExgPW4Lbzrdv8dggjvIRDF55LC8BYG5mWw3I4E2FbVaD4BXV9uY72621GVGleoEGok3v2DlcqVWecpCyDNHJiL9L0moRqsjXOAVb5d4GTeOqRGBj8rkvEdjtSen0C7o7YjOaXJw7L2oW9yCxZSTRPZhFPJTYuCEwiTPwlJBHeSZjOQQS9ePVkzIOMCxPYW1V5gmpnbZ+/nBr0L8p2AJQy0HHmFTFbgW08YNvtKi+kK4oQEzaWncySBFWD+OjxBJUE5Xpg0tWvoaB1aHcEFWhmon7Q3bDC4uvBrwf3zYmg59wPDrv3a05fR/uzt+VEdQT4HI9gkbjMB69zAEoOnVpXv+g6MAhzEGJ04htmFN2c6V45IWwNewXmc7lkx4y58n+XxMo55c1HrKrHu3BlqbUe79UmjFCkr3s6Ewd2zics/Gvedw340HSoJ0khUuDKkTfbEByeN6dfPLvViTDRYeq2whv3lvi0q2oyZRL13l7Zhe4k+b4ita2nkoZ7Vhi+44QmxIuKxSkBMOlq5iE7C+L4Rk18AUIBwVP2ru96j19M+7tNGxO6RLkaiKXrHz8ul97bBnVOHGF4GTRP2fuID6DT8wc9UOXC1MeSfznbRI7Me6xotYr66NoJBaZotxhjUwq3bI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MnhwZDd4bGFSR2wvL2JXekI1cW13bTlaL2lVUG5OenJBVUt5NjE1SEJRcStX?=
 =?utf-8?B?djZDV2tKb1phTXZFSVRZcHJTamUwTnMxZU9VZkJObk1qK2hkWmNib1loWERv?=
 =?utf-8?B?VTk3UGZBWHRCa0RSNUFXNnBwdGxXMHZ0Tk94YTZUcEorMy96RzE1bytrK0Uv?=
 =?utf-8?B?ZjNCTHlhQ2QvblRpN0VFZFRJOC9LK0ZLYnJ3UXJlUGkxcFV1cXdYZ3dBcE8w?=
 =?utf-8?B?b25qc1NTWFAvc1J0YVRKZ0txTEYxeVl2anBkMzhIVFY1M0xiRlhsZnNob29W?=
 =?utf-8?B?QTBNclUyd0tUZHZkQm43ejhnT1NVSDJsRkNGdE1td3NuU05TemxiOFdhUzcw?=
 =?utf-8?B?bzFzRzdXekJZNWh1YkRpY2d4SDhXcFFQbE1VRDBHZ0VNZzBJK0pOZ2tiMTRG?=
 =?utf-8?B?V1NIT2MxdEE4ZDdydHNlRzdpRDVLWXdoR2VveTZRMHpYeXdaNUczUkdzWWJK?=
 =?utf-8?B?amRvbDQzSENBMkM3N3N3UENqRGpVMkpEWC92dG1PWUpsL1NVdzNFOC9kYWtJ?=
 =?utf-8?B?OU1CZ0ZxTmRML2twWWNoYjNQUEY5OThTMitSWUtmbVJOOGRpc2NqZTV4TExX?=
 =?utf-8?B?MGQzZVAyOTFJWlRtTGdyQlBieG02NmZJMURsN0dCcGxteGc2S0cxbzJUODBM?=
 =?utf-8?B?TTE1RTRKMWFtYVkwU0U5VFV3YjY5bDNDSlZBWEsrbkRRblJGaGR6RGtKRUVN?=
 =?utf-8?B?WFlsMmREZkM4ejMrU2k1aC9heDNsbC9wMGhlNWNLUVBicVVuU3ZwMU5EbVZa?=
 =?utf-8?B?ZDE0bUgyRVBoUXUvRlh2SzlYZGFmZ1hlMWdERVQ5ZFl4d2lPZGw5elJJZkpL?=
 =?utf-8?B?VHh2QWpoZlpjNXV1L0xMMjg5VHJybEI5TWNGc2VtWm00Wk5ab2diZytTUXdo?=
 =?utf-8?B?TVlZaUZCMG5iM3E5Sm51UnhiSlVKN1JwZFV3RlpNSEpHV1EreWxIZkxXdnor?=
 =?utf-8?B?UHdHdG1INHIwMitJWHppOHlqMkkzMzR3SVliVVpWcHpLbUx3Rkk1MmZZdmpu?=
 =?utf-8?B?REp5WTJ2NHBxQW40MjNqdC9NdC85emNrS3NmSDZtK0NpZnV6OUFPb2xOLzJj?=
 =?utf-8?B?QzVpVXZPVklLQm1LalpaejVEcXVDSVo2cHZ3QjQxTDFvQTYxbkpqYkx0VEl3?=
 =?utf-8?B?aUx5d1hUNHJpV0xVRmJJOWRKbkwvM25RUFVhczQzbnhkMVBPYXhBajJlajZZ?=
 =?utf-8?B?a2RwK0tjTUhFRG4zVkxoNDJPQU5lN1ZMWWlCWWFwQzVZQjIvUnFYTmFQQ3BF?=
 =?utf-8?B?Q3FVazF0d3hmek52cjduMkoxeHhaVy9MZm9zSWdicnZWbXIzR1FXanFobFNC?=
 =?utf-8?B?b2FSbzQ1OFUyN2JiekpuQ0RpaklhbFA2VDBxZ2VCaU9tQTBkWkVma0diZGky?=
 =?utf-8?B?ekVvQSs3MzhkNEdjS2I2UGYrcDNlelQwUHl1VGJlMEhLcHh2ZVRiRXRwQ05K?=
 =?utf-8?B?VDNzbWxJRm1aZHhKREJqNVc5ZThaVU9VTzdWTmY3cGMyWnhFa0tSaHFkRExO?=
 =?utf-8?B?L3dTU1dZVXRoNVMwQUkyZEsreExhLzRBNlBpSFVEREcwVVl2WUZsSmphcVBp?=
 =?utf-8?B?NUJaU2ViWERENDdFVzJ0WHh0VU9BV1JpenUxWWV6dFRDVmJUa292REMveGRa?=
 =?utf-8?B?eVUyYUFFdFBvYklSUFdMK0tGOFE3bk5TRFc5N3RlWVMwQ1l2YkQvelMxeGlr?=
 =?utf-8?B?U2lvRG9raWFDWnk5UEgvUVYwVTc1NWlnWGtpSkUzOHgySFl4K0hZVUM1ejVO?=
 =?utf-8?B?cDNPQWgwWHVVckNNMUtJTmEzRmd1NHpUUFRSN05qeHF5YkYyRFFoeEpjQ0Ny?=
 =?utf-8?B?SjRXUnlybXJxM3J4ZmV4U2pPUnVFa3BuLzA5UzdmcEZQREFDbnNYUlRsMDc4?=
 =?utf-8?B?blZDU0cwbG5JRDE4NEl2NGR0WEQ5aDd1emlqckJQaWd0dllwMzlOUkMzcmhU?=
 =?utf-8?B?Y3pxZHJLek81c2loRHROWVRsKy9jUEl2UVVEeHFQOU16cGRyWmp3b0pVemtG?=
 =?utf-8?B?Y3d6bG90SVErVWRCRlZiS3lOS3RQRmluVDhKNkdZdStqNzhDd3FyWWNwTXhE?=
 =?utf-8?B?VUxrTFAyYUtCR2ZOaXA2Um51ZGZhTlkrSENGYU9IYTdhc0oxbGkyYWtqMFl3?=
 =?utf-8?B?TUtZbGdsVitSbVlXUTEvOTdCTmcwZnVkV2JZcmIwUXNTRS9sVTBsTW01QnU2?=
 =?utf-8?B?Umc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f8e5e14d-b108-4a9b-b507-08dc3b5c0991
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2024 08:29:26.3044
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: toQsQQMrrGL+ur+mglNca+AkSHzmxuIzHdg33wKOBf8HMe5bGr5DQgJIkaDqTbwElFOF6ce+f25XJ2rmz+NXJOMx+3r6JDOVDtqShDx5G1k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5574

SGkgVXdlLA0KDQpUaGFua3MgZm9yIHRoZSBwYXRjaC4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPiBGcm9tOiBVd2UgS2xlaW5lLUvDtm5pZyA8dS5rbGVpbmUta29lbmlnQHBlbmd1
dHJvbml4LmRlPg0KPiBTZW50OiBTYXR1cmRheSwgTWFyY2ggMiwgMjAyNCA4OjU0IFBNDQo+IFN1
YmplY3Q6IFtQQVRDSF0gbXVsX3U2NF91NjRfZGl2X3U2NDogSW5jcmVhc2UgcHJlY2lzaW9uIGJ5
IGNvbmRpdGlvbmFsbHkgc3dhcHBpbmcgYSBhbmQgYg0KPiANCj4gQXMgaW5kaWNhdGVkIGluIHRo
ZSBhZGRlZCBjb21tZW50LCB0aGUgYWxnb3JpdGhtIHdvcmtzIGJldHRlciBpZiBiIGlzIGJpZy4g
QXMgbXVsdGlwbGljYXRpb24gaXMNCj4gY29tbXV0YXRpdmUsIGEgYW5kIGIgY2FuIGJlIHN3YXBw
ZWQuIERvIHRoaXMgSWYgYSBpcyBiaWdnZXIgdGhhbiBiLg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
VXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4NCg0KVGVz
dGVkLWJ5OiBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQoNCkNoZWVycywN
CkJpanUNCg0KPiAtLS0NCj4gIGxpYi9tYXRoL2RpdjY0LmMgfCAxNyArKysrKysrKysrKysrKysr
Kw0KPiAgMSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQg
YS9saWIvbWF0aC9kaXY2NC5jIGIvbGliL21hdGgvZGl2NjQuYyBpbmRleCA1NWE4MTc4MmUyNzEu
LmJhZjZmODY4MTkwNyAxMDA2NDQNCj4gLS0tIGEvbGliL21hdGgvZGl2NjQuYw0KPiArKysgYi9s
aWIvbWF0aC9kaXY2NC5jDQo+IEBAIC0xOTAsNiArMTkwLDIzIEBAIHU2NCBtdWxfdTY0X3U2NF9k
aXZfdTY0KHU2NCBhLCB1NjQgYiwgdTY0IGMpDQo+IA0KPiAgCS8qIGNhbiBhICogYiBvdmVyZmxv
dyA/ICovDQo+ICAJaWYgKGlsb2cyKGEpICsgaWxvZzIoYikgPiA2Mikgew0KPiArCQkvKg0KPiAr
CQkgKiBOb3RlIHRoYXQgdGhlIGFsZ29yaXRobSBhZnRlciB0aGUgaWYgYmxvY2sgYmVsb3cgbWln
aHQgbG9vc2UNCj4gKwkJICogc29tZSBwcmVjaXNpb24gYW5kIHRoZSByZXN1bHQgaXMgbW9yZSBl
eGFjdCBmb3IgYiA+IGEuIFNvDQo+ICsJCSAqIGV4Y2hhbmdlIGEgYW5kIGIgaWYgYSBpcyBiaWdn
ZXIgdGhhbiBiLg0KPiArCQkgKg0KPiArCQkgKiBGb3IgZXhhbXBsZSB3aXRoIGEgPSA0Mzk4MDQ2
NTEwMDgwMCwgYiA9IDEwMDAwMDAwMCwgYyA9IDEwMDAwMDAwMDANCj4gKwkJICogdGhlIGJlbG93
IGNhbGN1bGF0aW9uIGRvZXNuJ3QgbW9kaWZ5IGIgYXQgYWxsIGJlY2F1c2UgZGl2ID09IDANCj4g
KwkJICogYW5kIHRoZW4gc2hpZnQgYmVjb21lcyA0NSArIDI2IC0gNjIgPSA5IGFuZCBzbyB0aGUg
cmVzdWx0DQo+ICsJCSAqIGJlY29tZXMgNDM5ODAzNTI1MTA4MC4gSG93ZXZlciB3aXRoIGEgYW5k
IGIgc3dhcHBlZCB0aGUgZXhhY3QNCj4gKwkJICogcmVzdWx0IGlzIGNhbGN1bGF0ZWQgKGkuZS4g
NDM5ODA0NjUxMDA4MCkuDQo+ICsJCSAqLw0KPiArCQlpZiAoYSA+IGIpIHsNCj4gKwkJCXU2NCB0
bXAgPSBhOw0KPiArCQkJYSA9IGI7DQo+ICsJCQliID0gdG1wOw0KPiArCQl9DQo+ICsNCj4gIAkJ
LyoNCj4gIAkJICogKGIgKiBhKSAvIGMgaXMgZXF1YWwgdG8NCj4gIAkJICoNCj4gDQo+IGJhc2Ut
Y29tbWl0OiAxODcwY2RjMGU4ZGVlMzJlM2MyMjE3MDRhMjk3Nzg5OGJhNGMxMGU4DQo+IC0tDQo+
IDIuNDMuMA0KDQo=

