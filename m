Return-Path: <linux-kernel+bounces-56930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 778CE84D185
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9D391C21B54
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48DA1292F4;
	Wed,  7 Feb 2024 18:43:25 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE98285C4F
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 18:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707331404; cv=none; b=ItN5F9Hwo6G5DMoX5oyis/S2YnGn8767+qImG8XyM9T1NZ6uKYrZ9ekMf4S+2lruK+OQ/gJv5l9cuofslCzLChMjXRAgscZfORX7KhaYjDKC7w6zINtISKptMK3B+SLaKvdJyEgGVf92FJ6P48sTPAqGY4UvsoqyQLT3sTYTigE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707331404; c=relaxed/simple;
	bh=eaa/MnI0DUDOZ12mwRQxd64w0nmqvV1lJGMXGlfIdDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CHsXt2avDaqYjwiuhdke4BT6AYW0peLOKPNxt5h1SYjW0B/B4A9tGY7CKo2N6+oFypycLQLzJ1htCiqnSFPYF+11M9oNuDnfqw7oP2FKMVSR0lzZqhW9+9XTMRqTlyIlKZcOXc4dlBnJAlRlgY90m02baji/x9NhIcnLs+C21KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmtA-0007mn-Bb; Wed, 07 Feb 2024 19:43:16 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmt9-0054Y8-VT; Wed, 07 Feb 2024 19:43:15 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmt9-00HRtD-2t;
	Wed, 07 Feb 2024 19:43:15 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: kernel@pengutronix.de,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 21/32] spi: loopback-test: Follow renaming of SPI "master" to "controller"
Date: Wed,  7 Feb 2024 19:40:35 +0100
Message-ID:  <2f57c89d601d0875cd245a2e95c915b9bfcfc47d.1707324794.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1707324793.git.u.kleine-koenig@pengutronix.de>
References: <cover.1707324793.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1142; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=eaa/MnI0DUDOZ12mwRQxd64w0nmqvV1lJGMXGlfIdDw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlw8641Pe+KdDSJAh2X8RAmDm8QNhzSllf38cQK ARB/tjhJFiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcPOuAAKCRCPgPtYfRL+ Tu9VCACKxH+TxatW/iKQ1TPthFJ1VJEQS5Oi0IQmKYZrj3L2fn2uRf0/Zo4QxpBgxuDmbi2B8DH r7kKvxo3GlfghaS+qjedeyDDxU/Mh5W54c5m4rCV+baTyG1HUkhIwWzb7BIeDlSQEdBgVGfYhM3 dZscvUuqNJW08c0XJzDBzBnKxI4umgz8FnccpU+zv/5x/yBZJH/g8yjQgb8Pbt2/Laf+nmaNZ9L yCCvXv1uyAjCIBJsHyZq/sTfLATujsISB84PWrnjE1hB69qVYl4MiQCxCbMt+01Knb+PHQDDEZ4 zo+ypQ5yCwxW2NESg/3KjnFhZ6JdkMYXLKFE12859+VFx+bn
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

In commit 8caab75fd2c2 ("spi: Generalize SPI "master" to "controller"")
some functions and struct members were renamed. To not break all drivers
compatibility macros were provided.

To be able to remove these compatibility macros push the renaming into
this driver.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/spi/spi-loopback-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index bbf2015d8e5c..fee8893d2751 100644
--- a/drivers/spi/spi-loopback-test.c
+++ b/drivers/spi/spi-loopback-test.c
@@ -1031,8 +1031,8 @@ int spi_test_run_test(struct spi_device *spi, const struct spi_test *test,
 #define FOR_EACH_ALIGNMENT(var)						\
 	for (var = 0;							\
 	    var < (test->iterate_##var ?				\
-			(spi->master->dma_alignment ?			\
-			 spi->master->dma_alignment :			\
+			(spi->controller->dma_alignment ?		\
+			 spi->controller->dma_alignment :		\
 			 test->iterate_##var) :				\
 			1);						\
 	    var++)
-- 
2.43.0


