Return-Path: <linux-kernel+bounces-25695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2104782D4B0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 08:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A851428199C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 07:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B245233;
	Mon, 15 Jan 2024 07:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="R4JcS7dy"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1048C4402;
	Mon, 15 Jan 2024 07:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705304980;
	bh=N3XCgFDqk2GrOitAp3uyTP3EuoDEu1xWts+NDkUZPHA=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=R4JcS7dyyz17O7mEwJV5qf5f1nlW0Mo+tFwR2hRBttaxbdHrHFV9bu112yi4NmNKM
	 WePKXscCqpfwoLQdSrq8LmRyrU4+p9e8B34nesX4bKlSywDbP9KZPCa/OwAGHd/Jil
	 5XVZOLJ4FoAPN6lbdhWFd8ea8wJVkPuFP2rhjq2HCg2F6E+UiUQZSWvpWzUugebhuM
	 DsE9N3xhNK/swZdhrk+IyRRLu/HkES7LqIYI9bmHueOrj+ZXApD3fQTL2BlUgcWiHY
	 H9gUgEg9fTLL10FK0z7xgB9vjaBV5fSby/gTseJ/EHR+MGvTu3HiqaKkFMjLAK1t3r
	 sDyeDvE6peUmg==
Received: from [100.96.234.34] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4264D37813DD;
	Mon, 15 Jan 2024 07:49:37 +0000 (UTC)
Message-ID: <b0c85ee9-5c43-444b-b81c-0c1a8401f2e0@collabora.com>
Date: Mon, 15 Jan 2024 12:49:45 +0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 akpm@linux-foundation.org, muchun.song@linux.dev, jiaqiyan@google.com,
 willy@infradead.org, linmiaohe@huawei.com, naoya.horiguchi@nec.com,
 shy828301@gmail.com, jthoughton@google.com, jane.chu@oracle.com,
 stable@vger.kernel.org, "kernel@collabora.com" <kernel@collabora.com>
Subject: Re: [PATCH v2] fs/hugetlbfs/inode.c: mm/memory-failure.c: fix
 hugetlbfs hwpoison handling
Content-Language: en-US
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240112180840.367006-1-sidhartha.kumar@oracle.com>
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240112180840.367006-1-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/12/24 11:08 PM, Sidhartha Kumar wrote:
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
Tested-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
> 
> v1 -> v2:
>     move ref_count adjustment to if(extra_pins) block as that represents
>     ref counts from the page cache per Miaohe Lin.
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
>  
>  	if (count > 0) {
>  		pr_err("%#lx: %s still referenced by %d users\n",

-- 
BR,
Muhammad Usama Anjum

