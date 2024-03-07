Return-Path: <linux-kernel+bounces-94856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 204988745F9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C1B8B20EB3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 02:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A2963B8;
	Thu,  7 Mar 2024 02:13:56 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2109.outbound.protection.partner.outlook.cn [139.219.146.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC83CA62;
	Thu,  7 Mar 2024 02:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709777636; cv=fail; b=UU8ttrg7umDN+PZ+YfBLfdl9qUKQvRk3jhGOCfmvPVL1uPhjLspEgfpnA3MwChA2/InseEAg1PxdU9ahbvHvqjYzdfVx8muo4XtNEitxZVHAfxG/LDk27Un8TspCRTv7c475/Moun9Cr5xsX9+cJ/oXG2+uvOmfhwAZgtrDDiMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709777636; c=relaxed/simple;
	bh=vEZA6prvXV+DiXLc5NkAwOzuHjv8RcNY5a62D7Xjlk4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hPySKxo0LgGvjrl4cJREOI5B76HoLU+1xRq1jVru5v/DrfIMn/muvE1NkEe9JnFYLQtu4mgkQX3YtW9Zn5ZKmpPWVA3ULYH0/IFtd09vueBjtKAQmDDzRyvensqvujoKLoHhMKLyP0ZTwHvkzRSRMSg6hYcHbcuTmLD4QFGd+1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMTU8tycFDGkpVKRhd9s/LNcLeXo3VmvuRNPrIEayfqh6luCM/4RScKHDA1edbgoIZdd6aki4VI5HwcvT5PwbTjZ5jiz5H/LAWVpmTB8SPtMJ43ms8V0kyvoCmbWqZDnNt5yCGD3IJqBMO6w4fPXJfVnCSQ5VwndVuzURmHpwMsRi2RnxC9dGNf7rmWOElOzY7OzqVbmGuTPtJRri1BTsFgIYjNLcBimSvCKZifzDJhT7jgeBMA/W3PQdTGMoqyk/613HXpRW/sa7u22EwozqQhnKMQGTIW57UoZJdZbnMGEF1IufjhYM1XDRbo/rpdhWa3/bINqy4Ub2QAuRtPyug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vEZA6prvXV+DiXLc5NkAwOzuHjv8RcNY5a62D7Xjlk4=;
 b=MwjNAzGPTpM5ak9FINPaX44CDn3LJ25UUI8C7o05vfqPIb15aLy1qSrNElV6Xw0cY7jfTkbB8nEZH3NPd4D6VRloAPZ4AYaNDe2ZdxBkr8Evg0GdPue2zQwhERmEXh3gN8DU5DasT4vxu/ppsxPjNbzDPyqAGEIVGXxtxkoCDYq/G/tGb/+4ve+Xwjrpf7JexMUCkcBF4fHyEuA7m3sEUUvXkWwrKA/AHvTplCUwsK1NiQVyuHHtTeUSc2VnOv/9tftm17XxAT5LsVQvzZRJ/yGkNseAvjuuqCCBNQFYDeNjP0AvEuE1LIT4dGbAg3kZyboVHAhKNx7Yt8cfa4NSTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0622.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.53; Thu, 7 Mar
 2024 02:13:50 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::b0af:4c9d:2058:a344]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::b0af:4c9d:2058:a344%6])
 with mapi id 15.20.7249.041; Thu, 7 Mar 2024 02:13:50 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Mauro Carvalho Chehab <mchehab@kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Jack Zhu
	<jack.zhu@starfivetech.com>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-staging@lists.linux.dev"
	<linux-staging@lists.linux.dev>
Subject:
 =?gb2312?B?u9i4tDogW1BBVENIIHYxIDUvN10gc3RhZ2luZzogbWVkaWE6IHN0YXJmaXZl?=
 =?gb2312?Q?:_Add_ISP_raw_video_device?=
Thread-Topic: [PATCH v1 5/7] staging: media: starfive: Add ISP raw video
 device
Thread-Index: AQHab6lkX7mvNt8JaUeLNcMpoLLCUrEqxR+AgADEU5A=
Date: Thu, 7 Mar 2024 02:13:50 +0000
Message-ID:
 <SHXPR01MB06715A4810E596B068029472F220A@SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn>
References: <20240306093334.9321-1-changhuang.liang@starfivetech.com>
 <20240306093334.9321-6-changhuang.liang@starfivetech.com>
 <c474bd8f-6c23-4536-a915-efbc197a223e@moroto.mountain>
