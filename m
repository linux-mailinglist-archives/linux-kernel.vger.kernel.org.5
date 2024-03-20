Return-Path: <linux-kernel+bounces-109167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0540B8815A3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEEB4282894
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8DF54FBE;
	Wed, 20 Mar 2024 16:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="KKhO4ZTI"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2100.outbound.protection.outlook.com [40.107.22.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA8654BFD;
	Wed, 20 Mar 2024 16:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710952113; cv=fail; b=nU3xn3Wcteu7s5KlBfVJ2rx0DEFxctZtqGTa5fsPVnlYf5z14laZqy++cfVEdLGcGKokTIj3SYYDFmx299V/NW59UowOze8mqkgKiWt9kAZtAbSoc4ga/t4DR5YnnzxwHFhkKXHpsEaiIIVnFLUDb3c24lI4xwHpJB5P2qmTuG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710952113; c=relaxed/simple;
	bh=lpqCSWJ0b4zO6WDGvGDCNYOVxgp6MFHK7tHW3IG+06I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fDpnD5QzAOMC7Ec/jzQQiZuAR3ihfz6mtBTXV52uZyDWrVEP1aWSs9jEx4t5Kw8VF9k/JN58OxZRHgSfj6Jdja8VP+bw6UmZKcrdmLWBrxreU35pkppvZeki9Q+qO7Dg0/1Y60x96yTWgVXRM9NRcGugoQAZy+SEG2GRXvgBuFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=KKhO4ZTI; arc=fail smtp.client-ip=40.107.22.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WnxSAd9JRotufN9c9OVeLSvSTArpsMsIlZ/4vMCPbavFdj45O3CEeujg16o7qq7bKRA/tLRx1hhoeK/ZrNenW9I1jZ+Em41TVsCTEEtiITd502ShRSY1vVhbUaW9odSsptIHO9NKx0AnvGZzpWQGvIzRVme+Kp5NrMyGSlf7WUiYoNZOxAR7z5QK0PY7anPQX1hwPESQlhDP1GfIXlZxklK0BwMP25l0YOTPp9zWwb6iTTwBSp9QB3FmgVuvMfTzs0GlSkiKaqPjrQNbbfpFBVnO0/ib1YDsILZCTcmZKYabTJkwV+a3i9Zbpf50Z3D1zrORXEdlLdrp+mkrIA3MQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lpqCSWJ0b4zO6WDGvGDCNYOVxgp6MFHK7tHW3IG+06I=;
 b=RW4txmdLV9xYzBn6TlmLCbTWctJH6kpK4yC1zzdxMqZvzai24D4D/Op6PeLB8mv/HkBLyeAV0fas2uyhwcAzavcZd70a9f1AkoCpRdMqVS1o70NokI0UcLiwqmsp4psYYIUYVDebrjwBpAgXDs1nf09G0t40C5p2ay6tq6xLr2gjfFmGjxmmD6y+P8pnte157U5jaESn2e7AdDUlhyd5XFU8Zi6vcmPsnk6spG1p+1djsJYG6Cjkyw1ZfvnhvR/Ui1FA3uVwo1JCt/8LDoHBWPiYsjnG8SQQkgPBfLUb6p9U3a38nDzeyHD46mOoLJXMxdmxkkyHATy1sHoZ4dFu9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lpqCSWJ0b4zO6WDGvGDCNYOVxgp6MFHK7tHW3IG+06I=;
 b=KKhO4ZTIiuteE8gGb23KXCmIAz8vQsEDDRSmiU4pE0JB3Q7k3FEl31A8MXDaB2odkKb6gVp1lGfW1ldLe3KmCAN/XJzrn6FVL/lCdacAY9JLgCMZrBK+t/COKaXvVJ4llJyYSFgzsBpB8yB9VayfnzbqleXCWRwSj6bcELrI6qo=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by PAWPR04MB9720.eurprd04.prod.outlook.com (2603:10a6:102:38d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Wed, 20 Mar
 2024 16:28:28 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::57e1:e1cb:74e2:2e9d]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::57e1:e1cb:74e2:2e9d%5]) with mapi id 15.20.7386.031; Wed, 20 Mar 2024
 16:28:28 +0000
From: Josua Mayer <josua@solid-run.com>
To: Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>
CC: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: dsa: mv88e6xxx: add warning for truncated mdio bus
 id
Thread-Topic: [PATCH] net: dsa: mv88e6xxx: add warning for truncated mdio bus
 id
Thread-Index: AQHaes1eqLrk3YtcdE6GnHKqfgAD+rFAqraAgAAHmgCAAApwgIAAFOwA
Date: Wed, 20 Mar 2024 16:28:28 +0000
Message-ID: <2af8544a-5b7b-44be-855a-5a4932db49e7@solid-run.com>
References:
 <20240320-mv88e6xxx-truncate-busid-v1-1-cface50b2efb@solid-run.com>
 <Zfrt_dlYvBzlxull@nanopsycho>
 <c76c95af-71cb-4eb6-b3af-846ae318d18d@solid-run.com>
 <a5b2d1df-cf6e-42b6-8ccf-122be672db24@gmail.com>
