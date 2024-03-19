Return-Path: <linux-kernel+bounces-107065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D96A187F720
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 084B31C21C69
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7743C5B1E3;
	Tue, 19 Mar 2024 06:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UOQhMrRG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204E34597E
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 06:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710828582; cv=none; b=f9axoyb518IxiRVhDEjU/2bkCCIsJc5uW9x0THXjf1OZwUwDu+QLsH+BhxSjZ8IZEO6NytEnWJcAUPuSo/cekdeDtWycAK7nUvT2SWT5+hho+44rNaL7Sv/ySX889AN9QTF5U/B8bEK4Bo1EvkLjZ98N18ZY7oiYCCgZlkUO/yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710828582; c=relaxed/simple;
	bh=FaN2AkTW/1g3b49U2gJ5dKMIWrQenSLsL/3wj1y2eF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bvvaujnYdtePDSN00ikdbNbxjNbYG6F7qLHHEm0k+GdUSfWOEMUnB8X7iL69RtPFu+23n8LA2xoJm5wHj+PjrClDkwMku9seeEegy+TGoxpEHRlk27n2zQxlWr0tJIVQaSM5Jjb+3IAzfhkWQPQiwKyN90QcWaz4sWZd3clMX3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UOQhMrRG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710828578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4gAjOoqwe4WiMjHGtvLfdIjhk3lra6uGlC6+BOty9fk=;
	b=UOQhMrRGq/914+C516h2/ozemiAdeOpflCdM4Uo5hkpu3uWYQJFi4uATTf1b6CQdlF0fhJ
	0H/MUZAhNd+i3fhz/REnLwjEQmEVTKIA1YZ42ze+Mqh3XtLz4PnQdHtqUa/UEt42++8mnT
	Msis52U8/IfJ1AC/svNxgwJFhKoJ4t4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-SMtlbYHbOXeB9XWNUDAwQw-1; Tue, 19 Mar 2024 02:09:36 -0400
X-MC-Unique: SMtlbYHbOXeB9XWNUDAwQw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a466c77307eso471027966b.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 23:09:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710828575; x=1711433375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4gAjOoqwe4WiMjHGtvLfdIjhk3lra6uGlC6+BOty9fk=;
        b=D7c+QU6uNlAKqDjujTNWSSdh6YtHMcMCmytjNxaFb+bTmhqc+nO90qRdIz9khQx7DL
         9a4fo4+1Qf73giLdMFvb16QnCRbXDpxlcCUc+G8v7m59UtU/Fp9NdR2K8g5b8iYNhYbH
         VtMVOWYZjPKROWIlFnlMkh5PaA8bFEcrwhSgw+QVg1nJHoxL9uXvB9fCEJPOvI/g2/F+
         P5Dh3+hKHpFqpSxhBBipIFncl5/dSMVAGsxLfLUyqRV3vxIKXxpCs4soRI1lkyFeYS/r
         Ib9KLI6oBsWoivTz6ebJIGNrKMHiR0N3pR7FF01tXi9iLrNhh++qwhQoKY3Pgj73zbO2
         qdWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrhqdQ7vh2yAN5WEAYOVKebUm31sNmCqbEJcEvHIg/lopitLxpD59rqaeSdtQy+FFygWykabCcT0KhfNi/vCZqqxYoTFDSxPv9V0Ha
X-Gm-Message-State: AOJu0YzwYrJa/C1BlceR41R343kQutw3J7w2v6Gr78+y67tm1Z7O6zBV
	w4gwmydmDozh3JSr1lAmKr8VCdkXCKKS8pDnqPy3sT+AX7h6e8G/JOIxooyaWBET3RFlYd+FZb2
	nwfMBdwd4oTyJIhQkem4K+YnXqaiV8OAtGX6aoD1+6nGrSVRq3Jgtn61dnoKa5A==
X-Received: by 2002:a17:906:124b:b0:a46:ba8f:bcdc with SMTP id u11-20020a170906124b00b00a46ba8fbcdcmr1669818eja.8.1710828574816;
        Mon, 18 Mar 2024 23:09:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGw2+yzvjo1VeEiJREnOUKPOQ5D+EoiV8KYmOyYmQdeAA6iIav3ruMjKj36kIfnfcmj2dr5aA==
X-Received: by 2002:a17:906:124b:b0:a46:ba8f:bcdc with SMTP id u11-20020a170906124b00b00a46ba8fbcdcmr1669795eja.8.1710828574200;
        Mon, 18 Mar 2024 23:09:34 -0700 (PDT)
Received: from redhat.com ([2a02:14f:175:ca2b:adb0:2501:10a9:c4b2])
        by smtp.gmail.com with ESMTPSA id d10-20020a1709067f0a00b00a413d1eda4bsm5647087ejr.87.2024.03.18.23.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 23:09:33 -0700 (PDT)
Date: Tue, 19 Mar 2024 02:09:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: Will Deacon <will@kernel.org>, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, yihyu@redhat.com, shan.gavin@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>, mochs@nvidia.com
Subject: Re: [PATCH] virtio_ring: Fix the stale index in available ring
Message-ID: <20240319020905-mutt-send-email-mst@kernel.org>
References: <20240314074923.426688-1-gshan@redhat.com>
 <20240318165924.GA1824@willie-the-truck>
 <35a6bcef-27cf-4626-a41d-9ec0a338fe28@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35a6bcef-27cf-4626-a41d-9ec0a338fe28@redhat.com>

