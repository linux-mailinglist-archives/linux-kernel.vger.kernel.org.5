Return-Path: <linux-kernel+bounces-72707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D9985B7B8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABE7828389E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD3560244;
	Tue, 20 Feb 2024 09:39:30 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2120.outbound.protection.partner.outlook.cn [139.219.17.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6945C5E0;
	Tue, 20 Feb 2024 09:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708421969; cv=fail; b=Gjb4BIA3zbe9bpYSc24DaDAB2JsUOMCeZ835rinMfQv6NgFKdNk3fL/n7tGaBBGj8JeDysSl9MK1QCj+HcsVYBInm/EE3YPXU/ZeHtbkXAB1nriygwr8M5BqKTthsqKkFerjGzPCoJyWYmBjAF0qDC2/4TtlBnRFo9yxCVjtNXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708421969; c=relaxed/simple;
	bh=2/VQC2nFF3zUAwmVR1wMEM0dTUPbaXu2BOO6lcFsXns=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FXGnwju8PIP+gQSkPiy6EVjazQv1l1d10CenP/Y2wcj5GCNzjK8nF2vDp5kRnbXCls8YwUZhJbQrdxxPToPQjt9ZL3V7w2Ue6gLmudnHjd5NSZFJFd7mfKW0c7T0tBqw9jMRfXNPd7rGdo3/s8Mlg9gEEpIwcvEMDzNsrMeaUNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DmXY7khqITbP+/h+8oenc7Hu+4gHNzMFCRK36Nk1xMSIOR5nHN4fbGZbj9tBaEZVT2Yx/otCsyrLmQgGec6Ka0d0AJPJt7tzUmpxNfd9/BpAo3vWAbG4cir+LvGmO5C6yxf2/nki2wOkuyk3S1TWOY/LumHdW4c/ugiWSlf6OJTZqK5yqN4v4GcUzWpZ0Em7sQQwRgnxTx9CSn5+2EWKsq4rUNO90A86AuVyfUzd16pWOGpZCyEWXe3rZvEc4jgcW8Oozkt0zsFTgnzmLhhfNEGjcXn7ZryDd/x+GFqRcusLbWZde+vCPwnoPrwu/2aghyCUYVUpjpaSCUw3qpiQUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2/VQC2nFF3zUAwmVR1wMEM0dTUPbaXu2BOO6lcFsXns=;
 b=mBDjS6LJj9M5jL5EyAAAVWXF25ri4xDnB+XtyKYqg4DULnCW6vPjK8DEcay9UtFUURRECy5agkaPL6nu2OjQNbF/zE+lRjHrTRMRRpUvzw85vvI9y7a+EsQoRdRY3nB45XqJRte/TK5Vkz+OqawhhhKp8L2emeleYlLjxt3k30h/i50gbXi/xXuiQyGO3PcZru65XJYEFirr06bR5/tHWU7MGKPdncAtjtHSCMbvgohpz33oldqU8OX2nkCKQgmz7cF8nWJeDy8h2lNJgQyK7Piq9cEd4ryuRVyCLFj7oagXHRUePjasigw6hd7LgCQNiYY2dsrIHYBkn/tXfkYvVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0800.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:24::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.47; Tue, 20 Feb
 2024 09:39:14 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::b0af:4c9d:2058:a344]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::b0af:4c9d:2058:a344%6])
 with mapi id 15.20.7249.041; Tue, 20 Feb 2024 09:39:14 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
CC: Leyfoon Tan <leyfoon.tan@starfivetech.com>, Jack Zhu
	<jack.zhu@starfivetech.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject:
 =?gb2312?B?u9i4tDogu9i4tDogW1BBVENIIHYyIDIvMl0gaXJxY2hpcDogQWRkIFN0YXJG?=
 =?gb2312?Q?ive_external_interrupt_controller?=
Thread-Topic:
 =?gb2312?B?u9i4tDogW1BBVENIIHYyIDIvMl0gaXJxY2hpcDogQWRkIFN0YXJGaXZlIGV4?=
 =?gb2312?Q?ternal_interrupt_controller?=
Thread-Index: AQHaU0FmkrIWOb3y5U2swetYFmXGFLEIEG4AgAdrmVCAA5upAIAAAOmg
Date: Tue, 20 Feb 2024 09:39:14 +0000
Message-ID:
 <SHXPR01MB06719FB406FAA201595028A8F250A@SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn>
