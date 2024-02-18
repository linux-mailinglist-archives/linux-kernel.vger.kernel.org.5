Return-Path: <linux-kernel+bounces-70310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9868595E7
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 10:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBB5C1C214B5
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 09:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A326F12B86;
	Sun, 18 Feb 2024 09:09:14 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2105.outbound.protection.partner.outlook.cn [139.219.146.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92F97470;
	Sun, 18 Feb 2024 09:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708247354; cv=fail; b=BioyeOAUjGnmUKFoe1SdwakM3PP/x8t1xmoQZqamISKw0pZ/rHLCDRF25ZKE/uBmcDPxPSnHU8q19Y1u/1zZ3usI4XKb9/lssK/QVbHMZXdYEdW6DP7vnAD7+2cxi/Lmd1jCnTqq49qcDQpZ8RP5uVE4nCNDYa6XUTL5PbWzKJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708247354; c=relaxed/simple;
	bh=uIQrkTheVkil3TxjeQbSGR1kNOJGTxNZ7rJs2Q4R7i4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RorbWqjioYIey32g6tYTir7P4e5ktFE6Uz2bOHidp/6q+wo7ev7CFVE8wnoKkAOxlMzOax/sxZthDlNq8YToRKTltXfF0+dGN/7WfbVjeuI3QUSmdQZP59oQo+ydFsyMa1g70HcfRoTXfDhZbxqwAZTPNePSkA32tvv65ZvQm20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TgmFVcdMzyICnhbftLtiumaEIqf5X191/LXTmskFfHi/+nJGP7OGX+okP/HxqtFTo4CYHCLWy2hWQZDTmTtLc+OlkvHPD3UIDel+HE2aDCIjwAW2kU76tsrjtc/KqJGurfPl4k4pHHeo0h+aIt8w2K7yB1xMWkrXShZT2q36KKl4oHbmTpwNKHQx3Lzh/Cz8Z+SXAe/PPju3McuxkQgzeOPju6LtOgnwt8PmrT0OpG9QmRbWEUG4bxqJgOKMzMDlWIKT7zAhWUBJWBj+axe0Mkn1fRDn0lBat+a/RcqOGagFRxAw3KRW444rPAA/VbUN6tSX6xTTmULDOH+D0ZD3HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uIQrkTheVkil3TxjeQbSGR1kNOJGTxNZ7rJs2Q4R7i4=;
 b=RRy/O5MrmsHF+2NUTRIGpFm888iWHANq0HifotBmIpEPiYdTYB4XzJ7maRgFw1hDOXK5dBl0NgmW/LBXAoJhdYJQoa3nHgsZfNu9QLq1kolqLUpnCGezS5ZcrJ/DJLSaeF7QbL7YM0nJIqwcYFn0YiogCfL+UkJO8evoyH9tkhQSHgntusld4Et2ZbQVrSn7P/HcVAHGJYtQk5TVr1CRd6WCPSjwS6M6gMMYzw6c0kpkYEEDrGZV6cbDjnTozjnpslp7l9ccxEOvzB70A2HWZzq8UTm6nLaFV7DXmhpkiJmiFHqCSpegO1cSdmiDTzg6laRkkxuVr1zYN4Cd71IiIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0816.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:27::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.46; Sun, 18 Feb
 2024 02:36:05 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::b0af:4c9d:2058:a344]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::b0af:4c9d:2058:a344%6])
 with mapi id 15.20.7249.041; Sun, 18 Feb 2024 02:36:05 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
CC: Leyfoon Tan <leyfoon.tan@starfivetech.com>, Jack Zhu
	<jack.zhu@starfivetech.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject:
 =?gb2312?B?u9i4tDogW1BBVENIIHYyIDIvMl0gaXJxY2hpcDogQWRkIFN0YXJGaXZlIGV4?=
 =?gb2312?Q?ternal_interrupt_controller?=
Thread-Topic: [PATCH v2 2/2] irqchip: Add StarFive external interrupt
 controller
Thread-Index: AQHaU0FmkrIWOb3y5U2swetYFmXGFLEIEG4AgAdrmVA=
Date: Sun, 18 Feb 2024 02:36:05 +0000
Message-ID:
 <SHXPR01MB0671BD046F6E3F3A215414A6F252A@SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn>
References: <20240130055843.216342-1-changhuang.liang@starfivetech.com>
 <20240130055843.216342-3-changhuang.liang@starfivetech.com>
 <87cyt0ivn3.ffs@tglx>
