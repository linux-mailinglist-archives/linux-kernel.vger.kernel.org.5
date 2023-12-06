Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131DC8068B9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 08:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376643AbjLFHip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 02:38:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjLFHiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 02:38:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE1D1BC8
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 23:37:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BA71C433C7;
        Wed,  6 Dec 2023 07:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701848268;
        bh=0jDTkca+DoCNT4GBW0SaHvJh6RK6c14dHl2xTDM0lig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bN4zps1VD14WaQ7L+ufCWjTlw7qYPRgdosdPmuF09qDmDabVcxBfBql5PfmRlNf04
         acw8RjjRDLADlERmXTH33hG0KFUYN3Ud+D83B7WzaSZxzwxaPe7lzxamEwECIL6rWo
         UGQOfo/WgWHqi8mzdueDhb69q7nMF11EQ4D9eCpTqd7++hRMXwxI+QR02HastM8vdi
         YUjFzsUkoCGYz1Zua5hORZfqrlsKtduoDb0cAwujsSdND7nm88zNemME1jLsGf4+9a
         cN7gQtcoC5kafJNT2l0VO+eSoxiAR2eSVFfKzIP0HBqRW+YG73/X1RJx9h3zghZPag
         GC+G1rowjVVEA==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Jens Taprogge <jens.taprogge@taprogge.org>,
        industrypack-devel@lists.sourceforge.net
Subject: [PATCH 13/27] tty: ipoctal: convert to u8 and size_t
Date:   Wed,  6 Dec 2023 08:36:58 +0100
Message-ID: <20231206073712.17776-14-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231206073712.17776-1-jirislaby@kernel.org>
References: <20231206073712.17776-1-jirislaby@kernel.org>
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

Switch character types to u8 and sizes to size_t. To conform to
characters/sizes in the rest of the tty layer.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Vaibhav Gupta <vaibhavgupta40@gmail.com>
Cc: Jens Taprogge <jens.taprogge@taprogge.org>
Cc: industrypack-devel@lists.sourceforge.net
---
 drivers/ipack/devices/ipoctal.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/ipack/devices/ipoctal.c b/drivers/ipack/devices/ipoctal.c
index da308be6c487..ba2e9e52d72b 100644
--- a/drivers/ipack/devices/ipoctal.c
+++ b/drivers/ipack/devices/ipoctal.c
@@ -158,9 +158,7 @@ static int ipoctal_get_icount(struct tty_struct *tty,
 static void ipoctal_irq_rx(struct ipoctal_channel *channel, u8 sr)
 {
 	struct tty_port *port = &channel->tty_port;
-	unsigned char value;
-	unsigned char flag;
-	u8 isr;
+	u8 isr, value, flag;
 
 	do {
 		value = ioread8(&channel->regs->r.rhr);
@@ -202,8 +200,8 @@ static void ipoctal_irq_rx(struct ipoctal_channel *channel, u8 sr)
 
 static void ipoctal_irq_tx(struct ipoctal_channel *channel)
 {
-	unsigned char value;
 	unsigned int *pointer_write = &channel->pointer_write;
+	u8 value;
 
 	if (channel->nb_bytes == 0)
 		return;
@@ -436,11 +434,11 @@ static int ipoctal_inst_slot(struct ipoctal *ipoctal, unsigned int bus_nr,
 	return res;
 }
 
-static inline int ipoctal_copy_write_buffer(struct ipoctal_channel *channel,
-					    const u8 *buf, int count)
+static inline size_t ipoctal_copy_write_buffer(struct ipoctal_channel *channel,
+					       const u8 *buf, size_t count)
 {
 	unsigned long flags;
-	int i;
+	size_t i;
 	unsigned int *pointer_read = &channel->pointer_read;
 
 	/* Copy the bytes from the user buffer to the internal one */
@@ -462,7 +460,7 @@ static ssize_t ipoctal_write_tty(struct tty_struct *tty, const u8 *buf,
 				 size_t count)
 {
 	struct ipoctal_channel *channel = tty->driver_data;
-	unsigned int char_copied;
+	size_t char_copied;
 
 	char_copied = ipoctal_copy_write_buffer(channel, buf, count);
 
-- 
2.43.0

