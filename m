Return-Path: <linux-kernel+bounces-92629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0162487231F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81FDB1F226A0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A6F127B65;
	Tue,  5 Mar 2024 15:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QlODpShP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEF5127B50
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 15:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709653813; cv=none; b=tPxNkcb6hhg7s5OJjrIuXv1YLscC9WSUH+Z/X6ps61D2vqM4IpWY7F3UBID+WmOrU/NHGbnKYo6JkIPpwsgDkFVA/F4HTP1WEYvoWS95k0Jp3RJf11Z74mVJN6Ka20N321kFKN+zI5VqgdCPJ+AhVqNQBRx+cqJWacRKY7LgS84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709653813; c=relaxed/simple;
	bh=QeyiRiKtFUmv85nxdL/Xv6ZWP8RdUk5xNvksulmsHOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iChDUFt9u36+FLoP3E0cEybf4kjwjEm/AdQUDXTtgk8nQVtF8n8AcKWvOyJ6OhiU8xN8liXIxrFQT1ndPLB6qiIICgYbZkDT9WEVrsSAmb0aB0Kg27wIGtUbFjm5YR2EwjdCz18LktDwBLP6u1J05MxnU+G59HPtc7K/BLoVcG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QlODpShP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709653806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zCIy443PV1bMExvsymG7IFjtByoanOECI8kV/uhdu4Q=;
	b=QlODpShPQnivpfkePLibszwfSI6lNzzKgom5zuURyuqh+v2ySBvjbWqQy322wXOrsreeCQ
	UaZrgOlCSgSV0TsCKCL//oyYjZ3KyrvAILbQYVLb2mJYAP5tN5rQtSqz2jA0kthTm53SZj
	OterMIHXbimipf728QdwpZro1pBWJak=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-FXf8J3NKPRKbcsZOFR1GYw-1; Tue, 05 Mar 2024 10:50:03 -0500
X-MC-Unique: FXf8J3NKPRKbcsZOFR1GYw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33deb0e69daso2396130f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 07:50:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709653802; x=1710258602;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zCIy443PV1bMExvsymG7IFjtByoanOECI8kV/uhdu4Q=;
        b=hRIk5TC8UwTEElKXIXZSWmSbXyuOOBd4ULGw4z3kc9ZpMkl8/l3mwDE/QCTEZFmPM7
         32t5o2w34tPaByzJrnAjwqEZgLlFYG+CRukTfHs3+f6oTmwaIYDKVZAD7fQ38CvYZc1j
         954WYQMazQ1xWwfAVnWZUNGGYYV1djYEbz1yB0nvvjstgyolec6R/JBoK8HSqbg/hXEP
         83ffYyGV3PsaGODcdnBfzWmqGcuQQbffFz0IJd5JIcZcv9p6ab11H+klPDUs0VfHTNoO
         Lqqr+ui/dujKcuycFzEnVlWEkmK2w932F94ddc8DhFMWmsVo4XYO4bjZoTY7HUrzZgMI
         egLQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3fWknI1O4vr3dc1vu7ZyVTczrcsFjG1tj5CJOkwtEXwX8SOOirQqRly1IjNRERBgDhe7uVltA2qr2p7sGZ71TRzE25IHzK5fbTGPW
X-Gm-Message-State: AOJu0Yy0viIk2Sb1R95TGGgbPsP7AOhsTwXM7LMS2UYQ5L5AJqzT4Zna
	yrdX86NDcIfEGTR6/YoDeJmipRPvVUvHXnAFvmW1qq51bzBnfllL2yExX63Ci8agvGYKuC/MS49
	6j+9Xq8zb+9Ty9l14SLkQ2Zk/CmCItgvhh4znLMvDJYPk1cjwNx47NEYwGdA1YMCWA0/3dQ==
X-Received: by 2002:adf:9dc4:0:b0:33e:1ee0:62ac with SMTP id q4-20020adf9dc4000000b0033e1ee062acmr8455507wre.5.1709653802058;
        Tue, 05 Mar 2024 07:50:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmrb4M094kjpI+xCb6K9TxDuygeKpMipcdzxLgCU/VQBNhWcXn8spbARz+uJ/HiNVXNVb6kw==
X-Received: by 2002:adf:9dc4:0:b0:33e:1ee0:62ac with SMTP id q4-20020adf9dc4000000b0033e1ee062acmr8455490wre.5.1709653801518;
        Tue, 05 Mar 2024 07:50:01 -0800 (PST)
Received: from ?IPV6:2003:cb:c73c:8100:600:a1e5:da94:a13a? (p200300cbc73c81000600a1e5da94a13a.dip0.t-ipconnect.de. [2003:cb:c73c:8100:600:a1e5:da94:a13a])
        by smtp.gmail.com with ESMTPSA id ch10-20020a5d5d0a000000b0033e26c81b11sm10380878wrb.92.2024.03.05.07.50.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 07:50:01 -0800 (PST)
Message-ID: <cb738797-77d9-4e20-a54c-f70385cdbd95@redhat.com>
Date: Tue, 5 Mar 2024 16:50:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm: swap: Fix race between free_swap_and_cache() and
 swapoff()
