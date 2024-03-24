Return-Path: <linux-kernel+bounces-115518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84612889410
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DD9228360D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A740D23CB6B;
	Mon, 25 Mar 2024 02:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MYREg7Ke"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5398B12B16F;
	Sun, 24 Mar 2024 22:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320968; cv=none; b=K4wC2FGwLrH3WVA0mmonfsKmQmOT80hFP20F6zTCCPgT11shxuvCX00Y346gmuiLluV/Zedjlqtp6l0RPgPVHNZhGPSGcviMMG01eK7T/CroRK6Pp2sVL/tn1ASjSOS8SvYU+px57QmF+bCN1jajCHtbiNCAKFY9V2PpLM+huvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320968; c=relaxed/simple;
	bh=K7s6iZDEqBncdjY4M9PX3Elscxa3YIEsRcGyrG/j8L0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ul9cFHChNl9+QQ2Ot3R0HzKYzHqVgrr1jnUiXiv/mxPai3pfodzawVL35YxdgaSICfhX/3FaCoXKDgfKszRh1X3pIlReGLWBerta4ShMtUf7t5RpJvBFwuA8GScuc0OvJl1oRwioaNqTFGMHUUYDnHmOOoqsKretZAYQtx7VZ/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MYREg7Ke; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 622ABC43394;
	Sun, 24 Mar 2024 22:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320968;
	bh=K7s6iZDEqBncdjY4M9PX3Elscxa3YIEsRcGyrG/j8L0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MYREg7KeN5H50NAq8nXtr4UUy9OsGcvzcVBeSL69eVw1f21gE0XQ+DZITUVsYzvWV
	 z5Ha2Z2qHGPKX64nRKyeuGnxxlm0fm2CFOpwCFGuNZC63Pf1zJXqDmPoTOi1cJJ5HN
	 lucF9TNgxqAWh+oOuZdXrwAW1SAY3I04CXrbEDhi7602ax9OKHAjbaDdJGUrPvnyTt
	 v2DXmPcAPFhiyO5ZVLBb51ecJWMoRFOxkHnARzXHWkL7USgS2p8s5aWTEFBBD+ZNRy
	 ZEp7GTh08FkCeeOfYownAQ0csnlHlnJT1OBd2D87eW2Ecrt1YKMe45nRnqHNYAcFEi
	 7SQJuI0+b6YBA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gabor Juhos <j4g8y7@gmail.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 531/713] clk: qcom: gcc-ipq5018: fix 'enable_reg' offset of 'gcc_gmac0_sys_clk'
Date: Sun, 24 Mar 2024 18:44:17 -0400
Message-ID: <20240324224720.1345309-532-sashal@kernel.org>
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

From: Gabor Juhos <j4g8y7@gmail.com>

[ Upstream commit f982adcc1b1c02a3114f68ac73c811cbfabe90fa ]

The value of the 'enable_reg' field in the 'gcc_gmac0_sys_clk'
clock definition seems wrong as it is greater than the
'max_register' value defined in the regmap configuration.
Additionally, all other gmac specific branch clock definitions
within the driver uses the same value both for the 'enable_reg'
and for the 'halt_reg' fields.

Due to the lack of documentation the correct value is not known.
Looking into the downstream driver does not help either, as that
uses the same (presumably wrong) value [1].

Nevertheless, change the 'enable_reg' field of 'gcc_gmac0_sys_clk'
to use the value from the 'halt_reg' field so it follows the pattern
used in other gmac clock definitions. The change is based on the
assumption that the register layout of this clock is the same
as the other gmac clocks.

1. https://git.codelinaro.org/clo/qsdk/oss/kernel/linux-ipq-5.4/-/blob/NHSS.QSDK.12.4.r4/drivers/clk/qcom/gcc-ipq5018.c?ref_type=heads#L1889

Fixes: e3fdbef1bab8 ("clk: qcom: Add Global Clock controller (GCC) driver for IPQ5018")
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Link: https://lore.kernel.org/r/20240225-gcc-ipq5018-register-fixes-v1-1-3c191404d9f0@gmail.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/gcc-ipq5018.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/gcc-ipq5018.c b/drivers/clk/qcom/gcc-ipq5018.c
index 4aba47e8700d2..cef9a1e7c9fdb 100644
--- a/drivers/clk/qcom/gcc-ipq5018.c
+++ b/drivers/clk/qcom/gcc-ipq5018.c
@@ -1754,7 +1754,7 @@ static struct clk_branch gcc_gmac0_sys_clk = {
 	.halt_check = BRANCH_HALT_DELAY,
 	.halt_bit = 31,
 	.clkr = {
-		.enable_reg = 0x683190,
+		.enable_reg = 0x68190,
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data) {
 			.name = "gcc_gmac0_sys_clk",
-- 
2.43.0


