Return-Path: <linux-kernel+bounces-114580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 826F6889070
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF3421C2C21F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054B5186390;
	Sun, 24 Mar 2024 23:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qQo7LEyl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78CB14AD34;
	Sun, 24 Mar 2024 23:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322224; cv=none; b=nqinudDSlr3MYqn4gb9rJGtxf0zM9oGgSCfgL1E/RWcxuvH+2dH47PboKp7snnT3SpM/Ox7lofjnUwFwXaZu8UZbsLUodRLKF39a8GqxBECtmb7ac3bq6QFr7YUpviriTsBZdqkSS5n4Ir+pcufz0El5wKYpaCOArwzbusut+m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322224; c=relaxed/simple;
	bh=bZsBnUnfKdFw2VCk5QyKwh671+Xs8KoP7fsGfnZBPpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sGLgOP2+wPqQxoB0+sOTR9t5FPr3xhdakquoNCvyNIsUinPsdJgMRNXyc+7ywEAiVFLWJ7XOnmsPI6b1l75TyxverltAudmWGcSRPsZUBenSavJ07+452oBpyxXBPhJ2GoljT8il+xn9WvIZlRYi6f5ip8axlbNPh9iBMeSiPI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qQo7LEyl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06BD2C43390;
	Sun, 24 Mar 2024 23:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322224;
	bh=bZsBnUnfKdFw2VCk5QyKwh671+Xs8KoP7fsGfnZBPpw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qQo7LEyl1lFuSfjrRcjeaqjtJS+Zb0N+0OMawBnm+U7iV8r/GO2Z9K+yJ48xzx4ED
	 EM74VPxKnbgwLC9NQQXeCBs1vqEj/P35wIk3VPwEeNp6ys3d7DsmphsrczEQvojTN0
	 SkBSwbBdqCnUdfJN4qx/pzZnKxouZ4RVVFF9nK2rOo/V/DCT3AXnGiUU0fKW6T4b9d
	 bzXP9wEmUuqYGjwvv+H0mjRT0gJdt/AuoAYwHZFzQyzb+0WW9XBvm6j0KququXe+I/
	 SBefGjUdZKSkyok7AeePuoXRH5rggvpmdVxW24ChNB8zytxJpJ70kCWVkmiZRZ55cT
	 F+WBTPzEOiY8w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Caleb Connolly <caleb.connolly@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 305/451] clk: qcom: dispcc-sdm845: Adjust internal GDSC wait times
Date: Sun, 24 Mar 2024 19:09:41 -0400
Message-ID: <20240324231207.1351418-306-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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


