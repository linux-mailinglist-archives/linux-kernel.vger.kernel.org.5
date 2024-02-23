Return-Path: <linux-kernel+bounces-77715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E99860960
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 04:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46E781C229C6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 03:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17ACDDA6;
	Fri, 23 Feb 2024 03:27:26 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2103.outbound.protection.partner.outlook.cn [139.219.17.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3119CC2C6;
	Fri, 23 Feb 2024 03:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708658846; cv=fail; b=oXfV9Qv7soRmEJI1PriiwFxfAdd3XoqEahcwRlwFIQ8jsCAGl/jRGCle6sTnbKQSSJn4xzHpUfJqFs9HnnrtEuD8neDLKJNRyFZ3TAtzaNSqM1NwCSligkz4DT33K2caL7OxM5rkoVrFqFNWsGGPdBWjeYfA/izR/8s5nCP6rlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708658846; c=relaxed/simple;
	bh=oJKxtjJvPnbkfw6j3TVtscM8YI1C3KKUDdKGDfAVBlo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q4AjpkJtSWE0uhj4Z64y6MXxohbFIXgKjGQE/zWlB0M9SJ0dj0Y57MA2C3uF08Qveoe5EdiuBhmJRpUr/BEYAJeIhqO6rz29i4G9DBJZ3BDV9koLQs9n0A4GcZ8ueGwtx36+kZQRwv+b1/mrRyyB3nkAni/Fp6PudkwMTZu7dwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y0qyR53FMaWbOak0iExzZcgWEXRT1CkCytVPQFPzrzCYh4KZFEbzQz7YJJgw9fNaGl8XMxk0tr1wQxbKW1QLNKot5hk1x5qglgccSB+JpWs2ntJKO/zjv/dohRcQ7cdKxyOU/KZcx907j6jAsYqESjdigJYkI8Z1xYnVd8A7ch7pMK9DCoVYaGgBK1LbrWvuTlo6N2QUxDGnp1490SEwkiLRQB+O0UEuOJfaGunT4R5+6IkexWjNJIGdtC3qtHkL7uTkNO3w0IkiM6DVpovMlYUqGyLcW8W+wZ0M29eYDqTjawWRpPbRdxIQV/DJ7PF9pM1KsZiHaTya6ZzNNBLxlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oJKxtjJvPnbkfw6j3TVtscM8YI1C3KKUDdKGDfAVBlo=;
 b=CQhv6uJgd2Eh1iGT5WMV/O8Q+0I7Xb2JUoq7cCdc84Ko7+qaYrq58ndvMXsEu3Yj3PxFEw/sWhhZf1DtZnbKTT41xsDYjWCQiGVUd7vXXBg8AlgFFkrLsiNNdNuqj2mTiisSVlTCU0m91BqrtUJNOuCGfHvc1ig14w2oYlfNIUYY5eKLRpxuDqV+VtXOboKs4eLUDYGa4AG+LnANtY+U21tSBMVd2/PIhnj/Sh1nNXXXBvrtzTSyYuutz4DE9lFIMoitjl0bE4jsDgjqT2IxpWFVYlfpx+SPg7THbRUIAwLmkYo5zhSgwGg72mNdf7pwO7HAHqTrgEIULzNLJTqMow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0845.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.47; Fri, 23 Feb
 2024 02:53:36 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::b0af:4c9d:2058:a344]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::b0af:4c9d:2058:a344%6])
 with mapi id 15.20.7249.041; Fri, 23 Feb 2024 02:53:36 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Jai Luthra <j-luthra@ti.com>, Tomi Valkeinen
	<tomi.valkeinen@ideasonboard.com>, Mauro Carvalho Chehab
	<mchehab@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Hans
 Verkuil <hverkuil-cisco@xs4all.nl>, Vaishnav Achath <vaishnav.a@ti.com>,
	Maxime Ripard <mripard@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>
CC: "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Vignesh
 Raghavendra <vigneshr@ti.com>, Aradhya Bhatia <a-bhatia1@ti.com>, Devarsh
 Thakkar <devarsht@ti.com>, Jack Zhu <jack.zhu@starfivetech.com>, Julien
 Massot <julien.massot@collabora.com>, Jayshri Pawar <jpawar@cadence.com>
Subject:
 =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggUkZDIDAwLzIxXSBtZWRpYTogY2FkZW5jZSx0aTog?=
 =?utf-8?Q?CSI2RX_Multistream_Support?=
Thread-Topic: [PATCH RFC 00/21] media: cadence,ti: CSI2RX Multistream Support
Thread-Index: AQHaZYLyz20pRFMaSU2WOsA6GWwHNbEXOg7g
Date: Fri, 23 Feb 2024 02:53:36 +0000
Message-ID:
 <SHXPR01MB06714030189A3CFD430A88EEF255A@SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn>
