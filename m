Return-Path: <linux-kernel+bounces-112958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBB988800F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B710AB225D6
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F7F126F31;
	Sun, 24 Mar 2024 22:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJr96o8e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4691126F1A;
	Sun, 24 Mar 2024 22:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319771; cv=none; b=BiDDTH/Fkf/9jvggiHBzNxMFqssjKR7h7iBBkGYd119wjLlwaUIWNAJTdlOPBQSfSOIHjR/Bzk0eDNMfcMNUOlYhWQMb3N99GAknmMXBJQI00ME9kbXNKTtQp8H9CLWDK1hlu5tpLGIA0eRAiMWJ0KcIeSw3KiNW/+XvXlf/bJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319771; c=relaxed/simple;
	bh=xjqHKYSgG2+1s7bWEwmzpDAXT7akFxCKu5c5fcVHtHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZSASYx0kE7lw0Gd1rympUiECUiIi3HwNNzSIsDWFX8nVXNHVxQkrs1LAFTCKtpWdXnkta5N+0VmYOURILxlP18uSHBnXPWlvDGktWOfkIAZOkO6pVwuAWXEjUcO1SqhUL44Q4RXevKOSgYPVC4vWxbwcUVzEq7Mp8LyaknQYNFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJr96o8e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD2B2C433F1;
	Sun, 24 Mar 2024 22:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319770;
	bh=xjqHKYSgG2+1s7bWEwmzpDAXT7akFxCKu5c5fcVHtHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VJr96o8eTr8V6EW5mFprFE788foTgDGRx1Pd2H9COvcxTZ8UVrAZfrHH+TbMcjvTF
	 TH9HbN4hqgxMpSgt4rLVQ1X3jqAEkBxIDukx95mAnetkfhxtsFyOZL/9x/iwXYX3WZ
	 8nskJj5LTlReTGelv/cd7996ej9ORR38VvwEeF35LknkdNkc9BwipqwG5WuTysOTDi
	 /S7gqww7mQQj2JroeW8z+8S70/9htmBIewMB8YAGqTCUvcY/hw2wKU47BjiF9NJn/y
	 HHBtdUhr8RevsFWu2Tx4HZ1Q/AF83StIUyAYX1ngdKzfulsVq41U3bYOEr0iHOEOUN
	 zv/DCmS/z7Dgw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 071/715] arm64: dts: qcom: sc8180x: Hook up VDD_CX as GCC parent domain
Date: Sun, 24 Mar 2024 18:24:10 -0400
Message-ID: <20240324223455.1342824-72-sashal@kernel.org>
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

[ Upstream commit 3c58b96df110a80e78fa36ef928f1e6c375008e3 ]

Most of GCC is powered by the CX rail. Describe that relationship to
let the performance state requests trickle up the chain.

Fixes: 8575f197b077 ("arm64: dts: qcom: Introduce the SC8180x platform")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20231230-topic-8180_more_fixes-v1-2-93b5c107ed43@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8180x.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8180x.dtsi b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
index 0430d99091e30..91fd805f17a1b 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
@@ -782,6 +782,7 @@ gcc: clock-controller@100000 {
 			clock-names = "bi_tcxo",
 				      "bi_tcxo_ao",
 				      "sleep_clk";
+			power-domains = <&rpmhpd SC8180X_CX>;
 		};
 
 		qupv3_id_0: geniqup@8c0000 {
-- 
2.43.0


