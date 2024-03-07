Return-Path: <linux-kernel+bounces-96309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EDF8759FF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 23:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3C3EB21E87
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 22:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6228913DBBE;
	Thu,  7 Mar 2024 22:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b="eIEWW1n5"
Received: from PAUP264CU001.outbound.protection.outlook.com (mail-francecentralazon11021011.outbound.protection.outlook.com [52.101.167.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC1C13BAC3;
	Thu,  7 Mar 2024 22:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.167.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709849377; cv=fail; b=V3VHuoBTWGaPVDgCDsrNV+XQ7Qn2IEY+04+lEtPOqKdE2avUfiBMz3G6KwJiqD0A5L4BFVlgEtjg+4oki/g12p/6JjL6rJwAdhjJe6Ii7dxhRJLjFxI2dgDYFuclgxXPvRCbo9h4h9TEdxIcKhELefUdGwRAlDjws/dwipiLBIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709849377; c=relaxed/simple;
	bh=njb1lG0QZJi7X4zY9/M+PnfCACEuxMn8PkuU1eB4ZeA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bNjb42tvhDBfVCMyXDZ8Pglihvp9SnyvXNFTmREDqUczWQ4n9baj8SLUdX+OVBQ6+tPjzFZ3NaSffkk3HJt4w3nvhuSprwx3TkH6L50KgXSZ9MeQq9isjHBZL6qLQIYVUP+OdNIbnica+7ZIouxJ26RDbdd4JViyHDSC+pb+ATE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b=eIEWW1n5; arc=fail smtp.client-ip=52.101.167.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RedWYBykVRHTgwp8qASDZuBawYHMZkfFCARwN8Fw12L7N1/Hj1nazajatSYKZJJDY+Ap6BJeWnFBFIpAxFuRiDtN/ZyZdtzFHl0uh8xe18kvovI+z4T2LIqQtT9+X1KHvk491/P2+XJhl5NZdJvGfxtv76oIv3VU6P8Yj9+1oYUEpxihjK6IWZyJcOJK+V8NPZ6gNlIwjieY7zqcqDeDB/ac24zzDEGCy2YKowttKlsY/IsN3fW51EFnY+exqVc/Jj8EKStY5H5aiJwHM8gifrPz8Bx/4uGy/KJADf13peHunIl6wv9Gp1FM2gNu92FwsFtBeL1e4Lv1xeH8dcnabw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=njb1lG0QZJi7X4zY9/M+PnfCACEuxMn8PkuU1eB4ZeA=;
 b=G92ag3wm8rY6Ahf6k5bFUFgzYD2/BJD5tLnnO1m77reWLpKYlz+jKyjPM6ys0wOA3GC9VWf2jvhuGV72cbgJEB8oiQaTDEjeznx8DSCRVQDrcgwrSbq67KsPUYt64T00CrNScvCdatY83rdRRut6Wj6+U3hQ39SfvUuhw4jj7GLEL6vGluHxo3bcWLkQCQ/7RBCDXgcnX7dKcqs1qIzCpkj3g8sVb01Aro6VNidt80ShIAfTXWl3ohaHxrlgWTGR9uiUC7PkIDB4au4ikPCew/enUSBCGJpTuGXmXy42gMZX23jVmoHh2w2fL0DF4JvA9zVewYQ5fNj33BajV8I+Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njb1lG0QZJi7X4zY9/M+PnfCACEuxMn8PkuU1eB4ZeA=;
 b=eIEWW1n5Vy23Qe0RNppmwvnwSIDl0DThIwLj4JvIUzpKDGTZV1Zk1WSyQdGtzn0nYZTc05fJRKxgmUYxtkbJDnUE50PLsDCE6S1o6qMIAfJgM8rCwhrFParunIEOdBp5BLXKEtraUyJgGJPBOmiXQYAYupsaFtbmTaEgJ+SoHUrQEKmOESty9kHk07W7A0GDDxy09ga7kieKI+Js25sjAyYT02Hr2K3TeBgWFILmihcRdkhPIgtXRmypiisIgKuFvIxh2rekWrEVaV0OFLS0+p7BcQI3g9JsvErCJhjHxoZzBTLC3HVgIBzgYm+4KuOhwn1++z+6FlTsFj60vzMfFQ==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB2235.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:15::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Thu, 7 Mar
 2024 22:09:31 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c192:d40f:1c33:1f4e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c192:d40f:1c33:1f4e%6]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 22:09:31 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Calvin Owens <jcalvinowens@gmail.com>, Luis Chamberlain
	<mcgrof@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alexei
 Starovoitov <ast@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Naveen N Rao <naveen.n.rao@linux.ibm.com>,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, David S Miller
	<davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH 2/4] bpf: Allow BPF_JIT with CONFIG_MODULES=n
