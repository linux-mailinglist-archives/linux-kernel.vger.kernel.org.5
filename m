Return-Path: <linux-kernel+bounces-67652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 566F5856E8C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 21:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AC881C2269A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12A213AA4B;
	Thu, 15 Feb 2024 20:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="H8F5PHeK"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02olkn2093.outbound.protection.outlook.com [40.92.44.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EAD138497
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 20:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.44.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708028806; cv=fail; b=Mtp+EyJ/n/ue0/5jUayVFIAE21mAz0AZPWOeoEmfyLfK49q7r2a01ASp45qA/Wgq6jNbIpFLbcHkFAftRVLeiPQtuvC8CvOyX2gt4ErhJZ/cbvkdcixukMXStjCp3ZDWEvSww59NkMqvKyxMFdmGcUOjfNOxqAvxP/3MbuUCEG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708028806; c=relaxed/simple;
	bh=xZ/Bgk7yJ+PNapz/y1SMNpFBii0TdS4L6JbAZEQHHZs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JMV1c4+ZEUBsA7OWlSVfIdAmUxhXvNvuvUUB12RtIMLU9uGcDpmQAFYuyN+JC22PlJ9MspI854OlkcboXf4cTKJDlrvCHjE6hay+Qc5kZS9ss57vTkOk8figIwE0q7+zH249m5YpLyxmwZL+o6gkNXM0ApwLlfjKk9NXCqDMkCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=H8F5PHeK; arc=fail smtp.client-ip=40.92.44.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dD9V7UAGP/nuVLBnA+owevZgk4yRflnzt2oJLq0HFcMDUCxQjAvLouAGb2x9sC4iZFwl6F+kjJZAKsD/kEuH359YUNmA2YDh1yumDzyp/GLJmAvtwbQzhtsXwauBUWQmcpztHAuddfrhyAkNCRJOyZtZ8YHeFhaQ9f4uemA1GkGOGIwiXoPpTHwfj1gEakPxUiH67YBaRQUEVix98J7PA09+jR+ZiMsldJaNS7W8vAkH+QieNElYTRJ0d+foQJyglcZQyqQKk6uCu9X20lk+zQRZwmgr3VVop0Gl3Gg8sbcoZu3AWJM4jgJgOSfPAF69FE4JRWZMSWJ6ps5IRCgE0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZ/Bgk7yJ+PNapz/y1SMNpFBii0TdS4L6JbAZEQHHZs=;
 b=Y7oac3GTdqw7zd7rfgnS6t0fwIt5tfonx7+pKMDhy44m0Vk9AbNpFMfGlr+qXdUBNzwLiEj6D3pmyTq4bsEA7SJDLcnqtydL681MsfgBnag3BmPKEZuM/eFIb4k3mECLPYyzK/bf/IRzL5JQ5uxdmO+CQsTMB6OtlbhI1PUXA8rL3SZRTd1kRldsdYxklp6LtOwCInvqwcqx4zftw3nYd0E31rHBpPk/tOgGCZi5pmjRB7bggA76KGm7IeUWeEKPMs6X44I5EuwiCiitPgTqaTZithRUiM0sioVzEB0Jggm6puqVs/fsG0E9SLci3yrvDqB5P8eQWNNAvR1tLtolwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZ/Bgk7yJ+PNapz/y1SMNpFBii0TdS4L6JbAZEQHHZs=;
 b=H8F5PHeKKtrJUG5OxU6rv4VlotXUVKUt1AunYHFkdQSlFnpNWkXayZaDuhL+E5JcbboeLQLqJ4l3thjadhJRufu5hmCPfTnnEYJfWKGbmf9XiNNHvEiPNghloLWnV20FgVsz5a4GB2ZMLKuMJVwxsIl9DTCVjsV4ZJ06dLFoKUDs+obfudcLgwTE76Tqv/fZ5VPvbCNlx7cF7rnKxzAO5NHxlSD8Yf5xWgP9loy8lI8RYvKvpDt0NY6w+xWL5RoN8Q1zUG1/P0LF+VvHDd78N1Lb0c9g7jrmDCZwPrbgc2Bv0Dqu7Wxw/P5NJt7R6UqapZtaLky2txUtfOKsb6CpWQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BL3PR02MB8017.namprd02.prod.outlook.com (2603:10b6:208:358::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.27; Thu, 15 Feb
 2024 20:26:41 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd%5]) with mapi id 15.20.7270.033; Thu, 15 Feb 2024
 20:26:41 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Alexander Graf <graf@amazon.com>, Vishal Annapurve
	<vannapurve@google.com>, "Kirill A. Shutemov" <kirill@shutemov.name>
