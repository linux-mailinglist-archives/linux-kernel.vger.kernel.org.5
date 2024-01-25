Return-Path: <linux-kernel+bounces-39248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CCE83CD74
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83C4C1F25043
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 20:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968B31386CB;
	Thu, 25 Jan 2024 20:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="PcCNcmnp"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9EF137C57
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 20:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706214638; cv=none; b=fv5hhtlKS4FLZJ/5gECi1hryLYYoh/usk0TdcneeaUuuMcv+VBU8Fif08SMIr3jhgCSY3m0bvwPmYDGroojc/lz1su2Wtdh4bJjwQGr8+Cm43ZbqxhPw8T3GnebKWZzMFN1bbD7EPu+Z/MQyXqVH3UZ9QSEvJ7Q+VdMpAXZrAYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706214638; c=relaxed/simple;
	bh=05cbVOo+mdcRvRfx6iJwRP4fFQj9OAacViPc4MYK1Ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJ0d8fXfW4+Dmbzti/ZcgwMkQbMB5A78Y8oEsyacmjBnbIyIbvXlX01T2TuiOmwywbp8nRWXfQBWyBLvCJFnf7twGEUkTMMWEJSr/D/8KgmltMwf4jZYBXkRdpRvXUE2mjHjjYHLSXhuYaZUrMkBzgTakgVlIhLTagJzImPHZO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=PcCNcmnp; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5586764bd0aso13106a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 12:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1706214635; x=1706819435; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fLwUYXjR6V1ZptUfaHjdXBygjq5la2NuNHiSaIUSLm4=;
        b=PcCNcmnpHT1nqInC/bOetHiGRA1JPq97O5nKsG09cATpFAtWuzPAEBSlajYKuGdKOQ
         EmN0JukvZqRh8i6qjpO0oBhYbq9L5yqLB5sfonzWDdLofnA9Q6MGfwC3HTDijxkfdbPn
         kTPIXKyHtrmTDjNDoBxZQPvKTvFycTCKdrzBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706214635; x=1706819435;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fLwUYXjR6V1ZptUfaHjdXBygjq5la2NuNHiSaIUSLm4=;
        b=oKC1M22A58jUb//aCrilFeta+S7zQa6AhQvsmy/c5Mu6V4dYxeicmg0KyT0JdzG/nq
         79ET3XblsqhSarcEavDds8iHVKX0tMIum86uYFf0UarVww/Yh8fu4t+y4ZwwvqsauacZ
         z7uzmgmjQPjbjwm59SuCcK+dgDM622lKvfVWD8r8AfQoyzghpOrxB4qG0IXQKqB5XkD4
         i6M5Yi//IzTAxcyh6cyPTwl8I4AjXFwf8WAAJG44u1gBwCHC6LrVwoMKSjF8VgEsHfRZ
         R8kaCTlbzl7bc863OTUfk6rUu2fhb7QJuqAgsYRJEWXhYH7/bm8SKiFcwui5vXUP7V+4
         uH7A==
X-Gm-Message-State: AOJu0YzSfYIf7h51zo/p0BxnBAMNp22p7nrIAvZuYhJ+Kv6qjBKSRrOy
	EdeXT4+5EG/57mc9rtC4gipqRpB6JrSt7cOSD5K7W7zw/yIjaeF/0Dy/aE7NmUY=
X-Google-Smtp-Source: AGHT+IGjLsHFOclmZ7s+HWyNGbTWD340yamr9nUQrEdDL92SJyZdmTEbPrGTy0cMfclmD3+5Y2D2qg==
X-Received: by 2002:aa7:d1ce:0:b0:559:c6da:c889 with SMTP id g14-20020aa7d1ce000000b00559c6dac889mr263448edp.1.1706214634780;
        Thu, 25 Jan 2024 12:30:34 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id q25-20020a056402041900b0055c104274e7sm5770172edv.78.2024.01.25.12.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 12:30:34 -0800 (PST)
Date: Thu, 25 Jan 2024 21:30:32 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Andrew Davis <afd@ti.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Paul Cercueil <paul@crapouillou.net>,
	dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [Linaro-mm-sig] [PATCH 2/3] udmabuf: Sync buffer mappings for
 attached devices
Message-ID: <ZbLE6FYXFVzTLh28@phenom.ffwll.local>
Mail-Followup-To: Andrew Davis <afd@ti.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Paul Cercueil <paul@crapouillou.net>,
	dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20240123221227.868341-1-afd@ti.com>
 <20240123221227.868341-2-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123221227.868341-2-afd@ti.com>
X-Operating-System: Linux phenom 6.6.11-amd64 

