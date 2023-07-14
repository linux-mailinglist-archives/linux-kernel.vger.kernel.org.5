Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F997540B0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236148AbjGNRl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236101AbjGNRlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:41:17 -0400
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806D94217;
        Fri, 14 Jul 2023 10:40:53 -0700 (PDT)
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3465ec72cc8so10181395ab.0;
        Fri, 14 Jul 2023 10:40:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689356452; x=1691948452;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CXMKUxaoJdVuKThpyxnw1WopjFcHSAjuBXw6F+dEEZg=;
        b=TPacPvbYGGq8/Q3ME4/drBSRXBOurSfVcl9YazDbTm3Vdr5hJt5HPeyea87hgKpK42
         HZ/D17m8Pdzg/FbAQg0DdCA8iGsuTLJ/yMXKVBsHuXngRUiDlELCzUlyNhqjsTtdDKQE
         Kavml9fCbihHCFd8Wwl0tXOjfrr1FeK2w6eBaa9heTJHylX6kz+bcP5HTmD7BO8vqEvg
         xhvt9LYbmlHSd17v+IQxkNfxUyAHtNYyYmFw9OJOL0FlLwNzupidlPtZ0iHdc6RRqiNr
         oKdcyl2GFMPfp5AWNkwzBbqrjUbdzDuwRMF0FeX1SN2KZ8Mlk6pgjQZI+RUyIrzmOCkv
         fkHg==
X-Gm-Message-State: ABy/qLbIC2uAF5PYjBNOfOrxpTaOkXSpCJu03tzbO6qwpIhmhUmb1tyS
        w0pNbISQi5o06vapTEQcYzpZGRBmVw==
X-Google-Smtp-Source: APBJJlG6CBStNwYWoQBlrAwomM+ldpZiejo2s+nE3X/4kN4YdcfHvYo1KJt+l/iurPs7/rXKsIjz/g==
X-Received: by 2002:a92:d181:0:b0:341:e2aa:3552 with SMTP id z1-20020a92d181000000b00341e2aa3552mr4846643ilz.4.1689356452587;
        Fri, 14 Jul 2023 10:40:52 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id f3-20020a056638022300b0042b39b2289asm2825851jaq.102.2023.07.14.10.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:40:51 -0700 (PDT)
Received: (nullmailer pid 4040813 invoked by uid 1000);
        Fri, 14 Jul 2023 17:40:50 -0000
From:   Rob Herring <robh@kernel.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     devicetree@vger.kernel.org, linux-crypto@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sparc: Explicitly include correct DT includes
Date:   Fri, 14 Jul 2023 11:40:46 -0600
Message-Id: <20230714174048.4040702-1-robh@kernel.org>
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
 arch/sparc/crypto/crop_devid.c       | 2 +-
 arch/sparc/include/asm/floppy_32.h   | 2 +-
 arch/sparc/include/asm/floppy_64.h   | 2 +-
 arch/sparc/include/asm/parport.h     | 3 ++-
 arch/sparc/kernel/apc.c              | 2 +-
 arch/sparc/kernel/auxio_32.c         | 1 -
 arch/sparc/kernel/auxio_64.c         | 3 ++-
 arch/sparc/kernel/central.c          | 2 +-
 arch/sparc/kernel/chmc.c             | 3 ++-
 arch/sparc/kernel/ioport.c           | 2 +-
 arch/sparc/kernel/leon_kernel.c      | 2 --
 arch/sparc/kernel/leon_pci.c         | 3 ++-
 arch/sparc/kernel/leon_pci_grpci1.c  | 3 ++-
 arch/sparc/kernel/leon_pci_grpci2.c  | 4 +++-
 arch/sparc/kernel/of_device_32.c     | 1 +
 arch/sparc/kernel/of_device_64.c     | 2 ++
 arch/sparc/kernel/of_device_common.c | 3 ++-
 arch/sparc/kernel/pci.c              | 3 ++-
 arch/sparc/kernel/pci_common.c       | 3 ++-
 arch/sparc/kernel/pci_fire.c         | 3 ++-
 arch/sparc/kernel/pci_impl.h         | 1 -
 arch/sparc/kernel/pci_msi.c          | 2 ++
 arch/sparc/kernel/pci_psycho.c       | 4 +++-
 arch/sparc/kernel/pci_sun4v.c        | 3 ++-
 arch/sparc/kernel/pmc.c              | 2 +-
 arch/sparc/kernel/power.c            | 3 ++-
 arch/sparc/kernel/prom_irqtrans.c    | 1 +
 arch/sparc/kernel/psycho_common.c    | 1 +
 arch/sparc/kernel/sbus.c             | 3 ++-
 arch/sparc/kernel/time_32.c          | 1 -
 arch/sparc/mm/io-unit.c              | 3 ++-
 arch/sparc/mm/iommu.c                | 5 +++--
 32 files changed, 49 insertions(+), 29 deletions(-)

