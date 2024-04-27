Return-Path: <linux-kernel+bounces-161081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1ED8B46CF
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 17:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8BC11F22ECE
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 15:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E1AEDF;
	Sat, 27 Apr 2024 15:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PWxEBAeb"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2067.outbound.protection.outlook.com [40.107.102.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C825E17D2
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 15:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714230454; cv=fail; b=sR9Eg1Hd3rzH62cKt15jRxMyFmTL+q2nNywHa8t+KSB/0yS/WI/4P4aJBl98dfrm4zeaR0+ZdFYwVC3qH9TpgFCciyFq+tY3IsiZKyZFLprE9QKpI17laXDGiC07kuSOCtd5RH0RsOlYwd9gKJ6Ljkjq1QcHTmkVBO9vBPb0hMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714230454; c=relaxed/simple;
	bh=7JwK9+yjXmAIk1kc9IIVIE8N4lfqc1Ms538+zX9fL9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DrwGdd4d7a7kBAqJyvcxaVm7/iWlW8NMN+UpfU1T475yS3hbBLSaJaWZyNuBkrx4WuhxgPv8/ZPTTWvTq55k55YavaWzAyS6Si4BYaff30vSLHo1HGB7ciMOQgOMflvje38rwihxDg5s7g5yOtS0hGUcc57NqiPfz53jumueQw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PWxEBAeb; arc=fail smtp.client-ip=40.107.102.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AX4PXWKxEx7FFjkLwMbpVhh7QhLswRuK9+7UNvTwFlWpK/zmKwoA9mbFR/Tu+Rut+a0FClyINIDlhKu5s7K/Xkd/3SqNcfk7l/bxWrPSDvAQN6JONVgGcI0cEz9bMnGShXTv7i0ARWG6K9L7KstlpwKXfQkS3F/gEqFKFdX9E53v5e+BgGwmUjWfUC3mugYvN1uJcDPpRbOtp0Q3Ml6cXFdDdEzRl39vDwqBE5m/zitl/hvEbKGT/JdFzPanDtcNEq3HKWVgetbAx0yD4wjbYV1OciA2CroZLtZ9sSRKG8AfORk6j8Bae8zCkSV9UKjRhb9sBsQ+suoCkFw7ln62Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nOIxf/p9wAzj1T9dHOkFnG8IF/wqcMsgJIWYyVZZJAU=;
 b=gK4bG/w4G5UeC7EodaHk1qTyrA7i20fPG4xM5shFO0dJ8BVEm7BNHInzWQQWDUzcQfZPffJBZO78id316lCxvqUsmI2+vR/CC2rHrGeIXIMn7pp/U8AeQw31WkbxivBsoGNK6R15FMKhFB0yFKIyxcc0TV+3zvuim5AFG8tdfzxNgT6PAkBH2QGYnn+dCsBQMnHnie9IKdvQB3rcLMxwOv06KkzxpKMfcfJiW7mKypu9eCLLI7f/uOigH05qJZM2F8YiP5WVBcNxzwk8fiR+ScY9PMV5mRwLbY5eOFbsWphcO5ETzN6zb0+VbpRSz/NyGUBgp4AaTYVnHR29maqODQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nOIxf/p9wAzj1T9dHOkFnG8IF/wqcMsgJIWYyVZZJAU=;
 b=PWxEBAebyyJweMPBT0Ddm4y0EbizB2zVcV020gPMNDyhojTYl+sPsF0SPnVOcGp/nt3QbF+iyRBI2enz4virXtadA0kiBeHFpcCLjC5Puub/pEnHv7JHxGQyudjMd6UDDMOzB8BOK6+uXNdpSqWzC00rr5r7xaq4o2kgLuV6G4bDlBUlJYzJpVXmYCghtZI3c0hugB2TTxGh3L6JRaN9uZxZ2BkvgzWy1PhIHfkx3RaGBzDH2HMYialLW5Lzdh0k9XB7Fi8ZfMq3tuBWP18dBLlhJGIGEFblNJyeV/0WosO6iqXwdUkaLgeILB7GmzbEu4ltmbSe9u9iJff9NDUzKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SJ2PR12MB9086.namprd12.prod.outlook.com (2603:10b6:a03:55f::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.22; Sat, 27 Apr 2024 15:07:29 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7519.031; Sat, 27 Apr 2024
 15:07:29 +0000
From: Zi Yan <ziy@nvidia.com>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm: Fix race between __split_huge_pmd_locked() and
 GUP-fast
Date: Sat, 27 Apr 2024 11:07:25 -0400
X-Mailer: MailMate (1.14r6030)
Message-ID: <6F2BB00A-DBCD-4482-B16E-B71A02847F0D@nvidia.com>
In-Reply-To: <1734de6e-1bcd-492e-b07b-9ad712967e1d@nvidia.com>
References: <20240425170704.3379492-1-ryan.roberts@arm.com>
 <39d0236c-4297-4001-bc7e-f516bc674f7b@arm.com>
 <87df74b7-2352-4ad6-b9f9-baed9291cbed@arm.com>
 <80148272-208A-4306-A8EC-98C79BBBDCA0@nvidia.com>
 <D0E6B5DC-6206-408C-81D1-C9B0A85E1D0E@nvidia.com>
 <1734de6e-1bcd-492e-b07b-9ad712967e1d@nvidia.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_1FD05359-9965-47F6-8621-EF7035B67727_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BLAPR03CA0122.namprd03.prod.outlook.com
 (2603:10b6:208:32e::7) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SJ2PR12MB9086:EE_
X-MS-Office365-Filtering-Correlation-Id: 6da377c5-a0fc-45de-76c0-08dc66cbc18b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MDtQMR2Fgg/jMR3JScaPOirlyRwRbMmSnMKgRu9Ao4Ing7z4bCzlRpBiBnlV?=
 =?us-ascii?Q?2vjLplKsqaHdb26yh4ayzWEBeBQW9jED0OVBxkJmcSAIA2mR7qL7O7MB5A5m?=
 =?us-ascii?Q?pkxsHmAmcgaiIKsExpxym6yOTw91FAgwQFcIZjrxyMdxj3TT1qF+/r2QtKsO?=
 =?us-ascii?Q?dG65k5gCyYuXKZ6CgrpSXwm4yrlUyTe1OSY4Uxs0Jeijmr33FG2N9YoehV//?=
 =?us-ascii?Q?MsoEQHmmE2dwuUPvlzCBp/gGlRmN9clTzCF8A6n2tVqht8/qL3uHcySWpsr9?=
 =?us-ascii?Q?f2u2zMvMjx0hl0OoQlIeiIibbyr0bBDOFW/MtNhJP8NS5c5gJ0yFP4EgY885?=
 =?us-ascii?Q?/B8z5mqqUJN5slQZNIB+calfM2v5+DKPrR2Zso6u2Zjzt+ghf1roywKr1V+a?=
 =?us-ascii?Q?RsElqF03+cIT8cJOh/cb+cSfwoJqtzNizp74EvEZQAF5v0mde83wwhe+gtzk?=
 =?us-ascii?Q?Rx061eU/zb8aWW5vGw3LIcCDjj2W/9Qu9cJNGUSOUg8kX0Alf2dfBIKSCHod?=
 =?us-ascii?Q?vGE7AEuxIqU9JsfI/B4l8hFxdJPtFI8cqrNfEiJLqVbWCFxIfAgoVrmMyEa6?=
 =?us-ascii?Q?axm6U2YzyYXz+tHgE9gEd3noJ1Imjp6Nh77lsq1O9cg+XlE8KCwcySmqHPXs?=
 =?us-ascii?Q?gKqHDnQ/xHTdGv4gBJw8OANMmj7AtbsFjHTXddzoPJ1HSlijfRVxEBl30NLe?=
 =?us-ascii?Q?BdrA4N1iIfRthh8xy0V3kxKjcj8Dl4zrenkS8ghaDPFIktjsAVry/9hDNDUG?=
 =?us-ascii?Q?6ppFC5BJL6z9QgjQl97+bsxtDbFBKmhRy+HChJiBxDf+WApsJwtTZxTep11J?=
 =?us-ascii?Q?yRiWYVpumJ5O3yyBL5og7mFrJEk/APpS/D6AcDB6ONZJMwxZzxmxXeJ9hdAi?=
 =?us-ascii?Q?kWBaUHJbgrAHdPmIrkecBip4WeFyIqqLKv1VD0FQCWQ5GPRV7nigLpIINLZ7?=
 =?us-ascii?Q?TWq+dNst+1nn0n8sRMTYebTFNscm8Hx9OaTYKS864dSb2HNOXOSCFiUfogKM?=
 =?us-ascii?Q?J1yudbhhN9yGKvUBPuaooe9pd10Oq5cRIR0kxahPVOKOqEdyFfHovzW8PvdU?=
 =?us-ascii?Q?omIVa8MGQaIG0QU+gqBJJVJ0i17MDEo728+WeIDqqZiJDqQtZ0nxbzlekcLf?=
 =?us-ascii?Q?bxyq/5tVYqf774bDmAMxivRDS+3bsQD3IrEPC0bOhziKf/liNh7lV0sfNsTg?=
 =?us-ascii?Q?4+ukS/Ez59ymhw0GyyB1EHFU1RM8J2UUveX+UB4W1dmPQ+EQGa0s1PDf3Wvt?=
 =?us-ascii?Q?UJ7ht33hAwTsKmnm/ClPRUZNmIOT0RzCv9/T9tV+Hg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oQkPSHIy7BMIz3ph26gA/GEZEWak2vnMXKxXhK1A7w2SKfi48ZeSUWMRCqhy?=
 =?us-ascii?Q?s6C8njJNPcDCRy26Vdzx4WERWxgSTIgPGggQTiIx80wMqBGnVjszB+lOh6EG?=
 =?us-ascii?Q?VKxUVnezk2fust3soKqlc2Erv4z17fmsX++ZdrK3Mhp1c2qyjG4WJkrBZDqv?=
 =?us-ascii?Q?ygOnOYVdrpEWgsYFjlSqH8dsQle4Q+ZBgICk6+rk3FcimD2NG1/ic9mu/yK4?=
 =?us-ascii?Q?x1jyTd8nddzUFVZOoysJkzsY2z7ncdmwE70PBw5rgl3A9t+Y/AJk0gQ27VF4?=
 =?us-ascii?Q?GR2SCPEQI7Uatrs7lpITsbB9xeKm72lP6SDwmNt7o6tbjtL3ZT7jn7CFDqYG?=
 =?us-ascii?Q?/o21+f5AulUAhq2Pxa+XqMfQBff01YI7YjDPpM5VNnBhQZPK11/yGaBJWRjd?=
 =?us-ascii?Q?8/Fzv6iH2bLUfDZCemPVcc9RBdMXyuQ4m97cN7YQNnq437rW0Q/IIjH0S8G5?=
 =?us-ascii?Q?yDOwrLv4xZwvcXNity7AjXxUxtfd/1/UnrlOt4KBTtzP2SA3bTe8U92nXNtS?=
 =?us-ascii?Q?Ni6ZaSToSfN7et1/IaY1mcb6CfzIEaK71XQeiQXKOsJ6rKyOy8d1ZUzhOwWB?=
 =?us-ascii?Q?ul/JgJ0Un3VHMHULdKNFGxMg+qy5kyZauwDtwTcCg7Qd+J5hQl3FgZw3CiKV?=
 =?us-ascii?Q?/fWn0iBedHkL2pG1X7MJxe+UF/nhfYQ7+hikT5gqC5iq8TtGTeVJNAYZyAXQ?=
 =?us-ascii?Q?/BIrwKMUuM74887UrBWUt0d6w7+uXEA5LN+j8njLlbKGYLc2oNZfbQ54vxDT?=
 =?us-ascii?Q?gBVU2ln+hNlKhb1r8JnTehnKyP5ULOMtBA+GfIEpDWLhOqXPYWXSPU8q1Ulw?=
 =?us-ascii?Q?TW4ln0QhSf8iLxlcChr9KQhAUjey6uHrXHBAmzgZqaPMgrZK4RhMhzBIDd/Y?=
 =?us-ascii?Q?/Qnl0xcxQrE9HByz6knBJYKVLUY5U/4m40MwQAuwLar8JsyiB8BmaWfjHtD2?=
 =?us-ascii?Q?dBbKFLkEgibaLMVRomX5DBN20LoFR/QYszVPbF2kXDN7oo7baI17U2RsX+1m?=
 =?us-ascii?Q?hyj+dHvjllAW549UpWxdmLUWaqBTKVbUl32AqGo9RjwUrEZ7IyNc6FPBj/2U?=
 =?us-ascii?Q?rwXbrwR6XPGLHGjXSuBdUvKS2Q+T3nxbDy8w4KPg4F/agPYGIxZx4ngVs+9b?=
 =?us-ascii?Q?HNNNqTWTs7ef0UkkQH57cJy+YbKqm18Mi8fbtZkNQfeynMW86IO7++ijEekr?=
 =?us-ascii?Q?JA19qXDtt2Q6OF3sIGJdYw4XjYKWUPuEI7hK78diTb+zvdtiT5/EnAddRoQs?=
 =?us-ascii?Q?TOhXr4hTH/6zZ9qA59GjuXqU2TpBxYyO8CJz4b7iV/pYnooO1u2GtsZrkkLY?=
 =?us-ascii?Q?x5rY5zabAIGht6VAcEP/zMcSavNTXDaE8G8/V4l7wMDvCAW02bc4H9HKlgw8?=
 =?us-ascii?Q?n8RmyHhBXySzXszVZeXByWyl5APg6c4R1d/GW4F2wi8o+fElMIkWF96kckD8?=
 =?us-ascii?Q?7IIq+sN1cOzPnVu/Fb1JoSSDFaNTsDsBkBu+IDUbKYqyh7r7Jz0lzk95njHj?=
 =?us-ascii?Q?o9Nu6JW7Lx6Z50pDfXkUBgekWVzqrTLLsJEZVsZLYgrqB7IIXCR1ChPQtpnO?=
 =?us-ascii?Q?dpq6VJiIyM1RZ018oeQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6da377c5-a0fc-45de-76c0-08dc66cbc18b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2024 15:07:29.2829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3MvARsXyLhUzzXtdIh6JoKW4dkH1TZwyuh7ycljICom9XI6btsWkxKfUbVRyI536
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9086

--=_MailMate_1FD05359-9965-47F6-8621-EF7035B67727_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 27 Apr 2024, at 0:25, John Hubbard wrote:

> On 4/26/24 7:53 AM, Zi Yan wrote:
>
> Hi Zi (and Ryan)!
>
>>>>>> lockless pgtable walker could see the migration entry pmd in this =
state
>>>>>> and start interpretting the fields as if it were present, leading =
to
>>>>>> BadThings (TM). GUP-fast appears to be one such lockless pgtable w=
alker.
>>>>>
>>>>> Could you please explain how bad things might happen ?
>>>>
>>>> See 2 places where pmdp_get_lockless() is called in gup.c, without t=
he PTL.
>>>> These could both return the swap pte for which pmd_mkinvalid() has b=
een called.
>>>> In both cases, this would lead to the pmd_present() check eroneously=
 returning
>>>> true, eventually causing incorrect interpretation of the pte fields.=
 e.g.:
>>>>
>>>> gup_pmd_range()
>>>>    pmd_t pmd =3D pmdp_get_lockless(pmdp);
>>>>    gup_huge_pmd(pmd, ...)
>>>>      page =3D nth_page(pmd_page(orig), (addr & ~PMD_MASK) >> PAGE_SH=
IFT);
>>>>
>>>> page is guff.
>>>>
>>>> Let me know what you think!
>>
>> Add JohnH to check GUP code.
>
> Ryan is correct about this behavior.
>
> By the way, remember that gup is not the only lockless page table
> walker: there is also the CPU hardware itself, which inconveniently
> refuses to bother with taking page table locks. :)
>
> So if we have code that can make a non-present PTE appear to be present=

