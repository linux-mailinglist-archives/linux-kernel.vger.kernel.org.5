Return-Path: <linux-kernel+bounces-44142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F84841DDA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FE3F1F26BBD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DE257864;
	Tue, 30 Jan 2024 08:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Sps8DPnU"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F89956B70
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 08:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706603676; cv=none; b=HfuGi95RDWW715r7BivJATG4vfeJyyNzIKF9L8p6d8RhIf2bn5Km1PeFnz4wjF2RYrtFnrUrbDp8+D/CzesuF4F+tAn0IKxsk50GTeOqhmeyBatk/pc8zj27MboJE0Hp4z+x/CnqTZ7ruk+jN7t6MOgTm0k3v9HLUaztj9PJ0Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706603676; c=relaxed/simple;
	bh=QPi9hZzAmAQnGpjqKJGPTf9pYceX3vVYfjquOOScukk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RbmhDdDZYTdZmFvLdvNpBFWPWEvz0x8GDYk9AiF6wIBoZ8LML1DXkksdEtS2MYt2g/Mo1O9nVvjAtipCFQI6BFaYUnswtTKkt/u36csnUm+hYvwajQHdpSJ14n41983MGKICFtLRzuGScod28/pjOiJxfnFQ70Mg6jc2AhjoszQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=Sps8DPnU; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55f3e2ef98bso76041a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 00:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1706603672; x=1707208472; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8A/F0qjSBSUkCN1wUoX6X3MUwGOk7GLAJ8sdI6nLy84=;
        b=Sps8DPnUh2UUYf5NvuaIZrR9NhIBNI2dOWbs4G4dDn2+VR0KE/4qe8pn+J4PWPrxI+
         qbiEa6l3V5QqbeECkwnP1YOlSHIMUvX64K8pqmBZJoYT5GMJNzoc7JJpx+/6ZqaerdAB
         Vg0Xnke5ainMrTP32aYOeKNWHlk9E7CVVxoyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706603672; x=1707208472;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8A/F0qjSBSUkCN1wUoX6X3MUwGOk7GLAJ8sdI6nLy84=;
        b=NAy/+lmf+opPe/80/QmUurSL/Dj0yn9/Obp4ENKmxJbA7OBtJ+On0p8MqIS/5Z60aX
         G7SnS1vEaG+wTXGTg95ZPqyb2rEySe13pe7MCorERpKbw11vjkNX4fCQcFrZhrRREcT4
         P1OaHcsuUnbNTB/zZph69bbl0i4r0L77h6HzFxntrcJ/WnSYl929HicCcxOpeJ9ot5Ng
         7wmNwkHQnoxnDZhgHqOazd7e6kDbJkyqt9G2Ba7506FPTCFIiegJ44JeN8/qcixPgImC
         1sVx+5ytzysr/FHLqIV89Gr0X8HosSVnXf1quK0bdbJCuBgoGMqWsp0aTSj81jAoTU+I
         BXZg==
X-Gm-Message-State: AOJu0Yzpy7OGvK187Z0+BXQG185Cl7jkU0RCnRXzniXusLzshcplLEyS
	Qx/B98mYfyRQjWfn63QcMM6JG31J7gB//8e6/iSIRZGSrqi92RFDGCB+l+BGKmc=
X-Google-Smtp-Source: AGHT+IFoBU0SlfO62YFQyBv5072jSKi3i4eibji92GBY7EfnrbEorrPEFCoLGaBtQ3uSEA6MKeKnRg==
X-Received: by 2002:a17:907:7d89:b0:a2c:4b28:90d5 with SMTP id oz9-20020a1709077d8900b00a2c4b2890d5mr7611829ejc.2.1706603672306;
        Tue, 30 Jan 2024 00:34:32 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id vx3-20020a170907a78300b00a363346802asm198856ejc.19.2024.01.30.00.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 00:34:31 -0800 (PST)
Date: Tue, 30 Jan 2024 09:34:29 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Qiang Yu <yuq825@gmail.com>, Steven Price <steven.price@arm.com>,
	Emma Anholt <emma@anholt.net>, Melissa Wen <mwen@igalia.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	kernel@collabora.com, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v19 09/30] drm/shmem-helper: Add and use lockless
 drm_gem_shmem_get_pages()
