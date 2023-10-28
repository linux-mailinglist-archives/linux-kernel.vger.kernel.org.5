Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201DF7DA57D
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 09:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjJ1Hah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 03:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjJ1Hae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 03:30:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B424DC0;
        Sat, 28 Oct 2023 00:30:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 558C8C433C8;
        Sat, 28 Oct 2023 07:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698478232;
        bh=G3hZFeqHp4KZz05yqyW+3YNpIcFRWrm+pgoXvykBFCk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IOGQtWsEUHEzXd0TRB22kJTGOW2z2KIewjBPhOgUtYKGIVKX+uCyHpu57jn4pBgRb
         GxG+nVDvibiKKo4k8bGVRqDjNBggW2tStYvJIXNRbdx32GTCWhpitaq/0xVQB+umyY
         XdXwS3FDrYjl20QWr/BfRnvgXCzsRz9G5i+O+LbQbDneBI0L+YYN2woOhfQdLCnEJI
         zgxDEShyU5UF8KaXtcjZt3efbOua5jI2KC/eaEMK5Nng2eIk24gVCkE714b+SZsBN5
         fE5bKu2XDMkGpWpT+s5/l2tuzruUj9KY16U+HCJazL+PmQx6HXYeRVMuY7DkajCoN0
         Y7F/3Ayy5n3zw==
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-7ba0d338367so375358241.2;
        Sat, 28 Oct 2023 00:30:32 -0700 (PDT)
X-Gm-Message-State: AOJu0YynsFTs0FyzgUH4rMTS8Ixdq9EN2hngP7BCGZ5Xyvm5ZI5m9A9y
        tcZYE156KuDZUGcZs8yN+g35NbtOqq7cXEnpm0c=
X-Google-Smtp-Source: AGHT+IG7K9xjsegw5RTq2blhfkWfHRNjGKwNqyremp28DI0CwYbLV93rXFq6KD+5AAX9dFRRk975K9AYys/ivUcoppc=
X-Received: by 2002:a67:e08e:0:b0:457:cca9:a922 with SMTP id
 f14-20020a67e08e000000b00457cca9a922mr4760277vsl.24.1698478231381; Sat, 28
 Oct 2023 00:30:31 -0700 (PDT)
MIME-Version: 1.0
References: <20231028-imx214-v2-0-69a8fb730d6e@apitzsch.eu> <20231028-imx214-v2-5-69a8fb730d6e@apitzsch.eu>
In-Reply-To: <20231028-imx214-v2-5-69a8fb730d6e@apitzsch.eu>
From:   Ricardo Ribalda Delgado <ribalda@kernel.org>
Date:   Sat, 28 Oct 2023 09:30:14 +0200
X-Gmail-Original-Message-ID: <CAPybu_1rw8eC=hMXfW1aS-_vJNDnNGTJEL+_k=xK=q5ajz7kRw@mail.gmail.com>
Message-ID: <CAPybu_1rw8eC=hMXfW1aS-_vJNDnNGTJEL+_k=xK=q5ajz7kRw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] media: i2c: imx214: Fix cleanup after controls
 initialization error
To:     =?UTF-8?Q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andre

On Sat, Oct 28, 2023 at 9:19=E2=80=AFAM Andr=C3=A9 Apitzsch <git@apitzsch.e=
u> wrote:
>
> If the controls are initialized incorrectly, don't destroy the mutex not
> initialized yet and don't free controls as that is handled in
> imx214_ctrls_init().
>
> Signed-off-by: Andr=C3=A9 Apitzsch <git@apitzsch.eu>

Since you are calling v4l2_ctrl_handler_free() in imx214_ctrls_init, I
think you should squash this patch with 2/5.

Sorry for asking for a follow-up patch :S

Regards!


> ---
>  drivers/media/i2c/imx214.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/media/i2c/imx214.c b/drivers/media/i2c/imx214.c
> index e0d9624a9d3f..0aba28d6dc2f 100644
> --- a/drivers/media/i2c/imx214.c
> +++ b/drivers/media/i2c/imx214.c
> @@ -1069,7 +1069,7 @@ static int imx214_probe(struct i2c_client *client)
>
>         ret =3D imx214_ctrls_init(imx214);
>         if (ret < 0)
> -               goto free_ctrl;
> +               goto error_power_off;
>
>         mutex_init(&imx214->mutex);
>         imx214->ctrls.lock =3D &imx214->mutex;
> @@ -1100,6 +1100,7 @@ static int imx214_probe(struct i2c_client *client)
>  free_ctrl:
>         mutex_destroy(&imx214->mutex);
>         v4l2_ctrl_handler_free(&imx214->ctrls);
> +error_power_off:
>         pm_runtime_disable(imx214->dev);
>
>         return ret;
>
> --
> 2.42.0
>
