Return-Path: <linux-kernel+bounces-108301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 451748808E8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 02:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC8881F2415B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 01:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F5B15C9;
	Wed, 20 Mar 2024 01:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EHeRaX1C"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2043.outbound.protection.outlook.com [40.107.7.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F20A47;
	Wed, 20 Mar 2024 01:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710897064; cv=fail; b=cBhvUYImrzSdtQv9N62NXm5hA0OKwG9aTW6c6nSCmjal64K0PTqd7bWj3Ps52aueEWIzX5N97zBP/3NPkAucNuD2Hjr0zSC0w/wlC1PVpeH005+0JKqv3ZlY47nlGVkTSXlGTx+bL3AqDMEgkdIcqaXDm8MNu0J9xCl2YDVy1OA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710897064; c=relaxed/simple;
	bh=JMdslGgVao8GoGKRBQQ4OTIk1mue3+JFyOFClWQroSY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qlbIqR8Kk+Wb5IU1+PMe5030E9uvWopARJQ2W5IbU1DoqH8T8cavBuKLtZvlKZfrFLuECAt20gC3jjRrPYbvybQ/wB2AAKfN41TMjhGbnHBvgVs2hiJ+OZSCYkysrwDDQIB6S3hMuDvFLK8AS+jpv1WIRVfGGzoAVOcbgtBGt+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=EHeRaX1C; arc=fail smtp.client-ip=40.107.7.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YixWF+hkxqRlqv5y7kfLwUW1gZUWtNAMHt+4183fQaCuVjz+uozuzO29cE2CFZFzRK4eXAgMgGpaA9GGPhJVCZGaLH+KuH2ujXMx3ptlS6hOAqjhjoJcoNz57PiDxIczPnGlMA/d4j34i2byoGBygVr14loI+TTbAkDEQbOTP4wLrd/IOaSPuD7ip8VM4ku6LXT3wQPTi4kSBFJVQtNQocMKb8Xmn9c/j+pvNn68Jjk4nCXNTShtqvGEpgk0nn2iUpV0j7vXY92rV7tF/acbEn7A2F2T6/y4AmGnlCkRBF2YT+94aKQrPN5CTBqmPWIp0yaaJ9uzUe7yNHEO0rwdxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JMdslGgVao8GoGKRBQQ4OTIk1mue3+JFyOFClWQroSY=;
 b=dDG9p1I/bOdVNvQ1SyTLkWzMJbPyACQjqg7yoKfWpm05VjvsNFeqzE8n0xb2GpNUMLciPzUgmSde5znKbfdZlL62qT9dJrz3IS/nX6ubUiBiOftIi0vUPn4Rq7/iLLq1LOFABI68FKiGiNVA+hvUXNHcb7dNAEzDXizWfYuTHNtH/rwOyi/Lyiu0Px+Y2LloWVXwb11swCU+zI0aS+YED7BWxDNGp7JeKe0seRNXFpCo4BqqWvyxHg7YXJJfqQaP7hmQOAG2GQ2Q/o1VU0EbSpquOXTDCNrMIodMxnJsNHYj/8hNo7XS2zeboGSPhYeV3TUHbJ7c5uKdinma8lVaoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMdslGgVao8GoGKRBQQ4OTIk1mue3+JFyOFClWQroSY=;
 b=EHeRaX1CUHz2LQjRTla+YYZE1xYGVfJ3k7lYwjLHf0yf4KlmbqBPzM20Rv6BYModutVXkE7fGj7vIibc+mI8Gp02fdCEeyhFqgPQwxhGsczVVynZVwBtYC7QILb9/NsfMFjn8VNsT17dLvm3+k2p0pJlKhFemucMFKWrreBLJ7A=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by DU2PR04MB8565.eurprd04.prod.outlook.com (2603:10a6:10:2d4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Wed, 20 Mar
 2024 01:10:58 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::6e8:79bd:7877:afa7]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::6e8:79bd:7877:afa7%3]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 01:10:58 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Johannes Berg <johannes@sipsolutions.net>, Brian Norris
	<briannorris@chromium.org>, Francesco Dolcini <francesco@dolcini.it>
CC: "kvalo@kernel.org" <kvalo@kernel.org>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Pete Hsieh <tsung-hsien.hsieh@nxp.com>,
	rafael.beims <rafael.beims@toradex.com>, Francesco Dolcini
	<francesco.dolcini@toradex.com>
Subject: RE: [EXT] Re: [PATCH v9 0/2] wifi: mwifiex: add code to support host
 mlme
Thread-Topic: [EXT] Re: [PATCH v9 0/2] wifi: mwifiex: add code to support host
 mlme
