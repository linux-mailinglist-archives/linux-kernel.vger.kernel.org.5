Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B01C7E2C47
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 19:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbjKFSsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 13:48:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbjKFSsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 13:48:53 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CB1B0
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 10:48:50 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3b5aee410f2so436061b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 10:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699296530; x=1699901330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GEU/T0YzjOtkbVZizp15U02rtKoeqg1sHvW0/B5DtdA=;
        b=haS10GIXKagjWC3mP4TQsvo2NwWqKSR1Cch2O9FynS4wdSk2Xy87l2n6AifRCIGHWF
         ZSullsyx3DQnSjgn+d/+9E0Ux2od9RK2rtR9Aq3ubZ+oPcIYqC06UM7q2JWf+OPr2YJC
         GEwGZ+p0lGWSYHxfOMYi7hSDz6aEELicO0tsL62HRVswic5hap8xZJmmNH2kJ0mhBoUA
         Md6j31fSQXoc3wNyH6D+r6G+wYqzciHsK4WmwRoQOfXMoq4MHW8bd6YrdD3AzwHoq/K7
         i9PMyWKx0DpF7Ot4iTAaIeVpGEEF86NflzH5U+gaTIJ9CD/kulENeT9w5W3oZcV6nYyz
         zE6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699296530; x=1699901330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GEU/T0YzjOtkbVZizp15U02rtKoeqg1sHvW0/B5DtdA=;
        b=oWhpbgYjPLS5BhZUpkM3DbcaYN9DGf+VBwLMVB9bQ8pF1idsqlZO61b1yab8dTzjyR
         HCdo9vFQMyrouznuxyA0Nrtn3bZ6liilitzRsR28QZu3j4W1o3Opq9yyaPLzTsUbznfr
         JJkpwSUW4atv1dbPMoz7IJABvMNplsxOpmH51TZb2B8wmC/EW9WVhEi+Mt16rFRFL+Mr
         t/OQkFgJ7QOST1VM6FuIddUvjey+yAROdBac+7tYeOjp3Dgc8bJac9xaRKysZuM6Ke+D
         vk93iuUkQQUkVbx3cWl/6mfpW5cnDU3NGNAyqVHREkuN03D+Vr/0H1Eq5YZHWgFL+E2u
         ksgQ==
X-Gm-Message-State: AOJu0YxOh6hFA1DGA3HIosxlvqIP5krqj9i6IPfEju1UC8MODmlUYx/V
        2nzLYGCrtm764vfw9XOv9GzM5KjvsZ20OFowOjSIKi3s
X-Google-Smtp-Source: AGHT+IGx9i2xhfecbXKM+Crwv24haeMNbJhw1G26AUXpr7Jj7oVxHkIyehbuuwd/4M7eEpgYPDo+SlUNw03C3ipL72c=
X-Received: by 2002:a05:6870:ff84:b0:1e9:b537:51ef with SMTP id
 qp4-20020a056870ff8400b001e9b53751efmr554623oab.31.1699296529538; Mon, 06 Nov
 2023 10:48:49 -0800 (PST)
