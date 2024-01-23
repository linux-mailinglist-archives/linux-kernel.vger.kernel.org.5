Return-Path: <linux-kernel+bounces-35441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB59283912F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 646C31F244B3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B29A5FB8B;
	Tue, 23 Jan 2024 14:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bd0JGNtn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C50E5DF0E;
	Tue, 23 Jan 2024 14:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706019648; cv=none; b=Nt3gshMQ2idW1+CC3aZkZqDx/9Mts8HLo3+z5NELxQRVllCDliHXPMcjfcLHxEHmfasOWfFUxrOL9blIsImLdrI6XvXOI0tZ72a9es42VTTcJgTPSm74YVTZIzZWDNjsUALtzAkVXFvaAxM1KG/CU7ABNnPoSknuIWkBkIJVD/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706019648; c=relaxed/simple;
	bh=JfMOziD33YQXKM5eSTRAheY0W73PRQugEPem6NQck3w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bjkaaohkzX8dbFmD1ZXiWqRxHvfWHUPMH85LUpM+y0cpbqCX/Eyq+QHDMvGO8gfROE5nJgJWRb0fUzeUcw03i9WvDQ2Im0Q9oi03rQymUEXOzlXlP/7jMfnwhjZNvOhI7di6Z1Hu4a4VU33skAmVTLwDipzmsDbYMKbCRVsCSE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bd0JGNtn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 364C1C433A6;
	Tue, 23 Jan 2024 14:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706019648;
	bh=JfMOziD33YQXKM5eSTRAheY0W73PRQugEPem6NQck3w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=bd0JGNtnUeJB5K87umzGFU1gzvLsWx7U8m680hRmhl5JBMCWnhM7R/7fW2ortE9kb
	 0k8txzBnNqMx6pZfyqBXW0ZRveDQJ7BIR7eTVKzoh73IcaUvWGBMsdf+FQyXjHUU69
	 cxNT/bAo6KBFpvSheJRbE2INgIobJ7bT7S5jJIy6DF9UAK5d4oDdt7OheesgCRhDKr
	 7Fv6oojcc6+rVFigWBZFjvonn91piMEl44U3C5GgDTywi/aha0YKGY0USjxAjtbZMD
	 wetn/Yqzb6fDL1KxS6O1x3HNalvgEpEUNmMGmpLUglmYFTEf8edTm/kckY1OUsnqTo
	 dLKqfQWPMEoeg==
From: Vinod Koul <vkoul@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, 
 Bart Van Assche <bvanassche@acm.org>, Andy Gross <agross@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 cros-qcom-dts-watchers@chromium.org, David Wronek <davidwronek@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-scsi@vger.kernel.org, linux-phy@lists.infradead.org, 
 ~postmarketos/upstreaming@lists.sr.ht, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Joe Mason <buddyjojo06@outlook.com>
In-Reply-To: <20240121-sm7125-upstream-v4-0-f7d1212c8ebb@gmail.com>
References: <20240121-sm7125-upstream-v4-0-f7d1212c8ebb@gmail.com>
Subject: Re: (subset) [PATCH v4 0/8] Add UFS support for SC7180/SM7125
Message-Id: <170601964084.371263.15660253192211463921.b4-ty@kernel.org>
Date: Tue, 23 Jan 2024 19:50:40 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Sun, 21 Jan 2024 17:57:40 +0100, David Wronek wrote:
> This patchset introduces UFS support for SC7180 and SM7125, as well as
> support for the Xiaomi Redmi Note 9S.
> 
> To: Bjorn Andersson <andersson@kernel.org>
> To: Konrad Dybcio <konrad.dybcio@linaro.org>
> To: Herbert Xu <herbert@gondor.apana.org.au>
> To: David S. Miller <davem@davemloft.net>
> To: Rob Herring <robh+dt@kernel.org>
> To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> To: Conor Dooley <conor+dt@kernel.org>
> To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> To: Alim Akhtar <alim.akhtar@samsung.com>
> To: Avri Altman <avri.altman@wdc.com>
> To: Bart Van Assche <bvanassche@acm.org>
> To: Andy Gross <agross@kernel.org>
> To: Vinod Koul <vkoul@kernel.org>
> To: Kishon Vijay Abraham I <kishon@kernel.org>
> To:  <cros-qcom-dts-watchers@chromium.org>
> Cc:  <linux-arm-msm@vger.kernel.org>
> Cc:  <linux-crypto@vger.kernel.org>
> Cc:  <devicetree@vger.kernel.org>
> Cc:  <linux-kernel@vger.kernel.org>
> Cc:  <linux-scsi@vger.kernel.org>
> Cc:  <linux-phy@lists.infradead.org>
> CC:  <~postmarketos/upstreaming@lists.sr.ht>
> 
> [...]

Applied, thanks!

[3/8] dt-bindings: phy: Add QMP UFS PHY compatible for SC7180
      commit: 1cf2bf8ffadf2f0ab9ad10a1e0f65b3a0a10d402
[5/8] phy: qcom: qmp-ufs: Add SC7180 support
      commit: 7551d945cb9ad8e8cfa4888c6b7be19855754baf

Best regards,
-- 
~Vinod



