Return-Path: <linux-kernel+bounces-114781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 148B388912B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C49A3294E9B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48B21B488D;
	Mon, 25 Mar 2024 00:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BYlBG8Gs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7AF2762A5;
	Sun, 24 Mar 2024 23:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323384; cv=none; b=jMJ+m53x6bPzfF6wS7go8d764/Yxovxm9SFGSFKofQ2TqgcbLerwT9/bNJWfLWlWdGhBNzjDdZsCoxXMlV31QhP60xjE3UdCRXTL6YBOJ4PuBMuSIjCHDX+VojL5Prwr7Eh6H7heYBe/kFRMzJkPyq4kh4A+fdxuddlATS0oqFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323384; c=relaxed/simple;
	bh=1ITZQsOA5uH5mLhtqE6Q6ShPQIh0iAuove/4OFBVZ0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=elgZPr1knSrkBeJr2dCmgwQBMszReOvs6gjXUrBANsMVA11tyoIHks32xg3K/NIbKM/weuXeswIU17q9MUXiorX2yn+ip7MWK95wMLgZ2P939hInGn7Yuh5NlbylxLoOWaijIsy3GF9WjuxpVZ+VVrOu2MZpCFKN50PwJeM4ocg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BYlBG8Gs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE940C433C7;
	Sun, 24 Mar 2024 23:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323383;
	bh=1ITZQsOA5uH5mLhtqE6Q6ShPQIh0iAuove/4OFBVZ0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BYlBG8GsihYRNzP7lNvsTaG4kLZc9VvRfTniNN5uqShYRquuCoT5G8XYvD81YfJy2
	 YcV2GyknBaYEYGXafBMDnsYWfWipJIwPADtOo3yhA3ClX5dgpcasdHYFDgmp7uqyo/
	 vpIpnLOBIRZaLJsXHAOsBpf5+g9D1yWzFKsoreKS7+gSZaqPjx/ymDvWtuRZMrXZ3R
	 q0niAHLLJW2yKlFnH6x0FvmlprcIuice5jnyol66cMIx3+tt0cfQ2BIw2UmVtYX0d6
	 80OXda3wWw9hXyzC2cyc2Xx0WeEzKSpGVGiwn2u5+T5sIBdwcUjksCp1YtAnDWuUCz
	 M2V5HmDHek2Ew==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 083/317] pwm: atmel-hlcdc: Fix clock imbalance related to suspend support
Date: Sun, 24 Mar 2024 19:31:03 -0400
Message-ID: <20240324233458.1352854-84-sashal@kernel.org>
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


