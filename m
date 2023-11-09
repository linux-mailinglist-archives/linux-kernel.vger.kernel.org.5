Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167CB7E65A8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 09:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbjKIIvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 03:51:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233700AbjKIIvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 03:51:11 -0500
Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A54F270E;
        Thu,  9 Nov 2023 00:50:58 -0800 (PST)
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.92)
        (envelope-from <prvs=06912c668f=fe@dev.tdt.de>)
        id 1r10kR-00E9lH-NM; Thu, 09 Nov 2023 09:50:47 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
        by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1r10kQ-001kJ1-UY; Thu, 09 Nov 2023 09:50:46 +0100
Received: from securemail.tdt.de (localhost [127.0.0.1])
        by securemail.tdt.de (Postfix) with ESMTP id 93A72240040;
        Thu,  9 Nov 2023 09:50:46 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
        by securemail.tdt.de (Postfix) with ESMTP id E9CC824004B;
        Thu,  9 Nov 2023 09:50:45 +0100 (CET)
Received: from localhost.localdomain (unknown [10.2.3.40])
        by mail.dev.tdt.de (Postfix) with ESMTPSA id 33B70222EE;
        Thu,  9 Nov 2023 09:50:45 +0100 (CET)
From:   Florian Eckert <fe@dev.tdt.de>
To:     Eckert.Florian@googlemail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, pavel@ucw.cz, lee@kernel.org,
        kabel@kernel.org, u.kleine-koenig@pengutronix.de,
        m.brock@vanmierlo.com
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: [Patch v8 1/6] tty: add new helper function tty_get_tiocm
Date:   Thu,  9 Nov 2023 09:50:33 +0100
Message-ID: <20231109085038.371977-2-fe@dev.tdt.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231109085038.371977-1-fe@dev.tdt.de>
References: <20231109085038.371977-1-fe@dev.tdt.de>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,URIBL_DBL_BLOCKED_OPENDNS,
        URIBL_ZEN_BLOCKED_OPENDNS autolearn=ham autolearn_force=no
        version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.dev.tdt.de
Content-Transfer-Encoding: quoted-printable
X-purgate: clean
X-purgate-ID: 151534::1699519847-CE6F33D8-428FBA8B/0/0
X-purgate-type: clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no in-kernel function to get the status register of a tty device
like the TIOCMGET ioctl returns to userspace. Create a new function,
tty_get_tiocm(), to obtain the status register that other portions of the
kernel can call if they need this information, and move the existing
internal tty_tiocmget() function to use this interface.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Florian Eckert <fe@dev.tdt.de>
---
 drivers/tty/tty_io.c | 28 ++++++++++++++++++++++------
 include/linux/tty.h  |  1 +
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 06414e43e0b5..e2e93404133e 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2498,6 +2498,24 @@ static int send_break(struct tty_struct *tty, unsi=
gned int duration)
 	return retval;
 }
=20
+/**
+ * tty_get_tiocm - get tiocm status register
+ * @tty: tty device
+ *
+ * Obtain the modem status bits from the tty driver if the feature
+ * is supported.
+ */
+int tty_get_tiocm(struct tty_struct *tty)
+{
+	int retval =3D -ENOTTY;
+
+	if (tty->ops->tiocmget)
+		retval =3D tty->ops->tiocmget(tty);
+
+	return retval;
+}
+EXPORT_SYMBOL_GPL(tty_get_tiocm);
+
 /**
  * tty_tiocmget - get modem status
  * @tty: tty device
@@ -2510,14 +2528,12 @@ static int send_break(struct tty_struct *tty, uns=
igned int duration)
  */
 static int tty_tiocmget(struct tty_struct *tty, int __user *p)
 {
-	int retval =3D -ENOTTY;
+	int retval;
=20
-	if (tty->ops->tiocmget) {
-		retval =3D tty->ops->tiocmget(tty);
+	retval =3D tty_get_tiocm(tty);
+	if (retval >=3D 0)
+		retval =3D put_user(retval, p);
=20
-		if (retval >=3D 0)
-			retval =3D put_user(retval, p);
-	}
 	return retval;
 }
=20
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 4b6340ac2af2..d219a11e3fe0 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -419,6 +419,7 @@ bool tty_unthrottle_safe(struct tty_struct *tty);
 int tty_do_resize(struct tty_struct *tty, struct winsize *ws);
 int tty_get_icount(struct tty_struct *tty,
 		struct serial_icounter_struct *icount);
+int tty_get_tiocm(struct tty_struct *tty);
 int is_current_pgrp_orphaned(void);
 void tty_hangup(struct tty_struct *tty);
 void tty_vhangup(struct tty_struct *tty);
--=20
2.30.2

