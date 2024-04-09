Return-Path: <linux-kernel+bounces-137206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 064C389DED8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AF6A1F2DDDF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98BF13C91E;
	Tue,  9 Apr 2024 15:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IpCEai/2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60B21304BD;
	Tue,  9 Apr 2024 15:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712676022; cv=none; b=Cfv4tN1F0UWgG+VAi3CPKoem/hMjrr+Suuc/IQH0ZaWD8WkW08M283ctAKTdmILUlB1JCswRpGCm/I3PZl0bLA0lE6AzjUyb8YEVDleKPjxrU/CAQ+id7ASCaq1p8G2npGEElKvZK1E4t3tmm1pTUsocgnsnzvt9RgqvoJaan9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712676022; c=relaxed/simple;
	bh=5CN7dOESEqY5NFZ2NkWwwZQ2DPE7LvMfCTVXJeBUg78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gyEvujX54Bq1XOpTEh3xPP7qABsI4tD+JVncWHlvePoosi7pmTLy4inS038/Py6Glll6glXWBQwsF8T8AchtRLiaI8brSgxKZnuNLwzd5e0Y6tttPBkDgb1DhgIohJ/xvZwDDXZH8fGRD5xSy7vKtGzTHu0/xIFYswANfxkjmyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IpCEai/2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 244FFC433F1;
	Tue,  9 Apr 2024 15:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712676021;
	bh=5CN7dOESEqY5NFZ2NkWwwZQ2DPE7LvMfCTVXJeBUg78=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IpCEai/2qT1dqTJnbR5RaNaTQj2UveN8s0UCqnjKYuhGKheRfWNXESwtd+1E8sggb
	 3zANjTgXc9v4QtKhrDUePQrrNAb1uD8OtQ3PuSH8kx+ONkv2d5PVqC4Edz/vjYPQO+
	 w+Ad5u0kL19wLiGA229RywQ/Uhlh+kh8Sx2iFOKUjRcRPi5F9xONk7EUKYDv1GC+a5
	 WG9qt48qaanoDAc62QXMZUfBIdPt56gUfCgzPJgkfd1uBnJ8eAxeSNcHQmH7rXmYLC
	 kaDRHrKF4xDHrIQQom7FNb/SdJyUqT+XXnN6F+HhpKdYT8GgYIHGUsqa3WPweEgrOV
	 LBebg8UUveFUA==
Date: Tue, 9 Apr 2024 10:20:18 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/6] soc: qcom: smem: Add pcode/fcode getters
Message-ID: <oq2g3vilhzu4comajkzk3hbx2ycocxbqc57q7zunpx4p37mafk@sglx5mb6dpdf>
References: <20240405-topic-smem_speedbin-v1-0-ce2b864251b1@linaro.org>
 <20240405-topic-smem_speedbin-v1-2-ce2b864251b1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405-topic-smem_speedbin-v1-2-ce2b864251b1@linaro.org>

On Fri, Apr 05, 2024 at 10:41:30AM +0200, Konrad Dybcio wrote:
> Introduce getters for SoC product and feature codes and export them.
> 

Thought I commented on this already, but I don't see my reply...

Can you please elaborate on what this stuff is, such that we have a
track record in the history of this driver as well, for those of us that
don't know what "feature/product codes" contain or are good for (or have
forgotten next week).

Regards,
Bjorn

> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/soc/qcom/smem.c       | 66 +++++++++++++++++++++++++++++++++++++++++++
>  include/linux/soc/qcom/smem.h |  2 ++
>  2 files changed, 68 insertions(+)
> 
> diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
> index 7191fa0c087f..e89b4d26877a 100644
> --- a/drivers/soc/qcom/smem.c
> +++ b/drivers/soc/qcom/smem.c
> @@ -795,6 +795,72 @@ int qcom_smem_get_soc_id(u32 *id)
>  }
>  EXPORT_SYMBOL_GPL(qcom_smem_get_soc_id);
>  
> +/**
> + * qcom_smem_get_feature_code() - return the feature code
> + * @id:	On success, we return the feature code here.
> + *
> + * Look up the feature code identifier from SMEM and return it.
> + *
> + * Return: 0 on success, negative errno on failure.
> + */
> +int qcom_smem_get_feature_code(u32 *code)
> +{
> +	struct socinfo *info;
> +	u32 raw_code;
> +
> +	info = qcom_smem_get(QCOM_SMEM_HOST_ANY, SMEM_HW_SW_BUILD_ID, NULL);
> +	if (IS_ERR(info))
> +		return PTR_ERR(info);
> +
> +	/* This only makes sense for socinfo >= 16 */
> +	if (__le32_to_cpu(info->fmt) < SOCINFO_VERSION(0, 16))
> +		return -EINVAL;
> +
> +	raw_code = __le32_to_cpu(info->feature_code);
> +
> +	/* Ensure the value makes sense */
> +	if (raw_code >= SOCINFO_FC_INT_RESERVE)
> +		raw_code = SOCINFO_FC_UNKNOWN;
> +
> +	*code = raw_code;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(qcom_smem_get_feature_code);
> +
> +/**
> + * qcom_smem_get_product_code() - return the product code
> + * @id:	On success, we return the product code here.
> + *
> + * Look up feature code identifier from SMEM and return it.
> + *
> + * Return: 0 on success, negative errno on failure.
> + */
> +int qcom_smem_get_product_code(u32 *code)
> +{
> +	struct socinfo *info;
> +	u32 raw_code;
> +
> +	info = qcom_smem_get(QCOM_SMEM_HOST_ANY, SMEM_HW_SW_BUILD_ID, NULL);
> +	if (IS_ERR(info))
> +		return PTR_ERR(info);
> +
> +	/* This only makes sense for socinfo >= 16 */
> +	if (__le32_to_cpu(info->fmt) < SOCINFO_VERSION(0, 16))
> +		return -EINVAL;
> +
> +	raw_code = __le32_to_cpu(info->pcode);
> +
> +	/* Ensure the value makes sense */
> +	if (raw_code >= SOCINFO_FC_INT_RESERVE)
> +		raw_code = SOCINFO_FC_UNKNOWN;
> +
> +	*code = raw_code;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(qcom_smem_get_product_code);
> +
>  static int qcom_smem_get_sbl_version(struct qcom_smem *smem)
>  {
>  	struct smem_header *header;
> diff --git a/include/linux/soc/qcom/smem.h b/include/linux/soc/qcom/smem.h
> index a36a3b9d4929..aef8c9fc6c08 100644
> --- a/include/linux/soc/qcom/smem.h
> +++ b/include/linux/soc/qcom/smem.h
> @@ -13,5 +13,7 @@ int qcom_smem_get_free_space(unsigned host);
>  phys_addr_t qcom_smem_virt_to_phys(void *p);
>  
>  int qcom_smem_get_soc_id(u32 *id);
> +int qcom_smem_get_feature_code(u32 *code);
> +int qcom_smem_get_product_code(u32 *code);
>  
>  #endif
> 
> -- 
> 2.40.1
> 

