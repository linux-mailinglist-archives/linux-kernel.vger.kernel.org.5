Return-Path: <linux-kernel+bounces-135830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FD589CBD9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 20:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 899E01C21AC7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF54145B2A;
	Mon,  8 Apr 2024 18:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="avMynLHi"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2131.outbound.protection.outlook.com [40.107.237.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAE556462
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 18:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712601668; cv=fail; b=IzCFQvhs+xinzI8lOT0TpiB4qG0TvqgTEqCtubymsGv5d1o0EJX8162RquynqhyWV4e8PJUfu94WIFYcj3dZsrpEKD0lQLnYNP9tUrfzXyqT52L+86ipYRWn1YHLxwDg28sVbDNsPm53p/w4X1P01mdlVGjYPbkH9Hub6UO/yHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712601668; c=relaxed/simple;
	bh=zTxfTJanofnHjSYFjEeXNP6S2vN391aDQ8mtEqDAUeI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BHXsOaibVSshKQazjuKueLf8BW62Exq4ZYKFgL7lcb0fTYrajkFv/b4h3au/Ii5Hc2cQSik6xiRBu6hY+dm9B/c0QyKy7qlcnQq8qf/TOTs2kMHNv+tp3V2NdloNS/SisHU+bE048EZpFkYAsRjG4OOGeWQFDnaevXfzNRlD4QU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=avMynLHi; arc=fail smtp.client-ip=40.107.237.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VTwmB/1tAaQOwBVY8nx4R7ZgXya5Ja+Ut/c2juDKSjozUt6kh8/VVQJEo3LPeyToopQYAeXmjM4V/wxC+5HE0vXZbBwk3PyqXJ1HIvp82EFrj0rXouAABGHWpb/beKXHDgcrInEj7PjLM5NWBN2Z8zQ5YyeArOKX0jELM6LlfQ+jpJFH54PUkz+hOzE7T/K8+u0ag2YarAVGXiJ6SYAuGA+EG+nAr2zHP78sbOTq96tJT3RjD6qCVSdNsVbDnR4WYPFIfeQiq/v/pc2uojvcQn8FXP+TdqfCkG+QdmJIAiX3JQRrLAVe8GwSExbn9ArpHd9bYGntxk/MAT+uhpZstg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zTxfTJanofnHjSYFjEeXNP6S2vN391aDQ8mtEqDAUeI=;
 b=EZk80lwtQIxgQNwZNVfi5ttSUBNJE1iJTZe+vXj0aRhPZLX3W669kNS3ulFlGwRlW7f1tLZ3irOHzptBWaJzNF41++2xPGpBgcwoKiYDDG8nb0gGAzlwAege3Ov9MupCKlXty7z1Npg4Mt1iM7mqPjo1f1jcu/W7573hVzfku/ZjNVm4GQU5Ub3srpl/F6t8r2TWdQ+SPqzsrfym4Kifi9xMgefcI6yGeIup7r9nsAG+luNoArumWleMaGa4yoAr2JsEOQbUXadsYeiHvpzcQBHrmR2UFFUqho/xBv73r40QT/q89MiZ2pUjAPB03fsnOhssuv5epkkWEJUQrnq/rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTxfTJanofnHjSYFjEeXNP6S2vN391aDQ8mtEqDAUeI=;
 b=avMynLHiJyTvQYLnosoB62PxbSzLAHfeM3M5Z3Flb1opzkzZIvM9gK+qw8XPTBuzPF4AdGJqjte/xS7pW0RbarqxPwLIYA+5deuFsYtAdbsXAFaVhqH+md9cwUhxQTe/sgPelRprAgbkKVw+Ejyc/04DC7RnwSsHJMxP3H+5w2QtR1BXny93IIcMT08MTGKg87unyFwPRBiu4cvPLYMgRSJT9wAAxl3y6ugZ/Nih+gSNijnLewfTnNozo33EW8yR047690V3rU7W4CYfp78nkAtx9Eg2S6nTj/8T7iNQX0AED2mjvd81hD/qQRTGQmFNHncXn6wYqQWqiVFfMUzj4Q==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SJ1PR12MB6314.namprd12.prod.outlook.com (2603:10b6:a03:457::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Mon, 8 Apr
 2024 18:41:03 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2%7]) with mapi id 15.20.7409.053; Mon, 8 Apr 2024
 18:41:03 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: ni.liqiang <ni_liqiang@126.com>
