Return-Path: <linux-kernel+bounces-131910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6D6898D7D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A014F1C27C04
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DEE12EBC5;
	Thu,  4 Apr 2024 17:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="cpYPb+jw"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2078.outbound.protection.outlook.com [40.92.41.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9102F129E88
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 17:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712252938; cv=fail; b=HJt2IVePyWWRRxgmb6c4Xke+/IpXdFlpuTuOHGeRA9Zf4tdJ15kWDNsmrqz2blY578LbrxXfdAQtBoqn5Dlq+CSHhORjYswJxkSf4TEmCIq7LrHt9b570mMtr1V62WEgMAD9aveRC7EY5dsi0tSAfJzsWBIJriASudv1RcnlWRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712252938; c=relaxed/simple;
	bh=I6C3meN8a2w2iK2js623zMXH9S/yk1EjnpC/c2tXU7c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VC0UHi4yhkjearYAl7gAyIIjnwdIzru1utMKB0wj2VtFX2UV09fm67In81diyioWKoWUbWX4N3vQLtd3/Ix2IPWhk0llKmw1a8mToQs3ysEtueEFop08TD2L3yn+OpsxmuX2N0HEf6VometMlHs7uUDXnZWLnHdkpDZKRGfnHNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=cpYPb+jw; arc=fail smtp.client-ip=40.92.41.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ilmhN4QPFTmM15JBAJ9LgxFGSFWqopItfGXM5Hkw3CtFSkeqrXhnZ+mXqveoS24BjSemD5i50Bp/iZC7BHxEI19KOQNscisrXjjJKGmpPjQYzytVvrJEj4Hi7pGg63GZEXewEFIWD6I8ilz4HpMmOAFmmvybNi2uUu6dIvBxVVXLz7ny2ShOpCj8YveRetc8fIwZiVdd3wuJgmh1s6u0sFBmrp7oTH5zqV4zfziD7PjVpI6WGYNXKjxoU4P8qi1R00q9RC+qLW2oLUwCfmyPR2c8a/ZIjK4nUX5kj1Uax5PaiVK8nY/CYSBd3mo3x/vUWv+nCsWKay5Vn7XtYNGtxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I6C3meN8a2w2iK2js623zMXH9S/yk1EjnpC/c2tXU7c=;
 b=FkJEw/JVPL/msot/ueRbLTkWEkp8QeAPoE6U4GSc/i7OED8kqDbEe0jMtirV7U44w6jTZtvUwXWr/wTCe5itLktK+cU/WoDfnyoejF3+60KFGzqWUWEypf/jk7EyxZJ8rC2bS5AFO9VJdFa5WVc10lUhjavRLZ4svQTzK3cqzjKwjIfRwnMX1JQvequjQwmGvAI0Jk7yyu8JxsE2/szJ4uYDG3aZKhn5bC/1pLh/012lXva2OVGox+rp4gjUvc/SGw1vFATfIETaOO9URzOX+UilcrHCS4Qt8kcVRwDaAr4PQHJJfLZyKV1dBNwIwV76PNlwLGOYkF284viWLrgZbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6C3meN8a2w2iK2js623zMXH9S/yk1EjnpC/c2tXU7c=;
 b=cpYPb+jwA9GS0Go56nwpE3fLBvfMI62fYpq/HbYa9/Yie3T0QLhG9nxOKeYrys4lNooRFFqLgyAVwvvppagvjdoGNvSGrNcMiG93ak/a5rsWixFui0zBTTN/MtiGuq8iyBb4LOiVOf56K0eVFiEbMHV/YcxMJ42aVkMMRb0P0i1Lt6nf4wz74zwLtkcCQKXXwWb34bfef35Nee6UQsMtandryQkd2CG5Tyo8Xhu71AgofnF+h/BaKE40LwXZp1IB3M/USFhviBWHTOomLVqmVJ+4ZemeXFSylHpzzmqgxbKgxpsHhRAuX1VDuP4BKrscamnTqO+JU9UNsgt67ETlcg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DM4PR02MB9191.namprd02.prod.outlook.com (2603:10b6:8:109::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 17:48:54 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::1276:e87b:ae1:a596]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::1276:e87b:ae1:a596%5]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 17:48:54 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Sean Christopherson <seanjc@google.com>, Andrew Cooper
	<andrew.cooper3@citrix.com>
