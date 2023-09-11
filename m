Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794A179ACF4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378738AbjIKWhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240399AbjIKOnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 10:43:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91750E40;
        Mon, 11 Sep 2023 07:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694443396; x=1725979396;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=I4/ojXmeBQapC+xcNa44W6610Ukxsr716DrBWlchx7o=;
  b=NtlsQqGpxw8h/SeIsQiKs0lXaCE2jO2uAPEGGQf0uq/mMc8fAyTC5OJm
   jaOSCkcEDTBbkoO4dBbdmcVVC5YNo7hkMBsRwbDsij132/M8jaxDoU56d
   BCo3l0tLq0deXH/7+A6R3Q/wTTSd93A+hfWUeXFRFvbnjTiKe+0VEM9cG
   PnNIL+TkX8PYMUaw1t+SZ0tdbm3J1T+gFGjDeWmvHg5fQHuB+qSc85DGv
   /GRhGteoVbh18Rit2KISmZvg9RhRcfA6FYIrgprcWUqN59WfqBZrkligu
   GyQ9O9Rbd1RSnnHR/eAxDBJCPLdReRaO5bsaORuHbAbASiX79u1AatvQx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="409067664"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="409067664"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 07:43:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="886531624"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="886531624"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 11 Sep 2023 07:42:49 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id AA14C45B; Mon, 11 Sep 2023 17:43:12 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] serial: 8250_port: Introduce UART_IIR_FIFO_ENABLED_16750
Date:   Mon, 11 Sep 2023 17:43:08 +0300
Message-Id: <20230911144308.4169752-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UART_IIR_64BYTE_FIFO is always being used in conjunction with
UART_IIR_FIFO_ENABLED. Introduce a joined UART_IIR_FIFO_ENABLED_16750
definition and use it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_port.c | 11 +++++------
 include/uapi/linux/serial_reg.h     |  1 +
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index fb891b67968f..a064698c2be0 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1008,12 +1008,11 @@ static void autoconfig_16550a(struct uart_8250_port *up)
 			serial_out(up, UART_LCR, 0);
 			serial_out(up, UART_FCR, UART_FCR_ENABLE_FIFO |
 				   UART_FCR7_64BYTE);
-			status1 = serial_in(up, UART_IIR) & (UART_IIR_64BYTE_FIFO |
-							     UART_IIR_FIFO_ENABLED);
+			status1 = serial_in(up, UART_IIR) & UART_IIR_FIFO_ENABLED_16750;
 			serial_out(up, UART_FCR, 0);
 			serial_out(up, UART_LCR, 0);
 
-			if (status1 == (UART_IIR_64BYTE_FIFO | UART_IIR_FIFO_ENABLED))
+			if (status1 == UART_IIR_FIFO_ENABLED_16750)
 				up->port.type = PORT_16550A_FSL64;
 			else
 				DEBUG_AUTOCONF("Motorola 8xxx DUART ");
@@ -1081,12 +1080,12 @@ static void autoconfig_16550a(struct uart_8250_port *up)
 	 */
 	serial_out(up, UART_LCR, 0);
 	serial_out(up, UART_FCR, UART_FCR_ENABLE_FIFO | UART_FCR7_64BYTE);
-	status1 = serial_in(up, UART_IIR) & (UART_IIR_64BYTE_FIFO | UART_IIR_FIFO_ENABLED);
+	status1 = serial_in(up, UART_IIR) & UART_IIR_FIFO_ENABLED_16750;
 	serial_out(up, UART_FCR, UART_FCR_ENABLE_FIFO);
 
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_A);
 	serial_out(up, UART_FCR, UART_FCR_ENABLE_FIFO | UART_FCR7_64BYTE);
-	status2 = serial_in(up, UART_IIR) & (UART_IIR_64BYTE_FIFO | UART_IIR_FIFO_ENABLED);
+	status2 = serial_in(up, UART_IIR) & UART_IIR_FIFO_ENABLED_16750;
 	serial_out(up, UART_FCR, UART_FCR_ENABLE_FIFO);
 
 	serial_out(up, UART_LCR, 0);
@@ -1094,7 +1093,7 @@ static void autoconfig_16550a(struct uart_8250_port *up)
 	DEBUG_AUTOCONF("iir1=%d iir2=%d ", status1, status2);
 
 	if (status1 == UART_IIR_FIFO_ENABLED_16550A &&
-	    status2 == (UART_IIR_64BYTE_FIFO | UART_IIR_FIFO_ENABLED_16550A)) {
+	    status2 == UART_IIR_FIFO_ENABLED_16750) {
 		up->port.type = PORT_16750;
 		up->capabilities |= UART_CAP_AFE | UART_CAP_SLEEP;
 		return;
diff --git a/include/uapi/linux/serial_reg.h b/include/uapi/linux/serial_reg.h
index 08b3527e1b93..9c987b04e2d0 100644
--- a/include/uapi/linux/serial_reg.h
+++ b/include/uapi/linux/serial_reg.h
@@ -49,6 +49,7 @@
 #define  UART_IIR_FIFO_ENABLED_8250	0x00	/* 8250: no FIFO */
 #define  UART_IIR_FIFO_ENABLED_16550	0x80	/* 16550: (broken/unusable) FIFO */
 #define  UART_IIR_FIFO_ENABLED_16550A	0xc0	/* 16550A: FIFO enabled */
+#define  UART_IIR_FIFO_ENABLED_16750	0xe0	/* 16750: 64 bytes FIFO enabled */
 
 #define UART_FCR	2	/* Out: FIFO Control Register */
 #define UART_FCR_ENABLE_FIFO	0x01 /* Enable the FIFO */
-- 
2.40.0.1.gaa8946217a0b