References: <20240130055843.216342-1-changhuang.liang@starfivetech.com>
 <20240130055843.216342-3-changhuang.liang@starfivetech.com>
 <87cyt0ivn3.ffs@tglx>
 <SHXPR01MB0671BD046F6E3F3A215414A6F252A@SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn>
 <87o7cbiixp.ffs@tglx>
In-Reply-To: <87o7cbiixp.ffs@tglx>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SHXPR01MB0671:EE_|SHXPR01MB0800:EE_
x-ms-office365-filtering-correlation-id: 561fd347-3268-473a-f7b6-08dc31f7ccd8
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 9/e48PSw1um5HXUMJVUgLP1i7U/8dsdJyZZzawigsXXGlp3qc8EYsnXgVgo/Cti728TP6Am+bxpcyWB80DjQqGAgDIB3mTRD9G4mBHZMGgyOn3dMHCnVvUTkDsrZDZAkxVRoarsMpVIKHN/D18YuA2pTlI43I28ZlOjufr1BIJbrZ0W5qK6ThtYsTbrC/L68oownq42aiDrhb5e6fdiRNSq5+L+cTCnvjXKfifBdSx6vxfs9ehp1Pvq3wa6c4z48yKtrTxmGtJbnDG3I52n796UoSGC2T7iUJlH22FgukguLRKxtolpCvgR9aDaE1VDtjBcyJ7wFfJhDZLtu6xhiOOUfq81IhpDT0f48PmeQXsQA32bf/1k5KiZGbTce21NYZHYXt0B35crH+YKijiN+C/C+a+N7aZtIzSK2xqnxIylJB4Skxf6X1ruNCUdGDFIm61O6nzZD7VeAxMZkiHl7/ZytM3KI7nn2ShupYzUZ+Dhz21v7l9TOE7tKt/BaMNd2LKEABfB0+RpSxfGhWfPk+x3JvRehIbS2mwlij6IkGSQe4gqm0JdxHsBIqTmSbt7O
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?c3ZMemNFbWxIaXA0Q09RTjZQOW5IVzhLSzZtRHIzaFJ2NGVuUEFPZ1lreUJw?=
 =?gb2312?B?ak05SzlpNHNqOTl6eUswTGFlRzJBejFrbzIwejJEMFQ3RjBNd1QrL3RIT3Zq?=
 =?gb2312?B?TFdvMXhidVRFNE5JOHFkZFRTa0hhWlp1R2k5MFZnQkpvdjJTSm1kZlAyU3M0?=
 =?gb2312?B?c08xbDZpVVlqc1FJQ1dOZTJRKy9jYlR2NFVlTU84WGMwZ1QzdDR6S0Z0QUtF?=
 =?gb2312?B?Vk9VLzZEeGE0clR4SThVRVFRL09qRmdhTEgvZWYyUGRmOE9mLzdpM0dEUjhG?=
 =?gb2312?B?dTlnSWNsaHRpVUZoaU9kckxPamg4SlBiV08vMDlQbC8yckNaWk0vcWRDNHVP?=
 =?gb2312?B?MzU5QkhOeTB2SzdDdWdsQ2RscnBRY013aWpRUXllVVdFOERVZ2lGcHg1VHRE?=
 =?gb2312?B?Sk4ybjhlMzNqOW9nTTRiVklxTHRTb0dBVVJzZ2tzRkNMTXZjTzF6dk9iRnZ4?=
 =?gb2312?B?ZmoyTS9PSXhndkN5ZEJteUxzbGdLN1c1U285LzFsZ0VJVnZCcFlRQm9qMW5r?=
 =?gb2312?B?ZDJUYStsa2VwT1pKWS9teUhHdG9EaXZwcCtRUEw5Q2ZPd2Vaa2R0WlkycUxo?=
 =?gb2312?B?blRuYmxSTnZ5aldrZnpUdXZmYk1wUDR5K0ZtbUs0NDZ2ZDVnMFQrMURoVm5u?=
 =?gb2312?B?UU5ERmNqejdIZ1FYWnZkeWVlYTVYR3l0TXdsbkRteDdhMHdmUDY0aWU3YWNI?=
 =?gb2312?B?RzdLT3NxeHY2M3BSVElRNTRSUXNncWwvQUpQYTQ2RktyeGcrdWdweU9MTlo2?=
 =?gb2312?B?RFVaMlovSTNITWtUNEVhR3FiWG5vSU5ja2NwS3pLMU5GNFpGRWJ4NGhWRHp3?=
 =?gb2312?B?YWdsKzZSYzhEZ0tCY241eTRaR2FOdUJ3Mlgza1dGc0s0ZldiWEZOQWFuYVBR?=
 =?gb2312?B?R1E2UHJEOVNMMjJnZDlEL1JOL3gvR0h2Y0tUbktFSVhESzIzMEUrK2NjU0N1?=
 =?gb2312?B?Y0NORkpzRU9jdkw3ZXNYdWVmYW5MR2FZdUFpWEdQYVd1RGhrL3dTQ3U4cVlh?=
 =?gb2312?B?Vy9vdytzZVZXckt1MlpNUlpoSVB6UTRjUklFTE5RWmM3OENxMGc5VGZ6Snpu?=
 =?gb2312?B?d0UvalMxRWZHTlN3S0NHWFN4OUwrL3RtQmhmYVJzSkpGanRvUkpXdWtaUVRw?=
 =?gb2312?B?S3MwaXVsakFvU2NqaGx1V3k4b2NiMnZQSUdSL0Z0OENxNlhIVlRmK05LeVVE?=
 =?gb2312?B?ZSs4UUxrYUxlZDNES1BEVkpOWktaMkZvd0JLSGZ6Z0NIRzA1dDYydEFWaG9Y?=
 =?gb2312?B?UDY2Yy9NSEoxT0xyd0xTV1p5NktlTFN5MEMrb2dmZHFuRGR0SGwyRmZXTDVq?=
 =?gb2312?B?ckhSZllsSmxoR1M2enY4Z2luWFpBa0JLMXk4VEdKRWZJWURtTVU5M3ZuVEVo?=
 =?gb2312?B?aUI4SnZrOFA0SHZ0NWlGUmJHQUlrMnpVSmZ3TFBmRkN6aVZqb1UwUnczV1Jr?=
 =?gb2312?B?VWZqNzBFdDZJdUJ0SDZaTzNjQnV3elhCd3F2RXNlajBnOWpTUFlRdHVYMHVm?=
 =?gb2312?B?bmx0V1kvbjdjUkRRQjd5c1RzREJuUXIrVXpwRzV0R2tJVlNhcnhQaFViMnAz?=
 =?gb2312?B?TDhIaFpYSEhDV1ZROXdnUWx6VnYxYlBiUktHcGc2ZzV2cWVFWjlUeXgrMytP?=
 =?gb2312?B?aU1tck55S2JBSDc2aWovZGlsdDhwWXhCL28wekxDSUcxaVMvcGhNcit5aWN4?=
 =?gb2312?B?NnBnRXdKYy9aRHh5VHdNZnJIUlNVK1JvL1RwTERXMzdiVmJLRERnSERYSDlY?=
 =?gb2312?B?ZEZnN3crb2FiUDJxY3BndHExZGd3SlFpczd5VXJwekI5aE9VZG9IVnF5dStU?=
 =?gb2312?B?d0tHSUpPY25UN0lWUzg3UmhXbUV4cHJJbitGV1g3d2lzSjQxT1dEK0RMa1Z6?=
 =?gb2312?B?ZEpieStKbCtRWW8zbzZyRU1LQ0xUbFlDV1N0ZWZjWW1NN0l4T1phT3VETkRj?=
 =?gb2312?B?MkpuSVhmTmkydUF3QitnRWR4NitRZEp6SWZFVTBYWXU1ZjQrV0orSnFpWnpy?=
 =?gb2312?B?M3FaR2NZalpTdlRra2FSeDYzb2RCWnk0dFN4QnpsZDVFcHlFeUMyc3FKdEg0?=
 =?gb2312?B?Z1NVM0RqaGl1QnIxN1hOc0w3WFdOMFNpVU5HTjVvWmRxcTlnWDFLRm1RYVBR?=
 =?gb2312?B?OVpCbnUvMG8rcnZiVEFoTWVkWi9ZSzgyNUhmdHhaUVJYSDVhMFE2UVI2L2Ju?=
 =?gb2312?B?S3c9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 561fd347-3268-473a-f7b6-08dc31f7ccd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2024 09:39:14.2959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H1zP0Y7XwNNSUoPKwuITIDH434dAgdpO1LmFXfoLrTp7vmWNk1Gulc0mrODSxLd8lEtTODi+Y8hjFmo3/gDi5FOVDscn4OoymU4qt3Mv0SfqeimauWk1sTjppKIB8Ufd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0800

