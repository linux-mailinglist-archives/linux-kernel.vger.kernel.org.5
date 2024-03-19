Return-Path: <linux-kernel+bounces-107234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E1E87F9BD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB31B282623
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A649254792;
	Tue, 19 Mar 2024 08:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JhzpgrA/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDC054672
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 08:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710836899; cv=none; b=ogfcmsaxVWkBBw2v1Qpnkd9cWaOkL3SH7lnAUltwCHtvVtE7sWj1VCv+onUTf39s0tErCLeyVxvvNyczQBFT9786IgZ9S3uF+ABymVerRDTaXdK2LRyalmLUyTnIuDPfyVaNBL3KHqugk9iuuV2jdiqnId6VDlFzGgdafQoJIZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710836899; c=relaxed/simple;
	bh=+xJo6B2RUfy6w3seqt7BSg8FYfwp1yJGm7MHWDDAG1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OBwmEoB+qY0oAUFAgt5wedkZlxZd21S2a2NgT0d1xG8teFCqBvop1N6resTljLROVoDTQ2pjZnP28YMpH46Y/O74AbdesiwYKUzthWiA83mKujCBoB0hZ1UAFFTLjiFI5sqh12Z/1WEYuVVEkdpH/8SX0xnUyY6fLRWkvARqi5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JhzpgrA/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710836896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CB0QtuwNQuGoMD7qtCWhc1XdgMcxMk46b8pSVshJge8=;
	b=JhzpgrA/RxV2fqtu8anZ5d/3SxLTXtUcyiwZm0EWlN2aIlwSfCAf/bmQMasGSVVxV/iDjV
	pH2Eb/FYB26NlvWf34yHnh1x1tF6riX54pX9MFDQRPHY4WwfuctEaBHE9Op1+Rdy9+ADB8
	TumKzpDkrMZs9V96lWqo5vlhZ/bhd18=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-UwfJ7S-lO9uOQiZSS45Jnw-1; Tue, 19 Mar 2024 04:28:14 -0400
X-MC-Unique: UwfJ7S-lO9uOQiZSS45Jnw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4140225e68aso18808785e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 01:28:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710836893; x=1711441693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CB0QtuwNQuGoMD7qtCWhc1XdgMcxMk46b8pSVshJge8=;
        b=YSpmrRt2OBAp+4ZhbP1vhO7xz8C/xS/CnFXTxW9Swy2PyC7YDUPU3wcxA6Jbf2e6qd
         V4e5STDtquZBCssUnaJeKjjOmqS1CUZiLPHtF5XpkCGN6k6SEO+CvAJv0tV30zWL4KvA
         rS1dndNpxZNn+LgUDiHhdeBM57OuKGWeaO6GWrJzxwqRYmwwoQAleAY9ej00LMbj1C4e
         q+clWjWEAaooSTTCyBpiHTnr7xxTcCG3Jy+t++KYrKeHABC0oQCxVyCTeZSfYDFwUJBj
         0RIT2sCDHpZGZQv9mEeyg7j57tescrG+slzARqHMkdflzFYDkguYl4GOdFnTiEKT6YEw
         iUoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFWi3D+9EvN5ohdtvzg75fTgrUrfgO3+pSw7DsaRG+U+dzaR2dneH0lhAD1AJ+vD3dzXdNfWDbKrUsL4eQNIF7APQQ4wzv/n8HccIv
X-Gm-Message-State: AOJu0YyFNM50xiEozZ3MY+BKGyuqwhkaVCUHFZsJwbUOCUdcEQxZeBnV
	GJ5DFw2A2i0pYyrgHwF7eSYOnaSN0dbPAeYkmzzseFauacvTrEQeCy2U8VvlwAq9cWUWNlZG5te
	fNQTGKoLXQUYmb0ljbFH2+bQuxYnjYlOgilw/C/fjIp6gwyXDWMZ5Mj7HxArL/w==
X-Received: by 2002:a05:600c:358a:b0:414:22b5:c33a with SMTP id p10-20020a05600c358a00b0041422b5c33amr2168375wmq.1.1710836893038;
        Tue, 19 Mar 2024 01:28:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqzZ3RSqI5aruFYvzTdmxlY7UT5zKZE8Kju5PdfFuBjeOEHAE4vfQF7dVW+EegfweCjpcAiA==
X-Received: by 2002:a05:600c:358a:b0:414:22b5:c33a with SMTP id p10-20020a05600c358a00b0041422b5c33amr2168349wmq.1.1710836892497;
        Tue, 19 Mar 2024 01:28:12 -0700 (PDT)
Received: from redhat.com ([2.52.6.254])
        by smtp.gmail.com with ESMTPSA id w9-20020a05600c474900b0041408af4b34sm9936953wmo.10.2024.03.19.01.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 01:28:11 -0700 (PDT)
Date: Tue, 19 Mar 2024 04:28:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: Will Deacon <will@kernel.org>, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, yihyu@redhat.com, shan.gavin@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>, mochs@nvidia.com
Subject: Re: [PATCH] virtio_ring: Fix the stale index in available ring
Message-ID: <20240319034110-mutt-send-email-mst@kernel.org>
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


> __wmb() works either. No issue found with it.

So this is 
arch/arm64/include/asm/barrier.h:#define __smp_wmb()    dmb(ishst)

versus

arch/arm64/include/asm/barrier.h:#define __wmb()                dsb(st)


right?

Really interesting. And you are saying dma_wmb does not work either:

arch/arm64/include/asm/barrier.h:#define __dma_wmb()    dmb(oshst)


Really strange.




However I found this:
https://developer.arm.com/documentation/den0024/a/Memory-Ordering/Memory-attributes/Cacheable-and-shareable-memory-attributes



Going by this picture, all CPUs are in the innner shareable domain so
ishst should be enough to synchronize, right?


However, there are two points that give me pause here:


Inner shareable
This represents a shareability domain that can be shared by multiple
processors, but not necessarily all of the agents in the system. A
system might have multiple Inner Shareable domains. An operation that
affects one Inner Shareable domain does not affect other Inner Shareable
domains in the system. An example of such a domain might be a quad-core
Cortex-A57 cluster.


Point 1 - so is it possible that there are multiple inner
shareable domains in this system? With vhost running
inside one and guest inside another? Anyone knows if that
is the case on nvidia grace hopper and how to find out?



Outer shareable
An outer shareable (OSH) domain re-order is shared by multiple agents and
can consist of one or more inner shareable domains. An operation that
affects an outer shareable domain also implicitly affects all inner
shareable domains inside it. However, it does not otherwise behave as an
inner shareable operation.


I do not get this last sentence. If it affects all inner domains then
how it "does not behave as an inner shareable operation"?






> 
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


