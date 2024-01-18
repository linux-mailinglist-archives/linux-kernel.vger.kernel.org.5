Return-Path: <linux-kernel+bounces-30225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 296A9831BC0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 942C21F245CD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 14:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D821DA44;
	Thu, 18 Jan 2024 14:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="ZkFQR/oy"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE9D1DA3B
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 14:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705589392; cv=none; b=JP0/b7i4/hIYk3Wvh6CMRo7CsY48MPRdVNYR7U4iclwZqk0icHT/IwpxJeY9BLhjRn548qwMh/x3/DzO5E3+IAZndyKTbFkqm8iK2RQ4TZUFWwvY41RG9Mpvrb9eZKasrzueVlTCqdSkIb2QYRbo5buga4JewtsOjedUz+Yr5UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705589392; c=relaxed/simple;
	bh=8JpvTZlqdFD2Rzqoo8GfNdFbMqPNFrBOmIJ6OpoVqiY=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:Mail-Followup-To:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-Operating-System; b=uctJUwbeuN1RzUQHaBo5NDGZxOoZkac63ytf4scXIpDdt+7MNpTzk5p/3g7RwSbG168dkN9svrBq2xOW4U2kISWPhVtr3Bl/n5/3w/fdKvV6gZnyfIvEt/SOzoNuDbYQvl5uWor/BRlJxCbRj88zYe/oYhFwBFUtvIkYpoQCck4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=ZkFQR/oy; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a29b850ec66so380700366b.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 06:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1705589389; x=1706194189; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T0SV8U+IlkdLHr/XjT2iGav+KPgKzY+DGmeC0LEv1Zs=;
        b=ZkFQR/oyVoy41gAb57ROXbzZ6MgZ3L7Gput0qgWHRpbQhCd2nPA2ChO/cAwuuwDbCc
         OYsuYNq8AYRQi4AveMH+SyNPOzQB+IY5oaxvdiNJV/4GVo+9zz47WAPI84VWu+GTUqcs
         NWtlpM64EB1fD7tLaL1JIIXYjDGhHgz3IwE/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705589389; x=1706194189;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T0SV8U+IlkdLHr/XjT2iGav+KPgKzY+DGmeC0LEv1Zs=;
        b=dzmXy2s2IL1y3Mb8tWBthvLXBkSQAtDNT3mJ3JpJPEy5sC8bnfrKnhveTHoiB2Be31
         7ZVGc2uZYgEywpbeoRy536oDVE8knBLyFemS3I5XROp2NCeq/29WY8zkG9KySkcblEPP
         zxJRaZeA8O6TLeSDmWyF4RCgME+T+FE3R4d/RltaDMDxsrIqlxOY+MvsEoBj6qIzN79g
         /Ma6ckaMfVX5zQf4L06NtYQbwmSSeRKwIfj2U2yyjKjXrbm0Jz1+KLPUL+zgEKr+oUA9
         a5cyXpji9qaN2N2vdjbcusr4G4xNqQoY4us598O9zD8MP+dcw1KD12hbW5oX+1eFc//x
         jvVg==
X-Gm-Message-State: AOJu0Yw73x4e0pFmXoyzY5EGzvWRHNPT/J0ItYGZKCuhJ4AvVgTf1ebk
	5FHn3NzsipdwJ17zBi1pakNWZMQTfcuxL9Kxhh2tdQtKmVXYyRzCxs8TOYFRtcI=
X-Google-Smtp-Source: AGHT+IEVM70e6beCogh7O7jcU8xaluhv/ktlLII9rfJtR4gxAiS0g3VAw/ikru3AEG+C2Wt7+UZAPw==
X-Received: by 2002:a17:906:4088:b0:a2e:9ff8:218d with SMTP id u8-20020a170906408800b00a2e9ff8218dmr1190541ejj.3.1705589388609;
        Thu, 18 Jan 2024 06:49:48 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id sa19-20020a1709076d1300b00a2eb5c46618sm2437136ejc.19.2024.01.18.06.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 06:49:47 -0800 (PST)
Date: Thu, 18 Jan 2024 15:49:45 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: "T.J. Mercier" <tjmercier@google.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Brian Starkey <Brian.Starkey@arm.com>,
	John Stultz <jstultz@google.com>,
	Sandeep Patil <sspatil@android.com>,
	Laura Abbott <labbott@redhat.com>, android-mm@google.com,
	minchan@google.com, daniel@ffwll.ch,
	John Stultz <john.stultz@linaro.org>,
	Benjamin Gaignard <benjamin.gaignard@linaro.org>,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-buf: heaps: Don't track CMA dma-buf pages under
 RssFile
