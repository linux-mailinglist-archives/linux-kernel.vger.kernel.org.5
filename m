Return-Path: <linux-kernel+bounces-91092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB71A870972
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67FE21F21359
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6F1626A3;
	Mon,  4 Mar 2024 18:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="sEFdx1Cv"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2086.outbound.protection.outlook.com [40.92.42.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE2F61694
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 18:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709576557; cv=fail; b=cjneOtpfVpHqE3Lro9gbVUNtQeEvTig6MqI961FORt6nHnrSmefiJU9pgJpdCn9SNteUsLJqIZoREr++1qQVYRxjrhpmj9UyarIoWqRYqWCxoD5/gKAihZaxZEx+/OxGODqfwLdXAfLgwe3oPNIJAHYQ79hq9u2rAyXx7RwE7Jk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709576557; c=relaxed/simple;
	bh=njaKCZ57aLAEaxfDgdYwaDN9xLlP9YbYmqf/X5J7nes=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rbJbQzOutyU5OUsztENZJqmY9IhrplN6bsmmVrgLdcjT/C9uyAD7nwKgQ0UJ2jE4k4G8EUUGXZiD7SY7ILGEQm8lN1AibWc3I4Vi09y/5VFLd6LqSmUU81+89/i0GH6L6tad3SHZgFadfg8OpuFldo5I/LV5+De/NE9n7E1uEBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=sEFdx1Cv; arc=fail smtp.client-ip=40.92.42.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLNHtAaifcDeQqu8zRlN6MoqCw5zsOIru8gQL3TK/8zbhye85Yc0qq4y4uH4L1f2jZICgTDg75t/wQT6boh/UrwCsvuJUNEfH7DOeAfU5TG55xKc5W0wjCWGvquxgtZ9zgxOrJS5DmqozJPS8nHKcNX+7J3HBOaadL6wlcJ5uYW6lRIZVns+yK28zN4vxj5mINBIV8UN8bSmtHyvxkQU33V3akcdLUxVV1VzzEc7EGUC1q+pMzw2QeAHsPYBmcp+HjjoCb+1sl5FKegFJlHuI19mdV8zWcGXejOq8Dtag4oCN2G77ZLJSebZJW3KGjzM/gPSZ21LmSYD0asYpcFKHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=njaKCZ57aLAEaxfDgdYwaDN9xLlP9YbYmqf/X5J7nes=;
 b=AvuxMjeL/Wn1AJ1bmVenfcWJcaF/FP1+2kN0QLWY+ICQKmKI0R6vHB6LhS16unpv5zcDRvm7wRcyQPMCT5k4GXKrVgUK3ExXfrQNZ+d9piTrJWMMnYDGy5OWLXZdpxNj5/OeB6tBlbXq3GDmBCY2OVH2vkzqjPbf0KyoQV56PQY5PoBC1bWw3Otzk8Amm/CByIMRvjhQzziayWwSs1B5Xuqpxd/W703AXQQtI/Q1LeD//XchcwkZRQRdX6Z2lQte8yrWCzLCLPd/WDyuDhzT3LuMU4goRaf+S37eSquRZhcsbPiVEy+nrMWRx4iA70nwSh5OlB3qVv9Xy6/rPRr2DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njaKCZ57aLAEaxfDgdYwaDN9xLlP9YbYmqf/X5J7nes=;
 b=sEFdx1CvGtnddJ/XVi3Dd3G7bMcunUKa+PqgadW4EpftCNdEKYrD/URsEO3gwtKfQJqgvBdhEnxyIEjv/ij/jBdeaj6x0ZiHUmRNyqH7hYR5JvqKR4c/jkE5AxjMUDqQSRVnUx19TdIYEjd7L+rg7ki2JpDrXwWvk9IW6sq1qckK3WYtZpgNyPY4dpozl7jJNYLQpG79rcXD2EUldSrRyMRd6aEakAKlerCGcbAZdCrPTPF6JuHPGNjDhT2pMXIzTW4rJwbRiZwzNR8eld7pWngqhjNq2nA2xarRplbguDkfbvas3hg+qW2KorAhyu1YzOXjuvCKjGYxqG+cInKOzQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BY5PR02MB6520.namprd02.prod.outlook.com (2603:10b6:a03:1d3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Mon, 4 Mar
 2024 18:22:32 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd%5]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 18:22:32 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	=?utf-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>
CC: Christoph Hellwig <hch@lst.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Petr Tesarik
	<petr.tesarik1@huawei-partners.com>, "kernel-team@android.com"
	<kernel-team@android.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Marek Szyprowski <m.szyprowski@samsung.com>, Dexuan Cui
	<decui@microsoft.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH v5 6/6] swiotlb: Remove pointless stride adjustment for
 allocations >= PAGE_SIZE
