Return-Path: <linux-kernel+bounces-13216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C71082013A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 20:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42BF228390D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 19:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61996134A4;
	Fri, 29 Dec 2023 19:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="wVpZ6jPr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A572C134A0
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 19:44:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7829C433C7;
	Fri, 29 Dec 2023 19:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1703879080;
	bh=ns1k4uVM2WW3ED0MkFvVFGjMioawgHcjU5xtCgOGIjw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=wVpZ6jPrKKPoOCPMaBquKZMt6vkoHZ7d2yQDRGa/2gydAcH5WmD4KjibPVoffWOoY
	 KUl81fD5OI4W1AtvD817iwKXlFqEE2tFz8W7kyFA7hhVJZG/ZdOrC88W3YH/Pco7HM
	 J4tPRxdIhT9JRSxqyC56wBvLXsvr3YGcAZVRTyL8=
Date: Fri, 29 Dec 2023 11:44:39 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc: hannes@cmpxchg.org, yosryahmed@google.com, nphamcs@gmail.com,
 sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, Chengming Zhou
 <zhouchengming@bytedance.com>, Chris Li <chrisl@kernel.org>, Nhat Pham
 <nphamcs@gmail.com>, Yosry Ahmed <yosryahmed@google.com>
Subject: Re: [PATCH] mm: zswap: fix the lack of page lru flag in 
 zswap_writeback_entry
Message-Id: <20231229114439.e3f3a33652fdc1e6df666ab5@linux-foundation.org>
In-Reply-To: <20231024142706.195517-1-hezhongkun.hzk@bytedance.com>
References: <20231024142706.195517-1-hezhongkun.hzk@bytedance.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Oct 2023 22:27:06 +0800 Zhongkun He <hezhongkun.hzk@bytedance.com> wrote:

> The zswap_writeback_entry() will add a page to the swap cache, decompress
> the entry data into the page, and issue a bio write to write the page back
> to the swap device. Move the page to the tail of lru list  through
> SetPageReclaim(page) and folio_rotate_reclaimable().
> 
> Currently, about half of the pages will fail to move to the tail of lru
> list because there is no LRU flag in page which is not in the LRU list but
> the cpu_fbatches. So fix it.

Some reviewer input on this change would be helpful, please.

Also, is there any measurable change in overall performance?

> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1139,6 +1139,11 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
>  	/* move it to the tail of the inactive list after end_writeback */
>  	SetPageReclaim(page);
>  
> +	if (!PageLRU(page)) {
> +		/* drain lru cache to help folio_rotate_reclaimable() */
> +		lru_add_drain();
> +	}
> +
>  	/* start writeback */
>  	__swap_writepage(page, &wbc);
>  	put_page(page);
> -- 
> 2.25.1
> 

