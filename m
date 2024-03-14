Return-Path: <linux-kernel+bounces-102965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B825A87B92E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC5A91C20B7D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 08:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDA5CA6F;
	Thu, 14 Mar 2024 08:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b="nZTancGG"
Received: from PR0P264CU014.outbound.protection.outlook.com (mail-francecentralazon11022018.outbound.protection.outlook.com [52.101.167.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B452EEC4
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 08:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.167.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710404365; cv=fail; b=cfKpfH9CqOYhZ8HumLy1sV8a75fw6RSHcteseflOO0zU65X+0tFDGy7sKQq+QWCJGZiTjcm/7ww9mQ0nW6+gwhWKMk55EMBcBZep6Xk6i6IzBH3rMqKBElxYvvp32OlW6t+MGc2pAX2cY9kFdwCHn+6cKZy6wQZXElAlEu3f6yc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710404365; c=relaxed/simple;
	bh=++a109ML8rbxIY+dN1JPqZ1wrtFo9qn23CbXBUoWvsw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XJxFw6Oa5eSqAU0LavVraO00/vCVPn1w/P+QbSt4Utkc8oM/kMWK6SkxXgbCZAde9UP2iBHYzLW8qOCWZbBVN2Mm8u0Ur/UbASn0jwQQ6FC5BYTsUWmEASiSNdTNmqochRVq7u5xYYRrWi7SJpQ5skZ8r5fr6OHaCbLJwhebzTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b=nZTancGG; arc=fail smtp.client-ip=52.101.167.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R3XfHMHuCffmVeEFRv1iyyqFjQyu4G2b/ysn0a8GzThBSdMmSPRCtqQurAybkoHCQ0CUZy7umpfHfIkM+F6mCZd+7yKsntbsmbmtxtAgywRfwO7UjT11bQ47W4YdXI5oCVbOC+3s7yYfFxVbbIeVTFLWpyfiztYzZCX0QzWp/7jeHtZYhG9HNEc0eXppdlPuM/VOLcDWWLKXxFSNDGVPDYpeQkuJzmlPZ9VPg89w+AFOX3aihkP1mYtWk/N957c/bPn3nibJwhpFHfyEzs1SLjmDpUZmWx8r7fcDSJeDwKyO5DpYWeGUgClbXBjrKDwntDKioHdsnWHDbIuiQW7RGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++a109ML8rbxIY+dN1JPqZ1wrtFo9qn23CbXBUoWvsw=;
 b=POdxn2keJT54gOwOG1/nj6Urs5XzHyexSM/J2gtUt5l7eg52JcS6zX4V2dCgSK8+dlXy3I1pjiZdqF8ToHKGwmO6w035qcJhXrJC3aiV6JeiX3N5kJ6Eem/o9Bkb5/gGUe7Ff/Ww21LbdCcxNhz7/QsiSdSdaTzJX9RqbgntLldzAC7ITF7mXcbb5t/aTGfzXxJgp9oo4e76UQO1AA6sLeqkIV6gYV+k02hx5/RJ6dsIpB/ZQCqLwtwq6GgRHvhxV3AFZPtXdfhBvJ51u0dWghsPDNedlRuq40XYzbBXlUKnXWQl9DM1zR1BSJIKs6W90LdVOsNpUgR1iagybguitg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++a109ML8rbxIY+dN1JPqZ1wrtFo9qn23CbXBUoWvsw=;
 b=nZTancGGmKJfRAmBsORGIhvRmuIXCgiRMw+OfU9FYlI/P0/RlQ4SvZpv9NdEorQVSy6KC8rMUMoYcaa4RwT6ac6+UJj9r7Dn2yiA0EsvJRTfiAAp262K98J2KwaToh6QvgtwlkhIdDdHkO+1rF8WymlgQgmefp11YI9ZentKEQqtTtXk1MP7FL6af7MjC1E327GA7AOHbehMz+nXlBqVjzUoJIiAD7Ku6pZzO/NeVlHzOqzLGDz7FvXK14f77MbL8oJGvLVXSrlg6sL2chaGohp+1hH2PrjY9q6O1uoSAkUt/gBetkfPCUgLHKP4pvdf/NytIYmDb6KGNw35vfX9Xw==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB3009.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:3a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21; Thu, 14 Mar
 2024 08:19:20 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c192:d40f:1c33:1f4e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c192:d40f:1c33:1f4e%6]) with mapi id 15.20.7386.020; Thu, 14 Mar 2024
 08:19:20 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
	"kent.overstreet@linux.dev" <kent.overstreet@linux.dev>,
	"peterz@infradead.org" <peterz@infradead.org>, "nphamcs@gmail.com"
	<nphamcs@gmail.com>, "cerasuolodomenico@gmail.com"
	<cerasuolodomenico@gmail.com>, "surenb@google.com" <surenb@google.com>,
	"lizhijian@fujitsu.com" <lizhijian@fujitsu.com>, "willy@infradead.org"
	<willy@infradead.org>, "shakeel.butt@linux.dev" <shakeel.butt@linux.dev>,
	"vbabka@suse.cz" <vbabka@suse.cz>, "ziy@nvidia.com" <ziy@nvidia.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH] vmstat: Keep count of the maximum page reached by the
 kernel stack
