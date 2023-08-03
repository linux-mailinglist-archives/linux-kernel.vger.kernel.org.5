Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D859A76EC49
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 16:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236640AbjHCOUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 10:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236384AbjHCOU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 10:20:28 -0400
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E641BF0;
        Thu,  3 Aug 2023 07:20:27 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4RGr4q23GCz9t4G;
        Thu,  3 Aug 2023 15:57:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id skcV4jzBXpBA; Thu,  3 Aug 2023 15:57:15 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4RGr4l6htXz9t4M;
        Thu,  3 Aug 2023 15:57:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E1D9C8B773;
        Thu,  3 Aug 2023 15:57:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id NRx7_-NHv-Ra; Thu,  3 Aug 2023 15:57:11 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.144])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 62D1B8B779;
        Thu,  3 Aug 2023 15:57:11 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 373Dv3Fa494189
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 3 Aug 2023 15:57:03 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 373Dv3jX494188;
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
Subject: [PATCH v1 06/12] serial: cpm_uart: Deduplicate cpm_line_cr_cmd()
Date:   Thu,  3 Aug 2023 15:56:47 +0200
Message-ID: <6996e6ff93067dcddebf0d0c86487345149e165c.1691068700.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1691068700.git.christophe.leroy@csgroup.eu>
References: <cover.1691068700.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691071001; l=2645; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=HHdfsZwGCoQoPJlY4fcmGryatj/HR1mbiEinpIS97SI=; b=Gb8p1cajdgOeWcLg5Wf1sxyN/GxsyD454iTMUoImOT2Vnrd5+OQuwzjykmZW75j+nNfwmwXuT Ozv5jBmGO6TCu2IKNl7rUhdmMRQW9FtfviTfbL9LDj7BklwicGrMP0j
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

cpm_line_cr_cmd() is identical for CPM1 and CPM2 and
is used only in cpm_uart_core.c. Move it there.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 drivers/tty/serial/cpm_uart/cpm_uart.h      | 1 -
 drivers/tty/serial/cpm_uart/cpm_uart_core.c | 5 +++++
 drivers/tty/serial/cpm_uart/cpm_uart_cpm1.c | 5 -----
 drivers/tty/serial/cpm_uart/cpm_uart_cpm2.c | 5 -----
 4 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/cpm_uart/cpm_uart.h b/drivers/tty/serial/cpm_uart/cpm_uart.h
index 81c1c5f97d19..1b5523474ab4 100644
--- a/drivers/tty/serial/cpm_uart/cpm_uart.h
+++ b/drivers/tty/serial/cpm_uart/cpm_uart.h
@@ -76,7 +76,6 @@ struct uart_cpm_port {
 };
 
 /* these are located in their respective files */
-void cpm_line_cr_cmd(struct uart_cpm_port *port, int cmd);
 void __iomem *cpm_uart_map_pram(struct uart_cpm_port *port,
 				struct device_node *np);
 void cpm_uart_unmap_pram(struct uart_cpm_port *port, void __iomem *pram);
diff --git a/drivers/tty/serial/cpm_uart/cpm_uart_core.c b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
index 743892c0e143..e6f3e4da3144 100644
--- a/drivers/tty/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
@@ -54,6 +54,11 @@ static void cpm_uart_initbd(struct uart_cpm_port *pinfo);
 
 #define HW_BUF_SPD_THRESHOLD    2400
 
+static void cpm_line_cr_cmd(struct uart_cpm_port *port, int cmd)
+{
+	cpm_command(port->command, cmd);
+}
+
 /*
  * Check, if transmit buffers are processed
 */
diff --git a/drivers/tty/serial/cpm_uart/cpm_uart_cpm1.c b/drivers/tty/serial/cpm_uart/cpm_uart_cpm1.c
index 56fc527015cb..b5680376ff3c 100644
--- a/drivers/tty/serial/cpm_uart/cpm_uart_cpm1.c
+++ b/drivers/tty/serial/cpm_uart/cpm_uart_cpm1.c
@@ -36,11 +36,6 @@
 
 /**************************************************************/
 
-void cpm_line_cr_cmd(struct uart_cpm_port *port, int cmd)
-{
-	cpm_command(port->command, cmd);
-}
-
 void __iomem *cpm_uart_map_pram(struct uart_cpm_port *port,
 				struct device_node *np)
 {
diff --git a/drivers/tty/serial/cpm_uart/cpm_uart_cpm2.c b/drivers/tty/serial/cpm_uart/cpm_uart_cpm2.c
index 108af254e8f3..35f539fcfde8 100644
--- a/drivers/tty/serial/cpm_uart/cpm_uart_cpm2.c
+++ b/drivers/tty/serial/cpm_uart/cpm_uart_cpm2.c
@@ -33,11 +33,6 @@
 
 /**************************************************************/
 
-void cpm_line_cr_cmd(struct uart_cpm_port *port, int cmd)
-{
-	cpm_command(port->command, cmd);
-}
-
 void __iomem *cpm_uart_map_pram(struct uart_cpm_port *port,
 				struct device_node *np)
 {
-- 
2.41.0