Thread-Index: AQHab2onJLj7by1TDUGmc5gbcJq9YLE4nU6AgAD7hoCABXXFAIAA1QEAgAAD/+A=
Date: Wed, 20 Mar 2024 01:10:58 +0000
Message-ID:
 <PA4PR04MB9638BE73DDBCE1CE8AA32BA8D1332@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240306020053.18054-1-yu-hao.lin@nxp.com>
	 <20240315094927.GA6624@francesco-nb> <ZfTspRKFgrO9xCTH@google.com>
 <969e95ccc4a1d35b45212b7fcb536ee90995e3b5.camel@sipsolutions.net>
 <PA4PR04MB9638D253189D6DD330B198B2D1332@PA4PR04MB9638.eurprd04.prod.outlook.com>
In-Reply-To:
 <PA4PR04MB9638D253189D6DD330B198B2D1332@PA4PR04MB9638.eurprd04.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|DU2PR04MB8565:EE_
x-ms-office365-filtering-correlation-id: 194c1b92-e987-412c-4a86-08dc487a99c8
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 4BAT9PZb3XF0xrJPfPWaJ/DP13Rfg3WoM0RrKEYLVVmctPcPX/TYKHjDE0nmksmNj13DovmlpmVv0wSygbDBgTCxTwBOkuHgO5fMzuq9YQvfulWqpeZ4B3nPut5EFRbzfyRMHseq6VT53nUS9ml+/MUq2+dH+jpEjiaimHcpKHrJgOhbQZtJLuF4lIQCiTlIbLuSIRJ5vG8+uAdU42J9TZkbaL8aanxA+Ll+auz9Ov+qW8AwpS1c4zC9s3T+tS1ruuzxSu7/vp6q7+I/fcbEKotX7c6QrW2AsqkpDpUhbULESnkSk5CWxI1LbKc5A98C3R2eq47Ukcn8SUtuf0L6F18gjqGJBehNWLViXM2EbF96VKqVpL5rWTCPx3XUtnW+wwTM8kQlzvQlnY6WLY23hFk6g2C8sTR+j6AExW1YLhmPV3VJa8J2oLNHf73T6mpqAzAFN+4eNm2niFbKSpGws3uIiQimUvCVBak+Eg1ZWXyu8fiT47t2EDNd3uAtgs10pkglpEO05TXQ9gAbYSwy5gw39IPTYID8vw8js72LnKcRpgy/ZisDs3wbo98jnry+1lKrunzweLdkOyEJV5Rn/NWRBDp6THQ6eZcQvGkp50Fu0JMipvbDT9ElvLdQ8nOwHsgSeD8azDBvTHLJsKtNFjfv1v9a8ukZoH4NP6SK/m+UPMeMULvbFetl3tO89sAFUQd2OZvU1cByuMi1IegHNmNOcORBoA6ji5NOSGK4Amo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UTUxUmtCdmZyTWtKOHM5MG84eExFMGhyQUpnWFo0RjczSjBJMWo5bzJETXBa?=
 =?utf-8?B?dXZPemdzM0tEUFVMSDkvR2ZVN0g3dnQ5citkeEtLVFVFV2U2UWpUN2hGaGhs?=
 =?utf-8?B?TlViL3VUdDdmZnZsY09xdjloNlhySWQ4V3cvSkNMZGN4WlFSOWNYOW1SZm5l?=
 =?utf-8?B?QTBQeWJ5amRhT3drQW5zQUxXS2J2MHJUZ3NSUmZMWXdjUEtZUXRWMTdVOGJr?=
 =?utf-8?B?MG43MkQ3WmFrdGhrNG5xaExZK3hKQ3BJYlM1Tk9Ld0FOSzl5VUVneFdNc1dP?=
 =?utf-8?B?QUtodEZ4VHJwVEhXN3ArMlYzWU5sUHVPcXVxL2lGR2MvOVViRXovWU9sa0R5?=
 =?utf-8?B?a0VhM3BzVjBDRUsydWxORFZEVGJFQWtPOFlJOUF5VUpsU1RBbUNOdVlpd1dY?=
 =?utf-8?B?c2s5dFFieE5tbHVjN3o2VEpMQkdKdzI1Smdwd1dRVkgvRWN5RVViS05jSXli?=
 =?utf-8?B?cjFvK3RVRG85c3hUTTNkSWdTRTZjblM5VWNFcmJ5UTNQVVFBS0NCQXpWMnZt?=
 =?utf-8?B?YURkUVgrb0gwUnhxekxrZnNGN2V5b3dlVmxKMVYyK1JHU3RMRnFRVzkzS2xO?=
 =?utf-8?B?bGp3VkxTSVRwNEtUVkxWZDFmUHl0bzNVTjJXQklwVlk5RytGWG9KZmdqV01r?=
 =?utf-8?B?dWYwR0N0cUluSkhrMW50Y1BWdmxRdTVTV05LY3NDVzRjWWVWZFJGNDVURXNY?=
 =?utf-8?B?cDJHUll2ZTkzTG1MTFpIUGtNeURLbDJZanUzL2F6M1h6Wm5KdmdCSk1NWHVZ?=
 =?utf-8?B?UWVPQXVrKzd3Q0JBS0hldjVBZSt1SXBvU04ybnU3KzdkVWFyUDhPMnhHSkhX?=
 =?utf-8?B?Slp6UHQrMUlSR2FmNlFTbWNYQ3RzbGZ1anBRd0NyUlh2UkFSY3VxSTdjUHBV?=
 =?utf-8?B?SWFWMDZyVFM0L1E1NUJxVWZBVnJKTU5TclBhSUh4SjYzZnFUMmQyV0lhU2xy?=
 =?utf-8?B?eWdhcTNGNDEvV09TU0xOQjFFajRaRDhYU04xbzNkTzJQb1BLNTBIbllwMzkv?=
 =?utf-8?B?dDVTMHd1OHNnVWRIcVZTY05JYkxYZFB4YUZRTndiRzdOeXBVU004OVZrTkRn?=
 =?utf-8?B?dm16L1gxNE84b0NLM2hSMkNDR00wQmJQcE95REQyRk9ESitMcy9qWFN3dUU2?=
 =?utf-8?B?eTBuVG8zbVJaRXROTEVjeXVSS052WlFqbGs1NHdZQ0NvbG5lU2xQQmZwa0RP?=
 =?utf-8?B?MW9rVFc5TGdrcGJGSUgrV0ZhNnd2WTRwMnNGOGFuakZqL2FOdnhxMVEwMnZU?=
 =?utf-8?B?bFhTdEowS2kzNTRPSHQvNmgrNENndW1oQ0VzdldTRElEWmhWZlRxeU03UDFI?=
 =?utf-8?B?bzQydGh3QW9TZ01GTDhTM215a0NZVDlUNG11TkNqZWtCblA3Q0RoSTZJSytS?=
 =?utf-8?B?RGhSZmRUalFRTG5CTnFWb2NMYXJTT0VRM2RsRFlac2UrQnVJNUovOUZraXlz?=
 =?utf-8?B?bkJXczBwT1JxSlZzQnU2RnJuUlhrQzB0a2YxL0JPTjcweWJQUGNWYklVcW84?=
 =?utf-8?B?Z0VEZDdRdFNuWVNKWlUvLzd6dHB2emFKeWJIZ2ovN0dHTE05amtJcC85MjhE?=
 =?utf-8?B?dCtQUklJUjJKODBDZVlZMEdoeFE3OEp6S1ZkekdiZlgzWW1uVDJhcXJjT1p3?=
 =?utf-8?B?UHZhcjRqZVpWemx6Zm9sNldmazY1T012eVRZSm10encrZWNWYkR1Uk5IWGp0?=
 =?utf-8?B?Nktvd3VXSEt0Wi9kNFNPT2tmSVZUaUU4bHdicjlGTEE2Ny8xaHl1TXdGYmdq?=
 =?utf-8?B?cHlQMEI3SjZqVHZZaXd4WEkrczJwUkRHVXpYN3dENUNHcGtvMFRQUFRHYVN4?=
 =?utf-8?B?VWhRcFlYeU96eWlXQ2ZMN2tSTWllTlEyQVgxeTRrdFl2OUNrdUErYjN3RmtF?=
 =?utf-8?B?VFRqOUZ0SFJQcGFMR0RtalhveTViWUhibVlLL3dCS0FsTzFkMUxFK3IzZWc1?=
 =?utf-8?B?dkNVOU90S0F2b0h0MFJkOE5mK3g0blBnNTZQNkZEZTVhTjBubFJ0K3FuRXhF?=
 =?utf-8?B?NkwwYWlaZmhMQ1dQa1oybDllb0dLblFlVXdHeEZ3VmtxY2Fld3d5M05vdXZj?=
 =?utf-8?B?S28xclFZOHY4QWo1dXcrdFo1OE5PVFM5NWlXUmh2TU9pbnM0aU9MV05wbjRz?=
 =?utf-8?Q?XWI+AgpmpF4Ko8x8c/6wr2dfN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 194c1b92-e987-412c-4a86-08dc487a99c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2024 01:10:58.2894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MzSLrTmtvoLFmnaeMHaGLoQpgGKSUtJCDlX2d8iJiZctpiKDQtIHVdPXk2gK12DE+y8A8TIJZwLk6ppKQ69Tdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8565

