Return-Path: <linux-kernel+bounces-111261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5218869D7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D9821C2267D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C366A2DF9C;
	Fri, 22 Mar 2024 10:00:08 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2094.outbound.protection.partner.outlook.cn [139.219.146.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A951C224FA;
	Fri, 22 Mar 2024 10:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711101608; cv=fail; b=SSW6n/YtJ6amrH/LGM2J9h4TTvZ3yMzZo/TzqwNU7OELZwVND2m3NorMN8RfECcYfd7QpdaEdhjoZGXw0YcQTfygo5d4WVCoCpyBP+PYGA1oh0c6JEWCVbjoBNbBswnXe8qEWaawaCv93KSlPF6+FInx8ytnimReTYLZsqOv9R8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711101608; c=relaxed/simple;
	bh=nnjn6zU3N+Z7Zr1vOpWBk5H/GbQC1wT8XZ8vPYQtsHw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GRoMhApaIA7o+w5R2sQcKvxdsIj9eJ1nz35B5rLDnX3DKIYJCx68R6CYQyk7gJoqfn4r63Va04Um8LOn0LH0eQgQ7MuBJC0QOWv6rSk3IlXSbREKWLMOYZN+n3atjoKvosa9vTMegB71bxMfbDk0wpYMEhT8zhhNzO6ItqB1NBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wf3ZkexNydclEySS98OQGGHgUIsxQD4n+R+NHqz2PFuB+iPdt9P8pMKG/SEciUthfVZdRc2VsewiOu4mzoz4XkcLvQhqii/3sNn4wGMzBgRLCLPemFW4LFPPdbqoi70gawcYPWhgf8XRPYkO4+mrwMK+KS5+AvnH7tGDehsVW6oe5BxOCKPD2hkL8mrugOgO44GwpBW+yN75p5cHo2rQpe2KXuo9TUihpg3MVN6dSxg+TAlDE76G2agra63QhJ0jpfjqjO6NZiM5VNiGTlE8pegUgQQm3roKty2HfhqmwnRZsPPnWi9aN5VDSOqQmmQPAjMmhKHAzzN7woWHv1+OiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nnjn6zU3N+Z7Zr1vOpWBk5H/GbQC1wT8XZ8vPYQtsHw=;
 b=Xz+w6whMyMdabf9sTurkO2v1FDa7JUJhMuVJOmEo2BJG2VRl/kWGNwF84sEq85mJOQAeByTOM/LV23tlWXUpG9mb/1/5BZ8evsh4MdEzDg+Iapx9q5e7C0OolnVs63fpMFO+d+1FDPF3iAVtvFTX6dS9760Uw3RLmZ3osq3TxV/O3DSJJKjHB+QV5FlcIVd13/gN9LvsEDPFAXg8JvQkaEUF8bw/Jm3gSDdSg/vJ83iv6uUDpvEAUAG/UZErDIOzs2IvHEPFqsgpv+cYPA+TLIAAyVqujgw2hm1Y+ZLxWPRpcJN9KLu1PYc7f6oxQgrfZADTv9Avvt+6kboUkmR0VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0767.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:27::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.51; Fri, 22 Mar
 2024 09:26:23 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::b0af:4c9d:2058:a344]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::b0af:4c9d:2058:a344%6])
 with mapi id 15.20.7249.041; Fri, 22 Mar 2024 09:26:22 +0000
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
 =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggUkZDIDAzLzIxXSBtZWRpYTogY2FkZW5jZTogY3Np?=
 =?utf-8?Q?2rx:_Support_runtime_PM?=
Thread-Topic: [PATCH RFC 03/21] media: cadence: csi2rx: Support runtime PM
Thread-Index: AQHaZYLyEm4HbUx67EuitQv2Y7JSOrFDqZIA
Date: Fri, 22 Mar 2024 09:26:22 +0000
Message-ID:
 <SHXPR01MB0671C565B12032569CFACD6EF231A@SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn>
References: <20240222-multistream-v1-0-1837ed916eeb@ti.com>
 <20240222-multistream-v1-3-1837ed916eeb@ti.com>
