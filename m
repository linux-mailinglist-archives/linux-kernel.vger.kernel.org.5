Return-Path: <linux-kernel+bounces-38049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A72D83BA46
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 07:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F9381C21BD6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 06:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A185010A1B;
	Thu, 25 Jan 2024 06:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b="ek5AWYkD"
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-pr2fra01on2052.outbound.protection.outlook.com [40.107.12.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9AA10A01
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 06:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.12.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706165356; cv=fail; b=KVI+M4UtlGTFsbhObWvpZKb9/eiBz0hzsw4xV0Y/8LCuzDtQ4soEfjOx514bQr1JEMRR9QQ0ZotTmYLdP3VmN6w0884fB/vVHlZk6+3cgwG5Li6cMyZMKBhYFLd/L4giLFW7vACJQpijNG7iDFPkt4Gpe9q614vOpi7F5iqqV10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706165356; c=relaxed/simple;
	bh=ykICuBDr+71SimGOAX/A2O2UrHxPpQ1soX7L1GyPazA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M3LW0xBKI9rAiwIARKvqX0s5HzHie8hKplOQOUEb9Enr3p1F1j3yCrhWxOwbvUZbDmadDyie2KBjG7e8U8wQoeBWYQFHMs3XnCwObWhgZMc5I40EZhjX6spoXh/PI9hLvrjhsD6OrOLU4DRsZr992lT6bS9DvzEnIOvUNDsqMsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b=ek5AWYkD; arc=fail smtp.client-ip=40.107.12.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eZCP2s+DXDb3NnjVVTlro97qqPG8lIAT94YYO9CokjglT2RnUFLMPk0GgjL2zVt04KPslpAlNhECsatwPJ5GZP+Zlxq8VRMtjbkjroIB639AY8lX0lUfAk0/rOR300maTV9oTSXa1nlboSLw+zRd72B/V6xuk504CHEzduDGH/wDAETjovRPTP1zH8IsQe56wfw982sGEaDoxLfqReTZuBhrcUcjUdEK0g9WlH7vAnIsLvoZLw7HTmHBiY0J8QP+dbEMjMf6R+lx0w+1pTiPOK9kllzDkOJYHE1kT7IhLiwjvt/fL7YgDI4dNWcMIm0IYlh12GxJXiAHBJ4t7icGbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ykICuBDr+71SimGOAX/A2O2UrHxPpQ1soX7L1GyPazA=;
 b=DSacnIL0yL1cI8kilm3Ym7vUIrtwlRB6NAb5Xs8OPXyXJM07hVYu64NP8YsNc0fje2VIxDvmlGnrU1s/PCMWlFczjietSa7plprU07F8+teyhJYQrY0lUwLbVeXvYOz2q4x1253Rc0o/GpF+TOH6EaAbZQ2fbqqbZSatdVD0wcyYds3iYMxJ7lcfsU/uJIJ6vo5UJJXRuVr+hjaFM4LytBQ3+Aj+Ph0VKzpDPlkRZuEzDrV3wmBQhHSMa3BD47mvB/vD70rRZBG1D4HKX7XdhOtkKQXJTBXb5fEG4XD5pnYmgyjiviY2rHj/irtp9tflED+9dLceClKbe7ZGY9Rufg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ykICuBDr+71SimGOAX/A2O2UrHxPpQ1soX7L1GyPazA=;
 b=ek5AWYkDT1/KVK5+2wyZQ4gy2/lA/R1qU9RR7/fB3PRqT8qtkUcdmzT6eS9B4RsDPVBODY85IWbT4OVXGhE3jMkSfuQi/pWUfEXG8/W1erz8AJv8UnGCdLBulyDA6e3adIXdKsla98H4rj46YRAH1S/oN6Co6tSbwOiXeVVv6B2SUV5En6GsI40gOeLnGBm1IKsOidvfGqEwy6z9VaoebQAWBNc5ZY6oUzYSum0FHmSjWXK814PkVru29Sxn/okGP8TneftBYZCrLq7fj69R3Q9Tvjgq4Lph5amxdppMvCFmuaOXorjDFr/qJ072do010Vf0ACH5bNsbrkDboPnYoQ==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB2532.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:35::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Thu, 25 Jan
 2024 06:49:11 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::9f77:c0ff:cd22:ae96]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::9f77:c0ff:cd22:ae96%4]) with mapi id 15.20.7228.026; Thu, 25 Jan 2024
 06:49:11 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Kunwu Chan <chentao@kylinos.cn>, "arnd@arndb.de" <arnd@arndb.de>,
	"mpe@ellerman.id.au" <mpe@ellerman.id.au>, "npiggin@gmail.com"
	<npiggin@gmail.com>, "aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>,
	"naveen.n.rao@linux.ibm.com" <naveen.n.rao@linux.ibm.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] powerpc/iommu: Code cleanup for cell/iommu.c
