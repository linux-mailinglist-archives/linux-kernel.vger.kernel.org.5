Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219F278DE40
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 21:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237897AbjH3TAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243260AbjH3Ker (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 06:34:47 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E30219A;
        Wed, 30 Aug 2023 03:34:43 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 632816607236;
        Wed, 30 Aug 2023 11:34:41 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1693391682;
        bh=2oFlKazPWojI5/ds8jUr1lptX3DTPFnZjaq1cV0IyoE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MAHD0K8KoUMS2LSPDxZs9Htbtlqy34+JTgz1UR8HMiVopU5IOmp7lmnTLevjalzLL
         6fUrEjap0/aS17zeIZuQoOTAnPQBjADzWWE0B59AjVIDunP7OQk76FHndHPEfpCcdl
         QoCwYkSo5R8PoddMBJuON5qO8CUrRpjcp7i5cbN8z/HylYOil8wY1a2XNBpTnDXZi2
         z19YfLZWKYNxIKIAY+8+koU+MFkuuopugD/EXjdHaVAH2efy7E/ND+AK3lCxAd+rsA
         omaqtxs90eA7McEU9U3zRxPbL6mua2ZX68EOB1IAr2OSbgh05dfpp1RjuMSHV56DRB
         eDNwWQ0U20Xmg==
Date:   Wed, 30 Aug 2023 12:34:38 +0200
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
Subject: Re: [PATCH v2 4/6] drm/drm_file: Add DRM obj's RSS reporting
 function for fdinfo
Message-ID: <20230830123438.782a5e42@collabora.com>
In-Reply-To: <20230824013604.466224-5-adrian.larumbe@collabora.com>
References: <20230824013604.466224-1-adrian.larumbe@collabora.com>
        <20230824013604.466224-5-adrian.larumbe@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Aug 2023 02:34:47 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> Some BO's might be mapped onto physical memory chunkwise and on demand,
> like Panfrost's tiler heap. In this case, even though the
> drm_gem_shmem_object page array might already be allocated, only a very
> small fraction of the BO is currently backed by system memory, but
> drm_show_memory_stats will then proceed to add its entire virtual size to
> the file's total resident size regardless.
>=20
> This led to very unrealistic RSS sizes being reckoned for Panfrost, where
> said tiler heap buffer is initially allocated with a virtual size of 128
> MiB, but only a small part of it will eventually be backed by system memo=
ry
> after successive GPU page faults.
>=20
> Provide a new DRM object generic function that would allow drivers to
> return a more accurate RSS size for their BOs.
>=20
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/drm_file.c | 5 ++++-
>  include/drm/drm_gem.h      | 9 +++++++++
>  2 files changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
> index 883d83bc0e3d..762965e3d503 100644
> --- a/drivers/gpu/drm/drm_file.c
> +++ b/drivers/gpu/drm/drm_file.c
> @@ -944,7 +944,10 @@ void drm_show_memory_stats(struct drm_printer *p, st=
ruct drm_file *file)
>  		}
> =20
>  		if (s & DRM_GEM_OBJECT_RESIDENT) {
> -			status.resident +=3D obj->size;
> +			if (obj->funcs && obj->funcs->rss)
> +				status.resident +=3D obj->funcs->rss(obj);
> +			else
> +				status.resident +=3D obj->size;
>  		} else {
>  			/* If already purged or not yet backed by pages, don't
>  			 * count it as purgeable:
> diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
> index c0b13c43b459..78ed9fab6044 100644
> --- a/include/drm/drm_gem.h
> +++ b/include/drm/drm_gem.h
> @@ -208,6 +208,15 @@ struct drm_gem_object_funcs {
>  	 */
>  	enum drm_gem_object_status (*status)(struct drm_gem_object *obj);
> =20
> +	/**
> +	 * @rss:
> +	 *
> +	 * Return resident size of the object in physical memory.
> +	 *
> +	 * Called by drm_show_memory_stats().
> +	 */
> +	size_t (*rss)(struct drm_gem_object *obj);
> +
>  	/**
>  	 * @vm_ops:
>  	 *

