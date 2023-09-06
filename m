Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E467936E6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 10:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234750AbjIFILL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 04:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjIFILK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 04:11:10 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B73D12A;
        Wed,  6 Sep 2023 01:11:07 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 231EF6600BB0;
        Wed,  6 Sep 2023 09:11:05 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1693987865;
        bh=8bSTrWbaMc1d/WyrUSjc3GFi3A3hna8Y85gKyKeZ2QE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=A6irFNZNcrndI+FVnSuQe06fuZ1lV4On04bGSuwM3m51elPTmgtclWNK7Ru7tTz0S
         CI153LatWq7IsT87scPUnmoZRN0AoUu2+FBh903IZgY/hF9txKqcppB9Ma9oc4D02C
         ceZlwTYD/7dZpQf4atTnb5/ku4ksxGfcH8gWFMYhxFF0M4cYFa8mOAfD++5tbyoi8b
         mHlbBCY2K4UIlIbr7w+avVxl0oi0KQN4ZznpMhCylFpN++IUw/pdhlP+qAlQrPhENI
         4WEQacSCxAl8dkq6puZEBEyx5Ezc14EwdFguepGJ1mBWWfF+bY9urrIDvHwlan+Aw7
         9RYLoWcWd+c1A==
Date:   Wed, 6 Sep 2023 10:11:01 +0200
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
Message-ID: <20230906101101.04f4e1a2@collabora.com>
In-Reply-To: <20230905184533.959171-9-adrian.larumbe@collabora.com>
References: <20230905184533.959171-1-adrian.larumbe@collabora.com>
        <20230905184533.959171-9-adrian.larumbe@collabora.com>
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

On Tue,  5 Sep 2023 19:45:24 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> The current implementation will try to pick the highest available size
> display unit as soon as the BO size exceeds that of the previous
> multiplier.
>=20
> By selecting a higher threshold, we could show more accurate size numbers.
>=20
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
> ---
>  drivers/gpu/drm/drm_file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
> index 762965e3d503..0b5fbd493e05 100644
> --- a/drivers/gpu/drm/drm_file.c
> +++ b/drivers/gpu/drm/drm_file.c
> @@ -879,7 +879,7 @@ static void print_size(struct drm_printer *p, const c=
har *stat,
>  	unsigned u;
> =20
>  	for (u =3D 0; u < ARRAY_SIZE(units) - 1; u++) {
> -		if (sz < SZ_1K)
> +		if (sz < (SZ_1K * 10000))
>  			break;

This threshold looks a bit random. How about picking a unit that allows
us to print the size with no precision loss?

	for (u =3D 0; u < ARRAY_SIZE(units) - 1; u++) {
		if (sz & (SZ_1K - 1))
			break;
	}


>  		sz =3D div_u64(sz, SZ_1K);
>  	}