CC: "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"rientjes@google.com" <rientjes@google.com>, "seanjc@google.com"
	<seanjc@google.com>, "erdemaktas@google.com" <erdemaktas@google.com>,
	"ackerleytng@google.com" <ackerleytng@google.com>, "jxgao@google.com"
	<jxgao@google.com>, "sagis@google.com" <sagis@google.com>,
	"oupton@google.com" <oupton@google.com>, "peterx@redhat.com"
	<peterx@redhat.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>,
	"dmatlack@google.com" <dmatlack@google.com>, "pgonda@google.com"
	<pgonda@google.com>, "michael.roth@amd.com" <michael.roth@amd.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
	"isaku.yamahata@gmail.com" <isaku.yamahata@gmail.com>,
	"andrew.jones@linux.dev" <andrew.jones@linux.dev>, "corbet@lwn.net"
	<corbet@lwn.net>, "hch@lst.de" <hch@lst.de>, "m.szyprowski@samsung.com"
	<m.szyprowski@samsung.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: RE: [RFC V1 1/5] swiotlb: Support allocating DMA memory from SWIOTLB
Thread-Topic: [RFC V1 1/5] swiotlb: Support allocating DMA memory from SWIOTLB
Thread-Index: AQHaRRu2XlAVwhlX4keozaeeIIQbSLEKH9+AgAE9Hc6AAK9p8A==
Date: Thu, 15 Feb 2024 20:26:41 +0000
Message-ID:
 <SN6PR02MB41575CFBC54C46701110703CD44D2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240112055251.36101-1-vannapurve@google.com>
 <20240112055251.36101-2-vannapurve@google.com>
 <etvf2mon464whscbxqktdd7bputnqmmwmoeg7ssixsk4kljfek@4wngbgzbbmck>
 <CAGtprH-95FEUzpc-yxQMo87gpqgMxyz9W8tiWtu_ZHhMW-jjuA@mail.gmail.com>
 <8a6dabdf-dc11-4989-b6b4-b49871ff9ca6@amazon.com>
