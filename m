Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD7075412B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235667AbjGNRsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236511AbjGNRsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:48:08 -0400
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CEB270A;
        Fri, 14 Jul 2023 10:47:48 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7835ae70e46so89119439f.3;
        Fri, 14 Jul 2023 10:47:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689356840; x=1691948840;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZsEsfKX6fx2CPTk8lEiCg36FX1KD3cI2EzS3pEP/M1Y=;
        b=Iz+iZ4mY9aEioEgjtcQS8qN8ehsbWSu7h84PGSz3DqxYz+TjMq+n8lzBxNyKo30c14
         cr1S7bQd3pWe9ata1tsIDgYVDS0kYLZ4OBFlrokmZ8dLPWdhPRh55gbGJooHigfmBTOv
         njuXzt2ZtWYClBt1UiPJKkYfg10paOQy3Nu1wcHRlBoRYr2mPzIq87oKZc0TwEg1Dj01
         yCAp3VS78ZiY322kMyMKTiCaZJvnLIuCXyAztvqqM1HQL/EW8dnClIjYILZS3KvHTYmf
         7UNheC+DmVBQAcCgXL3Kl9WsU4PdacnmUFFhCpcVy6yIbyYv3YUNP4oAGwrFdEtzTdf3
         Jx8A==
X-Gm-Message-State: ABy/qLYkbHvukrVG4T3pRmy5wgVlnnTlzeriz5snMfuCL0OdMG32QSKp
        5SdKmV7cwyul8XOQgktPdg==
X-Google-Smtp-Source: APBJJlHtkf2StfuBbwBf8coPVemYiYLnfRrMm7RxOWmK/J92J/Cq3PmUW0tNGo59CjkyVi79zBYnag==
X-Received: by 2002:a5e:da4c:0:b0:783:5e4e:b785 with SMTP id o12-20020a5eda4c000000b007835e4eb785mr5813551iop.19.1689356840237;
        Fri, 14 Jul 2023 10:47:20 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id b25-20020a05663801b900b0042b3a328ee0sm2682686jaq.166.2023.07.14.10.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:47:19 -0700 (PDT)
Received: (nullmailer pid 4059057 invoked by uid 1000);
        Fri, 14 Jul 2023 17:47:01 -0000
From:   Rob Herring <robh@kernel.org>
To:     Colin Leroy <colin@colino.net>
Cc:     devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] macintosh: Explicitly include correct DT includes
Date:   Fri, 14 Jul 2023 11:46:54 -0600
Message-Id: <20230714174654.4058898-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DT of_device.h and of_platform.h date back to the separate
of_platform_bus_type before it as merged into the regular platform bus.
As part of that merge prepping Arm DT support 13 years ago, they
"temporarily" include each other. They also include platform_device.h
and of.h. As a result, there's a pretty much random mix of those include
files used throughout the tree. In order to detangle these headers and
replace the implicit includes with struct declarations, users need to
explicitly include the correct includes.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/macintosh/ams/ams.h              |  1 -
 drivers/macintosh/smu.c                  |  1 +
 drivers/macintosh/therm_adt746x.c        |  2 ++
 drivers/macintosh/therm_windtunnel.c     | 22 ++++++++++++----------
 drivers/macintosh/windfarm_lm75_sensor.c |  4 ++--
 5 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/macintosh/ams/ams.h b/drivers/macintosh/ams/ams.h
index 2c159c8844c1..e053c1515460 100644
--- a/drivers/macintosh/ams/ams.h
+++ b/drivers/macintosh/ams/ams.h
@@ -8,7 +8,6 @@
 #include <linux/mutex.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
