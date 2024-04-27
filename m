Return-Path: <linux-kernel+bounces-161186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 574F18B4817
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 22:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD1FF1F21979
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 20:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE09144D22;
	Sat, 27 Apr 2024 20:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NXwGGjHo"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5228710E6
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 20:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714250914; cv=fail; b=pWWIo0CkBDgLL252eDpZLwiSryV3xrOwPBNhzHVBZHqPwRoO3OiBHOqLk+zaWpVWjtwzxhHnMJrb3jD9A8kmMlgBO0FxY2r2k/kXNlr6h6sOBTCs6QAd64PNN9xAT0O5xcn4d+ljt7NgAf2iWNOkDEb+OTTOQv1hSrNSHh/ik4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714250914; c=relaxed/simple;
	bh=l/pxRPK2bylM5m26ud1xINwAtpL54FvdvlX8/rK+AIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kNfG7kOJw6Bw2/hhie7LKCiFd7eCVAhnsXmqPN1lhEhhzoWz8WxfmvPHVaFpqwDTlDKqoU7x2NN4plORSvFj8nf0jW6mplQyNbon1qgujy1ilSgrPwNnyyK4SWg3fJewpKuzShIVUziIhHEXaAN28M5opgzI+/wpPjiNSVe44ZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NXwGGjHo; arc=fail smtp.client-ip=40.107.223.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sxg+sXls2b8gAsObQFNIzoCwJHhNUHifqz17Qf7ym75P3BexzDuX6TFPIKZKyK1qn1aTKx/5VX7ODQ6PYyVI5bKHREszk1IlVkvAwvkXTyIFLVTTrg6+1u+CAgrHeQ71PcTID/FqC839eJFltTUWgzK0iFXMlKQjrs0lHQObkGX0G+GWk4p1OCT7w2CMM+sc/Scy0e+aOxrPTyuDxxqAXGTZqTpbFSX1eSs660QA2R1zbwUj0Szo6NF8n62t7W4gXFmfzafMhdigT0YoSPTh5LzyGHPe6VxG7hk6Ypymnq3egO/lVvsFsw9OueX5sdFpjIM4yX32Kd11HJ+fmEQ//g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xYS4PrGtmW4i4A32z+8HOHWqS0fSYc+EDr5tkPwg1a0=;
 b=f3ZhtsDwdITlFconq077KluwJ+IhJ6wphZr+KVMNcufnY6G7FUgkWXXeEPO4CKBTwe/PnUNfZcvm3FMclnFqulwjzoyIMlTwDtwFTYi/ASR9/X05mAxYqo16sHbE3CS9Tr6rip35DCsnsGZ1aNggcV/nBv3sU82s53Bc57VZ9xHUAJX003wm66AGhjQN90OXhxXiMwPrF4ffXSkDBfkrcbbVq2OiThebAoDJlFbaZizeY88PQq7l8FrEjvIUc8AcgimecFy6uuI4kM58jPo7tQbNqFPGu9iNOVGbp82IUQhfJredDDB9vdfqN/jxVj1gctruL4clffTN5NkYHSbYHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xYS4PrGtmW4i4A32z+8HOHWqS0fSYc+EDr5tkPwg1a0=;
 b=NXwGGjHoVMV52YB3CLt5IzlC7ItDnhwIzM5E0TH6qwLRDC4t2Cln+dhUfRcp4R0icpuwDOozV1eEdEyJvyf4JpHcQBFSziZ5a6i7LC3nf5tDs366DeQDaPxUnHP9glNOjVBWIuQTxRO5tIIUBw5e5im8Dwn3G0oKEFNC57w3BY1UMJIkg8htIS6U4DSApld6M+10icCqFonZBoVZB6OotycG5bggjqqKjZ8bvA3Kx/zFCqv4Nf2t3jlEcwvEnhNl/PlHIpl7hADlyh7JtmNzYCh1qyVi9wzLvtiWTERSPfL1SukrW7y59DsnHeKGPbMbjsjKvQwG89Vu987mZjfeZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SA3PR12MB9106.namprd12.prod.outlook.com (2603:10b6:806:37e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32; Sat, 27 Apr
 2024 20:48:29 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7519.031; Sat, 27 Apr 2024
 20:48:29 +0000
From: Zi Yan <ziy@nvidia.com>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <zi.yan@cs.rutgers.edu>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm: Fix race between __split_huge_pmd_locked() and
 GUP-fast
Date: Sat, 27 Apr 2024 16:48:27 -0400
X-Mailer: MailMate (1.14r6030)
Message-ID: <4E0ACD41-970E-4EAF-84D7-FFDB5CD49B3E@nvidia.com>
In-Reply-To: <E18F9D0B-C855-4252-BEEB-F8B1FA5BCE9E@nvidia.com>
References: <20240425170704.3379492-1-ryan.roberts@arm.com>
 <17956e0f-1101-42d7-9cba-87e196312484@nvidia.com>
 <2C9D897B-0E96-42F0-B3C4-9926E6DF5F4B@nvidia.com>
 <328b2b69-e4ab-4a00-9137-1f7c3dc2d195@nvidia.com>
 <E18F9D0B-C855-4252-BEEB-F8B1FA5BCE9E@nvidia.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_C11DFD4F-C48C-4EBF-BA06-8BE030EFB045_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL0PR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:208:91::33) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SA3PR12MB9106:EE_