In-Reply-To: <8a6dabdf-dc11-4989-b6b4-b49871ff9ca6@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [baEvVU65RiHyY/1eZ6UPQgh2FHhU8GEH]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BL3PR02MB8017:EE_
x-ms-office365-filtering-correlation-id: c4f24484-a5ad-45d1-33f7-08dc2e646b74
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 AFiHlx9G41oaMIuMoby5tL1cN8LM3r4Zgk2mXB+x7bPMqoUl+YFmLS3P14wP2MhnLq3xJa6chdvgniJVr5efbrkQuBuMkRiBuHffVmMt3yV7XqnMA5sXXKMY9iVn0wtB9Y9v3m/q5R68T5iHA5y4NmHRH2rarX0OQOJRh02O+52eTaoshSghnk5G/qOyJvtkHhnAVBXcqMDpx4AHaNKR7vzNn/cOoCBtjtd4aA3gz07zFugppEMWoH/0ZIVm8GGg2MgdAXKlWdV/KK8mDjoKtkXD+fV5IqANiXoeh0tpuIk0y7iohha8lzynDEnRvVlzugEzrBneVzP/rnOY1THrC+j4B2BrC0F77EXa0IeaQg017qtFJ+bbC6RzrZrsPYfcFdLmZ6BhHzYwv8CCd/Mj6G8UX3dG8M5VJ/k9dsaRbWwFN1/xs9144y+/XcCqlzTtp+K1xDq+hIiVENAZvUsOEE1BWlHMtxsCbk3/ejy5ODzLCyioWxqBNHB6bkVg0tRcU14dudrnsTr9KVDp6eDqNzE+ArsC0Qo0sOTTZ1eEKTIDOlW6oZUhAXkc5SuQWB/J
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TzZYVHZ4Z0Z3UmYyTER1bEVLU3R1MDhLN0l6UjVyY2FMT28zcnhnYzRRY2xX?=
 =?utf-8?B?MWRjbDNLd0xkeHRwRWtWTWtiSm0wdHpyNXZNMzVtUW4yRXU0QTMvQzhPaDZy?=
 =?utf-8?B?UGVOV29sakx0Z2dsUXNFN20wa0N2SlJBM1gyd3o4Q0tvRWM2V1FOL0ZZWDRi?=
 =?utf-8?B?VzFjOVl5QzVlZXdDaFVKbjdzY0E1SEdDWE8vc3gxeXVld2g5bXlaQVFjU3VD?=
 =?utf-8?B?V2NscktDMEVESlQveUlDZ3ZEcWNtdTFpNVFXOGgxNThya2VTQzlRYTRnUmYy?=
 =?utf-8?B?a3VPUnBXYUVjaG41R1hWanlyWmZtWnQ3ZE9nNVB2cFFpa0tQWVZTcjVSMVJi?=
 =?utf-8?B?eGxhc2NMMnFuRkFmMy9IaUxna1NZVWJ6QThKQTRZRGh1Zi84NnRVcVVabExi?=
 =?utf-8?B?VGdlY0E3YlhKaDh2SXNEa2hLTVpjSDVYaDN3VWF3b1RGR1RTZkZFbUwvdjhD?=
 =?utf-8?B?Y2NZVDcwVHNweko3MEhBT1g1d1I3Tk5la2xDcGp2UHlFYXZabnU0dnA3a1pz?=
 =?utf-8?B?YTdMNUZ4N1ZCeXoyTUc0SGg5SHBKYUVLQkovRjI2dml2eHRsMXJJa3Job3l3?=
 =?utf-8?B?SVk1VjJtajlndXROSlFwOTNsMTVlSklackhsRldCaHV6c0VxWWFOLzJkWk00?=
 =?utf-8?B?RHF4clJ2VEEyWFRtV2VzVDdCODkrTkd0a2svY3dNWlczYlpPdmtCUWtKbnVk?=
 =?utf-8?B?U2ZlczhycC9HRXhobzlDZ3F6MDlrN3l1eUxKb0pVQ3hBUktCT1lQWmxSQnVG?=
 =?utf-8?B?OWNhYVQyUTYzcDd6bXNwVkdtUW50SWN1VFNQTEEwV1p5M1gwZVZocUtFMnhH?=
 =?utf-8?B?Ums5RnkyUmFTVjBjbWM2T3dCQnF0U3h6T3R3NTMxczFvWHd6WWdDWGJyY0gx?=
 =?utf-8?B?elpwN3pzUkM5SHQ1RWlLc1YreHVPYXhXcHRGVzlwS2VxSlU0dGxPRHdPelA0?=
 =?utf-8?B?Y2pOUGtxME5INkhTMlF0a1NXN1NzQzV1UXhPUWlBOXR6L3pTVjJXV05wWFQ2?=
 =?utf-8?B?eG1yRzdKTzc3dkJhT2J3YnBRQTA2REtuRDBkSWF0ZVFIc1Z0dTVUcldTSHdG?=
 =?utf-8?B?TTZ6akpHWVdRWXh4ODNrdDlOVGRJRzVIK3k0Q2FhWnRvRDlMU01oQmpNV1pk?=
 =?utf-8?B?MUtQNUFTY1Q1ZFZ3RWpqOHdXK1R6dG9xMFA2REczWE9QTml2Z1IwcHg5RnhH?=
 =?utf-8?B?emdqcE5lbFdvSUZPNlVpdDVqQnJ4bDY4WGNaWjVtTXNIQkI1SzFpdzBrYnFU?=
 =?utf-8?B?MUZnc3J5c2ZvUXpiNmNMWHJiS3U2YUt0b1Blc1YwWHkzYjN2M0dOZkF6UTBx?=
 =?utf-8?B?QzFZQjBLWkpaS2MzS29Ma2R1bkhlQ2d6V1ZQeGlTSldiWFR6L2JVQTdSejdO?=
 =?utf-8?B?dEl3aTg2T21BN0dodVI2THVzcXBNZEI5WjMrQkVlTHhRNE1jQmlXQ3J3cDdQ?=
 =?utf-8?B?Q3RQNkFMUWwxelgwNWEwZnpFZGlWMHJvaThMeDFYZUdjMUpiZWFpZFljTHJU?=
 =?utf-8?B?OHdFRG1zTDRNT0dpNk93NFE4ZXpTdUw0RHZvazBkalV2NER6K1lNM0dWWkQw?=
 =?utf-8?B?Y3ZqakJYTE5TUWZBQmltb293ODVVWGIvS3lnL3pxdk0yRmRwQW95dlFFaDJr?=
 =?utf-8?Q?hvbQOsyOUN7522Mn6Qn1X/qNyEF2AWmexgD9XCr2vTyc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: c4f24484-a5ad-45d1-33f7-08dc2e646b74
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2024 20:26:41.3944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8017

