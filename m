Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9781777434
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbjHJJSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234718AbjHJJR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:17:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E079D468B;
        Thu, 10 Aug 2023 02:16:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A3C86551A;
        Thu, 10 Aug 2023 09:16:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AAD7C433CA;
        Thu, 10 Aug 2023 09:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691658985;
        bh=A8935zg9mWP6HBioO/NsJ2dq9U54oyHMV8NxaoI4yys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FycmI7Vdn+yU0EJrGvic2OkCdYhKqE2msZgI+9HYM73WcI/ajQSJmG5xVCbJUtDib
         Chl/mJhitLyaR9IzT4xnCdYGPeLG5wIWobT3oMVXF5oGY93AJFS/ue5UOb3J+0R0RX
         HGvo0GNb3IZ5BTnKcfrlaD6vbZA5CzBTY+/Q0SRpfUNFBS6H9RB3mvsOftxWRQXhCr
         qo00BLMc2zNwdqyGYL0jwm0j0JbReQw/+7I+ma+OZLRSpHBXYtnZqSjeYObwwh5HML
         TLNqtx/taNSkbUblbUnzFIVxqGwt++ChiDEMQtS30pG8fY5opJo8gof0y6bhS9XlJU
         xQrKQ16NITTpA==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Karsten Keil <isdn@linux-pingi.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Mathias Nyman <mathias.nyman@intel.com>
Subject: [PATCH 28/36] tty: propagate u8 data to tty_operations::put_char()
Date:   Thu, 10 Aug 2023 11:15:02 +0200
Message-ID: <20230810091510.13006-29-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230810091510.13006-1-jirislaby@kernel.org>
References: <20230810091510.13006-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Data are now typed as u8. Propagate this change to
tty_operations::put_char().

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Karsten Keil <isdn@linux-pingi.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>
---
 arch/m68k/emu/nfcon.c                  | 4 ++--
 drivers/isdn/capi/capi.c               | 2 +-
 drivers/s390/char/con3215.c            | 2 +-
 drivers/s390/char/con3270.c            | 2 +-
 drivers/s390/char/sclp_tty.c           | 6 +++---
 drivers/s390/char/sclp_vt220.c         | 2 +-
 drivers/tty/amiserial.c                | 2 +-
 drivers/tty/mxser.c                    | 2 +-
 drivers/tty/serial/serial_core.c       | 2 +-
 drivers/tty/synclink_gt.c              | 4 ++--
 drivers/tty/vt/vt.c                    | 2 +-
 drivers/usb/gadget/function/u_serial.c | 2 +-
 drivers/usb/host/xhci-dbgtty.c         | 2 +-
 include/linux/tty_driver.h             | 2 +-
 14 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/m68k/emu/nfcon.c b/arch/m68k/emu/nfcon.c
index e7a21234b481..87398f834e36 100644
--- a/arch/m68k/emu/nfcon.c
+++ b/arch/m68k/emu/nfcon.c
@@ -76,9 +76,9 @@ static int nfcon_tty_write(struct tty_struct *tty, const u8 *buf, int count)
 	return count;
 }
 
-static int nfcon_tty_put_char(struct tty_struct *tty, unsigned char ch)
+static int nfcon_tty_put_char(struct tty_struct *tty, u8 ch)
 {
-	char temp[2] = { ch, 0 };
+	u8 temp[2] = { ch, 0 };
 
 	nf_call(stderr_id, virt_to_phys(temp));
 	return 1;
diff --git a/drivers/isdn/capi/capi.c b/drivers/isdn/capi/capi.c
index cf6daf79c1a2..2f38e1cfe97a 100644
--- a/drivers/isdn/capi/capi.c
+++ b/drivers/isdn/capi/capi.c
@@ -1111,7 +1111,7 @@ static int capinc_tty_write(struct tty_struct *tty, const u8 *buf, int count)
 	return count;
 }
 
