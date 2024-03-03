Return-Path: <linux-kernel+bounces-89703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D3486F45D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 11:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F12EC28224D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 10:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E5BB66B;
	Sun,  3 Mar 2024 10:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b="Jdas55gS"
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-pr2fra01on2111.outbound.protection.outlook.com [40.107.12.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D6A7F;
	Sun,  3 Mar 2024 10:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.12.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709461240; cv=fail; b=gBWw5ZUONCvVSUS+PS9ylgLCQChDN5KM6Rjt/NJ+tG/GcR+0HJ1G6HuWZJes1yh5vHKc2orAnwrPFbM72cVqupagpEGO4QrDEJiK8XLXGJJ69aRCEcuRw4BTUNOcvp0xuDRIGa+j0w1sNICW42UrkODSlJH9L2TVIVQp3cwVodM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709461240; c=relaxed/simple;
	bh=JbHiDZyEppFVAseZdCE4zw5jaxPR3yIv54/JMh5/lnE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WJ60svGqeFanU2jkkPxY0dCl73TGRDee2gnKb3CBaJ616PgDwPnPuJm9XVk02OaeTB1c9G/PmlOMwrtxMk0VR+V+IEPPFsLdKAlvEk/qFh12i08ZRrb1RS3YdsBGYqPIhqD1oh83yQ5g8/KgVIsUUqamfiA7+zXudMGB1r4S464=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b=Jdas55gS; arc=fail smtp.client-ip=40.107.12.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R0V+W0Pj8aqlR2gXB18H9xBpTN/YnUM6dZwntS/B+Im8/+UJdUUF3tffslJcynSR3kZZYavIRQoDHfOvS1+cR3u5HRXEHMD6pMHOUgME7Og2jHfH7xrHgqmBI4PlhJk1xhbFod+nZI3cqtDwEvsB0FxCSrxqNsjJxqCaUoog5jja+gLoRKFz7NEgssPGiC42c4Hmwt9Wuh1PSrv5fzVVtLL4NCR2HDaaW64oV4C7bpUY2ajxeoB4KcLn6aYUFCmpkKkqc7yHcIFgwRX9d7siIDqBPNyGTJVF/jpzfDFVZsqj67GrmaEALgAkoTXpoX7AEepMIfvyCvLmZJpd96L7Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JbHiDZyEppFVAseZdCE4zw5jaxPR3yIv54/JMh5/lnE=;
 b=ecN2gXEHG7KfP/nzAkxIhecIh2gXgEtFYuJxR+ce39P3AjbaPboIaWMZ3DfjW2mrwZuDkJ3FpqXvMY58wDrpgt+fptKAE5HtAQqL2+3IVttNyj7E8o5bPJwWx/pE2Fe0wUrXO1f7ouUZQUoAcpFZLRoRhhV29iyqX1V1s8X9/nAoUyQDN4tlupW+0tf6uVjyDZDIOrzirOUTC7jg70lHlIns5cilDyq+kDTX0X0zaD08q7gvDxaUYScrsm/rgSaAFLyafn78hWaT54P6qKO2fvDWBr9aRrkihnOKJnlqPBKryqXvLMD5Bh9/9M+rvXBNtnXD2Gje/UBWdUK5UCwN6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JbHiDZyEppFVAseZdCE4zw5jaxPR3yIv54/JMh5/lnE=;
 b=Jdas55gShyiPpJlIQkFLtf0ebiIs30ZDTUtaR6VeB4OquvZUdCwwpDq2dJ1b8tWtYhs9DDjKBuOX993gvaE2LfSIi63vfjEf988HszgRYzgRM6faSeECOrI4YXoPKpumEAWvQ00fjT+E3MwdEzciMt/Tmp4AgW2qhT5RpLGJ4vjiSBcLdb28hJ2so1gwk8l6edj0LIOhMrQbtcViqy40c+96609kghCR5orGJB6bJMoRKlg3HKEhp3zGvCp0pYkJSjJ7XKYehMRBEeFAfGVt6EOGNXkyQBWleoLy0Zc1eP/MA1HWMF6xO8tyMbL+TkR6+LE5HFHE1if9idgF3dK4iw==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB3305.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:25b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.37; Sun, 3 Mar
 2024 10:20:34 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c192:d40f:1c33:1f4e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c192:d40f:1c33:1f4e%6]) with mapi id 15.20.7339.035; Sun, 3 Mar 2024
 10:20:34 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Guenter Roeck <linux@roeck-us.net>, Russell King <linux@armlinux.org.uk>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Palmer
 Dabbelt <palmer@dabbelt.com>, David Laight <David.Laight@aculab.com>, Charlie
 Jenkins <charlie@rivosinc.com>, "James E.J. Bottomley"
	<James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, Palmer
 Dabbelt <palmer@rivosinc.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
	Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>,
	Parisc List <linux-parisc@vger.kernel.org>
