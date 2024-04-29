Return-Path: <linux-kernel+bounces-162842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4BB8B6149
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 20:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E9461C220FF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FEA13AA3A;
	Mon, 29 Apr 2024 18:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bUW/J39b"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB39313AA2D
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 18:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714416303; cv=none; b=r2y5K1P2VsKFNMOE2jcy9gGRsmqbKwZ1TWDykXIh9ogP08y6/4ecipEbAchpg9H6dnkfhKiL5SY69RGFx46D9rRHmihxNzBcgODggPvJ9dgHstpATLIDBlDB5308K77bSmQVPcamCQsXU89xvfltVoi+ewciZRILMMWLZQJOCCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714416303; c=relaxed/simple;
	bh=ThzOjjFdSWcf4ZwGD6I9o/10uRl3uJNw5agA1J54e0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UnFhX9/qsBah/Jat4qZYfMqMuSvg29QVKxio4V0ExmQmxdNhJafCrEhZIzEUoOj2b6oJ9NrJf5CErUwqRGdXEKISlDJdHDiU2NW5zRlOQnjyfgZmGWbPEmWKHfgOOb1PtJFPa6R6IX3I7EqpmXeXQxsYfkMEXgXXoHOVXO7cQfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bUW/J39b; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714416300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mVBzmRd7oU5uOx/EylUSgaYUJMx4L8f+1pEBOrD7+jM=;
	b=bUW/J39bm8b7sW0ut87566ijRUazr/xmS38wmDtXTgp8W043potdZ2/QTc6ZPn/Z37U0YL
	nfGb+z80myrVzK8CtmCeNBkruSO/KVB/HI4oZrNBAiqga5SB3B4X7UPWWwKdAeLkPad4Gt
	nLOgtsQqCBpF8iC5H7FT0eqSsht5KDo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-a4V-Bg2jOn6piqQnDZJwBQ-1; Mon, 29 Apr 2024 14:44:59 -0400
X-MC-Unique: a4V-Bg2jOn6piqQnDZJwBQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-41a38f6e371so21475775e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 11:44:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714416297; x=1715021097;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mVBzmRd7oU5uOx/EylUSgaYUJMx4L8f+1pEBOrD7+jM=;
        b=HFIRmjKS8pj8qtv0rQ80Qy5oBOjG4q0Izl2pX98LdYEsOl1EEJFkwwo11FdC4ShcRS
         OWqtrA/0nG3V5ni3DkT2CXZVxuXDkZlTLGLF9Fm80bF7UJgidJJf37rcZXba86rSoAAO
         noVi1K0VO89HfeE0No8/deb41MB8mnzc0Wsq8fiLCWN+YrK7klWmwJlqCd20NXu9LbQZ
         5AKsL/71S66T5FV6g9Eiu+iUrEf55w5SzhUICqhiYJ55wEhZeuX0LnnpGruMfjaQn73J
         9wtv7FaGLlTGBTEy9e4/mQlBcxeYd6H7woFEBT6Mckn/Ei8vXgXDni3xV+golKWLERek
         yTbg==
X-Forwarded-Encrypted: i=1; AJvYcCUVUtW0aEu2Eqdj27TJ4uU6kDNPpz7YGcdatNvEvIrhskRGkVLa87vR0ESkOga6dL2dKXeRtxkZBGMTHWsF1yU1hrKQ3PAPTuETSy6L
X-Gm-Message-State: AOJu0Yxio8TTAOytkL8cd37iylethwmpeCXZzdNBilFyHsWKZIkOGY+o
	01eKIVf8LBulfI23d2uaVAqhKq6toxvFngW/nq/jAR7zW1mtV1WpCSDAQw44jdEu6dUDTxlv3R8
	7HAbrcPlJyiM3y04q4fkYAQmbmr3mjSJEd6OdzlDZFDGaAQWLETpB2DfRK0ONJQ==
X-Received: by 2002:a05:600c:3507:b0:41c:13f6:206d with SMTP id h7-20020a05600c350700b0041c13f6206dmr4572564wmq.25.1714416296604;
        Mon, 29 Apr 2024 11:44:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuGloXgCYkzrg42at2UQkIWtzVS7rvi7tmkU09K8jMeIEPBTFnAQ1lWfTryCfyH+bMKhVPDw==
X-Received: by 2002:a05:600c:3507:b0:41c:13f6:206d with SMTP id h7-20020a05600c350700b0041c13f6206dmr4572541wmq.25.1714416295949;
        Mon, 29 Apr 2024 11:44:55 -0700 (PDT)
Received: from redhat.com ([2a02:14f:174:67cc:7d0:12ee:4f8f:484f])
        by smtp.gmail.com with ESMTPSA id iv20-20020a05600c549400b00418e4cc9de7sm42184282wmb.7.2024.04.29.11.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 11:44:55 -0700 (PDT)
Date: Mon, 29 Apr 2024 14:44:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	jasowang@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH v2 1/4] vhost: Improve vhost_get_avail_idx() with
 smp_rmb()
Message-ID: <20240429143732-mutt-send-email-mst@kernel.org>
References: <20240429101400.617007-1-gshan@redhat.com>
 <20240429101400.617007-2-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429101400.617007-2-gshan@redhat.com>

On Mon, Apr 29, 2024 at 08:13:57PM +1000, Gavin Shan wrote:
> From: "Michael S. Tsirkin" <mst@redhat.com>
> 
> All the callers of vhost_get_avail_idx() are concerned to the memory

*with* the memory barrier

> barrier, imposed by smp_rmb() to ensure the order of the available
> ring entry read and avail_idx read.
> 
> Improve vhost_get_avail_idx() so that smp_rmb() is executed when
> the avail_idx is advanced.