CC: Xi Ruoyao <xry111@xry111.site>, Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
	"x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATCH v2] x86/mm: Don't disable INVLPG if "incomplete Global
 INVLPG flushes" is fixed by microcode
Thread-Topic: [PATCH v2] x86/mm: Don't disable INVLPG if "incomplete Global
 INVLPG flushes" is fixed by microcode
Thread-Index: AQHafh5br9v5ziibjkOOzawG3mO/srFH4YWAgBB5xoCAAAgygIAACzgAgAAB4kA=
Date: Thu, 4 Apr 2024 17:48:53 +0000
Message-ID:
 <SN6PR02MB415717D76F71C023A574841ED43C2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240324190503.116160-1-xry111@xry111.site>
 <SN6PR02MB41576028614CB7FE9A11EBEBD4362@SN6PR02MB4157.namprd02.prod.outlook.com>
 <Zg7S5dk3J4Zc82nj@google.com>
 <d1cc1f7c-9df0-4e3c-88ae-aedcd556ba95@citrix.com>
 <Zg7jLn-lV55Yh6mH@google.com>
In-Reply-To: <Zg7jLn-lV55Yh6mH@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [QSBV0RzLZp17XJehtM6sh6azrOvRYMtY]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DM4PR02MB9191:EE_
x-ms-office365-filtering-correlation-id: 3063826d-247a-4d5d-cc83-08dc54cf7eb2
x-ms-exchange-slblob-mailprops:
 Cq7lScuPrnpvfvtnCL/nAgNU6SrUc5dpFgYIKdBzqnkWw1ZKP8ayi8p1N3EC/8ADjjNdmbcdmi266iWjP+c664CS36MT1W0tFyQyX+MGleDRHIFQpLU/ZcjsHvS2PTZ81bjKXhbGO2ngSSH2P8y52IJCT/X2Z+4NoIFQvhLitfWVRu1WKIfjm5uQuAhAfyVLvuvjQrtwg341h3z2x27/xCnLn0hKoOG97ghfQ5Bezm5P/mUUdxd12Mrs0kdcZ8HzVWMG4MCORXfMH5V9aamoSC9V5Z/KTJ3/OMvgSWhJwdko1A35xbq2Nb41SbQzZSlf8HKGznoYSEQyOa/D2zI2zbPSj+/GHQ6buXxClPMTdhIv1NEs2pafoksaZYDp7vdGC7xnJSSz1TEuosVseSqNu3rF43YLCj32hg0/Tgp/myBdW6MRgwfgg13h5r+Bn+1vAp9H2Mu7Du/iDVW2Mlyv7/oWK0skh3VLRGpOhSCxz0T1Moy3/vb+dwTFe3Cps3lasw7hpJPW0edcZ0RcKTsb3+jq+vjXoIVzPJgYZ0j0V0ir0DihSBSwcw8lUFXKcbRHSrs9EYhXYY176pIGqpCT1FoocKuBDRrltG2hg4BPdRD4uDa+wXU/nAje1B+KRKtLCYIzT2XQwZqlGX8Cofmu+s48Vq7WUUeMEzJosf08BGrXQbqr2Ez0a95tOJLV52dTOCFrR3dIjtPhsSxilGUV5sa8z3GQ81Fdg5sOO1wHwBaP2jwDaygyUDrNhdXywMOxKafTzAi04Ss=
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 QLYlDotKYqc16CSlLXHW8rK4iW3TFUmNMDq8mFvItxpcTpqjp1TFaMglPKDplJgxyLT8mZ6Unkq/Fc1LmU9cVoqh4X7krjkoqS+u5p0znJc1xdO+OJ68dFaH8Wj0Odzm+LxourtDRQ8tIsA9HQDetc8oYpmuvdQ1or2vwu6oEzoMTd4qC01Vl5h3pHKfVNGPcofQuRH3Jd6FOIkgGm0oKaZkeRuJi8cZqjRikv2YaPnv02K4C4+mrCIszBmMdkhSB9zvK4Ze0gyfCaJI5xe/cvoQk/2SIrNuoE9BLVA7fDLfdtH/+QQ7YgwSOuD3vGUoYMwGP9sHzZdj3jDnPqnB4f6hcsqhxg3UlRHxZwJ/j20BViYefkeV6vepUCp6nTjcvelh5IVmv4wk0A63+jmik01/hTBV6go2G/OAOjsIglwt5mJwYG6OP2UESjcG4QYVFX4PJjT4tVEwNk/d++0NiAv6Km25x3wGTJs8e0LqU/h6kldh6Y0IZJ7oMy5bunQyTVoYFBXdSUzGJC6o3GPoKxGH3WXmFsQ9fe7tmqzjlCx4c9vQRgGSfdYSXlzHn73p
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NWlscEZ2d3RudTZjMGZhcEh5TE9PVjVMYmdoQVYxcFVGbEJza2k4eU0xZm1o?=
 =?utf-8?B?MVh4SmpEUTI5amVGQkpodXByMTRNTXkyVVIrV3Z5Nm9OTXhZVVpFbjR5K3R6?=
 =?utf-8?B?K2pXSkcvamNGYUI1MXQ1SWtaYXNoU0lHcS92cHRUV1VQNXZLbVVvcTV1eXk5?=
 =?utf-8?B?aVJVb2Y5RG9rYVhIb2dKSk0raWFJbDFoUzkzM0NsQ1I1VWhybEkzV2pYMDVE?=
 =?utf-8?B?b0NLK1JVK1lPQnI5VnZnQVhKdE56SlJXazZvTzQrbnducVB3RHNHMDZINWlI?=
 =?utf-8?B?Szk0TmpPYm5qeDR5dWwvcThRcnBrUDR0MU5aclQ5dERnekpOU2VmaDJ0TGRH?=
 =?utf-8?B?U05XcmVmdnp2SjkwTmZiR2ljV1Nrd2tSUTd4bHlmVDY0M2o2T05WdUVJUkVY?=
 =?utf-8?B?VXk0YmVvTnRFWEd0QzhWR1BtMnkrdVp4VTZMREJmdEpjdm1DT3p1VExSQUx3?=
 =?utf-8?B?NHhEK2hRT1FydldZekE4L0JxM2toQko5MUxOblg5WGY3RTNkY0RDeUFzMXo2?=
 =?utf-8?B?c1B0eDF5K2FsdXprUFArdGZJTGFJbTY5WnBSaDhXN04wcUl1anZZMU9nSDZM?=
 =?utf-8?B?d3h6SldldFg5TDFkeE5nOVJjYlJYODc0RWRhWUFTeGxFNEI4TUlwVDkvWHAw?=
 =?utf-8?B?dXRVYnk0ei9CZ3VhazZOblJwKzN3L0NOM1BzeEdHMHdROWpicC91cjd2SERY?=
 =?utf-8?B?VFVtQ3hUa1JBYzl5VTNRWEx6Q2oyQlpWenRnaThRYUxCeWVPZk5JZDBmVElh?=
 =?utf-8?B?TEN1dEFoWGRHbGc2cnNlUEtpZVRtbWs3dmM1L2xMT2I3bFR4VmFxam5QSllZ?=
 =?utf-8?B?eHd5T1Q2ZTRvU3hvamZEbVBBTHRVTWNwb2E1bzIxUFdLejlBYUZxa1crZW1U?=
 =?utf-8?B?OG9jdlJNWDZoQ1l3cGI1M2l3WTFVRmc2TGlQY1oyWGZvbTAxNjd4cXBqbVJS?=
 =?utf-8?B?aE85VTdtN29pR0p4N3RSVlQxWFd0bU5JZHZDb1lxY2lOeHI3SFplYnhBTm51?=
 =?utf-8?B?VlYySnhvUzVJTmc3aGQ4ZytkOUNoTFM3YUVQV3NwOTRYblQwSEcycTNSdnVM?=
 =?utf-8?B?UllkMFVXdTFpR2FtbG42aDJUbjlwS0taRG5XL0daSW9UcHRPRiswNFRubFQ0?=
 =?utf-8?B?d3pIcVphNzdpd3Q0eDhWYUJ0TENoRkFkb0pzSG10eW5oMmJQWGQ0S3FnV2l2?=
 =?utf-8?B?TnJ2Qmt3WmRabi95Y2kzL1E5dEhaTVFmMjkzeTBYUmhsazI1c01NZ09UQWZs?=
 =?utf-8?B?OVJuOC8wV3psOE1Wc2V1bjhvT2J5TkNlcDA5M0J4Q3R0MlM2TW1RRzY5ZDZG?=
 =?utf-8?B?OWhwbGpaM1FpaEJwOFJLNlE4NERkOURxTXJvcHpsRnlYQmFsSnoxdkhxNG4r?=
 =?utf-8?B?TG02bHJwZGh0Z2FyVytsVWMveFgyYWY0clVCY1J4U3lTOVorV3djdWpTK0ZK?=
 =?utf-8?B?L1V5RVJGMHU1Nm1FbEtUUTNJWHh0bWgxcDEzeU1KS1NmUkYyYXY5SVBiYU50?=
 =?utf-8?B?ZVpZU1I2aDdYOUlVdlk5NElHVHd3T1ZhZUU4Nmk5TXBUMUNqcytsL0k1NGFZ?=
 =?utf-8?B?MGNVUUNYYjVKUEYyRS82cGluNHg1a3RXUExBU3RETElQanFqNG1BYkx6cXlq?=
 =?utf-8?B?MVBFVTRpVFRsY2xIMW5BZE14U3FtQkE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3063826d-247a-4d5d-cc83-08dc54cf7eb2
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2024 17:48:53.9936
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR02MB9191

