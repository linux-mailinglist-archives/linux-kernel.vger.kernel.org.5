Return-Path: <linux-kernel+bounces-116726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 762B588A1D5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 312222A3DC5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4E015FA8F;
	Mon, 25 Mar 2024 10:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oImfIzH4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB953153BFB;
	Mon, 25 Mar 2024 08:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711357134; cv=none; b=XPY+INgcuVOwP1sOyj/Hf6075nuvx1hdRsj8XYzWOsp2jLpRtBX6khYg5ciWR6aYY6P37KIY2U48cULu2vYUEeHrMfHTS+m32MDlNy+VWKJzrskxw+kZ6vpJhScdmxqsNJ5VwzjEBUrABSuM1q3DG1e4RBb+UXF10s88Fhvlebw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711357134; c=relaxed/simple;
	bh=3kNKmqcvjVl9nlFohKUhmUZ38lAcXqFMYW0taY9PxKY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=azzh19sbivbktodqcLXw+Ym1iMFEwtYjlfP00Ht71uIPhpD0tQRkZ/VXB2F5QrwWz6VEh76yc3GGhQ3K1YPG9EsE5EUi6RGUfmRmtL/uyEdU5qhV8g8y3y3xJ8M1W62z4EzV4pflbOPt+bgDkj3JxjWSa9w0ZWx5MJ92ZSdrqvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oImfIzH4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD60C433C7;
	Mon, 25 Mar 2024 08:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711357133;
	bh=3kNKmqcvjVl9nlFohKUhmUZ38lAcXqFMYW0taY9PxKY=;
	h=From:To:Cc:Subject:Date:From;
	b=oImfIzH4/qvEdDO3AwkDkR7EnD3/B2jEwyrx1KjwbLPqJBL4JJUdDOWCDz1OHLFn5
	 +flteqqS+TY+iBHAQkqp6hlAjMT64I/p9vSwOCbfFHOfi97mm3m02BraIZOxMDijvH
	 cFn7+1F1y4ySeq+m19i0DUQ0jlv2jCP4W4fI201zasC5Ulj17ZzJASVWXZUlXjBjkG
	 kQO6EBv+9bvHjUcGLf1gu6gI7n091LENfmyK2cE3G7PZgIdGnH3ka5hDw1mTN3eBIT
	 HCrsOFwZ/aT59EaShg422gResSK/054X1ytTYI0OCgx6AbNYZgE0+OMMIsVVoKZE9w
	 deZWOnVsqVZeQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rogAV-000000006o6-3A6x;
	Mon, 25 Mar 2024 09:58:59 +0100
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
Date: Mon, 25 Mar 2024 09:58:35 +0100
Message-ID: <20240325085835.26158-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.0
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
2.43.0


