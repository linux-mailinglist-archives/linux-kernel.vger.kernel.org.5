Return-Path: <linux-kernel+bounces-161185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2E18B4816
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 22:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 264D01C20CAD
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 20:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7288F144D22;
	Sat, 27 Apr 2024 20:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G9EzWK0Z"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2050.outbound.protection.outlook.com [40.107.102.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3171010E6
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 20:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714250742; cv=fail; b=Y0/ronQUSs9bKvsfpjVUCmsyE75+8aCXgtYOctG7Kgs9oWIZlDeadjlTRUkVSeymtYAkoDw8FkHE5IpnCXGpScGCDKuMuV/61X/dg5aKbkYD5Qi78CIbxNHr8SLFbLLqFUKCjQym5MZTfQAoz9Efz6aEdFfY4Y/gUaeFCjkHpOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714250742; c=relaxed/simple;
	bh=U163/Eu7CmEDcT8ukeiQS9ZqflJwyRTwb3FISzsdyMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m7EpHTaHKMwotbSpyPTrom5AqwLpJ1UweFRW3RLkbQPAhdc7FQRbuF7/8ixEAfhaDrAe4+NpZJgQKh3xeeyiOPkRM2G6kXU/RdmNNE4s7j0c9p4+AhRBEDHZCXWH/VZcNDncR7CLQaghTxDNrlGGHasu60AFlnzpGSyk60UWmmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G9EzWK0Z; arc=fail smtp.client-ip=40.107.102.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nvKyBX9PEOkRUK30Qkzl/jGrbFHcb1bDHXo3bisu2lb3wumEPYhSwYqXYBuThsoqNDGHG2ainwLDpDkj3SrnEaU1N5srSLJ8LsR58plqgZuNe01mcFuFl9ikPGewpVKPWQ7Bc0vsOdyBxDLVjmpuHSJ3QPz/3I1Yxnr/UrbukaDVDqO18Lvbs/yMpFxsBYafzyhZYevAD45a1vqTwjxvBdy9jBcpmSc66yygzQ0BYAEui0w3WpvGTrOdDhxf4Xg+2Vep70hi2Af/tnQ7EcSZWpIXurd7cgY900mcmrICR6Jd1HBg6VkaBaPbFnH8NySpjM3VgxL0bhzwMGr3Ssv+sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jD/0xRRe3gc1tIQWtN/tsx4TsUUwiLB/23mVARwt5kI=;
 b=kTxGgF6Zelov7+Hc56s1zxiDK57j12kFTEGYpJcwT5SR3P3GYXYBWuafZQ3TCLbzrpDm23joSxifa0S2hM7We1aEWCq9jbPk4juuKz1qT0Rkl38tg3CAUoJgpJl3n/BjVUAe68J9Q1WtKaVZjJ9yWaNdVXDEXuf5WrzSK9q8ugdc7cLNF+TBitLk10PmksXD1KSs3llAX96riBF6xo52lf1TFNV9m9D9PMHPwrxD88heDyG+ISDKSGFpvgJ9MqU34GDZ2nplwCpYNdHnbw25SqU8gHr2rKsXg/sTs9BxqT0RfbBThLuZBEqZgc8OKCnpOWADHo6mP63IzVapY6nCkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jD/0xRRe3gc1tIQWtN/tsx4TsUUwiLB/23mVARwt5kI=;
 b=G9EzWK0ZfGe1L6x778uGQexBebLRdfLxAvroaQQbQd6+c+D84idvTo9626cns3/fLbsVTJQjUIJhM4P1LQNgKH457ixQV4VTE+nzQDW2mZZXoMuogUoU4gwxp/+WPwVR7CakOUZ8Q6zk414KF425zX0gs5kt6iCWfruwvS/REtc0y8w3HEs7gC5/V3FnR2R7lFFtlOcD4+pCzgHyPDXj2tHD6dB7YaQh6NAmw4GwCoaVOA3b7XLMcI1dNXcJmkp0aMmsfYrVX8wfHyPhh5pstxqzD+fApQcQETRSrTlel+oUnQMN42zTI0F++POvqTzhX8x3M4vI/355NalKmkPR4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SA3PR12MB9106.namprd12.prod.outlook.com (2603:10b6:806:37e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32; Sat, 27 Apr
 2024 20:45:35 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7519.031; Sat, 27 Apr 2024
 20:45:35 +0000
From: Zi Yan <ziy@nvidia.com>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <zi.yan@cs.rutgers.edu>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm: Fix race between __split_huge_pmd_locked() and
 GUP-fast
Date: Sat, 27 Apr 2024 16:45:33 -0400
X-Mailer: MailMate (1.14r6030)
Message-ID: <E18F9D0B-C855-4252-BEEB-F8B1FA5BCE9E@nvidia.com>
In-Reply-To: <328b2b69-e4ab-4a00-9137-1f7c3dc2d195@nvidia.com>
References: <20240425170704.3379492-1-ryan.roberts@arm.com>
 <17956e0f-1101-42d7-9cba-87e196312484@nvidia.com>
 <2C9D897B-0E96-42F0-B3C4-9926E6DF5F4B@nvidia.com>
 <328b2b69-e4ab-4a00-9137-1f7c3dc2d195@nvidia.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_79B30AAD-B22B-4282-834B-AF1CC99F1D50_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1P223CA0022.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::27) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SA3PR12MB9106:EE_