Thread-Topic: [PATCH] powerpc/iommu: Code cleanup for cell/iommu.c
Thread-Index: AQHaTzmCajGAaMhMM0On6Mng+hR4krDqFr8A
Date: Thu, 25 Jan 2024 06:49:11 +0000
Message-ID: <7cdfcfc3-fc9e-433d-8992-7782d641cb94@csgroup.eu>
References: <20240125024633.512513-1-chentao@kylinos.cn>
In-Reply-To: <20240125024633.512513-1-chentao@kylinos.cn>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MR1P264MB2532:EE_
x-ms-office365-filtering-correlation-id: e388a63e-a030-4e13-473f-08dc1d71bc8a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 w/WzgIALJSkGC8ktKYwwIDWFDkPXnq4Qpa+Vt82m4l23tWjGSo7B279/SfKZBSFsinR0EjjjdmoHJL3gBBlo3VKV+uE3mAz+d/Tz2uqEyTZhGetj8P/LiiO7i3WGuyziQwSLtWJ7EHB8rGBq2b6EhEEr4P0FnJxHPg6XGd+F9ek5SjCE3VrvcSgp2lPv6sPhmd+60Ssx1srHztCAgipj4EStYa3N1B4ZVAhnEr9e+LoVEz2Qh4Pqp0x5PpQd7D/Ptlbaj3DCjRqb68S20+7P97COcZAAL8vLMv4YJypfBxx5UsbwPwW28kFgKuEqVaO3zfUCz8UOgLMjY4E5HHoTSYo8zvp4IYTtUPBt+aI396/EBtbBdxZVDso/SBC8R0yBb+VxZNTxVLATTNPymrS1Jvm3MhMvfST0pDVhKQAyvKqCfmuCliTyud2Le4Tf5BckJUZqW3m+plaJZ7lqJehKOfNdp5JFKPjAcx/+tjpzBKsZEk5xFfABxV3GwCbzGQa/UeZ3QA8X/kN/n9QrXERvVilXG9VtpLteUGT9CIagTEITSDb6psgQnUKzgN1/xcNrZI+To0KHJLpI5dxkoq3kON3DxA6fSlezupzH+SiHhAF7yTAa8/tfHxuGIwhFjP5ZKW5CE0AKvqIlEn7oUPgVYGStzYJF790xjSB0/lVy7CE+g2Mv3Bfl5/XBY9p7+Kid
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(346002)(376002)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(41300700001)(38100700002)(54906003)(64756008)(66446008)(66476007)(66556008)(66946007)(316002)(31696002)(91956017)(76116006)(110136005)(86362001)(8676002)(71200400001)(8936002)(6506007)(6486002)(478600001)(36756003)(44832011)(4326008)(5660300002)(2906002)(31686004)(26005)(2616005)(6512007)(83380400001)(38070700009)(122000001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YjNXUzVWaWU2TElYb2cxd1A1Nk9hWlJ6TXVxUjZZNGF3N1JZUXJCWkxZNmJD?=
 =?utf-8?B?bmRBVU1VS1RKS3dkNkdsNk9pWWViUEhmbWRqdU5hRDA3Q1ZwanJDNE1UM3FX?=
 =?utf-8?B?cm8zWno4Qkc2eUJoVStxTjRlV2h3bzc1Q0o0cFNiNUc5RE9TRVQ4Yndhdkhs?=
 =?utf-8?B?QnR2Q1l1aXlZc0xWZHEyWmRKb01Yd1g1NXVtYytJaXd1eXl1ZEczL0U2SkNk?=
 =?utf-8?B?YlFEeUJlS05IVjRCL2d0L2F0SDlPdWdrcW9wSnRwci84cC9sVjlwVGN1RS9Z?=
 =?utf-8?B?YlI4d1Q4aG9YRnh6dUdoZ3J5TlZidVVNa0lZQ3ZWRm1jR0lqc0xDS2szSGk1?=
 =?utf-8?B?dlkvNVlkb0xDREpvSkFNYXJnclFDdXNJMFFtSXUwS1lwL0s3ejFTSjFiODZH?=
 =?utf-8?B?UEF5aGpjUjV1RjBVVnpqeGhqbTBBbklWZTViWEtzMnFobFRnNitLY2ErYVlT?=
 =?utf-8?B?ZS85RXZnaWZkRzlJS29oNTFOR2d6MzZHSEJ3ZEhHRVg2aEN5eFdOTFZQcXJS?=
 =?utf-8?B?WFI2ajd5V0ZhclhNZ1dNZDN2aUk0dE4wZ01adnhwNytCOFFnWk94eUVINGlO?=
 =?utf-8?B?cGxUVGRDcjhYWU1wdURlZ1FYQ1d1eS9jTDNJS3ZRQlgvMmZXV1lYMDRkb3h6?=
 =?utf-8?B?Vlhla3FEYVJ1UitBc3BEcGs1UDE1L3BUZnErV3pqcUxKRG4wSXRXTG1QN2pz?=
 =?utf-8?B?RWtZOXNSd0FzT04zd2NLQytXbVR1U3IySkxkVncySjVUeFl1UlZkZmhIR3Z2?=
 =?utf-8?B?eUJlUnM5Qy9oNkxXbHdPV3hhSkROUkx0Z0RnckZpS1FHZjJwT1pXalRkanFk?=
 =?utf-8?B?Y3RRY3IrZ0lzTllLZmZuTzdwRjJvNnZtdTI4VlMxVFZHTFhzallyN0tEMXVh?=
 =?utf-8?B?MldkNzY5a0czSUxwUzJhcCtJemtvZ21GdndEOC9HczJGRWVsdVhXUU1Ebldm?=
 =?utf-8?B?ZFJIa1NOZmhNSk11MSsxckFzOHEweldGS0E4eElXY2gzWmdqNDM2SnVtVFc4?=
 =?utf-8?B?czV3Z3hZd3Q4V2xMSG5iWXlBMUlVc1hRQlhoaDNybERnTzIrenNqbURwaEd5?=
 =?utf-8?B?MkJCcVJnZTNXa0hNdy9kdDNueUNmSHl1ZnNMYW1ZaUxvZnVYOXNONU1RQnlo?=
 =?utf-8?B?SCt5QVlqUjU3YzZWRFU0bUJEanRndDluTDdPUE5va0hlSUlQVUJMdlppME9w?=
 =?utf-8?B?Q3hDMVZjUjlUOEp0Z3UrYlBoVWtvYUlLYTBMNWc1TUl4eExkYWh4Vmo1Nmk2?=
 =?utf-8?B?R0hHK1I2Q09kNHl4aGRDV1FrQkROa1N2dFVyMFZ0eUtTTlBiQWg1MmJ0b1BT?=
 =?utf-8?B?YTlxU0h6YWREQ1N0dG9Fb2NDbzAyVnc3NmMwZURWczZNK3NqZFUrMmFpMmlL?=
 =?utf-8?B?dit3VTI0VDRTV0VyaWYyNHdiSzY1dE1mYW5VZlA5RkluZFpyYjVJWG9SQmpK?=
 =?utf-8?B?TnU5V2Vha1k2KzVVOHl1eUtEYkhmWE5BQy9Kcm5GcFQzZTNWTGh5Y1NNcnNO?=
 =?utf-8?B?ZG1iWnRoYWpxd1dpRTMzdlRUcG5GUWpRYk5jRi9xUGZiWGJVanpCTCtPa0dn?=
 =?utf-8?B?UkFOME9MSkFOWFo0NDlCZ1dVWEtsSmgrbHlITVpTa2hTbVAzVzJvSy8rbHgw?=
 =?utf-8?B?ZFNjcTlRUWE5MTBUcXlHd3Qzb0dNQ2lMYnl6R0dIRlJ2SGN1UkhQSFZub0lO?=
 =?utf-8?B?dXlFR042ckxSbTkzUHd5bUxUT1dNRTR0YmM0UWVBOEozN3EwNy95SXJDVk9G?=
 =?utf-8?B?ZDQzWEQwRVNEZWRZSjY4UzQrZUx5clhUN3pWOWVaOCtZbFhEQk4vR2pwd3lm?=
 =?utf-8?B?SDVSWGNSSVlTZ1RubFBWVTZGRkZMVzAwSUNHM2wxSzlQUy9mMU1pNWlqYlJk?=
 =?utf-8?B?TUkxaGF3UGI2M0tvZHhEQU0rQmM0TGlBdjg1WnFRTVJjZ25zZFkrWlB6YjJm?=
 =?utf-8?B?ZnlEazR3UWNjekxDY0xpdytybW1vUEN5bzlxK0lKNnprUkxUaG91SGZaOFZ3?=
 =?utf-8?B?cFBZUDI5bmxEVnVSYnJ4NCtVNGN3VFBRSVByYXgwcTI4cFdtYnM4TnNJQkFi?=
 =?utf-8?B?enhyMHJGcEdlVzBXYWlKNGo5dDh1YjZvNm10Ym40VFg4WTNhRWo3eklBYTAw?=
 =?utf-8?B?VkRIM1cxd2YyRytPd2JNTm9LWkIwaXlCMXpYYStWakxFb2h1empWQTBFYUcr?=
 =?utf-8?B?a2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B54BD2BA74E7E04AB153755549FD357F@FRAP264.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e388a63e-a030-4e13-473f-08dc1d71bc8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2024 06:49:11.0962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XfPyWITXitaX8DCQcMk76+zFrHB1ZfbXqg/EbS1YYfw47cVya1PcYN20dbEMG5/ip/XsCjPD5gRufzYIkGnYQmGeN3L02KwlRKoL58+Bcqo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2532

DQoNCkxlIDI1LzAxLzIwMjQgw6AgMDM6NDYsIEt1bnd1IENoYW4gYSDDqWNyaXTCoDoNCj4gVGhp
cyBwYXJ0IHdhcyBjb21tZW50ZWQgZnJvbSBjb21taXQgMTY1Nzg1ZTVjMGJlICgiW1BPV0VSUENd
IENlbGwNCj4gaW9tbXUgc3VwcG9ydCIpIGluIGFib3V0IDE3IHllYXJzIGJlZm9yZS4NCj4gDQo+
IElmIHRoZXJlIGFyZSBubyBwbGFucyB0byBlbmFibGUgdGhpcyBwYXJ0IGNvZGUgaW4gdGhlIGZ1
dHVyZSwNCj4gd2UgY2FuIHJlbW92ZSB0aGlzIGRlYWQgY29kZS4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IEt1bnd1IENoYW4gPGNoZW50YW9Aa3lsaW5vcy5jbj4NCj4gLS0tDQo+ICAgYXJjaC9wb3dl
cnBjL3BsYXRmb3Jtcy9jZWxsL2lvbW11LmMgfCAxNiAtLS0tLS0tLS0tLS0tLS0tDQo+ICAgMSBm
aWxlIGNoYW5nZWQsIDE2IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvcG93
ZXJwYy9wbGF0Zm9ybXMvY2VsbC9pb21tdS5jIGIvYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9jZWxs
L2lvbW11LmMNCj4gaW5kZXggMTIwMmE2OWIwYTIwLi5hZmNlOWU2NGE0NDMgMTAwNjQ0DQo+IC0t
LSBhL2FyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvY2VsbC9pb21tdS5jDQo+ICsrKyBiL2FyY2gvcG93
ZXJwYy9wbGF0Zm9ybXMvY2VsbC9pb21tdS5jDQo+IEBAIC00MjQsMjIgKzQyNCw2IEBAIHN0YXRp
YyB2b2lkIF9faW5pdCBjZWxsX2lvbW11X3NldHVwX2hhcmR3YXJlKHN0cnVjdCBjYmVfaW9tbXUg
KmlvbW11LA0KPiAgIAljZWxsX2lvbW11X2VuYWJsZV9oYXJkd2FyZShpb21tdSk7DQo+ICAgfQ0K
PiAgIA0KPiAtI2lmIDAvKiBVbnVzZWQgZm9yIG5vdyAqLw0KPiAtc3RhdGljIHN0cnVjdCBpb21t
dV93aW5kb3cgKmZpbmRfd2luZG93KHN0cnVjdCBjYmVfaW9tbXUgKmlvbW11LA0KPiAtCQl1bnNp
Z25lZCBsb25nIG9mZnNldCwgdW5zaWduZWQgbG9uZyBzaXplKQ0KPiAtew0KPiAtCXN0cnVjdCBp
b21tdV93aW5kb3cgKndpbmRvdzsNCj4gLQ0KPiAtCS8qIHRvZG86IGNoZWNrIGZvciBvdmVybGFw
cGluZyAoYnV0IG5vdCBlcXVhbCkgd2luZG93cykgKi8NCj4gLQ0KPiAtCWxpc3RfZm9yX2VhY2hf
ZW50cnkod2luZG93LCAmKGlvbW11LT53aW5kb3dzKSwgbGlzdCkgew0KPiAtCQlpZiAod2luZG93
LT5vZmZzZXQgPT0gb2Zmc2V0ICYmIHdpbmRvdy0+c2l6ZSA9PSBzaXplKQ0KPiAtCQkJcmV0dXJu
IHdpbmRvdzsNCj4gLQl9DQo+IC0NCj4gLQlyZXR1cm4gTlVMTDsNCj4gLX0NCj4gLSNlbmRpZg0K
DQpTYW1lIGFzIHRoZSBvdGhlciBvbmUsIHBsZWFzZSByZW1vdmUgdGhlIHNlY29uZCBibGFuayBs
aW5lLCBkb24ndCBsZWF2ZSANCnR3byBibGFuayBsaW5lcyBiZXR3ZWVuIHRoZSByZW1haW5pbmcg
ZnVuY3Rpb25zLg0KDQo+ICAgDQo+ICAgc3RhdGljIGlubGluZSB1MzIgY2VsbF9pb21tdV9nZXRf
aW9pZChzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wKQ0KPiAgIHsNCg==

