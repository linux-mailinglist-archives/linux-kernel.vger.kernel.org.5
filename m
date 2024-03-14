Return-Path: <linux-kernel+bounces-103262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBA187BD24
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 283321C20D1C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8235A4C6;
	Thu, 14 Mar 2024 12:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ca01VcQP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C9E59158
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 12:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710421180; cv=none; b=ubyEG9lcBedbtyoT5P8mq9iL4NECwhh7uRUUsg61USHQNk1On48BPMTgv082EimtEiQd1eacey2Iz0cizO4dWm8zNLVa4m9l5VBnzTSKv6+5aFt9xXoWQll4LQSHSSGRCINeyHozVRaH12SOFXVzD1BOmxeOCnl9mBNp0YOQN/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710421180; c=relaxed/simple;
	bh=XNhLg658PFnGFnvviAuQCSSB6pBCuHvQhqmEHrOFczw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nm0L1rlL/AtHpFxD/BDh06uJ+kaR963dnc71ZIFe7LLOyGBPshw9/jrdsNTpZgngvtdKfVGNxgj0fcpABckvrTX08yoY1GGckwvVLTqhuj//jT7Raavh3QUG1Gztm1AXNB7jM+jWduqOrd4/9s0vnkbGjFtgvqMDpyJcu0UZJ3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ca01VcQP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710421178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y1Nn5GLy/B4rJ3k67Y8e3KIUSteOIaHP4tOl0v+CG40=;
	b=ca01VcQP7Y9UdWgcYHRvewfo9rPIJNRLJr+98D8IWVJb0HmknOc1SCqWzex2WbZ9/c7ASv
	rFjaQlVGz2M2wJbaKxQ2GQ7EQ2d5UPq12/XGf6f2r3dPLDkwaYr8cqro9xKyn7cYupF3zW
	nO9ZHhNs0eW3IGeFUz8YXosQui0+mms=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-i_B54Iq6NQW9VoWQy63DJQ-1; Thu, 14 Mar 2024 08:59:36 -0400
X-MC-Unique: i_B54Iq6NQW9VoWQy63DJQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-41320a30302so4542625e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 05:59:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710421175; x=1711025975;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y1Nn5GLy/B4rJ3k67Y8e3KIUSteOIaHP4tOl0v+CG40=;
        b=UJ80etf5zghgm6AYyVI2ZdjxaroHVjo04qiOLRQnSX09/L5SR9vczbg9tJUolD0TXi
         yDbn26UT5OlDIaR7xtFr+X56vCIaZSvDM0QFXG93UVZzul0WkyJ+XeKqV5I0flkyH/eM
         hD5KvYGeF0V9y8oHbb6PkHKM1oPDHU3rpkcXREOpESoGHnZ/6e61HQH3O3fB8ioeMnHH
         kuJvUFaVV3wei9mXZrPPaOObLDxd7zk7R9xtYXAXaj+fApofN0KtJX9cggNoxYC/Edd1
         PMVpO/K28kUYGtTLFNwAB2pN0p5JSRrQpku/4VpBsvKr6zMrKwD/yg72L7mx5QcmQUJ9
         N+sA==
X-Forwarded-Encrypted: i=1; AJvYcCXTNKC5fiYyswNpZkvGFNnhKYgRPC4cd9Ls7UEndZLdjGQPeftxvok6TQau4FHNlr04yztrR+BoBIG5Z0DOZMrNL6fruuAaKOOreyiA
X-Gm-Message-State: AOJu0YxNVpft3cq/GuIb197egLPCOnK5TGbNj+U57iwMDHs4AnWwpgac
	Xys+dId1usBYWuwFHmisYkBLhePcFQGpjCz2lxrxaSJs/Wyn/EPMpOcOseyPaSFBksjOkK1EmPp
	k0DmCy6rOJkQWjKT3K5QWEoYEHnBPe5DfAMWCXX4TuYjplaW9d85nknmOfud77w==
X-Received: by 2002:a05:600c:350c:b0:413:f0c8:6520 with SMTP id h12-20020a05600c350c00b00413f0c86520mr1268487wmq.10.1710421175361;
        Thu, 14 Mar 2024 05:59:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGokHld8+/KkVZwEN3yI79CVCyVK0VB47HCzzZSKR93DImgwYI46ZfSRkPhCW9+e/4nUIj+6w==
X-Received: by 2002:a05:600c:350c:b0:413:f0c8:6520 with SMTP id h12-20020a05600c350c00b00413f0c86520mr1268469wmq.10.1710421174830;
        Thu, 14 Mar 2024 05:59:34 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f0:532c:5ae4:fce6:76e1:fa1a])
        by smtp.gmail.com with ESMTPSA id m8-20020a05600c4f4800b00413ea26f942sm5071474wmq.14.2024.03.14.05.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 05:59:34 -0700 (PDT)
