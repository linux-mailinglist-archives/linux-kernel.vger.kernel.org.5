Return-Path: <linux-kernel+bounces-101243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCDC87A48C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9C3B1F215F4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E4D1B965;
	Wed, 13 Mar 2024 09:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b="AcWKZMOm"
Received: from PR0P264CU014.outbound.protection.outlook.com (mail-francecentralazon11022018.outbound.protection.outlook.com [52.101.167.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DABE1B7F8
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 09:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.167.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710320676; cv=fail; b=HAMnINjFy2K/yMa6GfW/bXMkYRQ/o15cD+Ow8RVthKTgvNh5JCD16Mggsfd0+1YRqcHeXt1XwONYcPNP4lOF1kCsXa59aZ7kQ5NlZiCpv93e+L8WD1CT3fOB6lUYKzO8TR6NswyVZv8/vEmpIGwNnV55w1RZ70w+Y/vEvPMK0tE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710320676; c=relaxed/simple;
	bh=2zUzHN42c3XfKup010UCE2JwPvJJwD2dkCMmUdtE/lk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FpYQNaYk0P7t7lQ51Ep1QR7ypGepQNk7ydJ+UcCRYVC7FTSBeUwt1UYoDRNjvWaUQrL0cCeJXedbCrGDFAsP62/V36UJJKzl4B1w7SJg62Ekp/TU7YjLfVrSoMAOLEdtklR8biJk640kvs8oBHMSbIG5ngBT5JqvMWJcPCFyCTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b=AcWKZMOm; arc=fail smtp.client-ip=52.101.167.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gg5ism6mDPCGff0fk4ExyV1TfLz9PYtrWgTa2PRdzxnC1pUTiiUz5k4MRaaqF56E0IJsr2xUXpX7MwKp5jcMvkOo5kQwKtVA+/ZZJCoIkZg40zJDGrXlOpHKzovkb/7t7dHV3b9skh/FrWMUhtM6nLwSCmFjw+FdrIlI0c+RfLrStXikuiCEslQzZog8GuMFGH+K6wMmMjhfkecoRjJogmfcXexba450UOZQrvC9E5xuuB0Mw0w9QCFNWenG8XPdVoUTSWrfrYPRucD2mGTr3jolyRQoErT4F9ip85iXa/AB0ZUWAIh7PiMSSdWOU2YEtuSJ/CFLNQFkb/NpZT54pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2zUzHN42c3XfKup010UCE2JwPvJJwD2dkCMmUdtE/lk=;
 b=MjOeYi3BzSKkAK6vHTKJ0x13Hn0NYIZbEmiF5GtTyOCT4kzzCq4HAdzOC8ToJO12TYZu9/kWEGFE1R13gUk4ZvQSxRS0Nf5IpnrV3qLjU+cyXxMG4eU397JejatlmUwgjuobJupcvNzkWqGs2qbF+taS4ubj2kn8wE9gOB8hEvdYTyfHnLoESPv0YtQVOaHBGeuChrYAVE++C6MPQ437HGH1DRYQfcLx0dnJYUSfw6jkeqGxoLF9U1reHR6w0Co1iLpQyb79baIzZzLrHymiq23ieqrx0mZ1qmVYyftjxvtuW9vUktJAKhh0DMYjUy+jQItH8kQsO+onEdp4PkFknw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zUzHN42c3XfKup010UCE2JwPvJJwD2dkCMmUdtE/lk=;
 b=AcWKZMOmzRpIS+R5GcQykf2oqreo+jSj4sHUos9VLKXprhxPFcqa+6vM5N+07tHdMIgF2l+EfZ3u/iBJsWr6saOvG6HqXqICr+CkhvJMIJXibf92JFGmXzkm+ufMmrxsEKRiZt3TsWZtQTmxxxXAlwaTdDoH7POcv9qnq3k2XWIqFPhZmgw7fNm6ZpxDyDWa3evOLr3eCgLuhtn4NkG/x7WrfigsLoYANcepoiQnq+PZ9MvGYvc+tjSTyT7uNC4RfSrFsg1B/XkyU1WtL8xX0m50Wokg67jc6tGP3D8IwMAL8zBzJeg+zopejPZ0IlpRkV8aUsUyKDryvnALCkNMhA==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR1P264MB1565.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:193::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Wed, 13 Mar
 2024 09:04:28 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c192:d40f:1c33:1f4e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c192:d40f:1c33:1f4e%6]) with mapi id 15.20.7386.017; Wed, 13 Mar 2024
 09:04:26 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>, "Liam.Howlett@oracle.com"
	<Liam.Howlett@oracle.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "bp@alien8.de" <bp@alien8.de>,
	"broonie@kernel.org" <broonie@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "debug@rivosinc.com" <debug@rivosinc.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "keescook@chromium.org"
	<keescook@chromium.org>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>, "luto@kernel.org" <luto@kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"x86@kernel.org" <x86@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v3 10/12] x86/mm: Implement
 HAVE_ARCH_UNMAPPED_AREA_VMFLAGS
