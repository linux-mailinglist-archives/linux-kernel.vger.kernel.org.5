Return-Path: <linux-kernel+bounces-35976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD099839989
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 20:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 434AAB294CD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A171E81AA9;
	Tue, 23 Jan 2024 19:15:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E7150A64;
	Tue, 23 Jan 2024 19:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706037347; cv=none; b=GtDiBxiZDb+kb+B6kDxIwRCKNTgaZ+Tw7EstfTygQrxsLzbB9Iwj6Me0Fj2hA7ScXZiDzsOXKATY+W+7zyJhw6hOIhoTV0b2/CDT2SEb4IkPZ8H/RYum0TZD29c+3RghJah6U4cubwKZ8nZLu/5Z1eIl29nzrTqCBRsrTp1kTrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706037347; c=relaxed/simple;
	bh=dO62yN+4S3GW0t7/iGaTOEbxPhAmAh875fSgkvySTng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NyjRZxIMNZuyQUoiZvmO/gsXoZZwLR3Z7FiWIf3kmRWahlxHLjA813iiWuGV0yzhIq+CV1FdLiP7+sOWmg+6DqF6D4WV8X+cnpNx6KYZjpAhf07SGd495wq+MAYRKXgOHZoRMn3uwVA9bKTe3KGdIl/Ba/c+Qk4sM25XAj74cQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7948C1FB;
	Tue, 23 Jan 2024 11:16:29 -0800 (PST)
Received: from [10.57.77.165] (unknown [10.57.77.165])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 787ED3F73F;
	Tue, 23 Jan 2024 11:15:40 -0800 (PST)
Message-ID: <56bee384-461e-4167-b7e9-4dd60666dd66@arm.com>
Date: Tue, 23 Jan 2024 19:15:39 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/11] mm/memory: optimize fork() with PTE-mapped THP
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Dinh Nguyen <dinguyen@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, "David S. Miller"
 <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org
References: <20240122194200.381241-1-david@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240122194200.381241-1-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/01/2024 19:41, David Hildenbrand wrote:
> Now that the rmap overhaul[1] is upstream that provides a clean interface
> for rmap batching, let's implement PTE batching during fork when processing
> PTE-mapped THPs.
> 
> This series is partially based on Ryan's previous work[2] to implement
> cont-pte support on arm64, but its a complete rewrite based on [1] to
> optimize all architectures independent of any such PTE bits, and to
> use the new rmap batching functions that simplify the code and prepare
> for further rmap accounting changes.
> 
> We collect consecutive PTEs that map consecutive pages of the same large
> folio, making sure that the other PTE bits are compatible, and (a) adjust
> the refcount only once per batch, (b) call rmap handling functions only
> once per batch and (c) perform batch PTE setting/updates.
> 
> While this series should be beneficial for adding cont-pte support on
> ARM64[2], it's one of the requirements for maintaining a total mapcount[3]
> for large folios with minimal added overhead and further changes[4] that
> build up on top of the total mapcount.

I'm currently rebasing my contpte work onto this series, and have hit a problem.
I need to expose the "size" of a pte (pte_size()) and skip forward to the start
of the next (cont)pte every time through the folio_pte_batch() loop. But
pte_next_pfn() only allows advancing by 1 pfn; I need to advance by nr pfns:


static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
		pte_t *start_ptep, pte_t pte, int max_nr, bool *any_writable)
{
	unsigned long folio_end_pfn = folio_pfn(folio) + folio_nr_pages(folio);
	const pte_t *end_ptep = start_ptep + max_nr;
	pte_t expected_pte = __pte_batch_clear_ignored(pte_next_pfn(pte));
-	pte_t *ptep = start_ptep + 1;
+	pte_t *ptep = start_ptep;
+	int vfn, nr, i;
	bool writable;

	if (any_writable)
		*any_writable = false;

	VM_WARN_ON_FOLIO(!pte_present(pte), folio);

+	vfn = addr >> PAGE_SIZE;
+	nr = pte_size(pte);
+	nr = ALIGN_DOWN(vfn + nr, nr) - vfn;
+	ptep += nr;
+
	while (ptep != end_ptep) {
+		pte = ptep_get(ptep);
		nr = pte_size(pte);
		if (any_writable)
			writable = !!pte_write(pte);
		pte = __pte_batch_clear_ignored(pte);

		if (!pte_same(pte, expected_pte))
			break;

		/*
		 * Stop immediately once we reached the end of the folio. In
		 * corner cases the next PFN might fall into a different
		 * folio.
		 */
-		if (pte_pfn(pte) == folio_end_pfn)
+		if (pte_pfn(pte) >= folio_end_pfn)
			break;

		if (any_writable)
			*any_writable |= writable;

-		expected_pte = pte_next_pfn(expected_pte);
-		ptep++;
+		for (i = 0; i < nr; i++)
+			expected_pte = pte_next_pfn(expected_pte);
+		ptep += nr;
	}

	return ptep - start_ptep;
}


So I'm wondering if instead of enabling pte_next_pfn() for all the arches,
perhaps its actually better to expose pte_pgprot() for all the arches. Then we
can be much more flexible about generating ptes with pfn_pte(pfn, pgprot).

What do you think?



