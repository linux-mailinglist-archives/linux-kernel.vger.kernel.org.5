Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72857E4CA5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 00:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234821AbjKGXWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 18:22:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234038AbjKGXWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 18:22:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CE5D79;
        Tue,  7 Nov 2023 15:22:36 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A5B1C433C7;
        Tue,  7 Nov 2023 23:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699399355;
        bh=+CbiV6rpXCNM6vhS/PR5+TmIMmNSjDz1OXp5IClnHWY=;
        h=From:To:Cc:Subject:Date:From;
        b=ppLF/uAX6TCx6i0kRXOW+epaJ/1C9INp1UglbkanA6RtlUloLywiBg0Iuxtawgg9H
         2Tt6BPxkT3Xb6NOuIExSc5dNX8bGVDlRb6FPL/S4AFl+yPFcADIpPyfDxkahI4tXVf
         b4z9nprXsiifyxHq5/Rwp/WZRnvsyZkeKuYMJnCil0pZ5LpN7SD0WOTHG5zBDcKxJl
         F3HCFnaw+S/dsyKhL9Iy3iyN0rofoydLK2RWH91oIppExdX8QVTXMozO2C1LLeTHB8
         JUQz3VJSxq5HMHDyf3dF2nVDSal8c4xN4uXS9cUWfSjMm6jycqmkjJYP+KJ+RoQ4Ja
         pYMW8Wyk4aQSg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zhang Shurong <zhang_shurong@foxmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>, jic23@kernel.org,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        robh@kernel.org, u.kleine-koenig@pengutronix.de, frank.li@vivo.com,
        heiko@sntech.de, olivier.moysan@foss.st.com,
        linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 01/18] iio: adc: stm32-adc: harden against NULL pointer deref in stm32_adc_probe()
Date:   Tue,  7 Nov 2023 18:21:55 -0500
Message-ID: <20231107232231.3775605-1-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Shurong <zhang_shurong@foxmail.com>

[ Upstream commit 3a23b384e7e3d64d5587ad10729a34d4f761517e ]

of_match_device() may fail and returns a NULL pointer.

In practice there is no known reasonable way to trigger this, but
in case one is added in future, harden the code by adding the check

Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
Link: https://lore.kernel.org/r/tencent_994DA85912C937E3B5405BA960B31ED90A08@qq.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/stm32-adc-core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
index 2f082006550fd..bbd5bdd732f01 100644
--- a/drivers/iio/adc/stm32-adc-core.c
+++ b/drivers/iio/adc/stm32-adc-core.c
@@ -708,6 +708,8 @@ static int stm32_adc_probe(struct platform_device *pdev)
 	struct stm32_adc_priv *priv;
 	struct device *dev = &pdev->dev;
 	struct device_node *np = pdev->dev.of_node;
+	const struct of_device_id *of_id;
+
 	struct resource *res;
 	u32 max_rate;
 	int ret;
@@ -720,8 +722,11 @@ static int stm32_adc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	platform_set_drvdata(pdev, &priv->common);
 
-	priv->cfg = (const struct stm32_adc_priv_cfg *)
-		of_match_device(dev->driver->of_match_table, dev)->data;
+	of_id = of_match_device(dev->driver->of_match_table, dev);
+	if (!of_id)
+		return -ENODEV;
+
+	priv->cfg = (const struct stm32_adc_priv_cfg *)of_id->data;
 	priv->nb_adc_max = priv->cfg->num_adcs;
 	spin_lock_init(&priv->common.lock);
 
-- 
2.42.0

