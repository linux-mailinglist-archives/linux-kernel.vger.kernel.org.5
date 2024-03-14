Return-Path: <linux-kernel+bounces-102958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5ED87B917
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4C8B1C22218
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 08:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371D63209;
	Thu, 14 Mar 2024 08:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DWsKPBDQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17834EAFA
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 08:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710403543; cv=none; b=tE5z8pYDaflLe3kFVQFfaPmOoP5o+WRPDCbphxNWMYSv9y5X5kc4LKBnkHNbcBeiYpzirjjJQ8gfNQZnv5hnB3yiefdcTucTKnQQhHwrbnR/m+4lGRD/y9aYygbowEhPCMTjuN2HIs+aLUGPisXIhsVCibmBfebr45bzEW6B0OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710403543; c=relaxed/simple;
	bh=c5dQPIi5+dTdkssS5kHf15ZWVGL4axBW5Y7E08xrRog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t73s87jc+7ksCNXMIjkTDP6hMTlESBfaTcNTrBwI+fr3jTB0lWDF2Pch2FSc7KGy6ygwx7rf9c1RM5XKYrbAgKCapjCgJfHEraFTv+/LEqzVLDCwtDKxgWOFclxTk+czMe/ecrWR9s7u9F7fg1sJHH/GZsXVFNR8lAxRLkS787E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DWsKPBDQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710403539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=twCf+S12MC6b5Qn4kEy/Qs5P8iL9E+CPn7P9+SqvFCw=;
	b=DWsKPBDQ5v2KMNvgi3cRJq5uavIBRxT0+41AXdi3XybMwuAtEZl1UVhzJlS8NXfDooI6UN
	v1TQaQOmo5dV5oJ9j9cDh0WDfWpDgE/EVYOt5vmzuC3JxqO67p+pFFK0AJb6h46Lh8mZ3Z
	3Dmx2fTnS3HpNm9NnhdGAzqs8iTMC/Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-Zfh1gcH-PI-5wJjUQgtrUA-1; Thu, 14 Mar 2024 04:05:38 -0400
X-MC-Unique: Zfh1gcH-PI-5wJjUQgtrUA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40d62d3ae0cso3518315e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 01:05:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710403537; x=1711008337;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=twCf+S12MC6b5Qn4kEy/Qs5P8iL9E+CPn7P9+SqvFCw=;
        b=W+9H07VwFv2NCSzZoWK8spQKsQOTg8PQz+iH0DP1KYFmRBvaMYUiPdcbY+2n7GWlSK
         GTy19ZQ40mEDv7xFFHtUtbF1IdPqt0T9sSWxBkKX9KwaC3jZPWyb8TwtdFHWSLU1uXXU
         Cp+eU89fG6D/+zbk8axeC0XgmLV3GLYSu/EIuWBiyGE+DwrsxWCq+2P27aY1jWpDwVXZ
         2XUzpwt/hhrZzqOq1tOlvlSCRNyrwgBfhCJDb23Tug7XRvftY3PVzDzSZzxA6dlRuCwD
         j6zYAq6ys/h+1ySPr36xGfXp+3PzTTeQ96WVmd1e51mblE+v2ajHtYriTjqLgDfpDPH5
         wkWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFy5DyErN2azMxEvqAoUhipCdhT4Dp2KHSphnBEwREv0JHThMWp2JJ3jjWPBq9wC02PlXiDuw1+HuMytsdKcAH2yjbHK5WYE5wMNBW
X-Gm-Message-State: AOJu0Yxozavn8P6MOtAgS+cjFv8XkTiak8EsXU2y+uIX99KhxQ0aDsv7
	h2asnhBiPLzcxkJCpwMSiuQ0g3cDMSkMky4zCEkfdFM8vjOxFFJOAn4yAxUQZMEPHPu/5cT/EjY
	TTw0phVL9wtCigJ4mexvEySQruyHewcJLssNfC6r3mTLb/xyl4kTauVYVwX9Gfw==
X-Received: by 2002:a05:600c:520d:b0:413:e19:337f with SMTP id fb13-20020a05600c520d00b004130e19337fmr726985wmb.22.1710403537078;
        Thu, 14 Mar 2024 01:05:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/vGlZoWw7dKN4Pbvd6mgsDyCr7HSvKmnXXoW0mIUYkLwKgnCpvfwwyLZHJbJ7gvGZhHbB0g==
X-Received: by 2002:a05:600c:520d:b0:413:e19:337f with SMTP id fb13-20020a05600c520d00b004130e19337fmr726952wmb.22.1710403536377;
        Thu, 14 Mar 2024 01:05:36 -0700 (PDT)
Received: from redhat.com ([2.52.134.16])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c315100b00413f76fe7b0sm202255wmo.21.2024.03.14.01.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 01:05:35 -0700 (PDT)
Date: Thu, 14 Mar 2024 04:05:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, yihyu@redhat.com,
	shan.gavin@gmail.com
Subject: Re: [PATCH] virtio_ring: Fix the stale index in available ring
Message-ID: <20240314040443-mutt-send-email-mst@kernel.org>
References: <20240314074923.426688-1-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314074923.426688-1-gshan@redhat.com>

On Thu, Mar 14, 2024 at 05:49:23PM +1000, Gavin Shan wrote:
> The issue is reported by Yihuang Yu who have 'netperf' test on
> NVidia's grace-grace and grace-hopper machines. The 'netperf'
> client is started in the VM hosted by grace-hopper machine,
> while the 'netperf' server is running on grace-grace machine.
> 
> The VM is started with virtio-net and vhost has been enabled.
> We observe a error message spew from VM and then soft-lockup
> report. The error message indicates the data associated with
> the descriptor (index: 135) has been released, and the queue
> is marked as broken. It eventually leads to the endless effort
> to fetch free buffer (skb) in drivers/net/virtio_net.c::start_xmit()
> and soft-lockup. The stale index 135 is fetched from the available
> ring and published to the used ring by vhost, meaning we have
> disordred write to the available ring element and available index.
> 
>   /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64              \
>   -accel kvm -machine virt,gic-version=host                            \
>      :                                                                 \
>   -netdev tap,id=vnet0,vhost=on                                        \
>   -device virtio-net-pci,bus=pcie.8,netdev=vnet0,mac=52:54:00:f1:26:b0 \
> 
>   [   19.993158] virtio_net virtio1: output.0:id 135 is not a head!
> 
> Fix the issue by replacing virtio_wmb(vq->weak_barriers) with stronger
> virtio_mb(false), equivalent to replaced 'dmb' by 'dsb' instruction on
> ARM64. It should work for other architectures, but performance loss is
> expected.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Yihuang Yu <yihyu@redhat.com>
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 49299b1f9ec7..7d852811c912 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -687,9 +687,15 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>  	avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
>  	vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
>  
> -	/* Descriptors and available array need to be set before we expose the
> -	 * new available array entries. */
> -	virtio_wmb(vq->weak_barriers);
> +	/*
> +	 * Descriptors and available array need to be set before we expose
> +	 * the new available array entries. virtio_wmb() should be enough
> +	 * to ensuere the order theoretically. However, a stronger barrier
> +	 * is needed by ARM64. Otherwise, the stale data can be observed
> +	 * by the host (vhost). A stronger barrier should work for other
> +	 * architectures, but performance loss is expected.
> +	 */
> +	virtio_mb(false);


I don't get what is going on here. Any explanation why virtio_wmb is not
enough besides "it does not work"?

>  	vq->split.avail_idx_shadow++;
>  	vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
>  						vq->split.avail_idx_shadow);
> -- 
> 2.44.0


