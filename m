Return-Path: <linux-kernel+bounces-94214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E928873B78
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7240288A2C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1DF613AA48;
	Wed,  6 Mar 2024 16:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FlQ+Kgxb"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61EE1386DF;
	Wed,  6 Mar 2024 16:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709740853; cv=fail; b=k6oqrkxJ9fk3cjuA8UxuDRaTsVk/BT/hrnetplrP5cB04xxnr3qPgXBq5biLl+aAGWzpqE13xs3xunHIa7EWUdq5m65BsjpA/FYLqlXBGr6bAs9lF78bBWduc7QOEuwzYW6ohDSyrmV/aIS6kwlwPGVRhv8opqP0+ILLJtyotO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709740853; c=relaxed/simple;
	bh=CO/u6u5h6K3spm7yMrJwmQ/SBXM5i9kngAyhHdWtvC8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Pazwq/C2eyof5YnBGyCQH3BElDj3eM+NEOXnko3MIGu+udKvyAttv/yDftYKfQvxRyLByPNkpJFtVM848LCkKF0ax1+bQxbif+/AmE3UgBLkr6ddtsitWQ26L1O+UsdIyKf1qtQwFpLVyUWpGfqpLCO8IFrty3Vf3A72C4aHP60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FlQ+Kgxb; arc=fail smtp.client-ip=40.107.243.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EgFZ3ZGqljf7q7+03rkv0F+AR0zCvwAxj1gJv+So2UEfTGRZmN7igkqazs+0DZAYuG0hJTYYx5KJj7BE/d/HxcDjwMz3alO9BTAdNc4EgT2Ayy0ojNfZ6P9/7AALMOizFMZry+hmnbu9h4G2ea8Q0TCGsr7NAeXE5J3dpooHXdfLTGZvN8NNxPzJqN/7aSSOcjOcpvAzm0tDdpMo6YvnuDqyR7QUp9ZgrTMm3y7Ob7NO8gCjOGC32oEZkwL//Ti1eA3NVqHviRgDPG5Fm4uvzIClhr6CTvLjZ76e3X8cgqxZinZR1ltSmFMoNSCs6LQgDN7qnl0RhlLxlLdmEPf27A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CO/u6u5h6K3spm7yMrJwmQ/SBXM5i9kngAyhHdWtvC8=;
 b=Dd1J/i25X3prgKMJr5CBNg4hFojjuZyKhyBhTaeE6KWg3cAkRin93taZXLbMgagyehxF1YMvBO1M/0+KygOJLQzPJQ3dhH8fQ7kOn5aZeoN99gkso0rOYM9R7XM6RWoRBSdjEx7WDClMa9CLj1lkBs5NnY8x1Q5FA1si8av52c3J9i5gt+gKptMEb0heE+0Xa0CXwvugUkGaaMDv24Rj3frsiR5l/qNSqlLI+jVJB2bEYTelgOWHpVAv75xmXGdPuY/GzI0irx9hntfaoNacxjLxuszX6wV4Hsf0lL3EhtHlf6+yC2C8MS55LuMfdB0Bxl+17O55W2X0Jj2cPAjNRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CO/u6u5h6K3spm7yMrJwmQ/SBXM5i9kngAyhHdWtvC8=;
 b=FlQ+KgxbU7xnmf5alNGd9ksZ9xWty+fl/1/qJDRtmn5chzaHMpfxPYTY9P7DoGmC+l+2Q+77tCRYv8ya8dVK0Z3UnKw7/Dm/HKSY9x9uD9W4Ux0WSbriZmFNXXwe4BTR1VGyOv/OzNeP/G1zfPDy9NwEDDVSUH3u9+5Tosw7FFQAL32fjoM0thZE6OFa+UAvI7UtONK+8lDVWjto79/mCxvty8m1dBhz47a+Ub/IZdSMqEUNeHN2PWPBT3S1MsYFo5o55dDVMzBKLLSHysHo9XWrEKVtTdUu3DQdeFeYV7U96hyYq3AoIjdk1ISaQMCoQfbq5vLu2Rz0Jh/GEdBw0Q==
