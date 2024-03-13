Return-Path: <linux-kernel+bounces-101253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE84C87A49B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EDDEB220DE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1E039AF5;
	Wed, 13 Mar 2024 09:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b="Mf+ZcfP6"
Received: from PA5P264CU001.outbound.protection.outlook.com (mail-francecentralazon11020003.outbound.protection.outlook.com [52.101.167.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0D537168;
	Wed, 13 Mar 2024 09:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.167.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710320691; cv=fail; b=qchNAkNgG40OPrxXou3qKEjQPVuSnbz68zOI/ZokxQJpp7QbyXmA3pO0te7B4kQDsi2MJuJeovJHTvjsq021+QXW1PCeiT00d7amTmlIUsdVinI9gT0pNdaumX7QVzs7v+jS76ndMYclQqq6VKIoL5bKS4dxqnLxL6Oe4I44R70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710320691; c=relaxed/simple;
	bh=nhf6swsgp3xmxBLC27AFoneRC78+tb6nRgbwT36cpmk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KQRfflncEQkfkaa7HdG0T1Zk17QS0huX7z9RF0ZoChZfC0Au8muSQwMyfAtnUKyLz817xfRn5cdLGBYubDXX6GNghsZcVL1nF41dyldEv7sXcq0zOnQSi+4Sxpx/EF/+X94nvvVjiuEB+YsZTMjIP2d3wZto0IlSA+ZizGr+b+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b=Mf+ZcfP6; arc=fail smtp.client-ip=52.101.167.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oaNzI6KVpQfWGk8/wAZPF//umn/uTB8ruRm8ae/6nkkIWrwZfvDp7kxtdNzYXRXIwbqzOrVlkG6lH67B+TcOWpo4VvkG1fUL3xVUEUmhhIgvWStaijm+WbmTxiAaVpENv++EEpWMupJRbZALuZOXWKoohdK8QhfjUJsU1FhStLqSwxCUXDIfMqxZTPh76WcYsssG+Dfq8C5ED0Aj9QkgsUT9Tg9GVhfA8c2cfFsqPzsS8P0hLWfLrY8gGJZhmMgWWnN5SSu4hEFhwHUmG6zOaCv48sUcjQKLukDwk+PFe6TaL7ZlmhJnkqlqt8aRA1G2AofKryGzXd4y9ruYSCIDlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nhf6swsgp3xmxBLC27AFoneRC78+tb6nRgbwT36cpmk=;
 b=Ql16oMyfojydEHzvtKvUx374T7o+1gqpUkvnQIomUjbJRCZG9jY+yivKy3+NbkcPKGfwUBU0n6n9l771Vjp/WYgkPBli3+7mKRHf4DvmJzF3lewxyWw/4EuU01cE3NkuUwiw4seUcrm+EI+pWxuYDGOSNtknYptRb/b4AjnAl8iM7BCWxSQRoGvJNPgegEgNYPuzTRsnSvkbMuOoW1ZwErzhfcVWjhp8lDBcHms8xWvsAiRwBUQFHV/9vRBo4XniE/3KSchd3dj+HZ4KuRaE0L9qY3ET0bDhlESByPeYN3DB7qaiwUqZISmBzagFvJ3/oAmRGWH3zKE6L1PSLEUqsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhf6swsgp3xmxBLC27AFoneRC78+tb6nRgbwT36cpmk=;
 b=Mf+ZcfP6UGWVFj4RQ8bUEMRAuNOYtwZAcskCpPjtnUSNQWjtg/rxOMbLQraTs12hUsSU08dZvnvRKVjarqxuHl3Zt8sJAvI4r6En5HckkdgHt9LVqK0I4VFpHiBv16zv9vX7nKx/yqprNaI4M03p+pze0ZfdUsGXyLSUFu9f+1vyvLSefxUzWxYpq1fc2n4fsUzaFWNxSwfM+1BPdgYuIwSWY/8RqJqmbEO1VadLgD6+i22gSgdTToPPA8GPGQaYbM2ovLft2EWDSjPk1VcUhx7IHaTnZklpzLRAid5vu+sNBbKVsg7P7uNevQ7M3fYxdR7YDkVdMRPoDlbhjQBcrg==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PAZP264MB2527.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19; Wed, 13 Mar
 2024 09:04:48 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c192:d40f:1c33:1f4e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c192:d40f:1c33:1f4e%6]) with mapi id 15.20.7386.017; Wed, 13 Mar 2024
 09:04:48 +0000
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
	"linux-mm@kvack.org" <linux-mm@kvack.org>, Guo Ren <guoren@kernel.org>,
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>
Subject: Re: [PATCH v3 05/12] csky: Use initializer for struct
 vm_unmapped_area_info
