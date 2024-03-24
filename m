Return-Path: <linux-kernel+bounces-115303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32615889B85
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B343B3269B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EC91D5F79;
	Mon, 25 Mar 2024 02:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHB52tM0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CD5482F4;
	Sun, 24 Mar 2024 22:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320496; cv=none; b=fzILjs1rWINnjy7kp8zOB1H2gyDkmYn0a/MXlPDGMPsglESZoNckyu7XZnVP6cSjFqg9m3Sdrfvp+J0+Nq6qo0sTvdx8W5o4WCrmRFBHFN23atC2XrUmuXXgpLdT/B7r0rT78pUtnGl6xy21g8d90tKkGg4GtvA64b9FcrI0pac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320496; c=relaxed/simple;
	bh=56cDsqFOGwW5Ckc+DVvS50eIfweND0EvI8zRDNwLbWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cXdfU/OBRZccwg2mABm0eCkkQFdypxRco7zWf9klraOFXXcaCjduY1KpoKgB0gyhtxBmiyt1XFGYL7LTPdz2V1Pp3mCFYCYof+qWi9i+zwcvHROYQB5YZ/5iyqyfaNJeoaWvKyclNoEs8IRVY89+TUcZECQVES3sy75PiwZwO+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHB52tM0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C23FC43399;
	Sun, 24 Mar 2024 22:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320496;
	bh=56cDsqFOGwW5Ckc+DVvS50eIfweND0EvI8zRDNwLbWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GHB52tM0Nzg1JR2/TQoqlh9wJpKBac7dPqDJcM7Ty4peXCszti8rYQ2vx6L9ikd2p
	 aQ+WX42gr2ecS05eElhwmaAr+nMu1o1Ol9zkN9M1rtrfJ/yFCfcQA2rhMcJyHtu4PF
	 SCwmpel0FKmR4rXyMwgX9tuFdUQ1mqgf7JJcNAqLCbxhgTFWmNR2F8Fo6t+HeMKXxJ
	 txIca3M6jPq0BnVcx/411LCmSVVuaCT5xiSW3/uaZR945WPAuRWlOAGPkE4+WS1vVx
	 n06n+GWO7BtGvVz/JGu7aZr6S9th40mnHWkgSbn50jWaFxtHB8FWmvTt63ChnidkYv
	 jGaWjLR0Fcf2g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 055/713] spi: cadence-qspi: add system-wide suspend and resume callbacks
Date: Sun, 24 Mar 2024 18:36:21 -0400
Message-ID: <20240324224720.1345309-56-sashal@kernel.org>
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

From: Théo Lebrun <theo.lebrun@bootlin.com>

[ Upstream commit 078d62de433b4f4556bb676e5dd670f0d4103376 ]

Each SPI controller is expected to call the spi_controller_suspend() and
spi_controller_resume() callbacks at system-wide suspend and resume.

It (1) handles the kthread worker for queued controllers and (2) marks
the controller as suspended to have spi_sync() fail while the
controller is unavailable.

Those two operations do not require the controller to be active, we do
not need to increment the runtime PM usage counter.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
Link: https://msgid.link/r/20240222-cdns-qspi-pm-fix-v4-4-6b6af8bcbf59@bootlin.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-cadence-quadspi.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 4b2d42e54f568..1a8d03958dffb 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1949,8 +1949,24 @@ static int cqspi_runtime_resume(struct device *dev)
 	return 0;
 }
 
-static DEFINE_RUNTIME_DEV_PM_OPS(cqspi_dev_pm_ops, cqspi_runtime_suspend,
-				 cqspi_runtime_resume, NULL);
+static int cqspi_suspend(struct device *dev)
+{
+	struct cqspi_st *cqspi = dev_get_drvdata(dev);
+
+	return spi_controller_suspend(cqspi->host);
+}
+
+static int cqspi_resume(struct device *dev)
+{
+	struct cqspi_st *cqspi = dev_get_drvdata(dev);
+
+	return spi_controller_resume(cqspi->host);
+}
+
+static const struct dev_pm_ops cqspi_dev_pm_ops = {
+	RUNTIME_PM_OPS(cqspi_runtime_suspend, cqspi_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(cqspi_suspend, cqspi_resume)
+};
 
 static const struct cqspi_driver_platdata cdns_qspi = {
 	.quirks = CQSPI_DISABLE_DAC_MODE,
-- 
2.43.0


