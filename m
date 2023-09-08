Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147D379869A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 13:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242123AbjIHLvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 07:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239226AbjIHLvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 07:51:46 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F7B1BC1
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 04:51:40 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1cc61f514baso1343399fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 04:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694173899; x=1694778699; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=etW99NG5BvyY4SuRfU5lZu1cQhINWbdTi13Yac2QPgE=;
        b=mFnVzlLhJ8gyQ3l9N2K1VE15XQWy1n59TvrwSfrbBAPSK4y7er+IACwkPEse2gWeD5
         cdvw+oCghBPNsLRw/PYNy8SFsTCUnZPwMuM4dyr3SMW4DVArnNBKiwc9EQzkILwKyjSW
         XeSRpBGmuJZdJT5XfRSNezEfrgH6Tcx0Tg9rQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694173899; x=1694778699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=etW99NG5BvyY4SuRfU5lZu1cQhINWbdTi13Yac2QPgE=;
        b=DCiVBymj/CYXDqRkHBe02jBQ7WLsqRLdvQ21SZNjkMZfVjh9kKvY3bWUvZNwO3U4JY
         AkeJpqlqXdDlGVTMQC0N8wr2jGVu9MSzZkwBi6HS7eg32sUN3PXjpdCn44B8xAnqq+JY
         9L94rH8GvgbL+5el+ONFNnHMYyFXF/Y73VoWfb4r7T3C4sqkjC35CDU/E3t8nlyiSTZD
         HfOzvHoRTeZFQzRVw4PCmb7hVXjuSHCB8vhcCHsUwHTrohHz5BflZ6E/65zqRqSXfjOX
         fbw/3s6QVsyorFgtIFAxLoAiIuxD/ZQuSoAj0evvI+Nh0ADcR4Bk4Y1sau2algLStzjI
         qD4g==
X-Gm-Message-State: AOJu0YzuxjAFpZpVhRw7SttcTDZWe1hBoeEe3C1HCluVtDDZsvjllfXt
        kYqeOdZXZFT01uoz+HBeAP4cmHEmbWsli7bifxc=
X-Google-Smtp-Source: AGHT+IG5ICz9joPNyU8eCxmKKANfdXZk0AHXdPio6vB9t2aB2i1gyBe2msgrfOxtNmmt4X3CmyjT4Q==
X-Received: by 2002:a05:6870:1710:b0:1be:f721:db04 with SMTP id h16-20020a056870171000b001bef721db04mr2607372oae.4.1694173899285;
        Fri, 08 Sep 2023 04:51:39 -0700 (PDT)
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com. [209.85.166.43])
        by smtp.gmail.com with ESMTPSA id f26-20020a02a81a000000b0042b70c5d242sm411294jaj.116.2023.09.08.04.51.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Sep 2023 04:51:38 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-77ac14ff51bso72949839f.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 04:51:38 -0700 (PDT)
X-Received: by 2002:a6b:e60b:0:b0:791:280:839e with SMTP id
 g11-20020a6be60b000000b007910280839emr2660662ioh.16.1694173898001; Fri, 08
 Sep 2023 04:51:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230901234202.566951-1-dianders@chromium.org> <20230901164111.RFT.5.I2b014f90afc4729b6ecc7b5ddd1f6dedcea4625b@changeid>
In-Reply-To: <20230901164111.RFT.5.I2b014f90afc4729b6ecc7b5ddd1f6dedcea4625b@changeid>
From:   Fei Shao <fshao@chromium.org>
Date:   Fri, 8 Sep 2023 19:51:00 +0800
X-Gmail-Original-Message-ID: <CAC=S1niYAC3PFQoAmwVc=1FcK29uu5sC9c1pGo-mku__y7eHcA@mail.gmail.com>
Message-ID: <CAC=S1niYAC3PFQoAmwVc=1FcK29uu5sC9c1pGo-mku__y7eHcA@mail.gmail.com>
Subject: Re: [RFT PATCH 05/15] drm/mediatek: Call drm_atomic_helper_shutdown()
 at shutdown time
To:     Douglas Anderson <dianders@chromium.org>
Cc:     dri-devel@lists.freedesktop.org,
        Maxime Ripard <mripard@kernel.org>, airlied@gmail.com,
        angelogioacchino.delregno@collabora.com, chunkuang.hu@kernel.org,
        daniel@ffwll.ch, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        matthias.bgg@gmail.com, p.zabel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Sep 2, 2023 at 7:42=E2=80=AFAM Douglas Anderson <dianders@chromium.=
org> wrote:
...<snip>
> @@ -952,6 +960,7 @@ static const struct dev_pm_ops mtk_drm_pm_ops =3D {
>  static struct platform_driver mtk_drm_platform_driver =3D {
>         .probe  =3D mtk_drm_probe,
>         .remove =3D mtk_drm_remove,

I think this patch, and perhaps some others in this series, will have
a trivial conflict to Uwe's work about the remove callback conversion
e.g. [1], so you might want to rebase the series onto the latest
linux-next.

On the other hand, I tested this patch on MT8195 and MT8188
Chromebooks and I don't see issues during boot / reboot, so

Reviewed-by: Fei Shao <fshao@chromium.org>
Tested-by: Fei Shao <fshao@chromium.org>

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git=
/commit/?h=3Dmediatek-drm-next&id=3Db3af12a0b46888340e024ba8b231605bcf2d0ab=
3



> +       .shutdown =3D mtk_drm_shutdown,
>         .driver =3D {
>                 .name   =3D "mediatek-drm",
>                 .pm     =3D &mtk_drm_pm_ops,
> --
> 2.42.0.283.g2d96d420d3-goog
>
>
