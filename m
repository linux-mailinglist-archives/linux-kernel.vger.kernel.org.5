Return-Path: <linux-kernel+bounces-136669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C74889D6E4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBA8728A297
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454AA12D21F;
	Tue,  9 Apr 2024 10:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mBWiiQ6H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7BB84A56;
	Tue,  9 Apr 2024 10:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712658040; cv=none; b=lR4EEOLtRs9h7HHrqYCdjWXkdRynKcOq3BIWwcDqgqbPiF2gx6vbAcJzOF9gP/rkb4VxJ5IV1slalQlu6/ze/QYUYkAw4EsMU5TQ7JuVddIO7LI0OuC0Tlw7tNQssvftUtw8MjdFewVFAdDok11MTJQNfqBHzEx7InyOIgVAMVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712658040; c=relaxed/simple;
	bh=pzdCSbr5SHBon91syIJCTeDKf1rySdQBVpzt6jNEgQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dpmPYm+ZPOuz2Xr1e3hi7DhEbFARFCdjz2Vg6FZiBIqKvG38hYjQeBqxnRkHVEWC1dPMPVEMi0bqocay/3Jzlp/e7YOeRWNw6pJJb2bXZNTPSy7It+5PfUfpagCTNlxWFHaccUyjxGUmaokmSdPPyo9oAl4LrtUH1ulVZvOYNi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mBWiiQ6H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B258EC433B1;
	Tue,  9 Apr 2024 10:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712658040;
	bh=pzdCSbr5SHBon91syIJCTeDKf1rySdQBVpzt6jNEgQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mBWiiQ6HYjrUnXh8pi5Y+nI2VufkIDxZO/XmS5JqHzIzKKCTFyV7b+JdB1J8eljk3
	 uY8uLDeRFlIO9Mf7//GhUc8688Q2OwdPcgwwYYl28hlq8nQ41g08WfBnB6QBbxdmkH
	 3Z570Zzg4S9m8kgE+sKCOw9kk6Hp+LC3g5QVd1AfXrgITn04uJvxjMPSWhcfr2as2X
	 rYCNFvJgG3PWZrt2crQLnTvwakDXiQQT1Glsur+x5qO899l1UwfNjZiXmXq1hO6K0k
	 H/FEtUgK+F7Hh3ALnjh3eW2REylKT0rje563SEAVGjrCEA2sFNwt7ygTwY9xdN/rOq
	 +Dqbxn3Gq6Thg==
Date: Tue, 9 Apr 2024 11:20:33 +0100
From: Will Deacon <will@kernel.org>
To: Georgi Djakov <quic_c_gdjako@quicinc.com>
Cc: robin.murphy@arm.com, joro@8bytes.org, iommu@lists.linux.dev,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	andersson@kernel.org, konrad.dybcio@linaro.org, robdclark@gmail.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, quic_cgoldswo@quicinc.com,
	quic_sukadev@quicinc.com, quic_pdaly@quicinc.com,
	quic_sudaraja@quicinc.com, djakov@kernel.org
Subject: Re: [PATCH v7 2/7] iommu/arm-smmu-qcom-tbu: Add Qualcomm TBU driver
Message-ID: <20240409102033.GA22381@willie-the-truck>
References: <20240329210638.3647523-1-quic_c_gdjako@quicinc.com>
 <20240329210638.3647523-3-quic_c_gdjako@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329210638.3647523-3-quic_c_gdjako@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Mar 29, 2024 at 02:06:33PM -0700, Georgi Djakov wrote:
> Operating the TBUs (Translation Buffer Units) from Linux on Qualcomm
> platforms can help with debugging context faults. To help with that,
> the TBUs can run ATOS (Address Translation Operations) to manually
> trigger address translation of IOVA to physical address in hardware
> and provide more details when a context fault happens.
> 
> The driver will control the resources needed by the TBU to allow
> running the debug operations such as ATOS, check for outstanding
> transactions, do snapshot capture etc.
> 
> Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
> ---
>  drivers/iommu/Kconfig                         |   9 +
>  drivers/iommu/arm/arm-smmu/Makefile           |   1 +
>  .../iommu/arm/arm-smmu/arm-smmu-qcom-tbu.c    | 372 ++++++++++++++++++
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h    |   2 +
>  drivers/iommu/arm/arm-smmu/arm-smmu.h         |   2 +
>  5 files changed, 386 insertions(+)
>  create mode 100644 drivers/iommu/arm/arm-smmu/arm-smmu-qcom-tbu.c
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 0af39bbbe3a3..b699e88f42c5 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -374,6 +374,15 @@ config ARM_SMMU_QCOM
>  	  When running on a Qualcomm platform that has the custom variant
>  	  of the ARM SMMU, this needs to be built into the SMMU driver.
>  
> +config ARM_SMMU_QCOM_TBU
> +	bool "Qualcomm TBU driver"
> +	depends on ARM_SMMU_QCOM
> +	help
> +	  The SMMUs on Qualcomm platforms may include Translation Buffer
> +	  Units (TBUs) for each master. Enabling support for these units
> +	  allows to operate the TBUs and obtain additional information
> +	  when debugging memory management issues like context faults.
> +
>  config ARM_SMMU_QCOM_DEBUG

Can we just use ARM_SMMU_QCOM_DEBUG for all of this? Having both
ARM_SMMU_QCOM_DEBUG and ARM_SMMU_QCOM_TBU for the same hardware is
pretty confusing, I think.

Will