Received: from DM6PR12MB5565.namprd12.prod.outlook.com (2603:10b6:5:1b6::13)
 by MW5PR12MB5598.namprd12.prod.outlook.com (2603:10b6:303:193::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 6 Mar
 2024 16:00:47 +0000
Received: from DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::bfce:51e5:6c7b:98ae]) by DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::bfce:51e5:6c7b:98ae%3]) with mapi id 15.20.7362.024; Wed, 6 Mar 2024
 16:00:47 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: "kuba@kernel.org" <kuba@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "herbert@gondor.apana.org.au"
	<herbert@gondor.apana.org.au>, "dsahern@kernel.org" <dsahern@kernel.org>, Gal
 Pressman <gal@nvidia.com>, "steffen.klassert@secunet.com"
	<steffen.klassert@secunet.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Leon Romanovsky <leonro@nvidia.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "almasrymina@google.com" <almasrymina@google.com>,
	"Anatoli.Chechelnickiy@m.interpipe.biz"
	<Anatoli.Chechelnickiy@m.interpipe.biz>, "ian.kumlien@gmail.com"
	<ian.kumlien@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [RFC] net: esp: fix bad handling of pages from page_pool
Thread-Topic: [RFC] net: esp: fix bad handling of pages from page_pool
Thread-Index: AQHabhlPr1Jip1r+TESj3iFnglf1YrEqCc2AgACn2oCAACZVgIAACraA
Date: Wed, 6 Mar 2024 16:00:46 +0000
Message-ID: <320ef2399e48ba0a8a11a3b258b7ad88384f42fb.camel@nvidia.com>
References: <20240304094950.761233-1-dtatulea@nvidia.com>
	 <20240305190427.757b92b8@kernel.org>
	 <7fc334b847dc4d90af796f84a8663de9f43ede5d.camel@nvidia.com>
	 <20240306072225.4a61e57c@kernel.org>
