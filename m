Return-Path: <linux-kernel+bounces-118485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F96D88BBA4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9B4B2E34B9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 07:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53FA132813;
	Tue, 26 Mar 2024 07:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TW2TsaW3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D8F13175C
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 07:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711439352; cv=none; b=IKmoLoAZUg1oppEOLbylxRYYtLDkViMCj6FN+s40NmCOaIvEpV1SNXNT80ynU4+A7eXphsIBGfcYlS7Mzng7Wjijpcl2R697XQmmPf/vcIJhC2lN2Af6Wsynwexv5P4jebpq5uBmY8KeZpcJ0DmUdyyjRsoWzrTz5iAlJW60jpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711439352; c=relaxed/simple;
	bh=YyI5P87eoxZmEYXRLjbKSoKqp/231zJ+E03srPerGOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tXod3SWcFMvmojoNK3aVSLINXv85zpC/k3xPJx46QnGrNuiCL1dQgRMbhR+uSLDedtZ3f9f/YLNVktVRSngzr6qT46g3lQqyOduhRQcuqK4Jr/ELmMHLe05VMS3cWBOZRyPiTZmSwhbMLcxZS2bRBjjUtqDVPZDJLKmQuzGuq/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TW2TsaW3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711439350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S1Uq7z4YPDu1tfLjrShk+kcEkEswJznbeM6Yc8BuQDY=;
	b=TW2TsaW3iykVZRf2aQPDneD5NwyYElOEoKlapgzGj5SVwZAQFFVEIc/H2mu5C72PiuI7JX
	pMmmUyydeO/BZIrXw+IFApejrgVrsY4vsiT9qIoVEMDcl4ntZDejZqIxq9AuUbST1t1S2w
	WLZDOK604oqzWDXAl591of+/5zdnN84=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-qypwrdiMPpuun1H94NZUsw-1; Tue, 26 Mar 2024 03:49:08 -0400
X-MC-Unique: qypwrdiMPpuun1H94NZUsw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33ece03ca5dso3698558f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 00:49:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711439347; x=1712044147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S1Uq7z4YPDu1tfLjrShk+kcEkEswJznbeM6Yc8BuQDY=;
        b=RQMzyQy4ks4FOxMuanvzuUNlymLV3I42aHIWXDOeBfGGnY2xRkAmIhB+xmQVxjFV7V
         yepT3afGx/87xR6D0aIt0f4MX4liRk23M5XfuUM92xY2Ndck12CG5mo1PoqJvzi2EUPo
         +lNS8Kq3McUfyPMzmsqSYmg06b+doldyI3BLwYJYZ6THcnlgUHjmPniMcPBoBbZaZyZY
         gmHlFE+0g9ywtDhOOpVP12IItygSaMiMj1Ff6dBZlWzwcjOV0ki9iBTDrmVz/GqHhFf6
         aCwJKQlf2xLkuH+/qowvvxj/MaOJZNEIwzamXVaPGA7C5hIUQ4RBBWuvEjgdY9AfU6RC
         kdKA==
X-Forwarded-Encrypted: i=1; AJvYcCWOhzhbqTPf05bIAakwU95x9p6QYE0xwSbwhBbNJA2vixPTdNx+kvV9uxJNJvtvuyMuunYN2skHiFhtVse3mcb/7iEUdyk2GKjzZ66U
X-Gm-Message-State: AOJu0YwJLCoz1sSvtXLWFgVPAHQXjH+KxjOZe/NTM7Qn1ncDnSvbmbaI
	mi4oaWvS7B3Amk9vm1kA2jfEyjQ6QRBmOGF5hXEnFFBP44Srh8et+qBrye4IrtGClxiXR0L8rVA
	dT36Erqcg0SwXqDgYVpLVFrhgr9qdZ9Ait5OL1LWngKykeSUJve34nmKWOMLcag==
X-Received: by 2002:a5d:6e01:0:b0:33c:deed:6745 with SMTP id h1-20020a5d6e01000000b0033cdeed6745mr7043783wrz.13.1711439346712;
        Tue, 26 Mar 2024 00:49:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDZ76bKRqpYhB8UU97OH4GlDC/CvSpy1jx/iBj2k9Bsb4KVn/8tVO+C3bjtFRt0oGNKjWMFw==
