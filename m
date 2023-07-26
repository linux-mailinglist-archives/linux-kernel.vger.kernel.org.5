Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3BE76428B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 01:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjGZXbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 19:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjGZXbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 19:31:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEE12704;
        Wed, 26 Jul 2023 16:31:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 228B561CDB;
        Wed, 26 Jul 2023 23:31:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD987C433C7;
        Wed, 26 Jul 2023 23:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690414303;
        bh=r7QYHW3VKvt2WtGg9gadUOAfwlfHNf+lUew4M0VWzWI=;
        h=From:To:Cc:Subject:Date:From;
        b=FigZcKcQPrGdBwQ9/L3i6PvgDhZ3jNe5Mw1YIWYsG0dTKG8E6LYsAy771371B2OfD
         DdId4YZkV7bvFGCfq0m7+VBBDGditUnRGUnwfe5jBd09q7vb7vpxc8hXP1MBkRl7Ke
         ta1gWNaSi3dsRutqCYI4bwQZn99HVRXmQUGeuP3oMa+pAtZxHdO4Viobu1cF1Bhvbk
         ELIRKd9CPw52H7ZNeM4bGi32fpmfe2dj4c5fmRep88RMmAcwSkMv28YPU5/b1JAFWG
         QLnYnjAXbm5Yz1t2WezhagAogiEJyGYRLUHAuV3hY17Aka1DZ4E0vs6KYRpR9hETET
         a8Is0LCZwn/9Q==
Received: (nullmailer pid 3811250 invoked by uid 1000);
        Wed, 26 Jul 2023 23:31:41 -0000
From:   Rob Herring <robh@kernel.org>
To:     =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>
Cc:     =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        linux-pm@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] soc: bcm: Explicitly include correct DT includes
Date:   Wed, 26 Jul 2023 17:31:29 -0600
Message-Id: <20230726233130.3811017-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DT of_device.h and of_platform.h date back to the separate
of_platform_bus_type before it was merged into the regular platform bus.
As part of that merge prepping Arm DT support 13 years ago, they
"temporarily" include each other. They also include platform_device.h
and of.h. As a result, there's a pretty much random mix of those include
files used throughout the tree. In order to detangle these headers and
replace the implicit includes with struct declarations, users need to
explicitly include the correct includes.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
 - Fix typo in commit msg
 - Add raspberrypi-power.c
---
 drivers/soc/bcm/bcm63xx/bcm-pmb.c       | 1 -
 drivers/soc/bcm/bcm63xx/bcm63xx-power.c | 1 -
 drivers/soc/bcm/raspberrypi-power.c     | 2 +-
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/soc/bcm/bcm63xx/bcm-pmb.c b/drivers/soc/bcm/bcm63xx/bcm-pmb.c
index 9407cac47fdb..a72ba26ecf9d 100644
--- a/drivers/soc/bcm/bcm63xx/bcm-pmb.c
+++ b/drivers/soc/bcm/bcm63xx/bcm-pmb.c
@@ -8,7 +8,6 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/reset/bcm63xx_pmb.h>
diff --git a/drivers/soc/bcm/bcm63xx/bcm63xx-power.c b/drivers/soc/bcm/bcm63xx/bcm63xx-power.c
index aa72e13d5d0e..98b0c2430dbc 100644
--- a/drivers/soc/bcm/bcm63xx/bcm63xx-power.c
+++ b/drivers/soc/bcm/bcm63xx/bcm63xx-power.c
@@ -14,7 +14,6 @@
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 
 struct bcm63xx_power_dev {
 	struct generic_pm_domain genpd;
diff --git a/drivers/soc/bcm/raspberrypi-power.c b/drivers/soc/bcm/raspberrypi-power.c
index 58175af982a0..06196ebfe03b 100644
--- a/drivers/soc/bcm/raspberrypi-power.c
+++ b/drivers/soc/bcm/raspberrypi-power.c
@@ -7,7 +7,7 @@
  */
 
 #include <linux/module.h>
-#include <linux/of_platform.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <dt-bindings/power/raspberrypi-power.h>
-- 
2.40.1