CC: "jin . qi" <jin.qi@zte.com.cn>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"ni . liqiang" <ni.liqiang@zte.com.cn>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason
 Wang <jasowang@redhat.com>
Subject: Re: [PATCH] drivers/virtio: delayed configuration descriptor flags
Thread-Topic: [PATCH] drivers/virtio: delayed configuration descriptor flags
Thread-Index: AQHaidkLG3Y36JghV0qzLyugnUjNYrFetOoA
Date: Mon, 8 Apr 2024 18:41:03 +0000
Message-ID: <c6782614-1201-4796-b82c-cf8a69c3c8bf@nvidia.com>
References: <20240408170252.13566-1-ni_liqiang@126.com>
In-Reply-To: <20240408170252.13566-1-ni_liqiang@126.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SJ1PR12MB6314:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 i+QVkrpkCNkqBlBx3B/+DxvramGLENGZpaPJjP/DPTNIee0il+s4LviP6AX7abCH0FdeUov5gjULu/SABdYO8r1afN0npKTv70YJvszHPODFTejq64X/DjolO3ZuYeXYGJQI0dZE3jKdaaA4yDz1AiNZw/517w//NILz0uDwbm3f+wZAfTu+cmjiP0XKjSv+UbcX9tTelFXbVT5/pxNEZ+fu9NxbCXlcCOlESD0u7gsuHUkCgflnk9AxtvcFNb9s5NjAEaBF9nHimyFpsaKAZpGyz46WY21wkg5RPcwX48NwPFD3ABSEFdDAM5EL5aqSS6/Xm5E2gD4SPOdm4dR4P62RSsym8W3f95xvKvPT+DHNYICfXICP+lzSqdau4FtzoNtwr6Q3tFeEfNfCfXPp+O+TqpKIubVBPhCA34OPkZoov3fDO+szmue9CqMjqvSUOGIFipkQdoefDKwLHmXWriNltHKjErbnembYOu7BUuoZQAkFKbhbJIXsPrYUWMYDJuge8Zu6r4seLeXohttSGeNBOmI5KpNESWtRipqOiijlBBIA1z0GPYrtc27ihKiRjlKEoy81c8yYi0Czb5qy1SwiIRGiAsOgvteHthBTAiYq56aRtxs/yxSzxp7+Fm1U6Tllu7qaX3+kqB9z80zm9e8n8qvljpoXnBjZT0suWlE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bjkzcDJROXpIMEJDVkRIaHZ0RUJ0bWxIWlI0OUExRHBoWHhZNzUxUHdwOFNk?=
 =?utf-8?B?eTVqWS8wTVN3SHdxaCtoSFByZ2hzdXRoM3BuMHBGTDdieFMxcHhCa2xSYXdr?=
 =?utf-8?B?bzZibGV2QktvZVdmNWJCSlRNWHZvYlJHREt1LzZzWmdNUzlVYTFPb0dReGgw?=
 =?utf-8?B?N2FMU1o0UjJraXVtV013UkNmdkdSblBJV1RSVXBzRjNHOHhuK2hId1V4SUZO?=
 =?utf-8?B?MXU0dktXVG8yaHVrbGRpQUhUZDhYcWpYSjNhNVZpUnRhMWJrdnRmRFBJQU80?=
 =?utf-8?B?UnFET0VNZml3SWp6RlpHTmc0UDFLeElKWktqUlRYTjA3b1FhWHA1REdkdWcz?=
 =?utf-8?B?ZW56d2hnelc4dlFYVWJod09UTFYwU1o3clZ2R0RscUZwMVVYQ2FMYjBLOGsy?=
 =?utf-8?B?RjZXWU1pRGM0WnJ1Ykl5T2NrM0g2andyQzUwUHNSQXpVOXRIRjZYYVBmSjRG?=
 =?utf-8?B?NkJkUEVoc1pwT0JLb2NpcE9kMjRPbGVJKzlIeUdWM0lCL1RvSHBtYXlqOVQ1?=
 =?utf-8?B?WmJDeHIxT0JPUS81akNaVUhROFVmUlZlbWJhMm9LKyttZFVWT2JjdU5jY2dX?=
 =?utf-8?B?NGU4V2NvZmhjSVBsY1VqSDB6L1ZNYkZpWTRjcW5PZXNmTThEZy9aK2dWbWJ1?=
 =?utf-8?B?d0pjYS9heEsvMDBJdnJhLzhoYmVLdDFtRlZRTFIwQ2J4TExMYSsxK29GdGVO?=
 =?utf-8?B?RGdwMkliL3R0aVFma2ZlNTBYNXcxNk5pV00vOXRBSjF6MzR3N2tqMkhlaVo4?=
 =?utf-8?B?VDRRMzFBT2VzMFlOQlExem1ic0dKdWVUdERUOWlzbDRQVTdMWlRrcW9PMGRI?=
 =?utf-8?B?d3RmcFROV1o3ejBsN2tOeGV3NUhLVDFUWndwcEorakNEWmpkV1VqMXkrNEEz?=
 =?utf-8?B?NzhjUEViMGkzVlpZVFVFM0pWQ2xnVS9PRXFSc0VRa25JVzNWSUZqMWFYVGl3?=
 =?utf-8?B?cE85ck1Sc0pnTEFmb2t5Ymw4M3I3MlhRTnlWTTRIZHIxaEhpL3REZ29wS3A2?=
 =?utf-8?B?eVB5amJNYm5uYlhJMk1IUFh2RTd1Yko2QU1CaHBxTGJMWlB3SG9UVWRPTFdT?=
 =?utf-8?B?aXZvemdVd09VYzRtcXVZcWJOaEVPb3ZlbEo0ZjhRdWtrWnJySEJLTXNBZEJ4?=
 =?utf-8?B?OExnZTNSMFh6RHJxbDlEeUgwYTNpbDZCbXJ5Rjl6VFZQWmRqTXhtV2REa2hI?=
 =?utf-8?B?V09HbS9PQlpjUTROSWwxY0JEMGhpMllwMzcwdjBxR2lGTHpwaFAwQVFOZUFv?=
 =?utf-8?B?ZzU0c3gxTE1yalNNdVRJSEdpUkJvZXZ1QU9mcVNVR1RnNVdzU1VmTXQvNURL?=
 =?utf-8?B?dVcrSThjMXk4ZDZJRENTcnhSK0pxWWpMY2hPeHdSejdDcW9XQ2F5WkNOa2Vj?=
 =?utf-8?B?WDVBUXM0aXEzSVRhbXRTUVVWcW1FOC9xYTVKR3hzS1dNbUU3ampMM0NRYmJ1?=
 =?utf-8?B?RE9pb00yRHI0c3ZzdlZHMjBXVUNOOVE0bjNkZitDZUptTzEyRStvWlFEUUhn?=
 =?utf-8?B?ZXQ0bmlIaG5YY0c3bGhiMzg4Rjk5eTFtWGFPanNsWFZRWVFjM1FzWE12L01w?=
 =?utf-8?B?S2tTT1NvR1loOVBNNXZBbExoTmxBRkE4TGtyVU5ydEtXS2JXcUU1dEZISHQ5?=
 =?utf-8?B?cE1mYmUxbHh6dHhqbUFkdVhwQ0VNUFg4YWk0djZJV0haS1htNWRleGVOOWdO?=
 =?utf-8?B?N0UxbnMzandrZW82UFlGV21UMjZzZ2FnRDcrMWpCSHphaFQ1WFFLT21CaW1v?=
 =?utf-8?B?bzRkVmxVUzU0b2NRTHM4cUNSM0dYdlI5Q3FGeDhPeXBaTGZKOEw3Q1pmaGJi?=
 =?utf-8?B?NUhmdnpvVXd6UEJYREo1NXdwTndNNEZ4RzNmcDhOKzk1QXczT1FpdXZVVk1k?=
 =?utf-8?B?L2kwdjM4WUVPYXBZc0MyTm9WRXltbjNQQ1ZTcEZmdTNadG56SmFqUEt2Skxl?=
 =?utf-8?B?MFlJVVhPaTBpWkN3dEM1dDVtQXJvbkUyUHB6cDdxckNTNzd2TUQzQWQrd3Ro?=
 =?utf-8?B?TkxVbmdQU1d1UnVnbXpyMUpOUllici9DWk01R3hlT2c1a0FTRXRaZkVUWFdZ?=
 =?utf-8?B?S3VFdXhPejg3OGN4dHo2dFM5amVOd1U1Y2V5Ynk1NXVwZHpKbWpEZlczbmM3?=
 =?utf-8?B?UTF6VXRyVmIyNXVwMmpOUWVVbXdETDllK0lqMXVITG0wcU1zaDNQWjIrT1hT?=
 =?utf-8?Q?DKjWVrsAU8T+yEmp7igyaRhsLdY+JSKZH1gSgekBrozi?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D086E8F61BCA3F438067D571EB535F61@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddb269d4-813c-443f-e0e1-08dc57fb7195
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2024 18:41:03.3409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bwxJAATTRD9U9EJgt0B+qk6gdzHUUVtEYWc/qe+IZHrzeU5fnVAxKD/oSdiIAoeS9+ariHAw79bSuN0EJNZOww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6314