X-MS-Office365-Filtering-Correlation-Id: 0597c853-24c5-48bb-5d5b-08dc66fb64c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+KJGxLe0PMkRQKZkVFxRJbj7pmjzvHwIdPVrhi8Z+KbqEemBIZ6yZV0nkg/1?=
 =?us-ascii?Q?GBDeVa4zZYcB9iGD5il2X9UGOXSrI8SMo8PZdhA0PDLsJ/0b5pMJ2Aabc2KL?=
 =?us-ascii?Q?jowMvkbDSLD88jE0XBUD1nIKY7ysR6cZql+Pxiv59ZkikVm2iLmmogeEYgOu?=
 =?us-ascii?Q?TOHeMcvqfrfkdGd+MfFqOTc+SawQFfkIJo1YAEPvrDyPfiro/jXWLEbz0JKY?=
 =?us-ascii?Q?h4Wb8K0uMT5/+7GNPRF8s0hgA0Fy0RnvXbaCUkg0I4HDxvvrz5MCwuuaU9bW?=
 =?us-ascii?Q?34tpJ+WKK0KY0wUvN4H0qqATxikppZUGKdK1j9j+DOQl19we5VDdmGc6Gt7z?=
 =?us-ascii?Q?Eb6JYvdbMOSMIaZNGCcZNSAfDFiY3WjT6+PxYN6VFzhk0VKY1Gv67uUM3teP?=
 =?us-ascii?Q?uxzowEu2HHywRR4m1QauIJQfJnzjWsVNFmSJcjB2U6BPnusL3sDmzX5mmlrE?=
 =?us-ascii?Q?eEF1fSf1u1G3oBMMXZnkhrZiQrB/wXYv2YuJEsZrR+b7Ul2dCqyQX9DDc8Ad?=
 =?us-ascii?Q?DPaWYY4zktjTKO6l9/1Pr2JjerJ/5k4ISP/DMkkHV7Jvop7R0qxveR/fbhG/?=
 =?us-ascii?Q?XSiTPu5LTFpe37aobpBBvN813xOQMftQm0r3v4GZQj8K3kYhqgZxeFSyMlNo?=
 =?us-ascii?Q?mZ5drwsHMnH7H/is6sPGFELM6ZKrMrSXKPwxxIRQTDp3xxjqi8Rn/6uTwo+b?=
 =?us-ascii?Q?YweKsBGQcZEcCEV+LjwJuG4nvOCVcTQQ4n6TIxD0Yn/tPh0Aqa3hAhjb4R2P?=
 =?us-ascii?Q?WHe8xmldJK6y8oS4DsTh2BFlVvhe3TlZLspWdcaKHaxNHn4rnNg31R/T0/6x?=
 =?us-ascii?Q?xA3Ez2+sCuyQE/gcLGRJhX/Rm5bj1mxxFtSu5mQUx7N1S79Z6v5BfL3dIwGV?=
 =?us-ascii?Q?sHQy+jKwSuBcFuKYgBhBTZbbAlCjH7O9mKemTmESDll5oNmpeKWZWA1p10eu?=
 =?us-ascii?Q?9uesSpOWlh5vkqaWSs0KMEa36CXMsG2FcJaJ18Gy5zfo3tfWvpEt2yJdpM1o?=
 =?us-ascii?Q?fSE8O6/k1lN0wMEbbHbtw/iIQ3RNypbDj4bUictJHZ670dXP3c8hHP6/f1Pk?=
 =?us-ascii?Q?39NrP8GoU/Hiz0kRN9f68l12tmuMEv8rDysvTqTZs7LECZyyshGIAGmQSejo?=
 =?us-ascii?Q?bFc1WL3/rVm7DNSwrKcHodJ+4ogIeitjpqfXkduCX9vcG9/u/rFvEUSIdIb+?=
 =?us-ascii?Q?ThWTQFeUZb7hGLgsJs0miu6xfEdreg0+QBuG8c9ovYPT74KuqFcnQ0C4uP4O?=
 =?us-ascii?Q?KYwhZgBLm+Q11y6XxtWYP5f6zHCOIm1QL5AgWbyWkg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iAl5x8YBbGxSFMshk80AwWf3zu3ipD1W5EFvQ24gBMAw8+k51VINiczfrGN9?=
 =?us-ascii?Q?bC0K7u4HR8fK/f2T4LvpknWCvj+od0Q0A+sRKADI/zGCAhogT6SxPq5jsAAz?=
 =?us-ascii?Q?FfvtkhBmhbamqnMCnJ2zEGYT/1B9ksszMaU3oGhQxzbHoXKV6y4a8U2o1Ljc?=
 =?us-ascii?Q?kY+YdASSGwaVLb2P6vVMbbtUQP79Vt2XEPNPnBGmOXqFSLAqq6L5aRwl8vW+?=
 =?us-ascii?Q?MKHuadjiqU6DBlJziVMLdSounJ8EQZdZ7anM0RX0n8ibGjzyn0++J+GxZnrb?=
 =?us-ascii?Q?Sfr9+9vyW44UrQQ8rJOWJnFOnEDh5IMH6QfwAXfLKZ6Yn6sN6L2NDhO2fO+3?=
 =?us-ascii?Q?iVa9ae4rJtcGUwDpdDUFFDn5Wc9lNNwd3ZpMdx0NlUcI7WgtqeMT55tiB/+E?=
 =?us-ascii?Q?DDRtoFGSkpEvHsy2dgeKXf4/RWdjwTsFk13SqZceHrnazSpr2iU8ywALQ7WA?=
 =?us-ascii?Q?SKpGixUgosBpLtwhi0LPfmI0yeF4tjHyC7R2ljKPQC01L0i+H0xwZ8wHrRvk?=
 =?us-ascii?Q?d1vvoBgmhey+ZwaRySBdl+AeP+DlcWQGM9FjFwpJTPzxRD+/AHgIOzKFKpCJ?=
 =?us-ascii?Q?7zF+nZTv3R9lGFkuBoNtS82ksmI0bUkhMNgHi305HQgT4S6nbvLpAIZV0GF9?=
 =?us-ascii?Q?HcTWQilsfkD6CBuuFyZ2UIDz4q/+i0ixPOj01RPC+noNSbBWoMqpBqSKOcfo?=
 =?us-ascii?Q?+fzQxV+Qv9uKncP3y/qLftdJmW/L0+x0DaB6gp1qvE/4DXHKdiuN0oVR2bWf?=
 =?us-ascii?Q?O1/nCKMM/4nJ1e1zSSfkNsLkO72qwcMcZWYawmM/QRHKa4pPQn7uyTxSdtlx?=
 =?us-ascii?Q?Qnod7JtiJaJ1F4KKKmBuQiMCdSty+P2485tXH3o6aMa4rIcEpCktHRvqh5aU?=
 =?us-ascii?Q?x1BPT+n3qCsBtAt2I4sCPfsbni9j9fviCH4KWxxj1Jlz2FpIJL2ncOpa4sUM?=
 =?us-ascii?Q?GEhfA+JHR4vDfa8Q3GfJy/o4WOkPq+7ENmYYockzNAimqu5ZFBgOI4dIF2wz?=
 =?us-ascii?Q?DGpLF/9cLdYD589O1AGWAoAIFM6VQ/UkRBSMOU6hRQYOrczyKVEqEZir3Leq?=
 =?us-ascii?Q?Kxv5NbR9pjlCzU2pVNZG0AhfTemVNv0ZnjrYRvssMK27lWKriEIi8w3Ds+5L?=
 =?us-ascii?Q?uM6SoFzf6/JTLmHFnDrIAPeX00A1CQDBX0KHse1uYlIXLlSSbENGnqaLnkUM?=
 =?us-ascii?Q?XxXPjRHSMBCCw+b9ytYE7YB85ydpJkhRrEZ/xe1yAzwfDvPHGwXgubqNjlkF?=
 =?us-ascii?Q?9iNoIk6UkOn3bGcKv3+LZp3FWBqxZNqWV73U17IhSDLFMkUxEE1PS2WgI+Uf?=
 =?us-ascii?Q?5yXClO2KpbjV06+pjJAoOyhN2bJgStOg+xe5D7qz7ghEY74TzSIo0jicqEoH?=
 =?us-ascii?Q?XIs4jPbWTmnR2ISJ/Em6Luf+Wkt/dAmdomxVA6vi6YnPuUgwmkpLiY9Hipt3?=
 =?us-ascii?Q?ppQr6gb+U+p8IAeSPVe2/nT9H9QE8LsVXYaJZagOMK4DRVGHzdwDVpkXIXJp?=
 =?us-ascii?Q?uv9u8oZjcsM+a1k2JNR5SgdLwoE5+wsCFZuIj4aYIjZUKUopqegE6hwoHqwy?=
 =?us-ascii?Q?CKvprHev3ELM5TGIGI5601TgUkevm6ZAiVbnyqEr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0597c853-24c5-48bb-5d5b-08dc66fb64c9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2024 20:48:29.4713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: giHXJSqsyDVGKRsMWS+S8CmOY1EPZkyH6kdlLH/7n4lYtKBDaAxPGF1AZj7S1g8n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9106

