Return-Path: <linux-kernel+bounces-114103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D764088886F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 153C01C27758
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454F023B474;
	Sun, 24 Mar 2024 23:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KSFKoOna"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51B8201270;
	Sun, 24 Mar 2024 23:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321406; cv=none; b=ErVLzjSqGVss9Tl+0H7ZIuMxgZ2cD9A57q1BBxM3HdfH6AX+41rGwBWw4bo5GcVKVpxZnNsaVC5LonaT7JZxRsgRSiFNbHlFTwWVDlbo7294Xw0oTB66P7z5l8RfozynnuMGBsgoOC5cq29n0XyTH1TsqcU34PdRzjrYaCu3EH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321406; c=relaxed/simple;
	bh=nMkkF7C7OnGxkOs0i6pXO9kc1dDogKXge1E9x2XVfRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q/LMHJfA13K/36yxH5w09XktpnivgnmdcDTMZPf0Wis0TBYV0sxwkj1Tc8e+d4leXQXospAqTQ9Lwalj6ZuwEL+rcYkpeC74MMTIyrO3Jy5xyRjhpDUnbK5HcQdMeEQKUMv+UKckNtLQmU3O1JOy1Ch7qMkhdTA3uhV4qVUH3I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KSFKoOna; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22BDAC43399;
	Sun, 24 Mar 2024 23:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321405;
	bh=nMkkF7C7OnGxkOs0i6pXO9kc1dDogKXge1E9x2XVfRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KSFKoOnaO2IX1Iw7W7O3BUBhjK3Pn9fxbV4eyFkShEwzTjU2MGZbWo3PBLn03swcE
	 zkVCtR7YAPNDBxVyY+StnI4AeLSYY17dq2VWEQKSihBanDbMTSW8ZW60Tz72OAg+o1
	 U4bW+sth4zr2wbIXXEey4nVuKqzR7B0ezEc5JKAwcOH+KnphwLjgI2UNlILNlj0E24
	 4JHOEt8v/3Nq0Zb0if1JtJkRcgPDHtMPc1wke32nRFyl3KTvTYr3yWHrQiUOSr5Smw
	 6jI2xQl7iE+mbi4Ti60yDRDgVFWeTUTqKv2kIGT2P/wmfEcpyLP17mvTVQoV2TZODs
	 nRQl7BZPuUr4Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 130/638] arm64: dts: qcom: sc8180x: Require LOW_SVS vote for MMCX if DISPCC is on
Date: Sun, 24 Mar 2024 18:52:47 -0400
Message-ID: <20240324230116.1348576-131-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index 5ef7500004896..de53541858420 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
@@ -3218,6 +3218,7 @@ dispcc: clock-controller@af00000 {
 				      "edp_phy_pll_link_clk",
 				      "edp_phy_pll_vco_div_clk";
 			power-domains = <&rpmhpd SC8180X_MMCX>;
+			required-opps = <&rpmhpd_opp_low_svs>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;
-- 
2.43.0


