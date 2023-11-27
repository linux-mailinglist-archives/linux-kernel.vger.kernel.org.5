Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D83B7FAC1B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 21:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbjK0U7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 15:59:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjK0U7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 15:59:44 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7E9C0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 12:59:51 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6d64c1155a8so3163610a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 12:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701118790; x=1701723590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X3yo837GDz7kubNtzjO6WNlCk3oHXeJlohNg0iLQ45k=;
        b=CvC/iO+Y7QCjxOEWQAHJxONR7ZmESQRn75AgGPzE8i8GW/Q+x+nandEGyVWgZ1bbkE
         i9SM3fTNkFIzag0w1k0T6qAs+FQUidhNeT1gBrDuNtiRmiwDeE8JSIrqzhOdNd0ZTJGI
         ly7VBrYphtqifo1NKoytadumaO5wnxCOpWNsXR47wrDEk6vjXZ3kWkex2W/WlGPLTuRE
         Tdfm1N4Vt1MejrVIPKNj4jsh5C1w9mFTP6KhDwmQoBAmU/m+rWgs0Kw0x4boy0SCpE1M
         Amch7BYAf2qbWbZCLnoRKm33EfN4cKqAinMQIuDrMKp1k6GKHpeS8RIGlmIFXsktXJf0
         kGLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701118790; x=1701723590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X3yo837GDz7kubNtzjO6WNlCk3oHXeJlohNg0iLQ45k=;
        b=f3hq7O/N0QGu7bL8OWyO2Huz6m1y9k5XWALutrzY8peHIIFwT1IQ0lpcsCcynwoL7N
         fmUNeOqYNgOOGps580D02Uh/AuntQIdm1vUGQrW1i1jGgnPNFIklIgiWC+coC0JV43fO
         KSO3biDMveyhHUiQeU0iZ58y7+gXoKH4Q9FqFFYwH8P7i2oByZ7cSLX22NLwgULc4byD
         +7aYjcWHaLQHkoAaFfIp7ZjnlWDfvcnqmENzIYoMD0T0W3ZNFFlpcgPY5shFED5a4Ccc
         XUR9mHTsiuYYN0RJZ2ZZEnTYo3JMLTACWlF/qXZ0Bgv7J+h8JOdxlrAWGhLkKBpWkhrn
         T8kg==
X-Gm-Message-State: AOJu0Yx9mihqLemgIIL46bxt/8L24eQMFudQlc0VDkfnHTYCXbUxlWfN
        71cPEWQr6qV7s286/OnxEqLH+83r0GBMqvtWnnY=
X-Google-Smtp-Source: AGHT+IFKyeIS5VTJZrANfRdevBMLW1f91RM2J5bRYY04tGsN7SGb+1O8Y1sezDSrVrT/0EFaAr+CWYML8gUnwK6S5CU=
X-Received: by 2002:a05:6870:3c8b:b0:1f9:dc5a:b8fc with SMTP id
 gl11-20020a0568703c8b00b001f9dc5ab8fcmr17780453oab.56.1701118790494; Mon, 27
 Nov 2023 12:59:50 -0800 (PST)
MIME-Version: 1.0
References: <20231123073325.16843-1-dinghao.liu@zju.edu.cn>
In-Reply-To: <20231123073325.16843-1-dinghao.liu@zju.edu.cn>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 27 Nov 2023 15:59:39 -0500
Message-ID: <CADnq5_Mm_LtYXAqGp0O0gk4YF-bM3_cBq6RZ-dBrZkSOQMo3qw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: fix a memleak in aldebaran_tables_init
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     Yifan Zhang <yifan1.zhang@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>,
        Yang Wang <kevinyang.wang@amd.com>,
        dri-devel@lists.freedesktop.org,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, Le Ma <le.ma@amd.com>,
        "Stanley.Yang" <Stanley.Yang@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Darren Powell <darren.powell@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Evan Quan <evan.quan@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Thu, Nov 23, 2023 at 3:08=E2=80=AFAM Dinghao Liu <dinghao.liu@zju.edu.cn=
> wrote:
>
> When kzalloc() for smu_table->ecc_table fails, we should free
> the previously allocated resources to prevent memleak.
>
> Fixes: edd794208555 ("drm/amd/pm: add message smu to get ecc_table v2")
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> index 1a6675d70a4b..f1440869d1ce 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> @@ -257,8 +257,11 @@ static int aldebaran_tables_init(struct smu_context =
*smu)
>         }
>
>         smu_table->ecc_table =3D kzalloc(tables[SMU_TABLE_ECCINFO].size, =
GFP_KERNEL);
> -       if (!smu_table->ecc_table)
> +       if (!smu_table->ecc_table) {
> +               kfree(smu_table->metrics_table);
> +               kfree(smu_table->gpu_metrics_table);
>                 return -ENOMEM;
> +       }
>
>         return 0;
>  }
> --
> 2.17.1
>
