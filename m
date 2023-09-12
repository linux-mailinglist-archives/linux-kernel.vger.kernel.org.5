Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9174F79DBBA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 00:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234892AbjILWNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 18:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbjILWNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 18:13:40 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13C110D9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 15:13:36 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-64b3ae681d1so33516696d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 15:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694556816; x=1695161616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=67MJC2d5J2erEiZgw/Tl5J0vIH9+tJ2KcoKs7uxuLf4=;
        b=EpiYcrhg/PH37kXIdurkb0lPgiswsvyOR8lYCltxswcP7hT8SmNHGOWfr9Kwt7/0K2
         j+yzdyfjHMfFQ5U0KROclEp4U4+1Mo30n7pGlFn4RNGvTdVN9jPTAZIL7IKCex7/f4qp
         43PHJlkLW7vM2lvmMMpxvfmGXNpOlYgd/BRfuKj1o/dIn3jO5OnS+wr6Gkf6mt1jXGkx
         S/WxhVKS0a8vmtP4M/7k3Njne69Px4JHLVYdMGtvVa4KeB1+I8jiiP7a/jTyL0GQmOne
         xyAfVL7TAFRCyJByEAF0yaGRgK1gXfxe7eyndE/IExAQ1aKB72+GX48ul2EMD3gN9ewE
         MG1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694556816; x=1695161616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=67MJC2d5J2erEiZgw/Tl5J0vIH9+tJ2KcoKs7uxuLf4=;
        b=f7o/7CMH5x4m3gYScnltozS0TAI8jAn0TUZYmbrAiN7Fryadr2A8i/ZilAkkmQ1fq/
         SJgYsFMkC3w4l45CQujatOfqDtOCcebYY5k7sCBslvalWGzPWGFytuekNtt2cKpbjrrB
         voB3WRhd13MA+6yKZJr5/u+YMIw+zAgP+dPyD2078lx1idkxOGtJ2VDLQxCM0h2IHT9L
         lyryESKU/6M6U1kaYNZF6bAOoBH0LOSW3r1u/SGjGpNNG9p7yHRvfd3xrgyl3cKTz/IE
         /GHv3/MYWByZAq3dmRDoClUUgqz9c5eIxZ72SXrHo5mectplnYGuAMVNyVdYBU8gsw+l
         kDYw==
X-Gm-Message-State: AOJu0Ywz0ajeldzEnNmI1+zPpUbs+H9CXfVs0yyKhKRQ3WrFYLJlWnMd
        Ae2gTgmE+875nhceZNoIm2KvM6Lt0nqpBj19DGOwlQ==
X-Google-Smtp-Source: AGHT+IGxFejFbJL5qeAMHOudBDNhE+uZ2FQTukHHr3qTslMku3xjMd87HeKet4oNSbvL+qnG5NCfK0Pn1z059Pvn61E=
X-Received: by 2002:a05:6214:29ee:b0:64f:8213:197d with SMTP id
 jv14-20020a05621429ee00b0064f8213197dmr983778qvb.33.1694556815805; Tue, 12
 Sep 2023 15:13:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230627033326.5236-1-nicolinc@nvidia.com>
In-Reply-To: <20230627033326.5236-1-nicolinc@nvidia.com>
From:   Aahil Awatramani <aahila@google.com>
Date:   Tue, 12 Sep 2023 15:13:25 -0700
Message-ID: <CAGfWUPziSWNMc_px4E-i+_V_Jxdb_WSwOLXHZ+PANz2Tv5pFPA@mail.gmail.com>
Subject: Re: [PATCH v1] iommu/arm-smmu-v3: Allow default substream bypass with
 a pasid support
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     robin.murphy@arm.com, will@kernel.org, jgg@nvidia.com,
        joro@8bytes.org, shameerali.kolothum.thodi@huawei.com,
        yangyicong@hisilicon.com, jean-philippe@linaro.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have a use-case for this patch to help in avoiding the map/unmap
overhead in some cases but still maintaining support for PASIDs.

Thanks.


