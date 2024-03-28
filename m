Return-Path: <linux-kernel+bounces-122695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3841788FB8B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5986E1C2CE29
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1AB459B71;
	Thu, 28 Mar 2024 09:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ge+l8fJB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68ECC34545
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 09:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711618296; cv=none; b=p6IVqC1pmUdV0YooZ187aqol9rLZbv7H/Kcoo2ZDJpLWqDQ8/5cH5dAQzzOVb05mixVFrNx4BoWz+DUOhN/QPWUIoQP4sf2Gv7o/SaPcvBGnposfy8OhVB7oiGK8K/SHhN6pzIMnqcZPfyn79usWQjfAwLqqGeFpFsR/4Uej9yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711618296; c=relaxed/simple;
	bh=UJN7llSWloOuIDmPUo9y4ITRwT/t6aHkKo6Xb+1KdJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sHBEuiiZ0Q9qXbYN+NB4As44UBh3Bir9tYtCnLBnMt8t57a4nO9IWLqscnNX4Ooin38P5tiGrknAj6Ym/ltu916ZDE9TPDwmqNHbThN3sCo5ZU5bJxwkGdJMghsob/dCsUQ6U8X4yRb97jqN/S/n9LwXLlX9GbgmuYosynJXO6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ge+l8fJB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711618293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ua5EarvvCOybG1jxpRjFw0PAbL97hvnMCO8ki8fQsj4=;
	b=ge+l8fJBp/K4Hi6o4QEMUYAR6Ahc9RZ2IzeLhHUzJMwgLbIOrr4VKz9WQUKUry13lRH4Bh
	UFUHvEhZ2YTlaKmCO+xLf2pE1CyRQljx3qGv5weq36JRU7H4GMP9D9sqLXvu4hab68yZ/U
	bxJkKv2iGhKhSD75Mycqk2YK+z36fhY=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-0kmTZaIhP4C7qBaQgeZM9g-1; Thu, 28 Mar 2024 05:31:31 -0400
X-MC-Unique: 0kmTZaIhP4C7qBaQgeZM9g-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-515c91a7ffdso309753e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 02:31:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711618289; x=1712223089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ua5EarvvCOybG1jxpRjFw0PAbL97hvnMCO8ki8fQsj4=;
        b=WZZuu4n6psBAZ0YbQ6R6JJg3MXFo3SN9ZW3FydnbCryo7XTz8ICnJEUx1usWDGVllD
         YXKiddbWk3BB4BXG7C3npAcClWboYyPw79B6wLFhFtX35e3U6E/Og9e2emFfSOIBtgL2
         VbVk4jCKrPPTJ+2d6KVQOSU0C1LuXUHN4H5Q/2aoJQ7LvU6uGh6id2c2zkddq481yHvK
         KoFIc8FE01gQTg+nI+C4PsyRc01opJeFuyhfaI5EiqK2ahTG0PvQ+hOidWgmk2HcWRLH
         0kGFAYe9oSdF1Nia5HZhZRqTWdSukCGsqncJH/XXkDybYPJn/PIJPU6GbeOl3B/fCtJm
         3S8w==
X-Forwarded-Encrypted: i=1; AJvYcCVv2jOCtWKuRv76E7DTdESaeyo8t4molWgVnbWl/uMbm1n1eAot/U6Ky7pLA5u+kcYa/CxROVs7+DLTUJhqoXcsUnV8+WT24YCLrJ98
X-Gm-Message-State: AOJu0Ywhsog8JdUpKw1TXh6v4AetF7DkS8SQRRs6qCwvFK8LgWJd5guL
	K8Q5G2/GvOBpW41wUNayC9y7dsG2zY74CwapA/XHbGjfjKxNgBYOXvcUuKc8bF0DMMMEkg0fpzb
	8Ai2r5OnSesiVe6e/Dbmd0A4TbEm/jqpfiviRboSJAH+bOaM1bVaFmvKdonl0eA==
