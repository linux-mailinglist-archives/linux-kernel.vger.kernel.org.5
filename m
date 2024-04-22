Return-Path: <linux-kernel+bounces-153039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E88458AC831
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FC9328393D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B850251C5F;
	Mon, 22 Apr 2024 08:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FM7YK9UR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F46C23A9
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 08:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713776311; cv=none; b=BUzro72THCZeTmvcgWyFBYW+KLoQPSLoPVUmEzHr+e4oMP7uBNmk5L2mTFSAFVmVXI2b5QqIN81+/G3DD8E68WEisLwShv4pB/mqQHRMgFW2W04cJlPGv8jLA/BX/MkYjRSnmCQKIPEW0ik7HQ9PGtotGKOzEYJoWEY0L9HJ3fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713776311; c=relaxed/simple;
	bh=gVwCH2r6/wSj8nNUi41yXnZY3OdmR9b7KNvzuSL9jDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BBcZyFzEUeIVhTA8gT3siIzw6MPSGkcjydFdhapiMhCMxYan5CXzE4zejeF/qOfxGwo36gItWpjLEi64KsRIwdDNbbwIXNkNvyTleKUm97hGvvdMk/IK0eiwpoPWzRWQsHacUthIddjGw6jtPm6XmiFcFKrWNDP8UjPHhQ4MLI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FM7YK9UR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713776307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QD7iRawZyTFIvjusEWyW4L845dvTHcZHV/ye2ilyQhw=;
	b=FM7YK9UREgsgjagAFAQr4UzCwdqp4eKE9y4Zy13fseZafQguEjd2045ste0PomoUx5QZeK
	q2B0T6GHJwbb3ScLbcMJ1OTOo0cwTUx0v7WdUSKZimZs0eNZpGXWQgxsILpeABn4s5A8tV
	mjaHSkOEPq6Wnx3QIvxJXMoaLx2I+4I=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-qQJXB6h0MkOaWGM1rusVow-1; Mon, 22 Apr 2024 04:58:25 -0400
X-MC-Unique: qQJXB6h0MkOaWGM1rusVow-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-343e46df264so2892152f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 01:58:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713776304; x=1714381104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QD7iRawZyTFIvjusEWyW4L845dvTHcZHV/ye2ilyQhw=;
        b=dBW/LBY12JsMmCNIVyxXRlszPKsrWoUeNu64pFwOsVmqbkmdF0PSbNjCOmGmbGQyGY
         ag1aUDDGLzvKO6dqqX5krx0VCewE/MXsWWxwIgvYXSsDNMRrw8loWsti7ND+IycTBvvA
         5PFQ9teC1WmkeoahqqAw0DzH6ji4wPmC1rCXDYe5KTHzWpSX7y+GUm5jrl/zhrNR7Kwy
         yqnkhiP9FQRik5tl5Tvpqb5UXQmjZODgkeE8l/QqlFlJG4HbOMY4DhSmtkwOYNtKjT0L
         uuiyYsEMHosHVY0yHaquuRnHJutvzDV3II6pcprsy5I9UC6GkgThp2mHmxsHU8bLXiMO
         dEvw==
X-Gm-Message-State: AOJu0YwaU3ouNU+UreIcFtgorEu0bP021/loZlyu54XnBVrPl9yFwpzB
	DuMjWjX+cMynGKnb2TAVTome1ZaFLDx/WSuQXMyFzZ7mrTqNWnymGW3Y9CLbSybyBCSOoTvpwLl
	qWP8qjOmeqPWUAJdaeA3ZAlxHvCN5W5tzdHKTSzf4y3Wupr7h5LazpBb1wSZ/mw==
X-Received: by 2002:a5d:6991:0:b0:34a:2a90:c45 with SMTP id g17-20020a5d6991000000b0034a2a900c45mr6673365wru.31.1713776304432;
        Mon, 22 Apr 2024 01:58:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJWXJnyNZas+WvMPjlNqBM0s//s3DLYCnkbxPHoJE4uXiiTGHjbnyPXkL4hkVSoUsd66znuQ==
X-Received: by 2002:a5d:6991:0:b0:34a:2a90:c45 with SMTP id g17-20020a5d6991000000b0034a2a900c45mr6673338wru.31.1713776303856;
        Mon, 22 Apr 2024 01:58:23 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7429:3c00:dc4a:cd5:7b1c:f7c2])
        by smtp.gmail.com with ESMTPSA id y18-20020a056000109200b00343300a4eb8sm10492124wrw.49.2024.04.22.01.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 01:58:23 -0700 (PDT)
Date: Mon, 22 Apr 2024 04:58:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: zhenwei pi <pizhenwei@bytedance.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	virtualization@lists.linux.dev, david@redhat.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	akpm@linux-foundation.org
Subject: Re: [PATCH v2 1/4] virtio_balloon: separate vm events into a function
Message-ID: <20240422045442-mutt-send-email-mst@kernel.org>
References: <20240422074254.1440457-1-pizhenwei@bytedance.com>
 <20240422074254.1440457-2-pizhenwei@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422074254.1440457-2-pizhenwei@bytedance.com>

