Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F78F7BD93B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 13:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346166AbjJILHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 07:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346139AbjJILHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 07:07:48 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0566099
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 04:07:47 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-536071e79deso9610435a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 04:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696849665; x=1697454465; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=guHVdpv8c4ei2FuWUdfrBzoMOIcM0hSMBR/+vC6tUmY=;
        b=g9boVoutIOJ4Q8JjnCHGbDVFnWyylDszwc0AwH5rXRG+Nfz8yewJXO9OPojtmpApoG
         XjasYbJRnb4XoXNPjVSDqSpn2T25g7YkAM3bP9LkoeiP+RnBWSVlMyyK4nIalUJk09QE
         Uds90w01VZM7lSzzDsLse7U9YgxqhyrjVrYsdS8d+rDzKSehDXkAM2tkLrVY4KaZFkv8
         UK5Xuin1KUZbv4k4ghwh+ViRh/jUfkX35RU0Sgiz+44yRoHAcu0OUuvgp2Hx7E4aq44G
         oblepXjRcTu84g2O4AnjsVScD5rVxnyQncqp/3eKbfCd6D/+C08QM5Lg2f3XRD82uhvg
         C5QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696849665; x=1697454465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=guHVdpv8c4ei2FuWUdfrBzoMOIcM0hSMBR/+vC6tUmY=;
        b=B1eHT+K+I4ofEXlJ3wyqt75KsnGIkRNwZmRNs/GTr7CEHha5CmNjjp2Xud+kdvm4kX
         QVZCMXL3dDI2MxunsYSNTRrV5d1EMDOhLVCCVr1VXI8F49kSRBBLASqeSqGJq8YgCoF8
         HGHROQC3Tc2RXJNSH2O8AMUwHt7AILN7wlyoeVLCd8xKV7ec4EJQrj+2CaaNuLca6Hgc
         O8K2jQmXSm3MhevWCZ4eUmGaeNNTOGbkX5uN4Xd/d+0m/7Ez2sgS1afwhvIIFd78wFLk
         qdUX2LfBJ8tEH4AsaRHDX2M0lN81eTwSqofk7yZiWj508RrZDCsx5mhw3GlkQL+t0XvE
         lreQ==
X-Gm-Message-State: AOJu0YyoDPhgQzWfQ964mwLmfMrP1zrgDd2yocsT8fipALtyXJxKYjLg
        Awrgl90wuhzeR8UWKfqdegAiqJfQms3z3pTkVcE=
X-Google-Smtp-Source: AGHT+IHguSL4wgR01UjzXOaSIFVcU+/sQIR6/w2BJeTttZ5NLTK5me/ng9hTzUa6NikJ7Ud6rqXQBcoQUBwutOsTbmI=
X-Received: by 2002:a05:6402:2813:b0:535:cbe5:a039 with SMTP id
 h19-20020a056402281300b00535cbe5a039mr10587138ede.12.1696849665249; Mon, 09
 Oct 2023 04:07:45 -0700 (PDT)
MIME-Version: 1.0
References: <20231008032908.11448-1-gehao@kylinos.cn>
In-Reply-To: <20231008032908.11448-1-gehao@kylinos.cn>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Mon, 9 Oct 2023 14:07:33 +0300
Message-ID: <CAEnQRZBKkFxgpxJVcnmFQe33abQ-36ZXL_GgNgE3jVwH5+dEJQ@mail.gmail.com>
Subject: Re: [PATCH] firmware/imx-dsp: Fix use_after_free in imx_dsp_setup_channels()
To:     Hao Ge <gehao@kylinos.cn>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        christophe.jaillet@wanadoo.fr, robh@kernel.org, treding@nvidia.com,
        daniel.baluta@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, gehao618@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 8, 2023 at 6:30=E2=80=AFAM Hao Ge <gehao@kylinos.cn> wrote:
>
> dsp_chan->name and chan_name points to same block of memory,
> because dev_err still needs to be used it,so we need free
> it's memory after use to avoid use_after_free.
>
> Fixes: e527adfb9b7d ("firmware: imx-dsp: Fix an error handling path in im=
x_dsp_setup_channels()")
> Signed-off-by: Hao Ge <gehao@kylinos.cn>

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>

> ---
>  drivers/firmware/imx/imx-dsp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/imx/imx-dsp.c b/drivers/firmware/imx/imx-ds=
p.c
> index 508eab346fc6..a48a58e0c61f 100644
> --- a/drivers/firmware/imx/imx-dsp.c
> +++ b/drivers/firmware/imx/imx-dsp.c
> @@ -114,11 +114,11 @@ static int imx_dsp_setup_channels(struct imx_dsp_ip=
c *dsp_ipc)
>                 dsp_chan->idx =3D i % 2;
>                 dsp_chan->ch =3D mbox_request_channel_byname(cl, chan_nam=
e);
>                 if (IS_ERR(dsp_chan->ch)) {
> -                       kfree(dsp_chan->name);
>                         ret =3D PTR_ERR(dsp_chan->ch);
>                         if (ret !=3D -EPROBE_DEFER)
>                                 dev_err(dev, "Failed to request mbox chan=
 %s ret %d\n",
>                                         chan_name, ret);
> +                       kfree(dsp_chan->name);
>                         goto out;
>                 }
>
> --
> 2.25.1
>
