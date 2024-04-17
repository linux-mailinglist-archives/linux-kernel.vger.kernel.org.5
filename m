Return-Path: <linux-kernel+bounces-148233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1607C8A7FAA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34A201C20EB1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FEF137905;
	Wed, 17 Apr 2024 09:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yg0cjU9j"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19103130A79
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 09:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713346190; cv=none; b=S9CIO5o6Nvs2JO5Yxyp8I6BlFhZQdADQfGFc18MbdYqoRYupJnXbNCGl1MrF/n0jbygnlmHOTlLQPy4kAIT0wVUJHIPiLgizz7IRAzVhs6lbekUDYOp9ojz5XjoChUV7h14RM3I8LKHisIKDaS11zarxVQVV+DCmJII/ZSP0IBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713346190; c=relaxed/simple;
	bh=Z6a2clvySatSre/JWaMGilT9UiZWLgBF9gzq2yif97A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pP1StxBuLBXDDDBnMErQUHWI369ES4Mavgcb8OumNlG7spYoataLoYJGP4YNA9AUwITVAtuR7tmXkchcgPxJVkw13y0sxSINdnLorK2Q9BoEbRIXb2D4hq1aLxt1YK02OAUkcLeqMMmrWQGXmoVaClmVgHIWud89YbX5SwUtp30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yg0cjU9j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713346187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wnkR6+X++mIRsBRTPfNHWnFS6/+Rlqu2C6vcj0wKpTk=;
	b=Yg0cjU9jgs8SwezzM7gsmiBCS0VzOXVRlH1MrO0oToLuIEb49Oj0+81+Zf+EhDDg50rZcp
	ReuPJ899/6/bxliSgw1ewhO4h8P0wIqiSC411P7lNcCvd3UW6Cvs0lviIIeaHcvD19Uxrs
	ikRxE5rppFgJjvrVqqXZMq/pKLythWM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-8jx55ogSP3aeZeTScpon0w-1; Wed, 17 Apr 2024 05:29:45 -0400
X-MC-Unique: 8jx55ogSP3aeZeTScpon0w-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-343c7fa0dd5so3520916f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 02:29:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713346184; x=1713950984;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wnkR6+X++mIRsBRTPfNHWnFS6/+Rlqu2C6vcj0wKpTk=;
        b=UPaVyHR+FJOquAGq37i1DN4bnQKFUVDK5ACGAvuwYgy4z6AHikjIs9E/K+r8f86hIW
         f2ozj7r2e02ubKYi+65ZlOTyjlFgJZRVuTk4mrIzd5qr38UtCFJi1KtFF9XmWQA2zS9l
         ZeXxiq9cYwL/5ASJoNt67cgJ8ehdq4yPaO6e8ZiucR+deycC+5QlgUwFwupX6axVNfjJ
         /hl+jDut+rmFbBXZgjSb4Kl1xjTJOdI7Yo2s8RZAKbqKVUxHbuPf/5WWKK6nHKU4hxp8
         jKD5uushB2YbA3Hc2Z09QwZFq7YEll+SI51Sb2/vCB/TmW7KEIEA6OoTc2yDWaJTcj6Z
         iG6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWBO5tYRzZPJMB5hx5jTH3vNYZ+uI33EfBjZVd8sVsZti9ikc8nmlExzhAbSNcD2ZlLaAYTkcOGlKAz1XAElhlMmzuw4ZYxdaDYso73
X-Gm-Message-State: AOJu0Yx4jHwtQfLhA9HFIr5ViiDhUSygNRyq00wKJohaA8z84DvPaDE9
	tYIXjKguuxb23V8G7Mvn08ecDBziN3gMCG2pfeK+ve2Y9flMF2/HewNzt8GDdb+73E5vvsgvIov
	PEYErt0ea3XVxt4SBvoOqD6g/odC5Innr4nR+LgVKDEx/8AK6EcdsAYkJqwM8JA==
X-Received: by 2002:adf:eb49:0:b0:346:4307:dd2b with SMTP id u9-20020adfeb49000000b003464307dd2bmr10290211wrn.46.1713346183612;
        Wed, 17 Apr 2024 02:29:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF02GRQhjx9pu5ih6EDC9BEkFgvPWyPa0fKgwGMnMjvoVvyawFthVWcHSGEIVbi6dxJppaSpw==