X-MS-Office365-Filtering-Correlation-Id: 56110830-8c15-4a4b-774d-08dc66fafd0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lychYRY0SwjSjo2zKaUdlXOxDkiHtWOJGfUJlPSnQocIVKJSgia5BAfBeifc?=
 =?us-ascii?Q?cqxxTD72yFhWpgYvEWooKI9V8CvO8lC24LmEky2Tn2CKlhZI4Q3dd6SPG2FW?=
 =?us-ascii?Q?8zOP+AYHSUYbWPK6wA7cAI5NFsgBfQ3xl0HKq8kxqZ85wwLnRJek1Jqo82gs?=
 =?us-ascii?Q?C4CijwR5Byn60Ln6Xu/LI56tlurDg5dl5Wjoq9MbLXhxeFLRE9c2rS7v0gQd?=
 =?us-ascii?Q?4OueNuwEkaacHgxud6CkbUy4uEitPCekOGSuDlZ+T2LuOkAggUGTB1pO5QCo?=
 =?us-ascii?Q?EeBPlMAEvdVc5v3iezEjzzMkpUYQo8wU7cxBXcCxH4SRQCFhdGMybEzzW2LL?=
 =?us-ascii?Q?jv/2U1AB84PRORyQZV3Mc+cn5C2VasFA1LaGvRQ59vnNwF8ar0aAasr1lbxG?=
 =?us-ascii?Q?C7BD9rOmLJ9adztYgkFbJxwLXVcmebm9pbNGuIqruzU3bMkn59gqt4L6DWRR?=
 =?us-ascii?Q?m6kuzsKxLIsk4EIUchtydwaa2LQwq+Lziqv2/XRGwnF2MhC9i09USDsGCqEP?=
 =?us-ascii?Q?b5jjdyN7MOFOgKrYswIE2gn8cluBz/AeHRK0uqj5m6QkX0lpK3HKNW56PRVp?=
 =?us-ascii?Q?IwjLSChrFeAN6ZXfr80iabjuobuywtZ2ZbWbkFbrgSrHEFNl60af5IxZOWNA?=
 =?us-ascii?Q?E2EyI6qlGMuPOlrcaOJqDVcu44QQ2/ojWL5aykdQunwU6+FwGyLTnxVTgVwJ?=
 =?us-ascii?Q?XY8ZXV7vMhdpRqSwsX7aXm54TdQLXyLUIosdBGBK38ZmkG2Hd48d4fWeRLYf?=
 =?us-ascii?Q?0lqEEsW0B6poN/KUmUWFMUr/kwxl0rbdyKriFPMXudAhEwesQp7dKjkKou7M?=
 =?us-ascii?Q?PLmKXzNmNGT8e+nFDYuNSzKDVZOvvnn/LG9O0hiy8qdWuSmhOPZuSOf1Jk+x?=
 =?us-ascii?Q?iGjkDSg5FwkWdfuDtVaB+jHHM5nrRaXJd8UW5bp0Ne40T4XVdamG7JttzPa6?=
 =?us-ascii?Q?NXU15wbXxze40+SC8pTXJa535EkHRpKQYhdFBze37/b1klMPwcIkZbkE1+Lm?=
 =?us-ascii?Q?S6P81O4O039rcDdtJNzw2cxPzIbkZ9bOaKCCqG4VRWMZquKop9zw7kDO07qo?=
 =?us-ascii?Q?MFULsAEUHw4tqD5XXN8AOIALFiRuXTUQxtPQLT1yr+XYDwiwP9/JO4r7GgR4?=
 =?us-ascii?Q?AOu3dMGD1RwdzejzqKK++GzGwEqFDdljv9FqlfswQfKJU20jUVck2QMETMKq?=
 =?us-ascii?Q?vx1HWbYAep6bewVG2BM+E/8iDkqnsv90eQwfAIER7MVRnMro3rooUSVYhwsM?=
 =?us-ascii?Q?Jws1bwkdYAI7akjlXAIjWv2ZVxLOYMUAUyuthsQbSg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v35ZMXM8F80mMxKF0a51Kg2pg+fYGmFBwVv7GH0eCK3RD8vn/8sHiDyEKqRi?=
 =?us-ascii?Q?eBHODoqAhYpKbeo0hbkIGkfgL1J5QoJ6vQAQXoHi6F+gkwoQrKk21RZKbfpI?=
 =?us-ascii?Q?dEum8HuYmLvompD1IBnRssl4r0EWlqZNXrCNkFS0kF30vgpxCKKVCee5WgFV?=
 =?us-ascii?Q?gK0J0o55kLTx24tz9Fcmbnoa/6TpRuJSX3wcCBQGD68dmG5LoQq9DlLOhSfx?=
 =?us-ascii?Q?AhCjLzzaWDA16gS40mGBY2SiCU/J/KRgjSO0zUAI7pmsj6iMm/MFhQWDf8E4?=
 =?us-ascii?Q?t6xL2RcDcAFEZrUdd0dbgf5FM+wDYeePeyu9nSv72cuqIHelL6n+T/tA4Q9o?=
 =?us-ascii?Q?49LDLPmYfXRQ0bdq6cEtheQST0ToSis8M22zB8KkEW4VcEukd6PCOupKNCcf?=
 =?us-ascii?Q?tbWExmnu5aWLOQm37tnkTKFDddZCbe36fBP/4lzziTVnLRSgPFoULB8mMdHt?=
 =?us-ascii?Q?gsmZWl6dsXbRKG3qc6/JZWTfxVXFblW10qbQTblEkVi3dpVCB+HbQkbBPxNT?=
 =?us-ascii?Q?kxnvK+waThLZC6pl1Xg+/Td+fRPtHvUql40gY3qNhu5Uyp+W/0ELO4E4Ix2i?=
 =?us-ascii?Q?eumm4eHSUpZFDGoOVV1B4URXWt33mGpA4FzKBGCktjDPBLAcAOVATl6KcYaR?=
 =?us-ascii?Q?NSUeqh88AfXoRgmrqaACcqhJjk84p7cYRUc8NSRdJiA288xv+e8kHA2J/ULa?=
 =?us-ascii?Q?F964xzQqn7WXQkkb91x0YbBvuE2gJWLr2Te/lytwCkvmcEU3JzC4psxF/Uux?=
 =?us-ascii?Q?ZsSZrkvBdiBaVJe5uIIm7VoPWa2LKT/hmxtHK0bGo9wJ4l+U1iX9N076yiC9?=
 =?us-ascii?Q?roHfCR+BUNNK9iI3gUcx3hS0uOBe27Ub5mD+c16FgLOrGS6XLtQScLyZZ+rh?=
 =?us-ascii?Q?pprqqanhIZzQH2EEefelNlOirIkom51HnXNysLaaEolbgWnD529V90kKGS4/?=
 =?us-ascii?Q?Oi9HpIgK4mnk5DJ/wsEl87pPMgQ06w7XUDAKxpLXnQByehMENhN8kmeCs5EZ?=
 =?us-ascii?Q?DZBHdyHO4fEB24Fjfi1NfDhf4IZ/PjQL1WtQgo8Hqqhp9CD3jRTK7Vvy1lPr?=
 =?us-ascii?Q?GATiBM0FNc/gi1g70u6vD8/PsziLRx4tAg4wNRKV/HfsDHi+MbK2jrJodWX6?=
 =?us-ascii?Q?MSSouEfGgfZxe8LSOdJG4OSs1tkBBwfDl5ax/pvp3g2ta4Oayv9IDglZHPNS?=
 =?us-ascii?Q?ZIA9xgkZyXporTcZ0rlTtGTzDuZdw2Pj+lvfWJ8PSjxxt69MGhb5OlkKx2aB?=
 =?us-ascii?Q?CSyQSAABLMmBO+1VAubhQdFgsQeTHpYEApVAiA0xuoFj4L8CNDBYjsh3rRpT?=
 =?us-ascii?Q?7lAnYOZlgRS6mvfbnd+AQ/5QauhKh51aTZEvkCzk7ThirD1MG83p4a5+d/xt?=
 =?us-ascii?Q?Xuan7ljw6QJi/OwydZFIJuwGYkZJb6wGkbPuWBsVeAf9UbgiR6OW9FO6PzFi?=
 =?us-ascii?Q?UNUGlucBIKoFsQdVTPQ35dV518jVYt04C7wjr2fpmRN4NbToDTApYnM5OBM5?=
 =?us-ascii?Q?eDBlQF3RUkxCDMMDw4rHvItmmX4sHiBBE1RayX9hR7cvfmGCVBchl+342FO0?=
 =?us-ascii?Q?EF9tR+tt/URTuMcZtZY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56110830-8c15-4a4b-774d-08dc66fafd0a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2024 20:45:35.5072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hdRxDZVnvY3muGoxywNa1Ub6ZYmYd1M7yM/Y9Vep4PA6VwW+5YMU7Wis0PfP5Mco
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9106

