Return-Path: <linux-kernel+bounces-33936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D41EF837050
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AD2E1F2BFCB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B8E62A0A;
	Mon, 22 Jan 2024 18:08:36 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0D960EEB
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 18:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705946914; cv=none; b=hKHUCcJdiJOiGKU9WPwDw6WvdNkt++lJ1zpgPuqz0ctHFOqyVplyvqRZW0aN1Ai0DDYnG/u55ftifkvTdDqh8LIztzqrwIAcxfVZHtMOxLeoINiKJskk58QmJeyWPkx2onlCBYibADaBUJhRcfpG4OGo5Br640Xvgk7H2SMVJVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705946914; c=relaxed/simple;
	bh=+iqzpfPfwM8JLJkorLSCUBZld3eFtgJC2EACC7dzGUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WDOlHknBua0Ki2Nt5FQqbWSYhqvZDovLVZUDSS79HKSaMK6qlMRLbPf6HAK9OyB9/sVfBfOYMPV4L7xwM9u12LbYBGjlaPliSMJd3fNyml+6wEIj6bwMN5FpVTvZsf5zle+d1xNS8A0SEy8JzMfHMErJJkx01GuBDyZbiISbvZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiX-0001yg-Rp; Mon, 22 Jan 2024 19:08:17 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiX-001eQW-1z; Mon, 22 Jan 2024 19:08:17 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiW-005ZyF-37;
	Mon, 22 Jan 2024 19:08:16 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: kernel@pengutronix.de,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 21/33] spi: geni-qcom: Follow renaming of SPI "master" to "controller"
Date: Mon, 22 Jan 2024 19:07:16 +0100
Message-ID:  <62a1745954aab076ab05e9b02aad6fbd63176c45.1705944943.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1141; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=+iqzpfPfwM8JLJkorLSCUBZld3eFtgJC2EACC7dzGUs=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlrq7bYHxk635tTZIlGrZqUFmwFO4wXkKUnT1Z4 W0Tbo6upv+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZa6u2wAKCRCPgPtYfRL+ TjHkCAC1NOHuyVQojyy+s/JSNPgJFwWA8GlsPSTcCRSSU/OZili1bD4PZpWp/Po1i0+90glzV2L UMcm2bfPel6O6JlFmJiG2HrpBQrBeFvS4neiNCRzn89yd3uTZ1ImN8jSIH6ZOtO248TopI9TOiu zFGlhqqP6B5igJRbXnEALglCF88pgOxtoXqED3W2R3FjyjmUAqRo0QsB9Os4iyn7wh8rRWiMN8q 9ApowptkKJqemKr+1vHxpHGaddxcH8LTuNJ+lFtdmQ4XJ+dPCAexRzL3H5G2BK2LF5GhDrE6moD VeqFhkSD4dlqIwsQkeM0qyVoEOU3nYPSOHg3K9FQKl+S7PjM
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


