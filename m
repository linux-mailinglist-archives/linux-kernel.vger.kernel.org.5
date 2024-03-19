Return-Path: <linux-kernel+bounces-107148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C82687F824
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE356282664
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDC551C54;
	Tue, 19 Mar 2024 07:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K/jA0ZbM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5805251C39
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 07:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710831905; cv=none; b=h9ofyfJKNGhbOMgvMnW6sg1Pjjb475sQ8r2GtT9U0gwH7mHYUue1KAbTBwCgmm1foQp32xunq9+zypB9GyRLvTZ9QBpnXzFfL+wKV+tLf5EwaHMkQUb/179DBvMd3SNfPaigL5fw0ue0Kn0b483CJhx9Nm/ZyO5/cCzjLvGeeXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710831905; c=relaxed/simple;
	bh=Ndfh/nh824nN5WcyANy2Uoh6V4Gixx5ZzpqNUelrwP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AhsuPxF/rKKmoF2NpvIomokfmmm8mkA9IcaisD7Ko85scMkJBmv7v+tRZYkkRHdtEQi32melrTIKEwIDbCa9d1nVREaZ8eNrZ2RUmBxgLqZK37G2WGML7nxfLXaUdVnIzWHeOUUeOUM4ZPOWAnOsRWayENZQ+iUDE21wwztAL/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K/jA0ZbM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710831903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=msk7w1tinlaWzEk2KKg0h88gDmDQY/OKdF9U/8feTqI=;
	b=K/jA0ZbMCsDDlqzV9Qj/YlPqWmn9yY1P+ZEUpaDjG7n26mKp8KipB1+FQHVXYdU8oXE28W
	cdP9okj5alIBpmRzSF3RuIFr+K8V6BeM7pESp3N/wmCAaiG8SewSlIHIZBft4zu6GHQfMQ
	pmD6/1iwvhMxmV9J/HjMLFdFW3amAzk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-2AmQmwVhPlKvNhjnZUiD3A-1; Tue, 19 Mar 2024 03:05:01 -0400
X-MC-Unique: 2AmQmwVhPlKvNhjnZUiD3A-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4140edcb197so10942685e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 00:05:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710831900; x=1711436700;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=msk7w1tinlaWzEk2KKg0h88gDmDQY/OKdF9U/8feTqI=;
        b=bL6C99JR0t8BAwwzmAZ2MLEzmaGiB43iGU8zN3Hktc74OFBMxkNfZSk8tE6faPSlPb
         FClwRuH+93YFRHLbAZXnx1g44uqA+hmeCVVZEbFn6gYafBmxEs33Sh/QgNo/0k/Knk5v
         CfPwVRd+pLdaNw+KMhqVSgP52vV/LLddkdicMOglriKVxHoAWW8EnaaAOjnleHRhieZl
         XOhrNeBM8V3VBN/4WeATkE2LzrVu4hERCDYSfJbM9K47NzCgp95jTuEiApQPtJLj2PpH
         S1IvzZnzJFwNwNrBN2ZrHNJOEug12wEi+lWPVQiTTg5irWTD5Oyoem69UPrTl4ZwAtQ3
         V6/g==
X-Forwarded-Encrypted: i=1; AJvYcCUW0M8tEEbbRRv/3dxdavqA/9ClexSx4fuKSQ8u5ZB/r2+tLaRuaUI16phUQxoL1ImAc7gmd6ZnIO8mCRD9n1+nArKJnB/y0zSXjfu5
X-Gm-Message-State: AOJu0YylFjazN0Wo5x6pj39NMCoA/PtFqHQ3taj+oABrrfqMExYMBz5Q
	SAIKRSqhYby7yi7VcV9ZTmS96OoP61vbHETo4AbmKr/s11cKohqi0WC8RTNsZNXyFr6e/UPXzsD
	4UqwgrC+mPBd2QlsU3u6X9FpTOVuVb14j+gCsBYjAeu4owdSMjMME4gHuxON7yQ==
X-Received: by 2002:a05:600c:4eca:b0:414:1e0:2afa with SMTP id g10-20020a05600c4eca00b0041401e02afamr8358557wmq.3.1710831900156;
        Tue, 19 Mar 2024 00:05:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHz4xz32UCYWB9lnqEcxFh5GXgSTBxzG1zltbsajW5LUv/qBjfGkKiOalU52s/Yd0zHsKkWFA==
X-Received: by 2002:a05:600c:4eca:b0:414:1e0:2afa with SMTP id g10-20020a05600c4eca00b0041401e02afamr8358522wmq.3.1710831899535;
        Tue, 19 Mar 2024 00:04:59 -0700 (PDT)
Received: from redhat.com ([2.52.6.254])
        by smtp.gmail.com with ESMTPSA id w9-20020a05600c474900b0041408af4b34sm9695750wmo.10.2024.03.19.00.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 00:04:59 -0700 (PDT)
Date: Tue, 19 Mar 2024 03:04:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: Will Deacon <will@kernel.org>, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, yihyu@redhat.com, shan.gavin@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>, mochs@nvidia.com
Subject: Re: [PATCH] virtio_ring: Fix the stale index in available ring
Message-ID: <20240319030148-mutt-send-email-mst@kernel.org>
References: <20240314074923.426688-1-gshan@redhat.com>
 <20240318165924.GA1824@willie-the-truck>
 <35a6bcef-27cf-4626-a41d-9ec0a338fe28@redhat.com>
 <20240319020905-mutt-send-email-mst@kernel.org>
 <20240319020949-mutt-send-email-mst@kernel.org>
 <6b829cfc-9cbe-42eb-9935-62d2cf5fbcc4@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b829cfc-9cbe-42eb-9935-62d2cf5fbcc4@redhat.com>