Thread-Topic: [PATCH v5 6/6] swiotlb: Remove pointless stride adjustment for
 allocations >= PAGE_SIZE
Thread-Index:
 AQHaakuep9s0mIf3eE+om+sQlmyZtbEg06/QgAAR1sCAAG26AIAAIlEwgAADLACAAY/2gIAAGPyAgAAMowCAAA1wAIADuADAgAB+HYCAACvfAIAAJlIAgAAB+gCAAAEkYIAADTYAgAAWM7A=
Date: Mon, 4 Mar 2024 18:22:31 +0000
Message-ID:
 <SN6PR02MB41574A920D7511D4E5DCE813D4232@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <SN6PR02MB4157314F142D05E279B7991ED45F2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20240229154756.GA10137@lst.de>
 <20240301163927.18358ee2@meshulam.tesarici.cz>
 <20240301180853.5ac20b27@meshulam.tesarici.cz>
 <8869c8b2-29c3-41e4-8f8a-5bcf9c0d22bb@arm.com>
 <20240301194212.3c64c9b2@meshulam.tesarici.cz>
 <SN6PR02MB41571DA1EE99BFAA65869024D4232@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20240304120055.56035c21@meshulam.tesarici.cz>
 <ffd7646b-37b1-4cd2-822a-848b36b076c9@arm.com>
 <20240304165506.49e3b2d3@meshulam.tesarici.cz>
 <20240304160210.GB21077@willie-the-truck>
 <SN6PR02MB41571F68F8F9E003C4359948D4232@SN6PR02MB4157.namprd02.prod.outlook.com>
 <b63d4332-b659-4897-83c7-04e5ad397a69@arm.com>
