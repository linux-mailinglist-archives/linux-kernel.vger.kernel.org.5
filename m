Return-Path: <linux-kernel+bounces-102953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D8F87B8FA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 08:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96ABB1C221A5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8975D47F;
	Thu, 14 Mar 2024 07:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b="Yi7W8lvx"
Received: from PA5P264CU001.outbound.protection.outlook.com (mail-francecentralazon11020003.outbound.protection.outlook.com [52.101.167.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D035D463
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 07:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.167.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710402912; cv=fail; b=SPe5kd83E4QuqB1GNrxSiH6nUG8abECpVnr/AC3SYpkR42waOpQtbxq5Aonhti4t9fcWyXoayYqY6NqXocitacol9IBZgxDaWIbaK5RNfQi/FdykDjCKJhEOvWyOVClgXjvg9j/NDeLpF4ASU7JS/AvWHnyojs71JO1eBe9icWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710402912; c=relaxed/simple;
	bh=5i9aTer9cfT0thtmQL+PK9tuuqSn13pu/eaYkhDgphQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cica+JVmnc0u4cIQuuX3ENfjxNVex1maUcIM5TXggwUldlr+8F/TvU+dGFJkluTDr4Akdy5MU2mwKHEs4L0Z/E0uZ2S96eoKu7eyoiStQuZmIcHsE3UdQM7g0TSoiMA8TB3qC7W9FDygsoQuDAVwA9AmzPTIO7KBpGKAqXTnmtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b=Yi7W8lvx; arc=fail smtp.client-ip=52.101.167.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VawToANvSOOzxo2KIMGladM1RosN9FORss85EFNzuNkbeisGQejy/0h0uIuHxEburNQuUcEk44gc3EdPw/aTNJcvaq2Q2sIII8Bos9z3342gUR1/8OLeUk6fM9tXIMMA1kBRwa+v0GJGeRu4Pl3qro0cpXm8cL5AjmjaXfsxkhEy2TaOt9muy/y1vK1WyGxhYKgOBOaF/cPHx/1aSyw5j9EFqe+7b+O6B3X7Cj+qPHkTp3+ivLsjulUMIzVAXMe4Jm36eLz9ES+PJ3cCrF903Krq2iwkDSvFD2m+NEIpf/wYDmDQYcOIxeXyDlMR/TesxlYzWpxYrviuU9QxKVIWHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5i9aTer9cfT0thtmQL+PK9tuuqSn13pu/eaYkhDgphQ=;
 b=f4d4HuWXPxQTkEJ9XsH+zmdGO3Et8TgC/a2+K2JLchnpXnhXr7qPD0GZ9uI8grpRnWOiQwwdgzv1tumgwxb9nU8pGTeXaVKFalc8Kfr/6akp/E+UZMtcuh6R47Cm4cyGtAlntR1HadL+gsp1aP9TuqNdvAWV2xZJkhomcwrG62NlW0eZ+zFDMH6di5fKcwL+F2fz+y7cmdzryzDRzVPPqnzmLFohuDvBURmZg9O4RwEGInRe7cOj3p+vPl3I054kMsSCz9Fd+0vg3jfjDRNf2U4OZQBOcooWyb1eijxLIHZKDrq281/a6E+MEx4mrvYh7nTNH0Uh2qjNmqO3ZHWK3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5i9aTer9cfT0thtmQL+PK9tuuqSn13pu/eaYkhDgphQ=;
 b=Yi7W8lvxvVisrPUD6DIC9/fYjNSCVSIFMTpWCg98p8QWUxvQPFe3aLlTiKSnv0gc/fnXiFzTGLCsTpwFjLxDehsNrEQTjkAkU043o5P9+PRqRlqQRtXmba8BsQM4DZ8UTV/d6UAVI3SR8WLybFCH57sa5aPQYb1UVDxRSkxPnjkobHnFzEFSpHK1sjlsZAuChQPYwsGwn13CkWsdgwOdokaxjVW9g2adAHNzzciVVToTork/WS4Bi9U33Ya2O5/sOmD1mABk5hueYrDO94+c/FycxVkI1JC8qwZs5dkhdRM7BjTpsKAvIWszN9E3dCbXaG3qkfepM8lR5KCvUQKifw==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB2275.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:16e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21; Thu, 14 Mar
 2024 07:55:05 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c192:d40f:1c33:1f4e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c192:d40f:1c33:1f4e%6]) with mapi id 15.20.7386.020; Thu, 14 Mar 2024
 07:55:05 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, Nikolay Borisov
	<nik.borisov@suse.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "x86@kernel.org" <x86@kernel.org>,
	"bp@alien8.de" <bp@alien8.de>, "brauner@kernel.org" <brauner@kernel.org>,
	"bristot@redhat.com" <bristot@redhat.com>, "bsegall@google.com"
	<bsegall@google.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "dianders@chromium.org"
	<dianders@chromium.org>, "dietmar.eggemann@arm.com"
	<dietmar.eggemann@arm.com>, "eric.devolder@oracle.com"
	<eric.devolder@oracle.com>, "hca@linux.ibm.com" <hca@linux.ibm.com>,
	"hch@infradead.org" <hch@infradead.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>, "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
	"jroedel@suse.de" <jroedel@suse.de>, "juri.lelli@redhat.com"
	<juri.lelli@redhat.com>, "kent.overstreet@linux.dev"
	<kent.overstreet@linux.dev>, "kinseyho@google.com" <kinseyho@google.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"lstoakes@gmail.com" <lstoakes@gmail.com>, "luto@kernel.org"
	<luto@kernel.org>, "mgorman@suse.de" <mgorman@suse.de>, "mic@digikod.net"
	<mic@digikod.net>, "michael.christie@oracle.com"
	<michael.christie@oracle.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"mjguzik@gmail.com" <mjguzik@gmail.com>, "mst@redhat.com" <mst@redhat.com>,
	"npiggin@gmail.com" <npiggin@gmail.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "pmladek@suse.com" <pmladek@suse.com>,
	"rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, "surenb@google.com"
	<surenb@google.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"urezki@gmail.com" <urezki@gmail.com>, "vincent.guittot@linaro.org"
	<vincent.guittot@linaro.org>, "vschneid@redhat.com" <vschneid@redhat.com>
