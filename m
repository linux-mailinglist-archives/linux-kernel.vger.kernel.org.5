Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F597A471F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 12:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241254AbjIRKc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 06:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241333AbjIRKcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 06:32:48 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E261C126;
        Mon, 18 Sep 2023 03:32:23 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 03E856607033;
        Mon, 18 Sep 2023 11:32:20 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695033141;
        bh=HGMvGDB1wXK1aRkUwoJnCxcXLdv/SVTCzXE3f2Tt9xM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RsE+wqV8sbDR9OSTd+VuqzXCftzJcvO21AdTW1ssvOFGHr0mdkQUHpA6Gf2pDQS8M
         MFb7079lvPGsDPOwehksrjU4P0lBX+pv+EFkh+KT94I96tHIIIhq/8dnPe0Ahcgc5C
         cdujUQ7GSp2mQ+rJ9BbCcBxu3duhnxAyltmQpyU/P7pUurHHlt6UsIZWso7fyb4Jd9
         rW7FllLfPZBHluppsY+e8LYxKFlx1amx076LYhLbyK597vh3WW0XBNWzrd44ISk+5f
         j71082ERaq4BvLeNkcGVo1uOSqr2quygMvWnFydnCU521gtWKZEgiRfa38aSToeau8
         J2uVpMSO+8WJQ==
Date:   Mon, 18 Sep 2023 12:32:18 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Steven Price <steven.price@arm.com>
Cc:     =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run,
        marijn.suijten@somainline.org, robh@kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        healych@amazon.com, kernel@collabora.com
Subject: Re: [PATCH v5 5/6] drm/panfrost: Implement generic DRM object RSS
 reporting function
Message-ID: <20230918123218.14ca9fde@collabora.com>
In-Reply-To: <a8d9fe07-7acc-db10-5660-293a449d9dd2@arm.com>
References: <20230914223928.2374933-1-adrian.larumbe@collabora.com>
        <20230914223928.2374933-6-adrian.larumbe@collabora.com>
        <a8d9fe07-7acc-db10-5660-293a449d9dd2@arm.com>
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

On Mon, 18 Sep 2023 11:01:43 +0100
Steven Price <steven.price@arm.com> wrote:

> On 14/09/2023 23:38, Adri=C3=A1n Larumbe wrote:
> > BO's RSS is updated every time new pages are allocated on demand and ma=
pped
> > for the object at GPU page fault's IRQ handler, but only for heap buffe=
rs.
> > The reason this is unnecessary for non-heap buffers is that they are ma=
pped
> > onto the GPU's VA space and backed by physical memory in their entirety=
 at
> > BO creation time.
> >=20
> > This calculation is unnecessary for imported PRIME objects, since heap
> > buffers cannot be exported by our driver, and the actual BO RSS size is=
 the
> > one reported in its attached dmabuf structure.
> >=20
> > Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
> > Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com> =20
>=20
> Am I missing something, or are we missing a way of resetting
> heap_rss_size when the shrinker purges? It looks like after several
> grow/purge cycles, heap_rss_size could actually grow to be larger than
> the BO which is clearly wrong.

Didn't even consider this case since we don't flag heap BOs purgeable
in mesa(panfrost), but let's assume we did. If the BO is purged, I'd
expect the core to report 0MB of resident memory anyway. And purged BOs
are not supposed to be re-used if MADVISE(WILL_NEED) returns
retained=3Dfalse, they should be destroyed. Not 100% sure this is
enforced everywhere though (we might actually miss tests to make sure
users don't pass purged BOs to jobs, or make the alloc-on-fault logic
doesn't try to grow a purged GEM).

If we want to implement transparent BO swap{out,in} (Dmitry's
patchset), that's be a different story, and we'll indeed have to set
heap_rss_size back to zero on eviction.

>=20
> Steve
>=20
> > ---
> >  drivers/gpu/drm/panfrost/panfrost_gem.c | 15 +++++++++++++++
> >  drivers/gpu/drm/panfrost/panfrost_gem.h |  5 +++++
> >  drivers/gpu/drm/panfrost/panfrost_mmu.c |  1 +
> >  3 files changed, 21 insertions(+)
> >=20
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/=
panfrost/panfrost_gem.c
> > index 7d8f83d20539..4365434b48db 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_gem.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
> > @@ -208,6 +208,20 @@ static enum drm_gem_object_status panfrost_gem_sta=
tus(struct drm_gem_object *obj
> >  	return res;
> >  }
> > =20
> > +static size_t panfrost_gem_rss(struct drm_gem_object *obj)
> > +{
> > +	struct panfrost_gem_object *bo =3D to_panfrost_bo(obj);
> > +
> > +	if (bo->is_heap) {
> > +		return bo->heap_rss_size;
> > +	} else if (bo->base.pages) {
> > +		WARN_ON(bo->heap_rss_size);
> > +		return bo->base.base.size;
> > +	} else {
> > +		return 0;
> > +	}
> > +}
> > +
> >  static const struct drm_gem_object_funcs panfrost_gem_funcs =3D {
> >  	.free =3D panfrost_gem_free_object,
> >  	.open =3D panfrost_gem_open,
> > @@ -220,6 +234,7 @@ static const struct drm_gem_object_funcs panfrost_g=
em_funcs =3D {
> >  	.vunmap =3D drm_gem_shmem_object_vunmap,
> >  	.mmap =3D drm_gem_shmem_object_mmap,
> >  	.status =3D panfrost_gem_status,
> > +	.rss =3D panfrost_gem_rss,
> >  	.vm_ops =3D &drm_gem_shmem_vm_ops,
> >  };
> > =20
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.h b/drivers/gpu/drm/=
panfrost/panfrost_gem.h
> > index ad2877eeeccd..13c0a8149c3a 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_gem.h
> > +++ b/drivers/gpu/drm/panfrost/panfrost_gem.h
> > @@ -36,6 +36,11 @@ struct panfrost_gem_object {
> >  	 */
> >  	atomic_t gpu_usecount;
> > =20
> > +	/*
> > +	 * Object chunk size currently mapped onto physical memory
> > +	 */
> > +	size_t heap_rss_size;
> > +
> >  	bool noexec		:1;
> >  	bool is_heap		:1;
> >  };
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/=
panfrost/panfrost_mmu.c
> > index d54d4e7b2195..7b1490cdaa48 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> > @@ -522,6 +522,7 @@ static int panfrost_mmu_map_fault_addr(struct panfr=
ost_device *pfdev, int as,
> >  		   IOMMU_WRITE | IOMMU_READ | IOMMU_NOEXEC, sgt);
> > =20
> >  	bomapping->active =3D true;
> > +	bo->heap_rss_size +=3D SZ_2;
> > =20
> >  	dev_dbg(pfdev->dev, "mapped page fault @ AS%d %llx", as, addr);
> >   =20
>=20