On Tue, Mar 19, 2024 at 02:59:23PM +1000, Gavin Shan wrote:
> On 3/19/24 02:59, Will Deacon wrote:
> > On Thu, Mar 14, 2024 at 05:49:23PM +1000, Gavin Shan wrote:
> > > The issue is reported by Yihuang Yu who have 'netperf' test on
> > > NVidia's grace-grace and grace-hopper machines. The 'netperf'
> > > client is started in the VM hosted by grace-hopper machine,
> > > while the 'netperf' server is running on grace-grace machine.
> > > 
> > > The VM is started with virtio-net and vhost has been enabled.
> > > We observe a error message spew from VM and then soft-lockup
> > > report. The error message indicates the data associated with
> > > the descriptor (index: 135) has been released, and the queue
> > > is marked as broken. It eventually leads to the endless effort
> > > to fetch free buffer (skb) in drivers/net/virtio_net.c::start_xmit()
> > > and soft-lockup. The stale index 135 is fetched from the available
> > > ring and published to the used ring by vhost, meaning we have
> > > disordred write to the available ring element and available index.
> > > 
> > >    /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64              \
> > >    -accel kvm -machine virt,gic-version=host                            \
> > >       :                                                                 \
> > >    -netdev tap,id=vnet0,vhost=on                                        \
> > >    -device virtio-net-pci,bus=pcie.8,netdev=vnet0,mac=52:54:00:f1:26:b0 \
> > > 
> > >    [   19.993158] virtio_net virtio1: output.0:id 135 is not a head!
> > > 
> > > Fix the issue by replacing virtio_wmb(vq->weak_barriers) with stronger
> > > virtio_mb(false), equivalent to replaced 'dmb' by 'dsb' instruction on
> > > ARM64. It should work for other architectures, but performance loss is
> > > expected.
> > > 
> > > Cc: stable@vger.kernel.org
> > > Reported-by: Yihuang Yu <yihyu@redhat.com>
> > > Signed-off-by: Gavin Shan <gshan@redhat.com>
> > > ---
> > >   drivers/virtio/virtio_ring.c | 12 +++++++++---
> > >   1 file changed, 9 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > index 49299b1f9ec7..7d852811c912 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -687,9 +687,15 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
> > >   	avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
> > >   	vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
> > > -	/* Descriptors and available array need to be set before we expose the
> > > -	 * new available array entries. */
> > > -	virtio_wmb(vq->weak_barriers);
> > > +	/*
> > > +	 * Descriptors and available array need to be set before we expose
> > > +	 * the new available array entries. virtio_wmb() should be enough
> > > +	 * to ensuere the order theoretically. However, a stronger barrier
> > > +	 * is needed by ARM64. Otherwise, the stale data can be observed
> > > +	 * by the host (vhost). A stronger barrier should work for other
> > > +	 * architectures, but performance loss is expected.
> > > +	 */
> > > +	virtio_mb(false);
> > >   	vq->split.avail_idx_shadow++;
> > >   	vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
> > >   						vq->split.avail_idx_shadow);
> > 
> > Replacing a DMB with a DSB is _very_ unlikely to be the correct solution
> > here, especially when ordering accesses to coherent memory.
> > 
> > In practice, either the larger timing different from the DSB or the fact
> > that you're going from a Store->Store barrier to a full barrier is what
> > makes things "work" for you. Have you tried, for example, a DMB SY
> > (e.g. via __smb_mb()).
> > 
> > We definitely shouldn't take changes like this without a proper
> > explanation of what is going on.
> > 
> 
> Thanks for your comments, Will.
> 
> Yes, DMB should work for us. However, it seems this instruction has issues on
> NVidia's grace-hopper. It's hard for me to understand how DMB and DSB works
> from hardware level. I agree it's not the solution to replace DMB with DSB
> before we fully understand the root cause.
> 
> I tried the possible replacement like below. __smp_mb() can avoid the issue like
> __mb() does. __ndelay(10) can avoid the issue, but __ndelay(9) doesn't.
> 
> static inline int virtqueue_add_split(struct virtqueue *_vq, ...)
> {
>     :
>         /* Put entry in available array (but don't update avail->idx until they
>          * do sync). */
>         avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
>         vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
> 
>         /* Descriptors and available array need to be set before we expose the
>          * new available array entries. */
>         // Broken: virtio_wmb(vq->weak_barriers);
>         // Broken: __dma_mb();
>         // Work:   __mb();
>         // Work:   __smp_mb();
>         // Work:   __ndelay(100);
>         // Work:   __ndelay(10);
>         // Broken: __ndelay(9);
> 
>        vq->split.avail_idx_shadow++;
>         vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
>                                                 vq->split.avail_idx_shadow);

What if you stick __ndelay here?


>         vq->num_added++;
> 
>         pr_debug("Added buffer head %i to %p\n", head, vq);
>         END_USE(vq);
>         :
> }
> 
> I also tried to measure the consumed time for various barrier-relative instructions using
> ktime_get_ns() which should have consumed most of the time. __smb_mb() is slower than
> __smp_wmb() but faster than __mb()
> 
>     Instruction           Range of used time in ns
>     ----------------------------------------------
>     __smp_wmb()           [32  1128032]
>     __smp_mb()            [32  1160096]
>     __mb()                [32  1162496]
> 
> Thanks,
> Gavin


