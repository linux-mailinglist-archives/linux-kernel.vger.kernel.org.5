Return-Path: <linux-kernel+bounces-113026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7379F8880E0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EFB21F2234D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B007713959C;
	Sun, 24 Mar 2024 22:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JkRT/sJh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2C413957F;
	Sun, 24 Mar 2024 22:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319837; cv=none; b=P6cxjsWX1ich3w7+79KSSpB/DHVtWW7/NrxWgtdaZ/Xqd9wBu1aEp2qpsDzknt3paUjko/z1GisVy3hbvbxIXRPxp0kOiwtGqB6H2My9ASiQBTqweeaiRJtZGn/4Atz1S29Nj1RWajpHHu2veLwEx4KCD+szbggpDGOHO79MhhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319837; c=relaxed/simple;
	bh=BlrEduLhK8IxCF6Js5m5Yhu9/N1eH5XB7begusWkerc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cVYst828vWVzSCSol9xKNGpraYmQUpZukBwtXDXiDIqSXENE64df+SvfAlsYudxf3taPszwir2hnSHzZmRqxJ99HnqL9IMJcqvQL7Sp1oP5tfEfgWzEzRvte4pau53ltljj28AOQ0vYXileag0rkmXG7FhNkPmyse6M1NNH53Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JkRT/sJh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEBE6C43330;
	Sun, 24 Mar 2024 22:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319836;
	bh=BlrEduLhK8IxCF6Js5m5Yhu9/N1eH5XB7begusWkerc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JkRT/sJhkbfnPTT7h+DA5Va7EQ+YlEEMqkGcZlpe6WIQ+eRbikfTrqmfmLjgPckwd
	 0FT+X6CTxHY7casZeyfgelUyNyIAUmXjv4TSMFye2KCUnE1W/zPYODGSw2OSip5U1o
	 onDecMXyuNVTzNpl5i0t2DgmQ2d3UpfK7cOgTSwLLVLbAWbEfde28R6fLfk/QT8Muj
	 zMatPHyCst+Mrqe9jMb0RcKjFdb8iwqTM3NZzyKZH/El1g7EFq7RdfSy5fuwwwk1Sr
	 96qp6lRORPy4cslMvOmAS+q6YtzFGgOTXoSaiz18aRIZ/MYPOT66Df7e9NLC9vO/e/
	 CqgbVuaEUVU9w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 139/715] pwm: atmel-hlcdc: Fix clock imbalance related to suspend support
Date: Sun, 24 Mar 2024 18:25:18 -0400
Message-ID: <20240324223455.1342824-140-sashal@kernel.org>
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
index 3f2c5031a3ba8..1f6fc9a9fcf3e 100644
--- a/drivers/pwm/pwm-atmel-hlcdc.c
+++ b/drivers/pwm/pwm-atmel-hlcdc.c
@@ -185,7 +185,7 @@ static int atmel_hlcdc_pwm_suspend(struct device *dev)
 	struct atmel_hlcdc_pwm *atmel = dev_get_drvdata(dev);
 
 	/* Keep the periph clock enabled if the PWM is still running. */
-	if (pwm_is_enabled(&atmel->chip.pwms[0]))
+	if (!pwm_is_enabled(&atmel->chip.pwms[0]))
 		clk_disable_unprepare(atmel->hlcdc->periph_clk);
 
 	return 0;
-- 
2.43.0


