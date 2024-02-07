Return-Path: <linux-kernel+bounces-56934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5221B84D195
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AC8E28360A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BB0131E5F;
	Wed,  7 Feb 2024 18:43:33 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5B7127B4A
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 18:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707331405; cv=none; b=l/e7yA1U/yOWRMz1SbXXPp2oTBb+AVJqCL2Hj5Nh1Vra1bXqwyhfbtKgwbJJTowb5H253Cz5HRURclkfcasTi3OdKLt/QP7SSLaBQidA4MqPUJSOOvgkK3DZMgPE6RaesSFYLD57aAnMbJ0BmxsWWjS1COwJUWTHPgiqMh/HccQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707331405; c=relaxed/simple;
	bh=wUvKlZOylTR25ACwo1tz3FpcLw1cTa0qMahNcZYRNf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZkY5wXmbKAkLyBIfd6P/V3y5HXCiR45nMkHQqekQkcMGBak2yiuBNuWksB/DhT2kAGdFaLTMSLid0zaUvHoeKNkpAS7t/68yW6NV6Q1AqwGHDN4Mg68a+D/S7N2TXg+qrBeP4KXQt/NVysjpLXurF+kDvZiEI8U5AjSkCwzjDco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmt4-0007PG-4K; Wed, 07 Feb 2024 19:43:10 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmt1-0054Wq-JH; Wed, 07 Feb 2024 19:43:07 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmt1-00HRrk-1b;
	Wed, 07 Feb 2024 19:43:07 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: kernel@pengutronix.de,
	Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 01/32] fpga: ice40-spi: Follow renaming of SPI "master" to "controller"
Date: Wed,  7 Feb 2024 19:40:15 +0100
Message-ID:  <6a3ddedc955cf55dddbc68ccf5ff5e46af5e8b6f.1707324793.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1202; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=wUvKlZOylTR25ACwo1tz3FpcLw1cTa0qMahNcZYRNf0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlw86WUHAWkGcRfm4ejb22wIJkr4J5rq2dd4nnu y/Az1s+R7eJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcPOlgAKCRCPgPtYfRL+ TvfOB/0VlX4j2NqYav7kvi55bMy4jP6iZ3BIVkH0MRTghLES4nrb+1y5l4G/49O2EKKyPIW4iVs go4FGGmaiaNPY4RUMrddvye1xfL+JfeIJy/1TvY+kc4F094/W32Is0aoqpVvXw5RtuEnRNVQjMd 1K6kOOcg/fveKQ+rkk7YMlS/EzchGWPv7NIFg+la+rls+KqpPspsyJcHW4gamQE0tBlMLGKRxna oL1SM66D2wVkaEaon/Je5Jlo+8LTIeYZAk43xU/CGJsw5kEySsTm/S+iLwSTBkbXPwU3GLTJV1n /Af9dbfu5M4DV54F/wxpKUAWLRJIKBNvNobOQI8y7rKkhx0e
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

Acked-by: Xu Yilun <yilun.xu@intel.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/fpga/ice40-spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/ice40-spi.c b/drivers/fpga/ice40-spi.c
index 7cbb3558b844..c0028ae4c5b7 100644
--- a/drivers/fpga/ice40-spi.c
+++ b/drivers/fpga/ice40-spi.c
@@ -66,7 +66,7 @@ static int ice40_fpga_ops_write_init(struct fpga_manager *mgr,
 	}
 
 	/* Lock the bus, assert CRESET_B and SS_B and delay >200ns */
-	spi_bus_lock(dev->master);
+	spi_bus_lock(dev->controller);
 
 	gpiod_set_value(priv->reset, 1);
 
@@ -94,7 +94,7 @@ static int ice40_fpga_ops_write_init(struct fpga_manager *mgr,
 	ret = spi_sync_locked(dev, &message);
 
 fail:
-	spi_bus_unlock(dev->master);
+	spi_bus_unlock(dev->controller);
 
 	return ret;
 }
-- 
2.43.0