T24gNC84LzI0IDEwOjAyLCBuaS5saXFpYW5nIHdyb3RlOg0KPiBJbiBvdXIgdGVzdGluZyBvZiB0
aGUgdmlydGlvIGhhcmR3YXJlIGFjY2VsZXJhdG9yLCB3ZSBmb3VuZCB0aGF0DQo+IGNvbmZpZ3Vy
aW5nIHRoZSBmbGFncyBvZiB0aGUgZGVzY3JpcHRvciBhZnRlciBhZGRyIGFuZCBsZW4sDQo+IGFz
IGltcGxlbWVudGVkIGluIERQREssIHNlZW1zIHRvIGJlIG1vcmUgZnJpZW5kbHkgdG8gdGhlIGhh
cmR3YXJlLg0KcGxlYXNlIGRlc2NyaWJlIGluIGRldGFpbCAiZnJpZW5kbHkgdG8gdGhlIGhhcmR3
YXJlIiBtZWFucyAuLg0KDQo+IEluIG91ciBWaXJ0aW8gaGFyZHdhcmUgaW1wbGVtZW50YXRpb24g
dGVzdHMsIHVzaW5nIHRoZSBkZWZhdWx0DQo+IG9wZW4tc291cmNlIGNvZGUsIHRoZSBoYXJkd2Fy
ZSdzIGJ1bGsgcmVhZHMgZW5zdXJlIHBlcmZvcm1hbmNlDQo+IGJ1dCBjb3JyZWN0bmVzcyBpcyBj
b21wcm9taXNlZC4gSWYgd2UgcmVmZXIgdG8gdGhlIGltcGxlbWVudGF0aW9uIGNvZGUNCj4gb2Yg
RFBESywgcGxhY2luZyB0aGUgZmxhZ3MgY29uZmlndXJhdGlvbiBvZiB0aGUgZGVzY3JpcHRvcg0K
PiBhZnRlciBhZGRyIGFuZCBsZW4sIHZpcnRpbyBiYWNrZW5kIGNhbiBmdW5jdGlvbiBwcm9wZXJs
eSBiYXNlZCBvbg0KPiBvdXIgaGFyZHdhcmUgYWNjZWxlcmF0b3IuDQoNCnlvdSBhcmUgbm90IHNw
ZWNpZnlpbmcgaG93IHRoZSBjb3JyZWN0bmVzcyBpcyBjb21wcm9taXNlZCAuLg0KYWdhaW4gd2hh
dCB0aGUgInByb3Blcmx5IiBtZWFuIGhlcmUgPyB3aGF0IGlzIHRoZSBleGFjdCBmYWlsdXJlIHRo
YXQNCnlvdSBhcmUgc2VlaW5nID8gcGxlYXNlIGRvY3VtZW50IC4uDQoNCj4gSSBhbSBzb21ld2hh
dCBwdXp6bGVkIGJ5IHRoaXMuIEZyb20gYSBzb2Z0d2FyZSBwcm9jZXNzIHBlcnNwZWN0aXZlLA0K
PiBpdCBzZWVtcyB0aGF0IHRoZXJlIHNob3VsZCBiZSBubyBkaWZmZXJlbmNlIHdoZXRoZXINCj4g
dGhlIGZsYWdzIGNvbmZpZ3VyYXRpb24gb2YgdGhlIGRlc2NyaXB0b3IgaXMgYmVmb3JlIG9yIGFm
dGVyIGFkZHIgYW5kIGxlbi4NCj4gSG93ZXZlciwgdGhpcyBpcyBub3QgdGhlIGNhc2UgYWNjb3Jk
aW5nIHRvIGV4cGVyaW1lbnRhbCB0ZXN0IHJlc3VsdHMuDQo+IFdlIHdvdWxkIGxpa2UgdG8ga25v
dyBpZiBzdWNoIGEgY2hhbmdlIGluIHRoZSBjb25maWd1cmF0aW9uIG9yZGVyDQo+IGlzIHJlYXNv
bmFibGUgYW5kIGFjY2VwdGFibGU/DQoNCndoZXJlIGFyZSB0aGUgZXhwZXJpbWVudGFsIHJlc3Vs
dHMgPyBhbnkgcGFydGljdWxhciByZWFzb24gdGhvc2UNCnJlc3VsdHMgYXJlIG5vdCBkb2N1bWVu
dGVkIGhlcmUgPw0KDQo+DQo+IFRoYW5rcy4NCj4NCj4gU2lnbmVkLW9mZi1ieTogbmkubGlxaWFu
ZyA8bmlfbGlxaWFuZ0AxMjYuY29tPg0KPiBSZXZpZXdlZC1ieTogamluLnFpIDxqaW4ucWlAenRl
LmNvbS5jbj4NCj4gVGVzdGVkLWJ5OiBqaW4ucWkgPGppbi5xaUB6dGUuY29tLmNuPg0KPiBDYzog
bmkubGlxaWFuZyA8bmkubGlxaWFuZ0B6dGUuY29tLmNuPg0KPiAtLS0NCj4gICBkcml2ZXJzL3Zp
cnRpby92aXJ0aW9fcmluZy5jIHwgOSArKysrKy0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgNSBp
bnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92
aXJ0aW8vdmlydGlvX3JpbmcuYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMNCj4gaW5k
ZXggNmY3ZTUwMTBhNjczLi5iZWEyYzJmYjA4NGUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdmly
dGlvL3ZpcnRpb19yaW5nLmMNCj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYw0K
PiBAQCAtMTQ3MiwxNSArMTQ3MiwxNiBAQCBzdGF0aWMgaW5saW5lIGludCB2aXJ0cXVldWVfYWRk
X3BhY2tlZChzdHJ1Y3QgdmlydHF1ZXVlICpfdnEsDQo+ICAgCQkJZmxhZ3MgPSBjcHVfdG9fbGUx
Nih2cS0+cGFja2VkLmF2YWlsX3VzZWRfZmxhZ3MgfA0KPiAgIAkJCQkgICAgKCsrYyA9PSB0b3Rh
bF9zZyA/IDAgOiBWUklOR19ERVNDX0ZfTkVYVCkgfA0KPiAgIAkJCQkgICAgKG4gPCBvdXRfc2dz
ID8gMCA6IFZSSU5HX0RFU0NfRl9XUklURSkpOw0KPiAtCQkJaWYgKGkgPT0gaGVhZCkNCj4gLQkJ
CQloZWFkX2ZsYWdzID0gZmxhZ3M7DQo+IC0JCQllbHNlDQo+IC0JCQkJZGVzY1tpXS5mbGFncyA9
IGZsYWdzOw0KPiAgIA0KPiAgIAkJCWRlc2NbaV0uYWRkciA9IGNwdV90b19sZTY0KGFkZHIpOw0K
PiAgIAkJCWRlc2NbaV0ubGVuID0gY3B1X3RvX2xlMzIoc2ctPmxlbmd0aCk7DQo+ICAgCQkJZGVz
Y1tpXS5pZCA9IGNwdV90b19sZTE2KGlkKTsNCj4gICANCj4gKwkJCWlmIChpID09IGhlYWQpDQo+
ICsJCQkJaGVhZF9mbGFncyA9IGZsYWdzOw0KPiArCQkJZWxzZQ0KPiArCQkJCWRlc2NbaV0uZmxh
Z3MgPSBmbGFnczsNCj4gKw0KPiAgIAkJCWlmICh1bmxpa2VseSh2cS0+dXNlX2RtYV9hcGkpKSB7
DQo+ICAgCQkJCXZxLT5wYWNrZWQuZGVzY19leHRyYVtjdXJyXS5hZGRyID0gYWRkcjsNCj4gICAJ
CQkJdnEtPnBhY2tlZC5kZXNjX2V4dHJhW2N1cnJdLmxlbiA9IHNnLT5sZW5ndGg7DQoNCi1jaw0K
DQoNCg==