X-Received: by 2002:a05:6512:3f05:b0:515:cb05:e749 with SMTP id y5-20020a0565123f0500b00515cb05e749mr654376lfa.12.1711618289493;
        Thu, 28 Mar 2024 02:31:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFisRfWJuhlbFUMvd/32hjjG15wfiARI/XrGWl3eBUrZwU/0XaBazhK4Ry6B5HvV7bfIwjJaQ==
X-Received: by 2002:a05:6512:3f05:b0:515:cb05:e749 with SMTP id y5-20020a0565123f0500b00515cb05e749mr654341lfa.12.1711618288700;
        Thu, 28 Mar 2024 02:31:28 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f0:5969:7af8:be53:dc56:3ccc])
        by smtp.gmail.com with ESMTPSA id gl17-20020a170906e0d100b00a4df6442e69sm524418ejb.152.2024.03.28.02.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 02:31:28 -0700 (PDT)
Date: Thu, 28 Mar 2024 05:31:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	jasowang@redhat.com, will@kernel.org, davem@davemloft.net,
	stefanha@redhat.com, sgarzare@redhat.com, keirf@google.com,
	yihyu@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH v3 3/3] vhost: Improve vhost_get_avail_idx() with
 smp_rmb()
Message-ID: <20240328052814-mutt-send-email-mst@kernel.org>
References: <20240328002149.1141302-1-gshan@redhat.com>
 <20240328002149.1141302-4-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328002149.1141302-4-gshan@redhat.com>

On Thu, Mar 28, 2024 at 10:21:49AM +1000, Gavin Shan wrote:
> All the callers of vhost_get_avail_idx() are concerned to the memory
> barrier, imposed by smp_rmb() to ensure the order of the available
> ring entry read and avail_idx read.
> 
> Improve vhost_get_avail_idx() so that smp_rmb() is executed when
> the avail_idx is advanced. With it, the callers needn't to worry
> about the memory barrier.
> 
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Gavin Shan <gshan@redhat.com>

Previous patches are ok. This one I feel needs more work -
first more code such as sanity checking should go into
this function, second there's actually a difference
between comparing to last_avail_idx and just comparing
to the previous value of avail_idx.
I will pick patches 1-2 and post a cleanup on top so you can
take a look, ok?


