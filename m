Return-Path: <linux-kernel+bounces-108001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 489818804AE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C01D5284E9D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F78D3A8CB;
	Tue, 19 Mar 2024 18:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOjkjRAp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC06F3A1B7;
	Tue, 19 Mar 2024 18:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710872491; cv=none; b=Wnya0KRiSokjHTSCHYdvYVZ//k9niTwd+ApHJolSrllZ8jQjEk0ykGUU6qeZh8xdhOdyNSgNyEKRrVy3a1x0VZop8pWvFHmmHWhhxiQsNhhwex3Jcy5u5wfh3NhlXWOhXdLUBHiA8lasfui9xSoZByVUDxtPtjitueAEe5TAgac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710872491; c=relaxed/simple;
	bh=aD/VhLpbiA3vcXTWj5tF6nefydh1cXCm5/9qP5S2BSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pp6sky/Rj5J5NZluqB7LFnLLzBoF6LdXf8NpBx3AocuLEdNij4vNanS8OAM16a9J2U3mEIj3eIflXGk7Zat4HYeoTQ/wWoFmh4URFbJvDYM3biIOjQ7GwRp6WaWxe4Opa+NDZCPheDsymE5wuM/lwFJErWQvySOY0Aa+W89JgDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HOjkjRAp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 015D4C43390;
	Tue, 19 Mar 2024 18:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710872490;
	bh=aD/VhLpbiA3vcXTWj5tF6nefydh1cXCm5/9qP5S2BSw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HOjkjRApQsEMcD8/EU3bOuLQ1KoiBSQRcgsqPtCeo/Q6ZNDK9itubzQ5b9FpZ4nY1
	 EHSL6xcECUV0XhH7M/0BjqFgHUqKniHneY9HV8ThzLOM/ZFTDacutQuQkNyvQ8hDpg
	 hpGKQhN6pROh1QbqET4OSotLbs6GWi0+pJhcmpAKi8dAqiqIwlQm1kRq2pxthrqURQ
	 NgZ/GaJ803xu0ym2EvzF2M14UPC578wY04EDBbQS5WRv0ts4RDcVyIhVeMBHAS8U83
	 QsTasv/u14Nf47VNM1QyZjktx3npaNIO5+gEZ/EKn9RcuJHH6B8/uvcAIV5seBfXE7
	 QmqqkqiQwZG7g==
Date: Tue, 19 Mar 2024 18:21:25 +0000
From: Will Deacon <will@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Gavin Shan <gshan@redhat.com>, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, yihyu@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH] virtio_ring: Fix the stale index in available ring
Message-ID: <20240319182125.GA3121@willie-the-truck>
References: <20240314074923.426688-1-gshan@redhat.com>
 <20240318165924.GA1824@willie-the-truck>
 <20240319033016-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319033016-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Mar 19, 2024 at 03:36:31AM -0400, Michael S. Tsirkin wrote:
> On Mon, Mar 18, 2024 at 04:59:24PM +0000, Will Deacon wrote:
> > On Thu, Mar 14, 2024 at 05:49:23PM +1000, Gavin Shan wrote:
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > index 49299b1f9ec7..7d852811c912 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -687,9 +687,15 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
> > >  	avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
> > >  	vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
> > >  
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
> > >  	vq->split.avail_idx_shadow++;
> > >  	vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
> > >  						vq->split.avail_idx_shadow);
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
> 
> Just making sure: so on this system, how do
> smp_wmb() and wmb() differ? smb_wmb is normally for synchronizing
> with kernel running on another CPU and we are doing something
> unusual in virtio when we use it to synchronize with host
> as opposed to the guest - e.g. CONFIG_SMP is special cased
> because of this:
> 
> #define virt_wmb() do { kcsan_wmb(); __smp_wmb(); } while (0)
> 
> Note __smp_wmb not smp_wmb which would be a NOP on UP.

I think that should be fine (as long as the NOP is a barrier() for the
compiler).

wmb() uses a DSB, but that is only really relevant to endpoint ordering
with real I/O devices, e.g. if for some reason you need to guarantee
that a write has made it all the way to the device before proceeding.
Even then you're slightly at the mercy of the memory type and the
interconnect not giving an early acknowledgement, so the extra ordering
is rarely needed in practice and we don't even provide it for our I/O
accessors (e.g. writel() and readl()).

So for virtio between two CPUs using coherent memory, DSB is a red
herring.

Will

