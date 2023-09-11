Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1560F79A48D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 09:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbjIKHcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 03:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbjIKHb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 03:31:58 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB346E7E;
        Mon, 11 Sep 2023 00:31:45 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DC8E966072F1;
        Mon, 11 Sep 2023 08:31:43 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694417504;
        bh=YKhGN9VTyZEcfKGJln7GGYD4tp1inT9sEtPJGXJfsvc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PJwWxTO0XRp9UCS3QFq2jFhLK5cpK2ZATCaYWxrXCXq6NbluLIeH91WwZ1utIMJUR
         9wF4263r6H+Qy9dSeSd0YnnaI43rO6tXJQzluEHq/hqCEpnLVVYwAXo6XZkqOaT090
         lXNyZCm1a3JGYEd4374ZrXF6n2cGxPoibhGWlc8217ujCQ4YdV5yvlmeoUc8/ATZtG
         MwwR30zbrRhhYxSV9bL3SrzzS6UIlVr4dr+OgceMlrAxEb2SmntbocruymwPGwWFMV
         fwWvTS7dNmS8EZBHDoHHjTaZSo4AMmqrhg0AOffOVKtyWahie5HhOfs7nLXkFtTbZL
         /X52MaM/SdjmA==
Date:   Mon, 11 Sep 2023 09:31:40 +0200
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
Subject: Re: [PATCH v3 7/8] drm/panfrost: Implement generic DRM object RSS
 reporting function
Message-ID: <20230911093140.121f2fbf@collabora.com>
In-Reply-To: <vullvbu3eepdci5dzotppoydeoyfwebpf7e6wle3ubwf6sdrg6@v6luzft4no4r>
References: <20230905184533.959171-1-adrian.larumbe@collabora.com>
        <20230905184533.959171-8-adrian.larumbe@collabora.com>
        <20230906100130.530c4e4a@collabora.com>
        <vullvbu3eepdci5dzotppoydeoyfwebpf7e6wle3ubwf6sdrg6@v6luzft4no4r>
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

