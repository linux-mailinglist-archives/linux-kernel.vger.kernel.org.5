Return-Path: <linux-kernel+bounces-133784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6570F89A8A2
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 05:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 786F42812C8
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 03:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB0A179AE;
	Sat,  6 Apr 2024 03:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F3heiz5A"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39E614273
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 03:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712373822; cv=none; b=QXyTa4JeNpU6HtIF5hT5kA3mf87AneOU1QJI+crockAgBNnJ42MoGgot3yzlgufQPws9zJRbwtd5INfH21UPSZ5pTqbMHc8ccIkuJdssI64kBaYDNtdyN3aX6ara/m84cuc+9thBKsw7llJOj7fGhhRuw3rdttwd1ZqXTorBKvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712373822; c=relaxed/simple;
	bh=qNr3cxZaaRKvS35D5tSEN7XYCbn71PlNi1XD5sm24jE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TunkbHuUru80dQYBep7DKB7qd4fmgo0XGS+eFeSt7xUSeL3Gp7d26S4oGQCzHhb7op2fsshsaYg/PU6Y09TVn06oquZ6ermeDG7GOhsQjtNBfusBqPQmORM74XEe+LNryhY2HElTEXc4fWvtgZdrYsUPuyrnI7X21hvefSTmaPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F3heiz5A; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d476d7972aso36109131fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 20:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712373819; x=1712978619; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9UUjkB/gspbJc6rWQEtn8QgHPmoLmxjTAN2ZpK5QagM=;
        b=F3heiz5APcLe/Wlr4I6iN0k2NszMLly5utvcAS/Tfk2srOFo9854Ob5qxTZPhYY7xt
         1mjJ5fOFNxuwqiziG+rvN4Pz9gQnR4AQND8nljUETV67Bk2QGoiRpTEC5PKX9yVzkKv8
         PNIFDC6mn8kE8VlRhiqgoK4WU2zn1/XXYppjrOR9X7Zjq5kkiFkN+iglF5gC16+WHz3h
         OkY3DH/if3oBR0UldRI2a3UKP2ToOiIc03+FitZu6Axhts8AGAp1D+Gqj+Kd072drtDD
         4uISCtj6GY+RmU92N6kYEISy+g5VNqaZiar+SvXK6Ugi5tJutpBFK0MTK8ChHLkCGoBx
         Su8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712373819; x=1712978619;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9UUjkB/gspbJc6rWQEtn8QgHPmoLmxjTAN2ZpK5QagM=;
        b=vdL0j5fCUASPRF6P4uXw9V31iszpBh3KSQdLkGrf5m6T8x5ov9VTYQQeouxySjdbLK
         ZqXRYvZEWXzrlgdAJLgnXf9RuKD/9rseKM39Q66l9GlBo+HBmLNRi6A67kAQZzmn1zzD
         o4qPOxCvnGSyBGk//YSZQIr//Y7bR4LwbhVd07j2y6VRkFHaWRZPpXEPta1Ni+CL6Yu6
         4PlGJabpL7NnDJk0Qz15dHO8Ff/FNPQ7WTgicpuLAcf2VaxNrzfWofMRw66s8b0pUpx/
         Fhxmb7dCGZZn5aYOgSTiOtMeYPvoaW5ZQnkcPwe/OcQN8WPM5Xw+2q3PWDXIifdvH75f
         4dfw==
X-Forwarded-Encrypted: i=1; AJvYcCXGo+x3zuZuNbiMNjoWQYA+Efi8C3I55hFJMhOuojihUtSA5stPy4roac3nJZs6N4+uv2eR1862A0vZpj2/GtF2AyaX5yBcevAtu3As
X-Gm-Message-State: AOJu0YwTemKZE+E6yiwqxa7Gimk7K112Erq59eMQX8aGoWDUF7XvJp5J
	U1Z6vavXBnZhKGg9x3eHmLmoadgqd6tyETF5FUgwfogu1WwmQogIO1ilrKyhY3o=
