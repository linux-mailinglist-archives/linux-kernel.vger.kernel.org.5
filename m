Return-Path: <linux-kernel+bounces-113529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2208C88850F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE4CC286310
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF9F1BF51E;
	Sun, 24 Mar 2024 22:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UfwJkYbz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D4F1BF503;
	Sun, 24 Mar 2024 22:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320331; cv=none; b=OxwwBGitsvwSQySZIq1LhqZGh3KubxXgIzyHWZP3xDPsDWIWmh6DKNtQEFvzR7SiMhBeeBz6zJAgI8ElA2f0nID5wPU/iumzTLwEZhxGoFSc48br31beTgu4P6sxXOYIhd/ITjU87+27ZsNUYLN1ISrDh+5d7p1UX0p/zH2/aUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320331; c=relaxed/simple;
	bh=q9cK5+CVva2zWZ5121iREcxRFvY+SrqSNGS/pgZCZmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SKY7ULGow0g57gcGqKJ2gnmA1xRsnundoTX4P0gT/Cut2Gj2C3q6NweS7hARCGjDO8LurbJhOpRo4wUkZPRnuX3OD8QjOpeaIQqdM8+D9vgf8XsqxiQdDoCAvFGU6g9R5yfmhfUpLVvquwszhQpCDG5YYnoDkL7u7CH+ZMdafXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UfwJkYbz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49CA4C43390;
	Sun, 24 Mar 2024 22:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320331;
	bh=q9cK5+CVva2zWZ5121iREcxRFvY+SrqSNGS/pgZCZmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UfwJkYbzltux2Oj9D+w6gNybp7/lnuQ3tEVKe4jg9koyQpvXsiEY76PYv103wwns6
	 Mr/7qOV5orOsoqsW8B+3zeb4w6IsoRHPRCFVbHdkIh7qE3Myp0Bt0lX2alb1zRbz2l
	 ft/PfoAdHenK3gNpUz7wvSpC0aGHrKAT7uvmRNPMY7bkDdlkMTkl3/JpxoZ0UcNinj
	 +v7Yxo0Y539p1C706B61vqeqNTlgi1TWa/pNcBR6Hs0dpULlRLJtOrUQL46mN/HTOO
	 +IwW1QR+ttQhEm0Oaw0Gx6l3LxeSKTTKppySLHkCWkW6xOplyvAS1OAVF/ps9w4M0/
	 z1OVUs+c0UX1w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peng Fan <peng.fan@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 638/715] thermal/drivers/qoriq: Fix getting tmu range
Date: Sun, 24 Mar 2024 18:33:37 -0400
Message-ID: <20240324223455.1342824-639-sashal@kernel.org>
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


