Return-Path: <linux-kernel+bounces-102099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7264887AE64
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DD2A283656
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B38418E766;
	Wed, 13 Mar 2024 16:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dlnh8GXf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3607D18E74E;
	Wed, 13 Mar 2024 16:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348484; cv=none; b=EPPqrUXg+XCpUFQIkeXz2snUAaaHHgSn1Xyp6a9ZBIi1+vLrStfAJ08uS2JaRAKCUotpMGlcG5H+dOCMVNKKyOVshM5mUXuOFgE/OzWYUB8O04CAae+RWjaJVwUXQrQnGhV8HSIk318KoIBU6wLZDRfWAVQgwKzVPxOOIbL2x28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348484; c=relaxed/simple;
	bh=bN6FyHWve+cJ69LrHSPDI7ih6sH5X6u68hczeQ7NoUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FaO29euk0dDugUDLH9mS6n8a03wyZyGycSuOr0EO89yzqS086Esmew6/YZ3H+VWYVLuMRnQFLkg/n8XpA4+K8u4yZ/dCHXXLeVn5MDgr7zXEMIBFoSf69Uye2I4qE4IrIOOGWIGyyyXKpWVSK2JCo7MlWBPhll8fmsr7mVBrMpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dlnh8GXf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDB12C433C7;
	Wed, 13 Mar 2024 16:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348483;
	bh=bN6FyHWve+cJ69LrHSPDI7ih6sH5X6u68hczeQ7NoUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dlnh8GXfKm3qMIorABkpoGP/gpEYSTIzUMNJm7HcnxQGSgUnxIm1T+Nzve5e8uoVD
	 Zny+2tCeKq0xgZsBDqOZd5c0OADfNUCo+4elmZXO7t2iEKuAKa39Z7kAb2BG376yUj
	 KbsUTFarJHDlVJqiuIlWjaF5XsQwWPHV6ZecB7IKn9teIDsTse8OSHqxxsR68qhlas
	 hkh+E6jHbTPPfWT9J2j8g0oW+WYlI0ciqWx83lyiiwB0XoIUgyqXNPJH4TCV48srSM
	 cdmZEfJzX/oUQA0qvU1MtnW1DzTqxTW0Kz7nrfEhfB7/7wHtdZn2pGLOQCTY29w2KD
	 q3HAv+dh2surg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Jan=20Kundr=C3=A1t?= <jan.kundrat@cesnet.cz>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 72/73] serial: max310x: fix IO data corruption in batched operations
Date: Wed, 13 Mar 2024 12:46:39 -0400
Message-ID: <20240313164640.616049-73-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164640.616049-1-sashal@kernel.org>
References: <20240313164640.616049-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.213-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.10.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.10.213-rc1
X-KernelTest-Deadline: 2024-03-15T16:46+00:00
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
 drivers/tty/serial/max310x.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index ed1aaa19854fd..2f88eae8a55a1 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -533,6 +533,11 @@ static bool max310x_reg_precious(struct device *dev, unsigned int reg)
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
@@ -667,14 +672,14 @@ static void max310x_batch_write(struct uart_port *port, u8 *txbuf, unsigned int
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
@@ -1508,6 +1513,10 @@ static struct regmap_config regcfg = {
 	.writeable_reg = max310x_reg_writeable,
 	.volatile_reg = max310x_reg_volatile,
 	.precious_reg = max310x_reg_precious,
+	.writeable_noinc_reg = max310x_reg_noinc,
+	.readable_noinc_reg = max310x_reg_noinc,
+	.max_raw_read = MAX310X_FIFO_SIZE,
+	.max_raw_write = MAX310X_FIFO_SIZE,
 };
 
 #ifdef CONFIG_SPI_MASTER
@@ -1593,6 +1602,10 @@ static struct regmap_config regcfg_i2c = {
 	.volatile_reg = max310x_reg_volatile,
 	.precious_reg = max310x_reg_precious,
 	.max_register = MAX310X_I2C_REVID_EXTREG,
+	.writeable_noinc_reg = max310x_reg_noinc,
+	.readable_noinc_reg = max310x_reg_noinc,
+	.max_raw_read = MAX310X_FIFO_SIZE,
+	.max_raw_write = MAX310X_FIFO_SIZE,
 };
 
 static const struct max310x_if_cfg max310x_i2c_if_cfg = {
-- 
2.43.0


