Return-Path: <linux-kernel+bounces-162461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E93E78B5B94
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 188051C21226
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B3A7E105;
	Mon, 29 Apr 2024 14:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iLZekiVn"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECA5DDB1
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 14:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714401687; cv=fail; b=eJQk6M+OcWS0d74PLRI7frtai5wZ29vvw2EGBW1B8AVRfP3eAP3Rb00AJWUSNga/bOtfLUnOb1TOR18eqDJgu8qu1b/GnIoY8ageQx7WlFxr7ZZC4g+E4YX7C8oPIxdWz8v2uh7xM6ToVpIejoxeNU1jI5Wv4UU8HrWu4sc7aa4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714401687; c=relaxed/simple;
	bh=xCFKi/PrLDh3SjygwnP1tVVG/nIL0aHkQXfUaS5pbZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X6cAJNzt5EWgy4QeyxbG0FdN8Gy9JMH1oZNXoalmeSsvR/nt/BDHicudX0Ud8uBBiNX8taVuxNrNJF8I96PtrZTf+Kw41e6HufYNyM/KgRnl1645fL3usT61I0h+6vX2GS8becud9JbX45PcL0dCDMO25gghcC0kTPtoieLJe6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iLZekiVn; arc=fail smtp.client-ip=40.107.243.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HBhPIFg8PAptKk4mEwcWYNlV8UhNCjRXY21mPh34QBUpPFaSKa5aTwAapEEZHFwBAPuTxy2z+xit/v7xPvCP9cHGQPFR5rwatrN/uYXbABAGd8AoJvCylAgYy+MuQZpmHK0KcXgxoLPwqYkVK0NY2r4axQuvCtJ0k2fgg3SVcY7xy9SXqkhQZ5jnYglgY9CQjsKgkYGE0KjDCH+KJsncpKWp4aBinEMeIHAh5AQUVP2+LyQI37MZATRorFtdvdLgVllc/qP8F2d3a1wAU5BMNIQScx4AX4K3nMq4bQIQnOl/CQKC6sfm/EgqIEYcZsfyVlsJvPRtH3hyQ+HUxf1rKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tTXBzWSjnd8oc/SRdYhI49aDMtXLumH+8+kKceT8n8g=;
 b=flNNEW6Ya9K9q7Tnr97GLV84CzmO8jxEHIBQ4iFzsh3FKW+MWVQuMBHlphPf3KS6DD7g5cCbo+EGpkuCxhJK2kESn5MkT6uy/9FwIYSaG3Mt9mf/DEX5Twz+eqRhK3M//IfAjZvtk9ZkHiKv+wxFL7VNDfNXKGLjvDgnkeN8buUbhLobD9I5KQTQK5WBHykAWsyzXDtxOmhwlfHs5XcBEESRUq2TqLmabHjU1JRXIibVSGawUm5wDZ5h7Xt9dJ+yan/lVmEWqTFV5PmupEmYEb1H3zBKeWOTmU09VslyEDFZFhutQ6xohpKc8RDUm+3tjCiOKyYVkWTq++0hWb5mog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tTXBzWSjnd8oc/SRdYhI49aDMtXLumH+8+kKceT8n8g=;
 b=iLZekiVn0rMZCrgkEX5o64juaXrmZkEztFmUiCPhkStIYPt+qNidU1n6EEjeRHHLqrrxo7Fo6lXwySPev2tB8hQt7d4w0g+xCe1HKf08ccr7udYnWccgQukgjqbWc/UA01CAOTUykF2/JECrsNOGY+BUT67azB7ffRd38GsruWiHsbslUacG9uffDzuj3id1KhN+v4ZfeRZRvV2d/ZWS1aerW7kBZQ2bV09gu6lJXSieVldw++rQPQigXoFf/0jyssghR/fKh7QIbhlaLHwVf9MVqXZCW1+ViIk52j4XO6/iPhVmOxiX2a6SaG7oLijsxLFXBpz1R1B8XSdRIgCZLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 MN2PR12MB4159.namprd12.prod.outlook.com (2603:10b6:208:1da::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 14:41:22 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 14:41:21 +0000
From: Zi Yan <ziy@nvidia.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: John Hubbard <jhubbard@nvidia.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <zi.yan@cs.rutgers.edu>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm: Fix race between __split_huge_pmd_locked() and
 GUP-fast
Date: Mon, 29 Apr 2024 10:41:20 -0400
X-Mailer: MailMate (1.14r6030)
Message-ID: <28269666-40B5-4610-8547-81FF68B7613B@nvidia.com>
In-Reply-To: <45d59bbe-b8ec-4725-8a4d-c715130036a3@arm.com>
References: <20240425170704.3379492-1-ryan.roberts@arm.com>
 <17956e0f-1101-42d7-9cba-87e196312484@nvidia.com>
 <2C9D897B-0E96-42F0-B3C4-9926E6DF5F4B@nvidia.com>
 <328b2b69-e4ab-4a00-9137-1f7c3dc2d195@nvidia.com>
 <E18F9D0B-C855-4252-BEEB-F8B1FA5BCE9E@nvidia.com>
 <4E0ACD41-970E-4EAF-84D7-FFDB5CD49B3E@nvidia.com>
 <45d59bbe-b8ec-4725-8a4d-c715130036a3@arm.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_343333EC-EC17-4672-BD3E-FE5639625456_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR16CA0002.namprd16.prod.outlook.com
 (2603:10b6:208:134::15) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|MN2PR12MB4159:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bfadf40-daa1-4968-93f1-08dc685a7029
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2SIE4xU5sSRvNB3qgfM47Bsdreqpa9oKwLaACj52wbCz0e4P5rqVIqTt+K1a?=
 =?us-ascii?Q?MflDlynnmVabOTXPoi9HYgOqJrqXo64ftSA/WG4RU9naW4r4ElC7MaYWvaRc?=
 =?us-ascii?Q?JY+gBEZ8ITAowYFQ2A3JQ7+c3PyGI8gmPTafe98qsrRCQINrA45x3yGJRHaw?=
 =?us-ascii?Q?wO1N0KxPnYLJWZfLzCtJO+8kCR9saGEwJ+GCHtPS1YcBHexUYqC+ifiYg6Bw?=
 =?us-ascii?Q?n6bqMlaX+HA6RbKvgbc1lKZ/pY7rdGG8dz8/DxysVpQqwEXCC75WbsAV+XH8?=
 =?us-ascii?Q?QyxhgsAbJwjrZBt6L/R00QRnZak5DhuDkFLvn67PJVWWzcxGTUm9z41hLipi?=
 =?us-ascii?Q?tUXWpenez7LPkNMH9m9ttuTHvhMko7mDJuSYz6TPFtDHY/68QtlmGmu/peXr?=
 =?us-ascii?Q?YvS5VTUdhLkeTgjdW5MKmiG3hbP2vKwiMAPseqVWa++1Fa9ZC8aitEXP5VEc?=
 =?us-ascii?Q?ItAteregoKPNLYwNyGrShy1ZtEHsfY/ZNyfV4BrkSkh3ppiMH3lbkWiQd+yU?=
 =?us-ascii?Q?sg0aDvKW6nWdTU0/nVto/8vWUc3ezVeYmQFjoydSQXEsTh4P/7mAZN3ARWQC?=
 =?us-ascii?Q?cITyX9uexO35zlnbT/+4rmeAFO0+kY89nCsplCPJBfXS7+v//cZmyjZlgXep?=
 =?us-ascii?Q?97LywJdDKjokj/4NKZXobkFMRIsnVAzb2Av4N06pHV+xc7b7IZ9ZmHAB6LhX?=
 =?us-ascii?Q?GYgMjmcbdAa4jhisH8Hr8RGtRa0TrWx4pIqsZSFEue+0f/m4s2hGrmZRqLKu?=
 =?us-ascii?Q?uOc+y29U+73a4rw56gqinXj5dB3vSAgWELSqsFTQv5uxJlg+he/ifs/1tPmk?=
 =?us-ascii?Q?QERP69ho9AfZlQf7XIHb9wqkX1d891zikR5U7eu6ixuSDUb3HjGSOS3p4twi?=
 =?us-ascii?Q?hZJohsX+ZkRcsZfrlxspThPqT565XhmgHlXak6Br5czSzvhr4z4tARCBec07?=
 =?us-ascii?Q?dTOjPaU54irpVBJTWSivHojhOfvSnjEP6ycHpZDVtKgzv4Uphbyf1mBXh4Jy?=
 =?us-ascii?Q?ALEPMqu+r6X3orPC1sfRElpnjFsfwEuueoIX20aI0rHhfMO/s8q9uj3z4zVR?=
 =?us-ascii?Q?0yA/clZXNvphQtQ0d+GCZnuHCC8tCjSABDU5jl0vAqOro+wXaFk5bWi+9Bio?=
 =?us-ascii?Q?2j0rFOk+bKlR/tAsiGXM2Hgh3hqJbzvffwEYR40mYTgJq8LHE/dTHusswHJj?=
 =?us-ascii?Q?ejg6Usb/5Xb7wCD1xM60eydwTJdmmSyb63m3Ok8s89RBtKDw/fsCjh2Ic0x9?=
 =?us-ascii?Q?JweSMC0g/oT45/LXQz/X72pr6sT7uuEtpNWSF6nbpA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XbLPkd5Cv3E2VKtay72HgwQ1CnMETFEWm6FrXVPblVopN6rhFXK7UcXB0aJr?=
 =?us-ascii?Q?eHl4vJ+P2nU2CFdbfxT4cg9bo24iuD7v1UoDSqYsd/smVieZ1lmaEFScrRs2?=
 =?us-ascii?Q?PqeJpE3bgU2vf01n58Tn0MbFG0Flpsow8GngXmyDiAz07HR9O08O/+dwo4sf?=
 =?us-ascii?Q?SZw/HK1woWnSxME/ZUhLeUjvakkIlNvg7iM6UuoDELKyNpJNt6pgUsmyx9Kp?=
 =?us-ascii?Q?nernIbDv74ZkyLpC7xqy2BXUsbNLvn31OuC3rQGZEaz2oo4tNx8dwkWN4Y5m?=
 =?us-ascii?Q?Hk7LFnFKvAzp8F/oHqQ29QpX0HX2MTfgPaYtbaCR6mMf8i8VGQ1CxzuZXNa0?=
 =?us-ascii?Q?G2JuGBf9evDY6s4mDhZ9k2f5tEhPm0i+d9almoHdO1Zgvoj8JiHOpFM8hJgX?=
 =?us-ascii?Q?m98eRQtYEmnFH0l4NvGFyLZTLTgOnp7V7bEC/BwNffZF339VKNSrkLNK4lOV?=
 =?us-ascii?Q?L75APkNAgcFVE5p7MzH5KegAJE/voW+Elxhqor7nBmLVZFvw703/J21yMim1?=
 =?us-ascii?Q?9BTtv+Y5wLQ6xADFRvixhlIBBQ4fvvZ8XVN27deZvrn8M0zbzkctusfKMYdH?=
 =?us-ascii?Q?NckOkW23kOa5QzcsSbb2WOp95ki6KWi49j5kIyAJD0uMGYQuWkuSNFBTrP5I?=
 =?us-ascii?Q?wRRIOSXWYORoWILTXGiRVqbNj2LNgFYR3wGJaqtxFdIpfXLaQ7ZE16w1xFH0?=
 =?us-ascii?Q?GtAAkLbsdgAiFrPF9b/QnlS/tSnFUvdpt+n9gmEZpfA4A/NGFaGoIkqLV0Hg?=
 =?us-ascii?Q?fN0lJMeio4RfGIwjuckKraPqEu3m7W2Gibw4zB6ISt6lOJK9ydEcKP4i4oSy?=
 =?us-ascii?Q?7cCVDkDayAP2rgcGkUnx8bgtwdyY0oTLRNiay5dUX7xjYmJwk2Au3OIllAVj?=
 =?us-ascii?Q?EHWqv/xjMVf09yx+lJ9Ua4flqDS/3rCVeib1C8fkW0q9EXljwjONg1Mh7jHK?=
 =?us-ascii?Q?iARuyqI74T6lNOqJbfM7tK/5avZHhtmMp47OaG7pTXI5u1m3ubyfro7ZlhVF?=
 =?us-ascii?Q?50mIZ08cxO3/a6GzSQJQKM/4VEcaC5qY8u11tL4UqPfEoseNG56nXER9N7RR?=
 =?us-ascii?Q?GPNMZsFrwFx8Va73Ar+3OdOsyE65MPRyMz36S16N1M1EP86HnLykk4Lkytpr?=
 =?us-ascii?Q?vlbXS0sjfWjkUwIVwIR4K11vY3+0yi18NVHuJUgEwEbwSaJHP6BXJp1wHU3f?=
 =?us-ascii?Q?A4irPEu0Nr+vO1IeMlePfKlKJuz8lm+AVFzGvCsBrIr7fXYU/yJA5pJwHynL?=
 =?us-ascii?Q?tm95EsC8AWMOFtW8VNngTKIN1Ho3pUQdxwq4pRP7DElXOJcLY/k0TrCoTKx8?=
 =?us-ascii?Q?pQEIzJJhSuDIYY4Ge1EmFkmgjiCTlhTQ67J8IAHdDSiYn7MrNEcFctdgNZ2j?=
 =?us-ascii?Q?2Sw/fpk1rJ7JcspJg9zkKcz/hzY3NrdVBKZ02YeLy5QRKBdxTnVWg22eUrYR?=
 =?us-ascii?Q?7JlCFR8cd8U1NabqYosN3E9pRhDVYK8l7wStleR8axOYV42XKDbcAuD4mF8f?=
 =?us-ascii?Q?qL6LHyg1//49fM/6tcJBHJrhFx8uHo6s2MAnIv/0/YqPld68tfOfXcdx4RHj?=
 =?us-ascii?Q?nsSv70vSUscemkIWc+M8yhrWfGXXCfYOb2ocqqpf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bfadf40-daa1-4968-93f1-08dc685a7029
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 14:41:21.8946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mKPH2Z/8ds6AIB+OhNencoLYp2pSCMLSVsuoNxx6uc9Neg0EycoVsmhxtasLS1T+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4159

--=_MailMate_343333EC-EC17-4672-BD3E-FE5639625456_=
Content-Type: text/plain

On 29 Apr 2024, at 2:17, Anshuman Khandual wrote:

> On 4/28/24 02:18, Zi Yan wrote:
>> On 27 Apr 2024, at 16:45, Zi Yan wrote:
>>
>>> On 27 Apr 2024, at 15:11, John Hubbard wrote:
>>>
>>>> On 4/27/24 8:14 AM, Zi Yan wrote:
>>>>> On 27 Apr 2024, at 0:41, John Hubbard wrote:
>>>>>> On 4/25/24 10:07 AM, Ryan Roberts wrote:
>>>>>>> __split_huge_pmd_locked() can be called for a present THP, devmap or
>>>>>>> (non-present) migration entry. It calls pmdp_invalidate()
>>>>>>> unconditionally on the pmdp and only determines if it is present or not
>>>>>>> based on the returned old pmd. This is a problem for the migration entry
>>>>>>> case because pmd_mkinvalid(), called by pmdp_invalidate() must only be
>>>>>>> called for a present pmd.
>>>>>>>
>>>>>>> On arm64 at least, pmd_mkinvalid() will mark the pmd such that any
>>>>>>> future call to pmd_present() will return true. And therefore any
>>>>>>> lockless pgtable walker could see the migration entry pmd in this state
>>>>>>> and start interpretting the fields as if it were present, leading to
>>>>>>> BadThings (TM). GUP-fast appears to be one such lockless pgtable walker.
>>>>>>> I suspect the same is possible on other architectures.
>>>>>>>
>>>>>>> Fix this by only calling pmdp_invalidate() for a present pmd. And for
>>>>>> Yes, this seems like a good design decision (after reading through the
>>>>>> discussion that you all had in the other threads).
>>>>> This will only be good for arm64 and does not prevent other arch developers
>>>>> to write code breaking arm64, since only arm64's pmd_mkinvalid() can turn
>>>>> a swap entry to a pmd_present() entry.
>>>> Well, let's characterize it in a bit more detail, then:
>>>>
>>>> 1) This patch will make things better for arm64. That's important!
>>>>
>>>> 2) Equally important, this patch does not make anything worse for
>>>>    other CPU arches.
>>>>
>>>> 3) This patch represents a new design constraint on the CPU arch
>>>>    layer, and thus requires documentation and whatever enforcement
>>>>    we can provide, in order to keep future code out of trouble.
>>>>
>>>> 3.a) See the VM_WARN_ON() hunks below.
>>>>
>>>> 3.b) I like the new design constraint, because it is reasonable and
>>>>      clearly understandable: don't invalidate a non-present page
>>>>      table entry.
>>>>
>>>> I do wonder if there is somewhere else that this should be documented?
>> In terms of documentation, at least in Documentation/mm/arch_pgtable_helpers.rst,
>> pmd_mkinvalid() entry needs to add "do not call on an invalid entry as
>> it breaks arm64"
>
> s/invalid/non-present ?					^^^^^^^^^^^^^
>
> But validation via mm/debug_vm_pgtable.c would require a predictable return
> value from pmd_mkinvalid() e.g return old pmd when the entry is not present.
>
> 	ASSERT(pmd = pmd_mkinvalid(pmd)) - when pmd is not present
>
> Otherwise, wondering how the semantics could be validated in the test.

