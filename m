Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C367BB9CC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 15:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbjJFNvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 09:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbjJFNvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 09:51:13 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB91AC
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 06:51:11 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99bf3f59905so381841566b.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 06:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696600267; x=1697205067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=59BqFGPIq+MlLg0nO/rZFvmB+hLKOqd3eB7b4cqnV5I=;
        b=ncXYf8qn0SHY583VUsRC36Np2Xpqp1KC8KQty6AGmjOH7YWAb/ISOxcQWvgr56OF6j
         N68FVvkbm4LxFDwvzBt2fuK3ZFU1BMmp/M7wyPkeYwg366dDBBH27iZ+Jyig+ws/Kdj0
         /WITZxorDhR4hHfRcBTPOp6i8OInIqXpg3fgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696600267; x=1697205067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=59BqFGPIq+MlLg0nO/rZFvmB+hLKOqd3eB7b4cqnV5I=;
        b=h1UVNzVQ6w8R7rGYVI09vo8PCpAPXNeaLl2yfeG6iY3lj7i9kDtVJXVxAAOI1cUlMA
         V2tB3w4LsoDsgCIg6XmgQTEOR7/ikjCJ17wH3rc11v+wUVsKVL5lsyMgDa7Jm9JBb5gF
         kncba2SvC/LogIuIyuIhkh/J1OvqtTMmNt0wgvqkkvwsVHObHs863W9SQPpERtuCNcHk
         f6imycm+cTUCGK/GsokR6RziRrUWJ+Ii7+GVXSY0qQVXI+J3GlSDiZkExZj6qyCQ8IE9
         zh5p/jClV5R802Hi3j+9O/TAJECUtq7kmyJIcdMTB2zjoJ+CdJn7MlxeoBjnZQF4WlIG
         mtig==
X-Gm-Message-State: AOJu0Yy7Qg1ihvt+dkmCQ+IGiUq08nWB7Arky4wt/jMIEOK8YFvo3jPz
        yT5dveipnvmIiuCtBuqY1xMjy3zpikm4Loq4wdybxdpL
X-Google-Smtp-Source: AGHT+IGtxODVbMt0JjForrPYH2bbTwt6+PvXHdANQSreF2vyEm7nN6fIoVYAmqdATZmJD/d7i5ECtg==
X-Received: by 2002:a17:906:2250:b0:9ae:54ea:5b0f with SMTP id 16-20020a170906225000b009ae54ea5b0fmr8034864ejr.24.1696600267094;
        Fri, 06 Oct 2023 06:51:07 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id h24-20020a17090634d800b009b94c545678sm2914922ejb.153.2023.10.06.06.51.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 06:51:06 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so14115a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 06:51:05 -0700 (PDT)
X-Received: by 2002:a50:8756:0:b0:52f:5697:8dec with SMTP id
 22-20020a508756000000b0052f56978decmr206638edv.4.1696600265520; Fri, 06 Oct
 2023 06:51:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230921192749.1542462-1-dianders@chromium.org>
 <CGME20230921194907eucas1p1027c5dfc5c5f77bca3c43673427c89cc@eucas1p1.samsung.com>
 <20230921122641.RFT.v2.9.Iea33274908b6b258955f45a8aaf6f5bba24ad6cd@changeid>
 <fb9cd62b-6637-7bcc-e23d-37f3806f8460@samsung.com> <CAAQKjZNn4RTJ-SHHEugcQoS2U9fzNTOGtUpSLLM0w1V6Pb0amw@mail.gmail.com>
In-Reply-To: <CAAQKjZNn4RTJ-SHHEugcQoS2U9fzNTOGtUpSLLM0w1V6Pb0amw@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 6 Oct 2023 06:50:49 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V2JSHsrTfdxP4=-nU4GGZB999iAb+NU3en-4o3-rLmYQ@mail.gmail.com>
Message-ID: <CAD=FV=V2JSHsrTfdxP4=-nU4GGZB999iAb+NU3en-4o3-rLmYQ@mail.gmail.com>
Subject: Re: [RFT PATCH v2 09/12] drm/exynos: Call drm_atomic_helper_shutdown()
 at shutdown/unbind time
To:     Inki Dae <daeinki@gmail.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        dri-devel@lists.freedesktop.org,
        Maxime Ripard <mripard@kernel.org>,
        linux-samsung-soc@vger.kernel.org, alim.akhtar@samsung.com,
        sw0312.kim@samsung.com, krzysztof.kozlowski@linaro.org,
        linux-kernel@vger.kernel.org, kyungmin.park@samsung.com,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Oct 5, 2023 at 7:20=E2=80=AFPM Inki Dae <daeinki@gmail.com> wrote:
