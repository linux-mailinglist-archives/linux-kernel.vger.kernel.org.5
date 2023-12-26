Return-Path: <linux-kernel+bounces-11200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A8D81E322
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 01:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 492622825F5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 00:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F59EEBB;
	Tue, 26 Dec 2023 00:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LpjzDtzD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9FEC2CE;
	Tue, 26 Dec 2023 00:20:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A55AC433CC;
	Tue, 26 Dec 2023 00:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703550041;
	bh=EfUZ9EXJVAs4VkmUHE7PHqIAoPfiO/4cLLlU/vCkkZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LpjzDtzDC9jfF2Bp5IJx3kZv/MOTvSyvwQRmNyooBqWairLvrI7DDLjnpYcK19cpt
	 9mvGo+CJFHPuf5dsLVsSm21HHkSnYCYP8J1pKXbtALFOcDftqE0q7Gl8oKpbWSzgJJ
	 0XZFDkfATwhbTBhQsCI8J4elxu8zbKU637+ZoBfLDZWyqdHeP6txP+cFgaiG9ltDZs
	 +iAfNtmZktPIor3uYYJRwR3bJt0ENNrq1ZC7Hm2O2UFnjaivX72iAVVrMqhv57ZC2p
	 0hjRzwB10aZKD9X6j2qO1+GOixUZIsSSHAUZTjnEzSCict7OL8ni9JjxTup/TfSuF+
	 RjtZlp48EKl0w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 07/39] spi: cadence: revert "Add SPI transfer delays"
Date: Mon, 25 Dec 2023 19:18:57 -0500
Message-ID: <20231226002021.4776-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231226002021.4776-1-sashal@kernel.org>
References: <20231226002021.4776-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.8
Content-Transfer-Encoding: 8bit

From: Nam Cao <namcao@linutronix.de>

[ Upstream commit 7a733e060bd20edb63b1f27f0b29cf9b184e0e8b ]

The commit 855a40cd8ccc ("spi: cadence: Add SPI transfer delays") adds a
delay after each transfer into the driver's transfer_one(). However,
the delay is already done in SPI core. So this commit unnecessarily
doubles the delay amount. Revert this commit.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Link: https://lore.kernel.org/r/20231206145233.74982-1-namcao@linutronix.de
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-cadence.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index 12c940ba074ab..bd96d8b546cdb 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -451,7 +451,6 @@ static int cdns_transfer_one(struct spi_controller *ctlr,
 		udelay(10);
 
 	cdns_spi_process_fifo(xspi, xspi->tx_fifo_depth, 0);
-	spi_transfer_delay_exec(transfer);
 
 	cdns_spi_write(xspi, CDNS_SPI_IER, CDNS_SPI_IXR_DEFAULT);
 	return transfer->len;
-- 
2.43.0


