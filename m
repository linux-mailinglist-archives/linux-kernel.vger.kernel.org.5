Return-Path: <linux-kernel+bounces-129294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2496D89684B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D25B8281F8B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D0F12AADA;
	Wed,  3 Apr 2024 08:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QxNDM2If"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F806EB5A;
	Wed,  3 Apr 2024 08:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131810; cv=none; b=u59flcTFd2Ao5W86Azb2aAbN9eWH8wEsKV6RMo2TdSAZ/e3O3iA0SiWWtzhoZaBsXQ7aOtUarPlLkBYks0QLkCUj6JKEBt+jMzn+3jKxa1zyPMPTTE62+5oMKcAMAj/5DJ63EoYfIOB/wHIfD80TVODqRw7tM8CoQpHaFgRJCkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131810; c=relaxed/simple;
	bh=YUxw+JSGkdgbd3oVvBLP3CDDX0jDK0CN6nzZN82wE/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b2sLcPCdWyyNcJzFO7HyFiwdk8Rfy2seCjqAm5EqbvkX5NcVxrc1CggJvPPPbIFNaSWGxZyuZvOx5KIlXfcxa5xk/0aehtU9aNENd7E9ttaq/QKMCD2bmaCPco/AMrpx931AIW31Wp5hzTFUGJ27/9uKKlr/FpImdvCGFMEVFPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QxNDM2If; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60198C433C7;
	Wed,  3 Apr 2024 08:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712131809;
	bh=YUxw+JSGkdgbd3oVvBLP3CDDX0jDK0CN6nzZN82wE/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QxNDM2IfgT/4LkCcNfSjOYfKZDCIRGle4NjtwhZAuoqhvWzogfXiRev/PqTRZhzDh
	 k1vHDrkUkJeg913HGLd1qMPO3mkyUBeXasBYHJuAOrJt7hmMZpUx6xtnLKbB/wDAXf
	 Cw+C1mKhcgvIrsfrRrF8t/RQ2fAz2r1hPIcs2l66EZI5HcfklM5F3QTYka7ATJtwTg
	 kwzQHrn1JbnF67VZPrHr/RA8GOOJts3+KlUBRw3bDql0tKsoOS3MQSyexR+7wxMcHy
	 pq+Vlmfro/x/aSUqT2H4tHU5Xvxuo7QXtj6Ir0PvOveBI96WjN8bXSV0M+yxOhuS43
	 bmPGJLUttko+w==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kernel@vger.kernel.org,
	Vaibhav Hiremath <hvaibhav.linux@gmail.com>,
	Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev
Subject: [PATCH 17/34] greybus: arche-ctrl: move device table to its right location
Date: Wed,  3 Apr 2024 10:06:35 +0200
Message-Id: <20240403080702.3509288-18-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240403080702.3509288-1-arnd@kernel.org>
References: <20240403080702.3509288-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The arche-ctrl has two platform drivers and three of_device_id tables,
but one table is only used for the the module loader, while the other
two seem to be associated with their drivers.

This leads to a W=1 warning when the driver is built-in:

drivers/staging/greybus/arche-platform.c:623:34: error: 'arche_combined_id' defined but not used [-Werror=unused-const-variable=]
  623 | static const struct of_device_id arche_combined_id[] = {

Drop the extra table and register both tables that are actually
used as the ones for the module loader instead.

Fixes: 7b62b61c752a ("greybus: arche-ctrl: Don't expose driver internals to arche-platform driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/staging/greybus/arche-apb-ctrl.c | 1 +
 drivers/staging/greybus/arche-platform.c | 9 +--------
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/greybus/arche-apb-ctrl.c b/drivers/staging/greybus/arche-apb-ctrl.c
index 8541995008da..aa6f266b62a1 100644
--- a/drivers/staging/greybus/arche-apb-ctrl.c
+++ b/drivers/staging/greybus/arche-apb-ctrl.c
@@ -466,6 +466,7 @@ static const struct of_device_id arche_apb_ctrl_of_match[] = {
 	{ .compatible = "usbffff,2", },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, arche_apb_ctrl_of_match);
 
 static struct platform_driver arche_apb_ctrl_device_driver = {
 	.probe		= arche_apb_ctrl_probe,
diff --git a/drivers/staging/greybus/arche-platform.c b/drivers/staging/greybus/arche-platform.c
index 891b75327d7f..b33977ccd527 100644
--- a/drivers/staging/greybus/arche-platform.c
+++ b/drivers/staging/greybus/arche-platform.c
@@ -619,14 +619,7 @@ static const struct of_device_id arche_platform_of_match[] = {
 	{ .compatible = "google,arche-platform", },
 	{ },
 };
-
-static const struct of_device_id arche_combined_id[] = {
-	/* Use PID/VID of SVC device */
-	{ .compatible = "google,arche-platform", },
-	{ .compatible = "usbffff,2", },
-	{ },
-};
-MODULE_DEVICE_TABLE(of, arche_combined_id);
+MODULE_DEVICE_TABLE(of, arche_platform_of_match);
 
 static struct platform_driver arche_platform_device_driver = {
 	.probe		= arche_platform_probe,
-- 
2.39.2