Thread-Topic: [PATCH v3 10/12] x86/mm: Implement
 HAVE_ARCH_UNMAPPED_AREA_VMFLAGS
Thread-Index: AQHadMy2BqEP9oP1AkqGttLi8fOuO7E1YUqA
Date: Wed, 13 Mar 2024 09:04:26 +0000
Message-ID: <887b3a3a-e4b6-4b0a-abea-bb47a593d9cc@csgroup.eu>
References: <20240312222843.2505560-1-rick.p.edgecombe@intel.com>
 <20240312222843.2505560-11-rick.p.edgecombe@intel.com>
In-Reply-To: <20240312222843.2505560-11-rick.p.edgecombe@intel.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR1P264MB1565:EE_
x-ms-office365-filtering-correlation-id: 262ee8a2-0619-48c0-1039-08dc433c95c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 RBQOH1lm0hfIh7+XgdQDYcWYJCBIGoWeIluJaaaSuBkeikjqlE/8BWxAO/q38lYzx4klQkVY+RpzijfDgcgE+thESrz2j8bEL7EkWZhkRpc651W+46JRwen3h3a5RcpqzgsIDQYZ9VZJv3lnHIH3Yt3Wn7ZH1IOrdsElkJgkkjGOPnetKK6INZwyoJTzmkaKcw1J8kkcqZXWyO1V95K1ETs5Jd2MdfSm/tFCW1EQNE6r//SPSEfW8pgw0opGzfRIFI7UzlMu+nwwJNAb+HxjLLrW3QSCv5frzARPOyDDnE69urLqY7FkQzJKQ4RZBx+ZGfDy1ZHYNkOfIjT/bjsSzlT/wstK7+4bk9Ph0swW5r77EtLfGbNMU0l79655BAwpL1hCt0G0gWjMcIu+XCEliNbkOLMISPfj7qa8fB7bL1O4k2JCDLTyljHUlllSCXfisO9nKOFLztRYbRD7NfB/Oqt1SGawAxw7wY6wd0wKOz5La1t9r0ozXv67FPPwCsho9OrdJSrQx3TBbpdNIuzrdlDB2OGcQ1OpL5Vk2F/yhcYstoO9tZ6dkROUzp61bnqv42gbv3xX3M44H136rx+DKOJ82vujKXNaMLOgtw/3dS/b7uW5cS4wMPYj0w9uaeO297DFOBIb4wS/Bnqv8/ZA/WTpzodeGpQnLv34N2l6UxQh0g7AYlmy/mTs8gXcRaOoIvH8ucZAyy2uDiQENxkCEAG5dTUB3/QOYUBJv4GPVJ4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(38070700009)(921011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dXpSc2wzeEpESXR1b0lUeVUxR2k0VnBHUHFuMjI3bldISFA3TTdUN3g5bDNU?=
 =?utf-8?B?M3NZTkFMUURqQkZMRlRGZEhSMEpFZDJENVN4dlVkeHBtem1pS3FRbjd1bklv?=
 =?utf-8?B?d2Z0N1M3OXpxSkRSOWNGU0p6Wkk1eWl2MWNHeE5vZ29yR3JzcWk1VGFNQ0tq?=
 =?utf-8?B?bG5zM3JjWGlHQnNhQklsZ3Axbi9hNVFHMDd6aVg1VjVTZElOZHp1Tlp2UThB?=
 =?utf-8?B?TEExNkkwVmxRMjE1bVZoaVJrdXVxc3VsVnFFM3hvUjNSdml1dXpTOXNWNjFo?=
 =?utf-8?B?V3hxN1A0aVZmUDE5eS94bHN5Qmp1ek5xblQ2K0YyZC9CdDExQXErVC9VQnkw?=
 =?utf-8?B?WjNRTkM2eUdSNUFyUVU5dUJWQlQyemhOQmI3SFZaMXJ4bTJMODNnQ2krQ3Nv?=
 =?utf-8?B?UE1Fay9NN3NBNE5rS3lNKytvSkIzZkxyNDJIZmFwV0pJS09WV0dmdWxBNm1K?=
 =?utf-8?B?NnovcG1VRGV2OHkrN0NDNDZ4RFh1Q3RabnJtZU5YTnZmSWNHSXhUN1VpZnIr?=
 =?utf-8?B?NVU3TTN0NnEvd3BrQ2dGODY5VWJvTzVSUHViR1BhQ1NVc2Z3N2w4bG5kdllh?=
 =?utf-8?B?a0tNNHUrOVQzTjIxazQ2VDB6VGJYY1Z1aGZDK2YyR05GSklhWjFQM1VWb1Zh?=
 =?utf-8?B?d05oWGl3UUk5U0VjMVdOVXl2T3c4T1VLbWNaSSsxK1hsQkZVSHBIelNYRWd1?=
 =?utf-8?B?M2dVUWh4R3hqT3JrMUpJcmVEMk1PSC9GeDc4VjdRejdCbmRDKzF4dUxaN2U5?=
 =?utf-8?B?TFE1NE5LSlZXWHkyNzkwenB1dEd0czIwaEZGNXhndW4yNU5mMHpyR3RwWWt5?=
 =?utf-8?B?aWxscTlvTlByZHIwOTdzekZscGprNmllSDhsTUpBd0VoZ1pLWlkwR1F3djdN?=
 =?utf-8?B?M3JNRXdhR2Jsc1htbTYrd1pUUlFhU1cwYnpCQURGaWgrQXlzRW9XZjU4c25M?=
 =?utf-8?B?MG4vY3doa0EyR3pVdWp2USt4V1MxbEtFeG5Yd1QxSFNzNkNXRnNJQktMVDht?=
 =?utf-8?B?MmFCK2duWm16d2FLbVRmaDRSZWw3eUFUOWN2aHRib1BMaW9HUkhuVEFMazJU?=
 =?utf-8?B?aXhQSFVhdENNMElGMmhMcFZxNGlzRW8rNzBLTzJMV2sySDFsMm5aVnE3Znc4?=
 =?utf-8?B?WnZ5YmNNT0ptV0g5MHMydHM4aGkrNkdNWTBLVTBBNW9aRFNzYkowZ0tBYldu?=
 =?utf-8?B?QVFRaXVyYXA0RThXUFkzZHpSaTZYQ3FER01OMERzYm0vdWxKMGI3eVRscEFY?=
 =?utf-8?B?NDUzdG1JejlxZjBvWXVLU0lYbitUbGU5SC9pT1lQOUVHdUVWRGRGb2czMDJW?=
 =?utf-8?B?bXRLdnZjbUY5QUVjeVB6cmFPNXRMT3hXWHFjVDhmSWFlOG9wMEIvbVpaMEho?=
 =?utf-8?B?WkdmYSthb1A2eE53NS9LWFd4endQbm1RL3JFWjVRVjRQc0VTVkF0UjhsNGpD?=
 =?utf-8?B?R1pXeVpsUjlpSXcvZFQ1VUkyM3VSbFZkUUNzOHBsanhoTXkxN2c4OGxjR21q?=
 =?utf-8?B?ait3UXRDbUJBSjVCOEF2NG41SVBhVVFrbkNCV0h6aFFOZ01XYTduUVloVjZ1?=
 =?utf-8?B?WDBDYys2cWFPdGhRQWpuRnVuWGhZZ3RXajlOS3Z3OW1DSUtOMy9VRjcvbGN1?=
 =?utf-8?B?c2paczRYeWlwWE9rL21UK3VHcTZyRHhpN0xuZ0JQaXlvR0NxRVVWZDBOQlow?=
 =?utf-8?B?SitCTVN6cFI3ZFozZXg2UWtZMU1mUWs0Q1A1eEthYnl0cmVWa2tUYmp4THVh?=
 =?utf-8?B?TE0xRFp0b3ZFbVU5REt5VnJpOVE3M291dGJXY21zem1zeXVhRTFqNWdlTm81?=
 =?utf-8?B?T0cwYUFPRlV0S1VLWnV2V1BFNk9id1Y4TkFLS0Uwc0g2WEZuN2dzWnVNZnNh?=
 =?utf-8?B?YWp6T21VK2F3VHkxZmJQeC9oK1JiTldENTd1VEM3S1hXelpBYk5KRmJlY2VF?=
 =?utf-8?B?UDRuNlRHTUtVeEZWWW9qUkNOcS9SZHlUNlJ5WGtSOS8vemQ3dDN2Q0xna3By?=
 =?utf-8?B?blpyejBqbmc5eEZSTHZycmo5R2JiZ2NkMWczUW9WaWRma2NpNnk0Lzg5Tk5i?=
 =?utf-8?B?eWlnTFFnazMvMklubDVTTi9Kb3NIYkdqM29zdU9rOG5UcllnbFBzcTMxSWVJ?=
 =?utf-8?Q?sXNvEz9erVYLNMoDqwG5PM8eY?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D92DBBAEF3A8EB4F8A3E4C8953F52903@FRAP264.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 262ee8a2-0619-48c0-1039-08dc433c95c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2024 09:04:26.9089
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RRClAhHHVjhp6Qj2fawk0T23PAM0WynTlZ6PFKUSr9Ti6Hw6V3Iv8zCfN6s2GyVI3x31Fu65/GMtScXAf2z7YhaH2FfC0pf7MHG8DP7Gfxk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB1565

