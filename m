Return-Path: <linux-kernel+bounces-38378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD6983BE85
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8691D28C00F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C370D1CAAC;
	Thu, 25 Jan 2024 10:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="crzCrYot"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D88E1CA97
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 10:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706177992; cv=none; b=qgLd4v26pDZGlJjFt/DiH5XcMqgR01xBMK+w1PNkKZt6owXQ6dSO7/VSqqwfgAFqcx1Ys/kPgnfMXs99TU0+ELnM/Q/u77CoC4EZYEbNQLHEeCrbFRZJ1FOtpujTYdeuBKeqzBSTwHB1IZz0Xc0MMFUx7sBS+riFSYZ7J8tbyRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706177992; c=relaxed/simple;
	bh=SNTqFndHS7fusbc/JoJL6VmM5mMHU74c/gZCl49dXII=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BxBJlIj9Q/CJsGAkf9NDxpO8ZyMYEwekqIvg/6kd//dDstWzrT0YahF9wssmBALQ2ahjzkYPeAbyPPPs1hVZLEjSRKjJN08fckS5X7unmgk9vfs+ntEoRcTnOQtoZ9v/6+EjscCznNl1K9xSmmudY6bsVfqifIz8W+2xS8Z3VbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=crzCrYot; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706177988;
	bh=SNTqFndHS7fusbc/JoJL6VmM5mMHU74c/gZCl49dXII=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=crzCrYotEFR6vHCVGwVhc8KCpzfBEpAGjgrKWvRQ8thXlbUnvSjkuRRNucJZMkYO3
	 zpqJs3oi/mRonlfMsnR8WglzPGURtXrGnD/c/EYZ1qzVEvXG5SWZ+3mf0fypx2lfQL
	 L3YMzd1en2ZEJrPhSPIYcmV60/0CrIV3BaDFTOyvRlZGDTWAZan6sjhww3Gi5+rw2s
	 2U+wIVvsDuFaCAgxTFLxMryEeh3XIyFe/HQpQAcOv69BfzfzdalaQ1yFWDlugbiSn2
	 qnEmc23s7Q2UktOoh6Hqknk3+8RnVzZLFTFb7lAWGInDP7jaaTmNsmXeVf2H8/RTZN
	 QjpJHe786N2vw==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 657083780FC7;
	Thu, 25 Jan 2024 10:19:47 +0000 (UTC)
Date: Thu, 25 Jan 2024 11:19:46 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: David Airlie <airlied@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Qiang Yu <yuq825@gmail.com>, Steven Price
 <steven.price@arm.com>, Emma Anholt <emma@anholt.net>, Melissa Wen
 <mwen@igalia.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel@collabora.com,
 virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v19 22/30] drm/shmem-helper: Add common memory shrinker
Message-ID: <20240125111946.797a1e1e@collabora.com>
In-Reply-To: <20240105184624.508603-23-dmitry.osipenko@collabora.com>
References: <20240105184624.508603-1-dmitry.osipenko@collabora.com>
	<20240105184624.508603-23-dmitry.osipenko@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  5 Jan 2024 21:46:16 +0300
Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:

> +static bool drm_gem_shmem_is_evictable(struct drm_gem_shmem_object *shmem)
> +{
> +	return (shmem->madv >= 0) && shmem->base.funcs->evict &&
> +		refcount_read(&shmem->pages_use_count) &&
> +		!refcount_read(&shmem->pages_pin_count) &&
> +		!shmem->base.dma_buf && !shmem->base.import_attach &&
> +		!shmem->evicted;

Are we missing

                && dma_resv_test_signaled(shmem->base.resv,
					  DMA_RESV_USAGE_BOOKKEEP)

to make sure the GPU is done using the BO?
The same applies to drm_gem_shmem_is_purgeable() BTW.

If you don't want to do this test here, we need a way to let drivers
provide a custom is_{evictable,purgeable}() test.

I guess we should also expose drm_gem_shmem_shrinker_update_lru_locked()
to let drivers move the GEMs that were used most recently (those
referenced by a GPU job) at the end of the evictable LRU.

> +}
> +