Thread-Topic: [RFC][PATCH 2/4] bpf: Allow BPF_JIT with CONFIG_MODULES=n
Thread-Index: AQHacAITOav1MY0noEakQNWRTlTZ/7Es2DuA
Date: Thu, 7 Mar 2024 22:09:31 +0000
Message-ID: <a7ac9672-06d1-4f6a-b676-01c9868ea39c@csgroup.eu>
References: <cover.1709676663.git.jcalvinowens@gmail.com>
 <afebd15dd032f908e46871bec5be438063ae7458.1709676663.git.jcalvinowens@gmail.com>
In-Reply-To:
 <afebd15dd032f908e46871bec5be438063ae7458.1709676663.git.jcalvinowens@gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MR1P264MB2235:EE_
x-ms-office365-filtering-correlation-id: 11265771-7ad4-4b8b-3613-08dc3ef343d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 3Cpp67mPzfuRnjl2wBrZloWUoQKdtWV21uJkF2KcRRAtq2RVUVs4O3wPMPJn/XzxHYNW2S0g1eeSLAClh9ITx7/5wtbMoofaHCTwaI8u+q2WP+S6vqAar26BPFE07EeWfLqeX8Db6+P57SRe7RaKVQL3OsGzdSPgKS5T34kAVDJhtZ3EQlx/0cQGQ4ggymlvqIKbeFgK2stXuLDhQ1gSITMm/RW9aVxA5e6hIGxtOC0aSE1xNhym18cvu96RSxP2OBGWL75AIbXzwSIcaQiBOaGYEwF8nTbVVFQS/2tZV360f7k89U7YMTEKKA9S4o+l7OAywfnSpt3rgroFFAHtk6rH/xpOo2U4WxfvB//B2LDcWRmZEUt8zXIIy88aixGtTWBTupHht0F78o8lPNoWjMdhFly8fohGHpZrhz1GQS7/ZHIhL+YzKuAfh6vr2wQ3z9u9pD5+IoLJbFoOlcQD3AZYOccwEXIXHmc24olpeCDS3WAiOHNbPVwRJ2hZQ6uJmVQjVlN9Vi1JPpKmfJSTbBM36tYfwdvP00njxo1SvuzLVp1+GbHzp30orOG12hdzFoSFo9HZeEteqnqXyT9gckEWrE+u7kMqW/NohdlUNJG3PsN0bv3JEfbRU0Pd9gteJ/jGx7RqnQNnqPhyK2BZAUN1ggpTVkDDsDiX0iIM1LTsgUTNU3G7YrYhcF3Nkd0W
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009)(921011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aXhneDZwYUthOGhsUkxIdDg2RWMxeURDQzVZQXpiTWJIcTRLdFlsdkpTMkpx?=
 =?utf-8?B?a3AyaUtBVmZvNDhUUzQwdzdhd0ZVcC9kcmltMW9yWmxiSzJ6QnB5SjkyUjcr?=
 =?utf-8?B?S0ZsNno5SHF1NG9XWDlmU1k4dkZyVmc0VHlQMlgwTVRvZUVzaTQwTXlhcEYv?=
 =?utf-8?B?QklsNTRIeWtCamRyMmcvSFNZRk12OEJLWjVhMVNVVGlxUUFQeTA1Z3E0VkJj?=
 =?utf-8?B?RTQxdnBsUUtSeGxYQkhVUWVLdFFFRFNRN21QVmRka2JOa20xb0RYYmJsSk53?=
 =?utf-8?B?L1Q4Y2YwdEI0WXJNVEVaVEcrL0NqY2ZVWTExVm82cE9GRzU2bTNaT2hKR0h2?=
 =?utf-8?B?cUs2M3Vlb0Y3ZUdYSXpRTmVPMmJXOGs0NHRsUGl3Q1hYTTVKTnpxRWhURU1K?=
 =?utf-8?B?aGUwYUxYSGI5anYzOEl2OTc1UWJKWS9rY0JkUDIySTZhVmhEc2gxeTZ1VWN3?=
 =?utf-8?B?Vm5yaUh3RGlmeUJyM0lnMDdaalBMMEt5eFhpSmdIRFVWY1ZIZVRPWGxGM2pL?=
 =?utf-8?B?anNFaXpZZ0prTDM4MVRNWUplRys2b0I1dll5WkdrcjhHNGIvTW1SOHBHSU9N?=
 =?utf-8?B?Y0JXVGZUVkg2cTZuUGo4QTJoQWlEMTRubkhSU0RaVy9EbDBpYkZCV0JTUGxi?=
 =?utf-8?B?cnZEQ2loTWZUSm4xUjhqdDdpd2pENmoydkNPUVFTREIzWk1vOFdzVVJSTmlY?=
 =?utf-8?B?bVVUeE1qQWZPT2l4by83VTJERlQrTm1sRFVkVjFHRUNxbFlaenFFOFU1b0Fk?=
 =?utf-8?B?aXlKNkMwU3hnb3o4QkZ6cGU2WXZsTVduMkw2dnVMZnNDZmM4dThQTUtiazZi?=
 =?utf-8?B?VUpMZVo2OWxBSEd3TkRiYmFUSXVJcW4zNlZwOUpLWUJTSFVwVjlKc1B5WkxI?=
 =?utf-8?B?bENOaTcxQ01XaWFTZ3FXWmt2dEpFWW5Vay9sUDN5bW9QZ3VmRUhIZWFQSXVm?=
 =?utf-8?B?VzBhUGVabHJlMkxpVXlCYnpUeFVUSFpzRFh0d2tSZHNZYURlc0EzRzdleXRw?=
 =?utf-8?B?ZHVERlFkalpBbU5kQ24yRnFKVVJzQkdCRG8zSGhpVE9QNk90K1E0aVVmRnRx?=
 =?utf-8?B?VmhyTy9SSmkxWVY2R0NEK3pMUE5EbU9oVTJxb20wRVlGc20rZ1NiUzlBSUh4?=
 =?utf-8?B?OUNmUHhQTm84MGVQcmFtS3ZpVER6RzZNNGFCZXU0MXMzdjV6QlQ2QzNYNlZR?=
 =?utf-8?B?Y0VMNmhKTGhrejd1azFFZ1RRalp6WTN5MXdyeHJZSmdIUDFyQVN6VWNZNXR0?=
 =?utf-8?B?L1VLTHREMWFjS3NXZDRwWjVGclBFVHBGVEQ2OTVZSCtoekhiNkRMVkdkOUlx?=
 =?utf-8?B?ZUQzbk5VM3pLY3U4OENyaEVYaXFJMUMzSlVRaFVQQnUwZVpmWlhSUk9kbjY2?=
 =?utf-8?B?R3hmYjFjY2N0MzhNeFNuT29kUXg0aVVUVEl5eCtObXBuMGtOcXdXWW5qckZi?=
 =?utf-8?B?TXVOb2s2Qms3cmNJMkpua2ZQUklHRktBRWhoUWdrZkVZR2N1N1ZuQmZ1aG96?=
 =?utf-8?B?TDhsb0x5YUtTSXZvVU9zQXgwN2hVSWFXcVZrRU1lekU4eEMrYTc5Vnc1bWVX?=
 =?utf-8?B?bm5KMXpLYTN0OGRMYnpNT3FaV1ZjdWZXZ2ZNRzJGVkxoeVhwaC9NMkVDSk4z?=
 =?utf-8?B?UGRvVTdEYkViVm1EcUlianBPK0RFMjM1QUZiazUxTFRGb1VxY2o2K1NNUnAy?=
 =?utf-8?B?Z0NnOWRXZVJjeGx1T0kwbU5tWVQwL0VseWJXZGxMeWJFSVZLTmdoVDBxakdj?=
 =?utf-8?B?UHpUaENBelNPR3lvZUxob2VzMGRhNHFtNEJnSlA5d3U5WmMrOFpldXRKdDZn?=
 =?utf-8?B?SHpyL0V2SW5kV2QrYUJ5dkV6OW5wbUxBQkJIR0xidE9xQXlRenN4M0ZOWU0y?=
 =?utf-8?B?U3dMTjhrcmpNcTJJRzdiMCt3TUk0V1V1NUNEOU5jOS9Ec2hjVGgwZVdaa2tH?=
 =?utf-8?B?VHBodUk3UlNwcktDdlZwcjVFK1NMTitDbFloOGUvNUtFdG5JditzMmgrdGFI?=
 =?utf-8?B?UmZLMU50MUgzNHRyTVdOTVVuUWQrNkRCSytYTTRkdmNNY0pQSzhTS1hEZVp1?=
 =?utf-8?B?QzJzbDVDR01MbFd4L3Azd0dCVnFlTEF6OVJyeWZqajN3US9KOStaTUhmc1ZE?=
 =?utf-8?B?bUVUbVUwZDVOdzh4ekRVTElQZGpwcFR4c0hYMmdoeGxjeFhPVTFXcXJIL0pN?=
 =?utf-8?B?d1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B26788E301691B40B7595B7D41C31262@FRAP264.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 11265771-7ad4-4b8b-3613-08dc3ef343d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 22:09:31.5580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: osRxyW/S7VbvVAj67LwK8PH/DM3T/rx9hvcrp1nrxGejVJyJQ5ToGZ73Sj6rAf1elCuuTXXTSOvxwurHuzy7F+bJiPbYWAEjaPWfdD192lQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2235

DQoNCkxlIDA2LzAzLzIwMjQgw6AgMjE6MDUsIENhbHZpbiBPd2VucyBhIMOpY3JpdMKgOg0KPiBb
Vm91cyBuZSByZWNldmV6IHBhcyBzb3V2ZW50IGRlIGNvdXJyaWVycyBkZSBqY2Fsdmlub3dlbnNA
Z21haWwuY29tLiBEw6ljb3V2cmV6IHBvdXJxdW9pIGNlY2kgZXN0IGltcG9ydGFudCDDoCBodHRw
czovL2FrYS5tcy9MZWFybkFib3V0U2VuZGVySWRlbnRpZmljYXRpb24gXQ0KPiANCj4gTm8gQlBG
IGNvZGUgaGFzIHRvIGNoYW5nZSwgZXhjZXB0IGluIHN0cnVjdF9vcHMgKGZvciBtb2R1bGUgcmVm
cykuDQo+IA0KPiBUaGlzIGNvbmZsaWN0cyB3aXRoIGJwZi1uZXh0IGJlY2F1c2Ugb2YgdGhpcyAo
cmVsZXZhbnQpIHNlcmllczoNCj4gDQo+ICAgICAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxs
LzIwMjQwMTE5MjI1MDA1LjY2ODYwMi0xLXRoaW5rZXIubGlAZ21haWwuY29tLw0KPiANCj4gSWYg
c29tZXRoaW5nIGxpa2UgdGhpcyBpcyBtZXJnZWQgZG93biB0aGUgcm9hZCwgaXQgY2FuIGdvIHRo
cm91Z2gNCj4gYnBmLW5leHQgYXQgbGVpc3VyZSBvbmNlIHRoZSBtb2R1bGVfYWxsb2MgY2hhbmdl
IGlzIGluOiBpdCdzIGEgb25lLXdheQ0KPiBkZXBlbmRlbmN5Lg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogQ2FsdmluIE93ZW5zIDxqY2Fsdmlub3dlbnNAZ21haWwuY29tPg0KPiAtLS0NCj4gICBrZXJu
ZWwvYnBmL0tjb25maWcgICAgICAgICAgfCAgMiArLQ0KPiAgIGtlcm5lbC9icGYvYnBmX3N0cnVj
dF9vcHMuYyB8IDI4ICsrKysrKysrKysrKysrKysrKysrKysrKy0tLS0NCj4gICAyIGZpbGVzIGNo
YW5nZWQsIDI1IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEva2VybmVsL2JwZi9LY29uZmlnIGIva2VybmVsL2JwZi9LY29uZmlnDQo+IGluZGV4IDZhOTA2
ZmY5MzAwNi4uNzdkZjQ4M2E4OTI1IDEwMDY0NA0KPiAtLS0gYS9rZXJuZWwvYnBmL0tjb25maWcN
Cj4gKysrIGIva2VybmVsL2JwZi9LY29uZmlnDQo+IEBAIC00Miw3ICs0Miw3IEBAIGNvbmZpZyBC
UEZfSklUDQo+ICAgICAgICAgIGJvb2wgIkVuYWJsZSBCUEYgSnVzdCBJbiBUaW1lIGNvbXBpbGVy
Ig0KPiAgICAgICAgICBkZXBlbmRzIG9uIEJQRg0KPiAgICAgICAgICBkZXBlbmRzIG9uIEhBVkVf
Q0JQRl9KSVQgfHwgSEFWRV9FQlBGX0pJVA0KPiAtICAgICAgIGRlcGVuZHMgb24gTU9EVUxFUw0K
PiArICAgICAgIHNlbGVjdCBNT0RVTEVfQUxMT0MNCj4gICAgICAgICAgaGVscA0KPiAgICAgICAg
ICAgIEJQRiBwcm9ncmFtcyBhcmUgbm9ybWFsbHkgaGFuZGxlZCBieSBhIEJQRiBpbnRlcnByZXRl
ci4gVGhpcyBvcHRpb24NCj4gICAgICAgICAgICBhbGxvd3MgdGhlIGtlcm5lbCB0byBnZW5lcmF0
ZSBuYXRpdmUgY29kZSB3aGVuIGEgcHJvZ3JhbSBpcyBsb2FkZWQNCj4gZGlmZiAtLWdpdCBhL2tl
cm5lbC9icGYvYnBmX3N0cnVjdF9vcHMuYyBiL2tlcm5lbC9icGYvYnBmX3N0cnVjdF9vcHMuYw0K
PiBpbmRleCAwMjA2OGJkMGU0ZDkuLmZiZjA4YTFiYjAwYyAxMDA2NDQNCj4gLS0tIGEva2VybmVs
L2JwZi9icGZfc3RydWN0X29wcy5jDQo+ICsrKyBiL2tlcm5lbC9icGYvYnBmX3N0cnVjdF9vcHMu
Yw0KPiBAQCAtMTA4LDExICsxMDgsMzAgQEAgY29uc3Qgc3RydWN0IGJwZl9wcm9nX29wcyBicGZf
c3RydWN0X29wc19wcm9nX29wcyA9IHsNCj4gICAjZW5kaWYNCj4gICB9Ow0KPiANCj4gKyNpZiBJ
U19FTkFCTEVEKENPTkZJR19NT0RVTEVTKQ0KDQpDYW4geW91IGF2b2lkIGlmZGVmcyBhcyBtdWNo
IGFzIHBvc3NpYmxlID8NCg0KPiAgIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYnRmX3R5cGUgKm1vZHVs
ZV90eXBlOw0KPiANCj4gK3N0YXRpYyBpbnQgYnBmX3N0cnVjdF9tb2R1bGVfdHlwZV9pbml0KHN0
cnVjdCBidGYgKmJ0ZikNCj4gK3sNCj4gKyAgICAgICBzMzIgbW9kdWxlX2lkOw0KDQpDb3VsZCBi
ZToNCg0KCWlmICghSVNfRU5BQkxFRChDT05GSUdfTU9EVUxFUykpDQoJCXJldHVybiAwOw0KDQo+
ICsNCj4gKyAgICAgICBtb2R1bGVfaWQgPSBidGZfZmluZF9ieV9uYW1lX2tpbmQoYnRmLCAibW9k
dWxlIiwgQlRGX0tJTkRfU1RSVUNUKTsNCj4gKyAgICAgICBpZiAobW9kdWxlX2lkIDwgMCkNCj4g
KyAgICAgICAgICAgICAgIHJldHVybiAxOw0KPiArDQo+ICsgICAgICAgbW9kdWxlX3R5cGUgPSBi
dGZfdHlwZV9ieV9pZChidGYsIG1vZHVsZV9pZCk7DQo+ICsgICAgICAgcmV0dXJuIDA7DQo+ICt9
DQo+ICsjZWxzZQ0KPiArc3RhdGljIGludCBicGZfc3RydWN0X21vZHVsZV90eXBlX2luaXQoc3Ry
dWN0IGJ0ZiAqYnRmKQ0KPiArew0KPiArICAgICAgIHJldHVybiAwOw0KPiArfQ0KPiArI2VuZGlm
DQo+ICsNCj4gICB2b2lkIGJwZl9zdHJ1Y3Rfb3BzX2luaXQoc3RydWN0IGJ0ZiAqYnRmLCBzdHJ1
Y3QgYnBmX3ZlcmlmaWVyX2xvZyAqbG9nKQ0KPiAgIHsNCj4gLSAgICAgICBzMzIgdHlwZV9pZCwg
dmFsdWVfaWQsIG1vZHVsZV9pZDsNCj4gKyAgICAgICBzMzIgdHlwZV9pZCwgdmFsdWVfaWQ7DQo+
ICAgICAgICAgIGNvbnN0IHN0cnVjdCBidGZfbWVtYmVyICptZW1iZXI7DQo+ICAgICAgICAgIHN0
cnVjdCBicGZfc3RydWN0X29wcyAqc3Rfb3BzOw0KPiAgICAgICAgICBjb25zdCBzdHJ1Y3QgYnRm
X3R5cGUgKnQ7DQo+IEBAIC0xMjUsMTIgKzE0NCwxMCBAQCB2b2lkIGJwZl9zdHJ1Y3Rfb3BzX2lu
aXQoc3RydWN0IGJ0ZiAqYnRmLCBzdHJ1Y3QgYnBmX3ZlcmlmaWVyX2xvZyAqbG9nKQ0KPiAgICNp
bmNsdWRlICJicGZfc3RydWN0X29wc190eXBlcy5oIg0KPiAgICN1bmRlZiBCUEZfU1RSVUNUX09Q
U19UWVBFDQo+IA0KPiAtICAgICAgIG1vZHVsZV9pZCA9IGJ0Zl9maW5kX2J5X25hbWVfa2luZChi
dGYsICJtb2R1bGUiLCBCVEZfS0lORF9TVFJVQ1QpOw0KPiAtICAgICAgIGlmIChtb2R1bGVfaWQg
PCAwKSB7DQo+ICsgICAgICAgaWYgKGJwZl9zdHJ1Y3RfbW9kdWxlX3R5cGVfaW5pdChidGYpKSB7
DQo+ICAgICAgICAgICAgICAgICAgcHJfd2FybigiQ2Fubm90IGZpbmQgc3RydWN0IG1vZHVsZSBp
biBidGZfdm1saW51eFxuIik7DQo+ICAgICAgICAgICAgICAgICAgcmV0dXJuOw0KPiAgICAgICAg
ICB9DQo+IC0gICAgICAgbW9kdWxlX3R5cGUgPSBidGZfdHlwZV9ieV9pZChidGYsIG1vZHVsZV9p
ZCk7DQo+IA0KPiAgICAgICAgICBmb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRShicGZfc3RydWN0
X29wcyk7IGkrKykgew0KPiAgICAgICAgICAgICAgICAgIHN0X29wcyA9IGJwZl9zdHJ1Y3Rfb3Bz
W2ldOw0KPiBAQCAtNDMzLDEyICs0NTAsMTUgQEAgc3RhdGljIGxvbmcgYnBmX3N0cnVjdF9vcHNf
bWFwX3VwZGF0ZV9lbGVtKHN0cnVjdCBicGZfbWFwICptYXAsIHZvaWQgKmtleSwNCj4gDQo+ICAg
ICAgICAgICAgICAgICAgbW9mZiA9IF9fYnRmX21lbWJlcl9iaXRfb2Zmc2V0KHQsIG1lbWJlcikg
LyA4Ow0KPiAgICAgICAgICAgICAgICAgIHB0eXBlID0gYnRmX3R5cGVfcmVzb2x2ZV9wdHIoYnRm
X3ZtbGludXgsIG1lbWJlci0+dHlwZSwgTlVMTCk7DQo+ICsNCj4gKyNpZiBJU19FTkFCTEVEKENP
TkZJR19NT0RVTEVTKQ0KDQpDYW4ndCBzZWUgYW55dGhpbmcgZGVwZW5kaW5nIG9uIENPTkZJR19N
T0RVTEVTIGhlcmUsIGNhbiB5b3UgaW5zdGVhZCBkbzoNCg0KCQlpZiAoSVNfRU5BQkxFRChDT05G
SUdfTU9EVUxFUykgJiYgcHR5cGUgPT0gbW9kdWxlX3R5cGUpIHsNCg0KPiAgICAgICAgICAgICAg
ICAgIGlmIChwdHlwZSA9PSBtb2R1bGVfdHlwZSkgew0KPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgaWYgKCoodm9pZCAqKikodWRhdGEgKyBtb2ZmKSkNCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgZ290byByZXNldF91bmxvY2s7DQo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAqKHZvaWQgKiopKGtkYXRhICsgbW9mZikgPSBCUEZfTU9EVUxFX09XTkVSOw0KPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgY29udGludWU7DQo+ICAgICAgICAgICAgICAgICAgfQ0KPiArI2Vu
ZGlmDQo+IA0KPiAgICAgICAgICAgICAgICAgIGVyciA9IHN0X29wcy0+aW5pdF9tZW1iZXIodCwg
bWVtYmVyLCBrZGF0YSwgdWRhdGEpOw0KPiAgICAgICAgICAgICAgICAgIGlmIChlcnIgPCAwKQ0K
PiAtLQ0KPiAyLjQzLjANCj4gDQo+IA0K