Thread-Topic: [PATCH v3 05/12] csky: Use initializer for struct
 vm_unmapped_area_info
Thread-Index: AQHadMzPndIF4OHzK0qrxtm0ND0p5rE1YWMA
Date: Wed, 13 Mar 2024 09:04:48 +0000
Message-ID: <06593c84-2fdb-4921-8d54-dabe13fa2227@csgroup.eu>
References: <20240312222843.2505560-1-rick.p.edgecombe@intel.com>
 <20240312222843.2505560-6-rick.p.edgecombe@intel.com>
In-Reply-To: <20240312222843.2505560-6-rick.p.edgecombe@intel.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PAZP264MB2527:EE_
x-ms-office365-filtering-correlation-id: 49be8004-6fad-4559-52ba-08dc433ca2c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 yOsfFqhLgSHJXPHk3ATCHl6lAeRxIyQ54gHLGQ1b4eE80rEjOXp1Vt4hZSp/v/ZRv1L3O5nZqBa30MfCB3K0Aox3BJBZWR9Afl5cXAGak8Avj6AYz3ic2ugKpRXZVC1aG1iYRe9q0gdybApdn9dW6cysP+e08S/nvxx+h3bfHhuexbD2qb6UxHDeEe4FxjOtdKvVTMstBJs2OLXesk0oj16oTJvbBsozOVtpajNB36haEf8/0UefW8pvwJIZNFW3E1Iu3oQWQUzqt51/28FtMAoS0CdL7Y0eE6IgOrOt5/lXFTqbcitYV2zM9K8uorqJomCWaqzvxshAKVd9kqNcwdq5uo5o54esXz8lxgiRMQlzNWhe/HYnZE3XJ7lbAR2H+OJi/feC6M6bCv0f2qEEZsBB+3IbHyFXJ0M9okddrRllj51ClTg8WOYcZtrEJkBWABV8GMrOblqiGI7FHrwkbtVF1JUwhgPnmlUohqerelk6G0eRrl+W4XSq21Uf2UOBbqF7t+9hSuNDqjOQB/mPJZ4+Egrw/rnDZsXf1DVtAFPH/QHO3NYBhiIbvCL/ePJi2fwdXcXyZTrqf4cJiwgcsIcUVrXRoT3XDjw0vjVf8cC4t0QO6XBNtz1X62jwuTTASmRDLCbw2esG2HIRI+q3dpL4ctqA1VBSVguHXSle4fpHShLb720PX6JR5wIwuWhz
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(921011)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S3dYdm9IV3V0OXV0M3JNT0dXejhPWGlINll0WlhpbUoyZWRQa3VKMm1nclVk?=
 =?utf-8?B?OEl5OTN2aW9TZ3dhcFA1WWlSZ2VjSk4rQTZkcnZjMUxOaUFoMFZaQytrMlAw?=
 =?utf-8?B?K0NST3lyV21qdzFqUXFkdmVXcHN6dXo3VlEvS1MyR1VGdm5RZDc1bDZMei9W?=
 =?utf-8?B?Q3RSbEpsYk5zWUVRdWN0TE01OElDY2hDdkNZSFlXbjV1MG5reVR0U085Mm8w?=
 =?utf-8?B?Vjl4MlZxQVVEYTR4bGx5V3NlUm84cWRodWNIMHV5OHp4cnJpQnFmY1FmdDJS?=
 =?utf-8?B?S1k0b2RuSVMxMHVmR1NMbFkxdW4wZWRNSXUxMFIzemJOSUw1QUFvWlJoRFVw?=
 =?utf-8?B?WkYwRms4dzhuMTBXdjAvekZPWTZWZWxIN2hMSFd0R094U0NjaVJjU0R4UG5L?=
 =?utf-8?B?czRlcnZHYk90blZ5bWdGTWFJV0dPbmdTT3lqdHllQVJsRCtreUZlM1kwR0VR?=
 =?utf-8?B?QTdjenhWMW9hUzRkY2JWcDMySlhsTzZYTHM5Mk1OTjFFY1RDWDZsckJoY0Ey?=
 =?utf-8?B?c3ZhWGhnSkRYS3hLakpCcnE4aUszRmZyaDRIRHhUajh4c0NJQTVEUFlmZHlE?=
 =?utf-8?B?VGVlLy9XSTFJc1o5bUh3YzZ0TitockNEK2xZT0hwNTM0SWF1RDVpeGk4YmRR?=
 =?utf-8?B?Q1ExTjUwcmFic3pzcFFZazRhVHlzbUNGdXNpaXpxeWZPRFFCT2dWbWMxb1B6?=
 =?utf-8?B?WjFDd3BCbjNRa0FqaXVKZElkd0Vxc3ZsYUVKM2lWZU1vcS9aaGhXVVZ4TUxr?=
 =?utf-8?B?bkdLWDhMNVZvdmcveFNZczUrYnlZdDVHcUhEWW41eW8zOXpiYVNvall1TWtq?=
 =?utf-8?B?cm15T1hJcGx6dWV3Q1RsZGh5aDRLeHgxZ2JNM2lMRk9aSmUwSUpxdTVLMXNZ?=
 =?utf-8?B?djllR2lNY1hvNUJoL1BZZGlPRWFLZUdlZ2xCRTVDVVU3MHlMK1pCNDVLclNo?=
 =?utf-8?B?TkdjK2dLU2svUUFmaDVuTTM1YkZvNk56dlFmRlVzcGRySVNuN0NuTmltYjBI?=
 =?utf-8?B?ZTF0YXM4aWNRTnBWK2l5NEhFak1Hc3RDZU0rTTYzdENFSVF1TmwvUGlId0cz?=
 =?utf-8?B?K1l3YWhDTVo4a29sMjZ5dWtPUGZROW85VU56RjE3S29NaC9VZkpwTmxLUFN4?=
 =?utf-8?B?OC82Zkw4U2l4WWI0dmRoWGRsN1psTGNzT0did0tGLzFjbzJtbnEraExIU3Ru?=
 =?utf-8?B?dnRuWHhKZm1xcFNmL2N5alJ0YTdtamhaYjFtYnN3QngycnVnbHpvTVd1RVhB?=
 =?utf-8?B?cHNqcE9oSFViYWM1Q3NiR2t1dCtiOHUwaGwwbDA3eGFlbm5PTXJDWVdWSkFm?=
 =?utf-8?B?RDRjQ05wOE5SR2MwdFFTMmVZeWJwazlvK1lqWTNvN0hpRUhNSVRVd1BjclJk?=
 =?utf-8?B?WGl5MGxoS1NOVVh5OWN4UEtsSFRJNnE4ZnZlWmJrK0FzbEMrb2I4MUtQaG03?=
 =?utf-8?B?TnZ5dmNLQm5BdTVWSTZMQUc4T1Rzb1UwdUdxalIrVGY3L1gvSFVoY25EQ1lE?=
 =?utf-8?B?SStnR015NDNUc0d3MStTanVyY2IrRFVTeWVySVlUdmVGS1pnc0FoN2pwcldj?=
 =?utf-8?B?VDl5UFRqTVlUL2Q3dkNCU0pXSmxGYVA2R3Z1SzhGZUM4bUhudGVuQjBoZWNI?=
 =?utf-8?B?enUwZ1JYbGg5QStObU1nR2dNYVAyNkQ4QWVGa21jRTNjVDgzanBsTVdBZFl3?=
 =?utf-8?B?bklGZmZIT3dnTTFpVlp0a3BzMGhTUnVjNkEvM3NBbmNXU0psWTFtdllNR2JJ?=
 =?utf-8?B?Q2dsVmZGeExkNGFNV2xIMXlvVGgraWVKaHRJc1ErUzNpNTdzKzRKcnlMT1ds?=
 =?utf-8?B?NitnVzJ4ZERnREJheTZWN0xqYWZOSno0VmFNTXNodHlHWkhreEVaV2tSbnZr?=
 =?utf-8?B?U0VvRmZMelFuckhMVTZRdjRjMjJRbytRMkVUYnFLNDNUUklIaUtER3VMUzFV?=
 =?utf-8?B?N3pyUjRzd04yaW42Tmw5OEp1NkJTQU8xT3phVWJnRSs0RUZGL1hNQjV6akJv?=
 =?utf-8?B?bklxK3lLR0llQVFaL08rb016UXZOYkMzVURTU2dGazNzOEdIRzF5WGZwTTFE?=
 =?utf-8?B?azVBZXd2S3VOU3p3M2swbUx5cHlKNVlPdmlMOGwxV3JkVnZIdlJVVWpHekd0?=
 =?utf-8?Q?cWZ98Y5/Vq0Q4VHleF64NV0AV?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F6EC48B99712844BBE2EFC88D23C16DE@FRAP264.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 49be8004-6fad-4559-52ba-08dc433ca2c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2024 09:04:48.7122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GL2zyCjRNwzPJrGvvz3SD33qv0G2ofEDOF9TaNiaUY2PFP8ZOB17N5IR4Nl5/9rGR+dIrismZyO5LnaIT9DeYrHcBOJFnWjBbWukE/A5Y+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB2527