Message-ID: <Zbi0lQG15vz6iHJK@phenom.ffwll.local>
Mail-Followup-To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	David Airlie <airlied@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Qiang Yu <yuq825@gmail.com>, Steven Price <steven.price@arm.com>,
	Emma Anholt <emma@anholt.net>, Melissa Wen <mwen@igalia.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	kernel@collabora.com, virtualization@lists.linux-foundation.org
References: <20240105184624.508603-1-dmitry.osipenko@collabora.com>
 <20240105184624.508603-10-dmitry.osipenko@collabora.com>
 <ZbKZNCbZoV4ovWTH@phenom.ffwll.local>
 <20240126111827.70f8726c@collabora.com>
 <d467e5a4-6b61-4cad-8e38-c4495836a0d6@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d467e5a4-6b61-4cad-8e38-c4495836a0d6@collabora.com>
X-Operating-System: Linux phenom 6.6.11-amd64 

On Fri, Jan 26, 2024 at 07:43:29PM +0300, Dmitry Osipenko wrote:
> On 1/26/24 13:18, Boris Brezillon wrote:
> > On Thu, 25 Jan 2024 18:24:04 +0100
> > Daniel Vetter <daniel@ffwll.ch> wrote:
> > 
> >> On Fri, Jan 05, 2024 at 09:46:03PM +0300, Dmitry Osipenko wrote:
> >>> Add lockless drm_gem_shmem_get_pages() helper that skips taking reservation
> >>> lock if pages_use_count is non-zero, leveraging from atomicity of the
> >>> refcount_t. Make drm_gem_shmem_mmap() to utilize the new helper.
> >>>
> >>> Acked-by: Maxime Ripard <mripard@kernel.org>
> >>> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> >>> Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
> >>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> >>> ---
> >>>  drivers/gpu/drm/drm_gem_shmem_helper.c | 19 +++++++++++++++----
> >>>  1 file changed, 15 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> >>> index cacf0f8c42e2..1c032513abf1 100644
> >>> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> >>> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> >>> @@ -226,6 +226,20 @@ void drm_gem_shmem_put_pages_locked(struct drm_gem_shmem_object *shmem)
> >>>  }
> >>>  EXPORT_SYMBOL_GPL(drm_gem_shmem_put_pages_locked);
> >>>  
> >>> +static int drm_gem_shmem_get_pages(struct drm_gem_shmem_object *shmem)
> >>> +{
> >>> +	int ret;  
> >>
> >> Just random drive-by comment: a might_lock annotation here might be good,
> >> or people could hit some really interesting bugs that are rather hard to
> >> reproduce ...
> > 
> > Actually, being able to acquire a ref in a dma-signalling path on an
> > object we know for sure already has refcount >= 1 (because we previously
> > acquired a ref in a path where dma_resv_lock() was allowed), was the
> > primary reason I suggested moving to this atomic-refcount approach.
> > 
> > In the meantime, drm_gpuvm has evolved in a way that allows me to not
> > take the ref in the dma-signalling path (the gpuvm_bo object now holds
> > the ref, and it's acquired/released outside the dma-signalling path).
> > 
> > Not saying we shouldn't add this might_lock(), but others might have
> > good reasons to have this function called in a path where locking
> > is not allowed.
> 
> For Panthor the might_lock indeed won't be a appropriate, thanks for
> reminding about it. I'll add explanatory comment to the code.

Hm these kind of tricks feel very dangerous to me. I think it would be
good to split up the two cases into two functions:

1. first one does only the atomic_inc and splats if the refcount is zero.
I think something in the name that denotes that we're incrementing a
borrowed pages reference would be good here, so like get_borrowed_pages
(there's not really a naming convention for these in the kernel).
Unfortunately no rust so we can't enforce that you provide the right kind
of borrowed reference at compile time.

2. second one has the might_lock.

This way you force callers to think what they're doing and ideally
document where the borrowed reference is from, and ideally document that
in the code. Otherwise we'll end up with way too much "works in testing,
but is a nice CVE" code :-/

Cheers, Sima
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

