Return-Path: <linux-kernel+bounces-165377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 972678B8BEF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52799282129
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731AC1DFE3;
	Wed,  1 May 2024 14:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GxDlY5Y1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8096E552;
	Wed,  1 May 2024 14:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714574048; cv=none; b=NEPkJDIuCiGw6qBTvEVsKwvyNXoWLfsn6R9RBBgaCvhTS3Ms5SL4X4VViERpq6ohYf6ilf+aI1DqZ4jI8FZk9JT7rhwIVtdoqh9NhNRy4NYFKNNlef/0Bet0U1lKHo+hi9xW6Yw01R/8wBoj2ctolUNBlDXPDM/9UsiAttfaN/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714574048; c=relaxed/simple;
	bh=CWxfucLjZKMuCq9KUz1Dscdcskx00ZJ/clYJpxna/Wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f2Ra0Oj04w0Nwl0ZU/QwhEOv/l+Ww4zI9IXYIHSFBnxXrrPnSbvZnHF6mnKKhCzTHwfTeWyIDibXlH4HvQdQbWvaTmp0moSRiw9z98FWKc2WKzbAaBQZKtr1a2QBQyTBc9++i4d8ogtSJGw8kgQBNuu2zvJoVDqwY5mnJfXQLCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GxDlY5Y1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9A77C072AA;
	Wed,  1 May 2024 14:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714574048;
	bh=CWxfucLjZKMuCq9KUz1Dscdcskx00ZJ/clYJpxna/Wk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GxDlY5Y1ypPthIpoAtKyaQd/ZBIcHSLBpr/2xmEoAGoXygcPxqr51/dxE+AgvpT2h
	 desQDC+pv+ZldTvWod9pExwhM7IjD3Ryup55foKD4EKmtLb8ayHlP63eor321wLfBP
	 YjsWuCPgsTYztYTBA7ydpIf/E5DarzDgWJJ3SuCxbZW5zJVHgr6OZ+8WhH1wQwyGP3
	 XmKLUcYlcfl+ug5TyoX62OvbbrHC80zfCVYaPQrN5FWht2SPjZSTIL/w7cbJ6Oy9zQ
	 z6kp4yP27xuZlcSId5Jg1Q9ow/Wm6lV8ldyR7ZLFrftpmVVbJiaJKi9LsKawzZkABE
	 dafvfUzoG6ihQ==
Date: Wed, 1 May 2024 15:34:01 +0100
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
Subject: Re: [PATCH v8 2/7] iommu/arm-smmu-qcom-debug: Add support for TBUs
Message-ID: <20240501143400.GA15503@willie-the-truck>
References: <20240417133731.2055383-1-quic_c_gdjako@quicinc.com>
 <20240417133731.2055383-3-quic_c_gdjako@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417133731.2055383-3-quic_c_gdjako@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Georgi,

On Wed, Apr 17, 2024 at 06:37:26AM -0700, Georgi Djakov wrote:
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c
> index bb89d49adf8d..eff7ca94ec8d 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c

..

> +static const struct of_device_id qcom_tbu_of_match[] = {
> +	{ .compatible = "qcom,sc7280-tbu" },
> +	{ .compatible = "qcom,sdm845-tbu" },
> +	{ }
> +};
> +
> +static struct platform_driver qcom_tbu_driver = {
> +	.driver = {
> +		.name           = "qcom_tbu",
> +		.of_match_table = qcom_tbu_of_match,
> +	},
> +	.probe = qcom_tbu_probe,
> +};
> +builtin_platform_driver(qcom_tbu_driver);

I just noticed that this breaks a modular build of the arm-smmu driver
because we now have two init functions for the module:

  ld.lld: error: duplicate symbol: init_module
  >>> defined at arm-smmu.c
  >>>            drivers/iommu/arm/arm-smmu/arm-smmu.o:(init_module)
  >>> defined at arm-smmu-qcom-debug.c
  >>>            drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.o:(.init.text+0x4)

I think you should initialise the TBU debug feature by calling into it
manually from qcom_smmu_impl_init().

Please can you send a patch to fix that? For now, I'll bodge it so that
the qcom debug stuff doesn't build as a module (see below).

Cheers,

Will

--->8

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 032bfd681307..66325210c8c9 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -376,7 +376,7 @@ config ARM_SMMU_QCOM

 config ARM_SMMU_QCOM_DEBUG
        bool "ARM SMMU QCOM implementation defined debug support"
-       depends on ARM_SMMU_QCOM
+       depends on ARM_SMMU_QCOM=y
        help
          Support for implementation specific debug features in ARM SMMU
          hardware found in QTI platforms. This include support for