diff --git a/arch/sparc/crypto/crop_devid.c b/arch/sparc/crypto/crop_devid.c
index 83fc4536dcd5..93f4e0fdd38c 100644
--- a/arch/sparc/crypto/crop_devid.c
+++ b/arch/sparc/crypto/crop_devid.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
 
 /* This is a dummy device table linked into all of the crypto
  * opcode drivers.  It serves to trigger the module autoloading
diff --git a/arch/sparc/include/asm/floppy_32.h b/arch/sparc/include/asm/floppy_32.h
index e10ab9ad3097..836f6575aa1d 100644
--- a/arch/sparc/include/asm/floppy_32.h
+++ b/arch/sparc/include/asm/floppy_32.h
@@ -8,7 +8,7 @@
 #define __ASM_SPARC_FLOPPY_H
 
 #include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/of_platform.h>
 #include <linux/pgtable.h>
 
 #include <asm/idprom.h>
diff --git a/arch/sparc/include/asm/floppy_64.h b/arch/sparc/include/asm/floppy_64.h
index 070c8c1f5c8f..6efeb24b0a92 100644
--- a/arch/sparc/include/asm/floppy_64.h
+++ b/arch/sparc/include/asm/floppy_64.h
@@ -11,7 +11,7 @@
 #define __ASM_SPARC64_FLOPPY_H
 
 #include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/of_platform.h>
 #include <linux/dma-mapping.h>
 
 #include <asm/auxio.h>
diff --git a/arch/sparc/include/asm/parport.h b/arch/sparc/include/asm/parport.h
index 03b27090c0c8..0a7ffcfd59cd 100644
--- a/arch/sparc/include/asm/parport.h
+++ b/arch/sparc/include/asm/parport.h
@@ -7,7 +7,8 @@
 #ifndef _ASM_SPARC64_PARPORT_H
 #define _ASM_SPARC64_PARPORT_H 1
 
-#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
 
 #include <asm/ebus_dma.h>
 #include <asm/ns87303.h>
diff --git a/arch/sparc/kernel/apc.c b/arch/sparc/kernel/apc.c
index ecd05bc0a104..d44725d37e30 100644
--- a/arch/sparc/kernel/apc.c
+++ b/arch/sparc/kernel/apc.c
@@ -13,7 +13,7 @@
 #include <linux/miscdevice.h>
 #include <linux/pm.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/platform_device.h>
 #include <linux/module.h>
 
 #include <asm/io.h>
diff --git a/arch/sparc/kernel/auxio_32.c b/arch/sparc/kernel/auxio_32.c
index a32d588174f2..989860e890c4 100644
--- a/arch/sparc/kernel/auxio_32.c
+++ b/arch/sparc/kernel/auxio_32.c
@@ -8,7 +8,6 @@
 #include <linux/init.h>
 #include <linux/spinlock.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/export.h>
 
 #include <asm/oplib.h>
diff --git a/arch/sparc/kernel/auxio_64.c b/arch/sparc/kernel/auxio_64.c
index 774a82b0c649..2a2800d21325 100644
--- a/arch/sparc/kernel/auxio_64.c
+++ b/arch/sparc/kernel/auxio_64.c
@@ -10,7 +10,8 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/ioport.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
 
 #include <asm/prom.h>
 #include <asm/io.h>
diff --git a/arch/sparc/kernel/central.c b/arch/sparc/kernel/central.c
index 23f8838dd96e..a1a6485c9183 100644
--- a/arch/sparc/kernel/central.c
+++ b/arch/sparc/kernel/central.c
@@ -10,7 +10,7 @@
 #include <linux/export.h>
 #include <linux/string.h>
 #include <linux/init.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 
 #include <asm/fhc.h>
diff --git a/arch/sparc/kernel/chmc.c b/arch/sparc/kernel/chmc.c
index 6ff43df740e0..d5fad5fb04c1 100644
--- a/arch/sparc/kernel/chmc.c
+++ b/arch/sparc/kernel/chmc.c
@@ -15,7 +15,8 @@
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <asm/spitfire.h>
 #include <asm/chmctrl.h>
 #include <asm/cpudata.h>
diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index a8cbe403301f..5ebca5c7af1e 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -39,7 +39,7 @@
 #include <linux/seq_file.h>
 #include <linux/scatterlist.h>
 #include <linux/dma-map-ops.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 
 #include <asm/io.h>
 #include <asm/vaddrs.h>
diff --git a/arch/sparc/kernel/leon_kernel.c b/arch/sparc/kernel/leon_kernel.c
index 39229940d725..4c61da491fee 100644
--- a/arch/sparc/kernel/leon_kernel.c
+++ b/arch/sparc/kernel/leon_kernel.c
@@ -8,9 +8,7 @@
 #include <linux/errno.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
-#include <linux/of_platform.h>
 #include <linux/interrupt.h>
-#include <linux/of_device.h>
 #include <linux/clocksource.h>
 #include <linux/clockchips.h>
 
diff --git a/arch/sparc/kernel/leon_pci.c b/arch/sparc/kernel/leon_pci.c
index b6663a3fbae9..8de6646e9ce8 100644
--- a/arch/sparc/kernel/leon_pci.c
+++ b/arch/sparc/kernel/leon_pci.c
@@ -7,7 +7,8 @@
  * Code is partially derived from pcic.c
  */
 
