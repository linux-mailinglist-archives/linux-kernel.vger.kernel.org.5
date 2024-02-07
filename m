Return-Path: <linux-kernel+bounces-55903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB51484C33A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 04:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A154A284270
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 03:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62FD1094E;
	Wed,  7 Feb 2024 03:42:55 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2104.outbound.protection.partner.outlook.cn [139.219.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDBEFC08;
	Wed,  7 Feb 2024 03:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707277374; cv=fail; b=C0mTGJFKuXcDTRixKWZ4m+K25hT8QrKEkw616lmfFdcvr6ZFOvKHKfoJHCAkEM2oQcgxUrlz4RtSXj4zJ95j7XFVDz4o0Hd0lrHZp3z0nRSiHRhh3as1udTXK62P7iFOqDKa1Nnwv0dG1BVldrDyHd0vp/eOwBmiKW/cQy46Xpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707277374; c=relaxed/simple;
	bh=gxJIvzAz1Ea7V4eSltdo1X6ZZHYzIcYKwWRH4TWz7Hg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RDljuL5J+qtupeYZHCD7yCY16pS7ojLjjRXiQ/1r3uTiFIS58JdDdSFMY7vSMDSVcnc/54Eiv9gvTAQUNormI16z6iv6vUJ8qmtaH4v6dvzP1RGwvb6fUKY74r0tWS2cIrQSVXfgX3ugpWg/9El8IkmQjeUGILKf7zw0Yb0UcnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jieh3Tetvc2fiz9Y4suRNb7dTqJmQLvmIsQx30J7AAeFP1VLDayowVu/UFLxVFxcaZZ+/4I7xPKztUq8SXa1FaeBuoYvxdvWLEJdKi+uEZkaditr2+JLjEKn+ewad56UNi3FNrW4/BGwKKHB5PtHefsLRFOahFWyKSA/XinkwytRlwqRO75m7klMPNVQE+wIYX/6OIl2A6qwfy6rkUl5YztIlV1E9mVC4D/+ILv+gIoSLaxfm20FxQShPawZSfpG9lKvYv3brbqMojvIvTDHRIRvrfFAzQHnHtWGw6BhJVhm5iyLMElud6o1PXApcVXPlh6qx7ncgyvGonRMyzX/DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxJIvzAz1Ea7V4eSltdo1X6ZZHYzIcYKwWRH4TWz7Hg=;
 b=mgbzYjgWceF1MMk+zBtwDxn6V62c5M8ilQOJq4hxhHYt+Oy+b7/iyuIXJz/zs5TxvmEAOIrkFDUvHPHDyCrMeWP/Ytdm6SDw8DEOq/vW6VGddbhBA7GAFjQKfqUTOX2kOrE7XKPzRdx48zfUtkv+GQJ2unwroFJrJvu1zJ3FrUODByFX5SUPm66/w7wtzDJwM0k3wKsCNj2U3NNSWwqXXZAAjUeoep4+CcUHb+z9WX2e3VmIDMizxsROgQIndw4caqkdQ4YYpnOuyx/EqE2EX9/7r4LUeUe4xe3wCJOuSGn6iNUUFgUX+Vlc0bnVxyTZEmuKiIct//4tuPhh+BEi8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::9) by ZQ0PR01MB1079.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.29; Wed, 7 Feb
 2024 03:09:27 +0000
Received: from ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 ([fe80::9d68:58f1:62cc:f1d3]) by
 ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn ([fe80::9d68:58f1:62cc:f1d3%4])
 with mapi id 15.20.7249.032; Wed, 7 Feb 2024 03:09:27 +0000
From: Yuklin Soo <yuklin.soo@starfivetech.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Yuklin Soo
	<yuklin.soo@starfivetech.com>, Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Hal Feng
	<hal.feng@starfivetech.com>, Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Jianlong Huang <jianlong.huang@starfivetech.com>, Emil Renner Berthing
	<kernel@esmil.dk>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Drew
 Fustini <drew@beagleboard.org>
CC: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: RE: [RFC PATCH 6/6] riscv: dts: starfive: jh8100: add pinctrl device
 tree nodes
Thread-Topic: [RFC PATCH 6/6] riscv: dts: starfive: jh8100: add pinctrl device
 tree nodes
Thread-Index: AQHaM+jja8Wq/pzVbUi0DezG4tUmILCzXaqAgEsZx/A=
Date: Wed, 7 Feb 2024 03:09:27 +0000
Message-ID:
 <ZQ0PR01MB1302882D6B43D18351D4169AF645A@ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn>
References: <20231221083622.3445726-1-yuklin.soo@starfivetech.com>
 <20231221083622.3445726-7-yuklin.soo@starfivetech.com>
 <f72b6ea4-a99b-4821-bb35-ee47b7b5cb8f@linaro.org>
In-Reply-To: <f72b6ea4-a99b-4821-bb35-ee47b7b5cb8f@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ0PR01MB1302:EE_|ZQ0PR01MB1079:EE_
x-ms-office365-filtering-correlation-id: 7d8ce68a-7992-4b76-4a4b-08dc278a31f4
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 QLnj6Ik4QbXduD5obdOWrGcT4P1C2/30mQpk5Cb+7j+AXz9DzOZ4tyIpwSCAerv5JUFuEreh+T8D9Mure+pF+YBhUahVZZ1F21GF2AjK7dnOWkz8/cJz1jLW4JBtDQxXQH6i44MHatvtIQ0Wbq56S5Yd4cBthzvtQTngiXrk4glZfvkKQ4fh3OlSGomA4yFtMiUXwazhZZQ27lko/gER0Vo3lAlhOvhNfPhWaIUzYn0K6n2lm3QP51eEF/83juNJQw6cvx8jzAgpYpIdrieJ5K5DahP9a23HBxlTkgfxEp6cveTqGm+zhOBwQbbGMw3CEwVSFolBs1o/g8gGBF98llv5t4cAB/DZBqpoPVLNgAAC2fjaAF6uFpswg9ac/6QX+x9gLUrBZEHo6Nj/F6XoU7jRZoP97dIjtPtAKvAppcSkG5rhJd+LWu228Y+/yoG8Bffhil3GxDh2QYDW2oIUlSMS0ztsYIzOUUnrJlYUVcUxQmPJ9c+gbJQYaUxKFyy+S1Lyg1nJLHyVwnQO3oIqPRAzlBnAFV4Vk7epH0q/Gtf8qh3kkAueIVy6YlZnjgYBlNZPaFPEQNYX75LRudwKGA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39830400003)(366004)(136003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(40160700002)(7696005)(33656002)(53546011)(38100700002)(41320700001)(122000001)(55016003)(83380400001)(86362001)(41300700001)(9686003)(7416002)(4326008)(76116006)(8936002)(8676002)(71200400001)(508600001)(2906002)(5660300002)(921011)(966005)(44832011)(66556008)(66476007)(66946007)(66446008)(64756008)(54906003)(40180700001)(110136005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eWlYaFVQakRENEZ2Ni9lZGFoRHJ0UUFEOHpwOE9MZVBXMGRBZy9xcU5wWE96?=
 =?utf-8?B?dkZCczZnSjZDRHVvSDlXdFlIOUpkcGJzT0FFWmhsZHJjMDlyd3Y2U2VVZStX?=
 =?utf-8?B?YndibDFQU3NwdG4xY2gxY2VCTnVNdTdhcjU4WlhDWE5abWwvUzJackt3ODJ2?=
 =?utf-8?B?TFVmUUhsSlJIeENiZ3d1Y1N4dW15dy96Q3lTQ2thUjhMMnY2RHg0NGNsekJZ?=
 =?utf-8?B?cVhvZTBzZTdvK3NEYThHTnVReW9UUk1FMVp3U1R4ZjMzbmgvYUhZSUpQUXAr?=
 =?utf-8?B?Qzc2OFNLcDRDQVk2cHdSVTRmSnNMZHNQTkVkTmE5OHVkTXJCcnlZMjZYMCtu?=
 =?utf-8?B?QlNHQzdRZWJ0eTMwcVUxYURVc0dHKzRsZk5RMmZZVG1UdUx3aFd5TWJ3dndq?=
 =?utf-8?B?YlFjd253S2RpUGZqQmdPcDFiNVMraEtEeXBJajVZSkVxSGU4MFdvdFJDTmRY?=
 =?utf-8?B?M1lBVnVVSEsrbC8xRVRKZjRQOXZUdGpPbXFjRjQvZXZ3UFRnZjUwdjFDQ0VQ?=
 =?utf-8?B?NTAxY0h6eFZKcjB6NGM2NDJWQUwzRnlYdDV2c3pFTTVzYTZzbkQyZFFyN3hl?=
 =?utf-8?B?ZURTdVMzWUxBZXhyYnFVYmNqeTlhZVZ4RU8vcnJ4LzdWV1V3RXBCcmJ5eTV1?=
 =?utf-8?B?TmRvWmlvSmg1OFRhTjl4MU4xc0Z6QlJzSE9rVk9Bald4UHpHNnV0UGVZV0ti?=
 =?utf-8?B?dmpSR1dBOUVVcFdaY2ZKUUtBaEhrWmRzNDNvTHl2dUE0M0FGemk1aXg0MnBI?=
 =?utf-8?B?Z1RIWmFrUFNnQ2JjeXkzQWdkekdWSnZwUUIzZ1ZGY1dYUnhOYzJEbExTZ3ZD?=
 =?utf-8?B?UjZhREdHcmRaT255MG0vc1RLT2NqZmdSeG9BeGtGRHRrQlZzWFR3OVNCZEJC?=
 =?utf-8?B?ZzZjT3dYRWFPN2djT3pEQ0lKb1YwWmdPbXhmWkZxajlsWEUxUE80T0VOUE5p?=
 =?utf-8?B?UVczWTV0M29aY1k5Vy9oK1d0VUU1U2xYZEZCaUYzbGsyWWxLUk43MDBaTGgz?=
 =?utf-8?B?YjB3Y0kyQXhlOFhYM1lFb3BJZTlwWUpMcVhRVEgvREpYQzM2RWV5Mk5zWUds?=
 =?utf-8?B?REhDRG9zS1BaRnJtdy9tMkVXUlNpWnJjdFJ5T3F3aW1yS0JuWnl0RkI0QWZr?=
 =?utf-8?B?Wk5VcTZnKzRUd0l2d0JhbWFZcEU2Ny9xRjlUNDR0QnkvUUJmQWdFOUNabkJQ?=
 =?utf-8?B?VUljUGZYb0p3MnhUMkJRaUorWFQ5K0lRMTZjcHBRZ2xaTjVreWIvZHBLdERw?=
 =?utf-8?B?YnZqbld6Z1pGLzBxTjdSbitzcFpPK2hKTjB2YzlWYkdLdDJtdjhKL3FINDQ4?=
 =?utf-8?B?TUxDTVZIeGRaVE1DRlB2V1hEQ3IyekFWdnFPZGFrdWhVamllVXJhdTFqN0R5?=
 =?utf-8?B?OS9hbDVxbUhHS1NWaXRwNWVtVy9QT1drbkJid3ZDMHlDSEVQRnFDWmQ0dDNK?=
 =?utf-8?B?VmhTWng3QzZ4bkFXcVpITUhWTTQrQVdnd0FqZnZFWEFacm1JWGJGOGZMNXBa?=
 =?utf-8?B?dVFOUmRaUjVOR2tTTFV4c1FyRTNLVjJOWXVmRUFuTWpqTXRqejdYZlVrbG1S?=
 =?utf-8?B?ME90cVFZY0tKUHJSQWVIK0QxY1M4SlRYRmZOWFBYY29rY1h1THo2ZkltM2Fs?=
 =?utf-8?B?YXJPb2NncWxGL0tTZ0cxb1p4dDJpcWk0V0ovQkd2TVdOVnZaYjZHZjh2VXE5?=
 =?utf-8?B?cjZZMmxGaWh4bVZ6R0dPOHdTQUdZb2NCdkJmOTdHNXFmMFBTNTNvQUp0alFJ?=
 =?utf-8?B?enFwQnJscEJ5S3F4bE5ZTTdPYTlpQVRYajB5UlpkODZmRnhTWVg0TjlESVhW?=
 =?utf-8?B?L0I1WW5WMVhhOEVFem53UXh6WDJkSGFxOENUNmk1bTJNL2ljd2E1K0Z3OGtM?=
 =?utf-8?B?UlZHam15Tys3REY1UFo5QVdHUHI3RlFRUmpFOGp3OGR2eXU1NkxDTm1ibytu?=
 =?utf-8?B?dGFYNzNkTjl2U1BMQlE1bGgyVWs3QmtkY0tLeXE2UGsyamdMNDZrSFFVVXlX?=
 =?utf-8?B?RkRsYnY4bUoybDAxU0xrWlhWSXB4YXZaMkxoWDJBMEpVdFNmcHNOWkEwY3Jk?=
 =?utf-8?B?SktOWWM3SC9TRFFOc0JqM3lZZEw5V0VGR0kra0paVldIeTY4TDhqejdRQWxR?=
 =?utf-8?B?WUJrWUFjMnRLV1c1c0tNdEsvZTNDa0FSYnNET1E2NjNoZkZ0YkwxNHBwNEFN?=
 =?utf-8?B?YTU3YlJhVlo2aTJXaDcrK0J6TlR3WGErMVdzQzV3NitNbXY0dHdsWHk2RmtP?=
 =?utf-8?B?VEJ4STI5WkJ2dXZnc29RelhGQU5BPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d8ce68a-7992-4b76-4a4b-08dc278a31f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2024 03:09:27.6388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SHCPU0BvT2V824/C7tIil4lvWcRBph0jpUTz5yzqdOuKBzalfJEGYAq6bhRQcgE25O650bRwObDAlfa/+obWtCpLfQQDF6NI4IV0c2QPj/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1079

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBUaHVyc2RheSwg
RGVjZW1iZXIgMjEsIDIwMjMgMTE6NTMgUE0NCj4gVG86IFl1a2xpbiBTb28gPHl1a2xpbi5zb29A
c3RhcmZpdmV0ZWNoLmNvbT47IExpbnVzIFdhbGxlaWoNCj4gPGxpbnVzLndhbGxlaWpAbGluYXJv
Lm9yZz47IEJhcnRvc3ogR29sYXN6ZXdza2kNCj4gPGJhcnRvc3ouZ29sYXN6ZXdza2lAbGluYXJv
Lm9yZz47IEhhbCBGZW5nIDxoYWwuZmVuZ0BzdGFyZml2ZXRlY2guY29tPjsNCj4gTGV5Zm9vbiBU
YW4gPGxleWZvb24udGFuQHN0YXJmaXZldGVjaC5jb20+OyBKaWFubG9uZyBIdWFuZw0KPiA8amlh
bmxvbmcuaHVhbmdAc3RhcmZpdmV0ZWNoLmNvbT47IEVtaWwgUmVubmVyIEJlcnRoaW5nDQo+IDxr
ZXJuZWxAZXNtaWwuZGs+OyBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPjsgS3J6eXN6dG9m
IEtvemxvd3NraQ0KPiA8a3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnPjsgQ29ub3Ig
RG9vbGV5IDxjb25vcitkdEBrZXJuZWwub3JnPjsNCj4gRHJldyBGdXN0aW5pIDxkcmV3QGJlYWds
ZWJvYXJkLm9yZz4NCj4gQ2M6IGxpbnV4LWdwaW9Admdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgt
cmlzY3ZAbGlzdHMuaW5mcmFkZWFkLm9yZzsgUGF1bCBXYWxtc2xleQ0KPiA8cGF1bC53YWxtc2xl
eUBzaWZpdmUuY29tPjsgUGFsbWVyIERhYmJlbHQgPHBhbG1lckBkYWJiZWx0LmNvbT47DQo+IEFs
YmVydCBPdSA8YW91QGVlY3MuYmVya2VsZXkuZWR1Pg0KPiBTdWJqZWN0OiBSZTogW1JGQyBQQVRD
SCA2LzZdIHJpc2N2OiBkdHM6IHN0YXJmaXZlOiBqaDgxMDA6IGFkZCBwaW5jdHJsIGRldmljZSB0
cmVlDQo+IG5vZGVzDQo+IA0KPiBPbiAyMS8xMi8yMDIzIDA5OjM2LCBBbGV4IFNvbyB3cm90ZToN
Cj4gPiBBZGQgcGluY3RybF9lYXN0L3BpbmN0cmxfd2VzdC9waW5jdHJsX2dtYWMvcGluY3RybF9h
b24gZGV2aWNlIHRyZWUNCj4gPiBub2RlcyBmb3IgSkg4MTAwIFNvQy4NCj4gPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IEFsZXggU29vIDx5dWtsaW4uc29vQHN0YXJmaXZldGVjaC5jb20+DQo+ID4gUmV2
aWV3ZWQtYnk6IExleSBGb29uIFRhbiA8bGV5Zm9vbi50YW5Ac3RhcmZpdmV0ZWNoLmNvbT4NCj4g
DQo+IEkgaGF2ZSBzb21lIGRvdWJ0cyBhYm91dCBpdC4uLg0KPiANCj4gPiAtLS0NCj4gPiAgYXJj
aC9yaXNjdi9ib290L2R0cy9zdGFyZml2ZS9qaDgxMDAtZXZiLmR0cyAgIHwgICA1ICsNCj4gPiAg
YXJjaC9yaXNjdi9ib290L2R0cy9zdGFyZml2ZS9qaDgxMDAtcGluZnVuYy5oIHwgNDE4ICsrKysr
KysrKysrKysrKysrKw0KPiA+ICBhcmNoL3Jpc2N2L2Jvb3QvZHRzL3N0YXJmaXZlL2poODEwMC5k
dHNpICAgICAgfCAgNDQgKysNCj4gPiAgMyBmaWxlcyBjaGFuZ2VkLCA0NjcgaW5zZXJ0aW9ucygr
KQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9yaXNjdi9ib290L2R0cy9zdGFyZml2ZS9q
aDgxMDAtcGluZnVuYy5oDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9ib290L2R0
cy9zdGFyZml2ZS9qaDgxMDAtZXZiLmR0cw0KPiA+IGIvYXJjaC9yaXNjdi9ib290L2R0cy9zdGFy
Zml2ZS9qaDgxMDAtZXZiLmR0cw0KPiA+IGluZGV4IGMxNmJjMjVkODk4OC4uODYzNGU0MTk4NGY4
IDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvcmlzY3YvYm9vdC9kdHMvc3RhcmZpdmUvamg4MTAwLWV2
Yi5kdHMNCj4gPiArKysgYi9hcmNoL3Jpc2N2L2Jvb3QvZHRzL3N0YXJmaXZlL2poODEwMC1ldmIu
ZHRzDQo+ID4gQEAgLTI2LDMgKzI2LDggQEAgbWVtb3J5QDQwMDAwMDAwIHsNCj4gPiAgJnVhcnQw
IHsNCj4gPiAgCXN0YXR1cyA9ICJva2F5IjsNCj4gPiAgfTsNCj4gPiArDQo+ID4gKyZwaW5jdHJs
X2FvbiB7DQo+IA0KPiBXcm9uZyBvcmRlci4gTm9kZXMgZG8gbm90IGdvIHRvIHRoZSBlbmQuDQoN
CkNvdWxkIHlvdSBwbGVhc2UgZXhwbGFpbiB3aGF0IGlzIG1lYW50IGJ5IOKAnE5vZGVzIGRvIG5v
dCBnbyB0byB0aGUgZW5kLuKAnT8gSG93IGl0IGNhdXNlcyB3cm9uZyBvcmRlcj8NCg0KPiANCj4g
PiArCXdha2V1cC1ncGlvcyA9IDwmcGluY3RybF9hb24gUEFEX1JHUElPMiBHUElPX0FDVElWRV9I
SUdIPjsNCj4gPiArCXdha2V1cC1zb3VyY2U7DQo+IA0KPiBOb25lIG9mIHRoZXNlIHdlcmUgdGVz
dGVkLg0KPiANCj4gSXQgZG9lcyBub3QgbG9vayBsaWtlIHlvdSB0ZXN0ZWQgdGhlIERUUyBhZ2Fp
bnN0IGJpbmRpbmdzLiBQbGVhc2UgcnVuIGBtYWtlDQo+IGR0YnNfY2hlY2sgVz0xYCAoc2VlIERv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy93cml0aW5nLXNjaGVtYS5yc3QNCj4gb3Ig
aHR0cHM6Ly93d3cubGluYXJvLm9yZy9ibG9nL3RpcHMtYW5kLXRyaWNrcy1mb3ItdmFsaWRhdGlu
Zy1kZXZpY2V0cmVlLQ0KPiBzb3VyY2VzLXdpdGgtdGhlLWRldmljZXRyZWUtc2NoZW1hLw0KPiBm
b3IgaW5zdHJ1Y3Rpb25zKS4NCg0KVGhlIOKAnHBpbmN0cmxfYW9u4oCdIGRvY3VtZW50IGhhcyBi
ZWVuIHVwZGF0ZWQ6DQoNCiAgd2FrZXVwLWdwaW9zOg0KICAgIG1heEl0ZW1zOiAxDQogICAgZGVz
Y3JpcHRpb246IEdQSU8gcGluIHRvIGJlIHVzZWQgZm9yIHdha2luZyB1cCB0aGUgc3lzdGVtIGZy
b20gc2xlZXAgbW9kZS4NCg0KICB3YWtldXAtc291cmNlOg0KICAgIG1heEl0ZW1zOiAxDQogICAg
ZGVzY3JpcHRpb246IHRvIGluZGljYXRlIHBpbmN0cmwgaGFzIHdha2V1cCBjYXBhYmlsaXR5Lg0K
DQpSdW5uaW5nIOKAnG1ha2UgZHRfYmluZGluZ19jaGVja+KAnSBhbmQg4oCcbWFrZSBkdGJzX2No
ZWNr4oCdIHRlc3RzIGFyZSBzdWNjZXNzZnVsLg0KV2lsbCBzZW5kIG91dCBpbiBuZXh0IHZlcnNp
b24uDQoNCj4gDQo+ID4gK307DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3YvYm9vdC9kdHMv
c3RhcmZpdmUvamg4MTAwLXBpbmZ1bmMuaA0KPiA+IGIvYXJjaC9yaXNjdi9ib290L2R0cy9zdGFy
Zml2ZS9qaDgxMDAtcGluZnVuYy5oDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRl
eCAwMDAwMDAwMDAwMDAuLjNmYjE2ZWY2MmQ5MA0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysg
Yi9hcmNoL3Jpc2N2L2Jvb3QvZHRzL3N0YXJmaXZlL2poODEwMC1waW5mdW5jLmgNCj4gPiBAQCAt
MCwwICsxLDQxOCBAQA0KPiA+ICsvKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCBP
UiBNSVQgKi8NCj4gPiArLyoNCj4gPiArICogQ29weXJpZ2h0IChDKSAyMDIzIFN0YXJGaXZlIFRl
Y2hub2xvZ3kgQ28uLCBMdGQuDQo+ID4gKyAqIEF1dGhvcjogQWxleCBTb28gPHl1a2xpbi5zb29A
c3RhcmZpdmV0ZWNoLmNvbT4NCj4gPiArICoNCj4gPiArICovDQo+ID4gKw0KPiA+ICsjaWZuZGVm
IF9fSkg4MTAwX1BJTkZVTkNfSF9fDQo+ID4gKyNkZWZpbmUgX19KSDgxMDBfUElORlVOQ19IX18N
Cj4gPiArDQo+ID4gKy8qDQo+ID4gKyAqIG11eCBiaXRzOg0KPiA+ICsgKiAgfCAzMSAtIDI0IHwg
MjMgLSAxNiB8IDE1IC0gMTAgfCAgOSAtIDggICB8ICA3IC0gMCAgfA0KPiA+ICsgKiAgfCAgZGlu
ICAgIHwgIGRvdXQgICB8ICBkb2VuICAgfCBmdW5jdGlvbiB8IGdwaW8gbnIgfA0KPiA+ICsgKg0K
PiA+ICsgKiBkb3V0OiAgICAgb3V0cHV0IHNpZ25hbA0KPiA+ICsgKiBkb2VuOiAgICAgb3V0cHV0
IGVuYWJsZSBzaWduYWwNCj4gPiArICogZGluOiAgICAgIG9wdGlvbmFsIGlucHV0IHNpZ25hbCwg
MHhmZiA9IG5vbmUNCj4gPiArICogZnVuY3Rpb246DQo+ID4gKyAqIGdwaW8gbnI6ICBncGlvIG51
bWJlciwgMCAtIDYzDQo+ID4gKyAqLw0KPiA+ICsjZGVmaW5lIEdQSU9NVVgobiwgZG91dCwgZG9l
biwgZGluKSAoIFwNCj4gPiArCQkoKChkaW4pICAmIDB4ZmYpIDw8IDI0KSB8IFwNCj4gPiArCQko
KChkb3V0KSAmIDB4ZmYpIDw8IDE2KSB8IFwNCj4gPiArCQkoKChkb2VuKSAmIDB4M2YpIDw8IDEw
KSB8IFwNCj4gPiArCQkoKG4pICYgMHgzZikpDQo+ID4gKw0KPiA+ICsjZGVmaW5lIFBJTk1VWChu
LCBmdW5jKSAoKDEgPDwgMTApIHwgKCgoZnVuYykgJiAweDMpIDw8IDgpIHwgKChuKSAmDQo+ID4g
KzB4ZmYpKQ0KPiA+ICsNCj4gPiArLyogc3lzX2lvbXV4X2Vhc3QgZG91dCAqLw0KPiA+ICsjZGVm
aW5lIEdQT1VUX0xPVwkJCQkwDQo+ID4gKyNkZWZpbmUgR1BPVVRfSElHSAkJCQkxDQo+IA0KPiBX
aGVyZSBhcmUgdGhlc2UgdXNlZD8NCg0KVGhlc2UgbWFjcm9zIGFyZSB1c2VkIHRvIHNldCB0aGUg
bG9naWMgbGV2ZWwgb2YgYSBwaW4gdG8gMCBvciAxIHJlc3BlY3RpdmVseToNCg0KICAgICAgICBj
YW4wX3BpbnM6IGNhbjAtZ3JwIHsNCiAgICAgICAgICAgICAgICBjYW4wX3J4LXBpbnMgew0KICAg
ICAgICAgICAgICAgICAgICAgICAgcGlubXV4ID0gPEdQSU9NVVgoUEFEX0dQSU8yOF9FLCBHUE9V
VF9MT1csDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEdQT0VOX1NZU19ESVNBQkxF
LCBHUElfU1lTX0NBTjBfUlhEKT47DQogICAgICAgICAgICAgICAgICAgICAgICBiaWFzLXB1bGwt
dXA7DQogICAgICAgICAgICAgICAgICAgICAgICBpbnB1dC1lbmFibGU7DQogICAgICAgICAgICAg
ICAgfTsNCg0KSG93ZXZlciwgICIgR1BPVVRfTE9XIiBhbmQgIiBHUE9VVF9MT1ciIHdpbGwgYmUg
cmVtb3ZlZCBmcm9tDQoiYXJjaC9yaXNjdi9ib290L2R0cy9zdGFyZml2ZS9qaDgxMDAtcGluZnVu
Yy5oIiwgYW5kIGtlcHQgaW4NCiIgaW5jbHVkZS9kdC1iaW5kaW5ncy9waW5jdHJsL3N0YXJmaXZl
LGpoODEwMC1waW5jdHJsLmgiLg0KDQo+IA0KPiA+ICsjZGVmaW5lIEdQT1VUX1NZU19DQU4wX1NU
QlkJCQkyDQo+ID4gKyNkZWZpbmUgR1BPVVRfU1lTX0NBTjBfVFNUX05FWFRfQklUCQkzDQo+ID4g
KyNkZWZpbmUgR1BPVVRfU1lTX0NBTjBfVFNUX1NBTVBMRV9QT0lOVAkJNA0KPiA+ICsjZGVmaW5l
IEdQT1VUX1NZU19DQU4wX1RYRAkJCTUNCj4gPiArI2RlZmluZSBHUE9VVF9TWVNfSTJDMF9DTEsJ
CQk2DQo+ID4gKyNkZWZpbmUgR1BPVVRfU1lTX0kyQzBfREFUQQkJCTcNCj4gPiArI2RlZmluZSBH
UE9VVF9TWVNfSTJTMF9TVEVSRU9fUlNDS08JCTgNCj4gDQo+IFlvdSBhZGQgaGVyZSBidW5jaCBv
ZiBjb25zdGFudHMgbm90IHVzZWQgYW55d2hlcmUuIE5vIHNpbmdsZSBleGFtcGxlIG9mDQo+IHRo
ZWlyIHVzYWdlLCBub3QgYSBvbmUuDQoNClRoZXNlIGNvbnN0YW50cyBhcmUgaW5kZXhlcyBvZiBv
dXRwdXQgc2lnbmFscywgYW5kIGl0IGlzIHBhcnQgb2YgdGhlIHBpbm11eCB2YWx1ZQ0KdG8gYmUg
d3JpdHRlbiB0byBhbiBpb211eCByZWdpc3RlciB0byBjb25maWd1cmUgd2hpY2ggb3V0cHV0IHNp
Z25hbCB3aWxsIGdvIHRocm91Z2gNCndoaWNoIEdQSU9fUEFELg0KDQpGb3IgaTJjLTAsICANCg0K
I2RlZmluZSBHUE9VVF9TWVNfSTJDMF9DTEsJCQk2DQojZGVmaW5lIEdQT1VUX1NZU19JMkMwX0RB
VEEJCQk3DQoNCk91dHB1dCBzaWduYWwgIkdQT1VUX1NZU19JMkMwX0NMSyIgZ29lcyB0aHJvdWdo
IFBBRF9HUElPOV9FLg0KT3V0cHV0IHNpZ25hbCAiR1BPVVRfU1lTX0kyQzBfREFUQSIgZ29lcyB0
aHJvdWdoIFBBRF9HUElPMTBfRS4NCg0KICAgICAgICBpMmMwX3BpbnM6IGkyYzAtZ3JwIHsNCiAg
ICAgICAgICAgICAgICBpMmMwLXNjbC1waW5zIHsNCiAgICAgICAgICAgICAgICAgICAgICAgIHBp
bm11eCA9IDxHUElPTVVYKFBBRF9HUElPOV9FLCBHUE9VVF9TWVNfSTJDMF9DTEssDQogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgR1BPRU5fU1lTX0kyQzBfQ0xLLA0KICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIEdQSV9TWVNfSTJDMF9DTEspPjsNCiAgICAgICAgICAg
ICAgICAgICAgICAgIGJpYXMtcHVsbC11cDsNCiAgICAgICAgICAgICAgICAgICAgICAgIGlucHV0
LWVuYWJsZTsNCiAgICAgICAgICAgICAgICB9Ow0KDQogICAgICAgICAgICAgICAgaTJjMC1zZGEt
cGlucyB7DQogICAgICAgICAgICAgICAgICAgICAgICBwaW5tdXggPSA8R1BJT01VWChQQURfR1BJ
TzEwX0UsIEdQT1VUX1NZU19JMkMwX0RBVEEsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgR1BPRU5fU1lTX0kyQzBfREFUQSwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBHUElfU1lTX0kyQzBfREFUQSk+Ow0KICAgICAgICAgICAgICAgICAgICAgICAgYmlhcy1w
dWxsLXVwOw0KICAgICAgICAgICAgICAgICAgICAgICAgaW5wdXQtZW5hYmxlOw0KICAgICAgICAg
ICAgICAgIH07DQogICAgICAgIH07DQoNCldpbGwgYWRkIHRoZSBhYm92ZSB0byBkZXZpY2UgdHJl
ZSBmb3IgbmV4dCB2ZXJzaW9uLg0KDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0K
DQo=

