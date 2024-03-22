Return-Path: <linux-kernel+bounces-111255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F208869C6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A52381F268B6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30AD2225D7;
	Fri, 22 Mar 2024 09:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="H3vkZYfA"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2138.outbound.protection.outlook.com [40.107.247.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32F4224C7;
	Fri, 22 Mar 2024 09:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711101264; cv=fail; b=bepEFHlVjtWz9a8wg0VJbxi7cbR5SYDUu8tNPCrpxkYY2HJo9uP/WFAlM1bVWEYKz0mabao5NPL31QjGENmubq20TkJXrAryUdRc2Fi7nA3+FbJOQUJHmQQhepadkjGrBoTcShzANyAjbE3khvDHX13/fMGRkZ7E+B4sxgPRkWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711101264; c=relaxed/simple;
	bh=FZa+dTVDYpy0+ih8U6RXenG+egL2Tp9e9yCYPOFD9Is=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fGKDBTUaUFtez5l01q+bhOecwxGy/+1mOYyC6+yeKwItp8CHSg+1ygAiMf/VOsjpur5j4pRCmtoBDzkACt/DTSlbMLdChLrQiE7F/XTnzkR0DJmUj1copclDlSNXM/LXfpqfXTa7r8LrwiaHvyqD9UpwAHENnULfWOy1U5CmYe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=H3vkZYfA; arc=fail smtp.client-ip=40.107.247.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=obZMrGfT+WF9adIjMg4DkKd6j2C76Zqa7VnF6XNrj/PqVQjhQ4anW9ou4w27TcUO9Hf682pAMo8RNZPN9RX5lxlO4FZHEBzO0Gn3Ta2HgmaE2jqCEtqFlI6XZb9/sLjI/ybpl9uIs9cGre0Rc6vPtoznOnb4V9kdUVlE8xUVb0ll6YMtq3UqZTKe4zMfzW5w7T9BntUfYIei08EyElOop9AGTMkDUaYs4mvt/8t6LS4HOVlT7pksmi/Fh2aGldn4Raa9iKRE6H5k7COUF5/s1YKgE5i8aYgamfUq2fZe2Ib1Vr11Z47imtCBJqSrldC6DSIsBnJ2hwDAMtewR2PnGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZa+dTVDYpy0+ih8U6RXenG+egL2Tp9e9yCYPOFD9Is=;
 b=KrPln8BQRqomliZrx5ANea17t/hNNoT9OZGJhnOu3B8TCcEIPNZNC9m8Bma0EuBEM1WmaNYqF2kqWjBLVIrhjoSkHW6z4V8h8nX6agz6XzFpx2pBZh+GSsdTkeQtpFzw2WXqedbHNKWZkqGVUehdw22qEEFH8ij8QrxTvykqjqo8Yz0VKvegliayqG/ZAD26v5ww8sOHLYdIMNdZqiAEO3zeVNfvKbOAeAXQIBymlcXSvAjI7yMVsciwwo8NFNjVgXROkoCrOoELwVUlL4xjSxIxWqmd0OvQEudyUcMKZp6DoJQDT772X2ZovkMBrzAX0U0wt4sbpJ9sOJ1DBJCCNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZa+dTVDYpy0+ih8U6RXenG+egL2Tp9e9yCYPOFD9Is=;
 b=H3vkZYfAFez/3hcYQZGhSflcH3AJxhk6DnDLD6B8o7phGqNvXmYpVNgiR/TL1yDj3oC8EU1y90X5uICopKdRqP0amfPV5scym3pNHe0q2+ODHbl9cNXMwzYE24iMwwrm4wh0Ip7bTh1M3S2de28ze/Tl49pE7KA5GjLNw+8/yi0=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by PA4PR04MB7664.eurprd04.prod.outlook.com (2603:10a6:102:f1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 09:54:19 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::57e1:e1cb:74e2:2e9d]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::57e1:e1cb:74e2:2e9d%5]) with mapi id 15.20.7409.023; Fri, 22 Mar 2024
 09:54:19 +0000
From: Josua Mayer <josua@solid-run.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Gregory Clement <gregory.clement@bootlin.com>, Sebastian Hesselbarth
	<sebastian.hesselbarth@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Yazan Shhady <yazan.shhady@solid-run.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] arm64: dts: add description for solidrun cn9130 som
 and clearfog boards
