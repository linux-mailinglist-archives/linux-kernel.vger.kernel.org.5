Return-Path: <linux-kernel+bounces-46940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C398D8446A0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8C791C22AC6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7C412BE8D;
	Wed, 31 Jan 2024 17:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="eCotu8nO"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04olkn2059.outbound.protection.outlook.com [40.92.45.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7590E84A5A
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 17:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.45.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706723954; cv=fail; b=DE3FjMgaeruqSc+t0PD2cvfBIz1+fkj7gKvfyDUYaodktTv+aUNXM2bqJC2nMj6dRA0A7zNMtOoUU+K+6X355tdJcM+OoDmuomKfIg/8xWhhcQz7P6tPzx28H4eGcl6HE9NIyLL/Zi0puQtrfvzXpANAoD8i6UzLo8QT2yUMryk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706723954; c=relaxed/simple;
	bh=3soOpZN8DIJD//SQd4irME/HTcYjh6j1uCU90doj2DI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CNdEBVvOR2h1vTsJNAzH0ZeNHWWnttMPNsEfFhyziekQHwzgWdVHr2tKi7IaTHxT+X78jFkbBzWaS4YDmzA/aRjSVPcsrT1LJUo9QcO83DiI8HJyUSG7m1lbTcyHrs9ohe2pMVGE67skMQBCKPH/3FQhmSMi4oW3/sRUzHr06f4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=eCotu8nO; arc=fail smtp.client-ip=40.92.45.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mtkJnGY4lyVCXpRxcMh3fBvprlYcKgZJsQqehNgCiT64x6TWIcuQak7Jp0+yIZEZwHcOSOnZYPtm5/7VHTycAprjuHA8Thk/Z+rkTWAVV+5wz66QNpWJycw9BiPJ+Vor33iEhKQx/YhJ8mahqnjw54hCOy/ErK1pWXkn9QHi4dXGeJzG8UbDjpx/Gq1v84dHmLbSvxp8eeh0Z3kbAYsxYAhqpCak3OdENaxvoePl6gpt5KZ02SgFcQyn9OOKaqDwF3dNHGzRb5g4Ve6jftj4VLupJo7v46CXNuCiBt6VtmXa/TyuSbdI2zhQ8sR/3+O75i4SI28fBW5NUUzIDNEJZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3soOpZN8DIJD//SQd4irME/HTcYjh6j1uCU90doj2DI=;
 b=CQXmq44UahXjuPwtuO8OeSGXiVvXBBUPc6PoxzgwkR7U9tHwoMWqILphDcJFAIBYFtM9tudlnO+0kEn2EPJ6P5AsWFc0flE26VOJyUdI8dSGYtyb83yUMaXZFxEUYv5dIsgzP7mJiZXhlmugwJj1tmwJbWAV1N+N0x9pMvj9sdZ3teEIlh70ifhldYfPRVATr6I9E+RjcdkHMMjWifNC7zTAt+U9mvRZrHoz8+d9Tdq2q5QFjj3VK1G1bIudhsQxgBO0siRzbiro6a5SS851n/gUX397iF4qZhPxpz0EAkFveSKVB2SeAo+zjWmNVShLGk48iL1aAnWGIiDUxY5GuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3soOpZN8DIJD//SQd4irME/HTcYjh6j1uCU90doj2DI=;
 b=eCotu8nORksVHdyh0o1PBxAKgHYAWHhcWrOAlzXhtvNyojGjaVcrOZTwbV2gw1dlMvUTlfiyUG6k8HWFtfWDQf6bW4Mcxp4ks6gEPzvlgWFJe6NSBLO0x7waSkjENxV3MuymdUmwZfACHvTIwMeIlGpmyFZsD6R85m1NnxdxH9aD1eIfLWONvDQ9StN00ZTSLmtTPNkQrUET21RewnnTN6PRqTbP7YNDU5PKz3uDPZNVsXMMR3cWEnaXNhmSFYzSMj+h+jQrhxZiqYgYihDAv4dKbAYZOIaQHkCNDH1fa3HVCU+LYWbDFPGWloAiRS0dFsuYFrCwQtVsCD6AWKd9Mw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DM6PR02MB7098.namprd02.prod.outlook.com (2603:10b6:5:251::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Wed, 31 Jan
 2024 17:59:10 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd%5]) with mapi id 15.20.7249.017; Wed, 31 Jan 2024
 17:59:10 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