--=_MailMate_79B30AAD-B22B-4282-834B-AF1CC99F1D50_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 27 Apr 2024, at 15:11, John Hubbard wrote:

> On 4/27/24 8:14 AM, Zi Yan wrote:
>> On 27 Apr 2024, at 0:41, John Hubbard wrote:
>>> On 4/25/24 10:07 AM, Ryan Roberts wrote:
>>>> __split_huge_pmd_locked() can be called for a present THP, devmap or=

>>>> (non-present) migration entry. It calls pmdp_invalidate()
>>>> unconditionally on the pmdp and only determines if it is present or =
not
>>>> based on the returned old pmd. This is a problem for the migration e=
ntry
>>>> case because pmd_mkinvalid(), called by pmdp_invalidate() must only =
be
>>>> called for a present pmd.
>>>>
>>>> On arm64 at least, pmd_mkinvalid() will mark the pmd such that any
>>>> future call to pmd_present() will return true. And therefore any
>>>> lockless pgtable walker could see the migration entry pmd in this st=
ate
>>>> and start interpretting the fields as if it were present, leading to=

>>>> BadThings (TM). GUP-fast appears to be one such lockless pgtable wal=
ker.
>>>> I suspect the same is possible on other architectures.
>>>>
>>>> Fix this by only calling pmdp_invalidate() for a present pmd. And fo=
r
>>>
>>> Yes, this seems like a good design decision (after reading through th=
e
>>> discussion that you all had in the other threads).
>>
>> This will only be good for arm64 and does not prevent other arch devel=
opers
>> to write code breaking arm64, since only arm64's pmd_mkinvalid() can t=
urn
>> a swap entry to a pmd_present() entry.
>
> Well, let's characterize it in a bit more detail, then:
>
> 1) This patch will make things better for arm64. That's important!
>
> 2) Equally important, this patch does not make anything worse for
>    other CPU arches.
>
> 3) This patch represents a new design constraint on the CPU arch
>    layer, and thus requires documentation and whatever enforcement
>    we can provide, in order to keep future code out of trouble.
>
> 3.a) See the VM_WARN_ON() hunks below.
>
> 3.b) I like the new design constraint, because it is reasonable and
>      clearly understandable: don't invalidate a non-present page
>      table entry.
>
> I do wonder if there is somewhere else that this should be documented?

