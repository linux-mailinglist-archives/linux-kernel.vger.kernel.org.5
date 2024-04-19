Return-Path: <linux-kernel+bounces-151800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0028AB402
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 18:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E406B1F212CB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6251386C0;
	Fri, 19 Apr 2024 16:59:24 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A89C4C63A;
	Fri, 19 Apr 2024 16:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713545964; cv=none; b=LQL5riu+q+stfSgxbFoGm8jmxHll6iubkGqy1X7GtVldx9c30Kv98U7ESqFFDJwKoDWEbgVI0T7OchJzIhWsYOe72NIiZdGcOGOqjWE5t6Dbtsvb3UHOT0Tc3cFNBqDgdg/cn/QHtRCfGWOxFl84bxCLBIj+tbBgHjMXXtZZRaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713545964; c=relaxed/simple;
	bh=cCw3To0crIlEWMlxy5XePe+u1HZtbjc8kkBOUA1C/0I=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=V41cYB4/oFcn8BhlTg1NhiBojepwDynq/pBTn3u/6QDEUdOXEqEx4WjMpgSKTd5D7f2SBsmWqUJHzLxKazLoh2UZOiVvEi+LQxW2v9wmFwmlyrSG7w9/sBKCqrIWVqwUddzx2W6oEUnAsNMH3yDnY4mxvJs7lDfXJdcknjMjt/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.97.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1rxra0-000000007Nq-26mP;
	Fri, 19 Apr 2024 16:59:16 +0000
Date: Fri, 19 Apr 2024 17:59:07 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] cpufreq: mediatek: Add support for MT7988A
Message-ID: <acf4fb446aacfbf6ce7b6e94bf3aad303e0ad4d1.1713545923.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

From: Sam Shih <sam.shih@mediatek.com>

This add cpufreq support for mediatek MT7988A SoC.

The platform data of MT7988A is different from previous MediaTek SoCs,
so we add a new compatible and platform data for it.

Signed-off-by: Sam Shih <sam.shih@mediatek.com>
---
 drivers/cpufreq/mediatek-cpufreq.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index a0a61919bc4c..518606adf14e 100644
--- a/drivers/cpufreq/mediatek-cpufreq.c
+++ b/drivers/cpufreq/mediatek-cpufreq.c
@@ -707,6 +707,15 @@ static const struct mtk_cpufreq_platform_data mt7623_platform_data = {
 	.ccifreq_supported = false,
 };
 
+static const struct mtk_cpufreq_platform_data mt7988_platform_data = {
+	.min_volt_shift = 100000,
+	.max_volt_shift = 200000,
+	.proc_max_volt = 900000,
+	.sram_min_volt = 0,
+	.sram_max_volt = 1150000,
+	.ccifreq_supported = true,
+};
+
 static const struct mtk_cpufreq_platform_data mt8183_platform_data = {
 	.min_volt_shift = 100000,
 	.max_volt_shift = 200000,
@@ -740,6 +749,7 @@ static const struct of_device_id mtk_cpufreq_machines[] __initconst = {
 	{ .compatible = "mediatek,mt2712", .data = &mt2701_platform_data },
 	{ .compatible = "mediatek,mt7622", .data = &mt7622_platform_data },
 	{ .compatible = "mediatek,mt7623", .data = &mt7623_platform_data },
+	{ .compatible = "mediatek,mt7988a", .data = &mt7988_platform_data },
 	{ .compatible = "mediatek,mt8167", .data = &mt8516_platform_data },
 	{ .compatible = "mediatek,mt817x", .data = &mt2701_platform_data },
 	{ .compatible = "mediatek,mt8173", .data = &mt2701_platform_data },
-- 
2.44.0


