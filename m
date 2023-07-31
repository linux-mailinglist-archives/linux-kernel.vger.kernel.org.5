Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4485768F91
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbjGaIFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbjGaIET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:04:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CD4269D;
        Mon, 31 Jul 2023 01:02:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2101060F78;
        Mon, 31 Jul 2023 08:02:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1509FC433C9;
        Mon, 31 Jul 2023 08:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690790574;
        bh=w3zM+yrYXpgkmIfhHdq6oR6kOfQGs28UkmPFxSAMjzY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mlBTAlXEYvnrKw+rnkk64Ny16BNI5CFUXkoWxTIm9o2vopncA27bmBEf3aaf4/NzG
         fCWedJkUbWt2tBE6EtlDgiEnm18UYa5en7G8C9j27TZOPkl1Q/bHnntBds0RMAwTUk
         6k2D1EF6SeKGa6xdNJfjXZr7eIfi4Esj9SnsQVthYExQpDdGL98vrSducz/rlXlIKq
         8GOM2tFaFwokemSZBrHWoJeAVCEQ4Oud77p7XN7QQ/+XOJkEPQ5dSSRkhU5nIi87hN
         G8vgJQ3u8T4Y3rF/1zJbjaUeiteVdY8RLuKcBgQLR4ua0+2t3lW+uDnL9K83DXg0bc
         Lrrcs+P6TeRgw==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Subject: [PATCH 04/10] input: serport: remove casts from tty->disc_data
Date:   Mon, 31 Jul 2023 10:02:38 +0200
Message-ID: <20230731080244.2698-5-jirislaby@kernel.org>
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

tty->disc_data is 'void *', so there is no need to cast from that.
Therefore remove the casts and assign the pointer directly.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
---
 drivers/input/serio/serport.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/input/serio/serport.c b/drivers/input/serio/serport.c
index 7f7ef0e3a749..a5d8953f5904 100644
--- a/drivers/input/serio/serport.c
+++ b/drivers/input/serio/serport.c
@@ -103,7 +103,7 @@ static int serport_ldisc_open(struct tty_struct *tty)
 
 static void serport_ldisc_close(struct tty_struct *tty)
 {
-	struct serport *serport = (struct serport *) tty->disc_data;
+	struct serport *serport = tty->disc_data;
 
 	kfree(serport);
 }
@@ -117,7 +117,7 @@ static void serport_ldisc_close(struct tty_struct *tty)
 static void serport_ldisc_receive(struct tty_struct *tty,
 		const unsigned char *cp, const char *fp, int count)
 {
-	struct serport *serport = (struct serport*) tty->disc_data;
+	struct serport *serport = tty->disc_data;
 	unsigned long flags;
 	unsigned int ch_flags = 0;
 	int i;
@@ -161,7 +161,7 @@ static ssize_t serport_ldisc_read(struct tty_struct * tty, struct file * file,
 				  unsigned char *kbuf, size_t nr,
 				  void **cookie, unsigned long offset)
 {
-	struct serport *serport = (struct serport*) tty->disc_data;
+	struct serport *serport = tty->disc_data;
 	struct serio *serio;
 
 	if (test_and_set_bit(SERPORT_BUSY, &serport->flags))
@@ -245,7 +245,7 @@ static int serport_ldisc_compat_ioctl(struct tty_struct *tty,
 
 static void serport_ldisc_hangup(struct tty_struct *tty)
 {
-	struct serport *serport = (struct serport *) tty->disc_data;
+	struct serport *serport = tty->disc_data;
 	unsigned long flags;
 
 	spin_lock_irqsave(&serport->lock, flags);
@@ -257,7 +257,7 @@ static void serport_ldisc_hangup(struct tty_struct *tty)
 
 static void serport_ldisc_write_wakeup(struct tty_struct * tty)
 {
-	struct serport *serport = (struct serport *) tty->disc_data;
+	struct serport *serport = tty->disc_data;
 	unsigned long flags;
 
 	spin_lock_irqsave(&serport->lock, flags);
-- 
2.41.0

