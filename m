Return-Path: <linux-kernel+bounces-113029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 567498880E7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 880BA1C21124
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D33B13A88B;
	Sun, 24 Mar 2024 22:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1qTLK9c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F70E13A864;
	Sun, 24 Mar 2024 22:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319839; cv=none; b=Cv5OhzGU9s+0gdkBEzvW2Snq88n8kS9TMknaWjWc3ATHci7Azm86id4liD0buImKIbrpTky4txNV9+al94RK7xbzhyg+tVsNjXuLIPRDHTHGRMNuH2RAM54vIb1YnkiKKl+jjpWJAe1TWwXyx0DEyUJG9NbBJkvI3H0Tfud6Z3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319839; c=relaxed/simple;
	bh=3bfJkURzDIggy6eepBk4lgt5ahplmu2n/xt07WfrKJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=toYGFZLClxusH7SODM8M7I64YlejLHYcbX7EDlwTs3MwScMiH/gZb8ClZXwupXL5W1/64XmERDaU+uZFOSQ3cOfDx6hKc3KW/xNv9n3CRwnnt9DaPWKMacHNE9Cn4NJWDOhf1o96KrRGJcobI7JkmGRI9SJ+QX0vY4XipwhjYLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1qTLK9c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E319C433C7;
	Sun, 24 Mar 2024 22:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319839;
	bh=3bfJkURzDIggy6eepBk4lgt5ahplmu2n/xt07WfrKJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M1qTLK9cO3rjNhSpb0rUEhG/05Rmzl0aVMd8UEfa0bYi1dhgBHrj1GS7nMIPPDkok
	 iRzQ6iuuVCTR/lWAIhWN4zUE+qhXTgjoNdQ4p04wshukNSEWX+i4SN6pscI9EMwYYO
	 toHCQKDL6FC7IaB3na1pVN0gZbv4ZyvFD3PDPA9LsqdxbS3qtqScEuODaca6r54GFl
	 6CMpNnyeUFh7VIrTRjqdO19tnP0MUSknAY2IaAamJloi3K8b2oZ2WweNNyCjcpG9Qj
	 LIciLsEj4wuM4vrwfLvk6zvATlfLbUS8UA0Bg+gzjjzfarU5vZN+qN1QviNzn7TaOW
	 5qFzvAZNZIfVQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 142/715] spi: move split xfers for CS_WORD emulation
Date: Sun, 24 Mar 2024 18:25:21 -0400
Message-ID: <20240324223455.1342824-143-sashal@kernel.org>
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

[ Upstream commit c8bec3355f08ddb887d5c13b7095dfa79e6db108 ]

This moves splitting transfers for CS_WORD software emulation to the
same place where we split transfers for controller-specific reasons.

This fixes a few subtle bugs.

The calculation for maxsize was wrong for bit sizes between 17 and 24.
This is fixed by making use of spi_split_transfers_maxwords() which
already has the correct calculation.

Also, since this indirectly calls spi_res_alloc(), to avoid leaking
resources, spi_finalize_current_message() would need to be called
on all error paths in __spi_validate() and callers of __spi_validate()
would need to do the same. This is fixed by moving the call to
__spi_pump_transfer_message() where it is already splitting transfers
for other reasons and correctly releases resources in the subsequent
error paths.

Fixes: cbaa62e0094a ("spi: add software implementation for SPI_CS_WORD")
Signed-off-by: David Lechner <dlechner@baylibre.com>
Link: https://lore.kernel.org/r/20240126212358.3916280-2-dlechner@baylibre.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi.c | 63 +++++++++++++++++++++++------------------------
 1 file changed, 31 insertions(+), 32 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 8dfe635fffd63..d1b297f438f14 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1747,13 +1747,37 @@ static int __spi_pump_transfer_message(struct spi_controller *ctlr,
 
 	trace_spi_message_start(msg);
 
-	ret = spi_split_transfers_maxsize(ctlr, msg,
-					  spi_max_transfer_size(msg->spi),
-					  GFP_KERNEL | GFP_DMA);
-	if (ret) {
-		msg->status = ret;
-		spi_finalize_current_message(ctlr);
-		return ret;
+	/*
+	 * If an SPI controller does not support toggling the CS line on each
+	 * transfer (indicated by the SPI_CS_WORD flag) or we are using a GPIO
+	 * for the CS line, we can emulate the CS-per-word hardware function by
+	 * splitting transfers into one-word transfers and ensuring that
+	 * cs_change is set for each transfer.
+	 */
+	if ((msg->spi->mode & SPI_CS_WORD) && (!(ctlr->mode_bits & SPI_CS_WORD) ||
+					       spi_is_csgpiod(msg->spi))) {
+		ret = spi_split_transfers_maxwords(ctlr, msg, 1, GFP_KERNEL);
+		if (ret) {
+			msg->status = ret;
+			spi_finalize_current_message(ctlr);
+			return ret;
+		}
+
+		list_for_each_entry(xfer, &msg->transfers, transfer_list) {
+			/* Don't change cs_change on the last entry in the list */
+			if (list_is_last(&xfer->transfer_list, &msg->transfers))
+				break;
+			xfer->cs_change = 1;
+		}
+	} else {
+		ret = spi_split_transfers_maxsize(ctlr, msg,
+						  spi_max_transfer_size(msg->spi),
+						  GFP_KERNEL | GFP_DMA);
+		if (ret) {
+			msg->status = ret;
+			spi_finalize_current_message(ctlr);
+			return ret;
+		}
 	}
 
 	if (ctlr->prepare_message) {
@@ -4065,31 +4089,6 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 
 	message->spi = spi;
 
-	/*
-	 * If an SPI controller does not support toggling the CS line on each
-	 * transfer (indicated by the SPI_CS_WORD flag) or we are using a GPIO
-	 * for the CS line, we can emulate the CS-per-word hardware function by
-	 * splitting transfers into one-word transfers and ensuring that
-	 * cs_change is set for each transfer.
-	 */
-	if ((spi->mode & SPI_CS_WORD) && (!(ctlr->mode_bits & SPI_CS_WORD) ||
-					  spi_is_csgpiod(spi))) {
-		size_t maxsize = BITS_TO_BYTES(spi->bits_per_word);
-		int ret;
-
-		ret = spi_split_transfers_maxsize(ctlr, message, maxsize,
-						  GFP_KERNEL);
-		if (ret)
-			return ret;
-
-		list_for_each_entry(xfer, &message->transfers, transfer_list) {
-			/* Don't change cs_change on the last entry in the list */
-			if (list_is_last(&xfer->transfer_list, &message->transfers))
-				break;
-			xfer->cs_change = 1;
-		}
-	}
-
 	/*
 	 * Half-duplex links include original MicroWire, and ones with
 	 * only one data pin like SPI_3WIRE (switches direction) or where
-- 
2.43.0