In-Reply-To: <a5b2d1df-cf6e-42b6-8ccf-122be672db24@gmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|PAWPR04MB9720:EE_
x-ms-office365-filtering-correlation-id: 53a9cf8e-9edb-4a3e-77d2-08dc48fac628
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 kBGDmwaOtfQzJ0etx9FdmDtLxhvv3nDGwZ2enrh/m0gLqeijtU47n83CxGiWm2VSp8X0AGEtHKz4GH5893dNsHCy72+GO+Q9GvO6u18nciGADjoP0d+HCir7a3grHKg2JKW9B7vleenOjvOFiCaIuoCyX1hyw4nnzEHUapO/UCGYifh7LYLOcj6uirLoJeWvle36jGqhedCyuzV/4UFFOjavGP3UU0HqxTR5Vj+yFMiI1RtuwJuHzp/qWGyTAF95oLCOwPU/dbZT8wbG7OW/T9lnGC640hUnlpSQe0revG5ZCO8+HQ0xq7ddxyRj056N56kWSZvoNgB1aGyIMqV1rB7odWbWviP8fUXUMZlvN4HbsxYudbGzb1vHANJlJ00B/5EvC7oCjRmwELjfKJruORba77o1VgbnFHiZNI1yIWhi5Kl8zWj35cIUyp8C36auhEBKqoHf61lTHP4xkH3lGQRn+/WCaVagqs9gkjLD9U+LVFz2ASHxem5NH1mnlob/qrqwBliEOub5xTiQw1a1c082miOI7NNBFEkQ3GzIDaUpK2yjFrWJq42UEdlu1lKlkblZoe0UkxDo8NKiQA+hMze22JYvRBJyJBkzzPeTVj9bDpotj+N2Ne+ygKhEARQ49vB+lgcx38T3KWCaQIiaJ5F3CNCEj+2UoWeyVQlkxgg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(7416005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UG5DZ1JaaWZxR09TQXdUbDVlME5GSmR1TURnd2pzWndHSWFSUWNwWkpvbkYx?=
 =?utf-8?B?dFV0WFNSclZRSEFWek8rQytaRU1kVElnRFozbSt2cXBtRzhrek92d3lhdG9Q?=
 =?utf-8?B?aXlNbzZwdThVWlMyL0cxTmZtUWsrYlZMdC91OWREMWJSc2dvWGNDbTVma2dv?=
 =?utf-8?B?U25wQjl5bjlPQXZlT1M3ZTNBQytWM2VsU2VtMTcrZTZRQnZXQkVPUGswR3Rj?=
 =?utf-8?B?Q2wzTDFGWTVybVhobUhSZDV4QytxbFJBMG4xVUo2Zk5rVTNVK2VwSGk4WitL?=
 =?utf-8?B?UDM5dmpUUnlXMWhrVjhJMTJHRVFNQmpRREFIYVJFK2tKL050cmI2Nnp4bzdL?=
 =?utf-8?B?b0VwR2d5K1VFcDQ5ejZQMzFjamZxVzdNTTlWcDQ3YUliY2w0K2xRTUxqYnZt?=
 =?utf-8?B?blpvc2tUQWFLRERxV0NBdG9nTHErNHBFNjJJL2lXNG9tcnUvcmlCQWd1YXhu?=
 =?utf-8?B?RHRwOU5ETE96NFZLQ2V5SCtPSGk2bEtNcHFTNnBFR1pjOWprelNJeHptMDRo?=
 =?utf-8?B?MFg5UmZkay9HbTVJNWFUbkE2T3NYZitJUG1hcHNtelQyK0RSaGpEbnlield6?=
 =?utf-8?B?MGVXVGJweWVGU1lIWERxMXlKdkZoZ0R3ejAxUHVSUnlYWktWQ0Z5b2ZIWEdq?=
 =?utf-8?B?RmtScktUK1NhYjQyVUhIbVB3VmJaNkNqN1E4RGNhMWlYeEtXY2wwNS92Kys5?=
 =?utf-8?B?NU0rNXpXWkVrME9nOHlVYmd5aHM1Z2xrTThqV2MwUkI4eUhGQi9Wc1VweXpU?=
 =?utf-8?B?R0RoNTU5Q3JRWVd6TVhldlFiZzYvNi81c1JFcnI5TFBLUWpRMzErSzBMRGZB?=
 =?utf-8?B?blZjamJaOFFiSkVRY0pDaTdnTE5pRWkyOXdSN2drcDFzdmxnVlBRL0RJQzFI?=
 =?utf-8?B?eXVkWk9kRFVLVzJKazMwQ0R1WlZHQlZKNUE4RTUwUkNMc1AyK01CajNqYU5p?=
 =?utf-8?B?VzdqeEV4Tmc2ZU13MDFibGdRTVEyenczb0ZjejZWbC9OUXBNb0tsWTFrWVRX?=
 =?utf-8?B?azNPaFh5OWFpdmRtNHMxZ2tpR0loazBUOXM3MDVmQ0J5SWxoNVc3Si9uTlh6?=
 =?utf-8?B?WTZGdENscnhlTllGbDZRK0xtTGd3QzZDRkJBRC8vQzhheWE5TTlsSDRHUG14?=
 =?utf-8?B?UWt4M2xvaVg5OXAvVHl0b3RpNXB3QThVa0xZVzBxL1Z4V3hVeGRGaW9wdEMv?=
 =?utf-8?B?bjNTUERJcVFjVkhuTStHUGJ6ZFo2QmJaU1ZSVWdxOUJ6ZVVTWThUUW9FR1RU?=
 =?utf-8?B?U0xaeitHYklEZXAxM25ySklEMW5nSnNVS01zZjVJYkNTT3BscFJQUEFzdGZt?=
 =?utf-8?B?YUtSVXlreXF3dDVlRU1lUzVlVnd1ZWJjcGtROThkWXNWZ01RRHNyaUdjdmlI?=
 =?utf-8?B?Y2xwYytTdDRMWi91MGhha1RIWHFMN0grUlBWS053NjZUQndDWmtkYXFyUTh1?=
 =?utf-8?B?NHBTd3lpQ0VTRnRXWUFXZWJHT2VZVkZVWUN4QjRxVlFKMDB0YmoyaFR1Nnlp?=
 =?utf-8?B?WEMwTVBoNHVnY04rTzBkc0J3YlYwOHhyUU9pYU54bmlxOG5zYXA5d3h3blJF?=
 =?utf-8?B?ZWk0RVZQQWtNUFgwc295UlRYWXhzTThpRWhXOUFURmxFdGYwV0ZKWjh2Q1Bo?=
 =?utf-8?B?TnB4dlhHeVVmUGtMa3YxK0c3M2M0dWFZam93Vkl3dU1nMjAzTlVyb1VETEZG?=
 =?utf-8?B?c3RqUUVNTFlMeWpDYkRNeHZmYkwwdWJhYmRybnpUZWZ3SW1SSW9rVkhzZmFn?=
 =?utf-8?B?ZktERDB2R3Y5TzdraUhKNGcvT081RU9zT1BwM3lSbHMzKzNJcGhJK0pVcU9X?=
 =?utf-8?B?RWRtdC9QNU1BY25Ja2Qwa3RySzRFdm9LaDdhUjFvRkcwdGlORjRqenpVbnJa?=
 =?utf-8?B?M2U0WXc4bDBCZzI1TkFuZmpIR2dFa1laUDdnTDlwcG9YY1lxcGJXZGdld0xh?=
 =?utf-8?B?K0NoOStoUGV0cGFTSitaS2FZRGU0eldENUMvZGpodmhwVmUwSWo1aHRsU0s4?=
 =?utf-8?B?bkc5Y1d6VU15MFd6YUJZME5GNnlPaGp5YjdIY01lcG1sZWlqY0REdUlSQnZS?=
 =?utf-8?B?ZzN4MHkyU01URGU5c0ZrR0V1dlYwbnZ0NFpuS1J5Wk9SZ0lwRldMNWpMZTZv?=
 =?utf-8?Q?cte8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A2A6D531558AC945BBC32A82803F8846@eurprd04.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 53a9cf8e-9edb-4a3e-77d2-08dc48fac628
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2024 16:28:28.2927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IgyN+scAPcfEWMKZMANDe3g0MpXMgQbw1epvVOk1pT5g30XCvIFBvL+pwbt300HRQB4QVZA43h3X3H33jl/PVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9720

QW0gMjAuMDMuMjQgdW0gMTY6MTMgc2NocmllYiBGbG9yaWFuIEZhaW5lbGxpOg0KPiBPbiAzLzIw
LzIwMjQgNzozMyBBTSwgSm9zdWEgTWF5ZXIgd3JvdGU6DQo+PiBKdXN0IGZvciBmdXR1cmUgcmVm
ZXJlbmNlIGZvciB0aG9zZSBvY2Nhc2lvbmFsIGNvbnRyaWJ1dG9ycyAtDQo+PiBpcyB0aGVyZSBz
dWNoIGEgdGhpbmcgYXMgYW4gbGttbCBjYWxlbmRhcj8NCj4NCj4gVGhlcmUgaXMgdGhpczogaHR0
cHM6Ly9wYXRjaHdvcmsuaG9wdG8ub3JnL25ldC1uZXh0Lmh0bWwNClRoYW5rIHlvdSA6KQ0KPiBX
ZSBzaG91bGQgY29uc2lkZXIgbW92aW5nIHRoZXNlIHR5cGVzIG9mIGNoZWNrcyBpbnRvIHRoZSBN
RElPIGJ1cyBjb3JlLCBvciBhdCBsZWFzdCBpbnRyb2R1Y2UgYSBoZWxwZXIgZnVuY3Rpb24gc3Vj
aCB0aGF0IGl0IGVtYmVkcyB0aGUgY2hlY2sgaW4gaXQuDQpJIHdpbGwgbG9vayBpbnRvIHRoaXMu
DQo=

