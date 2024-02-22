Return-Path: <linux-kernel+bounces-77042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E85C860063
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 542AF1F224CF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B092157E78;
	Thu, 22 Feb 2024 18:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nOj4Yd1j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE62B4776E;
	Thu, 22 Feb 2024 18:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708625218; cv=none; b=T1a7wKMO0ycM/+kX/6YX6IEHKgjtE6EzueUXJUOeA/yb4vJupKijLM7ViWFGLfuap/cFoO85uo6Gd96yLM0WHlR8U+8rPjpb5E5yRxhtotGklW3olbFVp2JvT20QX56sqKgbExcqnK3TiaGn2v5VqGIJBELGfvmBiACxaZk+I/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708625218; c=relaxed/simple;
	bh=lBeRCmby1gUQMllOcKWPl1MR8+1XX3jNUKV55GgSZAs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pz1NfmJtkI6zarhZP2Aolm+SDJBLZA8u812OKxykK6j4SQxokbZqKKkVJn4k9E5BqQKAzcBPs5ZA9cJ0I00ykuAWAVAPxd5eAN5xE81f9qjKfrEYxgLAVC5sUkJAQSGkrnrreICm1Ynpuk5aLYvw65UoxGa6OnL35N2vIntvYAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nOj4Yd1j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B1C1C433C7;
	Thu, 22 Feb 2024 18:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708625218;
	bh=lBeRCmby1gUQMllOcKWPl1MR8+1XX3jNUKV55GgSZAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nOj4Yd1jSGV/rjAPstPTsYiX+lJPz6EK1NrTGv2/aKwxPtNlK3XwRyBkMo2xXsyU7
	 ZwP1xxts/KJzXw/q2GLcL0qJKGA8sqCttvVHRLDYP543X2ZKIrP5l2h+pCsMICnhMt
	 e9j9u43vWXrN1kcjmvE8GYsSaRLw2+oMCAyW5Xgcm5fJSSPBXDZdVXWgA+eyBhd8/R
	 rwFR6MgB5qq07jMnfwASdMorZ21XXlunJxKEGF0zcbNs7ZzLyA+lrHr9bP9jhjzfVR
	 c+DG0836DiJFLKJ06sWpb/3wztPPnoTAPxIwMnYk9M2p9SJrYI0wD2M8tWQm2K2AHG
	 j2KkN8BtsSSBg==
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Joerg Roedel <joro@8bytes.org>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Sean Paul <sean@poorly.run>,
	Rob Herring <robh@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Clark <robdclark@gmail.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Bjorn Andersson <andersson@kernel.org>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-kernel@vger.kernel.org,
	freedreno@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-clk@vger.kernel.org,
	Konrad Dybcio <konradybcio@kernel.org>,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 0/8] A702 support
Date: Thu, 22 Feb 2024 18:06:24 +0000
Message-Id: <170861662823.1923805.14686424405847288477.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240219-topic-rb1_gpu-v1-0-d260fa854707@linaro.org>
References: <20240219-topic-rb1_gpu-v1-0-d260fa854707@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 19 Feb 2024 14:35:45 +0100, Konrad Dybcio wrote:
> Bit of a megaseries, bunched together for your testing convenience..
> Needs mesa!27665 [1] on the userland part, kmscube happily spins.
> 
> I'm feeling quite lukewarm about the memory barriers in patch 3..
> 
> Patch 1 for Will/smmu, 5-6 for drm/msm, rest for qcom
> 
> [...]

Applied SMMU bindings patch to will (for-joerg/arm-smmu/bindings), thanks!

[1/8] dt-bindings: arm-smmu: Add QCM2290 GPU SMMU
      https://git.kernel.org/will/c/0eca305f8e0d

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