PiBGcm9tOiBEYXZpZCBMaW4NCj4gU2VudDogV2VkbmVzZGF5LCBNYXJjaCAyMCwgMjAyNCA5OjAw
IEFNDQo+IFRvOiBKb2hhbm5lcyBCZXJnIDxqb2hhbm5lc0BzaXBzb2x1dGlvbnMubmV0PjsgQnJp
YW4gTm9ycmlzDQo+IDxicmlhbm5vcnJpc0BjaHJvbWl1bS5vcmc+OyBGcmFuY2VzY28gRG9sY2lu
aSA8ZnJhbmNlc2NvQGRvbGNpbmkuaXQ+DQo+IENjOiBrdmFsb0BrZXJuZWwub3JnOyBsaW51eC13
aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IFBldGUgSHNpZWggPHRzdW5nLWhzaWVuLmhzaWVoQG54cC5jb20+Ow0KPiByYWZhZWwuYmVpbXMg
PHJhZmFlbC5iZWltc0B0b3JhZGV4LmNvbT47IEZyYW5jZXNjbyBEb2xjaW5pDQo+IDxmcmFuY2Vz
Y28uZG9sY2luaUB0b3JhZGV4LmNvbT4NCj4gU3ViamVjdDogUkU6IFtFWFRdIFJlOiBbUEFUQ0gg
djkgMC8yXSB3aWZpOiBtd2lmaWV4OiBhZGQgY29kZSB0byBzdXBwb3J0IGhvc3QNCj4gbWxtZQ0K
PiANCj4gPiBGcm9tOiBKb2hhbm5lcyBCZXJnIDxqb2hhbm5lc0BzaXBzb2x1dGlvbnMubmV0Pg0K
PiA+IFNlbnQ6IFR1ZXNkYXksIE1hcmNoIDE5LCAyMDI0IDg6MTMgUE0NCj4gPiBUbzogQnJpYW4g
Tm9ycmlzIDxicmlhbm5vcnJpc0BjaHJvbWl1bS5vcmc+OyBGcmFuY2VzY28gRG9sY2luaQ0KPiA+
IDxmcmFuY2VzY29AZG9sY2luaS5pdD4NCj4gPiBDYzoga3ZhbG9Aa2VybmVsLm9yZzsgbGludXgt
d2lyZWxlc3NAdmdlci5rZXJuZWwub3JnOw0KPiA+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7IERhdmlkIExpbiA8eXUtaGFvLmxpbkBueHAuY29tPjsgUGV0ZQ0KPiA+IEhzaWVoIDx0c3Vu
Zy1oc2llbi5oc2llaEBueHAuY29tPjsgcmFmYWVsLmJlaW1zDQo+ID4gPHJhZmFlbC5iZWltc0B0
b3JhZGV4LmNvbT47IEZyYW5jZXNjbyBEb2xjaW5pDQo+ID4gPGZyYW5jZXNjby5kb2xjaW5pQHRv
cmFkZXguY29tPg0KPiA+IFN1YmplY3Q6IFtFWFRdIFJlOiBbUEFUQ0ggdjkgMC8yXSB3aWZpOiBt
d2lmaWV4OiBhZGQgY29kZSB0byBzdXBwb3J0DQo+ID4gaG9zdCBtbG1lDQo+ID4NCj4gPiBDYXV0
aW9uOiBUaGlzIGlzIGFuIGV4dGVybmFsIGVtYWlsLiBQbGVhc2UgdGFrZSBjYXJlIHdoZW4gY2xp
Y2tpbmcNCj4gPiBsaW5rcyBvciBvcGVuaW5nIGF0dGFjaG1lbnRzLiBXaGVuIGluIGRvdWJ0LCBy
ZXBvcnQgdGhlIG1lc3NhZ2UgdXNpbmcNCj4gPiB0aGUgJ1JlcG9ydCB0aGlzIGVtYWlsJyBidXR0
b24NCj4gPg0KPiA+DQo+ID4gT24gRnJpLCAyMDI0LTAzLTE1IGF0IDE3OjQ5IC0wNzAwLCBCcmlh
biBOb3JyaXMgd3JvdGU6DQo+ID4gPg0KPiA+ID4gTm93IHRoYXQgSSd2ZSBsb29rZWQgYSBiaXQg
Y2xvc2VyIHRvZGF5OiBJJ20gcmVhbGl6aW5nIHRoaXMgbWF5KD8pDQo+ID4gPiBiZSBvbmUgb2Yg
dGhlIGZpcnN0ICJmdWxsIE1BQyIgZHJpdmVycyB0cnlpbmcgdG8gaW1wbGVtZW50IGl0cyBvd24N
Cj4gPiA+IE1MTUUNCj4gPiA+IC0tIG9yIGF0IGxlYXN0LCB0aGUgYXV0aC9hc3NvYyBiaXRzLg0K
PiA+DQo+ID4gSG1tLCB5ZWFoLCB3aHkgX2lzXyB0aGF0PyBtd2lmaWV4IHdhcyBvcmlnaW5hbGx5
ICJzb2xkIiBhcyBhICJmdWxsIE1BQyINCj4gPiBkcml2ZXIsIGkuZS4gZG9pbmcgdGhpbmdzIGlu
IHRoZSBmaXJtd2FyZS4NCj4gPg0KPiA+IFdlJ3ZlIHNhaWQgdGhhdCAic29mdCBNQUMiIGRyaXZl
cnMgc2hvdWxkIGJlIHVzaW5nIG1hYzgwMjExLCBidXQgdGhpcw0KPiA+IHRoaW5nIGNhbid0IHNl
ZW0gdG8gZGVjaWRlPw0KPiA+DQo+ID4gQWxzbyBkZWNsLmggc2hvdWxkIHByb2JhYmx5IF9zaHJp
bmtfIHJhdGhlciB0aGFuIGdyb3csIGEgbnVtYmVyIG9mDQo+ID4gdGhpbmdzIGp1c3QgcmVwbGlj
YXRlIGllZWU4MDIxMS5oIChzdWNoIGFzIE1XSUZJRVhfTUdNVF9IRUFERVJfTEVODQo+ID4gcmVh
bGx5IGlzIGp1c3QNCj4gPiBzaXplb2YoaWVlZTgwMjExX21nbXQpIG9yIHNvPyBOb3QgcXVpdGUg
Y29ycmVjdGx5LikNCj4gPg0KPiANCj4gVGhpcyBjYW4gYmUgZG9uZSBmb3IgZmVhdHVyZSBwYXRj
aGVzLg0KPiANCj4gPiBTbyB5ZWFoLCBhZ3JlZSB3aXRoIEJyaWFuLCBub3Qgb25seSB3b3VsZCB0
aGlzIGJlIHRoZSBmaXJzdCwgYnV0IGl0J3MNCj4gPiBhbHNvIHNvbWV0aGluZyB3ZSBkb24ndCBy
ZWFsbHkgX3dhbnRfLiBBbGwgb3RoZXIgZHJpdmVycyB0aGF0IHdhbnQNCj4gPiBzdHVmZiBsaWtl
IHRoaXMgYXJlIHN0dWNrIGluIHN0YWdpbmcgLi4uDQo+ID4NCj4gPiBTbyB3aHkgaXMgdGhpcyBu
ZWVkZWQgZm9yIGEgc3VwcG9zZWRseSAiZmlybXdhcmUgZG9lcyBpdCBhbGwiIGRyaXZlciwNCj4g
PiBhbmQgd2h5IGNhbiBpdCBub3QgYmUgaW50ZWdyYXRlZCB3aXRoIG1hYzgwMjExIGlmIGl0J3Mg
bm8gbG9uZ2VyICJmaXJtd2FyZQ0KPiBkb2VzIGl0IGFsbCI/DQo+ID4NCj4gPiBKb2hhbm5lcw0K
PiANCj4gT3VyIHByb3ByaWV0YXJ5IGRyaXZlciBpcyBjZmc4MDIxMSBkcml2ZXIsIGl0IGlzIHZl
cnkgaGFyZCB0byBjcmVhdGUgYSBicmFuZCBuZXcNCj4gbWFjODAyMTEgZHJpdmVyIGFuZCBzdGls
bCBjYW4gcG9ydCBhbGwgdGVzdGVkIHN0dWZmcyBmcm9tIG91ciBwcm9wcmlldGFyeSBkcml2ZXIu
DQo+IA0KPiBUaGFua3MsDQo+IERhdmlkDQoNCkJUVywgdmVuZG9yIHNob3VsZCBoYXZlIHRoZSBj
aG9pY2UgdG8gdXNlIGNmZzgwMjExIG9yIG1hYzgwMjExIGZvciB0aGVpciBjaGlwcywgcmlnaHQ/
DQo=

