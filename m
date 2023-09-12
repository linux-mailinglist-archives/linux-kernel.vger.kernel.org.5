Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7529779CBC5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 11:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233715AbjILJ3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 05:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233712AbjILJ3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 05:29:35 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B5FCE;
        Tue, 12 Sep 2023 02:29:30 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E3C0166072F2;
        Tue, 12 Sep 2023 10:29:28 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694510969;
        bh=i2OhOc45ENXBJL1iLuW5plyR5L9lav8VqezmHCDAV8g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UcPFCsFvYpXC6ssL1Ef8H2qoYuZMy2VpO19yTA5IoAVB4/fiN2Yvl9VESzCYncJXe
         eIK2O+1YK/ehs9FyPy0xjIrQ7SokaGK9NCWZMainEroef/36DMes/qK66o9XEDPd4G
         AHONPDxrP1eICg1fAlaKkwcBqxAA5A1DFuGPEj7Ukc9IHgUxIyVMmxWMpOA8GdyQIv
         k7zEoaf310zDBb5uiwX5TkHDLGythLPQbpUOsQW01aPuxwIftrGWv/JKalaa3d8WJW
         Le4P8ahqXrEnSKa4VfmQMgM0k6Dm8iIeE0m8FGlA+EB7nfL1hfcSP/+62esCfSZXRo
         YHONjPse+LylA==
Date:   Tue, 12 Sep 2023 11:29:25 +0200
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
Subject: Re: [PATCH v4 3/6] drm/panfrost: Add fdinfo support for memory
 stats
Message-ID: <20230912112925.00ac3aad@collabora.com>
In-Reply-To: <20230912084044.955864-4-adrian.larumbe@collabora.com>
References: <20230912084044.955864-1-adrian.larumbe@collabora.com>
        <20230912084044.955864-4-adrian.larumbe@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Sep 2023 09:36:57 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> A new DRM GEM object function is added so that drm_show_memory_stats can
> provide more accurate memory usage numbers.
>=20
> Ideally, in panfrost_gem_status, the BO's purgeable flag would be checked
> after locking the driver's shrinker mutex, but drm_show_memory_stats takes
> over the drm file's object handle database spinlock, so there's potential
> for a race condition here.
>=20
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/panfrost/panfrost_drv.c |  2 ++
>  drivers/gpu/drm/panfrost/panfrost_gem.c | 14 ++++++++++++++
>  2 files changed, 16 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/pa=
nfrost/panfrost_drv.c
> index 2d9c115821a7..e71a89a283cd 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -567,6 +567,8 @@ static void panfrost_show_fdinfo(struct drm_printer *=
p, struct drm_file *file)
>  	struct panfrost_device *pfdev =3D dev->dev_private;
> =20
>  	panfrost_gpu_show_fdinfo(pfdev, file->driver_priv, p);
> +
> +	drm_show_memory_stats(p, file);
>  }
> =20
>  static const struct file_operations panfrost_drm_driver_fops =3D {
> diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/pa=
nfrost/panfrost_gem.c
> index 3c812fbd126f..7d8f83d20539 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gem.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
> @@ -195,6 +195,19 @@ static int panfrost_gem_pin(struct drm_gem_object *o=
bj)
>  	return drm_gem_shmem_pin(&bo->base);
>  }
> =20
> +static enum drm_gem_object_status panfrost_gem_status(struct drm_gem_obj=
ect *obj)
> +{
> +	struct panfrost_gem_object *bo =3D to_panfrost_bo(obj);
> +	enum drm_gem_object_status res =3D 0;
> +
> +	res |=3D (bo->base.madv =3D=3D PANFROST_MADV_DONTNEED) ?
> +		DRM_GEM_OBJECT_PURGEABLE : 0;
> +
> +	res |=3D (bo->base.pages) ? DRM_GEM_OBJECT_RESIDENT : 0;
> +
> +	return res;
> +}
> +
>  static const struct drm_gem_object_funcs panfrost_gem_funcs =3D {
>  	.free =3D panfrost_gem_free_object,
>  	.open =3D panfrost_gem_open,
> @@ -206,6 +219,7 @@ static const struct drm_gem_object_funcs panfrost_gem=
_funcs =3D {
>  	.vmap =3D drm_gem_shmem_object_vmap,
>  	.vunmap =3D drm_gem_shmem_object_vunmap,
>  	.mmap =3D drm_gem_shmem_object_mmap,
> +	.status =3D panfrost_gem_status,
>  	.vm_ops =3D &drm_gem_shmem_vm_ops,
>  };
> =20

