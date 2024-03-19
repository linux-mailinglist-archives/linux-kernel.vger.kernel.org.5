Return-Path: <linux-kernel+bounces-107264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3207E87FA21
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B83131F2207C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C997B3EB;
	Tue, 19 Mar 2024 08:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c2JuozIZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0611756441
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 08:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710838194; cv=none; b=fvaacG3DZZ3XS24VRmQ6eFMYVvIeoxO2m/wBHGqomYF1AGpqywoez+DW0RBnc2kF8Pxo8/cLWdEacQXOS9ruKDhtwy9WTnhOWzq+EtQaybNe7/6OE/m0ku2rxkvUmIEWtqccQ+HcJR2s+PoPJ+E5jCikB09cT6UbsIf6sFlkzZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710838194; c=relaxed/simple;
	bh=k20h/gra/8Yp7OXx8XlMFpX1tZP75XML8xy6RbIIqDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tw+ojts9lpCqJOHzJrvEidVkMaCIM4wGqoKHlRikUQlzyL+eWvwFMKqRhB5hqmb/Q4TV/BR2k6YfjQN0NEGhXmVF9eZ8EWtR6z742msfnpXRUBPFDUG8gwKcPBoKqSq68XoQM0gF6kINu7EdtYdLfN9jW7eAorWmPSk6vFgH6eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c2JuozIZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710838191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/WohdgPgBQLxOCq0Jnnwxvvgxi6wjhKyeRiLGXAYd2s=;
	b=c2JuozIZoKvD2UppWKyQ7hh7j46R7ecHWeZzn8A45I4SAYPVadrt3RyaTkhLuWUpvOhXA8
	i7+q7VnwPdOemTJPrZJQ4g++AZevHDkieHCP03jjrGMKbMONerXYuy96FfJF4IjFb/92bv
	yUgDIyw2k1rBBdNNVec4/TqWhT94aP8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-9jKHFu40M7aSGXJyQe66Lw-1; Tue, 19 Mar 2024 04:49:50 -0400
X-MC-Unique: 9jKHFu40M7aSGXJyQe66Lw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4140edcb197so11461605e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 01:49:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710838189; x=1711442989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/WohdgPgBQLxOCq0Jnnwxvvgxi6wjhKyeRiLGXAYd2s=;
        b=lRmmlhGhRysrFo6UgAcTNQ9PykayAA162wSdbLDl7BWPENqHX1gIaU3jKQvj5CByDj
         J+13QGre5K3EYpZVNv2AdQbdPEwxWln6/xpagNc6AFUVfip5hYZU82y128Q6fOwBV9qX
         jSbFvtWTbhR8w7uGZMgtvSsa6xl9NQbsy9TofvU0kWtyiJi8sEqT5EHhAZzEgDYq/DlJ
         y+lzO3UvHvkPlqNl4sZlRpXH/l5eiJgpKjGzDNbwYsSkUxiDUsKCNlqDls9sAPCnA+Kq
         sDm7QvpvulCrHGVnZeZCqwYazRuwMS9oHRBFTDdwLU52veof5xl5ulXl3kuaR1ZvpsHo
         XolA==
X-Forwarded-Encrypted: i=1; AJvYcCW/yEOQ22GlmA5U+tTvFzv1abGJCrf0ADz0B7Vs10Yoxl9MrRbVkE9lGvocbzEuane4spiIKGKHMC2kTfHYE/mkAay3OjpZrprqE0na
X-Gm-Message-State: AOJu0Yz8F+Ph5apGZfCKgLHFDn+OWiRCZcYPnZNG7PTmySLtOwM3Jpcj
	vVjvADzHI9Tmq8i+sLdB+L/5D600Ki+Klkc/+R4YBzo4G4heVuTChiAtc3SF72u8t95nM0Ugpdx
	Mv/HNLT+XL6bLw4f8bGl0FRdu9WG6W5t7Q8Sy26ubsvaUy/ca6mrOix+kOHGuxQ==
X-Received: by 2002:a05:600c:4f0e:b0:414:1363:53a4 with SMTP id l14-20020a05600c4f0e00b00414136353a4mr2982555wmq.15.1710838189081;
        Tue, 19 Mar 2024 01:49:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2vmirEEIpmgvouK03uixipQW7NF0Cv3jiRA56Jl0MaFtjCJ6YaTZjGRO7zI4YB0gF25PTYw==
X-Received: by 2002:a05:600c:4f0e:b0:414:1363:53a4 with SMTP id l14-20020a05600c4f0e00b00414136353a4mr2982539wmq.15.1710838188518;
        Tue, 19 Mar 2024 01:49:48 -0700 (PDT)
Received: from redhat.com ([2.52.6.254])
        by smtp.gmail.com with ESMTPSA id l12-20020a05600c4f0c00b0041409d4841dsm9292994wmq.33.2024.03.19.01.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 01:49:47 -0700 (PDT)
