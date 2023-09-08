Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6BC798993
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 17:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244343AbjIHPHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 11:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236517AbjIHPHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 11:07:08 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04DE1FC4;
        Fri,  8 Sep 2023 08:07:04 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6bca3311b4fso1599540a34.0;
        Fri, 08 Sep 2023 08:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694185624; x=1694790424; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AWiQIDttL2OGM1T9s0mfq0PqM64VbXI9XuBxObgq3WM=;
        b=XBiv8bafv7QQAXuzejLfkuvt3iS0h+MVCLEdEHELUPFcJDFhgR+RAr6JgcjTUtayF7
         MzUhH4djMsNEbUZ3DoFoM1ynqBm45gHAWzZ0zfJVdhqoIXQANIRrGRJ3aaTHK16oWhdj
         5Uxrbz+dz9px6DsUPAVAF228XzI2dCy7JFHtZfrU+7l7lVid74CgTyV+M2560FJHIkbL
         W7o1yFFoP6+lNj4knX98tDXu+nt+7BjqVe0h0KsQdUVzwuGXuut6eKBRjC0rkLwR/GxP
         z22C/u/5u6cwHwF+IFb3MV0RQc/QSsauG4nlkIei7pHDgONVf590EZ+Ki6CU3XqOt7N7
         vDxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694185624; x=1694790424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AWiQIDttL2OGM1T9s0mfq0PqM64VbXI9XuBxObgq3WM=;
        b=K7Smz1AAz03la8xWDv7iB1fGMjkR5g8G8/sVQCQ9l0DBZ3KBsg31fD48tys0wuaPcb
         SXUkkktpvXnvelLIJGsafQSxfa/tuwEtvQ1kahEGMfpli/IzxAtqG8ukP1NpOGJELAFW
         hpF/BUz1yQLtZrkPqHiZDWPbzXhG8MzWjceP65PyXiruZBLdPUpYJGsr4OfwIP9Ew6GS
         0/0gkBXUUQN4mB4xTAQC7k3QMh0O90KkexzkdhlqBh7QN1hVtE9k4aZIfLlhvd6NP70z
         Kpjaa7z1fQ2C1p+ewO0BbKdFCAd4OFabd6e3Br7UR9o9tMdSWuNVGokmFxr9rmze5KMP
         fuWw==
X-Gm-Message-State: AOJu0Ywf8jtTrfjJ/QT1usykOAakhL8YZKJhLGbeaud0rCZ1dNRGK8Vi
        ldAHX9nGI4HamURDrRzS+uXDTxOAdy5G5fq4Q6U=
X-Google-Smtp-Source: AGHT+IF0E37hZoCh63iuI5mxUajpuAnMjnY78v4uV+t3y1JIviJL8DKuBKMgl7W0zFbRBJIldu3BjZp/o3b6WwUIflk=
X-Received: by 2002:a05:6870:24aa:b0:1bb:8040:24e1 with SMTP id
 s42-20020a05687024aa00b001bb804024e1mr3333783oaq.28.1694185624141; Fri, 08
 Sep 2023 08:07:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230908145521.39044-1-hamza.mahfooz@amd.com>
In-Reply-To: <20230908145521.39044-1-hamza.mahfooz@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 8 Sep 2023 11:06:52 -0400
Message-ID: <CADnq5_MZt-sFrJSy9UKo-DL18LCEuBcf1-jnd1MocqHCh_QS5g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/amd/display: fix the white screen issue when
 >= 64GB DRAM
To:     Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc:     amd-gfx@lists.freedesktop.org, Alan Liu <haoping.liu@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>,
        dri-devel@lists.freedesktop.org,
        Mario Limonciello <mario.limonciello@amd.com>,
        David Airlie <airlied@gmail.com>,
        Shashank Sharma <shashank.sharma@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Qingqing Zhuo <Qingqing.Zhuo@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Stylon Wang <stylon.wang@amd.com>,
        Victor Zhao <Victor.Zhao@amd.com>,
        Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Le Ma <le.ma@amd.com>, Hersen Wu <hersenxs.wu@amd.com>,
        Yifan Zhang <yifan1.zhang@amd.com>,
        Felix Kuehling <felix.kuehling@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Hawking Zhang <Hawking.Zhang@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>, Wayne Lin <wayne.lin@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Candice Li <candice.li@amd.com>, Lang Yu <Lang.Yu@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Luben Tuikov <luben.tuikov@amd.com>
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

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Fri, Sep 8, 2023 at 10:56=E2=80=AFAM Hamza Mahfooz <hamza.mahfooz@amd.co=
m> wrote:
>
> From: Yifan Zhang <yifan1.zhang@amd.com>
>
> Dropping bit 31:4 of page table base is wrong, it makes page table
> base points to wrong address if phys addr is beyond 64GB; dropping
> page_table_start/end bit 31:4 is unnecessary since dcn20_vmid_setup
> will do that. Also, while we are at it, cleanup the assignments using
> upper_32_bits()/lower_32_bits() and AMDGPU_GPU_PAGE_SHIFT.
>
> Cc: stable@vger.kernel.org
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2354
> Fixes: 81d0bcf99009 ("drm/amdgpu: make display pinning more flexible (v2)=
")
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
> ---
> v2: use upper_32_bits()/lower_32_bits() and AMDGPU_GPU_PAGE_SHIFT
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 1bb1a394f55f..5f14cd9391ca 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1283,11 +1283,15 @@ static void mmhub_read_system_context(struct amdg=
pu_device *adev, struct dc_phy_
>
>         pt_base =3D amdgpu_gmc_pd_addr(adev->gart.bo);
>
> -       page_table_start.high_part =3D (u32)(adev->gmc.gart_start >> 44) =
& 0xF;
> -       page_table_start.low_part =3D (u32)(adev->gmc.gart_start >> 12);
> -       page_table_end.high_part =3D (u32)(adev->gmc.gart_end >> 44) & 0x=
F;
> -       page_table_end.low_part =3D (u32)(adev->gmc.gart_end >> 12);
> -       page_table_base.high_part =3D upper_32_bits(pt_base) & 0xF;
> +       page_table_start.high_part =3D upper_32_bits(adev->gmc.gart_start=
 >>
> +                                                  AMDGPU_GPU_PAGE_SHIFT)=
;
> +       page_table_start.low_part =3D lower_32_bits(adev->gmc.gart_start =
>>
> +                                                 AMDGPU_GPU_PAGE_SHIFT);
> +       page_table_end.high_part =3D upper_32_bits(adev->gmc.gart_end >>
> +                                                AMDGPU_GPU_PAGE_SHIFT);
> +       page_table_end.low_part =3D lower_32_bits(adev->gmc.gart_end >>
> +                                               AMDGPU_GPU_PAGE_SHIFT);
> +       page_table_base.high_part =3D upper_32_bits(pt_base);
>         page_table_base.low_part =3D lower_32_bits(pt_base);
>
>         pa_config->system_aperture.start_addr =3D (uint64_t)logical_addr_=
low << 18;
> --
> 2.41.0
>
