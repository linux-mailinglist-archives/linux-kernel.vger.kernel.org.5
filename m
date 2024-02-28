Return-Path: <linux-kernel+bounces-85833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FB386BBFB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66C801C2219D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 23:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC2513D309;
	Wed, 28 Feb 2024 23:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b="hvUGc5k/"
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-pr2fra01on2134.outbound.protection.outlook.com [40.107.12.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DB913D2F9;
	Wed, 28 Feb 2024 23:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.12.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709161848; cv=fail; b=oDCoCoXQbGsqIXgNkOVQ9OnjuNGRwYTVSvDtMwJ4IU5nWjJhPAoqWvZ9yJPE8PHEdYuB8ggiPCBDiSRuXwV0ZELKrpfu4sDJ0zhny7Pc7aYHxCwnBAI2HMmT/FNjIEwC+/uyHhL5IcxEWHfBNG0MgScEL6qVYTGKPGYBILx/SWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709161848; c=relaxed/simple;
	bh=xrN8UnRT+YB396jDlQtIBeQ1iVSJ4yZl010chlIxSho=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rnGIH9xYVA5ADGjp//WpcMVe++Tcv9pddHTz4NFIn9sNFGps1VBM/wcVwijkh0hSRIgZw+TnTdbRHtuha9pAS/5TZ0gynK60Wa78WRILfhMmcyP99HhTj4jfnFVkDVRHTfswpET+K5vH19/3zQWSoT2fnOhg3i3LZQ+oKTWQK9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b=hvUGc5k/; arc=fail smtp.client-ip=40.107.12.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h4O/c0fpWoXvXU9vFgeDS5i+9LWpDSYZQjVWQdBImAgR0OyAf3SPBRfSj4IMT5q9lUvMIpZuU+PI9sxWYYwI1dksGmfCUChjFxBXCKmB4cJZxvNN/eGQ+3f81GnIUWd165KUwVorHzpLeW+cWrFDI6jV/qw5uA8lf59qYwaHv01kvvfY5zuO1469Qx5DLXuVE5/bXjprRSLegE4trV1vgZtSRNUcG6oK8YJxtGPJx/Z+UlopiPNrRRIyjLnzt6iUkkB4HUJ43Xw96L4q5hSLRnhVlq4G2w0Lu1vWTsC+55YYPuFzm5ipt+Irin2pSoJY0FVjl4Ad/PlM4RRpaohBwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xrN8UnRT+YB396jDlQtIBeQ1iVSJ4yZl010chlIxSho=;
 b=gHr/wu1LhTwxhITn6UA6C+Q2E/IGAmrXMACyB29X1ydNOMZ+e/25IJZiX0v52hzjuXmdGM6dF25VsEGe+Ittr5j/SmZ6xerKQcCHkfIOK32VbOMMrYgInvyTWz4Dws25FBRBPgjeznYNRgkDwwBUBPs7o+wRqyKKjin9iahyM4yE0WVHw1vOI/OPKGUj88XJnGkCpAWFv6orKV8iHx13VGLFhaV2fvC68qsSuUE0vxf056+oEXep2cMmTM3hVXXzXq3zoMHQSiJfAawVu7LWBBchZXL9NkvgfAbjk1yUyRuz2R2qbNIisVzVQoFSQO84xMvy/BEACCmLBfDPmqlPiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrN8UnRT+YB396jDlQtIBeQ1iVSJ4yZl010chlIxSho=;
 b=hvUGc5k/Ak4DP3gSKTds39h/6azSetsXI1ftOxNvj/43wwg3RF6ovnki2qp8WMZKTFpuakjAdDE0Sg9yduE6tR5JVQhDhZ+OkaNOWLbxCJu6tYZHFgbexknFM5z+x+r7TptVsXk4bjD2proIrIkdohtrk9tuB47o08aBhYmn4oIqSvRd23QxLDv5Kz3TrlZ+XyKFdIQs4/ZyStZzp8YNkDsPqv/QrkqiRqOu21EeIV/hylFNBM9ycoGF6UdOOXfFaQFuE1DG6UDLs7yJic1zipn7COv1n+RBIhEjFiKi9rEba1oqXBJ/OLjue4K3Bu2h5+6IJI0ZdktP0BBziCdGHA==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PAZP264MB3005.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Wed, 28 Feb
 2024 23:10:43 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c192:d40f:1c33:1f4e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c192:d40f:1c33:1f4e%6]) with mapi id 15.20.7316.039; Wed, 28 Feb 2024
 23:10:43 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "keescook@chromium.org"
	<keescook@chromium.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "luto@kernel.org" <luto@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"debug@rivosinc.com" <debug@rivosinc.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "linux-sh@vger.kernel.org"
	<linux-sh@vger.kernel.org>, "linux-csky@vger.kernel.org"
	<linux-csky@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "linux-parisc@vger.kernel.org"
	<linux-parisc@vger.kernel.org>, "loongarch@lists.linux.dev"
	<loongarch@lists.linux.dev>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>,
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"bp@alien8.de" <bp@alien8.de>, "linux-s390@vger.kernel.org"
	<linux-s390@vger.kernel.org>, "linux-alpha@vger.kernel.org"
	<linux-alpha@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mips@vger.kernel.org"
	<linux-mips@vger.kernel.org>, "sparclinux@vger.kernel.org"
	<sparclinux@vger.kernel.org>, "broonie@kernel.org" <broonie@kernel.org>
