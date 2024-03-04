Return-Path: <linux-kernel+bounces-90593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E95EC8701DF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F60AB24A6F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096A63D3B4;
	Mon,  4 Mar 2024 12:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KgydFu61"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2076.outbound.protection.outlook.com [40.107.96.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3281D53F
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 12:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709557073; cv=fail; b=InOPsqGaQL+pok3BTQEnDxqJPfMKxDG1SbINV2iykym6FNxVsrYiDPwFHDY6g04Iq1XknGT/bBG3tuOp01lDXbHdCoyjI2AT3WH4YZstxoCrQkzKP4PrZwGpN+KK9aE56FFYMEn77h+xkbOgkEhWbGF/qkinYNRj72Gc9w4Deyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709557073; c=relaxed/simple;
	bh=9tqhSiPLysJr0/8Sw14AbD3qutMd1d/ZUXQUtxrjBTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rbT8s+X/1yyDhQu2Nx9VNnoyeAXWTYtQ4GTpKP5J05idnD88FFvYtl8jLw5C4kRHNu1tSKWt8FOFVIV3Hzqv8y6J9YQCfRvxLhCVTA82OdOcwNno6iBBZFHPiqdCxu6CKhvSZSWhtBnRxi9EuekoBQvdzJ6opSoRsHUPSGC7FU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KgydFu61; arc=fail smtp.client-ip=40.107.96.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nqu/qAkEfJVfYSSTRmkElWojiVi6N39MjYcPVhnsgRHWugvwzxyYlCn+XAQvfSmX8c9C77NRXCOwfoYEBeJWf1sa2u9M32X/CLAc/GVJ3ng0tmFfLebH6Zq7U9F+2NMmiFwKj/l359fbNdPOi+BffEnbVmzbz6Vq4HqL6TQFC9A+R2v/FQG0NRqLkmaKa1wIJSAAyrdqp8S2kzZ3CQa/VQkhaRLRhngiS4cq/BKPzIURi4rTFCuJnr2MRhA0kw7f7Nuz2WWdNW7NEgGcvHWz+kqybzZZwXX1AQimwHTgSd9q8IJMJcnh7Zi6C+Nuhc230udTzBnlETkyJB/BAU/UJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qHpNzowK/7kgPIApFTyGCqhesgtmFXk20KhgDsV9T/I=;
 b=l5zkkiukTY0TXjnZf0xWyQUoL+bK8V6NZq16+iDTkYu8PxTKEeHQmix+DNqA8USPO2gZv8HLbikyfKBPOAoQBo0JCxjsGqa8zAz321CPOfsnq0KQUxUA/jbYsj1lfHchyncB2naQmKzGgBUmd/DjY6aIOwq67K8I4lePhb7ONResBXVCG2hHAiw+CIzWNeJrljVM+euQ7RYisH5QZiDZSZatukG148jPlyNsLAOlbkKwf0JvL34i2sA1tvIP+Iiriu+GAxbs2oNI0rSQwyJCf9d96aPJJsxSKGhqyB9b+T0yIlymXWvZImUFPkoelpcsMBI8WOVisrYT7EEwKSCkWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qHpNzowK/7kgPIApFTyGCqhesgtmFXk20KhgDsV9T/I=;
 b=KgydFu6132nXNfNVC8FEBBNwsA0f0Q6D/MgQa5aUkmmzeoLXU+GpuBa50LssIdjlkOxUGT8FtKzsU4M10I/rMvjwvMI0Cxu+VtrwKhB7a8PsLwdG6wfc/6Mc+JhKJaxWKSq9tghxm6W5cCkrfN4s+qBMUOic4+t9cKtRe8YNPPFNf4JetsGNyoXdsXlPzqj7maa5QTYHMaGm2aBMVvFzxpndmDBRcn3h8FmARNkpjvZqiX9hWN9LP27FRL3PthKk6lDTm/4oImVxH59Rhr3sG29rQWYHX091sMQck0fTH5ZyBKtRZ+ST+77IG5hYZ34MJvT2qUG3regwPehnjceeSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by SN7PR12MB8102.namprd12.prod.outlook.com (2603:10b6:806:359::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 12:57:49 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c33c:18db:c570:33b3]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c33c:18db:c570:33b3%5]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 12:57:49 +0000