In-Reply-To: <c474bd8f-6c23-4536-a915-efbc197a223e@moroto.mountain>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SHXPR01MB0671:EE_|SHXPR01MB0622:EE_
x-ms-office365-filtering-correlation-id: db55a151-bd9d-4ea9-c6de-08dc3e4c3afc
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 tTV2zST40FJrLbhxew8BZvRJfWDj0zbYXIorvMvoixpY3XBD1ak3dj/fiX7W5B8j4x2OS1UNrs6Mau+usL3qAqVy653FWBx71TX2fqo4H2DGENwdJ6m2lG82GcIEcufQGIkNIRicilwDa0zW1Jb2M3sLdEv7F6a2fRPHdeYcFjKgXhSqFJx7kC1bwuzs8wZ4j2XDbiZcz3hhM/9UQUyxo8cVaCn/il0dA3yjWfxzQEIGq9mZ/xymedVSarBKFINI9wYc3VIA5LiVUHdZN3bj05WQUUdFFwVZOdr/+DxsHwT549RbGbT/54jaXenNy8//qg3l6yw2annTU9Plfo1T/hqC8V0Z2oD0VbCiKE3REM/715lSyQZ/6Pu6Risa8Q7zpibV1+3EH69qTK5fd5QzTqCVO+Ve5Bym+ooWBd7c0CXzYu2ZYA+YaS52lgYBPJsB3+uPx/jG+gvhOAM3knP/xEM+X8Ytt3aNcyEghtmgZQ/d2NtSJGRZgOE10glvN9YC2jQpX4Euk7L4aSOUIoAbS27WAyv/MFqFBpBbblB+SRx0OwnbTKeEOGSj7C7FX7gPFJdRvtrercUFDvC9OjrltRy2iInAUl1ojqVG6XizvVXM4RNHFKCwAg9tl3Z0OEz/
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?OEx5NWFLMjVIcDZnSVVEK1lEalJIVG9vNldMdFgvZ3Zaa1BTRmpncUNBYzE4?=
 =?gb2312?B?czBXSTdJUlJKMHhwaVZ6bGY5L09OSU5NV3NwbWZoK09rMGh3QktJdGNGVTZh?=
 =?gb2312?B?MXVDM2pQYlBZZVgwbmJEbC9Fc2NyaVVvZFpXRkJKaEtvTS9pOXBjMkI5YitE?=
 =?gb2312?B?bk1pVlZrYWZxWWZOdWpob0xQS0p4Y0JOY1BUUmZtU3NsYzNVR2lrSFNqcEJD?=
 =?gb2312?B?a3lVbkpMeG1vRGlNZENXQ1FhbnpWN0hhM1ZRUGg0YXMvKzBYUG1EZU9rSlhG?=
 =?gb2312?B?WlRkQnZLaVRKMTBDTmtsMWhwUEkyeFlMU09PS3ovQm9sNGcxS2ZIbFpnVTVS?=
 =?gb2312?B?cm90ZnR4OFlXYXk5UWJJdzJvaW83YU50cTFwK1hGK0ZNbHduazZ5WHJLdjZ4?=
 =?gb2312?B?TnlDUUR1cXhVOHBJS3NWdU1RcFFibk1jK1VyUTFPRzR5NFdsWmhwekd3ZEFt?=
 =?gb2312?B?cjd0eTRENC9DL3JuRUZmdnh6YXVYcFF3ZlgzQ1Q5MUN6L0diUEw2eXFUS3lO?=
 =?gb2312?B?WjJSMVgzSU1icWQrV3F4cDc3L0FaZ0NUOU1nSk04UFQyWkppOWd4K2d0VFVI?=
 =?gb2312?B?VlFQc0lzODBzQzBCeFhOb2E1VTVjZU1lMXRvWWJONFVIOFo2dzBDQlBtWlhZ?=
 =?gb2312?B?QzJUdVB4Q1FWbnRFUGVlVXJPMWI5eHMxZ2VNWnF3QU05V2UybmMxYmFmTmxn?=
 =?gb2312?B?OHI1SnovSXd3Qzgwd0plSmtybTNsOTQrN1kwOWFRb1dEY1kzaHllbGNwVUlS?=
 =?gb2312?B?djYzVVZZN1lrOHRyR2hvMG5GV0ppTm0wVFhZdk9MQ2M0d0J5VXJ2aTZBK2w3?=
 =?gb2312?B?MFZxOUZvZkJYWFhEYlltaUNFNnlBM3JRb3p1RHdwVUo0aGdvUDVlMG9qZDdp?=
 =?gb2312?B?cVVLNHhCOCt2d1Y1NlBkRmhUY2JoSDlNdWNtOFVlRFo4enl1bW92WHRxT3Ro?=
 =?gb2312?B?QnRBeWlDT2pMYTFCVWNsY0QvT2tjVEdwOFFhVzdGMWRKdjE5UmFXQmFoSm5s?=
 =?gb2312?B?a3pPcFAyNHJWVTZ5M0lGQjZqS3hOcTI4aHBNbWFMNnNxVjlmbTA3WVhKN2p3?=
 =?gb2312?B?K21YUExBVnNxYlpiUHZRanREcXB5cW13V1FHcUM1UHdQZFZoZlRhb25ZSW5s?=
 =?gb2312?B?ZEluSXE1ditpS2Q2UXZWcHA5M2h1aFo2L0p4bzl3MVF0YS9wVHIyK00yeWNx?=
 =?gb2312?B?MkQraGxGNWpuQnVKL2p0RC9SempkVmNmQ01RYzJhTHpxR0NLM1FFYUxvZTRZ?=
 =?gb2312?B?VWcwQmFWdUtVYWE4c1ZYL1lMS0VQMTlrL0NseDU4U014T09RdFhwazVoeHY3?=
 =?gb2312?B?Z3FyT0pyUG5QZnZhV1BwMENFNVRsSmlJd3ZmbVYrVDRKY255MTdrZFB4NEpC?=
 =?gb2312?B?SEZyN252Qnp6ZnYwd2JGeVlLUGt1U0czaER2anhKTlRyRTkvQlYrUjFSYThn?=
 =?gb2312?B?MURuQUdZSVZzSVI5VTl6dDBNTFp1UG5rNVNKTkQ4WTJYdTA2ZHo0OXBmRTFv?=
 =?gb2312?B?OHBZdkl2UUVEejlMUkJNSW14OUx0R1RFcjFDTzBSNmhibWxCTU5nend6KzRn?=
 =?gb2312?B?WnU1c2lPbnBzaGhXeThyeDk1QzRMRHVEdkY0VzJ5aFQvaVo0S1hzdnUxU3RL?=
 =?gb2312?B?Snh1SVpLZGlYZ00yZE1TMnp6ZjN0dlJnMnNzR1hSL3I2RHNKNHBsRGdBaGRw?=
 =?gb2312?B?VS90K2ZnV0NOZEZ6WDY4cmZ6Q3FMSDVVa29FRm1jNzc4Q2NGcktvNzUyenRx?=
 =?gb2312?B?Uys1d2F4WjhnZ20vSHczdVNCR0hUcG43Y01yZzVlaEJqQVBlY2VacklLSC9K?=
 =?gb2312?B?YzBMcElPT0ZPTDh2OXM5QmtGNFdBSnRpTWJmSzdNTGdMbXI4RGVYd2VFMlJE?=
 =?gb2312?B?dFVNd240ejVac0pWNzJQbzF2VEpuMnErdzhWK0Z1aCtDYmVUaEZack9jNGVt?=
 =?gb2312?B?d1JVNnpRV3lMdjdwb0RlNUlUaHJJeklUc0hDT1d5QWhEMWxnTXRhOHJhSzV0?=
 =?gb2312?B?TS9jQmRjK0x5cXhFcWtVWEJ6d3BBd3RHVE4rYkZ4OVhSL05OcWJ6cldFQ2dJ?=
 =?gb2312?B?bXY5SnV1a1ljWC96a0VGWU9NcmM5dnBNU3lvdkg5RTBtenU1czQwYVFnTUhn?=
 =?gb2312?B?UjBpM2loT0ZFUTdNTVN0ZU9EdXhyZ3NhaXE5YW52bENONVBiWnQ2LzdWV2pX?=
 =?gb2312?B?VXc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: db55a151-bd9d-4ea9-c6de-08dc3e4c3afc
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 02:13:50.7235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xl/Qg5fT0kaDmC8DD+TxSrLEgJ6S28H8eSrbRCYm23n3ChzBvHynXuo2QPZJwm6dNwnw3c8FTd7TMJQA18pjXuJS8AKSiZtTffZmlEs9C14pER4xh86jSvN3B+/q4UJK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0622

