Return-Path: <linux-kernel+bounces-78320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B34E28611D9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0C401C20D56
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26B77EEF9;
	Fri, 23 Feb 2024 12:46:13 +0000 (UTC)
Received: from smtp-bc0f.mail.infomaniak.ch (smtp-bc0f.mail.infomaniak.ch [45.157.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D241C7D40B;
	Fri, 23 Feb 2024 12:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708692373; cv=none; b=GWUw5fRmzE82Q2Pn8AVDtOPXff1YpM52iGIgGo+zRdhoqrczl/9qq/tgJjuU6sCOZfwHMDxBzeMGdnm99dgrv/e4FHeAdYUyEBp0wVjfhbwO5N/3JbsE7T7rJXL499FCzX3obRSZUCw+o8bqgf9ap0M419PUig+fM0XN6tq0VwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708692373; c=relaxed/simple;
	bh=O5J38fZMczK0MaBGKtlxx86NTATzdfRmyBIfc3ANxZg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rN44W+idMCz/GOllGdOoc7TibXocInSGNaPpsO+F6MyVTXafRWUDpAi/oyXGxCdjPzPnM2O0j5khEb6oVCKBd0qCz+5lS39te4K/eUZlbCHcmTMnTOvvZ6zWcrs2GB1uuWEJeA6P43SUXYFsRx4254b1VTtP1beuLHUHv9M+f9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net; spf=pass smtp.mailfrom=0leil.net; arc=none smtp.client-ip=45.157.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Th8rW0T5kzGlS;
	Fri, 23 Feb 2024 13:46:03 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Th8rV3HzMzw14;
	Fri, 23 Feb 2024 13:46:02 +0100 (CET)
From: Quentin Schulz <foss+kernel@0leil.net>
Date: Fri, 23 Feb 2024 13:45:23 +0100
Subject: [PATCH 3/3] iio: adc: rockchip_saradc: replace custom logic with
 devm_reset_control_get_optional_exclusive
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-saradcv2-chan-mask-v1-3-84b06a0f623a@theobroma-systems.com>
References: <20240223-saradcv2-chan-mask-v1-0-84b06a0f623a@theobroma-systems.com>
In-Reply-To: <20240223-saradcv2-chan-mask-v1-0-84b06a0f623a@theobroma-systems.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Heiko Stuebner <heiko@sntech.de>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Andy Shevchenko <andy.shevchenko@gmail.com>, 
 Shreeya Patel <shreeya.patel@collabora.com>, Simon Xue <xxm@rock-chips.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, 
 Quentin Schulz <foss+kernel@0leil.net>
X-Mailer: b4 0.13.0
X-Infomaniak-Routing: alpha

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>

devm_reset_control_get_optional_exclusive does what this driver is
trying to do in its probe function, therefore let's switch over to that
subsystem function.

Cc: Quentin Schulz <foss+kernel@0leil.net>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 drivers/iio/adc/rockchip_saradc.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
index 1c0042fbbb54..bbe954a738c7 100644
--- a/drivers/iio/adc/rockchip_saradc.c
+++ b/drivers/iio/adc/rockchip_saradc.c
@@ -450,16 +450,11 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
 	 * The reset should be an optional property, as it should work
 	 * with old devicetrees as well
 	 */
-	info->reset = devm_reset_control_get_exclusive(&pdev->dev,
-						       "saradc-apb");
+	info->reset = devm_reset_control_get_optional_exclusive(&pdev->dev,
+								"saradc-apb");
 	if (IS_ERR(info->reset)) {
 		ret = PTR_ERR(info->reset);
-		if (ret != -ENOENT)
-			return dev_err_probe(&pdev->dev, ret,
-					     "failed to get saradc-apb\n");
-
-		dev_dbg(&pdev->dev, "no reset control found\n");
-		info->reset = NULL;
+		return dev_err_probe(&pdev->dev, ret, "failed to get saradc-apb\n");
 	}
 
 	init_completion(&info->completion);

-- 
2.43.2


