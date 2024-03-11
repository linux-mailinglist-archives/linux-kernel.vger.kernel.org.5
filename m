Return-Path: <linux-kernel+bounces-99055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 446278782EC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D95F0B21648
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C277746551;
	Mon, 11 Mar 2024 15:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OV8pnm4U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D48482D7;
	Mon, 11 Mar 2024 15:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710169957; cv=none; b=jwfiV72hl2XrJx6LwL62zC1Hmhnqo+PJvUKWoWPCu9sF+/dFwsxtncoEp/04U5OUzcuckx+BMWXyogDcx9elEBBxy5Xjq0/2xaMRdZnkt1wPPZHp9owFayRH95ngimpe352ymPaoe+fE76zzKW6zjmWHL0wA+dtAud0H3Me6j54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710169957; c=relaxed/simple;
	bh=56cDsqFOGwW5Ckc+DVvS50eIfweND0EvI8zRDNwLbWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O0/FtRla34y8OOFbDqv3M17T0NUyhlFHsVyAy0M6Gpo/gBccC8GP+hRTOxqaAWLt9ximTR0LWE0o8SylwHwhjPoYmMk61tz/+5OX/HTuokgsb567MM6ZqL48+10r3gi51494FKD0kz1KOP/Cjq4stZa5bvUSngxwiiv+vujTHZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OV8pnm4U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8FB8C43394;
	Mon, 11 Mar 2024 15:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710169956;
	bh=56cDsqFOGwW5Ckc+DVvS50eIfweND0EvI8zRDNwLbWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OV8pnm4UslaKUt0BDGSQZIIcbmDMrOIWbhPfC49d5XNmcCaElcnuj9aVOscEEFWW6
	 kSMefRlslJt2sTLTlQmHtVZpJhLcqGInVxMtTuMU0RkA2tmISRbz0cqpcbfQx8f8v3
	 yMwhL1bTgO+IH2YJgJ0vo3mc1BLjdvco4rcxnWYXtu97b/S5i5I+vSVrBAYUuB/QsS
	 wnA+L5fIdd/Lih9Y6c4CTvzLGtafoILyuNMdhV40VC0LL0yh8sOeknD653T8/GUe15
	 C0stA0JFM0cHhyCHkdz7aU1Qo0/R57sRFHhLGred380K+JFN92RU/hNNPKEQr6A1mQ
	 ONbKEO2tSDf4g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 08/23] spi: cadence-qspi: add system-wide suspend and resume callbacks
Date: Mon, 11 Mar 2024 11:11:48 -0400
Message-ID: <20240311151217.317068-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311151217.317068-1-sashal@kernel.org>
References: <20240311151217.317068-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.9
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