accessed, not advanced. guest advances it.

> With it, the callers needn't to worry
> about the memory barrier.
> 
> No functional change intended.

I'd add:

As a side benefit, we also validate the index on all paths now, which
will hopefully help catch future errors earlier.

Note: current code is inconsistent in how it handles errors:
some places treat it as an empty ring, others - non empty.
This patch does not attempt to change the existing behaviour.



> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> [gshan: repainted vhost_get_avail_idx()]

?repainted?

> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Acked-by: Will Deacon <will@kernel.org>
> ---
>  drivers/vhost/vhost.c | 106 +++++++++++++++++-------------------------
>  1 file changed, 42 insertions(+), 64 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 8995730ce0bf..7aa623117aab 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -1290,10 +1290,36 @@ static void vhost_dev_unlock_vqs(struct vhost_dev *d)
>  		mutex_unlock(&d->vqs[i]->mutex);
>  }
>  
> -static inline int vhost_get_avail_idx(struct vhost_virtqueue *vq,
> -				      __virtio16 *idx)
> +static inline int vhost_get_avail_idx(struct vhost_virtqueue *vq)
>  {
> -	return vhost_get_avail(vq, *idx, &vq->avail->idx);
> +	__virtio16 idx;
> +	int r;
> +
> +	r = vhost_get_avail(vq, idx, &vq->avail->idx);
> +	if (unlikely(r < 0)) {
> +		vq_err(vq, "Failed to access available index at %p (%d)\n",
> +		       &vq->avail->idx, r);
> +		return r;
> +	}
> +
> +	/* Check it isn't doing very strange thing with available indexes */
> +	vq->avail_idx = vhost16_to_cpu(vq, idx);
> +	if (unlikely((u16)(vq->avail_idx - vq->last_avail_idx) > vq->num)) {
> +		vq_err(vq, "Invalid available index change from %u to %u",
> +		       vq->last_avail_idx, vq->avail_idx);
> +		return -EINVAL;
> +	}
> +
> +	/* We're done if there is nothing new */
> +	if (vq->avail_idx == vq->last_avail_idx)
> +		return 0;
> +
> +	/*
> +	 * We updated vq->avail_idx so we need a memory barrier between
> +	 * the index read above and the caller reading avail ring entries.
> +	 */
> +	smp_rmb();
> +	return 1;
>  }
>  
>  static inline int vhost_get_avail_head(struct vhost_virtqueue *vq,
> @@ -2498,38 +2524,17 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
>  {
>  	struct vring_desc desc;
>  	unsigned int i, head, found = 0;
> -	u16 last_avail_idx;
> -	__virtio16 avail_idx;
> +	u16 last_avail_idx = vq->last_avail_idx;
>  	__virtio16 ring_head;
>  	int ret, access;
>  
> -	/* Check it isn't doing very strange things with descriptor numbers. */
> -	last_avail_idx = vq->last_avail_idx;
> -
>  	if (vq->avail_idx == vq->last_avail_idx) {
> -		if (unlikely(vhost_get_avail_idx(vq, &avail_idx))) {
> -			vq_err(vq, "Failed to access avail idx at %p\n",
> -				&vq->avail->idx);
> -			return -EFAULT;
> -		}
> -		vq->avail_idx = vhost16_to_cpu(vq, avail_idx);
> -
> -		if (unlikely((u16)(vq->avail_idx - last_avail_idx) > vq->num)) {
> -			vq_err(vq, "Guest moved avail index from %u to %u",
> -				last_avail_idx, vq->avail_idx);
> -			return -EFAULT;
> -		}
> +		ret = vhost_get_avail_idx(vq);
> +		if (unlikely(ret < 0))
> +			return ret;
>  
> -		/* If there's nothing new since last we looked, return
> -		 * invalid.
> -		 */
> -		if (vq->avail_idx == last_avail_idx)
> +		if (!ret)
>  			return vq->num;
> -
> -		/* Only get avail ring entries after they have been
> -		 * exposed by guest.
> -		 */
> -		smp_rmb();
>  	}
>  
>  	/* Grab the next descriptor number they're advertising, and increment
> @@ -2790,35 +2795,20 @@ EXPORT_SYMBOL_GPL(vhost_add_used_and_signal_n);
>  /* return true if we're sure that avaiable ring is empty */
>  bool vhost_vq_avail_empty(struct vhost_dev *dev, struct vhost_virtqueue *vq)
>  {
> -	__virtio16 avail_idx;
>  	int r;
>  
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
> -		return false;
> -	}
> -
> -	return true;
> +	/* Treat error as non-empty here */

If you write the comment like that then put it before "return":
that is where you treat an error like this.
And I feel Note: is better in that the comment does not
explain all of what is going on, just an aspect of it.

> +	r = vhost_get_avail_idx(vq);
> +	return r == 0;
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
> @@ -2842,25 +2832,13 @@ bool vhost_enable_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
>  	/* They could have slipped one in as we were doing that: make
>  	 * sure it's written, then check again. */
>  	smp_mb();
> -	r = vhost_get_avail_idx(vq, &avail_idx);
> -	if (r) {
> -		vq_err(vq, "Failed to check avail idx at %p: %d\n",
> -		       &vq->avail->idx, r);
> -		return false;
> -	}
>  
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
> +	/* Treat error as empty here */
> +	r = vhost_get_avail_idx(vq);

If you write the comment like that then put it before "return":
that is where you treat an error like this.
And I feel Note: is better in that the comment does not
explain all of what is going on, just an aspect of it.

> +	if (unlikely(r < 0))
> +		return false;
>  
> -	return false;
> +	return r;
>  }
>  EXPORT_SYMBOL_GPL(vhost_enable_notify);
>  
> -- 
> 2.44.0


