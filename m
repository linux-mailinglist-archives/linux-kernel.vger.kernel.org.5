Return-Path: <linux-kernel+bounces-118840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D2C88C00E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BA361F36417
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12A214AB8;
	Tue, 26 Mar 2024 10:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="w/mLZvXV"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC18DDBC;
	Tue, 26 Mar 2024 10:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711450780; cv=none; b=GRZI+xXOJ1cPzWFyWO/lSpgn1uIoRd2mF/52BO33ERESGLGpDMk5j/k4ereWr0lq1XQhtJHAeWNZTDHXV94fvmOLu0G19FeMnRXMP66RaaNoHj1GJT+ihUc5iyGRH9iMXpLILdx3p3z1Ieo4/2j3nrHSxNuZIsE1lCwYKHp3u3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711450780; c=relaxed/simple;
	bh=aliybyz47uinRGXtRKuSPxDxjVQ2TQQ62bnfexZTrs0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e/V3+HxgSCpd8jtcuU/LT0WM+/7/nv0Pufv6KmIJ1pvIXi4BhX3uZ43d7PRZagOU54tiEGfBTYq+j8bQdM+K0I8hzKWXLKUbnzWc1JSNT8d2a+Er/WiF1CMuDsqouidHMQaAPHDa3quq3zZCW/igFgf0HzHmtfqK3zgK/jECFPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=w/mLZvXV; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711450776;
	bh=aliybyz47uinRGXtRKuSPxDxjVQ2TQQ62bnfexZTrs0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=w/mLZvXVacsLyu1w1YPitYD7b71BVTkwHwEjVQcPrOlcSprscNQbgLFCPjs/hv7VD
	 IAi2JzFPKfGSXYLyD/5JEMz1xHzAG7FnqOgmU6OXf/yCn3rWflQExN6oWNoXtygBno
	 hqIcspidGTNLc3p86j0Ng5RuU+ag+toUkvuZ1XwqBcL7F+AcM9Aiw8NBvxPoZ0gzu/
	 lrwGH4xuuRNaQhS2+lxjsPvUWO0Lm0jjjX0DSzDfinIlY2BPDQsnvapUW3RqFRvWAE
	 lgZUdXc4RUXE3pmiWskVNBM3PDHe5qB7V8lG4FngdaxSyYKTgC+GrEO5E7eMjZDIN+
	 quDDouyKuxzRg==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3E65B378110A;
	Tue, 26 Mar 2024 10:59:36 +0000 (UTC)
Date: Tue, 26 Mar 2024 11:59:34 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] drm/panthor: Fix spelling mistake "readyness" ->
 "readiness"
Message-ID: <20240326115934.726d3ca1@collabora.com>
In-Reply-To: <20240326100219.43989-1-colin.i.king@gmail.com>
References: <20240326100219.43989-1-colin.i.king@gmail.com>
Organization: Collabora
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Mar 2024 10:02:19 +0000
Colin Ian King <colin.i.king@gmail.com> wrote:

> There is a spelling mistake in a drm_err message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Queued to drm-misc-next.

> ---
>  drivers/gpu/drm/panthor/panthor_gpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
> index 6dbbc4cfbe7e..0f7c962440d3 100644
> --- a/drivers/gpu/drm/panthor/panthor_gpu.c
> +++ b/drivers/gpu/drm/panthor/panthor_gpu.c
> @@ -333,7 +333,7 @@ int panthor_gpu_block_power_on(struct panthor_device *ptdev,
>  						 val, (mask32 & val) == mask32,
>  						 100, timeout_us);
>  		if (ret) {
> -			drm_err(&ptdev->base, "timeout waiting on %s:%llx readyness",
> +			drm_err(&ptdev->base, "timeout waiting on %s:%llx readiness",
>  				blk_name, mask);
>  			return ret;
>  		}


