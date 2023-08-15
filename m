Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D24F77CF96
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 17:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238293AbjHOPvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 11:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238323AbjHOPus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 11:50:48 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46FB1BE2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 08:50:16 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-56cc461f34fso3591041eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 08:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692114616; x=1692719416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AVuBwJh4e/PJsRX9uAJCAxNUSRGi87vXGCf9LVu/RZI=;
        b=l3+v0arNVlZh6xKCSEAle7gwWilV7bK3j2wrYSbZVr04kMpHxTqsCnZRoWoukqnCnC
         1MRXCZ5nD4dHr4sWev1L+/ppIWlewwToWwYT6/WRiwCmP/XVgSIaEzb8CepIT9Aqjd7H
         5M00zyBo1wXrovalLFsg/mqKAweK4cUBFUkzWSlT7bcXZATmJvNGSAKufNqhnVciD0uc
         RYXAiBorG/4StHafZLNn7eemP+BAtYgfSvnMlsy6FfSdKkcJVZXmn8DL0VZhL5MD+b0A
         SdyRbRDT7ReMwIBkzmgSbmKkJuj9I0eupsWB7kjs6L2LscV0icsjt0Fl8eoikx93qVWN
         sNcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692114616; x=1692719416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AVuBwJh4e/PJsRX9uAJCAxNUSRGi87vXGCf9LVu/RZI=;
        b=YLOFbJ+/cNcbpc45NzyRSb2xBt0ClemyI0PQJHg3Zh2hs1O8zvODMlBgz1OLWC2jkF
         lbXOJt5JPhY9TxUkBoE6qJmb5VPm/eclCQXLjZCJ3y4O79P0BgCFjj289ELq1LLf/mAC
         +jnFNtiokrsrl1jTfOBof7lPVLFQPdaXYm7bZmyyDstcicXEq32603d4CpDPLxgeQy2C
         xVHJe0AOHfmfA/KZuqgFqtzekDAcyYvPKaakez7dnpvYgXwHoaWw00cTP0LvI4qE+nHX
         HmxOPlizy7FexdkZhXDBecIG33ag52XSjKQ/xfBOUaaSZvRMUM0BaxKrDweOie3IxHb2
         SyDg==
X-Gm-Message-State: AOJu0YycgvMIHZxS58kzjAsyiMqRqP0W2SPUPBBAo3er4/OlRdiwZGTA
        p7guWCMdxyKHjAD9r5e5AhGj5tBVx1I9tJyiGz4=
X-Google-Smtp-Source: AGHT+IHnfanJXW9hOJVO0LHdf7NOx4OjrsIyG1aeMXAi9KSDW4x3gIykJjmw9TK435u51yUPEFMT1UKL4QlqQgtdoWE=
X-Received: by 2002:a05:6870:638b:b0:1ba:c3a2:fb71 with SMTP id
 t11-20020a056870638b00b001bac3a2fb71mr13551780oap.31.1692114616012; Tue, 15
 Aug 2023 08:50:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230815065445.25576-1-hongao@uniontech.com>
In-Reply-To: <20230815065445.25576-1-hongao@uniontech.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 15 Aug 2023 11:50:04 -0400
Message-ID: <CADnq5_N8nHV5ub0qf6ihU=+QKXOFfM4AnWbYmWf=EG8SbJXa8A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gmc6: fix in case the PCI BAR is larger than
 the actual amount of vram
To:     hongao <hongao@uniontech.com>
Cc:     alexander.deucher@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, lijo.lazar@amd.com, mario.limonciello@amd.com,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
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

Applied.  Thanks!

On Tue, Aug 15, 2023 at 3:13=E2=80=AFAM hongao <hongao@uniontech.com> wrote=
:
>
> [why]
> limit visible_vram_size to real_vram_size in case
> the PCI BAR is larger than the actual amount of vram.
>
> Signed-off-by: hongao <hongao@uniontech.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v6_0.c
> index b7dad4e67813..c0de7496bfd1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> @@ -320,6 +320,8 @@ static int gmc_v6_0_mc_init(struct amdgpu_device *ade=
v)
>         adev->gmc.aper_base =3D pci_resource_start(adev->pdev, 0);
>         adev->gmc.aper_size =3D pci_resource_len(adev->pdev, 0);
>         adev->gmc.visible_vram_size =3D adev->gmc.aper_size;
> +       if (adev->gmc.visible_vram_size > adev->gmc.real_vram_size)
> +               adev->gmc.visible_vram_size =3D adev->gmc.real_vram_size;
>
>         /* set the gart size */
>         if (amdgpu_gart_size =3D=3D -1) {
> --
> 2.20.1
>