I thought about checking this in mm/debug_vm_pgtable.c but concluded it is
impossible. We want to make sure no one use pmd_mkinvalid() on
!pmd_present() entries but that requires pmd_mkinvalid() on input entries'
at code writing time. A runtime test like mm/debug_vm_pgtable.c does not help.

I also even thought about changing pmd_mkinvalid() input parameter type to
a new pmd_invalid_t, so the type system can enforce it, but when we read
from a PMD entry, unless we inspect the bits, there is no way of determining
it is valid or not statically.

To me, the most future proof method is to make arm64 pmd_mkinvalid() to return
without changing anything if the input entry is !pmd_present(). This aligns
arm64 pmd_mkinvalid() with other arches pmd_mkinvalid() semantics, so that
if someone writes code using pmd_mkinvalid(), which runs on arches other than
arm64, the code would also work on arm64. But I am not going to insist on this
and let Ryan to make the call.


--
Best Regards,
Yan, Zi

--=_MailMate_343333EC-EC17-4672-BD3E-FE5639625456_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmYvsZAPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUsMoP+wZVtQkz0PVJrCX8SlrLczGOg/gLrXEYSMP1
8eBgDOl6uBQ/zHxPjXcUu966xzooGl7YGBwU4KN59Qv0IB+mkJH+A58UPYoeOXCZ
HUTbXO3lwc2MnSXPOF/uvNYKEOQw2RBvtx720oz+O+riZpeYmA6AWJxwgCQXKcbN
hZVnZn/5zlRoOg5b1PfPYjgsfwAk1iVNtdouPbPKP921YGFU2Ub1NzUdCLbXbHL8
WwajQDupaW4dY1BXuARtbMFQ6amj0XQOV0oC6dSwmE5v3+F0RRVXqoEvZ7uFXmfy
/O0gOpac7g9MsN1gsAXpf6a9bF/ccZuT76Jo/yLq/4+ezTNXSTjRKslW3P8JMvFK
S+mdzsFTwzMMZk8xFeufuuIuY/6w1iKoGhwrKPgD/oi/ByeBODsyL5fPMJC4l57D
khMpZjkPjs7y2bFl+PAYuJB+n5s66PPtZ98NFg5i3Xq93wf7WZkI8iSOQGXmxciR
UNanDPcyalgJ54tqSTB3Y1vvmpEuqjJpFn8u9tv48OsIDKUjFuyRDPeWwk7ieJDI
q6rS7QxE5u+lN9mYWX4Tm50bPFD9rUXA1Inb0vdypF8BAPjNg763/iLRw1k7f0Z6
xuYI1kHhKHpzFV+bBtwQUyekYQH0EG6+MdvBhBsafdzQha4D608fpchSNNm4z3Wm
Y2aIxKrf
=/eT3
-----END PGP SIGNATURE-----

--=_MailMate_343333EC-EC17-4672-BD3E-FE5639625456_=--

