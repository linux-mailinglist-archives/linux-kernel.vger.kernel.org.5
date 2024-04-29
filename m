Return-Path: <linux-kernel+bounces-162858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C01408B6165
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 20:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95C631C216E5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1314513AA39;
	Mon, 29 Apr 2024 18:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QTutc7YL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94028612C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 18:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714416600; cv=none; b=pJyvIpNBmpfE3OmYbkKnkgmVcUmX/DF2kMYgD09/V8ijaOI0FX9FdJXb1MW0BKgEWIFrLzJ+KhmX3hZlxE6BcWDtkXuCTdPHgKUDV6QU37awUHFrD8euZ7KFX6wAl1SAGMtx4wM+kpNRsUhKLsu4tORO1HZRn27HQ1BklenjSLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714416600; c=relaxed/simple;
	bh=ibS47OzWKnXsrz/clEM8WXST7kYkQMIbx8DG7ht8SUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AS+J/0Dd1SoUBb0zb79XGurjeUTrEopk6uAP6igKyrZ8OFqmCUZMSYnq0/S6jOwvGfdsqGrPyBSl9uQRLOtPnkBzuBZfuckKO3bsuRyP1LNCBk0QkoIBZSHUhyIn0SUyl6wQXKohSYUjuKCxw7uOPX5/r+4PrsRQPreJ7q3weM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QTutc7YL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714416597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Cri9wJQIMuiWfyMRh8o3fAPmxNnbcSXNHzgldLoV4IA=;
	b=QTutc7YLNxDFNsau/LrdsHstlafTm1b2N82LLSITfQlh0Hlx3M/phzOzkU7gUm+QrnTu4A
	VTGaqYVuvA7JSxao5jGAaAsfdAVz5Gh6erxQwgzAho0V2MDo57j/8bjkXB/3ZhNDu658lk
	CyWK/U7MKg0LJUR4JkRTxXkR8S3OHNc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-dHysN8hhN5iMnRHMyZLOWQ-1; Mon, 29 Apr 2024 14:49:54 -0400
X-MC-Unique: dHysN8hhN5iMnRHMyZLOWQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-41c025915a9so9460205e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 11:49:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714416593; x=1715021393;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cri9wJQIMuiWfyMRh8o3fAPmxNnbcSXNHzgldLoV4IA=;
        b=oc08RmXuMzt8sXKhIBdQbmxXgZCS09ZVYJDmJVEs/lsBEao8+KCpj3NfI/XSHt9wFU
         NDAvtLnJ+jrLdXKvCU09+yB3sqeTD2vwbtMMfccVZtAU+PSXXdaL11HCyxeRF3id4c1h
         jFH38Zez8OGPZxr0z8IEFLDgqjtkrroJXgiWeSvkwhjHerCn13hz03Mevz256mmC77d1
         FALJh01Q/Lm3o9fmVtNVIZ9WHUGw7oY7bjg9LmvHVCNoa8EO4fmh7bM0Z0xe9yBhIjM7
         UKMuW26kkWxtVBxnKd0Qv6mb/QvQxhM0/bDTf/HKZ4csvT+YKB8DGg5z0HNXI+2rfb+6
         Gtbw==
X-Forwarded-Encrypted: i=1; AJvYcCVXLv7hnNhJWorBGU1Wbw/w4s1hc6f6V2DB0LaGl2+shinSLCKM2WwgZrSd7x0VAztnIBQMOE2aCkdc8v9JKskGSWRAtZNSO6a1xxID
X-Gm-Message-State: AOJu0YwAx9CP6/P3h2siiY/tnRaQWoQrx+h2WV2C7u1kwLzt2NHgpihU
	U4B02uC02y5aM8RzoUWKmCBnJ9H+SzL70L4Aok/YpgvptCH55zsW5YZ4J0A0mIhKabE1D7cAoSM
	qLyRfA7hNykipksYyt2BbzC6mVqACbH1jt+btTUqAcWz9u/PjENuvjkZ/L0bRYw==
X-Received: by 2002:a05:600c:46ce:b0:41c:2313:da92 with SMTP id q14-20020a05600c46ce00b0041c2313da92mr3567509wmo.4.1714416593041;
        Mon, 29 Apr 2024 11:49:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkkesKdP7YY8chM377hZx4GvhLIFpBn1K2lrDyPtS5lNinYq8rzhwIkb7IwxxwcLnNiSC0Rg==