In-Reply-To: <b63d4332-b659-4897-83c7-04e5ad397a69@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [Uw5O9jiWpXbUdH19qIh6Wbq+mowNexjh]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BY5PR02MB6520:EE_
x-ms-office365-filtering-correlation-id: 97480671-5035-4a9c-fda4-08dc3c780eae
x-ms-exchange-slblob-mailprops:
 laRBL560oLTeY4B5Uu9VZYvGMTlNPOvpsrECZ3BciMY6cDnNp0A8hHPnsWVFQXlg9/kj9wtWBafLghuovrapX6iz+3Gx3n0vpj/CZyFjCgL891qgGDC7811Xa2yrolqFSvverivnMaIZ8N2zJuywMUVddOYJw22QkXdDsrArCoFpj+UEvpDPGKqkvPtkt66D6PPOO8i6xqFiQTuhrxc35hhIa99NpuqtbtDogvrjlSvRhJak+gCISVxAPvA11CBNxxCHKgi64wud0vtuGsyujEi+Pe4B5ooWNxYueY5pyVM3KQLRopsjEGamglKTVYcm0UteUINXBTJNbYrnZt2cvWyeiKHlVUGkh/oTItO4r0LY9ESLW7pR1lCvrmK7idd7Sm8EDO7iJ/AntBaickPhJxZ54RoB4kvAfhBeDx4bsCSqJg4mYIdhNSjwteKFq/oWqOWPAQdtZyQhntX/l3eEx5ir27H9pmHWUnIGrskAA7Ivbe4ymHnGfd0i84HBoMQivV2B9vx8TGpKih+rs/fL1NcsraJynLgJ1Ty7jloqTJ6uEHyLWKntopJDTBR6LmPUR4IITgfIYFseq7/z+CFboxQEBNIlZc7u3u3HfTmDqPMUystKqrSqEkhrl8S+XisrYyPw8I+2XDRISVRU+pVBQgm+ZrxPK2IH00TbnDbHIjQpgdghffpwf+gLWeD1i+6Tv23ED+rBfBBUlC54hsim1kNPPPmJ1mmil6c5vw9mGsDOdLWayF5/SNkvrI6N0aWKgdtMfjfXeFPYUSjbcPexlVf3fdmRq6CE
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 u8dkIsbGpWCh0eh5Ya9w+4Wcq2ObSyYEbByW0e9mAOS6FX3QiUfQLqsun1vS/3/ayMZNy1CHjMjMsg///YxkaKrOVytYR0llfPTshDesUFWGW/4k69S57MV1oEqnTIF7pvg7IETcoSF10ZhH/1B9XHM0MJ9CDQViWccStXz5zdPGl+dmnXeLmj61VHYvkJOf70zlDwuuJL52yBMzXgwPCtTpid67d8yclGd/txJVyyDcsSoXmH5gwkz5fceNx+mGcs5EivJQFIUzAvfoERr7ixjxej4MHW3S2XjAZgQMTxUIGVNazbQe5U1Ds/fbu9HJ5x+CycqW+ZF8vg6ypXiZLmRTnqlQF4hv2mq57hzUOQU79RkSKPa5qcvMDYws6ol4NzbUSBIuzfasInHQNuvnFJsg14BOJIpWJHzpZmtsmE5AvQHhE9yh5MZ9L3/3UXIz1uThA/zMatOMnp5el7ptjmlEtPeSroLIKqcR2h0jzgY4+U3MsGrr9bzkBWhH0sf1iVWn4NBKGAPABLeV6JNQcKSaZdSRpxfsx2P5kPNl3qGSVFH0QDo2oQktCYKXahvM
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bHgzMWFLUlV6bjIvbmlEeTUweFBFOWdYUjAxSHNGYXMzdTZ4ZS9hcUpCMVMy?=
 =?utf-8?B?STBZbkluaytNZzd5VnFxbmcrZFJPcnQweVVHNFF5eWRzZzEwSGFOa0lLRnBK?=
 =?utf-8?B?OEVMWjFROWdHcEVoYUFiTnNYbjBXT1RleTJ6dE93YWRrNm1vOUZRYmVEamVt?=
 =?utf-8?B?VFVBaHZQUjdIek9zMS9yWjJOZjdQcGVROGhQQ2FVTldTVTBTUVhXZS8zTmhS?=
 =?utf-8?B?SGlId3Q5OWZXNEVweHJFS3ZMN29hRHFqejhBUDNHdHFlWmJubnhIS1gxUFVq?=
 =?utf-8?B?UUlydmtlek9ESytJeGlOMG45bkFEZ0Q0THAxOXhTMDY4R3VsajNPTEhTdFNY?=
 =?utf-8?B?YXZIeHFtN0p1QnFTWWlYem9KZWNPNzdPdmF3SDdzSi9lS2ZiOXpWbmg4WUx5?=
 =?utf-8?B?M0E5M2owZWNsSXhZTXhlcDVzWEs4UTBKeXlLaTRpUFVjOTF3Y3BpWmpqd3lR?=
 =?utf-8?B?U1hHcUNSOHIyWWZMYnJHdytLWWZ3WkpGak9PMUtkKytzcXVQVjhzM3ZmV2JU?=
 =?utf-8?B?eXZ5M1lUaWZDZDlYVDJnMS9yaUhYb0poZ2wyY1NNcnBURVRGTTBWWnlES1ZJ?=
 =?utf-8?B?WmF4Rkl0U29QSERkNld4citmZ0xyQ2gwaHgxVUlNNTFRVXRyWWFCcE5lMHB5?=
 =?utf-8?B?VHE4VXBueURrYTJ2bjYzMFMzQ25TWjJvbjRtOXBOREEwdlNvVU91elJjelJi?=
 =?utf-8?B?SjBWOEJnMDlyWTVBYmFlZlZrenNDU2N4MGM3MUR2Sm00VW9vQU9oQ2pqdVNH?=
 =?utf-8?B?TEs0cThKUjJyQkN6RnkveVFhQ2ZacDFIODVDcWNDWGM5Um5XUkxLcnVUYXBH?=
 =?utf-8?B?V3IvbVcxQkVsTHRRaGM5UGZjVmFyUzdOMUVaSk5EMVlHV3h5ZXplcTFjKytY?=
 =?utf-8?B?MjIxTG5lWUEzbEFiRGJWNEhpNGo2TTF5bjlScDhKZk1qL1NQT3pMSFFmbVpO?=
 =?utf-8?B?ek03OEdQajFnRXEzcTZPL3FQNlZVWlA2aXRvTWR2U2ZqWmFERzQvOXpjbVJP?=
 =?utf-8?B?c29wSmY1RCtqazE0VnZhREo5Ykt6YlJEYWlvZWpZNFhjNUU0OG83U1VveWNq?=
 =?utf-8?B?WHgxMy9PWTNEYWt4U29ZWGR1YlZOQ1kyQmZReHpJWWJPcEtHcWFlNWxMZENk?=
 =?utf-8?B?enZ1RHZucStHV2JXcWV4NDdyaWZ2cGtNS0h6bUQ4aDRkcFF6L3hOZzBNdDhE?=
 =?utf-8?B?YjJiZzJaa1JQdTlIbXR1c3FYTUYyOEpZVGxudXZwR3B4dExOUlQ1bjM5RmJY?=
 =?utf-8?B?RnJqVk40aXp6TG80bStvZEtTQjFaWWVadmJKTVMwdXNhcy8wRXk3R1QyV1hw?=
 =?utf-8?B?eU1ueTFMbDM2bkRMajY1VnlxVUZURjMrL2E4a3BKZDFCT1VveUVoQ3ZZVkVa?=
 =?utf-8?B?cnVBek5RUjNwTlJuajFJakhvRnBnV0RFUjBvS0NtY0tweXQwWlhMbGQ3Z3B4?=
 =?utf-8?B?NlRQNHJlZFFlYUhEZitjRzZwY0k5R2dFWTVPSm5CWEQyYlhFcE5wYUg1L2pr?=
 =?utf-8?B?Ym9scUZzOWYxNzN4SXVWZVdzNDBodml6SWtBZTlBSk5oWlFyTGJ4eDE1cGJ0?=
 =?utf-8?B?aGpXK3g1YjVTVkhxamV5SzhFbjI5QjBlZkw4aTEvRElOR1ZtMEF4NmpvNlhY?=
 =?utf-8?B?Uk8rMkw5c3lxWDcyeE1tMWNldGJObEE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 97480671-5035-4a9c-fda4-08dc3c780eae
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2024 18:22:31.9300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6520

