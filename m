Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBA07F5CD4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 11:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344818AbjKWKsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 05:48:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344787AbjKWKsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 05:48:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBD41BD
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 02:48:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54935C433C8;
        Thu, 23 Nov 2023 10:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700736495;
        bh=C+pNMYVLFZEmoFSbcwLsLirku3hsdHnT0ZOPIncJ5go=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iRG8lggdbvok32Jt1t2luxAHhXf4vpDXyQYUCywG0OpPWeBQRKMMXuvRbJcaLIoey
         FZ1gcHucb3rsW9yiPHTQKm3bdccnyCEAbJuAX+OoD8yy00Wg6ziFj/tiJ3BGlEJBd5
         7nWYhp+sYVXFeZ3AJ9HVEzLvCKkdYbABk4ORpjfjSgArvEU6rtE3sNV6ME7SdtVHaU
         b6z4+SJYMdu7nUhBrj02zQA/CH/1gZmhV84bd0mp8PvtlXi7iETLVHTdxWuFUXIfF/
         mwSihdNvMnJMeuorFxdmW93sUgIXg92TJwzBawfkX70Yf1KxpT7Gvnq47kAVKjtDn3
         5VMKP+R09gD6g==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Arnd Bergmann <arnd@arndb.de>, Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH v2 1/3] powerpc: ps3: move udbg_shutdown_ps3gelic prototype
Date:   Thu, 23 Nov 2023 11:47:59 +0100
Message-Id: <20231123104801.15537-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231123104801.15537-1-arnd@kernel.org>
References: <20231123104801.15537-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Allmodconfig kernels produce a missing-prototypes warning:

arch/powerpc/platforms/ps3/gelic_udbg.c:239:6: error: no previous prototype for 'udbg_shutdown_ps3gelic' [-Werror=missing-prototypes]

Move the declaration from a local header to asm/ps3.h where it can be
seen from both the caller and the definition. As suggested
by Michael Ellerman, remove the CONFIG_PS3GELIC_UDBG option to
prevent this from causing a build regression.

Acked-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/Kconfig.debug                   |  1 -
 arch/powerpc/include/asm/ps3.h               |  6 ++++++
 arch/powerpc/platforms/ps3/Kconfig           | 12 ------------
 arch/powerpc/platforms/ps3/Makefile          |  2 +-
 arch/powerpc/platforms/ps3/gelic_udbg.c      |  1 +
 drivers/net/ethernet/toshiba/ps3_gelic_net.h |  6 ------
 6 files changed, 8 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index ea4033abc07d..8c80b154e814 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -271,7 +271,6 @@ config PPC_EARLY_DEBUG_USBGECKO
 config PPC_EARLY_DEBUG_PS3GELIC
 	bool "Early debugging through the PS3 Ethernet port"
 	depends on PPC_PS3
-	select PS3GELIC_UDBG
 	help
 	  Select this to enable early debugging for the PlayStation3 via
 	  UDP broadcasts sent out through the Ethernet port.
diff --git a/arch/powerpc/include/asm/ps3.h b/arch/powerpc/include/asm/ps3.h
index a5f36546a052..d13d8fdc3411 100644
--- a/arch/powerpc/include/asm/ps3.h
+++ b/arch/powerpc/include/asm/ps3.h
@@ -514,4 +514,10 @@ u64 ps3_get_spe_id(void *arg);
 
 void ps3_early_mm_init(void);
 
+#ifdef CONFIG_PPC_EARLY_DEBUG_PS3GELIC
+void udbg_shutdown_ps3gelic(void);
+#else
+static inline void udbg_shutdown_ps3gelic(void) {}
+#endif
+
 #endif
diff --git a/arch/powerpc/platforms/ps3/Kconfig b/arch/powerpc/platforms/ps3/Kconfig
index a44869e5ea70..e9c1087dd42e 100644
--- a/arch/powerpc/platforms/ps3/Kconfig
+++ b/arch/powerpc/platforms/ps3/Kconfig
@@ -167,16 +167,4 @@ config PS3_LPM
 	  profiling support of the Cell processor with programs like
 	  perfmon2, then say Y or M, otherwise say N.
 
-config PS3GELIC_UDBG
-	bool "PS3 udbg output via UDP broadcasts on Ethernet"
-	depends on PPC_PS3
-	help
-	  Enables udbg early debugging output by sending broadcast UDP
-	  via the Ethernet port (UDP port number 18194).
-
-	  This driver uses a trivial implementation and is independent
-	  from the main PS3 gelic network driver.
-
-	  If in doubt, say N here.
-
 endmenu
diff --git a/arch/powerpc/platforms/ps3/Makefile b/arch/powerpc/platforms/ps3/Makefile
index 86bf2967a8d4..bc79bb124d1e 100644
--- a/arch/powerpc/platforms/ps3/Makefile
+++ b/arch/powerpc/platforms/ps3/Makefile
@@ -3,7 +3,7 @@ obj-y += setup.o mm.o time.o hvcall.o htab.o repository.o
 obj-y += interrupt.o exports.o os-area.o
 obj-y += system-bus.o
 
-obj-$(CONFIG_PS3GELIC_UDBG) += gelic_udbg.o
+obj-$(CONFIG_PPC_EARLY_DEBUG_PS3GELIC) += gelic_udbg.o
 obj-$(CONFIG_SMP) += smp.o
 obj-$(CONFIG_SPU_BASE) += spu.o
 obj-y += device-init.o
diff --git a/arch/powerpc/platforms/ps3/gelic_udbg.c b/arch/powerpc/platforms/ps3/gelic_udbg.c
index 6b298010fd84..a5202c18c236 100644
--- a/arch/powerpc/platforms/ps3/gelic_udbg.c
+++ b/arch/powerpc/platforms/ps3/gelic_udbg.c
@@ -14,6 +14,7 @@
 #include <linux/ip.h>
 #include <linux/udp.h>
 
+#include <asm/ps3.h>
 #include <asm/io.h>
 #include <asm/udbg.h>
 #include <asm/lv1call.h>
diff --git a/drivers/net/ethernet/toshiba/ps3_gelic_net.h b/drivers/net/ethernet/toshiba/ps3_gelic_net.h
index 0d98defb011e..0ec7412febc7 100644
--- a/drivers/net/ethernet/toshiba/ps3_gelic_net.h
+++ b/drivers/net/ethernet/toshiba/ps3_gelic_net.h
@@ -346,12 +346,6 @@ static inline void *port_priv(struct gelic_port *port)
 	return port->priv;
 }
 
-#ifdef CONFIG_PPC_EARLY_DEBUG_PS3GELIC
-void udbg_shutdown_ps3gelic(void);
-#else
-static inline void udbg_shutdown_ps3gelic(void) {}
-#endif
-
 int gelic_card_set_irq_mask(struct gelic_card *card, u64 mask);
 /* shared netdev ops */
 void gelic_card_up(struct gelic_card *card);
-- 
2.39.2

