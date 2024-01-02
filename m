Return-Path: <linux-kernel+bounces-14083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 782708217B3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 07:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 255462824C3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 06:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F9746B7;
	Tue,  2 Jan 2024 06:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o38+Omru"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F126468C
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 06:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704177059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xwM83SlsLb1lbvo4JCqZZv0h8wT6KPgcWS/HAwN04/0=;
	b=o38+Omrur7cm8Q/e0nLnXqBIsWvLMDkbm5ptAnn/ZlZWQiCVmcDjZtwoEs60A94RgcAauv
	E132opwWBTvCsPeDzfzlh9A4yzPTIVTPtHNC/5L0+b6GA84IBDoYN0L7I27E5LuYL9UL8A
	OyzbfsSDRORVadxA5D4C39d8zPUzD98=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH 03/13] mm: Provide generic pmd_thp_or_huge()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <ZZOhCuuozrBscdRC@x1n>
Date: Tue, 2 Jan 2024 14:30:25 +0800
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux-MM <linux-mm@kvack.org>,
 Matthew Wilcox <willy@infradead.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Lorenzo Stoakes <lstoakes@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Vlastimil Babka <vbabka@suse.cz>,
 Mike Kravetz <mike.kravetz@oracle.com>,
 Mike Rapoport <rppt@kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 John Hubbard <jhubbard@nvidia.com>,
 Andrew Jones <andrew.jones@linux.dev>,
 linux-arm-kernel@lists.infradead.org,
 Michael Ellerman <mpe@ellerman.id.au>,
 "Kirill A . Shutemov" <kirill@shutemov.name>,
 linuxppc-dev@lists.ozlabs.org,
 Rik van Riel <riel@surriel.com>,
 linux-riscv@lists.infradead.org,
 Yang Shi <shy828301@gmail.com>,
 James Houghton <jthoughton@google.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jason Gunthorpe <jgg@nvidia.com>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Axel Rasmussen <axelrasmussen@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4B38660D-3AC2-4F96-9DD1-2D8CAA55E7E4@linux.dev>
References: <20231219075538.414708-1-peterx@redhat.com>
 <20231219075538.414708-4-peterx@redhat.com>
 <135b3189-f459-4b57-9861-bb8acb999d91@linux.dev> <ZZOhCuuozrBscdRC@x1n>
To: Peter Xu <peterx@redhat.com>
X-Migadu-Flow: FLOW_OUT



> On Jan 2, 2024, at 13:37, Peter Xu <peterx@redhat.com> wrote:
>=20
> On Mon, Dec 25, 2023 at 02:29:53PM +0800, Muchun Song wrote:
>>> @@ -1355,6 +1355,10 @@ static inline int pmd_write(pmd_t pmd)
>>>  #endif /* pmd_write */
>>>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>>> +#ifndef pmd_thp_or_huge
>>=20
>> I think it may be the time to rename to pmd_thp_or_hugetlb,
>> the "huge" is really confusing. thp is not huge? Actually,
>> it is huge. It is better to make it more specific from now on, like
>> "hugetlb".
>=20
> The rename will need to touch ARM code, which I wanted to avoid, see:

I see.

>=20
> arch/arm64/include/asm/pgtable.h:#define pmd_thp_or_huge(pmd)   =
(pmd_huge(pmd) || pmd_trans_huge(pmd))
>=20
> So far this series only touches generic code.  Would you mind I keep =
this
> patch as-is, and leave renaming to later?

OK.

THanks.

>=20
>>=20
>> BTW, please cc me via the new email (muchun.song@linux.dev) next =
edition.
>=20
> Sure.  Thanks for taking a look.
>=20
> --=20
> Peter Xu
>=20