>
> Thanks for testing. :)
>
> Acked-by : Inki Dae <inki.dae@samsung.com>

Inki: does that mean you'd like this to go through drm-misc? I'm happy
to do that, but there are no dependencies here so this could easily go
through your tree.


> 2023=EB=85=84 9=EC=9B=94 22=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 3:00,=
 Marek Szyprowski <m.szyprowski@samsung.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=
=84=B1:
> >
> >
> > On 21.09.2023 21:26, Douglas Anderson wrote:
> > > Based on grepping through the source code this driver appears to be
> > > missing a call to drm_atomic_helper_shutdown() at system shutdown tim=
e
> > > and at driver unbind time. Among other things, this means that if a
> > > panel is in use that it won't be cleanly powered off at system
> > > shutdown time.
> > >
> > > The fact that we should call drm_atomic_helper_shutdown() in the case
> > > of OS shutdown/restart and at driver remove (or unbind) time comes
> > > straight out of the kernel doc "driver instance overview" in
> > > drm_drv.c.
> > >
> > > A few notes about this fix:
> > > - When adding drm_atomic_helper_shutdown() to the unbind path, I adde=
d
> > >    it after drm_kms_helper_poll_fini() since that's when other driver=
s
> > >    seemed to have it.
> > > - Technically with a previous patch, ("drm/atomic-helper:
> > >    drm_atomic_helper_shutdown(NULL) should be a noop"), we don't
> > >    actually need to check to see if our "drm" pointer is NULL before
> > >    calling drm_atomic_helper_shutdown(). We'll leave the "if" test in=
,
> > >    though, so that this patch can land without any dependencies. It
> > >    could potentially be removed later.
> > > - This patch also makes sure to set the drvdata to NULL in the case o=
f
> > >    bind errors to make sure that shutdown can't access freed data.
> > >
> > > Suggested-by: Maxime Ripard <mripard@kernel.org>
> > > Reviewed-by: Maxime Ripard <mripard@kernel.org>
> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> >
> > Seems to be working fine on all my test Exynos-based boards with displa=
y.
> >
> > Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> >
> > Reviewed-by: Marek Szyprowski <m.szyprowski@samsung.com>
> >
> > > ---
> > > This commit is only compile-time tested.
> > >
> > > (no changes since v1)
> > >
> > >   drivers/gpu/drm/exynos/exynos_drm_drv.c | 11 +++++++++++
> > >   1 file changed, 11 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/exynos/exynos_drm_drv.c b/drivers/gpu/dr=
m/exynos/exynos_drm_drv.c
> > > index 8399256cb5c9..5380fb6c55ae 100644
> > > --- a/drivers/gpu/drm/exynos/exynos_drm_drv.c
> > > +++ b/drivers/gpu/drm/exynos/exynos_drm_drv.c
> > > @@ -300,6 +300,7 @@ static int exynos_drm_bind(struct device *dev)
> > >       drm_mode_config_cleanup(drm);
> > >       exynos_drm_cleanup_dma(drm);
> > >       kfree(private);
> > > +     dev_set_drvdata(dev, NULL);
> > >   err_free_drm:
> > >       drm_dev_put(drm);
> > >
> > > @@ -313,6 +314,7 @@ static void exynos_drm_unbind(struct device *dev)
> > >       drm_dev_unregister(drm);
> > >
> > >       drm_kms_helper_poll_fini(drm);
> > > +     drm_atomic_helper_shutdown(drm);
> > >
> > >       component_unbind_all(drm->dev, drm);
> > >       drm_mode_config_cleanup(drm);
> > > @@ -350,9 +352,18 @@ static int exynos_drm_platform_remove(struct pla=
tform_device *pdev)
> > >       return 0;
> > >   }
> > >
> > > +static void exynos_drm_platform_shutdown(struct platform_device *pde=
v)
> > > +{
> > > +     struct drm_device *drm =3D platform_get_drvdata(pdev);
> > > +
> > > +     if (drm)
> > > +             drm_atomic_helper_shutdown(drm);
> > > +}
> > > +
> > >   static struct platform_driver exynos_drm_platform_driver =3D {
> > >       .probe  =3D exynos_drm_platform_probe,
> > >       .remove =3D exynos_drm_platform_remove,
> > > +     .shutdown =3D exynos_drm_platform_shutdown,
> > >       .driver =3D {
> > >               .name   =3D "exynos-drm",
> > >               .pm     =3D &exynos_drm_pm_ops,
> >
> > Best regards
> > --
> > Marek Szyprowski, PhD
> > Samsung R&D Institute Poland
> >
