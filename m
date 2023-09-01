Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8E878F8AB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 08:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346760AbjIAGpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 02:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjIAGpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 02:45:05 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19670CEB;
        Thu, 31 Aug 2023 23:45:03 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E6941660728E;
        Fri,  1 Sep 2023 07:45:00 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1693550701;
        bh=xNJ/JsssI9AvwYvwzTZkZ5foAHHEAsCmcEIqq3AhxhY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bTvk5hB3bcbHHptFnVoC2Sbc8fsX4l4fGhveQSe9keJt9UZ1zZAhUuxCoeD4NkJmM
         GEUQX7N7j9KSYsKhIfIbUxVZxgvDXPR7uKdTKeFoupCnnwSX8Gq2LwMyf/73wAqEx+
         JV+8g0cjpOPQ4dHTCEA8otwzhyFHhvGhJtVTCaZZ4gpgNmnj8UxDB3cPoJl7Jr9wUK
         PShRV20mt9N+upwTqBX9lrmdjAHaUCl+Zchoyx5n3bG5VnpEHGiZMJWlKobizQNCAm
         y3mEM1Urr0Uxq+GULrHcEOkE5g7T82gt6DZiaAaqiBa7zK/q9IpSIdAfoqHSYUA6Y2
         oXDHjoAW9jAyg==
Date:   Fri, 1 Sep 2023 08:44:57 +0200
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
Subject: Re: [PATCH v2 5/6] drm/panfrost: Implement generic DRM object RSS
 reporting function
Message-ID: <20230901084457.5bc1ad69@collabora.com>
In-Reply-To: <jev3jdwfkdoqbdhdgapfyb2fghpmw4lzhozi6m2ylfvsofwstv@4uj624i74i3e>
References: <20230824013604.466224-1-adrian.larumbe@collabora.com>
        <20230824013604.466224-6-adrian.larumbe@collabora.com>
        <20230830125210.3d1172db@collabora.com>
        <jev3jdwfkdoqbdhdgapfyb2fghpmw4lzhozi6m2ylfvsofwstv@4uj624i74i3e>
Organization: Collabora
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Sep 2023 01:03:23 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> >> @@ -274,13 +286,23 @@ panfrost_gem_prime_import_sg_table(struct drm_de=
vice *dev,
> >>  {
> >>  	struct drm_gem_object *obj;
> >>  	struct panfrost_gem_object *bo;
> >> +	struct scatterlist *sgl;
> >> +	unsigned int count;
> >> +	size_t total =3D 0;
> >> =20
> >>  	obj =3D drm_gem_shmem_prime_import_sg_table(dev, attach, sgt);
> >>  	if (IS_ERR(obj))
> >>  		return ERR_CAST(obj);
> >> =20
> >> +	for_each_sgtable_dma_sg(sgt, sgl, count) {
> >> +		size_t len =3D sg_dma_len(sgl);
> >> +
> >> +		total +=3D len;
> >> +	} =20
> >
> >Why not simply have bo->rss_size =3D obj->size here? Not sure I see a
> >reason to not trust dma_buf? =20
>=20
> Can PRIME-imported BO's ever be heap objects?

Nope, heap BOs can't be exported, and if they can, that's probably a
bug we need to fix.