References: <20240222-multistream-v1-0-1837ed916eeb@ti.com>
In-Reply-To: <20240222-multistream-v1-0-1837ed916eeb@ti.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SHXPR01MB0671:EE_|SHXPR01MB0845:EE_
x-ms-office365-filtering-correlation-id: daa0fd9f-e4ad-4c2a-d288-08dc341aa166
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Eir8f7Oht5lIvZG5bPQhT1NYnEh89bqEpS+ZpCAAW8Jlu+Qpr/T/4hKb/CqdHyQhcx38JyZMi8kjUur2p6v2i5G9tRSlC9zx1SkTOJQDohC7L2YP7EAMZfDd0o9Mk7DqUNpO5gVURT/suDmJucwxBdxZWbDe3OpK4xO8LDwM88IfZP1PI9HRYss8SXOO+3vMcu9dM3iE4e0kG5SNn4R/Ls7axoofpus0QeXV6Uv+lTTEWPIQtTPlINB+4kVltIr4N53TtqgROeIaCsH1k/adOY4kwNWVgw665jW2n1lE1uhwgeQq89BEMSjfD+bSmUe/IPnjURwM2bbGsA4rJSPq1j1roAcfaWP5A5xAqgFAt5zW+6LkuLoirx/oVJMVVcPF74utaVylfdpkhPz8MvGm2CBHxBtfnKn8VBpgQHxTLF4sfX8u8/VH/Y5XEWEjaVtoqHCobOOL/NU5cRNFKpeoVIWOallQwA0Kx00/eJELgwhFjZFcWezn62l+7/jfJuKyq74VIVrUESLNLTd9YOx7M/mS6AeGWDJsnIqL+fC5pe0o6hSim+7axHX596jrHzUxXzKbrCPQ+PHsRLRqNSrCJg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(38070700009)(921011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NUtZUGRXUHVDbjN5OThHSjcwVksyK052U1U3YTNvcXpOeUhtcGx1TjRRMG1T?=
 =?utf-8?B?MzlnV3FVSzZIY240dnlLZlVvN05XVHkyazNLbkRLWCtEc01OTzh5T3hlenNl?=
 =?utf-8?B?dm9MdVNtdFNvelY5d3V3RnlIQzIvdzZ0alBZMlg3NTZkYWkvWVJsaldzalhL?=
 =?utf-8?B?UjRCdVhBeUpkNHBQTmJyQzA4SVpzVy9rT2JoZnpEY0N0bUQyaGM3dmdRVlFt?=
 =?utf-8?B?NjY2eUEwTUZLTHl1VkdZM245UWpyQjhBVTR4d3k3Wk9vNFhIZGhtMU9CNURU?=
 =?utf-8?B?d3RQZUxteVpNNjRUSVBkT1FmNUV2TndMK1RmM2tEaXVNbk9DSDRmMmRVdXJ5?=
 =?utf-8?B?emYwZEZQME5Yb2YwdHdKT3Y4VE1aMUxTVFdYd01BYzMvQkl2TGJIaW1ydWov?=
 =?utf-8?B?QVVzQnVRSTNrMHdqNWsrZ3hSMm9RZTFnS2F0a2Q0MEhLOFhZZHVkNU1lL0xE?=
 =?utf-8?B?b0RrVm9EYU10Ky9QR0l2U3VhSCsyRStnMkdyK3RVdVU1ZjNXd0Y4alFEWWV3?=
 =?utf-8?B?STRRY1lzMExWWk5CSEtCQXNrUFRLelQ0STU3R1RrWUJmUEVkakppYVZSUzJE?=
 =?utf-8?B?aFZiR05GUE85Q3hqeDRjMURUNnI5RVZlUFFKZXhKSk9XS08vaUhNTVdzZlJq?=
 =?utf-8?B?Rmluais1b2MyNU0xVVE5ZU45RS8yMU9HUjMyNFNJemFMYXg4dVBrSDdFQXAy?=
 =?utf-8?B?RVVBVWRNVGNVYU15S3BLeDdYSWliNUZWZWdYdFZkNUNpOW9HWHFxcHF6RnRJ?=
 =?utf-8?B?MHBQY01TWUtSdFl0Rm8wZWdoWVgrRlJicDdYSUgySm4rMHFTR29jbGtxN0ZT?=
 =?utf-8?B?WjUrcHV2ZlFGVWVlQVJIdE84MFNCbVpHUTZheFErZWFPZ2ZCWlJFYWxqdWo2?=
 =?utf-8?B?R1p0Ymc3dnpZMnpRRDU5Ny9LY1ovcks4TmFHdGNVZjVJemhlb2M4SURkNVN0?=
 =?utf-8?B?cFp1c1RaVEN0SzcrUVU0dnJMOGhGMS94OG1CZTBtTjVmUVEzTk1od3E3MVUv?=
 =?utf-8?B?UURFd1FiYUdSb2ZLZnZ6ckR4dFNTazQvdW1FQzhXRmVEdFhrRU5SUkV5V081?=
 =?utf-8?B?OXdkeXc5Ri9WUlpWUzFSREhBNklvaHBYZFJOSGNqVGhBMW1TS04wWWtSZ0lq?=
 =?utf-8?B?eHhUVTh2RldKYjJ2K2x0enREV3ZjN28vbi8wdnZXYm9wZFNMclM5MzVVUklQ?=
 =?utf-8?B?aS9lRE9IWi9HeUVxOHcvSjAyb2F6NjBwaWMzdHMxRmV2cHVUb2g0TEUzYVFS?=
 =?utf-8?B?eitEeWN4MC84TFVTYWhsYXFnV0o4aE5peVpybyt3c2prbUVsVkZRSElUdVNv?=
 =?utf-8?B?Q3I5YkxXdDFOaXBqWkhMNTl5REhzVFd3Y3hrWmNaY0dObHBFNnZ1VVFoYy9B?=
 =?utf-8?B?bGxISlR5TDV0eGxnbzF2c0cwRkNmdERhR2d1b0hRU05nY3BPb3BmL0ZUZkNS?=
 =?utf-8?B?LzZPWjNUOXErRFBHdzVsN3ZnMjRrLytNY1pNaU54VHJVZ0VOWUFQc0krdmFa?=
 =?utf-8?B?TTdiRDFMNFJ4WG96SkgzdWJaRTlVUnlJK3RkWVpWQ0FqaUFXMUU3MmpRTis2?=
 =?utf-8?B?bGVjY0dQSktXdjB3YlJMeHNFdmpwWlIzSEw1dTMyemdFcG5EdXVQMnZBQXp0?=
 =?utf-8?B?M0VSMmM2Sjc3QzRzQmFOYzJENm10ZnJhdTROUlg5MDZMK2E5dWFvdFArY2RY?=
 =?utf-8?B?Z09WbEhzS2t3dGtoNWozK2NtM0VmZjNpQ3dpMmgzN0tueWNBTmx1UHdSK1Nw?=
 =?utf-8?B?SHBHd1I4cVlubUhFUGhqVWF4VU1VSTdwS1BpaitNZmdDVWhuSEJWeWt1cyto?=
 =?utf-8?B?RzZobWc0QzFscytwQk1zUGtjMmxBdnQ5bkF3TGE4cllaTEFJL1lVR2ZLMWRP?=
 =?utf-8?B?OUYxbS9qSUY2NDNkK0ptSlZjVVVXT2ZrNHljT3Z2WEdVTHNWKy84WEZvZzhn?=
 =?utf-8?B?L05tMVVDeUlCR3dBZ3Z0Slg5TjFTMHM5T29iTE00aEw3d1lqOUQwYmVxa3cx?=
 =?utf-8?B?VGtGOERHUVRMU1dlRENNdDFLc01VUWI5R0QxcktQSU5uVkdaZ1hVczFlbkFR?=
 =?utf-8?B?ZUY4K1JMZ3hWT2UwRHNwc2R3Nmtlc1lFK2wweEtXbUEzOXNFOVUzQkhHeXlW?=
 =?utf-8?B?MXNhT25wS21YK1dHRGFRajBBNC80K3BPL0VmTGxQVmhWUlNVU3Uxem90NXFU?=
 =?utf-8?B?T2c9PQ==?=
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
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: daa0fd9f-e4ad-4c2a-d288-08dc341aa166
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2024 02:53:36.0841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u1sJvPCCdg25NKqV7hNnMktLSMK+LMw9R3C1pO87MxFw8UcE0e2Qu2kojH1Zc/3Y0vFv9UjiPlof3/pE8AWjkaRrzt26ij9BILgTzpPPBVtvLAmoScaL25di8VBlbHkz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0845

SGkgSmFpLA0KDQo+IFtQQVRDSCBSRkMgMDAvMjFdIG1lZGlhOiBjYWRlbmNlLHRpOiBDU0kyUlgg
TXVsdGlzdHJlYW0gU3VwcG9ydA0KWy4uLl0NCj4gIC4uLi9iaW5kaW5ncy9tZWRpYS90aSxqNzIx
ZS1jc2kycngtc2hpbS55YW1sICAgICAgIHwgIDQwICstDQo+ICBkcml2ZXJzL21lZGlhL3BsYXRm
b3JtL2NhZGVuY2UvY2Rucy1jc2kycnguYyAgICAgICB8IDQ2MCArKysrKysrKystLQ0KPiAgLi4u
L21lZGlhL3BsYXRmb3JtL3RpL2o3MjFlLWNzaTJyeC9qNzIxZS1jc2kycnguYyAgfCA4NTMNCj4g
KysrKysrKysrKysrKysrLS0tLS0tDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDEwNTIgaW5zZXJ0aW9u
cygrKSwgMzAxIGRlbGV0aW9ucygtKQ0KPiAtLS0NCj4gYmFzZS1jb21taXQ6IGQ4OTRhMmEyODZm
Y2NkNmU0N2NkMWNhYzRjMmQ0ZmY1ZDMwMGQ3YzcNCg0KQ2FuIHlvdSBwcm92aWRlIG1lIHdpdGgg
d2hlcmUgdGhpcyBjb21taXQgY29tZXMgZnJvbSwgSSBjYW4gb25seSANCmFwcGx5IHBhcnRpYWwg
cGF0Y2hzIHRvIHRlc3QuDQoNClRoYW5rcywNCkNoYW5naHVhbmcNCg==

