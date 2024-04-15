Return-Path: <linux-kernel+bounces-145424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C948A55FC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EBAA282DAC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F957602A;
	Mon, 15 Apr 2024 15:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AVjO6klC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FD81D524
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 15:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713193589; cv=none; b=MrDD8blqCDjrf7pE1HnJkdPF650RwNqEjC+LGlIDqHpRTphXnxhB4WiRkDgqPpNIiZjyqpqMnukbO7Q83xykGmcdUaxnyqbZSxA4aDs5Zt0cTwRn07wfRh3s0yk9rNuKhUuX8tj++j1D8CsvwPBGmUM8nyWVojquJJsqOW1CHvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713193589; c=relaxed/simple;
	bh=2lr3ebABi+mdEealoy0sxdcQeBaTFXrm5m0MkbKRz9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pRJGYWif/RfDFxyCAs2S/XsbfOBNEIM2NjD2SzoVwSf2OW6gMRWu13rNnqZNKLBnAaj8Z2S/nmSBbNAZKbl7LNlHH3ksYKzKHS985nDkF1YVJncj7G/o8GncLt2HNKEUYoWP8n3czrd0m8ON14aE+BcwH7cIVN51HoLwIg6Kbbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AVjO6klC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713193584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=SWMgTI6choihLIiQqxi4W/di2i0okUpqfQyANhD1YlM=;
	b=AVjO6klC2zjo7eCSDfqEes513NydNr8qrYjT/SBggElkFefYWLRLNCfprWfKU9P47Xwnwl
	5RQJkCqH8wHrNm7M4hrR5ipEGBuvenhA4Yy/5xyL4rFjOd+l8v/+lK11jI3IwZq8HRuc1j
	/FlcFL45P4K26FpLGsm/lGx1ayNydzc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-xfyiubyqPrSoEEW437y3zA-1; Mon, 15 Apr 2024 11:06:23 -0400
X-MC-Unique: xfyiubyqPrSoEEW437y3zA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-346b8ef7e10so1762442f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 08:06:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713193582; x=1713798382;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SWMgTI6choihLIiQqxi4W/di2i0okUpqfQyANhD1YlM=;
        b=WCxQHKaZPpl/Y5Z3Gcm41YaEj2teS2hIcZ8HStsugqcl1Kj5gPa+lUyjNcrjczz5Qv
         iveNu8YkXhdkUVVzpod1wQxSaQBw7M4U6KC2fOySoAdXRbz6UITB8R83L2oE9HlxRSJP
         WfuSEMQYk60Uocf2h+8l0HGlvIf1ZI2TxCPD4mraqjV+SWqXOo+Ncpt6Oosm3mRNF5CO
         hGDBqA78I6lGPqBqyiepxgCL5Umfm/Hrq5xUKqOM/l2B5ielh7sXaVReZ0od3P0+o+nh
         PsDT7iQoPmiZFo2aO81Q1NnpMxq9X9n7yuaPtyGJ80d8UWg6bJbMeGk9jgLdxUT0oVr5
         HQIw==
X-Forwarded-Encrypted: i=1; AJvYcCVzi7E0OcPbsmXc+d8RIh4PnbX1s2fY+3nWa1tbcUMTcUKXm2YXkbxc1xcQpSLEQQvRj0GXxPfxM/gl/e0qnMAZnQOyUrZssSGg9dum
X-Gm-Message-State: AOJu0YwJ6IKjL6WPBsjOk+CAwXJUriziSq2jZ+bqWzG+fmLe/9saqJ8m
	5t+IJZHCJ4C/14vO9TabASHSawpYgJIu2pb7iZPgTocJCmh3DSfUw0ShVowQKR4EfUclXznHXDN
	y9K9ca9mfmQ/fRy+djcnFqaIihQgppmOHte8MHG8bfR/kb6/0jFnjskdUQukpBAhBxYXH0w==