SGksIFRob21hcw0KDQo+IC0tLS0t08q8/tStvP4tLS0tLQ0KPiC3orz+yMs6IFRob21hcyBHbGVp
eG5lciA8dGdseEBsaW51dHJvbml4LmRlPg0KPiC3osvNyrG85DogMjAyNMTqMtTCMjDI1SAxNzoy
OA0KPiDK1bz+yMs6IENoYW5naHVhbmcgTGlhbmcgPGNoYW5naHVhbmcubGlhbmdAc3RhcmZpdmV0
ZWNoLmNvbT47IFJvYg0KPiBIZXJyaW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+OyBLcnp5c3p0b2Yg
S296bG93c2tpDQo+IDxrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc+OyBDb25vciBE
b29sZXkgPGNvbm9yK2R0QGtlcm5lbC5vcmc+Ow0KPiBQaGlsaXBwIFphYmVsIDxwLnphYmVsQHBl
bmd1dHJvbml4LmRlPg0KPiCzrcvNOiBMZXlmb29uIFRhbiA8bGV5Zm9vbi50YW5Ac3RhcmZpdmV0
ZWNoLmNvbT47IEphY2sgWmh1DQo+IDxqYWNrLnpodUBzdGFyZml2ZXRlY2guY29tPjsgbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcNCj4g
1vfM4jogUmU6ILvYuLQ6IFtQQVRDSCB2MiAyLzJdIGlycWNoaXA6IEFkZCBTdGFyRml2ZSBleHRl
cm5hbCBpbnRlcnJ1cHQNCj4gY29udHJvbGxlcg0KPiANCj4gT24gU3VuLCBGZWIgMTggMjAyNCBh
dCAwMjozNiwgQ2hhbmdodWFuZyBMaWFuZyB3cm90ZToNCj4gPj4gT24gTW9uLCBKYW4gMjkgMjAy
NCBhdCAyMTo1OCwgQ2hhbmdodWFuZyBMaWFuZyB3cm90ZToNCj4gPiBbLi4uXQ0KPiA+PiA+ICtz
dGF0aWMgdm9pZCBzdGFyZml2ZV9pbnRjX21vZChzdHJ1Y3Qgc3RhcmZpdmVfaXJxX2NoaXAgKmly
cWMsIHUzMg0KPiA+PiA+ICtyZWcsIHUzMiBtYXNrLCB1MzIgZGF0YSkgew0KPiA+PiA+ICsJdTMy
IHZhbHVlOw0KPiA+PiA+ICsNCj4gPj4gPiArCXZhbHVlID0gaW9yZWFkMzIoaXJxYy0+YmFzZSAr
IHJlZykgJiB+bWFzazsNCj4gPj4gPiArCWRhdGEgJj0gbWFzazsNCj4gPj4NCj4gPj4gV2h5Pw0K
PiA+Pg0KPiA+DQo+ID4gSWYgSSB3YW50IHRvIHVwZGF0ZSB0aGUgcmVnICBHRU5NQVNLKDcsIDQp
ICB0byB2YWx1ZSA1LCB0aGUgZGF0YSBJDQo+ID4gd2lsbCBwYXNzIGluIDUgPDwgNA0KPiANCj4g
QWxsIGNhbGwgc2l0ZXMgcGFzcyBhIHNpbmdsZSBiaXQgdG8gc2V0L2NsZWFyLCByaWdodD8gU28g
dGhpcyBHRU5NQVNLIGFyZ3VtZW50DQo+IGRvZXMgbm90IG1ha2Ugc2Vuc2UgYXQgYWxsLg0KPiAN
Cg0KWWVzLCBJIHdpbGwgdXBkYXRlIHRoaXMgZnVuY3Rpb24NCg==