--=_MailMate_C11DFD4F-C48C-4EBF-BA06-8BE030EFB045_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 27 Apr 2024, at 16:45, Zi Yan wrote:

> On 27 Apr 2024, at 15:11, John Hubbard wrote:
>
>> On 4/27/24 8:14 AM, Zi Yan wrote:
>>> On 27 Apr 2024, at 0:41, John Hubbard wrote:
>>>> On 4/25/24 10:07 AM, Ryan Roberts wrote:
>>>>> __split_huge_pmd_locked() can be called for a present THP, devmap o=
r
>>>>> (non-present) migration entry. It calls pmdp_invalidate()
>>>>> unconditionally on the pmdp and only determines if it is present or=
 not
>>>>> based on the returned old pmd. This is a problem for the migration =
entry
>>>>> case because pmd_mkinvalid(), called by pmdp_invalidate() must only=
 be
>>>>> called for a present pmd.
>>>>>
>>>>> On arm64 at least, pmd_mkinvalid() will mark the pmd such that any
>>>>> future call to pmd_present() will return true. And therefore any
>>>>> lockless pgtable walker could see the migration entry pmd in this s=
tate
>>>>> and start interpretting the fields as if it were present, leading t=
o
>>>>> BadThings (TM). GUP-fast appears to be one such lockless pgtable wa=
lker.
>>>>> I suspect the same is possible on other architectures.
>>>>>
>>>>> Fix this by only calling pmdp_invalidate() for a present pmd. And f=
or
>>>>
>>>> Yes, this seems like a good design decision (after reading through t=
he
>>>> discussion that you all had in the other threads).
>>>
>>> This will only be good for arm64 and does not prevent other arch deve=
lopers
>>> to write code breaking arm64, since only arm64's pmd_mkinvalid() can =
turn
>>> a swap entry to a pmd_present() entry.
>>
>> Well, let's characterize it in a bit more detail, then:
>>
>> 1) This patch will make things better for arm64. That's important!
>>
>> 2) Equally important, this patch does not make anything worse for
>>    other CPU arches.
>>
>> 3) This patch represents a new design constraint on the CPU arch
>>    layer, and thus requires documentation and whatever enforcement
>>    we can provide, in order to keep future code out of trouble.
>>
>> 3.a) See the VM_WARN_ON() hunks below.
>>
>> 3.b) I like the new design constraint, because it is reasonable and
>>      clearly understandable: don't invalidate a non-present page
>>      table entry.
>>
>> I do wonder if there is somewhere else that this should be documented?=


