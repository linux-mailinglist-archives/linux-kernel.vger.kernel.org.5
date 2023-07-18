Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E26757F95
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 16:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233011AbjGRObk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 10:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbjGRObg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 10:31:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0101BD9;
        Tue, 18 Jul 2023 07:31:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26F0C615E2;
        Tue, 18 Jul 2023 14:31:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DB62C433C7;
        Tue, 18 Jul 2023 14:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689690670;
        bh=KFSOdgGe2AR4rCLx81EdF6WoCI+RZt43fQf1DLPQLYg=;
        h=From:To:Cc:Subject:Date:From;
        b=clYMJlj7g8He9tuMGZ8gXMzyV1Xn9XporLTeQxR7cM5i+sjbFBFNpglXf7kgfEOYj
         fSt3DoxGYG1koXlwohYqsHcAAEPei3NecuG5uRQjzPEphai8TtgsVLv9cBnIDmoWMP
         yH6B6+xTsmtOX+G17kMUHMEEIQ+fJhlV+41s+ENFHxdXPJmVHobxVfD/MtR+q/5L0V
         MEijRNwKYh8YzFf00Jzw/khWAXIJmZwERzJMtxfYCOIHQes99tWXExjbdX5/xoUCdJ
         OuSAGcf4hySbCSH/XjKvNP3On0YXcuIx7F6ewRiUzWAWfY0XkK12xGzm76W2zVgQU0
         Yk51ZrYmZiqxQ==
Received: (nullmailer pid 1065624 invoked by uid 1000);
        Tue, 18 Jul 2023 14:31:08 -0000
From:   Rob Herring <robh@kernel.org>
To:     Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Eric Piel <eric.piel@tremplin-utc.net>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Derek Kiernan <derek.kiernan@amd.com>,
        Dragan Cvetic <dragan.cvetic@amd.com>,
        Michal Simek <michal.simek@amd.com>,
        Appana Durga Kedareswara rao 
        <appana.durga.kedareswara.rao@amd.com>
Cc:     devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] misc: Explicitly include correct DT includes
Date:   Tue, 18 Jul 2023 08:31:01 -0600
Message-Id: <20230718143102.1065481-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
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
of_platform_bus_type before it as merged into the regular platform bus.
As part of that merge prepping Arm DT support 13 years ago, they
"temporarily" include each other. They also include platform_device.h
and of.h. As a result, there's a pretty much random mix of those include
files used throughout the tree. In order to detangle these headers and
replace the implicit includes with struct declarations, users need to
explicitly include the correct includes.

Acked-by: Andrew Donnellan <ajd@linux.ibm.com> # cxl
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
- Fix double include of of.h
---
 drivers/misc/cxl/base.c            | 1 +
 drivers/misc/fastrpc.c             | 1 +
 drivers/misc/lis3lv02d/lis3lv02d.c | 2 +-
 drivers/misc/qcom-coincell.c       | 1 -
 drivers/misc/sram.c                | 2 +-
 drivers/misc/vcpu_stall_detector.c | 1 -
 drivers/misc/xilinx_sdfec.c        | 3 ++-
 drivers/misc/xilinx_tmr_inject.c   | 3 ++-
 drivers/misc/xilinx_tmr_manager.c  | 3 ++-
 9 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/cxl/base.c b/drivers/misc/cxl/base.c
index cc0caf9192dc..b054562c046e 100644
--- a/drivers/misc/cxl/base.c
+++ b/drivers/misc/cxl/base.c
@@ -7,6 +7,7 @@
 #include <linux/rcupdate.h>
 #include <asm/errno.h>
 #include <misc/cxl-base.h>
+#include <linux/of.h>
 #include <linux/of_platform.h>
 #include "cxl.h"
 
diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 9666d28037e1..1c7c0532da6f 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/of.h>
+#include <linux/platform_device.h>
 #include <linux/sort.h>
 #include <linux/of_platform.h>
 #include <linux/rpmsg.h>
diff --git a/drivers/misc/lis3lv02d/lis3lv02d.c b/drivers/misc/lis3lv02d/lis3lv02d.c
index 299d316f1bda..49868a45c0ad 100644
--- a/drivers/misc/lis3lv02d/lis3lv02d.c
+++ b/drivers/misc/lis3lv02d/lis3lv02d.c
@@ -26,7 +26,7 @@
 #include <linux/miscdevice.h>
 #include <linux/pm_runtime.h>
 #include <linux/atomic.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include "lis3lv02d.h"
 
 #define DRIVER_NAME     "lis3lv02d"
diff --git a/drivers/misc/qcom-coincell.c b/drivers/misc/qcom-coincell.c
index 54d4f6ee8888..3c57f7429147 100644
--- a/drivers/misc/qcom-coincell.c
+++ b/drivers/misc/qcom-coincell.c
@@ -8,7 +8,6 @@
 #include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/regmap.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 
 struct qcom_coincell {
diff --git a/drivers/misc/sram.c b/drivers/misc/sram.c
index 5757adf418b1..a88f92cf35be 100644
--- a/drivers/misc/sram.c
+++ b/drivers/misc/sram.c
@@ -10,8 +10,8 @@
 #include <linux/genalloc.h>
 #include <linux/io.h>
 #include <linux/list_sort.h>
+#include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
diff --git a/drivers/misc/vcpu_stall_detector.c b/drivers/misc/vcpu_stall_detector.c
index 53b5506080e1..6479c962da1a 100644
--- a/drivers/misc/vcpu_stall_detector.c
+++ b/drivers/misc/vcpu_stall_detector.c
@@ -13,7 +13,6 @@
 #include <linux/module.h>
 #include <linux/nmi.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/param.h>
 #include <linux/percpu.h>
 #include <linux/platform_device.h>
diff --git a/drivers/misc/xilinx_sdfec.c b/drivers/misc/xilinx_sdfec.c
index 270ff4c5971a..29e9c380b643 100644
--- a/drivers/misc/xilinx_sdfec.c
+++ b/drivers/misc/xilinx_sdfec.c
@@ -15,7 +15,8 @@
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of_platform.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
 #include <linux/poll.h>
 #include <linux/slab.h>
 #include <linux/clk.h>
diff --git a/drivers/misc/xilinx_tmr_inject.c b/drivers/misc/xilinx_tmr_inject.c
index d96f6d7cd109..9fc5835bfebc 100644
--- a/drivers/misc/xilinx_tmr_inject.c
+++ b/drivers/misc/xilinx_tmr_inject.c
@@ -11,7 +11,8 @@
 
 #include <asm/xilinx_mb_manager.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
 #include <linux/fault-inject.h>
 
 /* TMR Inject Register offsets */
diff --git a/drivers/misc/xilinx_tmr_manager.c b/drivers/misc/xilinx_tmr_manager.c
index 0ef55e06d3a0..3e4e40c3766f 100644
--- a/drivers/misc/xilinx_tmr_manager.c
+++ b/drivers/misc/xilinx_tmr_manager.c
@@ -15,7 +15,8 @@
 
 #include <asm/xilinx_mb_manager.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
 
 /* TMR Manager Register offsets */
 #define XTMR_MANAGER_CR_OFFSET		0x0
-- 
2.40.1

