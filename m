Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCED777446
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234978AbjHJJTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234783AbjHJJSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:18:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F2F47EA;
        Thu, 10 Aug 2023 02:16:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F9BD654DA;
        Thu, 10 Aug 2023 09:16:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1808C433C9;
        Thu, 10 Aug 2023 09:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691658999;
        bh=7m3JsfPMLiKgFfQV74GNsNXjJ2VCRfWCFVK3pJRiZ3Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DG6xWzEwT7xF96/U2407avRLJMGIPoz80XMbZrmyx+9d5u3h3o8q4hXBs0ypGm2hn
         79QEOuzO7vfVgAPlK3/AcLRrjafrRCGnzXgZdw+YnRzG2leCYCwX+KbRCEZRO2xNiC
         Wr911rl2+YUbqX7LNo5CzdJ0aV4fZiY+jZmTtugVhTV6l8FBoB0uTk7nE0TdGYcM8i
         zH0pz5WbQ0F+NLwWGYMFrDJDixTxGl1FI3yg15sjv5ye2HF8Sy2I196fgYylcM2IIY
         x7Z8RqPaRj7awBQZ3UjS7xxdKvxheIOPP3u9n1mO3SNe38RQBhI0jmWwBwSB1mFMfe
         wEduW9x+IblfA==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 35/36] tty: hso: simplify hso_serial_write()
Date:   Thu, 10 Aug 2023 11:15:09 +0200
Message-ID: <20230810091510.13006-36-jirislaby@kernel.org>
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

There is no need for two more variables in hso_serial_write(). Switch to
min_t() and eliminate those.

Furthermore, the 'if-goto' is superfluous as memcpy() of zero count is a
nop. So is addition of zero. So remove the 'if-goto' completely.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
---
 drivers/net/usb/hso.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/net/usb/hso.c b/drivers/net/usb/hso.c
index 3f424da87bf4..83b8452220ec 100644
--- a/drivers/net/usb/hso.c
+++ b/drivers/net/usb/hso.c
@@ -1326,7 +1326,6 @@ static ssize_t hso_serial_write(struct tty_struct *tty, const u8 *buf,
 				size_t count)
 {
 	struct hso_serial *serial = tty->driver_data;
-	int space, tx_bytes;
 	unsigned long flags;
 
 	/* sanity check */
@@ -1337,21 +1336,16 @@ static ssize_t hso_serial_write(struct tty_struct *tty, const u8 *buf,
 
 	spin_lock_irqsave(&serial->serial_lock, flags);
 
-	space = serial->tx_data_length - serial->tx_buffer_count;
-	tx_bytes = (count < space) ? count : space;
+	count = min_t(size_t, serial->tx_data_length - serial->tx_buffer_count,
+		      count);
+	memcpy(serial->tx_buffer + serial->tx_buffer_count, buf, count);
+	serial->tx_buffer_count += count;
 
-	if (!tx_bytes)
-		goto out;
-
-	memcpy(serial->tx_buffer + serial->tx_buffer_count, buf, tx_bytes);
-	serial->tx_buffer_count += tx_bytes;
-
-out:
 	spin_unlock_irqrestore(&serial->serial_lock, flags);
 
 	hso_kick_transmit(serial);
 	/* done */
-	return tx_bytes;
+	return count;
 }
 
 /* how much room is there for writing */
-- 
2.41.0