RnJvbTogQWxleGFuZGVyIEdyYWYgPGdyYWZAYW1hem9uLmNvbT4gU2VudDogVGh1cnNkYXksIEZl
YnJ1YXJ5IDE1LCAyMDI0IDE6NDQgQU0NCj4gDQo+IE9uIDE1LjAyLjI0IDA0OjMzLCBWaXNoYWwg
QW5uYXB1cnZlIHdyb3RlOg0KPiA+IE9uIFdlZCwgRmViIDE0LCAyMDI0IGF0IDg6MjDigK9QTSBL
aXJpbGwgQS4gU2h1dGVtb3YNCj4gPGtpcmlsbEBzaHV0ZW1vdi5uYW1lPiB3cm90ZToNCj4gPj4g
T24gRnJpLCBKYW4gMTIsIDIwMjQgYXQgMDU6NTI6NDdBTSArMDAwMCwgVmlzaGFsIEFubmFwdXJ2
ZSB3cm90ZToNCj4gPj4+IE1vZGlmeSBTV0lPVExCIGZyYW1ld29yayB0byBhbGxvY2F0ZSBETUEg
bWVtb3J5IGFsd2F5cyBmcm9tIFNXSU9UTEIuDQo+ID4+Pg0KPiA+Pj4gQ1ZNcyB1c2UgU1dJT1RM
QiBidWZmZXJzIGZvciBib3VuY2luZyBtZW1vcnkgd2hlbiB1c2luZyBkbWFfbWFwXyogQVBJcw0K
PiA+Pj4gdG8gc2V0dXAgbWVtb3J5IGZvciBJTyBvcGVyYXRpb25zLiBTV0lPVExCIGJ1ZmZlcnMg
YXJlIG1hcmtlZCBhcyBzaGFyZWQNCj4gPj4+IG9uY2UgZHVyaW5nIGVhcmx5IGJvb3QuDQo+ID4+
Pg0KPiA+Pj4gQnVmZmVycyBhbGxvY2F0ZWQgdXNpbmcgZG1hX2FsbG9jXyogQVBJcyBhcmUgYWxs
b2NhdGVkIGZyb20ga2VybmVsIG1lbW9yeQ0KPiA+Pj4gYW5kIHRoZW4gY29udmVydGVkIHRvIHNo
YXJlZCBkdXJpbmcgZWFjaCBBUEkgaW52b2NhdGlvbi4gVGhpcyBwYXRjaCBlbnN1cmVzDQo+ID4+
PiB0aGF0IHN1Y2ggYnVmZmVycyBhcmUgYWxzbyBhbGxvY2F0ZWQgZnJvbSBhbHJlYWR5IHNoYXJl
ZCBTV0lPVExCDQo+ID4+PiByZWdpb25zLiBUaGlzIGFsbG93cyBlbmZvcmNpbmcgYWxpZ25tZW50
IHJlcXVpcmVtZW50cyBvbiByZWdpb25zIG1hcmtlZA0KPiA+Pj4gYXMgc2hhcmVkLg0KPiA+PiBC
dXQgZG9lcyBpdCB3b3JrIGluIHByYWN0aWNlPw0KPiA+Pg0KPiA+PiBTb21lIGRldmljZXMgKGxp
a2UgR1BVcykgcmVxdWlyZSBhIGxvdCBvZiBETUEgbWVtb3J5LiBTbyB3aXRoIHRoaXMgYXBwcm9h
Y2gNCj4gPj4gd2Ugd291bGQgbmVlZCB0byBoYXZlIGh1Z2UgU1dJT1RMQiBidWZmZXIgdGhhdCBp
cyB1bnVzZWQgaW4gbW9zdCBWTXMuDQo+ID4+DQo+ID4gQ3VycmVudCBpbXBsZW1lbnRhdGlvbiBs
aW1pdHMgdGhlIHNpemUgb2Ygc3RhdGljYWxseSBhbGxvY2F0ZWQgU1dJT1RMQg0KPiA+IG1lbW9y
eSBwb29sIHRvIDFHLiBJIHdhcyBwcm9wb3NpbmcgdG8gZW5hYmxlIGR5bmFtaWMgU1dJT1RMQiBm
b3IgQ1ZNcw0KPiA+IGluIGFkZGl0aW9uIHRvIGFsaWduaW5nIHRoZSBtZW1vcnkgYWxsb2NhdGlv
bnMgdG8gaHVnZXBhZ2Ugc2l6ZXMsIHNvDQo+ID4gdGhhdCB0aGUgU1dJT1RMQiBwb29sIGNhbiBi
ZSBzY2FsZWQgdXAgb24gZGVtYW5kLg0KPiA+DQoNClZpc2hhbCAtLQ0KDQpXaGVuIHRoZSBkeW5h
bWljIHN3aW90bGIgbWVjaGFuaXNtIHRyaWVzIHRvIGdyb3cgc3dpb3RsYiBzcGFjZQ0KYnkgYWRk
aW5nIGFub3RoZXIgcG9vbCwgaXQgZ2V0cyB0aGUgYWRkaXRpb25hbCBtZW1vcnkgYXMgYSBzaW5n
bGUNCnBoeXNpY2FsbHkgY29udGlndW91cyBjaHVuayB1c2luZyBhbGxvY19wYWdlcygpLiAgIEl0
IHN0YXJ0cyBieSB0cnlpbmcNCnRvIGFsbG9jYXRlIGEgY2h1bmsgdGhlIHNpemUgb2YgdGhlIG9y
aWdpbmFsIHN3aW90bGIgc2l6ZSwgYW5kIGlmIHRoYXQNCmZhaWxzLCBoYWx2ZXMgdGhlIHNpemUg
dW50aWwgaXQgZ2V0cyBhIHNpemUgd2hlcmUgdGhlIGFsbG9jYXRpb24gc3VjY2VlZHMuDQpUaGUg
bWluaW11bSBzaXplIGlzIDEgTWJ5dGUsIGFuZCBpZiB0aGF0IGZhaWxzLCB0aGUgImdyb3ciIGZh
aWxzLg0KDQpTbyBpdCBzZWVtcyBsaWtlIGR5bmFtaWMgc3dpb3RsYiBpcyBzdWJqZWN0IHRvIHRo
ZSBhbG1vc3QgdGhlIHNhbWUNCm1lbW9yeSBmcmFnbWVudGF0aW9uIGxpbWl0YXRpb25zIGFzIHRy
eWluZyB0byBhbGxvY2F0ZSBodWdlIHBhZ2VzLg0Kc3dpb3RsYiBuZWVkcyBhIG1pbmltdW0gb2Yg
MSBNYnl0ZSBjb250aWd1b3VzIGluIG9yZGVyIHRvIGdyb3csDQp3aGlsZSBodWdlIHBhZ2VzIG5l
ZWQgMiBNYnl0ZXMsIGJ1dCBlaXRoZXIgaXMgbGlrZWx5IHRvIGJlDQpwcm9ibGVtYXRpYyBpbiBh
IFZNIHRoYXQgaGFzIGJlZW4gcnVubmluZyBhIHdoaWxlLiAgV2l0aCB0aGF0DQppbiBtaW5kLCBJ
J20gbm90IGNsZWFyIG9uIHRoZSBiZW5lZml0IG9mIGVuYWJsaW5nIGR5bmFtaWMgc3dpb3RsYi4N
Ckl0IHNlZW1zIGxpa2UgaXQganVzdCBtb3ZlcyBhcm91bmQgdGhlIHByb2JsZW0gb2YgbmVlZGlu
ZyBoaWdoIG9yZGVyDQpjb250aWd1b3VzIG1lbW9yeSBhbGxvY2F0aW9ucy4gIE9yIGFtIEkgbWlz
c2luZyBzb21ldGhpbmc/DQoNCk1pY2hhZWwNCg0KPiA+IFRoZSBpc3N1ZSB3aXRoIGFsaWduaW5n
IHRoZSBwb29sIGFyZWFzIHRvIGh1Z2VwYWdlcyBpcyB0aGF0IGh1Z2VwYWdlDQo+ID4gYWxsb2Nh
dGlvbiBhdCBydW50aW1lIGlzIG5vdCBndWFyYW50ZWVkLiBHdWFyYW50ZWVpbmcgdGhlIGh1Z2Vw
YWdlDQo+ID4gYWxsb2NhdGlvbiBtaWdodCBuZWVkIGNhbGN1bGF0aW5nIHRoZSB1cHBlciBib3Vu
ZCBpbiBhZHZhbmNlLCB3aGljaA0KPiA+IGRlZmVhdHMgdGhlIHB1cnBvc2Ugb2YgZW5hYmxpbmcg
ZHluYW1pYyBTV0lPVExCLiBJIGFtIG9wZW4gdG8NCj4gPiBzdWdnZXN0aW9ucyBoZXJlLg0KPiAN
Cj4gDQo+IFlvdSBjb3VsZCBhbGxvY2F0ZSBhIG1heCBib3VuZCBhdCBib290IHVzaW5nIENNQSBh
bmQgdGhlbiBvbmx5IGZpbGwgaW50bw0KPiB0aGUgQ01BIGFyZWEgd2hlbiBTV0lPVExCIHNpemUg
cmVxdWlyZW1lbnRzIGluY3JlYXNlPyBUaGUgQ01BIHJlZ2lvbg0KPiB3aWxsIGFsbG93IG1vdmFi
bGUgYWxsb2NhdGlvbnMgYXMgbG9uZyBhcyB5b3UgZG9uJ3QgcmVxdWlyZSB0aGUgQ01BIHNwYWNl
Lg0KPiANCj4gDQo+IEFsZXgNCg0K

