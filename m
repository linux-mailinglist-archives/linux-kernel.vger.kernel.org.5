Return-Path: <linux-kernel+bounces-108005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1248804B8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 373B4285252
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627E7383A0;
	Tue, 19 Mar 2024 18:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rDbrMCe1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D905374F2;
	Tue, 19 Mar 2024 18:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710872577; cv=none; b=T4mcEM87yWFbiKAZS5lMd2ySxnwVxkwAUznMg1cg8LEvyocbjKny0p3v2le1aGiZDGbrk0VC6zINZwNOswQh8DfWLQiX1VvyPAwOmY3u0pTHzwn/2zBKKk1iVC7CR97cKeKjlGPiZCLLBXLJ4UAdadNkq38APdtAQZzqnt6RFE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710872577; c=relaxed/simple;
	bh=T/xW9xACdijAKdAsTAcfOoYLNSPzlFzEkZf6uy18UYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jH7CBn+z7OeRnSxRlO0mqKc4uYaaEdMyqN5AjFBQqf1op1g7EQR5SkOSF/4jRQ7+7gUU12j5NGpGVSZLyH1LAvR14mJ43pkNHRzH/D41RK7AmXGMMe5COLfYCEXDJ8N4/9+3q6MJQLgS19syldlOZQEBSUYGrQdWEsXC96xVtao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rDbrMCe1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBCB6C43390;
	Tue, 19 Mar 2024 18:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710872576;
	bh=T/xW9xACdijAKdAsTAcfOoYLNSPzlFzEkZf6uy18UYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rDbrMCe1KWxt3v/BQGVS9s1d03mwvHYcCBlT2CGLZelWwqbOd4jcvfiEpUbmnti9u
	 x2ThGrn9ImJQ+iQXzvdCo0i0xRcwl22auO9S8+/URavirztZprUPknHUQTqNoov63g
	 4NMMkghdb207xs1Fig/CIXKZ8buqdnXSg9IHr8KzuTB/8Wt+stdfsEfLGjpZpUKbp+
	 6V5HQWcP0TOboD6EyHmdyAx8G3vFBETm99hdEJ7o0QUhC1bdygmUR+Y/iMx4mkuZl2
	 9H9Wb0DoxAukmvXYqIFwKFV3POZ1g4Qb7whpPQGMtRmYxEb8kTLjRg61/POb5e8KHw
	 coNmgm7TQ5n8Q==
Date: Tue, 19 Mar 2024 18:22:51 +0000
From: Will Deacon <will@kernel.org>
To: Gavin Shan <gshan@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	yihyu@redhat.com, shan.gavin@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>, mochs@nvidia.com
Subject: Re: [PATCH] virtio_ring: Fix the stale index in available ring
Message-ID: <20240319182251.GB3121@willie-the-truck>
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
User-Agent: Mutt/1.10.1 (2018-07-13)

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

It's pretty weird that __dma_mb() is "broken" but __smp_mb() "works". How
confident are you in that result?

Will

