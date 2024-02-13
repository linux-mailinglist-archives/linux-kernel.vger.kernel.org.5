Return-Path: <linux-kernel+bounces-63610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9AC853238
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB2241F26ECE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263FA5647D;
	Tue, 13 Feb 2024 13:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bSwRpVIz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9D256465;
	Tue, 13 Feb 2024 13:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707832042; cv=none; b=ScnJMz/ae5uFyBFeOxqyi+ppuwnQ/EbEyHx77iQEzQb2DVHdhv74sahqKiWzXUAy1KBBAyihtR44dnthjScIqf850aDuAUAZlsOWrhExkWeaKGMQx9qFAxEmiU2BR8lPaWYOgZAfRaBPAWgxjJPag5DEJpNNB8Dv3l8pCiWz4hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707832042; c=relaxed/simple;
	bh=0haMYFvkv9oRSevwsnTH0KPqSIE/ntXnuv7VSZm9rQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f5o+uzYVpzNSp1n/VyDIG3IO1M1fCXcPbwOhCkw6GWYPS2LqWpVoYoDPN/jT33cwLdI3IZFsQufNQQdRxTn+tB9ka1ai2No/qB1SFn4wU5MIw0Pck48+wngujdTpKi+rE9YxZ8eKWJfM1xQfQr37ydafoYifFOsOXyBP2Aipurc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bSwRpVIz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B1ABC433F1;
	Tue, 13 Feb 2024 13:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707832041;
	bh=0haMYFvkv9oRSevwsnTH0KPqSIE/ntXnuv7VSZm9rQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bSwRpVIzMPTyS4AI7y6/gI/nE+9YiP71nhDxFYlmn6wigUj+hUhRxC66t6PbYOnk6
	 /ZRmNpRLXX1Jz1KdOQpr1JvjzCNdO9GugwBL4xFSucXY6tDRfLibLgSWaJHNoGBH+x
	 3J+4VkwB2aFX0h/jGnArc2jo8HOLt+zhNRErXPDRCe6ksXkSLUSSi4yW5ZTTWsbpzD
	 SwrzomUVDgxFrwjd2QMEWpFWwBJkDk3QcWvChzjuVUymKYW92hSWSJTP05+tKVfOan
	 Lbt0XLemE0x2MNmuPzmUPEjLQv3H8eXiJq3u/wpTEibEttktym56I6q8TCBJ3yqH+D
	 7aZFzW2XPOmxQ==
Date: Tue, 13 Feb 2024 13:47:14 +0000
From: Will Deacon <will@kernel.org>
To: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
Cc: robin.murphy@arm.com, joro@8bytes.org, dmitry.baryshkov@linaro.org,
	konrad.dybcio@linaro.org, jsnitsel@redhat.com,
	quic_bjorande@quicinc.com, mani@kernel.org,
	quic_eberman@quicinc.com, robdclark@chromium.org,
	u.kleine-koenig@pengutronix.de, robh@kernel.org,
	vladimir.oltean@nxp.com, quic_pkondeti@quicinc.com,
	quic_molvera@quicinc.com, linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
	saravanak@google.com
Subject: Re: [PATCH v9 4/5] iommu/arm-smmu: add ACTLR data and support for
 SM8550
Message-ID: <20240213134714.GC28926@willie-the-truck>
References: <20240123144543.9405-1-quic_bibekkum@quicinc.com>
 <20240123144543.9405-5-quic_bibekkum@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123144543.9405-5-quic_bibekkum@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Jan 23, 2024 at 08:15:42PM +0530, Bibek Kumar Patro wrote:
> Add ACTLR data table for SM8550 along with support for
> same including SM8550 specific implementation operations.
> 
> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 90 ++++++++++++++++++++++
>  1 file changed, 90 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index 6004c6d9a7b2..db15b1eade97 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -23,6 +23,86 @@
> 
>  #define CPRE			(1 << 1)
>  #define CMTLB			(1 << 0)
> +#define PREFETCH_SHIFT		8
> +#define PREFETCH_DEFAULT	0
> +#define PREFETCH_SHALLOW	(1 << PREFETCH_SHIFT)
> +#define PREFETCH_MODERATE	(2 << PREFETCH_SHIFT)
> +#define PREFETCH_DEEP		(3 << PREFETCH_SHIFT)
> +#define PREFETCH_SWITCH_GFX	(5 << 3)
> +
> +static const struct actlr_config sm8550_apps_actlr_cfg[] = {
> +	{ 0x18a0, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
> +	{ 0x18e0, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
> +	{ 0x0800, 0x0020, PREFETCH_DEFAULT | CMTLB },
> +	{ 0x1800, 0x00c0, PREFETCH_DEFAULT | CMTLB },
> +	{ 0x1820, 0x0000, PREFETCH_DEFAULT | CMTLB },
> +	{ 0x1860, 0x0000, PREFETCH_DEFAULT | CMTLB },
> +	{ 0x0c01, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
> +	{ 0x0c02, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
> +	{ 0x0c03, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
> +	{ 0x0c04, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
> +	{ 0x0c05, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
> +	{ 0x0c06, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },

[...]

Isn't this effectively hard-coding the topology of the SoC in the driver?
Wouldn't it better describing higher-level prefetch properties in the DT
nodes corresponding to the upstream devices?

Looking back at the prior revisions of this series, it seems like others
were in favour of this approach, so if that's the general consensus, then
so be it. But is this _really_ what we want in the SMMU driver? It would
be good to have an Ack from Robin and a DT maintainer on this mechanism.

It just all feels a bit like a step back into the bad old world of
platform data to me, where we end up trying to maintain a bunch of random
constants that supposedly make things faster for somebody :/

Will

