Return-Path: <linux-kernel+bounces-107157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DD687F848
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36E2E1F219B0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C67535D2;
	Tue, 19 Mar 2024 07:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SPjoEY2e"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6196C51C3E
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 07:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710832990; cv=none; b=BLUpoA3EMGHCQ5rV37XyqOarOu4VjV8M6pyqfQTaIaOFZZGS/yiBtRUmwqPTSENokb+Kr+n7basiwA2bVLQrpaQO0Gcgy97ShkFxLlthrz0N/MRCGMPDHvIBuQkeGakiLBITbWNPrSabK+6kGuhw4NyHCJJhU/njFJnoxQkW7gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710832990; c=relaxed/simple;
	bh=gqHMvDqH0GXe3nNnNKZOzNASEO3LjbY4EVAyXt8HAfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dn7FXXkSDluTjcQNXYdL7LPiKHzzKBZLM4G+MSBjHDPbAMS9KOOJHmA+C7O2rDbhrP6gZJ6uZnNu4JI8Fa/hxXjWnwwqcqhryvi6WdLWpODzOCRFyhfyDAqNTu9nHYEYotX+Ftq2veANHi7H2DE+eFLSadFpMG9OOya8IYSeYVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SPjoEY2e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710832988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VuSY72tnFKw3HBgsDczhmcUm8blV9e3YgrUys0sfBAo=;
	b=SPjoEY2eFY4dozoKhFysX3O55JJdFSLS7Daw+G4JtLooUZGaY8QrUBHlyzbxLodRNhBCcU
	hwCZ/5y/NqZsdxfqkIWksv3ZZ5pX2DQnQyKw6RUXhcjHyKdoTExxepWmK2iLJ8Lnat0Rai
	e9whO5RyaFtZGSrJlBGw+cEPvVZoIYk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-NqjzbUBPNZShznuOst7fsQ-1; Tue, 19 Mar 2024 03:23:06 -0400
X-MC-Unique: NqjzbUBPNZShznuOst7fsQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4140dd880b2so11996285e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 00:23:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710832985; x=1711437785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VuSY72tnFKw3HBgsDczhmcUm8blV9e3YgrUys0sfBAo=;
        b=BkGUAZsF0D6vV71Ty21JCTiNF8I5jlgKr/kqxPos4MyRgWMfGvCBr0q/hazBQGHMWO
         SwUSOgv66KhtAWWyRzqFunwo5GYzI7ZR9NWqCkMpGaqzNa6V4dKa4GVOdWb0nYEQog3f
         OoCxWRzaDBVf4pjwzfDqZ6VGfEqowX3FLAkN5W11loGFCKZjxKC3poG+X37Dvujbkio3
         S8wVu0qbII9vUw80SG0dVDUeItFTHtPL9yIhewu8h5eEsC06L4947EhYMBdDvR6SqPC9
         Zp1kYZmC/7CObZ0FghSDJMW9huYwIweHQ04b49cz8P3iVM4fSwIrbaI/c0pNRA1N7R3U
         SliQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEF0cFxvBMClfQk6ADV1TuKw+QfZH2UtBYW59i/KTRP18rXaUBtSs7ysd1Gvyz260xQTxg68Exo5MDPhvftD5SXEG7BXEVhQ+Omf51
X-Gm-Message-State: AOJu0YwFkLQ5QBekqs3R3tdhCgQR8e7wYf06QBD5Npo05Ne+lWy65FWl
	0nAhuRiuxTFMdnUt80TmrEYtxw+DuF0rZcgpwXa8wHyH8N+jE72MazXQGf2p4Omt49OQg5iaxVd
	Ry3vOiMcrPHozffy94Gy6JT8J/zH+fvkeO8HerYc/v0M0sLBV15L99gT6g03XiQ==
X-Received: by 2002:a05:600c:1ca8:b0:414:1351:8662 with SMTP id k40-20020a05600c1ca800b0041413518662mr2829457wms.12.1710832984766;
        Tue, 19 Mar 2024 00:23:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpzVhgY4JbDOMx+gLoAdQmLnA6ngQJMNzK4g2rbZEkR6NI+HOgZjEDBPCMFSZnVPXHqFGHSA==
X-Received: by 2002:a05:600c:1ca8:b0:414:1351:8662 with SMTP id k40-20020a05600c1ca800b0041413518662mr2829433wms.12.1710832984278;
        Tue, 19 Mar 2024 00:23:04 -0700 (PDT)
Received: from redhat.com ([2.52.6.254])
        by smtp.gmail.com with ESMTPSA id fb4-20020a05600c520400b00413e4ff2884sm20338273wmb.40.2024.03.19.00.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 00:23:03 -0700 (PDT)
Date: Tue, 19 Mar 2024 03:23:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Cindy Lu <lulu@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Xie Yongji <xieyongji@bytedance.com>,
	Maxime Coquelin <maxime.coquelin@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christian Brauner <brauner@kernel.org>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v3] vduse: Fix off by one in vduse_dev_mmap()
Message-ID: <20240319032236-mutt-send-email-mst@kernel.org>
References: <98298b2f-7288-4b0b-8974-3d5111b589cb@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98298b2f-7288-4b0b-8974-3d5111b589cb@moroto.mountain>

On Wed, Feb 28, 2024 at 09:24:07PM +0300, Dan Carpenter wrote:
> The dev->vqs[] array has "dev->vq_num" elements.  It's allocated in
> vduse_dev_init_vqs().  Thus, this > comparison needs to be >= to avoid
> reading one element beyond the end of the array.
> 
> Add an array_index_nospec() as well to prevent speculation issues.
> 
> Fixes: 316ecd1346b0 ("vduse: Add file operation for mmap")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Thanks a lot!
I assume this will be squashed in the relevant patch when that is
re-spun.

> ---
> v2: add array_index_nospec()
> v3: I accidentally corrupted v2.  Try again.
> 
>  drivers/vdpa/vdpa_user/vduse_dev.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index b7a1fb88c506..eb914084c650 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -1532,9 +1532,10 @@ static int vduse_dev_mmap(struct file *file, struct vm_area_struct *vma)
>  	if ((vma->vm_flags & VM_SHARED) == 0)
>  		return -EINVAL;
>  
> -	if (index > dev->vq_num)
> +	if (index >= dev->vq_num)
>  		return -EINVAL;
>  
> +	index = array_index_nospec(index, dev->vq_num);
>  	vq = dev->vqs[index];
>  	vaddr = vq->vdpa_reconnect_vaddr;
>  	if (vaddr == 0)
> -- 
> 2.43.0