Thread-Topic: [PATCH 2/2] arm64: dts: add description for solidrun cn9130 som
 and clearfog boards
Thread-Index: AQHae9lamF1Na8/mpEGgdJkfFpR9o7FCvoaAgADHmIA=
Date: Fri, 22 Mar 2024 09:54:19 +0000
Message-ID: <0d1afbcc-948e-4aff-8296-42f7166d318d@solid-run.com>
References: <20240321-cn9130-som-v1-0-711127a409ae@solid-run.com>
 <20240321-cn9130-som-v1-2-711127a409ae@solid-run.com>
 <e24e78a6-852c-4458-987c-3601908a71f0@lunn.ch>
In-Reply-To: <e24e78a6-852c-4458-987c-3601908a71f0@lunn.ch>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|PA4PR04MB7664:EE_
x-ms-office365-filtering-correlation-id: a4b788da-0f29-430a-03d7-08dc4a560b42
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 6PGiffRv+NrpNfmQPCuz3K16IN55PEEzWV6CGqZxWC1L3okHlZAipyIDMsuoUtalbzo7S8HmGLAnLScfwM96Enn1W5XNAo7BnqPmg9uKf0P6o1wdN5CJ1VFOsNdozsqwZ21n2r1mIj52V3FU037OfntI4CIxGLuo9M98M+d4Px2tCLV7lKPriZaW1dmrXNW5XBNNl8ZwjaK8TUC2h1VpauCa2D7Ryiy2/j1qkfm7jxO6mPKeRLNe3v1W0l3JIQnLKuUku7+BOEKRUyGfDbB5+LyeM3Q1aHkbVvk5o0Yqy5eC3Z3jw7myJhc3liuHuT3hb4obOCqX7ZERm7R3fhrTtXRAAfb6oR8oyqfphqcOx4JK4uaX0wFVPIbee/2T+65aDq5L9/caq4mSM9q6Hft+Fo5tS8x+ZZx/Teu+RFLf9OoaM3lvXH0jHoH69M3VHCs47d90IHEAFNUiunZ5VCQE+EW3EFj1lJxgu7zG7A9my8RjWWcgiCfAN/QFP6qBF5dzoIZK+wXf9bMXwSCRq/td0/PyYzzl/ZbJDrVS7nYCQo89639nAmijaNrwLyWpquykoNUkauT584Yl7fn3P6laaqbJdIa3/X+yv0jCUIcKTbfzSEQ4whYYbOW8IUfhv43NW/JULO43+lHX45YyoskeE6WZ4EX9H+7UpFHQpgc6qh1syPnl573etce0TgSstnFoi8liToQMlwRngidgF9jL5g==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V0dUbTNESUZERWNRZy9McTFkdGFsczBNRS9COVJEbmgwcFJTZ2g3UEFBK0JP?=
 =?utf-8?B?K2ovVzZnNjJVWk1kSlFqNlQ4ZUxHMXROT0c5TzFDa3RZbjFDdXRvSVNBbHVi?=
 =?utf-8?B?aUpSQUxqUFFDU1VVR2pueGV6dE9YQUErc2hXam5uOUhrc2F6UzFyRjFZc2RI?=
 =?utf-8?B?b2hMYU5QYmo4bzBUTWdKdmtpYzBOWW42b2lSbit0ZDNxWFl4ZDVQdU02QkFy?=
 =?utf-8?B?OGFjeTc0VVF0M25ubTNmSFZGa25pNVNLOUNkbmJpUU11RGpPSUhDV2sxZU5B?=
 =?utf-8?B?eHBHZ0g0REdhOU5WcjJuQWFVTElGUTRaVDhCQ0dKclZDcDRva1R1UkFXeUNK?=
 =?utf-8?B?ZVF5RU1sR0FVTzZFdS9SY0g5cmpUOW9jTUZiUHVGa3NKMHo3dnQzTWM2RUFS?=
 =?utf-8?B?UWNsOUZxYjF0eWJ1NzdUaTRtSFFnU1k4cnRYMHJpVjNsV0dYQWdOT2lKdndC?=
 =?utf-8?B?NHV1R1FGbHA3c0NzOUNTcXNtZXhPN3dHUGl6djJTWG5lN05yQnQ5RDhsdWJG?=
 =?utf-8?B?cVRuelBqZnlTQUhNcW1Tdkkxc3Y4QVBncHBVajFxZ3U0ZHpuTlBUSjdMNEFo?=
 =?utf-8?B?RzNvendGMy9tMk5DYWN6MWpsZlRJbmMyakFoMlVMOWppN0JCSjIzWHpmV3Y3?=
 =?utf-8?B?ZEswWWpoRC8rTitHeVBWMTdsUGxDeUJnWUh1TXZidDdpVDRKaXh6SkFnYXhI?=
 =?utf-8?B?QW5YK1RoMmpJU3FFb2U0d3pOVWdCd2gzWTA1Q3h5cjlLbXFIOWxiNjZuM0lt?=
 =?utf-8?B?Mk1keVBqV3ljbTlGREVpS2R2OFg5WnE0cGkvVEcyaGNraHFoODBMREVmQjQy?=
 =?utf-8?B?MXhNelN3RlFIZjh3WlNPMzdlTXZycE5oc3VVWUVidU1TVmlYMFBHVm5OWHZI?=
 =?utf-8?B?aXVtam93NGFPMVplK0FFYWZTcXpUdi96ZHpyTXZtaFA4RnVTQWFFWXA0cDl5?=
 =?utf-8?B?eFlLendSYlI5MmY5dWtUcTBYNjFaRHZEVGlHNUhtY3VMRkh5anI3Q3dkOFZ1?=
 =?utf-8?B?VVc3R0tvSDhmQjQyWDJwRGMwa2R5dVpwdjlqM3dySEhiS1l0b0hlYnIwK2l6?=
 =?utf-8?B?SjdFeVQ2RVQzSlovWFlzNmRqcnh6Z09SajlzNklDNDZOa1VEazgzTEpjcW12?=
 =?utf-8?B?alA4WVlybzFaWUN4YmdrS2VuWjlYVW93WFhyc2p3Sm1LMlkrMVp5bS9MMEgv?=
 =?utf-8?B?NTFubGx3RlN0RFNQbHl6NWJhQUZHRVA3em1qMEgyMTJTVEQ1L2NvZVpHVjI3?=
 =?utf-8?B?TnYzWFBlN1pkUE8xamJWckZIVUlLd3RIakloQmJXSVBuSG0zWiszWDIvK1JF?=
 =?utf-8?B?OVN6bWlsRzMxQk51VzBTWWR3NEtaU1ZzNFJjU3NKajdtbGdVSmd0Rm1UWUVy?=
 =?utf-8?B?Tk9UUmU0N0FSUGpySnRyWVNVQy80NGZMeUtIajdlN21odTJ3aUhzY211NGJ0?=
 =?utf-8?B?YkxIMVpON1FEdWlZWWdWa1NNMWV5SWY2QklGMXNGcGhDN1FLZ0JXRForT1Fv?=
 =?utf-8?B?QkZFVG13SkdCdjdxRld3c3VLV0EzRUZ2YmNPTkFlbFJJdElHOCs4c2E3Vytj?=
 =?utf-8?B?QXdoUnJ1YVQxOFJJK1NJbFdEQUpUMURkZEJKYWtqNVNNMm9uSjJ5RklQenhi?=
 =?utf-8?B?UDFpQU43OFBoU2U3UVZnS1FLQ2poWnRWTU9MTVBuZHR3VWJVUzI3RTVHQml4?=
 =?utf-8?B?N0MrN2FkZXVLSTMrbGpiaFNBajY2UmRGaHpZY0JKK0RCT3NuTUUrdlVHT2Zj?=
 =?utf-8?B?SmFSaXVkcFVJWS9vaEpSWEZNczU0SWJNOWVTNzZUNHk2Tyt2a3d5MFcrUEhM?=
 =?utf-8?B?OWxHL2grb1BOZ3F6SDFRYjdGaEtSSVNJY2lzU3QzYkdwU2RmQTVpOW92L0lO?=
 =?utf-8?B?SStLOWpXMXBKTDVOdTMwMzIrM1pBT1pyWjRpMHBWVExxcTErL1dXdUdQc3dO?=
 =?utf-8?B?YnNoTWNyWWJXNURSSEg3TmZOMnlLemVFV1Y1UjZlSnpFSkowUm04bGNXS0pT?=
 =?utf-8?B?MytOdUdXZksyOWIzejdleFdMTnRZVGNTbjN1SlZ0WWNPVTJYRWtKWGNrVy9F?=
 =?utf-8?B?VDRwcUMvWDR2WG9YNWJHOFpValpQYTdHZmNTRWNSUWlqRkFVMElMaUY3SUVD?=
 =?utf-8?Q?XvXw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C0577CDE139C2C4DAFF2933FE70E35FA@eurprd04.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a4b788da-0f29-430a-03d7-08dc4a560b42
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2024 09:54:19.6039
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +V6pIUCWy80XOAQVPv9QbJKfkWC5s4+2DMm77v2ecwuhdPXm8ttYHGd93wbquq8WN00z3z68G8n2p10Qc6dR6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7664

