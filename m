Return-Path: <linux-kernel+bounces-129095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 701508964CF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A16B31C21ADF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 06:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E9B5339E;
	Wed,  3 Apr 2024 06:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Hthilw/9"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5349454750
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 06:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712126797; cv=none; b=bg4agPocc+VO2/Ih+TWlDgY+0/LhCjBnCG1OM2eCj+yFMJhKKFUroYOowrYSbh1n9vkzhOdT6S1kDAesU4ZGeQQROI6UoDglxg6eoWk/DI/WjRZ6wlWVtg7egpTCibYpn0BJR5aSt7fiHpVKNpwjpmx7pFf/f8BfwYESdDklknU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712126797; c=relaxed/simple;
	bh=hIZbR30slL0FGdXzurjYhKrkjHFf/JJm1t6jgO08JD4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NunosIlu5bAG9DfSEM/KHNkN89APeG/euZuK8/U3tbvJdNPvdCn/wKb7IQfQ6/nfFJbUoiDboS09AFB8+JtG8u3DEsVYBZ4y7eoQ1cE9erHkUPObWCeWdBDHYGIWCtA2vUje9NjQkS58c1CeO3cPaNEoZX7shRMdWibdKd1VOE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Hthilw/9; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712126794;
	bh=hIZbR30slL0FGdXzurjYhKrkjHFf/JJm1t6jgO08JD4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Hthilw/9ANClt2yi6/22ZMDxCdxvHBUzkkCsc8nIh47vcWiehNKyppXr4RWnNrOAn
	 b8lOtpyt2+U0vyt7Pk8doYFk1OgkiNAdgieEGX/dRNt+lOLgO+VtMejN2nun+fFabx
	 cEXlr/9+8hjy13Id0Xt1FwkLDxk9KDbyc0YqtRT41T+ZpvRHkeep9j+5lkmAF9KRI+
	 x83CIo4JPjpcCuLGsHKv/jwOBewKLWoWjtOP5Mk2PBmCpYAbphnZyxSTUpsSK4ceJ1
	 aGACxe25MTdgV21rrl0tq6cziIvbtIJmUKx23uDg/nhgcZV8BPbT0t8mGILseWScbY
	 YdrJcMmpPGWLQ==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 155F737820CD;
	Wed,  3 Apr 2024 06:46:34 +0000 (UTC)
Date: Wed, 3 Apr 2024 08:46:32 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Steven Price
 <steven.price@arm.com>
Subject: Re: [PATCH 2/2] drm/panthor: Fix some kerneldoc warnings
Message-ID: <20240403084632.1d00d1c6@collabora.com>
In-Reply-To: <20240402215423.360341-2-liviu.dudau@arm.com>
References: <20240402215423.360341-1-liviu.dudau@arm.com>
	<20240402215423.360341-2-liviu.dudau@arm.com>
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

On Tue,  2 Apr 2024 22:54:23 +0100
Liviu Dudau <liviu.dudau@arm.com> wrote:

> When compiling with W=1 the build process will flag empty comments,
> misnamed documented variables and incorrect tagging of functions.
> Fix them in one go.
> 
> Fixes: de8548813824 ("drm/panthor: Add the scheduler logical block")
> Cc: Boris Brezillon <boris.brezillon@collabora.com>
> Cc: Steven Price <steven.price@arm.com>
> Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/panthor/panthor_sched.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> index e5a710f190d2a8..a787f2fea33e98 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -517,7 +517,7 @@ struct panthor_group {
>  	/** @max_compute_cores: Maximum number of shader cores used for compute jobs. */
>  	u8 max_compute_cores;
>  
> -	/** @max_compute_cores: Maximum number of shader cores used for fragment jobs. */
> +	/** @max_fragment_cores: Maximum number of shader cores used for fragment jobs. */
>  	u8 max_fragment_cores;
>  
>  	/** @max_tiler_cores: Maximum number of tiler cores used for tiler jobs. */
> @@ -993,7 +993,7 @@ cs_slot_prog_locked(struct panthor_device *ptdev, u32 csg_id, u32 cs_id)
>  }
>  
>  /**
> - * @cs_slot_reset_locked() - Reset a queue slot
> + * cs_slot_reset_locked() - Reset a queue slot
>   * @ptdev: Device.
>   * @csg_id: Group slot.
>   * @cs_id: Queue slot.
> @@ -1591,7 +1591,7 @@ static void sched_process_idle_event_locked(struct panthor_device *ptdev)
>  }
>  
>  /**
> - * panthor_sched_process_global_irq() - Process the scheduling part of a global IRQ
> + * sched_process_global_irq_locked() - Process the scheduling part of a global IRQ
>   * @ptdev: Device.
>   */
>  static void sched_process_global_irq_locked(struct panthor_device *ptdev)
> @@ -1660,8 +1660,6 @@ static const struct dma_fence_ops panthor_queue_fence_ops = {
>  	.get_timeline_name = queue_fence_get_timeline_name,
>  };
>  
> -/**
> - */
>  struct panthor_csg_slots_upd_ctx {
>  	u32 update_mask;
>  	u32 timedout_mask;


