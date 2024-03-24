Return-Path: <linux-kernel+bounces-113396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4238883FE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF0751F293DE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E2E1A3790;
	Sun, 24 Mar 2024 22:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZpDOvek"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3331A2F7D;
	Sun, 24 Mar 2024 22:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320197; cv=none; b=aEXJQbbnDl+K7fA8qtPMgc+zWZ5DYO5LfXIFMD/nDY6viP7J4w/z2yVvjzix/3c02ixRirDns5HaAuKFuH+en7FUrPIDtLp0xlxhtBDF4LYhg8IHNxolFI7Dss6CoEJ2knjNGhufICyrVcspscdY9JWS24IK4/FzAq9Rt64o1Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320197; c=relaxed/simple;
	bh=hG24ceIatTC20ZxBsqp5TxfOgfB2eDG8J9pF5Gn0hMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KhfPAtWWWBTWZDtytGDfBVKnpgkQ5trn3/y+QXPYNDA5xG3RPxLcJPqerrb5w0GAioab+dKxTxeKn/8Z4EqJtP8KikWVlNTd4c9OfcETFNrTjKVrtxkMiQXv4DmeBMZT0w0ebAbDbWTUMBtqjhNj78ZXKC0R4QKkUBujbcrEe0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZpDOvek; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDC70C433A6;
	Sun, 24 Mar 2024 22:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320197;
	bh=hG24ceIatTC20ZxBsqp5TxfOgfB2eDG8J9pF5Gn0hMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PZpDOvekPr00C64OfPDyW1PVnfchoxl6/UQfM5//jQ10x4wgIS0eqHxHQGNDdfmwL
	 jmB+z8obXXF8zARmygVOdTfun9zCin2Gm9R//sJs47ZQCT0Zc+9kqTOi/87V1nLs8R
	 Ao/sgGtJBVBZExUFb+CXgqkXOXPE8Y7E97MkYGvgkFBXyUqIc0e1kM5EXIo/tFSqte
	 libNMD900ld5Cw+Vp/4H8VgGEDoXq33Gg/8I/muBb2Fm4wVWw9nnv/doW4Aa439nkv
	 WZ8sVkdHgOGr8rrswILBNlj3Y5amyR6D1jAnDWyDZV/3JzVSSGlKcPnrTzcOWzDMek
	 tHllpbTDkcfKA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gabor Juhos <j4g8y7@gmail.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 505/715] clk: qcom: gcc-ipq5018: fix register offset for GCC_UBI0_AXI_ARES reset
Date: Sun, 24 Mar 2024 18:31:24 -0400
Message-ID: <20240324223455.1342824-506-sashal@kernel.org>
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

From: Gabor Juhos <j4g8y7@gmail.com>

[ Upstream commit 7d474b43087aa356d714d39870c90d77fc6f1186 ]

The current register offset used for the GCC_UBI0_AXI_ARES reset
seems wrong. Or at least, the downstream driver uses [1] the same
offset which is used for other the GCC_UBI0_*_ARES resets.

Change the code to use the same offset used in the downstream
driver and also specify the reset bit explicitly to use the
same format as the followup entries.

1. https://git.codelinaro.org/clo/qsdk/oss/kernel/linux-ipq-5.4/-/blob/NHSS.QSDK.12.4.r4/drivers/clk/qcom/gcc-ipq5018.c?ref_type=heads#L3773

Fixes: e3fdbef1bab8 ("clk: qcom: Add Global Clock controller (GCC) driver for IPQ5018")
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Link: https://lore.kernel.org/r/20240225-gcc-ipq5018-register-fixes-v1-3-3c191404d9f0@gmail.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/gcc-ipq5018.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/gcc-ipq5018.c b/drivers/clk/qcom/gcc-ipq5018.c
index 5e81cfa77293a..e2bd54826a4ce 100644
--- a/drivers/clk/qcom/gcc-ipq5018.c
+++ b/drivers/clk/qcom/gcc-ipq5018.c
@@ -3632,7 +3632,7 @@ static const struct qcom_reset_map gcc_ipq5018_resets[] = {
 	[GCC_SYSTEM_NOC_BCR] = { 0x26000, 0 },
 	[GCC_TCSR_BCR] = { 0x28000, 0 },
 	[GCC_TLMM_BCR] = { 0x34000, 0 },
-	[GCC_UBI0_AXI_ARES] = { 0x680},
+	[GCC_UBI0_AXI_ARES] = { 0x68010, 0 },
 	[GCC_UBI0_AHB_ARES] = { 0x68010, 1 },
 	[GCC_UBI0_NC_AXI_ARES] = { 0x68010, 2 },
 	[GCC_UBI0_DBG_ARES] = { 0x68010, 3 },
-- 
2.43.0


