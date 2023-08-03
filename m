Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077B976EC47
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 16:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236588AbjHCOUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 10:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236296AbjHCOUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 10:20:24 -0400
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338B1DA;
        Thu,  3 Aug 2023 07:20:22 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4RGr4p1171z9t4C;
        Thu,  3 Aug 2023 15:57:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dIybbaA2s4qM; Thu,  3 Aug 2023 15:57:14 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4RGr4l6X85z9t4G;
        Thu,  3 Aug 2023 15:57:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DC2D38B775;
        Thu,  3 Aug 2023 15:57:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id e-x1_hcJiGHO; Thu,  3 Aug 2023 15:57:11 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.144])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4CEB58B774;
        Thu,  3 Aug 2023 15:57:11 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 373Dv3hd494185
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 3 Aug 2023 15:57:03 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 373Dv3VR494184;
        Thu, 3 Aug 2023 15:57:03 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Timur Tabi <timur@kernel.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-serial@vger.kernel.org
Subject: [PATCH v1 05/12] serial: cpm_uart: Deduplicate cpm_set_{brg/smc_fcr/scc_fcr}()
Date:   Thu,  3 Aug 2023 15:56:46 +0200
Message-ID: <6920e61fd362961ae1aeda897c8bfe1efacdc9dc.1691068700.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1691068700.git.christophe.leroy@csgroup.eu>
References: <cover.1691068700.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691071000; l=4981; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=dehNxJt+NVQgHzWczRwdWctQB1n4VJLDxJOGm5qbyXQ=; b=pEEgwzS+a9mP7i2GVRXIyfDl6V8yctoxxHIfZmK6VXoRj9JHVUk+AX05sg7qAIrxyAqh/Ga2t b6yzurMZ/DjAJGIDDZME47grF8P0Gww+UcSDfi2QxfpXHTCLgpXt4RW
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPMFCR_EB is the same as SMC_EB and is defined
for both CPM1 and CPM2.

CPMFCR_GBL is defined as 0 for CPM1.

Therefore the CPM2 version of cpm_set_scc_fcr() and
cpm_set_smc_fcr() can be used on both CPM1 and CPM2.

And cpm_set_brg() is already identical and just a
wrapper of cpm_setbrg().

In addition those three fonctions are only called once
from cpm_uart_core.c, so just replace the calls with
the content of the CPM2 versions of them.

And DPRAM_BASE is identical so can go in cpm_uart.h. While
moving it, use cpm_muram_addr() directly instead of the
cpm_dpram_addr() macro and remove __force tag which isn't needed.

Then cpm_uart_cpm1.h and cpm_uart_cpm2.h go away.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 drivers/tty/serial/cpm_uart/cpm_uart.h      |  6 ++--
 drivers/tty/serial/cpm_uart/cpm_uart_core.c |  8 +++--
 drivers/tty/serial/cpm_uart/cpm_uart_cpm1.h | 33 ---------------------
 drivers/tty/serial/cpm_uart/cpm_uart_cpm2.h | 33 ---------------------
 4 files changed, 9 insertions(+), 71 deletions(-)
 delete mode 100644 drivers/tty/serial/cpm_uart/cpm_uart_cpm1.h
 delete mode 100644 drivers/tty/serial/cpm_uart/cpm_uart_cpm2.h

diff --git a/drivers/tty/serial/cpm_uart/cpm_uart.h b/drivers/tty/serial/cpm_uart/cpm_uart.h
index c220700df693..81c1c5f97d19 100644
--- a/drivers/tty/serial/cpm_uart/cpm_uart.h
+++ b/drivers/tty/serial/cpm_uart/cpm_uart.h
@@ -15,11 +15,13 @@
 struct gpio_desc;
 
 #if defined(CONFIG_CPM2)
-#include "cpm_uart_cpm2.h"
+#include "asm/cpm2.h"
 #elif defined(CONFIG_CPM1)
-#include "cpm_uart_cpm1.h"
+#include "asm/cpm1.h"
 #endif
 
+#define DPRAM_BASE	((u8 __iomem *)cpm_muram_addr(0))
+
 #define SERIAL_CPM_MAJOR	204
 #define SERIAL_CPM_MINOR	46
 