On Mon, Apr 22, 2024 at 03:42:51PM +0800, zhenwei pi wrote:
> All the VM events related statistics have dependence on
> 'CONFIG_VM_EVENT_COUNTERS', once any stack variable is required by any
> VM events in future, we would have codes like:
>  #ifdef CONFIG_VM_EVENT_COUNTERS
>       unsigned long foo;
>  #endif
>       ...
>  #ifdef CONFIG_VM_EVENT_COUNTERS
>       foo = events[XXX] + events[YYY];
>       update_stat(vb, idx++, VIRTIO_BALLOON_S_XXX, foo);
>  #endif
> 
> Separate vm events into a single function, also remove
> 'CONFIG_VM_EVENT_COUNTERS' from 'update_balloon_stats'.
> 
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>  drivers/virtio/virtio_balloon.c | 44 ++++++++++++++++++++++-----------
>  1 file changed, 29 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 1f5b3dd31fcf..59fe157e5722 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -316,34 +316,48 @@ static inline void update_stat(struct virtio_balloon *vb, int idx,
>  
>  #define pages_to_bytes(x) ((u64)(x) << PAGE_SHIFT)
>  
> -static unsigned int update_balloon_stats(struct virtio_balloon *vb)
> +/* Return the number of entries filled by vm events */
> +static inline unsigned int update_balloon_vm_stats(struct virtio_balloon *vb,
> +						   unsigned int start)
>  {
> +#ifdef CONFIG_VM_EVENT_COUNTERS
>  	unsigned long events[NR_VM_EVENT_ITEMS];
> -	struct sysinfo i;
> -	unsigned int idx = 0;
> -	long available;
> -	unsigned long caches;
> +	unsigned int idx = start;
>  
>  	all_vm_events(events);
> -	si_meminfo(&i);
> -
> -	available = si_mem_available();
> -	caches = global_node_page_state(NR_FILE_PAGES);
> -
> -#ifdef CONFIG_VM_EVENT_COUNTERS
>  	update_stat(vb, idx++, VIRTIO_BALLOON_S_SWAP_IN,
> -				pages_to_bytes(events[PSWPIN]));
> +		    pages_to_bytes(events[PSWPIN]));
>  	update_stat(vb, idx++, VIRTIO_BALLOON_S_SWAP_OUT,
> -				pages_to_bytes(events[PSWPOUT]));
> +		    pages_to_bytes(events[PSWPOUT]));
>  	update_stat(vb, idx++, VIRTIO_BALLOON_S_MAJFLT, events[PGMAJFAULT]);
>  	update_stat(vb, idx++, VIRTIO_BALLOON_S_MINFLT, events[PGFAULT]);
> +
>  #ifdef CONFIG_HUGETLB_PAGE
>  	update_stat(vb, idx++, VIRTIO_BALLOON_S_HTLB_PGALLOC,
>  		    events[HTLB_BUDDY_PGALLOC]);
>  	update_stat(vb, idx++, VIRTIO_BALLOON_S_HTLB_PGFAIL,
>  		    events[HTLB_BUDDY_PGALLOC_FAIL]);
> -#endif
> -#endif
> +#endif /* CONFIG_HUGETLB_PAGE */
> +
> +	return idx - start;
> +#else /* CONFIG_VM_EVENT_COUNTERS */
> +
> +	return 0;
> +#endif /* CONFIG_VM_EVENT_COUNTERS */
> +}
> +

Generally the preferred style is this:

#ifdef .....

static inline unsigned int update_balloon_vm_stats(struct virtio_balloon *vb,
						   unsigned int start)
{
	....
}

#else /* CONFIG_VM_EVENT_COUNTERS */

static inline unsigned int update_balloon_vm_stats(struct virtio_balloon *vb,
						   unsigned int start)
{
	return 0;
}

#endif

however given it was a spaghetti of ifdefs even before that,
the patch's ok I think.


> +static unsigned int update_balloon_stats(struct virtio_balloon *vb)
> +{
> +	struct sysinfo i;
> +	unsigned int idx = 0;
> +	long available;
> +	unsigned long caches;
> +
> +	idx += update_balloon_vm_stats(vb, idx);
> +
> +	si_meminfo(&i);
> +	available = si_mem_available();
> +	caches = global_node_page_state(NR_FILE_PAGES);
>  	update_stat(vb, idx++, VIRTIO_BALLOON_S_MEMFREE,
>  				pages_to_bytes(i.freeram));
>  	update_stat(vb, idx++, VIRTIO_BALLOON_S_MEMTOT,
> -- 
> 2.34.1


