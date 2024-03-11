Return-Path: <linux-kernel+bounces-99379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E4C87878D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B622E285AC6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24FC58107;
	Mon, 11 Mar 2024 18:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gXdi7d7P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0180E5788B;
	Mon, 11 Mar 2024 18:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182207; cv=none; b=YHPub1tGiTCdRwMbxcFa5s8nmhcd1rzdeHMI6shkEMgse6t99Jyokrqx+J/8jH7nxAfw9hd+U5wl05VdE0xJ3VSqDgCDsQNe5y8PkbGhyzFLLGbW9zeZDsEthrcsvQIUZdNCFYhSyzSLP41Pkk7Jb5BptTJ2dAGeKfOHt3KzaQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182207; c=relaxed/simple;
	bh=TrTV18yl4VRw9q2qnX3Xx3k96Du1jyisaNz4ZlqRnRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZQr4DAxIQ4Q9981+z3sXvkF1snGLuDDOVxd/cRYtu0nmwRvTlAWTJp8p2oQc+RGW95J6K75KG8Ih2K72rGqFxq+vjNnYgM4CrhN114ahVSHYBINlmH8eldKizdUSN5yUswbND2fxegASaD20XYgFhajOlSfeQzUMvTm1xgeccH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gXdi7d7P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BAA4C43390;
	Mon, 11 Mar 2024 18:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710182206;
	bh=TrTV18yl4VRw9q2qnX3Xx3k96Du1jyisaNz4ZlqRnRU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gXdi7d7PiL2ZsP8LlxeRWcHq6s//+XiS3dknpwlJ1jjB0XsZ6/8UpzQ7R9ub6LILl
	 LzlotnxuTETVwPGTHpcn7HvjD3LAx41FftnF9qgvNZT5Px9V528QCI2Lf9Ibx9x7uH
	 DUHZ2l6gY59WF7ijyjDCB+zVkZrTRHPHRQ3rqTtPlTFN08PrO9/gu3cj6cBKfrL0L8
	 w4BqyjJP/WiLDm2t+C1HpncQ5S7A0h3SlBDjQhytF523fbn0srbuMRuntVYd0mdU4U
	 BtkSCD/cqq0fEgMpMsjm+cTGJ3oanQJOJsLR5OS4YXUad4zxVTm/kVqVnG+RcYTzZy
	 kgchEl9Jdzy9g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	andy.gross@linaro.org,
	david.brown@linaro.org,
	robh+dt@kernel.org,
	mark.rutland@arm.com,
	linux-arm-msm@vger.kernel.org,
	linux-soc@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 05/14] arm64: dts: qcom: sc8280xp-crd: limit pcie4 link speed
Date: Mon, 11 Mar 2024 14:36:08 -0400
Message-ID: <20240311183618.327694-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311183618.327694-1-sashal@kernel.org>
References: <20240311183618.327694-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.9
Content-Transfer-Encoding: 8bit

From: Johan Hovold <johan+linaro@kernel.org>

[ Upstream commit db8138845cebcdd0c709570b8217bd052757b8df ]

Limit the WiFi PCIe link speed to Gen2 speed (500 MB/s), which is the
speed that Windows uses.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Link: https://lore.kernel.org/r/20240223152124.20042-7-johan+linaro@kernel.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
index ffc4406422ae2..41215567b3aed 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
@@ -563,6 +563,8 @@
 };
 
 &pcie4 {
+	max-link-speed = <2>;
+
 	perst-gpios = <&tlmm 141 GPIO_ACTIVE_LOW>;
 	wake-gpios = <&tlmm 139 GPIO_ACTIVE_LOW>;
 
-- 
2.43.0


