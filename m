Return-Path: <linux-kernel+bounces-149421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD878A90EB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 04:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FA011C20CFA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 02:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C663BBD8;
	Thu, 18 Apr 2024 02:00:59 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2112.outbound.protection.partner.outlook.cn [139.219.146.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D624481D3;
	Thu, 18 Apr 2024 02:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713405659; cv=fail; b=Jj0OXE5HBBqHzxiqc/YtHnZT0WLgt7aK2tDl9TbzYX4teb/a1giYtmvRjXxCXUIkYRWqbh+Yi0HHgn37zmp7P7PtRoIpjFQh0gBsWEJ2avn6HzUCvfpTbn4lbqjOTaeoz7CZYliYVKHjn9muGLai+LBIS2mwR/k4HiB53UcAKL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713405659; c=relaxed/simple;
	bh=iYr56Oclq+HJNOH0APVrxA6/PNI0cLYsvO7OULPBnGI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DJiG4WPfLTRjcd4HPN2Blz8Heug4Hvg6sxOBcAOvUCCDnJFwuTWvsq2jS0wHKSp4hveR3aKXl5GtHep7R52ZYgcwT9Ll+HqfMfYD4T0Cjz9JbhK51QPM1VJd9OXQxIdJLMdu/U7a8muG2878UqZLV2Zkb+a+KtUUZt55BwO0uVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mE9EYXyXHmaQWZj6e6DS29b8cQdOA0kUbo7bS4IcmfjWgLCiGfJNAKpbyz2sO+lhbGrUbkfe0jIUbnXwe0xAVXjkWze+s7KgrI6HRbDcFQpKUhApXpHy/dU3GadsyQ1eLpDTjSQZMFWmxHI0Q5K8H4DDUfhmkOQyEtQtRP/C5Gf+4LIDxH2ztz0oZDlc8zcJ8TYonCH3S6fwAkSoe/5Wgte7cIBmTVJEAcbxGew/kg9F79++urJWo97rRnyIXVfne/R/evajxZcRfyXLRsiyfwHGQvwZ3IF/fKX+6em5V8lRPzfKYc44ppg7cZ6IhQVKGZzWw+QO0y23MpU50b+ucw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iYr56Oclq+HJNOH0APVrxA6/PNI0cLYsvO7OULPBnGI=;
 b=CvupmHhYJlktPb0bkxG6pjBdvCyjv2ksXpsXB4nkfqXoXTJR7RXjjIPTkW3H03AwPtb8k+ycgcvJI4mQKToIYBzwCUJo/n5+o+tt/L984wrR3iaf6FfAg7brTasqOmPpHYnqzK5LzyT2We8zyWj21KTLnb7RyySz1UhiaOGZBN4O7kSHuES9C0tuINepIf4DV1s4ancd7YBKj3764x6hEMA/+95c5/S4IXB7m6yBKZSTii3JBDhi00wB/QvtaYS6qhF1EcdAVDFCgWyoGOliWKNPGsS2Y8996HTEo8RjIO/Hwt3se0wP2CcT4aBc2okqwne1rUyrcX6IPsWr8z0k/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0848.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 18 Apr
 2024 01:27:05 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::b0af:4c9d:2058:a344]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::b0af:4c9d:2058:a344%7])
 with mapi id 15.20.7409.055; Thu, 18 Apr 2024 01:27:05 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: Hans Verkuil <hverkuil-cisco@xs4all.nl>, Laurent Pinchart
	<laurent.pinchart@ideasonboard.com>, Jack Zhu <jack.zhu@starfivetech.com>,
	Dan Carpenter <dan.carpenter@linaro.org>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-staging@lists.linux.dev"
	<linux-staging@lists.linux.dev>
Subject:
 =?gb2312?B?u9i4tDogW3YxXSBzdGFnaW5nOiBtZWRpYTogc3RhcmZpdmU6IENsZWFuIHBh?=
 =?gb2312?B?ZCBzZWxlY3Rpb24gaW4gaXNwX3RyeV9mb3JtYXQoKQ==?=
Thread-Topic: [v1] staging: media: starfive: Clean pad selection in
 isp_try_format()
Thread-Index: AQHadCdXg2iQIaE4RE2+8VSiB5BEfLFtdhSw
Date: Thu, 18 Apr 2024 01:27:04 +0000
Message-ID:
 <SHXPR01MB06710239B9F69E2F0EC0CB01F20EA@SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn>
