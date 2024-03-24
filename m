Return-Path: <linux-kernel+bounces-115378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F880889B2A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AD802A547C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3B11F618D;
	Mon, 25 Mar 2024 02:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ehJkzSIt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CEB83A1F;
	Sun, 24 Mar 2024 22:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320639; cv=none; b=ask6HEjn0TMSpetrrPJvnNyCxMboBkvKYSm3rsmy77g+cGgsk2f5+aAy3oapqydqFv0EyT3WUE/jbUy/ZVi1waKtp4udJsvMz3fqgE7QkcO6uGKD0PEyy8TDARymi/PbgrDiHBKg8qn8ijSbnNRbHYPhbJNrLr73ceNfCj1u4t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320639; c=relaxed/simple;
	bh=LokX5o72x0ED+b2JNMAGsU0bHH90SPf3RnjM0uqF/ys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RpqcwtjFevHR4R9LDiQO4Zstzi2BWYjrjDRX9eXQou7dzs2G+NI13hwtagvxQ4ScI+JP6ImJyTaj2ADPT5PcIbX5T5NsP0KH48igwBerSDqpxu6LhwBNaWk2F4uBDYwe3nzqSSsTvh24iaolnEvj9wQ1luNMDUDeHwKAsyXul9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ehJkzSIt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3722EC433C7;
	Sun, 24 Mar 2024 22:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320638;
	bh=LokX5o72x0ED+b2JNMAGsU0bHH90SPf3RnjM0uqF/ys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ehJkzSIt3V3b4dXBUnMMSMdU7EsSG6SjHKkK7g7a8KkBjpli+JsdkyvY0dY6XyUo+
	 iocBQEDryV0rce1USQaiLTCmlJr8MsMxTj88BZ79NVDhCsqRa8m962+EN+FwmfA08d
	 n0hP/6fP7XA5uTYFQWT5rogDlf8LyVTh3q2OoaZyTIJPGFe49kvqxsugNno3z6pPh5
	 mGx1scHc/RqtH0KiH3fo9r5ODyTQhVlD6dKwWK2iZoTiE8KOC+1Pi2aDSRJ4ZmBZvo
	 hP0342OBCs8TMgsdj32f5xjwgZxzBvY/7faSmoE2IhCrljHCEr1Yl/BxOmbyk1++5Y
	 zsbwMfxKobi8Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 200/713] pwm: atmel-hlcdc: Fix clock imbalance related to suspend support
Date: Sun, 24 Mar 2024 18:38:46 -0400
Message-ID: <20240324224720.1345309-201-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index 07920e0347575..584288d8c0503 100644
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