Date: Tue, 19 Mar 2024 04:49:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: Will Deacon <will@kernel.org>, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, yihyu@redhat.com, shan.gavin@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>, mochs@nvidia.com
Subject: Re: [PATCH] virtio_ring: Fix the stale index in available ring
Message-ID: <20240319043045-mutt-send-email-mst@kernel.org>
References: <20240314074923.426688-1-gshan@redhat.com>
 <20240318165924.GA1824@willie-the-truck>
 <35a6bcef-27cf-4626-a41d-9ec0a338fe28@redhat.com>
 <20240319020905-mutt-send-email-mst@kernel.org>
 <9b3030d1-cb2c-4ce0-8b24-1074b616fc84@redhat.com>
 <20240319024025-mutt-send-email-mst@kernel.org>
 <d8387677-7025-4daa-b8b5-5a8f24a671d5@redhat.com>
 <20240319030505-mutt-send-email-mst@kernel.org>
 <e582f248-28e9-4d0b-aa5d-26b82cd96a68@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e582f248-28e9-4d0b-aa5d-26b82cd96a68@redhat.com>

On Tue, Mar 19, 2024 at 06:08:27PM +1000, Gavin Shan wrote:
> On 3/19/24 17:09, Michael S. Tsirkin wrote:
> > On Tue, Mar 19, 2024 at 04:49:50PM +1000, Gavin Shan wrote:
> > > 
> > > On 3/19/24 16:43, Michael S. Tsirkin wrote:
> > > > On Tue, Mar 19, 2024 at 04:38:49PM +1000, Gavin Shan wrote:
> > > > > On 3/19/24 16:09, Michael S. Tsirkin wrote:
> > > > > 
> > > > > > > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > > > > > > > index 49299b1f9ec7..7d852811c912 100644
> > > > > > > > > --- a/drivers/virtio/virtio_ring.c
> > > > > > > > > +++ b/drivers/virtio/virtio_ring.c
> > > > > > > > > @@ -687,9 +687,15 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
> > > > > > > > >      	avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
> > > > > > > > >      	vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
> > > > > > > > > -	/* Descriptors and available array need to be set before we expose the
> > > > > > > > > -	 * new available array entries. */
> > > > > > > > > -	virtio_wmb(vq->weak_barriers);
> > > > > > > > > +	/*
> > > > > > > > > +	 * Descriptors and available array need to be set before we expose
> > > > > > > > > +	 * the new available array entries. virtio_wmb() should be enough
> > > > > > > > > +	 * to ensuere the order theoretically. However, a stronger barrier
> > > > > > > > > +	 * is needed by ARM64. Otherwise, the stale data can be observed
> > > > > > > > > +	 * by the host (vhost). A stronger barrier should work for other
> > > > > > > > > +	 * architectures, but performance loss is expected.
> > > > > > > > > +	 */
> > > > > > > > > +	virtio_mb(false);
> > > > > > > > >      	vq->split.avail_idx_shadow++;
> > > > > > > > >      	vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
> > > > > > > > >      						vq->split.avail_idx_shadow);
> > > > > > > > 
> > > > > > > > Replacing a DMB with a DSB is _very_ unlikely to be the correct solution
> > > > > > > > here, especially when ordering accesses to coherent memory.
> > > > > > > > 
> > > > > > > > In practice, either the larger timing different from the DSB or the fact
> > > > > > > > that you're going from a Store->Store barrier to a full barrier is what
> > > > > > > > makes things "work" for you. Have you tried, for example, a DMB SY
> > > > > > > > (e.g. via __smb_mb()).
> > > > > > > > 
> > > > > > > > We definitely shouldn't take changes like this without a proper
> > > > > > > > explanation of what is going on.
> > > > > > > > 
> > > > > > > 
> > > > > > > Thanks for your comments, Will.
> > > > > > > 
> > > > > > > Yes, DMB should work for us. However, it seems this instruction has issues on
> > > > > > > NVidia's grace-hopper. It's hard for me to understand how DMB and DSB works
> > > > > > > from hardware level. I agree it's not the solution to replace DMB with DSB
> > > > > > > before we fully understand the root cause.
> > > > > > > 
> > > > > > > I tried the possible replacement like below. __smp_mb() can avoid the issue like
> > > > > > > __mb() does. __ndelay(10) can avoid the issue, but __ndelay(9) doesn't.
> > > > > > > 
> > > > > > > static inline int virtqueue_add_split(struct virtqueue *_vq, ...)
> > > > > > > {
> > > > > > >        :
> > > > > > >            /* Put entry in available array (but don't update avail->idx until they
> > > > > > >             * do sync). */
> > > > > > >            avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
> > > > > > >            vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
> > > > > > > 
> > > > > > >            /* Descriptors and available array need to be set before we expose the
> > > > > > >             * new available array entries. */
> > > > > > >            // Broken: virtio_wmb(vq->weak_barriers);
> > > > > > >            // Broken: __dma_mb();
> > > > > > >            // Work:   __mb();
> > > > > > >            // Work:   __smp_mb();
> > > > > > >            // Work:   __ndelay(100);
> > > > > > >            // Work:   __ndelay(10);
> > > > > > >            // Broken: __ndelay(9);
> > > > > > > 
> > > > > > >           vq->split.avail_idx_shadow++;
> > > > > > >            vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
> > > > > > >                                                    vq->split.avail_idx_shadow);
> > > > > > 
> > > > > > What if you stick __ndelay here?
> > > > > > 
> > > > > 
> > > > >          /* Put entry in available array (but don't update avail->idx until they
> > > > >            * do sync). */
> > > > >           avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
> > > > >           vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
> > > > > 
> > > > >           /* Descriptors and available array need to be set before we expose the
> > > > >            * new available array entries. */
> > > > >           virtio_wmb(vq->weak_barriers);
> > > > >           vq->split.avail_idx_shadow++;
> > > > >           vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
> > > > >                                                   vq->split.avail_idx_shadow);
> > > > >           /* Try __ndelay(x) here as Michael suggested
> > > > >            *
> > > > >            * Work:      __ndelay(200);    possiblly make it hard to reproduce
> > > > >            * Broken:    __ndelay(100);
> > > > >            * Broken:    __ndelay(20);
> > > > >            * Broken:    __ndelay(10);
> > > > >            */
> > > > >           __ndelay(200);
> > > > 
> > > > So we see that just changing the timing masks the race.
> > > > What are you using on the host side? vhost or qemu?
> > > > 
> > > 
> > > __ndelay(200) may make the issue harder to be reproduce as I understand.
> > > More delays here will give vhost relief, reducing the race.
> > > 
> > > The issue is only reproducible when vhost is turned on. Otherwise, we
> > > aren't able to hit the issue.
> > > 
> > >     -netdev tap,id=vnet0,vhost=true,script=/etc/qemu-ifup,downscript=/etc/qemu-ifdown \
> > >     -device virtio-net-pci,bus=pcie.8,netdev=vnet0,mac=52:54:00:f1:26:b0
> > 
> > 
> > Given it's vhost, it's also possible that the issue is host side.
> > I wonder what happens if we stick a delay or a stronger barrier
> > in vhost.c - either here:
> > 
> >          /* Make sure buffer is written before we update index. */
> >          smp_wmb();
> > 
> > 
> > or here:
> > 
> >                  /* Only get avail ring entries after they have been
> >                   * exposed by guest.
> >                   */
> >                  smp_rmb();
> > 
> > ?
> > 
> 
> It's possible. However, I still can hit the issue after both of them are
> replaed with '__mb()'. So the issue seems on the guest side, where the
> written data isn't observed in time by the CPU on far end (for vhost worker).
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 045f666b4f12..327b68d21b02 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2529,7 +2529,8 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
>                 /* Only get avail ring entries after they have been
>                  * exposed by guest.
>                  */
> -               smp_rmb();
> +               // smp_rmb();
> +               __mb();
>         }
>         /* Grab the next descriptor number they're advertising, and increment
> @@ -2703,7 +2704,9 @@ int vhost_add_used_n(struct vhost_virtqueue *vq, struct vring_used_elem *heads,
>         r = __vhost_add_used_n(vq, heads, count);
>         /* Make sure buffer is written before we update index. */
> -       smp_wmb();
> +       // smp_wmb();
> +       __mb();
> +
> 
> From the guest:
> 
> [   14.102608] virtio_net virtio0: output.0:id 80 is not a head!