The issue is pmd_mkinvalid(), since it turns a swap entry into a pmd_pres=
ent()
entry on arm64. This patch only adds a warning on pmd_invalidate(), altho=
ugh
pmd_invalidate() is the only caller of pmd_mkinvalid(). This means any
future user of pmd_mkinvalid() can cause the same issue on arm64 without =
any
warning.

I am not against changing the logic in __split_huge_pmd_lock() to fix arm=
64,
but just want to prevent future errors, that might only be possible on ar=
m64.

BTW, in terms of the patch itself, moving "pmdp_invalidate(vma, haddr, pm=
d)"
without moving the big comment above it is not OK, since later no one can=

figure out why that comment is there.


>
>
> thanks,
> -- =

> John Hubbard
> NVIDIA
>
>
>>>
>>>> good measure let's add a warning to the generic implementation of
>>>> pmdp_invalidate(). I've manually reviewed all other
>>>> pmdp_invalidate[_ad]() call sites and believe all others to be
>>>> conformant.
>>>>
>>>> This is a theoretical bug found during code review. I don't have any=

>>>> test case to trigger it in practice.
>>>>
>>>> Fixes: 84c3fc4e9c56 ("mm: thp: check pmd migration entry in common p=
ath")
>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>> ---
>>>>
>>>> Applies on top of v6.9-rc5. Passes all the mm selftests on arm64.
>>>>
>>>> Thanks,
>>>> Ryan
>>>>
>>>>
>>>>    mm/huge_memory.c     | 5 +++--
>>>>    mm/pgtable-generic.c | 2 ++
>>>>    2 files changed, 5 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>> index 89f58c7603b2..80939ad00718 100644
>>>> --- a/mm/huge_memory.c
>>>> +++ b/mm/huge_memory.c
>>>> @@ -2513,12 +2513,12 @@ static void __split_huge_pmd_locked(struct v=
m_area_struct *vma, pmd_t *pmd,
>>>>    	 * for this pmd), then we flush the SMP TLB and finally we write=
 the
>>>>    	 * non-huge version of the pmd entry with pmd_populate.
>>>>    	 */
>>>> -	old_pmd =3D pmdp_invalidate(vma, haddr, pmd);
>>>>
>>>> -	pmd_migration =3D is_pmd_migration_entry(old_pmd);
>>>> +	pmd_migration =3D is_pmd_migration_entry(*pmd);
>>>>    	if (unlikely(pmd_migration)) {
>>>>    		swp_entry_t entry;
>>>>
>>>> +		old_pmd =3D *pmd;
>>>>    		entry =3D pmd_to_swp_entry(old_pmd);
>>>>    		page =3D pfn_swap_entry_to_page(entry);
>>>>    		write =3D is_writable_migration_entry(entry);
>>>> @@ -2529,6 +2529,7 @@ static void __split_huge_pmd_locked(struct vm_=
area_struct *vma, pmd_t *pmd,
>>>>    		soft_dirty =3D pmd_swp_soft_dirty(old_pmd);
>>>>    		uffd_wp =3D pmd_swp_uffd_wp(old_pmd);
>>>>    	} else {
>>>> +		old_pmd =3D pmdp_invalidate(vma, haddr, pmd);
>>>
>>> This looks good, except that now I am deeply confused about the pre-e=
xisting
>>> logic. I thought that migration entries were a subset of swap entries=
,
>>> but this code seems to be treating is_pmd_migration_entry() as a
>>> synonym for "is a swap entry". Can you shed any light on this for me?=

>>
>> It is likely because kernel only split present pmd and migration pmd, =
but I
>> could be wrong since the code is changed a lot since splitting migrati=
on
>> pmd was added. We either need to check all call sites or check pmd_pre=
sent()
>> instead of is_pmd_migration_entry() and handle all possible situations=
=2E
>>
>>>
>>>
>>>>    		page =3D pmd_page(old_pmd);
>>>>    		folio =3D page_folio(page);
>>>>    		if (pmd_dirty(old_pmd)) {
>>>> diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
>>>> index 4fcd959dcc4d..74e34ea90656 100644
>>>> --- a/mm/pgtable-generic.c
>>>> +++ b/mm/pgtable-generic.c
>>>> @@ -198,6 +198,7 @@ pgtable_t pgtable_trans_huge_withdraw(struct mm_=
struct *mm, pmd_t *pmdp)
>>>>    pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long a=
ddress,
>>>>    		     pmd_t *pmdp)
>>>>    {
>>>> +	VM_WARN_ON(!pmd_present(*pmdp));
>>>>    	pmd_t old =3D pmdp_establish(vma, address, pmdp, pmd_mkinvalid(*=
pmdp));
>>>>    	flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
>>>>    	return old;
>>>> @@ -208,6 +209,7 @@ pmd_t pmdp_invalidate(struct vm_area_struct *vma=
, unsigned long address,
>>>>    pmd_t pmdp_invalidate_ad(struct vm_area_struct *vma, unsigned lon=
g address,
>>>>    			 pmd_t *pmdp)
>>>>    {
>>>> +	VM_WARN_ON(!pmd_present(*pmdp));
>>>
>>> Should these be VM_WARN_ON_ONCE(), instead?
>>>
>>> Also, this seems like a good place to put a little comment in, to mar=
k the
>>> new design constraint. Something like "Only present entries are allow=
ed
>>> to be invalidated", perhaps.
>>>
>>>
>>>>    	return pmdp_invalidate(vma, address, pmdp);
>>>>    }
>>>>    #endif
>>>> --
>>>> 2.25.1
>>>>
>>>>
>>>
>>> thanks,
>>> -- =

>>> John Hubbard
>>> NVIDIA
>>
>>
>> --
>> Best Regards,
>> Yan, Zi


--
Best Regards,
Yan, Zi

--=_MailMate_79B30AAD-B22B-4282-834B-AF1CC99F1D50_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmYtY+0PHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUtuIP/A9Z7NbMBtVPupYaiNGKB6ATCsELu1w0+O9+
dsWhguVFfpNWC+qpucRtBoxBNfgvM1wPiPUJAxodQRKc+03VMoWMYTq3kneSnalu
nR9n1CMmeOIPOIQi35BelpQMceUcwY40t0aRzcJXFAffPeR6Hv2ASFHnikxHOF1P
QxJXMzGbRQAsguJqbKY6Kyi09Kzrar0gNfiMt3XXj7eYg+65rSIye1JSxY05cSKB
Mk538+AT9A8jmsDPyKWBVtZNLdIxgOhBiVSC3lUhlY8973rilEhX8c/smJP0nEV4
TeRskep8qiJV2JyXDinHI699asdH4NHZRuyzmkby6LdubmLmq3iUqCLz7VkTQYOx
yjkWwYidNBodLrzl77YTRrfN7GlrpRfC++PCetQKlt66Binz6TmNdnCGJKaX5ZZh
AwgttTlVvvfrkzg5clIhoqiegSc08MpxWjKv99TboQh+OFvooiIsZGLKZd9Ka9cI
CS02gpq/TOddBDS/pcoDeQpMUfiO3aOCGQkxQBcIweZyAOrjdAkeI03yNVbqniPF
YPiNKbjp6YRDq3pvICv7RqjT6tk0RXdF8LTSKkL8GpSxERFrNXpTaM3nJp9v8z+b
cNGwmPNu46P9bxsKWgBLWpdxLLSmxaufUy5ypXE9t9dZIZrPncuC8JoiH2aKu7Dt
8dP7QqVv
=XFqm
-----END PGP SIGNATURE-----

--=_MailMate_79B30AAD-B22B-4282-834B-AF1CC99F1D50_=--

