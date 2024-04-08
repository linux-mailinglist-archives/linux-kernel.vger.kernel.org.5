Return-Path: <linux-kernel+bounces-134894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B8889B858
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D35EF283487
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 07:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0982C86A;
	Mon,  8 Apr 2024 07:23:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766952C19D
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 07:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712561015; cv=none; b=mtPOD+s5q69tRyHIE03NLFLuNY2337i3J5U4z+HyXvPFH3q6yNbxiTIg7XO6f6lYYG3M3MjLlnmgpQPlDXdrfhIJ61OEl5vK6qG4DBZ0k4wJ5tk/uJXJwfScdw/sf3NCzZ2m+apPzMZIWHDDZXi2n9OjeBQYBJWX2TpTz8vqCa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712561015; c=relaxed/simple;
	bh=ZzRAcHxtSjjr3xSt8JnhXEEAZLntlCbosx2pWWo4Ink=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bs+z1t13e6ysY7PRmu/6K14PoWelMIbdHOi02CClVjKZaSiZ+R3maW6x/V862CGUMO7/WdK3qEFyua+Y1GkR2z5+Hzymu1XoMew4c4xaRe9OCj38kumILC/qQe5OexytbocwFOd/BdvkyYhdnldtfFgFJ8+qwJhDO03ew5ArEcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C91B51007;
	Mon,  8 Apr 2024 00:24:02 -0700 (PDT)
Received: from [10.57.73.169] (unknown [10.57.73.169])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 29E063F64C;
	Mon,  8 Apr 2024 00:23:31 -0700 (PDT)
Message-ID: <30f09196-5152-45db-85de-12ac89c974b1@arm.com>
Date: Mon, 8 Apr 2024 08:23:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm,swap: add document about RCU read lock and swapoff
 interaction
Content-Language: en-GB
To: Huang Ying <ying.huang@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 David Hildenbrand <david@redhat.com>, Miaohe Lin <linmiaohe@huawei.com>,
 Hugh Dickins <hughd@google.com>, Minchan Kim <minchan@kernel.org>
References: <20240407065450.498821-1-ying.huang@intel.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240407065450.498821-1-ying.huang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/04/2024 07:54, Huang Ying wrote:
> During reviewing a patch to fix the race condition between
> free_swap_and_cache() and swapoff() [1], it was found that the
> document about how to prevent racing with swapoff isn't clear enough.
> Especially RCU read lock can prevent swapoff from freeing data
> structures.  So, the document is added as comments.
> 
> [1] https://lore.kernel.org/linux-mm/c8fe62d0-78b8-527a-5bef-ee663ccdc37a@huawei.com/
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Miaohe Lin <linmiaohe@huawei.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Minchan Kim <minchan@kernel.org>

LGTM!

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>


> ---
>  mm/swapfile.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 4919423cce76..6925462406fa 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1226,16 +1226,15 @@ static unsigned char __swap_entry_free_locked(struct swap_info_struct *p,
>  
>  /*
>   * When we get a swap entry, if there aren't some other ways to
> - * prevent swapoff, such as the folio in swap cache is locked, page
> - * table lock is held, etc., the swap entry may become invalid because
> - * of swapoff.  Then, we need to enclose all swap related functions
> - * with get_swap_device() and put_swap_device(), unless the swap
> - * functions call get/put_swap_device() by themselves.
> + * prevent swapoff, such as the folio in swap cache is locked, RCU
> + * reader side is locked, etc., the swap entry may become invalid
> + * because of swapoff.  Then, we need to enclose all swap related
> + * functions with get_swap_device() and put_swap_device(), unless the
> + * swap functions call get/put_swap_device() by themselves.
>   *
> - * Note that when only holding the PTL, swapoff might succeed immediately
> - * after freeing a swap entry. Therefore, immediately after
> - * __swap_entry_free(), the swap info might become stale and should not
> - * be touched without a prior get_swap_device().
> + * RCU reader side lock (including any spinlock) is sufficient to
> + * prevent swapoff, because synchronize_rcu() is called in swapoff()
> + * before freeing data structures.
>   *
>   * Check whether swap entry is valid in the swap device.  If so,
>   * return pointer to swap_info_struct, and keep the swap entry valid
> @@ -2495,10 +2494,11 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
>  
>  	/*
>  	 * Wait for swap operations protected by get/put_swap_device()
> -	 * to complete.
> -	 *
> -	 * We need synchronize_rcu() here to protect the accessing to
> -	 * the swap cache data structure.
> +	 * to complete.  Because of synchronize_rcu() here, all swap
> +	 * operations protected by RCU reader side lock (including any
> +	 * spinlock) will be waited too.  This makes it easy to
> +	 * prevent folio_test_swapcache() and the following swap cache
> +	 * operations from racing with swapoff.
>  	 */
>  	percpu_ref_kill(&p->users);
>  	synchronize_rcu();