On Tue, Sep 12, 2023 at 1:30=E2=80=AFPM Nicolin Chen <nicolinc@nvidia.com> =
wrote:
>
> When an iommu_domain is set to IOMMU_DOMAIN_IDENTITY, the driver would
> skip the allocation of a CD table and set the CONFIG field of the STE
> to STRTAB_STE_0_CFG_BYPASS. This works well for devices that only have
> one substream, i.e. PASID disabled.
>
> However, there could be a use case, for a pasid capable device, that
> allows bypassing the translation at the default substream while still
> enabling the pasid feature, which means the driver should not skip the
> allocation of a CD table nor simply bypass the CONFIG field. Instead,
> the S1DSS field should be set to STRTAB_STE_1_S1DSS_BYPASS and the
> SHCFG field should be set to STRTAB_STE_1_SHCFG_INCOMING.
>
> Add s1dss and shcfg in struct arm_smmu_s1_cfg, to allow configurations
> in the finalise() to support that use case. Then, set them accordingly
> depending on the iommu_domain->type and the master->ssid_bits.
>
> Also, add STRTAB_STE_1_SHCFG_NONSHAREABLE of the default configuration
> to distinguish from STRTAB_STE_1_SHCFG_INCOMING of the bypass one.
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 18 +++++++++++++++---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  3 +++
>  2 files changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/=
arm/arm-smmu-v3/arm-smmu-v3.c
> index 9b0dc3505601..8dc7934a0175 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1350,11 +1350,12 @@ static void arm_smmu_write_strtab_ent(struct arm_=
smmu_master *master, u32 sid,
>
>                 BUG_ON(ste_live);
>                 dst[1] =3D cpu_to_le64(
> -                        FIELD_PREP(STRTAB_STE_1_S1DSS, STRTAB_STE_1_S1DS=
S_SSID0) |
> +                        FIELD_PREP(STRTAB_STE_1_S1DSS, s1_cfg->s1dss) |
>                          FIELD_PREP(STRTAB_STE_1_S1CIR, STRTAB_STE_1_S1C_=
CACHE_WBRA) |
>                          FIELD_PREP(STRTAB_STE_1_S1COR, STRTAB_STE_1_S1C_=
CACHE_WBRA) |
>                          FIELD_PREP(STRTAB_STE_1_S1CSH, ARM_SMMU_SH_ISH) =
|
> -                        FIELD_PREP(STRTAB_STE_1_STRW, strw));
> +                        FIELD_PREP(STRTAB_STE_1_STRW, strw) |
> +                        FIELD_PREP(STRTAB_STE_1_SHCFG, s1_cfg->shcfg));
>
>                 if (smmu->features & ARM_SMMU_FEAT_STALLS &&
>                     !master->stall_enabled)
> @@ -2119,6 +2120,13 @@ static int arm_smmu_domain_finalise_s1(struct arm_=
smmu_domain *smmu_domain,
>                 goto out_unlock;
>
>         cfg->s1cdmax =3D master->ssid_bits;
> +       if (smmu_domain->domain.type =3D=3D IOMMU_DOMAIN_IDENTITY) {
> +               cfg->s1dss =3D STRTAB_STE_1_S1DSS_BYPASS;
> +               cfg->shcfg =3D STRTAB_STE_1_SHCFG_INCOMING;
> +       } else {
> +               cfg->s1dss =3D STRTAB_STE_1_S1DSS_SSID0;
> +               cfg->shcfg =3D STRTAB_STE_1_SHCFG_NONSHAREABLE;
> +       }
>
>         smmu_domain->stall_enabled =3D master->stall_enabled;
>
> @@ -2198,7 +2206,11 @@ static int arm_smmu_domain_finalise(struct iommu_d=
omain *domain,
>         struct arm_smmu_domain *smmu_domain =3D to_smmu_domain(domain);
>         struct arm_smmu_device *smmu =3D smmu_domain->smmu;
>
> -       if (domain->type =3D=3D IOMMU_DOMAIN_IDENTITY) {
> +       /*
> +        * A master with a pasid capability might need a CD table, so onl=
y set
> +        * ARM_SMMU_DOMAIN_BYPASS if IOMMU_DOMAIN_IDENTITY and non-pasid =
master
> +        */
> +       if (domain->type =3D=3D IOMMU_DOMAIN_IDENTITY && !master->ssid_bi=
ts) {
>                 smmu_domain->stage =3D ARM_SMMU_DOMAIN_BYPASS;
>                 return 0;
>         }
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/=
arm/arm-smmu-v3/arm-smmu-v3.h
> index dcab85698a4e..8052d02770d0 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -244,6 +244,7 @@
>  #define STRTAB_STE_1_STRW_EL2          2UL
>
>  #define STRTAB_STE_1_SHCFG             GENMASK_ULL(45, 44)
> +#define STRTAB_STE_1_SHCFG_NONSHAREABLE        0UL
>  #define STRTAB_STE_1_SHCFG_INCOMING    1UL
>
>  #define STRTAB_STE_2_S2VMID            GENMASK_ULL(15, 0)
> @@ -601,6 +602,8 @@ struct arm_smmu_s1_cfg {
>         struct arm_smmu_ctx_desc_cfg    cdcfg;
>         struct arm_smmu_ctx_desc        cd;
>         u8                              s1fmt;
> +       u8                              s1dss;
> +       u8                              shcfg;
>         u8                              s1cdmax;
>  };
>
> --
> 2.41.0
>
