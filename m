Return-Path: <linux-kernel+bounces-78000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52ADD860DE2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76FEC1C2172D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E435C61F;
	Fri, 23 Feb 2024 09:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b="F0jC/wSa"
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on2108.outbound.protection.outlook.com [40.107.9.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD701AAD8;
	Fri, 23 Feb 2024 09:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.9.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708680183; cv=fail; b=W7ZkBDDgnDg4nG7KEtxLOBI1myTMRzYNBI1jYseCpi5lATq/3VwyDVGKkkj0ds6QCJk/fZ9ACkWuKiQ3uOt3w2muHL7GhfEFwLI+jHCxxTe3bURVRgVUpruvtEs24zA9rcy53R9g7M90rWD8/X600MIARRaaF8VdNljWd09e/gM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708680183; c=relaxed/simple;
	bh=qd8df/Dol7PBemzqy1z+czyFuvygPy5QtPlk7ZdafZo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KaNG1rKULH/4h6yA3I7FfhNqZCFruJtuWmXsHSp5Aq17qpO3Th+FRNW3QQ9JM7sxksE8/FBY++VJDEw0iiSOxLWWwSyx32RZa0waW+W5AQFRRcdM+LJh6YB6ZgydwNnTmiG9Lc/EkWQ0g3MVg8/VDmLF94NpnY47YAHn/3kQm9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b=F0jC/wSa; arc=fail smtp.client-ip=40.107.9.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZmBmWGFdZuZmzrNSg9H0eJYAu/4q4REbqQVRnbEiKFzDPObdYTih6ND2JB8bOyK5zBZSgIfL0cbevbGHu4x8E6B3VyVXg+BH/veqF0ejCYZDkNDU8lQ07WnwamrCDSAFsSdAD8vgoCPwnMJBeRopidAnV0BmLF+NR6/Z39V4hqWocW5G0bhka3zsbu2p9WQhPuV//46ABx9OUmogb0BbD50qnz/0w5XGP9t4QBnNJfFtT20e373RQJ3oCj5zihuiKOR/Us+7UME1bSiLDEZ8vwatZUiMudtk+saAtN3iObahFC7jvV2ewiYlBAfXR4zhogbYO27QLxKHxM6sRKYQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qd8df/Dol7PBemzqy1z+czyFuvygPy5QtPlk7ZdafZo=;
 b=Td7VAkNVAUH99ObT80Q3YhxyYuF2LhbGHEb2gacGojJG11nyBncB4auhkjZ0tmtRJb6x3GTzhNsVvep3Eaeb4MJ8Nc1INI6qbRjbsc+6x5XS01weMHPUN56a+LfWtgrn8PYT/Lzz4DUvp1Itd/jp8Rsq7ew84sXGmdhqi9pU84Hn8QiuJhkzYOpruR96Y4lF5nHMq+6kks+WxRQ7X3hcmgWLxsw5krNmresnxIamzsce/EEDkF5p0QSc4Yi8+WItXVOPpeELSEgDybKS/8SXYUt7IoYGskTSTt536g56ugsFYsszY7pojlGHOkw5ZCsmS0MKRH7wbxKxekkOwjhn6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qd8df/Dol7PBemzqy1z+czyFuvygPy5QtPlk7ZdafZo=;
 b=F0jC/wSaJqgmEBX3to/9hA3+mBC9Npto0bKwL8nmhm7VSGdijXCduKHKINHSRvNANyMXe+y+9jdh13vfohIWUQj7ov0CUDWBbWxSm4/hCtCFFtp/p3YF6rM7bACctnccSUUWaWwjtbLUqq8iqKGdObG7VHl+Am+t7s+uB0EdFgLMU6KkM7AF9G6i8sJ6DAT9n4oTatqsJ0FBVAgFUwRVgAK2BIupmAJYhNpyA1HAMBjqcwK8raEfqzJa78SheAX4o0ktCB2ivs1lKrrlJGAwt/9sqDvTvmCp/WGnz71PAaIrHEp/Rs+qROTKA9OfEd9pRh7AEMIi95GCHmXKAAJPBA==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB2694.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1d1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 23 Feb
 2024 09:22:58 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::46af:917d:3bb2:167e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::46af:917d:3bb2:167e%6]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 09:22:58 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Michael Ellerman <mpe@ellerman.id.au>, Palmer Dabbelt
	<palmer@dabbelt.com>, Charlie Jenkins <charlie@rivosinc.com>