-#include <linux/of_device.h>
 
 enum ams_irq {
 	AMS_IRQ_FREEFALL = 0x01,
diff --git a/drivers/macintosh/smu.c b/drivers/macintosh/smu.c
index 5183a00529f5..b2b78a53e532 100644
--- a/drivers/macintosh/smu.c
+++ b/drivers/macintosh/smu.c
@@ -37,6 +37,7 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/sched/signal.h>
 
diff --git a/drivers/macintosh/therm_adt746x.c b/drivers/macintosh/therm_adt746x.c
index 53ea56b286f9..00693741f744 100644
--- a/drivers/macintosh/therm_adt746x.c
+++ b/drivers/macintosh/therm_adt746x.c
@@ -25,7 +25,9 @@
 #include <linux/kthread.h>
 #include <linux/moduleparam.h>
 #include <linux/freezer.h>
+#include <linux/of.h>
 #include <linux/of_platform.h>
+#include <linux/platform_device.h>
 
 #include <asm/machdep.h>
 #include <asm/io.h>
diff --git a/drivers/macintosh/therm_windtunnel.c b/drivers/macintosh/therm_windtunnel.c
index 18a982454321..52289de15058 100644
--- a/drivers/macintosh/therm_windtunnel.c
+++ b/drivers/macintosh/therm_windtunnel.c
@@ -1,9 +1,9 @@
-/* 
+/*
  *   Creation Date: <2003/03/14 20:54:13 samuel>
  *   Time-stamp: <2004/03/20 14:20:59 samuel>
- *   
+ *
  *	<therm_windtunnel.c>
- *	
+ *
  *	The G4 "windtunnel" has a single fan controlled by an
  *	ADM1030 fan controller and a DS1775 thermostat.
  *
@@ -20,11 +20,11 @@
  *   Copyright (C) 2003, 2004 Samuel Rydh (samuel@ibrium.se)
  *
  *   Loosely based upon 'thermostat.c' written by Benjamin Herrenschmidt
- *   
+ *
  *   This program is free software; you can redistribute it and/or
  *   modify it under the terms of the GNU General Public License
  *   as published by the Free Software Foundation
- *   
+ *
  */
 
 #include <linux/types.h>
@@ -36,7 +36,9 @@
 #include <linux/i2c.h>
 #include <linux/init.h>
 #include <linux/kthread.h>
+#include <linux/of.h>
 #include <linux/of_platform.h>
+#include <linux/platform_device.h>
 
 #include <asm/machdep.h>
 #include <asm/io.h>
@@ -48,10 +50,10 @@
 static struct {
 	volatile int		running;
 	struct task_struct	*poll_task;
-	
+
 	struct mutex	 	lock;
 	struct platform_device	*of_dev;
-	
+
 	struct i2c_client	*thermostat;
 	struct i2c_client	*fan;
 
@@ -127,7 +129,7 @@ write_reg( struct i2c_client *cl, int reg, int data, int len )
 	tmp[1] = (len == 1) ? data : (data >> 8);
 	tmp[2] = data;
 	len++;
-	
+
 	if( i2c_master_send(cl, tmp, len) != len )
 		return -ENODEV;
 	return 0;
@@ -369,7 +371,7 @@ attach_fan( struct i2c_client *cl )
 }
 
 static int
-attach_thermostat( struct i2c_client *cl ) 
+attach_thermostat( struct i2c_client *cl )
 {
 	int hyst_temp, os_temp, temp;
 
@@ -378,7 +380,7 @@ attach_thermostat( struct i2c_client *cl )
 
 	if( (temp=read_reg(cl, 0, 2)) < 0 )
 		goto out;
-	
+
 	/* temperature sanity check */
 	if( temp < 0x1600 || temp > 0x3c00 )
 		goto out;
diff --git a/drivers/macintosh/windfarm_lm75_sensor.c b/drivers/macintosh/windfarm_lm75_sensor.c
index 48dbdb2bda15..6b26e0f92105 100644
--- a/drivers/macintosh/windfarm_lm75_sensor.c
+++ b/drivers/macintosh/windfarm_lm75_sensor.c
@@ -14,7 +14,7 @@
 #include <linux/init.h>
 #include <linux/wait.h>
 #include <linux/i2c.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <asm/machdep.h>
 #include <asm/io.h>
 #include <asm/sections.h>
@@ -128,7 +128,7 @@ static int wf_lm75_probe(struct i2c_client *client)
 		name = "cpu-inlet-temp-1";
 	else
 		return -ENXIO;
- 	
+
 
 	lm = kzalloc(sizeof(struct wf_lm75_sensor), GFP_KERNEL);
 	if (lm == NULL)
-- 
2.40.1