diff --git a/drivers/tty/serial/cpm_uart/cpm_uart_core.c b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
index 36bac4390c13..743892c0e143 100644
--- a/drivers/tty/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
@@ -603,7 +603,7 @@ static void cpm_uart_set_termios(struct uart_port *port,
 	if (pinfo->clk)
 		clk_set_rate(pinfo->clk, baud);
 	else
-		cpm_set_brg(pinfo->brg - 1, baud);
+		cpm_setbrg(pinfo->brg - 1, baud);
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 
@@ -769,7 +769,8 @@ static void cpm_uart_init_scc(struct uart_cpm_port *pinfo)
 	 * parameter ram.
 	 */
 
-	cpm_set_scc_fcr(sup);
+	out_8(&sup->scc_genscc.scc_rfcr, CPMFCR_GBL | CPMFCR_EB);
+	out_8(&sup->scc_genscc.scc_tfcr, CPMFCR_GBL | CPMFCR_EB);
 
 	out_be16(&sup->scc_genscc.scc_mrblr, pinfo->rx_fifosize);
 	out_be16(&sup->scc_maxidl, 0x10);
@@ -840,7 +841,8 @@ static void cpm_uart_init_smc(struct uart_cpm_port *pinfo)
 	/* Set up the uart parameters in the
 	 * parameter ram.
 	 */
-	cpm_set_smc_fcr(up);
+	out_8(&up->smc_rfcr, CPMFCR_GBL | CPMFCR_EB);
+	out_8(&up->smc_tfcr, CPMFCR_GBL | CPMFCR_EB);
 
 	/* Using idle character time requires some additional tuning.  */
 	out_be16(&up->smc_mrblr, pinfo->rx_fifosize);
diff --git a/drivers/tty/serial/cpm_uart/cpm_uart_cpm1.h b/drivers/tty/serial/cpm_uart/cpm_uart_cpm1.h
deleted file mode 100644
index 18ec0849918a..000000000000
--- a/drivers/tty/serial/cpm_uart/cpm_uart_cpm1.h
+++ /dev/null
@@ -1,33 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Driver for CPM (SCC/SMC) serial ports
- *
- * definitions for cpm1
- *
- */
-
-#ifndef CPM_UART_CPM1_H
-#define CPM_UART_CPM1_H
-
-#include <asm/cpm1.h>
-
-static inline void cpm_set_brg(int brg, int baud)
-{
-	cpm_setbrg(brg, baud);
-}
-
-static inline void cpm_set_scc_fcr(scc_uart_t __iomem * sup)
-{
-	out_8(&sup->scc_genscc.scc_rfcr, SMC_EB);
-	out_8(&sup->scc_genscc.scc_tfcr, SMC_EB);
-}
-
-static inline void cpm_set_smc_fcr(smc_uart_t __iomem * up)
-{
-	out_8(&up->smc_rfcr, SMC_EB);
-	out_8(&up->smc_tfcr, SMC_EB);
-}
-
-#define DPRAM_BASE	((u8 __iomem __force *)cpm_dpram_addr(0))
-
-#endif
diff --git a/drivers/tty/serial/cpm_uart/cpm_uart_cpm2.h b/drivers/tty/serial/cpm_uart/cpm_uart_cpm2.h
deleted file mode 100644
index 051a8509c3e5..000000000000
--- a/drivers/tty/serial/cpm_uart/cpm_uart_cpm2.h
+++ /dev/null
@@ -1,33 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Driver for CPM (SCC/SMC) serial ports
- *
- * definitions for cpm2
- *
- */
-
-#ifndef CPM_UART_CPM2_H
-#define CPM_UART_CPM2_H
-
-#include <asm/cpm2.h>
-
-static inline void cpm_set_brg(int brg, int baud)
-{
-	cpm_setbrg(brg, baud);
-}
-
-static inline void cpm_set_scc_fcr(scc_uart_t __iomem *sup)
-{
-	out_8(&sup->scc_genscc.scc_rfcr, CPMFCR_GBL | CPMFCR_EB);
-	out_8(&sup->scc_genscc.scc_tfcr, CPMFCR_GBL | CPMFCR_EB);
-}
-
-static inline void cpm_set_smc_fcr(smc_uart_t __iomem *up)
-{
-	out_8(&up->smc_rfcr, CPMFCR_GBL | CPMFCR_EB);
-	out_8(&up->smc_tfcr, CPMFCR_GBL | CPMFCR_EB);
-}
-
-#define DPRAM_BASE	((u8 __iomem __force *)cpm_dpram_addr(0))
-
-#endif
-- 
2.41.0

