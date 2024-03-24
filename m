Return-Path: <linux-kernel+bounces-113334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7C288837E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2646B23031
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FFC196E1C;
	Sun, 24 Mar 2024 22:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9aCKPHc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F09C196E06;
	Sun, 24 Mar 2024 22:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320135; cv=none; b=Riw6V6oGtTgnKdxJb9+61eJ/IN8RmtE9TKABKI0nxgrpwKz/XHIaft1pDOhCRU2u1y4HobImCB85L5cw5we5l42B4JyeSEkXG0viDGCyJcPB+l1Nu3lFibAy0vIeUagyQCQhegEQ3vJSAlxR3AKi/qlSwPNnwqxwk/bF3O65GuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320135; c=relaxed/simple;
	bh=bZsBnUnfKdFw2VCk5QyKwh671+Xs8KoP7fsGfnZBPpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sD7in7fwPPYqx106r1BNYiRVuXaLqb8koPGZQeebpVAgpUsG76prrsAxBiUNq9GBqTxc9l5BztT/yXZ4z/UF0x9vxH4DzrU1RLYPCWU31EjO5yFbIcV5DWY/bgQR6Fg6K6ojaDHAcpwo2wPbEG/kd9wmoU1A/OBgXsKd+xZLBDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9aCKPHc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F082C433C7;
	Sun, 24 Mar 2024 22:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320135;
	bh=bZsBnUnfKdFw2VCk5QyKwh671+Xs8KoP7fsGfnZBPpw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V9aCKPHc6tf5RCfwZAK9q2jln8Q+iDeNr9FP2iCaf5LG+Cl2HSOXFdnLNn/Cz/VJ8
	 B40ds8Blj95ONRXAfSmPuxBMTBb+3vXE+EEJGhWI2YSlUtMTzkDM3rQ/UeQUA/xZ39
	 nNtFiVhThnEv1lTbST6JVHNwB/3M2HspFTaLkCNinTRtrq2qzMxLmWrwx5kWbzBkZz
	 9LCfgwSmLFFF2eeSAXwOROmlvX7Xs54OkbLxAxBN0pCuyprOqTuQ5fztkd1zarIv9d
	 Gv6kEJHEjWe4t4TQk0S7Ne2OAoG8j1hfQS+DOet5YIFcfpVsqnF41Pj/bvFYRKYXxE
	 m3UKf5WXkpAVA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Caleb Connolly <caleb.connolly@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 443/715] clk: qcom: dispcc-sdm845: Adjust internal GDSC wait times
Date: Sun, 24 Mar 2024 18:30:22 -0400
Message-ID: <20240324223455.1342824-444-sashal@kernel.org>
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


