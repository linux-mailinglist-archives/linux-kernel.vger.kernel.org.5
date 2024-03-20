Return-Path: <linux-kernel+bounces-108281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 868B48808B7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 01:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA1AC1C21AE6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 00:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F98E10E9;
	Wed, 20 Mar 2024 00:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Krt5aa+S"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A164B5250
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 00:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710895791; cv=none; b=e/wGcbYkR9GA+VYq8rqvYG9V/Czam9ZKSlPPAwIi8GolltZjQoOKuHvF9tQemBlfi3GygLdK2oxOPjrOqzJWOzc9/NAPa8sk4oN6du3ngffNHpdz3nU8w5KYDZ7+WUciXUdlUrbgyXr1lR5WvCz/6LYkw2S1hib6TUJ5l2/if6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710895791; c=relaxed/simple;
	bh=QtENe5tGqc5L93sGz7xIFY5bkgWARpDXtvakwsiQy9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aR65qYDX3er+qDqTLgKdSIbrYvmZq1KcnaADrqBSFZtdyhace7iJ7VB41k1falSqG3BE8R+qiD0SfS+ngI4p1I6NToXtCqgOMUOzLV4O1JN1N+1Gsvepr2m+EGw2wOlfqUN5g2jH39aHUb4M1syT7Q31m/JwpQdsUR+fWMxqcbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Krt5aa+S; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710895788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CE0aiUgp6PdfvujdkzIH46kf740RuCaPAFwYm77rL6c=;
	b=Krt5aa+S5E8CVvqGuUN3l/BcWwUedlLSOiyJs1rlht0IzNZS3zwXHTH8f2Ifl2o/vrgDjy
	Q3NEAAdvBzLfe3IQdHRJF8WUhKxdCHbKCwgNhLPJqFD4R43P2tCFyWBMwldBzasMRXih7I
	S2OXMt7Rz4kVuiPQbPplA4QCiWlDxok=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-8eY2CHhONy6qCJJW2a9tgg-1; Tue, 19 Mar 2024 20:49:47 -0400
X-MC-Unique: 8eY2CHhONy6qCJJW2a9tgg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33ed44cb765so2242335f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 17:49:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710895786; x=1711500586;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CE0aiUgp6PdfvujdkzIH46kf740RuCaPAFwYm77rL6c=;
        b=BFKxJJ8J4fGyTgnJ0d2EZGuC14XJtzytzXtRE/JMCY5a4mAu9CrTusbxvmm4dp0eQ1
         iMh3VqvRRKK2/YyZovkufkveGiVQAv0nLQvMKpTm426tvvUGULyqzCpn8PltvIOmFUTb
         bBfywe8yVsiplmOr95dy+EY5gSvfrHXeeaKz2glvHDytTTTPIt+VPp6OSqRo0/62cCGh
         Ub4UYRch/5aN5M8mW8XoH0iXuy/gfq40J4puLpjNJTZvcHF2PEZOh0dfIsUL1KUHmIfh
         fVoqE/EK7LHTdrU6WLj4RWN+EaZaobIfveQV5q77KmgqfztVhqIRczWbUfCU3M56FjZO
         SFRA==
X-Forwarded-Encrypted: i=1; AJvYcCUxb+DudLXRJt3zXtQFOfzWY5QDxkfjOM+cFgwH8Vpj1sLExh61ZsNr9bhAmp6i2ZugPYG13nmKG80y8N2YqpO4qS69yAzd9L9Evpbz
X-Gm-Message-State: AOJu0YxOuiDa/Phx8gqYIuJkx1/KSqfAS9GYKiCylEvCKYdJJbfq89nY
	wPscmkyvB2LXePszWV9YkPLVlIoBbEKeI/RQ/EKzTuI6ZPtxJ89LQ6UywY57NmP+aiQg1QRRegY
	tBF9LZD2C+5mKN4SJ87S7pMGP78QcwYhQ5/4PKY/OyjEpUNnQ7BaW0YnSsHgarQ==
X-Received: by 2002:a5d:6605:0:b0:33e:c9ce:23fe with SMTP id n5-20020a5d6605000000b0033ec9ce23femr366583wru.25.1710895785871;
        Tue, 19 Mar 2024 17:49:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEk6XEl3djgMno5+rKGDJaHnEp73VZSbNTX00Jd72jtRf2nDEaEUxaqAu/J9M21qKE29pVSWQ==
X-Received: by 2002:a5d:6605:0:b0:33e:c9ce:23fe with SMTP id n5-20020a5d6605000000b0033ec9ce23femr366565wru.25.1710895785255;
        Tue, 19 Mar 2024 17:49:45 -0700 (PDT)
Received: from redhat.com ([2.52.6.254])
        by smtp.gmail.com with ESMTPSA id dd12-20020a0560001e8c00b0033eab3520a9sm13483749wrb.43.2024.03.19.17.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 17:49:44 -0700 (PDT)