MIME-Version: 1.0
References: <87wmuwo7i3.fsf@gentoo.org> <20231105160652.374422-1-sam@gentoo.org>
In-Reply-To: <20231105160652.374422-1-sam@gentoo.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 6 Nov 2023 13:48:38 -0500
Message-ID: <CADnq5_OvEsUD5wcvk8YtvHO+=89WJra4YFRoKe8JANvM_R9AKg@mail.gmail.com>
Subject: Re: [PATCH] amdgpu: Adjust kmalloc_array calls for new -Walloc-size
To:     Sam James <sam@gentoo.org>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Sun, Nov 5, 2023 at 11:07=E2=80=AFAM Sam James <sam@gentoo.org> wrote:
>
> GCC 14 introduces a new -Walloc-size included in -Wextra which errors out
> on various files in drivers/gpu/drm/amd/amdgpu like:
> ```
> amdgpu_amdkfd_gfx_v8.c:241:15: error: allocation of insufficient size =E2=
=80=984=E2=80=99 for type =E2=80=98uint32_t[2]=E2=80=99 {aka =E2=80=98unsig=
ned int[2]'} with size =E2=80=988=E2=80=99 [-Werror=3Dalloc-size]
> ```
>
> This is because each HQD_N_REGS is actually a uint32_t[2]. Move the * 2 t=
o
> the size argument so GCC sees we're allocating enough.
>
> Originally did 'sizeof(uint32_t) * 2' for the size but a friend suggested
> 'sizeof(**dump)' better communicates the intent.
>
> Link: https://lore.kernel.org/all/87wmuwo7i3.fsf@gentoo.org/
> Signed-off-by: Sam James <sam@gentoo.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c   | 4 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c   | 4 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c   | 4 ++--
>  5 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/driver=
s/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> index 625db444df1c..0ba15dcbe4e1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> @@ -200,7 +200,7 @@ int kgd_arcturus_hqd_sdma_dump(struct amdgpu_device *=
adev,
>  #undef HQD_N_REGS
>  #define HQD_N_REGS (19+6+7+10)
>
> -       *dump =3D kmalloc_array(HQD_N_REGS * 2, sizeof(uint32_t), GFP_KER=
NEL);
> +       *dump =3D kmalloc_array(HQD_N_REGS, sizeof(**dump), GFP_KERNEL);
>         if (*dump =3D=3D NULL)
>                 return -ENOMEM;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c b/driver=
s/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> index 490c8f5ddb60..ca7238b5535b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> @@ -141,7 +141,7 @@ static int kgd_gfx_v9_4_3_hqd_sdma_dump(struct amdgpu=
_device *adev,
>                 (*dump)[i++][1] =3D RREG32(addr);         \
>         } while (0)
>
> -       *dump =3D kmalloc_array(HQD_N_REGS * 2, sizeof(uint32_t), GFP_KER=
NEL);
> +       *dump =3D kmalloc_array(HQD_N_REGS, sizeof(**dump), GFP_KERNEL);
>         if (*dump =3D=3D NULL)
>                 return -ENOMEM;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c b/drivers/=
gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
> index 6bf448ab3dff..ca4a6b82817f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
> @@ -214,7 +214,7 @@ static int kgd_hqd_dump(struct amdgpu_device *adev,
>                 (*dump)[i++][1] =3D RREG32(addr);         \
>         } while (0)
>
> -       *dump =3D kmalloc_array(HQD_N_REGS * 2, sizeof(uint32_t), GFP_KER=
NEL);
> +       *dump =3D kmalloc_array(HQD_N_REGS, sizeof(**dump), GFP_KERNEL);
>         if (*dump =3D=3D NULL)
>                 return -ENOMEM;
>
> @@ -301,7 +301,7 @@ static int kgd_hqd_sdma_dump(struct amdgpu_device *ad=
ev,
>  #undef HQD_N_REGS
>  #define HQD_N_REGS (19+4)
>
> -       *dump =3D kmalloc_array(HQD_N_REGS * 2, sizeof(uint32_t), GFP_KER=
NEL);
> +       *dump =3D kmalloc_array(HQD_N_REGS, sizeof(**dump), GFP_KERNEL);
>         if (*dump =3D=3D NULL)
>                 return -ENOMEM;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c b/drivers/=
gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
> index cd06e4a6d1da..0f3e2944edd7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
> @@ -238,7 +238,7 @@ static int kgd_hqd_dump(struct amdgpu_device *adev,
>                 (*dump)[i++][1] =3D RREG32(addr);         \
>         } while (0)
>
> -       *dump =3D kmalloc_array(HQD_N_REGS * 2, sizeof(uint32_t), GFP_KER=
NEL);
> +       *dump =3D kmalloc_array(HQD_N_REGS, sizeof(**dump), GFP_KERNEL);
>         if (*dump =3D=3D NULL)
>                 return -ENOMEM;
>
> @@ -324,7 +324,7 @@ static int kgd_hqd_sdma_dump(struct amdgpu_device *ad=
ev,
>  #undef HQD_N_REGS
>  #define HQD_N_REGS (19+4+2+3+7)
>
> -       *dump =3D kmalloc_array(HQD_N_REGS * 2, sizeof(uint32_t), GFP_KER=
NEL);
> +       *dump =3D kmalloc_array(HQD_N_REGS, sizeof(**dump), GFP_KERNEL);
>         if (*dump =3D=3D NULL)
>                 return -ENOMEM;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/=
gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> index 51011e8ee90d..a3355b90aac5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> @@ -365,7 +365,7 @@ int kgd_gfx_v9_hqd_dump(struct amdgpu_device *adev,
>                 (*dump)[i++][1] =3D RREG32(addr);         \
>         } while (0)
>
> -       *dump =3D kmalloc_array(HQD_N_REGS * 2, sizeof(uint32_t), GFP_KER=
NEL);
> +       *dump =3D kmalloc_array(HQD_N_REGS, sizeof(**dump), GFP_KERNEL);
>         if (*dump =3D=3D NULL)
>                 return -ENOMEM;
>
> @@ -462,7 +462,7 @@ static int kgd_hqd_sdma_dump(struct amdgpu_device *ad=
ev,
>  #undef HQD_N_REGS
>  #define HQD_N_REGS (19+6+7+10)
>
> -       *dump =3D kmalloc_array(HQD_N_REGS * 2, sizeof(uint32_t), GFP_KER=
NEL);
> +       *dump =3D kmalloc_array(HQD_N_REGS, sizeof(**dump), GFP_KERNEL);
>         if (*dump =3D=3D NULL)
>                 return -ENOMEM;
>
> --
> 2.42.1
>
