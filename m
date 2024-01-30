Return-Path: <linux-kernel+bounces-44151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2246841E00
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F0E5B2A52F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2752F57302;
	Tue, 30 Jan 2024 08:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="VLFkN1Km"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF11D5647A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 08:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706603949; cv=none; b=N5hTTxqiqnKYhX1ET1ceLJUQdxTla1FJk1aTH1YlbRRIg+BBAxjCUqDofwSCoXXvDrii1eniEjCWd2ledNkLnpPvf460PgKBEt6wUB0QP1TeVKtZsX0QGSXO10FRoprBhGkH1mlgXwL8VVbe3O9qFIbuFDgK9szFI9w6j+puRJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706603949; c=relaxed/simple;
	bh=UKBvv/BFlyrDxBcZH/pwwW+bTFeY41MHyLdKXLHf118=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RcWbZlQA2IBIJQrlVZ0KxIRvkcpcxXd3oO+HZpNt3KEdvrQMx6pJkmoFKkTb6uUPc55m4pwbp1JvlTyPVEGHzm33nJ+95GWF904pqFmGGZMxPdvUKl+tUVaOv5LYpRAiQa1lleSGPT+FODz3uOM558nbHxsyVBaJumslCqFiDRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=VLFkN1Km; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a352d9c0f9dso108323166b.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 00:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1706603946; x=1707208746; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TE8g68bLoogToLshL4JAe9mPYk5p/5wsw2SHoYT3R4c=;
        b=VLFkN1KmuWTsVitoLnBh79rcMLIg3LOLoqWwkQf+bPNukQbpPJTaYrMFXakN42Kcny
         G6ez3u1M278sO8iOxJ7xvldiPgnYcXcQ+1JLrCJM/R7kINbII56iwpolpooBZsaEDuPE
         aqoDTzevT0CB1HXbU4RVdkOUuGCut+GMxw7LY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706603946; x=1707208746;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TE8g68bLoogToLshL4JAe9mPYk5p/5wsw2SHoYT3R4c=;
        b=bXFdAS6i48JbBozqgUfJ9bmttbeX+dLpJSUx6JmtXAoJeabOuXfY1O+TY8AtXVs0Qy
         ARANU7PPWbWG46GM4H3b6azlUN1JMwYQCprpJSUrJmvXwGPeYydjnoRH2vwsPh+ZWjsH
         GgnKetx2OxC3Y3rvOHzcP3QvgKXk0XiNzz11S8pMkPVpq3uRAsx2ItmV+9ePfB/uyzir
         zn6XceHqqYn4iieG9wVPOwBR3ZcWA5LUWWfvYJJ6H8LAiIgFERDr+Ry9fcf3fds5W9YY
         kJT40+P5w1NxT9cuYVDCJ4S6w+wDP6+ZWrW0NO3N16TD+3kAt49njmpGAYRyMlrCgxN3
         ShTQ==
X-Gm-Message-State: AOJu0YxAKmKSrf3eFaFf2Z+3mpBwS3alGagMa2VE5S5cCzVJdJ0+uuMO
	hAmv+SsWqfCYIzjoMalB6ylfCe1pnbTpIyPlHRvXkATPgS69I5EIHbxcdkqrcJ4=
X-Google-Smtp-Source: AGHT+IFdCTZEdjvisRYBnyq6kNe7z03n8kmvQKAP+gzRjiJX+KgoRRSwkprv6TQSY4NWeiBUSsDbbA==
X-Received: by 2002:a17:906:6d01:b0:a35:561d:cf5a with SMTP id m1-20020a1709066d0100b00a35561dcf5amr5688909ejr.6.1706603945702;
        Tue, 30 Jan 2024 00:39:05 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id s8-20020a17090699c800b00a351828ca32sm4271064ejn.118.2024.01.30.00.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 00:39:05 -0800 (PST)
Date: Tue, 30 Jan 2024 09:39:03 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	David Airlie <airlied@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Qiang Yu <yuq825@gmail.com>, Steven Price <steven.price@arm.com>,
	Emma Anholt <emma@anholt.net>, Melissa Wen <mwen@igalia.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	kernel@collabora.com, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v19 22/30] drm/shmem-helper: Add common memory shrinker
Message-ID: <Zbi1pzY3CbQxnnBQ@phenom.ffwll.local>
Mail-Followup-To: Boris Brezillon <boris.brezillon@collabora.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
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
 <20240105184624.508603-23-dmitry.osipenko@collabora.com>
 <20240125100703.76d802ad@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125100703.76d802ad@collabora.com>
X-Operating-System: Linux phenom 6.6.11-amd64 

On Thu, Jan 25, 2024 at 10:07:03AM +0100, Boris Brezillon wrote:
> On Fri,  5 Jan 2024 21:46:16 +0300
> Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:
> 
> >   *
> >   * This function Increases the use count and allocates the backing pages if
> >   * use-count equals to zero.
> > + *
> > + * Note that this function doesn't pin pages in memory. If your driver
> > + * uses drm-shmem shrinker, then it's free to relocate pages to swap.
> > + * Getting pages only guarantees that pages are allocated, and not that
> > + * pages reside in memory. In order to pin pages use drm_gem_shmem_pin().
> 
> I still find this explanation confusing, if pages are allocated, they
> reside in memory. The only difference between drm_gem_shmem_get_pages()
> and drm_gem_shmem_pin_pages() is that the former lets the system
> reclaim the memory if the buffer is idle (no unsignalled fence attached
> to the dma_resv).
> 
> We also need to describe the workflow for GEM validation (that's the
> TTM term for the swapin process happening when a GPU job is submitted).
> 
> 1. Prepare the GPU job and initialize its fence
> 2. Lock the GEM resv
> 3. Add the GPU job fence to the resv object
> 4. If the GEM is evicted
>    a. call drm_gem_shmem_swapin_locked()
>    b. get the new sgt with drm_gem_shmem_get_pages_sgt_locked()
>    c. repopulate the MMU table (driver internals)

Might be good to explain where to call drm_sched_job_arm() here for
drivers using drm/sched, since that also needs to be at a very specific
point. Probably best to flesh out the details here by linking to the
relevant drm/sched and gpuvm functions as examples.

> 5. Unlock the GEM dma_resv
> 6. Submit the GPU job
> 
> With this sequence, the GEM pages are guaranteed to stay around until
> the GPU job is finished.

Yeah I think the comment needs to explain how this ties together with
dma_resv locking and dma_resv fences, otherwise it just doesn't make much
sense.

This holds even more so given that some of the earlier drivers derived
from i915-gem code (and i915-gem itself) use _pin() both for these more
permanent pinnings, and also to temporarily put the memory in place before
it all gets fenced and then unpinned&unlocked.

So would be really good to have the sharpest possible nomeclatura here we
can get, and link between all the related concepts and functions in the
kerneldoc.

Some overview flow like Boris sketched above in a DOC: section would also
be great.

Cheers, Sima
> 
> >   */
> >  int drm_gem_shmem_get_pages(struct drm_gem_shmem_object *shmem)

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

