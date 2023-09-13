Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C8B79F112
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 20:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbjIMSVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 14:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbjIMSVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 14:21:31 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9191BC6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 11:21:27 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99bf3f59905so17788466b.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 11:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694629285; x=1695234085; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l5QGC6faED9UJjdk62LCMZfSOuUFJeBirWltiWK+61M=;
        b=kd0wrCe8bkrmjNK4fdH9ikuz/V7eCHf3qyD0/14pBz/VQ2ZKLrIhXO9Qum3i3lYJxi
         0zPykmUyrAjSaGTwuFkRzzpT81CuBfyzBhgxfNsFJMhHvV+pAoILBaWuX4XJ+uaevZxg
         u6tczYG03efQDpPH2sOYxFiBFmBWsz7HsNnvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694629285; x=1695234085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l5QGC6faED9UJjdk62LCMZfSOuUFJeBirWltiWK+61M=;
        b=SSpiTaYf4Uo4q9HcOD9jG2MK8ERkNWrPKvPaXhgwlS46qJ2LT7AsQc/J5kQ72UTOKA
         7hyQsgIZJg1J0OfQMQfxmstgo1o834MEMm6iiFtcQQLGwnskllcjHLWdTrTw+KOjlf75
         zTPq6b5vuvy141q4va21hYDrqz/LQyds6xhEouv840KOTfvu2n8fFklWddow7WpvEo3I
         zcRofIYVUza4a8mfujrpfSqeLMWdVM/Jo4cmo/PoS++9+fFEkv9oswOvtBFoYhKxIVNK
         +HwEqwX2sX1I9iJhvNpxXIC+gW3nOhCG2ZwFfdyVDZ5QZES+Xn9ZesCSeVDmX2TXRtuE
         +AHQ==
X-Gm-Message-State: AOJu0YzgUUQ5MShz7HEI+C8bQ5ChCfBs/+aj94epDPsoaf3YA+a1W+I5
        DwsKll3immLvUtALTo/1LV23MaO3fWtsnVktXut+euxT
X-Google-Smtp-Source: AGHT+IFq4wKlWtO7hgcmHEXPRa80aWydBGSy3qLCWMPEZXE27zNPrGTTSBVi2fLzE1ql9b6RkvI4iA==
X-Received: by 2002:a17:906:3151:b0:9a2:295a:9bc5 with SMTP id e17-20020a170906315100b009a2295a9bc5mr2635758eje.21.1694629285335;
        Wed, 13 Sep 2023 11:21:25 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id o22-20020a17090637d600b00992b510089asm8723709ejc.84.2023.09.13.11.21.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 11:21:24 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-529fa243739so2461a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 11:21:24 -0700 (PDT)
X-Received: by 2002:a50:cd59:0:b0:522:4741:d992 with SMTP id
 d25-20020a50cd59000000b005224741d992mr219125edj.4.1694629284486; Wed, 13 Sep
 2023 11:21:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230901234202.566951-1-dianders@chromium.org> <20230901164111.RFT.13.I0a9940ff6f387d6acf4e71d8c7dbaff8c42e3aaa@changeid>
In-Reply-To: <20230901164111.RFT.13.I0a9940ff6f387d6acf4e71d8c7dbaff8c42e3aaa@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 13 Sep 2023 11:21:12 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VvbkKo9i994-GGFBKte=f_d9Vzh3o1UkTpTPSqCCEdeQ@mail.gmail.com>
Message-ID: <CAD=FV=VvbkKo9i994-GGFBKte=f_d9Vzh3o1UkTpTPSqCCEdeQ@mail.gmail.com>
Subject: Re: [RFT PATCH 13/15] drm/imx/ipuv3: Call drm_atomic_helper_shutdown()
 at shutdown/unbind time
To:     dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>, airlied@gmail.com,
        daniel@ffwll.ch, festevam@gmail.com, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
        shawnguo@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Sep 1, 2023 at 4:42=E2=80=AFPM Douglas Anderson <dianders@chromium.=
org> wrote:
>
> Based on grepping through the source code this driver appears to be
> missing a call to drm_atomic_helper_shutdown() at system shutdown time
> and at driver unbind time. Among other things, this means that if a
> panel is in use that it won't be cleanly powered off at system
> shutdown time.
>
> The fact that we should call drm_atomic_helper_shutdown() in the case
> of OS shutdown/restart and at driver remove (or unbind) time comes
> straight out of the kernel doc "driver instance overview" in
> drm_drv.c.
>
> A few notes about this fix:
> - When adding drm_atomic_helper_shutdown() to the unbind path, I added
>   it after drm_kms_helper_poll_fini() since that's when other drivers
>   seemed to have it.
> - Technically with a previous patch, ("drm/atomic-helper:
>   drm_atomic_helper_shutdown(NULL) should be a noop"), we don't
>   actually need to check to see if our "drm" pointer is NULL before
>   calling drm_atomic_helper_shutdown(). We'll leave the "if" test in,
>   though, so that this patch can land without any dependencies. It
>   could potentially be removed later.
> - This patch also makes sure to set the drvdata to NULL in the case of
>   bind errors to make sure that shutdown can't access freed data.
>
> Suggested-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> This commit is only compile-time tested.
>
>  drivers/gpu/drm/imx/ipuv3/imx-drm-core.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/gpu/drm/imx/ipuv3/imx-drm-core.c b/drivers/gpu/drm/i=
mx/ipuv3/imx-drm-core.c
> index 4a866ac60fff..4c8bc49758a7 100644
> --- a/drivers/gpu/drm/imx/ipuv3/imx-drm-core.c
> +++ b/drivers/gpu/drm/imx/ipuv3/imx-drm-core.c
> @@ -257,6 +257,7 @@ static int imx_drm_bind(struct device *dev)
>         drm_kms_helper_poll_fini(drm);
>         component_unbind_all(drm->dev, drm);
>  err_kms:
> +       dev_set_drvdata(dev, NULL);
>         drm_dev_put(drm);
>
>         return ret;
> @@ -269,6 +270,7 @@ static void imx_drm_unbind(struct device *dev)
>         drm_dev_unregister(drm);
>
>         drm_kms_helper_poll_fini(drm);
> +       drm_atomic_helper_shutdown(drm);
>
>         component_unbind_all(drm->dev, drm);
>
> @@ -298,6 +300,14 @@ static int imx_drm_platform_remove(struct platform_d=
evice *pdev)
>         return 0;
>  }
>
> +static void imx_drm_platform_shutdown(struct platform_device *pdev)
> +{
> +       struct drm_device *drm =3D platform_get_drvdata(pdev);
> +
> +       if (drm)
> +               drm_atomic_helper_shutdown(platform_get_drvdata(pdev));

Since this is now landing through the drm-misc-next tree, I got rid of
the check for NULL when applying and landed this after the patch
("drm/atomic-helper: drm_atomic_helper_shutdown(NULL) should be a
noop").


> @@ -325,6 +335,7 @@ MODULE_DEVICE_TABLE(of, imx_drm_dt_ids);
>  static struct platform_driver imx_drm_pdrv =3D {
>         .probe          =3D imx_drm_platform_probe,
>         .remove         =3D imx_drm_platform_remove,
> +       .shutdown       =3D imx_drm_platform_shutdown,

There was a trivial context conflict with commit 3095f1122203
("drm/imx/ipuv3: Convert to platform remove callback returning void")
that I resolved while applying.

I've now pushed to drm-misc-next:

02680d71dea8 drm/imx/ipuv3: Call drm_atomic_helper_shutdown() at
shutdown/unbind time
