Return-Path: <linux-kernel+bounces-114776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9254889350
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9863AB2DBE4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090321B884E;
	Mon, 25 Mar 2024 00:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WV15budV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CD2276292;
	Sun, 24 Mar 2024 23:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323382; cv=none; b=OKzy4l/RrrfqFsfCyKzuvBhRAvRcyjY2GMziTeCeqb9BTZh0hviUH3onE69CFFFyPH4BQQb1r0DgCP1HwzqyC3kxRWcF+nFsTJj+NxCrYDMGMkevk8mk3Bf81y7z+b1ZP7m1LC1gU2yE1eU+9OhwkmMwESGyW4AB//br//+8tPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323382; c=relaxed/simple;
	bh=QoO5Sp3xDDn2Bel5GdHMW9VjYekzmEIYKOXYEG2rCNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QAfjOwCHQcGrDa/Ufykyd964svXLWdsE8iq6JvgQHY4YertYUMTtMj3lEwV3CaBLtwfA7u/9x5KyByJvw54NRcRx5bISe4t2XVpIFn5XCy5rl5YU8VZXS58k21J+PSPsM33Bmegu+Nlt2pO0yyI8dlCOLfOPbH4aIN4ecfe6aXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WV15budV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F88C43399;
	Sun, 24 Mar 2024 23:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323381;
	bh=QoO5Sp3xDDn2Bel5GdHMW9VjYekzmEIYKOXYEG2rCNs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WV15budVLWQPVb1JDXjQXEIBp79QDY9LCB0eM3xR5DDQ2LngNYWAF3IA9QGo/y9fC
	 rW/APraGlKjS2GsU0ax1sXl8iHHJHIox6143t/gKzGwYM/wOlTrGaqbgdGcrql8X4o
	 EI9FT9g2EIG7VVjlNz9ZCzt52YDa9Snry9jZgrw1u0NdhPbUpoVDNkJGmkKP/5e0Bh
	 dhzmr80p4xRc/Mo1Gfqymfe8FGGDxZak9UOhuXzTI8pWkJEsKAXLqWGS2hLWiDRmwQ
	 VDjH1btU2t2TzqbEIzdK0yQXkuwuB1cWcFWKQMTsVNhphoixmIgrRLrYM0ze2af8GJ
	 oXR2+rZ4XiH7A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Claudiu Beznea <claudiu.beznea@microchip.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 081/317] pwm: atmel-hlcdc: Convert to platform remove callback returning void
Date: Sun, 24 Mar 2024 19:31:01 -0400
Message-ID: <20240324233458.1352854-82-sashal@kernel.org>
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


