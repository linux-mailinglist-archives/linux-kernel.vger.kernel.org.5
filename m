Return-Path: <linux-kernel+bounces-104281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFDE87CB95
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7E141F2295A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1995A1B951;
	Fri, 15 Mar 2024 10:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="IwZbbJ5Z"
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11021006.outbound.protection.outlook.com [52.101.128.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B201B946
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 10:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710499444; cv=fail; b=khmywFp0j0ihouLQ7DPS+k5nbJN4Xhswilz1uAgiX8s9mwma7klxhHjJUNIH5L/ie4Rmnz/8UHUqI5bsNpx5eL3kvxctbp3WWMwnJrvD7hzf1Pxn0FkEzsHYwlDQK2J7AfqkVWkE+EiRAZ/6fPkxbsqceMcytf5cZ3fnxS1YvUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710499444; c=relaxed/simple;
	bh=FGkVKnnFlJTNIzC6xqZTuyle489VGna/h8cmMJzk6P8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bP6zweWJyoukU5/Ehff/wSogRlQJhF1Co9mcXhdo4J6t/6uQO7kKLuoyyWZSUlhq8M0r5HJdRD4CuYAMj0Kz7dpXX7iJ3iBM6KtvHFOn+AHjtOcXv5f6ErK3veXSsYFnLzS2PQ7r4GPdWyDvwC48JCS8E/KyxyCQwF7MC4eieK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=IwZbbJ5Z; arc=fail smtp.client-ip=52.101.128.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NYmZ46LfweeR7WRtk2Cci3S4KHHCKZRrHMgSMA/+zat1i72wiwrVDXGkRx/1VOAfHWJnbJ2oYH0oF0oXRkDwgG7TmkzmcSVtRqnmg/jcD7r1d8c1LsAg4O8ketx+IAuzUnb1Kz36OIfjuc4ai16xsxyRlyv25wHevO50Vo51OKJ8Xp6p6pRAMh09iTAd/ShcC+30bgegCJU5sh3AAi75vHuKA1Ft5bBDnGs3U/NFo8b7NzNDCVURrcV5Ok6Ne/nMSL34rbsu+Yf5eJneAKVc1clx/+do8bWlX888NRixqJKzY2b5YC5NX0/UbW+mKmAJRHVVEgyUKcXXt6ruORGlIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FGkVKnnFlJTNIzC6xqZTuyle489VGna/h8cmMJzk6P8=;
 b=FcyjMchYmO7UMoFOFv6qsassvZXfz9u1jZ2IEFXTuBnqTt9+2eonX/RXHkVNufZyLaRZ5n0+aC2bcycvzEb8qQ7uZ4+twgkFDue829sgpdBtJPm675fIw1v963phSBtg3qvrMNfpSPBHCWvnuhQH5dBocEU8Lgeho4Ec+huONHdFqZ+TPbXR/0mBzzwHxiyIiirmlf83EwSoFSyv4t257SvpS5+yUw7zlugZUYaSoru1RPo8txRsY0vLVvTU4+tnrqPRGo7zqgWiDxxsj4apydwxUF4ZFpRjLtxFQ6wrp0sGyUuAkEUyWUtIqidfpJ7Do4wHkKGF7swM/aoBmDrUCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FGkVKnnFlJTNIzC6xqZTuyle489VGna/h8cmMJzk6P8=;
 b=IwZbbJ5ZdGD8WYrpLjIE7N41jKUODXF0Jt0fN7t4Ckt+PPcCBlTKK6ougb8XqFXc/srC0+ACpUv7/VM9B/Sx2Ilpf/80bHZstvuk2iggWv86I6xsTzSWIukh+WEgjkm2MtzCCA68Lwi/HdWRnPhBjKjw7kYDtHgkDm9U0YIlVDg=
Received: from SEZPR02MB7164.apcprd02.prod.outlook.com (2603:1096:101:194::8)
 by TYSPR02MB8038.apcprd02.prod.outlook.com (2603:1096:405:54::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Fri, 15 Mar
 2024 10:43:59 +0000
Received: from SEZPR02MB7164.apcprd02.prod.outlook.com
 ([fe80::bc02:302a:a551:9b07]) by SEZPR02MB7164.apcprd02.prod.outlook.com
 ([fe80::bc02:302a:a551:9b07%5]) with mapi id 15.20.7362.035; Fri, 15 Mar 2024
 10:43:59 +0000
From: =?utf-8?B?5YiY5rW36b6ZKExhb0xpdSk=?= <liuhailong@oppo.com>
To: Barry Song <21cnbao@gmail.com>
CC: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"nathan@kernel.org" <nathan@kernel.org>, "ndesaulniers@google.com"
	<ndesaulniers@google.com>, "trix@redhat.com" <trix@redhat.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "llvm@lists.linux.dev"
	<llvm@lists.linux.dev>, "surenb@google.com" <surenb@google.com>,
	"zhaoyang.huang@unisoc.com" <zhaoyang.huang@unisoc.com>,
	"quic_charante@quicinc.com" <quic_charante@quicinc.com>, "yuzhao@google.com"
	<yuzhao@google.com>
Subject: Re: [PATCH v2] Revert "mm: skip CMA pages when they are not
 available"
Thread-Topic: [PATCH v2] Revert "mm: skip CMA pages when they are not
 available"
Thread-Index: AQHadrFVJJtVzEecOUS87iMUQEAAwLE4fR0AgAAg3gA=
Date: Fri, 15 Mar 2024 10:43:59 +0000
Message-ID: <ba894762-d3ea-4773-b54c-ce063e1065e5@oppo.com>
References: <20240314141516.31747-1-liuhailong@oppo.com>
 <20240315081803.2223-1-liuhailong@oppo.com>
 <CAGsJ_4yMXE_4YuMTczF6u4YYp_TWksi+byszD09E2PT5pK8zfA@mail.gmail.com>
In-Reply-To:
 <CAGsJ_4yMXE_4YuMTczF6u4YYp_TWksi+byszD09E2PT5pK8zfA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR02MB7164:EE_|TYSPR02MB8038:EE_
x-ms-office365-filtering-correlation-id: 00ef1cdb-0f32-4d51-0635-08dc44dcd23e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 /Gmj6ZCUKP4tVXHMVPzCCVFzkNq9CXEK6VuWTjZFBkw4/AV6neCu9DAP0QBRB4+YhtUu8butaxXh2kyVQ+RM9aIjc8gqDfYru2vNZHqUcRu7lceJzEiXEDr5GxISUkOFy6qSzTv8UF8dyhfJ3VAIfjoTPKs7/CsDDz7jASaB2usVjivwe/4pHFJNoxyfmgN6UY0GCU4Ub/Qtav88f+WHaCI9kS5rBF6ccvL1KINDjtvvbb/bduiY3fqtCO46fcznETJ/ql103oBiblBS4qQIBtQPFWnxpLBhI5yibLsqNtO1ASva4caMOBJbqpnwfXmnScUv35eyVkNtCDvfLhv4I8KRDwr3H+KK6Xqn7/ONWB7i8vDTWLqGba9DO7Bf6BzCRDMHLuSapUzZF4hvnT1bu8AjU6gj7GnFbM6J5Il2ocZO2heCDatNyUAlHuo7Mo86t0stkIvO+3b7X2RdQ/lVR7DW3JlAoYEOj13XqxHhB3sV0paYVd7kYN7be27TRXDk8+Le5FMb6Ps9an7OUmutEZfG37NcSAc0/pv0bbqFORZj+oUjK4aq0cDIdqwUUsc1vxxwxHmK7w6qHas5IX43kozZnEZYgAF83hv7gYM07KNfBOAzMPX5TYD/0Ax+7uZdCyaLkVibsYfU8EJHKsPVr5fVEkDTxIOLT70p0QwBxWYcSpZaYP82InJRCftBEDnEGnLvcEKsHNHrQW2N6qcR37y61OH6rhK5jJAHW0LOnIk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR02MB7164.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b1g2ZjVJZmQzTjZCL1psRWoyRkRleGlBcUlwcU9jcG9XTFIrMHA0eU4zUWtL?=
 =?utf-8?B?Ryt0Qi9XZngxL3E2cW4wbTE1ZWxiOEdxNThFaGxEelpic1hoN1NNZmZOMFNL?=
 =?utf-8?B?UVpDNG9uYzN0QjJIQWJ5Zk16Q05IYnVrWmlqck0xOXhhNzNjZ0trQy83Ykt2?=
 =?utf-8?B?d25jT2JQSXJ6bC9ob2tOTWJxTkdtR0luRkdzOVhUODk3d3UxTC9adHIwWEdH?=
 =?utf-8?B?Q3lvdGZsTmZVUnVMemdLd2tDcnFKdkdpL1J2TTRVRy8zcmUwRlc5V1BpMVZS?=
 =?utf-8?B?RGVYaVBkbXVGMHZhdmNXUm1QczhmcDI0Zk1qWVg4OWw1WWtYcnhtbmx1aUQy?=
 =?utf-8?B?UU1LMkErcWJyeTRPTDZJUUxlVXorYmMyL0YrbHdtYTBwbEVaTzBpYVNuYzhZ?=
 =?utf-8?B?bUJaZ20vRkJXcTllVENQcDVwUnExWFoyUEI4ZHJnZ1lQa2pYS2lqVitsOERI?=
 =?utf-8?B?VEdsNmhseDVaV2EyZGlVZitHbUkwRXVKbUtrSGpJWFRWdXJQMkdGdFRkTzhH?=
 =?utf-8?B?eWdpcG5QOThNNS80OWlGUlNXa2QxS0ltQjUwd002d1dUOGluc1JJV2x2cFNC?=
 =?utf-8?B?ZDJlcmtQbGFaeERQVi9iS1F6MTJOMEp1NGlyUzJyZEJPWVY3RzIwYm8ya3lo?=
 =?utf-8?B?TU43VlVCLy9LTFdyRTNFKzdUNUlCbEdkTkp0TVhmeWJTc21jaGpiblJjQTBH?=
 =?utf-8?B?MTY0WXN6OElKUnhFbjBvcGFKRFgwczFRemlNbGFOUGl1Ymg3L1puTmVUbHJD?=
 =?utf-8?B?MDBYN2s5MzZMdFU3VWw0NGpjdEw5dWZXUE01UkNXNy9uMmxyK1owMFBSa3Nv?=
 =?utf-8?B?bjErdXVaYXZDM1RrRlQrUXUvZVdvaXF1UzI1aWFWdlIzSjBxemozY0ZVTnNZ?=
 =?utf-8?B?Qnl4MEJQVTU2QmZWUG9GdzhJYkROMDhKVjZQUHVNQmthK3g5V2JsSkhtT0Za?=
 =?utf-8?B?Q1BpOWdWRVpFSVV1VGdDWmdXT0cyU3d4dG02VDVCRm9MeW04NTNPTFNBdmM4?=
 =?utf-8?B?MXMrU2NOZHRZUUZXM1I0RWtCc29vbHFwOFV3SlBrbVV6MDZNS1FPbS9pOUtV?=
 =?utf-8?B?R1dZZkt1L0V2NC85VU9ZNXR5Qm5RSnUxMXZBWGQ4MVpiUUN0VTNiaHdPTmVs?=
 =?utf-8?B?emJVWk01WFFrTkdrNmFaL1F4eWZTTTZ4QlJqU29wT3pVNTVPQjhmdnJyRU9u?=
 =?utf-8?B?UTZJcDdQOWFsWVN5bkgxWUJPU2QvSjJvbU9RZ3p5azB5QVBmVWZKZU5xb255?=
 =?utf-8?B?RWpveTE5UW9SWnRta3JaQ2o5TjV1b1RmcVVFZGdlZDVkWVRXT2x0Wm1rL0dr?=
 =?utf-8?B?Z0xEdkZwM05DQlZ5cUFYUXA2ZjVXNGhpdVBwN2xsdUlmenh0ZGxhVUJOTklo?=
 =?utf-8?B?L2tKVUhSMjNSM09NS05KOFRVUFdGTE05VCt3dDVyaDZXS1lGVG50RWVIWnZ0?=
 =?utf-8?B?UytYRWVJd2R3a3lpZXlhRDgvZWN2VHphSjZuQSs5Y3N1Zmc4Tlk2bERoMWY0?=
 =?utf-8?B?L3U3ekZkS3Vucnh0a0RnUTUzWXkvTHBjaEFtcWZSelFjMk5xSFhNOHU0dVNv?=
 =?utf-8?B?cTZHbDZJdkw4QllpSHg4TnYzQ2VXN1llYTYvRVgwajR4a0hOb1djUmM3SkJr?=
 =?utf-8?B?dUNhb3YzVkYzSUljcHowNEZZd01zV0xVenNxRTM0UnJ5cElDNGtLU2tUL3JD?=
 =?utf-8?B?SEg5eUkvNUl1dXZWeGdJZjE0M0ptNG45NUJ4dk0xUnVEd0RJSG5xV3RORnpP?=
 =?utf-8?B?MFNveHNPMWMzZDR3WEZnUCs2Tkg5S04vQ2ZHcGRJSC9TeTdnWTVVQ2FTOU9k?=
 =?utf-8?B?dDJLTlQ4QVFrL3VZMEtjU29IdXBVVGZqS3h6WURkYkpLZGpONlZwU1ZCLzVN?=
 =?utf-8?B?d3ZNS0RFY3N2RlBIN0FZQkpQWnRNa1Q1Q1BDRW16eVIzcXVyUHRQejZyak9Y?=
 =?utf-8?B?dVVnY3JUUnpoOXo3MitmT2VULytReElzbDRrcFVGZXVzcE1MajhzNUFxNnVI?=
 =?utf-8?B?QlJoMU81bmJjTk44VWk5WXV3WFZ5UStpaWhjS0lNK2V4cmxScitaWTExb3JR?=
 =?utf-8?B?dkFCcktmY09YU0k1bHk4Z3F1eWVsMCtKVjRpaktWYVlIb01CdGpMWTN3U3Fq?=
 =?utf-8?Q?Xq+MZvmfkqNp82bVRvwjsq4kT?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0F662AED9D42314390A4AC0A0DDBBA4A@apcprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR02MB7164.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00ef1cdb-0f32-4d51-0635-08dc44dcd23e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2024 10:43:59.0241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +00gLJreLYnB0Ag3qbrYaCM0yuCYKX4ixI8X9aRO9ljNnSGSHFO0LoBOv667BnEIRjsOY93fy52YrYg/YwZ4zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR02MB8038

T24gMjAyNC8zLzE1IDE2OjQ2LCBCYXJyeSBTb25nIHdyb3RlOg0KPiBPbiBGcmksIE1hciAxNSwg
MjAyNCBhdCA5OjE44oCvUE0gPGxpdWhhaWxvbmdAb3Bwby5jb20+IHdyb3RlOg0KPj4NCj4+IEZy
b206ICJIYWlsb25nLkxpdSIgPGxpdWhhaWxvbmdAb3Bwby5jb20+DQo+Pg0KPj4gVGhpcyByZXZl
cnRzDQo+PiBjb21taXQgYjcxMDhkNjYzMThhICgiTXVsdGktZ2VuIExSVTogc2tpcCBDTUEgcGFn
ZXMgd2hlbiB0aGV5IGFyZSBub3QgZWxpZ2libGUiKQ0KPj4gY29tbWl0IDVkYTIyNmRiZmNlMyAo
Im1tOiBza2lwIENNQSBwYWdlcyB3aGVuIHRoZXkgYXJlIG5vdCBhdmFpbGFibGUiKQ0KPiANCj4g
UmV2ZXJ0aW5nIHRoZXNlIGNoYW5nZXMgc2VlbXMgaW5hcHByb3ByaWF0ZSBzaW5jZSB0aGUgb3Jp
Z2luYWwgcGF0Y2hlcw0KPiBkaWQgaW1wcm92ZSBtb3N0IGNhc2VzLg0KPiBXaGlsZSBkb2luZyBk
aXJlY3QgcmVjbGFtYXRpb24gd2l0aG91dCBNT1ZBQkxFIGZsYWdzLCBzY2FubmluZyBjbWENCj4g
Zm9saW8gZG9lc24ndCBoZWxwIGF0IGFsbC4NCj4gDQoNCkFic29sdXRlbHksIGJ1dCB3aXRob3V0
IHRoaXMgcGF0Y2ggIGl0IGdpdmUgY2hhbmNlIHRvIHJlY2xhaW0gY21hIHBhZ2VzIHRvIGZyZWVs
aXN0LCANCm90aGVyIHRhc2tzIHdpdGhvdXQgdGhpcyBmbGFnIHdvdWxkIHdvcmsgbm9ybWFsbHkg
d2l0aG91dCBob2xkaW5nIHRvbyBtdWNoIHRpbWUgDQpvbiBscnUgbG9jayBhbmQgbHJ1IHNpemUg
ZGVjcmVhc2XjgIIgaXQgYWxzbyB0cmlnZ2VyIG1lbW9yeSBwc2kgZXZlbnQgdG8gYWxsb3cgDQph
ZG1pbiBkbyBzb21ldGhpbmcgdG8gcmVsZWFzZSBtZW1vcnkuDQoNCj4+DQo+PiBza2lwX2NtYSBt
YXkgY2F1c2Ugc3lzdGVtIG5vdCByZXNwb25kaW5nLiBpZiBjbWEgcGFnZXMgaXMgbGFyZ2UgaW4g
bHJ1X2xpc3QNCj4+IGFuZCBzeXN0ZW0gaXMgaW4gbG93bWVtb3J5LCBtYW55IHRhc2tzIHdvdWxk
IGRpcmVjdCByZWNsYWltIGFuZCB3YXN0ZQ0KPj4gY3B1IHRpbWUgdG8gaXNvbGF0ZV9scnVfcGFn
ZXMgYW5kIHJldHVybi4NCj4+DQo+PiBUZXN0IHRoaXMgcGF0Y2ggb24gYW5kcm9pZC01LjE1IDhH
IGRldmljZQ0KPj4gcmVwcm9kdWNlcjoNCj4+IC0gY21hX2RlY2xhcmVfY29udGlndW91cyAzRyBw
YWdlcw0KPj4gLSBzZXQgL3Byb2Mvc3lzL3ZtL3N3YXBwaW5lc3MgMCB0byBlbmFibGUgZGlyZWN0
X3JlY2xhaW0gcmVjbGFpbSBmaWxlDQo+PiAgIG9ubHkuDQo+PiAtIHJ1biBhIG1lbWxlYWsgcHJv
Y2VzcyBpbiB1c2Vyc3BhY2UNCj4gDQo+IA0KPiBJIGFzc3VtZSB0aGF0IHNjYW5uaW5nIGNtYSBm
b2xpbyBwcm92aWRlcyBhZGRpdGlvbmFsIG9wcG9ydHVuaXRpZXMgdG8gcmVjbGFpbQ0KPiBhbm9u
eW1vdXMgbWVtb3J5LCBldmVuIHRob3VnaCBpdCBpcyBpbmVmZmVjdGl2ZSBmb3IgYWxsb2NhdGlu
ZyBOT04tTU9WQUJMRQ0KPiBmb2xpb3MuIENvbnNlcXVlbnRseSwgd2UgYWxsZXZpYXRlIHByZXNz
dXJlIGZvciBmdXR1cmUgYWxsb2NhdGlvbnMgb2YgYW5vbnltb3VzDQo+IGZvbGlvcy4gTW9yZW92
ZXIsIHNldHRpbmcgc3dhcHBpbmVzcz0wIGlzIGEgcmFyZSBzY2VuYXJpby4gSW5zdGVhZCBvZiBl
bnRpcmVseQ0KPiByZW1vdmluZyB0aGUgbWVjaGFuaXNtLCBjb3VsZCB3ZSBkZXRlY3Qgc3VjaCBj
b3JuZXIgY2FzZXMgYW5kIGhhbmRsZSB0aGVtDQo+IGRpZmZlcmVudGx5Lg0KPiANCj4gT3RoZXJ3
aXNlLCBJIGRvbid0IHNlZSBhbnkgY2hhbmNlIG9mIHRoaXMgYmVpbmcgYWNrbm93bGVkZ2VkLg0K
DQpJdCBoYXBwZW5zIGluIGludGVybmFsIGFnaW5nIHRlc3QuIG9wZW4gY2FtZXJhIGFuZCByZWNv
cmQgOEsgdmlkZW8gd2hpY2ggdXNlIA0KbW9yZSB0aGFuIDJHaWIgZG1hYnVmIHBhZ2VzLiB3aXRo
b3V0IHRoaXMgcGF0Y2ggdGhlIGRldmljZXMgd291bGQga2lsbCBjYW1lcmEgcHJvY2VzcywNCmJ1
dCB0aGUgc3lzdGVtIGhhbmcgd2l0aCBpdC4NCg0KSW4gZmFjdCwgaW4gbXkgb3BpbmlvbiB0aGUg
aXNzdWUgb2YgdGhpcyBwYXRjaCBpbmNyZWFzZSB0aGUgc2Nhbm5pbmcgbHJ1IHRpbWUgDQphbmQg
cmVjbGFpbSBub3RoaW5nLiBEbyB5b3UgaGF2ZSBhIGJldHRlciBzb2x1dGlvbiA/DQoNCkJycywN
CkhhaWxvbmcuDQoNCg0K

