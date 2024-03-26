Return-Path: <linux-kernel+bounces-119109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E38F88C44C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E95EB2E282B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37BC76C68;
	Tue, 26 Mar 2024 14:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rKVoACsQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1027C757FD;
	Tue, 26 Mar 2024 14:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711461693; cv=none; b=bHs1hWYhhHF9C39TlcPTN2Unht1JKH50SS688jwXp2dtllEj9eIY4Fvo3CzJH4NTpOSUtd7MZmN6BiqbZsejBhDBkmumVsbdR8tpYk5lVK7HAh/GRaib+XH3NGpNwcqpbV9hfFDx80tEy/GoHHKKOb6MZhBeHGf5hVeW8iykOzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711461693; c=relaxed/simple;
	bh=sshlJawg659jSJfqUQ6B4XGmjcjFXGGOIn2jUhaVb9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WRUJX+BegCfF1lcxXDbx5jloShuszyi9gbB6Dw3zUNzwuIWooDacBqQb+UKauIrtea7uxVXAr1UiiceBPtZQ+mdNcES4rOaFg6r0MsE7p7ZlB+VM1fadlSKPsSyJBoDYQ/+w8qdsem6G69Y6PfroRJWwdm7/NjScKZsyMIC/DPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rKVoACsQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B8BC433A6;
	Tue, 26 Mar 2024 14:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711461692;
	bh=sshlJawg659jSJfqUQ6B4XGmjcjFXGGOIn2jUhaVb9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rKVoACsQNc8saXiMROuxFyNJiPoe+4lapP5s6rohMVryogcSykeied/MZMn4lTjAy
	 xGmUFXVigXSJwQoLZPR+7NLHcJ0Y2IVdEiUGt4tnrSSqdTi/kgarFjpIxjnHOkt6NP
	 m3q5Xmq0sGpbr+ljYdR0bzUSrrWSgFEYPtndnKooQmHAj9EbfqjNuppmHgvvNZugGj
	 vjCA+R+OJkgj0IpKMGmAtv09fcYaUds9Phi6ttscTbN2AFCYnAazff54S/Q+dDgcbY
	 gunLiHCOaWHABdrAGB3gw0zc/ZJFyHl98X1B+XDAkcJkOGw5SAtKgGSlHPIUc6f8id
	 iXlK71+UD2jDA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rp7My-000000005Yt-3rXx;
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
Subject: [PATCH 3/5] clk: qcom: gpucc-sc8280xp: make cc descriptor const
Date: Tue, 26 Mar 2024 15:01:06 +0100
Message-ID: <20240326140108.21307-4-johan+linaro@kernel.org>
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

Add the missing 'const' keyword to mark the Qualcomm clock controller
descriptor data as constant.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/clk/qcom/gpucc-sc8280xp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/gpucc-sc8280xp.c b/drivers/clk/qcom/gpucc-sc8280xp.c
index 3611d2d1823d..df6b01768767 100644
--- a/drivers/clk/qcom/gpucc-sc8280xp.c
+++ b/drivers/clk/qcom/gpucc-sc8280xp.c
@@ -415,7 +415,7 @@ static const struct regmap_config gpu_cc_sc8280xp_regmap_config = {
 	.fast_io = true,
 };
 
-static struct qcom_cc_desc gpu_cc_sc8280xp_desc = {
+static const struct qcom_cc_desc gpu_cc_sc8280xp_desc = {
 	.config = &gpu_cc_sc8280xp_regmap_config,
 	.clks = gpu_cc_sc8280xp_clocks,
 	.num_clks = ARRAY_SIZE(gpu_cc_sc8280xp_clocks),
-- 
2.43.0


