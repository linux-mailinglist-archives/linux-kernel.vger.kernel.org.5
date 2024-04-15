Return-Path: <linux-kernel+bounces-145421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8EE8A55F7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CF0E1F23037
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A92D7AE43;
	Mon, 15 Apr 2024 15:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MAX99x6z"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C10757FC
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 15:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713193503; cv=none; b=DaylsdLXQ364DMEqIZeJs/WmNrGgzPcSHHC9yFXU+G8FL78gmI2g7ArhwKn2dzmulLiOtJq0Q60gujE9waYyfHppJhZmV6imgWJHK55a3PGGImPjznvkNl3K1tLYC5BVwCKtzPqYHX+0+5SxmuzQHOAqvtMVxhtjknl+ATHtduQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713193503; c=relaxed/simple;
	bh=Q6vZXQU1Dps7WNxABJihEtrwW4SStDakJ5cPUNc8dqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QUxY/PJpv13N2ehQkHuQyI96OLJt7Mm+VCmsiXrMXwaFTPqIW5C14GPxhYRO0tU2u1xzdmyfNexLAhoWcen2bUCde2nbTpZg8h+wP7XkFUCqtmYNu5pIAPiOx3OF6r5R0CCZnrZkI8WsUrCK6MAF95tRghEPeKA0puXKZ3WgE+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MAX99x6z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713193498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TF7bkVJrx1aH7MvweFhEZtnv8SR9+bz0TmbKC8c2sKQ=;
	b=MAX99x6z/lrQVBSihC9LNOJ3d0Ug4kHWqadMiqaj4NiWWhPn1IyF8FtwZTzDudKROZcFkG
	JJtMlKF+Uh/BA8vSch7+4+oLtVgSZp8TiqUXfojl8fKpXuB1HrUvxzjj5sxyYNj0UQW0gk
	tVi9sTXZz9XpBkRztiAsWho8uZhPWSg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385--aCgSUFFMcmi2nqYvsrf0g-1; Mon, 15 Apr 2024 11:04:56 -0400
X-MC-Unique: -aCgSUFFMcmi2nqYvsrf0g-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-41663c713b7so21355375e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 08:04:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713193496; x=1713798296;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TF7bkVJrx1aH7MvweFhEZtnv8SR9+bz0TmbKC8c2sKQ=;
        b=E5m9+41rttOqg5+5ldJYL6IfAsZxBx6ljMbr2h773mcnbbewoJKF07wcvx4zHI+ZCh
         TKBzWK5JifEji8KnfvW9XWLqahjnJAj8LNDEmfEEkkfWiwfZe5LyWlpbVCKy6Eya8LNq
         MjIVvzOcEywUCMtq84Vfymb1PlAlEtkrWfMsDZbLxrTQFQTMu3YzxlO1SGsO6JLrMx7J
         lZ77m4N3Uuw7E8+sAv0OR7WevxzYxyzDP9HNDtlaCB9fARpgoe8PD21ows9z7+gBYclw
         eprPblivjQsrWm+ERFLB2VTnHKe3spDniOKOkCUt/DoVA7V4X7G7AHvrJ9Qj/Jh8D0TJ
         KOcg==
X-Forwarded-Encrypted: i=1; AJvYcCVEfb0PbcGLzN0WqIl76TasiNX0oRZWUlKuCl2qSfVjtQH6Bqu+TTwq0+K77myhX9UMbLodEXUcjfu+5l77vR2qnhf7LwBJBTybgbD+
X-Gm-Message-State: AOJu0YwzMZEKq7Q46MBSL6vjOVHqXg77Wg4e35JL3JUdEpayJ380HM3j
	cluN2PZX+3bwPzjysqSSr6BOTGOv8MJfAxL8Els3XqRrd1PQktXJyR7UZRfQxnd43aU0iZAX9q4
	8IIGsZ/FFQ8BrZiN715CdfkIBA07wQS6tBOZ/6WxYSm8e8ws9X3kbPK13foiFFA==
X-Received: by 2002:a05:600c:450d:b0:417:d01a:6d64 with SMTP id t13-20020a05600c450d00b00417d01a6d64mr8797482wmo.5.1713193495759;
        Mon, 15 Apr 2024 08:04:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7BkTxm8FFb16vkwqCrM+M3c0z+jpsn+daUGwUsD7BSMU7IyLfzGd2qrhIDaZwpFSdX8hCZw==
