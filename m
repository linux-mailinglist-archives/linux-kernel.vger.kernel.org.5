Return-Path: <linux-kernel+bounces-128901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A9289619F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 02:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 998BE284884
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44C3DDC9;
	Wed,  3 Apr 2024 00:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="e3/RzaVz"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEBA125CC
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 00:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712105274; cv=none; b=OB2OtZwqCsA/m+RmQ4RnMaHmeY6gyaqKyQy20YLytExmbFAWi4hOTku5o+40PGjRF5PHU9OlzOTCQlNy+9qB+mirk1/6SkUtXS8fa8n1dJLBpISZktvfBKO20SSPxIBfyOdBADIA6jXu0hwGxh/oKL/7Kv+ialS3WA4vIzQ0waE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712105274; c=relaxed/simple;
	bh=hP8G3UaWFuuXyJ9AEmMHvMKJeN/3+AdHrGS4nfykHt4=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=cFZQe7vPXgW+gOQ9y/ePwTw6TELlKJBHn9spUg9kuT9bddC7Io2H8dgSYAnvO2fkGC/jnLU7l9PtChkj9F23Gc4GYA/ReLzpWZOQ23494TYgPTjFV028wsXLYCF483eJtsO+4kbZ+S4A4HRoKBYGMZrnTHpibE0bSDRLloBc+P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=e3/RzaVz; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712105270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VpwvRSrPLH+MnRF++w0ONvrc5w145lT6umS6mZQL/vg=;
	b=e3/RzaVzNG6TFVqMp1I3dKvaLbhhTDjRNWOAfPTyrIaIemAdswPC7WeuMiE2xRCEstXlCW
	2hS8g55t2J6DNsOQJt9y2RmAcVMm3TuBfp05cuIGYHXa1PXrqwW9g3CFybT3YwQPKH9hsi
	8H9G7PDNkfndf5JN/IgEOPX388fdZDE=
Date: Wed, 03 Apr 2024 00:47:47 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Lance Yang" <lance.yang@linux.dev>
Message-ID: <ae13e7bf958d38ce56bd7e2e2c4ff3375a0ab0ff@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v5 2/6] mm: swap: free_swap_and_cache_nr() as batched
 free_swap_and_cache()
To: "Zi Yan" <ziy@nvidia.com>, "Ryan Roberts" <ryan.roberts@arm.com>
Cc: "Andrew Morton" <akpm@linux-foundation.org>, "David Hildenbrand"
 <david@redhat.com>, "Matthew Wilcox" <willy@infradead.org>, "Huang Ying"
 <ying.huang@intel.com>, "Gao Xiang" <xiang@kernel.org>, "Yu Zhao"
 <yuzhao@google.com>, "Yang Shi" <shy828301@gmail.com>, "Michal Hocko"
 <mhocko@suse.com>, "Kefeng Wang" <wangkefeng.wang@huawei.com>, "Barry
 Song" <21cnbao@gmail.com>, "Chris Li" <chrisl@kernel.org>, "Lance Yang"
 <ioworker0@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <B0E526FD-64CF-4653-B624-1AFA5B7AA245@nvidia.com>
References: <20240327144537.4165578-1-ryan.roberts@arm.com>
 <20240327144537.4165578-3-ryan.roberts@arm.com>
 <B0E526FD-64CF-4653-B624-1AFA5B7AA245@nvidia.com>
X-Migadu-Flow: FLOW_OUT

April 3, 2024 at 8:30 AM, "Zi Yan" <ziy@nvidia.com> wrote:



>=20
>=20On 27 Mar 2024, at 10:45, Ryan Roberts wrote:
>=20
>=20>=20
>=20> Now that we no longer have a convenient flag in the cluster to dete=
rmine
> >=20
>=20>  if a folio is large, free_swap_and_cache() will take a reference a=
nd
> >=20
>=20>  lock a large folio much more often, which could lead to contention=
 and
> >=20
>=20>  (e.g.) failure to split large folios, etc.
> >=20
>=20>  Let's solve that problem by batch freeing swap and cache with a ne=
w
> >=20
>=20>  function, free_swap_and_cache_nr(), to free a contiguous range of =
swap
> >=20
>=20>  entries together. This allows us to first drop a reference to each=
 swap