DQoNCkxlIDEyLzAzLzIwMjQgw6AgMjM6MjgsIFJpY2sgRWRnZWNvbWJlIGEgw6ljcml0wqA6DQo+
IFdoZW4gbWVtb3J5IGlzIGJlaW5nIHBsYWNlZCwgbW1hcCgpIHdpbGwgdGFrZSBjYXJlIHRvIHJl
c3BlY3QgdGhlIGd1YXJkDQo+IGdhcHMgb2YgY2VydGFpbiB0eXBlcyBvZiBtZW1vcnkgKFZNX1NI
QURPV1NUQUNLLCBWTV9HUk9XU1VQIGFuZA0KPiBWTV9HUk9XU0RPV04pLiBJbiBvcmRlciB0byBl
bnN1cmUgZ3VhcmQgZ2FwcyBiZXR3ZWVuIG1hcHBpbmdzLCBtbWFwKCkNCj4gbmVlZHMgdG8gY29u
c2lkZXIgdHdvIHRoaW5nczoNCj4gICAxLiBUaGF0IHRoZSBuZXcgbWFwcGluZyBpc27igJl0IHBs
YWNlZCBpbiBhbiBhbnkgZXhpc3RpbmcgbWFwcGluZ3MgZ3VhcmQNCj4gICAgICBnYXBzLg0KPiAg
IDIuIFRoYXQgdGhlIG5ldyBtYXBwaW5nIGlzbuKAmXQgcGxhY2VkIHN1Y2ggdGhhdCBhbnkgZXhp
c3RpbmcgbWFwcGluZ3MNCj4gICAgICBhcmUgbm90IGluICppdHMqIGd1YXJkIGdhcHMuDQo+IA0K
PiBUaGUgbG9uZyBzdGFuZGluZyBiZWhhdmlvciBvZiBtbWFwKCkgaXMgdG8gZW5zdXJlIDEsIGJ1
dCBub3QgdGFrZSBhbnkgY2FyZQ0KPiBhcm91bmQgMi4gU28gZm9yIGV4YW1wbGUsIGlmIHRoZXJl
IGlzIGEgUEFHRV9TSVpFIGZyZWUgYXJlYSwgYW5kIGENCj4gbW1hcCgpIHdpdGggYSBQQUdFX1NJ
WkUgc2l6ZSwgYW5kIGEgdHlwZSB0aGF0IGhhcyBhIGd1YXJkIGdhcCBpcyBiZWluZw0KPiBwbGFj
ZWQsIG1tYXAoKSBtYXkgcGxhY2UgdGhlIHNoYWRvdyBzdGFjayBpbiB0aGUgUEFHRV9TSVpFIGZy
ZWUgYXJlYS4gVGhlbg0KPiB0aGUgbWFwcGluZyB0aGF0IGlzIHN1cHBvc2VkIHRvIGhhdmUgYSBn
dWFyZCBnYXAgd2lsbCBub3QgaGF2ZSBhIGdhcCB0bw0KPiB0aGUgYWRqYWNlbnQgVk1BLg0KPiAN
Cj4gQWRkIHg4NiBhcmNoIGltcGxlbWVudGF0aW9ucyBvZiBhcmNoX2dldF91bm1hcHBlZF9hcmVh
X3ZtZmxhZ3MvX3RvcGRvd24oKQ0KPiBzbyBmdXR1cmUgY2hhbmdlcyBjYW4gYWxsb3cgdGhlIGd1
YXJkIGdhcCBvZiB0eXBlIG9mIHZtYSBiZWluZyBwbGFjZWQgdG8NCj4gYmUgdGFrZW4gaW50byBh
Y2NvdW50LiBUaGlzIHdpbGwgYmUgdXNlZCBmb3Igc2hhZG93IHN0YWNrIG1lbW9yeS4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IFJpY2sgRWRnZWNvbWJlIDxyaWNrLnAuZWRnZWNvbWJlQGludGVsLmNv
bT4NCj4gLS0tDQo+IHYzOg0KPiAgIC0gQ29tbWl0IGxvZyBncmFtbWFyDQo+IA0KPiB2MjoNCj4g
ICAtIFJlbW92ZSB1bm5lY2Vzc2FyeSBhZGRlZCBleHRlcm4NCj4gLS0tDQo+ICAgYXJjaC94ODYv
aW5jbHVkZS9hc20vcGd0YWJsZV82NC5oIHwgIDEgKw0KPiAgIGFyY2gveDg2L2tlcm5lbC9zeXNf
eDg2XzY0LmMgICAgICB8IDI1ICsrKysrKysrKysrKysrKysrKysrLS0tLS0NCj4gICAyIGZpbGVz
IGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vcGd0YWJsZV82NC5oIGIvYXJjaC94ODYvaW5jbHVk
ZS9hc20vcGd0YWJsZV82NC5oDQo+IGluZGV4IDI0YWYyNWIxNTUxYS4uMTNkY2FmNDM2ZWZkIDEw
MDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9wZ3RhYmxlXzY0LmgNCj4gKysrIGIv
YXJjaC94ODYvaW5jbHVkZS9hc20vcGd0YWJsZV82NC5oDQo+IEBAIC0yNDQsNiArMjQ0LDcgQEAg
ZXh0ZXJuIHZvaWQgY2xlYW51cF9oaWdobWFwKHZvaWQpOw0KPiAgIA0KPiAgICNkZWZpbmUgSEFW
RV9BUkNIX1VOTUFQUEVEX0FSRUENCj4gICAjZGVmaW5lIEhBVkVfQVJDSF9VTk1BUFBFRF9BUkVB
X1RPUERPV04NCj4gKyNkZWZpbmUgSEFWRV9BUkNIX1VOTUFQUEVEX0FSRUFfVk1GTEFHUw0KPiAg
IA0KPiAgICNkZWZpbmUgUEFHRV9BR1AgICAgUEFHRV9LRVJORUxfTk9DQUNIRQ0KPiAgICNkZWZp
bmUgSEFWRV9QQUdFX0FHUCAxDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvc3lzX3g4
Nl82NC5jIGIvYXJjaC94ODYva2VybmVsL3N5c194ODZfNjQuYw0KPiBpbmRleCBiMzI3OGU0Zjdl
NTkuLmQ2ZmJjNGRkMDhlZiAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYva2VybmVsL3N5c194ODZf
NjQuYw0KPiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvc3lzX3g4Nl82NC5jDQo+IEBAIC0xMjAsOCAr
MTIwLDggQEAgc3RhdGljIHZvaWQgZmluZF9zdGFydF9lbmQodW5zaWduZWQgbG9uZyBhZGRyLCB1
bnNpZ25lZCBsb25nIGZsYWdzLA0KPiAgIH0NCj4gICANCj4gICB1bnNpZ25lZCBsb25nDQo+IC1h
cmNoX2dldF91bm1hcHBlZF9hcmVhKHN0cnVjdCBmaWxlICpmaWxwLCB1bnNpZ25lZCBsb25nIGFk
ZHIsDQo+IC0JCXVuc2lnbmVkIGxvbmcgbGVuLCB1bnNpZ25lZCBsb25nIHBnb2ZmLCB1bnNpZ25l
ZCBsb25nIGZsYWdzKQ0KPiArYXJjaF9nZXRfdW5tYXBwZWRfYXJlYV92bWZsYWdzKHN0cnVjdCBm
aWxlICpmaWxwLCB1bnNpZ25lZCBsb25nIGFkZHIsIHVuc2lnbmVkIGxvbmcgbGVuLA0KPiArCQkg
ICAgICAgdW5zaWduZWQgbG9uZyBwZ29mZiwgdW5zaWduZWQgbG9uZyBmbGFncywgdm1fZmxhZ3Nf
dCB2bV9mbGFncykNCj4gICB7DQo+ICAgCXN0cnVjdCBtbV9zdHJ1Y3QgKm1tID0gY3VycmVudC0+
bW07DQo+ICAgCXN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hOw0KPiBAQCAtMTU2LDkgKzE1Niw5
IEBAIGFyY2hfZ2V0X3VubWFwcGVkX2FyZWEoc3RydWN0IGZpbGUgKmZpbHAsIHVuc2lnbmVkIGxv
bmcgYWRkciwNCj4gICB9DQo+ICAgDQo+ICAgdW5zaWduZWQgbG9uZw0KPiAtYXJjaF9nZXRfdW5t
YXBwZWRfYXJlYV90b3Bkb3duKHN0cnVjdCBmaWxlICpmaWxwLCBjb25zdCB1bnNpZ25lZCBsb25n
IGFkZHIwLA0KPiAtCQkJICBjb25zdCB1bnNpZ25lZCBsb25nIGxlbiwgY29uc3QgdW5zaWduZWQg
bG9uZyBwZ29mZiwNCj4gLQkJCSAgY29uc3QgdW5zaWduZWQgbG9uZyBmbGFncykNCj4gK2FyY2hf
Z2V0X3VubWFwcGVkX2FyZWFfdG9wZG93bl92bWZsYWdzKHN0cnVjdCBmaWxlICpmaWxwLCB1bnNp
Z25lZCBsb25nIGFkZHIwLA0KPiArCQkJICB1bnNpZ25lZCBsb25nIGxlbiwgdW5zaWduZWQgbG9u
ZyBwZ29mZiwNCj4gKwkJCSAgdW5zaWduZWQgbG9uZyBmbGFncywgdm1fZmxhZ3NfdCB2bV9mbGFn
cykNCj4gICB7DQo+ICAgCXN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hOw0KPiAgIAlzdHJ1Y3Qg
bW1fc3RydWN0ICptbSA9IGN1cnJlbnQtPm1tOw0KPiBAQCAtMjI3LDMgKzIyNywxOCBAQCBhcmNo
X2dldF91bm1hcHBlZF9hcmVhX3RvcGRvd24oc3RydWN0IGZpbGUgKmZpbHAsIGNvbnN0IHVuc2ln
bmVkIGxvbmcgYWRkcjAsDQo+ICAgCSAqLw0KPiAgIAlyZXR1cm4gYXJjaF9nZXRfdW5tYXBwZWRf
YXJlYShmaWxwLCBhZGRyMCwgbGVuLCBwZ29mZiwgZmxhZ3MpOw0KPiAgIH0NCj4gKw0KPiArdW5z
aWduZWQgbG9uZw0KPiArYXJjaF9nZXRfdW5tYXBwZWRfYXJlYShzdHJ1Y3QgZmlsZSAqZmlscCwg
dW5zaWduZWQgbG9uZyBhZGRyLA0KPiArCQl1bnNpZ25lZCBsb25nIGxlbiwgdW5zaWduZWQgbG9u
ZyBwZ29mZiwgdW5zaWduZWQgbG9uZyBmbGFncykNCj4gK3sNCj4gKwlyZXR1cm4gYXJjaF9nZXRf
dW5tYXBwZWRfYXJlYV92bWZsYWdzKGZpbHAsIGFkZHIsIGxlbiwgcGdvZmYsIGZsYWdzLCAwKTsN
Cj4gK30NCj4gKw0KPiArdW5zaWduZWQgbG9uZw0KPiArYXJjaF9nZXRfdW5tYXBwZWRfYXJlYV90
b3Bkb3duKHN0cnVjdCBmaWxlICpmaWxwLCBjb25zdCB1bnNpZ25lZCBsb25nIGFkZHIsDQo+ICsJ
CQkgIGNvbnN0IHVuc2lnbmVkIGxvbmcgbGVuLCBjb25zdCB1bnNpZ25lZCBsb25nIHBnb2ZmLA0K
PiArCQkJICBjb25zdCB1bnNpZ25lZCBsb25nIGZsYWdzKQ0KPiArew0KPiArCXJldHVybiBhcmNo
X2dldF91bm1hcHBlZF9hcmVhX3RvcGRvd25fdm1mbGFncyhmaWxwLCBhZGRyLCBsZW4sIHBnb2Zm
LCBmbGFncywgMCk7DQo+ICt9DQoNCldvdWxkbid0IGl0IGJlIGJldHRlciB0byBkZWZpbmUgdGhv
c2UgdHdvIGFzIHN0YXRpYyBpbmxpbmVzID8NCg0K

