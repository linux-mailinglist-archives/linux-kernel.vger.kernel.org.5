Return-Path: <linux-kernel+bounces-111275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF5D8869FE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AD40285F4A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8490E36AF3;
	Fri, 22 Mar 2024 10:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxera.com header.i=@tuxera.com header.b="Y7raYEVO"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2127.outbound.protection.outlook.com [40.107.8.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B381BC47;
	Fri, 22 Mar 2024 10:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711102414; cv=fail; b=HIySHjIkbWsEJp3yhJZlyUl092XmJSmiKlNZOtK46uWWXglpJ7BF4b0zfuiD0BwiZY3eTYsXohO4VrOXtTUwxrvUrz6eSk50OOBNdeWhsDcukcASDHD7REXINMycC9fhXOu+/X90mv2LxoLlmFAvI3dzEnFvzsNuVFDATna+hTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711102414; c=relaxed/simple;
	bh=6RWzj1hCdi5wUirMYLX62nN10nETNQFqrjkwXcWPs5k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IAYR9Np2KQCh+9f2THi7CnylFEbKGoPQvjfp2YH6iNhMjYqh+oLF/SXrwhVQjemU0bQh40kGMQbs8A2kptDPtGsAfUJIC0CYMRLSQTpxxGDBrV+Eeyu9/777SgyIG4xnJeCW2ZM2XYdE0orP8p9gaThGomzwWpOY9x8k762eIoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxera.com; spf=pass smtp.mailfrom=tuxera.com; dkim=pass (2048-bit key) header.d=tuxera.com header.i=@tuxera.com header.b=Y7raYEVO; arc=fail smtp.client-ip=40.107.8.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SaHacKs5a5tIuSUizFqDRzpDn4LeTM4FWcX5Om9DEJRkHMB3PCgLRIABEbVd6r/59OXZL/B9EvR+vVyDjfxeG1+ALZWk7Hhyxlhv+XjFWVSx+pnT52qXQaOBDOlPs43otlqyVOmRIbwNmb5AIA3tYu1kwiVU/TDSSKGtKJKsAsQQZsnveYJeT2+RGe4p5sNmrZv0XobDVC6b9VabjvN1KTOHMnBak0IHaTeotYmWnDGQNiF1HeIrlxgRzjsJLHTqSjTogNR2VfoDtDfatQMoYbyCdm9WABLYrnsCd1ftDOnjUxs/SSauxkMpdD3sdsn/ugKmIM6nwErUBM5mqa3eQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZDwnX+YyDLsqdAdwdUyhAKH8IMUB9nq+LTd9CeVuC8=;
 b=DHHNoQPbLLVPBmunz3XqMC2t/fgEHuGKagm/GlJN0wcfi0uBvNHXIJ9jelBAhmofTpavAc5ddLy17TgIxno/D6jvBFGuWn53uPBmCjtsMDKrj7QiUKBXS0PdytZ7mGObXSFmkNx44eMzJlr2EeoR+5sBki1PdovFtsaWvm1tOXUrpn6yaKpoyTE4AmGVwNkx42OnrafQdQm0L1/qNTW8JkVrsPdt8T2aRGVPO+rFTvA5mFenLGat9aCCBAry37v3MXkA17jx5FVwXVaPMcifPWzC2JspxJ0gmdNzkN/U3fCVJ7GKWvTw3fQO0kYYrsi7pKkaVVufDGGLoOTY6tbQEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tuxera.com; dmarc=pass action=none header.from=tuxera.com;
 dkim=pass header.d=tuxera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZDwnX+YyDLsqdAdwdUyhAKH8IMUB9nq+LTd9CeVuC8=;
 b=Y7raYEVOSceC8whGu/UANnBSXCQozcMnHa/9A3iQ7ZpZjkZZ4wDr4heNI0iTr878eHnoM91XL0Gfm+4lMC/X5pIr+kXg8rQM9B72mWXeYzFv37P6TlUcfU2PKNvUH2LZPm3cJ0veR8mKeK22l72j7lAsgepA+MAibgEwyQggYsiVyOBrENhr6hNMhZ0NaoDTN/1v74f8l8VY48ATtfXdB8sh8kDWU3t6ph1C7UUZUM/t8Eq7OyJRjWncIMHbRdfeSbcS88IbprnXWqlufxt3FchTONDTdu77wfeZGIwR9IDuuc1j6TB0tnGusUlaMNFrKxGJyfdKkqLdNjh0NrnyQQ==
Received: from AS8PR06MB7239.eurprd06.prod.outlook.com (2603:10a6:20b:254::18)
 by GVXPR06MB8946.eurprd06.prod.outlook.com (2603:10a6:150:11e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 10:13:29 +0000
Received: from AS8PR06MB7239.eurprd06.prod.outlook.com
 ([fe80::2664:11aa:434c:516c]) by AS8PR06MB7239.eurprd06.prod.outlook.com
 ([fe80::2664:11aa:434c:516c%5]) with mapi id 15.20.7409.023; Fri, 22 Mar 2024
 10:13:29 +0000
From: Anton Altaparmakov <anton@tuxera.com>
To: Ingo Molnar <mingo@kernel.org>
CC: Dave Hansen <dave.hansen@intel.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Chen Yu
	<yu.c.chen@intel.com>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Catalin Marinas <catalin.marinas@arm.com>, Linux Memory Management
	<linux-mm@kvack.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH] x86/pm: Fix false positive kmemleak report in
 msr_build_context().
Thread-Topic: [PATCH] x86/pm: Fix false positive kmemleak report in
 msr_build_context().
Thread-Index: AQHadiEQrskV1NWHjkSsYR0U0Bb8SLE3YQqAgAwy8QCAAALigA==
Date: Fri, 22 Mar 2024 10:13:29 +0000
Message-ID: <EA749B00-AD4C-461A-91E1-B471B79B733C@tuxera.com>
References: <20240314142656.17699-1-anton@tuxera.com>
 <70261e2a-b87e-462e-964e-95a51ecde978@intel.com>
 <653BCAC0-8A79-400F-B496-23A2FA169786@tuxera.com>
 <Zf1XVPicqdJ3VBcl@gmail.com>
In-Reply-To: <Zf1XVPicqdJ3VBcl@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=tuxera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR06MB7239:EE_|GVXPR06MB8946:EE_
x-ms-office365-filtering-correlation-id: 1c86d2a3-c3a1-4a21-fe66-08dc4a58b8be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 LBE2rOiWUvmdVigY0hkDAFOiu0JUUgThezPqZ/7MTkoidSk55aDI7gA4PVjBpPWA3Kgh6lt0ihZo94B9DyfcBz27EG91j3HRttHCLhpqF2w2shFTbte7W2FpTg60EHqsCaK2l6bRzQIoySl1loop6dFjRwfa3tHp7dL9qYmwL/8I9N0fbmcsegQvawaP/kjMq8O2QBRw5jU3F4GG1OK+ogfj/mV8QngKHXd4c0NKEQFnQOWYvtRFxlmwG6I7eRQOGeTEUdZzxGjihtmGOmC0Q6n9hIJiaXP2cUcaOqNFxIHOkCTBLQlzn5XF01eT7q3HTnOn9W7avrCk+oPtkeuiHbaQW9oDyQPYQCKGc94rwvFSWiCMgWBg3vXuvlX7+24kktqJUoOH2IvxESeNcvPnNbDm2TDexkwy/wJDShJtsrcpG/Hn/BiCuno8yOAKCJM5nMb/b4to4WxoCMJ0OOWl5ouW2X7eDa1KvKJ8itnDC2UGh1VTZAy9mZ2S2PQ7FWus9JDKpeg0l9rTAQJ9V2/UphTrFqX7c8kgI/CUL/DDja4beYdQhY1CZXHs2V0V/ej2XmPi/QGn/6g/RLGM0SCcS8w/WY6J1uuNAXF6GU5ZmEPhjNUqJ6yjzu0NYYmeoWjTFnqf4p5kUfIHS4jKMoEA1MSZBPk1UP4cYdOkeBizsfM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR06MB7239.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8jUOJfvZfZ4GVJkIC3ocmE4vYZb/WrZyFbKHtY4JnfpfnUjlTba9yejkoQ5K?=
 =?us-ascii?Q?Dp5A3OEr7WwOxirURp1EnehlS1BCcOGL37Fxqvbpr9nK4C/jkAWwq8ybIbQt?=
 =?us-ascii?Q?Hj34ZmSs5gl0N1dm3B6caEwD7c+NC3oSz0D+4gNfH+0hjnydSrNuUMpKdbad?=
 =?us-ascii?Q?dhkE2McsESeaGYvoVzlJBDd5EikVu9B+jF4XtAmEc61eGjWEvl9K2eRwCgU5?=
 =?us-ascii?Q?S4kYJ3IEcmf2taNqy4V70M1R15lW25VW73oLs9CfOY83MFPmN4mJvy+bo9Oa?=
 =?us-ascii?Q?Qetn5OdFJ+6cc3VcLyctQXeHRLwD2lk/EBNrUnv1IjttOvSxq8vIVXQINIeC?=
 =?us-ascii?Q?qBgdya5HqiUz6TIStcZCXvYA75UPyZkgpiO4fCYgqpHECO4F8OJakRTD8TH1?=
 =?us-ascii?Q?2FKBcDOFpHmmpl/MlT3f3MCkE151y0V1r1+BaHR3coN3vrwI7xrZ1/L/75P9?=
 =?us-ascii?Q?+wwAttrpGQzkrM9o2g4rZ64l2P4VSrk+G24v3P+MQ3NMedeTlZ1Xuz2Nf4af?=
 =?us-ascii?Q?C0RcO3IINunBbGnKgDH4vO6Yz++R6lxJTfiG44+KHOUIAwqHzQ05CjmAmWbv?=
 =?us-ascii?Q?L7l8gscTI1c9oy79pDQQuwvWp1hbu9Ce92pPzhdBUDJfJOUxq88kArXu8ezn?=
 =?us-ascii?Q?Wv57PrmhGo9vhTEqsn3cZr2Nlh0A1l92NXWrm9lXDp0D6A7W8gBbd2BEcdW7?=
 =?us-ascii?Q?WN7jDuQBMFAZXvre/OqQYgqNEepYA8S/RBDXbXKAKXT7wGvSGKH7lsnkvAw6?=
 =?us-ascii?Q?0tbZ4B7mgAJ0nQxjiWVEkei3tGmu45y68kbwk+E80SAzfjAAYePSF2y0fnRY?=
 =?us-ascii?Q?vjp42+vb4aCEzmO6E4f1y/VN4zluU72rtylB+d6BC0EAfzzVAPFj75GZONzh?=
 =?us-ascii?Q?C3OMNPv5WHlMq/bimd0td0alU637N5cGhnmXs27mPf0wGQoPnHt4V2iTObUY?=
 =?us-ascii?Q?CVVv33mIUNgHXuTEZm0aT9grGeZGyPtr/dQzYet535z77VHsaBFYxHiw1yej?=
 =?us-ascii?Q?4lFwYAL3Kle78FWXwHpMkIUQIym3IK+q3q8En9QkFWi6fdtB89zOKN3mRj9S?=
 =?us-ascii?Q?0D4hYuKbIqwfF/HofPnSmqED1ZpBmWLR2gmt62wjmmliYBeVu35lCR0hZphh?=
 =?us-ascii?Q?8UBam7y36du0w6nJ1jjt6VNEbu3Yp3132sFx8CzxAkqn+xSUtXVcN7LRbKC2?=
 =?us-ascii?Q?VZGOkShq8xnWeG21/dx8+xvOfLV1RWIzGwbGx7s8sN++iobcgH0OygirvosX?=
 =?us-ascii?Q?aqG/0JeTvUdLHyrFMhuW4c4tyqAvu7JGH523ZgLP28juPMFI/UF1RUARbvIk?=
 =?us-ascii?Q?d/aWIhg0hzTYQ2Uou9aN0bRkxzXY2eHNWpm6GyGAik19i+awYuARIfGBy4zb?=
 =?us-ascii?Q?QmU+Vh9gxDUl4F5eODrJq4Gfgv64cJRMtYwyYN5ZVMlfd95dYYSSPTwoY2jd?=
 =?us-ascii?Q?eIiHsbsY8HcZgZfayiFYuEUuSEnyPHoKHiilAl65ix9f1OZivWQnSBQ5+GRn?=
 =?us-ascii?Q?OprFDdy/RMjyeLv2JJKho5Xk0XooqCpDZus/eoZ/ITYG2y4rBLnq8ru/Rduj?=
 =?us-ascii?Q?JrjhrS+EzFK6lsCZvvv0mmWSCwEV58ErBCwyDg3J?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5D95FA9085C0FB449CBEC15BB4377E99@eurprd06.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: tuxera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR06MB7239.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c86d2a3-c3a1-4a21-fe66-08dc4a58b8be
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2024 10:13:29.6737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e7fd1de3-6111-47e9-bf5d-4c1ca2ed0b84
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ApC3MNziuLLaPQIEkIoqBtkPej5cI2Y2r6evl6x7demMiNBkxsVq99MqYXnhj7fK3cb7QdQPayhn/0cBNb0neA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR06MB8946

Hi Ingo,

> On 22 Mar 2024, at 10:03, Ingo Molnar <mingo@kernel.org> wrote:
> * Anton Altaparmakov <anton@tuxera.com> wrote:
>> Hi Dave,
>>> On 14 Mar 2024, at 15:05, Dave Hansen <dave.hansen@intel.com> wrote:
>>> On 3/14/24 07:26, Anton Altaparmakov wrote:
>>>> /* image of the saved processor state */
>>>> struct saved_context {
>>>> - /*
>>>> - * On x86_32, all segment registers except gs are saved at kernel
>>>> - * entry in pt_regs.
>>>> - */
>>>> - u16 gs;
>>>> unsigned long cr0, cr2, cr3, cr4;
>>>> u64 misc_enable;
>>>> struct saved_msrs saved_msrs;
>>>> @@ -27,6 +22,11 @@ struct saved_context {
>>>> unsigned long tr;
>>>> unsigned long safety;
>>>> unsigned long return_address;
>>>> + /*
>>>> + * On x86_32, all segment registers except gs are saved at kernel
>>>> + * entry in pt_regs.
>>>> + */
>>>> + u16 gs;
>>>> bool misc_enable_saved;
>>>> } __attribute__((packed));
>>>=20
>>> Isn't this just kinda poking at the symptoms?  This seems to be
>>> basically the exact same bug as b0b592cf08, just with a different sourc=
e
>>> of unaligned structure members.
>>=20
>> Yes, that is exactly the same bug.  That's how we figured out the soluti=
on in fact - it is totally the same problem with another struct member...
>>=20
>>> There's nothing to keep folks from reintroducing these kinds of issues
>>> and evidently no way to detect when they happen without lengthy reprodu=
cers.
>>=20
>> Correct.  But short of adding asserts / documentation that pointers must=
 be aligned or kmemleak won't work or fixing kmemleak (which I expect is no=
t tractical as it would become a lot slower if nothing else) not sure what =
else can be done.
>>=20
>> Given I cannot see any alternative to fixing the kmemleak failures I thi=
nk it is worth applying this fix.
>>=20
>> Unless you have better ideas how to fix this issue?
>>=20
>> What I can say is that we run a lot of tests with our CI and applying=20
>> this fix we do not see any kmemleak issues any more whilst without it we=
=20
>> see hundreds of the above - from a single, simple test run consisting of=
=20
>> 416 individual test cases on kernel 5.10 x86 with kmemleak enabled we go=
t=20
>> 20 failures due to this which is quite a lot.  With this fix applied we=
=20
>> get zero kmemleak related failures.
>=20
> I turned this tidbit into the following paragraph in the commit:
>=20
>    Testing:
>=20
>    We run a lot of tests with our CI, and after applying this fix we do n=
ot
>    see any kmemleak issues any more whilst without it we see hundreds of
>    the above report. From a single, simple test run consisting of 416 ind=
ividual test
>    cases on kernel 5.10 x86 with kmemleak enabled we got 20 failures due =
to this,
>    which is quite a lot. With this fix applied we get zero kmemleak relat=
ed failures.
>=20
> Describing the impact of a fix in a changelog is always helpful.

That's a good idea, thank you!  Also, thank you for taking the patch.  Alwa=
ys nice not to have to maintain too many custom kernel patches!

Best regards,

Anton

>=20
> Thanks,
>=20
> Ingo


--=20
Anton Altaparmakov <anton at tuxera.com> (replace at with @)
Lead in File System Development, Tuxera Inc., http://www.tuxera.com/=