X-Received: by 2002:a05:600c:46ce:b0:41c:2313:da92 with SMTP id q14-20020a05600c46ce00b0041c2313da92mr3567486wmo.4.1714416592241;
        Mon, 29 Apr 2024 11:49:52 -0700 (PDT)
Received: from redhat.com ([2a02:14f:174:67cc:7d0:12ee:4f8f:484f])
        by smtp.gmail.com with ESMTPSA id y7-20020a5d6207000000b00346f9071405sm30250181wru.21.2024.04.29.11.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 11:49:51 -0700 (PDT)
Date: Mon, 29 Apr 2024 14:49:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	jasowang@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH v2 4/4] vhost: Reformat vhost_{get, put}_user()
Message-ID: <20240429144908-mutt-send-email-mst@kernel.org>
References: <20240429101400.617007-1-gshan@redhat.com>
 <20240429101400.617007-5-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429101400.617007-5-gshan@redhat.com>

On Mon, Apr 29, 2024 at 08:14:00PM +1000, Gavin Shan wrote:
> Reformat the macros to use tab as the terminator for each line so
> that it looks clean.
> 
> No functional change intended.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>

Just messes up history for no real gain.

> ---
>  drivers/vhost/vhost.c | 60 +++++++++++++++++++++----------------------
>  1 file changed, 30 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 4ddb9ec2fe46..c1ed5e750521 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -1207,21 +1207,22 @@ static inline void __user *__vhost_get_user(struct vhost_virtqueue *vq,
>  	return __vhost_get_user_slow(vq, addr, size, type);
>  }
>  
> -#define vhost_put_user(vq, x, ptr)		\
> -({ \
> -	int ret; \
> -	if (!vq->iotlb) { \
> -		ret = __put_user(x, ptr); \
> -	} else { \
> -		__typeof__(ptr) to = \
> +#define vhost_put_user(vq, x, ptr)					\
> +({									\
> +	int ret;							\
> +	if (!vq->iotlb) {						\
> +		ret = __put_user(x, ptr);				\
> +	} else {							\
> +		__typeof__(ptr) to =					\
>  			(__typeof__(ptr)) __vhost_get_user(vq, ptr,	\
> -					  sizeof(*ptr), VHOST_ADDR_USED); \
> -		if (to != NULL) \
> -			ret = __put_user(x, to); \
> -		else \
> -			ret = -EFAULT;	\
> -	} \
> -	ret; \
> +						sizeof(*ptr),		\
> +						VHOST_ADDR_USED);	\
> +		if (to != NULL)						\
> +			ret = __put_user(x, to);			\
> +		else							\
> +			ret = -EFAULT;					\
> +	}								\
> +	ret;								\
>  })
>  
>  static inline int vhost_put_avail_event(struct vhost_virtqueue *vq)
> @@ -1252,22 +1253,21 @@ static inline int vhost_put_used_idx(struct vhost_virtqueue *vq)
>  			      &vq->used->idx);
>  }
>  
> -#define vhost_get_user(vq, x, ptr, type)		\
> -({ \
> -	int ret; \
> -	if (!vq->iotlb) { \
> -		ret = __get_user(x, ptr); \
> -	} else { \
> -		__typeof__(ptr) from = \
> -			(__typeof__(ptr)) __vhost_get_user(vq, ptr, \
> -							   sizeof(*ptr), \
> -							   type); \
> -		if (from != NULL) \
> -			ret = __get_user(x, from); \
> -		else \
> -			ret = -EFAULT; \
> -	} \
> -	ret; \
> +#define vhost_get_user(vq, x, ptr, type)				\
> +({									\
> +	int ret;							\
> +	if (!vq->iotlb) {						\
> +		ret = __get_user(x, ptr);				\
> +	} else {							\
> +		__typeof__(ptr) from =					\
> +			(__typeof__(ptr)) __vhost_get_user(vq, ptr,	\
> +						sizeof(*ptr), type);	\
> +		if (from != NULL)					\
> +			ret = __get_user(x, from);			\
> +		else							\
> +			ret = -EFAULT;					\
> +	}								\
> +	ret;								\
>  })
>  
>  #define vhost_get_avail(vq, x, ptr) \
> -- 
> 2.44.0


