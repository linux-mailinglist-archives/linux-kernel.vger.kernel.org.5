Return-Path: <linux-kernel+bounces-56943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A19E84D19C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CB2A1C250B3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA001339B6;
	Wed,  7 Feb 2024 18:43:33 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07381129A62
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 18:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707331409; cv=none; b=DiKK3IoAJL3UrFMBtSwoWIDTkrGLHurzp+53NzMl1qZ/KJcAccp+Xwr17K/0uVHhjoDFQYrILpoBi8yGNIvPm3jNi7qwm9LIXCJmGAZdKd+0TUYaUzi8C47Kb6vcAhUwBmsKqmuSK7anm2ZzMTrMbvYt4EhlenaBin4pjewijXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707331409; c=relaxed/simple;
	bh=sedoM7CcQ8yhtvlljO6KHXwExG+ci9r0NNv85ipsCl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QTX/vSjSV56ym3+ChrLFoMb5HXNqFE3zQq5kzEoZI72HnPxjSricFvIZ0NlyN2axnsb+F45weRsTMh72p+qUiNXzawsUT8UasqgZwkXixke4xjgYqzf4A9JGFCHk1botxcM9/I1eg2NhfgnAsWEz5LZQi7JPK+HbbKGUoor01Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmtA-0007mb-4g; Wed, 07 Feb 2024 19:43:16 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmt9-0054Y4-O6; Wed, 07 Feb 2024 19:43:15 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmt9-00HRt4-29;
	Wed, 07 Feb 2024 19:43:15 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: kernel@pengutronix.de,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 20/32] spi: geni-qcom: Follow renaming of SPI "master" to "controller"
Date: Wed,  7 Feb 2024 19:40:34 +0100
Message-ID:  <895f9a42691dcea037b30dcce5e61be0b44e3a25.1707324794.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1199; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=sedoM7CcQ8yhtvlljO6KHXwExG+ci9r0NNv85ipsCl8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlw86xAk1vvboMlXWACn8sl31yuENXIP7NREKjb lCzErfnaq6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcPOsQAKCRCPgPtYfRL+ Tq2uB/wIpbY6Y0vKbaPylLEMNFlZogoOP/fMCAFoGCAFhQU74nd6pLUmsqiFgJbs2VZ61KypDvL UDcQ8Ir3EDF2fseBjbdSb0Kj86jTopRJzfnjtzjuerGhrXWi3kzmSr0wfbl44n6nY/Z/AyeJXmn bpNw7Hn2uN6RZyQxEZ7z5OhQ5ylTEDwbTuRsvD407knRpm3xT+KCHg+151Ls55fnbbME4l39Spu 8jdNCVJwHUVtUAIAX9W4Uqv3MSFv0eQdUwifDB8kLllhTpC0GV8LSL5XZ6SkVyMC7reON8v5ohg at0IhQuOOOTINYb8eaRfE7BtBUtSF3XMRjFISyo4naNawlnU
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
this driver. This was already tried before in commit 8726bdcef62e ("spi:
geni-qcom: switch to use modern name"), that's why this change is so
small.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/spi/spi-geni-qcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 15f84e68d4d2..37ef8c40b276 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -647,7 +647,7 @@ static void spi_geni_release_dma_chan(struct spi_geni_master *mas)
 
 static int spi_geni_init(struct spi_geni_master *mas)
 {
-	struct spi_master *spi = dev_get_drvdata(mas->dev);
+	struct spi_controller *spi = dev_get_drvdata(mas->dev);
 	struct geni_se *se = &mas->se;
 	unsigned int proto, major, minor, ver;
 	u32 spi_tx_cfg, fifo_disable;
-- 
2.43.0


