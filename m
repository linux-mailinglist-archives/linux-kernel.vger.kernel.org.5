Return-Path: <linux-kernel+bounces-116187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B758889A1D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38DE41F32810
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E02417BB0D;
	Mon, 25 Mar 2024 03:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T8sI8W2t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251F617C6AE;
	Sun, 24 Mar 2024 23:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323782; cv=none; b=fESKrNHndUaO06QCyxa4osXhAKGQTUqQuDWuG6kV/758g7drRA2oCVYJFufArklaWvZJLvmVP0XK8oNr5YR/GzVlhr+MINaZRcuXWniXIMcH3Av1wZrttW30ZzUxPYaKdEAfMLMM50c/xRhuJYDD4jhcPhvAZ1JhfQtIrZMmyts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323782; c=relaxed/simple;
	bh=Drqi5r3d6775OKi+5Qy3gKeom29Vnn5yKc0wag/duSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yemp1Wjd/GnPRCdvIQBXQYks0AInioSsUJLt1m8yNVNsQ8gpk9ZPaMSD+gr4LC5LC1gD4nf8jnRxxW3V+roqfScaGdi26o7l1bdDxbdEfbkplC/nB/iJ3I8ayTssByumv1ES6YwdTfbEhgo+5SQ1jJNmPOBFPS8My2iE6KIu1cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T8sI8W2t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45F22C43399;
	Sun, 24 Mar 2024 23:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323782;
	bh=Drqi5r3d6775OKi+5Qy3gKeom29Vnn5yKc0wag/duSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T8sI8W2tvKzu0P9n08vc40t+uekqbUn11wkblzaE/4IlOik0ULfGVA2pI0EHxsiV/
	 HK5mJ/oG1NyG+YzmagDprCrPFGgnAqcJiyfF/TWJyh+xfd11/EC+LKb07+kmOK+zBB
	 Amb5zyc+QOZBIqO3j9X6wGJ06DWUpkbMyYzZWLkZADRgfaD9Vt690Rvq7cWfhliDcM
	 SbDgEk0d3bD4WXDRZuH61vAKw8PVMDUCN+PrMe4FVu2HWQsLiEPV4c+txIvc78L0Ht
	 sfvumKGej2IXW+HX0FcKdobi4121lqOxD9jHeROC0KxBQSZKEqSX8236XWcWJRJLWo
	 5Bc+gaLc1srSQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Caleb Connolly <caleb.connolly@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 158/238] clk: qcom: dispcc-sdm845: Adjust internal GDSC wait times
Date: Sun, 24 Mar 2024 19:39:06 -0400
Message-ID: <20240324234027.1354210-159-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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
index 5c932cd17b140..8cd8174ac9aa7 100644
--- a/drivers/clk/qcom/dispcc-sdm845.c
+++ b/drivers/clk/qcom/dispcc-sdm845.c
@@ -768,6 +768,8 @@ static struct clk_branch disp_cc_mdss_vsync_clk = {
 
 static struct gdsc mdss_gdsc = {
 	.gdscr = 0x3000,
+	.en_few_wait_val = 0x6,
+	.en_rest_wait_val = 0x5,
 	.pd = {
 		.name = "mdss_gdsc",
 	},
-- 
2.43.0