Subject: Re: [PATCH v11] lib: checksum: Use aligned accesses for ip_fast_csum
 and csum_ipv6_magic tests
Thread-Topic: [PATCH v11] lib: checksum: Use aligned accesses for ip_fast_csum
 and csum_ipv6_magic tests
Thread-Index: AQHaa2FN/UPATTv23UaTwsptpp4BsbEjNucAgAKbLgA=
Date: Sun, 3 Mar 2024 10:20:33 +0000
Message-ID: <f422742a-4c86-4cb0-a4f7-a62f0310eb23@csgroup.eu>
References:
 <20240229-fix_sparse_errors_checksum_tests-v11-1-f608d9ec7574@rivosinc.com>
 <62b69aaf-7633-4bd8-aefe-5ba47147dba7@roeck-us.net>
In-Reply-To: <62b69aaf-7633-4bd8-aefe-5ba47147dba7@roeck-us.net>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR0P264MB3305:EE_
x-ms-office365-filtering-correlation-id: 941c6f16-f155-403c-39e3-08dc3b6b8f45
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 YliPsdOwWVOhDJ6VamaDrnnq9KS2PpT52Kx5YRyI53SXR5s7FAAFOP29C0Cif/IWeFp9UB7/u+XvFiWJQkU7sCLwWkhivfwXF0ruqSS0HhSoCuR2KqK95HYRIuF1C3mwb4j4hOyyq3BbAmSbgO6vx42z5WqMyZSicBWEuW3J1ZcQ2Y0heE/wMUQyyLE1fHjPiF+0mMtdWg4rtcECbR5KvznU80HSyVY5/ew5VRTtveo1xHkOowrWIQlnngEN+LacTSpca7QnszS2YBZhhdoPKV+oJRRQzgsGJ3SoLai8UfunB1vPylXjsErMzVe5reN0YtuctI4o2sKuoFOOn27B3GX2B2EDPzBp2E5BFW3Hql79J/yggLhq+cLgWajsj6gOIdLw5VVRHAcgTGZVgWVTt83cqaugRXnOazC0H+yXz+db5IVNFavNv/ER3Ncb41m/iTClMsIQbhiQEXUovtxvb1DiJspTLlNoDL9nBCXVn9QbKIsI9FIeJjixkQBwftqq5E64AZgugb/nYc+cPmVbTtCYnfa2sLYxrT/i87/uO61zFJSPErjdfxlgkhU+IW6X1oCSOH+tDLYMeNOvq0pkRmHkiHko3mji4YVm6ks2S9hKKF+VwCmWiwXgvWFpJ3kpnlaCpRAod+NpYBSWkRgrjBFbQa53eoeg/OBMRiUAjLMvXvNBT1hvG6lxQuFaS1Uu6SYxTe6b3hbOx3HOZBVer92kCSAR/UzM2SEAV3POe88=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y1JQc2t2bnlZVlVqS0tuSHFTaXQydkN1OUxLWVhIWXlKeWlIM2NWYjhlbTA4?=
 =?utf-8?B?UGpYSlhveXZVZUZSd0xEc04zcE9uY3dMQ2ZsZmd6dTRRcFhxUHdNRWJ6aVhw?=
 =?utf-8?B?L0Q2Q01jMGNWRnBpYU5kMjMwUFdvWXMxU3l6SWZDT3Q0RG5jM3RjUXRjVmln?=
 =?utf-8?B?LzJ1ZWc3YVNPUkxiVWhmMkFvbUc5S2NWZUxmZlprV0RmMGV4VVV5R3Jwc1Er?=
 =?utf-8?B?dGR3eG92dmYrYjFLN2wyV3RKRHZJYzlGb1haR1NROGFrQThnVEtqdUNLT28x?=
 =?utf-8?B?d2FjbFBtSzF6THA2ZzB2Qnl2UzJFcjFZOHN1OEtkd0ZTaTA1ODNWR3JERGJQ?=
 =?utf-8?B?RnNoV1E0Qm5wM3F0Rk1ZZnJsYUkwOHVHOTZWdEE3V1JxeXFjbEtRYTFqNGFo?=
 =?utf-8?B?U3dYV2hMV1U1MlFEOWJvUFB5UEhMRFpjelpXQjc5ZHJiUjNjdjJFYkhKWWRF?=
 =?utf-8?B?cG94Y1BQY2RmWWNqR2tBV204eis1a2preHFicnJ1bTVuaTJRRUVrc0NYM2hk?=
 =?utf-8?B?TW51Ui9sWHRTWG40V3FGMTlUcUNhdWRJUkRFRDNweWtIUVNNNG1ndHhqVFlq?=
 =?utf-8?B?NitURTF4WVpLU0hhNmdBSGNMcUxWUnJ3ZFp3cGlWa0tRSVh2c3JxTHRMYVFz?=
 =?utf-8?B?RGo1UnlZMTBTV3dJR0F3L1pQRUdOZEpiaEZHTWh3YmRiVks2em5oS05MTENM?=
 =?utf-8?B?cVQ2TUhTZlR1MHk4ajB0alZpYWQyVGV3YkpuUTRmd0VJNVlEdkhMNEdNdzJj?=
 =?utf-8?B?NFpqekp2L2MrMEhzMlpYVnJwMS9zc21mRG5uTXNodG51cmdaMUNSQ0RGeWZr?=
 =?utf-8?B?bndRYng2U2NLc25vYUIyd1BYRklhcUt3SDZoZm5jenlITjZkeHRwYlo2SG82?=
 =?utf-8?B?ZjlKKzA5NHhqaGZEVEZrTmk0a0M5Umc0MDVGVHk3NzQvckUxTUhGYUdsaFkw?=
 =?utf-8?B?SnRPZjMyTUxNMWhQQlFkWXY3d2lXampNV3NHL081d2dxSStwdkd0MzUyVUlI?=
 =?utf-8?B?UU9FZmtSZ3d6TStYbUdWYnNUMytxRU1UTnk2WHFDNUwxRnVlU3FxOG9ETjlD?=
 =?utf-8?B?dG1NbW4wa2FWTXBpQlc2c0dSVmdyelIzYXBrNXp0d3V0NWt1elBhQnNvV05l?=
 =?utf-8?B?VlBZSXlsbTNXWE5QRkxCYzVBVTQ4S2gzN01xZVBwL0FUdGJPdTUvLzZKVFBp?=
 =?utf-8?B?ZXhjdzJaUlBZMEN5bTljZmVheEJWOHB5anJNR0hHaHlDU2VrcWk5ZzQveGFN?=
 =?utf-8?B?UXVLcHBXSlYrRk02ZityOUJTVG8yNlk0a2RuVWt6bXk1Z2RRL3NoN0Q3WUZX?=
 =?utf-8?B?MDdRalZNYzdoMERuamgyWTg3RGN5enFmZkhocUUzQkt3OUJqYW5yYzN3SDFS?=
 =?utf-8?B?WHdDclNSSEtrWU5CaFRtK0tqbmxqQkRyK3JPcU85L1BwL2FXNG1kRWRQc0Mz?=
 =?utf-8?B?a0h3eUsyVVNBbDU2VlM1NFduVXV0VGdnSlRrdHU4T3Z0TDZXbVdOM3lhT2h2?=
 =?utf-8?B?MGJMZDBFSXFReHpGei9Yb2NEUSsrWkFWTVJFRGRlTmJZTXZHb1lQa2I1REI4?=
 =?utf-8?B?c2pOS0c3RkFpQnY0UjBkMUpoMGhiM2ZsTUxkeUNTRnJ4eVd4SGI3cGUrTzFa?=
 =?utf-8?B?S01kMG1IaDdnRHpCVVBPOFA0MzNidGVxRGp5anMvNVlxYWJ0dXdQdzJCeGlp?=
 =?utf-8?B?b09kTXRQWlBuYnlXaExZK2JXc3dlQmRqQWt5SjdhUS9QWTFrMXFpL2tYWlhy?=
 =?utf-8?B?WFR2UTl2U3ZITnRMVXRaWEhFRFJjR1hlSUwybVRteUZBRVBGdVJKdzJMdVdX?=
 =?utf-8?B?M1BxMXJMQWNKN2tMN0dka2swNmFTMzhhazBmb28yWWE1NkdvRjBlVXJMcHdv?=
 =?utf-8?B?SWpXS2tyZVJxMTBQOWFPdjBnOGFVRFYyVVNVcHc3MmNROXo3emtGeEFUWHU3?=
 =?utf-8?B?bURzcUZBYjlmUTdaRE40YW53Q1lhYnNvTFNDVVNnTlNDWVo4ZlZFcm0vNWp2?=
 =?utf-8?B?OFZVU2ZPRWNiejZ3SjRQQmloTHJYbTNwdERzcGdZR1ErOExkZUE3UU9ZR0Zh?=
 =?utf-8?B?aFJhbEl6M3VNTUV6alVxaWtwaHNDUDdKZU4wK0YyazVBdnVxVTlpWlFLUnkw?=
 =?utf-8?B?UlJFVDc1Um9MU254K3BaSTBmaTdYMGdxSndJeGtmbndIZ2Y3M2N1UzBkdlNm?=
 =?utf-8?Q?6kZCJNK6Yn+lAy6GFAhpQ0h3zZjmdsk96xNGz/dUZIV/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D12777B6C4498040AD8BDFAE926119B8@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 941c6f16-f155-403c-39e3-08dc3b6b8f45
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2024 10:20:33.0828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B28rQYwWFFBdNNJaVmuCgw+4kIzPrjPIgW4T2ETS2PChtvtIbfMTkWvjz17pD6WynLAe7tQZs/9SbRhI1fjgrf6pPpTcAuo16lsCbrOF4lo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB3305

