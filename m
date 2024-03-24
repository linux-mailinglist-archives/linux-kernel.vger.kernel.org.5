Return-Path: <linux-kernel+bounces-115835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D04A88994B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C94BEB438CF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF033709E7;
	Mon, 25 Mar 2024 03:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g40Kce4+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B147145B24;
	Sun, 24 Mar 2024 23:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322026; cv=none; b=dJkkO6QHGWoZ2ftf+xI5ZjLBOQxG8WL7C2m8NjDnqVd74vsedwvJSNy+jMS7KqvEm7DDk49M58B6ohY+7sWZ9icoWuRvIjuDxO6fChdBSwWBCxF+b4GD1Hxr7TuOr8eKsKfyEEIPwCNqlACTt5ocRHcIimdqqlzlH71ZUyNfhz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322026; c=relaxed/simple;
	bh=AG23bdc6T+HcriaBH5aprj0FR+KrOH33r/hrRR9Hni4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O+FgZxrNvyvRx37OopOInFKnfuH7GCNVLWG7MsE1uVOQnhmEnkQnWodGCKsOVZgPcAUVF1NvDaI8RhrLW8utOTyBFcDqDuV9LQbWHHm43V3ty0B0PlMaYviyVEQWP96jZ0SiyorScoWeKLe5+cAFYjZAIfkmBtYEFGPQgNg00SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g40Kce4+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F21C433C7;
	Sun, 24 Mar 2024 23:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322025;
	bh=AG23bdc6T+HcriaBH5aprj0FR+KrOH33r/hrRR9Hni4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g40Kce4+3HgKGpHHoG10idS7xmXRZ6yUenH4seQlLCVfc2BZW99sk+EHH4M9kJXo1
	 HOrs9q258+w8yuHGJlajfLQ/WyFsOyV2AkjYkGgwajP0RHtDfVdk/CPkqS6lqrIfZ7
	 SQauGPtshH/WjO9dKOsr3bS6fbHrfcg2Jv8+F+U4IBA7S5UR8HnVT1WhP+XO/aSzaJ
	 v1iq2iHlO2il/B6fiXVPuD2L30CB8O0xcatWrOwle7jS1honLdZFkzxg6oAtXUlQ8h
	 XVdrVRP42Qenz+YOdMwdOYJec5VcRutj6Ir7PzDfbSAIxPfMmpctMvVenT1gI5u5Yr
	 KzNkn2qBgNcSQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 097/451] cpufreq: mediatek-hw: Wait for CPU supplies before probing
Date: Sun, 24 Mar 2024 19:06:13 -0400
Message-ID: <20240324231207.1351418-98-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Nícolas F. R. A. Prado <nfraprado@collabora.com>

[ Upstream commit 788715b5f21c6455264fe00a1779e61bec407fe2 ]

Before proceeding with the probe and enabling frequency scaling for the
CPUs, make sure that all supplies feeding the CPUs have probed.

This fixes an issue observed on MT8195-Tomato where if the
mediatek-cpufreq-hw driver enabled the hardware (by writing to
REG_FREQ_ENABLE) before the SPMI controller driver (spmi-mtk-pmif),
behind which lies the big CPU supply, probed the platform would hang
shortly after with "rcu: INFO: rcu_preempt detected stalls on
CPUs/tasks" being printed in the log.

Fixes: 4855e26bcf4d ("cpufreq: mediatek-hw: Add support for CPUFREQ HW")
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/mediatek-cpufreq-hw.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/mediatek-cpufreq-hw.c b/drivers/cpufreq/mediatek-cpufreq-hw.c
index 212bbca8daf32..42240a7d826da 100644
--- a/drivers/cpufreq/mediatek-cpufreq-hw.c
+++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
@@ -13,6 +13,7 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 
 #define LUT_MAX_ENTRIES			32U
@@ -296,7 +297,23 @@ static struct cpufreq_driver cpufreq_mtk_hw_driver = {
 static int mtk_cpufreq_hw_driver_probe(struct platform_device *pdev)
 {
 	const void *data;
-	int ret;
+	int ret, cpu;
+	struct device *cpu_dev;
+	struct regulator *cpu_reg;
+
+	/* Make sure that all CPU supplies are available before proceeding. */
+	for_each_possible_cpu(cpu) {
+		cpu_dev = get_cpu_device(cpu);
+		if (!cpu_dev)
+			return dev_err_probe(&pdev->dev, -EPROBE_DEFER,
+					     "Failed to get cpu%d device\n", cpu);
+
+		cpu_reg = devm_regulator_get_optional(cpu_dev, "cpu");
+		if (IS_ERR(cpu_reg))
+			return dev_err_probe(&pdev->dev, PTR_ERR(cpu_reg),
+					     "CPU%d regulator get failed\n", cpu);
+	}
+
 
 	data = of_device_get_match_data(&pdev->dev);
 	if (!data)
-- 
2.43.0


