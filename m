Return-Path: <linux-kernel+bounces-115476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 313C388957D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 591BDB3550C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E4A224A2D;
	Mon, 25 Mar 2024 02:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXZXmfwV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54791DCC89;
	Sun, 24 Mar 2024 22:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320909; cv=none; b=GDrPYQY0t5G1nhr1id91pRcOmCwOODF6gqbTMcnFbOFexhQzbmQD0+bLNO1WNKeJ+pxGDP71rsEcClBEfxQL44PCHLOFqB0lcNZag0paDjWEngYTxKiW5Lfz1MijS/hlDRle8kzRBJJ7kfrvj049Gvg9ZweFPdGTdUpXw3OkUg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320909; c=relaxed/simple;
	bh=bZsBnUnfKdFw2VCk5QyKwh671+Xs8KoP7fsGfnZBPpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qpI3F164/dQGveCzIj+dIXK9MV26/i6hpU5H6yW22kMq9SpHJZTGHoX611WDg6a40+0eIUfsEaOidCOHmNyLFkwCytFKrxIo3+8OUTuF1R/ay0hpHMgYECyzD8xJsWx0lfHII5Dofp7dkag4lypOA2E8ycjJzRpA3aJ2FNoqY50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXZXmfwV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEF18C43399;
	Sun, 24 Mar 2024 22:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320909;
	bh=bZsBnUnfKdFw2VCk5QyKwh671+Xs8KoP7fsGfnZBPpw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mXZXmfwV//5APRBorvLbe3VRfjYYDWmaLbVtnGEbZN2qADWRCae/B8qkVOhpw1HKP
	 C2hMGTyk69QjlbczPSXNwOsaT6cR51nN0Vsslsc78Xt+7fNbeeXGLnyOgSiBrN31Xj
	 xBJtHu+lWa1DAbWu0tyT7djBh0jmiuXwJo5LS3pMDoXX5j/fDc+/2tmeMv8nW6xenj
	 X2Zdk9TRkHI2xT2OgmZHld83RzJqDkLF/QdCAX0OUPpmwmUoNu7QBu60O0cGfrZjzb
	 oOIKlL6AGAVSzWf/deqLvAeV8fFRAXUWXlTIm/RI+9r6FwRJiGXoB4LrSOj9IWRFao
	 Vl1UwRhMFE7KQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Caleb Connolly <caleb.connolly@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 473/713] clk: qcom: dispcc-sdm845: Adjust internal GDSC wait times
Date: Sun, 24 Mar 2024 18:43:19 -0400
Message-ID: <20240324224720.1345309-474-sashal@kernel.org>
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


