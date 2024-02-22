Return-Path: <linux-kernel+bounces-77045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4586C86006C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D83761F25E79
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7100F158D99;
	Thu, 22 Feb 2024 18:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hmO+2am9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FFB158D83;
	Thu, 22 Feb 2024 18:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708625225; cv=none; b=iGjwotLHHPPQFSiHTV/CBpmvci1u67lI8b0EwVIwbCXa725H4EU+zgip4qy25pE34eQsd4ZXQERJCUc2d4gDXagyjbYYk5X0mkF+cfybRTofAnLuylGTCCHF33WNoWYtlpvEayqJMY77SJwT3vdPf7GQXSV4EgMzmcIfWerdmm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708625225; c=relaxed/simple;
	bh=ZtNhYpZN7rqPE9bUe0k8mpZXmH6Y6GMI25YBDA2i5Aw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pHxLDZLKDJZ8mSSZDDOc0wTTkCOFd6bOIOS9lxlSyN1dxdwxcpbcy+B9NzQjdOVLRLbtJSO+YsGe7ovSZSDYAzGF5nUXEql9tIbSKIdVvCRA8S+eGmDpwDRdb8sKI3LGNBnaGqcGjM/SLfiTyylHtF0xe+d+8PEP8oSs/ogEVMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hmO+2am9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D56E2C43390;
	Thu, 22 Feb 2024 18:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708625225;
	bh=ZtNhYpZN7rqPE9bUe0k8mpZXmH6Y6GMI25YBDA2i5Aw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hmO+2am9MHLbtPB3UvcT421hW55I4NzSmdJKNRlpbEEeFchi48eKfBYTj3XRmMBAg
	 bSBL+BphdA3zplWNs4th5WheQvwHQuEa2Rc0jZZb40+RgADhdRQMtFfhyDffSUsHBl
	 Wey+6FFHszS0p2VXI44nqQIbNjmUWSraIx0+gX6kMnnfZFSBfUmMjBXoXxIOeAbziY
	 Kq5PRC3Afd1boEMP78FK1RGbhcPzqWvwz5By3iUVW34ceq7ncanStz+PFMRgbvYhUN
	 ms9vrxkpBgCeYeI8SKTRXSf19aY3o8U1SXXuvTwaHQbmahgKjcXzzlZJ2MJS4KOk0J
	 OTK4j6x55QrjQ==
From: Will Deacon <will@kernel.org>
To: Marijn Suijten <marijn.suijten@somainline.org>,
	Maxime Ripard <mripard@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Sean Paul <sean@poorly.run>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	Rob Clark <robdclark@gmail.com>,
	David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Neil Armstrong <neil.armstrong@linaro.org>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	freedreno@lists.freedesktop.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 0/7] drm/msm: Add support for the A750 GPU found on the SM8650 platform
Date: Thu, 22 Feb 2024 18:06:25 +0000
Message-Id: <170861684323.1924954.5000298340107956205.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240216-topic-sm8650-gpu-v3-0-eb1f4b86d8d3@linaro.org>
References: <20240216-topic-sm8650-gpu-v3-0-eb1f4b86d8d3@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 16 Feb 2024 12:03:47 +0100, Neil Armstrong wrote:
> Unlike the the very close A740 GPU on the SM8550 SoC, the A750 GPU
> doesn't have an HWCFG block but a separate register set.
> 
> The missing registers are added in the a6xx.xml.h file that would
> require a subsequent sync and the non-existent hwcfg is handled
> in a6xx_set_hwcg().
> 
> [...]

Applied SMMU binding changes to will (for-joerg/arm-smmu/bindings), thanks!

[2/7] dt-bindings: arm-smmu: Fix SM8[45]50 GPU SMMU 'if' condition
      https://git.kernel.org/will/c/2777781ca9b6
[3/7] dt-bindings: arm-smmu: Document SM8650 GPU SMMU
      https://git.kernel.org/will/c/8a05f74d567a

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

