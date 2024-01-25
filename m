Return-Path: <linux-kernel+bounces-38112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CF483BB0B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E91BB1C214E4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 07:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E81A18044;
	Thu, 25 Jan 2024 07:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="zBWcBxnJ"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9477817BAE
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 07:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706169310; cv=none; b=S6iJVhUxjjs8VkUSjMUtZFbNLXEp/hIc3XA8Knr7GuMhebtXNbyBfmHUWFNn7zGF7/DY2Srj0HQ26jcmS0n6Vb3eMM7XDni8bnMM68L04NxQ7ItZYyPR6FCwPqk9KAvA6X818fDdiMZYoEEMibE7Y90PGMEYT2qvIyfbx58/m8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706169310; c=relaxed/simple;
	bh=pyMEcKtVJxb7T/GxClE/3Bz1lwTzPFpnniWDjB5Fa5o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WmdWud0fqJycTyqKgLPUglPU6PnhEtJf/Mbl5G+VEQZMEBlhznv3G7AUE2V3csCoCMX2gTY51bUhBz42QMJZ/7spnA9BIcR2ptrUChhfW6y3nRwjDjhIlD3YYetRkWDChiQKNhdKIJHIZROmK1B50f02rR8kWflMXakhsHIGcyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=zBWcBxnJ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706169305;
	bh=pyMEcKtVJxb7T/GxClE/3Bz1lwTzPFpnniWDjB5Fa5o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=zBWcBxnJsGwrfch37UMhqu8LOsolJ/KVQkSJosUgJJGDb13zcIFPsx6HODmWPyU8f
	 9Snas5pyoGFXvJxIG8IDHGvtHbNhq2E9pcEdcrwauBNR10UF4BXpcmcBpKtl8eA10W
	 eGtHePMNgsNf/tLNUwustb7V3WUku1kt6gubqx1HQu4eIFXO1tl0DZhkvxuOPpbKb5
	 F8LZNWLndzD6mX7VsvSNG8t8zZ721d38yKCLaiDKcTqkijAeVgOqfnf6TR3ryfd7S7
	 7lOI/jnhRkZwApt5Q7OsiAfZ01w21/IPJZ1uUhRowWTgHeQo8Rrl00L40pUw4slIu+
	 0Raekb75VHLsQ==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 460243781FC7;
	Thu, 25 Jan 2024 07:55:04 +0000 (UTC)
Date: Thu, 25 Jan 2024 08:55:02 +0100
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
Subject: Re: [PATCH v19 03/30] drm/gem: Document locking rule of vmap and
 evict callbacks
Message-ID: <20240125085502.3207ee29@collabora.com>
In-Reply-To: <20240105184624.508603-4-dmitry.osipenko@collabora.com>
References: <20240105184624.508603-1-dmitry.osipenko@collabora.com>
	<20240105184624.508603-4-dmitry.osipenko@collabora.com>
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

On Fri,  5 Jan 2024 21:45:57 +0300
Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:

> The vmap/vunmap/evict GEM callbacks are always invoked with a held GEM's
> reservation lock. Document this locking rule for clarity.
> 
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  include/drm/drm_gem.h | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
> index f835fdee6a5e..021f64371056 100644
> --- a/include/drm/drm_gem.h
> +++ b/include/drm/drm_gem.h
> @@ -156,7 +156,8 @@ struct drm_gem_object_funcs {
>  	 * @vmap:
>  	 *
>  	 * Returns a virtual address for the buffer. Used by the
> -	 * drm_gem_dmabuf_vmap() helper.
> +	 * drm_gem_dmabuf_vmap() helper. Called with a held GEM reservation
> +	 * lock.
>  	 *
>  	 * This callback is optional.
>  	 */
> @@ -166,7 +167,8 @@ struct drm_gem_object_funcs {
>  	 * @vunmap:
>  	 *
>  	 * Releases the address previously returned by @vmap. Used by the
> -	 * drm_gem_dmabuf_vunmap() helper.
> +	 * drm_gem_dmabuf_vunmap() helper. Called with a held GEM reservation
> +	 * lock.
>  	 *
>  	 * This callback is optional.
>  	 */
> @@ -189,7 +191,8 @@ struct drm_gem_object_funcs {
>  	 * @evict:
>  	 *
>  	 * Evicts gem object out from memory. Used by the drm_gem_object_evict()
> -	 * helper. Returns 0 on success, -errno otherwise.
> +	 * helper. Returns 0 on success, -errno otherwise. Called with a held
> +	 * GEM reservation lock.
>  	 *
>  	 * This callback is optional.
>  	 */