Date: Thu, 14 Mar 2024 08:59:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, yihyu@redhat.com,
	shan.gavin@gmail.com
Subject: Re: [PATCH] virtio_ring: Fix the stale index in available ring
Message-ID: <20240314085630-mutt-send-email-mst@kernel.org>
References: <20240314074923.426688-1-gshan@redhat.com>
 <20240314040443-mutt-send-email-mst@kernel.org>
 <9b148de7-b687-4d10-b177-5608b8dc7046@redhat.com>
 <20240314074216-mutt-send-email-mst@kernel.org>
 <23dc6d00-6a57-4ddf-8611-f3c6f6a8e43c@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23dc6d00-6a57-4ddf-8611-f3c6f6a8e43c@redhat.com>

On Thu, Mar 14, 2024 at 10:50:15PM +1000, Gavin Shan wrote:
> On 3/14/24 21:50, Michael S. Tsirkin wrote:
> > On Thu, Mar 14, 2024 at 08:15:22PM +1000, Gavin Shan wrote:
> > > On 3/14/24 18:05, Michael S. Tsirkin wrote:
> > > > On Thu, Mar 14, 2024 at 05:49:23PM +1000, Gavin Shan wrote:
> > > > > The issue is reported by Yihuang Yu who have 'netperf' test on
> > > > > NVidia's grace-grace and grace-hopper machines. The 'netperf'
> > > > > client is started in the VM hosted by grace-hopper machine,
> > > > > while the 'netperf' server is running on grace-grace machine.
> > > > > 
> > > > > The VM is started with virtio-net and vhost has been enabled.
> > > > > We observe a error message spew from VM and then soft-lockup
> > > > > report. The error message indicates the data associated with
> > > > > the descriptor (index: 135) has been released, and the queue
> > > > > is marked as broken. It eventually leads to the endless effort
> > > > > to fetch free buffer (skb) in drivers/net/virtio_net.c::start_xmit()
> > > > > and soft-lockup. The stale index 135 is fetched from the available
> > > > > ring and published to the used ring by vhost, meaning we have
> > > > > disordred write to the available ring element and available index.
> > > > > 
> > > > >     /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64              \
> > > > >     -accel kvm -machine virt,gic-version=host                            \
> > > > >        :                                                                 \
> > > > >     -netdev tap,id=vnet0,vhost=on                                        \
> > > > >     -device virtio-net-pci,bus=pcie.8,netdev=vnet0,mac=52:54:00:f1:26:b0 \
> > > > > 
> > > > >     [   19.993158] virtio_net virtio1: output.0:id 135 is not a head!
> > > > > 
> > > > > Fix the issue by replacing virtio_wmb(vq->weak_barriers) with stronger
> > > > > virtio_mb(false), equivalent to replaced 'dmb' by 'dsb' instruction on
> > > > > ARM64. It should work for other architectures, but performance loss is
> > > > > expected.
> > > > > 
> > > > > Cc: stable@vger.kernel.org
> > > > > Reported-by: Yihuang Yu <yihyu@redhat.com>
> > > > > Signed-off-by: Gavin Shan <gshan@redhat.com>
> > > > > ---
> > > > >    drivers/virtio/virtio_ring.c | 12 +++++++++---
> > > > >    1 file changed, 9 insertions(+), 3 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > > > index 49299b1f9ec7..7d852811c912 100644
> > > > > --- a/drivers/virtio/virtio_ring.c
> > > > > +++ b/drivers/virtio/virtio_ring.c
> > > > > @@ -687,9 +687,15 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
> > > > >    	avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
> > > > >    	vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
> > > > > -	/* Descriptors and available array need to be set before we expose the
> > > > > -	 * new available array entries. */
> > > > > -	virtio_wmb(vq->weak_barriers);
> > > > > +	/*
> > > > > +	 * Descriptors and available array need to be set before we expose
> > > > > +	 * the new available array entries. virtio_wmb() should be enough
> > > > > +	 * to ensuere the order theoretically. However, a stronger barrier
> > > > > +	 * is needed by ARM64. Otherwise, the stale data can be observed
> > > > > +	 * by the host (vhost). A stronger barrier should work for other
> > > > > +	 * architectures, but performance loss is expected.
> > > > > +	 */
> > > > > +	virtio_mb(false);
> > > > 
> > > > 
> > > > I don't get what is going on here. Any explanation why virtio_wmb is not
> > > > enough besides "it does not work"?
> > > > 
> > > 
> > > The change is replacing instruction "dmb" with "dsb". "dsb" is stronger barrier
> > > than "dmb" because "dsb" ensures that all memory accesses raised before this
> > > instruction is completed when the 'dsb' instruction completes. However, "dmb"
> > > doesn't guarantee the order of completion of the memory accesses.
> > > 
> > > So 'vq->split.vring.avail->idx = cpu_to_virtio(_vq->vdev, vq->split.avail_idx_shadow)'
> > > can be completed before 'vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head)'.
> > 
> > Completed as observed by which CPU?
> > We have 2 writes that we want observed by another CPU in order.
> > So if CPU observes a new value of idx we want it to see
> > new value in ring.
> > This is standard use of smp_wmb()
> > How are these 2 writes different?
> > 
> > What DMB does, is that is seems to ensure that effects
> > of 'vq->split.vring.avail->idx = cpu_to_virtio(_vq->vdev, vq->split.avail_idx_shadow)'
> > are observed after effects of
> > 'vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head)'.
> > 
> > 
> 
> Completed as observed by the CPU where vhost worker is running. I don't think DMB
> does the work here. If I'm understanding correctly, DMB ensures the order of these
> two writes from the local CPU's standpoint.