X-Received: by 2002:a5d:6e01:0:b0:33c:deed:6745 with SMTP id h1-20020a5d6e01000000b0033cdeed6745mr7043768wrz.13.1711439346203;
        Tue, 26 Mar 2024 00:49:06 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73e8:4f00:4a9d:49ee:c7ac:ea36])
        by smtp.gmail.com with ESMTPSA id u13-20020a056000038d00b00341c934ae4asm6449808wrf.75.2024.03.26.00.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 00:49:05 -0700 (PDT)
Date: Tue, 26 Mar 2024 03:49:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: Will Deacon <will@kernel.org>, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, yihyu@redhat.com, shan.gavin@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>, mochs@nvidia.com
Subject: Re: [PATCH] virtio_ring: Fix the stale index in available ring
Message-ID: <20240326033809-mutt-send-email-mst@kernel.org>
References: <20240314074923.426688-1-gshan@redhat.com>
 <20240318165924.GA1824@willie-the-truck>
 <35a6bcef-27cf-4626-a41d-9ec0a338fe28@redhat.com>
 <20240319182251.GB3121@willie-the-truck>
 <9500adaf-0075-4ae9-92db-7e310b6598b0@redhat.com>
 <20240319203540-mutt-send-email-mst@kernel.org>
 <3a6c8b23-af9c-47a7-8c22-8e0a78154bd3@redhat.com>
 <20240320030215-mutt-send-email-mst@kernel.org>
 <1dcec730-ec26-46f4-ba4c-06101fcc599e@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1dcec730-ec26-46f4-ba4c-06101fcc599e@redhat.com>

On Mon, Mar 25, 2024 at 05:34:29PM +1000, Gavin Shan wrote:
> 
> On 3/20/24 17:14, Michael S. Tsirkin wrote:
> > On Wed, Mar 20, 2024 at 03:24:16PM +1000, Gavin Shan wrote:
> > > On 3/20/24 10:49, Michael S. Tsirkin wrote:>
> > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > > index 6f7e5010a673..79456706d0bd 100644
> > > > --- a/drivers/virtio/virtio_ring.c
> > > > +++ b/drivers/virtio/virtio_ring.c
> > > > @@ -685,7 +685,8 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
> > > >    	/* Put entry in available array (but don't update avail->idx until they
> > > >    	 * do sync). */
> > > >    	avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
> > > > -	vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
> > > > +	u16 headwithflag = head | (q->split.avail_idx_shadow & ~(vq->split.vring.num - 1));
> > > > +	vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, headwithflag);
> > > >    	/* Descriptors and available array need to be set before we expose the
> > > >    	 * new available array entries. */
> > > > 
> 
> Ok, Michael. I continued with my debugging code. It still looks like a
> hardware bug on NVidia's grace-hopper. I really think NVidia needs to be
> involved for the discussion, as suggested by you.

Do you have a support contact at Nvidia to report this?

> Firstly, I bind the vhost process and vCPU thread to CPU#71 and CPU#70.
> Note that I have only one vCPU in my configuration.

Interesting but is guest built with CONFIG_SMP set?

> Secondly, the debugging code is enhanced so that the available head for
> (last_avail_idx - 1) is read for twice and recorded. It means the available
> head for one specific available index is read for twice. I do see the
> available heads are different from the consecutive reads. More details
> are shared as below.
> 
> From the guest side
> ===================
> 
> virtio_net virtio0: output.0:id 86 is not a head!
> head to be released: 047 062 112
> 
> avail_idx:
> 000  49665
> 001  49666  <--
>  :
> 015  49664

what are these #s 49665 and so on?
and how large is the ring?
I am guessing 49664 is the index ring size is 16 and
49664 % 16 == 0

> avail_head:


is this the avail ring contents?

> 000  062
> 001  047  <--
>  :
> 015  112


What are these arrows pointing at, btw?


> From the host side
> ==================
> 
> avail_idx
> 000  49663
> 001  49666  <---
>  :
> 
> avail_head
> 000  062  (062)
> 001  047  (047)  <---
>  :
> 015  086  (112)          // head 086 is returned from the first read,
>                          // but head 112 is returned from the second read
> 
> vhost_get_vq_desc: Inconsistent head in two read (86 -> 112) for avail_idx 49664
> 
> Thanks,
> Gavin

OK thanks so this proves it is actually the avail ring value.

-- 
MST


