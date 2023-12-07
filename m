Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7792D8082DB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 09:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378165AbjLGIWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 03:22:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbjLGIWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 03:22:15 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC03110EA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 00:22:13 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6ce7c1b07e1so320460b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 00:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=friendlyarm-com.20230601.gappssmtp.com; s=20230601; t=1701937333; x=1702542133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xjeb4b6lyrZZzJQNF0NTbIeDzIeVTA8ShffAsyhB2JI=;
        b=byfJvpmDWeAC5/FQCTQtMXSLqar5q/+1tMJQgcD/ehx7ASTCt+dpaA/N514QO+MkrG
         BnSp3bEQAV4uTMVSnaTrPyFK8pfFcgCPzmBxhwrKYOOFkk86gdvJF7KiXD7xlRXBWOi2
         ZS+hkW4xN2aq8BD9MX0urj0ozfEIoB43ka10GnTIiqgNuBpCxdgAD77ao8kw91N+Wrp3
         BQ2115EKHVv2Nbb8ZoqoH5+ErrNQznL+kg1fJtl3EjPRyp7q2+Yl/91qVRCOclJ9JreU
         ZJb34cZsAoGtWl12/oghr96PF4sMIT7hOrg/jYe+xER1YojUnM9BJVo44bnLkXjwE3Wr
         jq0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701937333; x=1702542133;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xjeb4b6lyrZZzJQNF0NTbIeDzIeVTA8ShffAsyhB2JI=;
        b=RJwqiY72ZUBII8xHYPGOnDAsNB637xeyNHS8vlo4sIhU9AikP1deZPq6ESGPyW6Eb1
         fMVMfjpn3WIVvxdbdepwc4Rw6jgzRU5Vc8eDRQubI1eP/m2LR3mKnw2nt1GHdW8RDA0a
         qcD7Bfbte8PLwjWweVOp+Vzql/tn6qFqiufGnI9CSBHP2OUhWhKrfn+fL9kfWJ9BYRey
         h8TMqtdYOKY80/W5BXjee1Nb2eostqNnLUhIuUhpfPyZ6Le59Y95UY5UkKxIDTiapCad
         DNKykb/3KvXZ7oopUBOXe5dc4efjmWtYTcfUmkGB6ER2riKEQQln5qL7raQJ7RUZBMfA
         DI8g==
X-Gm-Message-State: AOJu0YxH8zFzlghO9naedtdUzIp+eZGGK31qhLJHloq1bVR+0x9sAEwH
        9/Xfcd8t0a/azi/G9hD79wwBrA==
X-Google-Smtp-Source: AGHT+IEEurwQbxShDq9JggR47aztflJkGvMYj35SfMTSgXCbvptMap7YnxF/CHrueLnQZPyEL1pr1Q==
X-Received: by 2002:a05:6a00:2d1b:b0:6ce:4b97:b894 with SMTP id fa27-20020a056a002d1b00b006ce4b97b894mr2240031pfb.17.1701937333161;
        Thu, 07 Dec 2023 00:22:13 -0800 (PST)
Received: from jensen.next (li999-236.members.linode.com. [45.33.49.236])
        by smtp.gmail.com with ESMTPSA id o27-20020a63731b000000b005c259cef481sm696377pgc.59.2023.12.07.00.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 00:22:12 -0800 (PST)
From:   Jensen Huang <jensenhuang@friendlyarm.com>
To:     Heiko Stuebner <heiko@sntech.de>,
        Andi Shyti <andi.shyti@kernel.org>
Cc:     Jensen Huang <jensenhuang@friendlyarm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] i2c: rk3x: fix potential spinlock recursion on poll
Date:   Thu,  7 Dec 2023 16:21:59 +0800
Message-ID: <20231207082200.16388-1-jensenhuang@friendlyarm.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Possible deadlock scenario (on reboot):
rk3x_i2c_xfer_common(polling)
    -> rk3x_i2c_wait_xfer_poll()
        -> rk3x_i2c_irq(0, i2c);
            --> spin_lock(&i2c->lock);
            ...
        <rk3x i2c interrupt>
        -> rk3x_i2c_irq(0, i2c);
            --> spin_lock(&i2c->lock); (deadlock here)

Store the IRQ number and disable/enable it around the polling transfer.
This patch has been tested on NanoPC-T4.

Signed-off-by: Jensen Huang <jensenhuang@friendlyarm.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
---
Changes in v2:
 - Add description for member 'irq' to fix build warning

 drivers/i2c/busses/i2c-rk3x.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
index a044ca0c35a1..4362db7c5789 100644
--- a/drivers/i2c/busses/i2c-rk3x.c
+++ b/drivers/i2c/busses/i2c-rk3x.c
@@ -178,6 +178,7 @@ struct rk3x_i2c_soc_data {
  * @clk: function clk for rk3399 or function & Bus clks for others
  * @pclk: Bus clk for rk3399
  * @clk_rate_nb: i2c clk rate change notify
+ * @irq: irq number
  * @t: I2C known timing information
  * @lock: spinlock for the i2c bus
  * @wait: the waitqueue to wait for i2c transfer
@@ -200,6 +201,7 @@ struct rk3x_i2c {
 	struct clk *clk;
 	struct clk *pclk;
 	struct notifier_block clk_rate_nb;
+	int irq;
 
 	/* Settings */
 	struct i2c_timings t;
@@ -1087,13 +1089,18 @@ static int rk3x_i2c_xfer_common(struct i2c_adapter *adap,
 
 		spin_unlock_irqrestore(&i2c->lock, flags);
 
-		rk3x_i2c_start(i2c);
-
 		if (!polling) {
+			rk3x_i2c_start(i2c);
+
 			timeout = wait_event_timeout(i2c->wait, !i2c->busy,
 						     msecs_to_jiffies(WAIT_TIMEOUT));
 		} else {
+			disable_irq(i2c->irq);
+			rk3x_i2c_start(i2c);
+
 			timeout = rk3x_i2c_wait_xfer_poll(i2c);
+
+			enable_irq(i2c->irq);
 		}
 
 		spin_lock_irqsave(&i2c->lock, flags);
@@ -1310,6 +1317,8 @@ static int rk3x_i2c_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	i2c->irq = irq;
+
 	platform_set_drvdata(pdev, i2c);
 
 	if (i2c->soc_data->calc_timings == rk3x_i2c_v0_calc_timings) {
-- 
2.42.0