X-Received: by 2002:a05:600c:450d:b0:417:d01a:6d64 with SMTP id t13-20020a05600c450d00b00417d01a6d64mr8797462wmo.5.1713193495484;
        Mon, 15 Apr 2024 08:04:55 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:d800:568a:6ea7:5272:797c? (p200300cbc706d800568a6ea75272797c.dip0.t-ipconnect.de. [2003:cb:c706:d800:568a:6ea7:5272:797c])
        by smtp.gmail.com with ESMTPSA id fc16-20020a05600c525000b00417f65fb982sm13543550wmb.6.2024.04.15.08.04.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 08:04:55 -0700 (PDT)
Message-ID: <3980b722-e45e-41bb-8b6a-afce44b6c3a0@redhat.com>
Date: Mon, 15 Apr 2024 17:04:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/3] virtio_balloon: introduce memory allocation stall
 counter
To: zhenwei pi <pizhenwei@bytedance.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, virtualization@lists.linux.dev
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 akpm@linux-foundation.org
References: <20240415084113.1203428-1-pizhenwei@bytedance.com>
 <20240415084113.1203428-3-pizhenwei@bytedance.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240415084113.1203428-3-pizhenwei@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.04.24 10:41, zhenwei pi wrote:
> Memory allocation stall counter represents the performance/latency of
> memory allocation, expose this counter to the host side by virtio
> balloon device via out-of-bound way.
> 
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>   drivers/virtio/virtio_balloon.c     | 19 ++++++++++++++++++-
>   include/uapi/linux/virtio_balloon.h |  6 ++++--
>   2 files changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index fd8daa742734..4b9c9569f6e5 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -321,7 +321,7 @@ static unsigned int update_balloon_stats(struct virtio_balloon *vb)
>   	unsigned long events[NR_VM_EVENT_ITEMS];
>   	struct sysinfo i;
>   	unsigned int idx = 0;
> -	long available;
> +	long available, stall = 0;
>   	unsigned long caches;
>   
>   	all_vm_events(events);
> @@ -355,6 +355,23 @@ static unsigned int update_balloon_stats(struct virtio_balloon *vb)
>   	update_stat(vb, idx++, VIRTIO_BALLOON_S_OOM_KILL,
>   				events[OOM_KILL]);
>   
> +	/* sum all the stall event */
> +#ifdef CONFIG_ZONE_DMA
> +	stall += events[ALLOCSTALL_DMA];
> +#endif
> +#ifdef CONFIG_ZONE_DMA32
> +	stall += events[ALLOCSTALL_DMA32];
> +#endif
> +#ifdef CONFIG_HIGHMEM
> +	stall += events[ALLOCSTALL_HIGH];
> +#endif
> +#ifdef CONFIG_ZONE_DEVICE
> +	stall += events[ALLOCSTALL_DEVICE];
> +#endif
> +	stall += events[ALLOCSTALL_NORMAL];
> +	stall += events[ALLOCSTALL_MOVABLE];
> +	update_stat(vb, idx++, VIRTIO_BALLOON_S_ALLOC_STALL, stall);
> +
>   	return idx;
>   }
>   
> diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
> index cde5547e64a7..13d0c32ba27c 100644
> --- a/include/uapi/linux/virtio_balloon.h
> +++ b/include/uapi/linux/virtio_balloon.h
> @@ -72,7 +72,8 @@ struct virtio_balloon_config {
>   #define VIRTIO_BALLOON_S_HTLB_PGALLOC  8  /* Hugetlb page allocations */
>   #define VIRTIO_BALLOON_S_HTLB_PGFAIL   9  /* Hugetlb page allocation failures */
>   #define VIRTIO_BALLOON_S_OOM_KILL      10 /* OOM killer invocations */
> -#define VIRTIO_BALLOON_S_NR       11
> +#define VIRTIO_BALLOON_S_ALLOC_STALL   11 /* Stall count of memory allocatoin */
> +#define VIRTIO_BALLOON_S_NR       12
>   
>   #define VIRTIO_BALLOON_S_NAMES_WITH_PREFIX(VIRTIO_BALLOON_S_NAMES_prefix) { \
>   	VIRTIO_BALLOON_S_NAMES_prefix "swap-in", \
> @@ -85,7 +86,8 @@ struct virtio_balloon_config {
>   	VIRTIO_BALLOON_S_NAMES_prefix "disk-caches", \
>   	VIRTIO_BALLOON_S_NAMES_prefix "hugetlb-allocations", \
>   	VIRTIO_BALLOON_S_NAMES_prefix "hugetlb-failures", \
> -	VIRTIO_BALLOON_S_NAMES_prefix "oom-kill" \
> +	VIRTIO_BALLOON_S_NAMES_prefix "oom-kill", \
> +	VIRTIO_BALLOON_S_NAMES_prefix "alloc-stall" \

"alloc-stalls"

-- 
Cheers,

David / dhildenb