Subject: Re: [PATCH v2 5/9] mm: Initialize struct vm_unmapped_area_info
Thread-Topic: [PATCH v2 5/9] mm: Initialize struct vm_unmapped_area_info
Thread-Index:
 AQHaaOd3T09DEeJabki6TgRFYbqm47EdxC4AgAC5pgCAAAKNAIAAJBAAgAEcAgCAAD1QgIAAZyKA
Date: Wed, 28 Feb 2024 23:10:43 +0000
Message-ID: <96bfa918-a7c6-4d65-b941-e69f8aaba1a9@csgroup.eu>
References: <20240226190951.3240433-1-rick.p.edgecombe@intel.com>
 <20240226190951.3240433-6-rick.p.edgecombe@intel.com>
 <94a2b919-e03b-4ade-b13e-7774849dc02b@csgroup.eu>
 <202402271004.7145FDB53F@keescook>
 <8265f804-4540-4858-adc3-a09c11a677eb@csgroup.eu>
 <91384b505cb78b9d9b71ad58e037c1ed8dfb10d1.camel@intel.com>
 <def71a27-2d5f-40da-867e-979648afc4cf@csgroup.eu>
 <8b12189f4379e9e321527ca2ece597a61c431c80.camel@intel.com>
In-Reply-To: <8b12189f4379e9e321527ca2ece597a61c431c80.camel@intel.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PAZP264MB3005:EE_
x-ms-office365-filtering-correlation-id: 49169ccf-a3b9-41db-d19b-08dc38b27d22
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 v1nZESFfCiu+7tjRwgiOJ0E/VljG87pabw8yDbZENlV1sl8FNvzegVNct+n65G7sC63i7t0DuU02AofL3Cs1V545b/I+xw0jkfJz+K0Gwem3MyDxMRc/JNV6OtWiA9+s7/1i2Nmr7Pj8Vz9nW2b1cAovrLyySi+3wnE+A7DJrexn5sobt9uHfLgjIwX7qEXcmDSqohAuvBD0zYSkmCjSR3OeV4/yQK+P3aODN2qALKG1/VVh0E+HxYP4Rk93zGsGTwxqJeDK8WtPozN0lyM1O6g9BVXncgJnjLicvJRs03e91hc1MPjUgrU6Cy9e3dfsTvKG76fcEs123iAM0Uz7K3XQh+JbHmr69k3Xflr/bEhNgZCTmOW1lzeG3QnXgbecmcllPR2thq6M7k/eXo0IOn4cO5UcDjNfizxz2dlIYOoeyhY4doXMKLrXmVojPmTFwHUi4j82EjspU5hTFU1WmJB0mIXz6C08glSn6vNf96LtQDxYqC9EhkuB9wyftTHwVuxRSdoo8DAuu6iSthu1ljw4vej7xeK+qBSCNvwoFDrdfReDZbJCxMMlnGabKwnDldJeCqW8ByqkirYrJr4PDTZJpTSExTtdIaJ0JdlFEFzHwOxbx72UhxzYqQLcHnnhscXj4eiEa8JLTAZZvxYwhHpH8kbn7YLDTbcpvK6lQ0TvIwBCypWnoyzHjgRyNv9JTpCwzXluy3awOmZmu4LjBCg4NgxJxFPxikYIWc01xl4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dEplK1NJNy8vaEFtekhRNW0vSTNtWkpRTitaRXgzMGRuRnNaTWlFTEZ6YXZN?=
 =?utf-8?B?WjdzMlYrYndjcFhQak1pQndheE85KzVUTFVvRmZEZGg1bWNVWWF4YkNHTjZJ?=
 =?utf-8?B?SjJkUXI2cmNrQy9QR3h3ZlRsZTJkRG9pa1JMOFpDL3Nqa2N5WEppRGZXNWtU?=
 =?utf-8?B?ek12aTA5a3BYNmFzbVZDRklOc2FxZk1GUmtIaXBOblBkRVJzQkxBWVl1NlJp?=
 =?utf-8?B?cFhsLzlGeE5ORXhjemt3dWQ0QTVWY1dORSttYlh3ZURWYkNaaVVIYytiaGFa?=
 =?utf-8?B?WjUwRFFLalphV2ZoQmlDUFcwVHRCWEx3QmVYRnVOdXFHcnpYdGRVbFNWYVkw?=
 =?utf-8?B?RVBIZ09MRytiYTdTd3pTcHM0b0NQVGdrUjFOSEhuZlY4cW9zWEpxSUNMWEJp?=
 =?utf-8?B?OSthVmdVcVFCaSt3ZmNkekhydG83KzJWOWY1cHRJSXkwQXRHVlhvUWVVK3Ur?=
 =?utf-8?B?S0FFYXhIME0xeTJHSzdSNjBBNkdUQzFpbGlsY0pjTndnMURXZzN2Y1Z4Zmta?=
 =?utf-8?B?R25oc2lVaVl2SDFsRGgvUWlUdUVRZjBWWnZHWFhaWWhKZ2pETDFWRklsdjky?=
 =?utf-8?B?SGxHWDlESjR6WE1Zd2FPamJrNkZUUS9iUTNnWG1JUWNHUnR1OEgwb21EMFd2?=
 =?utf-8?B?eE9GbTA3c3htR2tSQmRyNXNsRFNMNytlb2dtSExCL0IxWEx2MisyMzVmYmxZ?=
 =?utf-8?B?SHVINHNtSStPV1pTZklpSS9Ib1R3Z0Q0MktPQkx2b0x4bDZjalYvNThLbTc1?=
 =?utf-8?B?TnBSV1pRL0FLdGp2dnhiQk8zam9RbUFEVy95MUxpUEpSOXJRdmpHd1N4cExF?=
 =?utf-8?B?dHlNdFAySXBiTWNaQlNFSmpiR0YvUk9IRXUrZTliMlliaHhEZjU2dGxaT0Fy?=
 =?utf-8?B?VUZmaURBU0VKdW84czU0MU9uS1FnV0IvTFk2VVRrYXNubGZEanJVeXdiN05r?=
 =?utf-8?B?Ukh6ME1OTE9rL0w5KzlmblFXNlZpVVRUa0tlSG9IVE5jSVRrelE5cUxTN0s0?=
 =?utf-8?B?NkRiOGZRdGF3MlRMZU9JdnV4amgwdEdaTWI2Sm55TzNva21jdVd6Ynlsdy8v?=
 =?utf-8?B?YXQveU8ybEQzMDlZc2Y1Mm1UVkhmZzF6Uy96Q0JlT1RvYmxzcUdEbm8vS3JQ?=
 =?utf-8?B?RGNYK3cyeVdvK1ArYS9xbjAyZ0Vhcy9FNmNObGk0bmRqVDJsc0Q4eEdZbjVm?=
 =?utf-8?B?NTFyT2x0cTkwMFNlRzZLSzFROU1Ba2NIR0NvM2VDZ2ZQVkFKaVo2YVp0WE9Q?=
 =?utf-8?B?RUZuY1NMZW1TdHo0SUNCWDBkaGRWNFRVMUFaNWJzc0lPd0xmOXRaL2JjZk9K?=
 =?utf-8?B?NUNIcUpNRGcvZW0yQnhOd1RWMHhqLzFFTldnZ3ZmOFJsaDRBZmZFZlk1SU1w?=
 =?utf-8?B?WDZrZVBSWmxnc2Rld3hoWTBad1M1NnVIT1VobzBjSlNYVXN6VTN6VDNhRnFH?=
 =?utf-8?B?aHVlM1JOYzJFWVBtTUJ3ZURmYzY4dXByNDQ1RkdKZVRhaXpRbUY4Z1hHK25V?=
 =?utf-8?B?Q1B2N0JtaC9DQVlnYWs4OUhlTFA3SzhrT2ExS3B3dWkzZjgyN1JkSGtBejRZ?=
 =?utf-8?B?bXZxUC9qUit2MUZoVGMrdjdkcnF2d3ZwcUt4b2xxVDZUVlc1bk9vQStYRUVY?=
 =?utf-8?B?cmtSdWV3UTFHUGtGTk5rNm90WUJsVmdaTnZmUno4QVFtUG5VTTZCWU5Oek5Q?=
 =?utf-8?B?Mkh1TFlwelJxOHNWWmpjT3RZdWVrQ2kzeXVUR25BYlJzZnU5dWFOcEhSdk5x?=
 =?utf-8?B?d2JnZTRoQVJKSmN4TWY0aEpmSXpsWHRaTzR0Y0hvbThBbndaaG9aU2hkMCtn?=
 =?utf-8?B?ZFB1UXlYUGRIeUhLeWtXRjlJVDhsNVVWN3pmMC9VQUlKNVFxOW1uWVQ1U25M?=
 =?utf-8?B?Njd5M1JZWS9INlAwRTRXQkVlU2lFV3lGRkNFUW1oQ2kxMmRaRm95WVlZdEVr?=
 =?utf-8?B?TXBkMzFFcmNydmdtaDJmV0UwVXdKL053cXM5dXN1cGRBbEFMMzR6Q1pkcldr?=
 =?utf-8?B?UHl1L1dSaTBGNUFPS0JkRGUyNGVvUUZ3bVJCbmExNkszZDh5ZWNyT1lqT0Uw?=
 =?utf-8?B?dUhZSjZJemdOaDU2QnFHYlBvWGJTSUI3UXc4MWVpNHpZM2VyT2F3RElBZ2lx?=
 =?utf-8?B?eTVoUCtiZjd1bW1xTXVkUEJaSlJObHBDQ28wQ3lieVdOd09TNlE1MmV6Rkg2?=
 =?utf-8?B?NGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B7D6CD42F738843B680CBD52475CB55@FRAP264.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 49169ccf-a3b9-41db-d19b-08dc38b27d22
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2024 23:10:43.4522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ne72u/kuw6TIB8DQHTi7DjI+Y/u5HyYR//Q75wu9DJJDvwfUaXmnttEvLKM50OQBL5AzmJZJwt1B6/AlNOIvUX/kPMCrREDT0UCzJ8tXTYw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB3005

