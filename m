Return-Path: <linux-kernel+bounces-115806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EFA8894BA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE45E1F33BBD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF1426382C;
	Mon, 25 Mar 2024 03:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XSdK34xJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34A1145B1B;
	Sun, 24 Mar 2024 23:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322049; cv=none; b=MI56wPembiLKvAL+hDyc+l+v9qWCBcIsY78P+IqqENSS2Nq0tv//qUzOwPw+72LEcTcNuBendFVJFKYRnOIAafi87GT4J97mSJlknsTwX3W2Xx7l6n0gyYQ6m+PQVwDC1nm+lJHjlnIwrwZ+Z53/onSraw1M167OiQ/OFZSt4L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322049; c=relaxed/simple;
	bh=QoO5Sp3xDDn2Bel5GdHMW9VjYekzmEIYKOXYEG2rCNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cawQseDi5A+FbBSfEyxewvQl+MSXi5kZ7AjUF2Q+lCw9ijUuZVNTVLx9Mv13BQ9MN9NxnJQ9sQxFF1KuwJBT0GcI7ZxJKlV9FojVd1/jSLXOqf4cf/FpMwj9uCCIT61Q3EpqkS9ewgAcyIIt4FSK2A653M9RXTXaYytOLi+TVm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XSdK34xJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B6AC43399;
	Sun, 24 Mar 2024 23:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322048;
	bh=QoO5Sp3xDDn2Bel5GdHMW9VjYekzmEIYKOXYEG2rCNs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XSdK34xJfZ8FtQBFKAHvTyWSWJI7HBvckqEc3cZ3Ynq0plpT968BT18F0WDBPLEYD
	 YYXl9aDtELMjImfB5LvIxsHV8qsYId5mv2wEb9/3jAaIVszIFxfNnM55maKAF+/FMg
	 yGtsHR13IFQ1e9XYL4p3ELPcIxxttBI5K9YxQriAhYBazT/SNZjRFPaoIE3svcMQpY
	 Vi2SShpsf5Ai/JMGGgHZ64FAzV4Txi/s91ZUIP19fv33ipdC+8BGloW3+OijBq5WBO
	 RLc1ANgLNElMJjCloo7l/rqL768q7J422sF0vh6qwfO1YCwxYqhR8ygTSXd5lGquDv
	 XJA4NmSk2dNrw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Claudiu Beznea <claudiu.beznea@microchip.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 121/451] pwm: atmel-hlcdc: Convert to platform remove callback returning void
Date: Sun, 24 Mar 2024 19:06:37 -0400
Message-ID: <20240324231207.1351418-122-sashal@kernel.org>
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

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 5fce94170ad8a67b839f3dd8e8e8a87039ba0251 ]

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is (mostly) ignored
and this typically results in resource leaks. To improve here there is a
quest to make the remove callback return void. In the first step of this
quest all drivers are converted to .remove_new() which already returns
void.

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Stable-dep-of: e25ac87d3f83 ("pwm: atmel-hlcdc: Fix clock imbalance related to suspend support")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pwm/pwm-atmel-hlcdc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-atmel-hlcdc.c b/drivers/pwm/pwm-atmel-hlcdc.c
index a43b2babc8093..96a709a9d49a8 100644
--- a/drivers/pwm/pwm-atmel-hlcdc.c
+++ b/drivers/pwm/pwm-atmel-hlcdc.c
@@ -278,15 +278,13 @@ static int atmel_hlcdc_pwm_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int atmel_hlcdc_pwm_remove(struct platform_device *pdev)
+static void atmel_hlcdc_pwm_remove(struct platform_device *pdev)
 {
 	struct atmel_hlcdc_pwm *chip = platform_get_drvdata(pdev);
 
 	pwmchip_remove(&chip->chip);
 
 	clk_disable_unprepare(chip->hlcdc->periph_clk);
-
-	return 0;
 }
 
 static const struct of_device_id atmel_hlcdc_pwm_dt_ids[] = {
@@ -301,7 +299,7 @@ static struct platform_driver atmel_hlcdc_pwm_driver = {
 		.pm = &atmel_hlcdc_pwm_pm_ops,
 	},
 	.probe = atmel_hlcdc_pwm_probe,
-	.remove = atmel_hlcdc_pwm_remove,
+	.remove_new = atmel_hlcdc_pwm_remove,
 };
 module_platform_driver(atmel_hlcdc_pwm_driver);
 
-- 
2.43.0


