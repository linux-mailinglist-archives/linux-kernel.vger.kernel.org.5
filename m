Return-Path: <linux-kernel+bounces-134925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE9789B8D6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D0A01F21A60
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 07:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC83E29CFD;
	Mon,  8 Apr 2024 07:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H5qkbkZ8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B61251004
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 07:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712562097; cv=none; b=pjqA6Xbql33+2yNtVD8EWPvs/b6gldQttCzY2T2OzUiDCnHSdclx9L3uxVe0ZbDxE/vdWkuZcQrYmQnBERDrxm9RiHDukuLLW/9wC4OBHb+eMCrq/AbFSLE9pBj0TzQHvVtRje+WpWzRZEdSHfxZzaH3f9H28sCY6Lee9Tg4JMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712562097; c=relaxed/simple;
	bh=OyXVP0R2ip4TFP/7ULM0+K+7pdgdByuPjaYkoU1E/rg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HzAnhvB/gaMQN616E/Pgp09OiNybuljK30SpDWKBTtYyCJO8kw/scNZNeQf2wWn+BYoPN05iEKWZ4R1GGysozD6BmMCDp61oQ7Zugxl/SXo3qtHTGjWVHRSFGtYob386540GNSBiLlttvxSSOadYSTSaey+e8jxoDh1MS/2W+hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H5qkbkZ8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712562095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aXjg1DGkpy6v+34vGsVRlYgX286GisZypAohRXKPIro=;
	b=H5qkbkZ8PDn7biSXJSPA7fs61QUNaExU5CDMGSqO3ow6Sh072ZBRg64qnfn1jUahmojusU
	iu4X2nwtqnLNZJc0n4DgQEKtlSgn5WjUgc1t+ze4FuWvg2vdpmkeIp29pupOMdsurNlB03
	89U2hi86+EuAhajjWoMIWZ2FRI51XOA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-sKYBJaEsMBm3lJqbIUMElQ-1; Mon, 08 Apr 2024 03:41:33 -0400
X-MC-Unique: sKYBJaEsMBm3lJqbIUMElQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-41663448bcbso3738645e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 00:41:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712562092; x=1713166892;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aXjg1DGkpy6v+34vGsVRlYgX286GisZypAohRXKPIro=;
        b=UoXFwDN7BAqVLlqEVK5eKBqugyjUaYDbOjDhfWDKOHdcEbIlXCAlLT9bptjOig2baG
         QUXu7JqSiQ4+LFK77x9aO1V1pE9cvzPtQLQLc7pu7R01uA6kMjU+akYkC4x4yDC/EYIc
         8hFw/1LzvpHqoZGrPpUw40J4jKJn8APzoMJyQhwVDNkfmvJrRokXQXcK14FJuV+5epGH
         O91p/h6w3tBBptvg7to1fG0yV7qchrsns1s0+f9+c7DYU61w8crCW46Uq+amYYFs0AXW
         SsuDGzymeizGSul01CTsrTh7U/xVedd4qv+XqCdZZI+kPrvcxLyLb94yGpnxX434FkG7
         /Tzw==
X-Forwarded-Encrypted: i=1; AJvYcCVUx0veIC66T4c3bFYZEGN7D6r2VO7YvKEgpSOeYbGdwQyVcGyFqUxl/vl2y0RIlTHO271QgB7kxDPIqZi8BBouezBIGUUlpdUEq7NY
X-Gm-Message-State: AOJu0Yynqik9H7kPB2EpwRGiFXmtrjpTDcPgwpERHfmjD5s0LfFsXQgv
	buNEEAMyIMvBgY5bhcMGRWRRPT/nA4rYZBuJZocWcyO21CnPT1/CNW+evT9Tz8hfAXSEyBdSEud
	eBQW1RmVMVvDSaQeiPtzIi5wXK/PRWXz1wy7hmkMJsGGaFo5F5BADsJhJzbdvpTXtV4Fx6Q==
X-Received: by 2002:a05:600c:1c0e:b0:416:4694:d743 with SMTP id j14-20020a05600c1c0e00b004164694d743mr3401750wms.4.1712562092182;
        Mon, 08 Apr 2024 00:41:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKtW1u3iGUmpqULkJu0p5sFwV9qG0A74NB63xdsHM8ZK9J1f5hlQR5r9XE3ZDI/Fhsl5G8IQ==
X-Received: by 2002:a05:600c:1c0e:b0:416:4694:d743 with SMTP id j14-20020a05600c1c0e00b004164694d743mr3401730wms.4.1712562091771;
        Mon, 08 Apr 2024 00:41:31 -0700 (PDT)
Received: from ?IPV6:2003:cb:c718:1300:9860:66a2:fe4d:c379? (p200300cbc7181300986066a2fe4dc379.dip0.t-ipconnect.de. [2003:cb:c718:1300:9860:66a2:fe4d:c379])
        by smtp.gmail.com with ESMTPSA id fc9-20020a05600c524900b004162a9f03a6sm15534185wmb.7.2024.04.08.00.41.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 00:41:31 -0700 (PDT)
Message-ID: <ad5877ed-0526-41ef-b639-6d5764a85952@redhat.com>
Date: Mon, 8 Apr 2024 09:41:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm,swap: add document about RCU read lock and swapoff
 interaction
To: Huang Ying <ying.huang@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Ryan Roberts <ryan.roberts@arm.com>, Miaohe Lin <linmiaohe@huawei.com>,
 Hugh Dickins <hughd@google.com>, Minchan Kim <minchan@kernel.org>
References: <20240407065450.498821-1-ying.huang@intel.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240407065450.498821-1-ying.huang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.04.24 08:54, Huang Ying wrote:
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
> ---
>   mm/swapfile.c | 26 +++++++++++++-------------
>   1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 4919423cce76..6925462406fa 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1226,16 +1226,15 @@ static unsigned char __swap_entry_free_locked(struct swap_info_struct *p,
>   
>   /*
>    * When we get a swap entry, if there aren't some other ways to
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
>    *
> - * Note that when only holding the PTL, swapoff might succeed immediately
> - * after freeing a swap entry. Therefore, immediately after
> - * __swap_entry_free(), the swap info might become stale and should not
> - * be touched without a prior get_swap_device().
> + * RCU reader side lock (including any spinlock) is sufficient to
> + * prevent swapoff, because synchronize_rcu() is called in swapoff()
> + * before freeing data structures.
>    *
>    * Check whether swap entry is valid in the swap device.  If so,
>    * return pointer to swap_info_struct, and keep the swap entry valid
> @@ -2495,10 +2494,11 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
>   
>   	/*
>   	 * Wait for swap operations protected by get/put_swap_device()
> -	 * to complete.
> -	 *
> -	 * We need synchronize_rcu() here to protect the accessing to
> -	 * the swap cache data structure.
> +	 * to complete.  Because of synchronize_rcu() here, all swap
> +	 * operations protected by RCU reader side lock (including any
> +	 * spinlock) will be waited too.  This makes it easy to
> +	 * prevent folio_test_swapcache() and the following swap cache
> +	 * operations from racing with swapoff.
>   	 */
>   	percpu_ref_kill(&p->users);
>   	synchronize_rcu();

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


