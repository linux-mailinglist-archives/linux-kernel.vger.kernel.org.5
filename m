Return-Path: <linux-kernel+bounces-9618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 724D581C884
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 11:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CD4A286D3B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 10:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED46D15ACC;
	Fri, 22 Dec 2023 10:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="llKWctkZ";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="fo8v5dvS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BA5156C4;
	Fri, 22 Dec 2023 10:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1703242021; bh=S3TdkYP2WghBFHy35jL/ROGvth6643mc86CxxDgb1U8=;
	h=From:To:Cc:Subject:Date:From;
	b=llKWctkZv4YXmaxVOF9OKSKxzPicte/5tLmA3UC+X1dm+y4jaf4hqqUOYgpeLb+Cf
	 8F/6mX7rcEqJbiFxwn8hBKr6XfbOatNC9Nvgjn469N1E/hDI6e+O+/XsQ0jOVAfbo/
	 HpJphrAmKk0xtTPRY6FhzZlzoy7MPzGNVVIWlyNCUt8dy854xoeAFHQnRS9B9Eun9h
	 /Ckc2R9ELoCqZNB0bL8J4I4V1ItuREUYYhaRL0xwOJb6SR/PammSO+wVSYh+yNfFqL
	 8BMMQvbRz7jzh5Qijo87HbFdKLG3x7nV9g3EDq1wp4wbHPFIl+5vWSKe3zPZibAgkb
	 2tRMZrsr2l4tQ==
Received: by gofer.mess.org (Postfix, from userid 501)
	id C424B1009FC; Fri, 22 Dec 2023 10:47:01 +0000 (GMT)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1703242019; bh=S3TdkYP2WghBFHy35jL/ROGvth6643mc86CxxDgb1U8=;
	h=From:To:Cc:Subject:Date:From;
	b=fo8v5dvSUCgr8MIUEOxgdZZeY146rwQuo9A8VEI4kkJCThHrjjsN/3OROrZnDrsEz
	 jxqjs8Tmc1fcYma2x+rAAKUmvMQowixuUVuQoUEC4nL+95fVw5jyMvabXmji1mUtqn
	 Z6ENDQUsCF7XGNZXaVKNzHKcjCoXflFdR5nzywpo4zB9T0PUka+6SB0hLi2KvtAE6h
	 GhS8hmA9Iy28/tDj8nM3ivCyLgjW9Z2hLOqIxn3SMccgWnmQSz07VgUQSZo2hE6O3K
	 i/entkExxaVWEP60GtBZK+pYRiTxU0QK9gcMCxAQOl/fjpnkiDJrOK/qj0jTBneegu
	 mfzJxGUDy4/gg==
Received: from localhost.localdomain (bigcore.local [IPv6:2a02:8011:d000:212:ca7f:54ff:fe51:14d6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gofer.mess.org (Postfix) with ESMTPSA id CDA5C1000CC;
	Fri, 22 Dec 2023 10:46:59 +0000 (GMT)
From: Sean Young <sean@mess.org>
To: Thierry Reding <thierry.reding@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>
Cc: Sean Young <sean@mess.org>,
	linux-pwm@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] pwm: bcm2835: Duplicate call to clk_rate_exclusive_put in error path
Date: Fri, 22 Dec 2023 10:46:51 +0000
Message-ID: <20231222104651.167821-1-sean@mess.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

devm_add_action_or_reset() already calls the action in the error case.

Reported-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Closes: https://lore.kernel.org/linux-pwm/fuku3b5ur6y4k4refd3vmeoenzjo6mwe3b3gtel34rhhhtvnsa@w4uktgbqsc3w/
Signed-off-by: Sean Young <sean@mess.org>
---
 drivers/pwm/pwm-bcm2835.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-bcm2835.c b/drivers/pwm/pwm-bcm2835.c
index 307c0bd5f885..283cf27f25ba 100644
--- a/drivers/pwm/pwm-bcm2835.c
+++ b/drivers/pwm/pwm-bcm2835.c
@@ -160,10 +160,8 @@ static int bcm2835_pwm_probe(struct platform_device *pdev)
 
 	ret = devm_add_action_or_reset(&pdev->dev, devm_clk_rate_exclusive_put,
 				       pc->clk);
-	if (ret) {
-		clk_rate_exclusive_put(pc->clk);
+	if (ret)
 		return ret;
-	}
 
 	pc->rate = clk_get_rate(pc->clk);
 	if (!pc->rate)
-- 
2.43.0


