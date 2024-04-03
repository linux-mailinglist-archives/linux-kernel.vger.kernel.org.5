Return-Path: <linux-kernel+bounces-129144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC478965D1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53E4E28336B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CCE5A4E9;
	Wed,  3 Apr 2024 07:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZSOfNFjC"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D535491E
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 07:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712128513; cv=none; b=YFeo/bV/GMIxrcFc7lRBB1SQaD4ifpefVUq+yZL5JlQp1OZyRA6CD4hbeabeIyTRvxroD8dZxPV5FlBjCUF9SKANIgSPasAM11tCEuaahIJaELuPZ+JcL86JgE06hINnHpBoZg5SI1J8NOKsXZxrY73Kug6ocAvCwF11ilkWO4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712128513; c=relaxed/simple;
	bh=qzfSfHG2Ybl71GhTl+7btqP37t8xlMwKwQEX6DKSPuc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZCx1gYcTo5OOCVNfoNbmcySHTDU/XwDTrbD8k68K1D9lHkEu4mPzBYzWxlprpc9pec833kA/+aIuNesWE1LVm32VfiaqX2JMfDNAl3OMrFoHFSthM/1mxKt0Rp6H55IwaTlBHUS7lB/tw1rzW2MuUg7mFL1cZ4RjxD1sKiUdcbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZSOfNFjC; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712128510;
	bh=qzfSfHG2Ybl71GhTl+7btqP37t8xlMwKwQEX6DKSPuc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZSOfNFjCrw4xsn7R+uqY+6VzlKRxIvoD/aWVbFtNhVn80sXm02Bpr0gqGSLr91zGw
	 xW9JDqijVntntCRsYNToY5aHEpTTk5vMJvV5iOET1iEh/rPQWmqYfmBxvd2uAxrMXa
	 M6FLuM6v0VNaXLK6f8a9P8biOAGSNpeKj3E9QTId/4fZK/EUhxcu//uD1k3ls5qR8o
	 IJyXSr1qf5gIWSfvNXBSR1ZPVBorEi3GEPn7kHU1kdnzYve/6g8CddMB3EqQzkJ1lC
	 IAIEuNJLm1ZaePI9aCxLzUJZlojyAVbsIe+OCcH6EGf6Z3Cggf/p4GbWgrLEpV83Ra
	 n22K46WdDofYQ==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D9F1037813DC;
	Wed,  3 Apr 2024 07:15:09 +0000 (UTC)
Date: Wed, 3 Apr 2024 09:15:08 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Steven Price
 <steven.price@arm.com>
Subject: Re: [PATCH 1/2] drm/panthor: Cleanup unused variable 'cookie'
Message-ID: <20240403091508.009369b0@collabora.com>
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

Queued both patches to drm-misc-next.

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


