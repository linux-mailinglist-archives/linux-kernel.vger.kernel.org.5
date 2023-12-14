Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29DE181389B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 18:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbjLNRe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 12:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444072AbjLNReZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 12:34:25 -0500
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D9A135
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 09:34:30 -0800 (PST)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-2031ebf11d9so862270fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 09:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702575269; x=1703180069; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=STnAG2tRSPrRkoOyuykDwCt+Qlz6ek3eimHvGihmNs0=;
        b=eeyVZ21rvVpNgWsst3Baa9T+cSvsJiFjaB40j2yNCm6FFSUXmO493Zr+1aapdI4OW7
         +12F/Jxg3krExvlh+McN0bs0ET7F17AYW5Ht6mV40bFJnmXcw/Yr0abmkOd7yLBURFTh
         K/fZY3UB647yYACrHmuZ5uWA8bBYE7tyBCssKfabPfBawc/OgWu2DdOyN1r76XlWH4a8
         FzpDeJKOnjrTjIY734SR9urs+jpZNM8yjoV90c9AZ9IqQKBOeD/a2++eF3vW/7o6zJje
         b+FprsPN6UN/dRQljyxrtEAtCGP8s5tyaF5+zy3zOADtKbAWMM4nxLIZvtwmSY97ahoK
         DC8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702575269; x=1703180069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=STnAG2tRSPrRkoOyuykDwCt+Qlz6ek3eimHvGihmNs0=;
        b=fH6rvkBwpkP7ULNSuqXKe/D4HrneLXVkVyHj0Qi7Rz38AkRR9dOOCcpcshNwcMW7rz
         y8T1Ca7cujyxqaBflC6ez+exiXVUm3Q4LtI14h6KvFNKtvK4FRmE46iu/xOz0rQV2RQb
         tUoLGpiRcuAQKiMZgYvr6N4yXRVTb38jFPAqPMzsucdmVDsjarF/Op0IovrMtm4VRvgH
         A9K4Upkr0IQFbYrh3UWWuJZAhQnOhkub53F2VS3bWxoqDGv7jjzRaac3YcYI3x9/I9Jl
         zO7HYwQ1omSSMRD17lnrKOYsZemGsIe4x9h8yc67hyZg/4nRslSrjHV2TvC2g9iN6Ga6
         qOTw==
X-Gm-Message-State: AOJu0YyQgAG4SW2u7EG+iN3j0d2zhGtpWwqvguvA+xw9fJEIhg6uKKj+
        1crDa8Xp9/KxqmgV+9SMUgegO7Kmd8L51+gkU1l0xhDG
X-Google-Smtp-Source: AGHT+IEKWXuqR4paEmw7Kggq1mLCq+BUvr4vk5F8v0KAOYf0b9vtgQXx3a98CVOwSkts3/orRPdk1lsku2mdk6IYLwg=
X-Received: by 2002:a05:6871:230e:b0:1fb:75b:2bb0 with SMTP id
 sf14-20020a056871230e00b001fb075b2bb0mr6987571oab.108.1702575269550; Thu, 14
 Dec 2023 09:34:29 -0800 (PST)
MIME-Version: 1.0
References: <20231214165941.3484829-1-alexious@zju.edu.cn>
In-Reply-To: <20231214165941.3484829-1-alexious@zju.edu.cn>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 14 Dec 2023 12:34:18 -0500
Message-ID: <CADnq5_NO23GM_Mo=GNC5wXy-r6yfz3W6VM_7tZsbMivsCO6VyA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: fix a double-free in amdgpu_parse_extended_power_table
To:     Zhipeng Lu <alexious@zju.edu.cn>
Cc:     Lijo Lazar <lijo.lazar@amd.com>, Kees Cook <keescook@chromium.org>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Evan Quan <evan.quan@amd.com>,
        David Airlie <airlied@gmail.com>,
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

Applied.  Thanks!

