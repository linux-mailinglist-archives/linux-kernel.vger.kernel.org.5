Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D6777743E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234841AbjHJJSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234838AbjHJJR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:17:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9EA46B4;
        Thu, 10 Aug 2023 02:16:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB6156551C;
        Thu, 10 Aug 2023 09:16:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF34C433CB;
        Thu, 10 Aug 2023 09:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691658992;
        bh=xUZ9/AL3u/qN9nyDCrwUn7AoTj5LSpl3Y8QSlJQ5kJQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ulGxlS3c7KWGoE1YOx1kbAT5LQm7HNwJSumVO+Lu4ZulvGw6dGdjQqeBS/pNpCxVQ
         R9FkodnNUxn0I5wcqOMyirR+mlA7Hd9Mb8EyefnIAdlKjYJDSNaeiJ4afcI4AS+hW8
         U6sUz5kYPekQMANvM4U06ryWVGk2AfCGz7zJnWX6yCJt+C/EZbaSm1YhbtxQrFcvYk
         Qs8CUOyOuPNYwY+RUc0O+BD1qKV8fLyh1dTUEjORjcSOEkGq/FA7uR7kuuna1cVucW
         r3+tzmlcogYv81Z37oLHwIs/F+E9z91Er4QeLUaCsMpjo0qVRHH/xFnh/Mm4GCWps3
         7fzaP3+45+eAQ==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 31/36] tty: ldops: unify to u8
Date:   Thu, 10 Aug 2023 11:15:05 +0200
Message-ID: <20230810091510.13006-32-jirislaby@kernel.org>
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

Some hooks in struct tty_ldisc_ops still reference buffers by 'unsigned
char'. Unify to 'u8' as the rest of the tty layer does.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/bluetooth/hci_ldisc.c |  6 +++---
 drivers/input/serio/serport.c |  4 ++--
 drivers/net/ppp/ppp_async.c   |  9 ++++-----
 drivers/net/ppp/ppp_synctty.c |  7 +++----
 drivers/tty/n_gsm.c           |  7 +++----
 drivers/tty/n_hdlc.c          |  6 +++---
 drivers/tty/n_null.c          |  7 +++----
 drivers/tty/n_tty.c           | 11 +++++------
 include/linux/tty_ldisc.h     | 13 ++++++-------
 net/nfc/nci/uart.c            |  6 +++---
 10 files changed, 35 insertions(+), 41 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 3e11fc06a932..a26367e9fb19 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -807,14 +807,14 @@ static int hci_uart_tty_ioctl(struct tty_struct *tty, unsigned int cmd,
  * We don't provide read/write/poll interface for user space.
  */
 static ssize_t hci_uart_tty_read(struct tty_struct *tty, struct file *file,
-				 unsigned char *buf, size_t nr,
-				 void **cookie, unsigned long offset)
+				 u8 *buf, size_t nr, void **cookie,
+				 unsigned long offset)
 {
 	return 0;
 }
 
 static ssize_t hci_uart_tty_write(struct tty_struct *tty, struct file *file,
-				  const unsigned char *data, size_t count)
+				  const u8 *data, size_t count)
 {
 	return 0;
 }