No this makes no sense at all. All memory accesses are in order from
local CPU standpoint.

> The written data can be stored in local
> CPU's cache, not flushed to DRAM and propogated to the cache of the far CPU where
> vhost worker is running. So DMB isn't ensuring the write data is observed from the
> far CPU.

No but it has to ensure *ordering*. So if index is oberved then ring
is observed too because there is a MB there when reading.


> DSB ensures that the written data is observable from the far CPU immediately.




> > 
> > 
> > > The stronger barrier 'dsb' ensures the completion order as we expected.
> > > 
> > >      virtio_wmb(true)         virt_mb(false)
> > >        virt_wmb                 mb
> > >          __smp_wmb               __mb
> > >            dmb(ishst)              dsb(sy)
> > 
> > First, why would you want a non smp barrier when you are
> > synchronizing with another CPU? This is what smp_ means ...
> > 
> > 
> > > Extraced from ARMv9 specificaton
> > > ================================
> > > The DMB instruction is a memory barrier instruction that ensures the relative
> > > order of memory accesses before the barrier with memory accesses after the
> > > barrier. The DMB instruction _does not_ ensure the completion of any of the
> > > memory accesses for which it ensures relative order.
> > 
> > Isn't this exactly what we need?
> > 
> 
> I don't think so. DMB gurantees the order of EXECUTION, but DSB gurantees the
> order of COMPLETION. After the data store is executed, the written data can
> be stored in local CPU's cache, far from completion. Only the instruction is
> completed, the written data is synchronized to the far CPU where vhost worker
> is running.
> 
> Here is another paper talking about the difference between DMB and DSB. It's
> explaining the difference between DMB/DSB better than ARMv9 specification.
> However, it's hard for us to understand DMB/DSB work from the hardware level
> based on the specification and paper.
> 
> https://ipads.se.sjtu.edu.cn/_media/publications/liuppopp20.pdf
> (section 2.2  Order-preserving Options)
> (I'm extracting the relevant part as below)
> 
> Data Memory Barrier (DMB) prevents reordering of memory accesses across the barrier.
> Instead of waiting for previous accesses to become observable in the specified domain,
> DMB only maintains the relative order between memory accesses. Meanwhile, DMB does
> not block any non-memory access operations.
> 
> Data Synchronization Barrier (DSB) prevents reordering of any instructions across
> the barrier. DSB will make sure that all masters in the specified domain can observe
> the previous operations before issuing any subsequent instructions.
> 

What you are describing is that smp_wmb is buggy on this platform.
Poossible but are you sure?
Write a small test and check.
Leave virtio alone.


> > > A DSB instruction is a memory barrier that ensures that memory accesses that
> > > occur before the DSB instruction have __completed__ before the completion of
> > > the DSB instruction.
> > 
> > This seems appropriate for when you want to order things more
> > strongly. I do not get why it's necessary here.
> > 
> 
> Please refer to above explanations.
> 
> > > In doing this, it acts as a stronger barrier than a DMB
> > > and all ordering that is created by a DMB with specific options is also generated
> > > by a DSB with the same options.
> > > 
> > > > >    	vq->split.avail_idx_shadow++;
> > > > >    	vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
> > > > >    						vq->split.avail_idx_shadow);
> > > > > -- 
> > > > > 2.44.0
> > > > 
> 
> Thanks,
> Gavin