References: <20240312024520.11022-1-changhuang.liang@starfivetech.com>
In-Reply-To: <20240312024520.11022-1-changhuang.liang@starfivetech.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SHXPR01MB0671:EE_|SHXPR01MB0848:EE_
x-ms-office365-filtering-correlation-id: f2fe3824-97b3-44fc-1983-08dc5f46a7f8
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 b4fuAd3IT/gcx9pFgseFreYOAXiXB87CVtOB6e+5pl8oi3lOaQZNVgUKOeWfBbrX/A3jF+/Ywl5FrcxV+4F5lCM4WD3TbaCiA+iWyikNVtkEAFyDrhXrjdQtvd5+Jwj6IT6WHstZVLz08WmIvx3aR5nFfskBVjQDFB+u8pxTwAd2Lu0cUq0RFt0Q0OyUM1PFsNE9CjTacxnIHH0fjmtd4ZeRu4vrhgmDOwbM0smZhHfkvd4chsfB8R8SoC8OoDlMeUJFuAgYKaq2/NoG9PvD5CA3/3PfEypSNNj4a7jCiMThWVswJmM6R//TpYxHJtb6xnRS9LHPdvr6xzTMTedxwOe6JLB6zOujwgwT0yIJGWpWwDZRUzGkidAOQEq4NnqCkVssrOLHTM7oBjkg3jP99KggZTfI749u/jJRxZDw9B4y5OlLKRxhxUJSft1hRi+uvXL1MP7i90/JTAH4XsKrK30GlZRUWn3T4PZYpr2mDA97Ww6nvB/B6RViuHiVqVANsXWDYveqrgYGIhITuIdlrs3NzbHUml/XbAQAhnwQ9JcsqpzyMupuvmG5kQ5wm/oMUOOUqWUJ4mAG5KET6XpipKDVuJnaoyfn35joLF2JePGBS5Bgr3HVLMyNDL9SVRDw
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(41320700004)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?MXd5eVhLR3Z2cVVhRGlUOWNXZGZvazM1T3QzcWgreFBlQm1vdklyVDNRVCtZ?=
 =?gb2312?B?WSt4V2hyWHR4bHpjZWpmS0JaRVNYU3ZYbGk5UWMyaG42RVlVL2hWd1R3alNT?=
 =?gb2312?B?dXNhUi9qL0xmZkVzWDdxS2F6c0NjMFVGalBBb2ZhRFJ3T0lJRzA3QTFIR1Zu?=
 =?gb2312?B?Q3RkeGJlWDBBZEsxVGU5dEl2ZzR4M1pEVjRJcDNQUjkrOCtjR0NtOFVMaTEr?=
 =?gb2312?B?VVkyOUNOcEtYTDN6VjhSWjZCUFFHaHNkL0h6Mnl2TFpHUGJEakNuZGVUV2RK?=
 =?gb2312?B?MXVPTEtqQUdJM1hZRTRlMjFiNWNuWjZSL1pFd0V2WWtLcU9KZFRTNmFLdmpz?=
 =?gb2312?B?SlJrVEI0NXdyMFgzc0RQVWp0Nm83bFoxanNpMVhPQk5UVVdjT1lsWGxvMS9o?=
 =?gb2312?B?V3cwSFMxL2N4ejdCWGQxWVhjalNMVnd2bFU2LzR4Vm5DYnlRWG83Zm9ScVpJ?=
 =?gb2312?B?WHdIV25zVExtVmxlRTN5Uzduem5mVnIzSm93bFF5SjlFODNUcWYwbW5RZ0JE?=
 =?gb2312?B?RzRkZGhCM3BDcG1BV0V4b3pkVDM0Qkh2V1RIZG1pMTVGVkpDNUJQdjI5ZzYv?=
 =?gb2312?B?elRzSVA3K0ZQYjlzUmwxZ2M3dlg0cDVLclNRQjVhVzBtQk5CQzVjeEhVN2pm?=
 =?gb2312?B?a0t3WTdXYnVvNUQvMkdHbklSaWJvd2RKNnU1SXgvVS9saCt3di9vdGNDU2Mz?=
 =?gb2312?B?eW80R3BBakY0NWR3L3dZUitKN2RFZEVQRjdaTmRRL1ZFc2p3VW9DRE9RRVRP?=
 =?gb2312?B?UU1hVGtyWUJuVmNpWnpHUEFSdTBsSmJjZ1VsUmhKYmFUbkZQRFdJbTN4eDRm?=
 =?gb2312?B?MVFBQlZaUGlyK0ZQa28wRzhNQW5NRlJ4eWNLUDEyRm1lRFBIcnM3cnhPV3Jm?=
 =?gb2312?B?WjZOOXliZFAvbVlMaXZ5MENNemlhTE9SYy84NnVDbWN2bE92R2I4U3MzZGRT?=
 =?gb2312?B?UWRjQ1hUa3RleGxadXZpUzllQTZvbHhlZUpja2pzc0tMTzF6MkNyTFZmQTZX?=
 =?gb2312?B?OXlKZ0oxVU11aTVIU3dBVzBNZGtmSlMxVGxZUWJHUDBTNnhndVJ3UXFLbko2?=
 =?gb2312?B?dCtuTmhtTm1SN2MwanMreFZiVWF2UUtiR2NIZklsTzBOL3FqMklyaXUvQXFj?=
 =?gb2312?B?MWhXdklGOGQwS2tucWVKRU4vNDN5d2poSVdjZFBydmJUTHpFZDBSSTBHKzN4?=
 =?gb2312?B?d0ovUUdXeDZtdnhQcWpwU2xnMW1NQTNrV1h5Y3d0N1FMY0I5WFhoT0Z4K1BC?=
 =?gb2312?B?ejFPZmk2YXRIZzNVK2dyOFZFcXh0bzgvbDQvYS9iYlRqVlhBemlrbHRXMURK?=
 =?gb2312?B?aTI2WFc5Vm1LZUc4NkdKdHd3Q2IwQWU0b01FekcrYzRIOGRlbm44V2d0aFUr?=
 =?gb2312?B?aUdxZTNnakNLNi8zcnhzZVhDRHBXZytDZ1VCOHFpT2toQ21NRjYrNndneTkw?=
 =?gb2312?B?Wjlsak56ZUE1OVduMmdnTldZSTNneHZhaWp6cGtrTmFLUWEvVlB0ZUNSN3Vq?=
 =?gb2312?B?b3BpT0srSEx3NkNDeEhJYnRpa2ZVZDVDNzduQWtHVkpTbG1YYmxDU1gvaklJ?=
 =?gb2312?B?MGRlVEs2WWl6NEUveHFveXZ5QzZvYjhqczJ3NGJpajRPdnR4ZkNRR2NMeFFv?=
 =?gb2312?B?RU5VOGtySU1aaVRuUUp3VEQ2RkRDL2RrZkhjVXJyWXlLcjZUUzFGcW5IcTdz?=
 =?gb2312?B?STdOMXRVVlQ2YlZpQzN5OGNWeHJ1OWRyL2JOekN5SUdoSWdHekcwK3FJRjV5?=
 =?gb2312?B?enI1d0RlczlKZ1U0akRHSURRTmxpOTZEUFcxSVJrcFUrakZLOWNxUkwrYmF5?=
 =?gb2312?B?QlFHK3k0SWE4Z0xEdU5JSUxFeUhtS0NoQ3o0emFQWExISDZWUnlXLzVlVWVs?=
 =?gb2312?B?TnBWLzNGaGcvcVRZemswcnNWa0FUdElPYjF1eEswUk9WTW1TSTdoVm9nbVBO?=
 =?gb2312?B?NEhnelQ0SVdmVi91aDloT2tiUXRCOFlrU3czVGxOTVBsb2tUY2dNeXFTUU5D?=
 =?gb2312?B?Qk1JcU8xU2hiTkVtVVBRMGFoM2VVek1ISko5Q2JzZCswaGc1MVF5SDQzS0RF?=
 =?gb2312?B?T0MyaEd6Uzk0cWpjY3BwQndhWW5uQUp6VHJhWWdKWmcyOEVBU0Y5Y3FPcm1T?=
 =?gb2312?B?ZExOaVZoMy83S1A3dTZNdzdSMU9FMzhodUgzenBHUlNnZEl5YWpFc1lqUU5u?=
 =?gb2312?B?OHc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f2fe3824-97b3-44fc-1983-08dc5f46a7f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2024 01:27:04.9721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PoUsAzeXeEjvUgzhiFZaw53urtgRJ9RWU1V66++6y4E/wyTZCmQy/wnlxWNEcdhBS2Ubl48rF/PH92gTCln+NG2DFMtVNeCTD/J27fQ2zvyv4VxRq0omwefL1z/D35IW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0848

SGksIEhhbnMNCg0KPiBUaGUgY29kZSB0byBzZWxlY3QgaXNwX2Rldi0+Zm9ybWF0c1tdIGlzIG92
ZXJseSBjb21wbGljYXRlZC4gIFdlIGNhbiBqdXN0IHVzZQ0KPiB0aGUgInBhZCIgYXMgdGhlIGlu
ZGV4LiAgVGhpcyB3aWxsIG1ha2luZyBhZGRpbmcgbmV3IHBhZHMgZWFzaWVyIGluIGZ1dHVyZQ0K
PiBwYXRjaGVzLiAgTm8gZnVuY3Rpb25hbCBjaGFuZ2UuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBD
aGFuZ2h1YW5nIExpYW5nIDxjaGFuZ2h1YW5nLmxpYW5nQHN0YXJmaXZldGVjaC5jb20+DQo+IC0t
LQ0KDQpDb3VsZCB5b3UgcGxlYXNlIGhlbHAgdG8gcmV2aWV3IHRoaXMgcGF0Y2gsIHRoYW5rcyBm
b3IgeW91ciB0aW1lLg0KDQpCZXN0IHJlZ2FyZHMsDQpDaGFuZ2h1YW5nDQoNCg==

