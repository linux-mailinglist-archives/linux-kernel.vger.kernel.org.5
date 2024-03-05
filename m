Return-Path: <linux-kernel+bounces-91811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDD28716E8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BF031F2111D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEDD7E775;
	Tue,  5 Mar 2024 07:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dblI7cMC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E997F7D9
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 07:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709623854; cv=none; b=HOYZndyqEord5xggXxGyLSiNrDFykAqihv+VDu+hECzbEp+R4H5Jp6H4SDtdq2+hNUYVuBSmSS6uakr3PCd0oHiS/6raBIf1aKP80GAmsXUcUxwLbAIDSSkFIKeuWnZE/reOS+dHFPGKm1A3+UjLlJH9W7d57ZfZnr7wSfbu/Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709623854; c=relaxed/simple;
	bh=EDxT4L0OSxDAkEd0ZQSl0ECYq1LMfRvCmOH5WtqS+h4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bTxXdXH+lNVDvhh4XfBY0Q9Nty4ftpcHVTCGJFDYmG6yWkuA9MsawuL6nzhAw/YiZh7MkZGZSOjBXNOolbkVWNJqrVyxF+Itjax9gpN9yNK7pNfFllYhYTsX6gEHEUxxyWys2hdvoEYIYXsiRe+feaJq3mmBlLc9UKbYh5qjN4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dblI7cMC; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709623854; x=1741159854;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=EDxT4L0OSxDAkEd0ZQSl0ECYq1LMfRvCmOH5WtqS+h4=;
  b=dblI7cMCsFSHesVhQENfnImMUVuXXIjKOJScJf6cQ8GKETA8mSQ7fWLe
   p44H9NZzDuXtfWt7Zl8U2F3VEEdPwiw51ZGUEik79xm5NIoRQIGkqzHmN
   oGt1SDFJG/j1q/IjNIBtWMjSQ3wTVHoc0JA2n3u/LsQaM6P+vNPsaGEfA
   H1nsQ2kuq02diCUMjd9eWa4BwPGpNKZYhcxVPWQk4wA6Ymdvzz5OpUpJA
   Gac+/N8OwpdzDJppCpL4ro2U/xUaopD0Q4Qc4QhI0HPBS9AHg13s7BSZZ
   SPWGLMiKlcRolwNgWTtKUREGKF7+xLN/Hrsby9bYb8ynze1N6KlKOpclq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="7970833"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="7970833"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 23:30:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="13861172"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 23:30:31 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org,  linux-mm@kvack.org,  david@redhat.com,
  ryan.roberts@arm.com,  chrisl@kernel.org,  yuzhao@google.com,
  hanchuanhua@oppo.com,  linux-kernel@vger.kernel.org,
  willy@infradead.org,  xiang@kernel.org,  mhocko@suse.com,
  shy828301@gmail.com,  wangkefeng.wang@huawei.com,  Barry Song
 <v-songbaohua@oppo.com>,  Hugh Dickins <hughd@google.com>
Subject: Re: [RFC PATCH] mm: hold PTL from the first PTE while reclaiming a
 large folio
In-Reply-To: <20240304103757.235352-1-21cnbao@gmail.com> (Barry Song's message
	of "Mon, 4 Mar 2024 23:37:57 +1300")
References: <20240304103757.235352-1-21cnbao@gmail.com>
Date: Tue, 05 Mar 2024 15:28:36 +0800
Message-ID: <878r2x9ly3.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Barry Song <21cnbao@gmail.com> writes:

> From: Barry Song <v-songbaohua@oppo.com>
>
> page_vma_mapped_walk() within try_to_unmap_one() races with other
> PTEs modification such as break-before-make, while iterating PTEs

Sorry, I don't know what is "break-before-make", can you elaborate?
IIUC, ptep_modify_prot_start()/ptep_modify_prot_commit() can clear PTE
temporarily, which may cause race with page_vma_mapped_walk().  Is that
the issue that you try to fix?

--
Best Regards,
Huang, Ying

> of a large folio, it will only begin to acquire PTL after it gets
> a valid(present) PTE. break-before-make intermediately sets PTEs
> to pte_none. Thus, a large folio's PTEs might be partially skipped
> in try_to_unmap_one().
> For example, for an anon folio, after try_to_unmap_one(), we may
> have PTE0 present, while PTE1 ~ PTE(nr_pages - 1) are swap entries.
> So folio will be still mapped, the folio fails to be reclaimed.
> What=E2=80=99s even more worrying is, its PTEs are no longer in a unified
> state. This might lead to accident folio_split() afterwards. And
> since a part of PTEs are now swap entries, accessing them will
> incur page fault - do_swap_page.
> It creates both anxiety and more expense. While we can't avoid
> userspace's unmap to break up unified PTEs such as CONT-PTE for
> a large folio, we can indeed keep away from kernel's breaking up
> them due to its code design.
> This patch is holding PTL from PTE0, thus, the folio will either
> be entirely reclaimed or entirely kept. On the other hand, this
> approach doesn't increase PTL contention. Even w/o the patch,
> page_vma_mapped_walk() will always get PTL after it sometimes
> skips one or two PTEs because intermediate break-before-makes
> are short, according to test. Of course, even w/o this patch,
> the vast majority of try_to_unmap_one still can get PTL from
> PTE0. This patch makes the number 100%.
> The other option is that we can give up in try_to_unmap_one
> once we find PTE0 is not the first entry we get PTL, we call
> page_vma_mapped_walk_done() to end the iteration at this case.
> This will keep the unified PTEs while the folio isn't reclaimed.
> The result is quite similar with small folios with one PTE -
> either entirely reclaimed or entirely kept.
> Reclaiming large folios by holding PTL from PTE0 seems a better
> option comparing to giving up after detecting PTL begins from
> non-PTE0.
>
> Cc: Hugh Dickins <hughd@google.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  mm/vmscan.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 0b888a2afa58..e4722fbbcd0c 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1270,6 +1270,17 @@ static unsigned int shrink_folio_list(struct list_=
head *folio_list,
>=20=20
>  			if (folio_test_pmd_mappable(folio))
>  				flags |=3D TTU_SPLIT_HUGE_PMD;
> +			/*
> +			 * if page table lock is not held from the first PTE of
> +			 * a large folio, some PTEs might be skipped because of
> +			 * races with break-before-make, for example, PTEs can
> +			 * be pte_none intermediately, thus one or more PTEs
> +			 * might be skipped in try_to_unmap_one, we might result
> +			 * in a large folio is partially mapped and partially
> +			 * unmapped after try_to_unmap
> +			 */
> +			if (folio_test_large(folio))
> +				flags |=3D TTU_SYNC;
>=20=20
>  			try_to_unmap(folio, flags);
>  			if (folio_mapped(folio)) {

