Return-Path: <linux-kernel+bounces-88500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F1186E26E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D058C28481E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8262C6D50A;
	Fri,  1 Mar 2024 13:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U7Y2Xi+1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2758A381DE
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 13:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709300520; cv=none; b=kqYXVIpoU72S42SwKwKPa2/GgE1j1u1FrUZShE3XlzD283HxwzLms3B4rYaiZhwnBeopZBNh+olIzamVC/iua/J6oDpg2KlidBYwdI9D8o8YhokHh1sj4ji1DimByVGla0ZUxO4ZRlbdkrCmvB/rfxiCtlQaWzg330sFhfe6PVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709300520; c=relaxed/simple;
	bh=2vk9V19VUlgEPl/3Idd/ZI+pMX1LOMB9aDys6AIl9Ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GnKf65K+eoeOc+3+0w2jLR4FtyfDXDQPhT3c5h2ie0CvFZ7FqeaZxyded2Ufepvav41HQmlHOCkrbWQEPsjzMo838+Y8PozmjSmQ+eWc7rUzW/6pZ9oO81YAT0X6KGC8DLsqMnesXNlPjy5W3P+uT8yD/APToq5YRheyAQco1yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U7Y2Xi+1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709300518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IV5GI9ggtOV7YL4yWU+pWO5696jTgiyXslpZgRz6IkE=;
	b=U7Y2Xi+1/tq9+/n3uOSZkq9WWox8vOwnpgfR3JQF9oo1YtH8FArI7wO2QKUKZUhfP3xljQ
	tDCcZ2ZuoiYpH35gw/dXGqQAKC67V9ltQmSV5P+aMmKr1J96DH70ATfdq7bv6PFVthyyI5
	7Bo4+RVczpvd8wWuvL3dxxH32Ao90FM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-Y_dIfbA-OuKv5jE3xYEGpg-1; Fri, 01 Mar 2024 08:41:57 -0500
X-MC-Unique: Y_dIfbA-OuKv5jE3xYEGpg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a44170156daso160288366b.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 05:41:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709300515; x=1709905315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IV5GI9ggtOV7YL4yWU+pWO5696jTgiyXslpZgRz6IkE=;
        b=U3oeWP5rqZ5OSTbkEgl8GKyoMk1DyEVb8vjsjyIT+sHgtoJ1jHCbnflHJRxbLEywOd
         pydiiTAoDDi8RujCGxC/SNHJf4cpN6V84aLG/iln4nNhLv0xm0LYpcWq1DrlCeukZO56
         189rcknFxwz8tg4qxi8PdKslGt8BVWOcLbyAAGojf4SGqDz5qV6+4N1fWVHA9WfHBDbO
         D2saVGO7PJHrW9Jr+YpM0/6R/5ozxjmRduD1wqNKR6iizREDe7NWauRFZANZlkOH9KEd
         rtWdJ9zLnoRbysvbf2lJHD25vLYX9BdXtSJ9tdNMkjMlftC3zCcwh2pUp1JvzdG0gTKC
         K47Q==
X-Forwarded-Encrypted: i=1; AJvYcCVjqJkQDQTYLuzmBqmV9VUpDtAbUibMYbeICXwhTkfwvN2eVp9iI02fLbwE2A8yAcI6eronRpKBs5V7L/rFdax3/MbWQuWN9o6FLNZj
X-Gm-Message-State: AOJu0YwAUspIBWnDnqEiI6Iq0VRL3Pu7/+SKchn/xAnd8wcqrGtlvJ3s
	mPkOy+WUk9/6/QY5hCYBlVuZpvG/yUSg5mJrUepEL/WYDRqnEFdk6YDsf6IyeQUhQpKwyl5teqs
	caNr0FUn+4IykWwYxR2Nh49cDFZf+OwMl4rikWyxq2T0VuqJldmlRG1UbaGONQtA3o0gjTA==
