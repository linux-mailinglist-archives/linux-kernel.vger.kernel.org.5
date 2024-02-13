Return-Path: <linux-kernel+bounces-63073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F76852A87
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D93B31F22461
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C2A179A8;
	Tue, 13 Feb 2024 08:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y1tfD3wY"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE2417995
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 08:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707811626; cv=none; b=NSmtiYoF/DSBU8MQP0HUpTJNMXSCJzeUG2Z+jVjvXSFbD6UKzhpXAJGits3YoUXM3ymPnFcWNi7L009BJRUx6mWGBUFPHplrhaor+NtDPIdc/YvCfH09wRICQdg24DbgLIKdy2i5iF+yZcFVxW+dU++iXVeLEs1dHGGeZ6ogsms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707811626; c=relaxed/simple;
	bh=TMO98LmTeFWaooCAosxSAV4g4gfDcC8Mxcbv1f1b7yQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PX+DiciJzdlKsvf7oIZWybgKbhApOjvrve3Bj29DrG6BEuGUbrw2QowF3MYm0TGjGENUYbYB3vSFfYonHZgz5YAa4cqh+ApMpP0oDFjcqEP0rP/w7eHPZKJ7CuJy06FqhBqjKziclB+yHcsIO0Skmck8eFRaD5JjBv9gW+DTGrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y1tfD3wY; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6002317a427so36430517b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 00:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707811622; x=1708416422; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LoE7SaCuCYZTXnO1AQekF/KrLmOVDpMhP6b6ysce880=;
        b=y1tfD3wY2/hrNKHO3F/fV9zQbVXvkYUIbduNATxjmH3RH7gZppYd6YnuPMmcmoK1Yo
         l44MlCxAGlfZkCmIrYw786Xm5iC2OtZYAYCc4qUJVU+oRrzVXPh2h5X7DvBeHoToIv6n
         Dg84ugm+czi7TID1wVCNLhBpXRXrrb9viHiQeWkoAciQjqSi0C24RnOCNF6mXIP0t2zN
         eUO7cL2MvYYMyY10D/dDmWwKmzcDxenqUS9MmXAuNKkBsSfszc8kthsJ0Ul9t71L5ZEf
         S0G0rBp7yh5H7yMCy2/C/GSxqHRRckj1VVYHLCayjgurKzOCLAIqB/cI+piB0QBc1A/m
         TRVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707811622; x=1708416422;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LoE7SaCuCYZTXnO1AQekF/KrLmOVDpMhP6b6ysce880=;
        b=c3a4ZBFWKgCU3OOH2XbqbTlVTSstEQHXqcthves+54ZKujlfRJ4Ndc03H6vHbIv0ss
         Q6iIksoy7Y6zlPxpbHGH/5JmHLii8Ri5fcZzVXS9FDpMFlWjSEHxmtz56MNy+9M5RTVL
         8iuD8cWYfK9Er/VJWSmqEVzzKgow1CuSFIAWadWrx7MFEncChvyqqP4dEbNKXrM56Wts
         V79X//Jc+n1XXg6shx3JtMfXV+Vl6fvmlW72CpuAXC6eostn0I2lSgZOqn3H6QraIyY1
         hUFSFMGZhdWR8p+aytd/PD+EkJ0E0QSolBiQRt8eTP/qm/cZH5hsbjIv28Ywlkzv8wtU
         hUbw==
X-Forwarded-Encrypted: i=1; AJvYcCWudV94CqtF5drkALUy7c4NbLtRfScWh/0ZhxftcshfLgLh816WpHfAQqzc8d09NvaxBi1+HSbc7GrSMHwa26vQVXHaM0EInR/dM8sp
X-Gm-Message-State: AOJu0Yz/pe5CXSmi0db20qoMwsUUe6bt7TnTeoB7zQhZIibV2whiHbwH
	31eE7d7B17axQkxxrpbTX7mAM1kFwt+VQ/vdFjtJbS+M9ufc+xPjHN6KZLBm/Xo0YTY7pm3tsTn
	chXQxBk3p6uHOIvXCt5S4cJ1NL0BXNWkdU5joNw==
X-Google-Smtp-Source: AGHT+IFJmNGwqkSI7VGiPpEbPYK61g9bG8fKHxYPKHEEFuP3n+/ab1e0w0YV5rg3cP19wA3QJhBHdbAVAxvLdL0n29I=
X-Received: by 2002:a5b:18e:0:b0:dc7:4564:fe6b with SMTP id
 r14-20020a5b018e000000b00dc74564fe6bmr6581471ybl.60.1707811621907; Tue, 13
 Feb 2024 00:07:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201210529.7728-4-quic_c_gdjako@quicinc.com> <20240213062608.13018-1-quic_pbrahma@quicinc.com>
In-Reply-To: <20240213062608.13018-1-quic_pbrahma@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 13 Feb 2024 10:06:51 +0200
Message-ID: <CAA8EJpoh-m_fzt9WcUXOkTxVZRQMDf-WrgqqoM0C_-qzjgDm1w@mail.gmail.com>
Subject: Re: [PATCH 1/1] iommu/arm-smmu-qcom: Fix use-after-free issue in qcom_smmu_create()
To: Pratyush Brahma <quic_pbrahma@quicinc.com>
Cc: quic_c_gdjako@quicinc.com, andersson@kernel.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, djakov@kernel.org, iommu@lists.linux.dev, 
	joro@8bytes.org, konrad.dybcio@linaro.org, krzysztof.kozlowski+dt@linaro.org, 
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, quic_cgoldswo@quicinc.com, 
	quic_pdaly@quicinc.com, quic_sudaraja@quicinc.com, quic_sukadev@quicinc.com, 
	robdclark@gmail.com, robh+dt@kernel.org, robin.murphy@arm.com, 
	will@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 13 Feb 2024 at 08:27, Pratyush Brahma <quic_pbrahma@quicinc.com> wrote:
>
> Currently, during arm smmu probe, struct arm_smmu_device pointer
> is allocated. The pointer is reallocated to a new struct qcom_smmu in
> qcom_smmu_create() with devm_krealloc() which frees the smmu device
> after copying the data into the new pointer.
>
> The freed pointer is then passed again in devm_of_platform_populate()
> inside qcom_smmu_create() which causes a use-after-free issue.
>
> Fix the use-after-free issue by reassigning the old pointer to
> the new pointer where the struct was copied by devm_krealloc().
>
> Signed-off-by: Pratyush Brahma <quic_pbrahma@quicinc.com>

Missing Fixes tag.

> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index ed5ed5da7740..49eaeed6a91c 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -710,6 +710,7 @@ static struct arm_smmu_device *qcom_smmu_create(struct arm_smmu_device *smmu,
>         qsmmu = devm_krealloc(smmu->dev, smmu, sizeof(*qsmmu), GFP_KERNEL);
>         if (!qsmmu)
>                 return ERR_PTR(-ENOMEM);
> +       smmu = &qsmmu->smmu;
>
>         qsmmu->smmu.impl = impl;
>         qsmmu->data = data;
> @@ -719,7 +720,7 @@ static struct arm_smmu_device *qcom_smmu_create(struct arm_smmu_device *smmu,
>         if (ret)
>                 return ERR_PTR(ret);

What is the tree that you have been developing this against? I don't
see this part of the code in the linux-next.

>
> -       return &qsmmu->smmu;
> +       return smmu;
>  }
>
>  /* Implementation Defined Register Space 0 register offsets */
> --
> 2.17.1
>
>


-- 
With best wishes
Dmitry

