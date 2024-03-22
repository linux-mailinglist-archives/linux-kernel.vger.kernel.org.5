Return-Path: <linux-kernel+bounces-111749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFE088705D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1907C284487
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C3857876;
	Fri, 22 Mar 2024 16:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NY1UovC2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2513F9FE;
	Fri, 22 Mar 2024 16:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711123709; cv=none; b=ByUzsH3wdXyGiE2t5cGmWhtQ9Jc+5r1NmAifIkyfc2KrgxAfkgmfM2BRKv/ZS19dUawuhmJqFmD7CsvsvzcHFxORIFhg8XznjQWu7gfErNBplkUvFij3Kz5rHw3NNdNvwoELjzrXZOQ9n+Qvhdugoh07fXYy3IOT8qoofCWhszE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711123709; c=relaxed/simple;
	bh=bXA2mHbCtGGlTTTDyyu+fASvyS/0DESgskmYDPSjP3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pjmqrbbI+VzPsVLcrR4oJvumWZZSp+FUm3VEkXsl9wbGaf+dcvqkB3Va47JWiFxHwFY7Aiq5s7ZJUXqabOB+KKBkYesi03TH8zfTOomjCjZThWob9W/zVrgtIaWVrl73uHaTI4aQLYaWL2u3mfy0E7z54s56ovcoHNWJpFx2fWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NY1UovC2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 010A8C433F1;
	Fri, 22 Mar 2024 16:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711123709;
	bh=bXA2mHbCtGGlTTTDyyu+fASvyS/0DESgskmYDPSjP3g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NY1UovC2N8ZgBi6I91h5VbIGAIVOhY6OV5XRTKcHbi1wadkhuCCjT5pG7pRTrl78n
	 dtBy7NRiqKKC5jJjiaTPFvqj2quyjW3e/uurmEbpfUZol6CWKg/CSg4O8Lmo8MebZN
	 EYohdTBXj1aLRL4iIHxMpX/z+q1wN1gEhYwz5p2SusghG1mqNkQPyFxvzncGlpnVcA
	 WIimKfepgyslqQL/Pt3+UL7T9pJkrGE30BCRnZsEB08v6SxJjbJqebaPOQ9/DVhfye
	 4ABJVhOd82DN02sL1RN81oPHDxf5NQr+vM8U15wubQ25JyzRFy+nDggrV8jrpHgz9I
	 J0ewnVMswKlmg==
Date: Fri, 22 Mar 2024 17:08:22 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH 01/11] PCI: qcom-ep: Disable resources unconditionally
 during PERST# assert
Message-ID: <Zf2s9kTMlZncldWx@ryzen>
References: <20240314-pci-epf-rework-v1-0-6134e6c1d491@linaro.org>
 <20240314-pci-epf-rework-v1-1-6134e6c1d491@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314-pci-epf-rework-v1-1-6134e6c1d491@linaro.org>

On Thu, Mar 14, 2024 at 08:53:40PM +0530, Manivannan Sadhasivam wrote:
> All EP specific resources are enabled during PERST# deassert. As a counter
> operation, all resources should be disabled during PERST# assert. There is
> no point in skipping that if the link was not enabled.
> 
> This will also result in enablement of the resources twice if PERST# got
> deasserted again. So remove the check from qcom_pcie_perst_assert() and
> disable all the resources unconditionally.
> 
> Fixes: f55fee56a631 ("PCI: qcom-ep: Add Qualcomm PCIe Endpoint controller driver")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom-ep.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> index 2fb8c15e7a91..50b1635e3cbb 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> @@ -500,12 +500,6 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
>  static void qcom_pcie_perst_assert(struct dw_pcie *pci)
>  {
>  	struct qcom_pcie_ep *pcie_ep = to_pcie_ep(pci);
> -	struct device *dev = pci->dev;
> -
> -	if (pcie_ep->link_status == QCOM_PCIE_EP_LINK_DISABLED) {
> -		dev_dbg(dev, "Link is already disabled\n");
> -		return;
> -	}
>  
>  	dw_pcie_ep_cleanup(&pci->ep);
>  	qcom_pcie_disable_resources(pcie_ep);

Are you really sure that this is safe?

I think I remember seeing some splat in dmesg if some clks, or maybe it
was regulators, got disabled while already being disabled.

Perhaps you could test it by simply calling:
qcom_pcie_disable_resources();
twice here, and see if you see and splat in dmesg.


Kind regards,
Niklas