CC: "linux@roeck-us.net" <linux@roeck-us.net>, "David.Laight@aculab.com"
	<David.Laight@aculab.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "deller@gmx.de" <deller@gmx.de>,
	"James.Bottomley@hansenpartnership.com"
	<James.Bottomley@hansenpartnership.com>, "linux-parisc@vger.kernel.org"
	<linux-parisc@vger.kernel.org>, "viro@zeniv.linux.org.uk"
	<viro@zeniv.linux.org.uk>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lkp@intel.com" <lkp@intel.com>
Subject: Re: [PATCH v9 0/2] lib: checksum: Fix issues with checksum tests
Thread-Topic: [PATCH v9 0/2] lib: checksum: Fix issues with checksum tests
Thread-Index: AQHaZjnjUP8531kIPEeS0G1nNiUgSg==
Date: Fri, 23 Feb 2024 09:22:58 +0000
Message-ID: <2c0ed167-4566-4120-80fc-a2f40539c27b@csgroup.eu>
References: <mhng-7bd71679-7e7b-459d-8d6f-068a0ee090ba@palmer-ri-x1c9a>
 <87plwnabm1.fsf@mail.lhotse>
In-Reply-To: <87plwnabm1.fsf@mail.lhotse>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR0P264MB2694:EE_
x-ms-office365-filtering-correlation-id: 615d6947-b843-438c-1786-08dc3451069f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 CHhl9Q2iCVl6M9qB5et5ZJbqOboyybIIEZ+GD7J6k65vm1G6t64zqUkZmr0NmFZ1qjjUK+LAJM4031AMd+EM9XKKTY5S7vupOgF5xQPtFEvrxH6j32eOebruVcB/jJgj+glwBda+3onky1PmFimxMeBOxhZmqt0ABzxBLHNhCe7LARpctuOpWSqLYf/WPVtSrjEOpR50Ple+8twzvxZtgHDGmfk0gsyY7nhNhxJa2S+p2/ecK1GsibFgs3E3pQyQAnPEbWWnESxDMQpuPT8NouQxI3Al368C4UMgVYOTjFi15iAG4J6ySg1zd60ESkcbxHmIIdr5DzsEkKATOI+yCsxYVtS/9yWBEiFaLcWsIlMpW4zq9xCD1gqSYwQPW8AhRLmvTjLCX2UwtGeb3sMMZ8trdN/glMj93G392jYBq0oH8UMgjTCYVXOBNEj9yMb2k49WKZnZ3ImaYJWW2BJTkAizLgxnz4gjkfjz1pFvG2ogGIxulYy7x7TSKTyf8HH/qjndXJ/pIk/Q8wuoFJC3pkOz4qe4H95/PD5cZs7lWGRTpKExBcjRUc6BU2ySCYTkk6gAPQFSwW2dZuPdsY+LQh23JWdG4PKIU1+2UE0Lo4U=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VE1mZUxFZzNZVFMyQmVwNnVDYVRLUDU3SFlxN3p3UmYxNE1Ib1NPaE0vNis2?=
 =?utf-8?B?UitUcWFCWWIrR3lqUDdISjBIbmEwSzlyZnpDMkUzSFNQdlJwWHlTLzVML002?=
 =?utf-8?B?N3ExM2tLMWJSYlpablRuL245OExjaFpmNGxja0tkZFJWQThMVXQ5WUdId0R0?=
 =?utf-8?B?c2Voa3BuU2phNTFiK3p2MHNNL1hMblUzcUFVUmM0NytiNHpxQUZsNUd6ejMv?=
 =?utf-8?B?TTMyZGRZTjNESnMySDhtNmZ4blRSWk00eFQ1MHI5MzA1RlErS3hKUnVDQzNJ?=
 =?utf-8?B?MTQwUkc3am5GbG0yYllKQ0NxZUtHMnRaV09BMkdPdXFTVjNqTitoRzExVm93?=
 =?utf-8?B?bW5uUTU1bWxudWNMZnVTNVc1TFphZlRlWmV4c09mWWJIcm5UYzlxTzlwQnd4?=
 =?utf-8?B?cFVtcUlhSkI5Z0hFdkpBdEl3RDVzaUlzaVk1YlBaV0YxU3JpOE0wZnFhQTNV?=
 =?utf-8?B?ekxpWHVwRjZmWnBENXNiZytvRWxqMEM2cHU3OUhkdk5vNDRWZDk4aWlWWlVN?=
 =?utf-8?B?aE8rbm1XZ1oyVm1DR2RkelluQ2I2b1grSjVVSDZiT3prNzA0WUN1cTlkWmlR?=
 =?utf-8?B?Vm9ZVE56NmxUeExBeHNoc1VIL2plUFBYeTZSRHArWnpZUTVNeFRaOWp2OUc0?=
 =?utf-8?B?MzROaWZRVG0yRTl1dGU5MUdXanpET3R3cXVYa3B0eVdLTW5wT0lNVUVFRjVM?=
 =?utf-8?B?dm1iWE9XL0VsVzRLVzJ2eXc1Y2kraGEwNGpVSHFiRlJ2a2FiYTVMMnkxN29J?=
 =?utf-8?B?b25YcitVM3MyZks1bVhQQmNLOVNReHFwMmlvOG0zOUV6SFgreExTdzRVeGZ1?=
 =?utf-8?B?bjBMVG5BTys2T01PRDlBQUFSUjI1VHBpRDdlVUVSelRKbWhiRG5hMW4vNk5T?=
 =?utf-8?B?SWFMblFpZzBsNnMrQmZKMkdxdkFiRHFJb2lRM2JHZklCYWlDL25wOTJ5WUtX?=
 =?utf-8?B?VnMxM1h2YlVGZ01VN1hBaHZyUmd6alNmdlFIOFZ0QjJCT1ZmUWRZeEV3alVs?=
 =?utf-8?B?cUJ2RHdLbGhRdzRDT2dra1FabG5Hd0EzRGRuaEdLc1pyaXVZQktpd2I3eW1H?=
 =?utf-8?B?YVg2REZIZmtBWnlVSExjUXJ2Ykd1SDMrSGlzcE9PcUlreUFaVjhVdFFxN09S?=
 =?utf-8?B?RDM0bUxiTTRRbGd1OGVwd091b3E5UUlHZnlPaFU5eUd0UmV5YWJXZ0JXeXor?=
 =?utf-8?B?ZmM1TzVqWXFSbjFjNndGU3U2S1pnYXhJbDZqbEVuY3pGeDhFcGJWMi9kWkNv?=
 =?utf-8?B?MjRFZFQ5cWhFV2plM3FTUGJJL0t1eUpMYTVOb091ZDVGZml2c2RLQnVvc3JG?=
 =?utf-8?B?T1NmY0lRRWNnM2lLbUc2M2lrZ0FRN1pCNmlEQmovY1FicWZ0dGxLQWUyN29z?=
 =?utf-8?B?azlIOFdkUW91RS9MQ0NTMVl6alpjTzlYVTlZU2JidUZ5aGMzRjA3ZWJZaG1h?=
 =?utf-8?B?bklOUG5CN2IrMHhaWHJlL0Zkc3M2VVZsTlQyV1VtM1diSzdJUStmOXFGUUh4?=
 =?utf-8?B?cW9SUkZ3ci9sQkJ0TUR5VzNCaDE4UnhZSEd4eTFIQll3ZXBrOC9uNUQxcUVV?=
 =?utf-8?B?cDVGd3F6L1Z3aGVYRVZ4VXF2Q1NEM1FoTytQME9Rc0lEL0Y0Rjd6RDR2SHU3?=
 =?utf-8?B?aDNZZEhyN0kvb2NIcGRJc1ZyajlQRkFkMlhMMHJMUW1qS0ZRN2thdHQ2dmlu?=
 =?utf-8?B?RFVvYmlxZGF0QWltSUpyZVRnWFVLMnc2amN4VyttZmloMGVtUXA5Y3kyVVNh?=
 =?utf-8?B?bFBEUzBmMk5CM1lkcnB1bTY4MUxRK0FWVW1XOWRnYVhwekpJMlpzUFk2M0xj?=
 =?utf-8?B?anB6Y2UvdWx4NW5TUzdQZ3o0ek4zNHpHVXZ0cHh0V29ReTVBRHc3SkI1L0hm?=
 =?utf-8?B?RTBQZmw5M1hma3k4UlIrN09lWFRRZjJUQmYzYy9DWmcwVnVCcDVhb3ZIREJh?=
 =?utf-8?B?emsvQVRpVmtMOHBHVEdtNnF6Zy83ZTZxb1RyVjlFMUpvTUhlY3IzemM4TnNW?=
 =?utf-8?B?TEt1N1czaWNKVlQ3VGxsd0xxdHdQNWdoSEs4S1hjcG9iTnFNbEx1OWF1MjNz?=
 =?utf-8?B?MWZrem1FNDJzbFIyTkRFVm96K21hSWl3cCtnd2hGWWRKRWxXTGNoek43OURF?=
 =?utf-8?B?SmtYUmQ2T3RVY1Zod1Qwc2F1elRqeEVSSC9CTHM1QkFhSlBGUnFIYytXRHN5?=
 =?utf-8?B?Zmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5C7CEB5ED517E4479852B3F12884C735@FRAP264.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 615d6947-b843-438c-1786-08dc3451069f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2024 09:22:58.7289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D80c0/7V5o5hRM7tlOV+azN+DHVi9pMfO/CMnBOFkAhG26Voig6+PRiw4wogNa8LtToSc/X/S638hKzQEwmr7GOpkO3lwPPsdwvEC4LCxe4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2694