-#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/export.h>
diff --git a/arch/sparc/kernel/leon_pci_grpci1.c b/arch/sparc/kernel/leon_pci_grpci1.c
index e6935d0ac1ec..8700a0e3b0df 100644
--- a/arch/sparc/kernel/leon_pci_grpci1.c
+++ b/arch/sparc/kernel/leon_pci_grpci1.c
@@ -13,10 +13,11 @@
  * Contributors: Daniel Hellstrom <daniel@gaisler.com>
  */
 
-#include <linux/of_device.h>
 #include <linux/export.h>
 #include <linux/kernel.h>
+#include <linux/of.h>
 #include <linux/of_irq.h>
+#include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/pci.h>
 
diff --git a/arch/sparc/kernel/leon_pci_grpci2.c b/arch/sparc/kernel/leon_pci_grpci2.c
index ca22f93d9045..60b6bdf7761f 100644
--- a/arch/sparc/kernel/leon_pci_grpci2.c
+++ b/arch/sparc/kernel/leon_pci_grpci2.c
@@ -6,12 +6,14 @@
  *
  */
 
-#include <linux/of_device.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/export.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+
 #include <asm/io.h>
 #include <asm/leon.h>
 #include <asm/vaddrs.h>
diff --git a/arch/sparc/kernel/of_device_32.c b/arch/sparc/kernel/of_device_32.c
index fa05b29fa051..06012e68bdca 100644
--- a/arch/sparc/kernel/of_device_32.c
+++ b/arch/sparc/kernel/of_device_32.c
@@ -8,6 +8,7 @@
 #include <linux/errno.h>
 #include <linux/irq.h>
 #include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
 #include <asm/leon.h>
 #include <asm/leon_amba.h>
