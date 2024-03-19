Return-Path: <linux-kernel+bounces-108234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E7D880829
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 00:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DBF328441E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 23:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387345FB8B;
	Tue, 19 Mar 2024 23:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iitv6AXA"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A49E364D4;
	Tue, 19 Mar 2024 23:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710890823; cv=fail; b=cvQe4umufNUDI6zLvr5T8h/SW87EV0w1bQveIeBb5+dyfqchFmTfCSA69Z8PxUwIYSpV0SRbiSWIDJ7rOYj5pTvGgDuAm+JhZYe6lERQxL2ssO9FZADuRugurQUfQGrr+bXKhL1SZ3CwyDn2ZlAqe42tLqqN1474qGNvdtluo5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710890823; c=relaxed/simple;
	bh=RvQ/WThk7cCAjoN65viNDv9ItDnwQrhCim8DHsy8gXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oaXRYn4RGQloJx93F5Xs9MH+qglNqi0i46oPnS+rSGILyVnNRRfhc0TqjQzWhme8Id0QgeP+6Ux/F+6PCl9j1YN5DCSO8J6dfTrK+0bkgbjgJ1Z77NxYKoWlO/+xVCdiIgJmf/2mq3jFsiSTacUlKbNbJkboWD3g4k1gNvFZwOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iitv6AXA; arc=fail smtp.client-ip=40.107.243.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PIjdKyMOu1z3tNGqXyOxJaKs8fisBc970k+FuuwfOc8PlTjylUDiOpZ2LmxFw/h+35vGwdjN7364QM9xCAptT/njCctwf9YD6E7u+D7S8PS7vjrKUBaNVaKTTaITY3OI/iF02+f8OJ+KTZdm5o8KrH4NPutiE7ZG+6ezs8WSTfpALqXEybNaQ/9IO4ojuY6dRYMez99LswRe/rnh+jwtZPrl0qK/fxrWSkVlwsf5F5JD/NQGshPzCETCEszf56AdmQyxdLBcG06DIAiv0zWPRHqR900oNhbFj5UeRcgjE3V0jFM0OcaQqmZJ05dzoTjMvpft9Aw8h0KyffNl9dtx8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kTBjnh4ouq7OW3t/XSXak8zzpI/M48KXChPCsfV+KII=;
 b=k8OshPRQCr3PWXIeSPzdZKcCQIHDPvALOTZtw+M5HeOwsIJFJ2EFYSEV+mkQEPHhzbB2saIdH8WE57jvb+niruMFItqi2CDv/7uMa1A7nlwQ6w5skr7mMuqexMT6FagBHvvlRSBJvaa7NzFh5PQc43QWJtx0ecJkSKotx8x3vGlTfDqUlX11Erc0HUpQXtESvdIq/VPOAtuR2aMufugACGhLPGOEIeWh4wmWBbtl/Eh5Bpg6jaxOkyi0h14vUvPw+U2v6vxKpJfZAVa6ysfrcxlXt+vmyyEr8TQ7U4jmDeR7JvrU4md7v5ZnLL5B1gzO3yOnSUIDkrwXGW1X5XlQow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kTBjnh4ouq7OW3t/XSXak8zzpI/M48KXChPCsfV+KII=;
 b=iitv6AXA8afrm0lGV/NGosYbAqtC/Hp/96JzZmQnyey6gco2sOsxuCmWKwhxNRan5J2UXfhGE7Rmnqeaxj487jQ21rrhm3/eaN8Fn7VzIGlouqF6WB0ppvj0tGuxAITOimfFAkLCBebgTVhal7O4OwsJ4kJ78EwRHsqpxU7HQ6g6hBxBfFf7JIu8GIGxJ+bBtklL3hoYTZ/43j4EBvoKNR4XAWykKuEmpCEFiS858dXHWJgWTaQF/G9isIkM1rYRYWl5JOmw3rERCChgjrjhS/ceTUglOEAymNDyovHmkU7s1dZBfNZa5ewupCv0VI1hq6U8iV3g6z0iEwQSBTSLZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by MW3PR12MB4441.namprd12.prod.outlook.com (2603:10b6:303:59::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Tue, 19 Mar
 2024 23:26:58 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 23:26:57 +0000
Date: Tue, 19 Mar 2024 20:26:56 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Peter Xu <peterx@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"x86@kernel.org" <x86@kernel.org>, Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	"sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Subject: Re: [PATCH 09/13] mm/powerpc: Redefine pXd_huge() with pXd_leaf()
Message-ID: <20240319232656.GC159172@nvidia.com>
References: <20240313214719.253873-1-peterx@redhat.com>
 <20240313214719.253873-10-peterx@redhat.com>
 <7b7d6ce1-4a3f-4392-951d-a9bd146c954c@csgroup.eu>
 <ZfLzZekFBp3J6JUy@x1n>
 <1f6ad500-3ff7-44d4-8223-067bd2ed9ffe@csgroup.eu>
 <20240318161519.GA5825@nvidia.com>
 <e0417c2a-2ef1-4435-b5a7-aadfe90ff8f1@csgroup.eu>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e0417c2a-2ef1-4435-b5a7-aadfe90ff8f1@csgroup.eu>
X-ClientProxiedBy: DS7PR03CA0207.namprd03.prod.outlook.com
 (2603:10b6:5:3b6::32) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|MW3PR12MB4441:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d781e57-9494-4738-6727-08dc486c1222
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5JEuA4PkqkQAtolcVQFsfDFLwHNNDT9Qg5xxD7WXOntanr/Kf47e+hqm4RDKWOykygxe/NspKnkOcSLgyqVbrZaxW2pKH/KqgTG3gBO7EW27XT3UGi3VjPya2pjzJEKMJMHoH0wjdyst2fLOpvDxZ5n35XXv736jX/PYAxw1S9qAGQZfsWrBIUFfxQZUU0gwGwra3KNLO3UkWm6f+xP19rewfpIzxCPWfNcOXKDck9MjBoXLeh2N5oNLXe9K8bnYcRAhfpkn0aXNc6h2H7hQBapD84t6v4+Cd2McktvdyfLtICJmWr0VeO3SKI2XTZVE7ZWosXrrUJBfyrNZjPvxVXmh8DTkVFzPIZHI4aYareSGS9NRGEpMmnw+OOINgr7K5IH+bKdymhT+2kxCAg8Khk11NSNnGMmDVAXfWCd1svRcbFolqVR+EIsFoJ2V+Z6cYAWEyRvXMxX/RAAvhBxrazHj5fgnRiV1Vv9K3kRlfQ2nszsuJH9DZsDF4y43OO7pgnL6Y35YOB5jvJeuEXPnkzbD4NOnH/lpuA2BKyUogtUb6mp87dMvrR+ns+UC0tk/iG0GCmxy4GhcH+kGhIjHGmrL6bQwGZZEdzBMVrTj3WBMMN1GWisF4IEold3v/MjcSROUM6/trPfJvrbZMUI+p9/DJjeF6W70oKEXzcQ/pAY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cllnU1lka25iTWtCZ1A0Y21OOFRwQnE3d2lTQ0VkMFF4TXA2VHhLR3ZoWFlB?=
 =?utf-8?B?TmNZM1Y1T01INGlQN0t1a1FSdUoybUQ4TTB2ZTJuTEJWT1M0WmJxbldCTjUz?=
 =?utf-8?B?aXVDYlBKcDdCTXN1S0dKSUx1MmQ2WjFuWFFIUy9FbUs5aWhUM0JOTFJXUjNF?=
 =?utf-8?B?KzBTWkZsOGs4ZGxPQ1dRdFpLMmszRDIwNGFLQ20zNTcvMmEwNC9MbEp5UnU3?=
 =?utf-8?B?WnJRV1lJWXRFTHhRSkpYSHYrL1hqWlNreEdpUlBlK3ZiY3YzNGhPRmxzSjJi?=
 =?utf-8?B?VWpuYlZ4emJuQTNzSmszUTNnWUlubmJFWkNLQURzdFZ2V09neXVSVVB1MVRQ?=
 =?utf-8?B?RWowQS8wTzZxc2xyd1llUDByRkNMZVZPUzd3b1V1bkZpeHRmcWl6d2d5WS9a?=
 =?utf-8?B?aVFaREhiQ3lEUXdNNWQxcEtFYVdlY3o5UUoxSy8wdXliMEY0K2VHY0YzSTZn?=
 =?utf-8?B?V0padmk5ZjNvT25FRElJeTlYR3V4amdCL0dnVXdxRGFycHBMeGRDZmNXeXMr?=
 =?utf-8?B?QXl1a1ZVeVVFVGpIcUxvaUw4TnBPRm1jWmQ1TGc2dlhyVVc4Z1Z6bHVyTUZR?=
 =?utf-8?B?M05Wc1pFcm1LaGRjNElZSStTdEdOMHBRQlVjampFNjROenNibnVweE1kRmlX?=
 =?utf-8?B?ZG9VYnYrSEVjc0FsOVRweHc1Y1RZaXJKNVl1d0tIRm9XaEliemtORTVJNk1u?=
 =?utf-8?B?VkU0YUJyajhQQSt1ZTEyRm9HdjIrSldRSHZtNUxtMmt3MXZoeTd2WnRrTURv?=
 =?utf-8?B?U1RGZURDTnFucWZHSHd0WnR1TUxyeEVJRXYrSWt2K0h2SlAxNjRlZ2hIbitD?=
 =?utf-8?B?UGIyL2EwOU1FcTRIRUNOV3Z0UExleW95MTlkcC9CSlZZcGhSeVdMY2ZZOWVn?=
 =?utf-8?B?bEl2WkVtazdhcDZxejkveW9ROXArbERtOWNNQ0ZERmt3bUN6VWJNaUNqZnlO?=
 =?utf-8?B?MFhvZzhrcElQaXozcXl3OFRkK2ZORFA2L1FRWmk4UGsrdjIwc1o0bzNqNzQz?=
 =?utf-8?B?dGFWUGI0dXIreUc5N0FaYTJ5ZWRNWXFuQjhScXZyb1hkSnpRMnp5dE10L1Zt?=
 =?utf-8?B?NlhMbnRKcFJWNzBibW4vTHdCNWx4M3BCSy9ranJLSU1aRHhCMG13UnhiSmhS?=
 =?utf-8?B?bytFTTRURjJuRzl4c0lrQ2lmOGRHUnNrYlhreHovYXhUWmpZOVd0VG9JMDRC?=
 =?utf-8?B?enZVamNBOUkrRjZWTDI4Q2pCSlovRmhJL0E1ZW5KL0lSd24wR0dsT3pHemE5?=
 =?utf-8?B?QThCMWprbnBxaUQ0UVRubkoveTYvOVV2ZmI1MHpjVUFYems2RWVRb1ZBNk9t?=
 =?utf-8?B?ODBCcEppY3RrTzJwek9ibTg3R29ZTkVnanJuOVVMdUxQZjVINzcyaWV2bEVa?=
 =?utf-8?B?c3QvdmMraVdFTkc1K1I5bS9zTWlSVnRSc29iZFN4WjVxUDhzanBNQjVvbE1i?=
 =?utf-8?B?RUxCVnRUcHB0NTdZWEs4RC9jbU1jU0V5MzR6dE41TTE3aDE1RGZiUDFSeGx2?=
 =?utf-8?B?Y3lBMnhqRlAwbmZJdnRjRU92QUtNdTM2d3E5TE9qR3pWZGhXc3J3QWx6d0gz?=
 =?utf-8?B?TlhHMnYwTnBDajB1bzB2MkRRY25MTENpRWNPSzdZZDhWTis4djZDckE2QTNm?=
 =?utf-8?B?ZDI0NmFSMHJQZ2dINlVFdGlSUnROZWt0aHI5ajNJL1pjYkZOWDMvNFl6OTZ2?=
 =?utf-8?B?eS8wRkdEODdDT2RoQTRtYkxXcWMrTCtVaEg0cytzalRkbVkvZVk2ajRHOUN6?=
 =?utf-8?B?eExtQjVtWXlmQ05mb013a2xXRXhoUDZ6Q3k2QTVKWHlPOEQxNWQxNlFaelBO?=
 =?utf-8?B?MlZGYnhWbnc1RGpGNkEyUVphWVA0alRIWWNEVVNaVzNtMnBxQ0lSNXltNUdx?=
 =?utf-8?B?NEs0WExTWFRaWHRKTmVaSmtabXRQdkVWRVUrR3lhQ3ZjVnFkanZLY1pSNEZx?=
 =?utf-8?B?eWpsSXJUMGQxbWVxRHRDZUJ6TG1EQXRDYy9VN1NpZTF6SEJRSk9pSC93aERn?=
 =?utf-8?B?b21nUjh0ZVNIcm5rMzE2RjltQ3E4TS9KdmJuc1FVcno0YjhQK0cwZEk5L1JG?=
 =?utf-8?B?QUhoVkJUWFhtNmhPcmkvVk1Oc1cyZ3dUb2NpRzM3dEhzZzN3bFlRR3VhamxL?=
 =?utf-8?Q?3ECo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d781e57-9494-4738-6727-08dc486c1222
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 23:26:57.8884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +n/EnfnIvLi58xdu3h7/LAYm87u0S5VBKdx5O2f7tAqXwl1ydMNwBBlQg/2y5EuZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4441

On Tue, Mar 19, 2024 at 11:07:08PM +0000, Christophe Leroy wrote:
> 
> 
> Le 18/03/2024 à 17:15, Jason Gunthorpe a écrit :
> > On Thu, Mar 14, 2024 at 01:11:59PM +0000, Christophe Leroy wrote:
> >>
> >>
> >> Le 14/03/2024 à 13:53, Peter Xu a écrit :
> >>> On Thu, Mar 14, 2024 at 08:45:34AM +0000, Christophe Leroy wrote:
> >>>>
> >>>>
> >>>> Le 13/03/2024 à 22:47, peterx@redhat.com a écrit :
> >>>>> From: Peter Xu <peterx@redhat.com>
> >>>>>
> >>>>> PowerPC book3s 4K mostly has the same definition on both, except pXd_huge()
> >>>>> constantly returns 0 for hash MMUs.  As Michael Ellerman pointed out [1],
> >>>>> it is safe to check _PAGE_PTE on hash MMUs, as the bit will never be set so
> >>>>> it will keep returning false.
> >>>>>
> >>>>> As a reference, __p[mu]d_mkhuge() will trigger a BUG_ON trying to create
> >>>>> such huge mappings for 4K hash MMUs.  Meanwhile, the major powerpc hugetlb
> >>>>> pgtable walker __find_linux_pte() already used pXd_leaf() to check hugetlb
> >>>>> mappings.
> >>>>>
> >>>>> The goal should be that we will have one API pXd_leaf() to detect all kinds
> >>>>> of huge mappings.  AFAICT we need to use the pXd_leaf() impl (rather than
> >>>>> pXd_huge() ones) to make sure ie. THPs on hash MMU will also return true.
> >>>>
> >>>> All kinds of huge mappings ?
> >>>>
> >>>> pXd_leaf() will detect only leaf mappings (like pXd_huge() ). There are
> >>>> also huge mappings through hugepd. On powerpc 8xx we have 8M huge pages
> >>>> and 512k huge pages. A PGD entry covers 4M so pgd_leaf() won't report
> >>>> those huge pages.
> >>>
> >>> Ah yes, I should always mention this is in the context of leaf huge pages
> >>> only.  Are the examples you provided all fall into hugepd category?  If so
> >>> I can reword the commit message, as:
> >>
> >> On powerpc 8xx, only the 8M huge pages fall into the hugepd case.
> >>
> >> The 512k hugepages are at PTE level, they are handled more or less like
> >> CONT_PTE on ARM. see function set_huge_pte_at() for more context.
> >>
> >> You can also look at pte_leaf_size() and pgd_leaf_size().
> > 
> > IMHO leaf should return false if the thing is pointing to a next level
> > page table, even if that next level is fully populated with contiguous
> > pages.
> > 
> > This seems more aligned with the contig page direction that hugepd
> > should be moved over to..
> 
> Should hugepd be moved to the contig page direction, really ?

Sure? Is there any downside for the reading side to do so?

> Would it be acceptable that a 8M hugepage requires 2048 contig entries
> in 2 page tables, when the hugepd allows a single entry ? 

? I thought we agreed the only difference would be that something new
is needed to merge the two identical sibling page tables into one, ie
you pay 2x the page table memory if that isn't fixed. That is write
side only change and I imagine it could be done with a single PPC
special API.

Honestly not totally sure that is a big deal, it is already really
memory inefficient compared to every other arch's huge page by needing
the child page table in the first place.

> Would it be acceptable performancewise ?

Isn't this particular PPC sub platform ancient? Are there current real
users that are going to have hugetlbfs special code and care about
this performance detail on a 6.20 era kernel?

In today's world wouldn't it be performance better if these platforms
could support THP by aligning to the contig API instead of being
special?

Am I wrong to question why we are polluting the core code for this
special optimization?

Jason

