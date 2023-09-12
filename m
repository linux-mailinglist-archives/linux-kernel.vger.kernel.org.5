Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D5979CBC7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 11:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbjILJaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 05:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233499AbjILJaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 05:30:00 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A79CF;
        Tue, 12 Sep 2023 02:29:56 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 29A2866072F2;
        Tue, 12 Sep 2023 10:29:55 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694510995;
        bh=AtoVPp9KLWE41rzu0WIVhCt5jV0VMJphXzqEX+DW2G8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Tzd+29xD39rOk6ka2D43td4QhORI9sYVOLYZ+kRj64PjJILhLGBkpdA1Q1r7F+aOV
         k7MVXVK4VsRMpccGIx0qTmlVMuKgJZKe6yN2ZFEwOgg6IzG57xkIaduSGfIwx6IG/M
         0UWA8e6AmGxEZe+FFNPZXqOqtwqWC6VKsW8NqmDLnZE0FbV9JnbZmNWh0Xtes5jWOE
         Uk7AK1bOP2gPyUBEX4nAVLnRxBYRc/Dypk1jM4sAqpMzCre4MPynL8lGxUZO1Sdr4A
         BduWpeMcbQC46wAsKzhQvl8BO6gs0N60Jfg5Xh0fvIWgNT+1qocyWXbMVcOK0hR9fF
         BfzCUYuLraY8A==
Date:   Tue, 12 Sep 2023 11:29:52 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run,
        marijn.suijten@somainline.org, robh@kernel.org,
        steven.price@arm.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        healych@amazon.com, kernel@collabora.com,
        freedreno@lists.freedesktop.org
Subject: Re: [PATCH v4 5/6] drm/panfrost: Implement generic DRM object RSS
 reporting function
Message-ID: <20230912112952.1fc608f4@collabora.com>
In-Reply-To: <20230912084044.955864-6-adrian.larumbe@collabora.com>
References: <20230912084044.955864-1-adrian.larumbe@collabora.com>
        <20230912084044.955864-6-adrian.larumbe@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Sep 2023 09:36:59 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> BO's RSS is updated every time new pages are allocated on demand and mapp=
ed
> for the object at GPU page fault's IRQ handler, but only for heap buffers.
> The reason this is unnecessary for non-heap buffers is that they are mapp=
ed
> onto the GPU's VA space and backed by physical memory in their entirety at
> BO creation time.
>=20
> This calculation is unnecessary for imported PRIME objects, since heap
> buffers cannot be exported by our driver, and the actual BO RSS size is t=
he
> one reported in its attached dmabuf structure.
>=20
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/panfrost/panfrost_gem.c | 15 +++++++++++++++
>  drivers/gpu/drm/panfrost/panfrost_gem.h |  5 +++++
>  drivers/gpu/drm/panfrost/panfrost_mmu.c |  1 +
>  3 files changed, 21 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/pa=
nfrost/panfrost_gem.c
> index 7d8f83d20539..4365434b48db 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gem.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
> @@ -208,6 +208,20 @@ static enum drm_gem_object_status panfrost_gem_statu=
s(struct drm_gem_object *obj
>  	return res;
>  }
> =20
> +static size_t panfrost_gem_rss(struct drm_gem_object *obj)
> +{
> +	struct panfrost_gem_object *bo =3D to_panfrost_bo(obj);
> +
> +	if (bo->is_heap) {
> +		return bo->heap_rss_size;
> +	} else if (bo->base.pages) {
> +		WARN_ON(bo->heap_rss_size);
> +		return bo->base.base.size;
> +	} else {
> +		return 0;
> +	}
> +}
> +
>  static const struct drm_gem_object_funcs panfrost_gem_funcs =3D {
>  	.free =3D panfrost_gem_free_object,
>  	.open =3D panfrost_gem_open,
> @@ -220,6 +234,7 @@ static const struct drm_gem_object_funcs panfrost_gem=
_funcs =3D {
>  	.vunmap =3D drm_gem_shmem_object_vunmap,
>  	.mmap =3D drm_gem_shmem_object_mmap,
>  	.status =3D panfrost_gem_status,
> +	.rss =3D panfrost_gem_rss,
>  	.vm_ops =3D &drm_gem_shmem_vm_ops,
>  };
> =20
> diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.h b/drivers/gpu/drm/pa=
nfrost/panfrost_gem.h
> index ad2877eeeccd..13c0a8149c3a 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gem.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_gem.h
> @@ -36,6 +36,11 @@ struct panfrost_gem_object {
>  	 */
>  	atomic_t gpu_usecount;
> =20
> +	/*
> +	 * Object chunk size currently mapped onto physical memory
> +	 */
> +	size_t heap_rss_size;
> +
>  	bool noexec		:1;
>  	bool is_heap		:1;
>  };
> diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/pa=
nfrost/panfrost_mmu.c
> index d54d4e7b2195..7b1490cdaa48 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> @@ -522,6 +522,7 @@ static int panfrost_mmu_map_fault_addr(struct panfros=
t_device *pfdev, int as,
>  		   IOMMU_WRITE | IOMMU_READ | IOMMU_NOEXEC, sgt);
> =20
>  	bomapping->active =3D true;
> +	bo->heap_rss_size +=3D SZ_2;
> =20
>  	dev_dbg(pfdev->dev, "mapped page fault @ AS%d %llx", as, addr);
> =20