Date: Mon, 4 Mar 2024 08:57:47 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: peterx@redhat.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, Yang Shi <shy828301@gmail.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2 2/7] mm/ppc: Replace pXd_is_leaf() with pXd_leaf()
Message-ID: <20240304125747.GP9179@nvidia.com>
References: <20240229084258.599774-1-peterx@redhat.com>
 <20240229084258.599774-3-peterx@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229084258.599774-3-peterx@redhat.com>
X-ClientProxiedBy: SN7PR04CA0103.namprd04.prod.outlook.com
 (2603:10b6:806:122::18) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|SN7PR12MB8102:EE_
X-MS-Office365-Filtering-Correlation-Id: 243c78cc-2ff1-4f82-c8a0-08dc3c4ab1f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TRylF9uEhUWrbSkYUugk8/X7c+WC5FlxRAP7rY8YI1CuUYf4JqqJyucoQZ62OiO4/+aRjBSXLAzZpM0E5mZTNEu1Gy8y64SdEspU0e952tnOv5YaL9IYGhlAqPgun4l36h5VkcvdlriZlnsSJOE3dmeiqA/M65AEmuIHWc4IpzrPJNJlLr17hJXWShKFpaJDh1rqeEhS3pHM67xmzi3FX1kPpCl7YVaqVtCjQUm5LLq/1Ov2fq+0aZ8nj4ljOU2U89bbI7Udd9mph4XMkJCfcvK2I69svxIyKNeZiwi/kHtljhC8/ohiGOhQyHYBrYfFHIom2qdqAy3p96Gw3YQgm2BJlpI8pQDzJmyQ29U4diNFv4ZVx668/fp9drT84VWlcaqRwn7M4/oPkvabSSp3Ll9uD242kA38Cculp42SO/11kCiOZVm+qTMmAWFFD80llosN7Q9qFikVLxiQIswbVedHGo/aJF4IGfTsMLwoWPSvOGJ+0xo/A74w63dtLpiWe+J4/Bj9FXeiIwuCFunomBSAnQOiIcOALip4vqfZU1FQjoFGCJqqU5Ie0oUPEmyvPvem0iNKdiF/ZOEcRvcYgHnZ0FXr6/KBfkNvDvzl8nhxm+qV998qR+wbPlQ8+9Of9Og3ebqUIvQ79M7aVh1x6mLdlKlmgp7MfSjlXTl6Gxw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c9CoqiLC5t+9SYdqNC7Vp8icceCaoaaFlKPtWih6QnSReW2U8sIzSYCiR1xO?=
 =?us-ascii?Q?HIU2YxF2c/onTmRPEYAf1ogzX2nHxPP0ogWBOsbiwcXof6d95j5PylctdJ9P?=
 =?us-ascii?Q?nJmeTIYn7+o4f6k9mqk+yjMJUGCdZJZ5B1iiHC0xD8qRm0VsFcfxzRmUzLKK?=
 =?us-ascii?Q?mtLqKE35GIAsceMOnYxSJj+l0nlpQNV69mBkETpU/KU52RkMiV+LlUU7FKR6?=
 =?us-ascii?Q?49x3If4BYCifbU0V9sS2gmriy850rn+4J/CpvnX2tkoBQC9A9Wf3YmTZPPq7?=
 =?us-ascii?Q?BmvJpAQLGZ664bIUJZioGKktweUuEc5U76Gc5tAbVtnvjbK8KJn5UojqKG6L?=
 =?us-ascii?Q?emhqXS/FCa8arzrQdYq/HLB9X6MatcofLH9ItgmzzbpPoBb2wpVhvrpHctIs?=
 =?us-ascii?Q?iZlhG87r6R4zzZBQTk/82YY9JAN1EPjifIjaIAO8PknVbuLkFgZZInyK6AfU?=
 =?us-ascii?Q?+3d7RM8Xq2qNtRxLug1HNl7UUo9fXu5Va4QPXPccvueUtn3fHgSmxLKTYCua?=
 =?us-ascii?Q?zkNpObyoHJHcQg1X3m7ThQDS5TsiBZvU3ng32MFtc4QL3H05cMXdHm56C7mH?=
 =?us-ascii?Q?UCgQYfjGHXu7kiLB/hMv/iJFfDE6qBTxhupnyHIiui0+15hWXumqzevZ8p2z?=
 =?us-ascii?Q?gxcc9Y2+ZWrCtljK4WTuGPhw5cuDq8d/XMRosu6G+HyqEKb4enj3053FX/AS?=
 =?us-ascii?Q?ihfaST5VvP4VXelU2qQ3jgVOugEyiKjNBNYR4ZPUVCRnAFYD2VWk2sNcc2LI?=
 =?us-ascii?Q?1oe5M9wzDstfqo/1aM+HsOtV9QV2vLW0dAhWBFpfAj9fHTASSklcHkmM+Smx?=
 =?us-ascii?Q?e19JzU5nNPi5TRdsyQih2364d/R8NvgzU9c/wZ6L3AyCMCqzyday8lhGxgGm?=
 =?us-ascii?Q?7coiL7jeWsLehIRb95QTtwJsBjjZ4z0M0EFlBFSX4yQdOyS6xAh6ONN3BqAr?=
 =?us-ascii?Q?6QG3FOICj62kZ6thGtC6p962qPRXyWDuhdTcgUTxh+fuvZJS2ee2yMW7bYYU?=
 =?us-ascii?Q?h760dcBgsMODU9FtktISAnVDb0R/M3DYS2xzH218y7zIoF9Wh7QjwaRAtM5T?=
 =?us-ascii?Q?wu8h+uuneu37IdkW2/EOpZwFHHZedqmNR/yMl2uDrFb8tXF8wOXkDfLHgND1?=
 =?us-ascii?Q?axY8pYiCKK/GSmTUBqMaKh7PofxxACKUfYohst6T6PW9AvyZiJFtSiMHwNdu?=
 =?us-ascii?Q?65oNSIZ7uE6WaajfVOjvsufBg0qW7X7UeZpySwzS+avBwgzI8VFgQ8wynKCa?=
 =?us-ascii?Q?1GcJr47P8E8loBI4BvECKzLGdsOUw8s6HFpkDR1BmfUV8XMYW07TtT7eVhZi?=
 =?us-ascii?Q?b6LVzSdM7oJjN0PPQM+daCniFvOIFu+udwt1I0Mp+TASGeb3EQkiJ5JbzgXq?=
 =?us-ascii?Q?4UAxupOXsuyzqwSFTjjfbtwViCIthHWCd7IlWLWayN27krcuEZ2Tscb4NFhZ?=
 =?us-ascii?Q?KOnRRZjcwI+4rPr2Yrwk5I3KTSGEAUN+oLI5Gt7Q7M3qvOFm5S7Uaw7lCF1g?=
 =?us-ascii?Q?Y9MZsqoG2vioTFYMWVzIU9NOgI1XeFLuFbSXJK5poRVLo5gdxde+9wH5CXZh?=
 =?us-ascii?Q?JR/p3qyY5EGL1zYjqgs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 243c78cc-2ff1-4f82-c8a0-08dc3c4ab1f7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 12:57:49.1803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4wR2u/wST/p+GUEk5mAWELIiPbUorKDoavVbtlCgAv9XqWRTl6eHdQuWopgiYsjW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8102

On Thu, Feb 29, 2024 at 04:42:53PM +0800, peterx@redhat.com wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> They're the same macros underneath.  Drop pXd_is_leaf(), instead always use
> pXd_leaf().
> 
> At the meantime, instead of renames, drop the pXd_is_leaf() fallback
> definitions directly in arch/powerpc/include/asm/pgtable.h. because similar
> fallback macros for pXd_leaf() are already defined in
> include/linux/pgtable.h.
> 
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
> Cc: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  arch/powerpc/include/asm/book3s/64/pgtable.h | 10 ++++----
>  arch/powerpc/include/asm/pgtable.h           | 24 --------------------
>  arch/powerpc/kvm/book3s_64_mmu_radix.c       | 12 +++++-----
>  arch/powerpc/mm/book3s64/radix_pgtable.c     | 14 ++++++------
>  arch/powerpc/mm/pgtable.c                    |  6 ++---
>  arch/powerpc/mm/pgtable_64.c                 |  6 ++---
>  arch/powerpc/xmon/xmon.c                     |  6 ++---
>  7 files changed, 26 insertions(+), 52 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