On Sat, 9 Sep 2023 17:42:02 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> On 06.09.2023 10:01, Boris Brezillon wrote:
> >On Tue,  5 Sep 2023 19:45:23 +0100
> >Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:
> > =20
> >> BO's RSS is updated every time new pages are allocated on demand and m=
apped
> >> for the object at GPU page fault's IRQ handler, but only for heap buff=
ers.
> >> The reason this is unnecessary for non-heap buffers is that they are m=
apped
> >> onto the GPU's VA space and backed by physical memory in their entiret=
y at
> >> BO creation time.
> >>=20
> >> This calculation is unnecessary for imported PRIME objects, since heap
> >> buffers cannot be exported by our driver, and the actual BO RSS size i=
s the
> >> one reported in its attached dmabuf structure.
> >>=20
> >> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
> >> ---
> >>  drivers/gpu/drm/panfrost/panfrost_gem.c | 14 ++++++++++++++
> >>  drivers/gpu/drm/panfrost/panfrost_gem.h |  5 +++++
> >>  drivers/gpu/drm/panfrost/panfrost_mmu.c | 12 ++++++++----
> >>  3 files changed, 27 insertions(+), 4 deletions(-)
> >>=20
> >> diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm=
/panfrost/panfrost_gem.c
> >> index 7d8f83d20539..cb92c0ed7615 100644
> >> --- a/drivers/gpu/drm/panfrost/panfrost_gem.c
> >> +++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
> >> @@ -208,6 +208,19 @@ static enum drm_gem_object_status panfrost_gem_st=
atus(struct drm_gem_object *obj
> >>  	return res;
> >>  }
> >> =20
> >> +static size_t panfrost_gem_rss(struct drm_gem_object *obj)
> >> +{
> >> +	struct panfrost_gem_object *bo =3D to_panfrost_bo(obj);
> >> +
> >> +	if (bo->is_heap)
> >> +		return bo->heap_rss_size;
> >> +	else if (bo->base.pages) {
> >> +		WARN_ON(bo->heap_rss_size);
> >> +		return bo->base.base.size;
> >> +	} else
> >> +		return 0; =20
> >
> >Nit: please add brackets on all conditional blocks, even if only the
> >second one needs it.
> > =20
> >> +}
> >> +
> >>  static const struct drm_gem_object_funcs panfrost_gem_funcs =3D {
> >>  	.free =3D panfrost_gem_free_object,
> >>  	.open =3D panfrost_gem_open,
> >> @@ -220,6 +233,7 @@ static const struct drm_gem_object_funcs panfrost_=
gem_funcs =3D {
> >>  	.vunmap =3D drm_gem_shmem_object_vunmap,
> >>  	.mmap =3D drm_gem_shmem_object_mmap,
> >>  	.status =3D panfrost_gem_status,
> >> +	.rss =3D panfrost_gem_rss,
> >>  	.vm_ops =3D &drm_gem_shmem_vm_ops,
> >>  };
> >> =20
> >> diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.h b/drivers/gpu/drm=
/panfrost/panfrost_gem.h
> >> index ad2877eeeccd..13c0a8149c3a 100644
> >> --- a/drivers/gpu/drm/panfrost/panfrost_gem.h
> >> +++ b/drivers/gpu/drm/panfrost/panfrost_gem.h
> >> @@ -36,6 +36,11 @@ struct panfrost_gem_object {
> >>  	 */
> >>  	atomic_t gpu_usecount;
> >> =20
> >> +	/*
> >> +	 * Object chunk size currently mapped onto physical memory
> >> +	 */
> >> +	size_t heap_rss_size;
> >> +
> >>  	bool noexec		:1;
> >>  	bool is_heap		:1;
> >>  };
> >> diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm=
/panfrost/panfrost_mmu.c
> >> index d54d4e7b2195..67c206124781 100644
> >> --- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
> >> +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> >> @@ -285,17 +285,19 @@ static void panfrost_mmu_flush_range(struct panf=
rost_device *pfdev,
> >>  	pm_runtime_put_autosuspend(pfdev->dev);
> >>  }
> >> =20
> >> -static int mmu_map_sg(struct panfrost_device *pfdev, struct panfrost_=
mmu *mmu,
> >> +static size_t mmu_map_sg(struct panfrost_device *pfdev, struct panfro=
st_mmu *mmu,
> >>  		      u64 iova, int prot, struct sg_table *sgt)
> >>  {
> >>  	unsigned int count;
> >>  	struct scatterlist *sgl;
> >>  	struct io_pgtable_ops *ops =3D mmu->pgtbl_ops;
> >>  	u64 start_iova =3D iova;
> >> +	size_t total =3D 0;
> >> =20
> >>  	for_each_sgtable_dma_sg(sgt, sgl, count) {
> >>  		unsigned long paddr =3D sg_dma_address(sgl);
> >>  		size_t len =3D sg_dma_len(sgl);
> >> +		total +=3D len;
> >> =20
> >>  		dev_dbg(pfdev->dev, "map: as=3D%d, iova=3D%llx, paddr=3D%lx, len=3D=
%zx", mmu->as, iova, paddr, len);
> >> =20
> >> @@ -315,7 +317,7 @@ static int mmu_map_sg(struct panfrost_device *pfde=
v, struct panfrost_mmu *mmu,
> >> =20
> >>  	panfrost_mmu_flush_range(pfdev, mmu, start_iova, iova - start_iova);
> >> =20
> >> -	return 0;
> >> +	return total;
> >>  }
> >> =20
> >>  int panfrost_mmu_map(struct panfrost_gem_mapping *mapping)
> >> @@ -447,6 +449,7 @@ static int panfrost_mmu_map_fault_addr(struct panf=
rost_device *pfdev, int as,
> >>  	pgoff_t page_offset;
> >>  	struct sg_table *sgt;
> >>  	struct page **pages;
> >> +	size_t mapped_size;
> >> =20
> >>  	bomapping =3D addr_to_mapping(pfdev, as, addr);
> >>  	if (!bomapping)
> >> @@ -518,10 +521,11 @@ static int panfrost_mmu_map_fault_addr(struct pa=
nfrost_device *pfdev, int as,
> >>  	if (ret)
> >>  		goto err_map;
> >> =20
> >> -	mmu_map_sg(pfdev, bomapping->mmu, addr,
> >> -		   IOMMU_WRITE | IOMMU_READ | IOMMU_NOEXEC, sgt);
> >> +	mapped_size =3D mmu_map_sg(pfdev, bomapping->mmu, addr,
> >> +				 IOMMU_WRITE | IOMMU_READ | IOMMU_NOEXEC, sgt);
> >> =20
> >>  	bomapping->active =3D true;
> >> +	bo->heap_rss_size +=3D mapped_size; =20
> >
> >The alloc-on-fault granularity is set static (2MB), so no need to
> >make mmu_map_sg() return the mapped size, we can just do +=3D SZ_2M if
> >things worked. =20
>=20
> At the moment mmu_map_sg is treated as though it always succeeds in mappi=
ng the
> page. Would it be alright if I changed it so that we take into account the
> unlikely case that ops->map_pages might fail?

Yep, that would probably be a good thing to gracefully handle
allocation failures happening in ops->map_pages(), but I'd do that in a
follow-up patch, because that's orthogonal to the fdinfo stuff.

> Something like this: https://gitlab.collabora.com/-/snippets/323

Nit: I would change the mmu_unmap_range() prototype for something like:

static void mmu_unmap_range(struct panfrost_mmu *mmu,
			    u64 iova, size_t len);

No need for this is_heap argument if you pass rss_size to
mmu_unmap_range() for heap BOs.

Note that ops->unmap_pages() can fail on mem allocation too, when an
unmap triggers a 2M -> 4k page table split. But I don't think this can
happen in panfrost, because, for regular BOs, we always map/unmap the
whole BO, and for heaps, we map/unmap 2M at a time.
