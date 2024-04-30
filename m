Return-Path: <linux-kernel+bounces-164702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B0C8B8154
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 22:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 153C9B24F4C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 20:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E4219DF5F;
	Tue, 30 Apr 2024 20:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hFPIqtD4"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93354180A82
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 20:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714508323; cv=none; b=nr0Drec671rcXDSCCnmxz18xDqHdn1TM6/26QUqFTEaaYUhjHQWktpuiVCTg5/U/VmSZwmsTjYqyhln5rBFk7hpyN1qJUwHiyD5TVTmD0o6QaC4qQf3C7ss5+GNvXIjRx//Z86/nYQkAVjRorh1w6aeoIl/zQ/GUr5pmmHQD6+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714508323; c=relaxed/simple;
	bh=xeKJVe5IVeE08nq0bVzZyqiSZ71yZJUwZwFcGTeFYJc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bMLrC5HxKhjjc0hQ9Ywv0lfTD0ibGEWpRkdmtAry86CHsgbnwwiQiv2ZTWF/ksoH00FWCsjfNOFrzRpuNMBwbUpgrwCrlgVUH39FCcl2dDaDmXzVt2Od1rz5NeWjdoKK+DPYbZPbbOMMVy1TiZFkuckljwJIVf/S3WR0MQ7NTm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=hFPIqtD4; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5aa20adda1dso3951677eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 13:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1714508318; x=1715113118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ORXndqCPX8oa0pC4YFIUBrFDkk+D8OkxD6HO3nH6Gu8=;
        b=hFPIqtD4idiSjibDDj3EBtEhH6adEpoWR7UHWorfH9PeLfM8Jr6zAVh/CkNisEIO38
         5mlXqSLnM+YzwsAbeVFMTfidVEXwr7wJoWOQqQHCJfF7CH4xDaNHzDf/I11Js89h1F5I
         u449vu+NbAhIYmIqy5XEP+UlA9S/ijI/9KsdlL1Hxn8bnuVU1NktlPUhpx8rELnin3YN
         ZrOpVwsl0VvlrR8Cu+3HvFLTn7sjR0DLOjKOr/oHJIF/MXBQb3BzGLTnDoCHLw3xPpyQ
         LP1972QxmtGiFcKVGG0YAwag/Txx/BnOkEpsPu/DXsvL5lDQFrkOTC1CIFt/eTMWlbVr
         SU0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714508318; x=1715113118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ORXndqCPX8oa0pC4YFIUBrFDkk+D8OkxD6HO3nH6Gu8=;
        b=JVmXTOS3h5zJfz7G7LbCWYo3UaDhvzz/6lLt5V1boduDuBFS+5etkegtBkxENRSGMg
         km02l8MMefVFhOTYYVASWE44aQCviEQGUcL4KOX48Fxgf8bGuJDksggUwI4yVnbq/egV
         DIr4RO+A/T88sEC0FZbNXWSq3gphk41eV6BI0nJVwZwlutidjQu7FFwZrdh8fbwhF41V
         KHpbsEYyBN+y75nfi8MMUZ/3cjwRFWu1nbKBKo47HQMKQzHoRaXremWBMhy+3/VgixW1
         d902flfR9vjuzrmoHxCchmasBhwYxNk2fTmoB+2DAmsCo2H3MckBTt7Wvgfn+4PcBsMB
         n55Q==
X-Forwarded-Encrypted: i=1; AJvYcCVzuvEP6YWYjpa7vlBnpV2avWewJZLAYLWTGzG5erYtnMYr2BeVxCaMT9pILdDVX29qssb7gkQzYNhDpF/t7sSfJAQmHVnszxg2zG0I
X-Gm-Message-State: AOJu0YxPsIL2qTJ5x0TuKBv9BNTF039W99ZYK9XmTUIWkM2dXL3OXdid
	MdSNbEa+sVHYV6IsA+3Mc5oN1XepBi5vb4G6Erea5aqDxuoKXQgqTa8IsM0LKzZXGSiz0O1aEIV
	J
X-Google-Smtp-Source: AGHT+IHnpIMnCkU79BvHJFAhHMmjnXsYZiVzIXv64GM+/siQ3GG9rzdppgmGi4XjvI1oQhg16oE3Rg==
X-Received: by 2002:a4a:1701:0:b0:5aa:4d23:9114 with SMTP id 1-20020a4a1701000000b005aa4d239114mr500982ooe.3.1714508318653;
        Tue, 30 Apr 2024 13:18:38 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id k13-20020a4ab08d000000b005a5554a076esm5522851oon.10.2024.04.30.13.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 13:18:09 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] spi: use spi_valid_{tx,rx}buf() in stats function
Date: Tue, 30 Apr 2024 15:15:27 -0500
Message-ID: <20240430201530.2138095-3-dlechner@baylibre.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are macros spi_valid_txbuf() and spi_valid_rxbuf() for determining
if an xfer actually intended to send or receive data.

These checks were hard-coded in spi_statistics_add_transfer_stats(). We
can make use of the macros instead to make the code more readable and
more robust against potential future changes in case the definition of
what valid means changes.

The macro takes the spi_message as an argument, so we need to change
spi_statistics_add_transfer_stats() to take the spi_message as an
argument instead of the controller.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 34fca94b2b5b..a500a4137a78 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -312,7 +312,7 @@ static const struct attribute_group *spi_master_groups[] = {
 
 static void spi_statistics_add_transfer_stats(struct spi_statistics __percpu *pcpu_stats,
 					      struct spi_transfer *xfer,
-					      struct spi_controller *ctlr)
+					      struct spi_message *msg)
 {
 	int l2len = min(fls(xfer->len), SPI_STATISTICS_HISTO_SIZE) - 1;
 	struct spi_statistics *stats;
@@ -328,11 +328,9 @@ static void spi_statistics_add_transfer_stats(struct spi_statistics __percpu *pc
 	u64_stats_inc(&stats->transfer_bytes_histo[l2len]);
 
 	u64_stats_add(&stats->bytes, xfer->len);
-	if ((xfer->tx_buf) &&
-	    (xfer->tx_buf != ctlr->dummy_tx))
+	if (spi_valid_txbuf(msg, xfer))
 		u64_stats_add(&stats->bytes_tx, xfer->len);
-	if ((xfer->rx_buf) &&
-	    (xfer->rx_buf != ctlr->dummy_rx))
+	if (spi_valid_rxbuf(msg, xfer))
 		u64_stats_add(&stats->bytes_rx, xfer->len);
 
 	u64_stats_update_end(&stats->syncp);
@@ -1618,8 +1616,8 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
 		trace_spi_transfer_start(msg, xfer);
 
-		spi_statistics_add_transfer_stats(statm, xfer, ctlr);
-		spi_statistics_add_transfer_stats(stats, xfer, ctlr);
+		spi_statistics_add_transfer_stats(statm, xfer, msg);
+		spi_statistics_add_transfer_stats(stats, xfer, msg);
 
 		if (!ctlr->ptp_sts_supported) {
 			xfer->ptp_sts_word_pre = 0;

base-commit: cecfc48904cfd3d518bd4dad13c70291e6741076
-- 
2.43.2