Subject: Re: [RFC 06/14] fork: zero vmap stack using clear_page() instead of
 memset()
Thread-Topic: [RFC 06/14] fork: zero vmap stack using clear_page() instead of
 memset()
Thread-Index: AQHac9O+Bl3nwUPpBkmgXZS6PicpsrEzspsAgAChSwCAAo5MgA==
Date: Thu, 14 Mar 2024 07:55:05 +0000
Message-ID: <6f351959-4711-4a21-8c46-94e536d2eff8@csgroup.eu>
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
 <20240311164638.2015063-7-pasha.tatashin@soleen.com>
 <f5105c5d-59fb-4bca-af70-353e480f2b12@suse.com>
 <CA+CK2bD0ShasU0U5gzp_m99V=NAg1o8wAKH3_+1ghZHmsWhL9w@mail.gmail.com>
In-Reply-To:
 <CA+CK2bD0ShasU0U5gzp_m99V=NAg1o8wAKH3_+1ghZHmsWhL9w@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR0P264MB2275:EE_
x-ms-office365-filtering-correlation-id: 73696448-2552-461d-e8b3-08dc43fc0fdf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 BZf3yV0aHv3r91Pb1f8uyyGtK8yIGXDfP2HkeRwWfzOdWWuOplPPsWsMOrKQYZ4rOaDELdaNIn4k8iTc/JJlIaHF6POo7JDPdTe4kpDAoathP0nQLvkIHiYqK26uLjMvs7otpGan0z2dVBuZ/9mJf+HT1hRoDQqagUDrTeVRMzL3X11Izuqo+ax++oUdh1aehcvnAT9K46aAj/mnkJzH7rqJJcSPizBsesRsR8GDeueo9ak8VxVvi04bfNne3SRXGuLsu60lJ8iY6Tfm89i0GDo2EH69FbBodWklc8kf9M5PiJ/VSs9Fii15mOvfYaOP/A6BUUfO6GD7UHJxcwVJLSRnqtlgCOU8AW6eLadAEvOfrUTrSZGy8ttFyNA0k0jiJ8jSMwOrs1jURuMBjzivZyfxr406mkNz9L8izWRPFqI4ZzaHF8Cu0PoewbSEZ6LK1gQ+vtlkD0DsN+dzYZabW2hdXzUPgVORPpl4rrpbEQ0+7YeYCrvvqfvfFoTIHBTYoDV3Zeqp11vQ87RLodBa4IgreDFQiNDTG4rFESkzk75JSgf+N0pgWESuLZlPauvMzuSP7UPvOV5JZvmDrp62mM6BDka+Vx6+OFgNraA44OKjwImIoYhTPn/0Hza9yDHDVnILaR41hUPiOJ7ovdxDRFuDS7ZJU5j6mr77eq/nXR8jin0AZi3ruTrPfy82vCkymnXq5SRnkVzR1rxMw7DffHdWJXQEn9YRg1jsjgKFb7M=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M1VBODNUQ3NlRFFiVGFrcGt3V0pjd0YvekFkdzBMeGtVUzdOcWtHY3JWaFU0?=
 =?utf-8?B?U2NLbHBqWHRCaGNyanA5YVpSUTNOR0VjUXhqSjZBa09WeUVHUVJOck5hT0Z6?=
 =?utf-8?B?K2FlSzRoc2VtQ1ZKcjFxeDAzamFpQW45Z09Lc2t4cWg0eG54c1QwZk8rWnlp?=
 =?utf-8?B?cEJxNFNmZS9zb2tYZkRJODhuQTBFTXdGSCtOb2FhNWlZRm5lbS9IcVArdWJa?=
 =?utf-8?B?bnpkTnpoYnF6SmI0ZWthUy8zK2VEVHpRb3BXVStUTUxpclBVTGJsUTJNZmgy?=
 =?utf-8?B?aFR5N1FkUTZXd3ZDblArRVNVdzB6bmhrRHRGeGxTb2VqZ3UvOWhQSXE4RUJZ?=
 =?utf-8?B?UjF6NXRlZm1Yb2dFTDhFWGIvZjZUY1BYb0t1MFlBU1g2Rit2QlovWmNFVEEy?=
 =?utf-8?B?Rm5RMEV5Zlp1cjBJTG9rR3BURFFhNi96MXVManh2VU0yUDYzQW9CUmFKQnhE?=
 =?utf-8?B?WDlDWWZCWjhxazZtU0IzT1Bzb2orUTJWTERNL05Pbk95Y2FwK0h0My9iOUxD?=
 =?utf-8?B?SWF5NW05Nk9JUFhBekpoemZpQWlDMVN6aHFKSXhSV1Jqc1J3T1JtUi9YSEpv?=
 =?utf-8?B?SlhLQ0pEeHdFMDdCeWJkT0hRWlY4dXlvVXV0aVh1M25QUmQ4U2MxWmhlbzg5?=
 =?utf-8?B?VW0wU0MrR0l6dkJseE1WMGtabjl2bHZhc1JINzlSY2dSMytXWkZWSjBhcmsy?=
 =?utf-8?B?cWh3K1Z5Smc2MnNET1NSeVVyUWRSYlU3T0dIOU1xaGc3bFNSZmZDMGxLTWJz?=
 =?utf-8?B?MlhQU2xxaDl2dkFVdXNZODNsaFhMNkFmZThZWXNJVm5YMUZlN2d3cnM0U2VB?=
 =?utf-8?B?cU9OV3pkTFJyaDd4SFUxd3hkdFFqNUxvVkh1aUtPNEpKTVN2ZVU5SDZJMGtS?=
 =?utf-8?B?aVlqVEZkL1dYUEhGVnhpYlA5S0pSY2phNUZMaEtoOUVRRVBwUEh3TW5uRGlI?=
 =?utf-8?B?c1B2VFRxcEg5ZGJVUCtBa1hwNFdQb0VRclQ2V3lLdkhQekw5UXhIbTAweDdW?=
 =?utf-8?B?Q24vWkNTRXNjejZxSTgyZy83STduNHZ3RjkraHJNdEJyczRvS2RsbGxIR01v?=
 =?utf-8?B?aE5IOEJJenZMUG1iaGhaZzErSyt0YnFGUHRDN3BIbHNQQ0lLS0JiQXh4dkdI?=
 =?utf-8?B?Sk1tRDMyWlBtMkdZdzlabFM0QXg2Z0J4bnR5cGJhekdidHg4TUwzWnBZVnRB?=
 =?utf-8?B?SVJ1cDdtWXpySkloRWZGdVVaN1dhNU55aCt1OFRrdi9EaVA4UVBtRU82WWUy?=
 =?utf-8?B?b3BGS0pLcE9DUEhaT2xtNnV5dG5QRmZ5d1drSHpaUjJzbmRFY2I1OWM0OW51?=
 =?utf-8?B?Q0RuL29uSkhEM2hDTkxBelhHZVRxNzVOSHdBMW9vNlJuaFpTcUIyQ1duV1dB?=
 =?utf-8?B?WmFuK3BZek9ycnBuaS9SbTlYa0RvMkNwMkFjWEhpam9SSDAvOUhrQTFFSTlu?=
 =?utf-8?B?RTcrWVQ4cVBoM0ZvcWJ0aUtaM21BL3RFS3dpVWx3bnNIc3d4Y2pUanpXUldY?=
 =?utf-8?B?YmF6TVRIVnZKQmVIdm54VG00UU9NMTFYelQ2OGZCN1Z0OFBlU3NxQlJpcTkx?=
 =?utf-8?B?NlBXY2VhOE1EZGgwQ0pmQTZ3RGVja2dLZmxHVFRWWHZ3RUNrOEVIUEptZUow?=
 =?utf-8?B?V1JpWjhieDBuQVJkK1QzVFBtNGoweUVEMmxrSW5TT1gwb2swcW4zS3RrN2hq?=
 =?utf-8?B?VjFZV3hRL0lCRGZpR080Z2IrK0ViV1RtTlBZc3RmM3BkcHVEUWp1QmJOQUpo?=
 =?utf-8?B?RUtvdElqQ01lNjIrdHdNQzJUclhodXVuSlpsTllIbUJGc3VaeGpseUJ4NHh0?=
 =?utf-8?B?Qjhnekh5VlZlaXR5ZzFBdk0xelEySmtGdkxOcjVBR2hIYUZFQllKdTRZTUNS?=
 =?utf-8?B?bzY1bHc2clltbHB6bDNGNURDMkxXUytvNDltc0pGT0EwcXM3eU45VVM1b3Iy?=
 =?utf-8?B?YVpBTTVhcjNqb1d6eW9pU3JMeGdROHdwNU5MK1E4bS9ncXNzeGhPanI5U1Vq?=
 =?utf-8?B?ZDcwbm0vdUdscndLbEdaSjB1anE4c3ZmQmpNVEg5cVg2Q2NROEpuMnpzbGtZ?=
 =?utf-8?B?cTlyOGdVTW1VRm1DdW5ZRTBnK2owQ0lYS0RHTUcyT0pNenNyZVlnUnpPakts?=
 =?utf-8?B?U0k0RlRLSldMczVQVWhkZnArTlRJcFJqbkVJMGl1NTFCMjhsYnJNUzNiZndX?=
 =?utf-8?B?NlpTVkJ1aHkxditkcXp0WFhwalo0ZWpyYXpYc1VybHZ0cjNzVFd2ZzlQOStJ?=
 =?utf-8?B?U0E2NW41aTBWOGF4RlVqS3dYdnRnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2E29FFA8C4BF194F96762B8577B0AD39@FRAP264.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 73696448-2552-461d-e8b3-08dc43fc0fdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2024 07:55:05.6841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E5Hky3++NRm+9/X86e6CiGDo093LoGsdBeV9mtvXouyfALTvzlooyuV2RDSAk/Ijhj0wpGCdIrQlnhYMrUy23uyTr8NGc0y+UE8EnyjqcOU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2275

