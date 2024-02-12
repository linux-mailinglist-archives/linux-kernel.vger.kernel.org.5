Return-Path: <linux-kernel+bounces-62291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 283E3851E21
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 20:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EF60280DF5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B2447A63;
	Mon, 12 Feb 2024 19:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="hII4tLOA"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2014.outbound.protection.outlook.com [40.92.18.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D6B46435
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 19:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.18.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707767358; cv=fail; b=jlAtVmaPJhCepapPZQnA1Z+HRBetKaEhoTn9ofa2Z2vjn8eNNZ2Zc/sqQCf3l1K3dfpgQbWNStB6ONLFg6Y3vkf/fF67RizGpLlCp8nMTYRR4g75/ommFaCbObp7DDIiBHkK+OFYxR6J+yRX9a8gdjm9kxQQxSB6NeHE9FfuR8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707767358; c=relaxed/simple;
	bh=h1XtQ5iz6lrOZqsyhGM267WWoksxOprV2uF3wC1ibhA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s27xOsEDu6jE4mkdMNvPk+w+4Zo83zepONaa29Fw3LD61R0m7VVJ4ZOFjANylUDKCncp8929YFzfKcyivR5jV/82eEXneoGYOapN8iOQQkuVF2Xs/eGiy8TPNlBW54lpe5E8RswZ6b8el206gqZh+PuO3HmvEV3P2U2CkgiSNBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=hII4tLOA; arc=fail smtp.client-ip=40.92.18.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nxqIhMmJIDRH2Kl2Q4RHp7E6vLL1bPkPqMi7sCLfodSIfahqi0A3ViFEr4gVvFPiTHcSI7tyZrEHxiXp6/H4HKaNI5GJN1CYR9i95AuL7IyCg1xkSgKVK4dSThbfd1mwJgdcMtaC0RU4NXOIM/0JCflB2pP68jZqIARr1z8HLi9v74Hy4TegZ0hQBVVKvrrf6uqgxZA5xICOsI57PhtWcOSNDL3HffUCodqDCoLAZSOGtx6IKbJfF92Q2M44cb1FeKtHgDwHHaJVxn5rwtwLmUNh4f4r+kc8w57d6tFs+DozWjUACCMCpS65k4S0GkkUuI6wm51ffTqc7MiUiGARyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ie4UAQx2xysgot2Iza+jRtKESFWPF6jYLIlLVKBflRE=;
 b=bLdY0juURi9w3e6qPtz/fDz7OFgmN1BjidxiyUd9oCxFf0PBcmGJVINkCJjks/br7d9I+hh8zZNOIZfpMb3iqvZRSXVpfrVRfTLsNnBepXdS962MteKNHli6C4vA0XltNHtLV0A4lI+Cqlat/QlGPuey3pkYJbZnwsMuzvoDcXSU3ZAOfPuf+9YXojmNxOKZyhMmlB/7oCOuR3Y9JexSUGtm0x//B8fm1THXUtl1Hix2vQFCgRbVKg/hciKNsjQKbVhos4Cwz5xnRve4cf/bLaaz7khuxavB3JzWRcundFKwTuUZPGOix+JdPZgHJvran8TCBKNSoSBT+UqloacaMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ie4UAQx2xysgot2Iza+jRtKESFWPF6jYLIlLVKBflRE=;
 b=hII4tLOAaV6ujKUcX0Ov2ah24t++47XViLp32UO4RrkggNw6Wdu9sonn+JceeInk/xMTDVFK/oeXxmVte24N9FCP+xDNIzNZqZG9BrQnXlVGy3RuyBAe6RPXPmtT6aaIc8l11S5vkRbtjEcDt/q1mCO5OZ1tsmR+xXEA/A/Z7VEYUoPR+YqBMo27EaxqZ+7q0p++zNUTALL6iwoDw/zFfQkC5sGDSsVpXyxGmu2yJmk+nyWi+ZNZlNQYElYpKrJdoFn1T5EDT0PPIFzlh2Cc0cb6X20o0DuuuNHzKYJ7+gTfqIJ4mVpbKJHsfcjIn2n3JgPPPjoDcRvsGXhSP0lzRA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB7382.namprd02.prod.outlook.com (2603:10b6:510:19::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.37; Mon, 12 Feb
 2024 19:49:13 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd%5]) with mapi id 15.20.7270.033; Mon, 12 Feb 2024
 19:49:13 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Thomas Gleixner <tglx@linutronix.de>, "Zhang, Rui" <rui.zhang@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "Raj, Ashok" <ashok.raj@intel.com>, "arjan@linux.intel.com"
	<arjan@linux.intel.com>, "ray.huang@amd.com" <ray.huang@amd.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>, "Sivanich, Dimitri"
	<dimitri.sivanich@hpe.com>, "Tang, Feng" <feng.tang@intel.com>,
	"kan.liang@linux.intel.com" <kan.liang@linux.intel.com>, "Mehta, Sohil"
	<sohil.mehta@intel.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "kprateek.nayak@amd.com"
	<kprateek.nayak@amd.com>, "jgross@suse.com" <jgross@suse.com>,
	"andy@infradead.org" <andy@infradead.org>, "x86@kernel.org" <x86@kernel.org>,
	Dexuan Cui <decui@microsoft.com>
