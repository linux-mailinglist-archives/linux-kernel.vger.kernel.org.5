Return-Path: <linux-kernel+bounces-115126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EA9888D3D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03DF91F29FA2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEA12FEFA0;
	Mon, 25 Mar 2024 01:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jeeO3puJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0653F181CE3;
	Sun, 24 Mar 2024 23:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324125; cv=none; b=OIfHHy/oYTzzLGa6sFPsMnvHFOhzW+gn5AGs6g2Jij1wZNoEAnFLiclfXSTnSLhmso2reALS9OBeHPlUIhUQrqYsV4Eg2VqrKf5cE49HK+mYeEhtCWG6MfskFCG4I6zqAvrpIS2yrBo16Py2cHAoPbJ1TCGuxbL0zCGjQDx8R4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324125; c=relaxed/simple;
	bh=ZfOUDs7jrsD7iao803en/1YeW13GBtchnkANuEkhMvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BWsevuMwy6ySIvTmzlhAl56jq3+xpS2MWmbbHAEww8K1XdvbDeQ6GXePsGVZfxwbMdDVd6YFeH5RrMQRN0LyGvQiXGSsQqTHzI8TlrbbogAQbjBtDcCqQ/WRbp8GyXffr+ZNWVyI4YjjHm9LtliVa3bNdxQWvYYivGoXw8UoxUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jeeO3puJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8671C433F1;
	Sun, 24 Mar 2024 23:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324123;
	bh=ZfOUDs7jrsD7iao803en/1YeW13GBtchnkANuEkhMvg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jeeO3puJDqmVnndLpd4HmSdi+r92n1fbS344j7W6Ou59JvenNMqXE47j3MNT+HAwX
	 3dphW8DktwRiTndCTpZnCccRfXg2zmRQo8ymL43abckFPB1UQ3wB9+laiP5MvXGPIe
	 KR+Gf8S6buU5L/azwNcG5S1kjoqBl4BoxZcQmWhjsF+bO0V7Tl7z4W0OZwdDuAxK4+
	 pkMjUjyb4magu36sksLvVZOpmle5Vrd6vogr1BRaRKuxDvjQiMyZ2EOwRIvBo26jGm
	 tXyQsVy5lLG5SZ2/nOZZxlVro3WJEwsVLxwqPhnpAT8jOS7HIGG/y1jAMFLptVbp0z
	 /75HNGgdgyihA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Caleb Connolly <caleb.connolly@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 121/183] clk: qcom: dispcc-sdm845: Adjust internal GDSC wait times
Date: Sun, 24 Mar 2024 19:45:34 -0400
Message-ID: <20240324234638.1355609-122-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
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
index 0cc4909b5dbef..cb7a2d9247b04 100644
--- a/drivers/clk/qcom/dispcc-sdm845.c
+++ b/drivers/clk/qcom/dispcc-sdm845.c
@@ -569,6 +569,8 @@ static struct clk_branch disp_cc_mdss_vsync_clk = {
 
 static struct gdsc mdss_gdsc = {
 	.gdscr = 0x3000,
+	.en_few_wait_val = 0x6,
+	.en_rest_wait_val = 0x5,
 	.pd = {
 		.name = "mdss_gdsc",
 	},
-- 
2.43.0


