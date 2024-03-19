Return-Path: <linux-kernel+bounces-107176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7135A87F878
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E5821C21A07
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8812537E0;
	Tue, 19 Mar 2024 07:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TntvpOXS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B893BBCA
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 07:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710833803; cv=none; b=CXPKnKOv8AUqKCH9S21DXju1B6Fir0WfO18xoyautUlmp0aQG/H3uoIOnuGmUlDscytxrvRBVkN0ZR2Fa42w8qpXjKVrQTDWAnwUCOvpJwyVwDWydObVDuKETVzFGoiGx4cNguh01bDgjfo1tlVExLmNtfNE/xEz3L/C6xy3QQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710833803; c=relaxed/simple;
	bh=rPNTGp/Tn8oSnoxZozZdnWDR8B4Ksv7q1cBV0qnDa3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QaR278J8hb3nV4tFVBB4vZeoB7PNQXWH/VeTP2Pp4BWhoN9pMwnJZ0DpkwPl3gS6DXi1BOLGHQLrMpfGslqDXbA33wxJaFL/qKQk0HRvwt/6BY6J/0tpXBSYIarvVA8d4mxhtnAvIIzGew1WN4eMwW6Zj4vT9J9o9yH+TKerFAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TntvpOXS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710833799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EKg9GvJFLNWkRSN6sgPN6hHh5dCxAIK5VhU/j1vuYMU=;
	b=TntvpOXS4bqP1n7TkEpsn+FdgQ+/1nf1jwQRm8/XTPCMTAEK5FegNEP7xMpMNqeiI/BGWZ
	QSwAoCQHnGZwbqT42xThBdfvmKJCrh6XbYrqADcn5dEAr14qbDM1/5HtCvV7EzUInXqhkP
	LO9qfsp4jp4SZe+3cVdQ3FrhdfbET9E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-h7ssjVrQP4-UJwO6AJV8pg-1; Tue, 19 Mar 2024 03:36:37 -0400
X-MC-Unique: h7ssjVrQP4-UJwO6AJV8pg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33ed44cb765so1935586f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 00:36:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710833796; x=1711438596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EKg9GvJFLNWkRSN6sgPN6hHh5dCxAIK5VhU/j1vuYMU=;
        b=KpazYq38jfvTOXFd86QWecfAuoxot/3iOJb+scByMF+t/3jMvcU+vxHACW9CKBSYN5
         o22jMk2or6dWRVrlfOIzRWeXZ0482O8f5MsnGZ4z/dAwLEjpxVTIDja1Ak3O+/Wg46bI
         rNcpBaF+rraciv6mbjhy7xmehUsd3jA5a/e86763YwxfdTZcD4yHD/OnI85n7gqvEmoX
         UIfP2S2eTUNAJmM6V82b8FhEYrE1ILXnZHXV14iC/oX4dlCBxwKPBqOMTiRFlB/cug/1
         Kzhexra0idaPEpt+ueI252maVuOBKVdZBfXBxXzrHzDjfWFd4LlTH1H0El3JJf5EW7Dl
         IDng==
X-Forwarded-Encrypted: i=1; AJvYcCXcpr4opzt/Pfg7pBSR8rT83bUrpqOfXlsi7Y3pdKLuHK634FUiZGjE+IT6JTjkB7lWO9L/Pw4RQBKpt7LdAZAT+k8x+Xe+smzauS/X
X-Gm-Message-State: AOJu0Yw1eUZZJPMHebmDkzx1COZQg95JEstWtnJz2QDJPbzIW9p3mY/F
	NN4R3MLyVHOEq6z4+V5CoT1fdd9TVG/DRSslI9Z+N5Dcq84+RmiFGx4UpHE/FlLpf/Y4y02eHES
	m+hmBE9Zd087k6fZGnYLugGo5INtW/cuQIPEwM1uW410vEmBKH8CFnbI3QVrCMw==
X-Received: by 2002:a05:6000:e4a:b0:341:80fc:4913 with SMTP id dy10-20020a0560000e4a00b0034180fc4913mr2202829wrb.67.1710833796207;
        Tue, 19 Mar 2024 00:36:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfMIhZzBmKNSSWXzIOXaRHlk22Ags3JFIXiJkum6UNSmNtxg7G6yImmY6QTGuvptfpS2dsfg==
X-Received: by 2002:a05:6000:e4a:b0:341:80fc:4913 with SMTP id dy10-20020a0560000e4a00b0034180fc4913mr2202813wrb.67.1710833795615;
        Tue, 19 Mar 2024 00:36:35 -0700 (PDT)