DQoNCkxlIDEyLzAzLzIwMjQgw6AgMTc6NTMsIFBhc2hhIFRhdGFzaGluIGEgw6ljcml0wqA6DQo+
IE9uIFR1ZSwgTWFyIDEyLCAyMDI0IGF0IDM6MTbigK9BTSBOaWtvbGF5IEJvcmlzb3YgPG5pay5i
b3Jpc292QHN1c2UuY29tPiB3cm90ZToNCj4+DQo+Pg0KPj4NCj4+IE9uIDExLjAzLjI0INCzLiAx
ODo0NiDRhy4sIFBhc2hhIFRhdGFzaGluIHdyb3RlOg0KPj4+IEluIHByZXBvcmF0aW9uIGZvciBk
eW5hbWljIGtlcm5lbCBzdGFja3MgZG8gbm90IHplcm8gdGhlIHdob2xlIHNwYW4gb2YNCj4+PiB0
aGUgc3RhY2ssIGJ1dCBpbnN0ZWFkIG9ubHkgdGhlIHBhZ2VzIHRoYXQgYXJlIHBhcnQgb2YgdGhl
IHZtX2FyZWEuDQo+Pj4NCj4+PiBUaGlzIGlzIGJlY2F1c2Ugd2l0aCBkeW5hbWljIHN0YWNrcyB3
ZSBtaWdodCBoYXZlIG9ubHkgcGFydGlhbGx5DQo+Pj4gcG9wdWxhdGVkIHN0YWNrcy4NCj4+Pg0K
Pj4+IFNpZ25lZC1vZmYtYnk6IFBhc2hhIFRhdGFzaGluIDxwYXNoYS50YXRhc2hpbkBzb2xlZW4u
Y29tPg0KPj4+IC0tLQ0KPj4+ICAgIGtlcm5lbC9mb3JrLmMgfCA2ICsrKystLQ0KPj4+ICAgIDEg
ZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+Pj4NCj4+PiBk
aWZmIC0tZ2l0IGEva2VybmVsL2ZvcmsuYyBiL2tlcm5lbC9mb3JrLmMNCj4+PiBpbmRleCA2YTJm
MmM4NWUwOWYuLjQxZTBiYWVlNzlkMiAxMDA2NDQNCj4+PiAtLS0gYS9rZXJuZWwvZm9yay5jDQo+
Pj4gKysrIGIva2VybmVsL2ZvcmsuYw0KPj4+IEBAIC0yNjMsOCArMjYzLDggQEAgc3RhdGljIGlu
dCBtZW1jZ19jaGFyZ2Vfa2VybmVsX3N0YWNrKHN0cnVjdCB2bV9zdHJ1Y3QgKnZtKQ0KPj4+ICAg
IHN0YXRpYyBpbnQgYWxsb2NfdGhyZWFkX3N0YWNrX25vZGUoc3RydWN0IHRhc2tfc3RydWN0ICp0
c2ssIGludCBub2RlKQ0KPj4+ICAgIHsNCj4+PiAgICAgICAgc3RydWN0IHZtX3N0cnVjdCAqdm1f
YXJlYTsNCj4+PiArICAgICBpbnQgaSwgaiwgbnJfcGFnZXM7DQo+Pj4gICAgICAgIHZvaWQgKnN0
YWNrOw0KPj4+IC0gICAgIGludCBpOw0KPj4+DQo+Pj4gICAgICAgIGZvciAoaSA9IDA7IGkgPCBO
Ul9DQUNIRURfU1RBQ0tTOyBpKyspIHsNCj4+PiAgICAgICAgICAgICAgICB2bV9hcmVhID0gdGhp
c19jcHVfeGNoZyhjYWNoZWRfc3RhY2tzW2ldLCBOVUxMKTsNCj4+PiBAQCAtMjgyLDcgKzI4Miw5
IEBAIHN0YXRpYyBpbnQgYWxsb2NfdGhyZWFkX3N0YWNrX25vZGUoc3RydWN0IHRhc2tfc3RydWN0
ICp0c2ssIGludCBub2RlKQ0KPj4+ICAgICAgICAgICAgICAgIHN0YWNrID0ga2FzYW5fcmVzZXRf
dGFnKHZtX2FyZWEtPmFkZHIpOw0KPj4+DQo+Pj4gICAgICAgICAgICAgICAgLyogQ2xlYXIgc3Rh
bGUgcG9pbnRlcnMgZnJvbSByZXVzZWQgc3RhY2suICovDQo+Pj4gLSAgICAgICAgICAgICBtZW1z
ZXQoc3RhY2ssIDAsIFRIUkVBRF9TSVpFKTsNCj4+PiArICAgICAgICAgICAgIG5yX3BhZ2VzID0g
dm1fYXJlYS0+bnJfcGFnZXM7DQo+Pj4gKyAgICAgICAgICAgICBmb3IgKGogPSAwOyBqIDwgbnJf
cGFnZXM7IGorKykNCj4+PiArICAgICAgICAgICAgICAgICAgICAgY2xlYXJfcGFnZShwYWdlX2Fk
ZHJlc3Modm1fYXJlYS0+cGFnZXNbal0pKTsNCj4+DQo+PiBDYW4ndCB0aGlzIGJlIG1lbXNldChz
dGFjaywgMCwgbnJfcGFnZXMqUEFHRV9TSVpFKSA/DQo+IA0KPiBObywgd2UgY2FuJ3QsIGJlY2F1
c2UgdGhlIHBhZ2VzIGNhbiBiZSBwaHlzaWNhbGx5IGRpc2NvbnRpZ3VvdXMuDQo+IA0KDQpCdXQg
dGhlIHBhZ2VzIHdlcmUgYWxyZWFkeSBwaHlzaWNhbGx5IGRpc2NvbnRpZ3VvdXMgYmVmb3JlIHlv
dXIgY2hhbmdlLCANCndoYXQncyB0aGUgZGlmZmVyZW5jZSA/DQoNCkl0IGRvZXNuJ3QgbWF0dGVy
IHRoYXQgdGhlIHBhZ2VzIGFyZSBwaHlzaWNhbGx5IGRpc2NvbnRpZ3VvdXMgYXMgZmFyIGFzIA0K
dGhleSBhcmUgdmlydHVhbGx5IGNvbnRpZ3VvdXMsIHdoaWNoIHNob3VsZCBzdGlsbCBiZSB0aGUg
Y2FzZSBoZXJlIGZvciBhIA0Kc3RhY2suDQoNCk5ldmVydGhlbGVzcywgZnJvbSBwb3dlcnBjIHBv
aW50IG9mIHZpZXcgSSdtIGhhcHB5IHdpdGggY2xlYXJfcGFnZSgpIA0Kd2hpY2ggaXMgbW9yZSBv
cHRpbWlzZWQgdGhhbiBtZW1zZXQoMCkNCg0KQ2hyaXN0b3BoZQ0K

