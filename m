Return-Path: <linux-kernel+bounces-70863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C4C859D6D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5E63283286
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 07:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6FC22325;
	Mon, 19 Feb 2024 07:46:42 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B149E208B9
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 07:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708328802; cv=none; b=o9SwOayLXY3Y1h/b6wwxzqtOvxDGadWqcSxoR0z6c3N/B05boAZiRu+8AkqGsvGArNlRcd0I9QgfuvSTsFURu+Pj9JMkQDwUXI+ib90w8Xw2+ralRvUqHklJa/MgmICOS4Ww47LBlhzpNmDlo8HKZR8kxpGB5DPfYjErOAgAmdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708328802; c=relaxed/simple;
	bh=QZqbPBhPYmmHIl+LVwHKgs3Du4oSnfjsBLIeKUtJ4R0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mW7YMM7pn2JAX6TCZLthJwciU8ECbrBwIzXB5tEHq4x7htDffTVd/WLqUh4iS8uyGt8Qb88Tzv3RtbGNWrHO5D0p375Xex0dPLHuYQVefSkVQa+B3cDET+ALHuHjDIr51mR+yKnouN+PvhaknmtNG3h0buOLkdv/q1oiL5Zi5W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rbyMH-0000QD-TM; Mon, 19 Feb 2024 08:46:37 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rbyMH-001bHu-Gb; Mon, 19 Feb 2024 08:46:37 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rbyMH-007bvV-1P;
	Mon, 19 Feb 2024 08:46:37 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thorsten Scherer <t.scherer@eckelmann.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] siox: Don't pass the reference on a master in siox_master_register()
Date: Mon, 19 Feb 2024 08:46:29 +0100
Message-ID:  <1e8d09d17848e58e8fc6a46278b5e8fb0cf4618a.1708328466.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1708328466.git.u.kleine-koenig@pengutronix.de>
References: <cover.1708328466.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1309; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=QZqbPBhPYmmHIl+LVwHKgs3Du4oSnfjsBLIeKUtJ4R0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl0wdWQIu5tDnIFdc4N1sCtCpl7yfMajaokhN6X zhaCNQH6vaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZdMHVgAKCRCPgPtYfRL+ TmucCACzAy5qlIT/7W4Sm4FWw3zBPiSj1dbaIYxgNHhkg4SB+a8KSq2XtyAx2Rl76t1DKcrrohc oqlSrwKqMOJ5+bW7uRZArvofTevc3xNiGPLsUHOYuRqWUMEDRHo+8wo//phN3noWK7j0IQaW+A/ BytMKxoYFadNh99eR8l1b49XiQKAJRuLIZar6dAFAAohwT50v8oKYBhCfh8D4EO2DHrPZLqPvYF RzgrcPvZwQyHbvrgcDOCPDKdDicPZsraXEhCepcpOJyHXmy4QZGffp9eiQDPIAJ5PtAenaLrNCX I5iKqhL/1cCcmZO9Myf6pHypVYQO86Xn4BsqGZCsBa7OCa9K
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

While it's technically fine to pass the ownership of the reference on
a struct siox_master from the caller of siox_master_register() to the
framework this is hard to use. Instead let the framework take its own
reference (that is freed in siox_master_unregister()) and drop the bus
driver's reference in its remove callback.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/siox/siox-bus-gpio.c | 2 ++
 drivers/siox/siox-core.c     | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/siox/siox-bus-gpio.c b/drivers/siox/siox-bus-gpio.c
index aeefeb725524..fdf20fe80059 100644
--- a/drivers/siox/siox-bus-gpio.c
+++ b/drivers/siox/siox-bus-gpio.c
@@ -149,6 +149,8 @@ static int siox_gpio_remove(struct platform_device *pdev)
 
 	siox_master_unregister(master);
 
+	siox_master_put(master);
+
 	return 0;
 }
 
diff --git a/drivers/siox/siox-core.c b/drivers/siox/siox-core.c
index 561408583b2b..d4acab7036d6 100644
--- a/drivers/siox/siox-core.c
+++ b/drivers/siox/siox-core.c
@@ -717,6 +717,8 @@ int siox_master_register(struct siox_master *smaster)
 	if (!smaster->pushpull)
 		return -EINVAL;
 
+	get_device(&smaster->dev);
+
 	dev_set_name(&smaster->dev, "siox-%d", smaster->busno);
 
 	mutex_init(&smaster->lock);
-- 
2.43.0