On Thu, Dec 14, 2023 at 12:20=E2=80=AFPM Zhipeng Lu <alexious@zju.edu.cn> w=
rote:
>
> The amdgpu_free_extended_power_table is called in every error-handling
> paths of amdgpu_parse_extended_power_table. However, after the following
> call chain of returning:
>
> amdgpu_parse_extended_power_table
>   |-> kv_dpm_init / si_dpm_init
>       (the only two caller of amdgpu_parse_extended_power_table)
>         |-> kv_dpm_sw_init / si_dpm_sw_init
>             (the only caller of kv_dpm_init / si_dpm_init, accordingly)
>               |-> kv_dpm_fini / si_dpm_fini
>                   (goto dpm_failed in xx_dpm_sw_init)
>                     |-> amdgpu_free_extended_power_table
>
> As above, the amdgpu_free_extended_power_table is called twice in this
> returning chain and thus a double-free is triggered. Similarily, the
> last kfree in amdgpu_parse_extended_power_table also cause a double free
> with amdgpu_free_extended_power_table in kv_dpm_fini.
>
> Fixes: 84176663e70d ("drm/amd/pm: create a new holder for those APIs used=
 only by legacy ASICs(si/kv)")
> Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
> ---
>  .../gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c    | 52 +++++--------------
>  1 file changed, 13 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c b/drivers/gpu=
/drm/amd/pm/legacy-dpm/legacy_dpm.c
> index 81fb4e5dd804..60377747bab4 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
> @@ -272,10 +272,8 @@ int amdgpu_parse_extended_power_table(struct amdgpu_=
device *adev)
>                                  le16_to_cpu(power_info->pplib4.usVddcDep=
endencyOnSCLKOffset));
>                         ret =3D amdgpu_parse_clk_voltage_dep_table(&adev-=
>pm.dpm.dyn_state.vddc_dependency_on_sclk,
>                                                                  dep_tabl=
e);
> -                       if (ret) {
> -                               amdgpu_free_extended_power_table(adev);
> +                       if (ret)
>                                 return ret;
> -                       }
>                 }
>                 if (power_info->pplib4.usVddciDependencyOnMCLKOffset) {
>                         dep_table =3D (ATOM_PPLIB_Clock_Voltage_Dependenc=
y_Table *)
> @@ -283,10 +281,8 @@ int amdgpu_parse_extended_power_table(struct amdgpu_=
device *adev)
>                                  le16_to_cpu(power_info->pplib4.usVddciDe=
pendencyOnMCLKOffset));
>                         ret =3D amdgpu_parse_clk_voltage_dep_table(&adev-=
>pm.dpm.dyn_state.vddci_dependency_on_mclk,
>                                                                  dep_tabl=
e);
> -                       if (ret) {
> -                               amdgpu_free_extended_power_table(adev);
> +                       if (ret)
>                                 return ret;
> -                       }
>                 }
>                 if (power_info->pplib4.usVddcDependencyOnMCLKOffset) {
>                         dep_table =3D (ATOM_PPLIB_Clock_Voltage_Dependenc=
y_Table *)
> @@ -294,10 +290,8 @@ int amdgpu_parse_extended_power_table(struct amdgpu_=
device *adev)
>                                  le16_to_cpu(power_info->pplib4.usVddcDep=
endencyOnMCLKOffset));
>                         ret =3D amdgpu_parse_clk_voltage_dep_table(&adev-=
>pm.dpm.dyn_state.vddc_dependency_on_mclk,
>                                                                  dep_tabl=
e);
> -                       if (ret) {
> -                               amdgpu_free_extended_power_table(adev);
> +                       if (ret)
>                                 return ret;
> -                       }
>                 }
>                 if (power_info->pplib4.usMvddDependencyOnMCLKOffset) {
>                         dep_table =3D (ATOM_PPLIB_Clock_Voltage_Dependenc=
y_Table *)
> @@ -305,10 +299,8 @@ int amdgpu_parse_extended_power_table(struct amdgpu_=
device *adev)
>                                  le16_to_cpu(power_info->pplib4.usMvddDep=
endencyOnMCLKOffset));
>                         ret =3D amdgpu_parse_clk_voltage_dep_table(&adev-=
>pm.dpm.dyn_state.mvdd_dependency_on_mclk,
>                                                                  dep_tabl=
e);
> -                       if (ret) {
> -                               amdgpu_free_extended_power_table(adev);
> +                       if (ret)
>                                 return ret;
> -                       }
>                 }
>                 if (power_info->pplib4.usMaxClockVoltageOnDCOffset) {
>                         ATOM_PPLIB_Clock_Voltage_Limit_Table *clk_v =3D
> @@ -339,10 +331,8 @@ int amdgpu_parse_extended_power_table(struct amdgpu_=
device *adev)
>                                 kcalloc(psl->ucNumEntries,
>                                         sizeof(struct amdgpu_phase_sheddi=
ng_limits_entry),
>                                         GFP_KERNEL);
> -                       if (!adev->pm.dpm.dyn_state.phase_shedding_limits=
_table.entries) {
> -                               amdgpu_free_extended_power_table(adev);
> +                       if (!adev->pm.dpm.dyn_state.phase_shedding_limits=
_table.entries)
>                                 return -ENOMEM;
> -                       }
>
>                         entry =3D &psl->entries[0];
>                         for (i =3D 0; i < psl->ucNumEntries; i++) {
> @@ -383,10 +373,8 @@ int amdgpu_parse_extended_power_table(struct amdgpu_=
device *adev)
>                         ATOM_PPLIB_CAC_Leakage_Record *entry;
>                         u32 size =3D cac_table->ucNumEntries * sizeof(str=
uct amdgpu_cac_leakage_table);
>                         adev->pm.dpm.dyn_state.cac_leakage_table.entries =
=3D kzalloc(size, GFP_KERNEL);
> -                       if (!adev->pm.dpm.dyn_state.cac_leakage_table.ent=
ries) {
> -                               amdgpu_free_extended_power_table(adev);
> +                       if (!adev->pm.dpm.dyn_state.cac_leakage_table.ent=
ries)
>                                 return -ENOMEM;
> -                       }
>                         entry =3D &cac_table->entries[0];
>                         for (i =3D 0; i < cac_table->ucNumEntries; i++) {
>                                 if (adev->pm.dpm.platform_caps & ATOM_PP_=
PLATFORM_CAP_EVV) {
> @@ -438,10 +426,8 @@ int amdgpu_parse_extended_power_table(struct amdgpu_=
device *adev)
>                                 sizeof(struct amdgpu_vce_clock_voltage_de=
pendency_entry);
>                         adev->pm.dpm.dyn_state.vce_clock_voltage_dependen=
cy_table.entries =3D
>                                 kzalloc(size, GFP_KERNEL);
> -                       if (!adev->pm.dpm.dyn_state.vce_clock_voltage_dep=
endency_table.entries) {
> -                               amdgpu_free_extended_power_table(adev);
> +                       if (!adev->pm.dpm.dyn_state.vce_clock_voltage_dep=
endency_table.entries)
>                                 return -ENOMEM;
> -                       }
>                         adev->pm.dpm.dyn_state.vce_clock_voltage_dependen=
cy_table.count =3D
>                                 limits->numEntries;
>                         entry =3D &limits->entries[0];
> @@ -493,10 +479,8 @@ int amdgpu_parse_extended_power_table(struct amdgpu_=
device *adev)
>                                 sizeof(struct amdgpu_uvd_clock_voltage_de=
pendency_entry);
>                         adev->pm.dpm.dyn_state.uvd_clock_voltage_dependen=
cy_table.entries =3D
>                                 kzalloc(size, GFP_KERNEL);
> -                       if (!adev->pm.dpm.dyn_state.uvd_clock_voltage_dep=
endency_table.entries) {
> -                               amdgpu_free_extended_power_table(adev);
> +                       if (!adev->pm.dpm.dyn_state.uvd_clock_voltage_dep=
endency_table.entries)
>                                 return -ENOMEM;
> -                       }
>                         adev->pm.dpm.dyn_state.uvd_clock_voltage_dependen=
cy_table.count =3D
>                                 limits->numEntries;
>                         entry =3D &limits->entries[0];
> @@ -525,10 +509,8 @@ int amdgpu_parse_extended_power_table(struct amdgpu_=
device *adev)
>                                 sizeof(struct amdgpu_clock_voltage_depend=
ency_entry);
>                         adev->pm.dpm.dyn_state.samu_clock_voltage_depende=
ncy_table.entries =3D
>                                 kzalloc(size, GFP_KERNEL);
> -                       if (!adev->pm.dpm.dyn_state.samu_clock_voltage_de=
pendency_table.entries) {
> -                               amdgpu_free_extended_power_table(adev);
> +                       if (!adev->pm.dpm.dyn_state.samu_clock_voltage_de=
pendency_table.entries)
>                                 return -ENOMEM;
> -                       }
>                         adev->pm.dpm.dyn_state.samu_clock_voltage_depende=
ncy_table.count =3D
>                                 limits->numEntries;
>                         entry =3D &limits->entries[0];
> @@ -548,10 +530,8 @@ int amdgpu_parse_extended_power_table(struct amdgpu_=
device *adev)
>                                  le16_to_cpu(ext_hdr->usPPMTableOffset));
>                         adev->pm.dpm.dyn_state.ppm_table =3D
>                                 kzalloc(sizeof(struct amdgpu_ppm_table), =
GFP_KERNEL);
> -                       if (!adev->pm.dpm.dyn_state.ppm_table) {
> -                               amdgpu_free_extended_power_table(adev);
> +                       if (!adev->pm.dpm.dyn_state.ppm_table)
>                                 return -ENOMEM;
> -                       }
>                         adev->pm.dpm.dyn_state.ppm_table->ppm_design =3D =
ppm->ucPpmDesign;
>                         adev->pm.dpm.dyn_state.ppm_table->cpu_core_number=
 =3D
>                                 le16_to_cpu(ppm->usCpuCoreNumber);
> @@ -583,10 +563,8 @@ int amdgpu_parse_extended_power_table(struct amdgpu_=
device *adev)
>                                 sizeof(struct amdgpu_clock_voltage_depend=
ency_entry);
>                         adev->pm.dpm.dyn_state.acp_clock_voltage_dependen=
cy_table.entries =3D
>                                 kzalloc(size, GFP_KERNEL);
> -                       if (!adev->pm.dpm.dyn_state.acp_clock_voltage_dep=
endency_table.entries) {
> -                               amdgpu_free_extended_power_table(adev);
> +                       if (!adev->pm.dpm.dyn_state.acp_clock_voltage_dep=
endency_table.entries)
>                                 return -ENOMEM;
> -                       }
>                         adev->pm.dpm.dyn_state.acp_clock_voltage_dependen=
cy_table.count =3D
>                                 limits->numEntries;
>                         entry =3D &limits->entries[0];
> @@ -606,10 +584,8 @@ int amdgpu_parse_extended_power_table(struct amdgpu_=
device *adev)
>                         ATOM_PowerTune_Table *pt;
>                         adev->pm.dpm.dyn_state.cac_tdp_table =3D
>                                 kzalloc(sizeof(struct amdgpu_cac_tdp_tabl=
e), GFP_KERNEL);
> -                       if (!adev->pm.dpm.dyn_state.cac_tdp_table) {
> -                               amdgpu_free_extended_power_table(adev);
> +                       if (!adev->pm.dpm.dyn_state.cac_tdp_table)
>                                 return -ENOMEM;
> -                       }
>                         if (rev > 0) {
>                                 ATOM_PPLIB_POWERTUNE_Table_V1 *ppt =3D (A=
TOM_PPLIB_POWERTUNE_Table_V1 *)
>                                         (mode_info->atom_context->bios + =
data_offset +
> @@ -645,10 +621,8 @@ int amdgpu_parse_extended_power_table(struct amdgpu_=
device *adev)
>                         ret =3D amdgpu_parse_clk_voltage_dep_table(
>                                         &adev->pm.dpm.dyn_state.vddgfx_de=
pendency_on_sclk,
>                                         dep_table);
> -                       if (ret) {
> -                               kfree(adev->pm.dpm.dyn_state.vddgfx_depen=
dency_on_sclk.entries);
> +                       if (ret)
>                                 return ret;
> -                       }
>                 }
>         }
>
> --
> 2.34.1
>