In-Reply-To: <87cyt0ivn3.ffs@tglx>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SHXPR01MB0671:EE_|SHXPR01MB0816:EE_
x-ms-office365-filtering-correlation-id: 1d572e35-26d2-46f6-f766-08dc302a5ae1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 LTooA5c7CgiukLMIp8aAeW3mIFYwBxHq8pDgrVfYXB83MTacszUwGEWnuVb0WhNwv2kKIb2UAUhvZF/Y7Ile3b+1oWRmh7fZMOmKuRwd3Qr2cb94cX63ZrqU0XCxA0uvqVQN7Y97ebeN0AG/8tWUMLw5tt+HLKEjvoJs3fMMbwJxKbkIEntA0hqvl/M0+WD9HCnL53JlH2LvmyOoGRohhyhgppRMLF3wJFlywWT2gRKZV5/l5jxitEEl6iQSY8lkwrcYe+LDYeFEOkTq52WIXqhmntu4Z+sMHTdnnBW7bzJ1tojkSuIRKvTLN/7QpM+7g4lrAsgGm+Un76zp6YGvxoaYg674QgO5Qhbx/Q9e5BCSgkaF8NbpR7fqC6YkaqeF8HFVWQ/SrhahMu1nLmy6Go1xcyuO8ScOZD3oNUOcBrnnKfPFjVE2RwGPBue7GuG2zpOTk+K3cZPUhHUJLcqNz8rNiqZi0fXVBsmqWnsLG4pmmR237Tk8WjammrjvfzupOHqAZzzpAp33EwhzibsGVWfY+0Ohv8JYDlBisvuikCGBMd6OA4MpriwGDlaIa8kf
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39830400003)(396003)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(38070700009)(38100700002)(40160700002)(41300700001)(122000001)(224303003)(55016003)(41320700001)(2906002)(7696005)(9686003)(26005)(508600001)(83380400001)(71200400001)(86362001)(33656002)(40180700001)(66946007)(44832011)(5660300002)(54906003)(64756008)(66446008)(110136005)(66476007)(66556008)(76116006)(8936002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?bzFBWXN3SGNETFAzQnRaT2xGS1gxVHhpSXhKRnBtTlRpclJMSENuYWZ2Qm1q?=
 =?gb2312?B?WkUrZE1wWXVlK3pnY21wdXdYeHBPNnNwaEwzamxSenVuSkZMRzF2MXlaeTlK?=
 =?gb2312?B?amFmNkR0Sk5UMFJqT1hXMlFzQUFBZmNUeUJzR3RqYzdnVmFZci9aSnBCYmhH?=
 =?gb2312?B?bnMwV2JsTU1UMDBSUDJpRmorTlRISE1kNCswWEZNMlhUU2JURVpHRzFtQ28x?=
 =?gb2312?B?dFUxODZPbExlUklsRnRhVlEzN0tiRzFCZHhNSW1LVTliN05vT3Ftd0U3d2lI?=
 =?gb2312?B?a3dtdmhqZGU0UytVQUxSSXR6cGFuc1pBUDBMUlFXNUl2Ti8rT3FibmlyQnBY?=
 =?gb2312?B?dDUzNFM3RThFMHJTYnBJTk9MN0MrWWJQODlCMXVVU0FkOXZ3K21kbnlIdE1o?=
 =?gb2312?B?SXZXMXFxVEFBdFU4c0N6cjlKcXdsdEFUMHh4WjF3VlpQUGsrWnhnSnFjODc5?=
 =?gb2312?B?MDl0TVdydVpmK2c4UXNwR0hsSHRic0hmaVM1bzJsNXFRZFArQWR3akdRYUVU?=
 =?gb2312?B?TG5FWmIrNmxMeFJwTVM2TUY0VjIvU2JXWUxiMUhVaTFXcmtyTEtrOUFHUEov?=
 =?gb2312?B?STg3WEZWWlhNNGUvUitiWUNHR1pxTXhxTHJWWDJzUXdKTlZadkg4OWlXdVJs?=
 =?gb2312?B?OHVGN2M5T25kWSt1Mm0wa2d5dnJ5d2pMNEtteDBFaERHL1EwVk95eVlUc2lx?=
 =?gb2312?B?cVJUaGdoVHcwekVkbTZKME9MeDJxREJTQXU1ZG1KSEVDTjJBS21ZRzFnaVlW?=
 =?gb2312?B?VGNsMlA2bjhBcjFSdTNwZEZIaFkwQk9RcWN6UlZ5QVBocWMvd0h2T2VyeTFN?=
 =?gb2312?B?TUJ0aDVnVlp4MlJOalg1QlBzRlFObTN3cG1ScXJMVGxzSlpxWXlob3FMSzFR?=
 =?gb2312?B?L0J2ck5EOFZ1aTVycXdmYlJ1OWpWUERPam8zOEFSSUhyMzhOazMwanQyc2NC?=
 =?gb2312?B?T3F5SUw1QjBLOUNyeEpsQnNiR2h3cmQ0NTZZYVkzVTUwWmMrMHVIQlU4RTBz?=
 =?gb2312?B?T0Z6SUhOU3gzYUR5MkliNGZ4d2o5dGREc2E3N1RjNFZMUWQ4akptVncvSC81?=
 =?gb2312?B?cDhteTZLRFErelozcnZlQmxxZmIxZnhZZ2w1VE5vV3RPRG9KeXAwTXB0NnVl?=
 =?gb2312?B?Q1FjamlUd0NDZEFQVHRhN2tHZkQ5UTlWaGxnZ2JCS0hiS0Z2d0pzUCs2U242?=
 =?gb2312?B?Sm5IL0RSNzBJQmxKMm1hMmR4Y21COUY4NkVQdUN1R1FMaFRRZkw2QU9IQXNp?=
 =?gb2312?B?MnZiazBMS3pQSVBZL0xGS0YwMkFXbm5wYXBWVzdkU1V4elhjckNhWkNUMGQx?=
 =?gb2312?B?ZktvQ1Joby82Z2RhSy80aWlyeVdXcXJxV1pXV0QvOVBGU3Rrek1mOWZOMjlT?=
 =?gb2312?B?blFiaXA0bHIwRUp4K3lHUGlzWHAwbHZ3YmlYa2VkQmlQWHpKVE8rTlZhVHdu?=
 =?gb2312?B?dmhXb0lZT0VnblZCTnEveVRmWS9tSkJBY0oreThsTVo3RlQrT05WYWIvSnNM?=
 =?gb2312?B?RjRncmFWRXNhQTV1R3lMM2VuRnRzV3UrUHBOYlpPbGN6Ty92cSttNk1lUTN2?=
 =?gb2312?B?YTRMbTlHNmVuS0JWdTN1L3RJMU9vWmo3bkJTVHhFeEQzekZ5WkR3dzVOdUFE?=
 =?gb2312?B?SmpRdDNGS2thczg4VkNMWnlkRmFjNHMreWdEbkpzREcyb3diYkQ3Qi9Zcy9q?=
 =?gb2312?B?TXFQem9CV21JakpPVFZnV1g0ZTZWTVNvUHY5NTJpdnB1UDUvNmZmODdIYkVl?=
 =?gb2312?B?YUpHcXhhN1VXQUNlWk81eGZwYkY0WDJud3o2VHR4eDUwSUhEbWtoakFwZTV3?=
 =?gb2312?B?NUdGOHhFT1lTSmFIZThWdVFwNnNXb1VBTzkxdGROcFhZamVwN01FalJMUnFW?=
 =?gb2312?B?emYyVVE5Rzc4MVJBRDFZaUFIZkJWM0VoaVU1TVBWRHNtWk8xanhZQWp5aU9I?=
 =?gb2312?B?TFRHU0M1Q2pBSStGRTdWZEg3dy9nQUI0NWU2TERXaG9TS0JBRjc0ME52b0R3?=
 =?gb2312?B?QnpQeE41RmVGMmZwUUFJQlNyVWkwM0pFWTEvb0JVMFVOY1FPZlk1OGx3Smtx?=
 =?gb2312?B?N05HZHhOQ2lXKzBTb0FDQkJyNmZwNmdUUStsbk1tcjdWb0NLOFpOUE1hRUZB?=
 =?gb2312?B?T3lOWTIzQXZJOE41R3NoUE1lK0tRMWVkQTJ3T2ZqRFJiV0tkNjBWd2ZYR2Fp?=
 =?gb2312?B?Unc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d572e35-26d2-46f6-f766-08dc302a5ae1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2024 02:36:05.1140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L+7wNsWJxkFzEehPokHeX925DzIFzYRDzNNyCj2jD8kgRELH0DCwWi4d3LbJ0qlmRQJhic0QlhX12ngVtX/PNTioFUw5Ab3YSOuV1ah4+EYNQ6H/zpVRJSQRFHYVhdW+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0816

SGksIFRob21hcw0KDQpUaGFua3MgZm9yIHlvdXIgY29tbWVudC4NCg0KPiBPbiBNb24sIEphbiAy
OSAyMDI0IGF0IDIxOjU4LCBDaGFuZ2h1YW5nIExpYW5nIHdyb3RlOg0KWy4uLl0NCj4gPiArc3Rh
dGljIHZvaWQgc3RhcmZpdmVfaW50Y19tb2Qoc3RydWN0IHN0YXJmaXZlX2lycV9jaGlwICppcnFj
LCB1MzINCj4gPiArcmVnLCB1MzIgbWFzaywgdTMyIGRhdGEpIHsNCj4gPiArCXUzMiB2YWx1ZTsN
Cj4gPiArDQo+ID4gKwl2YWx1ZSA9IGlvcmVhZDMyKGlycWMtPmJhc2UgKyByZWcpICYgfm1hc2s7
DQo+ID4gKwlkYXRhICY9IG1hc2s7DQo+IA0KPiBXaHk/DQo+IA0KDQpJZiBJIHdhbnQgdG8gdXBk
YXRlIHRoZSByZWcgIEdFTk1BU0soNywgNCkgIHRvIHZhbHVlIDUsIHRoZSBkYXRhIEkgd2lsbCBw
YXNzIGluIDUgPDwgNA0KDQo+ID4gKwlkYXRhIHw9IHZhbHVlOw0KPiA+ICsJaW93cml0ZTMyKGRh
dGEsIGlycWMtPmJhc2UgKyByZWcpOw0KPiANCj4gSG93IGlzIHRoaXMgc2VyaWFsaXplZCBhZ2Fp
bnN0IGNvbmN1cnJlbnQgaW52b2NhdGlvbnMgb2YgdGhpcyBjb2RlIG9uIGRpZmZlcmVudA0KPiBD
UFVzIGZvciBkaWZmZXJlbnQgaW50ZXJydXB0cz8NCj4gDQo+IEl0J3Mgbm90IGFuZCB0aGlzIHJl
cXVpcmVzIGEgcmF3X3NwaW5sb2NrIGZvciBwcm90ZWN0aW9uLg0KPiANCg0KV2lsbCB1c2UgcmF3
X3NwaW5sb2NrLg0KDQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyB2b2lkIHN0YXJmaXZlX2lu
dGNfdW5tYXNrKHN0cnVjdCBpcnFfZGF0YSAqZCkgew0KPiA+ICsJc3RydWN0IHN0YXJmaXZlX2ly
cV9jaGlwICppcnFjID0gaXJxX2RhdGFfZ2V0X2lycV9jaGlwX2RhdGEoZCk7DQo+ID4gKw0KPiA+
ICsJc3RhcmZpdmVfaW50Y19tb2QoaXJxYywgU1RBUkZJVkVfSU5UQ19TUkMwX01BU0ssIEJJVChk
LT5od2lycSksIDApOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgdm9pZCBzdGFyZml2ZV9p
bnRjX21hc2soc3RydWN0IGlycV9kYXRhICpkKSB7DQo+ID4gKwlzdHJ1Y3Qgc3RhcmZpdmVfaXJx
X2NoaXAgKmlycWMgPSBpcnFfZGF0YV9nZXRfaXJxX2NoaXBfZGF0YShkKTsNCj4gPiArDQo+ID4g
KwlzdGFyZml2ZV9pbnRjX21vZChpcnFjLCBTVEFSRklWRV9JTlRDX1NSQzBfTUFTSywgQklUKGQt
Pmh3aXJxKSwNCj4gPiArQklUKGQtPmh3aXJxKSk7IH0NCj4gPiArDQpbLi4uXQ0KPiA+ICsJaXJx
Yy0+cm9vdF9kb21haW4gPSBpcnFfZG9tYWluX2FkZF9saW5lYXIoaW50YywNCj4gU1RBUkZJVkVf
SU5UQ19TUkNfSVJRX05VTSwNCj4gPiArCQkJCQkJICAmc3RhcmZpdmVfaW50Y19kb21haW5fb3Bz
LCBpcnFjKTsNCj4gPiArCWlmICghaXJxYy0+cm9vdF9kb21haW4pIHsNCj4gPiArCQlwcl9lcnIo
IlVuYWJsZSB0byBjcmVhdGUgSVJRIGRvbWFpblxuIik7DQo+ID4gKwkJcmV0ID0gLUVJTlZBTDsN
Cj4gPiArCQlnb3RvIGVycl9jbGs7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJcGFyZW50X2lycSA9
IG9mX2lycV9nZXQoaW50YywgMCk7DQo+ID4gKwlpZiAocGFyZW50X2lycSA8IDApIHsNCj4gPiAr
CQlwcl9lcnIoIkZhaWxlZCB0byBnZXQgbWFpbiBJUlE6ICVkXG4iLCBwYXJlbnRfaXJxKTsNCj4g
PiArCQlyZXQgPSBwYXJlbnRfaXJxOw0KPiA+ICsJCWdvdG8gZXJyX2NsazsNCj4gDQo+IExlYWtz
IHRoZSBpbnRlcnJ1cHQgZG9tYWluLCBubz8NCj4gDQo+IFRoYW5rcywNCj4gDQoNCldpbGwgdXNl
IGlycV9kb21haW5fcmVtb3ZlKCkgZnJlZSBkb21haW4uDQoNCnJlZ2FyZHMNCkNoYW5naHVhbmcN
Cg==

