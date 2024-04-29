Return-Path: <linux-kernel+bounces-162857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7878B6161
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 20:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EB551F22BD6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3769913440A;
	Mon, 29 Apr 2024 18:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d4Ugv8L6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED90213AD13
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 18:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714416506; cv=none; b=GRMhxSeZVHRxed67Sb91ZCConFVv+uDXzNB/f68s7/a215WvJzxoAmggxcNd+frjKq0MpMjmiHNBSRd3T1hcRV9wDRe0idDzwF/JQKPLeT1Hn2uMKYoB3TtyEoXWlMUAv2H66LcW8FemLZuybmm3uwQsSlV83K0No4CqGwvscbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714416506; c=relaxed/simple;
	bh=eZxtrf9lFLbRYS6FHtj2I3gWxhGJwU4It4fKZYp2ywk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LLAxTWDrcxJYy7MEh2JBDZucAw/qpdUUvUH1NHY+p5gD3cNAUFoPJaMJQkDfnvdTn4y6rm7+BRHgmhsQza2Kgo9lzZb3XU/8nVA0MgYbCWWC3ashL7IXNwLnlkocICol89XnqcI8821uDbriOnnvzf4zzjZWDLaGCj7FHo4I0Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d4Ugv8L6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714416503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RdG84ex/nMZG5ZQdy1/L27yMdIPK+dfGYmnkbYr0h48=;
	b=d4Ugv8L66TYR+YtfvKvtEztPLi+qOAxwbMS91+w0/xreUYCvhlvxoWveEdi0k2+AECUT6F
	bvJKS6X8Do489mypxyorIk3SPRJ0tst5wlHsTx21283ykPs2Z1hxaND8Hq8CLEAuqBn7A1
	17tezJoEtOTbyL77WLlak4lAmHvVyuQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-_92UmVlzOT-rcDMXlL9VdQ-1; Mon, 29 Apr 2024 14:48:21 -0400
X-MC-Unique: _92UmVlzOT-rcDMXlL9VdQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-417c5cc7c96so24019505e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 11:48:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714416500; x=1715021300;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RdG84ex/nMZG5ZQdy1/L27yMdIPK+dfGYmnkbYr0h48=;
        b=e5qY8eZD79rRh8pbXo23sHVyaS+RQ2Xpfa+BKfJdv/Y1HbBVG0xbDOZyYtGgSAXEWL
         aut+HRp/m+vpEVan/CW60Z1s3RfiAEkpeoS8JiJSxnIJV3454Xt9tJ+Qxqvac2lJlS6n
         wNBMYCrHFiNmeS7OqzsRkk2bsnhk0um/lcgnNPx5hAt0n24rpTtlZ8sGFquq0faS7hUp
         5I6y/mra1GGhST95a5lEq9qQr02KCiOCrVGzEueY/NXQTpeyW1xsrUNfhIZB7XZo5nic
         CsQIzyev+KjKEgWVEUU5KXs94KAcHULFRDErz67+QzRSBUGuKHCLv2hfc/8fdEebBnAH
         SOrw==
X-Forwarded-Encrypted: i=1; AJvYcCXBh0ksHGytuqLeJqHKX/zfyp9oCAwON28YGw3QIsnpP05VgR9rPBXhgRXWLNlMk5JI+efrxPGoSF44zUqWP0EyirLZiFyES+LUa4nZ
X-Gm-Message-State: AOJu0Yx2erDNcZeO59jKBSrIRpJMAbNc8kgC/QEezOlsgwE6x7CVXbtT
	NQnEKyjFbJfPygHopYFnDwuA6/4ChEngdpI0Ia7a7ZtNFVZlk2ONvAJGFRd+aXTZEIAqNrKEFfC
	74yngWdApcvbOBOQc4CSvAtVU0KmpacksGb2gD3jJYzUgIChxefsCMiEVwZUN+w==
X-Received: by 2002:a05:600c:510f:b0:41b:f979:e359 with SMTP id o15-20020a05600c510f00b0041bf979e359mr464447wms.38.1714416499971;
        Mon, 29 Apr 2024 11:48:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjtAIlxMm2tBl4L3iWAcVWLXlMihfauuOETtUwmHtI4xqPiyJid/dfBh3OESk5FQcVaWHJNg==