CC: "x86@kernel.org" <x86@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>, Arjan van de Ven
	<arjan@linux.intel.com>, Huang Rui <ray.huang@amd.com>, Juergen Gross
	<jgross@suse.com>, Dimitri Sivanich <dimitri.sivanich@hpe.com>, Sohil Mehta
	<sohil.mehta@intel.com>, K Prateek Nayak <kprateek.nayak@amd.com>, Kan Liang
	<kan.liang@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, "Paul E.
 McKenney" <paulmck@kernel.org>, Feng Tang <feng.tang@intel.com>, Andy
 Shevchenko <andy@infradead.org>, "Peter Zijlstra (Intel)"
	<peterz@infradead.org>
Subject: RE: [patch v2 15/30] x86/cpu: Detect real BSP on crash kernels
Thread-Topic: [patch v2 15/30] x86/cpu: Detect real BSP on crash kernels
Thread-Index: AQHaTf2my/8yESS52ke3R+ZOo/dqPLD0PdKg
Date: Wed, 31 Jan 2024 17:59:10 +0000
Message-ID:
 <SN6PR02MB4157A06A068D13F50B479AE0D47C2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240118123127.055361964@linutronix.de>
 <20240118123649.400523172@linutronix.de>
In-Reply-To: <20240118123649.400523172@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [pR717/Fefg47KQIf6hNH5YIn5gv7RumJ]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DM6PR02MB7098:EE_
x-ms-office365-filtering-correlation-id: 4fc266c6-d2ae-4759-33fb-08dc228653a2
x-ms-exchange-slblob-mailprops:
 Cq7lScuPrnp0HDrO/Vxd+DZ9iBsgRg0Hy9BvEs2ZDX9NmzZjJ4MnA+oe34vfEC/fo9uSUAv8/l/+9JJFp93sQSlMDschtK4h3lV6LlsBhkqLowu1Z+PZYG+iZQtPj40sL3naJPsPi3ZyNm9DulRAeCrt9VyDqqucUrEQPz1BbaWIKbtd9Lo3OD8u89SLCGfJgoVfxOBLilF1wQ5hwL2OhmGp8xoRBVwgbkKJFMG30xNILzvf5n7vwuvrou8WpovKEeOwI7F1F6/ZXB0AqMgnviqT+rEVChIrA5ynrRxW2fXdMpMlTMbrvTOU9UxJG9LH74iMFjycacRbJm7GOdqkvxoR/miItBAYKBK/g+b29W+h9a0MKaE16KwPpfXYUbZtr92VtXae8CgbnuV1PgzOn35IRNj1ymoU+RkwV+3LTQrKc12kUnQsaxxqeavhiDkucFi95JqxM8dFQzK60JUci8bPZ2UGnomCdnsuGTdLdlVv4QCYdN8G1O8HP+NGuFLtiHMGJpkL3BP1dGXCJprmQUOyV/sU/mVVWR/AOU0Ik1DcJCgYRG4+Gy4CkJfKAhDNKtn68u1haGoynVZ5hu2FgobIgHeDuHvrxf4uHDtcbrTajDGpAlC2FPgZ7gurlKr/lHAy52GMCRPk+Y3Baz9QCPxVlFi4r0GFsBWZfAZeIfNhQmEnivprF3Wo7Z72ncU5bC7EA7zXUz2bWtIm7WTdQW7mqPjFBux1Xy++AU74ElPoBCpLRzUZzt/VNojvDQvwzx7svDXl+54=
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 QobJvPbF0LK5WNJiTAFfmHvKI3XAQlO1pygfuNn/iNQBsLrhOMUnJkYlPcuMoOxWL1QGANzUwQuFxeCbXuZoYjioovLzTTEmhANfoIKm/AB8zCKyu637DKS5ZvIzNXZ/X/g4W3KAfGfRUR6Qnj1q7V6D+KOQNLN4xu6dbDcDsVALjhFgy9izdjEvcL8kwePuw9+juWsytpIrphk5I6f4i0IO3M8nBSxWiNxTL0xF1rOErBKD+5XNfV29pB3OOUAcSvYR7vjP69oYkWfaqv2+n7I0RE7THXPFuaoZi/b028AV5TzXSiVmsBtmrppyOp8SIWOTNWhD79Mp4bt/MH6WRMc1wfb9DkKfMlYsMa3Str7Bjl4BCC3djz2SPvGjX9hTWjiSlXcmU9XYuMtFp50mrbFVPyaNcxwwryn4wdel18/hXbTJfVPCyTc1l+wk2Kfpi+p4K/vWFOwzcVLlsaTqt6mvIKqmuUAayD2XhH8THY4VHqxcGqEMDP1gJlDIeOy9SIffqTjDIueQ4bKZx67+SyddIaQpTR88pTjakHl//NwJFiV03QryiKv5pCFSs7dU
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S3JQdmpyYVptelFGWFdpYW11L3dycm44Y1dKdGRNR3o0U1hYSkhqQ3piYUxZ?=
 =?utf-8?B?SU4vRzJaSkZERWRWV1VuOXRHbHJqT2YxL0x5by9jcmJ2Y20yZW9OOHNUY0Ri?=
 =?utf-8?B?NU5hc0NCc1VpQk9icllkUlZZTFV0SWZSZWRwV2QwbFRJcTRiSVJsbGp5RVVi?=
 =?utf-8?B?ckM2SDlKUDRpRGF2NmdxZXpMYXhlbkZ1VDZRcXBON3Y0Wk9GMm9BZXlHbjZo?=
 =?utf-8?B?TFFZQWMzYlFKYVJ2eHloeGpNcmhGeWRKMGlHbnNKZ1pDSVdUc2NXUVNyTDNk?=
 =?utf-8?B?Qk1uZ21kUW5TYjRZQzlXYlZ5MXVSQlA5ZjFQZm95eE12cjZNZG1wN3h3VEVG?=
 =?utf-8?B?NzYybWtEWnM5ZzE3UGdnRWk0TVplVTN6bVVSS3QrYzlid2Z5TWh3NzFoT1Nk?=
 =?utf-8?B?amZsdFhOT3AxR2RiN3F4bGdxdTZCc0dlYWRxNDBSMjIwWXNTN2lHa1BjdThU?=
 =?utf-8?B?WGJsaWVwMTVub3NlWXhvdjhiNnc0T214YkNoS3pOb2pQaThGd2w3cWg1d3lZ?=
 =?utf-8?B?WERaZVNEWmV3Z0YveGxCMjZTTlVIQVEySzVDbThXaVVuQ1lHOElCSzFEdng5?=
 =?utf-8?B?MnY0TXh0Tm1XZ0g2UGFCeUlZOEhLMk1RR3Z1Y1UraVNNdlVLeVBOeUFPaWxu?=
 =?utf-8?B?VU9YNnI3bUo2N0RFUUF2VDd3b1dWTHMvTnI1N200L1Rzd0FnZCtaSDV0ZDVR?=
 =?utf-8?B?aU1BWDRMQkN1NWdlNFpLcmlKVWVpTFFHZmRUWXViOGo5ZStVSmtxK2pqb3p3?=
 =?utf-8?B?VjkzVGJCeEprc2QvcllQWEFTcEpYU2lkUG5URzdTbS9JaGJuaFd4dGxLRC9y?=
 =?utf-8?B?NTVUSGNZZktoRjVZOURkRzVvWFJzeUttTVVrOHcwUWg2UTdNUDdDVlRvV0dV?=
 =?utf-8?B?cVk2NS81WlBtR2JIQ3FHUG13LzZXUXpDcmQrSHoyNUVKMXBEbm5JelVNeldj?=
 =?utf-8?B?a216cUdhcGxIUTZjc1lZQVZDc2R5QWhBS1ZVRTFSaGREL1ZBQU9UdkZxaXpK?=
 =?utf-8?B?a1Q3eDR1ajdqL1Z5T0RzZm1lSW5sUmpnQyt5TW0zZVlkN295ak9zb2QyU254?=
 =?utf-8?B?dlNWaFZDaVArTWo3UzN4T0lHL1djU1gxaWFLRVVMc29NaUZCSUF6c1l5MkJS?=
 =?utf-8?B?MXBaNWlLRTE0TUNxc3dYb01TbWlkZEpXdUVGVFB4c2dMUVpxL1YxMlJnM0pM?=
 =?utf-8?B?TmhyeStqRzJnSUt6OXR3R09Da2M3ZFhiUWtKaFIzOUMwaUUvSXMzSUI2d2c3?=
 =?utf-8?B?Q0ZHV0ZFc25POWJUYzh2WkZvMDZDdTBEL09BVjVIU1FFUkh6WWNwbHdrWjVh?=
 =?utf-8?B?elAyb3h1ZUNPNzBoUElwYjRqTXNFREtNeWUzTXh0Sjlob0dnTGVLY3hESzVh?=
 =?utf-8?B?STR2dTJtb2VKdGI5U0NTa0tVTkpNTVJVS09QKzRYNE1DTHJ4YTY1YmJLazA0?=
 =?utf-8?B?QTQxNFNWc2xYaHMvWHhxVFRRajUvdWZ1N0Y1MXRhVll0NVpHazg1UitLd0g3?=
 =?utf-8?B?ajJTaUpWT2lVZ3B1eEpEUHQybTBxK0JSUW1hRUYzSm1uMXNtVEFHYndBUkRa?=
 =?utf-8?B?dnNBc0kzOVpxaTRGUXJVRDRqL3A0OC9lZWZQS2F6SFc1NERxVkdCN0lZV3Fx?=
 =?utf-8?B?NDFxNFRCVkx6VGVGN0grRy9pWUhhYlE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fc266c6-d2ae-4759-33fb-08dc228653a2
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2024 17:59:10.3437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB7098

RnJvbTogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+IFNlbnQ6IFR1ZXNkYXks
IEphbnVhcnkgMjMsIDIwMjQgNToxMSBBTQ0KPiANCj4gV2hlbiBhIGtkdW1wIGtlcm5lbCBpcyBz
dGFydGVkIGZyb20gYSBjcmFzaGluZyBDUFUgdGhlbiB0aGVyZSBpcyBubw0KPiBndWFyYW50ZWUg
dGhhdCB0aGlzIENQVSBpcyB0aGUgcmVhbCBib290IENQVSAoQlNQKS4gSWYgdGhlIGtkdW1wIGtl
cm5lbA0KPiB0cmllcyB0byBvbmxpbmUgdGhlIEJTUCB0aGVuIHRoZSBJTklUIHNlcXVlbmNlIHdp
bGwgcmVzZXQgdGhlIG1hY2hpbmUuDQo+IA0KPiBUaGVyZSBpcyBhIGNvbW1hbmQgbGluZSBvcHRp
b24gdG8gcHJldmVudCB0aGlzLCBidXQgaW4gY2FzZSBvZiBuZXN0ZWQga2R1bXANCj4ga2VybmVs
cyB0aGlzIGlzIHdyb25nLg0KPiANCj4gQnV0IHRoYXQgY29tbWFuZCBsaW5lIG9wdGlvbiBpcyBu
b3QgcmVxdWlyZWQgYXQgYWxsIGJlY2F1c2UgdGhlIHJlYWwNCj4gQlNQIGlzIGVudW1lcmF0ZWQg
YXMgdGhlIGZpcnN0IENQVSBieSBmaXJtd2FyZS4gU3VwcG9ydCBmb3IgdGhlIG9ubHkNCj4ga25v
d24gc3lzdGVtIHdoaWNoIHdhcyBkaWZmZXJlbnQgKFZveWFnZXIpIGdvdCByZW1vdmVkIGxvbmcg
YWdvLg0KPiANCj4gRGV0ZWN0IHdoZXRoZXIgdGhlIGJvb3QgQ1BVIEFQSUMgSUQgaXMgdGhlIGZp
cnN0IEFQSUMgSUQgZW51bWVyYXRlZCBieQ0KPiB0aGUgZmlybXdhcmUuIElmIHRoZSBmaXJzdCBB
UElDIElEIGVudW1lcmF0ZWQgaXMgbm90IG1hdGNoaW5nIHRoZSBib290DQo+IENQVSBBUElDIElE
IHRoZW4gc2tpcCByZWdpc3RlcmluZyBpdC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFRob21hcyBH
bGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPg0KPiAtLS0NCj4gVjI6IENoZWNrIGZvciB0aGUg
Zmlyc3QgZW51bWVyYXRlZCBBUElDIElEIChSdWkpDQo+IC0tLQ0KDQpbc25pcF0NCg0KPiAgLyoq
DQo+ICsgKiB0b3BvbG9neV9yZWdpc3Rlcl9hcGljIC0gUmVnaXN0ZXIgYW4gQVBJQyBpbiBlYXJs
eSB0b3BvbG9neSBtYXBzDQo+ICsgKiBAYXBpY19pZDoJVGhlIEFQSUMgSUQgdG8gc2V0IHVwDQo+
ICsgKiBAYWNwaV9pZDoJVGhlIEFDUEkgSUQgYXNzb2NpYXRlZCB0byB0aGUgQVBJQw0KPiArICog
QHByZXNlbnQ6CVRydWUgaWYgdGhlIGNvcnJlc3BvbmRpbmcgQ1BVIGlzIHByZXNlbnQNCj4gKyAq
Lw0KPiArdm9pZCBfX2luaXQgdG9wb2xvZ3lfcmVnaXN0ZXJfYXBpYyh1MzIgYXBpY19pZCwgdTMy
IGFjcGlfaWQsIGJvb2wgcHJlc2VudCkNCj4gK3sNCj4gKwlpZiAoYXBpY19pZCA+PSBNQVhfTE9D
QUxfQVBJQykgew0KPiArCQlwcl9lcnJfb25jZSgiQVBJQyBJRCAleCBleGNlZWRzIGtlcm5lbCBs
aW1pdCBvZjogJXhcbiIsIGFwaWNfaWQsIE1BWF9MT0NBTF9BUElDIC0gMSk7DQo+ICsJCXRvcG9f
aW5mby5ucl9yZWplY3RlZF9jcHVzKys7DQo+ICsJCXJldHVybjsNCj4gKwl9DQo+ICsNCj4gKwkv
KiBDUFUgbnVtYmVycyBleGhhdXN0ZWQ/ICovDQo+ICsJaWYgKHRvcG9faW5mby5ucl9hc3NpZ25l
ZF9jcHVzID49IG5yX2NwdV9pZHMpIHsNCg0KSSdtIHNlZWluZyBhIHByb2JsZW0gaGVyZSB3aGVu
IG5yX2NwdXM9MSBvbiB0aGUga2VybmVsIGJvb3QgbGluZQ0KaW4gYW4gb3RoZXJ3aXNlIG11bHRp
cHJvY2Vzc29yIHN5c3RlbS4gIHRvcG9faW5mby5ucl9hc3NpZ25lZF9jcHVzDQppcyBzdGF0aWNh
bGx5IGluaXRpYWxpemVkIHRvICIxIiwgc28gd2hlbiBucl9jcHVzX2lkcyBpcyAiMSIsIHRoaXMg
dGVzdA0KaXMgdHJ1ZSBldmVyeSB0aW1lIHRoaXMgZnVuY3Rpb24gaXMgY2FsbGVkLCBpbmNsdWRp
bmcgZm9yIHRoZSBmaXJzdCBBUElDDQplbnVtZXJhdGVkIGZyb20gdGhlIE1BRFQuICAgVGhlIHdh
cm5pbmcgbWVzc2FnZSBpcyBvdXRwdXQgb25jZSwNCmFuZCBpdCdzIGNvcnJlY3QuICBCdXQgdG9w
b19pbmZvLm5yX3JlamVjdGVkX2NwdXMgaXMgaW5jcmVtZW50ZWQNCndoZW4gaXQgc2hvdWxkbid0
IGJlIHNvIHRoZSBudW1iZXIgb2YgcmVqZWN0ZWQgQ1BVcyBpcyByZXBvcnRlZCBhcw0KdGhlICMg
b2YgQ1BVcyBpbiB0aGUgc3lzdGVtLg0KDQpUaGUgIyBvZiByZWplY3RlZCBDUFVzIG1lc3NhZ2Ug
aXMganVzdCBjb3NtZXRpYy4gQnV0IHdvcnNlLA0KY2hlY2tfZm9yX3JlYWxfYnNwKCkgYW5kIHRv
cG9fcmVnaXN0ZXJfYXBpYygpIGFyZSBuZXZlciBjYWxsZWQuIEluDQphIGtkdW1wIGtlcm5lbCB3
aGVyZSB0aGUgcGFuaWMnaW5nIENQVSBpcyBub3QgcGh5c2ljYWwgQ1BVIHplcm8sDQpJIGRvbid0
IGdldCBhbnkgbWVzc2FnZXMgZnJvbSBjaGVja19mb3JfcmVhbF9ic3AoKS4NCg0KTWljaGFlbA0K
DQo+ICsJCXByX3dhcm5fb25jZSgiQ1BVIGxpbWl0IG9mICVkIHJlYWNoZWQuIElnbm9yaW5nIGZ1
cnRoZXIgQ1BVc1xuIiwgbnJfY3B1X2lkcyk7DQo+ICsJCXRvcG9faW5mby5ucl9yZWplY3RlZF9j
cHVzKys7DQo+ICsJCXJldHVybjsNCj4gKwl9DQo+ICsNCj4gKwlpZiAoY2hlY2tfZm9yX3JlYWxf
YnNwKGFwaWNfaWQpKQ0KPiArCQlyZXR1cm47DQo+ICsNCj4gKwl0b3BvX3JlZ2lzdGVyX2FwaWMo
YXBpY19pZCwgYWNwaV9pZCwgcHJlc2VudCk7DQo+ICt9DQo+ICsNCg==