Date: Tue, 19 Mar 2024 20:49:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: Will Deacon <will@kernel.org>, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, yihyu@redhat.com, shan.gavin@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>, mochs@nvidia.com
Subject: Re: [PATCH] virtio_ring: Fix the stale index in available ring
Message-ID: <20240319203540-mutt-send-email-mst@kernel.org>
References: <20240314074923.426688-1-gshan@redhat.com>
 <20240318165924.GA1824@willie-the-truck>
 <35a6bcef-27cf-4626-a41d-9ec0a338fe28@redhat.com>
 <20240319182251.GB3121@willie-the-truck>
 <9500adaf-0075-4ae9-92db-7e310b6598b0@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9500adaf-0075-4ae9-92db-7e310b6598b0@redhat.com>

On Wed, Mar 20, 2024 at 09:56:58AM +1000, Gavin Shan wrote:
> On 3/20/24 04:22, Will Deacon wrote:
> > On Tue, Mar 19, 2024 at 02:59:23PM +1000, Gavin Shan wrote:
> > > On 3/19/24 02:59, Will Deacon wrote:
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
> > > > >    	vq->split.avail_idx_shadow++;
> > > > >    	vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
> > > > >    						vq->split.avail_idx_shadow);
> > > > 
> > > > Replacing a DMB with a DSB is _very_ unlikely to be the correct solution
> > > > here, especially when ordering accesses to coherent memory.
> > > > 
> > > > In practice, either the larger timing different from the DSB or the fact
> > > > that you're going from a Store->Store barrier to a full barrier is what
> > > > makes things "work" for you. Have you tried, for example, a DMB SY
> > > > (e.g. via __smb_mb()).
> > > > 
> > > > We definitely shouldn't take changes like this without a proper
> > > > explanation of what is going on.
> > > > 
> > > 
> > > Thanks for your comments, Will.
> > > 
> > > Yes, DMB should work for us. However, it seems this instruction has issues on
> > > NVidia's grace-hopper. It's hard for me to understand how DMB and DSB works
> > > from hardware level. I agree it's not the solution to replace DMB with DSB
> > > before we fully understand the root cause.
> > > 
> > > I tried the possible replacement like below. __smp_mb() can avoid the issue like
> > > __mb() does. __ndelay(10) can avoid the issue, but __ndelay(9) doesn't.
> > > 
> > > static inline int virtqueue_add_split(struct virtqueue *_vq, ...)
> > > {
> > >      :
> > >          /* Put entry in available array (but don't update avail->idx until they
> > >           * do sync). */
> > >          avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
> > >          vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
> > > 
> > >          /* Descriptors and available array need to be set before we expose the
> > >           * new available array entries. */
> > >          // Broken: virtio_wmb(vq->weak_barriers);
> > >          // Broken: __dma_mb();
> > >          // Work:   __mb();
> > >          // Work:   __smp_mb();
> > 
> > It's pretty weird that __dma_mb() is "broken" but __smp_mb() "works". How
> > confident are you in that result?
> > 
> 
> Yes, __dma_mb() is even stronger than __smp_mb(). I retried the test, showing
> that both __dma_mb() and __smp_mb() work for us. I had too many tests yesterday
> and something may have been messed up.
> 
> Instruction         Hitting times in 10 tests
> ---------------------------------------------
> __smp_wmb()         8
> __smp_mb()          0
> __dma_wmb()         7
> __dma_mb()          0
> __mb()              0
> __wmb()             0
> 
> It's strange that __smp_mb() works, but __smp_wmb() fails. It seems we need a
> read barrier here. I will try WRITE_ONCE() + __smp_wmb() as suggested by Michael
> in another reply. Will update the result soon.
> 
> Thanks,
> Gavin


I think you are wasting the time with these tests. Even if it helps what
does this tell us? Try setting a flag as I suggested elsewhere.
Then check it in vhost.
Or here's another idea - possibly easier. Copy the high bits from index
into ring itself. Then vhost can check that head is synchronized with
index.

Warning: completely untested, not even compiled. But should give you
the idea. If this works btw we should consider making this official in
the spec.


 static inline int vhost_get_avail_flags(struct vhost_virtqueue *vq,
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 6f7e5010a673..79456706d0bd 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -685,7 +685,8 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 	/* Put entry in available array (but don't update avail->idx until they
 	 * do sync). */
 	avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
-	vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
+	u16 headwithflag = head | (q->split.avail_idx_shadow & ~(vq->split.vring.num - 1));
+	vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, headwithflag);
 
 	/* Descriptors and available array need to be set before we expose the
 	 * new available array entries. */

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 045f666b4f12..bd8f7c763caa 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1299,8 +1299,15 @@ static inline int vhost_get_avail_idx(struct vhost_virtqueue *vq,
 static inline int vhost_get_avail_head(struct vhost_virtqueue *vq,
 				       __virtio16 *head, int idx)
 {
-	return vhost_get_avail(vq, *head,
+	unsigned i = idx;
+	unsigned flag = i & ~(vq->num - 1);
+	unsigned val = vhost_get_avail(vq, *head,
 			       &vq->avail->ring[idx & (vq->num - 1)]);
+	unsigned valflag = val & ~(vq->num - 1);
+
+	WARN_ON(valflag != flag);
+
+	return val & (vq->num - 1);
 }
 
-- 
MST