RnJvbTogU2VhbiBDaHJpc3RvcGhlcnNvbiA8c2VhbmpjQGdvb2dsZS5jb20+IFNlbnQ6IFRodXJz
ZGF5LCBBcHJpbCA0LCAyMDI0IDEwOjI4IEFNDQo+IA0KPiBPbiBUaHUsIEFwciAwNCwgMjAyNCwg
QW5kcmV3IENvb3BlciB3cm90ZToNCj4gPiBPbiAwNC8wNC8yMDI0IDU6MTggcG0sIFNlYW4gQ2hy
aXN0b3BoZXJzb24gd3JvdGU6DQo+ID4gPiBPbiBNb24sIE1hciAyNSwgMjAyNCwgTWljaGFlbCBL
ZWxsZXkgd3JvdGU6DQo+ID4gPj4+ICBzdGF0aWMgdm9pZCBzZXR1cF9wY2lkKHZvaWQpDQo+ID4g
Pj4+ICB7DQo+ID4gPj4+ICsJY29uc3Qgc3RydWN0IHg4Nl9jcHVfaWQgKmludmxwZ19taXNzX21h
dGNoOw0KPiA+ID4+PiArDQo+ID4gPj4+ICAJaWYgKCFJU19FTkFCTEVEKENPTkZJR19YODZfNjQp
KQ0KPiA+ID4+PiAgCQlyZXR1cm47DQo+ID4gPj4+DQo+ID4gPj4+ICAJaWYgKCFib290X2NwdV9o
YXMoWDg2X0ZFQVRVUkVfUENJRCkpDQo+ID4gPj4+ICAJCXJldHVybjsNCj4gPiA+Pj4NCj4gPiA+
Pj4gLQlpZiAoeDg2X21hdGNoX2NwdShpbnZscGdfbWlzc19pZHMpKSB7DQo+ID4gPj4+ICsJaW52
bHBnX21pc3NfbWF0Y2ggPSB4ODZfbWF0Y2hfY3B1KGludmxwZ19taXNzX2lkcyk7DQo+ID4gPj4+
ICsJaWYgKGludmxwZ19taXNzX21hdGNoICYmDQo+ID4gPj4+ICsJICAgIGludmxwZ19taXNzX21h
dGNoLT5kcml2ZXJfZGF0YSA+IGJvb3RfY3B1X2RhdGEubWljcm9jb2RlKSB7DQo+ID4gPj4+ICAJ
CXByX2luZm8oIkluY29tcGxldGUgZ2xvYmFsIGZsdXNoZXMsIGRpc2FibGluZyBQQ0lEIik7DQo+
ID4gPj4+ICAJCXNldHVwX2NsZWFyX2NwdV9jYXAoWDg2X0ZFQVRVUkVfUENJRCk7DQo+ID4gPj4+
ICAJCXJldHVybjsNCj4gPiA+PiBBcyBub3RlZCBpbiBzaW1pbGFyIHBsYWNlcyB3aGVyZSBtaWNy
b2NvZGUgdmVyc2lvbnMgYXJlDQo+ID4gPj4gY2hlY2tlZCwgaHlwZXJ2aXNvcnMgb2Z0ZW4gbGll
IHRvIGd1ZXN0cyBhYm91dCBtaWNyb2NvZGUgdmVyc2lvbnMuDQo+ID4gPj4gRm9yIGV4YW1wbGUs
IHNlZSBjb21tZW50cyBpbiBiYWRfc3BlY3RyZV9taWNyb2NvZGUoKS4gIEkNCj4gPiA+PiBrbm93
IEh5cGVyLVYgZ3Vlc3RzIGFsd2F5cyBzZWUgdGhlIG1pY3JvY29kZSB2ZXJzaW9uIGFzDQo+ID4g
Pj4gMHhGRkZGRkZGRiAobWF4IHUzMiB2YWx1ZSkuICBTbyBpbiBhIEh5cGVyLVYgZ3Vlc3QgdGhl
IGFib3ZlDQo+ID4gPj4gY29kZSB3aWxsIGFsd2F5cyBsZWF2ZSBQQ0lEIGVuYWJsZWQuDQo+ID4g
PiBFbnVtZXJhdGluZyBicm9rZW4gUENJRCBzdXBwb3J0IHRvIGEgZ3Vlc3QgaXMgdmVyeSBhcmd1
YWJseSBhIGh5cGVydmlzb3IgYnVnLg0KPiA+ID4gSHlwZXJ2aXNvcnMgYWxzbyBsaWUgdG8gZ3Vl
c3QgYWJvdXQgRk1TLiAgQXMgS1ZNICp1c2VyKiB3aXRoIGFmZmVjdGVkIGhhcmR3YXJlDQo+ID4g
PiAoaG9tZSBib3gpLCBJIHdvdWxkIHdhbnQgdGhlIGtlcm5lbCB0byBhc3N1bWUgUENJRCB3b3Jr
cyBpZiBYODZfRkVBVFVSRV9IWVBFUlZJU09SDQo+ID4gPiBpcyBwcmVzZW50Lg0KPiA+DQo+ID4g
SSBoYXZlIHZlcnkgbWl4ZWQgZmVlbGluZ3MgYWJvdXQgYWxsIG9mIHRoaXMuDQo+ID4NCj4gPiBU
aGUgR3JhY2Vtb250IElOVkxQRyB2cyBQQ0lEIGJ1ZyB3YXMgZm91bmQgaW4gdGhlIGZpZWxkLCBz
byBQQ0lEIHdpbGwNCj4gPiBoYXZlIGJlZW4gZW51bWVyYXRlZCB0byBndWVzdHMgYXQgdGhhdCBw
b2ludC7CoCBZb3UgY2FuJ3QgYmxpbmRseSBkcm9wDQo+ID4gUENJRCB1bnRpbCB0aGUgVk0gbmV4
dCByZWJvb3RzLg0KPiA+DQo+ID4gQSByZWxhdGVkIGV4YW1wbGUuwqAgSSB3cm90ZSB0aGUgcGF0
Y2ggdG8gaGlkZSBYU0FWRVMgdG8gd29yayBhcm91bmQgYW4NCj4gPiBBTUQgZXJyYXR1bSB3aGVy
ZSBYU0FWRUMgc3VmZmljZWQsIGFuZCB0aGUgY29uc2VxdWVuY2VzIHdlcmUgc28gZGlyZSBmb3IN
Cj4gPiBzb21lIHZlcnNpb25zIG9mIFdpbmRvd3MgdGhhdCB0aGVyZSB3YXMgYSBzdWdnZXN0aW9u
IHRvIHNpbXBseSByZXZlcnQNCj4gPiB0aGUgd29ya2Fyb3VuZCB0byBtYWtlIFZNcyBydW4gYWdh
aW4uwqAgV2luZG93cyBpbnRlbnRpb25hbGx5IGFzc2VydHMNCj4gPiBzYW5pdHkgKD09IGV4cGVj
dGF0aW9ucykgaW4gd2hhdCBpdCBjYW4gc2VlOyBJIGhhdmUgbm8gaWRlYSB3aGV0aGVyIGl0DQo+
ID4gd291bGQgb2JqZWN0IGluIHRoaXMgY2FzZSBidXQgaGlkaW5nIFBDSUQgaXMgZGVmaW5pdGVs
eSBwbGF5aW5nIHdpdGggZmlyZS4NCj4gDQo+IFllYWgsIEtWTSB1c2VycyBnb3QgYnVybmVkIGJ5
IHRoYXQgdG9vLiAgZDUyNzM0ZDAwYjhlICgiS1ZNOiB4ODY6IEdpdmUgYQ0KPiBoaW50IHdoZW4g
V2luMjAxNiBtaWdodCBmYWlsIHRvIGJvb3QgZHVlIHRvIFhTQVZFUyBlcnJhdHVtIikuDQo+IA0K
PiBCdXQgcHJhY3RpY2FsbHkgc3BlYWtpbmcsIHRoYXQgc2hpcCBoYXMgc2FpbGVkIGZvciBLVk0s
IGFzIEtWTSBhZHZlcnRpc2VzIFBDSUQNCj4gc3VwcG9ydCBpZiBhbmQgb25seSBpZiB0aGUgaG9z
dCBrZXJuZWwgc3VwcG9ydHMgaXQsIGkuZS4gY2xlYXJpbmcgWDg2X0ZFQVRVUkVfUENJRA0KPiBp
biBzZXR1cF9wY2lkKCkgbWVhbnMgS1ZNIHN0b3BzIGFkdmVydGlzaW5nIHRvIHVzZXJzcGFjZSwg
d2hpY2ggaW4gdHVybiBtZWFucw0KPiBRRU1VIHN0b3BzIGVudW1lcmF0aW5nIGl0IFZNcyBieSBk
ZWZhdWx0Lg0KDQpGV0lXLCBteSBob21lIGxhcHRvcCBoYXMgYSBSYXB0b3JMYWtlIENQVSB3aXRo
IHRoZSBmbGF3LiBJdCdzIHJ1bm5pbmcgYW4NCnVwLXRvLWRhdGUgV2luZG93cyAxMS9IeXBlci1W
IGFuZCBhIExpbnV4IGd1ZXN0IFZNLiBUaGUgbWljcm9jb2RlIGhhcw0Kbm90IGJlZW4gdXBkYXRl
ZCB0byBhIHZlcnNpb24gd2l0aCB0aGUgZml4LiBCdXQgdGhlIExpbnV4IGd1ZXN0IHN0aWxsDQpz
ZWVzIENQVUlEIDB4MDAwMDAwMDEgRUNYIHdpdGggdGhlICJQQ0lEIiBmbGFnIChiaXQgMTcpIGFz
IHNldC4gU28gZXZpZGVudGx5DQpIeXBlci1WIGlzIG5vdCBmaWx0ZXJpbmcgdGhpcyBmbGF3Lg0K
DQpJIGFncmVlIG9uZSBjb3VsZCBhcmd1ZSB0aGF0IGl0IGlzIGEgaHlwZXJ2aXNvciBidWcgdG8g
cHJlc2VudCBQQ0lEIHRvIHRoZSBndWVzdA0KaW4gdGhpcyBzaXR1YXRpb24uIEl0J3MgYSBsb3Qg
Y2xlYW5lciB0byBub3QgaGF2ZSBhIGd1ZXN0IGJlIGNoZWNraW5nIEZNUyBhbmQNCm1pY3JvY29k
ZSB2ZXJzaW9ucy4gQnV0IHdoZXRoZXIgdGhhdCdzIHByYWN0aWNhbCBpbiB0aGUgcmVhbCB3b3Js
ZCwgYXQgbGVhc3QNCmZvciBIeXBlci1WLCBJIGRvbid0IGtub3cuIFdoYXQncyB0aGUgcmVhbCBp
bXBhY3Qgb2YgcnVubmluZyB3aXRoIFBDSUQgd2hpbGUNCnRoZSBmbGF3IGlzIHN0aWxsIHByZXNl
bnQ/IEkgZG9u4oCZdCBrbm93IHRoZSBoaXN0b3J5IGhlcmUgLi4uDQoNCk1pY2hhZWwNCg==

