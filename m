Return-Path: <linux-kernel+bounces-111484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D9D886D9B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2EAE2847C7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F15F4DA16;
	Fri, 22 Mar 2024 13:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="VQWMi+Nx"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB2D45C0B
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 13:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711114002; cv=none; b=aUVbCy5l2POQk1i9MLovGuFj+IcJ+0JU4S90q+pB54KU+gMw/VZrrna9BGCsJrXKFKH3po5Njijl4U71D2YEzDe9mALjQgsBCL3ATcTSmp7D1JekhlmO5XAxHD/w6eQviTNv34cmYDoP55RugfNA2ZNvaQOv8PTOFGzcmLqAjLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711114002; c=relaxed/simple;
	bh=sstUsdHf8IqQGy2e/CDeusFddPWdrFuWg1qsnOgINWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bhjP8cjI0BFJtlTawaBDjzwmetZkaXIxWPywG8/Yt9VoKnLBNM2xFOV3CYoQXRsqfMQNDNzEGGIq1UwbYMPOIEI8ksYox30Cfkmw/PhBBnFRoq/bbo8D+4Addkf5GHNtgfK/2qGdqfXXx6eylq1TjC/H4ptmHniKgKK9OaZMcxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=VQWMi+Nx; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=1fuavoM1tsxpg+sffePeG5Oq2+/3E0Rj2cjqhiCzSao=; b=VQWMi+
	Nxn8XW8Est4ionNwmGyCHOI4xrIV2OqLZlWhldTv8QMzXNBKLriYUHzfXMwQwpRm
	QI8+xYK8L9+XmjcruKkkvEyTmUtwYhK69yJC/5GBC5q4V/+u99GKN/DTAlQC+Ec+
	8WFS8NVRbDjfJS0DY7Lcx02PsJu5BB/XPEvhOwDuCp5+KUlQ7+++YVIwmMODpmGu
	Zx2/rsbpR9eON1AoLMXV1vbx8fKX5ikpFFL2dVh9qx00iayrWw4BHsZEgLwWkYVA
	RRBrRP3k4wj0T1ti4fNMjOd/C5zA/HI9nFz8O6ddH6Iw6FNKg/ySu37jJmWQM+Vc
	yhPeZScCs+KP0Tfw==
Received: (qmail 3870173 invoked from network); 22 Mar 2024 14:26:25 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 22 Mar 2024 14:26:25 +0100
X-UD-Smtp-Session: l3s3148p1@fm86xT8UYpNehhtF
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Joel Stanley <joel@jms.id.au>,
	Andi Shyti <andi.shyti@kernel.org>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	openbmc@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/64] i2c: aspeed: reword according to newest specification
Date: Fri, 22 Mar 2024 14:24:58 +0100
Message-ID: <20240322132619.6389-6-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240322132619.6389-1-wsa+renesas@sang-engineering.com>
References: <20240322132619.6389-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Match the wording of this driver wrt. the newest I2C v7, SMBus 3.2, I3C
specifications and replace "master/slave" with more appropriate terms.
They are also more specific because we distinguish now between a remote
entity ("client") and a local one ("target").

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-aspeed.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index ce8c4846b7fa..4e6ea4a5cab9 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -159,7 +159,7 @@ struct aspeed_i2c_bus {
 	bool				send_stop;
 	int				cmd_err;
 	/* Protected only by i2c_lock_bus */
-	int				master_xfer_result;
+	int				xfer_result;
 	/* Multi-master */
 	bool				multi_master;
 #if IS_ENABLED(CONFIG_I2C_SLAVE)
@@ -608,9 +608,9 @@ static u32 aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
 out_complete:
 	bus->msgs = NULL;
 	if (bus->cmd_err)
-		bus->master_xfer_result = bus->cmd_err;
+		bus->xfer_result = bus->cmd_err;
 	else
-		bus->master_xfer_result = bus->msgs_index + 1;
+		bus->xfer_result = bus->msgs_index + 1;
 	complete(&bus->cmd_complete);
 out_no_complete:
 	return irq_handled;
@@ -679,7 +679,7 @@ static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
 	return irq_remaining ? IRQ_NONE : IRQ_HANDLED;
 }
 