Received: from redhat.com ([2.52.6.254])
        by smtp.gmail.com with ESMTPSA id f1-20020a5d4dc1000000b0033e99b7cfa8sm6483794wru.13.2024.03.19.00.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 00:36:35 -0700 (PDT)
Date: Tue, 19 Mar 2024 03:36:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: Gavin Shan <gshan@redhat.com>, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, yihyu@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH] virtio_ring: Fix the stale index in available ring
Message-ID: <20240319033016-mutt-send-email-mst@kernel.org>
References: <20240314074923.426688-1-gshan@redhat.com>
 <20240318165924.GA1824@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318165924.GA1824@willie-the-truck>

On Mon, Mar 18, 2024 at 04:59:24PM +0000, Will Deacon wrote:
> On Thu, Mar 14, 2024 at 05:49:23PM +1000, Gavin Shan wrote:
> > The issue is reported by Yihuang Yu who have 'netperf' test on
> > NVidia's grace-grace and grace-hopper machines. The 'netperf'
> > client is started in the VM hosted by grace-hopper machine,
> > while the 'netperf' server is running on grace-grace machine.
> > 
> > The VM is started with virtio-net and vhost has been enabled.
> > We observe a error message spew from VM and then soft-lockup
> > report. The error message indicates the data associated with
> > the descriptor (index: 135) has been released, and the queue
> > is marked as broken. It eventually leads to the endless effort
> > to fetch free buffer (skb) in drivers/net/virtio_net.c::start_xmit()
> > and soft-lockup. The stale index 135 is fetched from the available
> > ring and published to the used ring by vhost, meaning we have
> > disordred write to the available ring element and available index.
> > 
> >   /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64              \
> >   -accel kvm -machine virt,gic-version=host                            \
> >      :                                                                 \
> >   -netdev tap,id=vnet0,vhost=on                                        \
> >   -device virtio-net-pci,bus=pcie.8,netdev=vnet0,mac=52:54:00:f1:26:b0 \
> > 
> >   [   19.993158] virtio_net virtio1: output.0:id 135 is not a head!
> > 
> > Fix the issue by replacing virtio_wmb(vq->weak_barriers) with stronger
> > virtio_mb(false), equivalent to replaced 'dmb' by 'dsb' instruction on
> > ARM64. It should work for other architectures, but performance loss is
> > expected.
> > 
> > Cc: stable@vger.kernel.org
> > Reported-by: Yihuang Yu <yihyu@redhat.com>
> > Signed-off-by: Gavin Shan <gshan@redhat.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 49299b1f9ec7..7d852811c912 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -687,9 +687,15 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
> >  	avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
> >  	vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
> >  
> > -	/* Descriptors and available array need to be set before we expose the
> > -	 * new available array entries. */
> > -	virtio_wmb(vq->weak_barriers);
> > +	/*
> > +	 * Descriptors and available array need to be set before we expose
> > +	 * the new available array entries. virtio_wmb() should be enough
> > +	 * to ensuere the order theoretically. However, a stronger barrier
> > +	 * is needed by ARM64. Otherwise, the stale data can be observed
> > +	 * by the host (vhost). A stronger barrier should work for other
> > +	 * architectures, but performance loss is expected.
> > +	 */
> > +	virtio_mb(false);
> >  	vq->split.avail_idx_shadow++;
> >  	vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
> >  						vq->split.avail_idx_shadow);
> 
> Replacing a DMB with a DSB is _very_ unlikely to be the correct solution
> here, especially when ordering accesses to coherent memory.
> 
> In practice, either the larger timing different from the DSB or the fact
> that you're going from a Store->Store barrier to a full barrier is what
> makes things "work" for you. Have you tried, for example, a DMB SY
> (e.g. via __smb_mb()).
> 
> We definitely shouldn't take changes like this without a proper
> explanation of what is going on.
> 
> Will

Just making sure: so on this system, how do
smp_wmb() and wmb() differ? smb_wmb is normally for synchronizing
with kernel running on another CPU and we are doing something
unusual in virtio when we use it to synchronize with host
as opposed to the guest - e.g. CONFIG_SMP is special cased
because of this:

#define virt_wmb() do { kcsan_wmb(); __smp_wmb(); } while (0)

Note __smp_wmb not smp_wmb which would be a NOP on UP.


-- 
MST


