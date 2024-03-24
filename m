Return-Path: <linux-kernel+bounces-112963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD701888018
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66A7D28127C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC321272B8;
	Sun, 24 Mar 2024 22:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=kernel.org header.i=@kernel.org header.b="tYPer1z9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2E5127B7E;
	Sun, 24 Mar 2024 22:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319775; cv=none; b=MAMVUV1cDTEF1jltObZj2N0WIguzo23nph0dZUEqmfDyw90wDOyZb7BP2/f03N32049dT7MbokhpwgVDOrLgIu43tggmcMb7gh9Vg61xchsDDWZW9mOEiWG9uNfedJGrIdjzqU5+qUxsUpG3nr+DIo03bdrtE9tkwjqsKFQAivU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319775; c=relaxed/simple;
	bh=Xck2m66cI9zOAz8cKRalWaRFNWvUQtCxJHs6BRohMG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PozElwhd9zLJAlaebO9rwmQ82q8o3K0Mae8By/YApOWqhKHxlmAVh2YuAMAT+IDPykuM1urAQZ+qzG1aXoB0tLViAasJQbBaERXSkAoFdQSnuTkv+ZCeNwU3aQgX/iS0FdEmWR20ch+ZMjCX2HyyQuXbS8q0if7nZhnfrCeqjLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tYPer1z9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49234C433B2;
	Sun, 24 Mar 2024 22:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319774;
	bh=Xck2m66cI9zOAz8cKRalWaRFNWvUQtCxJHs6BRohMG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tYPer1z9Nb9w6QW6AL/uOSRjI9lO2T55iinMiHId/afWlseCb6J+81fpv3vakIaLB
	 uKFcrU6LBBCqtbyV+0y0y25QkDKMkq9wrefT7FhhSteJTc+CF8yQtPeOvozP9E2RgO
	 FOxBowhobcP4NyimsxapuLOYstFkf86+JNxkflIawti+xfyD8Fx0Kc4NWK7xpK8kAv
	 kq3/AL2+Y4i+/rir7gQc69+PqfyYvAQxMexO9nss7rZSCPs3sw3ybHaxoGc5NlFHsb
	 MEMyx/Kx0+xh4dtP7jeabieKMs4vpMITSiRQA2xR6L74INcM3KO+jyG0K8FUyyrU9M
	 KU/TV4yOkYVVA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 076/715] arm64: dts: qcom: sc8180x: Require LOW_SVS vote for MMCX if DISPCC is on
Date: Sun, 24 Mar 2024 18:24:15 -0400
Message-ID: <20240324223455.1342824-77-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Konrad Dybcio <konrad.dybcio@linaro.org>

[ Upstream commit 6d9fb9e4c473cdfd2adca019b46d8e482105cae7 ]

To ensure the PLLs are getting enough power, cast a vote with DISPCC so
that MMCX is at least at LOW_SVS.

Fixes: 494dec9b6f54 ("arm64: dts: qcom: sc8180x: Add display and gpu nodes")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20231230-topic-8180_more_fixes-v1-7-93b5c107ed43@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8180x.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8180x.dtsi b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
index 3bb9d25b1dec6..97c139d0399d4 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
@@ -3217,6 +3217,7 @@ dispcc: clock-controller@af00000 {
 				      "edp_phy_pll_link_clk",
 				      "edp_phy_pll_vco_div_clk";
 			power-domains = <&rpmhpd SC8180X_MMCX>;
+			required-opps = <&rpmhpd_opp_low_svs>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;
-- 
2.43.0