Subject: RE: [patch v2 21/30] x86/cpu/topology: Use topology bitmaps for
 sizing
Thread-Topic: [patch v2 21/30] x86/cpu/topology: Use topology bitmaps for
 sizing
Thread-Index: AQHaTf2smbCXa6mJFkOEOgXGKwFMGbDrsI4AgADeUICAGnmhAIAALa3Q
Date: Mon, 12 Feb 2024 19:49:12 +0000
Message-ID:
 <SN6PR02MB415763795AC759CBB6530AABD4482@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240118123127.055361964@linutronix.de>
 <20240118123649.739960607@linutronix.de>
 <7c8874d971c69fb4c22c1b771983f8d5109a9387.camel@intel.com>
 <87fryjhmjs.ffs@tglx> <87mss5k54b.ffs@tglx>
In-Reply-To: <87mss5k54b.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [klV/HO/2UlE27IEsAcKy7YWw/EqVlfN5]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB7382:EE_
x-ms-office365-filtering-correlation-id: 668be2c8-f1cb-4068-3c42-08dc2c03b020
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 3XqeJYa6i6awiSidMcJLO9dp51kPcEy/aZgsLVmnnzapLv7YvJYTdlhLJWO3BkvkRTkUC1BMREOAhc1TLSHTqKbHAgWT2RHXf6BwMyVL26OzAeAYmxojbgtYZSw6rbp0UTLjBLx6gdoIxJwVzTW1z4nXlwl+bkUOSiYWir6IHQ5OsGk7tlQ6OkU0YBJPu5fmh4mkXXFWdYsDjAeNpxz2B39vUuwzFVsgaTy8T4CZenZRn9+nDK7fiuAP/AwgvXsinglldytxw3hR7A5oQTZ+41M8epYcTmoPrx2YLTZw1YCP0Nagdu/ms851QvnAQGM+6CJfiY4cV5OpZzNEBNUizETJaXNUVu3aeOH4BBYska8kNdmQo3ReCw5Vd2rs/OCychq42SlXei6b4WiFetXKuzSgqtqUw4JdmkYsLjv9iCV4ZN7A5uXBAwrHMAJNML+KDFouLFPcHu7ksaGKpi2jPqD9089ekUDMLr3eSvNfqfeAi/cTrK/BZcmWpflmYSPK4VHrcVRrxwrLC2S5V7taECo8Yn9yrj3ldkx1/7A5r2BvrlppZxVyqRL3y+Keu9to
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?iLJMODSSFjsUtTu0T0EovcKjzCwJSoCZw/uA9CnKBQzfUKFo12fmsPi+0zgx?=
 =?us-ascii?Q?OHAVBElMWzKtbb+FPbsKrtahrakvi4tMn0EY9bFB0uYCRBiHXTKPzp5kY7r2?=
 =?us-ascii?Q?4F21xPLnJMI1Id2BXC2P32vLhQnEtuX6aNnmQuQmBVJyb/2jp16/OYBoFrRN?=
 =?us-ascii?Q?5JECy7KGFInlUNQXggy/zKMX/Wsg1qwinnvSFMmyURnmRVsEUKU6UICfqwYC?=
 =?us-ascii?Q?+J84isW1SZCvdNvbptUY/MRU7HU9vnZ20JSGgl1PlAKSN3SsQ4RZCSHTx3/s?=
 =?us-ascii?Q?fq8RWApT1+XeIqTfdv6u7zgayw46LEifh1WckBKEAVFKXlg++fZhqwM9Mvgm?=
 =?us-ascii?Q?WxG5xGsLBeJCjpwxKUuYBErNooXocQRdnuTPGbqMOHmOP/EndogOu97R7OSt?=
 =?us-ascii?Q?jOR3Y8v4zMbgGWbzBPBUWQixfQPzDiuS6L9XyoADINqqmS06PfRS+CiuVfrO?=
 =?us-ascii?Q?QY5aID2qBE3BmLCjrP9tFuxESFSDzGu70tW9CYB0T3mqF3sbrSvrR0hpiLou?=
 =?us-ascii?Q?fmD4f561BnoQ96sgV+2Id0YTU/BZygvXN2PlyV4sOttPP1o/RYRREqpW9Hlb?=
 =?us-ascii?Q?htmbCHs45jNPL+UfMQrBZO3rLhPv7OSJQed+98SKAdAYPpbZIMd3HdwuxCzN?=
 =?us-ascii?Q?zKfAxK2I+QC7DTl/hBoOPSGgBMhekKcE9SNHqD+mK1Rktz6d6bN6YuV8LlWB?=
 =?us-ascii?Q?DwgZsjkVUtF82zIhro4Sbgb2bnhh/b+jGEkq2lRRSb9WbnrCLROGOsgHxlFo?=
 =?us-ascii?Q?WI1J0CxxMDE3VBc2B6DX6fbV0fVpl0VDAOQMa2S/viRcHUpSvbyKanMR+i9O?=
 =?us-ascii?Q?Ic4yR6rDaz4KI6pR9c9/Fyen/qSEJdHa7okMFTnbUvVRwYOaZDtJ7tt9/QYc?=
 =?us-ascii?Q?2DJzE43hla6rIDuSy1O1bs4S4K14kbliQBuNRS9kNNwp+gNB0wuD6YC+UTcQ?=
 =?us-ascii?Q?4arVfxq4d3aErI30K+cBLdf0KQSux98ZBGdj0I6k0vPXYcDwVGMyO+SqmZTL?=
 =?us-ascii?Q?1dVvbMeY+wj9ql0E4/i/ZVkCXhEayqc3eUsZrzmbzqg22e+cfNRQacrmEyqp?=
 =?us-ascii?Q?Ft5JpwZv+1ZmTqVN2NMzeML18XNTDKmhAHyc16sbkmrkWKaR7gq3OsCMXo/L?=
 =?us-ascii?Q?Ba4b0YPIsDcjmchED7tVB4xNmUysnCKJI9hQCks9rlBd8AXtrMoGOs8AQcd+?=
 =?us-ascii?Q?iw5J3skOOSoHrW5SFGJlpHWthstXFQZw+B4p4fT+/j88CVbOKJFgILz3dDM?=
 =?us-ascii?Q?=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 668be2c8-f1cb-4068-3c42-08dc2c03b020
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2024 19:49:13.1077
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7382