DQoNCkxlIDIzLzAyLzIwMjQgw6AgMDg6MjIsIE1pY2hhZWwgRWxsZXJtYW4gYSDDqWNyaXTCoDoN
Cj4gUGFsbWVyIERhYmJlbHQgPHBhbG1lckBkYWJiZWx0LmNvbT4gd3JpdGVzOg0KPj4gT24gV2Vk
LCAyMSBGZWIgMjAyNCAxODo1NTo0OCBQU1QgKC0wODAwKSwgQ2hhcmxpZSBKZW5raW5zIHdyb3Rl
Og0KPj4+IFRoZSBpcF9mYXN0X2NzdW0gYW5kIGNzdW1faXB2Nl9tYWdpYyB0ZXN0cyBkaWQgbm90
IHdvcmsgb24gYWxsDQo+Pj4gYXJjaGl0ZWN0dXJlcyBkdWUgdG8gZGlmZmVyZW5jZXMgaW4gZW5k
aWFubmVzcyBhbmQgbWlzYWxpZ25lZCBhY2Nlc3MNCj4+PiBzdXBwb3J0LiBGaXggdGhvc2UgaXNz
dWVzIGJ5IGNoYW5naW5nIGVuZGlhbm5lc3Mgb2YgZGF0YSBhbmQgYWxpZ25pbmcNCj4+PiB0aGUg
ZGF0YS4NCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IENoYXJsaWUgSmVua2lucyA8Y2hhcmxpZUBy
aXZvc2luYy5jb20+DQo+Pj4gLS0tDQo+Pj4gQ2hhbmdlcyBpbiB2OToNCj4+PiAtIFJldmVydCBi
YWNrIHRvIHY3LCB0aGUgY2hhbmdlcyB0byB2OCB3ZXJlIG5vdCBuZWVkZWQNCj4+PiAtIExpbmsg
dG8gdjg6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNDAyMTQtZml4X3NwYXJzZV9lcnJv
cnNfY2hlY2tzdW1fdGVzdHMtdjgtMC0zNmI2MGU2NzM1OTNAcml2b3NpbmMuY29tDQo+IC4uLg0K
Pj4+DQo+Pj4gLS0tDQo+Pj4gQ2hhcmxpZSBKZW5raW5zICgyKToNCj4+PiAgICAgICAgbGliOiBj
aGVja3N1bTogRml4IHR5cGUgY2FzdGluZyBpbiBjaGVja3N1bSBrdW5pdHMNCj4+PiAgICAgICAg
bGliOiBjaGVja3N1bTogVXNlIGFsaWduZWQgYWNjZXNzZXMgZm9yIGlwX2Zhc3RfY3N1bSBhbmQg
Y3N1bV9pcHY2X21hZ2ljIHRlc3RzDQo+Pj4NCj4+PiAgIGxpYi9jaGVja3N1bV9rdW5pdC5jIHwg
Mzk2ICsrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0K
Pj4+ICAgMSBmaWxlIGNoYW5nZWQsIDEzNiBpbnNlcnRpb25zKCspLCAyNjAgZGVsZXRpb25zKC0p
DQo+Pj4gLS0tDQo+Pj4gYmFzZS1jb21taXQ6IDY2MTM0NzZlMjI1ZTA5MGNjOWFhZDQ5YmU3ZmE1
MDRlMjkwZGQzM2QNCj4+PiBjaGFuZ2UtaWQ6IDIwMjQwMTE5LWZpeF9zcGFyc2VfZXJyb3JzX2No
ZWNrc3VtX3Rlc3RzLTI2Yjg2YjM0ZDc4NA0KPj4NCj4+IEkgcHV0IGENCj4+DQo+PiBBY2tlZC1i
eTogUGFsbWVyIERhYmJlbHQgPHBhbG1lckByaXZvc2luYy5jb20+DQo+Pg0KPj4gb24gdGhlIHY0
LCBidXQgbG9va3MgbGlrZSBpdCBnb3QgbG9zdC4gIEknbSBoYXBweSB0byB0YWtlIHRoaXMgdmlh
IHRoZQ0KPj4gUklTQy1WIHRyZWUsIGFzIHRoYXQncyBob3cgSSBtZXJnZWQgdGhlIGJyb2tlbiBw
YXRjaGVzIGluIHRoZSBmaXJzdA0KPj4gcGxhY2UsIGJ1dCBubyBiaWcgZGVhbCBpZiBzb21lb25l
IGVsc2Ugd2FudHMgdG8gcGljayBpdCB1cC4NCj4+DQo+PiBJdCBsb29rcyBsaWtlIHRoZSBpc3N1
ZXMgYXJlIGFsbCByZXNvbHZlZCBhbmQgc3VjaCwgYnV0IHRoZXJlJ3MgYmVlbiBhDQo+PiBsb25n
IHRhaWwgb2YgdGhlbSBzbyBJJ20gbm90IDEwMCUgc3VyZSBoZXJlLi4uDQo+IA0KPiBJIHRlc3Rl
ZCB2OSBvbiBwcGMzMi82NCBCRSwgYW5kIGl0IGZpeGVzIHRoZSB0ZXN0IGZhaWx1cmVzIGFuZCB0
aGUNCj4gc3BhcnNlIGVycm9ycywgc28gTEdUTS4NCj4gDQo+IFRlc3RlZC1ieTogTWljaGFlbCBF
bGxlcm1hbiA8bXBlQGVsbGVybWFuLmlkLmF1PiAocG93ZXJwYykNCg0KSXQgbWFnaWNhbGx5IHdv
cmtzLCBidXQgcGF0Y2ggMSBpcyB3cm9uZyBhbmQgcGF0Y2ggMiBzdWJqZWN0IGlzIA0KdW5yZWxh
dGVkIHRvIHRoZSBwcm9ibGVtIG9uIHBvd2VycGMuDQoNClRoaXMgZml4IHNlcmllcyBuZWVkcyBy
ZXdvcmsuDQoNCkNocmlzdG9waGUNCg==

