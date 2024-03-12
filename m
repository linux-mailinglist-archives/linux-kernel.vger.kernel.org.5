Return-Path: <linux-kernel+bounces-99916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16927878F2B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 08:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A335D1F2236B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 07:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A5169970;
	Tue, 12 Mar 2024 07:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="RgPp0Ekc"
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8F4BA28
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 07:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710229613; cv=fail; b=nMg9K3LHMhNRJf1NovPGQx3pegswjvnMhpJLcvI1VJTAru3CHdy0z1ktF65xDTkNRXKTfRBhuaF5w2P3PAFlg1MvEednCX0QMxV4g6HMI1jpa+6LQ1Ml/6Drcrri+PM9RMAVr1A9VC213mShB52sS7iZ5a+Uzv1czULia/FDEVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710229613; c=relaxed/simple;
	bh=ThIrOeU9uof5uqxSLLJu6vbYcP3HCFaM8D4pyttw2pc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oBZrkll6CHUUfxgTaoPiLBoML9N/lYXRU5w+LUJ3rKolaweOBq6MrXY0s3XhTSK/u1sGh/wGDc3zlnYB8GFHN6frN6aIK6yARraU1M/AEQggWRIYKUHq4rjUgCkuvP6ReBgtnBvmtkUjGjpPvLvI9NdY8gDOyilvpfoafxvVyjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=RgPp0Ekc; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42C4wRgS031063;
	Tue, 12 Mar 2024 06:53:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	PPS06212021; bh=ThIrOeU9uof5uqxSLLJu6vbYcP3HCFaM8D4pyttw2pc=; b=
	RgPp0EkcC4f+0K3PlTd40ig1k7mmLXPNBwOPiAs0M/s4HhHw+5eCg6n57NAKm+A9
	R5/JE980Q3JHxosjSPtXeFLTmNX4Fbyd82cp6z3VzwhWR3oKm30cjq8w8KwtH0lU
	YcCT2fO9n5ZzOeHYq/lbL0KR2bbEXhYgmg4tocnR8tLhfAa2bAEh5ACpn2QseLmT
	nlasQPll9Mza7Jb/pnBXPqwfGQCmVDgZtZaBcgLE9F0CuXUw73TjjubPT2p7RxLV
	zqQ73gUdZ2+OYQUqBJmJSaLdmidLsA5LpN7AGVVSF5AuinGu0KyFjqNCz2dXYsHk
	W3pz4EEoU4sMWOOPKtJVRA==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3wrcyxtkdk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 06:53:14 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=exXxThQjnA+timEItj6RwmuBixozdEUcTXwjVi82XI1qVCLDE9uX4o6853OvnAN3UA7HxozI9jlPyyFcMfwWrCKg+LGMzvQ2yzNBXhfEZXx674msIfjay4kLsve5bTjWZpUFqRWUufDJp8QCL7Uib31Lwhxifjvts/9hv2gjNjTkpRc/1ofoEBvZmf0o0nUAPfSWhXofgzm5P5Q8xgaUvHmE2nmVwEB3ponhCX7zl+Dk9EUZ6cucQ02vl/0yyT6ghbpYbrblfSlY2BEk9F18/co240q1xQsZsGXe+3nDrAAgtBrYZONcFcTpqP9bXWZ6CN2zJM38OaX+S78BSSx0tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ThIrOeU9uof5uqxSLLJu6vbYcP3HCFaM8D4pyttw2pc=;
 b=EXqK7BgqRXvaYIKjXlXHcv05Eym39CYeQBUqqNSHh0eSHl4fwDfoHLhrYGG7svjFz0sEns4hvL6QFMx7TvhHdR6LxkoScgeK0phnga9SUV2kh/J7tR+qyNukTr3tu8l37k2NCw2vd1/wnIT8+Lhz6UcAmnmAKJ/h1MnifW4CFRA3ht3QtC4kmBsMLHbfEKnY0HjXSVpYKtYIIE8SBchW+dGnmakcQ2WDtyHbzXIlm0GhPH8E4gIqjqMan8Zm/UmMuS0pBfBmwLnZgMiyFCOTKUDLcwfWU3Ma6hrwVyWKEN4kb2nnd3V8EG9m6cOfibjM5Q++8R9ugjdskMNFwVaOGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5192.namprd11.prod.outlook.com (2603:10b6:510:3b::9)
 by CO1PR11MB5204.namprd11.prod.outlook.com (2603:10b6:303:6e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.16; Tue, 12 Mar
 2024 06:53:10 +0000
Received: from PH0PR11MB5192.namprd11.prod.outlook.com
 ([fe80::230c:58c0:c3f9:b5f3]) by PH0PR11MB5192.namprd11.prod.outlook.com
 ([fe80::230c:58c0:c3f9:b5f3%3]) with mapi id 15.20.7386.015; Tue, 12 Mar 2024
 06:53:09 +0000
From: "Song, Xiongwei" <Xiongwei.Song@windriver.com>
To: Chengming Zhou <chengming.zhou@linux.dev>,
        "sxwjean@me.com"
	<sxwjean@me.com>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg
	<penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim
	<iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mm/slub: Simplify get_partial_node()
Thread-Topic: [PATCH] mm/slub: Simplify get_partial_node()
Thread-Index: AQHac7fnTJ593Y7pyUSU22ikjsNve7Ezo34AgAAIf5A=
Date: Tue, 12 Mar 2024 06:53:09 +0000
Message-ID: 
 <PH0PR11MB51923030F39CD8390556758DEC2B2@PH0PR11MB5192.namprd11.prod.outlook.com>
References: <20240311132720.37741-1-sxwjean@me.com>
 <fd749f4e-2086-4ef9-80f7-b0984350c195@linux.dev>
In-Reply-To: <fd749f4e-2086-4ef9-80f7-b0984350c195@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5192:EE_|CO1PR11MB5204:EE_
x-ms-office365-filtering-correlation-id: 2710f1f7-ca37-451d-8bce-08dc42611406
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 VLOCcO1LTxFY73EqzT/sw3/iR5+G8FhE3RzBx4nMZZgYXhpmKNZ12x5ThsyboDo52F2rCNXI5zQ1/b8ffEfU1hqrUOzZWO0ZWzAtidsYuVZfmwdexVSXkWPPBfgAyXhor+g9GUIpFZozi9z3sNa3uI71LWV69oTO0qAiuSUB90ve0uqZgNuXXioN215Ec/lrtMtbuQSRaH/5yqZaCWCh3X6SviKQEp73jI0uM6J1umdEcd3wgPqEw6wqGA4q0sHaAcRVyW4WrFeYlM1n4WK5HA6Vdt9kdOzAlTOoDCqtO0uQZTAMGiD93r4NpBRDT5NYQcTCThJm//ecjFXzu+yaI33OzrHTMAy0GHOrruE/e2szXOKEJVRhyxTnxmiU9z2vNsYrS4Lz95L0BU/286ig+Xf2Jjeujw3kNAMpOc57KHJxVRdrONngF/9RJzFPMzqk7hCVoSDfQuZ4nCnwMzMjTlq1gm8yWPaYD+TvLsC5io13br0tAXZz3J73sy8nNgNPMHG4ZBtemseo15oRkT51Pa+OAFKEKEv3/IVU2L4vjIXYZKGcu0LEC3/TlU9STos5srLlqfj+C9M64pNGmNw02FizSg1hfzbZafsSerzA/IylXHRrxACel3Y5B21WvNje/NRORPVOie9TL+kPa9MROk9U5LPHLwF6QlEQOlWu17vsv5kyUjEysz4Wk5UeUaHzI9/hpJZBKJKWLmbfj9zBrhDoNF1TgJiV2JAFJI0BcoY=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5192.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(38070700009)(921011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?YlpPTGF4OVpvRkJPYzRQcDNZL21KMDlYdDlxYjRtMHdvVkE0Z1hpenZiMzN6?=
 =?utf-8?B?U1g2eVJ5Q3dha0dDWGo1VUUxVzRsZkpFcXhzSldhdVZxcjFRT1VOQS9jN1hi?=
 =?utf-8?B?dnFKQnhwQnkrVXFhcVdGR3N2eWpvdy9jYTF6YUgyNXNpRkY1dHdobnljWXp5?=
 =?utf-8?B?OGFUZHZiTXRWdFdKQllJVWVtV0dsUkRGVkJCYXZpYUZBMngwV3RFbnRXVHFJ?=
 =?utf-8?B?RklXZWhmdDVOZkJPNk5NZitiaGg0S0pMVnRYREFORGNyVjkyc0VRMU5XLzlL?=
 =?utf-8?B?UXEybHB1eFEyNFRDN1BmK1NFNkcxd2VjMnc3eDFzbWpaUEltMTByem9uVlMz?=
 =?utf-8?B?L0l0MW0zN2xuSlVPaFg5TFFuRkszdmp6YVJQbFJjU1dOM1NhWTRORDUzVGNw?=
 =?utf-8?B?Y21GdjlodUhzQlpOWTZXOENrQkR6YjE0WnZWUVRock5nTnRoNktxU2hoc1Fs?=
 =?utf-8?B?YmJXdXREYzdwSm5OQWJML3piUXFrb3doQitxSjhzUW91YXpydDJqQ0VkS2x0?=
 =?utf-8?B?Nk1rc1A4cnlLejNFeWh5SnNBVU1RV3BuM1lCU3ZUWXdGbHRiSk51aitMZnVI?=
 =?utf-8?B?SlIvcm0vOG5VSnR1Ri9VcU1CWml6S1FtK01nTnBJeWM0RTNqVE43SnR0Uk55?=
 =?utf-8?B?M3hxWW1sQ1dNTmdUVTh6cm0vZ0kvaXIweWdRdEk1UXU1WEp6Tk04MzdXUk5T?=
 =?utf-8?B?Uy9ZNk1KNEk1TUs4cWwranB4T29GKzNhRUpITTdtdUZCMnJtSklXNGo0WDk5?=
 =?utf-8?B?MHZXcEQyYk5wWEE0R3U2OHVJeDh0Rlh2SHUwVUt1WG8weVlhUndlQ0x3QmhY?=
 =?utf-8?B?akV4WW1RRERZb3ZVSEhpNTlCNW5mTERBYVdET3BVTkpZMXd3N3V3bFY0YzhI?=
 =?utf-8?B?N3BXMW9CKzFwUkRSY3ZJVURVM2hUZkE3M2grYjJweTJMeXZET05aK0IxMUtL?=
 =?utf-8?B?Q2RnandGaS83dGMzUjRxS3p5NEtQdEY1cHNyTng0ckorZUF1cEp2ZERLMWt1?=
 =?utf-8?B?VkhnNWF0VTFSV3JDTGpoY0pyUG0yUnNMVmdNSVZURURnWlBBVFhrNlkya3oz?=
 =?utf-8?B?bXJCV0dRcEtZc3IxcUxjdG5Tdzc4L1Q4SkhpY3RZZXNYeWRoc1hEbHIxclJL?=
 =?utf-8?B?dEx5YUp2bFFFc0FEd09yQmpHMUNLeGNuWnAwZEZuNnpXZklyV0dEK1ZuZDN3?=
 =?utf-8?B?OVBhdVRKVkc0bFVZSHFqM3RUekRyY0pla3VFbEM4K1dOcUdXM1JGSkJpK0RI?=
 =?utf-8?B?SkR5cUtGVC9wNFJMVTJRVjRkYzBOVUM1dUphUjE2MWpoWFAzTWJ6OEVQR253?=
 =?utf-8?B?ek8vTmFNMDhKU1hSbHAyL0xWOHNuUVMvSlBCT0Q0S1Q0SHZqUk9iZFRBLzJE?=
 =?utf-8?B?NVN5VCsrTkFGV0NkTXp6WGJ2UHhvZmtWd0k0MUw2Vmc3Q0M1SFZxeXFPR3dq?=
 =?utf-8?B?U0RCSmxZdVpVTitnV0VHemk2aXZoQjd0R3MyUVVtUml6dTU0UTFUak9XOGhu?=
 =?utf-8?B?emZUTGh2alVONU94MGZYVlg1RUhtZUM1eXRtM2hGMFRidnFla2ptakUycW1S?=
 =?utf-8?B?OEpKMTRWWDE4WlZKVDN6Z3NvQ0VsMXRTajBlYTIyNkh3STFMRzJJSFBXenNM?=
 =?utf-8?B?RURZdi91OEVnSSt0ZVZTRVEzRWsxU1loUmlhU0FXcURtTkduK0hUL0FES1ZQ?=
 =?utf-8?B?LzdnMEJKdkcwNUt0N3hKTm9nVmlzM3N3TitUVVc0Z21oNDZrYTdhQW5PTGsr?=
 =?utf-8?B?a3JIb3FIQ2dTcy92SXZTQ2wydjRZUDladWZINVVsUys4RGZQSVhlVktJSkpv?=
 =?utf-8?B?dThBV3BwVDc3MkVXTXhXeXU2cll3VmlZZ3oxUzVaNFp4WkJTbnhwaHZORzcr?=
 =?utf-8?B?UXFreXA4Z0U4b2VvTEpmRFJUY1V4UW9zSE9jL2J3aGVFQ0NvbHdBM3JJVDJV?=
 =?utf-8?B?VDVja25CNXBhQURYRVYzT1h6cEVZWm5UV3NQSndVeGtjdVZkeW9RY0wyNTM3?=
 =?utf-8?B?T05scE9nQ3AveTJYZjhnREdXMVNGdEczczlqbnpndU1QeHh3UVVGeW1zTEkz?=
 =?utf-8?B?VkpCRlJMc1p5enV3K0R4dHZSNWFsSU5Dc0sxNWNwand0OWVFbFZJT0tQRFFz?=
 =?utf-8?B?a2htU3pkLzdyWk9OVHdzcGRvNXpySEFYR2JSdnBNZjlMZWZwTkZvbSt4QWNj?=
 =?utf-8?B?R1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5192.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2710f1f7-ca37-451d-8bce-08dc42611406
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2024 06:53:09.4482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hxcG1SZWIcnvpmMeuddocTq4f5AVF/Vhxu/cGIz6OnLAWoCt1Da+7+TEJnHcI7jERif8ULp5nBayM5ufVzrlpd0MqVzkxUpgmj/BtYVTMos=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5204
X-Proofpoint-GUID: qdSfKvW92IpSb0h9XmaHCFTct7do-a9c
X-Proofpoint-ORIG-GUID: qdSfKvW92IpSb0h9XmaHCFTct7do-a9c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_06,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 clxscore=1011 suspectscore=0
 phishscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403120052

PiBPbiAyMDI0LzMvMTEgMjE6MjcsIHN4d2plYW5AbWUuY29tIHdyb3RlOg0KPiA+IEZyb206IFhp
b25nd2VpIFNvbmcgPHhpb25nd2VpLnNvbmdAd2luZHJpdmVyLmNvbT4NCj4gPg0KPiA+IFJlbW92
ZSB0aGUgY2hlY2sgb2YgIWttZW1fY2FjaGVfaGFzX2NwdV9wYXJ0aWFsKCkgYmVjYXVzZSBpdCBp
cyBhbHdheXMNCj4gPiBmYWxzZSwgd2UndmUga25vd24gdGhpcyBieSBjYWxsaW5nIGttZW1fY2Fj
aGVfZGVidWcoKSBiZWZvcmUgY2FsbGluZw0KPiA+IHJlbW92ZV9wYXJ0aWFsKCksIHNvIHdlIGNh
biByZW1vdmUgdGhlIGNoZWNrLg0KPiANCj4gVGhpcyBpcyBjb3JyZWN0Lg0KPiANCj4gPg0KPiA+
IE1lYW53aGlsZSwgcmVkbyBmaWxsaW5nIGNwdSBwYXJ0aWFsIGFuZCBhZGQgY29tbWVudCB0byBp
bXByb3ZlIHRoZQ0KPiA+IHJlYWRhYmlsaXR5Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogWGlv
bmd3ZWkgU29uZyA8eGlvbmd3ZWkuc29uZ0B3aW5kcml2ZXIuY29tPg0KPiA+IC0tLQ0KPiA+ICBt
bS9zbHViLmMgfCAyMiArKysrKysrKysrKystLS0tLS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2Vk
LCAxMiBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQg
YS9tbS9zbHViLmMgYi9tbS9zbHViLmMNCj4gPiBpbmRleCBhM2FiMDk2YzM4YzAuLjYyMzg4ZjJh
MGFjNyAxMDA2NDQNCj4gPiAtLS0gYS9tbS9zbHViLmMNCj4gPiArKysgYi9tbS9zbHViLmMNCj4g
PiBAQCAtMjYyMCwxOSArMjYyMCwyMSBAQCBzdGF0aWMgc3RydWN0IHNsYWIgKmdldF9wYXJ0aWFs
X25vZGUoc3RydWN0DQo+IGttZW1fY2FjaGUgKnMsDQo+ID4gICAgICAgICAgICAgICBpZiAoIXBh
cnRpYWwpIHsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgcGFydGlhbCA9IHNsYWI7DQo+ID4g
ICAgICAgICAgICAgICAgICAgICAgIHN0YXQocywgQUxMT0NfRlJPTV9QQVJUSUFMKTsNCj4gPiAt
ICAgICAgICAgICAgIH0gZWxzZSB7DQo+ID4gKw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAv
KiBGaWxsIGNwdSBwYXJ0aWFsIGlmIG5lZWRlZCBmcm9tIG5leHQgaXRlcmF0aW9uLCBvciBicmVh
ayAqLw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICBpZiAoSVNfRU5BQkxFRChDT05GSUdfU0xV
Ql9DUFVfUEFSVElBTCkpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29udGlu
dWU7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIGVsc2UNCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBicmVhazsNCj4gPiArICAgICAgICAgICAgIH0NCj4gPiArDQo+ID4gKyAg
ICAgICAgICAgICBpZiAoSVNfRU5BQkxFRChDT05GSUdfU0xVQl9DUFVfUEFSVElBTCkpIHsNCj4g
DQo+IEJ1dCB0aGlzIHdvbid0IHdvcmsgc2luY2UgInMtPmNwdV9wYXJ0aWFsX3NsYWJzIiBpcyBk
ZWZpbmVkIHVuZGVyDQo+IENPTkZJR19TTFVCX0NQVV9QQVJUSUFMLA0KPiB5b3Ugd291bGQgZ2V0
IGNvbXBpbGVyIGVycm9yIGlmIGJ1aWxkaW5nIHdpdGhvdXQgQ09ORklHX1NMVUJfQ1BVX1BBUlRJ
QUwuDQoNClllcywgbWF5YmUgd2UgY2FuIHVzZSAiI2lmIElTX0VOQUJMRUQoQ09ORklHX1NMVUJf
Q1BVX1BBUlRJQUwpIiBpbnN0ZWFkLg0KDQpSZWdhcmRzLA0KWGlvbmd3ZWkNCg0KPiANCj4gVGhh
bmtzLg0KPiANCj4gPiAgICAgICAgICAgICAgICAgICAgICAgcHV0X2NwdV9wYXJ0aWFsKHMsIHNs
YWIsIDApOw0KPiA+ICAgICAgICAgICAgICAgICAgICAgICBzdGF0KHMsIENQVV9QQVJUSUFMX05P
REUpOw0KPiA+IC0gICAgICAgICAgICAgICAgICAgICBwYXJ0aWFsX3NsYWJzKys7DQo+ID4gLSAg
ICAgICAgICAgICB9DQo+ID4gLSNpZmRlZiBDT05GSUdfU0xVQl9DUFVfUEFSVElBTA0KPiA+IC0g
ICAgICAgICAgICAgaWYgKCFrbWVtX2NhY2hlX2hhc19jcHVfcGFydGlhbChzKQ0KPiA+IC0gICAg
ICAgICAgICAgICAgICAgICB8fCBwYXJ0aWFsX3NsYWJzID4gcy0+Y3B1X3BhcnRpYWxfc2xhYnMg
LyAyKQ0KPiA+IC0gICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4gPiAtI2Vsc2UNCj4gPiAt
ICAgICAgICAgICAgIGJyZWFrOw0KPiA+IC0jZW5kaWYNCj4gPg0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICBpZiAoKytwYXJ0aWFsX3NsYWJzID4gcy0+Y3B1X3BhcnRpYWxfc2xhYnMvMikNCj4g
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4gPiArICAgICAgICAgICAg
IH0NCj4gPiAgICAgICB9DQo+ID4gICAgICAgc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmbi0+bGlz
dF9sb2NrLCBmbGFncyk7DQo+ID4gICAgICAgcmV0dXJuIHBhcnRpYWw7DQo=

