Return-Path: <linux-kernel+bounces-144842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6AC8A4BA3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 403431F22994
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2768B40BFE;
	Mon, 15 Apr 2024 09:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IoGVNHr+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522FA3A1B9;
	Mon, 15 Apr 2024 09:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713173833; cv=none; b=jJRhlLvuTuTfByuJQcoiPNDEkZBv4J5FpaEyA04tQpcAYBX6Z0YgDXnskHPYj10v9FzOrDHskzVQkX1VyPGI+Byw4Ub+KS6Xl6MSEo54YbLJG28cqyBm3RzgSw0oz1ighVaEDSLwwllFs3hXJbbe99bVkF+Il+nI9iAmhpv39vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713173833; c=relaxed/simple;
	bh=zC/gGj3VI8C9hFSEvF7iLDAhNJrC3T7auxiRiw+ez84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HkiQ18qNlS06LcpptHq3CL+qfTk13dSA/RatRxLsV7gOmkNb6d0iJTuwuAP8benb0uSY3cI8vwcPZhqeJ186OErZ8xJJXvlNVjOQfe/60WT7av2sBhao005q2WRPELeaNi88pZPt1GspHaU1lcYZEes5E1Dci1x/sjdVcmNugZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IoGVNHr+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 592E0C32781;
	Mon, 15 Apr 2024 09:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713173832;
	bh=zC/gGj3VI8C9hFSEvF7iLDAhNJrC3T7auxiRiw+ez84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IoGVNHr+owcpQDH3Q0FUhRdHbCJQHT7K7NEeF6di/KE1weI8pEM+fN5y5jj9sA8or
	 ljsLhk4YUoKfhIHLjzjcAvRXnK0GaZtYHNrEB7O67U2AZSy1WAunnJHDChOIxGNa3q
	 Rg9nsRR39fcQKCx0PHUDHEXmYk3RC6ZNURBnxO0eR3ySB1JKDgxrxZz5XESTxx0Lqx
	 sPg6YID2mU4FP82L0hJroJKK/27uHpLbS8ZBnvWFA1Gb/u6ct1/v/3h4aTFJZPp5HG
	 KmoWLqt8nhMYrbJYWQnFjS2R0E8BrV2wk39J+Z/YDRDQFMbKiYbefCzVgnchCAxq+K
	 5pOY3mThgGGpw==
Date: Mon, 15 Apr 2024 11:37:10 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Shawn Sung <shawn.sung@mediatek.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Sumit Semwal <sumit.semwal@linaro.org>, 
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
	"Jason-JH.Lin" <jason-jh.lin@mediatek.com>
Subject: Re: [PATCH v5 2/9] drm/mediatek: Add secure buffer control flow to
 mtk_drm_gem
Message-ID: <20240415-guppy-of-perpetual-current-3a7974@houat>
References: <20240403102701.369-1-shawn.sung@mediatek.com>
 <20240403102701.369-3-shawn.sung@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="j4ten6lzqjc6nid4"
Content-Disposition: inline
In-Reply-To: <20240403102701.369-3-shawn.sung@mediatek.com>