In-Reply-To: <20240222-multistream-v1-3-1837ed916eeb@ti.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SHXPR01MB0671:EE_|SHXPR01MB0767:EE_
x-ms-office365-filtering-correlation-id: 093cda2b-4617-498b-36ed-08dc4a5223d0
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 JeUqzyuI12yqW0/UpvnJGMZvGTuUWCxmA5ncT8BIz5kmG2cJx5Dy85E7FZr2BwIcoOHO3ULde3jMDgTu5u7WmtrY4s9siWu+0PB4f/RjcdPk89GxXJ1I6TcUU9t3fCjoZktOrQzDI0vvMz/ZlDzlbDrlF2DhnIPK8Dp6TOMX+nmuucm9wqFTMrgtvhR/ngiSyfrjGSGYVNqeCeX4posRzSykzHpdc3nVRwOkoeAP4YgztL8/r08BTd06xrCEQcp2A9zZCIBm4lzqT6YmpQmqtd9Q5pfyRGAXd9zKR4OvfquNyOSIEDGlhdmWy94SwuMroudv6+B+4aPGtMKAgv6zwOasIrkp9xUyyO1K2cjPhT7v3jFk3ifesPx2jIH6vZULbCzlIkECnvGaAqi2XbDezuKZlvCWi9NutqEKQQMx/MXNiwJnYZKQjulzA/VgYr/n2W2bX3KkpSye9UWc5/XiILMe3D2uthbkL45jG8ChjoRGiUZ+SQYi3Bq4VgCFelOChNPuz5JmH57/ILvkIsfFZZoTvBfl727/pXmk/BWWkqvBtKhF9CWTOjVRbbcdu87YtS5p+vhFUeXAakDbfF4hSUB3hgA8HHzWtVCbTiCh85XXBUXOS0TYx4ledEsu+rrIyCJMJbyiIMUg+HuijKWmNA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(1800799015)(7416005)(366007)(921011)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K3RJeEtzWGxsMjVybGhpRy85ZFpXa2c1WHBwNm04NWN2d2VOSGN6ckY4ZzN5?=
 =?utf-8?B?bVVRWjlsU2VXdzlZbDhnSHlqellEK0I3WnkwZ3JxOCtCRUoxMU5MdUIvcFJU?=
 =?utf-8?B?Rk9ibHRXMDFTZmJSK2RBOWtZeWZUQTFLQmUrMnVxMHdaV0dWdnU3bzR6TUZt?=
 =?utf-8?B?TVRQQlZWRDFYWU1xcmp1UWs1dXd6SVNYdDZnNDhhU20zYTNWcUtTSWxGdXc4?=
 =?utf-8?B?VVhzV0JPcTc3M0FidlVwY3NuMXE3RVNzV21jSm1vTHBETlVIT2lHYmk4eEF0?=
 =?utf-8?B?a3ZQNyt1T3ViY2tFNzFTemhqVk5RMUN6RVdMT1YvbE1zaVY2eG83TUgyOStQ?=
 =?utf-8?B?My9WZnIvaXZjTnVhRiszNjVzblRmaHBnZXoyRzkxZ2ZKTTBrNlAwaTF5K2NH?=
 =?utf-8?B?aCtuV1JUbkl3LzlRcGFOY2xPZ0dGTlMvWmM0L0J5b2pVME0xalIxZ2JVL2Y5?=
 =?utf-8?B?Y3hhSnFiM3A5YXBGWFdFWWRUZ3Y3bHFaWXlSMnEzUVlua05MVXVkTXU4NTB3?=
 =?utf-8?B?bTlSRURmL2FFaXZYNzR4TiswSU1vRExOWk1UTnh0cU9QclRyN2FtQnJNdEc3?=
 =?utf-8?B?QWlVajR0UFREZUoyeGNFbE9jTno4WTJZZ1BzZ2FJS3JVRUpiZmlSNDROUFlK?=
 =?utf-8?B?empCeVovT09YNk5UZEtlaDAvd3k5MEU2aFZjYllnMko4ZEtQdzdMTXVWTUZ3?=
 =?utf-8?B?OGRlc2RNVU5aK2VyelBmK1g1WlpPb2JOT1JlM0p0eE1vOGhrdStMKzJmSkV4?=
 =?utf-8?B?N2FLRzRSeFlvWHc3Z0x6dVBCQnlZK3o3QlhKUjVsNzZXT2ZOQmM1bm1RZlBq?=
 =?utf-8?B?Wi9tc3hHZm1UU29BL2ZSbCtRWU9wY2tGZkk2NUxxZXRKdkFJdDBCNlVhQllX?=
 =?utf-8?B?SWZpYlNhM3I2VHZEUTdDV25BTGFBNGthME9YN1pXc2ZYQk9WN25ZN0FDRTY1?=
 =?utf-8?B?SXNxRG4wdm1vL1dYUUFSajdVcUVscFlQN3EzSmRyT3QyWmVSd0tQa3dVdGVv?=
 =?utf-8?B?MVJEemsrdEo2bzA3empEMXR4ZjBSMnNGT0lyNDJDd3BBVlhaUkZ2MXNnbUh4?=
 =?utf-8?B?T2JNb0ZvQW05R3RKLzNlcndnOTdUbE1wekxBZW01L2tLaVR0QTk3c01Qdy90?=
 =?utf-8?B?cDRjZkU1RytMbVpKaUVoZS9EM29MeDlLQVdjWkEvcUVsY05iZUwxclVXekpp?=
 =?utf-8?B?T250RFZCQVIzL3dSaU5hdU1RWU5tTS9VdFFrZFM5ek10TG9jUTFVcituMG1p?=
 =?utf-8?B?WC96NUFLZWhHWFlTd1g4Zys5dUlWQXdBSzF4bVlXT1JWcUVFU0piQ0ZkMEps?=
 =?utf-8?B?VTBWWjdVVXptQWkvcTNWdE1MZkhUZnNYWEJTd2pqSWRGWDN3VE9pSDh5dlIx?=
 =?utf-8?B?cjhWVVV1aEhrRnVRS0lTL29KRTBPVUhYQjYzRUk1U3FNL3Y1MzAzaXdPSUI5?=
 =?utf-8?B?aGxDelNGYW50bVQvRjVzUWFGa1JRdUZWckNrSzdXT21HbFR0K3BoZVZKYWFX?=
 =?utf-8?B?S2w5SUYzNzVjbWRMemZ6aEc5cHlKa245VmFIK3c5QnVKUldBWkxnT1N0UDNO?=
 =?utf-8?B?cVdKUXdKNG5vandIQVNGdEhDM1p1bHFjUG45V2VaOS9DeXNTbEttSE1iNERw?=
 =?utf-8?B?ai94S1BqVmpleHd0cWhnL2pWRFY5WVNUT0xJWVRsMmY0c3JucUwzYWprN2w0?=
 =?utf-8?B?QjdJLzl0VWtzcytmS2p5NU5zTFU3VDBvSWY0SEplUUNmL0h3a3dwOWVIQnRj?=
 =?utf-8?B?a0kweTlKQ0ZndVZrY2dSTm9pN1A3SFFDa1A3R1B2YVJtY29ZM1djMUFiUjgy?=
 =?utf-8?B?bXdCaHVSb0hLMnY3QVJXUzlzNjgzOHRGYnd3RjY2QU1RRklCbm1KV09lTUZ2?=
 =?utf-8?B?cnl3VEJBbXVVaUhlZmJjMmJDMmkzZmowblBlODY4VVhNbURWQTlLdzNIdVdJ?=
 =?utf-8?B?cWppVUpyQm9oSk95RjA0aEFrQ1R0MURROFJqRWFiaUpuRDd5NG5lVHZ1c0Zw?=
 =?utf-8?B?bGFZMS96MzI5aWhSSHkzcm9VWUJ1cEI4S0ljaWh1bnNYL3U1UEFZWmtuUnov?=
 =?utf-8?B?Y3lVTW9hd1BwR1hLNitEbWtsV01rcDlSV0RQNElHUG9BWlVVZEdpcnl4R2du?=
 =?utf-8?B?TlIwUjIvK1BRWWdnL0RhVVpvTkhvSEYvcWo0ZkVSWlY4US9QaHVvcml5ajhU?=
 =?utf-8?B?Smc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 093cda2b-4617-498b-36ed-08dc4a5223d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2024 09:26:22.7892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YkYLrWmPSdGVsyoVQf0V6QQAJRwXWIO5Sy0Ivok84ms0Vp+7KAt6TmQzJQlAhSi85vjXz01L5lDQJaKL3KQaTsJ1388ZToYqTV+7JknuN37XWf0Eg2Lwg0fdF4SxS/+S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0767

