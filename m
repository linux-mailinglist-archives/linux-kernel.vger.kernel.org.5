Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03C57DBDC8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 17:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbjJ3Q0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 12:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232887AbjJ3Q0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 12:26:42 -0400
Received: from cnc.isely.net (cnc.isely.net [192.69.181.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A44DA
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 09:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=isely.net; s=deb;
        t=1698682891; bh=RJdQVRnJ416Wgcvb+WG6qIsjnzbvVyX8BWqzPyjn0Lw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=B3htted8H4OPvFO0ZKlY6OyIk66ctUL+MsAlwryE2lPloLVr5B5eHDasV4oHbwKR8
         6pED6Dp6FaQRoCIoTKhA8xonLSXFyaUzqlPEwCA4One02DRulNggogOjce3FFFc9N5
         bXWeaPBB20PITelVzhY4T22o2ilSs1oawHM7KPWfYkEMw9M5IMeD1oK99CySy
Original-Subject: [PATCH 2/2] [i2c-bcm2835] ALWAYS enable INTD
Author: mike.isely@cobaltdigital.com
Original-Cc: Mike Isely <mike.isely@cobaltdigital.com>,
  Mike Isely <isely@pobox.com>,
  Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
  Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
  linux-rpi-kernel@lists.infradead.org,
  linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Received: from cobalt1.eng.cobalt.local (ts3-dock1.isely.net [::ffff:192.168.23.13])
  (AUTH: PLAIN isely, TLS: TLS1.3,256bits,ECDHE_RSA_AES_256_GCM_SHA384)
  by cnc.isely.net with ESMTPSA
  id 000000000008096B.00000000653FD80B.00007A07; Mon, 30 Oct 2023 11:21:31 -0500
From:   mike.isely@cobaltdigital.com
To:     Andi Shyti <andi.shyti@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     Mike Isely <mike.isely@cobaltdigital.com>,
        Mike Isely <isely@pobox.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] [i2c-bcm2835] ALWAYS enable INTD
Date:   Mon, 30 Oct 2023 11:21:14 -0500
Message-Id: <20231030162114.3603829-3-mike.isely@cobaltdigital.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231030162114.3603829-1-mike.isely@cobaltdigital.com>
References: <20231030162114.3603829-1-mike.isely@cobaltdigital.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Isely <mike.isely@cobaltdigital.com>

There is a race in the bcm2835 i2c hardware: When one starts a write
transaction, two things apparently take place at the same time: (1) an
interrupt is posted to cause the FIFO to be filled with TX data,
and (2) an I2C transaction is started on the wire with the slave
select byte.  The race happens if there's no slave, as this causes a
slave selection timeout, raising the ERR flag in the hardware and
setting DONE.  The setting of that DONE flag races against TXW.  If
TXW gets set first, then an interrupt is raised if INTT was set.  If
ERR gets set first, then an interrupt is raised if INTD was set.  It's
one or the other, not both - probably because DONE being set disables
the hardware INTT interrupt path.

MOST of the time, TXW gets set first, the ISR runs, sees ERR is set
and cleanly fails the transaction.  However some of the time DONE gets
set first - but since the driver doesn't enable INTD until it's on the
last message - there's no interrupt at all.  Thus the ISR never fires
and the driver detects a timeout instead.  At best, the "wrong" error
code is delivered to the owner of the transaction.  At worst, if the
timeout doesn't propertly clean up the hardware (see prior commit
fixing that), the next - likely unrelated - transaction will get
fouled, leading to bizarre behavior in logic otherwise unrelated to
the source of the original error.

The fix here is to set INTD on for all messages not just the last one.
In that way, unexpected failures which might set DONE earlier than
expected will always trigger an interrupt and be handled correctly.

The datasheet for this hardware doesn't describe any scenario where
the hardware can realistically hang - even a stretched clock will be
noticed if it takes too long.  So in theory a timeout should really
NEVER happen, and with this fix I was completely unable to trigger any
further timeouts at all.

Signed-off-by: Mike Isely <isely@pobox.com>
---
 drivers/i2c/busses/i2c-bcm2835.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c
index 96de875394e1..70005c037ff9 100644
--- a/drivers/i2c/busses/i2c-bcm2835.c
+++ b/drivers/i2c/busses/i2c-bcm2835.c
@@ -235,26 +235,22 @@ static void bcm2835_drain_rxfifo(struct bcm2835_i2c_dev *i2c_dev)
 
 static void bcm2835_i2c_start_transfer(struct bcm2835_i2c_dev *i2c_dev)
 {
-	u32 c = BCM2835_I2C_C_ST | BCM2835_I2C_C_I2CEN;
+	u32 c = BCM2835_I2C_C_ST | BCM2835_I2C_C_I2CEN | BCM2835_I2C_C_INTD;
 	struct i2c_msg *msg = i2c_dev->curr_msg;
-	bool last_msg = (i2c_dev->num_msgs == 1);
 
 	if (!i2c_dev->num_msgs)
 		return;
 
 	i2c_dev->num_msgs--;
 	i2c_dev->msg_buf = msg->buf;
 	i2c_dev->msg_buf_remaining = msg->len;
 
 	if (msg->flags & I2C_M_RD)
 		c |= BCM2835_I2C_C_READ | BCM2835_I2C_C_INTR;
 	else
 		c |= BCM2835_I2C_C_INTT;
 
-	if (last_msg)
-		c |= BCM2835_I2C_C_INTD;
-
 	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_A, msg->addr);
 	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_DLEN, msg->len);
 	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_C, c);
 }
-- 
2.39.2