--j4ten6lzqjc6nid4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 03, 2024 at 06:26:54PM +0800, Shawn Sung wrote:
> From: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
>=20
> Add secure buffer control flow to mtk_drm_gem.
>=20
> When user space takes DRM_MTK_GEM_CREATE_ENCRYPTED flag and size
> to create a mtk_drm_gem object, mtk_drm_gem will find a matched size
> dma buffer from secure dma-heap and bind it to mtk_drm_gem object.
>=20
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_gem.c | 85 +++++++++++++++++++++++++++++-
>  drivers/gpu/drm/mediatek/mtk_gem.h |  4 ++
>  2 files changed, 88 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/mediatek/mtk_gem.c b/drivers/gpu/drm/mediate=
k/mtk_gem.c
> index e59e0727717b7..ec34d02c14377 100644
> --- a/drivers/gpu/drm/mediatek/mtk_gem.c
> +++ b/drivers/gpu/drm/mediatek/mtk_gem.c
> @@ -4,6 +4,8 @@
>   */
> =20
>  #include <linux/dma-buf.h>
> +#include <linux/dma-heap.h>
> +#include <uapi/linux/dma-heap.h>
>  #include <drm/mediatek_drm.h>
> =20
>  #include <drm/drm.h>
> @@ -102,6 +104,81 @@ struct mtk_gem_obj *mtk_gem_create(struct drm_device=
 *dev,
>  	return ERR_PTR(ret);
>  }
> =20
> +struct mtk_gem_obj *mtk_gem_create_from_heap(struct drm_device *dev,
> +					     const char *heap, size_t size)
> +{
> +	struct mtk_drm_private *priv =3D dev->dev_private;
> +	struct mtk_gem_obj *mtk_gem;
> +	struct drm_gem_object *obj;
> +	struct dma_heap *dma_heap;
> +	struct dma_buf *dma_buf;
> +	struct dma_buf_attachment *attach;
> +	struct sg_table *sgt;
> +	struct iosys_map map =3D {};
> +	int ret;
> +
> +	mtk_gem =3D mtk_gem_init(dev, size);
> +	if (IS_ERR(mtk_gem))
> +		return ERR_CAST(mtk_gem);
> +
> +	obj =3D &mtk_gem->base;
> +
> +	dma_heap =3D dma_heap_find(heap);
> +	if (!dma_heap) {
> +		DRM_ERROR("heap find fail\n");
> +		goto err_gem_free;
> +	}
> +	dma_buf =3D dma_heap_buffer_alloc(dma_heap, size,
> +					O_RDWR | O_CLOEXEC, DMA_HEAP_VALID_HEAP_FLAGS);
> +	if (IS_ERR(dma_buf)) {
> +		DRM_ERROR("buffer alloc fail\n");
> +		dma_heap_put(dma_heap);
> +		goto err_gem_free;
> +	}
> +	dma_heap_put(dma_heap);
> +
> +	attach =3D dma_buf_attach(dma_buf, priv->dma_dev);
> +	if (IS_ERR(attach)) {
> +		DRM_ERROR("attach fail, return\n");
> +		dma_buf_put(dma_buf);
> +		goto err_gem_free;
> +	}
> +
> +	sgt =3D dma_buf_map_attachment(attach, DMA_BIDIRECTIONAL);
> +	if (IS_ERR(sgt)) {
> +		DRM_ERROR("map failed, detach and return\n");
> +		dma_buf_detach(dma_buf, attach);
> +		dma_buf_put(dma_buf);
> +		goto err_gem_free;
> +	}
> +	obj->import_attach =3D attach;
> +	mtk_gem->dma_addr =3D sg_dma_address(sgt->sgl);
> +	mtk_gem->sg =3D sgt;
> +	mtk_gem->size =3D dma_buf->size;
> +
> +	if (!strcmp(heap, "mtk_svp") || !strcmp(heap, "mtk_svp_cma")) {
> +		/* secure buffer can not be mapped */
> +		mtk_gem->secure =3D true;
> +	} else {
> +		ret =3D dma_buf_vmap(dma_buf, &map);
> +		mtk_gem->kvaddr =3D map.vaddr;
> +		if (ret) {
> +			DRM_ERROR("map failed, ret=3D%d\n", ret);
> +			dma_buf_unmap_attachment(attach, sgt, DMA_BIDIRECTIONAL);
> +			dma_buf_detach(dma_buf, attach);
> +			dma_buf_put(dma_buf);
> +			mtk_gem->kvaddr =3D NULL;
> +		}
> +	}
> +
> +	return mtk_gem;
> +
> +err_gem_free:
> +	drm_gem_object_release(obj);
> +	kfree(mtk_gem);
> +	return ERR_PTR(-ENOMEM);
> +}
> +
>  void mtk_gem_free_object(struct drm_gem_object *obj)
>  {
>  	struct mtk_gem_obj *mtk_gem =3D to_mtk_gem_obj(obj);
> @@ -229,7 +306,9 @@ struct drm_gem_object *mtk_gem_prime_import_sg_table(=
struct drm_device *dev,
>  	if (IS_ERR(mtk_gem))
>  		return ERR_CAST(mtk_gem);
> =20
> +	mtk_gem->secure =3D !sg_page(sg->sgl);
>  	mtk_gem->dma_addr =3D sg_dma_address(sg->sgl);
> +	mtk_gem->size =3D attach->dmabuf->size;
>  	mtk_gem->sg =3D sg;
> =20
>  	return &mtk_gem->base;
> @@ -304,7 +383,11 @@ int mtk_gem_create_ioctl(struct drm_device *dev, voi=
d *data,
>  	struct drm_mtk_gem_create *args =3D data;
>  	int ret;
> =20
> -	mtk_gem =3D mtk_gem_create(dev, args->size, false);
> +	if (args->flags & DRM_MTK_GEM_CREATE_ENCRYPTED)
> +		mtk_gem =3D mtk_gem_create_from_heap(dev, "mtk_svp_cma", args->size);

That heap doesn't exist upstream either. Also, I'm wondering if it's the
right solution there.

=46rom what I can tell, you want to allow to create encrypted buffers from
the TEE. Why do we need this as a DRM ioctl at all? A heap seems like
the perfect solution to do so, and then you just have to import it into
DRM.

I'm also not entirely sure that not having a SG list is enough to
consider the buffer secure. Wouldn't a buffer allocated without a kernel
mapping also be in that situation?

Maxime

--j4ten6lzqjc6nid4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZhz1RQAKCRAnX84Zoj2+
dlI4AYDxql2+g9gUiJu1Qw1gZ6WJRkNn2Ht6tGhwLrXg9Be1L85EyFAghYVXZuKJ
/NWOwAUBgIyk2hnBIXawQB3gcc6CR27FFeBUTC0hXbNZeCOUedEgB3w2Qp5X8HG6
XSL76qoBBA==
=Wv76
-----END PGP SIGNATURE-----

--j4ten6lzqjc6nid4--

