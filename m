Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 990AE7BCD91
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 11:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344576AbjJHJiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 05:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344589AbjJHJiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 05:38:09 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4482AE9
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 02:38:07 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-3512b425662so15273215ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 02:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696757886; x=1697362686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1fYiXpHzdursWStkJtczyobJvyoVD92PbbCoVYotrfY=;
        b=QHFEsIPvFJZh82f+daq08zKBn6+KDJ4hnW0C99nbioS3+907oKzE6htpCPEw1DjwSU
         AbdI8zaBM4LKi//eGm11PDXiJ9Aii7N+5H7RU0McyzDTLSxYJV+XFJcjqyFxL2FSzHsx
         ZwW62dXjqQc6l5M60FTWcLvOYeoRZt60aq4xRltI9MCVv5osWaVkUGGvPv3AppOS4sNA
         EzqhATp5OkHUhn0ZTfqOfTNPfD8iXKumOs1U7ueSBG73mW1lvp8LewaMz1HdCH462hOm
         ZmmCC26/S/RNRqMCi8xG3tFLTgPSmaqHdUVgsIrdaqImUEJh6m/ubYAK31FKYiT3LYQE
         R//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696757886; x=1697362686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1fYiXpHzdursWStkJtczyobJvyoVD92PbbCoVYotrfY=;
        b=I0ivOVFk1h1iUzkLYvulcW85FS/e3Oss4bG9zppyS6Iwi/FzVRXAYVGdMTcw5ioPTa
         8DvWmjXE00KrsQYdREukEvKpWAvW77U8qA6tW55SpaU9U7TB/iReMEqREvYskfnT2wg4
         qJK9G2Hsm6BC+yNVW0b9VZiV+gkp0K1iO5/XR4wSMqL9XE0UXRqlDnH/bqCHjxKQ2nbK
         wZOkTI5zsu/GjcSsN/MWXgN6H9ic/B7Pmv/piNVUPtvBsEZjg1mP36idTLO7k7FaQuBY
         BGD5/GAsQPcSincK3mAgD3hWs/ciuarzOfQNiaZ8iz1kJLXgcUoTD3uFBWKOLQzC6Hl1
         0PwQ==
X-Gm-Message-State: AOJu0Yycqm0rpWw/CjqmAhoW+RNiwo7e53TmP4fWsRWbavd/hXammupu
        X29/sMVtZp2mTU5sWrGtjPG9wa8ts/vs/VeXuYmQRpxoXg/Mrg==
X-Google-Smtp-Source: AGHT+IFOPXqa1g6fZGD/2vL4Ek92lAQIZ3j/sZIBurFiKkx5uCP6NxLrJQ6ZaN6RV8gr8K1oXMJbJlZME8c7U+Lw4uA=
X-Received: by 2002:a05:6e02:184f:b0:349:3020:d103 with SMTP id
 b15-20020a056e02184f00b003493020d103mr15718726ilv.25.1696757886364; Sun, 08
 Oct 2023 02:38:06 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_681B0528D436898B1B945A8B2D46300C0F07@qq.com>
In-Reply-To: <tencent_681B0528D436898B1B945A8B2D46300C0F07@qq.com>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Sun, 8 Oct 2023 17:37:54 +0800
Message-ID: <CAA+D8ANxyQbZDp0DuaxzvucHWvuU9N-ckWQYAEa89LAD7-whUA@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl: Fix PM disable depth imbalance in fsl_easrc_probe
To:     Zhang Shurong <zhang_shurong@foxmail.com>
Cc:     Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 4, 2023 at 3:12=E2=80=AFPM Zhang Shurong <zhang_shurong@foxmail=
.com> wrote:
>
> The pm_runtime_enable will increase power disable depth. Thus
> a pairing decrement is needed on the error handling path to
> keep it balanced according to context. We fix it by calling
> pm_runtime_disable when error returns.
>

Please add a Fixes tag.
Thanks.

Best regards
Wang Shengjiu

> Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
> ---
>  sound/soc/fsl/fsl_easrc.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/sound/soc/fsl/fsl_easrc.c b/sound/soc/fsl/fsl_easrc.c
> index ba62995c909a..ec53bda46a46 100644
> --- a/sound/soc/fsl/fsl_easrc.c
> +++ b/sound/soc/fsl/fsl_easrc.c
> @@ -1966,17 +1966,21 @@ static int fsl_easrc_probe(struct platform_device=
 *pdev)
>                                               &fsl_easrc_dai, 1);
>         if (ret) {
>                 dev_err(dev, "failed to register ASoC DAI\n");
> -               return ret;
> +               goto err_pm_disable;
>         }
>
>         ret =3D devm_snd_soc_register_component(dev, &fsl_asrc_component,
>                                               NULL, 0);
>         if (ret) {
>                 dev_err(&pdev->dev, "failed to register ASoC platform\n")=
;
> -               return ret;
> +               goto err_pm_disable;
>         }
>
>         return 0;
> +
> +err_pm_disable:
> +       pm_runtime_disable(&pdev->dev);
> +       return ret;
>  }
>
>  static void fsl_easrc_remove(struct platform_device *pdev)
> --
> 2.30.2
>