X-Received: by 2002:adf:c086:0:b0:346:b79c:b1ee with SMTP id d6-20020adfc086000000b00346b79cb1eemr7359575wrf.44.1713193581824;
        Mon, 15 Apr 2024 08:06:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3IpHGX4eBvaap7cR+1gBUBPyeuaceWkZ5RyrQBFH8pySWHVwiaycuCHDvCmsZ1kwulqhBhA==
X-Received: by 2002:adf:c086:0:b0:346:b79c:b1ee with SMTP id d6-20020adfc086000000b00346b79cb1eemr7359553wrf.44.1713193581396;
        Mon, 15 Apr 2024 08:06:21 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:d800:568a:6ea7:5272:797c? (p200300cbc706d800568a6ea75272797c.dip0.t-ipconnect.de. [2003:cb:c706:d800:568a:6ea7:5272:797c])
        by smtp.gmail.com with ESMTPSA id q3-20020adfb183000000b00343cad2a4d3sm12481436wra.18.2024.04.15.08.06.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 08:06:21 -0700 (PDT)
Message-ID: <e34fc532-a1a5-4012-b3e2-8baa93e27e86@redhat.com>
Date: Mon, 15 Apr 2024 17:06:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 3/3] virtio_balloon: introduce memory scan/reclaim info
To: zhenwei pi <pizhenwei@bytedance.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, virtualization@lists.linux.dev
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 akpm@linux-foundation.org
References: <20240415084113.1203428-1-pizhenwei@bytedance.com>
 <20240415084113.1203428-4-pizhenwei@bytedance.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240415084113.1203428-4-pizhenwei@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.04.24 10:41, zhenwei pi wrote:
> Expose memory scan/reclaim information to the host side via virtio
> balloon device.
> 
> Now we have a metric to analyze the memory performance:
> 
> y: counter increases
> n: counter does not changes
> h: the rate of counter change is high
> l: the rate of counter change is low
> 
> OOM: VIRTIO_BALLOON_S_OOM_KILL
> STALL: VIRTIO_BALLOON_S_ALLOC_STALL
> ASCAN: VIRTIO_BALLOON_S_SCAN_ASYNC
> DSCAN: VIRTIO_BALLOON_S_SCAN_DIRECT
> ARCLM: VIRTIO_BALLOON_S_RECLAIM_ASYNC
> DRCLM: VIRTIO_BALLOON_S_RECLAIM_DIRECT
> 
> - OOM[y], STALL[*], ASCAN[*], DSCAN[*], ARCLM[*], DRCLM[*]:
>    the guest runs under really critial memory pressure
> 
> - OOM[n], STALL[h], ASCAN[*], DSCAN[l], ARCLM[*], DRCLM[l]:
>    the memory allocation stalls due to cgroup, not the global memory
>    pressure.
> 
> - OOM[n], STALL[h], ASCAN[*], DSCAN[h], ARCLM[*], DRCLM[h]:
>    the memory allocation stalls due to global memory pressure. The
>    performance gets hurt a lot. A high ratio between DRCLM/DSCAN shows
>    quite effective memory reclaiming.
> 
> - OOM[n], STALL[h], ASCAN[*], DSCAN[h], ARCLM[*], DRCLM[l]:
>    the memory allocation stalls due to global memory pressure.
>    the ratio between DRCLM/DSCAN gets low, the guest OS is thrashing
>    heavily, the serious case leads poor performance and difficult
>    trouble shooting. Ex, sshd may block on memory allocation when
>    accepting new connections, a user can't login a VM by ssh command.
> 
> - OOM[n], STALL[n], ASCAN[h], DSCAN[n], ARCLM[l], DRCLM[n]:
>    the low ratio between ARCLM/ASCAN shows that the guest tries to
>    reclaim more memory, but it can't. Once more memory is required in
>    future, it will struggle to reclaim memory.
> 
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>   drivers/virtio/virtio_balloon.c     |  9 +++++++++
>   include/uapi/linux/virtio_balloon.h | 12 ++++++++++--
>   2 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 4b9c9569f6e5..7b86514e99d4 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -372,6 +372,15 @@ static unsigned int update_balloon_stats(struct virtio_balloon *vb)
>   	stall += events[ALLOCSTALL_MOVABLE];
>   	update_stat(vb, idx++, VIRTIO_BALLOON_S_ALLOC_STALL, stall);
>   
> +	update_stat(vb, idx++, VIRTIO_BALLOON_S_SCAN_ASYNC,
> +				pages_to_bytes(events[PGSCAN_KSWAPD]));
> +	update_stat(vb, idx++, VIRTIO_BALLOON_S_SCAN_DIRECT,
> +				pages_to_bytes(events[PGSCAN_DIRECT]));
> +	update_stat(vb, idx++, VIRTIO_BALLOON_S_RECLAIM_ASYNC,
> +				pages_to_bytes(events[PGSTEAL_KSWAPD]));
> +	update_stat(vb, idx++, VIRTIO_BALLOON_S_RECLAIM_DIRECT,
> +				pages_to_bytes(events[PGSTEAL_DIRECT]));
> +
>   	return idx;
>   }
>   
> diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
> index 13d0c32ba27c..0875a9cccb01 100644
> --- a/include/uapi/linux/virtio_balloon.h
> +++ b/include/uapi/linux/virtio_balloon.h
> @@ -73,7 +73,11 @@ struct virtio_balloon_config {
>   #define VIRTIO_BALLOON_S_HTLB_PGFAIL   9  /* Hugetlb page allocation failures */
>   #define VIRTIO_BALLOON_S_OOM_KILL      10 /* OOM killer invocations */
>   #define VIRTIO_BALLOON_S_ALLOC_STALL   11 /* Stall count of memory allocatoin */
> -#define VIRTIO_BALLOON_S_NR       12
> +#define VIRTIO_BALLOON_S_SCAN_ASYNC    12 /* Amount of memory scanned asynchronously */
> +#define VIRTIO_BALLOON_S_SCAN_DIRECT   13 /* Amount of memory scanned directly */
> +#define VIRTIO_BALLOON_S_RECLAIM_ASYNC 14 /* Amount of memory reclaimed asynchronously */
> +#define VIRTIO_BALLOON_S_RECLAIM_DIRECT 15 /* Amount of memory reclaimed directly */

Should these be the other way around:

ASYN_SCAN
..
ASYNC_RECLAIM

so we can get ...

> +#define VIRTIO_BALLOON_S_NR       16
>   
>   #define VIRTIO_BALLOON_S_NAMES_WITH_PREFIX(VIRTIO_BALLOON_S_NAMES_prefix) { \
>   	VIRTIO_BALLOON_S_NAMES_prefix "swap-in", \
> @@ -87,7 +91,11 @@ struct virtio_balloon_config {
>   	VIRTIO_BALLOON_S_NAMES_prefix "hugetlb-allocations", \
>   	VIRTIO_BALLOON_S_NAMES_prefix "hugetlb-failures", \
>   	VIRTIO_BALLOON_S_NAMES_prefix "oom-kill", \
> -	VIRTIO_BALLOON_S_NAMES_prefix "alloc-stall" \
> +	VIRTIO_BALLOON_S_NAMES_prefix "alloc-stall", \
> +	VIRTIO_BALLOON_S_NAMES_prefix "scan-async", \
> +	VIRTIO_BALLOON_S_NAMES_prefix "scan-direct", \
> +	VIRTIO_BALLOON_S_NAMES_prefix "reclaim-async", \
> +	VIRTIO_BALLOON_S_NAMES_prefix "reclaim-direct" \

..

"async-scans", "async-reclaims" ...

-- 
Cheers,

David / dhildenb