RnJvbTogUm9iaW4gTXVycGh5IDxyb2Jpbi5tdXJwaHlAYXJtLmNvbT4gU2VudDogTW9uZGF5LCBN
YXJjaCA0LCAyMDI0IDg6NTQgQU0NCj4gDQo+IE9uIDA0LzAzLzIwMjQgNDoxMCBwbSwgTWljaGFl
bCBLZWxsZXkgd3JvdGU6DQo+ID4gRnJvbTogV2lsbCBEZWFjb24gPHdpbGxAa2VybmVsLm9yZz4g
U2VudDogTW9uZGF5LCBNYXJjaCA0LCAyMDI0IDg6MDIgQU0NCj4gPj4NCj4gPj4gSGkgZm9sa3Ms
DQo+ID4+DQo+ID4+IE9uIE1vbiwgTWFyIDA0LCAyMDI0IGF0IDA0OjU1OjA2UE0gKzAxMDAsIFBl
dHIgVGVzYcWZw61rIHdyb3RlOg0KPiA+Pj4gT24gTW9uLCA0IE1hciAyMDI0IDEzOjM3OjU2ICsw
MDAwDQo+ID4+PiBSb2JpbiBNdXJwaHkgPHJvYmluLm11cnBoeUBhcm0uY29tPiB3cm90ZToNCj4g
Pj4+PiBPbiAwNC8wMy8yMDI0IDExOjAwIGFtLCBQZXRyIFRlc2HFmcOtayB3cm90ZToNCj4gPj4+
PiBbLi4uXQ0KPiA+Pj4+Pj4gSGVyZSdzIG15IHRha2Ugb24gdHlpbmcgYWxsIHRoZSB0aHJlYWRz
IHRvZ2V0aGVyLiBUaGVyZSBhcmUNCj4gPj4+Pj4+IGZvdXIgYWxpZ25tZW50IGNvbWJpbmF0aW9u
czoNCj4gPj4+Pj4+DQo+ID4+Pj4+PiAxLiBhbGxvY19hbGlnbl9tYXNrOiB6ZXJvOyBtaW5fYWxp
Z25fbWFzazogemVybw0KPiA+Pg0KPiA+PiBCYXNlZCBvbiB0aGlzIF5eXiAuLi4NCj4gPj4NCj4g
Pj4+Pj4+IHhlbl9zd2lvdGxiX21hcF9wYWdlKCkgYW5kIGRtYV9kaXJlY3RfbWFwX3BhZ2UoKSBh
cmUgIzEgb3IgIzINCj4gPj4+Pj4+IHZpYSBzd2lvdGxiX21hcCgpIGFuZCBzd2lvdGxiX3RibF9t
YXBfc2luZ2xlKCkNCj4gPj4+Pj4+DQo+ID4+Pj4+PiBpb21tdV9kbWFfbWFwX3BhZ2UoKSBpcyAj
MyBhbmQgIzQgdmlhIHN3aW90bGJfdGJsX21hcF9zaW5nbGUoKQ0KPiA+Pj4+Pj4NCj4gPj4+Pj4+
IHN3aW90bGJfYWxsb2MoKSBpcyAjMywgZGlyZWN0bHkgdG8gc3dpb3RsYl9maW5kX3Nsb3RzKCkN
Cj4gPj4+Pj4+DQo+ID4+Pj4+PiBGb3IgIzEsIHRoZSByZXR1cm5lZCBwaHlzaWNhbCBhZGRyZXNz
IGhhcyBubyBjb25zdHJhaW50cyBpZg0KPiA+Pj4+Pj4gdGhlIHJlcXVlc3RlZCBzaXplIGlzIGxl
c3MgdGhhbiBhIHBhZ2UuIEZvciBwYWdlIHNpemUgb3INCj4gPj4+Pj4+IGdyZWF0ZXIsIHRoZSBk
aXNjdXNzZWQgaGlzdG9yaWNhbCByZXF1aXJlbWVudCBmb3IgcGFnZQ0KPiA+Pj4+Pj4gYWxpZ25t
ZW50IGFwcGxpZXMuDQo+ID4+DQo+ID4+IC4uLiBhbmQgdGhpcyBeXl4gLi4uDQo+ID4+DQo+ID4+
DQo+ID4+PiBJIGJlbGlldmUgdGhpcyBwYXRjaCBzZXJpZXMgaXMgbm93IGdvb2QgYXMgaXMsIGV4
Y2VwdCB0aGUgY29tbWl0DQo+ID4+PiBtZXNzYWdlIHNob3VsZCBtYWtlIGl0IGNsZWFyIHRoYXQg
YWxsb2NfYWxpZ25fbWFzayBhbmQgbWluX2FsaWduX21hc2sNCj4gPj4+IGNhbiBib3RoIGJlIHpl
cm8sIGJ1dCB0aGF0IHNpbXBseSBtZWFucyBubyBhbGlnbm1lbnQgY29uc3RyYWludHMuDQo+ID4+
DQo+ID4+IC4uLiBteSAocG9zc2libHkgaW5jb3JyZWN0ISkgcmVhZGluZyBvZiB0aGUgdGhyZWFk
IHNvIGZhciBpcyB0aGF0IHdlDQo+ID4+IHNob3VsZCBwcmVzZXJ2ZSBwYWdlLWFsaWduZWQgYWxs
b2NhdGlvbiBpbiB0aGlzIGNhc2UgaWYgdGhlIGFsbG9jYXRpb24NCj4gPj4gc2l6ZSBpcyA+PSBQ
QUdFX1NJWkUuDQo+ID4+DQo+ID4+IFNvbWV0aGluZyBsaWtlIHRoZSBkaWZmIGJlbG93LCB0byBy
ZXBsYWNlIHRoaXMgZmluYWwgcGF0Y2g/DQo+ID4+DQo+ID4+IFdpbGwNCj4gPj4NCj4gPj4gLS0t
PjgNCj4gPj4NCj4gPj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9kbWEvc3dpb3RsYi5jIGIva2VybmVs
L2RtYS9zd2lvdGxiLmMNCj4gPj4gaW5kZXggYzM4MWE3ZWQ3MThmLi42N2VhYzA1NzI4YzAgMTAw
NjQ0DQo+ID4+IC0tLSBhL2tlcm5lbC9kbWEvc3dpb3RsYi5jDQo+ID4+ICsrKyBiL2tlcm5lbC9k
bWEvc3dpb3RsYi5jDQo+ID4+IEBAIC05OTIsNiArOTkyLDE0IEBAIHN0YXRpYyBpbnQgc3dpb3Rs
Yl9zZWFyY2hfcG9vbF9hcmVhKHN0cnVjdCBkZXZpY2UNCj4gPj4gKmRldiwgc3RydWN0IGlvX3Rs
Yl9wb29sICpwb29sDQo+ID4+ICAgICAgICAgIEJVR19PTighbnNsb3RzKTsNCj4gPj4gICAgICAg
ICAgQlVHX09OKGFyZWFfaW5kZXggPj0gcG9vbC0+bmFyZWFzKTsNCj4gPj4NCj4gPj4gKyAgICAg
ICAvKg0KPiA+PiArICAgICAgICAqIEhpc3RvcmljYWxseSwgYWxsb2NhdGlvbnMgPj0gUEFHRV9T
SVpFIHdlcmUgZ3VhcmFudGVlZCB0byBiZQ0KPiA+PiArICAgICAgICAqIHBhZ2UtYWxpZ25lZCBp
biB0aGUgYWJzZW5jZSBvZiBhbnkgb3RoZXIgYWxpZ25tZW50IHJlcXVpcmVtZW50cy4NCj4gPj4g
KyAgICAgICAgKiBTaW5jZSBkcml2ZXJzIG1heSBiZSByZWx5aW5nIG9uIHRoaXMsIHByZXNlcnZl
IHRoZSBvbGQgYmVoYXZpb3VyLg0KPiA+PiArICAgICAgICAqLw0KPiA+PiArICAgICAgIGlmICgh
YWxsb2NfYWxpZ25fbWFzayAmJiAhaW90bGJfYWxpZ25fbWFzayAmJiBhbGxvY19zaXplID49IFBB
R0VfU0laRSkNCj4gPj4gKyAgICAgICAgICAgICAgIGFsbG9jX2FsaWduX21hc2sgPSBQQUdFX1NJ
WkUgLSAxOw0KPiA+PiArDQo+ID4NCj4gPiBZZXMsIEkgdGhpbmsgdGhhdCBzaG91bGQgZG8gaXQu
DQo+IA0KPiBJbiBwcmluY2lwbGUgaXQgbWlnaHQgYmUgbW9yZSBsb2dpY2FsIHRvIGZ1ZGdlIHRo
aXMgaW50bw0KPiBpb3RsYl9hbGlnbl9tYXNrIHJhdGhlciB0aGFuIGFsbG9jX2FsaWduX21hc2sg
DQoNCkknbSBub3QgdW5kZXJzdGFuZGluZyB3aGF0IHlvdSBhcmUgZ2V0dGluZyBhdCwgYnV0IG1h
eWJlIHdlIGFyZQ0KaW50ZXJwcmV0aW5nIHRoZSBoaXN0b3JpY2FsIHBhZ2UgYWxpZ25tZW50IHJl
cXVpcmVtZW50IGRpZmZlcmVudGx5Lg0KSSB0aGluayBvZiB0aGUgcGFnZSBhbGlnbm1lbnQgcmVx
dWlyZW1lbnQgYXMgaW5kZXBlbmRlbnQgb2YgdGhlDQpvcmlnX2FkZHIgLS0gdGhlIHJldHVybmVk
IHBoeXNpY2FsIGFkZHJlc3Mgc2hvdWxkIGFsd2F5cyBiZSBleGFjdGx5DQpwYWdlIGFsaWduZWQs
IGFuZCBub3Qgb2Zmc2V0IHRvIG1hdGNoIGJpdHMgaW4gb3JpZ19hZGRyLiAgSWYgdGhhdCdzDQp0
aGUgY2FzZSwgdGhlbiBpbXBsZW1lbnRpbmcgdGhlIHBhZ2UgYWxpZ25tZW50IHZpYQ0KYWxsb2Nf
YWxpZ25fbWFzayBpcyBsb2dpY2FsbHkgdGhlIHJpZ2h0IHBsYWNlLiBGdWRnaW5nIGludG8NCmlv
dGxiX2FsaWduX21hc2sgd291bGQgZG8gbWF0Y2hpbmcgb2YgYml0cyBpbiBvcmlnX2FkZHIuDQoN
Ck9yIGlzIHRoZXJlIHNvbWV0aGluZyBlbHNlIEknbSBub3QgY29uc2lkZXJpbmc/DQoNCk1pY2hh
ZWwNCg0KPiAtIHNpbmNlIHRoYXQncyByZWFsbHkgdGhlDQo+IGVmZmVjdGl2ZSBiZWhhdmlvdXIg
dG8gcHJlc2VydmUgZm9yIHN0cmVhbWluZyBtYXBwaW5ncyAtIGFuZCB0aGVuIHBhc3MNCj4gYW4g
ZXhwbGljaXQgYWxsb2NfYWxpZ25fbWFzayBmcm9tIHN3aW90bGJfYWxsb2MoKSB0byBob25vdXIg
dGhlDQo+IGRtYS1jb2hlcmVudCByZXF1aXJlbWVudHMuIEhvd2V2ZXIgSSBhbHNvIHdvdWxkbid0
IHJlYWxseSBvYmplY3QgdG8gbm90DQo+IGdvaW5nIHRoYXQgZmFyIGFuZCBpbnN0ZWFkIGp1c3Qg
bWFraW5nIHRoZSBjb21tZW50IGEgYml0IGNsZWFyZXIgdGhhdA0KPiB0aGlzIGlzIHN0aWxsIHNl
cnZpbmcgYm90aCBwdXJwb3Nlcy4NCj4gDQo+IENoZWVycywNCj4gUm9iaW4uDQo+IA0KPiA+DQo+
ID4gTWljaGFlbA0KPiA+DQo+ID4+ICAgICAgICAgIC8qDQo+ID4+ICAgICAgICAgICAqIEVuc3Vy
ZSB0aGF0IHRoZSBhbGxvY2F0aW9uIGlzIGF0IGxlYXN0IHNsb3QtYWxpZ25lZCBhbmQgdXBkYXRl
DQo+ID4+ICAgICAgICAgICAqICdpb3RsYl9hbGlnbl9tYXNrJyB0byBpZ25vcmUgYml0cyB0aGF0
IHdpbGwgYmUgcHJlc2VydmVkIHdoZW4NCj4gPj4gQEAgLTEwMDYsMTMgKzEwMTQsNiBAQCBzdGF0
aWMgaW50IHN3aW90bGJfc2VhcmNoX3Bvb2xfYXJlYShzdHJ1Y3QNCj4gZGV2aWNlICpkZXYsIHN0
cnVjdCBpb190bGJfcG9vbCAqcG9vbA0KPiA+PiAgICAgICAgICAgKi8NCj4gPj4gICAgICAgICAg
c3RyaWRlID0gZ2V0X21heF9zbG90cyhtYXgoYWxsb2NfYWxpZ25fbWFzaywgaW90bGJfYWxpZ25f
bWFzaykpOw0KPiA+Pg0KPiA+PiAtICAgICAgIC8qDQo+ID4+IC0gICAgICAgICogRm9yIGFsbG9j
YXRpb25zIG9mIFBBR0VfU0laRSBvciBsYXJnZXIgb25seSBsb29rIGZvciBwYWdlIGFsaWduZWQN
Cj4gPj4gLSAgICAgICAgKiBhbGxvY2F0aW9ucy4NCj4gPj4gLSAgICAgICAgKi8NCj4gPj4gLSAg
ICAgICBpZiAoYWxsb2Nfc2l6ZSA+PSBQQUdFX1NJWkUpDQo+ID4+IC0gICAgICAgICAgICAgICBz
dHJpZGUgPSB1bWF4KHN0cmlkZSwgUEFHRV9TSElGVCAtIElPX1RMQl9TSElGVCArIDEpOw0KPiA+
PiAtDQo+ID4+ICAgICAgICAgIHNwaW5fbG9ja19pcnFzYXZlKCZhcmVhLT5sb2NrLCBmbGFncyk7
DQo+ID4+ICAgICAgICAgIGlmICh1bmxpa2VseShuc2xvdHMgPiBwb29sLT5hcmVhX25zbGFicyAt
IGFyZWEtPnVzZWQpKQ0KPiA+PiAgICAgICAgICAgICAgICAgIGdvdG8gbm90X2ZvdW5kOw0KPiA+
DQo=