In terms of documentation, at least in Documentation/mm/arch_pgtable_help=
ers.rst,
pmd_mkinvalid() entry needs to add "do not call on an invalid entry as
it breaks arm64".

>
> The issue is pmd_mkinvalid(), since it turns a swap entry into a pmd_pr=
esent()
> entry on arm64. This patch only adds a warning on pmd_invalidate(), alt=
hough
> pmd_invalidate() is the only caller of pmd_mkinvalid(). This means any
> future user of pmd_mkinvalid() can cause the same issue on arm64 withou=
t any
> warning.
>
> I am not against changing the logic in __split_huge_pmd_lock() to fix a=
rm64,
> but just want to prevent future errors, that might only be possible on =
arm64.
>
> BTW, in terms of the patch itself, moving "pmdp_invalidate(vma, haddr, =
pmd)"
> without moving the big comment above it is not OK, since later no one c=
an
> figure out why that comment is there.
>
>
>>
>>
>> thanks,
>> -- =

>> John Hubbard
>> NVIDIA
>>
>>
>>>>
>>>>> good measure let's add a warning to the generic implementation of
>>>>> pmdp_invalidate(). I've manually reviewed all other
>>>>> pmdp_invalidate[_ad]() call sites and believe all others to be
>>>>> conformant.
>>>>>
>>>>> This is a theoretical bug found during code review. I don't have an=
y
>>>>> test case to trigger it in practice.
>>>>>
>>>>> Fixes: 84c3fc4e9c56 ("mm: thp: check pmd migration entry in common =
path")
>>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>>> ---
>>>>>
>>>>> Applies on top of v6.9-rc5. Passes all the mm selftests on arm64.
>>>>>
>>>>> Thanks,
>>>>> Ryan
>>>>>
>>>>>
>>>>>    mm/huge_memory.c     | 5 +++--
>>>>>    mm/pgtable-generic.c | 2 ++
>>>>>    2 files changed, 5 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>>> index 89f58c7603b2..80939ad00718 100644
>>>>> --- a/mm/huge_memory.c
>>>>> +++ b/mm/huge_memory.c
>>>>> @@ -2513,12 +2513,12 @@ static void __split_huge_pmd_locked(struct =
vm_area_struct *vma, pmd_t *pmd,
>>>>>    	 * for this pmd), then we flush the SMP TLB and finally we writ=
e the
>>>>>    	 * non-huge version of the pmd entry with pmd_populate.
>>>>>    	 */
>>>>> -	old_pmd =3D pmdp_invalidate(vma, haddr, pmd);
>>>>>
>>>>> -	pmd_migration =3D is_pmd_migration_entry(old_pmd);
>>>>> +	pmd_migration =3D is_pmd_migration_entry(*pmd);
>>>>>    	if (unlikely(pmd_migration)) {
>>>>>    		swp_entry_t entry;
>>>>>
>>>>> +		old_pmd =3D *pmd;
>>>>>    		entry =3D pmd_to_swp_entry(old_pmd);
>>>>>    		page =3D pfn_swap_entry_to_page(entry);
>>>>>    		write =3D is_writable_migration_entry(entry);
>>>>> @@ -2529,6 +2529,7 @@ static void __split_huge_pmd_locked(struct vm=
_area_struct *vma, pmd_t *pmd,
>>>>>    		soft_dirty =3D pmd_swp_soft_dirty(old_pmd);
>>>>>    		uffd_wp =3D pmd_swp_uffd_wp(old_pmd);
>>>>>    	} else {
>>>>> +		old_pmd =3D pmdp_invalidate(vma, haddr, pmd);
>>>>
>>>> This looks good, except that now I am deeply confused about the pre-=
existing
>>>> logic. I thought that migration entries were a subset of swap entrie=
s,
>>>> but this code seems to be treating is_pmd_migration_entry() as a
>>>> synonym for "is a swap entry". Can you shed any light on this for me=
?
>>>
>>> It is likely because kernel only split present pmd and migration pmd,=
 but I
>>> could be wrong since the code is changed a lot since splitting migrat=
ion
>>> pmd was added. We either need to check all call sites or check pmd_pr=
esent()
>>> instead of is_pmd_migration_entry() and handle all possible situation=
s.
>>>
>>>>
>>>>
>>>>>    		page =3D pmd_page(old_pmd);
>>>>>    		folio =3D page_folio(page);
>>>>>    		if (pmd_dirty(old_pmd)) {
>>>>> diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
>>>>> index 4fcd959dcc4d..74e34ea90656 100644
>>>>> --- a/mm/pgtable-generic.c
>>>>> +++ b/mm/pgtable-generic.c
>>>>> @@ -198,6 +198,7 @@ pgtable_t pgtable_trans_huge_withdraw(struct mm=
_struct *mm, pmd_t *pmdp)
>>>>>    pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long =
address,
>>>>>    		     pmd_t *pmdp)
>>>>>    {
>>>>> +	VM_WARN_ON(!pmd_present(*pmdp));
>>>>>    	pmd_t old =3D pmdp_establish(vma, address, pmdp, pmd_mkinvalid(=
*pmdp));
>>>>>    	flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
>>>>>    	return old;
>>>>> @@ -208,6 +209,7 @@ pmd_t pmdp_invalidate(struct vm_area_struct *vm=
a, unsigned long address,
>>>>>    pmd_t pmdp_invalidate_ad(struct vm_area_struct *vma, unsigned lo=
ng address,
>>>>>    			 pmd_t *pmdp)
>>>>>    {
>>>>> +	VM_WARN_ON(!pmd_present(*pmdp));
>>>>
>>>> Should these be VM_WARN_ON_ONCE(), instead?
>>>>
>>>> Also, this seems like a good place to put a little comment in, to ma=
rk the
>>>> new design constraint. Something like "Only present entries are allo=
wed
>>>> to be invalidated", perhaps.
>>>>
>>>>
>>>>>    	return pmdp_invalidate(vma, address, pmdp);
>>>>>    }
>>>>>    #endif
>>>>> --
>>>>> 2.25.1
>>>>>
>>>>>
>>>>
>>>> thanks,
>>>> -- =

>>>> John Hubbard
>>>> NVIDIA
>>>
>>>
>>> --
>>> Best Regards,
>>> Yan, Zi
>
>
> --
> Best Regards,
> Yan, Zi


--
Best Regards,
Yan, Zi

--=_MailMate_C11DFD4F-C48C-4EBF-BA06-8BE030EFB045_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmYtZJsPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUVZ0QAKGQgWamejEIaj3yVomOwVd/AGSJSk/lvo5s
/ddmfA9QEaMyHMx9HmJzqfJlHTC/SoTVkLfTYAgqBRPIJEK09bE7JDJ8oGHWZx/J
FGI+gzN/5GbTdbDfsqHmZzu1/5peHa56B40wBgp5u5rnIsOezGQvixnhFOf0Pbot
7j733WYtfjFWk/gBMDMd/TUU2aaErl18gg7XhqEkZzrzNseh2yEJoAce5uo3e3w+
9F59iG+mPN/Q/JBaxRvRzMiblgvje3feUG+2R53Cc5LHaGqjlVk/z8fVKpGYcZ5b
o1XT7RhjNuL03yTj7flLGUQzQOX8Fb5zcjOEiI/VAl6oB+DFqi5GtY4sYvuj6ds1
6DNvAHdJeOGUj+j29kjnpP2SK52Wo6romm058LT6UlofeiN7XHrrysKW3HdlTX5d
3JdMcyRB9dzJ8l2eJnWO5IHWPS0gyLznTWL+jWgzu7zJSzHgwgeXpiUM6fFuxAKY
Hzpt90sksHgczHSX4jRPMT0bMhiylIQpDEMsEZ/7oeVk+AOvlJRxgXm04TFqP6je
54o5HlDjFCGQ4/HkA9QydUXcalJs2PduTJGiRlFowL5HuP8zaPk6KCK+7FXx1Zmk
SwM1g9T+38lNZofYaw1wlwvGqp3BJO7E04n+zjr3oW1Nfb6Mk9qQtceomBxNNzkU
yULl33pz
=EQ2U
-----END PGP SIGNATURE-----

--=_MailMate_C11DFD4F-C48C-4EBF-BA06-8BE030EFB045_=--

