Return-Path: <linux-kernel+bounces-113028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 488108880E4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD0DAB23967
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3735213A863;
	Sun, 24 Mar 2024 22:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="owsjPHF4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7084913A256;
	Sun, 24 Mar 2024 22:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319838; cv=none; b=GNCkusRByK0RIj9aPImzeXxB/lrCxm8LB0PbxvqqK7Xyo16ZRqFXYGfNj6vOQxVRjGZMwo92S7icwB0JzAN6zuIMs+rhSJZ+kUrIKkjGPW1NpcS93M2r5d5fCc6PzqZPc++qnHOU88H6/p+05zs77YsXKxPzj+WaQnF3qqGOFyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319838; c=relaxed/simple;
	bh=TF481GA7/dvxygYzeDlVCuY0/d+mkVT9zKQRiVlmJiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L69oRrjjpJ9uOL0NHbs7Bxvqfsbly0Dm/vtTVRkhcpEdQuLwOSe3JWe+ysxWBP1/72YuvOqi53axEEA7DN3DxwNDnXd2pNQwSNgpt0P724eoUe3AYCzMlVtz7toYFoSXxjDgQQbekyx5RdfNMYKSypYUsDDWFOvwgt2fkwPcTVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=owsjPHF4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8313C43390;
	Sun, 24 Mar 2024 22:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319838;
	bh=TF481GA7/dvxygYzeDlVCuY0/d+mkVT9zKQRiVlmJiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=owsjPHF4zHYSIE9NmWjLr0cVHnuX2s+s7A3k/Kd4DdhKJmpHgdUDHHtqxpvRXX/DF
	 GAtWjWZVJaSZ8HhJQcBT1ZvSMG3tzTiHTEZ7uBU5Ri1PJMI7i7yhEaJVyPhhQakWq3
	 bMgCLQgmeo7MOPRs99EpaA7yEkiAQ7TSmgFjfpedob/skGfeX4t1J32aDYq7ECIj7A
	 kk6qbwS+D8TeQg3appi43XYY62h6oUC0qUXv/IQ7jweGd84W3dQqnseBonq50qWaSA
	 XA3dRplCtvs438hugmn6IjQw3iDjKagEGJyioyL8n73lg0YKKeggBViAQQvo3AUcpv
	 ShXxi91PXITTA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 141/715] spi: consolidate setting message->spi
Date: Sun, 24 Mar 2024 18:25:20 -0400
Message-ID: <20240324223455.1342824-142-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: David Lechner <dlechner@baylibre.com>

[ Upstream commit b204aa0f99cfe3c9d796ecfc0bc6f3f89585789e ]

Previously, __spi_sync() and __spi_async() set message->spi to the spi
device independently after calling __spi_validate(). __spi_validate()
also would conditionally set this if it needed to split the message
since it wasn't set yet.

Since both __spi_sync() and __spi_async() call __spi_validate(), we can
consolidate this into only setting message->spi once (unconditionally)
in __spi_validate(). This will also save any future callers of
__spi_validate() from also needing to set message->spi.

Signed-off-by: David Lechner <dlechner@baylibre.com>
Link: https://msgid.link/r/20240123214946.2616786-1-dlechner@baylibre.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: c8bec3355f08 ("spi: move split xfers for CS_WORD emulation")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index f2170f4b50775..8dfe635fffd63 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -4063,6 +4063,8 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 	if (list_empty(&message->transfers))
 		return -EINVAL;
 
+	message->spi = spi;
+
 	/*
 	 * If an SPI controller does not support toggling the CS line on each
 	 * transfer (indicated by the SPI_CS_WORD flag) or we are using a GPIO
@@ -4075,9 +4077,6 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 		size_t maxsize = BITS_TO_BYTES(spi->bits_per_word);
 		int ret;
 
-		/* spi_split_transfers_maxsize() requires message->spi */
-		message->spi = spi;
-
 		ret = spi_split_transfers_maxsize(ctlr, message, maxsize,
 						  GFP_KERNEL);
 		if (ret)
@@ -4214,8 +4213,6 @@ static int __spi_async(struct spi_device *spi, struct spi_message *message)
 	if (!ctlr->transfer)
 		return -ENOTSUPP;
 
-	message->spi = spi;
-
 	SPI_STATISTICS_INCREMENT_FIELD(ctlr->pcpu_statistics, spi_async);
 	SPI_STATISTICS_INCREMENT_FIELD(spi->pcpu_statistics, spi_async);
 
@@ -4395,8 +4392,6 @@ static int __spi_sync(struct spi_device *spi, struct spi_message *message)
 	if (status != 0)
 		return status;
 
-	message->spi = spi;
-
 	SPI_STATISTICS_INCREMENT_FIELD(ctlr->pcpu_statistics, spi_sync);
 	SPI_STATISTICS_INCREMENT_FIELD(spi->pcpu_statistics, spi_sync);
 
-- 
2.43.0