-static int capinc_tty_put_char(struct tty_struct *tty, unsigned char ch)
+static int capinc_tty_put_char(struct tty_struct *tty, u8 ch)
 {
 	struct capiminor *mp = tty->driver_data;
 	bool invoke_send = false;
diff --git a/drivers/s390/char/con3215.c b/drivers/s390/char/con3215.c
index 16b6f430dfd3..8bbce6a4d7f5 100644
--- a/drivers/s390/char/con3215.c
+++ b/drivers/s390/char/con3215.c
@@ -1030,7 +1030,7 @@ static int tty3215_write(struct tty_struct *tty, const u8 *buf, int count)
 /*
  * Put character routine for 3215 ttys
  */
-static int tty3215_put_char(struct tty_struct *tty, unsigned char ch)
+static int tty3215_put_char(struct tty_struct *tty, u8 ch)
 {
 	struct raw3215_info *raw = tty->driver_data;
 
diff --git a/drivers/s390/char/con3270.c b/drivers/s390/char/con3270.c
index 123524bff734..6374555a0937 100644
--- a/drivers/s390/char/con3270.c
+++ b/drivers/s390/char/con3270.c
@@ -1821,7 +1821,7 @@ static int tty3270_write(struct tty_struct *tty, const u8 *buf, int count)
 /*
  * Put single characters to the ttys character buffer
  */
-static int tty3270_put_char(struct tty_struct *tty, unsigned char ch)
+static int tty3270_put_char(struct tty_struct *tty, u8 ch)
 {
 	struct tty3270 *tp;
 
diff --git a/drivers/s390/char/sclp_tty.c b/drivers/s390/char/sclp_tty.c
index cc0f6a97124e..831a8c7cacc2 100644
--- a/drivers/s390/char/sclp_tty.c
+++ b/drivers/s390/char/sclp_tty.c
@@ -48,7 +48,7 @@ static struct sclp_buffer *sclp_ttybuf;
 static struct timer_list sclp_tty_timer;
 
 static struct tty_port sclp_port;
-static unsigned char sclp_tty_chars[SCLP_TTY_BUF_SIZE];
+static u8 sclp_tty_chars[SCLP_TTY_BUF_SIZE];
 static unsigned short int sclp_tty_chars_count;
 
 struct tty_driver *sclp_tty_driver;
@@ -168,7 +168,7 @@ sclp_tty_timeout(struct timer_list *unused)
 /*
  * Write a string to the sclp tty.
  */
-static int sclp_tty_write_string(const unsigned char *str, int count, int may_fail)
+static int sclp_tty_write_string(const u8 *str, int count, int may_fail)
 {
 	unsigned long flags;
 	void *page;
@@ -250,7 +250,7 @@ sclp_tty_write(struct tty_struct *tty, const u8 *buf, int count)
  * sclp_write() without final '\n' - will be written.
  */
 static int
-sclp_tty_put_char(struct tty_struct *tty, unsigned char ch)
+sclp_tty_put_char(struct tty_struct *tty, u8 ch)
 {
 	sclp_tty_chars[sclp_tty_chars_count++] = ch;
 	if (ch == '\n' || sclp_tty_chars_count >= SCLP_TTY_BUF_SIZE) {
diff --git a/drivers/s390/char/sclp_vt220.c b/drivers/s390/char/sclp_vt220.c
index 44974d801c1e..e148350c1e2c 100644
--- a/drivers/s390/char/sclp_vt220.c
+++ b/drivers/s390/char/sclp_vt220.c
@@ -579,7 +579,7 @@ sclp_vt220_close(struct tty_struct *tty, struct file *filp)
  * done stuffing characters into the driver.
  */
 static int
-sclp_vt220_put_char(struct tty_struct *tty, unsigned char ch)
+sclp_vt220_put_char(struct tty_struct *tty, u8 ch)
 {
 	return __sclp_vt220_write(&ch, 1, 0, 0, 1);
 }
diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
index 1dd8b86f4a32..91cf294ec8c1 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -696,7 +696,7 @@ static void change_speed(struct tty_struct *tty, struct serial_state *info,
 	local_irq_restore(flags);
 }
 
-static int rs_put_char(struct tty_struct *tty, unsigned char ch)
+static int rs_put_char(struct tty_struct *tty, u8 ch)
 {
 	struct serial_state *info;
 	unsigned long flags;
diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 8b4b8493fed5..a5dfd08d4ea2 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -920,7 +920,7 @@ static int mxser_write(struct tty_struct *tty, const u8 *buf, int count)
 	return written;
 }
 
-static int mxser_put_char(struct tty_struct *tty, unsigned char ch)
+static int mxser_put_char(struct tty_struct *tty, u8 ch)
 {
 	struct mxser_port *info = tty->driver_data;
 	unsigned long flags;
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 33df5b08d992..d5b682ff20b3 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -551,7 +551,7 @@ uart_get_divisor(struct uart_port *port, unsigned int baud)
 }
 EXPORT_SYMBOL(uart_get_divisor);
 
-static int uart_put_char(struct tty_struct *tty, unsigned char c)
+static int uart_put_char(struct tty_struct *tty, u8 c)
 {
 	struct uart_state *state = tty->driver_data;
 	struct uart_port *port;
diff --git a/drivers/tty/synclink_gt.c b/drivers/tty/synclink_gt.c
index c7cecea38ca8..0264e9f7699c 100644
--- a/drivers/tty/synclink_gt.c
+++ b/drivers/tty/synclink_gt.c
@@ -780,7 +780,7 @@ static int write(struct tty_struct *tty, const u8 *buf, int count)
 	return ret;
 }
 
-static int put_char(struct tty_struct *tty, unsigned char ch)
+static int put_char(struct tty_struct *tty, u8 ch)
 {
 	struct slgt_info *info = tty->driver_data;
 	unsigned long flags;
@@ -788,7 +788,7 @@ static int put_char(struct tty_struct *tty, unsigned char ch)
 
 	if (sanity_check(info, tty->name, "put_char"))
 		return 0;
-	DBGINFO(("%s put_char(%d)\n", info->device_name, ch));
+	DBGINFO(("%s put_char(%u)\n", info->device_name, ch));
 	if (!info->tx_buf)
 		return 0;
 	spin_lock_irqsave(&info->lock,flags);
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 2f28612aee91..ea7c20d66acb 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -3248,7 +3248,7 @@ static int con_write(struct tty_struct *tty, const u8 *buf, int count)
 	return retval;
 }
 
-static int con_put_char(struct tty_struct *tty, unsigned char ch)
+static int con_put_char(struct tty_struct *tty, u8 ch)
 {
 	return do_con_write(tty, &ch, 1);
 }
diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
index 1d08a1d8d3cd..3e6b750aa4fc 100644
--- a/drivers/usb/gadget/function/u_serial.c
+++ b/drivers/usb/gadget/function/u_serial.c
@@ -753,7 +753,7 @@ static int gs_write(struct tty_struct *tty, const u8 *buf, int count)
 	return count;
 }
 
-static int gs_put_char(struct tty_struct *tty, unsigned char ch)
+static int gs_put_char(struct tty_struct *tty, u8 ch)
 {
 	struct gs_port	*port = tty->driver_data;
 	unsigned long	flags;
diff --git a/drivers/usb/host/xhci-dbgtty.c b/drivers/usb/host/xhci-dbgtty.c
index f5f2d0e12e69..5b82bdd82ba9 100644
--- a/drivers/usb/host/xhci-dbgtty.c
+++ b/drivers/usb/host/xhci-dbgtty.c
@@ -222,7 +222,7 @@ static int dbc_tty_write(struct tty_struct *tty, const u8 *buf, int count)
 	return count;
 }
 
-static int dbc_tty_put_char(struct tty_struct *tty, unsigned char ch)
+static int dbc_tty_put_char(struct tty_struct *tty, u8 ch)
 {
 	struct dbc_port		*port = tty->driver_data;
 	unsigned long		flags;
diff --git a/include/linux/tty_driver.h b/include/linux/tty_driver.h
index a7bd8060ac96..c5299d952e59 100644
--- a/include/linux/tty_driver.h
+++ b/include/linux/tty_driver.h
@@ -357,7 +357,7 @@ struct tty_operations {
 	void (*shutdown)(struct tty_struct *tty);
 	void (*cleanup)(struct tty_struct *tty);
 	int  (*write)(struct tty_struct *tty, const u8 *buf, int count);
-	int  (*put_char)(struct tty_struct *tty, unsigned char ch);
+	int  (*put_char)(struct tty_struct *tty, u8 ch);
 	void (*flush_chars)(struct tty_struct *tty);
 	unsigned int (*write_room)(struct tty_struct *tty);
 	unsigned int (*chars_in_buffer)(struct tty_struct *tty);
-- 
2.41.0

