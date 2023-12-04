Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60665803CF7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 19:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbjLDS1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 13:27:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjLDS1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 13:27:17 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC968116
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 10:27:23 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6d8029dae41so2567558a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 10:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701714443; x=1702319243; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qKS/R0LCdw8slEjKVFrwMfnGQ9/6ujHp7Vv1Nk4Yan8=;
        b=FZXYB47FYZIX9F3TrJOuufzJseJDQxuaY1jZYY20B7A8H/xuuJOvOMVMpFXTdWE62K
         tYFWBtcz+9ZkbsxCH0qkBmg4VH+TypW8ff7EbODWCJaNO0a4HQWDg3yV+yPmScvR1ni5
         ro4nWW45AfEIBgIhtVeZmHZUFLCQHrrD2MTFGGNr0VGscDhPB4A8fJTWdZXlivoTzkTg
         1rqUC93llDAXNdxCtaDI3Cwkx9iy+cEHJ81XNoDTI4nRi0uj8zZFoOTivvXmLh/xMD2O
         mXzIuDHkOPZVHewffPYL2LCXeoRBz5NjmiztOZvfq7mAvk3n5ZEvLd99IWyk+1u9JEVH
         V3EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701714443; x=1702319243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qKS/R0LCdw8slEjKVFrwMfnGQ9/6ujHp7Vv1Nk4Yan8=;
        b=supH4AT1kExAed2rET8fLHuDGKI3LrIHQPqVECktJTYuNGMNOp4ZJmez+ocUAMAwZO
         m2AQASzXuhBAcXUhslC8wxLPs2At1iqDwTh4r4AoxTGQtBYySmh4PN/tzaigjLokX7sm
         GBQS7asLR+QwJQ7Wcw78GDN9rDnzymX4oOSfsPYo5kwn/mnuVL87+YjajlT8hRiHFo0k
         Cb3klsL9qasXD2hpyGhzM5PKG4sq18gRGhNkryIYiiBUtaLMuftSlnnCNu9xK0UsO/fi
         L69NcaPuDwXSTz/pW3F1IcgRV2jkA2r+Fxj2d34JCEMzsWqvTqd3VgS1XYx7hqj2eb7+
         XDNg==
X-Gm-Message-State: AOJu0Yz2PoznCa5Pg18tf7silv9nie06ZIZLxPQeBmiR6Ckg42CHBE96
        VBvIt4MyZy/Ln7n5g+KYu+edjnpCH005Rb3WeVQ=
X-Google-Smtp-Source: AGHT+IFpRbGI/d8p6DZaN7Pl996L2VYH9OmYnQ82PEmp4ww76xvcUbv12dovgxqEXpefd1J4UKlyWX2fWtvfy0137U0=
X-Received: by 2002:a05:6871:878a:b0:1fb:186d:73f2 with SMTP id
 td10-20020a056871878a00b001fb186d73f2mr4684487oab.32.1701714442949; Mon, 04
 Dec 2023 10:27:22 -0800 (PST)
MIME-Version: 1.0
References: <20231204085756.3303900-1-alexious@zju.edu.cn>
In-Reply-To: <20231204085756.3303900-1-alexious@zju.edu.cn>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 4 Dec 2023 13:27:11 -0500
Message-ID: <CADnq5_M0UodAHEkZR+naBELpeJXDexa5WHgp5DEzpP5ympAmaA@mail.gmail.com>
Subject: Re: [PATCH] [v2] drm/radeon/dpm: fix a memleak in sumo_parse_power_table
To:     Zhipeng Lu <alexious@zju.edu.cn>
Cc:     "Pan, Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, Jerome Glisse <jglisse@redhat.com>,
        dri-devel@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

On Mon, Dec 4, 2023 at 5:39=E2=80=AFAM Zhipeng Lu <alexious@zju.edu.cn> wro=
te:
>
> The rdev->pm.dpm.ps allocated by kcalloc should be freed in every
> following error-handling path. However, in the error-handling of
> rdev->pm.power_state[i].clock_info the rdev->pm.dpm.ps is not freed,
> resulting in a memleak in this function.
>
> Fixes: 80ea2c129c76 ("drm/radeon/kms: add dpm support for sumo asics (v2)=
")
> Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>

Applied.  Thanks!

> ---
>
> Changelog:
>
> v2: Adding {} to make if statement correct.
> ---
>  drivers/gpu/drm/radeon/sumo_dpm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/radeon/sumo_dpm.c b/drivers/gpu/drm/radeon/s=
umo_dpm.c
> index f74f381af05f..d49c145db437 100644
> --- a/drivers/gpu/drm/radeon/sumo_dpm.c
> +++ b/drivers/gpu/drm/radeon/sumo_dpm.c
> @@ -1493,8 +1493,10 @@ static int sumo_parse_power_table(struct radeon_de=
vice *rdev)
>                 non_clock_array_index =3D power_state->v2.nonClockInfoInd=
ex;
>                 non_clock_info =3D (struct _ATOM_PPLIB_NONCLOCK_INFO *)
>                         &non_clock_info_array->nonClockInfo[non_clock_arr=
ay_index];
> -               if (!rdev->pm.power_state[i].clock_info)
> +               if (!rdev->pm.power_state[i].clock_info) {
> +                       kfree(rdev->pm.dpm.ps);
>                         return -EINVAL;
> +               }
>                 ps =3D kzalloc(sizeof(struct sumo_ps), GFP_KERNEL);
>                 if (ps =3D=3D NULL) {
>                         kfree(rdev->pm.dpm.ps);
> --
> 2.34.1
>
