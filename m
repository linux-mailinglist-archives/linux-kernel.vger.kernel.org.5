Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 339597540E7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236240AbjGNRon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236210AbjGNRo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:44:29 -0400
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67933A82;
        Fri, 14 Jul 2023 10:44:21 -0700 (PDT)
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3476d0b5295so9349635ab.1;
        Fri, 14 Jul 2023 10:44:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689356661; x=1691948661;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=okCesB8vq0x8U1gsD/TWacF0WVO1m+nFy/8yiC3iifs=;
        b=CQ1LlXAjDoaXd37VCFb0rAHw1Q36UVIP9Bh40ePh0xfiFa3+a+caylf2rGA49QS+oZ
         yDL4PIBKTV+BP/fJyG3MzDNwmDGBHjFWDXn/k7TKAw2N7jwlQ0ogNMBshkkKTs+C2zW/
         FshMEvcJN6U2rz6Tju3qmSwujreiesVZAAeY+57+okbmGoS+K0I7GdMptiIsJvPLQ5+K
         PjS7fYbG0HEef0Bi5ue8XKxjGpjG1YG5sFkSKVSJQ9rACMSeSzCPlLQlM9oRtAbsgYP+
         HlzXsI2UomPFBHllNBso7hxIv8hZ4fdg1YS7XhHDl40Ozc1vjNlCzvU0x4xIhcM9c3tM
         jAsA==
X-Gm-Message-State: ABy/qLZOKam16XTnSmlav+kiCDUZD9JookFtc/UrxLVujhDlQx3yNmEi
        JkPHQ8DGKfNj7yUb7C858g==
X-Google-Smtp-Source: APBJJlFC2jC+f9N75sk1i5bkaRbQnatr5CTlxojDWcK0dyUdA9EdNzmSrILtuG0RK4PvsUULof8+BQ==
X-Received: by 2002:a92:dc09:0:b0:345:e5ab:e177 with SMTP id t9-20020a92dc09000000b00345e5abe177mr4830492iln.9.1689356660838;
        Fri, 14 Jul 2023 10:44:20 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id o14-20020a02cc2e000000b0042acf389acesm2580556jap.71.2023.07.14.10.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:44:20 -0700 (PDT)
Received: (nullmailer pid 4054150 invoked by uid 1000);
        Fri, 14 Jul 2023 17:44:18 -0000
From:   Rob Herring <robh@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH] cpufreq: Explicitly include correct DT includes
Date:   Fri, 14 Jul 2023 11:44:13 -0600
Message-Id: <20230714174414.4054011-1-robh@kernel.org>
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
 drivers/cpufreq/armada-37xx-cpufreq.c  | 4 +---
 drivers/cpufreq/mediatek-cpufreq-hw.c  | 3 ++-
 drivers/cpufreq/ppc_cbe_cpufreq.c      | 2 +-
 drivers/cpufreq/ppc_cbe_cpufreq_pmi.c  | 1 -
 drivers/cpufreq/qcom-cpufreq-nvmem.c   | 1 -
 drivers/cpufreq/scpi-cpufreq.c         | 2 +-
 drivers/cpufreq/sti-cpufreq.c          | 2 +-
 drivers/cpufreq/ti-cpufreq.c           | 2 +-
 drivers/cpufreq/vexpress-spc-cpufreq.c | 1 -
 9 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/cpufreq/armada-37xx-cpufreq.c b/drivers/cpufreq/armada-37xx-cpufreq.c
index b74289a95a17..bea41ccabf1f 100644
--- a/drivers/cpufreq/armada-37xx-cpufreq.c
+++ b/drivers/cpufreq/armada-37xx-cpufreq.c
@@ -14,10 +14,8 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/mfd/syscon.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of_address.h>
-#include <linux/of_device.h>
-#include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
 #include <linux/regmap.h>
diff --git a/drivers/cpufreq/mediatek-cpufreq-hw.c b/drivers/cpufreq/mediatek-cpufreq-hw.c
index b22f5cc8a463..c93e14eb6221 100644
--- a/drivers/cpufreq/mediatek-cpufreq-hw.c
+++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
@@ -10,8 +10,9 @@
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of_address.h>
+#include <linux/of.h>
 #include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/slab.h>
 
 #define LUT_MAX_ENTRIES			32U
diff --git a/drivers/cpufreq/ppc_cbe_cpufreq.c b/drivers/cpufreq/ppc_cbe_cpufreq.c
index e3313ce63b38..88afc49941b7 100644
--- a/drivers/cpufreq/ppc_cbe_cpufreq.c
+++ b/drivers/cpufreq/ppc_cbe_cpufreq.c
@@ -9,7 +9,7 @@
 
 #include <linux/cpufreq.h>
 #include <linux/module.h>
-#include <linux/of_platform.h>
+#include <linux/of.h>
 
 #include <asm/machdep.h>
 #include <asm/cell-regs.h>
diff --git a/drivers/cpufreq/ppc_cbe_cpufreq_pmi.c b/drivers/cpufreq/ppc_cbe_cpufreq_pmi.c
index 4fba3637b115..6f0c32592416 100644
--- a/drivers/cpufreq/ppc_cbe_cpufreq_pmi.c
+++ b/drivers/cpufreq/ppc_cbe_cpufreq_pmi.c
@@ -11,7 +11,6 @@
 #include <linux/types.h>
 #include <linux/timer.h>
 #include <linux/init.h>
-#include <linux/of_platform.h>
 #include <linux/pm_qos.h>
 #include <linux/slab.h>
 
diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index a88b6fe5db50..4590c2570086 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -22,7 +22,6 @@
 #include <linux/module.h>
 #include <linux/nvmem-consumer.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_opp.h>
diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
index fd2c16821d54..ac719aca49b7 100644
--- a/drivers/cpufreq/scpi-cpufreq.c
+++ b/drivers/cpufreq/scpi-cpufreq.c
@@ -14,7 +14,7 @@
 #include <linux/cpumask.h>
 #include <linux/export.h>
 #include <linux/module.h>
-#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/pm_opp.h>
 #include <linux/scpi_protocol.h>
 #include <linux/slab.h>
diff --git a/drivers/cpufreq/sti-cpufreq.c b/drivers/cpufreq/sti-cpufreq.c
index 1a63aeea8711..9c542e723a15 100644
--- a/drivers/cpufreq/sti-cpufreq.c
+++ b/drivers/cpufreq/sti-cpufreq.c
@@ -13,7 +13,7 @@
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/pm_opp.h>
 #include <linux/regmap.h>
 
diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index d5cd2fd25cad..3c37d7899660 100644
--- a/drivers/cpufreq/ti-cpufreq.c
+++ b/drivers/cpufreq/ti-cpufreq.c
@@ -12,7 +12,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/of.h>
-#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/pm_opp.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
diff --git a/drivers/cpufreq/vexpress-spc-cpufreq.c b/drivers/cpufreq/vexpress-spc-cpufreq.c
index d295f405c4bb..865e50164803 100644
--- a/drivers/cpufreq/vexpress-spc-cpufreq.c
+++ b/drivers/cpufreq/vexpress-spc-cpufreq.c
@@ -18,7 +18,6 @@
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
-#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
 #include <linux/slab.h>
-- 
2.40.1

