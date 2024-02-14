Return-Path: <linux-kernel+bounces-65296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A693854AC2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7CE5B264D9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A2E54BDE;
	Wed, 14 Feb 2024 13:52:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F1D54BD2
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 13:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707918727; cv=none; b=TXnGsyo9KD6ok64HiF6mj3u91L6LeootqiXbSUtc0Hsz8R0nznM/2fvTzwQ0k5tfD1u1xAQWrdXIji7TN4vxqd2oYuMOCslaY6LTEm/qtwlqwFYg7nGDKn5B0IXMuU3IYU4Ja0kZEAW1xCcXdh4gIypEZfhLuNVCR5dwiegW78k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707918727; c=relaxed/simple;
	bh=LrtHpvJw1vI6P720DwnUq6dxSYylRr0Q5fQtw2Jur1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ev+wEyeD04I05ZN22DGK39P+29o9Bt40vxi41oO3LMEVQkQcFjGat89kC5ZD6uWDnKbEV/3Z9IrXjXnuym+ZtV6Q+fojz3BduN9a6NBuz+NddLvc+l/TmAw+I38san+pKZ9PaLwH19aeKtVlLkJLd8XoJEMrovHP7ie78oDC8d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F77B1FB;
	Wed, 14 Feb 2024 05:52:45 -0800 (PST)
Received: from [10.57.64.191] (unknown [10.57.64.191])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B8B7A3F5A1;
	Wed, 14 Feb 2024 05:52:02 -0800 (PST)
Message-ID: <ba987da3-b4aa-410c-95ae-434e94793d85@arm.com>
Date: Wed, 14 Feb 2024 13:52:05 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] Always record job cycle and timestamp information
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20240214121435.3813983-1-adrian.larumbe@collabora.com>
Content-Language: en-GB
From: Steven Price <steven.price@arm.com>
In-Reply-To: <20240214121435.3813983-1-adrian.larumbe@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Adrián,

On 14/02/2024 12:14, Adrián Larumbe wrote:
> A driver user expressed interest in being able to access engine usage stats
> through fdinfo when debugfs is not built into their kernel. In the current
> implementation, this wasn't possible, because it was assumed even for
> inflight jobs enabling the cycle counter and timestamp registers would
> incur in additional power consumption, so both were kept disabled until
> toggled through debugfs.
> 
> A second read of the TRM made me think otherwise, but this is something
> that would be best clarified by someone from ARM's side.

I'm afraid I can't give a definitive answer. This will probably vary
depending on implementation. The command register enables/disables
"propagation" of the cycle/timestamp values. This propagation will cost
some power (gates are getting toggled) but whether that power is
completely in the noise of the GPU as a whole I can't say.

The out-of-tree kbase driver only enables the counters for jobs
explicitly marked (BASE_JD_REQ_PERMON) or due to an explicit connection
from a profiler.

I'd be happier moving the debugfs file to sysfs rather than assuming
that the power consumption is small enough for all platforms.

Ideally we'd have some sort of kernel interface for a profiler to inform
the kernel what it is interested in, but I can't immediately see how to
make that useful across different drivers. kbase's profiling support is
great with our profiling tools, but there's a very strong connection
between the two.

Steve

> Adrián Larumbe (1):
>   drm/panfrost: Always record job cycle and timestamp information
> 
>  drivers/gpu/drm/panfrost/Makefile           |  2 --
>  drivers/gpu/drm/panfrost/panfrost_debugfs.c | 21 ------------------
>  drivers/gpu/drm/panfrost/panfrost_debugfs.h | 14 ------------
>  drivers/gpu/drm/panfrost/panfrost_device.h  |  1 -
>  drivers/gpu/drm/panfrost/panfrost_drv.c     |  5 -----
>  drivers/gpu/drm/panfrost/panfrost_job.c     | 24 ++++++++-------------
>  drivers/gpu/drm/panfrost/panfrost_job.h     |  1 -
>  7 files changed, 9 insertions(+), 59 deletions(-)
>  delete mode 100644 drivers/gpu/drm/panfrost/panfrost_debugfs.c
>  delete mode 100644 drivers/gpu/drm/panfrost/panfrost_debugfs.h
> 
> 
> base-commit: 6b1f93ea345947c94bf3a7a6e668a2acfd310918


