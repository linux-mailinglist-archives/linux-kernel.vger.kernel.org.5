Return-Path: <linux-kernel+bounces-129094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1840D8964CD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C736E283FF7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 06:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8EB4778B;
	Wed,  3 Apr 2024 06:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="X1u1ZoyM"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F15341C72
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 06:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712126793; cv=none; b=ani+A/dwgOwplthcG8mTO7ZL5QxT1gAg5MX00cCuRoBTueDyIYHWN5cZIBTQ/P8rI4URfec89bNMRj2lHj9OrPP7V2P6IyrflLLTkQk08NAF+WEtnOijIvz4ldPWXvYVdjT00cBtHevfmwKKkP1undQAY4AS8BTyJcpaGE9w1nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712126793; c=relaxed/simple;
	bh=4o3ntBNpYqUgIZdHQ1U/y0jQBsMQSH9TcFAtLdKyjuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZtTBe0QUi4NEblJwef7c/0JiPmnXAsLiwd528SPbAHkEFoyvu+46T3A7z02PsMnrQa+cIHpKoZE2cg5qYxcDlyIttFfxXqPVkTB4PLKLpVTz3Zbxbd/eUcPsb5Kx+e9mdRZ8xlBG+ZTkrINyXCT2twvR7dfjjxydr10dCxl5znk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=X1u1ZoyM; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712126784;
	bh=4o3ntBNpYqUgIZdHQ1U/y0jQBsMQSH9TcFAtLdKyjuQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X1u1ZoyMammAE08xT4ox6hLmoYLdDW2GFZgpWa/l4VDVw1cvFaJ907uYdCznXLMc6
	 iSN+Kq53I024oSSq5XxM9VjtWJCTrR15wJueEd+Yc/o3+E6Kz2eex32ekASSCJ5C87
	 m7RiImAzBk4U0Kan8hsvzO6IGt3ZhyMf4D+xwMK2nIhiLJSQd/BbJx3WnH2paVaoqz
	 CBt2m4M6cqLMc3mCvUuo0eGNfakYuAIUVvwuyfNGgCCR5BfwyZo8Hj9Vo+pfJhN8wO
	 bmh2Fu7mSTNSxC6RPbGXF/HmH4FrcsbHotrdcOkxQBDWJXKU0OnKoGZQ8nYbVjRVk5
	 pJwoXxKZZ75mg==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D632237820CD;
	Wed,  3 Apr 2024 06:46:23 +0000 (UTC)
Date: Wed, 3 Apr 2024 08:46:22 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Steven Price
 <steven.price@arm.com>
Subject: Re: [PATCH 1/2] drm/panthor: Cleanup unused variable 'cookie'
Message-ID: <20240403084622.4fc0f0d8@collabora.com>
In-Reply-To: <20240402215423.360341-1-liviu.dudau@arm.com>
References: <20240402215423.360341-1-liviu.dudau@arm.com>
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

On Tue,  2 Apr 2024 22:54:22 +0100
Liviu Dudau <liviu.dudau@arm.com> wrote:

> Commit 962f88b9c916 ("drm/panthor: Drop the dev_enter/exit() sections in
> _irq_suspend/resume()") removed the code that used the 'cookie' variable
> but left the declaration in place. Remove it.
> 
> Fixes: 962f88b9c916 ("drm/panthor: Drop the dev_enter/exit() sections in _irq_suspend/resume()")
> Cc: Boris Brezillon <boris.brezillon@collabora.com>
> Cc: Steven Price <steven.price@arm.com>
> Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/panthor/panthor_device.h | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
> index dc3e9c666b5bd4..2fdd671b38fd9b 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.h
> +++ b/drivers/gpu/drm/panthor/panthor_device.h
> @@ -323,8 +323,6 @@ static irqreturn_t panthor_ ## __name ## _irq_threaded_handler(int irq, void *da
>  												\
>  static inline void panthor_ ## __name ## _irq_suspend(struct panthor_irq *pirq)			\
>  {												\
> -	int cookie;										\
> -												\
>  	pirq->mask = 0;										\
>  	gpu_write(pirq->ptdev, __reg_prefix ## _INT_MASK, 0);					\
>  	synchronize_irq(pirq->irq);								\
> @@ -333,8 +331,6 @@ static inline void panthor_ ## __name ## _irq_suspend(struct panthor_irq *pirq)
>  												\
>  static inline void panthor_ ## __name ## _irq_resume(struct panthor_irq *pirq, u32 mask)	\
>  {												\
> -	int cookie;										\
> -												\
>  	atomic_set(&pirq->suspended, false);							\
>  	pirq->mask = mask;									\
>  	gpu_write(pirq->ptdev, __reg_prefix ## _INT_CLEAR, mask);				\


