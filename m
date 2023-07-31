Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C18768F8E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbjGaIFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbjGaIES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:04:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6234E1713;
        Mon, 31 Jul 2023 01:02:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7FC4E60E8B;
        Mon, 31 Jul 2023 08:02:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DE88C433C9;
        Mon, 31 Jul 2023 08:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690790570;
        bh=iL+/iMkVyPpitc+31cYvs+uU/ZxRswV5+Wl1H0RRVAc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kk8c18DLN8tYP5izkZrkGSFDhJrb7SeDZ2SJdORAd4uCe9aBlAuCYU4UpsXxCh1q7
         nOQqzUT+G08qFcjMIIQ/pOIvdg2x0Z+65ju3cD8Z+9D7HHt45CFK7yUbIff/GI+JbK
         ijOILqb8o3+xF0Hiu5rwe3S86z9WyK1cqGTOMzVsiCFUu9Vm45Zg3OkfMjMOneoNtJ
         rZx01dTozdMNkVlKNj58/YqEESOGn3K9obS8F6L6epGPzJ9H5vi6fK1AOnbQ1PS/My
         AW78bF4WFORdBUyYEnCIV1MFh9lCHEl9Nif7xvBcpLJgjF4IG8zEiSJU8vAtd/YTMf
         7eGVYk0787PsA==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH 02/10] Bluetooth: rfcomm: remove casts from tty->driver_data
Date:   Mon, 31 Jul 2023 10:02:36 +0200
Message-ID: <20230731080244.2698-3-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230731080244.2698-1-jirislaby@kernel.org>
References: <20230731080244.2698-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tty->driver_data is 'void *', so there is no need to cast from that.
Therefore remove the casts and assign the pointer directly.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
---
 net/bluetooth/rfcomm/tty.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index 5697df9d4394..d73eec146529 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -771,7 +771,7 @@ static int rfcomm_tty_open(struct tty_struct *tty, struct file *filp)
 
 static void rfcomm_tty_close(struct tty_struct *tty, struct file *filp)
 {
-	struct rfcomm_dev *dev = (struct rfcomm_dev *) tty->driver_data;
+	struct rfcomm_dev *dev = tty->driver_data;
 
 	BT_DBG("tty %p dev %p dlc %p opened %d", tty, dev, dev->dlc,
 						dev->port.count);
@@ -781,7 +781,7 @@ static void rfcomm_tty_close(struct tty_struct *tty, struct file *filp)
 
 static int rfcomm_tty_write(struct tty_struct *tty, const unsigned char *buf, int count)
 {
-	struct rfcomm_dev *dev = (struct rfcomm_dev *) tty->driver_data;
+	struct rfcomm_dev *dev = tty->driver_data;
 	struct rfcomm_dlc *dlc = dev->dlc;
 	struct sk_buff *skb;
 	int sent = 0, size;
@@ -810,7 +810,7 @@ static int rfcomm_tty_write(struct tty_struct *tty, const unsigned char *buf, in
 
 static unsigned int rfcomm_tty_write_room(struct tty_struct *tty)
 {
-	struct rfcomm_dev *dev = (struct rfcomm_dev *) tty->driver_data;
+	struct rfcomm_dev *dev = tty->driver_data;
 	int room = 0;
 
 	if (dev && dev->dlc)
@@ -864,7 +864,7 @@ static void rfcomm_tty_set_termios(struct tty_struct *tty,
 	u8 baud, data_bits, stop_bits, parity, x_on, x_off;
 	u16 changes = 0;
 
-	struct rfcomm_dev *dev = (struct rfcomm_dev *) tty->driver_data;
+	struct rfcomm_dev *dev = tty->driver_data;
 
 	BT_DBG("tty %p termios %p", tty, old);
 
@@ -996,7 +996,7 @@ static void rfcomm_tty_set_termios(struct tty_struct *tty,
 
 static void rfcomm_tty_throttle(struct tty_struct *tty)
 {
-	struct rfcomm_dev *dev = (struct rfcomm_dev *) tty->driver_data;
+	struct rfcomm_dev *dev = tty->driver_data;
 
 	BT_DBG("tty %p dev %p", tty, dev);
 
@@ -1005,7 +1005,7 @@ static void rfcomm_tty_throttle(struct tty_struct *tty)
 
 static void rfcomm_tty_unthrottle(struct tty_struct *tty)
 {
-	struct rfcomm_dev *dev = (struct rfcomm_dev *) tty->driver_data;
+	struct rfcomm_dev *dev = tty->driver_data;
 
 	BT_DBG("tty %p dev %p", tty, dev);
 
@@ -1014,7 +1014,7 @@ static void rfcomm_tty_unthrottle(struct tty_struct *tty)
 
 static unsigned int rfcomm_tty_chars_in_buffer(struct tty_struct *tty)
 {
-	struct rfcomm_dev *dev = (struct rfcomm_dev *) tty->driver_data;
+	struct rfcomm_dev *dev = tty->driver_data;
 
 	BT_DBG("tty %p dev %p", tty, dev);
 
@@ -1029,7 +1029,7 @@ static unsigned int rfcomm_tty_chars_in_buffer(struct tty_struct *tty)
 
 static void rfcomm_tty_flush_buffer(struct tty_struct *tty)
 {
-	struct rfcomm_dev *dev = (struct rfcomm_dev *) tty->driver_data;
+	struct rfcomm_dev *dev = tty->driver_data;
 
 	BT_DBG("tty %p dev %p", tty, dev);
 
@@ -1052,7 +1052,7 @@ static void rfcomm_tty_wait_until_sent(struct tty_struct *tty, int timeout)
 
 static void rfcomm_tty_hangup(struct tty_struct *tty)
 {
-	struct rfcomm_dev *dev = (struct rfcomm_dev *) tty->driver_data;
+	struct rfcomm_dev *dev = tty->driver_data;
 
 	BT_DBG("tty %p dev %p", tty, dev);
 
@@ -1061,7 +1061,7 @@ static void rfcomm_tty_hangup(struct tty_struct *tty)
 
 static int rfcomm_tty_tiocmget(struct tty_struct *tty)
 {
-	struct rfcomm_dev *dev = (struct rfcomm_dev *) tty->driver_data;
+	struct rfcomm_dev *dev = tty->driver_data;
 
 	BT_DBG("tty %p dev %p", tty, dev);
 
@@ -1070,7 +1070,7 @@ static int rfcomm_tty_tiocmget(struct tty_struct *tty)
 
 static int rfcomm_tty_tiocmset(struct tty_struct *tty, unsigned int set, unsigned int clear)
 {
-	struct rfcomm_dev *dev = (struct rfcomm_dev *) tty->driver_data;
+	struct rfcomm_dev *dev = tty->driver_data;
 	struct rfcomm_dlc *dlc = dev->dlc;
 	u8 v24_sig;
 
-- 
2.41.0

