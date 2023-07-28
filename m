Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BADF5766EB3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 15:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235582AbjG1Ns0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 09:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233321AbjG1NsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 09:48:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3CA272C;
        Fri, 28 Jul 2023 06:48:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3F2D62130;
        Fri, 28 Jul 2023 13:48:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95A7AC433CC;
        Fri, 28 Jul 2023 13:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690552097;
        bh=sM1z3r4ZQqsZ2MTbur36HkVlI+Jw+HIb1ZJhf9P5mFk=;
        h=From:To:Cc:Subject:Date:From;
        b=K+XLNkPQjlddtcAir0C+2Grni9Y//df2HgRxnbpynnGliRjaZPoFw6ZwzNgw0WV+V
         5ZZnmkJ3ERVpryxRYgacMmaf/zmP13+QZEEWp3MlCXGQHPt4jw2kDXbCUUWrn0Y/mX
         5GMR8wUytZbWiyQUgj6itwC2AiSEIOIFr8qMy4KWlICWEJtX0KrLEDeod03/RvnnRu
         G186yUwMHm5EHtHOJKA7gKSYSfSvKzAu81TE9lOCa8KuLVMIQkS4J84+7Hrh8Zp52Z
         nMxbi0ymE7QKh60tPvV7pLcOH4QaP+BSrDO+u9tfdG/tInx49AT+5UnDVzqQFoYN2C
         jlSei9hY7wqSw==
Received: (nullmailer pid 3223992 invoked by uid 1000);
        Fri, 28 Jul 2023 13:48:15 -0000
From:   Rob Herring <robh@kernel.org>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     devicetree@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] tpm: Explicitly include correct DT includes
Date:   Fri, 28 Jul 2023 07:48:02 -0600
Message-Id: <20230728134803.3223742-1-robh@kernel.org>
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
of_platform_bus_type before it was merged into the regular platform bus.
As part of that merge prepping Arm DT support 13 years ago, they
"temporarily" include each other. They also include platform_device.h
and of.h. As a result, there's a pretty much random mix of those include
files used throughout the tree. In order to detangle these headers and
replace the implicit includes with struct declarations, users need to
explicitly include the correct includes.

Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v3:
 - Split out hw_random, ipmi and tpm
v2:
 - Fix build for pic32-rng.c dropping of_match_ptr()
---
 drivers/char/tpm/tpm_ftpm_tee.c      | 1 -
 drivers/char/tpm/tpm_tis.c           | 1 -
 drivers/char/tpm/tpm_tis_spi_main.c  | 2 +-
 drivers/char/tpm/tpm_tis_synquacer.c | 1 -
 4 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_tee.c
index 528f35b14fb6..76adb108076c 100644
--- a/drivers/char/tpm/tpm_ftpm_tee.c
+++ b/drivers/char/tpm/tpm_ftpm_tee.c
@@ -11,7 +11,6 @@
 
 #include <linux/acpi.h>
 #include <linux/of.h>
-#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/tee_drv.h>
 #include <linux/tpm.h>
diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
index 7db3593941ea..e4030404c64e 100644
--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -25,7 +25,6 @@
 #include <linux/acpi.h>
 #include <linux/freezer.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/kernel.h>
 #include <linux/dmi.h>
 #include "tpm.h"
diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_tis_spi_main.c
index 1f5207974a17..c6101914629d 100644
--- a/drivers/char/tpm/tpm_tis_spi_main.c
+++ b/drivers/char/tpm/tpm_tis_spi_main.c
@@ -28,7 +28,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/spi/spi.h>
 #include <linux/tpm.h>
 
diff --git a/drivers/char/tpm/tpm_tis_synquacer.c b/drivers/char/tpm/tpm_tis_synquacer.c
index 49278746b0e2..7f9b4bfceb6e 100644
--- a/drivers/char/tpm/tpm_tis_synquacer.c
+++ b/drivers/char/tpm/tpm_tis_synquacer.c
@@ -9,7 +9,6 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/kernel.h>
 #include "tpm.h"
 #include "tpm_tis_core.h"
-- 
2.40.1

