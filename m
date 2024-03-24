Return-Path: <linux-kernel+bounces-115813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D195A8894BD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B99B29618A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FF0375F22;
	Mon, 25 Mar 2024 03:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4xxVllg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C194D145FEF;
	Sun, 24 Mar 2024 23:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322051; cv=none; b=iQOjBux9rBMYVW1+e/CQ/nFypihDAlvk2qyETb3SFXKLEKeTTqOvw9d9vo/Nj8WoPUnNwmyyyNl/vaTBCzRJc+8ssnshuR3t49F/dY4YfsGRQXNQnUy+zITabTGI16s6nGkXHJXQkKlVNObg/SO9fHBHum+ucHurmc0qkpKyEPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322051; c=relaxed/simple;
	bh=1ITZQsOA5uH5mLhtqE6Q6ShPQIh0iAuove/4OFBVZ0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CWHGiQYBqYiL3DnDrUE1uBXWsLiwfzyUZDpxSk803HKLRwIRHSF4OYrd19gTmJbqxcuggAW9SF+u98ifSshv2AJWSZEBJU9+v7SFQI/Tc5LPSZrvd9E1nzx/NyPhOg+9QtvwF/tIbYMkK8vIaPaQRDCevNvhwqWqMtgeP3ylAss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4xxVllg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BA40C433F1;
	Sun, 24 Mar 2024 23:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322050;
	bh=1ITZQsOA5uH5mLhtqE6Q6ShPQIh0iAuove/4OFBVZ0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O4xxVllgJI/Dg5iewAS6lHrG8U8duildQtvDMRUnvPLVTWJ4IcXZyjdi9JzIWlNNA
	 PSbyJwHbS903YzApB+GKjZIE87uWP/XjZl9F48DaUi03TDbf5h48vU/RCx8jw8ig6R
	 YKWQpJYUBRtElTtvyt/jjtN8p2fAgplyNCwaKp2oKrkW+9e71BwV5B9kPB2Uam4Cse
	 XCfApfAj1ZhkG8/uo0iSjFljx9CARSeWB8RgmVKx2ivxYhkm6DxGh2wpUNrxMul4L1
	 PVXpuhe9EqeLhD3ahPMnAdeF12PxjMnaHeNtyR6xbza0FjwX992B02/g8+JNx7Z83i
	 hRRhNfM8SmbWw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 123/451] pwm: atmel-hlcdc: Fix clock imbalance related to suspend support
Date: Sun, 24 Mar 2024 19:06:39 -0400
Message-ID: <20240324231207.1351418-124-sashal@kernel.org>
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
index 4d0b859d0ac13..3e9c94a8d7f72 100644
--- a/drivers/pwm/pwm-atmel-hlcdc.c
+++ b/drivers/pwm/pwm-atmel-hlcdc.c
@@ -186,7 +186,7 @@ static int atmel_hlcdc_pwm_suspend(struct device *dev)
 	struct atmel_hlcdc_pwm *atmel = dev_get_drvdata(dev);
 
 	/* Keep the periph clock enabled if the PWM is still running. */
-	if (pwm_is_enabled(&atmel->chip.pwms[0]))
+	if (!pwm_is_enabled(&atmel->chip.pwms[0]))
 		clk_disable_unprepare(atmel->hlcdc->periph_clk);
 
 	return 0;
-- 
2.43.0