Thread-Topic: [PATCH] vmstat: Keep count of the maximum page reached by the
 kernel stack
Thread-Index: AQHadPdfRmd9q5Dvw0ykuTv8AkuxKrE25rCA
Date: Thu, 14 Mar 2024 08:19:20 +0000
Message-ID: <7af73776-06f9-42e6-9bfc-fabe8f8b002e@csgroup.eu>
References: <20240313033417.447216-1-pasha.tatashin@soleen.com>
In-Reply-To: <20240313033417.447216-1-pasha.tatashin@soleen.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MR1P264MB3009:EE_
x-ms-office365-filtering-correlation-id: b0fe3fff-dc1c-401c-5a14-08dc43ff72ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Rk8zucMUPukjGmZm/YtaYbeSAvqDIvesWwJlg8CoEVJOyXpxqQ2RhzFUXg57fWZz4jhlsoXCecwEXlSj5KxNxIk26ynfRhXyDl/7sZ/M2S/5tYFrNE0a45rX5QfDUQatH6iLU+BRUFlthUfdMSgSD8LFE7DyqlOCrIHinmxSpz0x52RqSE4ARZsbsA32Q7GlZWIBrzCCT3TrrecArjoLF+j59fkYiaHMiIRnBUGqkTtuzrTOpbybDt1b1gTWvvyufQ71sufJ3iKQ32nkleaQ5+PJUF+Sh+nw5AZ5nO+g0OLTrmxhZPjAb6ieiZ0udMmHnb0WinWVrbXedRYb/b8SFSLwEuUNMM7N9s/0kk5yPOxzgDdzIRe5w7//rudUaa75Mvqix1fQDnMjK3isCUW6YyAP7etLW29bhAbTlZGL33+pBL/l4oiIawUq6/wmbE1p1TQQT/i7I8YppOp6VpMXd1NhES4Mk9/9sH44gpnuwCismKtA81s0ueYGlRdmrUrhE1jq4aVt5oZsV3G0o+PLi4pQ3FqVa377X9P9BAP4I4ojnuiqP8sMYZonVTpWTcheW38g1OhkqD91n4RPAwcCksJ91F7n1gTOGq8l2oZb+qEcSDZepvxarKuYyUhshNhw4nj5jnc/UP+6Dn19VYkDS9NYoX3O5rSsEPUW3g523JrrWKdUekULwK56JR0GI4HNe9SG4h61+HoeHojp5RS7ZJMUnSmEqUIj6vWj2RPsUE8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(38070700009)(921011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UUxteVlQb0kyWWd3NjNpTmIvNHoxR2pBTG1TbjJvT2RUV2NwVTREMVlZWW5F?=
 =?utf-8?B?N3U3Qm1WaSs3MnRxTjJZbU90ZDQrMEhhYjd4d3ZyVzg0TDZUdnJybFBRbkc0?=
 =?utf-8?B?YW1XSzF3OEJ6em1aV09FWC9EV05aeTBaTEdsSnZsSCtGY2FrbmdQQUc0YkM2?=
 =?utf-8?B?T3RSN0xuRCtqQmErYnhWcFB6VmVWUEtlSUNVTDdnQmpSeG9vWkpWWGF3cGY3?=
 =?utf-8?B?Q1FJbzNQRkpsK0d0U2g1bGRvb0dET1VOdm1UT01HcG5YeFRhU3RYd3Q3SHhL?=
 =?utf-8?B?c0U1TEJDbDkwT01JVjBFM1N5ZG81NTgxRVRQeWxnYVc2OFJZZjh1RTVVaGhJ?=
 =?utf-8?B?cGUvZGlTRDRXN0pMNmVkeGtlNlNnUnhaRzFmNVNscDhXZEZhcEdUVXlaMDBW?=
 =?utf-8?B?MXFPelRwcDNjR1B3Tm11VjMvaTBYYmExNDFHR2l6M2d2a1d1UTdHMHlQOVE2?=
 =?utf-8?B?ZnI4UXBQTElNbElJaXBSQ1FsbG9IUkpYbVhCV2Y4V2ltVGhvOXpvWFhIN2Yw?=
 =?utf-8?B?NENQdlJmdjAzcmF5bnpXbE85SHE0QUI4T2lVeDZhK2I4ZE8yWDVRdU1zcHJL?=
 =?utf-8?B?R1lheEFHaThIWUtXenZsSXRkWWY0Q0xBcjVFelZ0Z1VWNGNUaHNzZytFN0lP?=
 =?utf-8?B?c2g4YjNPaGQ0Y0VLRytxTlMwTEMzZ2R1MHZoQTRGQ0h5alhtU2h5S0Exd3lF?=
 =?utf-8?B?RDQxRUpWZTJBWjMrVGNrV1dDY2VqWXZDTlR2TWdaenFkeGZJeVBEbTNKTk1G?=
 =?utf-8?B?WUFnRHJMWUJvY2RkRWNSaXVrbnJkb3I1QjN4MDltMkV6eUlXc0w0cmhyK2c0?=
 =?utf-8?B?MG1hU1piNFRYUjQ4Yy93TGUzQS9YWXJxWVpvenBXMm9OMXkwNDNUc3lsbUNS?=
 =?utf-8?B?WHRqc1JLc1Y2U2o5MjR6cG95MjB3Qm5KNEpkV2p5OGRtNm45VG1ldTFBWEJN?=
 =?utf-8?B?TTg1bHBIR25BVU8vQ0xIOTA0Y005VU5PKzZNZVRiSXNHNmFnU0pmOG42OTlK?=
 =?utf-8?B?Sm5hcDkydm1EVHAvYmdia3ZRQ3RKNmdEcTRaVmt1TkZyaTVCZEk2QjZtUXNB?=
 =?utf-8?B?TURyb1BKbGYxTkFVRXRPUnZtRTk3NlBaa0p3N29MYk1sVDdtTlVUVXBLdFd2?=
 =?utf-8?B?YVlpUVNMSmVub2owNEJwS1JJUTZZQU5CbGxRTExxWmtDSGtjSUtNVzhuZHds?=
 =?utf-8?B?QzY3OXR1U2o2Zzl0cklYT3lzcHN4NUswK0x3bGFFd05TeWFLcVFoaWpwSWlm?=
 =?utf-8?B?SStuZUpTOFR4MzdjcE9YT3ZsaXZKbWJZTjA1NDVjbDZ1NzE3bm4yWDlSUDZP?=
 =?utf-8?B?VkU4UzdtTlE3SGNzL0hVcXljWStrVmloYWNLeUhHeGZSVGxPRlZaVDJybnM4?=
 =?utf-8?B?VVh5NDhxWTFBdEYrZDdzS2lCRzRZTitUVGtmdFFxYmZtZFJCZ3pFV0Y1MVh6?=
 =?utf-8?B?SG9uMlQyU29NRWRhWkowRll3SVVBdVcvNEtpSE9IRGs3ZnNoNlplWUJzM2hE?=
 =?utf-8?B?MXhKcVo0amlyUUZUaDh6Zk1UNEZYZVAzamZ3VmVybURpd09yZkFjUlNwMTUy?=
 =?utf-8?B?NktVa24wUlN0WGVNRCs4b2o5cHVlczFKM3VtRHFnUGdQcXc5akF0VzhzNkM0?=
 =?utf-8?B?WEhSWG1heE5pb1AxcDJSa2p2dUZkY1VVaC8wVzhOUzQvY2VsaHAvOGN4bWFq?=
 =?utf-8?B?dlA0YzAwcGgrcGNsaE5tdkV1WU5xMEhMeUhaWFlQNXJxQzkya0xwNkJ4UTlD?=
 =?utf-8?B?R2JCdjlKZ3ZZUEJORE5hRjUxQ1hQLzdVSVMvd0xtMFhFTzBORm1EYTVBZUo1?=
 =?utf-8?B?Q0k5U0J2TXd1WTZWMzMzM3lvSlkra3IxV2RIZzFwQ3ZUOVZ3aldEWUZkWHJh?=
 =?utf-8?B?THlJTERUWmoxMEVIdlZPQXhRd1NmTElnRDhZbFFUeTVkTm5LZE92K3lsQWVn?=
 =?utf-8?B?LzZkMy80cmtIYnhUTHhzaUludW5yZnZGZEpETDFNYVkyanBvRk1kRUttY1lF?=
 =?utf-8?B?VkxYWW8rZFMya1NGT09VOURtZzhNREtDaXozWWZtWE16N3hhQkQ0cmNMckF2?=
 =?utf-8?B?MEpvS1VnbzlybEZCVEl0b0NhbUlWOU80dktDa1Voa2dib2NkTGpVZWZDVG5u?=
 =?utf-8?B?dHVXMXFYWjY0cU1IVUpKVXBmemxvbGlWTk5wc2JhbDJ1bklnT1JlV2N1YTVj?=
 =?utf-8?B?YjZuTkF5Q1RzZ2xRR3ZHNm55M09HN3ZyTXlWZjBjZVdYWkRoTnpKTXROcUd2?=
 =?utf-8?B?OUNtZ1poY2tWK1lTdVJraGgwaW5nPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0762734F82C6A140A812933929C35A67@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b0fe3fff-dc1c-401c-5a14-08dc43ff72ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2024 08:19:20.1110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vruunjcNsS1m10F1BAY5bfPZ6zSL05ElJ6N7SeQ1TB/0LXWeWrj+F1pFHWIZlQgTWGFTS2/NrHdW/QXgKgxXz0uvb8vBMy1k9mO26a0LKWA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB3009