DQoNCkxlIDAxLzAzLzIwMjQgw6AgMTk6MzIsIEd1ZW50ZXIgUm9lY2sgYSDDqWNyaXTCoDoNCj4g
VGhpcyBsZWF2ZXMgdGhlIG1wczItYW4zODU6bXBzMl9kZWZjb25maWcgY3Jhc2gsIHdoaWNoIGlz
IGF2b2lkZWQgYnkgDQo+IHRoaXMgcGF0Y2guDQo+IE15IHVuZGVyc3RhbmRpbmcsIHdoaWNoIG1h
eSBiZSB3cm9uZywgaXMgdGhhdCBhcm0gaW1hZ2VzIHdpdGggdGh1bWIgDQo+IGluc3RydWN0aW9u
cw0KPiBkbyBub3Qgc3VwcG9ydCB1bmFsaWduZWQgYWNjZXNzZXMgKG1heWJlIEkgc2hvdWxkIHNh
eSBkbyBub3Qgc3VwcG9ydCANCj4gdW5hbGlnbmVkDQo+IGFjY2Vzc2VzIHdpdGggdGhlIG1wczIt
YW4zODUgcWVtdSBlbXVsYXRpb247IEkgZGlkIG5vdCB0ZXN0IHdpdGggcmVhbCANCj4gaGFyZHdh
cmUsDQo+IGFmdGVyIGFsbCkuDQo+IA0KPiBHaXZlbiBhbGwgdGhhdCwgdGhlIGNvbnRpbnVlZCBk
aXNjdXNzaW9uIGFyb3VuZCB0aGUgc3ViamVjdCwgYW5kIHRoZSBsYWNrDQo+IG9mIGFncmVlbWVu
dCBpZiB1bmFsaWduZWQgYWNjZXNzZXMgc2hvdWxkIGJlIHRlc3RlZCBvciBub3QsIEkgZG9uJ3Qg
cmVhbGx5DQo+IHNlZSBhIHBhdGggZm9yd2FyZCBmb3IgdGhpcyBwYXRjaC4gVGhlIHJlbWFpbmlu
ZyBrbm93biBwcm9ibGVtIGlzIGFybSB3aXRoDQo+IHRodW1iIGluc3RydWN0aW9ucy4gSSBkb24n
dCB0aGluayB0aGF0IGlzIGdvaW5nIHRvIGJlIGZpeGVkLiBJIHN1c3BlY3QgdGhhdA0KPiBubyBv
bmUgYnV0IG1lIGV2ZW4gdHJpZXMgdG8gcnVuIHRoYXQgY29kZSAob3IgYW55IGFybTpub21tdSBp
bWFnZXMsIGZvciANCj4gdGhhdA0KPiBtYXR0ZXIpLiBJJ2Qgc3VnZ2VzdCB0byBkcm9wIHRoaXMg
cGF0Y2gsIGFuZCBJJ2xsIHN0b3AgdGVzdGluZyBJUCBjaGVja3N1bQ0KPiBnZW5lcmF0aW9uIGZv
ciBtcHMyLWFuMzg1Om1wczJfZGVmY29uZmlnLg0KDQpJJ20gdHJ5aW5nIHRvIHJ1biBhbiBBUk0g
a2VybmVsIGJ1aWx0IHdpdGggR0NDIDEzLjIgYW5kIG1wczJfZGVmY29uZmlnIA0Kb24gdGhlIG1w
czItYW4zODUgcWVtdSBlbXVsYXRpb24sIGFuZCBJIGdldCB0aGUgZm9sbG93aW5nIGZhdGFsIGVy
cm9yLg0KDQokIHFlbXUtc3lzdGVtLWFybSAtTSBtcHMyLWFuMzg1IC1rZXJuZWwgdm1saW51eA0K
cWVtdTogZmF0YWw6IExvY2t1cDogY2FuJ3QgZXNjYWxhdGUgMyB0byBIYXJkRmF1bHQgKGN1cnJl
bnQgcHJpb3JpdHkgLTEpDQoNClIwMD0wMDAwMDAwMCBSMDE9MDAwMDAwMDAgUjAyPTAwMDAwMDAw
IFIwMz0wMDAwMDAwMA0KUjA0PTAwMDAwMDAwIFIwNT0wMDAwMDAwMCBSMDY9MDAwMDAwMDAgUjA3
PTAwMDAwMDAwDQpSMDg9MDAwMDAwMDAgUjA5PTAwMDAwMDAwIFIxMD0wMDAwMDAwMCBSMTE9MDAw
MDAwMDANClIxMj0wMDAwMDAwMCBSMTM9ZmZmZmZmZTAgUjE0PWZmZmZmZmY5IFIxNT0wMDAwMDAw
MA0KWFBTUj00MDAwMDAwMyAtWi0tIEEgaGFuZGxlcg0KRlBTQ1I6IDAwMDAwMDAwDQpBYmFuZG9u
IChjb3JlIGR1bXBlZCkNCg0KQ2FuIHlvdSB0ZWxsIGhvdyB0byBwcm9jZWVkID8NCg0KVGhhbmtz
DQpDaHJpc3RvcGhlDQo=

