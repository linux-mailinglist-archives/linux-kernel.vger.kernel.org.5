Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2F87FD828
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 14:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234037AbjK2NcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 08:32:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbjK2NcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 08:32:20 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E212A3;
        Wed, 29 Nov 2023 05:32:27 -0800 (PST)
From:   Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701264746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kzdtc8JyJA+/FCzC+xiv8TQYBEoRzlUz4DduhP6xQ4M=;
        b=xjZXDnVc0ovq0TSW9b98/h3ZELuqA15QueP8c+dXzxKrIp8wNN7O1hmf/fCD5G1ylI26hz
        L78xZrMJbXnMTnK4MwFl7UaEv6UC6TD6OiuD1WAloGWy2cCqstcLxlL+EzR27OeGfiaHps
        zEgFQsjk8zvX3J/Em2oUdtOQg7g0F6+DVllqfJTVLdWNW1nj61t3Ej3zmqGq3VSjEGiURF
        arpkYa25kNCMGOlwDcmjxBEZtKi2d2kCXws/LdoXN9T/B+8JWn/Hz+fPQhRYD97kf84rLE
        JBx7rP99mf602Yh9t+VkfGeeM07HXz55wyYrKBCojpKIJBZbnoid5NEhwAeO0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701264746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kzdtc8JyJA+/FCzC+xiv8TQYBEoRzlUz4DduhP6xQ4M=;
        b=9i9b/NsWVbiv7sXSCvMncA5ugNF88CKqDLw3PPHnZ19aS2mRShIgLjpvAt6g0iEmGa65Ei
        P5CxPjuDEvsuJqDA==
To:     linus.walleij@linaro.org, broonie@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Nam Cao <namcao@linutronix.de>
Subject: [PATCH 1/2] spi: introduce SPI_TRANS_FAIL_IO for error reporting
Date:   Wed, 29 Nov 2023 14:32:18 +0100
Message-Id: <361901574eec1271c0969edba6492d3f2132fade.1701264413.git.namcao@linutronix.de>
In-Reply-To: <cover.1701264413.git.namcao@linutronix.de>
References: <cover.1701264413.git.namcao@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default message transfer implementation - spi_transfer_one_message -
invokes the specific device driver's transfer_one(), then waits for
completion. However, there is no mechanism for the device driver to
report failure in the middle of the transfer.

Introduce SPI_TRANS_FAIL_IO for drivers to report transfer failure.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 drivers/spi/spi.c       | 3 +++
 include/linux/spi/spi.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 8ead7acb99f3..a4b8c07c5951 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1361,6 +1361,9 @@ static int spi_transfer_wait(struct spi_controller *c=
tlr,
 				"SPI transfer timed out\n");
 			return -ETIMEDOUT;
 		}
+
+		if (xfer->error & SPI_TRANS_FAIL_IO)
+			return -EIO;
 	}
=20
 	return 0;
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 7b4baff63c5c..ddadae2e1ead 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -1040,6 +1040,7 @@ struct spi_transfer {
 	unsigned	len;
=20
 #define SPI_TRANS_FAIL_NO_START	BIT(0)
+#define SPI_TRANS_FAIL_IO	BIT(1)
 	u16		error;
=20
 	dma_addr_t	tx_dma;
--=20
2.39.2

