Return-Path: <linux-kernel+bounces-114864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCAF8891D7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C85A1F2DEA0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F321BC038;
	Mon, 25 Mar 2024 00:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VF3Lh7XV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6838A27B124;
	Sun, 24 Mar 2024 23:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323509; cv=none; b=Z6r/MVLNaIozO5DTJ2HJkRcYlh8YcUcU8DL24PcMsbocVYfu9AQi6hpu2EE/uUKPGf7KCg4qr4WtvKF4eXsgZ6cPxSte004bUur9RbR62J8KUPiSluZv0iicF8up4CF+o8W7wtybFNHGGoGrGQFxS4SkkJkxA5XyYianEXwQRVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323509; c=relaxed/simple;
	bh=bZsBnUnfKdFw2VCk5QyKwh671+Xs8KoP7fsGfnZBPpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r3D915VkR+wjyqDPP5v5JimxQ9BMgRxdJLAhWp2Atp9Tho/sh8NE3mOVDg9vTbe5IwLZ6AAUfbaxnHEBcORMvKvTxsMN0Xw6Ob7RWHcm3xvBV6Lq/ei/rg/UlXlDY7arYov3mhGaVFVRKvz5hLn1P5y6eltMgJyRqY7rng577jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VF3Lh7XV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C8AC433F1;
	Sun, 24 Mar 2024 23:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323508;
	bh=bZsBnUnfKdFw2VCk5QyKwh671+Xs8KoP7fsGfnZBPpw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VF3Lh7XVVydJniBt/RSZbhp+HZmccVA44bx/N0+gC+5kwDKGMDO1FLKhfNxL2Fm7b
	 9y1Q7SXvVeGkS6InrEhsmAi/yYwTra97C6/OK+wCIM4YylXlaP0tJbOU1KicZIGMNy
	 i50i4SEZWJWBgli6xckF9xXTEILRj3TBMtnLNeHYqiMqIhNafBKosJ9JSyfilEPTCe
	 jUsGjGoXfS/ezWwi0vhP48uKweJPpd0qGZMHwcaXHJq3TgtgGThuCRCefB8oTA8Rz0
	 rWYy7T9xp9VZ26BNFiDv8SEvAa3pFbu+KNR2kqVr6NhJdaKcwKOe33QKm+8thZVka9
	 kLQPutCa2YBiA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Caleb Connolly <caleb.connolly@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 214/317] clk: qcom: dispcc-sdm845: Adjust internal GDSC wait times
Date: Sun, 24 Mar 2024 19:33:14 -0400
Message-ID: <20240324233458.1352854-215-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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


