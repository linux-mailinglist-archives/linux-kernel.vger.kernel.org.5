Return-Path: <linux-kernel+bounces-112967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA7F888020
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E653AB22950
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7A140BE3;
	Sun, 24 Mar 2024 22:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Py55qTDL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202AD1292E3;
	Sun, 24 Mar 2024 22:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319779; cv=none; b=MKALo1B9EkEK4IKzCLqYnuYJ+RYo3hrYyqaodLFFBn7+HCoTa+NwRn3C2bSfUfcx3aNKBoi6oCopp3hAKuYt2ogvo/+ujx98ehphTAHRb+5t74CX0LhuCz4qMb4T49UQB/45c45O6vEvFg9G6EzeY1wjZT2n9ugCvFu4yzPuyGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319779; c=relaxed/simple;
	bh=yo2Z2RP8nH+NEKT0SUBmtftPM/25colUC9zO2Yovi1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p0nGN5B5LpfUWCOx4jX5gowyzYWEiaWdLCDLkFV81buoKThaAYP7WVDCuAmzE0+TRh/tdzUSRcYS840z1hinzYmGVlPsYz1PtUiY3c5umpVZtVHp6F0qfEehqoMXRn1FdBlhUXKngi3EJeoWcDrD/qTVHLH5Z9N/9yFwxdETKh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Py55qTDL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9A25C43399;
	Sun, 24 Mar 2024 22:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319778;
	bh=yo2Z2RP8nH+NEKT0SUBmtftPM/25colUC9zO2Yovi1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Py55qTDLnp4Cka0kJJBwaLJmzy59kAZAxgjV8nRDnzbKPntaqRHDHxPIHtNKpag92
	 4n6VSgb9L+PzB/a0se0PQWw6PGshpf6670O0NVuS7eL/Os7bESzHNNXLOZvGRact1Q
	 LlmDD4BC2Mep9cTfyLAL0zJMIuXCP0PTMxaHTRQaO9amwCkPWuRFNxYIcZBEaptzMH
	 LXKwVEVu2m0x4R8PxiUhyNN0qGdbp8heSsWMlMISQYYuPzzfNz5kcvJZDN9TdYtTd/
	 IN5lzMc2k1k7SUPMnO6yzLb7YE4CVFfK9gGULUccvZ2yTwJCWJRm7LB0f+sP+hV4hp
	 JvfnIi52xfuUA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 080/715] cpufreq: mediatek-hw: Wait for CPU supplies before probing
Date: Sun, 24 Mar 2024 18:24:19 -0400
Message-ID: <20240324223455.1342824-81-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index d46afb3c00923..a1aa9385980ae 100644
--- a/drivers/cpufreq/mediatek-cpufreq-hw.c
+++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
@@ -13,6 +13,7 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 
 #define LUT_MAX_ENTRIES			32U
@@ -300,7 +301,23 @@ static struct cpufreq_driver cpufreq_mtk_hw_driver = {
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


