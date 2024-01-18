Return-Path: <linux-kernel+bounces-30565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA058320A5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 21:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 568462857F0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 20:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D182E858;
	Thu, 18 Jan 2024 20:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="SfCR96y5"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53952E640
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 20:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705611478; cv=none; b=MzVND8OVOIihrA+xixrtL4xvo4mB4Uc5Dm0VPnJudI7Hupj2ZFk8jXcqcsZgUMIAFSoVXjF9sUXsMY0SaJjdfcN9xMlEfhxf8kWonOjI/V60I+LWd7gcTdv+cU0FAAKLZL89Ls+KF5pGacZOCIT7LrJMAY5Lcvf4ZvAPRveC8nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705611478; c=relaxed/simple;
	bh=35+4/7X5aWBIYlFEYHJiHnlSDrpJBZS2YEWmnB9tGko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ez9xiG9vVYsNQrYF7u5NfRiWKHtRJ7EsPxB+CJdcpSmWY4kGzv8mG4RPXumr/mLpivttjxZOLyTfVx9VwDIeLpRJ0aNddRhy1MbO77LTH8o4GP46qHnf80J2cfpVt78VzGAzcEzYe6pCU9vHLRoFS6L2wFYIh45IQbh2ZXeABOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=SfCR96y5; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55760f84177so9862a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 12:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1705611475; x=1706216275; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vG2d4C5q3VAnujQnY/vfroPdU2IS/AysqJ++FSIJIio=;
        b=SfCR96y51403xoN3DSEYHFmEtWInTiyM3GGr1Ws3XqRjfFxGTAkKKeoM84/7Yspn/u
         ipTnQ8bUnjsYjCIYHPu+hOIuDfVBmEM3zgBuN3xdVOqGxTkmHHgsG76WU8vRTwEgZ1EQ
         vaV+liB/6ECP1zQBz7gKkAILgcbRsg0A4SdMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705611475; x=1706216275;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vG2d4C5q3VAnujQnY/vfroPdU2IS/AysqJ++FSIJIio=;
        b=FGddb7NKi91qI5zsc6LZbAOPPmuxuB5C+EDHH7AUYRFqX3AV6rWLq4O/iirDFryv0j
         +17757XSZ6FVaoe7wbUUeWGUXgmNpdBhc396uy1m+kJTLTAUPz/4lV3SvkuEfpRTy+o1
         dhk9us5ZHxzjMkB6JT5sJkComnsPzPPIM4W0YjIgx/Ee2L8K3fsxpfGaEgCmvbtB9Dkb
         uxEV8ds4rKdnShAdUgQhkOI+wZdvHaVklhIPR48Kq3Y+N5pDLX/msJU8OhHw8h2Ky7ky
         Y172DtI2uiD4ph5ZHnWPtswDhGc2F522XRHbg9OL2s4/O3OAkKNEXXWjXtVaGeTM+dvC
         SKwg==
X-Gm-Message-State: AOJu0YxDuLXtN8Dt/B/BkydkpG7CJ0HjNhIvKjaEAwfXgewVauTpHsPK
	gpC1O68WVnzAhnov2+H1FKxyzUQ2vbJ0rzXQ33nKJffEDE7/U2Vy6aFPK6CpAM0=
X-Google-Smtp-Source: AGHT+IFYmE5E+AxibG3l6XMG9L3qmRanwGu4ICGZmkOTqqqlW7iV75YmqX3x6L0EdKpKJSK42kFhYg==
X-Received: by 2002:aa7:dad4:0:b0:559:87b5:9692 with SMTP id x20-20020aa7dad4000000b0055987b59692mr276297eds.2.1705611474838;
        Thu, 18 Jan 2024 12:57:54 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id o9-20020a056402444900b00559dd0a5146sm2509754edb.44.2024.01.18.12.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 12:57:54 -0800 (PST)
Date: Thu, 18 Jan 2024 21:57:52 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Brian Starkey <Brian.Starkey@arm.com>,
	John Stultz <jstultz@google.com>,
	Sandeep Patil <sspatil@android.com>,
	Laura Abbott <labbott@redhat.com>, android-mm@google.com,
	minchan@google.com, John Stultz <john.stultz@linaro.org>,
	Benjamin Gaignard <benjamin.gaignard@linaro.org>,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
	daniel@ffwll.ch
