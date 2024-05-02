Return-Path: <linux-kernel+bounces-166030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CED58B94FA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19462282D28
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 07:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E4E219E0;
	Thu,  2 May 2024 07:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FjEkK6MI"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4131C6A1;
	Thu,  2 May 2024 07:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714633315; cv=none; b=UZqq3xwCmBBMZeZcC1IS22hYrp7hCL1wHmBGNYmM3QsYlCk07lcFnILQzsbLO2IhP/VR/+hjr1S9sGvSAKB3lxMj2tt1xmOvctLHXevebcLbPeLeitICBVEHe5xNklcqjid5kmWN48lKMh5oTGHGfgXl4Jetl0CJh5IL8C4A4X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714633315; c=relaxed/simple;
	bh=ye0z1gvg/13+dE7aKuIpgiRz56aWOAjKJk0D7Jw1sUo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hVX+29GzROm7mVcwniXgmVR7+7vU4F++BJPj0qaCk2+B/3WuNRxH8UTm2SwACkWrEafWuc7HrIDQ8+8t4ZE8EX5ns2oogyBw+PGTqUYX2TMD2rQixlkhIQL+zCBGZaNKEhSjuSOVhriXFRCE/aOspmY2788NnKw1kaLvLfaC8u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FjEkK6MI; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1714633311;
	bh=ye0z1gvg/13+dE7aKuIpgiRz56aWOAjKJk0D7Jw1sUo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FjEkK6MIljTrW0uRzXQtKQ1y+L14noagP3H/HU6s67kg11Ms7psh0xBb+Uy8Vxp/0
	 m3W/xptTS4qVG6ogj0md1BNlSq/ovLmjiE28jRYKCpcBgPxZuXqnLJj7J3TbaD8cCK
	 LcX3zoQNgKeOabzgC+q415bkgSvNDwGBf+Xs6EyP/sAwjw7Ch7m2c9OELBUWiWECNx
	 SVRgHGQqDCS9w/740n9hXChe/oZbLvS2Ea33E7KRMKGAUoq0RObgbyVHGtJjNipn8d
	 6FYWxYhjaH0LOBfsOgj5VFcKhlbWA7Gd9rHqmNE9BAdIfgYEr6p7QpArQ3yDz+Muo6
	 KuN8lPAhZp5wA==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D4D2F378001E;
	Thu,  2 May 2024 07:01:50 +0000 (UTC)
Date: Thu, 2 May 2024 09:01:49 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: Qiang Yu <yuq825@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh@kernel.org>, Steven
 Price <steven.price@arm.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian Koenig= <christian.koenig@amd.com>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, Zack Rusin <zack.rusin@broadcom.com>,
 kernel@collabora.com, dri-devel@lists.freedesktop.org,
 lima@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v3 2/2] drm/gem-shmem: Add import attachment warning to
 locked pin function
Message-ID: <20240502090149.6b33817e@collabora.com>
In-Reply-To: <20240501065650.2809530-3-adrian.larumbe@collabora.com>
References: <20240501065650.2809530-1-adrian.larumbe@collabora.com>
	<20240501065650.2809530-3-adrian.larumbe@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed,  1 May 2024 07:56:00 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> Commit ec144244a43f ("drm/gem-shmem: Acquire reservation lock in GEM
> pin/unpin callbacks") moved locking DRM object's dma reservation to
> drm_gem_shmem_object_pin, and made drm_gem_shmem_pin_locked public, so we
> need to make sure the non-NULL check warning is also added to the latter.
>=20
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
> ---
>  drivers/gpu/drm/drm_gem_shmem_helper.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm=
_gem_shmem_helper.c
> index 177773bcdbfd..ad5d9f704e15 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -233,6 +233,8 @@ int drm_gem_shmem_pin_locked(struct drm_gem_shmem_obj=
ect *shmem)
> =20
>  	dma_resv_assert_held(shmem->base.resv);
> =20
> +	drm_WARN_ON(shmem->base.dev, shmem->base.import_attach);

If we add a WARN_ON() here, we can probably drop the one in
drm_gem_shmem_pin(), and do the same for drm_gem_shmem_unpin[_locked]()
to keep things consistent.

> +
>  	ret =3D drm_gem_shmem_get_pages(shmem);
> =20
>  	return ret;