> >=20
>=20>  slot before we try to release the cache folio. This means we only =
try to
> >=20
>=20>  release the folio once, only taking the reference and lock once - =
much
> >=20
>=20>  better than the previous 512 times for the 2M THP case.
> >=20
>=20>  Contiguous swap entries are gathered in zap_pte_range() and
> >=20
>=20>  madvise_free_pte_range() in a similar way to how present ptes are
> >=20
>=20>  already gathered in zap_pte_range().
> >=20
>=20>  While we are at it, let's simplify by converting the return type o=
f both
> >=20
>=20>  functions to void. The return value was used only by zap_pte_range=
() to
> >=20
>=20>  print a bad pte, and was ignored by everyone else, so the extra
> >=20
>=20>  reporting wasn't exactly guaranteed. We will still get the warning=
 with
> >=20
>=20>  most of the information from get_swap_device(). With the batch ver=
sion,
> >=20
>=20>  we wouldn't know which pte was bad anyway so could print the wrong=
 one.
> >=20
>=20>  Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> >=20
>=20>  ---
> >=20
>=20>  include/linux/pgtable.h | 28 +++++++++++++++
> >=20
>=20>  include/linux/swap.h | 12 +++++--
> >=20
>=20>  mm/internal.h | 48 +++++++++++++++++++++++++
> >=20
>=20>  mm/madvise.c | 12 ++++---
> >=20
>=20>  mm/memory.c | 13 +++----
> >=20
>=20>  mm/swapfile.c | 78 ++++++++++++++++++++++++++++++-----------
> >=20
>=20>  6 files changed, 157 insertions(+), 34 deletions(-)
> >=20
>=20>  diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> >=20
>=20>  index 09c85c7bf9c2..8185939df1e8 100644
> >=20
>=20>  --- a/include/linux/pgtable.h
> >=20
>=20>  +++ b/include/linux/pgtable.h
> >=20
>=20>  @@ -708,6 +708,34 @@ static inline void pte_clear_not_present_full=
(struct mm_struct *mm,
> >=20
>=20>  }
> >=20
>=20>  #endif
> >=20
>=20>  +#ifndef clear_not_present_full_ptes
> >=20
>=20>  +/**
> >=20
>=20>  + * clear_not_present_full_ptes - Clear consecutive not present PT=
Es.
> >=20
>=20>  + * @mm: Address space the ptes represent.
> >=20
>=20>  + * @addr: Address of the first pte.
> >=20
>=20>  + * @ptep: Page table pointer for the first entry.
> >=20
>=20>  + * @nr: Number of entries to clear.
> >=20
>=20>  + * @full: Whether we are clearing a full mm.
> >=20
>=20>  + *
> >=20
>=20>  + * May be overridden by the architecture; otherwise, implemented =
as a simple
> >=20
>=20>  + * loop over pte_clear_not_present_full().
> >=20
>=20>  + *
> >=20
>=20>  + * Context: The caller holds the page table lock. The PTEs are al=
l not present.
> >=20
>=20>  + * The PTEs are all in the same PMD.
> >=20
>=20>  + */
> >=20
>=20>  +static inline void clear_not_present_full_ptes(struct mm_struct *=
mm,
> >=20
>=20>  + unsigned long addr, pte_t *ptep, unsigned int nr, int full)
> >=20
>=20>  +{
> >=20
>=20>  + for (;;) {
> >=20
>=20>  + pte_clear_not_present_full(mm, addr, ptep, full);
> >=20
>=20>  + if (--nr =3D=3D 0)
> >=20
>=20>  + break;
> >=20
>=20>  + ptep++;
> >=20
>=20>  + addr +=3D PAGE_SIZE;
> >=20
>=20>  + }
> >=20
>=20>  +}
> >=20
>=20>  +#endif
> >=20
>=20>  +
> >=20
>=20
> Would the code below be better?
>=20
>=20for (i =3D 0; i < nr; i++, ptep++, addr +=3D PAGE_SIZE)
>=20

FWIW

for=20(; nr-- > 0; ptep++, addr +=3D PAGE_SIZE)
  pte_clear_not_present_full(mm, addr, ptep, full);

Thanks,
Lance


>  pte_clear_not_present_full(mm, addr, ptep, full);
>=20
>=20--
>=20
>=20Best Regards,
>=20
>=20Yan, Zi
>