DQoNCkxlIDEyLzAzLzIwMjQgw6AgMjM6MjgsIFJpY2sgRWRnZWNvbWJlIGEgw6ljcml0wqA6DQo+
IEZ1dHVyZSBjaGFuZ2VzIHdpbGwgbmVlZCB0byBhZGQgYSBuZXcgbWVtYmVyIHRvIHN0cnVjdA0K
PiB2bV91bm1hcHBlZF9hcmVhX2luZm8uIFRoaXMgd291bGQgY2F1c2UgdHJvdWJsZSBmb3IgYW55
IGNhbGwgc2l0ZSB0aGF0DQo+IGRvZXNuJ3QgaW5pdGlhbGl6ZSB0aGUgc3RydWN0LiBDdXJyZW50
bHkgZXZlcnkgY2FsbGVyIHNldHMgZWFjaCBtZW1iZXINCj4gbWFudWFsbHksIHNvIGlmIG5ldyBt
ZW1iZXJzIGFyZSBhZGRlZCB0aGV5IHdpbGwgYmUgdW5pbml0aWFsaXplZCBhbmQgdGhlDQo+IGNv
cmUgY29kZSBwYXJzaW5nIHRoZSBzdHJ1Y3Qgd2lsbCBzZWUgZ2FyYmFnZSBpbiB0aGUgbmV3IG1l
bWJlci4NCj4gDQo+IEl0IGNvdWxkIGJlIHBvc3NpYmxlIHRvIGluaXRpYWxpemUgdGhlIG5ldyBt
ZW1iZXIgbWFudWFsbHkgdG8gMCBhdCBlYWNoDQo+IGNhbGwgc2l0ZS4gVGhpcyBhbmQgYSBjb3Vw
bGUgb3RoZXIgb3B0aW9ucyB3ZXJlIGRpc2N1c3NlZCwgYW5kIGEgd29ya2luZw0KPiBjb25zZW5z
dXMgKHNlZSBsaW5rcykgd2FzIHRoYXQgaW4gZ2VuZXJhbCB0aGUgYmVzdCB3YXkgdG8gYWNjb21w
bGlzaCB0aGlzDQo+IHdvdWxkIGJlIHZpYSBzdGF0aWMgaW5pdGlhbGl6YXRpb24gd2l0aCBkZXNp
Z25hdGVkIG1lbWJlciBpbml0aWF0b3JzLg0KPiBIYXZpbmcgc29tZSBzdHJ1Y3Qgdm1fdW5tYXBw
ZWRfYXJlYV9pbmZvIGluc3RhbmNlcyBub3QgemVybyBpbml0aWFsaXplZA0KPiB3aWxsIHB1dCB0
aG9zZSBzaXRlcyBhdCByaXNrIG9mIGZlZWRpbmcgZ2FyYmFnZSBpbnRvIHZtX3VubWFwcGVkX2Fy
ZWEoKSBpZg0KPiB0aGUgY29udmVudGlvbiBpcyB0byB6ZXJvIGluaXRpYWxpemUgdGhlIHN0cnVj
dCBhbmQgYW55IG5ldyBtZW1iZXIgYWRkaXRpb24NCj4gbWlzc2VzIGEgY2FsbCBzaXRlIHRoYXQg
aW5pdGlhbGl6ZXMgZWFjaCBtZW1iZXIgbWFudWFsbHkuDQo+IA0KPiBJdCBjb3VsZCBiZSBwb3Nz
aWJsZSB0byBsZWF2ZSB0aGUgY29kZSBtb3N0bHkgdW50b3VjaGVkLCBhbmQganVzdCBjaGFuZ2UN
Cj4gdGhlIGxpbmU6DQo+IHN0cnVjdCB2bV91bm1hcHBlZF9hcmVhX2luZm8gaW5mbw0KPiB0bzoN
Cj4gc3RydWN0IHZtX3VubWFwcGVkX2FyZWFfaW5mbyBpbmZvID0ge307DQo+IA0KPiBIb3dldmVy
LCB0aGF0IHdvdWxkIGxlYXZlIGNsZWFudXAgZm9yIHRoZSBtZW1iZXJzIHRoYXQgYXJlIG1hbnVh
bGx5IHNldA0KPiB0byB6ZXJvLCBhcyBpdCB3b3VsZCBubyBsb25nZXIgYmUgcmVxdWlyZWQuDQo+
IA0KPiBTbyB0byBiZSByZWR1Y2UgdGhlIGNoYW5jZSBvZiBidWdzIHZpYSB1bmluaXRpYWxpemVk
IG1lbWJlcnMsIGluc3RlYWQNCj4gc2ltcGx5IGNvbnRpbnVlIHRoZSBwcm9jZXNzIHRvIGluaXRp
YWxpemUgdGhlIHN0cnVjdCB0aGlzIHdheSB0cmVlIHdpZGUuDQo+IFRoaXMgd2lsbCB6ZXJvIGFu
eSB1bnNwZWNpZmllZCBtZW1iZXJzLiBNb3ZlIHRoZSBtZW1iZXIgaW5pdGlhbGl6ZXJzIHRvIHRo
ZQ0KPiBzdHJ1Y3QgZGVjbGFyYXRpb24gd2hlbiB0aGV5IGFyZSBrbm93biBhdCB0aGF0IHRpbWUu
IExlYXZlIHRoZSBtZW1iZXJzIG91dA0KPiB0aGF0IHdlcmUgbWFudWFsbHkgaW5pdGlhbGl6ZWQg
dG8gemVybywgYXMgdGhpcyB3b3VsZCBiZSByZWR1bmRhbnQgZm9yDQo+IGRlc2lnbmF0ZWQgaW5p
dGlhbGl6ZXJzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUmljayBFZGdlY29tYmUgPHJpY2sucC5l
ZGdlY29tYmVAaW50ZWwuY29tPg0KPiBSZXZpZXdlZC1ieTogR3VvIFJlbiA8Z3VvcmVuQGtlcm5l
bC5vcmc+DQoNCg0KUmV2aWV3ZWQtYnk6IENocmlzdG9waGUgTGVyb3kgPGNocmlzdG9waGUubGVy
b3lAY3Nncm91cC5ldT4NCg0KDQoNCj4gQ2M6IEd1byBSZW4gPGd1b3JlbkBrZXJuZWwub3JnPg0K
PiBDYzogbGludXgtY3NreUB2Z2VyLmtlcm5lbC5vcmcNCj4gTGluazogaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvbGttbC8yMDI0MDIyODA5MTIuMzNBRUU3QTlDRkBrZWVzY29vay8jdA0KPiBMaW5r
OiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sL2o3YmZ2aWczZ2V3M3FydW91eHJoN3o3ZWhq
amFmcmdrYmNtZzZ0Y2doaGZoM3JobXppQHd6bGNvZWNneTVycy8NCj4gLS0tDQo+IHYzOg0KPiAg
IC0gRml4ZWQgc3BlbGxpbmcgZXJyb3JzIGluIGxvZw0KPiAgIC0gQmUgY29uc2lzdGVudCBhYm91
dCBmaWVsZCB2cyBtZW1iZXIgaW4gbG9nDQo+IA0KPiBIaSwNCj4gDQo+IFRoaXMgcGF0Y2ggd2Fz
IHNwbGl0IGFuZCByZWZhY3RvcmVkIG91dCBvZiBhIHRyZWUtd2lkZSBjaGFuZ2UgWzBdIHRvIGp1
c3QNCj4gemVyby1pbml0IGVhY2ggc3RydWN0IHZtX3VubWFwcGVkX2FyZWFfaW5mby4gVGhlIG92
ZXJhbGwgZ29hbCBvZiB0aGUNCj4gc2VyaWVzIGlzIHRvIGhlbHAgc2hhZG93IHN0YWNrIGd1YXJk
IGdhcHMuIEN1cnJlbnRseSwgdGhlcmUgaXMgb25seSBvbmUNCj4gYXJjaCB3aXRoIHNoYWRvdyBz
dGFja3MsIGJ1dCB0d28gbW9yZSBhcmUgaW4gcHJvZ3Jlc3MuIEl0IGlzIGNvbXBpbGUgdGVzdGVk
DQo+IG9ubHkuDQo+IA0KPiBUaGVyZSB3YXMgZnVydGhlciBkaXNjdXNzaW9uIHRoYXQgdGhpcyBt
ZXRob2Qgb2YgaW5pdGlhbGl6aW5nIHRoZSBzdHJ1Y3RzDQo+IHdoaWxlIG5pY2UgaW4gc29tZSB3
YXlzIGhhcyBhIGdyZWF0ZXIgcmlzayBvZiBpbnRyb2R1Y2luZyBidWdzIGluIHNvbWUgb2YNCj4g
dGhlIG1vcmUgY29tcGxpY2F0ZWQgY2FsbGVycy4gU2luY2UgdGhpcyB2ZXJzaW9uIHdhcyByZXZp
ZXdlZCBteSBhcmNoDQo+IG1haW50YWluZXJzIGFscmVhZHksIGxlYXZlIGl0IGFzIHdhcyBhbHJl
YWR5IGFja25vd2xlZGdlZC4NCj4gDQo+IFRoYW5rcywNCj4gDQo+IFJpY2sNCj4gDQo+IFswXSBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjQwMjI2MTkwOTUxLjMyNDA0MzMtNi1yaWNr
LnAuZWRnZWNvbWJlQGludGVsLmNvbS8NCj4gLS0tDQo+ICAgYXJjaC9jc2t5L2FiaXYxL21tYXAu
YyB8IDEyICsrKysrKy0tLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyks
IDYgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9jc2t5L2FiaXYxL21tYXAu
YyBiL2FyY2gvY3NreS9hYml2MS9tbWFwLmMNCj4gaW5kZXggNjc5MmFjYTQ5OTk5Li43ZjgyNjMz
MWQ0MDkgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvY3NreS9hYml2MS9tbWFwLmMNCj4gKysrIGIvYXJj
aC9jc2t5L2FiaXYxL21tYXAuYw0KPiBAQCAtMjgsNyArMjgsMTIgQEAgYXJjaF9nZXRfdW5tYXBw
ZWRfYXJlYShzdHJ1Y3QgZmlsZSAqZmlscCwgdW5zaWduZWQgbG9uZyBhZGRyLA0KPiAgIAlzdHJ1
Y3QgbW1fc3RydWN0ICptbSA9IGN1cnJlbnQtPm1tOw0KPiAgIAlzdHJ1Y3Qgdm1fYXJlYV9zdHJ1
Y3QgKnZtYTsNCj4gICAJaW50IGRvX2FsaWduID0gMDsNCj4gLQlzdHJ1Y3Qgdm1fdW5tYXBwZWRf
YXJlYV9pbmZvIGluZm87DQo+ICsJc3RydWN0IHZtX3VubWFwcGVkX2FyZWFfaW5mbyBpbmZvID0g
ew0KDQpJIHNlZSB5b3UgZGlkbid0IGhhZCAuZmxhZ3MgPSAwLCB3aGljaCBpcyBnb29kLiBXb25k
ZXJpbmcgd2h5IHlvdSBkaWRuJ3QgDQpkbyB0aGUgc2FtZSBmb3IgcG93ZXJwYy4NCg0KPiArCQku
bGVuZ3RoID0gbGVuLA0KPiArCQkubG93X2xpbWl0ID0gbW0tPm1tYXBfYmFzZSwNCj4gKwkJLmhp
Z2hfbGltaXQgPSBUQVNLX1NJWkUsDQo+ICsJCS5hbGlnbl9vZmZzZXQgPSBwZ29mZiA8PCBQQUdF
X1NISUZUDQoNClVzdWFsbHkgd2UgbGVhdmUgdGhlIGNvbW1hIGF0IHRoZSBlbmQgb2YgdGhlIGxh
c3QgZWxlbWVudCBzbyB0aGF0IHRoZSANCmRheSB5b3UgYWRkIGEgbmV3IGVsZW1lbnQgeW91IGRv
bid0IGhhdmUgdG8gY2hhbmdlIGFuIGV4aXN0aW5nIGxpbmUganVzdCANCnRvIGFkZCBhIGNvbW1h
Lg0KDQo+ICsJfTsNCj4gICANCj4gICAJLyoNCj4gICAJICogV2Ugb25seSBuZWVkIHRvIGRvIGNv
bG91ciBhbGlnbm1lbnQgaWYgZWl0aGVyIHRoZSBJIG9yIEQNCj4gQEAgLTYxLDExICs2Niw2IEBA
IGFyY2hfZ2V0X3VubWFwcGVkX2FyZWEoc3RydWN0IGZpbGUgKmZpbHAsIHVuc2lnbmVkIGxvbmcg
YWRkciwNCj4gICAJCQlyZXR1cm4gYWRkcjsNCj4gICAJfQ0KPiAgIA0KPiAtCWluZm8uZmxhZ3Mg
PSAwOw0KPiAtCWluZm8ubGVuZ3RoID0gbGVuOw0KPiAtCWluZm8ubG93X2xpbWl0ID0gbW0tPm1t
YXBfYmFzZTsNCj4gLQlpbmZvLmhpZ2hfbGltaXQgPSBUQVNLX1NJWkU7DQo+ICAgCWluZm8uYWxp
Z25fbWFzayA9IGRvX2FsaWduID8gKFBBR0VfTUFTSyAmIChTSE1MQkEgLSAxKSkgOiAwOw0KPiAt
CWluZm8uYWxpZ25fb2Zmc2V0ID0gcGdvZmYgPDwgUEFHRV9TSElGVDsNCj4gICAJcmV0dXJuIHZt
X3VubWFwcGVkX2FyZWEoJmluZm8pOw0KPiAgIH0NCg==

