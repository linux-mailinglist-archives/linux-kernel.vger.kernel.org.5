Return-Path: <linux-kernel+bounces-121960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7557488EFE1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B82C29A2FD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE23615575C;
	Wed, 27 Mar 2024 20:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WZZEQSN5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A380155730
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 20:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711569856; cv=none; b=cVAdKVVuyZl7rDYFzvRrSklXgPV0Cx1qQ43Vm4TPtkOkKcmm20hWkDuHaIiFeEQxK+mE87YUQG5IAoeytUlnrHikJerwJ9R2/Fl4HcsgGE+cv5Cbwnxk2xWDi3HFzsXkjswCaVSup6kkOF8xwAOzTq7isLzM8mHCkdvK1wP/dBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711569856; c=relaxed/simple;
	bh=pgMb9uGoyAIyFbF9znVIz68QYrW0g+ex10ZFvjS1k8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ebk9wMjTg+YOghc4BHg1fBOHwyoROxxE03/eQaV1U23YjQ2fMZp5J9XzZMEdMc/SuawGOb6KsKYKsLl09fnU5/1NcEY0aQXylFR+Do0Wx5yQX25z5gq81WK117V0ot1DI4/BsYHngQl8ILlxh+VRhQWNZzog8y15D4aBfjdQvNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WZZEQSN5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711569853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2pUwkeyxpCIgmMVeDahMru1IGnRUaXTuK4+0dNpSIAI=;
	b=WZZEQSN5rc1UcMOZvYCV9fx+UC0YARbbZ6OvGdQnqimfC/zUByXJSq8Og+2e5q1FalTYFF
	q/m1lopvjTvOoqq/xXej9IMLsXPJFWUJ3E7GXm+OZpLAn0dAYw0DxhuSrx+fqCGxeSqA5J
	yCd6hemDOdqa6RcjGwpcgToNHrnaodU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-oZupqZTGPfOent5Y9qZCuw-1; Wed, 27 Mar 2024 16:04:09 -0400
X-MC-Unique: oZupqZTGPfOent5Y9qZCuw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33ecf15c037so85923f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 13:04:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711569848; x=1712174648;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2pUwkeyxpCIgmMVeDahMru1IGnRUaXTuK4+0dNpSIAI=;
        b=GU+Jaxb5kUM9Zj9AfVRJwevimMX0VCTUlpeUIoYSnH5RwBNeVqtsONerw5//zwtfkN
         BnO6jvAzutuh9kWSsOxX89aBmkcIHepmGvIXSBDi7o2btg9paziDAFWrzpePNpaVrDdT
         yAnFI/dwXSVpmTXqjSkBqpFnMO11Mx/bCA2iE3sEVodwcUQCOQKhWvrEK70F76lNcoXO
         ABVvNkWlJ9Qjm2DdvTR9G454UGLSbyZiPCgvylkufjdHtgJ2h8Z/YZcOWuEyxt4rVFzC
         e+tVwB6DKL/YmceVlnIJbfXQJ5Magvu2gIqYmVWiwKCVhLcq1OsAKZRAmthvkKNMf2Oe
         Q6Rg==
X-Gm-Message-State: AOJu0YxdKeNxCuDOKqoYvksHqIJ1FlBhF2v8ZNwd4QD042sgLmEIuECj
	AEvC6ApsYy5OIXlvLPmpKBNOlhQHfC2mKp3yc/xn4oHd3wihSFp1VTvSzv7BjzJSU+LpmK4W0YO
	WbfZGLtxeI7FuBCQVKOpcCuDnAf+Y+eHTdGJnxKCV8a0svI0FJAJH0HKN+Z/CqgtawhJspw==
X-Received: by 2002:adf:a4d0:0:b0:33e:737f:2f2b with SMTP id h16-20020adfa4d0000000b0033e737f2f2bmr855575wrb.53.1711569847982;
        Wed, 27 Mar 2024 13:04:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTklukmtRKY9zEEGC4iwvdgrZ6nHRSYn8IS9kk7sn2RF5Cfz9P+w2Hhw3wmG5duVPhRlleig==
X-Received: by 2002:adf:a4d0:0:b0:33e:737f:2f2b with SMTP id h16-20020adfa4d0000000b0033e737f2f2bmr855554wrb.53.1711569847214;
        Wed, 27 Mar 2024 13:04:07 -0700 (PDT)
Received: from redhat.com ([2.52.20.36])
        by smtp.gmail.com with ESMTPSA id ck19-20020a5d5e93000000b00341c6440c36sm11892032wrb.74.2024.03.27.13.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 13:04:06 -0700 (PDT)
Date: Wed, 27 Mar 2024 16:04:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Gavin Shan <gshan@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"David S. Miller" <davem@davemloft.net>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH untested] vhost: order avail ring reads after index
 updates