Message-ID: <Zak6iW8lktml7f2H@phenom.ffwll.local>
Mail-Followup-To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	"T.J. Mercier" <tjmercier@google.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Brian Starkey <Brian.Starkey@arm.com>,
	John Stultz <jstultz@google.com>,
	Sandeep Patil <sspatil@android.com>,
	Laura Abbott <labbott@redhat.com>, android-mm@google.com,
	minchan@google.com, John Stultz <john.stultz@linaro.org>,
	Benjamin Gaignard <benjamin.gaignard@linaro.org>,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20240117181141.286383-1-tjmercier@google.com>
 <20a68f86-27f0-48f4-a066-7dcf0092858e@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20a68f86-27f0-48f4-a066-7dcf0092858e@amd.com>
X-Operating-System: Linux phenom 6.5.0-4-amd64 

On Thu, Jan 18, 2024 at 11:02:22AM +0100, Christian König wrote:
> Am 17.01.24 um 19:11 schrieb T.J. Mercier:
> > DMA buffers allocated from the CMA dma-buf heap get counted under
> > RssFile for processes that map them and trigger page faults. In
> > addition to the incorrect accounting reported to userspace, reclaim
> > behavior was influenced by the MM_FILEPAGES counter until linux 6.8, but
> > this memory is not reclaimable. [1] Change the CMA dma-buf heap to set
> > VM_PFNMAP on the VMA so MM does not poke at the memory managed by this
> > dma-buf heap, and use vmf_insert_pfn to correct the RSS accounting.
> > 
> > The system dma-buf heap does not suffer from this issue since
> > remap_pfn_range is used during the mmap of the buffer, which also sets
> > VM_PFNMAP on the VMA.
> 
> Mhm, not an issue with this patch but Daniel wanted to add a check for
> VM_PFNMAP to dma_buf_mmap() which would have noted this earlier.
> 
> I don't fully remember the discussion but for some reason that was never
> committed. We should probably try that again.

Iirc the issue is that dma_mmap is not guaranteed to give you a VM_SPECIAL
mapping, at least on absolutely all architectures. That's why I defacto
dropped that idea, but it would indeed be really great if we could
resurrect it.

Maybe for x86 only? Or x86+armv8, I'm honestly not sure anymore which
exact cases ended up with a VM_NORMAL mapping ... Would need a pile of
digging.

I think all the other patches I've landed.
-Sima

> 
> > [1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/mm/vmscan.c?id=fb46e22a9e3863e08aef8815df9f17d0f4b9aede
> > 
> > Fixes: b61614ec318a ("dma-buf: heaps: Add CMA heap to dmabuf heaps")
> > Signed-off-by: T.J. Mercier<tjmercier@google.com>
> 
> Acked-by: Christian König <christian.koenig@amd.com>
> 
> > ---
> >   drivers/dma-buf/heaps/cma_heap.c | 7 +++----
> >   1 file changed, 3 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/dma-buf/heaps/cma_heap.c b/drivers/dma-buf/heaps/cma_heap.c
> > index ee899f8e6721..4a63567e93ba 100644
> > --- a/drivers/dma-buf/heaps/cma_heap.c
> > +++ b/drivers/dma-buf/heaps/cma_heap.c
> > @@ -168,10 +168,7 @@ static vm_fault_t cma_heap_vm_fault(struct vm_fault *vmf)
> >   	if (vmf->pgoff > buffer->pagecount)
> >   		return VM_FAULT_SIGBUS;
> > -	vmf->page = buffer->pages[vmf->pgoff];
> > -	get_page(vmf->page);
> > -
> > -	return 0;
> > +	return vmf_insert_pfn(vma, vmf->address, page_to_pfn(buffer->pages[vmf->pgoff]));
> >   }
> >   static const struct vm_operations_struct dma_heap_vm_ops = {
> > @@ -185,6 +182,8 @@ static int cma_heap_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma)
> >   	if ((vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) == 0)
> >   		return -EINVAL;
> > +	vm_flags_set(vma, VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP);
> > +
> >   	vma->vm_ops = &dma_heap_vm_ops;
> >   	vma->vm_private_data = buffer;

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

