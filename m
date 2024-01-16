Return-Path: <linux-kernel+bounces-26929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7A082E7EF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 03:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39E332849D9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 02:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014605254;
	Tue, 16 Jan 2024 02:36:17 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710A47E;
	Tue, 16 Jan 2024 02:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4TDY4S31fxz1V47r;
	Tue, 16 Jan 2024 10:34:32 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id B17FE14011F;
	Tue, 16 Jan 2024 10:36:09 +0800 (CST)
Received: from [10.173.135.154] (10.173.135.154) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Jan 2024 10:36:09 +0800
Subject: Re: [PATCH v2] fs/hugetlbfs/inode.c: mm/memory-failure.c: fix
 hugetlbfs hwpoison handling
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC: <akpm@linux-foundation.org>, <usama.anjum@collabora.com>,
	<muchun.song@linux.dev>, <jiaqiyan@google.com>, <willy@infradead.org>,
	<naoya.horiguchi@nec.com>, <shy828301@gmail.com>, <jthoughton@google.com>,
	<jane.chu@oracle.com>, <stable@vger.kernel.org>
References: <20240112180840.367006-1-sidhartha.kumar@oracle.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <1e59e3c8-63d5-bba1-9c00-218c3cc8f5ff@huawei.com>
Date: Tue, 16 Jan 2024 10:36:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240112180840.367006-1-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)

On 2024/1/13 2:08, Sidhartha Kumar wrote:
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
>     move ref_count adjustment to if(extra_pins) block as that represents
>     ref counts from the page cache per Miaohe Lin.

Thanks for your update of patch.

> 
>  fs/hugetlbfs/inode.c | 2 +-
>  mm/memory-failure.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 36132c9125f9..3a248e4f7e93 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -340,7 +340,7 @@ static ssize_t hugetlbfs_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  		} else {
>  			folio_unlock(folio);
>  
> -			if (!folio_test_has_hwpoisoned(folio))
> +			if (!folio_test_hwpoison(folio))
>  				want = nr;
>  			else {
>  				/*
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index d8c853b35dbb..ef7ae73b65bd 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -976,7 +976,7 @@ static bool has_extra_refcount(struct page_state *ps, struct page *p,
>  	int count = page_count(p) - 1;
>  
>  	if (extra_pins)
> -		count -= 1;
> +		count -= folio_nr_pages(page_folio(p));

I think this should be the right solution. @extra_pins indicates the extra page refcnt from page cache.

Acked-by: Miaohe Lin <linmiaohe@huawei.com>
Thanks.

>  
>  	if (count > 0) {
>  		pr_err("%#lx: %s still referenced by %d users\n",
> 