X-Received: by 2002:a05:600c:510f:b0:41b:f979:e359 with SMTP id o15-20020a05600c510f00b0041bf979e359mr464429wms.38.1714416499419;
        Mon, 29 Apr 2024 11:48:19 -0700 (PDT)
Received: from redhat.com ([2a02:14f:174:67cc:7d0:12ee:4f8f:484f])
        by smtp.gmail.com with ESMTPSA id p6-20020a05600c468600b0041563096e15sm46664716wmo.5.2024.04.29.11.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 11:48:19 -0700 (PDT)
Date: Mon, 29 Apr 2024 14:48:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	jasowang@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH v2 3/4] vhost: Improve vhost_get_avail_head()
Message-ID: <20240429144751-mutt-send-email-mst@kernel.org>
References: <20240429101400.617007-1-gshan@redhat.com>
 <20240429101400.617007-4-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429101400.617007-4-gshan@redhat.com>

On Mon, Apr 29, 2024 at 08:13:59PM +1000, Gavin Shan wrote:
> Improve vhost_get_avail_head() so that the head or errno is returned.
> With it, the relevant sanity checks are squeezed to vhost_get_avail_head()
> and vhost_get_vq_desc() is further simplified.
> 
> No functional change intended.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>

I don't see what does this moving code around achieve.

> ---
>  drivers/vhost/vhost.c | 50 ++++++++++++++++++++++---------------------
>  1 file changed, 26 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index b278c0333a66..4ddb9ec2fe46 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -1322,11 +1322,27 @@ static inline int vhost_get_avail_idx(struct vhost_virtqueue *vq)
>  	return 1;
>  }
>  
> -static inline int vhost_get_avail_head(struct vhost_virtqueue *vq,
> -				       __virtio16 *head, int idx)
> +static inline int vhost_get_avail_head(struct vhost_virtqueue *vq)
>  {
> -	return vhost_get_avail(vq, *head,
> -			       &vq->avail->ring[idx & (vq->num - 1)]);
> +	__virtio16 head;
> +	int r;
> +
> +	r = vhost_get_avail(vq, head,
> +			    &vq->avail->ring[vq->last_avail_idx & (vq->num - 1)]);
> +	if (unlikely(r)) {
> +		vq_err(vq, "Failed to read head: index %u address %p\n",
> +		       vq->last_avail_idx,
> +		       &vq->avail->ring[vq->last_avail_idx & (vq->num - 1)]);
> +		return r;
> +	}
> +
> +	r = vhost16_to_cpu(vq, head);
> +	if (unlikely(r >= vq->num)) {
> +		vq_err(vq, "Invalid head %d (%u)\n", r, vq->num);
> +		return -EINVAL;
> +	}
> +
> +	return r;
>  }
>  
>  static inline int vhost_get_avail_flags(struct vhost_virtqueue *vq,
> @@ -2523,9 +2539,8 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
>  		      struct vhost_log *log, unsigned int *log_num)
>  {
>  	struct vring_desc desc;
> -	unsigned int i, head, found = 0;
> -	__virtio16 ring_head;
> -	int ret, access;
> +	unsigned int i, found = 0;
> +	int head, ret, access;
>  
>  	if (vq->avail_idx == vq->last_avail_idx) {
>  		ret = vhost_get_avail_idx(vq);
> @@ -2536,23 +2551,10 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
>  			return vq->num;
>  	}
>  
> -	/* Grab the next descriptor number they're advertising, and increment
> -	 * the index we've seen. */
> -	if (unlikely(vhost_get_avail_head(vq, &ring_head, vq->last_avail_idx))) {
> -		vq_err(vq, "Failed to read head: idx %d address %p\n",
> -		       vq->last_avail_idx,
> -		       &vq->avail->ring[vq->last_avail_idx % vq->num]);
> -		return -EFAULT;
> -	}
> -
> -	head = vhost16_to_cpu(vq, ring_head);
> -
> -	/* If their number is silly, that's an error. */
> -	if (unlikely(head >= vq->num)) {
> -		vq_err(vq, "Guest says index %u > %u is available",
> -		       head, vq->num);
> -		return -EINVAL;
> -	}
> +	/* Grab the next descriptor number they're advertising */
> +	head = vhost_get_avail_head(vq);
> +	if (unlikely(head < 0))
> +		return head;
>  
>  	/* When we start there are none of either input nor output. */
>  	*out_num = *in_num = 0;
> -- 
> 2.44.0


