Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02FAA798961
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 16:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244266AbjIHO6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 10:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbjIHO6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 10:58:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E049D1BF9;
        Fri,  8 Sep 2023 07:58:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57A1DC433CB;
        Fri,  8 Sep 2023 14:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694185097;
        bh=YHWiozBQz8M89S0eQtdzMDiHAWQW+bFwnLQBuywA5v0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PjuN4uW4xHA2bfQRNMtMyibAtItMsgMAWDKgp7FbsKOCQBzOL4j7vWFQp7ijpPmBR
         Dj5oLHaHWn1fdVZdB4Lk/7P0/Yli9dGI2sOGBVzoubgbvBQgNNrLCCsyu8uwvJBIM/
         2UMsCPA0LmYM8ecJwp5O+E9vpgAgTqrCbraz06W1apq2l7WTedAX+AXhWHnSwsERH+
         t8HWAek6++SSLVhStdhVooVX74QtEKUpPXESLu9KfSzvnr7KRkLRAey2Ourp1uvHVg
         NnkeNYrhIMqpTMAeJx/8F1HpAb9RF3IUDBhHWdMxWW5adlnS3ondLqZ1Y9rRfzyAWn
         xyZg9HLyqND6g==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-501eec0a373so3440119e87.3;
        Fri, 08 Sep 2023 07:58:17 -0700 (PDT)
X-Gm-Message-State: AOJu0YyXdeB+BONk3CHCIteclXU/iIHh211S41ZrYXehgqDJj5qI4DIB
        WjOnbnNmB43zuagc6I+u5YBIfWjrf0tpmUoZEg==
X-Google-Smtp-Source: AGHT+IGhnXrBYf2YFXjtpNn+1fKCeSBVL6YtDzATpLiPWYvlg5Nj1GMXlbClb+fRpxoL7jet5iA29WbZSeWGNtf0qGY=
X-Received: by 2002:a05:6512:110c:b0:502:9fce:b6d0 with SMTP id
 l12-20020a056512110c00b005029fceb6d0mr1462402lfg.11.1694185095517; Fri, 08
 Sep 2023 07:58:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230908104458.775740-1-songshuaishuai@tinylab.org>
In-Reply-To: <20230908104458.775740-1-songshuaishuai@tinylab.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 8 Sep 2023 09:58:02 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJFWTWg9gmO7P8d5-W9VeMtmazhCsQW121LDAWLMAHEnQ@mail.gmail.com>
Message-ID: <CAL_JsqJFWTWg9gmO7P8d5-W9VeMtmazhCsQW121LDAWLMAHEnQ@mail.gmail.com>
Subject: Re: [PATCH] of/kexec: Omit kaslr-seed when kexecing with nokaslr
To:     Song Shuai <songshuaishuai@tinylab.org>
Cc:     frowand.list@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Fri, Sep 8, 2023 at 5:45=E2=80=AFAM Song Shuai <songshuaishuai@tinylab.o=
rg> wrote:
>
> The chosen node always adds the kaslr-seed property which is needless
> for the kernels kexeced with the cmdline contained "nokaslr".
>
> So omit the kaslr-seed when kexecing with nokaslr.

The kexec'ed kernel can ignore bootargs with CONFIG_CMDLINE_FORCE. So
you don't know if kaslr-seed will be used or not.

> Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
> ---
>  drivers/of/kexec.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
> index f26d2ba8a371..c0d53b10cb70 100644
> --- a/drivers/of/kexec.c
> +++ b/drivers/of/kexec.c
> @@ -19,6 +19,7 @@
>  #include <linux/random.h>
>  #include <linux/slab.h>
>  #include <linux/types.h>
> +#include <linux/string.h>
>
>  #define RNG_SEED_SIZE          128
>
> @@ -263,6 +264,14 @@ static inline int setup_ima_buffer(const struct kima=
ge *image, void *fdt,
>  }
>  #endif /* CONFIG_IMA_KEXEC */
>
> +static bool is_nokaslr_cmdline(const char *cmdline)
> +{
> +       char *str;
> +
> +       str =3D strstr(cmdline, "nokaslr");
> +       return str =3D=3D cmdline || (str > cmdline && *(str - 1) =3D=3D =
' ');

Yet another copy of the same code. That's a clue to refactor into a
common function.

Rob
