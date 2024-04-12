Return-Path: <linux-kernel+bounces-142666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A50FE8A2E91
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02205B22048
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134DD59170;
	Fri, 12 Apr 2024 12:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AtgGZwpD"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2042.outbound.protection.outlook.com [40.107.20.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C524597C;
	Fri, 12 Apr 2024 12:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712926195; cv=fail; b=eZKGPnyrnxUEYtz/5HKqDhyeEVIDt6VhoLx/loBoI0pePTQUipdEHFxKYDhFsP81TPR5O/Dhjb0LloY98/KBKnU4AGTtWsz5hllXVv26UgAeUdDiXiMhRecNfT6WKitaFbHkwRge35UFcO2R1vRharmNdWLhTa+8TtRKjCkBj/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712926195; c=relaxed/simple;
	bh=xLf1u9VYt+StoUtXyVTncmONyzqsvwJWazF6l9dZIbA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r5vitzwmuRJpcQpH9iRrBKHbSw8FN79kkidINF3RXZV0ObZL8DPjsUzUREAZoFl8c/hqtRo/eUgN2LviYhDEMlZZyT13t4uSGTtMAszoW6aGxxKo7whVN/j2ee4g8gJchjwskrUtVeW9ZWhSDvSo7TgBgL8VZ4SHzgHfokZPEyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=AtgGZwpD; arc=fail smtp.client-ip=40.107.20.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aTfok8Ny6AJkmcnYiUVS+Tyu7W7Cb9QrgkxN26q0AXIyVbO1weXKAHDmY7oE5TqrE5VjQbK/nfE9j/1YzMObo98caxziPuZcIUwWAXxhI6QUNfmXXn1xxbsDCpcZnfTgmFx2qugN2yxewc8I9kZ6RicXDIVf2T25WMLGBwTab7OdTGch0W29xuAxPlHGyX5BZqIZRyJ0YEFSFS+ecOSaWGsKoOt9D0mE5DZC2vsqUe7O0sTc7uRC7bjpx3lYgELiP9nxE1pTAwk5e07VGWY2BzpQx+yxr6FUTxuIM/c9EyTkI/k7VbsPOcBMO+RB6OR0GayhBobZB/No74Ull5t8Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xLf1u9VYt+StoUtXyVTncmONyzqsvwJWazF6l9dZIbA=;
 b=efQBAT/GcdxQ1mf4SO9wUqv0cjyV/4MD+Tv4P+Uktb1D3vcSqfugFTkVRvPh+g31AaVM/zS9zuXORzXs0viCgtC+nZalimfHvdeBAZDsxxRJ9Yc0kLX98OoYvVVrX26x9+k8Q724Aqc4/lBVbdc/OOb6IlUZjjHgGuBU4VpkxGJIcx9gsQg2EJzXbjZPrGVoYacEBi3j0KE6VAHjRR4I/zroyUvc2xqXos4UgcedstAcwmRwNGdGZd+aIDk0IXW0lH6gfMmUy2W5ztvfWF3mKpIBBTRPES7Y/3zhcjdbvEebBVBv8myK38Gx92s9NkrnV/Kn8wXvL5LZ9IaF5gQ+dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xLf1u9VYt+StoUtXyVTncmONyzqsvwJWazF6l9dZIbA=;
 b=AtgGZwpD6NV42FISRHljdPDz8LlDKEjffX2posHjizKT/V5MxOi8M7XwbkwM1bVnmbXvfQO2gep9+Adb/q9lgBuXfWxeA+HzxYO4YSH7pCLOawRxa+E76yWL+AUe6/hvniU2B4IF+lU8vAxv6ZwyA0i7Os1iM4NdsDSg3ryWKEc=
