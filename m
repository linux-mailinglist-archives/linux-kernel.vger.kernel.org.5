Return-Path: <linux-kernel+bounces-136121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E9189D035
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 04:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F26C8284D17
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 02:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38A04F1EB;
	Tue,  9 Apr 2024 02:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="wb3m50+l"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2106.outbound.protection.outlook.com [40.107.96.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9B54EB2B;
	Tue,  9 Apr 2024 02:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712628339; cv=fail; b=P506OdYX5XB6/X1uE12uKbYzQpkSyfcV9Xr1ECpjpKlkX4aI1SBjpLEe9ZLQ7L1HM8l3FjYZuyy/0ax3nua3gD6gbt+3YuECdWp+BjxL8x4bsMmq4HebR0FRPfe509QJ0/rNo+sjqCcw5selN2A1ycynuinknRpbgQp43pxjHQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712628339; c=relaxed/simple;
	bh=5iusDoVIGyO78UZ1DhR3u1RGJzrezuakAQWT4BgBQtQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MO83lnWsdDbkLQWti7yQCDddxUF9qhm74BSWxENJq4wWzCRFhyurv+s8lNUHJFbzR+DRVdVFYbiMu4QcHbJ3xtyBtbI1QMhNOrgJnYmzODNYqn1I/tTbWNRoCmeJB/S0qOfYaxWMoyHT/dnBrqSLpkfuB0G7GXs/dHlu5uzDoLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com; spf=pass smtp.mailfrom=corigine.com; dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b=wb3m50+l; arc=fail smtp.client-ip=40.107.96.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corigine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mqVq+//OyoqNG1zoDKikYftbWuhMSIzwY0zO3sjhDMAPuhmhX7IhAnyZmEq4JPfvZPg9txdzlSG+f+kjw2P2Ro0e0Fzi5ifIvAjyH2dFFY7ycY4c3sBU5wS9bdE3zzGUWQPS4GjW3smxrZyVB7p2/ejV9Mmx4eZ1AAzdWvCLF7mLPIhn4c/+m7qZEqLZO/BF4ioqYX1cYeh3fPgWfh4UFEWczMKOOvjBroTLWL570smJAa9gsI2pTsTcvz4QQtbV8bCzmIa2exlFyiDCXb4suwtDn/Q2RyvRqLZ6mr0UbML66NDEqgA07MeinD/cZw2sUjmzlnavqVxnkojiCzdE4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5iusDoVIGyO78UZ1DhR3u1RGJzrezuakAQWT4BgBQtQ=;
 b=WaHiIP6YM2GZ+G6jvjUeRz8ppE07vIZ5ahWNYykG6QpXHojAGG0K7GNeFNEZ/aGl7phqJRdN7QbmzB/AWUtQaEtDWbtfDiHpEU853RqKdoKY2gGCSztKUH/Jfe6VWboxkRi83GTAa0QfDWy76yUEc3IqeaqtTnIiGGh6wXQycxQApzFxteqkwqNw81jjqZqk11ImgUdf0QLwg/A4p7eHX9TLzs/ei2SMEaAFFZHS6ewijtjKOcenrurswXfzckslbP8CQCAT8EvHa3G7BQ1grnvcdnATDmir50e8JMYyQxPkgO9cEshXFvUKK9Tk6iaWdJ5V1RBQrvFQhmzxEkmFpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5iusDoVIGyO78UZ1DhR3u1RGJzrezuakAQWT4BgBQtQ=;
 b=wb3m50+lOhuD7qewSSzIRAuSoj8yXMG774hRGHTbWqVbVZys9sCwEatlOmYqM4pqs4yAUKhRTkNzJOG3ZkAfKC5g/TVaRITsjaIO8h3rYzntJ/GPzK8epNyic0C8Eo2XnsWukC9GWhPrhsK06yBmqm69wh3L/gjkbJhAth9tDdM=
Received: from DM4PR13MB5882.namprd13.prod.outlook.com (2603:10b6:8:4d::13) by
 PH7PR13MB5478.namprd13.prod.outlook.com (2603:10b6:510:130::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 02:05:34 +0000
Received: from DM4PR13MB5882.namprd13.prod.outlook.com
 ([fe80::5e89:b434:88dd:50a]) by DM4PR13MB5882.namprd13.prod.outlook.com
 ([fe80::5e89:b434:88dd:50a%3]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 02:05:27 +0000
From: Baowen Zheng <baowen.zheng@corigine.com>
To: =?utf-8?B?QXNiasO4cm4gU2xvdGggVMO4bm5lc2Vu?= <ast@fiberby.net>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Louis Peens
	<louis.peens@corigine.com>, Taras Chornyi <taras.chornyi@plvision.eu>,
	Woojung Huh <woojung.huh@microchip.com>, "UNGLinuxDriver@microchip.com"
	<UNGLinuxDriver@microchip.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Yanguo Li
	<yanguo.li@nephogine.com>, oss-drivers <oss-drivers@corigine.com>, Andrew
 Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Vladimir
 Oltean <olteanv@gmail.com>, Edward Cree <ecree.xilinx@gmail.com>, Jamal Hadi
 Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
	<jiri@resnulli.us>
Subject: RE: [PATCH net-next 1/6] flow_offload: add
 flow_rule_no_unsupp_control_flags()
Thread-Topic: [PATCH net-next 1/6] flow_offload: add
 flow_rule_no_unsupp_control_flags()
Thread-Index: AQHaibYrsvBECEUwwku93UrztVy9A7FfMJ4g
Date: Tue, 9 Apr 2024 02:05:26 +0000
Message-ID:
 <DM4PR13MB5882CFB977ACCBB06DFCDE40E7072@DM4PR13MB5882.namprd13.prod.outlook.com>
References: <20240408130927.78594-1-ast@fiberby.net>
 <20240408130927.78594-2-ast@fiberby.net>
In-Reply-To: <20240408130927.78594-2-ast@fiberby.net>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR13MB5882:EE_|PH7PR13MB5478:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ZBKqnK+3b0u3N/H3aj2Hv17EcTv/Hyhvv6HcSahth2fsgk2txr/Vis1M75vR7LX4cKl6qY1eexCTgI/M3DRMaBy212WMkwx6gp9bAlSnm5p6P3TwvMj6ljABUlpv4tVxAK87W+BgXNrWxV6xKRFT2uDHH2yq7HFnh18+hCN3Bb8GeF0+NCiT+XO49QT/JZfEsZmKjuJwDnPntrdMG4O0d/RyERvLlC2jC/2ZBm7iakqUKJbAhYfl15vy+ITjoG6bViLqih+ez+En7KDFvleScShH1j6qjUNOJiXdBEnNp89Qk70RcGBTPZ5/B0YrMPEnU5x2tT7jyQnAjjNgudt536lUKgWfJx3XP+kiwLupDqud4IoK/mHdJCWAzjq/sJxdp64mbDhqvIKNVB/Th8rKdqLN7pv2bsBtqvBjibnehEB87DwOa37u2E/lg461FhENNGGRRLC77xEsc/iIoLXXWhzsjKR/ixwCw5DKSYfFZv6sIpKWLno/7nzP3LV6mzogdErTgeFZsXgclZ/9QLZqecYoIZvmgaS092KxCUL379BiXvuIwaUCzsjiUZp/+w/nMwpgTMPDPsUQ5l4nBrh8FI4Yiplp92gN7fLyzE6WV95Oka18SuBjY5gfh6TLYUQhdt4Qsdo/7kRbV2bsNuEESmF0t7V65quq/oDSVgS5ITc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR13MB5882.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a0dGeXNuMlJ2RHlPbUZMZzdDWDVkeUhDTnFsdjQvazNwbFY5S01wVGdMcE5j?=
 =?utf-8?B?OTh6Q1FVUk94VVdlYkg3QVFCTGFoSmpWdGk2YjZmRVVBVGUyQnB6NEwwcmFN?=
 =?utf-8?B?QnhnZjF5VDRkL0xCZ29rbDB6ZWN4d2xMTldDK1VLNlNoSDRHb2gxODk3SDZJ?=
 =?utf-8?B?RlQ1eDl0MlUxK0d3dHdvWi81UHVLck4vRC9sNDdwR0hqM3pQZ0htNVRsdjg0?=
 =?utf-8?B?TThzT0ZGem1MOGJLN2kyL2tEVE94SUxZS1dKYzBOS0dXVFY3OGJHV0tJMlh0?=
 =?utf-8?B?bUhEb2xzT3RGc3ZqNnozZUFxM2tFRjUwVXowNlhVbk5TMjVYNDlPTHdqQ2dT?=
 =?utf-8?B?dkVyOGNsNFJFZmNuUWcxc0t1Wk0yT2EyZWZQOHBQRVg4RXpEYTltYXZqazdM?=
 =?utf-8?B?Z3RYcW0rK2orWnhya3lhREV1RjlRRWNoaUhnSk1qdy9rWlpCbVBBamN3cnBX?=
 =?utf-8?B?WWh0eCtZTmZGSk5JdVd5Nk9TVzA4a0R2ZlBQRFEvTjZwSGhHcGhlcDhJS3gw?=
 =?utf-8?B?NGV1SUFmTGJ0L3d3a1ZiUTBQYmppMExidGllU1Y4MGh1RUV0bmdOUGtaR1Zt?=
 =?utf-8?B?SFVDMjg2aGoxdnZzSUhsWHNkMW5YanRlUHppMVovdGVrQkR2YUorZlNBVFFX?=
 =?utf-8?B?VzYwVEZGd2VkdkhqQVlOeEVtZ2hVSmNYREwrU1N3akxyVkxMd003YlAzd09h?=
 =?utf-8?B?emMySVVUZm1FNTlWK0M4QU9va1ZKTllBMkRobjhIQXdkT1ltbXNPemV6WG9O?=
 =?utf-8?B?cEVmV2Zuc3NRMS9YS0ZXb01FUFV1TEgzTTBvZktRR2VqTzNHcXpBMXV1YSsr?=
 =?utf-8?B?SDFWb3VQR0FwQmVWL1pkRHJPNzd2dTU0bkRiM3V0RVhBZUVHdGJNTmtnSmVC?=
 =?utf-8?B?aTl2cVFwUEttRW5Lekk1N0w5eDRPYk5tbjB4dkRTNHJzKzJYZFFlcWI2WThW?=
 =?utf-8?B?QUlva2N1OUZVTkpJb2d0eGNWM1RwYW1majE3aXA3aEMvdksvZVhwZmorREgz?=
 =?utf-8?B?bUx2M1NhM0ZxZnlreUdCT3pZdVp1Yy9STG1QQ25Rb0dReTdjSDZQZXAyN2VK?=
 =?utf-8?B?SkhjMGJJcTcrbll1QmsyK2ltNUZzaHJpc3VtUitDZDU5WngrQ1Rja2tqWGsr?=
 =?utf-8?B?OTlnQlBIejJEazVOaTVCSnE1Y25kaVJyYTdlczZIYnFPVXlSdmZyb1R4ZGNv?=
 =?utf-8?B?ZGhuelVZK05Fd1RYajZtNnZsR1l0OExoKzVzZ0FXMUJUc2l4bnNiM2ZINGdO?=
 =?utf-8?B?ektiRW4xZG5vbGNuclBqTUpoejN1RDRJN29Kei9VQ2xxcGJBa25wTkJEa01Y?=
 =?utf-8?B?d3VyK294dVlVZFgxOUh3UnBHWURjY0ZLSWJWaWh3WHhWdGhqakJ0YXp0LzE0?=
 =?utf-8?B?dVRGY0plcE1Mb2tmUFRuZ3NpTG1JOFF4OVZ6dCtBRHFvQzdiQmlGNWkzSXN5?=
 =?utf-8?B?NllCZnN3a0llNW52TGhlNXlGQnBvTUxFWVYrQVVIS1FVZVh2RnpUTVM4R0Fi?=
 =?utf-8?B?VFFrL2NMcDNyUm1GYWgvd0JMU0VtaVpSRTFzbHFTcWZRVFNHOWYxYlc4U3Qx?=
 =?utf-8?B?U3JkdmJMVWprSmJQT0l1UjNFdlIwREN5OWtsQWZuVXhsN1lJZm1ER0hCUDJQ?=
 =?utf-8?B?MmV2WmxNZzdTeHhTTGlZOVZuUWtrTzBzU2dZS3c2cHpRR2FrQURyZHJZVmNX?=
 =?utf-8?B?NENGRjUwT0FIVVJQeExMQ2NSTXRFSU9tdmUzaUJuUmNEclJVOXU5YmR1eVg1?=
 =?utf-8?B?cTBGTWwyV0h3QTJ0YmNUTUpvamZvc3EzUE1PN2ZtT1FOVG9jUUE0Nk9yRG1M?=
 =?utf-8?B?eW8ySzNMOFlGWWMzb1ErQzdFcmR2SlRLRVhkcXdFZkdtU3EvUGc5Si9pSEJl?=
 =?utf-8?B?QU0xN01Qb3dNQU9KenA3Tld1bGg4Ry9ZWXBJUGZrZllpcndkaENxVENXbnVx?=
 =?utf-8?B?dktHakE5c1JtYWNsVWNubWpSUzRtWWtSdjZhMDFNU3c4ODNpRGhqMGsxV3Zn?=
 =?utf-8?B?ZDZEVVlpNU1ld2Vmd0FuUzRYWGZuRlF6SXdoU2dFNzdIbHZGNUxLZVpja0lK?=
 =?utf-8?B?SlB0ajI4VlliM0lPMjhzc3F4ZWxmYkVrQ2lIN0FlNVpnRUNwclExdVFiYmJm?=
 =?utf-8?Q?rQoPVnu3/yqOKp3Zs7F6uaA6W?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR13MB5882.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 898fe55d-a1b0-4653-cc24-08dc58398650
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2024 02:05:26.9432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AuI4KXt68yFjst5Ki8end/7gxeLEOrvQv6z5ZLZIPtFRkHPxTZaFkdvBUUR8f5rBXjw6aWYfZaHZP9hUllFvlAe+YGIA3msXq7u0F+EByss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR13MB5478

T24gQXByaWwgOCwgMjAyNCA5OjA5IFBNLCBBc2Jqw7hybiB3cm90ZToNCg0KPmZsb3dfcnVsZV9u
b191bnN1cHBfY29udHJvbF9mbGFncygpDQo+DQo+W1NvbWUgcGVvcGxlIHdobyByZWNlaXZlZCB0
aGlzIG1lc3NhZ2UgZG9uJ3Qgb2Z0ZW4gZ2V0IGVtYWlsIGZyb20NCj5hc3RAZmliZXJieS5uZXQu
IExlYXJuIHdoeSB0aGlzIGlzIGltcG9ydGFudCBhdA0KPmh0dHBzOi8vYWthLm1zL0xlYXJuQWJv
dXRTZW5kZXJJZGVudGlmaWNhdGlvbiBdDQo+DQo+VGhpcyBoZWxwZXIgY2FuIGJlIHVzZWQgYnkg
ZHJpdmVycyB0byBjaGVjayBmb3IgdGhlIHByZXNlbmNlIG9mIHVuc3VwcG9ydGVkDQo+Y29udHJv
bCBmbGFncy4NCj4NCj5JdCBtaXJyb3JzIHRoZSBleGlzdGluZyBjaGVjayBkb25lIGluIHNmYzoN
Cj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L3NmYy90Yy5jICsyNzYNCj4NCj5UaGlzIGlzIGFpbWVk
IGF0IGRyaXZlcnMsIHdoaWNoIGltcGxlbWVudHMgc29tZSBjb250cm9sIGZsYWdzLg0KPg0KPlRo
aXMgc2hvdWxkIGFsc28gYmUgdXNlZCBieSBkcml2ZXJzIHRoYXQgaW1wbGVtZW50IGFsbCBjdXJy
ZW50IGZsYWdzLCBzbyB0aGF0DQo+ZnV0dXJlIGZsYWdzIHdpbGwgYmUgdW5zdXBwb3J0ZWQgYnkg
ZGVmYXVsdC4NCj4NCj5Pbmx5IGNvbXBpbGUtdGVzdGVkLg0KPg0KPlNpZ25lZC1vZmYtYnk6IEFz
YmrDuHJuIFNsb3RoIFTDuG5uZXNlbiA8YXN0QGZpYmVyYnkubmV0Pg0KPi0tLQ0KPiBpbmNsdWRl
L25ldC9mbG93X29mZmxvYWQuaCB8IDIyICsrKysrKysrKysrKysrKysrKysrKysNCj4gMSBmaWxl
IGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKykNCj4NCj5kaWZmIC0tZ2l0IGEvaW5jbHVkZS9uZXQv
Zmxvd19vZmZsb2FkLmggYi9pbmNsdWRlL25ldC9mbG93X29mZmxvYWQuaCBpbmRleA0KPjMxNDA4
N2E1ZTE4MTguLmMxMzE3YjE0ZGEwOGMgMTAwNjQ0DQo+LS0tIGEvaW5jbHVkZS9uZXQvZmxvd19v
ZmZsb2FkLmgNCj4rKysgYi9pbmNsdWRlL25ldC9mbG93X29mZmxvYWQuaA0KPkBAIC00NDksNiAr
NDQ5LDI4IEBAIHN0YXRpYyBpbmxpbmUgYm9vbCBmbG93X3J1bGVfbWF0Y2hfa2V5KGNvbnN0IHN0
cnVjdA0KPmZsb3dfcnVsZSAqcnVsZSwNCj4gICAgICAgIHJldHVybiBkaXNzZWN0b3JfdXNlc19r
ZXkocnVsZS0+bWF0Y2guZGlzc2VjdG9yLCBrZXkpOyAgfQ0KPg0KPisvKioNCj4rICogZmxvd19y
dWxlX25vX3Vuc3VwcF9jb250cm9sX2ZsYWdzKCkgLSBjaGVjayBmb3IgdW5zdXBwb3J0ZWQgY29u
dHJvbA0KPitmbGFncw0KPisgKiBAc3VwcF9mbGFnczogZmxhZ3Mgc3VwcG9ydGVkIGJ5IGRyaXZl
cg0KPisgKiBAZmxhZ3M6IGZsYWdzIHByZXNlbnQgaW4gcnVsZQ0KPisgKiBAZXh0YWNrOiBUaGUg
bmV0bGluayBleHRlbmRlZCBBQ0sgZm9yIHJlcG9ydGluZyBlcnJvcnMuDQo+KyAqDQo+KyAqIFJl
dHVybnMgdHJ1ZSBpZiBvbmx5IHN1cHBvcnRlZCBjb250cm9sIGZsYWdzIGFyZSBzZXQsIGZhbHNl
IG90aGVyd2lzZS4NCj4rICovDQo+K3N0YXRpYyBpbmxpbmUgYm9vbCBmbG93X3J1bGVfbm9fdW5z
dXBwX2NvbnRyb2xfZmxhZ3MoY29uc3QgdTMyIHN1cHBfZmxhZ3MsDQo+KyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCB1MzIgZmxhZ3MsDQo+
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1
Y3QNCj4rbmV0bGlua19leHRfYWNrICpleHRhY2spIHsNCj4rICAgICAgIGlmIChsaWtlbHkoKGZs
YWdzICYgfnN1cHBfZmxhZ3MpID09IDApKQ0KPisgICAgICAgICAgICAgICByZXR1cm4gdHJ1ZTsN
Cj4rDQo+KyAgICAgICBOTF9TRVRfRVJSX01TR19GTVRfTU9EKGV4dGFjaywNCj4rICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIlVuc3VwcG9ydGVkIG1hdGNoIG9uIGNvbnRyb2wuZmxhZ3Mg
JSN4IiwNCj4rICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZmxhZ3MpOw0KPisNCj4rICAg
ICAgIHJldHVybiBmYWxzZTsNCj4rfQ0KSG93IGFib3V0IHRvIHNxdWFzaCB0aGlzIGNoYW5nZSB3
aXRoIHNlcmllcyBJIHBhdGNoIHNpbmNlIHRoZXkgaGF2ZSBzaW1pbGFyIGZ1bmN0aW9ucyBmb3Ig
ZHJpdmVyIHRvIHVzZS4NCj4rDQo+IHN0cnVjdCBmbG93X3N0YXRzIHsNCj4gICAgICAgIHU2NCAg
ICAgcGt0czsNCj4gICAgICAgIHU2NCAgICAgYnl0ZXM7DQo+LS0NCj4yLjQzLjANCg0K