From: Thomas Gleixner <tglx@linutronix.de> Sent: Monday, February 12, 2024 =
8:41 AM
>=20
> On Fri, Jan 26 2024 at 21:22, Thomas Gleixner wrote:
> > On Fri, Jan 26 2024 at 07:07, Zhang, Rui wrote:
> >> Say, on my Adlerlake platform, which has 4 Pcores with HT + 8 Ecores,
> >> cnta is 12, cntb is 16, and smp_num_siblings is set to 1 erroneously.
> >>
> >> I think we should use
> >> 	smp_num_siblings =3D DIV_ROUND_UP(cntb, cnta);
> >> here.
> >
> > Indeed. That's more than obvious.
>=20
> I pushed out a new version which addresses this and also the fallout
> Michael and Sohil reported:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git topo-full-=
v3
>=20
> I let the robot chew on it before posting it in the next days.
>=20

I've tested the topo-full-v3 tag on a Hyper-V guest, and can confirm
that the Rejected CPU count is now correct when nr_cpus=3D1 is on the
kernel boot line.  And as expected, these messages are now emitted
when a kdump kernel boots on other than CPU 0:

[    0.339622] CPU topo: Boot CPU APIC ID not the first enumerated APIC ID:=
 2c > 0
[    0.342993] CPU topo: Crash kernel detected. Disabling real BSP to preve=
nt machine INIT

Earlier, I did a variety of tests on topo-full-v2, and didn't see any other
problems, but I did not repeat those tests on topo-full-v3.  So overall,

Tested-by: Michael Kelley <mhklinux@outlook.com>

Tangentially and FWIW, you probably remember our discussion last
fall about Hyper-V, where in some circumstances the APIC IDs in the=20
guest ACPI tables don't match the APIC ID reported by the CPUID
instruction, resulting in Linux guest "APIC id mismatch" warnings. That
problem appears to be fixed now in the Azure public cloud, and your
full set of topo revisions no longer causes mangled scheduler domains
in those circumstances.

There may be nooks and crannies in the Azure fleet that haven't gotten
the update for whatever reason, but everything I tested is good.  The
on-premises Hyper-V as part of the latest Windows 11 has *not* been
updated.  I don't have access to a Windows Server instance to test, but
it's probably not updated either.  Hopefully they will both be updated
in the coming months.
=20
Michael