Received: from PA4PR04MB9709.eurprd04.prod.outlook.com (2603:10a6:102:26b::10)
 by AM9PR04MB7619.eurprd04.prod.outlook.com (2603:10a6:20b:284::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 12:49:51 +0000
Received: from PA4PR04MB9709.eurprd04.prod.outlook.com
 ([fe80::ead1:809:aa83:c1e2]) by PA4PR04MB9709.eurprd04.prod.outlook.com
 ([fe80::ead1:809:aa83:c1e2%7]) with mapi id 15.20.7409.053; Fri, 12 Apr 2024
 12:49:51 +0000
From: Horia Geanta <horia.geanta@nxp.com>
To: Pankaj Gupta <pankaj.gupta@nxp.com>, Gaurav Jain <gaurav.jain@nxp.com>,
	Varun Sethi <V.Sethi@nxp.com>, "herbert@gondor.apana.org.au"
	<herbert@gondor.apana.org.au>, "davem@davemloft.net" <davem@davemloft.net>,
	Iuliana Prodan <iuliana.prodan@nxp.com>, "linux-crypto@vger.kernel.org"
	<linux-crypto@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Francesco
 Dolcini <francesco@dolcini.it>
Subject: Re: [PATCH v2] caam: init-clk based on caam-page0-access
Thread-Topic: [PATCH v2] caam: init-clk based on caam-page0-access
Thread-Index: AQHaix0ndXuyoCY2X0+PHggtPgD/MbFkmZUA
Date: Fri, 12 Apr 2024 12:49:50 +0000
Message-ID: <ab774af1-1599-46ff-843e-6333a55a97a3@nxp.com>
References: <20240410075815.4030570-1-pankaj.gupta@nxp.com>
In-Reply-To: <20240410075815.4030570-1-pankaj.gupta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9709:EE_|AM9PR04MB7619:EE_
x-ms-office365-filtering-correlation-id: f18ee135-f298-4a82-0848-08dc5aef0b24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 zacCUiT6H9F8u3daHAztj6XBehx9z0fUvVzWv1pbjRr1W76mGcNzD2cnyqVgXSEJzDdGVt7ZwyyOyY/NFxt9wCMYFid/NYfnX4Y75D2qZ/oRGf7LQ6Dwyvs0b50WAhT8XK4GLWDVsvu8hNymFHRXowwtW4m18YmnAY6GyIMQegSuGN3X0jUsdfvGn1HvQHP2GTWgxZ7lQAZq4/rriJ5o+cITCZ0iJ+a4ti6OaDpHGc6uhpD0VF7RUvPc1gpzyVBr+QJvyrm+spJtGHJy9FdGDCLUpC5sjaxe63Nmtpkxpp00XkR6Scce2SMe3LBPofQm6nfBIKofpKlUmlbzFLxWvpmyIQehkq7zc0yy0WNIZUj6uecRKQEUrU8BmoJ8sE8cmv0xtopGExnuA+Yq24UttZb9xN5/I+8vs1JG9CSjk4BsP84or1t6s1jULTcDyZh7mOdjBplmk96rFmdtUQaeigXA+7vdff0WvQSeD62YpYJRi91OCsoPJUD1aZzZx7RVuEJkFAI5P4Bir+nP3f9SG5adzkvdq53F/5v+o3prcf7eDic7muVH+n4suEm54u44XzBgiNDuaMnahllQyWpjKhyMFXD5Lhi2+4SKInwURbjCPEBACbhlhl8o11njQaDSbJTw8/VVvt9qhZ6aN9uL+UbdXRNXXtPpWU9drEAcbhMj0lYZneEaZxLeS/1CyaDxnlCtq7ztFeheWKSyRPkjArhSUg2ocUBhHnEmKdINh9k=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9709.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RnltMzdjdkZ3ckpXVVBsR05lUEgyYkhuM1FNOGljYVp5aUNxbUV2azc0ZUdX?=
 =?utf-8?B?Wkx4c3JuUjNxTEJwczNmcEhjaUZuMUg2Umo0V3R6ZjBDVDdNU3MxTnF1NVc5?=
 =?utf-8?B?Ym45Z2l3TktpUityd3pvMGJQNTNFZ2VWanNoN1k5Z2J4bHlEdXdCQ0ROblBp?=
 =?utf-8?B?bXJSWXc1QUhYRTh6MXJaQ2NhcnZKNjV1WWl3TFoxQzczWnBtZlJFY280Y2pL?=
 =?utf-8?B?TkJUNnprVlF0OEthcWwrcGtMVGEyblI3TzdhMEEvbUVuNy93eGJ2NWJNMTdG?=
 =?utf-8?B?NHBJMnFQYUZtTzMxUndQUVd3RTBJaGdqeVF4ZlZOZW9WVlZ1SUFoc3N1N0VO?=
 =?utf-8?B?b2N0R2ZqTWZidGxxMmlLQ0RFSFltQndRTVdSb09WZ1VnODdzMXI3aElRZUZ5?=
 =?utf-8?B?VXVvZ24ydHBsZFBoYmpKWXA2ams1bW9mSUhXZ0IvU1prRTh6UkdoTnAxQ0Iv?=
 =?utf-8?B?dzdPdXBmZkVRR2NPbFFWbkdBWTNVRFRqeUN5Mkw5ZC9PMXIyOHFQbG1YZ25U?=
 =?utf-8?B?alVSenpObDJQbDZQNGpZTUJuTXFCakhYbmFiQktJTXBIWWQxd2dGVTJneEl3?=
 =?utf-8?B?dWNhd3kyczNMdkoxem1FQmlLRTJEVjVwN3R0R1lVUk5LZnNFdGdDWDRveGxF?=
 =?utf-8?B?TmFRSjNQbm14MS9FbHZtWVdUSG93WVYzWDVTVjhoVS9nSGVON1JRTDZncEVP?=
 =?utf-8?B?Z1JOYXdSc0E4WGJmOUVNVEJKR20vZktGV0loenV0c1RDTHZ1eWFBYXA4QUtW?=
 =?utf-8?B?cHBnZ1czeGVFY1QrTmYvSk9oV1FkTXhLQkZnZ0JuVXBHZ2NLNnJlQ2lZclVy?=
 =?utf-8?B?b2JCbWpRVlU0cjJtNFZIb2R5SkFycDhtY0R3NGV1YXozcXJ0MXhmdll0K0RC?=
 =?utf-8?B?Vk00RjFYeFQraGREKzh1NUhvb2JzdUNFMzVWMWNtSUhCZWRRRi9XQ2tudU5O?=
 =?utf-8?B?SWdLV3RETStORmpuRTZsdkV5SUVwc1ZJcDRhWms1c2xzSHJQYlVlUGhnR2V4?=
 =?utf-8?B?V3c3clRxZFhiQlFha1VrTCtUdW9ZTHZIVmswMlBiRi83NlRINmlFQ2cwOFg2?=
 =?utf-8?B?elpsVlpYRHJDdVdRUzZNMnVRQ0M2OGxFNlJpK3ZoSTJ1aGhrenNjYVhNYytN?=
 =?utf-8?B?ZFUvOHFTY0k1ZmtNMlZQMHdCMW1menRJQTFQUGdwbW9sdlllQ2lIcHdFT3pu?=
 =?utf-8?B?amo4SVUvWCtUcW81cGpQR0RUbkMxaFI1cHluUFluL095R2RYaWl5L3REY2Iv?=
 =?utf-8?B?MHVra05WVUF5eC9GNWV3Y1owZ2g2MmRvNW9mbC9RQVhtNlF0WlB2QW0rcklI?=
 =?utf-8?B?SlIvWmZReGFmcWlNNXJ2UFFuY0lQcmtBUWZVTXJEQXVCdmN1aWZlRTFMajdO?=
 =?utf-8?B?eURQcmdjc05iK2RWVHFmamNVeXp2eExiNWJONGdvVm4xSnhaeG1sUGhoUzlZ?=
 =?utf-8?B?S1FOaTc0S2llM2IvWlkzVUZ0d0pVVTlxbjdPSkhaS29Nbk9nbEpyTllKZmpS?=
 =?utf-8?B?aWE4TndtSms4dlpHZnR3cjhFZ0VIYmdITE11WnNvKzZqNmpKODFNQStIQlo3?=
 =?utf-8?B?ditGbEloNXF3dVVzeHlXWTNqSGJtNUhNU29EV0NiSC9kSlFVVk1STXlMb2RO?=
 =?utf-8?B?Qm1HcTZhbjBMZDZmeGM0djdHSU5lNElzNTl1NG5Bei9Oby9uVWkyQ0lsQkgz?=
 =?utf-8?B?OHp0dkxZMERGWHdUTkNHNzM5QTFISFZjUGhzR0k0bnhNdVFpTnZnbGhUS2ty?=
 =?utf-8?B?VFBsVk10aTNZUUR6dTVqK1BETjBzVGhzcFBJa3A0WVQ2RHVjMk5JaEM0NE54?=
 =?utf-8?B?SG1xT0pGZ2hqSVBGOE9OZnZBM2txK0oxc1Z3M09LcGUybTBUV1hyRytib2R0?=
 =?utf-8?B?WEM2RVEvNGdpWFNpRUo5WHZBak1Ha25QejAzSXNxQXFqWDcxYnNhOWVFWGpi?=
 =?utf-8?B?a2c4QmVRTS9YSmt5My9RdUM4dFFNZE5lV0dVbTVhMGhPUFlXK1VseXNqUXBK?=
 =?utf-8?B?WEd1M1B1L3ZVTEhQeXMramFiRnF2S2ZBbGVVY2F3ME1FU3RNU0FCdFA5anpq?=
 =?utf-8?B?N01JUk55R0VhbTVINGtLbzJqL0F3UDY2UVMwYm1WbDQySWZVMldUME1xSFZI?=
 =?utf-8?B?VlZETktMbWNyT0tna1liQmJSSVNFMStWY1VJRDhQWGU4UVRLb1ZpZUlHcWNW?=
 =?utf-8?B?YXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA31934C89FE7A40A8D05658E9C221A8@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9709.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f18ee135-f298-4a82-0848-08dc5aef0b24
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2024 12:49:50.9944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TxXt+WXD5OJcNflRAxIgyxiQ7YR5R4xwFlzzjkvCA2YPd1a/xvYnH5xTVegO0uI0Z4LUJjZD7kEQRsngj9snXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7619

T24gNC8xMC8yMDI0IDExOjAwIEFNLCBQYW5rYWogR3VwdGEgd3JvdGU6DQo+IENBQU0gY2xvY2sg
aW5pdGlhbGl6YXRpb24gdG8gYmUgZG9uZSBiYXNlZCBvbiwgc29jIHNwZWNpZmljDQo+IGluZm8g
c3RvcmVkIGluIHN0cnVjdCBjYWFtX2lteF9kYXRhOg0KPiAtIGNhYW0tcGFnZTAtYWNjZXNzIGZs
YWcNCj4gLSBudW1fY2xrcw0KPiANClsuLi5dDQo+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGNhYW1f
aW14X2RhdGEgY2FhbV9pbXg4dWxwX2RhdGEgPSB7DQo+ICsJLnBhZ2UwX2FjY2VzcyA9IGZhbHNl
LA0KPiArCS5jbGtzID0gTlVMTCwNCj4gKwkubnVtX2Nsa3MgPSAwLA0KPiArfTsNCk5vdCBuZWVk
ZWQsIGFuIGVtcHR5IHN0YXRpYyBzdHJ1Y3Qgd291bGQgZG8uDQoNCj4gIHN0YXRpYyBjb25zdCBz
dHJ1Y3Qgc29jX2RldmljZV9hdHRyaWJ1dGUgY2FhbV9pbXhfc29jX3RhYmxlW10gPSB7DQo+ICAJ
eyAuc29jX2lkID0gImkuTVg2VUwiLCAuZGF0YSA9ICZjYWFtX2lteDZ1bF9kYXRhIH0sDQo+ICAJ
eyAuc29jX2lkID0gImkuTVg2KiIsICAuZGF0YSA9ICZjYWFtX2lteDZfZGF0YSB9LA0KPiAgCXsg
LnNvY19pZCA9ICJpLk1YNyoiLCAgLmRhdGEgPSAmY2FhbV9pbXg3X2RhdGEgfSwNCj4gIAl7IC5z
b2NfaWQgPSAiaS5NWDhNKiIsIC5kYXRhID0gJmNhYW1faW14N19kYXRhIH0sDQo+ICsJeyAuc29j
X2lkID0gImkuTVg4VUxQIiwgLmRhdGEgPSAmY2FhbV9pbXg4dWxwX2RhdGEgfSwNCj4gIAl7IC5z
b2NfaWQgPSAiVkYqIiwgICAgIC5kYXRhID0gJmNhYW1fdmY2MTBfZGF0YSB9LA0KPiAgCXsgLmZh
bWlseSA9ICJGcmVlc2NhbGUgaS5NWCIgfSwNCj4gIAl7IC8qIHNlbnRpbmVsICovIH0NCkFzIEZy
YW5jZXNjbyBwb2ludGVkIG91dCBpbiB2MSwgdGhpcyBjaGFuZ2UgaXMgbm90IHJlbGF0ZWQuDQoN
CklkZWFsbHksIGFkZGluZyBzdXBwb3J0IGZvciBpLk1YOFVMUCBTb0Mgc2hvdWxkIGJlIGRvbmUg
aW4gYSBzZXBhcmF0ZSBwYXRjaCwNCmV4cGxhaW5pbmcgYSBiaXQgdGhlIHBhcnRpY3VsYXJpdGll
cyAtIHNpbWlsYXIgdG8gdGhlIGNvbW1pdCBtZXNzYWdlIGhlcmU6DQpodHRwczovL2dpdGh1Yi5j
b20vbnhwLWlteC9saW51eC1pbXgvY29tbWl0L2Q0MjBmMjI0ZWUwMmMxNjRmNmJkYjNjOGJiYjVl
YzU4MjdlYWJhMzcNCg0KPiBAQCAtODg5LDcgKzkwMiwxNSBAQCBzdGF0aWMgaW50IGNhYW1fcHJv
YmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIA0KPiAgCQlyZWdfYWNjZXNzID0g
IWN0cmxwcml2LT5vcHRlZV9lbjsNCj4gIA0KPiAtCQlpZiAoIWlteF9zb2NfbWF0Y2gtPmRhdGEp
IHsNCj4gKwkJaWYgKGlteF9zb2NfbWF0Y2gtPmRhdGEpIHsNCj4gKwkJCWlteF9zb2NfZGF0YSA9
IGlteF9zb2NfbWF0Y2gtPmRhdGE7DQo+ICsJCQlyZWdfYWNjZXNzID0gcmVnX2FjY2VzcyAmJiBp
bXhfc29jX2RhdGEtPnBhZ2UwX2FjY2VzczsNCj4gKwkJCS8qDQo+ICsJCQkgKiBDQUFNIGNsb2Nr
cyBjYW5ub3QgYmUgY29udHJvbGxlZCBmcm9tIGtlcm5lbC4NCj4gKwkJCSAqLw0KPiArCQkJaWYg
KCFpbXhfc29jX2RhdGEtPm51bV9jbGtzKQ0KPiArCQkJCWdvdG8gaW9tYXBfY3RybDsNCj4gKwkJ
fSBlbHNlIHsNCj4gIAkJCWRldl9lcnIoZGV2LCAiTm8gY2xvY2sgZGF0YSBwcm92aWRlZCBmb3Ig
aS5NWCBTb0MiKTsNCj4gIAkJCXJldHVybiAtRUlOVkFMOw0KPiAgCQl9DQppZi9lbHNlIGNvdWxk
IGJlIGF2b2lkZWQsIG1ha2luZyBjb2RlIHNpbXBsZXI6DQoNCglpZiAoIWlteF9zb2NfbWF0Y2gt
PmRhdGEpIHsNCgkJZGV2X2VycihkZXYsICJObyBjbG9jayBkYXRhIHByb3ZpZGVkIGZvciBpLk1Y
IFNvQyIpOw0KCQlyZXR1cm4gLUVJTlZBTDsNCgl9DQoNCglpbXhfc29jX2RhdGEgPSBpbXhfc29j
X21hdGNoLT5kYXRhOw0KCXJlZ19hY2Nlc3MgPSByZWdfYWNjZXNzICYmIGlteF9zb2NfZGF0YS0+
cGFnZTBfYWNjZXNzOw0KCS8qIENBQU0gY2xvY2tzIGNhbm5vdCBiZSBjb250cm9sbGVkIGZyb20g
a2VybmVsLiAqLw0KCWlmICghaW14X3NvY19kYXRhLT5udW1fY2xrcykNCgkJZ290byBpb21hcF9j
dHJsOw0KDQpSZWdhcmRzLA0KSG9yaWENCg0K