X-Received: by 2002:a17:906:b214:b0:a3f:9629:d305 with SMTP id p20-20020a170906b21400b00a3f9629d305mr1372880ejz.28.1709300515431;
        Fri, 01 Mar 2024 05:41:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGLbgF6qBOfPODlpr/w/K+nFzei0cb6QwGv163EHqSi9QSh8ayVYUSqzu7zpVrOH7v0/7CwUQ==
X-Received: by 2002:a17:906:b214:b0:a3f:9629:d305 with SMTP id p20-20020a170906b21400b00a3f9629d305mr1372862ejz.28.1709300514951;
        Fri, 01 Mar 2024 05:41:54 -0800 (PST)
Received: from redhat.com ([2.52.158.48])
        by smtp.gmail.com with ESMTPSA id vk1-20020a170907cbc100b00a445c16d902sm1267866ejc.96.2024.03.01.05.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 05:41:54 -0800 (PST)
Date: Fri, 1 Mar 2024 08:41:50 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev,
	Zelin Deng <zelin.deng@linux.alibaba.com>
Subject: Re: [RFC] dma-mapping: introduce dma_can_skip_unmap()
Message-ID: <20240301082703-mutt-send-email-mst@kernel.org>
References: <20240301071918.64631-1-xuanzhuo@linux.alibaba.com>
 <64be2e23-c526-45d3-bb7b-29e31241bbef@arm.com>
 <20240301064632-mutt-send-email-mst@kernel.org>
 <a00f0b55-0681-4e9c-b75e-e7e3d4110471@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a00f0b55-0681-4e9c-b75e-e7e3d4110471@arm.com>

On Fri, Mar 01, 2024 at 12:42:39PM +0000, Robin Murphy wrote:
> On 2024-03-01 11:50 am, Michael S. Tsirkin wrote:
> > On Fri, Mar 01, 2024 at 11:38:25AM +0000, Robin Murphy wrote:
> > > Not only is this idea not viable, the entire premise seems flawed - the
> > > reasons for virtio needing to use the DMA API at all are highly likely to be
> > > the same reasons for it needing to use the DMA API *properly* anyway.
> > 
> > The idea has nothing to do with virtio per se
> 
> Sure, I can see that, but if virtio is presented as the justification for
> doing this then it's the justification I'm going to look at first. And the
> fact is that it *does* seem to have particular significance, since having up
> to 19 DMA addresses involved in a single transfer is very much an outlier
> compared to typical hardware drivers.

That's a valid comment. Xuan Zhuo do other drivers do this too,
could you check pls?

> Furthermore the fact that DMA API
> support was retrofitted to the established virtio design means I would
> always expect it to run up against more challenges than a hardware driver
> designed around the expectation that DMA buffers have DMA addresses.


It seems virtio can't drive any DMA changes then it's forever tainted?
Seems unfair - we retrofitted it years ago, enough refactoring happened
since then.


> > - we are likely not the
> > only driver that wastes a lot of memory (hot in cache, too) keeping DMA
> > addresses around for the sole purpose of calling DMA unmap.  On a bunch
> > of systems unmap is always a nop and we could save some memory if there
> > was a way to find out. What is proposed is an API extension allowing
> > that for anyone - not just virtio.
> 
> And the point I'm making is that that "always" is a big assumption, and in
> fact for the situations where it is robustly true we already have the
> DEFINE_DMA_UNMAP_{ADDR,LEN} mechanism.
> I'd consider it rare for DMA
> addresses to be stored in isolation, as opposed to being part of some kind
> of buffer descriptor (or indeed struct scatterlist, for an obvious example)
> that a driver or subsystem still has to keep track of anyway, so in general
> I believe the scope for saving decidedly small amounts of memory at runtime
> is also considerably less than you might be imagining.
> 
> Thanks,
> Robin.


Yes. DEFINE_DMA_UNMAP_ exits but that's only compile time.
And I think the fact we have that mechanism is a hint that
enough configurations could benefit from a runtime
mechanism, too.

E.g. since you mentioned scatterlist, it has a bunch of ifdefs
in place.

Of course
- finding more examples would be benefitial to help maintainers
  do the cost/benefit analysis
- a robust implementation is needed


-- 
MST


