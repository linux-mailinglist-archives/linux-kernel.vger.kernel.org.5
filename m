Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969547FF7BD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 18:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345992AbjK3RG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 12:06:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbjK3RGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 12:06:24 -0500
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4692BD7D
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:06:31 -0800 (PST)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1fa8dc2a0bfso588860fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701363990; x=1701968790; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MlJsnM9X8S1R1QU50aDaUxRnifVbK+6ZZXWm1jW3cRo=;
        b=LKvVM/EeEXo1NK47i4YpuiETykg7sUlvIgGxxTCafSFvUTXH5DA300hkC/KhTcqTRz
         92ICtVaCWvH5oaHZoRyRKfHA0aA01S+v1UkUAD0CSdJo05AKIoc0U87zsfN83DiW69vu
         TZElStdbpszPsHuRRzOEUUQbrLrpyYnNBu2TQizna3PIWHnWgH6leql/S0LPESn1xO5i
         4LbRqZUH+DnM2TNoiKbS1jsMgUZr/6gg0/BDNyVzNFrBvfz03hLm5YGLzZtye+fN4M08
         x0pjvtOPvesgpEtrEX8xaRjwtgBzZKTTXPQ7rKv7d5gInZatcgZsvPqpb2U2JN+BnmYQ
         IWdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701363990; x=1701968790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MlJsnM9X8S1R1QU50aDaUxRnifVbK+6ZZXWm1jW3cRo=;
        b=IorZJ30dzEu2J6l8Uwz7kxvI0vd1J8C17vlqDoIswSasL4P5LBGif+a7Ldn1nqYXqM
         bstHa9TS8/VRnUJg1cncra/Xr+vvraPxlSi9IDTTWsKmY/GGFjrjzZ1H7nFARcszDdCM
         MreLL4GRNlHBCbZgUHKxXkxYdiPBKa8McSr59EmImYoikgsh/DQqZafIvwXUm9RuQ29y
         2B5fRtITqEQwtpCXd+Q5Hs5D24ToNQLLZov7vUy8Yd2bu/wZT9KJWA1PdtBmbNat1ya8
         VjG2e2csizzsprYTIJyFLgznsSURmCvmRtGAR6MI3hd8luUgZA9ojR/6+a5hsHNs2zqL
         cOgw==
X-Gm-Message-State: AOJu0Ywqv3W1KKmTK5dqyHYbHsYqhFZoFaBH8amU2uNlKctwu4P2D6/Z
        ra/E2aoB4YFpvS20C/uD5NWXoZazoWpnd8rsakcmLC0e
X-Google-Smtp-Source: AGHT+IEKdlosNmIQ5WeWVkNt7+fGwMIv0iwX5QXmSbUiiJUhBwH4O/QquYnAvbeL0qpC1g0R62JMDvqxfN7qssEs27Y=
X-Received: by 2002:a05:6870:2888:b0:1fa:1c34:98e9 with SMTP id
 gy8-20020a056870288800b001fa1c3498e9mr25202035oab.30.1701363990540; Thu, 30
 Nov 2023 09:06:30 -0800 (PST)
MIME-Version: 1.0
References: <20231129152230.7931-1-n.zhandarovich@fintech.ru>
In-Reply-To: <20231129152230.7931-1-n.zhandarovich@fintech.ru>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 30 Nov 2023 12:06:19 -0500
Message-ID: <CADnq5_O+O-395Brq+OHR3YEDaeTwQsMseJynv4Mm3L-KotO-5g@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon/r600_cs: Fix possible int overflows in r600_cs_check_reg()
To:     Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
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

On Wed, Nov 29, 2023 at 10:28=E2=80=AFAM Nikita Zhandarovich
<n.zhandarovich@fintech.ru> wrote:
>
> While improbable, there may be a chance of hitting integer
> overflow when the result of radeon_get_ib_value() gets shifted
> left.
>
> Avoid it by casting one of the operands to larger data type (u64).
>
> Found by Linux Verification Center (linuxtesting.org) with static
> analysis tool SVACE.
>
> Fixes: 1729dd33d20b ("drm/radeon/kms: r600 CS parser fixes")
> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
> ---
>  drivers/gpu/drm/radeon/r600_cs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/r600_cs.c b/drivers/gpu/drm/radeon/r6=
00_cs.c
> index 638f861af80f..6cf54a747749 100644
> --- a/drivers/gpu/drm/radeon/r600_cs.c
> +++ b/drivers/gpu/drm/radeon/r600_cs.c
> @@ -1275,7 +1275,7 @@ static int r600_cs_check_reg(struct radeon_cs_parse=
r *p, u32 reg, u32 idx)
>                         return -EINVAL;
>                 }
>                 tmp =3D (reg - CB_COLOR0_BASE) / 4;
> -               track->cb_color_bo_offset[tmp] =3D radeon_get_ib_value(p,=
 idx) << 8;
> +               track->cb_color_bo_offset[tmp] =3D (u64)radeon_get_ib_val=
ue(p, idx) << 8;
>                 ib[idx] +=3D (u32)((reloc->gpu_offset >> 8) & 0xffffffff)=
;
>                 track->cb_color_base_last[tmp] =3D ib[idx];
>                 track->cb_color_bo[tmp] =3D reloc->robj;
> @@ -1302,7 +1302,7 @@ static int r600_cs_check_reg(struct radeon_cs_parse=
r *p, u32 reg, u32 idx)
>                                         "0x%04X\n", reg);
>                         return -EINVAL;
>                 }
> -               track->htile_offset =3D radeon_get_ib_value(p, idx) << 8;
> +               track->htile_offset =3D (u64)radeon_get_ib_value(p, idx) =
<< 8;
>                 ib[idx] +=3D (u32)((reloc->gpu_offset >> 8) & 0xffffffff)=
;
>                 track->htile_bo =3D reloc->robj;
>                 track->db_dirty =3D true;
> --
> 2.25.1
>
