Return-Path: <linux-kernel+bounces-162845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1AC8B614E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 20:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 079F01C22126
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DB513AA39;
	Mon, 29 Apr 2024 18:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CDJqlr2u"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0212413AA20
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 18:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714416358; cv=none; b=F+M9hyHsmxiQmvID7oHDAvkqy9/05G8JIQCI0zatdKw8rDm5ArtMsmWRCLRn1eJudaaoztAoxcI8NwhEZ9P+xbaj8Nm8De556Lfhr6fx/nQmlL4hmU1fZ0i8egQtqQDBddnBK8C7Thm34pMlU5PEjBjPikBOwFSjRhm0TLuNWUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714416358; c=relaxed/simple;
	bh=mM8kGZlDl8TmBQeU28EZPe8oMDuyPKjLgxjL7cZnPOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qLDVtjAUZoMKwkwdaY+QHH1Yf6Ecbe0JiL8ZvyTrP4u1YtyBFky9iEkG7S9Kh5ctJGv42psn7B2yuh7hq6nb4DUUAd0kREXVs8qcv2hD7bE/fQbuZjP6/JDlLN2S5mqYrrAzXxoqiy7l21ZuJPHmnoGXV8Ia3bkMVmbZK3GC3lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CDJqlr2u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714416355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RX7fwG5JMx7yJ1qmHsffkQfYEsGcSd79VTgyvVoGa6g=;
	b=CDJqlr2u0cnNw9Lau96Gb30Ve4t6m4xI5R04j+/VUpxZ5UwEoA31WDYVI8K8x3zWW/IQce
	BI1oOLr97ippB3agqvGPV5WepAzp1f7yeEmwRGe6fT0sOxkjZbrUvh+JI0X6AvTlHFgF6f
	i17PrPb6Mm6cB6Su3zCNgW5TCGaB20s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-hZcmSckdPey-Y88f-bftoA-1; Mon, 29 Apr 2024 14:45:54 -0400
X-MC-Unique: hZcmSckdPey-Y88f-bftoA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-416ac21981dso25556585e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 11:45:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714416353; x=1715021153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RX7fwG5JMx7yJ1qmHsffkQfYEsGcSd79VTgyvVoGa6g=;
        b=hrOpl2Hd0IHnPNHwx07HQ20Yu/6ZmzKDWEHI5LZxKz+PCogTZN85hEWOSvJP2i3OiB
         fT4M2z00EUWXeZfpq3uje+KagJCA0v70K5fyBue8kQv+AbtmHfG7fDf/gFZi6MTMnGLZ
         7IaXLF0oprg08IZCYKNa4NmQAkJzDzYBeFHmsVOBQT9QrxlppS4pOSAULLnM1gkU5+gF
         QpkN/0ydTpqUXibdZjoW1gLsR70bs6by0S7j40brHNpaHiJt2YTo609P9T+ccS91bCmU
         ZuYB4UK9atfme4JlbdoS3qN8Ie89F5AOvynTt0arwwvaeceOL0I0eLOx1XpcQPR5UTR5
         KGPw==
X-Forwarded-Encrypted: i=1; AJvYcCVTCjGOijCMFzSSYl6Mp2+rYVLYVHWl67RAyP5ivf8umn13TbvdpILK3jKwWvNHpCLU+TWy/NQ3f7GmWjmY8qTC083e68VCd0/KT94s
X-Gm-Message-State: AOJu0Yz0qi2m0ak4TXtEp6pDe0QpMH/HEzPKmYpYxuBODoFSCPhoubdA
	uILC1KeAkFHav78KwL59+P7KoqtWxDcg2JkffsO0xtDy9MSvDaHR1XczYEkrUkY3aRVTLFMuiKa
	2SLBcT6HycAqInQaXq8FgE6A2ISFwKvX8PRiZN9SvYUMfnHrz2DKliMEZYXNytA==
X-Received: by 2002:a05:600c:5103:b0:419:c9e1:70b8 with SMTP id o3-20020a05600c510300b00419c9e170b8mr453031wms.13.1714416352735;
        Mon, 29 Apr 2024 11:45:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9FVC/AcEk5XqomYInW9MvPVrZtDb+VuMkz75ffufEDns29bRVmX3KqOYvbkJBMce36oXIOw==
X-Received: by 2002:a05:600c:5103:b0:419:c9e1:70b8 with SMTP id o3-20020a05600c510300b00419c9e170b8mr453011wms.13.1714416352141;
        Mon, 29 Apr 2024 11:45:52 -0700 (PDT)
Received: from redhat.com ([2a02:14f:174:67cc:7d0:12ee:4f8f:484f])
        by smtp.gmail.com with ESMTPSA id l10-20020a5d410a000000b00343d1d09550sm30195687wrp.60.2024.04.29.11.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 11:45:51 -0700 (PDT)
Date: Mon, 29 Apr 2024 14:45:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	jasowang@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH v2 2/4] vhost: Drop variable last_avail_idx in
 vhost_get_vq_desc()
Message-ID: <20240429144522-mutt-send-email-mst@kernel.org>
References: <20240429101400.617007-1-gshan@redhat.com>
 <20240429101400.617007-3-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429101400.617007-3-gshan@redhat.com>

On Mon, Apr 29, 2024 at 08:13:58PM +1000, Gavin Shan wrote:
> The local variable @last_avail_idx is equivalent to vq->last_avail_idx.
> So the code can be simplified a bit by dropping the local variable
> @last_avail_idx.
> 
> No functional change intended.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  drivers/vhost/vhost.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 7aa623117aab..b278c0333a66 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2524,7 +2524,6 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
>  {
>  	struct vring_desc desc;
>  	unsigned int i, head, found = 0;
> -	u16 last_avail_idx = vq->last_avail_idx;
>  	__virtio16 ring_head;
>  	int ret, access;
>  
> @@ -2539,10 +2538,10 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
>  
>  	/* Grab the next descriptor number they're advertising, and increment
>  	 * the index we've seen. */
> -	if (unlikely(vhost_get_avail_head(vq, &ring_head, last_avail_idx))) {
> +	if (unlikely(vhost_get_avail_head(vq, &ring_head, vq->last_avail_idx))) {
>  		vq_err(vq, "Failed to read head: idx %d address %p\n",
> -		       last_avail_idx,
> -		       &vq->avail->ring[last_avail_idx % vq->num]);
> +		       vq->last_avail_idx,
> +		       &vq->avail->ring[vq->last_avail_idx % vq->num]);
>  		return -EFAULT;
>  	}

I don't see the big advantage and the line is long now.

>  
> -- 
> 2.44.0


