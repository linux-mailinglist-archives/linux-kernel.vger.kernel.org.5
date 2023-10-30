Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E09867DBDC7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 17:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbjJ3Q0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 12:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbjJ3Q0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 12:26:42 -0400
X-Greylist: delayed 308 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 30 Oct 2023 09:26:40 PDT
Received: from cnc.isely.net (cnc.isely.net [192.69.181.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4020CD9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 09:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=isely.net; s=deb;
        t=1698682891; bh=hfdYzCdm+x+tKMPgcOZzIeuFJxxf0KYbhVmSfhSKie0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=AEhPwc3ik23Rivj/BYW/k5RTjxSASvnPmmZsZ2pJKq0Fu3t/B+OIYQ2KW1Fi3xX9w
         n+owQehpIKD4JXkT5R0h5K7i2Oatqp3g2yXkk0DZRbLHc1th1QKUcqK4XfX1zvzfjC
         jVgaAnB5Kv/vejUF++ujkzN3mZbPxg3HOSO9Wf7QL7gdoacwfFZOoKvFBEyM7
Original-Subject: [PATCH 1/2] [i2c-bcm2835] Fully clean up hardware state machine after a timeout
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
  id 000000000008093D.00000000653FD80B.000079FF; Mon, 30 Oct 2023 11:21:31 -0500
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
Subject: [PATCH 1/2] [i2c-bcm2835] Fully clean up hardware state machine after a timeout
Date:   Mon, 30 Oct 2023 11:21:13 -0500
Message-Id: <20231030162114.3603829-2-mike.isely@cobaltdigital.com>
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

When the driver detects a timeout, there's no guarantee that the ISR
would have fired.  Thus after a timeout, it's the foreground that
becomes responsible to reset the hardware state machine.  The change
here just duplicates what is already implemented in the ISR.

Signed-off-by: Mike Isely <isely@pobox.com>
---
 drivers/i2c/busses/i2c-bcm2835.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c
index 8ce6d3f49551..96de875394e1 100644
--- a/drivers/i2c/busses/i2c-bcm2835.c
+++ b/drivers/i2c/busses/i2c-bcm2835.c
@@ -345,42 +345,46 @@ static irqreturn_t bcm2835_i2c_isr(int this_irq, void *data)
 static int bcm2835_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
 			    int num)
 {
 	struct bcm2835_i2c_dev *i2c_dev = i2c_get_adapdata(adap);
 	unsigned long time_left;
 	int i;
 
 	for (i = 0; i < (num - 1); i++)
 		if (msgs[i].flags & I2C_M_RD) {
 			dev_warn_once(i2c_dev->dev,
 				      "only one read message supported, has to be last\n");
 			return -EOPNOTSUPP;
 		}
 
 	i2c_dev->curr_msg = msgs;
 	i2c_dev->num_msgs = num;
 	reinit_completion(&i2c_dev->completion);
 
 	bcm2835_i2c_start_transfer(i2c_dev);
 
 	time_left = wait_for_completion_timeout(&i2c_dev->completion,
 						adap->timeout);
 
 	bcm2835_i2c_finish_transfer(i2c_dev);
 
 	if (!time_left) {
+		/* Since we can't trust the ISR to have cleaned up, do the
+		 * full cleanup here... */
 		bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_C,
 				   BCM2835_I2C_C_CLEAR);
+		bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_S, BCM2835_I2C_S_CLKT |
+				   BCM2835_I2C_S_ERR | BCM2835_I2C_S_DONE);
 		dev_err(i2c_dev->dev, "i2c transfer timed out\n");
 		return -ETIMEDOUT;
 	}
 
 	if (!i2c_dev->msg_err)
 		return num;
 
 	dev_dbg(i2c_dev->dev, "i2c transfer failed: %x\n", i2c_dev->msg_err);
 
 	if (i2c_dev->msg_err & BCM2835_I2C_S_ERR)
 		return -EREMOTEIO;
 
 	return -EIO;
 }
-- 
2.39.2