> ---
>  drivers/vhost/vhost.c | 75 +++++++++++++++----------------------------
>  1 file changed, 26 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 32686c79c41d..e6882f4f6ce2 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -1290,10 +1290,28 @@ static void vhost_dev_unlock_vqs(struct vhost_dev *d)
>  		mutex_unlock(&d->vqs[i]->mutex);
>  }
>  
> -static inline int vhost_get_avail_idx(struct vhost_virtqueue *vq,
> -				      __virtio16 *idx)
> +static inline int vhost_get_avail_idx(struct vhost_virtqueue *vq)
>  {
> -	return vhost_get_avail(vq, *idx, &vq->avail->idx);
> +	__virtio16 avail_idx;
> +	int r;
> +
> +	r = vhost_get_avail(vq, avail_idx, &vq->avail->idx);
> +	if (unlikely(r)) {
> +		vq_err(vq, "Failed to access avail idx at %p\n",
> +		       &vq->avail->idx);
> +		return r;
> +	}
> +
> +	vq->avail_idx = vhost16_to_cpu(vq, avail_idx);
> +	if (vq->avail_idx != vq->last_avail_idx) {
> +		/* Ensure the available ring entry read happens
> +		 * before the avail_idx read when the avail_idx
> +		 * is advanced.
> +		 */
> +		smp_rmb();
> +	}
> +
> +	return 0;
>  }
>  
>  static inline int vhost_get_avail_head(struct vhost_virtqueue *vq,
> @@ -2499,7 +2517,6 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
>  	struct vring_desc desc;
>  	unsigned int i, head, found = 0;
>  	u16 last_avail_idx;
> -	__virtio16 avail_idx;
>  	__virtio16 ring_head;
>  	int ret, access;
>  
> @@ -2507,12 +2524,8 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
>  	last_avail_idx = vq->last_avail_idx;
>  
>  	if (vq->avail_idx == vq->last_avail_idx) {
> -		if (unlikely(vhost_get_avail_idx(vq, &avail_idx))) {
> -			vq_err(vq, "Failed to access avail idx at %p\n",
> -				&vq->avail->idx);
> +		if (unlikely(vhost_get_avail_idx(vq)))
>  			return -EFAULT;
> -		}
> -		vq->avail_idx = vhost16_to_cpu(vq, avail_idx);
>  
>  		if (unlikely((u16)(vq->avail_idx - last_avail_idx) > vq->num)) {
>  			vq_err(vq, "Guest moved used index from %u to %u",
> @@ -2525,11 +2538,6 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
>  		 */
>  		if (vq->avail_idx == last_avail_idx)
>  			return vq->num;
> -
> -		/* Only get avail ring entries after they have been
> -		 * exposed by guest.
> -		 */
> -		smp_rmb();
>  	}
>  
>  	/* Grab the next descriptor number they're advertising, and increment
> @@ -2790,35 +2798,19 @@ EXPORT_SYMBOL_GPL(vhost_add_used_and_signal_n);
>  /* return true if we're sure that avaiable ring is empty */
>  bool vhost_vq_avail_empty(struct vhost_dev *dev, struct vhost_virtqueue *vq)
>  {
> -	__virtio16 avail_idx;
> -	int r;
> -
>  	if (vq->avail_idx != vq->last_avail_idx)
>  		return false;
>  
> -	r = vhost_get_avail_idx(vq, &avail_idx);
> -	if (unlikely(r))
> -		return false;
> -
> -	vq->avail_idx = vhost16_to_cpu(vq, avail_idx);
> -	if (vq->avail_idx != vq->last_avail_idx) {
> -		/* Since we have updated avail_idx, the following
> -		 * call to vhost_get_vq_desc() will read available
> -		 * ring entries. Make sure that read happens after
> -		 * the avail_idx read.
> -		 */
> -		smp_rmb();
> +	if (unlikely(vhost_get_avail_idx(vq)))
>  		return false;
> -	}
>  
> -	return true;
> +	return vq->avail_idx == vq->last_avail_idx;
>  }
>  EXPORT_SYMBOL_GPL(vhost_vq_avail_empty);
>  
>  /* OK, now we need to know about added descriptors. */
>  bool vhost_enable_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
>  {
> -	__virtio16 avail_idx;
>  	int r;
>  
>  	if (!(vq->used_flags & VRING_USED_F_NO_NOTIFY))
> @@ -2842,25 +2834,10 @@ bool vhost_enable_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
>  	/* They could have slipped one in as we were doing that: make
>  	 * sure it's written, then check again. */
>  	smp_mb();
> -	r = vhost_get_avail_idx(vq, &avail_idx);
> -	if (r) {
> -		vq_err(vq, "Failed to check avail idx at %p: %d\n",
> -		       &vq->avail->idx, r);
> +	if (unlikely(vhost_get_avail_idx(vq)))
>  		return false;
> -	}
> -
> -	vq->avail_idx = vhost16_to_cpu(vq, avail_idx);
> -	if (vq->avail_idx != vq->last_avail_idx) {
> -		/* Since we have updated avail_idx, the following
> -		 * call to vhost_get_vq_desc() will read available
> -		 * ring entries. Make sure that read happens after
> -		 * the avail_idx read.
> -		 */
> -		smp_rmb();
> -		return true;
> -	}
>  
> -	return false;
> +	return vq->avail_idx != vq->last_avail_idx;
>  }
>  EXPORT_SYMBOL_GPL(vhost_enable_notify);
>  
> -- 
> 2.44.0


