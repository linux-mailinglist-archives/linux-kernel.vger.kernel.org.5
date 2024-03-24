Return-Path: <linux-kernel+bounces-115436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0C9889B90
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3B571F340FE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9204A211D3F;
	Mon, 25 Mar 2024 02:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L59r0u7z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A292B1E0E2E;
	Sun, 24 Mar 2024 22:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320768; cv=none; b=jUrbJ7qJ5ub38Y+8MGlVwuXVu8hMfKIZLEbuVmdtsBHeAGhDC2XOX9FbkyiVEP4ylNqPH7YrMRPhFDPwWhKN6Yw2jhAnWgrpoO7XOP1jgKRx89488IEadMkFl0chqyQCU2IAYrjjuHsfwgGXFm+jEjRhPpZLzGfARl0Bl/wlm7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320768; c=relaxed/simple;
	bh=qfiltWF1DjBz/PYTLyHlIKycekeTw9i4OTfCTEjgtGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R8zE+8Vp+HUSSc0IBePO3LG8hdFQ82AOjc2df8MR9Peh/b0f8Q7HTwULM2zQNaJUz5DO2NiYnmYDC49FAfD7IQHCq9siPc+azTEES9zRgj8/LqCD69wVPXa2JKbYWlu0fq27M+jIWVFrJmQppf5ZOzk7iAltmhv/UW6K8xFu/WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L59r0u7z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6939FC43390;
	Sun, 24 Mar 2024 22:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320767;
	bh=qfiltWF1DjBz/PYTLyHlIKycekeTw9i4OTfCTEjgtGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L59r0u7zguT5yyHCuM1gH79xB2g2EulImJ7liYeHlQB7VjeHnC4g4WwrcjiHXbgwB
	 InY1FViwrR4kejH2XQSgHa9xKCn10vH8xdcFGGelE244m27s4Y0KY/cpY6twTI7xM+
	 iieCEW/ork/zbUtPNJwRMD2J6Zo5NrLgOtbC01/NsFtN6y5NqDOAQNWRO74QyXV6/+
	 sYcZDjzJZ7uew8veS9NkPiP5VoYBBbzx76gs9a0OqTifV+u/LXugUeM5cgXYQi7emd
	 JhpMNcmJTmbYKzNfxUNP478JvLN70k+1Wf9jOEoebXCewrNi34OagiOlow7guBAyqS
	 Hf874fgqsEVUQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Abel Vesa <abel.vesa@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 331/713] arm64: dts: qcom: sm8550: Fix SPMI channels size
Date: Sun, 24 Mar 2024 18:40:57 -0400
Message-ID: <20240324224720.1345309-332-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Abel Vesa <abel.vesa@linaro.org>

[ Upstream commit 77dd1e50ffcba33c3195ae4fc78f354368ddacb2 ]

The actual size of the channels registers region is 4MB, according to the
documentation. This issue was not caught until now because the driver was
supposed to allow same regions being mapped multiple times for supporting
multiple buses. Thie driver is using platform_get_resource_byname() and
devm_ioremap() towards that purpose, which intentionally avoids
devm_request_mem_region() altogether.

Fixes: ffc50b2d3828 ("arm64: dts: qcom: Add base SM8550 dtsi")
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD
Link: https://lore.kernel.org/r/20240221-dts-qcom-sm8550-fix-spmi-chnls-size-v2-1-72b5efd9dc4f@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index e15564ed54cef..d7e68e0f57131 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -3047,7 +3047,7 @@ sram@c3f0000 {
 		spmi_bus: spmi@c400000 {
 			compatible = "qcom,spmi-pmic-arb";
 			reg = <0 0x0c400000 0 0x3000>,
-			      <0 0x0c500000 0 0x4000000>,
+			      <0 0x0c500000 0 0x400000>,
 			      <0 0x0c440000 0 0x80000>,
 			      <0 0x0c4c0000 0 0x20000>,
 			      <0 0x0c42d000 0 0x4000>;
-- 
2.43.0