Subject: Re: [PATCH] dma-buf: heaps: Don't track CMA dma-buf pages under
 RssFile
Message-ID: <ZamQ0LAX2B6qaK6g@phenom.ffwll.local>
Mail-Followup-To: "T.J. Mercier" <tjmercier@google.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
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
 <Zak6iW8lktml7f2H@phenom.ffwll.local>
 <CABdmKX10zz6bk4VVDgsosJbA8_7WOxuCnkyYFiL1FPwtZ-C+WQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABdmKX10zz6bk4VVDgsosJbA8_7WOxuCnkyYFiL1FPwtZ-C+WQ@mail.gmail.com>
X-Operating-System: Linux phenom 6.5.0-4-amd64 

On Thu, Jan 18, 2024 at 08:57:16AM -0800, T.J. Mercier wrote:
> On Thu, Jan 18, 2024 at 6:49 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > On Thu, Jan 18, 2024 at 11:02:22AM +0100, Christian König wrote:
> > > Am 17.01.24 um 19:11 schrieb T.J. Mercier:
> > > > DMA buffers allocated from the CMA dma-buf heap get counted under
> > > > RssFile for processes that map them and trigger page faults. In
> > > > addition to the incorrect accounting reported to userspace, reclaim
> > > > behavior was influenced by the MM_FILEPAGES counter until linux 6.8, but
> > > > this memory is not reclaimable. [1] Change the CMA dma-buf heap to set
> > > > VM_PFNMAP on the VMA so MM does not poke at the memory managed by this
> > > > dma-buf heap, and use vmf_insert_pfn to correct the RSS accounting.
> > > >
> > > > The system dma-buf heap does not suffer from this issue since
> > > > remap_pfn_range is used during the mmap of the buffer, which also sets
> > > > VM_PFNMAP on the VMA.
> > >
> > > Mhm, not an issue with this patch but Daniel wanted to add a check for
> > > VM_PFNMAP to dma_buf_mmap() which would have noted this earlier.
> > >
> > > I don't fully remember the discussion but for some reason that was never
> > > committed. We should probably try that again.
> >
> > Iirc the issue is that dma_mmap is not guaranteed to give you a VM_SPECIAL
> > mapping, at least on absolutely all architectures. That's why I defacto
> > dropped that idea, but it would indeed be really great if we could
> > resurrect it.
> 
> I actually had it in my head that it was a BUG_ON check for VM_PFNMAP
> in dma_buf_mmap and it was merged, so I was surprised to discover that
> it wasn't set for these CMA buffers.
> 
> > Maybe for x86 only? Or x86+armv8, I'm honestly not sure anymore which
> > exact cases ended up with a VM_NORMAL mapping ... Would need a pile of
> > digging.
> 
> Looking back at the patch, the CI email at the end of the thread lists
> a bunch of now-broken links to DMESG-WARN test failures I assume
> pointed at a large chunk of them.
> 
> https://lore.kernel.org/all/166919750173.15575.2864736980735346730@emeril.freedesktop.org/

I thought there was a more recent submission, where I at least fixed the
various fallout in gem code. But maybe I only dreamed ...

Also I did the code grepping again, and at least iommu_dma_mmap() in
drivers/iommu/dma-iommu.c and arm_iommu_mmap_attrs() for arm use
vm_map_pages in certain cases, which is _not_ VM_PFNMAP.

Means really no cases where I think we can assume we'll always get
VM_PFNMAP, and unfortunately we need VM_PFNMAP or VM_IO to prevent
get_user_pages and similar bad things from happening to dma-buf mmaps.

So still no luck :-/
-Sima


> 
> > >
> > > > [1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/mm/vmscan.c?id=fb46e22a9e3863e08aef8815df9f17d0f4b9aede
> > > >
> > > > Fixes: b61614ec318a ("dma-buf: heaps: Add CMA heap to dmabuf heaps")
> > > > Signed-off-by: T.J. Mercier<tjmercier@google.com>
> > >
> > > Acked-by: Christian König <christian.koenig@amd.com>
> 
> Thanks Christian.

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