diff --git a/drivers/input/serio/serport.c b/drivers/input/serio/serport.c
index 5ce8d9f10f3e..1db3f30011c4 100644
--- a/drivers/input/serio/serport.c
+++ b/drivers/input/serio/serport.c
@@ -158,8 +158,8 @@ static void serport_ldisc_receive(struct tty_struct *tty, const u8 *cp,
  */
 
 static ssize_t serport_ldisc_read(struct tty_struct * tty, struct file * file,
-				  unsigned char *kbuf, size_t nr,
-				  void **cookie, unsigned long offset)
+				  u8 *kbuf, size_t nr, void **cookie,
+				  unsigned long offset)
 {
 	struct serport *serport = tty->disc_data;
 	struct serio *serio;
diff --git a/drivers/net/ppp/ppp_async.c b/drivers/net/ppp/ppp_async.c
index cfd5cb609d99..fbaaa8c102a1 100644
--- a/drivers/net/ppp/ppp_async.c
+++ b/drivers/net/ppp/ppp_async.c
@@ -257,9 +257,8 @@ static void ppp_asynctty_hangup(struct tty_struct *tty)
  * Pppd reads and writes packets via /dev/ppp instead.
  */
 static ssize_t
-ppp_asynctty_read(struct tty_struct *tty, struct file *file,
-		  unsigned char *buf, size_t count,
-		  void **cookie, unsigned long offset)
+ppp_asynctty_read(struct tty_struct *tty, struct file *file, u8 *buf,
+		  size_t count, void **cookie, unsigned long offset)
 {
 	return -EAGAIN;
 }
@@ -269,8 +268,8 @@ ppp_asynctty_read(struct tty_struct *tty, struct file *file,
  * from the ppp generic stuff.
  */
 static ssize_t
-ppp_asynctty_write(struct tty_struct *tty, struct file *file,
-		   const unsigned char *buf, size_t count)
+ppp_asynctty_write(struct tty_struct *tty, struct file *file, const u8 *buf,
+		   size_t count)
 {
 	return -EAGAIN;
 }
diff --git a/drivers/net/ppp/ppp_synctty.c b/drivers/net/ppp/ppp_synctty.c
index 164c9053f73b..ebcdffdf4f0e 100644
--- a/drivers/net/ppp/ppp_synctty.c
+++ b/drivers/net/ppp/ppp_synctty.c
@@ -255,8 +255,7 @@ static void ppp_sync_hangup(struct tty_struct *tty)
  * Pppd reads and writes packets via /dev/ppp instead.
  */
 static ssize_t
-ppp_sync_read(struct tty_struct *tty, struct file *file,
-	      unsigned char *buf, size_t count,
+ppp_sync_read(struct tty_struct *tty, struct file *file, u8 *buf, size_t count,
 	      void **cookie, unsigned long offset)
 {
 	return -EAGAIN;
@@ -267,8 +266,8 @@ ppp_sync_read(struct tty_struct *tty, struct file *file,
  * from the ppp generic stuff.
  */
 static ssize_t
-ppp_sync_write(struct tty_struct *tty, struct file *file,
-		const unsigned char *buf, size_t count)
+ppp_sync_write(struct tty_struct *tty, struct file *file, const u8 *buf,
+	       size_t count)
 {
 	return -EAGAIN;
 }
diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 3e5cc30941a7..42759500b79e 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -3638,9 +3638,8 @@ static void gsmld_write_wakeup(struct tty_struct *tty)
  *	This code must be sure never to sleep through a hangup.
  */
 
-static ssize_t gsmld_read(struct tty_struct *tty, struct file *file,
-			  unsigned char *buf, size_t nr,
-			  void **cookie, unsigned long offset)
+static ssize_t gsmld_read(struct tty_struct *tty, struct file *file, u8 *buf,
+			  size_t nr, void **cookie, unsigned long offset)
 {
 	return -EOPNOTSUPP;
 }
@@ -3660,7 +3659,7 @@ static ssize_t gsmld_read(struct tty_struct *tty, struct file *file,
  */
 
 static ssize_t gsmld_write(struct tty_struct *tty, struct file *file,
-			   const unsigned char *buf, size_t nr)
+			   const u8 *buf, size_t nr)
 {
 	struct gsm_mux *gsm = tty->disc_data;
 	unsigned long flags;
diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
index 9be0932d07e0..a670419efe79 100644
--- a/drivers/tty/n_hdlc.c
+++ b/drivers/tty/n_hdlc.c
@@ -425,8 +425,8 @@ static void n_hdlc_tty_receive(struct tty_struct *tty, const u8 *data,
  * Returns the number of bytes returned or error code.
  */
 static ssize_t n_hdlc_tty_read(struct tty_struct *tty, struct file *file,
-			   __u8 *kbuf, size_t nr,
-			   void **cookie, unsigned long offset)
+			       u8 *kbuf, size_t nr, void **cookie,
+			       unsigned long offset)
 {
 	struct n_hdlc *n_hdlc = tty->disc_data;
 	int ret = 0;
@@ -518,7 +518,7 @@ static ssize_t n_hdlc_tty_read(struct tty_struct *tty, struct file *file,
  * Returns the number of bytes written (or error code).
  */
 static ssize_t n_hdlc_tty_write(struct tty_struct *tty, struct file *file,
-			    const unsigned char *data, size_t count)
+				const u8 *data, size_t count)
 {
 	struct n_hdlc *n_hdlc = tty->disc_data;
 	int error = 0;
diff --git a/drivers/tty/n_null.c b/drivers/tty/n_null.c
index 4a0d8bb2fb4c..5a429d923eb3 100644
--- a/drivers/tty/n_null.c
+++ b/drivers/tty/n_null.c
@@ -10,15 +10,14 @@
  *  Copyright (C) Intel 2017
  */
 
-static ssize_t n_null_read(struct tty_struct *tty, struct file *file,
-			   unsigned char *buf, size_t nr,
-			   void **cookie, unsigned long offset)
+static ssize_t n_null_read(struct tty_struct *tty, struct file *file, u8 *buf,
+			   size_t nr, void **cookie, unsigned long offset)
 {
 	return -EOPNOTSUPP;
 }
 
 static ssize_t n_null_write(struct tty_struct *tty, struct file *file,
-			    const unsigned char *buf, size_t nr)
+			    const u8 *buf, size_t nr)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 1053b2adb04c..f44f38bb412e 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -2128,12 +2128,11 @@ static int job_control(struct tty_struct *tty, struct file *file)
  *	claims non-exclusive termios_rwsem;
  *	publishes read_tail
  */
-static ssize_t n_tty_read(struct tty_struct *tty, struct file *file,
-			  unsigned char *kbuf, size_t nr,
-			  void **cookie, unsigned long offset)
+static ssize_t n_tty_read(struct tty_struct *tty, struct file *file, u8 *kbuf,
+			  size_t nr, void **cookie, unsigned long offset)
 {
 	struct n_tty_data *ldata = tty->disc_data;
-	unsigned char *kb = kbuf;
+	u8 *kb = kbuf;
 	DEFINE_WAIT_FUNC(wait, woken_wake_function);
 	int c;
 	int minimum, time;
@@ -2332,9 +2331,9 @@ static ssize_t n_tty_read(struct tty_struct *tty, struct file *file,
  */
 
 static ssize_t n_tty_write(struct tty_struct *tty, struct file *file,
-			   const unsigned char *buf, size_t nr)
+			   const u8 *buf, size_t nr)
 {
-	const unsigned char *b = buf;
+	const u8 *b = buf;
 	DEFINE_WAIT_FUNC(wait, woken_wake_function);
 	int c;
 	ssize_t retval = 0;
diff --git a/include/linux/tty_ldisc.h b/include/linux/tty_ldisc.h
index a661d7df5497..af01e89074b2 100644
--- a/include/linux/tty_ldisc.h
+++ b/include/linux/tty_ldisc.h
@@ -90,8 +90,8 @@ int ldsem_down_write_nested(struct ld_semaphore *sem, int subclass,
  *
  *	Optional.
  *
- * @read: [TTY] ``ssize_t ()(struct tty_struct *tty, struct file *file,
- *		unsigned char *buf, size_t nr)``
+ * @read: [TTY] ``ssize_t ()(struct tty_struct *tty, struct file *file, u8 *buf,
+ *		size_t nr)``
  *
  *	This function is called when the user requests to read from the @tty.
  *	The line discipline will return whatever characters it has buffered up
@@ -102,7 +102,7 @@ int ldsem_down_write_nested(struct ld_semaphore *sem, int subclass,
  *	Optional: %EIO unless provided. Can sleep.
  *
  * @write: [TTY] ``ssize_t ()(struct tty_struct *tty, struct file *file,
- *		const unsigned char *buf, size_t nr)``
+ *		 const u8 *buf, size_t nr)``
  *
  *	This function is called when the user requests to write to the @tty.
  *	The line discipline will deliver the characters to the low-level tty
@@ -238,11 +238,10 @@ struct tty_ldisc_ops {
 	int	(*open)(struct tty_struct *tty);
 	void	(*close)(struct tty_struct *tty);
 	void	(*flush_buffer)(struct tty_struct *tty);
-	ssize_t	(*read)(struct tty_struct *tty, struct file *file,
-			unsigned char *buf, size_t nr,
-			void **cookie, unsigned long offset);
+	ssize_t	(*read)(struct tty_struct *tty, struct file *file, u8 *buf,
+			size_t nr, void **cookie, unsigned long offset);
 	ssize_t	(*write)(struct tty_struct *tty, struct file *file,
-			 const unsigned char *buf, size_t nr);
+			 const u8 *buf, size_t nr);
 	int	(*ioctl)(struct tty_struct *tty, unsigned int cmd,
 			unsigned long arg);
 	int	(*compat_ioctl)(struct tty_struct *tty, unsigned int cmd,
diff --git a/net/nfc/nci/uart.c b/net/nfc/nci/uart.c
index 93775c540287..ed1508a9e093 100644
--- a/net/nfc/nci/uart.c
+++ b/net/nfc/nci/uart.c
@@ -345,14 +345,14 @@ static int nci_uart_tty_ioctl(struct tty_struct *tty, unsigned int cmd,
 
 /* We don't provide read/write/poll interface for user space. */
 static ssize_t nci_uart_tty_read(struct tty_struct *tty, struct file *file,
-				 unsigned char *buf, size_t nr,
-				 void **cookie, unsigned long offset)
+				 u8 *buf, size_t nr, void **cookie,
+				 unsigned long offset)
 {
 	return 0;
 }
 
 static ssize_t nci_uart_tty_write(struct tty_struct *tty, struct file *file,
-				  const unsigned char *data, size_t count)
+				  const u8 *data, size_t count)
 {
 	return 0;
 }
-- 
2.41.0

