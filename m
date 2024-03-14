Return-Path: <linux-kernel+bounces-103196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAA287BC35
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 12:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFCA6B2137E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61716EB76;
	Thu, 14 Mar 2024 11:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ESgZLNwN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D609F433C0
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 11:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710417030; cv=none; b=KMzVpvUb/qXHEdT2ZCmOJWPD6sRM/p1WFPh/CLEbxiVQ+bFxpxp8Tu3Gl4l/oxfPbcjCt7DGzqMwBTxX00YSJ5Vii7ckWv3KKjzbH+e9nvAAxMwiqWxCI3jrcl9uigYRpWuzapZLLTDC9TI/yPaiiG5WzvpGnaf2WtMDR037SX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710417030; c=relaxed/simple;
	bh=HKRn+9y+a3/rYvZ3ESCh1LVIrsTcWcf9pLYDRmbMyvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ro6rCtl5PyijdauWvXLD1PlisFo36JL10s52g/LBnRo4wjR+4s1RkuRfVLtNV4sfozFHhOhFjaB2QYasmJBLVDv4fX8bSMewhxrBwqbeCkVaJViJV+8fFrcXiWp0q4sbv54+r/k/Vqrq0WrNKRnBmRrvyADtOe++LzbYtuDpMAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ESgZLNwN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710417027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O2unAqCq7zZuuI1ZYRAH4h5wote2AeO/niw40LSxCFo=;
	b=ESgZLNwNFKspSfWW/tdDwJGTcemmdCbFIzp094QAKQTcHlcEBeVY2oHSLo3orEG7d+7c4L
	DHuimb6tVh2o8rWlygYbGwuDZdmSW4tYV7FXocDynHbiu4uYwCG3bj2LrOSGKAU/WI8CNt
	BKJuLMbs9sijktf3O+ErGiJyudEpESY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-qed2lTeON8CbeAiV4sUXWw-1; Thu, 14 Mar 2024 07:50:26 -0400
X-MC-Unique: qed2lTeON8CbeAiV4sUXWw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33e78c1b314so430333f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 04:50:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710417025; x=1711021825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O2unAqCq7zZuuI1ZYRAH4h5wote2AeO/niw40LSxCFo=;
        b=dQZFzj3rcjj9sqFgkfByE54euJAzkW9MfGRRneM1a71ieFWuXlw9XHJJD2Dlgfapuv
         ZXhHzspP2pVYffK9+KJX/a8+cdFdf7EHRKJGyNDjpYOG0YH+nfnQu22xuAvMxduUTFfU
         5mN4Klk2gfC2XwCLjFYZ1rmTLveumPheC7vLDbSNNRDvprfsgtETkqinNYKbqlCqlvZU
         n3yI5NNjmo/OYEDpX3cE+X7STccz4Fx2WSQ8LN6roKN2jN4GdkMEyGdrJhoF5hwpzGr6
         8msXP39Aiue5OCm4/uye2Xmk7OSv4omWiNOjqh7anb3b8YfQTbsTuNc1JThEPQ044Fx4
         0ORQ==
X-Forwarded-Encrypted: i=1; AJvYcCWe+fyWxZW9ggBhykgRDtL5LtVmIGig5orwYegjAJ4UmGKPaSOSUYIyrPu+T6BF4/QWBxdZPPAMKiwFl9P/pgFCcBjvuEikDNOWjIRi
X-Gm-Message-State: AOJu0YxSAW2eMRW4g01GRAhPHDtSJq32scZW3Gcmh9dauYw95MinBGtx
	H/5A8xt7cXlp4VXICIfR9EXQG9CeJSkZT21afjdcrWdqiKZnRVXau/VU2ohqFxsYZEQUONG8/o0
	zC4XT+HdgtGR8W7cYP9sdzpbapKUM9L9o1a2P9yLVLqsIwA4kIVbdZposW392Gw==