X-Received: by 2002:adf:eb49:0:b0:346:4307:dd2b with SMTP id u9-20020adfeb49000000b003464307dd2bmr10290193wrn.46.1713346182968;
        Wed, 17 Apr 2024 02:29:42 -0700 (PDT)
Received: from redhat.com ([2a02:14f:17e:a69f:1202:8a1b:788c:6fa1])
        by smtp.gmail.com with ESMTPSA id l3-20020a05600012c300b003434c764f01sm16960454wrx.107.2024.04.17.02.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 02:29:42 -0700 (PDT)
Date: Wed, 17 Apr 2024 05:29:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v5 3/5] vduse: Add function to get/free the pages for
 reconnection
Message-ID: <20240417052723-mutt-send-email-mst@kernel.org>
References: <20240412133017.483407-1-lulu@redhat.com>
 <20240412133017.483407-4-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412133017.483407-4-lulu@redhat.com>

On Fri, Apr 12, 2024 at 09:28:23PM +0800, Cindy Lu wrote:
> Add the function vduse_alloc_reconnnect_info_mem
> and vduse_alloc_reconnnect_info_mem
> These functions allow vduse to allocate and free memory for reconnection
> information. The amount of memory allocated is vq_num pages.
> Each VQS will map its own page where the reconnection information will be saved
> 
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 40 ++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index ef3c9681941e..2da659d5f4a8 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -65,6 +65,7 @@ struct vduse_virtqueue {
>  	int irq_effective_cpu;
>  	struct cpumask irq_affinity;
>  	struct kobject kobj;
> +	unsigned long vdpa_reconnect_vaddr;
>  };
>  
>  struct vduse_dev;
> @@ -1105,6 +1106,38 @@ static void vduse_vq_update_effective_cpu(struct vduse_virtqueue *vq)
>  
>  	vq->irq_effective_cpu = curr_cpu;
>  }
> +static int vduse_alloc_reconnnect_info_mem(struct vduse_dev *dev)
> +{
> +	unsigned long vaddr = 0;
> +	struct vduse_virtqueue *vq;
> +
> +	for (int i = 0; i < dev->vq_num; i++) {
> +		/*page 0~ vq_num save the reconnect info for vq*/
> +		vq = dev->vqs[i];
> +		vaddr = get_zeroed_page(GFP_KERNEL);


I don't get why you insist on stealing kernel memory for something
that is just used by userspace to store data for its own use.
Userspace does not lack ways to persist data, for example,
create a regular file anywhere in the filesystem.



> +		if (vaddr == 0)
> +			return -ENOMEM;
> +
> +		vq->vdpa_reconnect_vaddr = vaddr;
> +	}
> +
> +	return 0;
> +}
> +
> +static int vduse_free_reconnnect_info_mem(struct vduse_dev *dev)
> +{
> +	struct vduse_virtqueue *vq;
> +
> +	for (int i = 0; i < dev->vq_num; i++) {
> +		vq = dev->vqs[i];
> +
> +		if (vq->vdpa_reconnect_vaddr)
> +			free_page(vq->vdpa_reconnect_vaddr);
> +		vq->vdpa_reconnect_vaddr = 0;
> +	}
> +
> +	return 0;
> +}
>  
>  static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>  			    unsigned long arg)
> @@ -1672,6 +1705,8 @@ static int vduse_destroy_dev(char *name)
>  		mutex_unlock(&dev->lock);
>  		return -EBUSY;
>  	}
> +	vduse_free_reconnnect_info_mem(dev);
> +
>  	dev->connected = true;
>  	mutex_unlock(&dev->lock);
>  
> @@ -1855,12 +1890,17 @@ static int vduse_create_dev(struct vduse_dev_config *config,
>  	ret = vduse_dev_init_vqs(dev, config->vq_align, config->vq_num);
>  	if (ret)
>  		goto err_vqs;
> +	ret = vduse_alloc_reconnnect_info_mem(dev);
> +	if (ret < 0)
> +		goto err_mem;
>  
>  	__module_get(THIS_MODULE);
>  
>  	return 0;
>  err_vqs:
>  	device_destroy(&vduse_class, MKDEV(MAJOR(vduse_major), dev->minor));
> +err_mem:
> +	vduse_free_reconnnect_info_mem(dev);
>  err_dev:
>  	idr_remove(&vduse_idr, dev->minor);
>  err_idr:
> -- 
> 2.43.0


