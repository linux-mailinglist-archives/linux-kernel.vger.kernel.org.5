Return-Path: <linux-kernel+bounces-114765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65684889112
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 972C31C2CFD7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533A41B149B;
	Mon, 25 Mar 2024 00:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUnooDrj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8CB27551E;
	Sun, 24 Mar 2024 23:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323364; cv=none; b=A1KGhCDSXtGSqa8HRChgxjHJgktiPPzFX+oVgCZtqrRZqEaUJ3EvZQKM2FktJiGgWzZeUENT7ho+3rjbfoNDExSLjTT9Qp5lAHHXqonNmKsnLapECmpByPqz0oi7vYj4mgyQ/9qqDDUtKZs+EVXj9f/ieOCzjX+rPXQNJ83C4+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323364; c=relaxed/simple;
	bh=tSvBj+9fAZrbZVQNSGQIlc8MnLUWAHjaR1WzNmMgebM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CtplJrlCJW+nbygsSKoqe+UwWzhXTvqbC4FhmtYA2MvTmFTwQnfNf/9fdK2UokY8LI8buFyW9Lycm1MaIr34R21DMIfnlAeHtdhNmgtDGaB2swjJyOuRwwqx4+elp0I/8at0OaqMfDvMc8A8MG+G61F6eW9EiTVHBevuia8mFhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IUnooDrj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A4C4C43394;
	Sun, 24 Mar 2024 23:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323363;
	bh=tSvBj+9fAZrbZVQNSGQIlc8MnLUWAHjaR1WzNmMgebM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IUnooDrjBp3qpM0cZHfdlzKnyBHBxHTQ226CEmv4RL0QZcE0JosafliPs18BC/5h9
	 eVN0XcLQrIYtdN7IPqpzESjdIoj6HJsbSb2UhBvubzaOoaSty75+mEdH8vVm15iEj5
	 DS0j6hxxONBXkfmH/2b3Eb5Lzkxn/NSXRMavcztsmmL52q6kjNysnz1w12R9Ey7oIr
	 2HCEaLDM4X1WGIiGmcAtAvLdR0CBj763SrOJ/SutsGRWSZKCIjHtQ83cpCetdYWwYW
	 8bIoc6llgCOvpYHI8ZMQnwU98vsaisCwjpLGADXQ0OLX92q6I0lMQqSoDiN/GOsy/a
	 iW3YEl5YGaL4A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 063/317] cpufreq: mediatek-hw: Wait for CPU supplies before probing
Date: Sun, 24 Mar 2024 19:30:43 -0400
Message-ID: <20240324233458.1352854-64-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index 8a4e52b22eed7..4a7478a91fb61 100644
--- a/drivers/cpufreq/mediatek-cpufreq-hw.c
+++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
@@ -13,6 +13,7 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 
 #define LUT_MAX_ENTRIES			32U
@@ -268,7 +269,23 @@ static struct cpufreq_driver cpufreq_mtk_hw_driver = {
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