X-Received: by 2002:a05:600c:1c89:b0:413:1047:362f with SMTP id k9-20020a05600c1c8900b004131047362fmr1397175wms.30.1710417025087;
        Thu, 14 Mar 2024 04:50:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJLLDY0RyHbIH1gFJUzQ32Tf6XFj1+IC9BnOXJcgAK7I7BmfcwPWrV4fkL4c6OxDwa5aQ+0Q==
X-Received: by 2002:a05:600c:1c89:b0:413:1047:362f with SMTP id k9-20020a05600c1c8900b004131047362fmr1397136wms.30.1710417024344;
        Thu, 14 Mar 2024 04:50:24 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f0:532c:5ae4:fce6:76e1:fa1a])
        by smtp.gmail.com with ESMTPSA id z14-20020a05600c0a0e00b00413ebce316fsm2246588wmp.0.2024.03.14.04.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 04:50:23 -0700 (PDT)
Date: Thu, 14 Mar 2024 07:50:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, yihyu@redhat.com,
	shan.gavin@gmail.com
Subject: Re: [PATCH] virtio_ring: Fix the stale index in available ring
Message-ID: <20240314074216-mutt-send-email-mst@kernel.org>
References: <20240314074923.426688-1-gshan@redhat.com>
 <20240314040443-mutt-send-email-mst@kernel.org>
 <9b148de7-b687-4d10-b177-5608b8dc7046@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b148de7-b687-4d10-b177-5608b8dc7046@redhat.com>

On Thu, Mar 14, 2024 at 08:15:22PM +1000, Gavin Shan wrote:
> On 3/14/24 18:05, Michael S. Tsirkin wrote:
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
> > 
> > 
> > I don't get what is going on here. Any explanation why virtio_wmb is not
> > enough besides "it does not work"?
> > 
> 
> The change is replacing instruction "dmb" with "dsb". "dsb" is stronger barrier
> than "dmb" because "dsb" ensures that all memory accesses raised before this
> instruction is completed when the 'dsb' instruction completes. However, "dmb"
> doesn't guarantee the order of completion of the memory accesses.
>
> So 'vq->split.vring.avail->idx = cpu_to_virtio(_vq->vdev, vq->split.avail_idx_shadow)'
> can be completed before 'vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head)'.

Completed as observed by which CPU?
We have 2 writes that we want observed by another CPU in order.
So if CPU observes a new value of idx we want it to see
new value in ring.
This is standard use of smp_wmb()
How are these 2 writes different?

What DMB does, is that is seems to ensure that effects
of 'vq->split.vring.avail->idx = cpu_to_virtio(_vq->vdev, vq->split.avail_idx_shadow)'
are observed after effects of
'vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head)'.




> The stronger barrier 'dsb' ensures the completion order as we expected.
> 
>     virtio_wmb(true)         virt_mb(false)
>       virt_wmb                 mb
>         __smp_wmb               __mb
>           dmb(ishst)              dsb(sy)

First, why would you want a non smp barrier when you are
synchronizing with another CPU? This is what smp_ means ...


> Extraced from ARMv9 specificaton
> ================================
> The DMB instruction is a memory barrier instruction that ensures the relative
> order of memory accesses before the barrier with memory accesses after the
> barrier. The DMB instruction _does not_ ensure the completion of any of the
> memory accesses for which it ensures relative order.

Isn't this exactly what we need?

> A DSB instruction is a memory barrier that ensures that memory accesses that
> occur before the DSB instruction have __completed__ before the completion of
> the DSB instruction.

This seems appropriate for when you want to order things more
strongly. I do not get why it's necessary here.

> In doing this, it acts as a stronger barrier than a DMB
> and all ordering that is created by a DMB with specific options is also generated
> by a DSB with the same options.
> 
> > >   	vq->split.avail_idx_shadow++;
> > >   	vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
> > >   						vq->split.avail_idx_shadow);
> > > -- 
> > > 2.44.0
> > 
> 
> Thanks,
> Gavin


