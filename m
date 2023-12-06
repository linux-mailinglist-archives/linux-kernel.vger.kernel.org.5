Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F468072B9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 15:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378980AbjLFOnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 09:43:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378943AbjLFOnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 09:43:52 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8274A1BD;
        Wed,  6 Dec 2023 06:43:58 -0800 (PST)
From:   Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701873837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=mAF870uQ0onfTlbiDl5VP75x4lowIYu0iaaaG3AvEnM=;
        b=vuavcnaqGzr2N+M1K1Kdm4ls72k288AsQrkpqzvT0Mck1T8T9L2pLSlJNaVULg25ZWBUm6
        GX04rhJxiakvop13d9Ay8yxoF3bysocFzYnbh985VYacL46psHy5p9LSKXJNqhGX5ze5Qj
        gAwx9LMM7FuY09Dt/mneorhtU/iKr282GTkSn5IvYoMh4LNVv9Hyg09ffvKQIU83sBlFD5
        ETxuQ1pgj7RqdjNZXI9shQNiE/40tRHHlesdKsb0Mdh2/18R4CI2kRKFVkn3M9mOQVYtG+
        g3MkR7HiGR4j9pXw2Fyhgcpvki/S1YQasOATxhgPiQ7Ox5gg9sdZt1adO0nvAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701873837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=mAF870uQ0onfTlbiDl5VP75x4lowIYu0iaaaG3AvEnM=;
        b=2GwYdPx0vHeTwED8sPssZImual1eE0YffQ1kmhcu6FbpNhwC5lIG8ULgXBmGYZPsa5CitT
        FXZ/9sT56G4DqQAQ==
To:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, daniel@zonque.org
Cc:     Nam Cao <namcao@linutronix.de>
Subject: [PATCH v2] spi: cadence: revert "Add SPI transfer delays"
Date:   Wed,  6 Dec 2023 15:43:51 +0100
Message-Id: <20231206144351.74492-1-namcao@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 855a40cd8ccc ("spi: cadence: Add SPI transfer delays") adds a
delay after each transfer into the driver's transfer_one(). However,
the delay is already done in SPI core. So this commit unnecessarily
doubles the delay amount. Revert this commit.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 drivers/spi/spi-cadence.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index 12c940ba074a..bd96d8b546cd 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -451,7 +451,6 @@ static int cdns_transfer_one(struct spi_controller *ctl=
r,
 		udelay(10);
=20
 	cdns_spi_process_fifo(xspi, xspi->tx_fifo_depth, 0);
-	spi_transfer_delay_exec(transfer);
=20
 	cdns_spi_write(xspi, CDNS_SPI_IER, CDNS_SPI_IXR_DEFAULT);
 	return transfer->len;
--=20
2.39.2

