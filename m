Return-Path: <linux-kernel+bounces-114144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D7D8888B1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DC9F28712B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B7C2433F9;
	Sun, 24 Mar 2024 23:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GdeqTxHd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D84203713;
	Sun, 24 Mar 2024 23:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321454; cv=none; b=Q38Ocnz2FSNET0t9EfnO3itNZv8/IpzBFNP9AfVl67bBDZuUwmBWf8SFRUkiMKWCBb7seFuJ1jBN56GkcD3OiMy/EvVgRMkUutYUQwG+8cVcZFNrZIVmZv2ZZP1rmxnRAw2A1IMnAAyzoOQbLs0S+j8NutspO9+Xb/DSMK5axuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321454; c=relaxed/simple;
	bh=Oiu632mGq/gNH95p8sCfzl69n+4w/oqp+rE0iSyKxjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dm6028q1hGfXqHEueXEp+yUoI9Ej6MDtrZzjB/QdvHLaLgkzvnguqutzLfpVZ9DoK1Vr4vO8xCM/BaxeGzEhPv/YEGhG+On9RJXo58slVcOiX3J1Btd7W7yVQhcyoI5dOFdfUzskyb4Nth7zo5MGzy8WN3vUEZm5/ZTQHDzy7AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GdeqTxHd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06224C433C7;
	Sun, 24 Mar 2024 23:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321453;
	bh=Oiu632mGq/gNH95p8sCfzl69n+4w/oqp+rE0iSyKxjU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GdeqTxHd7k4dx8UUMcHS34Wrxp94biVxminVSkH0hvHLckiBZBojWdJuPTYZFVwN1
	 4gSCREIVXuQlJQynKLqFz+Y8f3z5zeBnxzGyvW65mXVykYMPuDLry4XxuXIgUU95GF
	 CbEs3f8ezX0/ojlIlaowGdC1B7MFta47wZ3WcGd1f5gcaPJ3uRWfCKS/f/xCkK1I9f
	 eY9Fdtnu3FRuoofaAblynt4PW45jyu7iaTGfxyZPEwcl1+HbmLnAhW9jVjqtMbYbIr
	 8BccyokNSzcAA347NVX8fkoIPZkv3HZxyKgDBy+en2PMWGwaGZ27eiNfhLn2xBUTQ2
	 THZ9bscWTjVaw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 178/638] pwm: atmel-hlcdc: Fix clock imbalance related to suspend support
Date: Sun, 24 Mar 2024 18:53:35 -0400
Message-ID: <20240324230116.1348576-179-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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

[ Upstream commit e25ac87d3f831fed002c34aadddaf4ebb4ea45ec ]

The suspend callback disables the periph clock when the PWM is enabled
and resume reenables this clock if the PWM was disabled before. Judging
from the code comment it's suspend that is wrong here. Fix accordingly.

Fixes: f9bb9da7c09d ("pwm: atmel-hlcdc: Implement the suspend/resume hooks")
Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Link: https://lore.kernel.org/r/b51ea92b0a45eff3dc83b08adefd43d930df996c.1706269232.git.u.kleine-koenig@pengutronix.de
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pwm/pwm-atmel-hlcdc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-atmel-hlcdc.c b/drivers/pwm/pwm-atmel-hlcdc.c
index e271d920151e4..5f6612e1dd34d 100644
--- a/drivers/pwm/pwm-atmel-hlcdc.c
+++ b/drivers/pwm/pwm-atmel-hlcdc.c
@@ -187,7 +187,7 @@ static int atmel_hlcdc_pwm_suspend(struct device *dev)
 	struct atmel_hlcdc_pwm *atmel = dev_get_drvdata(dev);
 
 	/* Keep the periph clock enabled if the PWM is still running. */
-	if (pwm_is_enabled(&atmel->chip.pwms[0]))
+	if (!pwm_is_enabled(&atmel->chip.pwms[0]))
 		clk_disable_unprepare(atmel->hlcdc->periph_clk);
 
 	return 0;
-- 
2.43.0