On Tue, Mar 19, 2024 at 04:54:15PM +1000, Gavin Shan wrote:
> On 3/19/24 16:10, Michael S. Tsirkin wrote:
> > On Tue, Mar 19, 2024 at 02:09:34AM -0400, Michael S. Tsirkin wrote:
> > > On Tue, Mar 19, 2024 at 02:59:23PM +1000, Gavin Shan wrote:
> > > > On 3/19/24 02:59, Will Deacon wrote:
> [...]
> > > > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > > > > index 49299b1f9ec7..7d852811c912 100644
> > > > > > --- a/drivers/virtio/virtio_ring.c
> > > > > > +++ b/drivers/virtio/virtio_ring.c
> > > > > > @@ -687,9 +687,15 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
> > > > > >    	avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
> > > > > >    	vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
> > > > > > -	/* Descriptors and available array need to be set before we expose the
> > > > > > -	 * new available array entries. */
> > > > > > -	virtio_wmb(vq->weak_barriers);
> > > > > > +	/*
> > > > > > +	 * Descriptors and available array need to be set before we expose
> > > > > > +	 * the new available array entries. virtio_wmb() should be enough
> > > > > > +	 * to ensuere the order theoretically. However, a stronger barrier
> > > > > > +	 * is needed by ARM64. Otherwise, the stale data can be observed
> > > > > > +	 * by the host (vhost). A stronger barrier should work for other
> > > > > > +	 * architectures, but performance loss is expected.
> > > > > > +	 */
> > > > > > +	virtio_mb(false);
> > > > > >    	vq->split.avail_idx_shadow++;
> > > > > >    	vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
> > > > > >    						vq->split.avail_idx_shadow);
> > > > > 
> > > > > Replacing a DMB with a DSB is _very_ unlikely to be the correct solution
> > > > > here, especially when ordering accesses to coherent memory.
> > > > > 
> > > > > In practice, either the larger timing different from the DSB or the fact
> > > > > that you're going from a Store->Store barrier to a full barrier is what
> > > > > makes things "work" for you. Have you tried, for example, a DMB SY
> > > > > (e.g. via __smb_mb()).
> > > > > 
> > > > > We definitely shouldn't take changes like this without a proper
> > > > > explanation of what is going on.
> > > > > 
> > > > 
> > > > Thanks for your comments, Will.
> > > > 
> > > > Yes, DMB should work for us. However, it seems this instruction has issues on
> > > > NVidia's grace-hopper. It's hard for me to understand how DMB and DSB works
> > > > from hardware level. I agree it's not the solution to replace DMB with DSB
> > > > before we fully understand the root cause.
> > > > 
> > > > I tried the possible replacement like below. __smp_mb() can avoid the issue like
> > > > __mb() does. __ndelay(10) can avoid the issue, but __ndelay(9) doesn't.
> > > > 
> > > > static inline int virtqueue_add_split(struct virtqueue *_vq, ...)
> > > > {
> > > >      :
> > > >          /* Put entry in available array (but don't update avail->idx until they
> > > >           * do sync). */
> > > >          avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
> > > >          vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
> > > > 
> > > >          /* Descriptors and available array need to be set before we expose the
> > > >           * new available array entries. */
> > > >          // Broken: virtio_wmb(vq->weak_barriers);
> > > >          // Broken: __dma_mb();
> > > >          // Work:   __mb();
> > > >          // Work:   __smp_mb();
> > 
> > Did you try __smp_wmb ? And wmb?
> > 
> 
> virtio_wmb(false) is equivalent to __smb_wmb(), which is broken.
> 
> __wmb() works either. No issue found with it.

Oh interesting. So how do smp_mb() and wmb() disassemble on this
platform? Can you please check?


> > > >          // Work:   __ndelay(100);
> > > >          // Work:   __ndelay(10);
> > > >          // Broken: __ndelay(9);
> > > > 
> > > >         vq->split.avail_idx_shadow++;
> > > >          vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
> > > >                                                  vq->split.avail_idx_shadow);
> > > 
> > > What if you stick __ndelay here?
> > 
> > And keep virtio_wmb above?
> > 
> 
> The result has been shared through a separate reply.
> 
> > > 
> > > >          vq->num_added++;
> > > > 
> > > >          pr_debug("Added buffer head %i to %p\n", head, vq);
> > > >          END_USE(vq);
> > > >          :
> > > > }
> > > > 
> > > > I also tried to measure the consumed time for various barrier-relative instructions using
> > > > ktime_get_ns() which should have consumed most of the time. __smb_mb() is slower than
> > > > __smp_wmb() but faster than __mb()
> > > > 
> > > >      Instruction           Range of used time in ns
> > > >      ----------------------------------------------
> > > >      __smp_wmb()           [32  1128032]
> > > >      __smp_mb()            [32  1160096]
> > > >      __mb()                [32  1162496]
> > > > 
> 
> Thanks,
> Gavin