SGksIEphaQ0KDQo+IFtQQVRDSCBSRkMgMDMvMjFdIG1lZGlhOiBjYWRlbmNlOiBjc2kycng6IFN1
cHBvcnQgcnVudGltZSBQTQ0KPiANCj4gRnJvbTogSmF5c2hyaSBQYXdhciA8anBhd2FyQGNhZGVu
Y2UuY29tPg0KPiANCj4gVXNlIHJ1bnRpbWUgcG93ZXIgbWFuYWdlbWVudCBob29rcyB0byBzYXZl
IHBvd2VyIHdoZW4gQ1NJLVJYIGlzIG5vdCBpbg0KPiB1c2UuIEFsc28gc3RvcC9zdGFydCBhbnkg
aW4tcHJvZ3Jlc3Mgc3RyZWFtcywgd2hpY2ggbWlnaHQgaGFwcGVuIGR1cmluZyBhDQo+IHN5c3Rl
bSBzdXNwZW5kL3Jlc3VtZSBjeWNsZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEpheXNocmkgUGF3
YXIgPGpwYXdhckBjYWRlbmNlLmNvbT4NCj4gQ28tZGV2ZWxvcGVkLWJ5OiBKYWkgTHV0aHJhIDxq
LWx1dGhyYUB0aS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEphaSBMdXRocmEgPGotbHV0aHJhQHRp
LmNvbT4NCg0KSSB3YW50IHRvIHNlbmQgYSBzZXJpZXMgY29udGFpbmluZyB0aGlzIHBhdGNoLCBT
byBJIHdhbnQgdG8gaGVscCB5b3Ugc2VuZCB0aGlzIHBhdGNoLA0KV2hhdCBhYm91dCB5b3VyIG9w
aW5pb24/DQoNClJlZ2FyZHMsDQpDaGFuZ2h1YW5nDQo=