> to any of these page walkers, whether software or hardware, it's a
> definitely Not Good and will lead directly to bugs.

This issue does not bother hardware, because the PTE_VALID/PMD_SECT_VALID=

is always unset and hardware always sees this PMD as invalid. It is a pur=
e
software issue, since for THP splitting, we do not want hardware to acces=
s
the page but still allow kernel to user pmd_page() to get the pfn, so
pmd_present() returns true even if PTE_VALID/PMD_SECT_VALID is unset by
setting and checking PMD_PRESENT_INVALID bit. pmd_mkinvalid() sets
PMD_PRESENT_INVALID, turning a migration entry from !pmd_present() to
pmd_present(), while it is always a invalid PMD to hardware.

>
> Since I had to study this patch and discussion a bit in order to
> respond, I'll go ahead and also reply to the original patch with review=

> comments.
>
>
> thanks,
> -- =

> John Hubbard
> NVIDIA


--
Best Regards,
Yan, Zi

--=_MailMate_1FD05359-9965-47F6-8621-EF7035B67727_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmYtFK4PHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhU7JYP/RIZ/7hML6LeEGHYZEKBJ/7xNKLghDODAmtT
LiFkOtgs6LusbevS4837wxNm4bigQUfiZ9vveWsc2HXeiJEzUqyiKShPny2B8yTW
7MAx79JqTeA/zl0RDYonXrYVXIrAKEab0wwZdlPksaZLwAJ2FGZZAt0LdOKOC7vd
cR2if2BSPWvivwQga6DAJNLZUEqOxJ1VdFvNlpwRSPJUHQRlra2rzJ4tsroyKB6y
VS6cJqVv33aX/EpS7llqZ0CM4LY+FZMLJeM9UNS+nWQTdDUE3mHugerToVAe6Iqx
qQDcsMqarpBTq5zr+wA2XIsbuYwoKHup5yVj2nhGv/5W4cckvNGYm3E+GCmMBiSU
mbP11JKnCsa1lYZnHP6+/2ol7X0eBWSnZtVSzqjSL00fT3BfXoIy5z/wm4H6ddKV
DIgviefFej2yVCINL7sUuTQGH2AUSKaf8Ve2WzMHHr+9rPUV10FWVi2QDC1p4WMH
V2c3ZEp2izTAEMs4w/6hOSVZkyVGOFV4Y2f11BPgKsbE+2pulu7cvfxp396qBKgb
YlPsrUIHrndrFDj1SaqSUFutB1eTirLXU/850YUInMAR0/fpYdSGhQTCiH52kgBs
gI9S0X6I/Z/w9W5sLxhFEH/Azej24CP1cnAXFWiMmyAE79ODvoQ0QMv2enfacYLA
7rSjicdT
=zPD1
-----END PGP SIGNATURE-----

--=_MailMate_1FD05359-9965-47F6-8621-EF7035B67727_=--