-static int aspeed_i2c_master_xfer(struct i2c_adapter *adap,
+static int aspeed_i2c_xfer(struct i2c_adapter *adap,
 				  struct i2c_msg *msgs, int num)
 {
 	struct aspeed_i2c_bus *bus = i2c_get_adapdata(adap);
@@ -738,7 +738,7 @@ static int aspeed_i2c_master_xfer(struct i2c_adapter *adap,
 		return -ETIMEDOUT;
 	}
 
-	return bus->master_xfer_result;
+	return bus->xfer_result;
 }
 
 static u32 aspeed_i2c_functionality(struct i2c_adapter *adap)
@@ -748,7 +748,7 @@ static u32 aspeed_i2c_functionality(struct i2c_adapter *adap)
 
 #if IS_ENABLED(CONFIG_I2C_SLAVE)
 /* precondition: bus.lock has been acquired. */
-static void __aspeed_i2c_reg_slave(struct aspeed_i2c_bus *bus, u16 slave_addr)
+static void __aspeed_i2c_reg_target(struct aspeed_i2c_bus *bus, u16 slave_addr)
 {
 	u32 addr_reg_val, func_ctrl_reg_val;
 
@@ -770,7 +770,7 @@ static void __aspeed_i2c_reg_slave(struct aspeed_i2c_bus *bus, u16 slave_addr)
 	bus->slave_state = ASPEED_I2C_SLAVE_INACTIVE;
 }
 
-static int aspeed_i2c_reg_slave(struct i2c_client *client)
+static int aspeed_i2c_reg_target(struct i2c_client *client)
 {
 	struct aspeed_i2c_bus *bus = i2c_get_adapdata(client->adapter);
 	unsigned long flags;
@@ -781,7 +781,7 @@ static int aspeed_i2c_reg_slave(struct i2c_client *client)
 		return -EINVAL;
 	}
 
-	__aspeed_i2c_reg_slave(bus, client->addr);
+	__aspeed_i2c_reg_target(bus, client->addr);
 
 	bus->slave = client;
 	spin_unlock_irqrestore(&bus->lock, flags);
@@ -789,7 +789,7 @@ static int aspeed_i2c_reg_slave(struct i2c_client *client)
 	return 0;
 }
 
-static int aspeed_i2c_unreg_slave(struct i2c_client *client)
+static int aspeed_i2c_unreg_target(struct i2c_client *client)
 {
 	struct aspeed_i2c_bus *bus = i2c_get_adapdata(client->adapter);
 	u32 func_ctrl_reg_val;
@@ -814,11 +814,11 @@ static int aspeed_i2c_unreg_slave(struct i2c_client *client)
 #endif /* CONFIG_I2C_SLAVE */
 
 static const struct i2c_algorithm aspeed_i2c_algo = {
-	.master_xfer	= aspeed_i2c_master_xfer,
+	.xfer	= aspeed_i2c_xfer,
 	.functionality	= aspeed_i2c_functionality,
 #if IS_ENABLED(CONFIG_I2C_SLAVE)
-	.reg_slave	= aspeed_i2c_reg_slave,
-	.unreg_slave	= aspeed_i2c_unreg_slave,
+	.reg_target	= aspeed_i2c_reg_target,
+	.unreg_target	= aspeed_i2c_unreg_target,
 #endif /* CONFIG_I2C_SLAVE */
 };
 
@@ -950,7 +950,7 @@ static int aspeed_i2c_init(struct aspeed_i2c_bus *bus,
 #if IS_ENABLED(CONFIG_I2C_SLAVE)
 	/* If slave has already been registered, re-enable it. */
 	if (bus->slave)
-		__aspeed_i2c_reg_slave(bus, bus->slave->addr);
+		__aspeed_i2c_reg_target(bus, bus->slave->addr);
 #endif /* CONFIG_I2C_SLAVE */
 
 	/* Set interrupt generation of I2C controller */
-- 
2.43.0