Content-Language: en-US
To: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>, "Huang, Ying"
 <ying.huang@intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240305151349.3781428-1-ryan.roberts@arm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240305151349.3781428-1-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.03.24 16:13, Ryan Roberts wrote:
> There was previously a theoretical window where swapoff() could run and
> teardown a swap_info_struct while a call to free_swap_and_cache() was
> running in another thread. This could cause, amongst other bad
> possibilities, swap_page_trans_huge_swapped() (called by
> free_swap_and_cache()) to access the freed memory for swap_map.
> 
> This is a theoretical problem and I haven't been able to provoke it from
> a test case. But there has been agreement based on code review that this
> is possible (see link below).
> 
> Fix it by using get_swap_device()/put_swap_device(), which will stall
> swapoff(). There was an extra check in _swap_info_get() to confirm that
> the swap entry was valid. This wasn't present in get_swap_device() so
> I've added it. I couldn't find any existing get_swap_device() call sites
> where this extra check would cause any false alarms.
> 
> Details of how to provoke one possible issue (thanks to David Hilenbrand
> for deriving this):

Almost

"s/Hilenbrand/Hildenbrand/" :)

> 
> --8<-----
> 
> __swap_entry_free() might be the last user and result in
> "count == SWAP_HAS_CACHE".
> 
> swapoff->try_to_unuse() will stop as soon as soon as si->inuse_pages==0.
> 
> So the question is: could someone reclaim the folio and turn
> si->inuse_pages==0, before we completed swap_page_trans_huge_swapped().
> 
> Imagine the following: 2 MiB folio in the swapcache. Only 2 subpages are
> still references by swap entries.
> 
> Process 1 still references subpage 0 via swap entry.
> Process 2 still references subpage 1 via swap entry.
> 
> Process 1 quits. Calls free_swap_and_cache().
> -> count == SWAP_HAS_CACHE
> [then, preempted in the hypervisor etc.]
> 
> Process 2 quits. Calls free_swap_and_cache().
> -> count == SWAP_HAS_CACHE
> 
> Process 2 goes ahead, passes swap_page_trans_huge_swapped(), and calls
> __try_to_reclaim_swap().
> 
> __try_to_reclaim_swap()->folio_free_swap()->delete_from_swap_cache()->
> put_swap_folio()->free_swap_slot()->swapcache_free_entries()->
> swap_entry_free()->swap_range_free()->
> ...
> WRITE_ONCE(si->inuse_pages, si->inuse_pages - nr_entries);
> 
> What stops swapoff to succeed after process 2 reclaimed the swap cache
> but before process1 finished its call to swap_page_trans_huge_swapped()?
> 
> --8<-----
> 
> Fixes: 7c00bafee87c ("mm/swap: free swap slots in batch")
> Closes: https://lore.kernel.org/linux-mm/65a66eb9-41f8-4790-8db2-0c70ea15979f@redhat.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
> 
> Applies on top of v6.8-rc6 and mm-unstable (b38c34939fe4).
> 
> Thanks,
> Ryan
> 
>   mm/swapfile.c | 14 +++++++++++---
>   1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 2b3a2d85e350..f580e6abc674 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1281,7 +1281,9 @@ struct swap_info_struct *get_swap_device(swp_entry_t entry)
>   	smp_rmb();
>   	offset = swp_offset(entry);
>   	if (offset >= si->max)
> -		goto put_out;
> +		goto bad_offset;
> +	if (data_race(!si->swap_map[swp_offset(entry)]))
> +		goto bad_free;
> 
>   	return si;
>   bad_nofile:
> @@ -1289,9 +1291,14 @@ struct swap_info_struct *get_swap_device(swp_entry_t entry)
>   out:
>   	return NULL;
>   put_out:
> -	pr_err("%s: %s%08lx\n", __func__, Bad_offset, entry.val);
>   	percpu_ref_put(&si->users);
>   	return NULL;
> +bad_offset:
> +	pr_err("%s: %s%08lx\n", __func__, Bad_offset, entry.val);
> +	goto put_out;
> +bad_free:
> +	pr_err("%s: %s%08lx\n", __func__, Unused_offset, entry.val);
> +	goto put_out;
>   }
> 
>   static unsigned char __swap_entry_free(struct swap_info_struct *p,
> @@ -1609,13 +1616,14 @@ int free_swap_and_cache(swp_entry_t entry)
>   	if (non_swap_entry(entry))
>   		return 1;
> 
> -	p = _swap_info_get(entry);
> +	p = get_swap_device(entry);
>   	if (p) {
>   		count = __swap_entry_free(p, entry);
>   		if (count == SWAP_HAS_CACHE &&
>   		    !swap_page_trans_huge_swapped(p, entry))
>   			__try_to_reclaim_swap(p, swp_offset(entry),
>   					      TTRS_UNMAPPED | TTRS_FULL);
> +		put_swap_device(p);
>   	}
>   	return p != NULL;
>   }
> --
> 2.25.1
> 

LGTM

Are you planning on sending a doc extension for get_swap_device()?

-- 
Cheers,

David / dhildenb