X-Google-Smtp-Source: AGHT+IHGgh+sXqF4BgwLXDjYK1OYySKW/T+gk11wHECQNHX1CWzB4PV5ZUb3WKLXxZRxZQ8EV9r5mQ==
X-Received: by 2002:a05:6512:44b:b0:513:cf5e:f2ad with SMTP id y11-20020a056512044b00b00513cf5ef2admr2506909lfk.60.1712373818728;
        Fri, 05 Apr 2024 20:23:38 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzyjmhyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a00e:a300::227])
        by smtp.gmail.com with ESMTPSA id b21-20020ac24115000000b00513c253696csm359141lfi.187.2024.04.05.20.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 20:23:38 -0700 (PDT)
Date: Sat, 6 Apr 2024 06:23:36 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 4/6] drm/msm/adreno: Implement SMEM-based speed bin
Message-ID: <scvwfj44z3wpp7phvesfwjuv5awtlkwby2vvrpaq4i5fircrt3@i3ebya4iymf3>
References: <20240405-topic-smem_speedbin-v1-0-ce2b864251b1@linaro.org>
 <20240405-topic-smem_speedbin-v1-4-ce2b864251b1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405-topic-smem_speedbin-v1-4-ce2b864251b1@linaro.org>

On Fri, Apr 05, 2024 at 10:41:32AM +0200, Konrad Dybcio wrote:
> On recent (SM8550+) Snapdragon platforms, the GPU speed bin data is
> abstracted through SMEM, instead of being directly available in a fuse.
> 
> Add support for SMEM-based speed binning, which includes getting
> "feature code" and "product code" from said source and parsing them
> to form something that lets us match OPPs against.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c      |  8 +++---
>  drivers/gpu/drm/msm/adreno/adreno_device.c |  2 ++
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c    | 39 +++++++++++++++++++++++++++---
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h    | 12 ++++++---
>  4 files changed, 51 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index 4cbdfabbcee5..6776fd80f7a6 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -2890,13 +2890,15 @@ static u32 fuse_to_supp_hw(const struct adreno_info *info, u32 fuse)
>  	return UINT_MAX;
>  }
>  
> -static int a6xx_set_supported_hw(struct device *dev, const struct adreno_info *info)
> +static int a6xx_set_supported_hw(struct adreno_gpu *adreno_gpu,
> +				 struct device *dev,
> +				 const struct adreno_info *info)
>  {
>  	u32 supp_hw;
>  	u32 speedbin;
>  	int ret;
>  
> -	ret = adreno_read_speedbin(dev, &speedbin);
> +	ret = adreno_read_speedbin(adreno_gpu, dev, &speedbin);
>  	/*
>  	 * -ENOENT means that the platform doesn't support speedbin which is
>  	 * fine
> @@ -3056,7 +3058,7 @@ struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
>  
>  	a6xx_llc_slices_init(pdev, a6xx_gpu, is_a7xx);
>  
> -	ret = a6xx_set_supported_hw(&pdev->dev, config->info);
> +	ret = a6xx_set_supported_hw(adreno_gpu, &pdev->dev, config->info);
>  	if (ret) {
>  		a6xx_destroy(&(a6xx_gpu->base.base));
>  		return ERR_PTR(ret);
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
> index c3703a51287b..901ef767e491 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
> @@ -6,6 +6,8 @@
>   * Copyright (c) 2014,2017 The Linux Foundation. All rights reserved.
>   */
>  
> +#include <linux/soc/qcom/socinfo.h>
> +
>  #include "adreno_gpu.h"
>  
>  bool hang_debug = false;
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> index 074fb498706f..0e4ff532ac3c 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> @@ -21,6 +21,9 @@
>  #include "msm_gem.h"
>  #include "msm_mmu.h"
>  
> +#include <linux/soc/qcom/smem.h>
> +#include <linux/soc/qcom/socinfo.h>
> +
>  static u64 address_space_size = 0;
>  MODULE_PARM_DESC(address_space_size, "Override for size of processes private GPU address space");
>  module_param(address_space_size, ullong, 0600);
> @@ -1057,9 +1060,37 @@ void adreno_gpu_ocmem_cleanup(struct adreno_ocmem *adreno_ocmem)
>  			   adreno_ocmem->hdl);
>  }
>  
> -int adreno_read_speedbin(struct device *dev, u32 *speedbin)
> +int adreno_read_speedbin(struct adreno_gpu *adreno_gpu,
> +			 struct device *dev, u32 *speedbin)
>  {
> -	return nvmem_cell_read_variable_le_u32(dev, "speed_bin", speedbin);
> +	u32 fcode, pcode;
> +	int ret;
> +
> +	/* Try reading the speedbin via a nvmem cell first */
> +	ret = nvmem_cell_read_variable_le_u32(dev, "speed_bin", speedbin);
> +	if (!ret && ret != -EINVAL)

This is always false.

> +		return ret;
> +
> +	ret = qcom_smem_get_feature_code(&fcode);
> +	if (ret) {
> +		dev_err(dev, "Couldn't get feature code from SMEM!\n");
> +		return ret;

This brings in QCOM_SMEM dependency (which is not mentioned in the
Kconfig). Please keep iMX5 hardware in mind, so the dependency should be
optional. Respective functions should be stubbed in the header.

> +	}
> +
> +	ret = qcom_smem_get_product_code(&pcode);
> +	if (ret) {
> +		dev_err(dev, "Couldn't get product code from SMEM!\n");
> +		return ret;
> +	}
> +
> +	/* Don't consider fcode for external feature codes */
> +	if (fcode <= SOCINFO_FC_EXT_RESERVE)
> +		fcode = SOCINFO_FC_UNKNOWN;
> +
> +	*speedbin = FIELD_PREP(ADRENO_SKU_ID_PCODE, pcode) |
> +		    FIELD_PREP(ADRENO_SKU_ID_FCODE, fcode);

What about just asking the qcom_smem for the 'gpu_bin' and hiding gory
details there? It almost feels that handling raw PCODE / FCODE here is
too low-level and a subject to change depending on the socinfo format.

> +
> +	return ret;
>  }
>  
>  int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
> @@ -1098,9 +1129,9 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
>  			devm_pm_opp_set_clkname(dev, "core");
>  	}
>  
> -	if (adreno_read_speedbin(dev, &speedbin) || !speedbin)
> +	if (adreno_read_speedbin(adreno_gpu, dev, &speedbin) || !speedbin)
>  		speedbin = 0xffff;
> -	adreno_gpu->speedbin = (uint16_t) (0xffff & speedbin);