diff --git a/arch/sparc/kernel/of_device_64.c b/arch/sparc/kernel/of_device_64.c
index c41aa82a9af3..74ce6850b531 100644
--- a/arch/sparc/kernel/of_device_64.c
+++ b/arch/sparc/kernel/of_device_64.c
@@ -9,7 +9,9 @@
 #include <linux/slab.h>
 #include <linux/errno.h>
 #include <linux/irq.h>
+#include <linux/of.h>
 #include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <asm/spitfire.h>
 
 #include "of_device_common.h"
diff --git a/arch/sparc/kernel/of_device_common.c b/arch/sparc/kernel/of_device_common.c
index 60f86b837658..07d794c8ba3b 100644
--- a/arch/sparc/kernel/of_device_common.c
+++ b/arch/sparc/kernel/of_device_common.c
@@ -6,10 +6,11 @@
 #include <linux/mod_devicetable.h>
 #include <linux/errno.h>
 #include <linux/irq.h>
+#include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/of_address.h>
-#include <linux/of_device.h>
 #include <linux/of_irq.h>
+#include <linux/platform_device.h>
 
 #include "of_device_common.h"
 
diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index a948a49817c7..f66005ce4cb5 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -20,8 +20,9 @@
 #include <linux/irq.h>
 #include <linux/init.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/of_platform.h>
 #include <linux/pgtable.h>
+#include <linux/platform_device.h>
 
 #include <linux/uaccess.h>
 #include <asm/irq.h>
diff --git a/arch/sparc/kernel/pci_common.c b/arch/sparc/kernel/pci_common.c
index 4759ccd542fe..5eeec9ad6845 100644
--- a/arch/sparc/kernel/pci_common.c
+++ b/arch/sparc/kernel/pci_common.c
@@ -8,7 +8,8 @@
 #include <linux/slab.h>
 #include <linux/pci.h>
 #include <linux/device.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
 
 #include <asm/prom.h>
 #include <asm/oplib.h>
diff --git a/arch/sparc/kernel/pci_fire.c b/arch/sparc/kernel/pci_fire.c
index 0ca08d455e80..0b91bde80fdc 100644
--- a/arch/sparc/kernel/pci_fire.c
+++ b/arch/sparc/kernel/pci_fire.c
@@ -10,7 +10,8 @@
 #include <linux/msi.h>
 #include <linux/export.h>
 #include <linux/irq.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
 #include <linux/numa.h>
 
 #include <asm/prom.h>
diff --git a/arch/sparc/kernel/pci_impl.h b/arch/sparc/kernel/pci_impl.h
index 4e3d15189fa9..f31761f51757 100644
--- a/arch/sparc/kernel/pci_impl.h
+++ b/arch/sparc/kernel/pci_impl.h
@@ -11,7 +11,6 @@
 #include <linux/spinlock.h>
 #include <linux/pci.h>
 #include <linux/msi.h>
-#include <linux/of_device.h>
 #include <asm/io.h>
 #include <asm/prom.h>
 #include <asm/iommu.h>
diff --git a/arch/sparc/kernel/pci_msi.c b/arch/sparc/kernel/pci_msi.c
index 9ed11985768e..fc7402948b7b 100644
--- a/arch/sparc/kernel/pci_msi.c
+++ b/arch/sparc/kernel/pci_msi.c
@@ -5,6 +5,8 @@
  */
 #include <linux/kernel.h>
 #include <linux/interrupt.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/irq.h>
 
diff --git a/arch/sparc/kernel/pci_psycho.c b/arch/sparc/kernel/pci_psycho.c
index f413371da387..1efc98305ec7 100644
--- a/arch/sparc/kernel/pci_psycho.c
+++ b/arch/sparc/kernel/pci_psycho.c
@@ -13,7 +13,9 @@
 #include <linux/export.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 
 #include <asm/iommu.h>
 #include <asm/irq.h>
