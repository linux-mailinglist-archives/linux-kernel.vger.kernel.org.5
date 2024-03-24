Return-Path: <linux-kernel+bounces-114315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B69888F9D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E76611F2A914
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D8A264D67;
	Sun, 24 Mar 2024 23:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TRefgYcX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9AB21086B;
	Sun, 24 Mar 2024 23:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321698; cv=none; b=YrpHM1VjtBGHqUaf5cETJVwmRkkMaKNWcXXe/uFLGOLV+nm5i/7zlcufiMWMN4TnuMCvf3Y5Ir7rA735S2mVdcyR637FGmfgpDGy/PzdLUnBS1uoonZB9W6Gp2Im/kSxiidUpo0fuA1RfitBwP015gZdHmXH7TIDufQLheYE/P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321698; c=relaxed/simple;
	bh=bZsBnUnfKdFw2VCk5QyKwh671+Xs8KoP7fsGfnZBPpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H18Jf2o/p2XzKekb1MCYBpbVEQzQqOuIK9Bvrk7Gn3tW4ziAQC9yPx/vMFFI2WEyIKLtpyHLJWIAz2d1qVyTdguX1BZyQJ+U7xyFndMi/odOSVc4awY79mTs+j7B5Q+uvJC1G6sFSCNiwk9AUARzVUy7GVBDBrxOcB7+aApB6NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TRefgYcX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1271C433C7;
	Sun, 24 Mar 2024 23:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321696;
	bh=bZsBnUnfKdFw2VCk5QyKwh671+Xs8KoP7fsGfnZBPpw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TRefgYcX6FJ4MQC0Xn9NhrRz8VlfB0GHcs7buPEiWIpjgLOEkVOzCIhoTeuTQ7hRT
	 gR6O+CQ/SItwaw6sFsAJKR27TogrpXc6mluBoNMiSt2KBuJ/d86rIyxiIasW0IR1ly
	 vHyEwBRellu9OkNAXuEKKeGzNNjMcw+GVS/2JJVc7sE8pErqGtdXTT6mNrDZC99SOf
	 WRy52AYyaMJ53lC986ieZ9+Jr9xDN6GRHusDCqDgSnmA0nKE4ii5KXsaaJxGSAYtM6
	 ChNZmRkm3+7Jg12nycJPj/JJlCBkDIDpEskyUap7czkcqq7/4ltz/2x8cXqVLcikoj
	 x+PoYcOSFmmFA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Caleb Connolly <caleb.connolly@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 425/638] clk: qcom: dispcc-sdm845: Adjust internal GDSC wait times
Date: Sun, 24 Mar 2024 18:57:42 -0400
Message-ID: <20240324230116.1348576-426-sashal@kernel.org>
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

[ Upstream commit 117e7dc697c2739d754db8fe0c1e2d4f1f5d5f82 ]

SDM845 downstream uses non-default values for GDSC internal waits.
Program them accordingly to avoid surprises.

Fixes: 81351776c9fb ("clk: qcom: Add display clock controller driver for SDM845")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Tested-by: Caleb Connolly <caleb.connolly@linaro.org> # OnePlus 6
Link: https://lore.kernel.org/r/20240103-topic-845gdsc-v1-1-368efbe1a61d@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/dispcc-sdm845.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/qcom/dispcc-sdm845.c b/drivers/clk/qcom/dispcc-sdm845.c
index 735adfefc3798..e792e0b130d33 100644
--- a/drivers/clk/qcom/dispcc-sdm845.c
+++ b/drivers/clk/qcom/dispcc-sdm845.c
@@ -759,6 +759,8 @@ static struct clk_branch disp_cc_mdss_vsync_clk = {
 
 static struct gdsc mdss_gdsc = {
 	.gdscr = 0x3000,
+	.en_few_wait_val = 0x6,
+	.en_rest_wait_val = 0x5,
 	.pd = {
 		.name = "mdss_gdsc",
 	},
-- 
2.43.0


