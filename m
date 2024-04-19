Return-Path: <linux-kernel+bounces-151677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D66C8AB1ED
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 275551C21EB1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855A3130E32;
	Fri, 19 Apr 2024 15:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XkBO24We"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF3512FF77;
	Fri, 19 Apr 2024 15:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713540808; cv=none; b=coy152FtDszzn8aMgxe3p5WnmVTvrm7nrkVcnMed6nT52sXInviqAH9c8IaGRTJfP0PtQMqjK5OhOWz2NFI6X2MJdazPXVczCkZ1X3HViT2BsvoHZvFl15UlFqE0+YxPbnwClcleRdNJ7beD2xixeVjRSI/4bSwhjqX50X3GR24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713540808; c=relaxed/simple;
	bh=b45OKv6+HEEMcsjz7Ivx9yll5x9P0Hi7RFcO7Y2qEJI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rJEx1AqKWEblkY6etf7MJWkKGT67+9Pr44XNEh8FuHWaQGlwj3Q8z2saXY/bN6YW4cSrSx6dvTEEwta1gk9TSwfNga+o9VAo6sOEyk59534pS3XjgDF4ujs6MfZ7Wu/ZiN4K5M7vksnWxqq2jqvtiE70NNBVCC0wiDUB22fz4dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XkBO24We; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F71C32786;
	Fri, 19 Apr 2024 15:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713540808;
	bh=b45OKv6+HEEMcsjz7Ivx9yll5x9P0Hi7RFcO7Y2qEJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XkBO24WeB5asEHeLjx4WTk0JhenMVR/4rWsCpdwB4LKORvz+BeNaJLvYKxFpPJ0Td
	 rc/5YDKvr8iJ34ndVTumbUs8O0mGP4sNSbGojCiIgxO5drSOUDpD1S//bbMg8aWQui
	 T8fPwyffWD3omsXHpEm2XNyj9Z9nMwlXDi3bmzd2nqEQ2RpzNmy5UMCOxRILu16KUG
	 AnXPC2gkCwfpl61EjZBHdk1kI+SpmqUI9+VPvbn+9oH3Uswfr9mrvX91v02IFdenWx
	 RMRYp8Sob5t4TXosQakzq9L/nVuZFprcRg/XdVxUZsuRpB/QBkwQk4jxZcLmT+ugMn
	 1ITyKMtBGHvXA==
From: Will Deacon <will@kernel.org>
To: robin.murphy@arm.com,
	joro@8bytes.org,
	iommu@lists.linux.dev,
	Georgi Djakov <quic_c_gdjako@quicinc.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	andersson@kernel.org,
	konrad.dybcio@linaro.org,
	robdclark@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	quic_cgoldswo@quicinc.com,
	quic_sukadev@quicinc.com,
	quic_pdaly@quicinc.com,
	quic_sudaraja@quicinc.com,
	djakov@kernel.org
Subject: Re: [PATCH v8 0/7] Add support for Translation Buffer Units
Date: Fri, 19 Apr 2024 16:33:01 +0100
Message-Id: <171345168321.302978.15581758312927085763.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240417133731.2055383-1-quic_c_gdjako@quicinc.com>
References: <20240417133731.2055383-1-quic_c_gdjako@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 17 Apr 2024 06:37:24 -0700, Georgi Djakov wrote:
> The TCUs (Translation Control Units) and TBUs (Translation Buffer
> Units) are key components of the MMU-500. Multiple TBUs are connected
> to a single TCU over an interconnect. Each TBU contains a TLB that
> caches page tables. The MMU-500 implements a TBU for each connected
> master, and the TBU is designed, so that it is local to the master.
> A common TBU DT schema is added to describe the TBUs.
> 
> [...]

Applied driver and binding updates to will (for-joerg/arm-smmu/updates),
thanks!

[1/7] dt-bindings: iommu: Add Qualcomm TBU
      https://git.kernel.org/will/c/54a75d8f14c5
[2/7] iommu/arm-smmu-qcom-debug: Add support for TBUs
      https://git.kernel.org/will/c/414ecb030870
[3/7] iommu/arm-smmu: Allow using a threaded handler for context interrupts
      https://git.kernel.org/will/c/960be6e10d4f
[4/7] iommu/arm-smmu-qcom: Use a custom context fault handler for sdm845
      https://git.kernel.org/will/c/d374555ef993

[6/7] iommu/arm-smmu-qcom: Use the custom fault handler on more platforms
      https://git.kernel.org/will/c/b8ca7ce709f8

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

