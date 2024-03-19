Return-Path: <linux-kernel+bounces-107068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 133DA87F725
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3616E1C21CA0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349EB59B73;
	Tue, 19 Mar 2024 06:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ng/vnWhW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73D14595A
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 06:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710828876; cv=none; b=NMVSc/H9qJt2WFpiQlLHPDataY7ntvAA8GDQvpcdOiIPzEWArk4gg+Z5xEPmEnTlMAkCAQbtuRqit/0tuW5xmHZwksKVV4v5G4qqEnJl2hHX4Q8+EfIJuLc6yA66lU1hqjP9F47Nc4zzYM5D5wZJKKq3nuGcvGdRuiyIk8Xt+vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710828876; c=relaxed/simple;
	bh=v2pKD6xIQbKNmcB1pUgXdy2M1Ktb7FP3Z2rqu9Hj1HQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F0iFKGcgDjb69SgxiEM2TzdLJTiHxNo0wQajhUfPbOe0zm/vXBUjqFzwKIJE+p56J6hvOndla8sBVCmAJ430rjl3mm2bLhTVYulExdioXw8AYB9Bx1yn7tUxt80A7G5MHBwqT5DpEuoF5IJTIpVJWYaO/sfzRkbvayrvtTTfU/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ng/vnWhW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710828873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nd2WnTQpqJ6t/rcAd5QrbY0+YyvvOiz3e4ifplxSCyk=;
	b=Ng/vnWhWEfyK3s+vccIs/p5zODkm6UZhs0IX1BRPA047qAbOx17BFwnwgNTOC2zxA49E7T
	uV2kOKtc5JEW/SeVGKsfYSUKusz1Iev32LL3WI4TqmizmQFwK/ilY/u2elHBWX7zeBg7Io
	tym3iEsjC9yas6YiXBKLnpSq9TORKEE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-ov18ZZMkOSWiDAsGOnGvlQ-1; Tue, 19 Mar 2024 02:14:32 -0400
X-MC-Unique: ov18ZZMkOSWiDAsGOnGvlQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a46e26556a2so8373766b.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 23:14:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710828871; x=1711433671;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nd2WnTQpqJ6t/rcAd5QrbY0+YyvvOiz3e4ifplxSCyk=;
        b=ekDRXkk5bVwvYo/mNvNITr0Yy8AtFafU6gx42h+ZeSIpcHn8ZYBFykTGP01jh61bBz
         uPaF0B0jApHqDDdm00xf3wPKPHDuP+iLJfsK1dff1Gr++BRplL6RIasdTLP0XrQxbOAo
         thjlYTkuf2PvE544Ye7ssnhf3psZENRrh1pAFWXaDL9oBq1A8uTiKf7l7MlCAnblbmyt
         2hXabvFi3fJ7j6KYpxK47t9Zbi3lntVa6YASJy0B/kDEAs0SLbb71WqsJ5cwiytZdMYi
         QJuvcQ40jX7/YgggAGsSfTUavhBeUccAv0C4zBxK+zNWveSRNTBLYq/LGOPwcnlOdH96
         YoNw==
X-Forwarded-Encrypted: i=1; AJvYcCW+h+C8rnsOrNj0sYTZ7cbkZCkXFMrjnEB8aElNN4at02xpAVihiF15qKJFZAlh9KjkfQAmJdy8yCqwZ2W0xrgH8eTWFsGCXh2jJI4z
X-Gm-Message-State: AOJu0YxPQ4fVdtY31KZQURbvZzJVtvWLJeLJfeMSplSTFGvLmG1LeQ7k
	l94RqLLrNBcU8Gti0tjG0DwOWU9pViN177zc/G7oTG2eh5jDK8IMJ/yz2uJwMFsMzsWu5IZ9FOD
	ep18c8WyoXNrCjtSPpVQqofhlr+0yzt1uBOfG8uTvK+XKls4qKfLdtIkF9Jxdlg==
X-Received: by 2002:a17:907:7a93:b0:a46:74fe:904f with SMTP id mm19-20020a1709077a9300b00a4674fe904fmr10682762ejc.26.1710828870987;
        Mon, 18 Mar 2024 23:14:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGo/SmdwOaw3x3Vaq0MJ5ceF64rXJYjddl/AfDh1pN5ip0sZk4YZOLeNTJ1ec6BERFY/yXtfQ==
X-Received: by 2002:a17:907:7a93:b0:a46:74fe:904f with SMTP id mm19-20020a1709077a9300b00a4674fe904fmr10682741ejc.26.1710828870515;
        Mon, 18 Mar 2024 23:14:30 -0700 (PDT)
Received: from redhat.com ([2a02:14f:175:ca2b:adb0:2501:10a9:c4b2])
        by smtp.gmail.com with ESMTPSA id gf8-20020a170906e20800b00a46d9966ff8sm567031ejb.147.2024.03.18.23.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 23:14:29 -0700 (PDT)
Date: Tue, 19 Mar 2024 02:14:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, yihyu@redhat.com,
	shan.gavin@gmail.com
Subject: Re: [PATCH] virtio_ring: Fix the stale index in available ring
Message-ID: <20240319021136-mutt-send-email-mst@kernel.org>
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
>  	vq->split.avail_idx_shadow++;
>  	vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
>  						vq->split.avail_idx_shadow);



Something else to try, is to disassemble the code and check the compiler is not broken.

It also might help to replace assigment above with WRITE_ONCE -
it's technically always has been the right thing to do, it's just a big
change (has to be done everywhere if done at all) so we never bothered
and we never hit a compiler that would split or speculate stores ...


> -- 
> 2.44.0