DQoNCkxlIDEzLzAzLzIwMjQgw6AgMDQ6MzQsIFBhc2hhIFRhdGFzaGluIGEgw6ljcml0wqA6DQo+
IENPTkZJR19ERUJVR19TVEFDS19VU0FHRSBwcm92aWRlcyBhIG1lY2hhbmlzbSB0byBrbm93IHRo
ZSBtaW5pbXVtIGFtb3VudA0KPiBvZiBtZW1vcnkgdGhhdCB3YXMgbGVmdCBpbiBzdGFjay4gRXZl
cnkgdGltZSB0aGUgbmV3IGFudGktcmVjb3JkIGlzDQo+IHJlYWNoZWQgYSBtZXNzYWdlIGlzIHBy
aW50ZWQgdG8gdGhlIGNvbnNvbGUuDQo+IA0KPiBIb3dldmVyLCB0aGlzIGlzIG5vdCB1c2VmdWwg
dG8ga25vdyBob3cgbXVjaCBlYWNoIHBhZ2Ugd2l0aGluIHN0YWNrIHdhcw0KPiBhY3R1YWxseSB1
c2VkLiBQcm92aWRlIGEgbWVjaGFuaXNtIHRvIGNvdW50IHRoZSBudW1iZXIgb2YgdGltZSBlYWNo
DQo+IHN0YWNrIHBhZ2Ugd2FzIHJlYWNoZWQgdGhyb3VnaG91dCB0aGUgbGl2ZSBvZiB0aGUgc3Rh
Y2s6DQoNCmJ5ICJ0aGlzIGlzIG5vdCB1c2VmdWwgdG8ga25vdyAiLCB5b3UgbWVhbiAidGhpcyBk
b2VzIG5vdCBhbGxvdyB1cyB0byANCmtub3ciID8NCg0KPiANCj4gCSQgZ3JlcCBrc3RhY2sgL3By
b2Mvdm1zdGF0DQo+IAlrc3RhY2tfcGFnZV8xIDE5OTc0DQo+IAlrc3RhY2tfcGFnZV8yIDk0DQo+
IAlrc3RhY2tfcGFnZV8zIDANCj4gCWtzdGFja19wYWdlXzQgMA0KDQpUaGF0J3MgcHJvYmFibHkg
b25seSB1c2VmdWxsIHdoZW4gVEhSRUFEX1NJWkUgaXMgbGFyZ2VyIHRoYW4gUEFHRV9TSVpFLg0K
DQpPbiBwb3dlcnBjIDh4eCwgVEhSRUFEX1NJWkUgaXMgOGsgYnkgZGVmYXVsdCBhbmQgUEFHRV9T
SVpFIGNhbiBiZSBlaXRoZXIgDQo0ayBvciAxNmsuDQoNCkNocmlzdG9waGUNCg==