diff --git a/arch/sparc/kernel/pci_sun4v.c b/arch/sparc/kernel/pci_sun4v.c
index 7d91ca6aa675..c80b0a21d709 100644
--- a/arch/sparc/kernel/pci_sun4v.c
+++ b/arch/sparc/kernel/pci_sun4v.c
@@ -15,7 +15,8 @@
 #include <linux/msi.h>
 #include <linux/export.h>
 #include <linux/log2.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
 #include <linux/dma-map-ops.h>
 #include <asm/iommu-common.h>
 
diff --git a/arch/sparc/kernel/pmc.c b/arch/sparc/kernel/pmc.c
index b5c1eb33b951..69a0206e56f0 100644
--- a/arch/sparc/kernel/pmc.c
+++ b/arch/sparc/kernel/pmc.c
@@ -11,7 +11,7 @@
 #include <linux/init.h>
 #include <linux/pm.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/platform_device.h>
 #include <linux/module.h>
 
 #include <asm/io.h>
diff --git a/arch/sparc/kernel/power.c b/arch/sparc/kernel/power.c
index 8147985a1dc4..db8a3f9e3d40 100644
--- a/arch/sparc/kernel/power.c
+++ b/arch/sparc/kernel/power.c
@@ -9,7 +9,8 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/reboot.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
 
 #include <asm/prom.h>
 #include <asm/io.h>
diff --git a/arch/sparc/kernel/prom_irqtrans.c b/arch/sparc/kernel/prom_irqtrans.c
index 28aff1c524b5..426bd08cb2ab 100644
--- a/arch/sparc/kernel/prom_irqtrans.c
+++ b/arch/sparc/kernel/prom_irqtrans.c
@@ -4,6 +4,7 @@
 #include <linux/init.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
+#include <linux/platform_device.h>
 
 #include <asm/oplib.h>
 #include <asm/prom.h>
diff --git a/arch/sparc/kernel/psycho_common.c b/arch/sparc/kernel/psycho_common.c
index e90bcb6bad7f..5ee74b4c0cf4 100644
--- a/arch/sparc/kernel/psycho_common.c
+++ b/arch/sparc/kernel/psycho_common.c
@@ -6,6 +6,7 @@
 #include <linux/kernel.h>
 #include <linux/interrupt.h>
 #include <linux/numa.h>
+#include <linux/platform_device.h>
 
 #include <asm/upa.h>
 
diff --git a/arch/sparc/kernel/sbus.c b/arch/sparc/kernel/sbus.c
index 32141e1006c4..0bababf6f2bc 100644
--- a/arch/sparc/kernel/sbus.c
+++ b/arch/sparc/kernel/sbus.c
@@ -14,7 +14,8 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/numa.h>
 
 #include <asm/page.h>
diff --git a/arch/sparc/kernel/time_32.c b/arch/sparc/kernel/time_32.c
index 958c2cf4479b..08bbdc458596 100644
--- a/arch/sparc/kernel/time_32.c
+++ b/arch/sparc/kernel/time_32.c
@@ -33,7 +33,6 @@
 #include <linux/ioport.h>
 #include <linux/profile.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 
 #include <asm/mc146818rtc.h>
diff --git a/arch/sparc/mm/io-unit.c b/arch/sparc/mm/io-unit.c
index 133dd42570d6..d8376f61b4d0 100644
--- a/arch/sparc/mm/io-unit.c
+++ b/arch/sparc/mm/io-unit.c
@@ -13,7 +13,8 @@
 #include <linux/bitops.h>
 #include <linux/dma-map-ops.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 
 #include <asm/io.h>
 #include <asm/io-unit.h>
diff --git a/arch/sparc/mm/iommu.c b/arch/sparc/mm/iommu.c
index 3a6caef68348..5a5080db800f 100644
--- a/arch/sparc/mm/iommu.c
+++ b/arch/sparc/mm/iommu.c
@@ -7,14 +7,15 @@
  * Copyright (C) 1996 Eddie C. Dost    (ecd@skynet.be)
  * Copyright (C) 1997,1998 Jakub Jelinek    (jj@sunsite.mff.cuni.cz)
  */
- 
+
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/dma-map-ops.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 
 #include <asm/io.h>
 #include <asm/mxcc.h>
-- 
2.40.1