On Tue, Jan 23, 2024 at 04:12:26PM -0600, Andrew Davis wrote:
> Currently this driver creates a SGT table using the CPU as the
> target device, then performs the dma_sync operations against
> that SGT. This is backwards to how DMA-BUFs are supposed to behave.
> This may have worked for the case where these buffers were given
> only back to the same CPU that produced them as in the QEMU case.
> And only then because the original author had the dma_sync
> operations also backwards, syncing for the "device" on begin_cpu.
> This was noticed and "fixed" in this patch[0].
> 
> That then meant we were sync'ing from the CPU to the CPU using
> a pseudo-device "miscdevice". Which then caused another issue
> due to the miscdevice not having a proper DMA mask (and why should
> it, the CPU is not a DMA device). The fix for that was an even
> more egregious hack[1] that declares the CPU is coherent with
> itself and can access its own memory space..
> 
> Unwind all this and perform the correct action by doing the dma_sync
> operations for each device currently attached to the backing buffer.
> 
> [0] commit 1ffe09590121 ("udmabuf: fix dma-buf cpu access")
> [1] commit 9e9fa6a9198b ("udmabuf: Set the DMA mask for the udmabuf device (v2)")
> 
> Signed-off-by: Andrew Davis <afd@ti.com>

So yeah the above hacks are terrible, but I don't think this is better.
What you're doing now is that you're potentially doing the flushing
multiple times, so if you have a lot of importers with life mappings this
is a performance regression.

It's probably time to bite the bullet and teach the dma-api about flushing
for multiple devices. Or some way we can figure out which is the one
device we need to pick which gives us the right amount of flushing.

Cheers, Sima

> ---
>  drivers/dma-buf/udmabuf.c | 41 +++++++++++++++------------------------
>  1 file changed, 16 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
> index 3a23f0a7d112a..ab6764322523c 100644
> --- a/drivers/dma-buf/udmabuf.c
> +++ b/drivers/dma-buf/udmabuf.c
> @@ -26,8 +26,6 @@ MODULE_PARM_DESC(size_limit_mb, "Max size of a dmabuf, in megabytes. Default is
>  struct udmabuf {
>  	pgoff_t pagecount;
>  	struct page **pages;
> -	struct sg_table *sg;
> -	struct miscdevice *device;
>  	struct list_head attachments;
>  	struct mutex lock;
>  };
> @@ -169,12 +167,8 @@ static void unmap_udmabuf(struct dma_buf_attachment *at,
>  static void release_udmabuf(struct dma_buf *buf)
>  {
>  	struct udmabuf *ubuf = buf->priv;
> -	struct device *dev = ubuf->device->this_device;
>  	pgoff_t pg;
>  
> -	if (ubuf->sg)
> -		put_sg_table(dev, ubuf->sg, DMA_BIDIRECTIONAL);
> -
>  	for (pg = 0; pg < ubuf->pagecount; pg++)
>  		put_page(ubuf->pages[pg]);
>  	kfree(ubuf->pages);
> @@ -185,33 +179,31 @@ static int begin_cpu_udmabuf(struct dma_buf *buf,
>  			     enum dma_data_direction direction)
>  {
>  	struct udmabuf *ubuf = buf->priv;
> -	struct device *dev = ubuf->device->this_device;
> -	int ret = 0;
> -
> -	if (!ubuf->sg) {
> -		ubuf->sg = get_sg_table(dev, buf, direction);
> -		if (IS_ERR(ubuf->sg)) {
> -			ret = PTR_ERR(ubuf->sg);
> -			ubuf->sg = NULL;
> -		}
> -	} else {
> -		dma_sync_sg_for_cpu(dev, ubuf->sg->sgl, ubuf->sg->nents,
> -				    direction);
> -	}
> +	struct udmabuf_attachment *a;
>  
> -	return ret;
> +	mutex_lock(&ubuf->lock);
> +
> +	list_for_each_entry(a, &ubuf->attachments, list)
> +		dma_sync_sgtable_for_cpu(a->dev, a->table, direction);
> +
> +	mutex_unlock(&ubuf->lock);
> +
> +	return 0;
>  }
>  
>  static int end_cpu_udmabuf(struct dma_buf *buf,
>  			   enum dma_data_direction direction)
>  {
>  	struct udmabuf *ubuf = buf->priv;
> -	struct device *dev = ubuf->device->this_device;
> +	struct udmabuf_attachment *a;
>  
> -	if (!ubuf->sg)
> -		return -EINVAL;
> +	mutex_lock(&ubuf->lock);
> +
> +	list_for_each_entry(a, &ubuf->attachments, list)
> +		dma_sync_sgtable_for_device(a->dev, a->table, direction);
> +
> +	mutex_unlock(&ubuf->lock);
>  
> -	dma_sync_sg_for_device(dev, ubuf->sg->sgl, ubuf->sg->nents, direction);
>  	return 0;
>  }
>  
> @@ -307,7 +299,6 @@ static long udmabuf_create(struct miscdevice *device,
>  	exp_info.priv = ubuf;
>  	exp_info.flags = O_RDWR;
>  
> -	ubuf->device = device;
>  	buf = dma_buf_export(&exp_info);
>  	if (IS_ERR(buf)) {
>  		ret = PTR_ERR(buf);
> -- 
> 2.39.2
> 
> _______________________________________________
> Linaro-mm-sig mailing list -- linaro-mm-sig@lists.linaro.org
> To unsubscribe send an email to linaro-mm-sig-leave@lists.linaro.org

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

