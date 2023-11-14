Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 569DD7EB1F4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 15:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233449AbjKNORK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 09:17:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233565AbjKNOQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 09:16:57 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5318E3C25
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 06:15:35 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5a92782615dso66497837b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 06:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699971334; x=1700576134; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H9gudHAzsoMl11k13t49Tgymd183FsAsDTQ4+MjrDYg=;
        b=bbAlNibzizenVc/GiI7oZ2Lxv3dFWQHerEbDYP/icmoKExqVtfUvs+PGVqvvSbLp70
         mnxgR4I4kz2zv/ZDnBFn+gmncz0NrGxmg098rI9gPLEt05M4teSZ+wdjHDQ+xxlHKnnw
         KuzgcA9jHBry+og95VpUBmSZCvZ8/3QeH9UUw5cy4ehDqps0t5JWy+mcNUotJ6lE0XBs
         qRreYq/itJ22Q5Wp5Gkw+LONiHp++kRPAZ0Agnz62aRXwCIewQvRyxgWoX4ZnhorByx9
         nHWbr4UqRQed3APfs72KEdmU6oy+0iAwXO6aNF9S+sAb7XTn0SrbIeaKEdJajoIBZeYL
         xFkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699971334; x=1700576134;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H9gudHAzsoMl11k13t49Tgymd183FsAsDTQ4+MjrDYg=;
        b=ba1NlD+AgexhPqlnTDz+5x39uWMCzHSyg7NcIKKHKA43mynf5UusxcQmf27iNM1WPl
         upebRFe8ilY1MZL6GqF4xeUQcg25xgymcwVfwRY2p2K8txjHex4MflmRi+EeqTrjkL3p
         Ipmu+n8b3RO273MsFMC+PxoRabF1bS5vFc/MLrcu7sN1iC+liwLD9xrvd7WQ+4urGYXT
         0m773bqzrKdd5A90CYcNe2U51Q32tqSaW4AC30/Sp1yK9U5BGjH13jvEUqSuRaoMUI+9
         igKJVRUa/itwLdmu0C2JAhnn/NrNRn4itAtG/4pktJWrhDqrfmrXv+2sgZzlhO/tZIG6
         z9/A==
X-Gm-Message-State: AOJu0YwNL263AzAOXf+b/JLAuw2hJCWchIzzoDz1N5fdIl6j75HeqG/e
        Hi5W5CdZfPtEMWAqm6RLnToaoolFp3S6YsrNh5hP7w==
X-Google-Smtp-Source: AGHT+IE70nxRhJcbYkoU42dNYejri2XOGgM/Ozf5+wgTTc0YFE0/tNgIkF23HXIk8rTgfCLbOps33kblQnJHdqvFWjU=
X-Received: by 2002:a25:414c:0:b0:da0:5775:fd77 with SMTP id
 o73-20020a25414c000000b00da05775fd77mr7966567yba.63.1699971334217; Tue, 14
 Nov 2023 06:15:34 -0800 (PST)
MIME-Version: 1.0
References: <20231114135654.30475-1-quic_bibekkum@quicinc.com> <20231114135654.30475-4-quic_bibekkum@quicinc.com>
In-Reply-To: <20231114135654.30475-4-quic_bibekkum@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 14 Nov 2023 16:15:23 +0200
Message-ID: <CAA8EJpoRmm42aAvyX61o3tMWXszUZmfFvJEtnNDEfYdDqy4Y0g@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] iommu/arm-smmu: re-enable context caching in smmu
 reset operation
To:     Bibek Kumar Patro <quic_bibekkum@quicinc.com>
Cc:     will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        a39.skl@gmail.com, konrad.dybcio@linaro.org,
        quic_pkondeti@quicinc.com, quic_molvera@quicinc.com,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, qipl.kernel.upstream@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2023 at 15:57, Bibek Kumar Patro
<quic_bibekkum@quicinc.com> wrote:
>
> Context caching is re-enabled in the prefetch buffer for Qualcomm SoCs
> through SoC specific reset ops, which is disabled in the default MMU-500
> reset ops, but is expected for context banks using ACTLR register to
> retain the prefetch value during reset and runtime suspend.

Please refer to Documentation/process/submitting-patches.rst and
rephrase this following the rules there.

>
> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 25 ++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index 0eaf6f2a2e49..fa867b1d9d16 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -478,11 +478,28 @@ static int qcom_smmu_def_domain_type(struct device *dev)
>         return match ? IOMMU_DOMAIN_IDENTITY : 0;
>  }
>
> +static int qcom_smmu500_reset(struct arm_smmu_device *smmu)
> +{
> +       int i;
> +       u32 reg;
> +
> +       arm_mmu500_reset(smmu);
> +
> +       /* Re-enable context caching after reset */
> +       for (i = 0; i < smmu->num_context_banks; ++i) {
> +               reg = arm_smmu_cb_read(smmu, i, ARM_SMMU_CB_ACTLR);
> +               reg |= CPRE;
> +               arm_smmu_cb_write(smmu, i, ARM_SMMU_CB_ACTLR, reg);
> +       }
> +
> +       return 0;
> +}
> +
>  static int qcom_sdm845_smmu500_reset(struct arm_smmu_device *smmu)
>  {
>         int ret;
>
> -       arm_mmu500_reset(smmu);
> +       qcom_smmu500_reset(smmu);

Is this applicable for sdm845? For all other platforms supported by
qcom_smmu_500 implementation?

>
>         /*
>          * To address performance degradation in non-real time clients,
> @@ -509,7 +526,7 @@ static const struct arm_smmu_impl qcom_smmu_500_impl = {
>         .init_context = qcom_smmu_init_context,
>         .cfg_probe = qcom_smmu_cfg_probe,
>         .def_domain_type = qcom_smmu_def_domain_type,
> -       .reset = arm_mmu500_reset,
> +       .reset = qcom_smmu500_reset,
>         .write_s2cr = qcom_smmu_write_s2cr,
>         .tlb_sync = qcom_smmu_tlb_sync,
>  };
> @@ -528,7 +545,7 @@ static const struct arm_smmu_impl sm8550_smmu_500_impl = {
>         .init_context = qcom_smmu_init_context,
>         .cfg_probe = qcom_smmu_cfg_probe,
>         .def_domain_type = qcom_smmu_def_domain_type,
> -       .reset = arm_mmu500_reset,
> +       .reset = qcom_smmu500_reset,
>         .write_s2cr = qcom_smmu_write_s2cr,
>         .tlb_sync = qcom_smmu_tlb_sync,
>  };
> @@ -544,7 +561,7 @@ static const struct arm_smmu_impl qcom_adreno_smmu_v2_impl = {
>  static const struct arm_smmu_impl qcom_adreno_smmu_500_impl = {
>         .init_context = qcom_adreno_smmu_init_context,
>         .def_domain_type = qcom_smmu_def_domain_type,
> -       .reset = arm_mmu500_reset,
> +       .reset = qcom_smmu500_reset,
>         .alloc_context_bank = qcom_adreno_smmu_alloc_context_bank,
>         .write_sctlr = qcom_adreno_smmu_write_sctlr,
>         .tlb_sync = qcom_smmu_tlb_sync,
> --
> 2.17.1
>


-- 
With best wishes
Dmitry
