Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47EA67AE9C9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 11:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233768AbjIZJ75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 05:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbjIZJ7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 05:59:55 -0400
X-Greylist: delayed 1406 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 26 Sep 2023 02:59:48 PDT
Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE0C97;
        Tue, 26 Sep 2023 02:59:48 -0700 (PDT)
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.92)
        (envelope-from <prvs=8647860101=fe@dev.tdt.de>)
        id 1ql4UJ-008coS-6B; Tue, 26 Sep 2023 11:36:15 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
        by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1ql4UI-00EaJX-CA; Tue, 26 Sep 2023 11:36:14 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
        by securemail.tdt.de (Postfix) with ESMTP id E860E24004D;
        Tue, 26 Sep 2023 11:36:13 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
        by securemail.tdt.de (Postfix) with ESMTP id 44600240049;
        Tue, 26 Sep 2023 11:36:13 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.2.3.40])
        by mail.dev.tdt.de (Postfix) with ESMTPSA id E599732D8A;
        Tue, 26 Sep 2023 11:36:12 +0200 (CEST)
From:   Florian Eckert <fe@dev.tdt.de>
To:     Eckert.Florian@googlemail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, pavel@ucw.cz, lee@kernel.org,
        kabel@kernel.org, u.kleine-koenig@pengutronix.de
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: [PATCH 1/2] tty: add new helper function tty_get_mget
Date:   Tue, 26 Sep 2023 11:36:06 +0200
Message-ID: <20230926093607.59536-2-fe@dev.tdt.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230926093607.59536-1-fe@dev.tdt.de>
References: <20230926093607.59536-1-fe@dev.tdt.de>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Content-Transfer-Encoding: quoted-printable
X-purgate-type: clean
X-purgate: clean
X-purgate-ID: 151534::1695720975-B296CB19-1805BCDD/0/0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct 'tty_struct' has a callback to read the status flags of the tt=
y
if the tty driver provides them. So fare, the data is transferred directl=
y
to userspace with the function 'tty_tiocmget'. This function cannot be
used to evaluate the status line of the tty interface in the ledtrig-tty
trigger. To make this possible, a new function must be added that does
not immediately pass the data on to userspace.

The new function 'tty_get_mget' only returns the status register.
This information can then be processed further in the ledtrig-tty
trigger.

Signed-off-by: Florian Eckert <fe@dev.tdt.de>
---
 drivers/tty/tty_io.c | 29 +++++++++++++++++++++++------
 include/linux/tty.h  |  1 +
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 8a94e5a43c6d..8070ed0ce41f 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2494,6 +2494,25 @@ static int send_break(struct tty_struct *tty, unsi=
gned int duration)
 	return retval;
 }
=20
+/**
+ * tty_get_mget		-	get modem status
+ * @tty: tty device
+ *
+ * Obtain the modem status bits from the tty driver if the feature
+ * is supported.
+ *
+ */
+int tty_get_mget(struct tty_struct *tty)
+{
+	int retval =3D -ENOTTY;
+
+	if (tty->ops->tiocmget)
+		retval =3D tty->ops->tiocmget(tty);
+
+	return retval;
+}
+EXPORT_SYMBOL_GPL(tty_get_mget);
+
 /**
  * tty_tiocmget		-	get modem status
  * @tty: tty device
@@ -2506,14 +2525,12 @@ static int send_break(struct tty_struct *tty, uns=
igned int duration)
  */
 static int tty_tiocmget(struct tty_struct *tty, int __user *p)
 {
-	int retval =3D -ENOTTY;
+	int retval;
=20
-	if (tty->ops->tiocmget) {
-		retval =3D tty->ops->tiocmget(tty);
+	retval =3D tty_get_mget(tty);
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
index f002d0f25db7..7b9edd4a7007 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -421,6 +421,7 @@ int tty_unthrottle_safe(struct tty_struct *tty);
 int tty_do_resize(struct tty_struct *tty, struct winsize *ws);
 int tty_get_icount(struct tty_struct *tty,
 		struct serial_icounter_struct *icount);
+int tty_get_mget(struct tty_struct *tty);
 int is_current_pgrp_orphaned(void);
 void tty_hangup(struct tty_struct *tty);
 void tty_vhangup(struct tty_struct *tty);
--=20
2.30.2