SGksIERhbg0KDQpbLi4uXQ0KPiA+DQo+ID4gK2Vycl9ybV9saW5rczA6DQo+ID4gKwltZWRpYV9l
bnRpdHlfcmVtb3ZlX2xpbmtzKCZpc3BfZGV2LT5zdWJkZXYuZW50aXR5KTsNCj4gDQo+IEkgZG9u
J3QgdGhpbmsgdGhpcyBsaW5lIGlzIGNvcnJlY3QuICBJIHRoaW5rIHdlIG9ubHkgbmVlZCB0byBy
ZW1vdmUNCj4gJmNhcF95dXYtPnZpZGVvLnZkZXYuZW50aXR5Lg0KPiANCg0KVGhlIGluc3RhbmNl
IEkgcmVmZXIgdG8gbmVlZHMgdG8gY2xlYXIgYm90aCB0aGUgc291cmNlIGVudGl0eSBhbmQgdGhl
IHNpbmsgZW50aXR5LiBTZWUNCmh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y2Ljgt
cmM3L3NvdXJjZS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL3ZlcmlzaWxpY29uL2hhbnRyb19kcnYu
YyNMODU1DQoNCj4gPiArCW1lZGlhX2VudGl0eV9yZW1vdmVfbGlua3MoJmNhcF95dXYtPnZpZGVv
LnZkZXYuZW50aXR5KTsNCj4gPiAgZXJyX2NhcF91bnJlZ2lzdGVyOg0KPiA+ICAJc3RmX2NhcHR1
cmVfdW5yZWdpc3RlcihzdGZjYW1zcyk7DQo+ID4gIGVycl9pc3BfdW5yZWdpc3RlcjoNCj4gPiBA
QCAtMTYyLDYgKzE3MywxNCBAQCBzdGF0aWMgaW50IHN0ZmNhbXNzX3JlZ2lzdGVyX2RldnMoc3Ry
dWN0IHN0ZmNhbXNzDQo+ID4gKnN0ZmNhbXNzKQ0KPiA+DQo+ID4gIHN0YXRpYyB2b2lkIHN0ZmNh
bXNzX3VucmVnaXN0ZXJfZGV2cyhzdHJ1Y3Qgc3RmY2Ftc3MgKnN0ZmNhbXNzKSAgew0KPiA+ICsJ
c3RydWN0IHN0Zl9jYXB0dXJlICpjYXBfeXV2ID0NCj4gJnN0ZmNhbXNzLT5jYXB0dXJlc1tTVEZf
Q0FQVFVSRV9ZVVZdOw0KPiA+ICsJc3RydWN0IHN0Zl9jYXB0dXJlICpjYXBfcmF3ID0NCj4gJnN0
ZmNhbXNzLT5jYXB0dXJlc1tTVEZfQ0FQVFVSRV9SQVddOw0KPiA+ICsJc3RydWN0IHN0Zl9pc3Bf
ZGV2ICppc3BfZGV2ID0gJnN0ZmNhbXNzLT5pc3BfZGV2Ow0KPiA+ICsNCj4gPiArCW1lZGlhX2Vu
dGl0eV9yZW1vdmVfbGlua3MoJmlzcF9kZXYtPnN1YmRldi5lbnRpdHkpOw0KPiANCj4gSSB0aGlu
ayB0aGlzIGxpbmUgc2hvdWxkIGJlIGRlbGV0ZWQuDQo+IA0KPiA+ICsJbWVkaWFfZW50aXR5X3Jl
bW92ZV9saW5rcygmY2FwX3Jhdy0+dmlkZW8udmRldi5lbnRpdHkpOw0KPiA+ICsJbWVkaWFfZW50
aXR5X3JlbW92ZV9saW5rcygmY2FwX3l1di0+dmlkZW8udmRldi5lbnRpdHkpOw0KPiANCj4gSSB0
aGluayB0aGlzICImY2FwX3l1diIgc2hvdWxkIGJlIHN1Ym1pdHRlZCBieSBpdHNlbGYgYXMgYSBi
dWdmaXggcGF0Y2guDQo+IA0KDQpZZXMuIA0KDQpSZWdhcmRzDQpDaGFuZ2h1YW5nDQo=