In-Reply-To: <20240306072225.4a61e57c@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.4 (3.50.4-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5565:EE_|MW5PR12MB5598:EE_
x-ms-office365-filtering-correlation-id: 4b955eb7-19c0-4a01-8c40-08dc3df6962d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 AOVT0b2q8MxHt0xN+zcPoxaD+QT7I52QyUImcsfIRiRu9XtSM4urpVcE7LTvkgiV/ySd+khZq6wbaOYj11e755FzC+Lkpv+ry9ws2wDEUrmj+rW5mNPN4fjmG1uH36yhRPjdJRs5J0rsD0Owt6bcn4zy5RNC3BTX4qMrJKN3gmwa3F5zwsGEL15ng+MqyvuUsoW66id8ps4/x1du8mB6MiA1hj+C8KsI0GSEkk4DujBvJJgR1oIX1AzlmJ9KcOUOk3GEx4hpqQXbrkw3dXZ3X26ru2GlaXEYqT7aap04sbsIrbcmjnlAIhEL63J8JPQvbPsez1bH+owYkDWmdOBZ/NakwjElKGkdN5MAwT8nYpxZ03/w0Ekm+tB5oLhTqL1Rgk+ERjY7BChIQekVSJ6Q+G4AYOM+ONeE4Bj1oAnXSDMlr7fTX0rZQ2rmcrRfUCHriaRF5oBlJXcHURchTyudjDYEoFr/3U8hERfpm1g90SAp1dbmQoX+KD0Uf01376/YzEaOclxbtmT/zppl+cEeArlPGdnOEVMKeO1IOm1QbRw8tRlujv3QYwfV30nMrUwLewVs6QaxAIgZW0AOcXomfEwdFSegVs2eCTXyx0hsegheWmNSWd9oLBx1v6K6NDjLc5Qeogm4NKoUdQlXuXvAvIEGDIhTu85H4PGzM1RQeOlNz5z0K8USky7dw4CzTLo7BgkxqOG/yjLYyfUZF6+BC0KMm2sAGd2F834qZ2t20Jo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5565.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bmlONWFucDE5OE03QTl0akpiWDhyaEZpRU45dzMrOGlUQVVWRDdNSHlyQS9I?=
 =?utf-8?B?ZEtIOHR1MSswV25uRXNmQktzYnd6ZDNPMHl2UjF2ekt2dEhqa3lyclBxcGdD?=
 =?utf-8?B?QnIzalBVZFI3VUdyRTFldkgwSlhyb0IxOGJWVUUvNDd3bmE4dGgzOGN0MjZx?=
 =?utf-8?B?bXl5M0lpRThuWmNxTjJqQXhFdlYzOUJoSEE1YjhqK1FqamE5QjY5TTFQcjRk?=
 =?utf-8?B?UXQ3RjNrL1UremFvNlVFV3BjQWN5VTlCZWNwQmRMSE9IM2U2aGk3SWMrRENk?=
 =?utf-8?B?ZVJFYXVQYm9GRy9FMXltL2tKYXZST3YxSTZWQTYxM3pBOHNOZzNtTjZKQnh2?=
 =?utf-8?B?MXlWaXluUDZ4OUN2KzV5ZXREV2hLOVBna00xWEViZXlkb2Z2Wmc1ZDExd0gz?=
 =?utf-8?B?V3BDNnpVeE1oekZRS2Ixa1JqNDdIL3ZGTWVZOEF2MVdyaE1hdmQ0WFJKUXdk?=
 =?utf-8?B?Y05UcEJiSDdmK1BJL0FZMkkrKy9MMnJSbmt6OU01aC8rUUtTaUlXcHN3ZVUw?=
 =?utf-8?B?RFNDS1NCUWxBY1pYQTI0eUVkVUd1cEt4QS9nQXg0dERuYjg4cUFMdm1Qa2pU?=
 =?utf-8?B?eVQ5WnJKSjczd1d1VVVoVDFZVUs1Qk1NZ0hMWGpIM0dtRmFQdlJJL25Ra0JT?=
 =?utf-8?B?SHJCY3pKa3AvZmtYTmpEblpqc0Z4UkJPbXlmb1JETTlXRTBwbENiSm05SXVB?=
 =?utf-8?B?aGxTc0JLZW1ybmcvc3NWSnc4eTNabDZFL2VNWTlwZVR6aFJMOHQreU8rNlo0?=
 =?utf-8?B?RWRNWDZYQWNHVmR6U01IZEFFVlhoNVM0ck1maHB4cTJuWU5JN3NwSHJuM2E1?=
 =?utf-8?B?TlQ2WFZOMjJ5VFF1ZGdiSWNnM05yY0pFU243WXl5azkrWHRqUWYvOFpkVkJL?=
 =?utf-8?B?Qzc2YUwwZDM2Q3RuWEFmN2tyc05FWENTRklidzRoNlkxTXRvSHoyeGt6ZjFI?=
 =?utf-8?B?ZkpPNGNYbjlVSDFoTndMWW5qemIyTzF4UUY3THFmSE84emNhb3VWcGg3azZy?=
 =?utf-8?B?WkMyMktUVVBTUkxvYjZiTG9sUExuRy9XQXlHcUwvZERkT3MzMmcvbkc0UEIr?=
 =?utf-8?B?MHBDcFZxTUVOM3ZDWTFlM1pINVpDcm92bXhselo5Y0V5ZmJ2dEFMMlVCSWsr?=
 =?utf-8?B?Ti9pSHFHVWJuWGN5bVF6Qlg4eUhFZkRBRTVJeXJtcHdVSUNnUTJvVE02QXAr?=
 =?utf-8?B?QmJ5dWZ3SDRKQTNaN2RqZ2FUUUNFQ2RTckgrMzFobmtiNG9tMEFKTUFCa3oy?=
 =?utf-8?B?RHpTbU8xcU81d0JHQW5oRnVNSFZ5YXdWUnpEd1J5T2czcml6am9IdXFvMmpC?=
 =?utf-8?B?M0pMdy9kK21Yd1pjd0lObk9NMmJSVjUxK0tQVnJuaEIzMmRZQWpkNGI0UWw2?=
 =?utf-8?B?UlYrSDNUbjVTTFV2L1JvZ0NmQ3hHakVyM2tJVHFnZVZtMXpsdzcvam5nMk9z?=
 =?utf-8?B?eC9sTTNoeG5QMnFLQndoNE8yMGZQd21UVHIvbHh3S2VnVHB6Rm0rSklHbmlV?=
 =?utf-8?B?aGdWbmtUMENVMzlGZXR3aS9zd09SVkl3MTZLbUwvVVdsTzU3UGpsMlZTODM0?=
 =?utf-8?B?WEQ5cGJIM3h6NjI1M1pwVjBrOVBuMlU3cVpIS1hsL1lDcGc2bkRiN1FTeWtV?=
 =?utf-8?B?QUplRlZwL3BxZitQcWQ4YmdpZ0RLY2NtNHVNeVd0VEN3ZnN2YkRBRUlxTDN4?=
 =?utf-8?B?ZWt1a0E4RHNod2IyazlWNVZYSlZZV2VadFRwa3NEMEI0NXBmVDZycExPdmVG?=
 =?utf-8?B?Zk5zWTBHb3ZQZDl2RnhicFdlbDhiRml4UWxGUVk0N2ZKU1M4RFFGVU9obUlk?=
 =?utf-8?B?WlZzdzhDTE4rSFJYeUpqb0dZQ2N6NEVLQlNBd1I0eVNFM0Y0UmJqVGEyWEQx?=
 =?utf-8?B?L2NGdTlnNGdRblNoa2FmTm8vYTlvWnlFM2ZWcmllSmVmSWgwcDkxS0pnN0Ji?=
 =?utf-8?B?SUhvMElRbGJ0c0xLYmJySWdweldRSGptYTBsT2FFNGhFait6dzZ5eHJLKzZS?=
 =?utf-8?B?TW9pYk5yWGsyOTZwOTZYY0tFNVRlMy9CWmJiSnhlcG5TVmdvck1CeW5NdU1B?=
 =?utf-8?B?dFFKcjh0RXY5UG5wZkVNUUlMdDREV0NINS91Ui96QVBRWnp1azBkbXZjUHNI?=
 =?utf-8?B?ZC9SNXBXc1dueHJINWtFWXhaSm92elFVVCtvaWwxSUZFK05RRG5KUmxLTW94?=
 =?utf-8?Q?MPIqtuY67TVzY0DEY16d9s4qwX0Y6CFMSjdoWy59LDL3?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DFBB987C3BF41A49A5F360295105E409@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5565.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b955eb7-19c0-4a01-8c40-08dc3df6962d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2024 16:00:47.0032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZmgWfrHQ7XlgVgjvPtbSIXbgz2vj1/uRchog3BI6lEU97/XuSe/2rhXZvmbH7QYt8Cq5LB1lWRXMFhssXSLegQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5598

T24gV2VkLCAyMDI0LTAzLTA2IGF0IDA3OjIyIC0wODAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gT24gV2VkLCA2IE1hciAyMDI0IDEzOjA1OjE0ICswMDAwIERyYWdvcyBUYXR1bGVhIHdyb3Rl
Og0KPiA+IE9uIFR1ZSwgMjAyNC0wMy0wNSBhdCAxOTowNCAtMDgwMCwgSmFrdWIgS2ljaW5za2kg
d3JvdGU6DQo+ID4gPiBPbiBNb24sIDQgTWFyIDIwMjQgMTE6NDg6NTIgKzAyMDAgRHJhZ29zIFRh
dHVsZWEgd3JvdGU6ICANCj4gPiA+ID4gV2hlbiB0aGUgc2tiIGlzIHJlb3JnYW5pemVkIGR1cmlu
ZyBlc3Bfb3V0cHV0ICghZXNwLT5pbmxpbmUpLCB0aGUgcGFnZXMNCj4gPiA+ID4gY29taW5nIGZy
b20gdGhlIG9yaWdpbmFsIHNrYiBmcmFnbWVudHMgYXJlIHN1cHBvc2VkIHRvIGJlIHJlbGVhc2Vk
IGJhY2sNCj4gPiA+ID4gdG8gdGhlIHN5c3RlbSB0aHJvdWdoIHB1dF9wYWdlLiBCdXQgaWYgdGhl
IHNrYiBmcmFnbWVudCBwYWdlcyBhcmUNCj4gPiA+ID4gb3JpZ2luYXRpbmcgZnJvbSBhIHBhZ2Vf
cG9vbCwgY2FsbGluZyBwdXRfcGFnZSBvbiB0aGVtIHdpbGwgdHJpZ2dlciBhDQo+ID4gPiA+IHBh
Z2VfcG9vbCBsZWFrIHdoaWNoIHdpbGwgZXZlbnR1YWxseSByZXN1bHQgaW4gYSBjcmFzaC4gIA0K
PiA+ID4gDQo+ID4gPiBTbyBpdCBqdXN0IGRvZXM6IHNrYl9zaGluZm8oc2tiKS0+bnJfZnJhZ3Mg
PSAxOw0KPiA+ID4gYW5kIGFzc3VtZXMgdGhhdCdzIGVxdWl2YWxlbnQgdG8gb3duaW5nIGEgcGFn
ZSByZWYgb24gYWxsIHRoZSBmcmFncz8NCj4gPiA+ICAgDQo+ID4gTXkgdW5kZXJzdGFuZGluZyBp
cyBkaWZmZXJlbnQ6IGl0IHNldHMgbnJfZnJhZ3MgdG8gMSBiZWNhdXNlIGl0J3Mgc3dhcHBpbmcg
b3V0DQo+ID4gdGhlIG9sZCBwYWdlIGZyYWcgaW4gZnJhZ21lbnQgMCB3aXRoIHRoZSBuZXcgeGZy
YWcgcGFnZSBmcmFnIGFuZCB3aWxsIHVzZSB0aGlzDQo+ID4gIm5ldyIgc2tiIGZyb20gaGVyZS4g
SXQgZG9lcyB0YWtlIGEgcGFnZSByZWZlcmVuY2UgZm9yIHRoZSB4ZnJhZyBwYWdlIGZyYWcuDQo+
IA0KPiBTYW1lIHVuZGVyc3RhbmRpbmcsIEknbSBqdXN0IGJhZCBhdCBleHBsYWluaW5nIDopDQo+
IA0KPiA+ID4gRml4IGxvb2tzIG1vcmUgb3IgbGVzcyBnb29kLCB3ZSB3b3VsZCBuZWVkIGEgbmV3
IHdyYXBwZXIgdG8gYXZvaWQNCj4gPiA+IGJ1aWxkIGlzc3VlcyB3aXRob3V0IFBBR0VfUE9PTCzC
oA0KPiA+ID4gICANCj4gPiBBY2suIFdoaWNoIGNvbXBvbmVudCB3b3VsZCBiZSBiZXN0IGxvY2F0
aW9uIGZvciB0aGlzIHdyYXBwZXI6IHBhZ2VfcG9vbD8NCj4gDQo+IEhtLCB0aGF0J3MgYSBqdWRn
bWVudCBjYWxsLg0KPiBQYXJ0IG9mIG1lIHdhbnRzIHRvIHB1dCBpdCBuZXh0IHRvIG5hcGlfZnJh
Z191bnJlZigpLCBzaW5jZSB3ZQ0KPiBiYXNpY2FsbHkgbmVlZCB0byBmYWN0b3Igb3V0IHRoZSBp
bnNpZGVzIG9mIHRoaXMgZnVuY3Rpb24uDQo+IFdoZW4geW91IHBvc3QgdGhlIHBhdGNoIHRoZSBw
YWdlIHBvb2wgY3Jvd2Qgd2lsbCBnaXZlIHVzDQo+IHRoZWlyIG9waW5pb25zLg0KPiANCldoeSBu
b3QgaGF2ZSBuYXBpX3BwX3B1dF9wYWdlIHNpbXBseSByZXR1cm4gZmFsc2UgaWYgQ09ORklHX1BB
R0VfUE9PTCBpcyBub3QNCnNldD8NCg0KUmVnYXJkaW5nIHN0YWJsZSB3b3VsZCBJIG5lZWQgdG8g
c2VuZCBhIHNlcGFyYXRlIGZpeCB0aGF0IGRvZXMgdGhlIHJhdyBwcCBwYWdlDQpjaGVjayB3aXRo
b3V0IHRoZSBBUEk/DQoNCj4gPiA+IGJ1dCBJIHdvbmRlciBpZiB3ZSB3b3VsZG4ndCBiZSBiZXR0
ZXINCj4gPiA+IG9mZiBjaGFuZ2luZyB0aGUgb3RoZXIgc2lkZS4gSW5zdGVhZCBvZiAiY3V0dGlu
ZyBvZmYiIHRoZSBmcmFncyAtDQo+ID4gPiB3YWxraW5nIHRoZW0gYW5kIGRlYWxpbmcgd2l0aCB2
YXJpb3VzIHBhZ2UgdHlwZXMuIEJlY2F1c2UgTWluYSBhbmQgY28uDQo+ID4gPiB3aWxsIHN0ZXAg
b250byB0aGlzIGxhbmRtaW5lIGFzIHdlbGwuICANCj4gPiBUaGUgcGFnZSBmcmFncyBhcmUgc3Rp
bGwgc3RvcmVkIGFuZCB1c2VkIGluIHRoZSBzZyBzY2F0dGVybGlzdC4gSWYgd2UgcmVsZWFzZQ0K
PiA+IHRoZW0gYXQgdGhlIG1vbWVudCB3aGVuIHRoZSBza2IgaXMgImN1dCBvZmYiLCB0aGUgcGFn
ZXMgaW4gdGhlIHNnIHdpbGwgYmUNCj4gPiBpbnZhbGlkLiBBdCBsZWFzdCB0aGF0J3MgbXkgdW5k
ZXJzdGFuZGluZy4NCj4gDQo+IEkgd2FzIHRoaW5raW5nIHNvbWV0aGluZyBhbG9uZyB0aGUgbGlu
ZXMgb2Y6DQo+IA0KPiAJZm9yIGVhY2ggZnJhZygpDQo+IAkJaWYgKGlzX3BwX3BhZ2UoKSkgew0K
PiAJCQlnZXRfcGFnZSgpOw0KPiAJCQlwYWdlX3Bvb2xfdW5yZWZfcGFnZSgxKTsNCj4gCQl9DQo+
IA0KPiBzbyB0aGF0IGl0J3MgdHJpdmlhbCB0byBpbnNlcnQgYW5vdGhlciBjaGVjayBmb3IgImlz
IHRoaXMgYSB6ZXJvLWNvcHkiDQo+IHBhZ2UgaW4gdGhlcmUsIGFuZCBlcnJvciBvdXIuIEJ1dCBv
biByZWZsZWN0aW9uIHRoZSB6ZXJvIGNvcHkgY2hlY2sgbWF5DQo+IGJlIGJldHRlciBwbGFjZWQg
aW4gX19za2JfdG9fc2d2ZWMoKSwgc28gaWdub3JlIHRoaXMuIEp1c3QgcmVzcGluDQo+IHdoYXQg
eW91IGdvdCB3aXRoIGEgbmV3IGhlbHBlci4NCj4gDQpJZ25vcmVkLiBJIHdhcyBob3Bpbmcgd2Ug
d291bGRuJ3QgZ28gaW4gdGhhdCBkaXJlY3Rpb24gOikuDQoNClRoYW5rcywNCkRyYWdvcw0K