the &= 0xffff should probably go to the adreno_read_speedbin / nvmem
case. WDYT?

> +	adreno_gpu->speedbin = speedbin;
>  
>  	gpu_name = devm_kasprintf(dev, GFP_KERNEL, "%"ADRENO_CHIPID_FMT,
>  			ADRENO_CHIPID_ARGS(config->chip_id));
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> index 460b399be37b..1770a9e20484 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> @@ -81,7 +81,12 @@ extern const struct adreno_reglist a612_hwcg[], a615_hwcg[], a630_hwcg[], a640_h
>  extern const struct adreno_reglist a660_hwcg[], a690_hwcg[], a702_hwcg[], a730_hwcg[], a740_hwcg[];
>  
>  struct adreno_speedbin {
> -	uint16_t fuse;
> +	/* <= 16-bit for NVMEM fuses, 32b for SOCID values */
> +	uint32_t fuse;
> +#define ADRENO_SKU_ID_PCODE		GENMASK(31, 16)
> +#define ADRENO_SKU_ID_FCODE		GENMASK(15, 0)
> +#define ADRENO_SKU_ID(pcode, fcode)	(pcode << 16 | fcode)
> +
>  	uint16_t speedbin;
>  };
>  
> @@ -137,7 +142,7 @@ struct adreno_gpu {
>  	struct msm_gpu base;
>  	const struct adreno_info *info;
>  	uint32_t chip_id;
> -	uint16_t speedbin;
> +	uint32_t speedbin;
>  	const struct adreno_gpu_funcs *funcs;
>  
>  	/* interesting register offsets to dump: */
> @@ -520,7 +525,8 @@ int adreno_fault_handler(struct msm_gpu *gpu, unsigned long iova, int flags,
>  			 struct adreno_smmu_fault_info *info, const char *block,
>  			 u32 scratch[4]);
>  
> -int adreno_read_speedbin(struct device *dev, u32 *speedbin);
> +int adreno_read_speedbin(struct adreno_gpu *adreno_gpu,
> +			 struct device *dev, u32 *speedbin);
>  
>  /*
>   * For a5xx and a6xx targets load the zap shader that is used to pull the GPU
> 
> -- 
> 2.40.1
> 

-- 
With best wishes
Dmitry