Message-ID: <20240327155750-mutt-send-email-mst@kernel.org>
References: <f7be6f4ed4bc5405e9a6b848e5ac3dd1f9955c2a.1711560268.git.mst@redhat.com>
 <20240327195202.GB12000@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327195202.GB12000@willie-the-truck>

On Wed, Mar 27, 2024 at 07:52:02PM +0000, Will Deacon wrote:
> On Wed, Mar 27, 2024 at 01:26:23PM -0400, Michael S. Tsirkin wrote:
> > vhost_get_vq_desc (correctly) uses smp_rmb to order
> > avail ring reads after index reads.
> > However, over time we added two more places that read the
> > index and do not bother with barriers.
> > Since vhost_get_vq_desc when it was written assumed it is the
> > only reader when it sees a new index value is cached
> > it does not bother with a barrier either, as a result,
> > on the nvidia-gracehopper platform (arm64) available ring
> > entry reads have been observed bypassing ring reads, causing
> > a ring corruption.
> > 
> > To fix, factor out the correct index access code from vhost_get_vq_desc.
> > As a side benefit, we also validate the index on all paths now, which
> > will hopefully help catch future errors earlier.
> > 
> > Note: current code is inconsistent in how it handles errors:
> > some places treat it as an empty ring, others - non empty.
> > This patch does not attempt to change the existing behaviour.
> > 
> > Cc: stable@vger.kernel.org
> > Reported-by: Gavin Shan <gshan@redhat.com>
> > Reported-by: Will Deacon <will@kernel.org>
> > Suggested-by: Will Deacon <will@kernel.org>
> > Fixes: 275bf960ac69 ("vhost: better detection of available buffers")
> > Cc: "Jason Wang" <jasowang@redhat.com>
> > Fixes: d3bb267bbdcb ("vhost: cache avail index in vhost_enable_notify()")
> > Cc: "Stefano Garzarella" <sgarzare@redhat.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> > 
> > I think it's better to bite the bullet and clean up the code.
> > Note: this is still only built, not tested.
> > Gavin could you help test please?
> > Especially on the arm platform you have?
> > 
> > Will thanks so much for finding this race!
> 
> No problem, and I was also hoping that the smp_rmb() could be
> consolidated into a single helper like you've done here.
> 
> One minor comment below:
> 
> >  drivers/vhost/vhost.c | 80 +++++++++++++++++++++++--------------------
> >  1 file changed, 42 insertions(+), 38 deletions(-)
> > 
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index 045f666b4f12..26b70b1fd9ff 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -1290,10 +1290,38 @@ static void vhost_dev_unlock_vqs(struct vhost_dev *d)
> >  		mutex_unlock(&d->vqs[i]->mutex);
> >  }
> >  
> > -static inline int vhost_get_avail_idx(struct vhost_virtqueue *vq,
> > -				      __virtio16 *idx)
> > +static inline int vhost_get_avail_idx(struct vhost_virtqueue *vq)
> >  {
> > -	return vhost_get_avail(vq, *idx, &vq->avail->idx);
> > +	__virtio16 idx;
> > +	u16 avail_idx;
> > +	int r = vhost_get_avail(vq, idx, &vq->avail->idx);
> > +
> > +	if (unlikely(r < 0)) {
> > +		vq_err(vq, "Failed to access avail idx at %p: %d\n",
> > +		       &vq->avail->idx, r);
> > +		return -EFAULT;
> > +	}
> > +
> > +	avail_idx = vhost16_to_cpu(vq, idx);
> > +
> > +	/* Check it isn't doing very strange things with descriptor numbers. */
> > +	if (unlikely((u16)(avail_idx - vq->last_avail_idx) > vq->num)) {
> > +		vq_err(vq, "Guest moved used index from %u to %u",
> > +		       vq->last_avail_idx, vq->avail_idx);
> > +		return -EFAULT;
> > +	}
> > +
> > +	/* Nothing new? We are done. */
> > +	if (avail_idx == vq->avail_idx)
> > +		return 0;
> > +
> > +	vq->avail_idx = avail_idx;
> > +
> > +	/* We updated vq->avail_idx so we need a memory barrier between
> > +	 * the index read above and the caller reading avail ring entries.
> > +	 */
> > +	smp_rmb();
> 
> I think you could use smp_acquire__after_ctrl_dep() if you're feeling
> brave, but to be honest I'd prefer we went in the opposite direction
> and used READ/WRITE_ONCE + smp_load_acquire()/smp_store_release() across
> the board. It's just a thankless, error-prone task to get there :(

Let's just say that's a separate patch, I tried hard to make this one
a bugfix only, no other functional changes at all.

> So, for the patch as-is:
> 
> Acked-by: Will Deacon <will@kernel.org>
> 
> (I've not tested it either though, so definitely wait for Gavin on that!)
> 
> Cheers,
> 
> Will


