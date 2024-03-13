Return-Path: <linux-kernel+bounces-101988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6A887AD5C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 081C628311F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB99148FF1;
	Wed, 13 Mar 2024 16:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZV80LE8k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD64663CAE;
	Wed, 13 Mar 2024 16:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348199; cv=none; b=SY2QC78cpk+xHvILoMCfcxGG8G+2JQUpm5clwMAu419n5/z6kRayQSHQio82qGn57sAxjH0fsaCDdMxBwwHbCdp4bgeohcAEF7cDRytWxFVOMfI74tmr9+EhznSYWnBbwYAZB99Kz4rLbEixujGw7WhC2pCFe46qPf0phOFNP4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348199; c=relaxed/simple;
	bh=uL4wRVagRog8IuUH9Dd2Z/ogV6B19zOQMfGMFLV9ap8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BbCQst7jX6/EGoqMf1STi9jY7YUkr7L9vVukXQYSzm3skp2D6WZs+UzX4Y3LJy0l0oAOc3AzNTyrz6MZxDIE2/uvJS+LWfKFTY2E77arYo3msiIC0Ie993UzacV+OC9AKIoOfvFI60wQzYf28NZaBTlMl37LB/N/fRrT5yBxkiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZV80LE8k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8803C43394;
	Wed, 13 Mar 2024 16:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348199;
	bh=uL4wRVagRog8IuUH9Dd2Z/ogV6B19zOQMfGMFLV9ap8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZV80LE8k9WFTWly+QxQNB0AL8FvO1286bBTDDoTB3SHMG3UvpPBN9M2rBSGrs+57t
	 W23G6MQPpahLI6hTKKqdWiyk8Eam8lesUoMaxk8NtAsV8b1zwy8t4IiodC8lEUVuVH
	 oQtZcAWJq7DHSxBCvoDxnjC9EG1kYD0NpStTW3xQKcI4uUE3pD3z/6ybhqbEaZQRer
	 l0s+LGDJ7Bzs9UnbXuGgX13k0m0lHUBkt7jMTV1aGz8wIt7VoBNHTaKIRYDPhnrUoe
	 D+DrfDPv3AMU9dyO7Q0P6ur2cMWZeCjwkfNVz3QW3HtCY5zhv7hYrcEl4p9zqxv2Xb
	 MRrqtsOZMyHvQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 48/76] serial: max310x: use regmap methods for SPI batch operations
Date: Wed, 13 Mar 2024 12:41:55 -0400
Message-ID: <20240313164223.615640-49-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164223.615640-1-sashal@kernel.org>
References: <20240313164223.615640-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.152-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.152-rc1
X-KernelTest-Deadline: 2024-03-15T16:42+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Cosmin Tanislav <cosmin.tanislav@analog.com>

[ Upstream commit 285e76fc049c4d32c772eea9460a7ef28a193802 ]

The SPI batch read/write operations can be implemented as simple
regmap raw read and write, which will also try to do a gather
write just as it is done here.

Use the regmap raw read and write methods.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
Link: https://lore.kernel.org/r/20220605144659.4169853-2-demonsingur@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: b35f8dbbce81 ("serial: max310x: prevent infinite while() loop in port startup")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/max310x.c | 36 ++++++++----------------------------
 1 file changed, 8 insertions(+), 28 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 5dd73d1da1ecc..c9032e300a586 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -263,8 +263,6 @@ struct max310x_one {
 	struct work_struct	md_work;
 	struct work_struct	rs_work;
 
-	u8 wr_header;
-	u8 rd_header;
 	u8 rx_buf[MAX310X_FIFO_SIZE];
 };
 #define to_max310x_port(_port) \
@@ -635,32 +633,18 @@ static s32 max310x_set_ref_clk(struct device *dev, struct max310x_port *s,
 
 static void max310x_batch_write(struct uart_port *port, u8 *txbuf, unsigned int len)
 {
-	struct max310x_one *one = to_max310x_port(port);
-	struct spi_transfer xfer[] = {
-		{
-			.tx_buf = &one->wr_header,
-			.len = sizeof(one->wr_header),
-		}, {
-			.tx_buf = txbuf,
-			.len = len,
-		}
-	};
-	spi_sync_transfer(to_spi_device(port->dev), xfer, ARRAY_SIZE(xfer));
+	struct max310x_port *s = dev_get_drvdata(port->dev);
+	u8 reg = port->iobase + MAX310X_THR_REG;
+
+	regmap_raw_write(s->regmap, reg, txbuf, len);
 }
 
 static void max310x_batch_read(struct uart_port *port, u8 *rxbuf, unsigned int len)
 {
-	struct max310x_one *one = to_max310x_port(port);
-	struct spi_transfer xfer[] = {
-		{
-			.tx_buf = &one->rd_header,
-			.len = sizeof(one->rd_header),
-		}, {
-			.rx_buf = rxbuf,
-			.len = len,
-		}
-	};
-	spi_sync_transfer(to_spi_device(port->dev), xfer, ARRAY_SIZE(xfer));
+	struct max310x_port *s = dev_get_drvdata(port->dev);
+	u8 reg = port->iobase + MAX310X_RHR_REG;
+
+	regmap_raw_read(s->regmap, reg, rxbuf, len);
 }
 
 static void max310x_handle_rx(struct uart_port *port, unsigned int rxlen)
@@ -1386,10 +1370,6 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 		INIT_WORK(&s->p[i].md_work, max310x_md_proc);
 		/* Initialize queue for changing RS485 mode */
 		INIT_WORK(&s->p[i].rs_work, max310x_rs_proc);
-		/* Initialize SPI-transfer buffers */
-		s->p[i].wr_header = (s->p[i].port.iobase + MAX310X_THR_REG) |
-				    MAX310X_WRITE_BIT;
-		s->p[i].rd_header = (s->p[i].port.iobase + MAX310X_RHR_REG);
 
 		/* Register port */
 		ret = uart_add_one_port(&max310x_uart, &s->p[i].port);
-- 
2.43.0


