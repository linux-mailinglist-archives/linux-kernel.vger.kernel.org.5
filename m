Return-Path: <linux-kernel+bounces-25946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF6482D8B0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 13:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E28191F22653
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 12:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BBF92C69B;
	Mon, 15 Jan 2024 12:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XMLr/Gyr"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997A81E867
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 12:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <03168121-080f-41e4-a242-02638f5787f7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705320181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0ku4XsXQqxqtL/FTICwMT++CeuXLKDLkAWaL9IT7UHs=;
	b=XMLr/GyrtPkV7e9kX240aayMjgfu+hZ4RAC0BD3UMdAsnR5UoeV+/t7OfvMpMiN+SEL4tv
	Eg7DbbHjNSlgyrXhC4xZvg6fqxayKQ63Vqs2yA7tQ9tqkXZrtDdxNXgvldzv3x8V5AwpyA
	0322B8O3yB1KcRQOU4KdyKWmvxGlmWY=
Date: Mon, 15 Jan 2024 20:02:51 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] fs/hugetlbfs/inode.c: mm/memory-failure.c: fix
 hugetlbfs hwpoison handling
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: akpm@linux-foundation.org, usama.anjum@collabora.com,
 jiaqiyan@google.com, willy@infradead.org, linmiaohe@huawei.com,
 naoya.horiguchi@nec.com, shy828301@gmail.com, jthoughton@google.com,
 jane.chu@oracle.com, stable@vger.kernel.org
References: <20240112180840.367006-1-sidhartha.kumar@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20240112180840.367006-1-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2024/1/13 02:08, Sidhartha Kumar wrote:
> has_extra_refcount() makes the assumption that the page cache adds a ref
> count of 1 and subtracts this in the extra_pins case. Commit a08c7193e4f1
> (mm/filemap: remove hugetlb special casing in filemap.c) modifies
> __filemap_add_folio() by calling folio_ref_add(folio, nr); for all cases
> (including hugtetlb) where nr is the number of pages in the folio. We
> should adjust the number of references coming from the page cache by
> subtracing the number of pages rather than 1.
>
> In hugetlbfs_read_iter(), folio_test_has_hwpoisoned() is testing the wrong
> flag as, in the hugetlb case, memory-failure code calls
> folio_test_set_hwpoison() to indicate poison. folio_test_hwpoison() is the
> correct function to test for that flag.
>
> After these fixes, the hugetlb hwpoison read selftest passes all cases.
>
> Fixes: a08c7193e4f1 ("mm/filemap: remove hugetlb special casing in filemap.c")
> Closes: https://lore.kernel.org/linux-mm/20230713001833.3778937-1-jiaqiyan@google.com/T/#m8e1469119e5b831bbd05d495f96b842e4a1c5519
> Cc: <stable@vger.kernel.org> # 6.7+
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> Reported-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>
> v1 -> v2:
>      move ref_count adjustment to if(extra_pins) block as that represents
>      ref counts from the page cache per Miaohe Lin.
>
>   fs/hugetlbfs/inode.c | 2 +-
>   mm/memory-failure.c  | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 36132c9125f9..3a248e4f7e93 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -340,7 +340,7 @@ static ssize_t hugetlbfs_read_iter(struct kiocb *iocb, struct iov_iter *to)
>   		} else {
>   			folio_unlock(folio);
>   
> -			if (!folio_test_has_hwpoisoned(folio))
> +			if (!folio_test_hwpoison(folio))
>   				want = nr;
>   			else {
>   				/*
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index d8c853b35dbb..ef7ae73b65bd 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -976,7 +976,7 @@ static bool has_extra_refcount(struct page_state *ps, struct page *p,
>   	int count = page_count(p) - 1;
>   
>   	if (extra_pins)
> -		count -= 1;
> +		count -= folio_nr_pages(page_folio(p));

IIUC, It seems than this also fix shmem of THP, because 
has_extra_refcount() is called
from me_pagecache_clean(), right?

>   
>   	if (count > 0) {
>   		pr_err("%#lx: %s still referenced by %d users\n",


