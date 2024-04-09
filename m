Return-Path: <linux-kernel+bounces-136843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BD889D8E1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE0B71F21BA5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1824E12DD97;
	Tue,  9 Apr 2024 12:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b="GYQp9av2"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2091.outbound.protection.outlook.com [40.107.93.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D1712AAC8
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 12:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712664438; cv=fail; b=sKc+8CtveAFlY5tBomoyy8StrUZ0y+1cMidCu5cWiwc8Fg0axL76tEJDGUxo3X/wC6JalQ3JAUniOpjRyAZ3ecxnaMGezu9PKU7CFq9SDY/h+6s+3Q7pyydTiWukCYH2Ln94/dYZdAyP3wghblonT4DNaVcjCq7lizMYmZ1Tgj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712664438; c=relaxed/simple;
	bh=E1Er3LI5xLPUuCf5+LDTPmExZ89HrYcF0O9GhE/PHY8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lcsyUHPEnBAoGjifH5bvKmgCO+C/g4LcF4DNrOj40LKc9rw/XIL6DxpYwg2qXfKvnH3Gnka/MoOgJSpFilxSsFBFPy+6j5P8xISv2KeVjYqOKhQ6D7/plyG9WkbkgcpXvPcmBSsFn05alO7+r1N6RlURnd8D1i6fqafs8BP8ST8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it; spf=pass smtp.mailfrom=asem.it; dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b=GYQp9av2; arc=fail smtp.client-ip=40.107.93.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asem.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KkhOyiaNhZ0pE6Rw10YfM8jOWCMualq1WkIl39hAvxLCDnBOOIeU95Yt6fyZ2nky2xUtnKcZwT/H8ZI31RIx08jv96tPx8d56jlcQ3JgxFndcWALQI2H1WLpdS+CIRlRzgK6soqMz9tjoZgq0Ox5dJfWo9R4TsuwKp7wEfOBy5vFcUDvzckTnvQpteFbk93czNa07FFSgracm4Md9PTI/VULoZXWCbQvUWTaueUHNF6gQa5Ynki7Sw5yhSSFA9wMWQLjCYj5fL7gsKwk7nfhCZhZfEaZGEQGX1/rzxGttyP41cNYASy+OjNCuQlPNlQm3hEt2VyXpIQ0prtTQ7IMXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E1Er3LI5xLPUuCf5+LDTPmExZ89HrYcF0O9GhE/PHY8=;
 b=m/Ax0jjNVCP/su2ALMfcM+WbSnNB69q7wtj4hReTTwL11OzXCZM4TY/CDcugOfgw+EieXIQwXdBFAqA/FUpi7NQujuZKVqJABV1E9ul71rzDEp/RiITQmLKizXhgMNxOteCJI+mJHUGe4XLPVb7xRa9bA/asnmkfo88ByxpQ5dazcwFJt+MpY2ZFF43eP7gOM4r6BrSaLjcuOzdQngStDQAWKsg9wAI404UPVlVsXTHBa5dWdIVpw2M+Hi4EithBxA3pNrg79NU0HYFX5ClzLSIbQMPFtlJSvT0GPD2U1WmzvXxn6TeqqJ0rokg6fErE4ur5J6wdp9rGE49EQe9vnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=asem.it; dmarc=pass action=none header.from=asem.it; dkim=pass
 header.d=asem.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E1Er3LI5xLPUuCf5+LDTPmExZ89HrYcF0O9GhE/PHY8=;
 b=GYQp9av2pdoL4SzxGpkimTKHwN+RrNoc8kvHbBUG9NPDAoVVOGI0SoaTWj2HyLoFxlGiHqnZjH1wafBdGwk0+vBIzvJeWrGuC5dw/8J/TU8BSLaWCE7tvjn/WKxj6I03xlF8FYB9dK664B37ROqDE6ouNUb/jMmA0LOnsnLIcVKateJ/zQcL7Np2xTtLaPFZgJ9R0WQTRRLXZPlxEukNjVdtWWdb4k1WbmVjbPMBDV1loyOFjkTc9iPsbYoWra6/B8n6P2Wmn/xo90M0Xu/ZGbSU/tCGycbhbz2JORDv/o3ajyc74t6tV+onHVFjEfmj0dxTeuOrQAU+8QjmNnItaQ==
Received: from PH0PR22MB3789.namprd22.prod.outlook.com (2603:10b6:510:29c::11)
 by DM4PR22MB3675.namprd22.prod.outlook.com (2603:10b6:8:66::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 12:07:14 +0000
Received: from PH0PR22MB3789.namprd22.prod.outlook.com
 ([fe80::35ce:ff48:fa8b:d4a7]) by PH0PR22MB3789.namprd22.prod.outlook.com
 ([fe80::35ce:ff48:fa8b:d4a7%7]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 12:07:14 +0000
From: FLAVIO SULIGOI <f.suligoi@asem.it>
To: 'Michael Walle' <mwalle@kernel.org>, Tudor Ambarus
	<tudor.ambarus@linaro.org>, Pratyush Yadav <pratyush@kernel.org>, Miquel
 Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
CC: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: EXTERNAL: Re: [PATCH 1/1] mtd: spi-nor: everspin: add em004lxb
 entry
Thread-Topic: EXTERNAL: Re: [PATCH 1/1] mtd: spi-nor: everspin: add em004lxb
 entry
Thread-Index: AQHah2eFH/UzLpYvwkmv+sCIpITisLFf3RJ1
Date: Tue, 9 Apr 2024 12:07:13 +0000
Message-ID:
 <PH0PR22MB3789719A62A1EE483C9FDF76F9072@PH0PR22MB3789.namprd22.prod.outlook.com>
References: <20240405100104.480779-1-f.suligoi@asem.it>
 <20240405100104.480779-2-f.suligoi@asem.it>
 <D0C9NCOMI27O.2VW2U3FNFTSPK@kernel.org>
In-Reply-To: <D0C9NCOMI27O.2VW2U3FNFTSPK@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR22MB3789:EE_|DM4PR22MB3675:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 kQLW9//VrI533LIsCjcQGYFZT7VZticbvGAiiwCAWi2SirsLpy21LzVOIk1pNHVufoSDHZOcR3YaDOvJmWcfCGdQ/unfZpph2pHVMsQQHyjkkwtkbD+2DkQiEFqk9FP6x5I2GrebI8qRFuH+h26yXA8BP86mAujZecz2I260cbLJktQdPIXh9BU17IibN9Tzlg0f/OSpQeZqNd7QTvM4vVbwirXTKH8I1EGLVYfat03TWth5XWewjGK+QrbYyQx2gloCz9eio0pZlJ3384yNnxwvTfytSXS2jUZ91uu7aFy4AtpWOAajrGfb0/gt4DHQQ9wSSbx5AwNiyHSBPx3WuXnJ4At4XC8/8MBlC6s+Sfs5U48AzN08lSoKWaZ8sF8RYOAt4Eh8fuksUe4nT+TKL/7Zin+mTRi7yx/AZUCRg3tUXVnQUc2hCgGd36gtawtTU8Uh2dfSm5+LvgOE9dYyPXL9mMT0sNMDBosryPWGcNYJYZivP0rWZVJNmv7orUT4EoIWB8WZEdFmE3IjptFk+k+IZcvCWQxp0p4XlJVQRIFp00xOVTqsPxjUgtgJcUKYaJKMvx34AXxWlRLVrlXPnhGn/DsGbBm2XefB5+YXYSVX8d28MvA6ZMQhlPfEhOtpLmoa0fd5MmKCFZd+IdE9O6zprqqsUNtIm1TfzsqHv2E=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR22MB3789.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S0VFRGhWNm5VdTBMWVN1c3IreTRmQ3RaTzNMRjZseStwVDBJcHRpbXJ4VXR4?=
 =?utf-8?B?a0xWWVFFZWFOT1VHWXBLS0tBNjBZTGQ4N1JMVGpzK2xKc2lrSEh4U3pMdHp5?=
 =?utf-8?B?ZDl2aU9ZanBMS2p3VHMzOXNYek1PNVoydU02Z2YybUpiWFdUR1NpY0tZVEky?=
 =?utf-8?B?VkJQcXZpMUxieEdmOWsvK2F1YlJaUVNtbzZPbzY0eUgvMGZTVmNlM1pBNzJy?=
 =?utf-8?B?dkFjb1BBZklEdnIrZm12ek56cU5nQUxTekNHS1c2WlJqeWY1MllEc01xRVJ1?=
 =?utf-8?B?VG5CVXRmL2xuTDZENGVOaS84WkFNYTRCN1I2UlpBZzlvTFdOanpoSXN2QytK?=
 =?utf-8?B?NitlZk1UR1pOUVd0ZjZTbkdYQk9KYmJhMGxHWE1XQ28zellNVVg2c0JucWtv?=
 =?utf-8?B?WE84WnV5RjFIQ3NXKzh6alJNQkFQWWpZOFBHNWhiUkVkNzd3V3JTd2Q1c2Fn?=
 =?utf-8?B?ZDJGSEVZalQ4OFAyYVB6N0ptVDBPaEVZYnRKK09hYUFVM0lBVjdjVHM0R1oy?=
 =?utf-8?B?MWd5K1IxTG9VSVlVK1hnaWVMbWRFUGVkZkZ4czVzQmVhSXdSbzkwVEJDcmk4?=
 =?utf-8?B?UXExOFNiR0diWkRIWERxZHVpdzFzQi80enk0WGRrZ3h5VVc0UlBUdC9GRTBT?=
 =?utf-8?B?UzYvSFA4RWhnSTQ4b3Irb01YODA1cWhkbVg4MmZWVDUvRDA2amRkNWZ1YldU?=
 =?utf-8?B?R1hLcXFaZmZlNkQ5TkpBOE1VSXp5UVJtbUNweENMUFdWQjloTWxycXVtN0dm?=
 =?utf-8?B?UVcyOEJyR3lhaUpkZkN3Zlo1cEVFNHRNV0ZtckpqTnFmU2JoNDhURnIyUy83?=
 =?utf-8?B?c0FQaDJiU1crbDBUdWJOVWxWQ3hVOFk4VDM1MDNnanYzb1FuOGVkSit1QkM3?=
 =?utf-8?B?SWQxcTM1eUdiVjF1RXZpazJwaWEvUHdERnpISldLZE91VEdseW9kd3pZQ2lI?=
 =?utf-8?B?YjZmOEF0V0RPK3grS2ZhRXVBeHBQV2luZUYyV3QzZzY1RXhnbHBpcmQ3bjVX?=
 =?utf-8?B?KzlqV0ZNZG9rZTBuQ3JTa2dGSDFFNk9KWWZ5Z3pIR25aQ3FoN1hDdUxlb2Fi?=
 =?utf-8?B?S1NwVHp6MFMvMDF2MW8rcnBtZDlITGFJRFBTV3FacDExM2FrUWFmZ1hYRWxt?=
 =?utf-8?B?RHFBZFNJdGcvQ3MxQnBwMGRNQ0puVHRIWmo0UUdhVFVGZVhtekozYmpJNy9H?=
 =?utf-8?B?NWhiQzUyTzUweGJDZFgxZWU3SW5BMlRaaG4wL1pMZDF0akQwMTBxYUdBK0VH?=
 =?utf-8?B?SUx0K3kyUmplK3lpQjdyVDBuNjNOMVo3ZlNnQzM4aWZjYUNrOE93djBNQ3ZM?=
 =?utf-8?B?OWIvc0VtOVZKMHN1eVFCTStoV3NXak0veHc0VGhtVTZPQlVMWTUwbXF6bmZn?=
 =?utf-8?B?UzFGUnJINGdJdU8yV2Q4UEFBYmtqVUQ1eVBvbDlEcStlZ0V4bENDazBBbjAv?=
 =?utf-8?B?LzJhTmpMY3M5QitSU3JwcHJsYXlrQVN2TE9HcS9oTldBUmRqdTk4SCt3ck00?=
 =?utf-8?B?d1pQcGtCb0s5MDdCV2RMdkR1YUo1d1cxQnVQaWhrY21Gay9NQjgxNklHKzFY?=
 =?utf-8?B?c2JRd1RaNlZwaU5nbStZYjh6a2VFR0xJSWxNdHBHWWZCY3VQOGdTRE0xclJv?=
 =?utf-8?B?eS9wanFpQXQwZEFPTFh6QWMrZkFVT2FUSnlSVWdzWkJyYnlLeGlRckFHYTQz?=
 =?utf-8?B?c3VSaEdWU3QxQjhMR0lZek5YMm9SMWlmc1lTYjl4OUJsWlVENkE4WGtUSWlS?=
 =?utf-8?B?NXArcUQrR3cyTGtSTS8wdUkyUGk5VjM5b3RaU0hVeEg2VlMvSWtjVEJ6Ujll?=
 =?utf-8?B?MjdnMzBVb0d1alNrUzFOR0dXeWdsNTVINnFMQmVPSTF2ZHgvdStqcWExTC92?=
 =?utf-8?B?MTROTTIvUHBvZlYxNDNzSmErV2Zsa1M4R0RYQW0yK1R2NFZCMmNEQ09lcmlM?=
 =?utf-8?B?Z2E2QnVsSnk3SzJpby9UQUhlbk9zdnBwN29TMFRHbVFrUGZmdkprQ0NDSkZv?=
 =?utf-8?B?YnBVTUxERHFKb090K214amJKampqMXl4TTFyOUl3OXEybFZtT1RoUURqdWFh?=
 =?utf-8?B?OFhsRDZ5SjhxUnc5QUNjcm02aEZxUlFscFFkRXhuVFozK1FQamZxVEdJdEJr?=
 =?utf-8?B?TWNBUVUrWTNTRHNaTWVGSVc3WllyQURIL1E1NTVUa2JXQVh4QnJJOUx5RG93?=
 =?utf-8?Q?9lqVXEFW8J6vI4teQ14s7ak=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: asem.it
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR22MB3789.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84b90847-c0a6-4b29-9c20-08dc588d97c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2024 12:07:13.9611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 855b093e-7340-45c7-9f0c-96150415893e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QG8uqFAn6/Zy6DQfmaT7PBcmvphzLQU/vl94q3H/Jecw/y3Dc9sL8Q6zHQkj36taLe6csyBGn9V6gmFhcIqAZc++P+ftvpeGMJJdG5He6K9wrmzdwwmjr+dKZGRUJF+K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR22MB3675

SGkgTWljaGFlbCwNCg0KLi4uDQogDQo+IEhpIEZsYXZpbywNCj4gDQo+IE9uIEZyaSBBcHIgNSwg
MjAyNCBhdCAxMjowMSBQTSBDRVNULCBGbGF2aW8gU3VsaWdvaSB3cm90ZToNCj4gPiBBZGQgdGhl
IEV2ZXJzcGluIEVNMDAwNExYQiA0TWIgKDUxMktCKSBJbmR1c3RyaWFsIFNUVC1NUkFNIFBlcnNp
c3RlbnQNCj4gPiBNZW1vcnkuDQo+ID4gVGhpcyBkZXZpY2UgaXMgSkVERUMgY29tcGF0aWJsZSAo
SkVTRDI1MSBhbmQgSkVTRDI1MS0xKSwgYnV0IGl0IGlzIG5vdA0KPiA+IGFibGUgdG8gcHJvdmlk
ZSBTRkRQIGluZm9ybWF0aW9uLg0KPiANCj4gRGlkIHlvdSB0cnkgdGhlIGF0MjUgZHJpdmVyIGlm
IGl0IHdpbGwgZml0IHlvdXIgdXNlY2FzZT8gSnVkZ2luZyBmcm9tDQo+IHlvdXIgbGFzdCByZXNw
b25zZSwgaXQgc291bmRzIGxpa2UgaXQgd2lsbCBkby4NCg0KWWVzLCB5b3UgYXJlIHJpZ2h0LCBp
dCB3b3JrcyB3aXRoIGF0MjUgZHJpdmVyIQ0KVGhhbmtzIQ0KDQpBdCB0aGUgbW9tZW50IEkgaGF2
ZSB0byB1c2UgYSBwYWdlIHNpemUgb2YgMjU2IGJ5dGVzLCB1c2luZyAiYXRtZWwsYXQyNSIuDQpT
aW5jZSB0aGUgRXZlcnNwaW4gRU0wMDA0TFhCIE1SQU0gZG9lc24ndCBoYXZlIHByb2JsZW0gd2l0
aCBhbnkgcGFnZSBzaXplDQoodGhlb3JldGljYWxseSBJIGNvdWxkIHVzZSBhIHNpbmdsZSBwYWdl
IHNpemUgb2YgNTEyS0IpLCBjYW4gSSB1cGRhdGUgdGhlDQphdDI1LmMgZHJpdmVyIHdpdGggYSBz
dXBwb3J0IGZvciB0aGUgRU0wMDA0TFhCIE1SQU0sIGFzIGFscmVhZHkgZG9uZSBmb3INCnRoZSBD
eXByZXNzIGZtMjUgRi1SQU0/DQoNCj4gDQo+ID4NCj4gPiBMaW5rOiBodHRwczovL3d3dy5ldmVy
c3Bpbi5jb20vZmlsZS8xNTgyNDQvZG93bmxvYWQNCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEZs
YXZpbyBTdWxpZ29pIDxmLnN1bGlnb2lAYXNlbS5pdD4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9t
dGQvc3BpLW5vci9ldmVyc3Bpbi5jIHwgOCArKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwg
OCBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvc3BpLW5v
ci9ldmVyc3Bpbi5jDQo+ID4gYi9kcml2ZXJzL210ZC9zcGktbm9yL2V2ZXJzcGluLmMgaW5kZXgg
NWYzMjFlMjRhZTdkLi40NzQxOTMwY2U5YTgNCj4gPiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJz
L210ZC9zcGktbm9yL2V2ZXJzcGluLmMNCj4gPiArKysgYi9kcml2ZXJzL210ZC9zcGktbm9yL2V2
ZXJzcGluLmMNCj4gPiBAQCAtMzEsNiArMzEsMTQgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBmbGFz
aF9pbmZvIGV2ZXJzcGluX25vcl9wYXJ0c1tdDQo+ID0gew0KPiA+ICAJCS5zaXplID0gU1pfNTEy
SywNCj4gPiAgCQkuc2VjdG9yX3NpemUgPSBTWl81MTJLLA0KPiA+ICAJCS5mbGFncyA9IFNQSV9O
T1JfTk9fRVJBU0UgfCBTUElfTk9SX05PX0ZSLA0KPiA+ICsJfSwgew0KPiA+ICsJCS5pZCA9IFNO
T1JfSUQoMHg2YiwgMHhiYiwgMHgxMyksDQo+ID4gKwkJLm5hbWUgPSAiZW0wMDRseGIiLA0KPiA+
ICsJCS5zaXplID0gU1pfNTEySywNCj4gPiArCQkuc2VjdG9yX3NpemUgPSBTWl81MTJLLA0KPiA+
ICsJCS5mbGFncyA9IFNQSV9OT1JfTk9fRVJBU0UgfCBTUElfTk9SX05PX0ZSIHwgU1BJX05PUl9I
QVNfTE9DSw0KPiB8DQo+IA0KPiBXaWxsIGl0IGFsc28gd29yayB3aXRob3V0IFNQSV9OT1JfTk9f
RVJBU0U/IEFsc28sIHRoZSBmbGFzaCBzdXBwb3J0cw0KPiBmYXN0IHJlYWQsIHNvIGRyb3AgTk9f
RlIuIEFsc28sIHBsZWFzZSBoYXZlIGEgbG9vayBhdCBbMV0gZm9yIHRoZQ0KPiB0ZXN0aW5nIHJl
cXVpcmVtZW50cy4NCj4gDQo+IFRoYW5rcy4NCj4gLW1pY2hhZWwNCj4gDQo+ID4gKwkJCSBTUElf
Tk9SX0hBU19UQiB8IFNQSV9OT1JfNEJJVF9CUCB8IFNQSV9OT1JfQlAzX1NSX0JJVDYsDQo+ID4g
KwkJLm5vX3NmZHBfZmxhZ3MgPSBTUElfTk9SX1NLSVBfU0ZEUCwNCj4gPiAgCX0NCj4gPiAgfTsN
Cj4gPg0KPiANCj4gWzFdIGh0dHBzOi8vZG9jcy5rZXJuZWwub3JnL2RyaXZlci1hcGkvbXRkL3Nw
aS1ub3IuaHRtbA0KDQpUaGFua3MgYW5kIGJlc3QgcmVnYXJkcywNCkZsYXZpbw0K

