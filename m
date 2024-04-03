Return-Path: <linux-kernel+bounces-129382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EC88969E3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ABFF1C24A54
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909476EB7C;
	Wed,  3 Apr 2024 09:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b="QYzkP+9W"
Received: from PAUP264CU001.outbound.protection.outlook.com (mail-francecentralazon11021010.outbound.protection.outlook.com [52.101.167.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD2F56471
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 09:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.167.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712135038; cv=fail; b=P9ZWRvvsPknJaAVgQ1v3Z1ZBlWN2WDCKrVDxvV70kC5OnRktdlRzIf9KDyLiAFHcv5Ru/TcMnqZxwU2U5T5IyjU+0n43O4kZgCEk8N0pat7o47Agm+VcyLwHrj37/bW6cx1hvBjMvTNKY0kEgK5Y+ztJM/h6YeBSJm68C15oLbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712135038; c=relaxed/simple;
	bh=z97gaE+5M0SI9zFhPvSMJ6FJd5s3AQa2zaO4p5hmvFg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rbv6NJG/LsJPBmnBFRhIUblWA4sgUHffICdIudiH9pS6mNOQUFRe7LC4UQhBLiDZYDQbXydaeDid33Us2G/5wPJ64rtrERXkoc5rTg3t2eCoueU0P2tEhcUEkZuhxT2uP4pdopw4fvCd/8yY+f3GBjgzDFGTBub8gd4/IQQK5f0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b=QYzkP+9W; arc=fail smtp.client-ip=52.101.167.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jEL0QWchXCSVqVTWPJIGd7/Hv8uXz58sR5JGYKC9fgJuMDSIUFWUwvLdg0fc61MP3tk1hYsMOKeHGgz/a4rubICOnGSEdfj4G7bNuAl5eoOpwFQPlagO/psW64Q/f2XHlHup3xdBkej+P5ImVGLbht6n/i6ra/W39Q17ymqn1dm77ImOtvynPfnzqeAchTmgV7fAa16xjpmUbQJfGaLyEOKUVkU3Mu6tTyn4FTpxVhJiM988gJ8W0Ma+We45eAlAisyX/hDn9WcmD5PPD9JjV9/Jueto2U1dv8qw7qFWqLaGhubmhvKMFkhf81Yg7aVoGcSUnbW+y5hsPyTP32DQfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z97gaE+5M0SI9zFhPvSMJ6FJd5s3AQa2zaO4p5hmvFg=;
 b=Rnb/SEUDJKk9mETZ9rpHPS3uQlIXfdhZ5jkMN16xEnFvj/F2il8l0eAHOQGnN8fFR0VIyYy9Yq2zz5QbvURfA3DsciStjk+qNKbUeaPmC2ebH9xW/sGDduH+rCL+TGBYGStkYI2SGR/haj0bKEtO7yoFVVcIWk43YL/WMLAoMrpjUYUHo3MTUhs3fLrb11T9dNhWx8664UYo4wAbjLiE+HQoG46gU4QhIqtHe0cE5SIIZ2mZ5kGuIYm12ysEbkPcUkTKduPN2nv8cXCRzpbfpl/Qr++L8uUFWnNMRIFfso8SoXt0ZnwTa2H4AwVXrz8Br+bBt9DHT7r0BI4CU15j9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z97gaE+5M0SI9zFhPvSMJ6FJd5s3AQa2zaO4p5hmvFg=;
 b=QYzkP+9W06J8U/QiE4zc9xq6GZBuB/beIV5RO3Xyw4BS6LRvhgjZmxEat2sbxaaEgt5O8OPrNZyrhnMGAm4FVVyDYUvLFoIxnfJPJmtFBMIrLBANXNgsGeQUmW7Hfmx72srtWTxVzH1twO6EcRMDQLjy+TAS+6C6t9KZtBGgwfyMH+xPlJYineT/QjkaBF73FuJC1mBj84ZNWKZAI29K8ycAhXvmeVHFUIE9u8GUnhVGdQdocNo1r13kiK4eoiX5v7semDOK5aj9o58OJS2hkxrDtiMh6y2+ivY/knl2FFGvWmaxyezz8i04umohw5TuwG5uWlpfbH98a1g0O6O7GA==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB1652.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:10::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 09:03:54 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c192:d40f:1c33:1f4e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c192:d40f:1c33:1f4e%6]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 09:03:54 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, Palmer Dabbelt <palmer@rivosinc.com>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Noah Goldstein
	<goldstein.w.n@gmail.com>, Charlie Jenkins <charlie@rivosinc.com>
Subject: Re: [PATCH 18/34] lib: checksum: hide unused
 expected_csum_ipv6_magic[]
Thread-Topic: [PATCH 18/34] lib: checksum: hide unused
 expected_csum_ipv6_magic[]
Thread-Index: AQHahZ5g28C+LJsTYku4NOBSr1WvGrFWOkqAgAAEhwCAAAGkAA==
Date: Wed, 3 Apr 2024 09:03:54 +0000
Message-ID: <2ffc8633-6ed8-4641-bd9f-313645dfff51@csgroup.eu>
References: <20240403080702.3509288-1-arnd@kernel.org>
 <20240403080702.3509288-19-arnd@kernel.org>
 <66a1d5f1-d9b2-402c-826d-955370288037@csgroup.eu>
 <bdcabb75-f9a5-4905-90b4-2c9c2cf0588a@app.fastmail.com>
In-Reply-To: <bdcabb75-f9a5-4905-90b4-2c9c2cf0588a@app.fastmail.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MR1P264MB1652:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 khV7Ys30I+aOT9q82cRX/hfZaeSmo/cQVJxSCPZO3OQHc0Q54MZWtVJoHcQuyp4xMYVmmfl0nLXFvtQ0UtjE8XX5vd2EKkvmrf1CHt7n/EzqiwXHem47jwr/4n7y4rmxo5Fqwn+474I07PrVCEzdHMoykSA2V8wc555BkWgTEcs7/CkonMXarCP8d4LQJnwtJFMKSaToH3dl9K1o2otDpLz0uq1VSB6PJeFjM+IqXvwYOZIWGUl1FXjnLrfoSQHEoIItgAEVPoVGgtfTEFod4YfpqGAsftAhabZDHO51rXI2pbHJohoJ3gwajaLAGOh/9uwZ4kB+7Ntriieq0M6DKzzTnW6tr4NHz1o+V7Lm2CtPK8eI4NbB5fkz57EToMdxCfFUPFPgPWrq8sW0w8HFro99ExhjKlZirCcxK8s7R0MtKKiyxP8Vg5U9oeIA16JXO0O+XYCDA7DDui31FEkbLKdqHUIA7kzHZXrCPaGgLE9e5qIdvR9ZeT1togJ+g5QbVh6bmsvPw6Xk5trCcOwx/DKtvxWoDrTWUpJwR8bK/O96M0zMpAzn73pXjd0OwmXGwH/R4KzyCwQh2V94ICq540ZhjwguJpSDzBALZeEZqYo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S1pESldEWkQ0VUFoUTRqNE5ObmJzWDBQT1UvTzdLY0F3Wm5Na1RhMGpGWVJm?=
 =?utf-8?B?S1NBOGpoa0dnaEN1Q3o5R0ZBRTJzL0ZNeExHVW43dmpONlN4N3FiK1Y3eldS?=
 =?utf-8?B?dmlYaW5abEMxWUh0dzhBRk1zdnZNb1M3RnkzbGhxbWZ6WXNjUTAwU3Mrcjhx?=
 =?utf-8?B?eHEvd3RzTTFybERZMzV5WTBjVlQ4UnNueXlqQllvRzV1SU42TkdlVHRYcjBH?=
 =?utf-8?B?U1lMbzNkVERXMVBhelNSN09BL0xjYzFYSnJyMnAwM01nNVh2UHAvSU9CT05Q?=
 =?utf-8?B?V1poU0pQcXp0YklkTTM5TExlMUFvNENra2pwUStkWlN2TnF4UlFpOXlCZ3B1?=
 =?utf-8?B?RzcxandUd3ZGU2xnQ3lRL2tYQjNiU3NGQW82bHNoZzVVN05kMVdvUytBd0Er?=
 =?utf-8?B?ZU16ZHVwdXppZVVTd2hva2lGWUFsNnA4NlpLbVh4OFNtbFREUWJvVVIyck5j?=
 =?utf-8?B?SExlTERYTTNsVTY4ZHVnMC9LQnVZMTh5YnErYWFSK1NDTDQxS0M0bHFZSVRp?=
 =?utf-8?B?ckpRcTlVL1d4QU44cTdBTkRuYzUyWkNuOFNjMGZDVG1oVjg2TmhvOUhrTmUw?=
 =?utf-8?B?Qk5scEhkTHVrckZ3cjdaVkt1T0gzUUREakZHU1VBblVjNDVnR21jZGh4YUQ4?=
 =?utf-8?B?M2tuMFFjYndEMjdsenlJZVBxQThCbU9YV3M5VmNRSU0vVWRyZHpVUUxTeGRV?=
 =?utf-8?B?QytyRE95ZHZkSUVXT0poeExZcDNUa3Rkcmc4VzNOdS9vWWtaOWNTR3BzNy8v?=
 =?utf-8?B?QWJ6RG9YNmVFWmRCTW13RGt4eXg5ZFp4cVRjNDI2d0JCSFV0NTBkRTlPNVdz?=
 =?utf-8?B?clcxOWlaaTBkdDM4V1JyWEFHOGNFYUl5YjhMSGRTZzlCZFY2Myt5ME5hU01k?=
 =?utf-8?B?czNVdnE0WWVCaktPSmdiWFVGUUNSK3c4aEpZYzR3bWFYZHV6aDkrVUtsREdn?=
 =?utf-8?B?RVlXenErVjl5RC9GbVRBT09ZeERYWDU5NWswU2JHUnNKU3p4L0dDRmNQUXBK?=
 =?utf-8?B?L1VBLy9pdkJxbktTL1psb0NQYm5qeUE5cWNac2VnbkRxWEcrYjcxZ1ZIVVN0?=
 =?utf-8?B?cEFaTEoyZzc5OUJ3TWVjNGhBL3VYTGtvV284SzVhUFd6UjZwVzM1NFdxbDZz?=
 =?utf-8?B?R3lJWEtLeG10U0dYUFdvZUNTV0I3cHFSa0pFV0NFN3JCTlpMMnBVN1pkNFEv?=
 =?utf-8?B?UStFQjFsbHE5RGV6eTEweFZlT2hGN2lTREQzWjFhOEQ2QWxkUzd6UWVjTVZk?=
 =?utf-8?B?ZGNkWmI0QnN6ZGxZUjM1OGVCc2Y0bDVLakFDTjB3Ri9uYk9wYkFIVVlvWVEy?=
 =?utf-8?B?V1NtSmxRTjdjYzFNVlJjekxaekV2dG9kb3ZCMmY0ZjVKTG41QTMrNUp3Y0N3?=
 =?utf-8?B?SUxYRC81cGpBemkxMXBlZjVFZnRFQ0ZpNHdWUnpYcWRBOWNRemRLeXlIeVNE?=
 =?utf-8?B?c0gvdXplL0ZLV3VqSWdzNStPRjZJdkxWK3FKaHhKdStaS2tRWDN4bGZpNjV3?=
 =?utf-8?B?ZU11bWNxUUdLaDg1ZGlxcXYwWGhsaEhlYS9MT2xtb0NtbS90SHYweURJM1dV?=
 =?utf-8?B?YTRFTnVhVVcveEx4c05uaGtWUXBBVENEd1ZqOUthUHlrVkNkK0hIVXdVdW1n?=
 =?utf-8?B?OGdZSHBzQ3JRcWtLUXdPZ3lPZFBtWGQxdkZsUWFjTjRhVGpMSzR6OEwxd2Er?=
 =?utf-8?B?RS84QThPbHN3NWpTN0E5UC91K0pHMEFkclMzQjd3SG1LVDdzeU1haGJ3dEo3?=
 =?utf-8?B?ZGlHcksxanI4N0d0cEJDT3U2VVBxOWpHK3FzZ3ptczFKRUpmTUJjOEp5Ympm?=
 =?utf-8?B?ZXNXeG56M2RQalI4SEg0Zi9Ya3VXZFFzcHg1cUhFY2JOcFh5VjAzOHVLays3?=
 =?utf-8?B?MEM5eit1aVFOSUhpQVBUdWxqb2NrenJlY0JldzdRSkdaRGlkb0VmVy9QVUlQ?=
 =?utf-8?B?UGkrbFdXT3FIVDhJQVdESHVGQmxMeitxRWg1K1pwbHozMGNMME9NRXZlcUVv?=
 =?utf-8?B?bm00UjRhdEJWRkVCTEdPQWl4SHlzaE5MdVJ5MTBGbDNPcmRha2tiQUdPb2tm?=
 =?utf-8?B?Sm5pajhiMUJSTmMzalltdGxqVnhnT3hxVVhDdXJKZHFIRU5LaHc5RWJhZjR4?=
 =?utf-8?Q?tNl8XlIxQavO4vmI0mQY0UKPv?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <26F664066A817B4EA194BD71112C5A47@FRAP264.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b66a690c-df28-47ae-ed06-08dc53bcfce4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2024 09:03:54.1445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ip2m660plI+GfVkj40VJllBpG3t4zSHdGKzDnq6uj8pgXJiNijWEkK5QBgrAYf+acooqoFCZnmsxyQL4egH5EC1Yb/jWw2phtGzWbDF995U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB1652

DQoNCkxlIDAzLzA0LzIwMjQgw6AgMTA6NTgsIEFybmQgQmVyZ21hbm4gYSDDqWNyaXTCoDoNCj4g
T24gV2VkLCBBcHIgMywgMjAyNCwgYXQgMTA6NDEsIENocmlzdG9waGUgTGVyb3kgd3JvdGU6DQo+
PiBMZSAwMy8wNC8yMDI0IMOgIDEwOjA2LCBBcm5kIEJlcmdtYW5uIGEgw6ljcml0wqA6DQo+Pj4g
RnJvbTogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4NCj4+Pg0KPj4+IFdoZW4gQ09ORklH
X05FVCBpcyBkaXNhYmxlZCwgYW4gZXh0cmEgd2FybmluZyBzaG93cyB1cCBmb3IgdGhpcw0KPj4+
IHVudXNlZCB2YXJpYWJsZToNCj4+Pg0KPj4+IGxpYi9jaGVja3N1bV9rdW5pdC5jOjIxODoxODog
ZXJyb3I6ICdleHBlY3RlZF9jc3VtX2lwdjZfbWFnaWMnIGRlZmluZWQgYnV0IG5vdCB1c2VkIFst
V2Vycm9yPXVudXNlZC1jb25zdC12YXJpYWJsZT1dDQo+Pj4NCj4+PiBIaWRlIGl0IHVuZGVyIHRo
ZSBzYW1lICNpZmRlZiBhcyB0aGUgcmVmZXJlbmNlIHRvIGl0Lg0KPj4+DQo+Pj4gRml4ZXM6IGYy
NGE3MDEwNmRjMSAoImxpYjogY2hlY2tzdW06IEZpeCBidWlsZCB3aXRoIENPTkZJR19ORVQ9biIp
DQo+Pg0KPj4gSSB0aGluayB0aGF0IGNvbW1pdCBpbnRyb2R1Y2VkIHVuanVzdGlmaWVkICNpZmRl
ZiBpbiBhIEMgZmlsZS4NCj4gDQo+PiBSZWZlcg0KPj4gaHR0cHM6Ly9kb2NzLmtlcm5lbC5vcmcv
cHJvY2Vzcy9jb2Rpbmctc3R5bGUuaHRtbCNjb25kaXRpb25hbC1jb21waWxhdGlvbg0KPj4NCj4+
IFRoZSBmaXggc2hvdWxkIGJlOg0KPj4NCj4+ICsJaWYgKCFJU19FTkFCTEVEKENPTkZJR19ORVQp
KQ0KPj4gKwkJcmV0dXJuOw0KPj4gKw0KPj4gICAgCWZvciAoaW50IGkgPSAwOyBpIDwgTlVNX0lQ
djZfVEVTVFM7IGkrKykgew0KPj4gICAgCQlzYWRkciA9IChjb25zdCBzdHJ1Y3QgaW42X2FkZHIg
KikocmFuZG9tX2J1ZiArIGkpOw0KPj4gICAgCQlkYWRkciA9IChjb25zdCBzdHJ1Y3QgaW42X2Fk
ZHIgKikocmFuZG9tX2J1ZiArIGkgKw0KPj4gQEAgLTYxOCw3ICs2MjAsNiBAQCBzdGF0aWMgdm9p
ZCB0ZXN0X2NzdW1faXB2Nl9tYWdpYyhzdHJ1Y3Qga3VuaXQgKnRlc3QpDQo+PiAgICAJCUNIRUNL
X0VRKHRvX3N1bTE2KGV4cGVjdGVkX2NzdW1faXB2Nl9tYWdpY1tpXSksDQo+PiAgICAJCQkgY3N1
bV9pcHY2X21hZ2ljKHNhZGRyLCBkYWRkciwgbGVuLCBwcm90bywgY3N1bSkpOw0KPj4gICAgCX0N
Cj4+IC0jZW5kaWYgLyogIUNPTkZJR19ORVQgKi8NCj4gDQo+IFllcywgSSB1c3VhbGx5IHByZWZl
ciB0aGF0IGFwcHJvYWNoLCBhbmQgSSB0aGluayBJIHRyaWVkIGl0IGZpcnN0DQo+IGJ1dCByYW4g
aW50byBjb21waWxlLXRpbWUgcHJvYmxlbXMgYmVjYXVzZSBjc3VtX2lwdjZfbWFnaWMoKQ0KPiBp
cyBkZWNsYXJlZCBjb25kaXRpb25hbGx5LiBMZXQgbWUgdHJ5IGFnYWluLCBtYXliZSBJIG1pc3Jl
bWVtYmVyDQo+IHdoYXQgSSBkaWQgb3IgSSBjYW4gcmVtb3ZlIHNvbWUgbW9yZSAjaWZkZWYgY2hl
Y2tzIGZvciB0aGlzLg0KDQpGV0lXLCBiZWZvcmUgcmVwbHlpbmcgSSBkaWQgYSBidWlsZCBjaGVj
ayB3aXRoIHBtYWMzMl9kZWZjb25maWcgDQoocG93ZXJwYykgd2l0aCBDT05GSUdfTkVUIHJlbW92
ZWQuIEkgd2FzIGFibGUgdG8gYnVpbGQgDQpsaWIvY2hlY2tzdW1fa3VuaXQubyBhbmQgb2JqZHVt
cCBzaG93biB0aGVyZSB3YXMgbm8gcmVmZXJlbmNlIHRvIA0KY3N1bV9pcHY2X21hZ2ljKCkgaW5z
aWRlIGl0Lg0KDQpDaHJpc3RvcGhlDQo=

