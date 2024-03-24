Return-Path: <linux-kernel+bounces-114426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1670888A71
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECBB01C28B78
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FD1177A8D;
	Sun, 24 Mar 2024 23:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FGPmmguv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388EC21D121;
	Sun, 24 Mar 2024 23:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321848; cv=none; b=EyFE4R09fkKA7gzw303OM8SQy/3oDdvWXIbL3hudEt3xap0EXMYZNTJ/rS5mLJETtxUTWFEQBZpaD6iJie4Ze8oc7z/u3tKvN5ehkrc1FAqaGvQSRKetZzLYlAZaSJbIuu89XEuISzWJUNL4iqzTNU9AbPXfceUBUws6zJccLmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321848; c=relaxed/simple;
	bh=q9cK5+CVva2zWZ5121iREcxRFvY+SrqSNGS/pgZCZmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bndS+z3k8/j6Ut2kT+No6giOiMjCe5ldvrOD5+CJHnTMLg8Huy/ab14ItGK7RBRWySRn8vljNClQXvjbmZ2dVEykA1Z5bpTwK5stcJ4EfUF+OKjWKOA3TcyR9OIt35UfNMd0uWtbn0tsECrA+dkKBkqfKhQM9at1sRiN70mdfZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FGPmmguv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D968C433F1;
	Sun, 24 Mar 2024 23:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321848;
	bh=q9cK5+CVva2zWZ5121iREcxRFvY+SrqSNGS/pgZCZmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FGPmmguvyrp8rlzMGBskQf22i33mNxhRA8bGNpN67VYKZp4lSDMk0yHnlFLnB+W8s
	 yqBWUKPYAy7pujKoqRpPfbz+BnswpQQxzeqiD2LPbBF9a/Hp+EHrtu7DSLvaamuRlE
	 QdKEMWILlNAOJaL+KNdzGxSgJahgbjxpMx6i8kicUVpx3VvP+SrfS4hwwFtJDfhGAP
	 1pWkb9/0tlqA3QScjQimloU8a09602JVQE/KzyyEzHD7ko1PUuZJjVJ3uyVHV8F9Pg
	 rrh8ArViqKVZICxKmRwq0gyMRJPzpCQ7AWZ5qGNwfZjqhAsH5WohJ1Eyxkhty6Wk7v
	 H4/4WNGsOZR/Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peng Fan <peng.fan@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 576/638] thermal/drivers/qoriq: Fix getting tmu range
Date: Sun, 24 Mar 2024 19:00:13 -0400
Message-ID: <20240324230116.1348576-577-sashal@kernel.org>
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

From: Peng Fan <peng.fan@nxp.com>

[ Upstream commit 4d0642074c67ed9928e9d68734ace439aa06e403 ]

TMU Version 1 has 4 TTRCRs, while TMU Version >=2 has 16 TTRCRs.
So limit the len to 4 will report "invalid range data" for i.MX93.

This patch drop the local array with allocated ttrcr array and
able to support larger tmu ranges.

Fixes: f12d60c81fce ("thermal/drivers/qoriq: Support version 2.1")
Tested-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20240226003657.3012880-1-peng.fan@oss.nxp.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/qoriq_thermal.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index ccc2eea7f9f54..404f01cca4dab 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -57,6 +57,9 @@
 #define REGS_TTRnCR(n)	(0xf10 + 4 * (n)) /* Temperature Range n
 					   * Control Register
 					   */
+#define NUM_TTRCR_V1	4
+#define NUM_TTRCR_MAX	16
+
 #define REGS_IPBRR(n)		(0xbf8 + 4 * (n)) /* IP Block Revision
 						   * Register n
 						   */
@@ -71,6 +74,7 @@ struct qoriq_sensor {
 
 struct qoriq_tmu_data {
 	int ver;
+	u32 ttrcr[NUM_TTRCR_MAX];
 	struct regmap *regmap;
 	struct clk *clk;
 	struct qoriq_sensor	sensor[SITES_MAX];
@@ -182,17 +186,17 @@ static int qoriq_tmu_calibration(struct device *dev,
 				 struct qoriq_tmu_data *data)
 {
 	int i, val, len;
-	u32 range[4];
 	const u32 *calibration;
 	struct device_node *np = dev->of_node;
 
 	len = of_property_count_u32_elems(np, "fsl,tmu-range");
-	if (len < 0 || len > 4) {
+	if (len < 0 || (data->ver == TMU_VER1 && len > NUM_TTRCR_V1) ||
+	    (data->ver > TMU_VER1 && len > NUM_TTRCR_MAX)) {
 		dev_err(dev, "invalid range data.\n");
 		return len;
 	}
 
-	val = of_property_read_u32_array(np, "fsl,tmu-range", range, len);
+	val = of_property_read_u32_array(np, "fsl,tmu-range", data->ttrcr, len);
 	if (val != 0) {
 		dev_err(dev, "failed to read range data.\n");
 		return val;
@@ -200,7 +204,7 @@ static int qoriq_tmu_calibration(struct device *dev,
 
 	/* Init temperature range registers */
 	for (i = 0; i < len; i++)
-		regmap_write(data->regmap, REGS_TTRnCR(i), range[i]);
+		regmap_write(data->regmap, REGS_TTRnCR(i), data->ttrcr[i]);
 
 	calibration = of_get_property(np, "fsl,tmu-calibration", &len);
 	if (calibration == NULL || len % 8) {
-- 
2.43.0


