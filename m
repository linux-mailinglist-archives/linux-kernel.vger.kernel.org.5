Return-Path: <linux-kernel+bounces-116689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF95D88A189
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29D041C37946
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1A714D455;
	Mon, 25 Mar 2024 10:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="saVe5D7Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB13818E0CA;
	Mon, 25 Mar 2024 08:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711354800; cv=none; b=D/zQ/TFzM5VK51NHnozyJs7Hkj2F9N5OYRAQ5Z0NDsYcoWeo2bkn7VI8SzWpfRhxoox/43JBOgTVStM+n5CkDKzjvW3Weo7eqt53wtCK2w+5t6OrYvxVBKfhtJ/zh/pM+Fhq962jUohut6NTfdMsLkt4a6IQ669+OKnpdoULN+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711354800; c=relaxed/simple;
	bh=VUHc+tkUJVEFMl8ci6fuYuXOdzY9EDJ895oRdy4VAlE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CdC8ZKMK1psPQOsHITCYAJmIG/xBJpVkt85Qxe0YHLXrkIojedULvNLaRJp50o+toS+l/Pj9+TxloX/MvwTzxfQ/rogelKbiYslTquTsLngxKyEHnFcCjcqLXT5zfcEIx4IT/5PSeLGt4E2j7QvS3TuHDF9eaTIx0UMgyu9CYgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=saVe5D7Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32B22C433C7;
	Mon, 25 Mar 2024 08:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711354800;
	bh=VUHc+tkUJVEFMl8ci6fuYuXOdzY9EDJ895oRdy4VAlE=;
	h=From:To:Cc:Subject:Date:From;
	b=saVe5D7Y4O3+jJDgqxIrHPbSGo2YsWpd+AOxuhmE9oLb3lm54/OcNDzO81fMDSYDT
	 ZCNfZRa2DuVfTNxu5jTjaivLtSorJD/eCSHDs0jageMy8yGJzfSjIaYfLJD2UKSdhF
	 dqtj/C2L87IVILdRIrQ+OidJvolDuqjL1R57+YfD6imqNxvkjmeWhaK/YrEJjP88Ql
	 5CdIl/4QAA2eBtUexAK5RE3CfQaNoVGG2U0/5SMnVR+HufB9rtTnMNoUoNyNV5lxYI
	 GrhgtP5jLtMIs89n1nqSFLFxoYAHrYntCqKyFTAvCWKAnz7BIzsA6brtGIX0v8bnOJ
	 DpI61KpZpYN2g==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rofYs-000000002qj-28tE;
	Mon, 25 Mar 2024 09:20:06 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH] clk: qcom: gdsc: treat optional supplies as optional
Date: Mon, 25 Mar 2024 09:19:57 +0100
Message-ID: <20240325081957.10946-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit deebc79b28d6 ("clk: qcom: gpucc-sc8280xp: Add external
supply for GX gdsc") the GDSC supply must be treated as optional to
avoid warnings like:

	gpu_cc-sc8280xp 3d90000.clock-controller: supply vdd-gfx not found, using dummy regulator

on SC8280XP.

Fortunately, the driver is already prepared to handle this by checking
that the regulator pointer is non-NULL before use.

This also avoids triggering a potential deadlock on SC8280XP even if the
underlying issue still remains for the derivative platforms like SA8295P
that actually use the supply.

Fixes: deebc79b28d6 ("clk: qcom: gpucc-sc8280xp: Add external supply for GX gdsc")
Link: https://lore.kernel.org/lkml/Zf25Sv2x9WaCFuIH@hovoldconsulting.com/
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/clk/qcom/gdsc.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index e7a4068b9f39..df9618ab7eea 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -487,9 +487,14 @@ int gdsc_register(struct gdsc_desc *desc,
 		if (!scs[i] || !scs[i]->supply)
 			continue;
 
-		scs[i]->rsupply = devm_regulator_get(dev, scs[i]->supply);
-		if (IS_ERR(scs[i]->rsupply))
-			return PTR_ERR(scs[i]->rsupply);
+		scs[i]->rsupply = devm_regulator_get_optional(dev, scs[i]->supply);
+		if (IS_ERR(scs[i]->rsupply)) {
+			ret = PTR_ERR(scs[i]->rsupply);
+			if (ret != -ENODEV)
+				return ret;
+
+			scs[i]->rsupply = NULL;
+		}
 	}
 
 	data->num_domains = num;
-- 
2.43.2


