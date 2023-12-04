Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6827180340E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235456AbjLDNKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:10:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235435AbjLDNKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:10:21 -0500
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BF9171C;
        Mon,  4 Dec 2023 05:10:04 -0800 (PST)
X-QQ-mid: bizesmtp64t1701695309t3n1mps1
Received: from localhost ( [183.209.108.253])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 04 Dec 2023 21:08:27 +0800 (CST)
X-QQ-SSF: 01400000000000502000000A0000000
X-QQ-FEAT: G7QNoC8aK8jCw2Cy7bzCegXSBk+GBMFxbHnjmWKfko8QStACzMyB7stW8UTSN
        MsCRsemUMOpAq2FCY0nIjHRbMrfPlAWXav0JNsqXjOsZDPwdSKpbHtafGMUD5u8fGoav6d5
        VK2UDQPiiO5qtyyRXXlEa2TdFQeQ4G54D23eeWLq21qV7e3oEyXVWBHh/hE93x4U+tR9lME
        F3Su97oUB/BCiiMk/iFZTPhed7wCftT5ZyPruqk3NsWbKTgXJCLFn7nrcnlefMsMJgyJkjc
        iW3ECNqtTC2WTqKFBWmvjNqUf5uSN0fTdc1TalaWI8FUB444CeyIFNqykgUuuTgGuDG7e2U
        KuFzjn7Uw//mODHfM/23j786A3v7yhkJ5o8E/yRP5Dt5ryB5z2/1jieW56EWULaD8OiGCV/
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 13229479588945865013
From:   Dawei Li <dawei.li@shingroup.cn>
To:     gregkh@linuxfoundation.org, ilpo.jarvinen@linux.intel.com,
        andriy.shevchenko@linux.intel.com
Cc:     jirislaby@kernel.org, jszhang@kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        set_pte_at@outlook.com, Dawei Li <dawei.li@shingroup.cn>,
        stable@kernel.org
Subject: [PATCH] serial: dw8250: Make DLF feature independent of ADDITIONAL_FEATURE
Date:   Mon,  4 Dec 2023 21:08:20 +0800
Message-Id: <20231204130820.2823688-1-dawei.li@shingroup.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DW apb uart databook defines couples of configuration parameters of
dw8250 IP, among which there are 2 of them:
- ADDTIONAL_FEATURE
" Configure the peripheral to have the option to include FIFO status
  registers, shadow registers and encoded parameter register. Also
  configures the peripheral to have UART component version and the
  peripheral ID registers. "

- FRACTIONAL_BAUD_DIVISOR_EN
" Configures the peripheral to have Fractional Baud Rate Divisor.
  .... "

These two parameters are completely irrelevant, and supposed to be
independent of each other. However, in current dw8250 driver
implementation, they are hooked together.

The bug was hit when we are bringing up dw8250 IP on our hardware
platform, in which parameters are configured in such combination:
- ADDTIONAL_FEATURE disabled;
- FRACTIONAL_BAUD_DIVISOR_EN enabled;

Fixes: 701c5e73b296 ("serial: 8250_dw: add fractional divisor support")
Cc: stable@kernel.org
Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
---
 drivers/tty/serial/8250/8250_dwlib.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dwlib.c b/drivers/tty/serial/8250/8250_dwlib.c
index 84843e204a5e..136ad093c5b6 100644
--- a/drivers/tty/serial/8250/8250_dwlib.c
+++ b/drivers/tty/serial/8250/8250_dwlib.c
@@ -259,17 +259,6 @@ void dw8250_setup_port(struct uart_port *p)
 	}
 	up->capabilities |= UART_CAP_NOTEMT;
 
-	/*
-	 * If the Component Version Register returns zero, we know that
-	 * ADDITIONAL_FEATURES are not enabled. No need to go any further.
-	 */
-	reg = dw8250_readl_ext(p, DW_UART_UCV);
-	if (!reg)
-		return;
-
-	dev_dbg(p->dev, "Designware UART version %c.%c%c\n",
-		(reg >> 24) & 0xff, (reg >> 16) & 0xff, (reg >> 8) & 0xff);
-
 	/* Preserve value written by firmware or bootloader  */
 	old_dlf = dw8250_readl_ext(p, DW_UART_DLF);
 	dw8250_writel_ext(p, DW_UART_DLF, ~0U);
@@ -282,6 +271,17 @@ void dw8250_setup_port(struct uart_port *p)
 		p->set_divisor = dw8250_set_divisor;
 	}
 
+	/*
+	 * If the Component Version Register returns zero, we know that
+	 * ADDITIONAL_FEATURES are not enabled. No need to go any further.
+	 */
+	reg = dw8250_readl_ext(p, DW_UART_UCV);
+	if (!reg)
+		return;
+
+	dev_dbg(p->dev, "Designware UART version %c.%c%c\n",
+		(reg >> 24) & 0xff, (reg >> 16) & 0xff, (reg >> 8) & 0xff);
+
 	reg = dw8250_readl_ext(p, DW_UART_CPR);
 	if (!reg) {
 		reg = data->pdata->cpr_val;
-- 
2.27.0

