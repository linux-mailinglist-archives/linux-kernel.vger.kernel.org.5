Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115F079A4FB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 09:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbjIKHuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 03:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233487AbjIKHuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 03:50:22 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD05E51;
        Mon, 11 Sep 2023 00:49:37 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BE2A466072F4;
        Mon, 11 Sep 2023 08:48:59 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694418540;
        bh=yxwpTAPyHaYbVsbWh810fGVyGlWADLqxOAqOHIMcmJo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=C3ApnLRXYKyFNabPBH/6hhNdg3noz4gDCQjXf/ULk+LP1q2qjLBtbAd3RjPD3FPo7
         4vJ+P/Zv3+Oz/kej7k0yg5ASCSjTzEe4WPK1nNPybwsKDjMy1HWFJ3cZoRfTCdo1KV
         4Yf4pVixs24IVTXGSr3YlYExeUUK1esV6nkCKmiNvhKDo4fD0cwtHafF5xduI8W9Q/
         iDpPTwH+vyAi11PlvBMjYWONFfUamHqIj0enMp6OuGsC9fpTbxCiYIpW9fuF1kQpvA
         08jcUPIrLa7HgOKdh+uJkA6AZYiy8ReCB6b69hjJasrXOVyHOkK5/Vdr7FoNoX04Sc
         quoksSYvegGlQ==
Date:   Mon, 11 Sep 2023 09:48:56 +0200
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
Subject: Re: [PATCH v3 8/8] drm/drm-file: Show finer-grained BO sizes in
 drm_show_memory_stats
Message-ID: <20230911094856.5c89aee5@collabora.com>
In-Reply-To: <dgo4x2tbdqvpfjf7cnspq2xvvkacc7pv2rdk5fesrqcv2xr3pi@mbwmqsg742hu>
References: <20230905184533.959171-1-adrian.larumbe@collabora.com>
        <20230905184533.959171-9-adrian.larumbe@collabora.com>
        <20230906101101.04f4e1a2@collabora.com>
        <dgo4x2tbdqvpfjf7cnspq2xvvkacc7pv2rdk5fesrqcv2xr3pi@mbwmqsg742hu>
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

On Sat, 9 Sep 2023 17:55:17 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> On 06.09.2023 10:11, Boris Brezillon wrote:
> >On Tue,  5 Sep 2023 19:45:24 +0100
> >Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:
> > =20
> >> The current implementation will try to pick the highest available size
> >> display unit as soon as the BO size exceeds that of the previous
> >> multiplier.
> >>=20
> >> By selecting a higher threshold, we could show more accurate size numb=
ers.
> >>=20
> >> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
> >> ---
> >>  drivers/gpu/drm/drm_file.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>=20
> >> diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
> >> index 762965e3d503..0b5fbd493e05 100644
> >> --- a/drivers/gpu/drm/drm_file.c
> >> +++ b/drivers/gpu/drm/drm_file.c
> >> @@ -879,7 +879,7 @@ static void print_size(struct drm_printer *p, cons=
t char *stat,
> >>  	unsigned u;
> >> =20
> >>  	for (u =3D 0; u < ARRAY_SIZE(units) - 1; u++) {
> >> -		if (sz < SZ_1K)
> >> +		if (sz < (SZ_1K * 10000))
> >>  			break; =20
> >
> >This threshold looks a bit random. How about picking a unit that allows
> >us to print the size with no precision loss?
> >
> >	for (u =3D 0; u < ARRAY_SIZE(units) - 1; u++) {
> >		if (sz & (SZ_1K - 1))
> >			break;
> >	} =20
>=20
> In this case I picked up on Rob Clark's suggestion of choosing a hard lim=
it of
> perhaps 10k or 100k times the current unit before moving on to the next o=
ne.
> While this approach guarantees that we don't lose precision, it would ren=
der a
> tad too long a number in KiB for BO's that aren't a multiple of a MiB.

I'd expect big BOs to have their size naturally aligned on something
bigger than a 4k page anyway, so I don't expect multi-MB/GB buffers to
be using the KiB unit in practice. It's just that it's weird to have,
8MiB printed as 8192KiB when we could have used the upper unit,
because it's naturally aligned on a megabyte.

Maybe we should have something like that instead:

	for (u =3D 0; u < ARRAY_SIZE(units) - 1; u++) {
		if ((sz & (SZ_1K - 1)) &&
		    sz < UPPER_UNIT_THRESHOLD * SZ_1K)
			break;

		sz =3D div_u64(sz, SZ_1K);
	}
>=20
> >>  		sz =3D div_u64(sz, SZ_1K);
> >>  	} =20

