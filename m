Return-Path: <linux-kernel+bounces-33928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF93837040
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF68C1F25537
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE7E60DD1;
	Mon, 22 Jan 2024 18:08:33 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF756089F
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 18:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705946912; cv=none; b=UWNBZMgkWbaoKEoeFfm/uHpj0BwvWSbOl+cyv/I/okuiZIiSWv5/Xqq1N+BJapFdyieFxY6yFqwokMhGh3YEE26EZA0MYz+/Ft8C+9U61JZrXd6suAMIOr5bnsxbht4fOpUCNl+U+OtxqMMegV/ejddlRJLIczrbqfxuShuC5wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705946912; c=relaxed/simple;
	bh=CT6mvx5MJLTpMbmu0NWGpTT+pYXsbShqSkc7JqmqXeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LE5sLlFaydgxE5VYfJ7MNsQEUYoZeUTwsVDf/C5URnQKN15PtqYkLKJ8DZ7bQ3HtyqaWmimhVACCHXNNc1Ezr3ZSb/oOtLcABuC2XqiZjeLda5etDnVNo7QoPL0WR9cDfIAxAMjW+yNODIJn43ecDhbhe1AmKX4cbYz8X53Bths=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiT-0001lQ-HX; Mon, 22 Jan 2024 19:08:13 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiS-001ePF-Ra; Mon, 22 Jan 2024 19:08:12 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiS-005Zwm-2S;
	Mon, 22 Jan 2024 19:08:12 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: kernel@pengutronix.de,
	Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: [PATCH v2 01/33] fpga: ice40-spi: Follow renaming of SPI "master" to "controller"
Date: Mon, 22 Jan 2024 19:06:56 +0100
Message-ID:  <62dce856652735aee45875325fe67a983ce0217d.1705944943.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1705944943.git.u.kleine-koenig@pengutronix.de>
References: <cover.1705944943.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1144; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=CT6mvx5MJLTpMbmu0NWGpTT+pYXsbShqSkc7JqmqXeM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlrq7E/sL5DoPQSDlOukasGqhLuAhZ65r9MjlCZ Xt+uBQMY/qJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZa6uxAAKCRCPgPtYfRL+ TrTWB/wO9zpn0hQi6pl9qxqHj4H+TWOyPJ3yO7coDr5AuP33ZJ62Cj2l5x2x5o8ijso2Yh0MPGQ URMbuiP3Jc5PNcNk1TgtKCBOsTSOw+LdUWKA7OOQaT5fxdBqwdV1YyNk05ZJ8ve8ZNwg1+Wr8LI VXL8xzUHEcBIaklZJSDxKw6bXM2oirDyzUoFLURfz5cRXYCZaKmSROvqJYT7YN0//EZUeKXUYkg ighY/cqEeosCrYr3ZwAygp8iolwgOgpcAfpEsCMCFy+2RmdFPDa7xd0azbdXhD9P0fjTe0VrCmB S+EjGJysfTvqm47CAI4hqMIgLKf5RcmoYBl/FYhRrHFr/E6g
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


