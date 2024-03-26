Return-Path: <linux-kernel+bounces-119110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D508C88C44E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E9061C3A1E4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC8C7868B;
	Tue, 26 Mar 2024 14:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HEAw18pT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102B375806;
	Tue, 26 Mar 2024 14:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711461693; cv=none; b=mTZrJ6ZbVpbVBdKzEKyTTILtamxArQrHXYtlSyxaTFopkGNHode0ugBuW5q+S/XAKupPm7P+t3k/7/9ZGjnFJySvgF5vcVNfkKjCwBNFheCt55l4sCo0TfnPjl1v4Jr9AajgdkF2R539hUPrPUqUsdqkzk83oDneUpgEBwZY0Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711461693; c=relaxed/simple;
	bh=yz4Tw4H/56nETqXKR1UOj4GtHTZDq3JA8OzpkBRqe+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UCxbKWNm/0s1icjmlnSPAxygojWbPyt+YfIxpRtLYspzlLjgRgkgmSHJTLvAMk8GDpsG91tinCMcr6WCWGrljNQEcG60TtphYkI4M7OjU6ajRjskh5Cg6274TGtRg3pWSXUHpsLK4wAu2zAMsa5Oh4zPkI/pc0BM/6aFnV62ISA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HEAw18pT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4673C43399;
	Tue, 26 Mar 2024 14:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711461692;
	bh=yz4Tw4H/56nETqXKR1UOj4GtHTZDq3JA8OzpkBRqe+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HEAw18pTYLJaYmZyq5gRSq+pnu16Uc6Bt6e+P0nEyiQTXO2qzcq0LG+eLR2gd9Sls
	 0RUA2Np3QPYdEGdlfW4zwxwEmGe1VLGpAB51cYxW0TWkGdY11tcHfLV5eR3ozeqNLd
	 euGgktPEcr8Uq6+a195UF54987YoPj9OKI9gdJEow11I5w+op8DczisLxhSIffWXct
	 W5vMzZTzhg45bjR4sfy71xiYmyCsO7mXr0xRXcR+auJBT9QnDQoAhAgCqySoqBz1id
	 XchLCb4YUb+A8kJ1joOoXS6RvWMxMJckMygWvtnvCOwAwNVORu3d42/9T2+v98+5RF
	 tEewqYiJkS/ug==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rp7My-000000005Yr-3Rkg;
	Tue, 26 Mar 2024 15:01:40 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 2/5] arm64: dts: qcom: sa8540p: use sa8540p gpucc compatible
Date: Tue, 26 Mar 2024 15:01:05 +0100
Message-ID: <20240326140108.21307-3-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240326140108.21307-1-johan+linaro@kernel.org>
References: <20240326140108.21307-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SA8540P platform is closely related to SC8280XP but differs in that
it uses an external supply for the GX power domain.

Use the new SA8540P compatible string for the GPU clock controller so
that the OS can determine which resources to look for.

Note that a fallback SC8280XP compatible is added temporarily to avoid
any temporary regressions for sa8295p-adp.

Fixes: fd5821a1a83c ("arm64: dts: qcom: sa8540p: Drop gfx.lvl as power-domain for gpucc")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sa8540p.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8540p.dtsi b/arch/arm64/boot/dts/qcom/sa8540p.dtsi
index 23888029cc11..3b31a9ea3492 100644
--- a/arch/arm64/boot/dts/qcom/sa8540p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8540p.dtsi
@@ -168,6 +168,8 @@ opp-2592000000 {
 };
 
 &gpucc {
+	compatible = "qcom,sa8540p-gpucc", "qcom,sc8280xp-gpucc";
+
 	/* SA8295P and SA8540P doesn't provide gfx.lvl */
 	/delete-property/ power-domains;
 
-- 
2.43.0