You realize however that for that to happen, first vhost has to
use the wrong index?
Again the fact tweaking code helps is suggestive but does
not lead us to the root cause.

So you should be able to detect the bad index when vhost gets it.
Here's a suggestion: stick a valid flag in desc.
then vhost should notice if it gets a desc with that flag clear.
Like this maybe?


diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 6f7e5010a673..2789e51b57e6 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -524,7 +524,7 @@ static inline unsigned int virtqueue_add_desc_split(struct virtqueue *vq,
 	struct vring_desc_extra *extra = vring->split.desc_extra;
 	u16 next;
 
-	desc[i].flags = cpu_to_virtio16(vq->vdev, flags);
+	desc[i].flags = cpu_to_virtio16(vq->vdev, flags | (0x1 << 5)); /* Mark it valid */
 	desc[i].addr = cpu_to_virtio64(vq->vdev, addr);
 	desc[i].len = cpu_to_virtio32(vq->vdev, len);
 
@@ -721,6 +721,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 			i = virtio16_to_cpu(_vq->vdev, desc[i].next);
 		} else
 			i = vring_unmap_one_split(vq, i);
+		desc[i].flags = 0x0;
 	}
 
 free_indirect:
@@ -775,11 +776,13 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 	i = head;
 
 	while (vq->split.vring.desc[i].flags & nextflag) {
+		vq->split.vring.desc[i].flags = 0x0;
 		vring_unmap_one_split(vq, i);
 		i = vq->split.desc_extra[i].next;
 		vq->vq.num_free++;
 	}
 
+	vq->split.vring.desc[i].flags = 0x0;
 	vring_unmap_one_split(vq, i);
 	vq->split.desc_extra[i].next = vq->free_head;
 	vq->free_head = head;


