Return-Path: <linux-kernel+bounces-128808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6966895FD6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA2ED1C23677
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477F12E410;
	Tue,  2 Apr 2024 22:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QIHeKsrv"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2104.outbound.protection.outlook.com [40.107.93.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2E62260B
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 22:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712098408; cv=fail; b=ZNGFtwevKIZyaA4iiRW/rM0AwXeKaYp13mKgrlRpx5iYmmeIPePV9FjKkFqMz9e9SU+LjQ1gihQbL5Yu8vSr4SJsnqI8uymU/levpyIKIhxxh3CLA1IRWYmSOxBFW1porJ3inB4xD/swOrqFlUmwM2BgMF0EQVbqMvH4B08pgRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712098408; c=relaxed/simple;
	bh=BbYgnLKUVL++d4TFYHeSw1iShZEG/w0X+yoeSO/tjO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nht4+rpt6psQaDl5GerrorSu3Y/PSkpCoC67izViCrGP1SYLRd365Ql3cJpllYDhpI/jZV5BAis/60+z+Goh6G5Y3J1JNbME64bJDCXwrH2tHM5tOlU/8k5WpSvwGSAEhI8fGOp0iqMUI2TAhbBFCsKBpDOPucEEdAPvtd+UvCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QIHeKsrv; arc=fail smtp.client-ip=40.107.93.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j5whBe2TPQ5eXK65hZsgCjupJfreBbCduLlbaNWOz4qLJA1Lm5ARHUR+f80j2ozuiR7VPB+NHEGcfCrahsNxU4rpGy8FeNLrEIIS1jaZkLqVeC7Blu/2MqygMfk2GGjs1NoSVvshwItI9kXsHlMOJgWFF7704mk7vHYBJdHQP8Jths9L4wbV6hajnn1RPpUQWXT/fkNAjeybKV9eMxjo+Vll8EXYSgvAclzXQoYIjKj3CC4L8nQtuRjfRWjMGdVLNbdGdv7trv9hJ73JkwS5719yMHFb0EKhLnpHnqqARayrv2QhUAwl5oed9eYIT5hokBMQxRIVWU+GVI9axOWm5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BhJ1UQURdwDUzvXSG96GikuJ0SUIiMxdS6K1gLCHIQ0=;
 b=NY0DjMEqgNnnEBPQii5H8c2t4gPkaFQxJOrsqVXzBwrOYsvFSW78sDMkR7oIvg2E5PmIwUyhPDNNBQeDfoyndJG4l123ZYjXyqVVrF4yrE7TOtP4zXdNenU3ObhCBmSsmFvxyv5IcKV185pzs2Hx+aFcxwTRoMwMjRp1gV+vKVMDMSFfx69pqS9xIbvyGD1G9/zxa72bBxdnEsL8zfNvbaIVM1eKzov0hGP2wBq2UaadIrT6tlZOf9cnvrk0FKU1m3IRpNYjCTKa1oSrF+j3ZPPz8BQwbEHuiI73Yc/ocJUSujz30aubTVxDnaNvXNufdLBagrmKsMdvfn+y6VUMjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BhJ1UQURdwDUzvXSG96GikuJ0SUIiMxdS6K1gLCHIQ0=;
 b=QIHeKsrv9dQSlg4VYOTZBEc8XMbAJDA+sibJoDGSBm8ECNJ5skYQ9tKa9Ccmo33G2yIw6XUSAVFDB19NU1YqoxFZtJttnwtnzN8GnqirKY6BUBOaspL5fyZ0Q5Fk3LU0YppxjazsoQ/2uKwEftMnWYnDVAm2FLPsq6jbkFRkw4l2qQlOH6nmwUYeKOhJSdE1iusxOnl9L9dnYOOkRe2u7MmNjMlUy6Df3yEbnCCpaMikq96DXbF6Lc4pdf4bcTyoRDHckgf7W+VnEqT+dZTxXjEKqkpiSM8UNdM7pqd/p7Eb7Yq3D0uDvvdRN+z3d36BxNyMi0Ma95gdNCAc2V9HmA==
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by LV8PR12MB9262.namprd12.prod.outlook.com (2603:10b6:408:1e7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 22:53:22 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 22:53:22 +0000
Date: Tue, 2 Apr 2024 19:53:20 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Peter Xu <peterx@redhat.com>
Cc: Nathan Chancellor <nathan@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Yang Shi <shy828301@gmail.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Andrew Jones <andrew.jones@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Rik van Riel <riel@surriel.com>,
	linux-arm-kernel@lists.infradead.org,
	Andrea Arcangeli <aarcange@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	James Houghton <jthoughton@google.com>,
	Mike Rapoport <rppt@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev
Subject: Re: [PATCH v4 05/13] mm/arch: Provide pud_pfn() fallback
Message-ID: <20240402225320.GU946323@nvidia.com>
References: <20240327152332.950956-1-peterx@redhat.com>
 <20240327152332.950956-6-peterx@redhat.com>
 <20240402190549.GA706730@dev-arch.thelio-3990X>
 <ZgyKLLVZ4vN56uZE@x1n>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgyKLLVZ4vN56uZE@x1n>
X-ClientProxiedBy: SA0PR12CA0015.namprd12.prod.outlook.com
 (2603:10b6:806:6f::20) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|LV8PR12MB9262:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aAb6xuu5/XJAHyVBhXWlYPiGm0Ij7iFUtCdheAh55xZnEif6U9osw6r5qd8saHTa1z5j4eeJDy6G4+SBbKSC0FJbUyP+1enSkKXgTM8rdlqU1jgs3+E3+Kr1q1Oaf8HIJXoIadx3s+1IVRrRkuDCYz2Fc/0dOptrmHOLAbHwJbno/bBFpBOa8T++2PW0mff9p74UoYUZr9iQnFIChQEWEDbqsGZWudF7Sbb4aZQRjJqFBMEEmZvCPeuuWMfZcrXLAiugvnweT7SviprX/7dJjY4eEjCLQ2ibDx5aGMY9QgJf6gskWHKS8r10zh2U2f8oJgkzGGu1B2sgYXFTO5FAEAK5RXXQcXuCDRDFrswxQ4GhG9PB80iiIdC++DMfMHK8TXHp/t2IzSH0sAnxXDwrOs/NcIAyxhy1OksPA9lHIigJQVRqgY6njgnmhNg4ZGCW8ZSWU0w6IWBfsrGQ9dJGjqc6iHZFm2t/o1rhpymWFgFC6vx0necF5dXk6FAAHecKgRXEEbktMUOaIltDxelWmGzx4Y3BWCcQsnTOlqhIUebVEE1p1KaPfupWkrXL8K7iwePPRX4L2OGFr2IFJ9zTwedEEb19Zm6WTmr45qNKYlhS+3aS3AAj0578joMp7NUpD2feH8PAxb+0M0enNbaY+mcQkNhtVifJV0x3GtqlIOc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C+DuDQS5m0FwmZVT3XgazypinSRUXPD2n2z0WCs0Dzk7kGekw1vKengH/5gu?=
 =?us-ascii?Q?N3NhemlAVzWH5lnVd7qIapurAK4wFG4B1fcGhyKycUJKxC0W9Cosl0yXdEUU?=
 =?us-ascii?Q?UkmyqOJ7j4u2RcWaYIAkYyLL9A3keTWNOCTVa7Bi9DDuH7vKnLJeyG9tqhQE?=
 =?us-ascii?Q?qlkcT0GnWRV66f+OfKP7rISSP77j6jhb6X7PilGCdErF3fTgYQuMOQfY724R?=
 =?us-ascii?Q?Ji8FG3VAjV2Uw2odkhoVSKR/jGaDFqjZVn/vRSymCzMHZs28bFIQr0TDGJFg?=
 =?us-ascii?Q?OWPnqEYbz7WxCtNQjEjKrUtbxRSsIFzHufyqJQ6YTkBAhjBD9Ef7hI6Rxt80?=
 =?us-ascii?Q?XpM9XAml8m1L6neKtaYC9D9Ym2YuYqgkdcYwLC+krGncN/1HjTRnaKX0QTUI?=
 =?us-ascii?Q?L5HrE6OwM1SGujcNueObqp6YLsDIbp9U839X8SvsOk/VI8d/CFC77HW3mNl+?=
 =?us-ascii?Q?8S3+oypDT+GEWcH+dV/A01Y9xvBWzzKNO1aDF8dRqR7M3Lj2wjqP8zZqt6N5?=
 =?us-ascii?Q?IQ1cdqZAFkT2ZG6H1ejUK5soZCGoGiBMgU4T+/Bp4wpSptIkW1T4IvIR0kl0?=
 =?us-ascii?Q?2/gZMt1pK0NaMwahilBD68c5OxJ6HEQ9yQNAnjpsPkHNA932PX0dDMHkk4cd?=
 =?us-ascii?Q?4L2ft6iBFZdj7tsB5dWKdxMuNQsAk+cpumIXoodBzgyiYNhkFpEJkXBqBRJ9?=
 =?us-ascii?Q?nCA69Q2Jh5W+IfY43r6kc3Gtfk6bGQwOUqpYFWJaWl0qI+bmV+HscFFyDdFK?=
 =?us-ascii?Q?Ik0KP/oS+gp3UOwJ6fZGUOH0XfL0EX2GPAuhH4bccRG8V04Gf3Ub8+sKzBl9?=
 =?us-ascii?Q?HqQ7bY+OG27YOhr1QL1uc6Jb3YVrvU7quk/Ezy5qV2isAjDP3spAcdqW50UB?=
 =?us-ascii?Q?2XE9Wy2EO98RAArmbe73AoSLyqWPX8IVqMjyvA3vAOV9IClfM/f1P5rY86DZ?=
 =?us-ascii?Q?OirmvlLt/cnb6ZhtDSiC7votu01aq73Cxmx9hXojUzh3xcfHC6BX0SL8xGte?=
 =?us-ascii?Q?WEDq1da1/dLosHYr9SE0ZVEXRdCCwH8H6fVm9Dx3Sz8RhN+6WOKS2nnbKNPZ?=
 =?us-ascii?Q?B7VHafBOt7rZ1ZdBOkihFg/dUgE/JakzeFH3WSHgRq0qOuixt/ZqbJDC9EeP?=
 =?us-ascii?Q?RSnE9w3w1ArGAW1QdMn9mf3NvpiMJLYw9C2XbmmZI5mw5ZS5y2ME9IRk1nDj?=
 =?us-ascii?Q?WihLuCIm9Ro9MR10qsgojN2/XP8oABd22kpeHkGwT0JmLCsBhhDdDi5ZPhbU?=
 =?us-ascii?Q?zXwvfkqop5dIqGIxvDNc70B+aiUQkIml5mYBNqBEzwQcairyrvVJr71MHZCy?=
 =?us-ascii?Q?ZDVGIjHpf6NeM/OHYAnWDeOwBj3BjNld+VcmexNkYDkWhxrJYI82EsDeZ8Wc?=
 =?us-ascii?Q?cH8gZSh7tm/toaFI4JiqN52PDCyYaJfi5Spd3BNueDc7pH82xH4HBckOgCeA?=
 =?us-ascii?Q?MUT7enF8IqTek9TWtKb8Uwma5ZEgKM0acUcbXD3HI7N4vla+r3T8vmKRU381?=
 =?us-ascii?Q?eDwAv9MMYzuuU5hsvT+shLXIrXKTP6jojR2BT6uAX/MUCaKtCNW58xd9FwOD?=
 =?us-ascii?Q?VH7yZfQX6ABB+053NKSPO2ioBTE370pze8xiVzCw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d611d46-9fb3-4e5d-6979-08dc5367b2a2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 22:53:22.4580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oa2HsOvvP6XJ1dsEuaN3GXjvhCh14tspZkBbQzjRMrzHJ0pnk2KzDpv4P9BaFwFM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9262

On Tue, Apr 02, 2024 at 06:43:56PM -0400, Peter Xu wrote:

> I actually tested this without hitting the issue (even though I didn't
> mention it in the cover letter..).  I re-kicked the build test, it turns
> out my "make alldefconfig" on loongarch will generate a config with both
> HUGETLB=n && THP=n, while arch/loongarch/configs/loongson3_defconfig has
> THP=y (which I assume was the one above build used).  I didn't further
> check how "make alldefconfig" generated the config; a bit surprising that
> it didn't fetch from there.

I suspect it is weird compiler variations.. Maybe something is not
being inlined.

> (and it also surprises me that this BUILD_BUG can trigger.. I used to try
>  triggering it elsewhere but failed..)

As the pud_leaf() == FALSE should result in the BUILD_BUG never being
called and the optimizer removing it.

Perhaps the issue is that the pud_leaf() is too far from the pud_pfn?

Jason