QW0gMjEuMDMuMjQgdW0gMjI6NTkgc2NocmllYiBBbmRyZXcgTHVubjoNCj4gT24gVGh1LCBNYXIg
MjEsIDIwMjQgYXQgMTA6NDc6MTJQTSArMDEwMCwgSm9zdWEgTWF5ZXIgd3JvdGU6DQo+PiBBZGQg
ZGVzY3JpcHRpb24gZm9yIHRoZSBTb2xpZFJ1biBDTjkxMzAgU29NLCBhbmQgQ2xlYXJmb2cgQmFz
ZSAvIFBybw0KPj4gcmVmZXJlbmNlIGJvYXJkcy4NCj4+DQo+PiBUaGUgU29NIGhhcyBiZWVuIGRl
c2lnbmVkIGFzIGEgcGluLWNvbXBhdGlibGUgcmVwbGFjZW1lbnQgZm9yIHRoZSBvbGRlcg0KPj4g
QXJtYWRhIDM4OCBiYXNlZCBTb00uIFRoZXJlZm9yZSBpdCBzdXBwb3J0cyB0aGUgc2FtZSBib2Fy
ZHMgYW5kIGENCj4+IHNpbWlsYXIgZmVhdHVyZSBzZXQuDQo+Pg0KPj4gTW9zdCBub3RhYmxlIHVw
Z3JhZGVzOg0KPj4gLSA0eCBDb3J0ZXgtQTcyDQo+PiAtIDEwR2JwcyBTRlANCj4+IC0gQm90aCBl
TU1DIGFuZCBTRCBzdXBwb3J0ZWQgYXQgdGhlIHNhbWUgdGltZQ0KPj4NCj4+IFRoZSBkZXZlbG9w
ZXIgZmlyc3Qgc3VwcG9ydGluZyB0aGlzIHByb2R1Y3QgYXQgU29saWRSdW4gZGVjaWRlZCB0byB1
c2UNCj4+IGRpZmZlcmVudCBmaWxlbmFtZXMgZm9yIHRoZSBEVEJzOiBBcm1hZGEgMzg4IHVzZXMg
dGhlIGZ1bGwNCj4+ICJjbGVhcmZvZyIgc3RyaW5nIHdoaWxlIGNuOTEzMCB1c2VzIHRoZSBhYmJy
ZXZpYXRpb24gImNmIi4NCj4+IFRoaXMgbmFtZSBpcyBhbHJlYWR5IGhhcmQtY29kZWQgaW4gcHJl
LWluc3RhbGxlZCB2ZW5kb3IgdS1ib290IGFuZCBjYW4NCj4+IG5vdCBiZSBjaGFuZ2VkIGVhc2ls
eS4NCj4+DQo+PiBOT1RJQ0UgSU4gQ0FTRSBBTllCT0RZIFdBTlRTIFRPIFNFTEYtVVBHUkFERToN
Cj4+IENOOTEzMCBTb00gaGFzIGEgZGlmZmVyZW50IGZvb3RwcmludCBmcm9tIEFybWFkYSAzODgg
U29NLg0KPj4gQ29tcG9uZW50cyBvbiB0aGUgY2FycmllciBib2FyZCBiZWxvdyB0aGUgU29NIG1h
eSBjb2xsaWRlIGNhdXNpbmcNCj4+IGRhbWFnZSwgc3VjaCBhcyBvbiBDbGVhcmZvZyBCYXNlLg0K
Pj4NCj4+IFNpZ25lZC1vZmYtYnk6IEpvc3VhIE1heWVyIDxqb3N1YUBzb2xpZC1ydW4uY29tPg0K
Pj4gLS0tDQo+PiAgYXJjaC9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL01ha2VmaWxlICAgICAgICAg
ICB8ICAgMiArDQo+PiAgYXJjaC9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL2NuOTEzMC1jZi1iYXNl
LmR0cyB8IDEzOCArKysrKysrKysrKysrKw0KPj4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVs
bC9jbjkxMzAtY2YtcHJvLmR0cyAgfCAyNDkgKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4g
IGFyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVsbC9jbjkxMzAtY2YuZHRzaSAgICAgfCAxOTggKysr
KysrKysrKysrKysrKysrKysNCj4+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvY245MTMw
LXNyLXNvbS5kdHNpIHwgMTYwICsrKysrKysrKysrKysrKysNCj4+ICA1IGZpbGVzIGNoYW5nZWQs
IDc0NyBpbnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9k
dHMvbWFydmVsbC9NYWtlZmlsZSBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVsbC9NYWtlZmls
ZQ0KPj4gaW5kZXggOTliOGNiM2M0OWUxLi4wMTlmMjI1MWQ2OTYgMTAwNjQ0DQo+PiAtLS0gYS9h
cmNoL2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvTWFrZWZpbGUNCj4+ICsrKyBiL2FyY2gvYXJtNjQv
Ym9vdC9kdHMvbWFydmVsbC9NYWtlZmlsZQ0KPj4gQEAgLTI4LDMgKzI4LDUgQEAgZHRiLSQoQ09O
RklHX0FSQ0hfTVZFQlUpICs9IGNuOTEzMC1jcmItQS5kdGINCj4+ICBkdGItJChDT05GSUdfQVJD
SF9NVkVCVSkgKz0gY245MTMwLWNyYi1CLmR0Yg0KPj4gIGR0Yi0kKENPTkZJR19BUkNIX01WRUJV
KSArPSBhYzV4LXJkLWNhcnJpZXItY245MTMxLmR0Yg0KPj4gIGR0Yi0kKENPTkZJR19BUkNIX01W
RUJVKSArPSBhYzUtOThkeDM1eHgtcmQuZHRiDQo+PiArZHRiLSQoQ09ORklHX0FSQ0hfTVZFQlUp
ICs9IGNuOTEzMC1jZi1iYXNlLmR0Yg0KPj4gK2R0Yi0kKENPTkZJR19BUkNIX01WRUJVKSArPSBj
bjkxMzAtY2YtcHJvLmR0Yg0KPj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWFy
dmVsbC9jbjkxMzAtY2YtYmFzZS5kdHMgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvY245
MTMwLWNmLWJhc2UuZHRzDQo+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPj4gaW5kZXggMDAwMDAw
MDAwMDAwLi5iMDA2Nzk0MGQ1ZTQNCj4+IC0tLSAvZGV2L251bGwNCj4+ICsrKyBiL2FyY2gvYXJt
NjQvYm9vdC9kdHMvbWFydmVsbC9jbjkxMzAtY2YtYmFzZS5kdHMNCj4+IEBAIC0wLDAgKzEsMTM4
IEBADQo+PiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjArDQo+PiArLyoNCj4+
ICsgKiBDb3B5cmlnaHQgKEMpIDIwMjQgSm9zdWEgTWF5ZXIgPGpvc3VhQHNvbGlkLXJ1bi5jb20+
DQo+PiArICoNCj4+ICsgKiBEVFMgZm9yIFNvbGlkUnVuIENOOTEzMCBDbGVhcmZvZyBCYXNlLg0K
Pj4gKyAqDQo+PiArICovDQo+PiArDQo+PiArL2R0cy12MS87DQo+PiArDQo+PiArI2luY2x1ZGUg
PGR0LWJpbmRpbmdzL2lucHV0L2lucHV0Lmg+DQo+PiArDQo+PiArI2luY2x1ZGUgImNuOTEzMC5k
dHNpIg0KPj4gKyNpbmNsdWRlICJjbjkxMzAtc3Itc29tLmR0c2kiDQo+PiArI2luY2x1ZGUgImNu
OTEzMC1jZi5kdHNpIg0KPj4gKw0KPj4gKy8gew0KPj4gKwltb2RlbCA9ICJTb2xpZFJ1biBDTjkx
MzAgQ2xlYXJmb2cgQmFzZSI7DQo+PiArCWNvbXBhdGlibGUgPSAic29saWRydW4sY2xlYXJmb2ct
YmFzZS1hMSIsICJzb2xpZHJ1bixjbGVhcmZvZy1hMSIsDQo+PiArCQkgICAgICJzb2xpZHJ1bixj
bjkxMzAtc3Itc29tIiwibWFydmVsbCxjbjkxMzAiLA0KPj4gKwkJICAgICAibWFydmVsbCxhcm1h
ZGEtYXA4MDctcXVhZCIsICJtYXJ2ZWxsLGFybWFkYS1hcDgwNyI7DQo+PiArDQo+PiArCWdwaW8t
a2V5cyB7DQo+PiArCQljb21wYXRpYmxlID0gImdwaW8ta2V5cyI7DQo+PiArCQlwaW5jdHJsLTAg
PSA8JnJlYXJfYnV0dG9uX3BpbnM+Ow0KPj4gKwkJcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsN
Cj4+ICsNCj4+ICsJCWJ1dHRvbi0wIHsNCj4+ICsJCQkvKiBUaGUgcmVhciBTVzMgYnV0dG9uICov
DQo+PiArCQkJbGFiZWwgPSAiUmVhciBCdXR0b24iOw0KPj4gKwkJCWdwaW9zID0gPCZjcDBfZ3Bp
bzEgMzEgR1BJT19BQ1RJVkVfTE9XPjsNCj4+ICsJCQlsaW51eCxjYW4tZGlzYWJsZTsNCj4+ICsJ
CQlsaW51eCxjb2RlID0gPEJUTl8wPjsNCj4+ICsJCX07DQo+PiArCX07DQo+PiArDQo+PiArCXJm
a2lsbC1tMi1nbnNzIHsNCj4+ICsJCWNvbXBhdGlibGUgPSAicmZraWxsLWdwaW8iOw0KPj4gKwkJ
bGFiZWwgPSAibS4yIEdOU1MiOw0KPj4gKwkJcmFkaW8tdHlwZSA9ICJncHMiOw0KPj4gKwkJLyog
cmZraWxsLWdwaW8gaW52ZXJ0cyBpbnRlcm5hbGx5ICovDQo+PiArCQlzaHV0ZG93bi1ncGlvcyA9
IDwmZXhwYW5kZXIwIDkgR1BJT19BQ1RJVkVfSElHSD47DQo+PiArCX07DQo+PiArDQo+PiArCS8q
IE0uMiBpcyBCLWtleWVkLCBzbyB3LWRpc2FibGUgaXMgZm9yIFdXQU4gKi8NCj4+ICsJcmZraWxs
LW0yLXd3YW4gew0KPj4gKwkJY29tcGF0aWJsZSA9ICJyZmtpbGwtZ3BpbyI7DQo+PiArCQlsYWJl
bCA9ICJtLjIgV1dBTiI7DQo+PiArCQlyYWRpby10eXBlID0gInd3YW4iOw0KPj4gKwkJLyogcmZr
aWxsLWdwaW8gaW52ZXJ0cyBpbnRlcm5hbGx5ICovDQo+PiArCQlzaHV0ZG93bi1ncGlvcyA9IDwm
ZXhwYW5kZXIwIDggR1BJT19BQ1RJVkVfSElHSD47DQo+PiArCX07DQo+PiArfTsNCj4+ICsNCj4+
ICsvKiBTUkRTICMzIC0gU0dNSUkgMUdFICovDQo+PiArJmNwMF9ldGgxIHsNCj4+ICsJcGh5ID0g
PCZwaHkxPjsNCj4+ICsJcGh5cyA9IDwmY3AwX2NvbXBoeTMgMT47DQo+PiArCXBoeS1tb2RlID0g
InNnbWlpIjsNCj4+ICsJc3RhdHVzID0gIm9rYXkiOw0KPj4gK307DQo+PiArDQo+PiArJmNwMF9l
dGgyX3BoeSB7DQo+PiArCS8qDQo+PiArCSAqIENvbmZpZ3VyZSBMRURzOg0KPj4gKwkgKiAtIExF
RFswXTogbGluay9hY3Rpdml0eTogT24vYmxpbmsgKGdyZWVuKQ0KPj4gKwkgKiAtIExFRFsxXTog
bGluayBpcyAxMDAvMTAwME1icHM6IE9uICh5ZWxsb3cpDQo+PiArCSAqIC0gTEVEWzJdOiBoaWdo
IGltcGVkYW5jZSAoZmxvYXRpbmcpDQo+PiArCSAqLw0KPj4gKwltYXJ2ZWxsLHJlZy1pbml0ID0g
PDMgMTYgMHhmMDAwIDB4MGE2MT47DQo+IFNvcnJ5LCBidXQgbm8uIExpc3QgdGhlIExFRHMgaW4g
dGhlIFBIWSBub2RlLCBhbmQgdGhleSBjYW4gdGhlbiBiZQ0KPiBjb250cm9sbGVkIHZpYSAvc3lz
L2NsYXNzL2xlZHMuDQpNYXkgSSBhc2sgbW9yZSBwcmVjaXNlbHkgdGhlIG1vdGl2YXRpb24/DQpE
b2VzIHRoaXMgcmVwbGFjZSB0aGUgcGh5J3MgYnVpbHRpbiBhdXRvbWF0aWMgbGVkIGNvbnRyb2w/
DQo+IGFyY2gvYXJtL2Jvb3QvZHRzL21hcnZlbGwvYXJtYWRhLTM3MC1yZC5kdHMgaXMgYW4gZXhh
bXBsZS4NCg0KSSB3aWxsIGludmVzdGlnYXRlIGl0Lg0KDQpNeSBtYWluIG1vdGl2YXRpb24gZm9y
IHR3ZWFraW5nIHRoZSBsZWQgY29udHJvbHMgd2FzIHRvIG1ha2UgdGhlbSBhbGwgY29uc2lzdGVu
dCBhY3Jvc3MgdGhlIHR3byBib2FyZHM6DQotIExFRHMgdW5kZXIgY29udHJvbCBvZiBQSFlzIG9u
IGNwdSBtZGlvIGJ1cw0KLSBMRURzIHVuZGVyIGNvbnRyb2wgb2YgZXRoZXJuZXQgc3dpdGNoIG9u
IG1kaW8gYnVzDQotIExFRHMgdW5kZXIgY29udHJvbCBvZiBldGhlcm5ldCBwaHkgb24gZXh0ZXJu
YWwgbWRpbyBidXMgYmVoaW5kIGV0aGVybmV0IHN3aXRjaA0KDQpJdCBsb29rcyBhcyBpZiB0aGUg
bWFydmVsbCBwaHkgZHJpdmVyIHN1cHBvcnRzIGxlZCBzdWJub2RlcywNClRoZSBzd2l0Y2ggZHJp
dmVyIGRvZXMgbm90Lg0KRmluYWxseSBvbmUgcGh5IGNhbiBvbmx5IGJlIHdyaXR0ZW4gdG8gYnV0
IG5vdCByZWFkLA0KdGhlIGNwdSBjYW4gbmV2ZXIga25vdyBpdHMgbGluayBzdGF0ZS4NCg0KU28g
SSBwcmVmZXIgKGZvciB0aGUgQ2xlYXJmb2cgUHJvKSBib2FyZCB0byBleHBsaWNpdGx5IHVzZSB0
aGUgcGh5cw0KYXV0b25vbW91cyBtYW5hZ2VtZW50IG9mIExFRHMuDQpJcyB0aGF0IHN0aWxsIHBv
c3NpYmxlIGlmIEkgYWRkZWQgbGVkIHN1Ym5vZGVzPw0KDQo=

