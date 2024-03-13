Return-Path: <linux-kernel+bounces-102016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 966F787AD9A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53032282F7C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A7014EA23;
	Wed, 13 Mar 2024 16:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3dVMaiR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2583764CF7;
	Wed, 13 Mar 2024 16:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348230; cv=none; b=dEnwYEUX2aF53olW4s9D2UdUtzczeDZOK+Ki4+K+wCXbBYLsPNpHdQTAfa+GcWxYNfGUWc0ytijjW5sfyMcQVwsjBDK3vNnDSJHO2b60AcAIVZyoeho2NAjk5kVvRKsUeuRWJuC7I1hHLLCng/DSscWE08hq+vl5ZnfSJXDtG6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348230; c=relaxed/simple;
	bh=j+1HcfbnqtQLFCt/+wgkCnxHewRTQth12vYb5SjsB1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sZSNn+VcahcspCtkqXaWSsmUs12Vx4lLplZQAWB+NUPBqMCx/LCWPUFwJq+i78nvNtXrUC/nDGzofUnYDEABj8yXinmw/QnHlrhQOYza7TtYreXzTremphqwsKpeQFWVIjG/ArTmKmMwHbCFtCori3gj2/Tc+dl66WNu1YA+GrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3dVMaiR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29CE8C433F1;
	Wed, 13 Mar 2024 16:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348230;
	bh=j+1HcfbnqtQLFCt/+wgkCnxHewRTQth12vYb5SjsB1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T3dVMaiR6FfSP+z9i0LUXLirzqx3QiyCNF5pkMH4w8sMwy1uSWY/ixL4DqKLMdjya
	 iyaiNZOTKikqaSq2BVl5B43OzooTsbJeL+iFfRNWtP9QnKuuJtA3XKV6jdJtiFMeRf
	 zGc4oZJS61o4QfAzUAAGpU5JYuVxfIdTfeQAGB/VZ83cpRuLfbJOi5jy8Yl5RHLl6q
	 e0lvG5+o8Mr5/a/yfZHiDZPn0oHmtSlGAxDB56t896kaVHmBL2V11JqQyWV5NU9ItF
	 LsWSstvsp1BuSjpPg7OOjiOpahhfIu076tVAQh0uu3PEZ79sfOkTfYAAiKuCTIcblb
	 /KC417gWb7v8g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Jan=20Kundr=C3=A1t?= <jan.kundrat@cesnet.cz>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 75/76] serial: max310x: fix IO data corruption in batched operations
Date: Wed, 13 Mar 2024 12:42:22 -0400
Message-ID: <20240313164223.615640-76-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164223.615640-1-sashal@kernel.org>
References: <20240313164223.615640-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.152-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.152-rc1
X-KernelTest-Deadline: 2024-03-15T16:42+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Jan Kundrát <jan.kundrat@cesnet.cz>

[ Upstream commit 3f42b142ea1171967e40e10e4b0241c0d6d28d41 ]

After upgrading from 5.16 to 6.1, our board with a MAX14830 started
producing lots of garbage data over UART. Bisection pointed out commit
285e76fc049c as the culprit. That patch tried to replace hand-written
code which I added in 2b4bac48c1084 ("serial: max310x: Use batched reads
when reasonably safe") with the generic regmap infrastructure for
batched operations.

Unfortunately, the `regmap_raw_read` and `regmap_raw_write` which were
used are actually functions which perform IO over *multiple* registers.
That's not what is needed for accessing these Tx/Rx FIFOs; the
appropriate functions are the `_noinc_` versions, not the `_raw_` ones.

Fix this regression by using `regmap_noinc_read()` and
`regmap_noinc_write()` along with the necessary `regmap_config` setup;
with this patch in place, our board communicates happily again. Since
our board uses SPI for talking to this chip, the I2C part is completely
untested.

Fixes: 285e76fc049c ("serial: max310x: use regmap methods for SPI batch operations")
Cc: stable@vger.kernel.org
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Jan Kundrát <jan.kundrat@cesnet.cz>
Link: https://lore.kernel.org/r/79db8e82aadb0e174bc82b9996423c3503c8fb37.1680732084.git.jan.kundrat@cesnet.cz
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/max310x.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 4299211183a74..c122e7e90fc89 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -511,6 +511,11 @@ static bool max310x_reg_precious(struct device *dev, unsigned int reg)
 	return false;
 }
 
+static bool max310x_reg_noinc(struct device *dev, unsigned int reg)
+{
+	return reg == MAX310X_RHR_REG;
+}
+
 static int max310x_set_baud(struct uart_port *port, int baud)
 {
 	unsigned int mode = 0, div = 0, frac = 0, c = 0, F = 0;
@@ -645,14 +650,14 @@ static void max310x_batch_write(struct uart_port *port, u8 *txbuf, unsigned int
 {
 	struct max310x_one *one = to_max310x_port(port);
 
-	regmap_raw_write(one->regmap, MAX310X_THR_REG, txbuf, len);
+	regmap_noinc_write(one->regmap, MAX310X_THR_REG, txbuf, len);
 }
 
 static void max310x_batch_read(struct uart_port *port, u8 *rxbuf, unsigned int len)
 {
 	struct max310x_one *one = to_max310x_port(port);
 
-	regmap_raw_read(one->regmap, MAX310X_RHR_REG, rxbuf, len);
+	regmap_noinc_read(one->regmap, MAX310X_RHR_REG, rxbuf, len);
 }
 
 static void max310x_handle_rx(struct uart_port *port, unsigned int rxlen)
@@ -1481,6 +1486,10 @@ static struct regmap_config regcfg = {
 	.writeable_reg = max310x_reg_writeable,
 	.volatile_reg = max310x_reg_volatile,
 	.precious_reg = max310x_reg_precious,
+	.writeable_noinc_reg = max310x_reg_noinc,
+	.readable_noinc_reg = max310x_reg_noinc,
+	.max_raw_read = MAX310X_FIFO_SIZE,
+	.max_raw_write = MAX310X_FIFO_SIZE,
 };
 
 #ifdef CONFIG_SPI_MASTER
-- 
2.43.0


