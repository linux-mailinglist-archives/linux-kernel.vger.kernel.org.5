Return-Path: <linux-kernel+bounces-115409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9CC889514
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA37AB29728
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5592046CC;
	Mon, 25 Mar 2024 02:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vw1k/PzF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC79142E78;
	Sun, 24 Mar 2024 22:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320587; cv=none; b=LVLEvQ9ep/AQtOpgNY214Rfx67E/kHEUgruSbBwLsAfo2SPqnNb5AHEU3QvXDkIhmpHVQEq+mMHyPyhwmb+es9z5vUbFeFfIXY101GUqpI6Plo1M8xB4COjktaSnhqJ2wLc8u0wC3Vm/+aB45LdXw82Pz0St9Djkk9sn0c+TjDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320587; c=relaxed/simple;
	bh=Lf3DJ9DScd7km095/jj3YNB0FFaQ8n8sAu8BommosWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QFygjIn0JJSROKd26a02CwvPKHdLWoo0SbV19pQv9lDeHqJFCGB0O34WuHpDHFVFftVevwA0mihdqajHHEdlii7cClmE08yX1UjJsuW2ZQqKYt1FQML/1beziTnZzNMoAQcRCQF47ZnfAnHGB2NsAImyubujMI4T9nDSMBJnbrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vw1k/PzF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF1C8C433C7;
	Sun, 24 Mar 2024 22:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320586;
	bh=Lf3DJ9DScd7km095/jj3YNB0FFaQ8n8sAu8BommosWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vw1k/PzFzPvxyyMw6XGn1WDsDhUrdIYkFemK3vp88rxUvPloqHlCiCji/aJcMiB9O
	 Ek6z3UUjwLXT+MGdcSOxh5DJKBwD0/mwCwGiBhw2MBEM1W8kjp66blf7h5VlVeYPRA
	 jc4Bmp/nAEGNhVkeJvB+5o/V0/0CLxqUSMvfDdaJAwGG/A49jNZpicQ+fGPgj2eCtY
	 wpmbwKXGLLJ12jRrXnlv1U2WSdoQXaeGeHNhn9MYk3WknQGOHzMCWSIDBXy3MyR4YG
	 ywGyOMRIYy/9ylHCDLykG82FAOZpVU6EM23tmcR89ShsuVztxWJTYodFMFyJMY9MjR
	 Oje9S/V6ynN8w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 148/713] arm64: dts: qcom: sc8180x: Require LOW_SVS vote for MMCX if DISPCC is on
Date: Sun, 24 Mar 2024 18:37:54 -0400
Message-ID: <20240324224720.1345309-149-sashal@kernel.org>
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
index 687efe3404ce5..881b4e0d5b8b4 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
@@ -3210,6 +3210,7 @@ dispcc: clock-controller@af00000 {
 				      "edp_phy_pll_link_clk",
 				      "edp_phy_pll_vco_div_clk";
 			power-domains = <&rpmhpd SC8180X_MMCX>;
+			required-opps = <&rpmhpd_opp_low_svs>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;
-- 
2.43.0


