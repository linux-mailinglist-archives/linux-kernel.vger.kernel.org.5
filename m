Return-Path: <linux-kernel+bounces-24258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD80A82B9D7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 04:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C00A28C771
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 03:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE11015C9;
	Fri, 12 Jan 2024 03:02:13 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADEF10A15;
	Fri, 12 Jan 2024 03:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4TB5sF3MFmz1Q7m0;
	Fri, 12 Jan 2024 11:01:21 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 0BB5114093A;
	Fri, 12 Jan 2024 11:01:53 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Jan 2024 11:01:52 +0800
Subject: Re: [PATCH] fix hugetlbfs hwpoison handling
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
CC: <akpm@linux-foundation.org>, <usama.anjum@collabora.com>,
	<muchun.song@linux.dev>, <jiaqiyan@google.com>, <willy@infradead.org>,
	<naoya.horiguchi@nec.com>, <shy828301@gmail.com>, <jthoughton@google.com>,
	<jane.chu@oracle.com>, <stable@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<ying.huang@linux.intel.com>
References: <20240111191655.295530-1-sidhartha.kumar@oracle.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <3b1206e2-85e5-7c66-b5eb-288cc7117420@huawei.com>
Date: Fri, 12 Jan 2024 11:01:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240111191655.295530-1-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)

On 2024/1/12 3:16, Sidhartha Kumar wrote:
> has_extra_refcount() makes the assumption that a ref count of 1 means
> the page is not referenced by other users. Commit a08c7193e4f1
> (mm/filemap: remove hugetlb special casing in filemap.c) modifies
> __filemap_add_folio() by calling folio_ref_add(folio, nr); for all cases
> (including hugtetlb) where nr is the number of pages in the folio. We
> should check if the page is not referenced by other users by checking
> the page count against the number of pages rather than 1.

Thanks for your patch.

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
> Tested-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
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
> index d8c853b35dbb..87f6bf7d8bc1 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -973,7 +973,7 @@ struct page_state {
>  static bool has_extra_refcount(struct page_state *ps, struct page *p,
>  			       bool extra_pins)
>  {
> -	int count = page_count(p) - 1;
> +	int count = page_count(p) - folio_nr_pages(page_folio(p));

IIRC, the refcnt of 1 here means the page is held by memory-failure. So I think it shouldn't be
changed to folio_nr_pages(page_folio(p)).

>  
>  	if (extra_pins)
>  		count -= 1;

Indeed @extra_pins indicates whether hugetlb page is kept in page cache. So the page refcnt of
'folio_nr_pages(page_folio(p))' might be used here.

Thanks.