DQoNCkxlIDI4LzAyLzIwMjQgw6AgMTg6MDEsIEVkZ2Vjb21iZSwgUmljayBQIGEgw6ljcml0wqA6
DQo+IE9uIFdlZCwgMjAyNC0wMi0yOCBhdCAxMzoyMiArMDAwMCwgQ2hyaXN0b3BoZSBMZXJveSB3
cm90ZToNCj4+PiBBbnkgcHJlZmVyZW5jZT8gT3IgbWF5YmUgYW0gSSBtaXNzaW5nIHlvdXIgcG9p
bnQgYW5kIHRhbGtpbmcNCj4+PiBub25zZW5zZT8NCj4+Pg0KPj4NCj4+IFNvIG15IHByZWZlcmVu
Y2Ugd291bGQgZ28gdG8gdGhlIGFkZGl0aW9uIG9mOg0KPj4NCj4+ICDCoMKgwqDCoMKgwqDCoMKg
aW5mby5uZXdfZmllbGQgPSAwOw0KPj4NCj4+IEJ1dCB0aGF0J3MgdmVyeSBtaW5vciBhbmQgaWYg
eW91IHRoaW5rIGl0IGlzIGVhc2llciB0byBtYW5hZ2UgYW5kDQo+PiBtYWludGFpbiBieSBwZXJm
b3JtaW5nIHt9IGluaXRpYWxpc2F0aW9uIGF0IGRlY2xhcmF0aW9uLCBsZXRzIGdvIGZvcg0KPj4g
dGhhdC4NCj4gDQo+IEFwcHJlY2lhdGUgdGhlIGNsYXJpZmljYXRpb24gYW5kIGhlbHAgZ2V0dGlu
ZyB0aGlzIHJpZ2h0LiBJJ20gdGhpbmtpbmcNCj4gS2VlcycgYW5kIG5vdyBLaXJpbGwncyBwb2lu
dCBhYm91dCB0aGlzIHBhdGNoIHJlc3VsdGluZyBpbiB1bm5lY2Vzc2FyeQ0KPiBtYW51YWwgemVy
byBpbml0aWFsaXphdGlvbiBvZiB0aGUgc3RydWN0cyBpcyBwcm9iYWJseSBzb21ldGhpbmcgdGhh
dA0KPiBuZWVkcyB0byBiZSBhZGRyZXNzZWQuDQo+IA0KPiBJZiBJIGNyZWF0ZWQgYSBidW5jaCBv
ZiBwYXRjaGVzIHRvIGNoYW5nZSBlYWNoIGNhbGwgc2l0ZSwgSSB0aGluayB0aGUNCj4gdGhlIGJl
c3QgaXMgcHJvYmFibHkgdG8gZG8gdGhlIGRlc2lnbmF0ZWQgZmllbGQgemVybyBpbml0aWFsaXph
dGlvbg0KPiB3YXkuDQo+IA0KPiBCdXQgSSBjYW4gZG8gc29tZXRoaW5nIGZvciBwb3dlcnBjIHNw
ZWNpYWwgaWYgeW91IHdhbnQuIEknbGwgZmlyc3QgdHJ5DQo+IHdpdGggcG93ZXJwYyBtYXRjaGlu
ZyB0aGUgb3RoZXJzLCBhbmQgaWYgaXQgc2VlbXMgb2JqZWN0aW9uYWJsZSwgcGxlYXNlDQo+IGxl
dCBtZSBrbm93Lg0KPiANCg0KTXkgY29tbWVudHMgd2VyZSBnZW5lcmljLCBpdCB3YXMgbm90IHBv
d2VycGMgb3JpZW50ZWQuIFBsZWFzZSBrZWVwIA0KcG93ZXJwYyBhcyBzaW1pbGFyIGFzIHBvc3Np
YmxlIHdpdGggb3RoZXJzLg0KDQpDaHJpc3RvcGhlDQo=

