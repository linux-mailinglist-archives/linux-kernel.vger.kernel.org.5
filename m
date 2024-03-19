Return-Path: <linux-kernel+bounces-107120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D54287F7B1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60CC21C21A8F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F52550251;
	Tue, 19 Mar 2024 06:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SfET+KID"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEA1446CF
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 06:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710830623; cv=none; b=pnhjysNkukxSZ6sQhgSB30SlQGmXBXyUwwXi7m74KxkWkCuNBl0QLfXmcxuuQCARpHbTj65BibOzlbxAsOSCmo353WXFt7TtHucE1c2jlR9wsDgWcFv++r1hcdEZFyTPPS1fuggGtujlv9IJjzvQzocpLLyL/aZ6TrB6rgkt9Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710830623; c=relaxed/simple;
	bh=T3mE/JcSP74FHv9QKgT14Tt0WuS2r9wz6NjhGQE/SNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RpYVblZ04E2Y2PvzR67xvmDUCmUZ+iz38H6cyF9yPP4LqPH4kIyHiGTz9DPcB6Qe9g6E+avRaZ++X1Ai1mUNpcJ8zDBY2++7Z3+hKUMA0rhFZbeg3C0slbPxAe/XDwJCjaiX/qCsmNo28uofXRZuji9GvtlMrm+RJQRZBnjVIfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SfET+KID; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710830620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ohZmKZ+KwPhgcffK5N1nXKGEgL+2hzErlGYMYgMXGEk=;
	b=SfET+KIDQyrQMHAT8qxN74gS93dG8ViSLlJ7/r/gp3AEFepkaqQ4OlIUqoDd099PSSOU+V
	wCqbCNzEo8MWbD+oY1L9MMSCfHE88o3s1n7Ie0pcbwSfY3n41M4Fn/9cBxWZIoUIN+1qn3
	uQxwW1NLUwlGqk9KqcwbQxWgS3Pru0A=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-zwx33l_ENU-hWbGLRqH1AA-1; Tue, 19 Mar 2024 02:43:38 -0400
X-MC-Unique: zwx33l_ENU-hWbGLRqH1AA-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-56b9e537837so11215a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 23:43:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710830617; x=1711435417;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ohZmKZ+KwPhgcffK5N1nXKGEgL+2hzErlGYMYgMXGEk=;
        b=o3e8+5edGhRhI5hBtOMTT0pGA3hr0HtZeWm6kkQEWKda2SMA2H8UFxeUhaN5yvNle7
         OkVbyWsHwy4NPLWKVGQvsbMYFUW0g0f9akzBEZno0AX79nLl4eZih0S3ycZ41B+LfHAt
         vnPSqwqzE0MmBht/pkVBJ/9Qw6O3Vd6QXD6teWJs+yN8cmwp9X5701E0Qc1wy0cd7X4P
         4CBY5lwQA4uKva/dRjByWnZkfgeoQ/t+HBG1DrYEpqDqYx6IcBgn96xXYdIWzvxHpOgv
         tMdBZ4ny7wAecxI0e/1Ow8SPnAVnJoyUh76pnFUzckTuc7LBfFXbArZZTem3eydwR3yJ
         WOEQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+1SKdyyJMLuFeNqf1ETJtVidY6+bJicx6OR444ArNEuw7DBo2k0eP4vwvcxinNshrdnX5cbxiBiIrNyy4efwf9WWQuUy/o5CkO9H6
X-Gm-Message-State: AOJu0YwKFOBRiUNV9Py5SOSHhpfXB3NQnVTpjDfeDf9Bq2OOX/zOdrO0
	TJp7jkcnoMjtcHkm6P8VMoe/OPtUSuwSOX1Zg5Sek5AqrRH1nMRCUOeB77RA2CJStq/AG704SWJ
	3+d1RYTVJURVo47XxC9q9aKj7dvmqt1rPFHjtBOXF9TiQIElXuiPb2iis0yyx6Q==
X-Received: by 2002:a17:906:e59:b0:a46:d718:cd28 with SMTP id q25-20020a1709060e5900b00a46d718cd28mr883343eji.1.1710830617369;
        Mon, 18 Mar 2024 23:43:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEY6fpppJjYVQwexsFjrflpwT3duw/rnvrhjmHgbJldVOFDzm08arBFsoQf3CjLD5TtwZ8LBQ==
X-Received: by 2002:a17:906:e59:b0:a46:d718:cd28 with SMTP id q25-20020a1709060e5900b00a46d718cd28mr883325eji.1.1710830616856;
        Mon, 18 Mar 2024 23:43:36 -0700 (PDT)
Received: from redhat.com ([2a02:14f:175:ca2b:adb0:2501:10a9:c4b2])
        by smtp.gmail.com with ESMTPSA id jx25-20020a170907761900b00a4503a78dd5sm5780529ejc.17.2024.03.18.23.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 23:43:36 -0700 (PDT)
Date: Tue, 19 Mar 2024 02:43:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: Will Deacon <will@kernel.org>, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, yihyu@redhat.com, shan.gavin@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>, mochs@nvidia.com
Subject: Re: [PATCH] virtio_ring: Fix the stale index in available ring
Message-ID: <20240319024025-mutt-send-email-mst@kernel.org>
References: <20240314074923.426688-1-gshan@redhat.com>
 <20240318165924.GA1824@willie-the-truck>
 <35a6bcef-27cf-4626-a41d-9ec0a338fe28@redhat.com>
 <20240319020905-mutt-send-email-mst@kernel.org>
 <9b3030d1-cb2c-4ce0-8b24-1074b616fc84@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b3030d1-cb2c-4ce0-8b24-1074b616fc84@redhat.com>

On Tue, Mar 19, 2024 at 04:38:49PM +1000, Gavin Shan wrote:
> On 3/19/24 16:09, Michael S. Tsirkin wrote:
> 
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
> > >          // Work:   __ndelay(100);
> > >          // Work:   __ndelay(10);
> > >          // Broken: __ndelay(9);
> > > 
> > >         vq->split.avail_idx_shadow++;
> > >          vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
> > >                                                  vq->split.avail_idx_shadow);
> > 
> > What if you stick __ndelay here?
> > 
> 
>        /* Put entry in available array (but don't update avail->idx until they
>          * do sync). */
>         avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
>         vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
> 
>         /* Descriptors and available array need to be set before we expose the
>          * new available array entries. */
>         virtio_wmb(vq->weak_barriers);
>         vq->split.avail_idx_shadow++;
>         vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
>                                                 vq->split.avail_idx_shadow);
>         /* Try __ndelay(x) here as Michael suggested
>          *
>          * Work:      __ndelay(200);    possiblly make it hard to reproduce
>          * Broken:    __ndelay(100);
>          * Broken:    __ndelay(20);
>          * Broken:    __ndelay(10);
>          */
>         __ndelay(200);

So we see that just changing the timing masks the race.
What are you using on the host side? vhost or qemu?

> 
> > 
> > >          vq->num_added++;
> > > 
> > >          pr_debug("Added buffer head %i to %p\n", head, vq);
> > >          END_USE(vq);
> > >          :
> > > }
> > > 
> > > I also tried to measure the consumed time for various barrier-relative instructions using
> > > ktime_get_ns() which should have consumed most of the time. __smb_mb() is slower than
> > > __smp_wmb() but faster than __mb()
> > > 
> > >      Instruction           Range of used time in ns
> > >      ----------------------------------------------
> > >      __smp_wmb()           [32  1128032]
> > >      __smp_mb()            [32  1160096]
> > >      __mb()                [32  1162496]
> > > 
> 
> Thanks,
> Gavin


