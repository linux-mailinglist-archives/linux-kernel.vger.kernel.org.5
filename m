Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28CCF777471
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234993AbjHJJ2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234225AbjHJJ2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:28:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF8C30ED;
        Thu, 10 Aug 2023 02:16:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21FE1654F0;
        Thu, 10 Aug 2023 09:16:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4906EC433C7;
        Thu, 10 Aug 2023 09:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691658995;
        bh=bnrsoGhE7/8YdxUdBJXDpgeuttOq6uFT0CqwRjobkl4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RtluJmJKgw6ivpn9rt46wrl+aWeLC7cBrbo9lS1FHLIj7ZXKX+JsBJPEDoXM66hd8
         +aH/Aq/r2ipMzOauyx8npaqyRhwxC+XKz1dZdxGUBQCH+7kvTkPSHiTLQZeBLeWqvN
         G/3zJ06OuHMbnWrEgF2UdeonT9BtgG7iAEUcyoC83cNSbOP14Zqa2PQM/e42Ma7/Z7
         +SJlqoBNfC5iVyH5lCAAljzGC9C4bcvkVy10U/vPuHVpDIDFO18jgQ9a63o65yYKYg
         Y6l/2iuNBT6/Tq38EhqLk6VKZriPxaXkCAycv4ETjAfcllKmVwPCxe5C9I6ziUhh1+
         xOER9mB65lGSw==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 33/36] tty: vcc: convert counts to size_t
Date:   Thu, 10 Aug 2023 11:15:07 +0200
Message-ID: <20230810091510.13006-34-jirislaby@kernel.org>
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

Unify the type of tty_operations::write() counters with the 'count'
parameter. I.e. use size_t for them.

This includes changing vcc_port::chars_in_buffer to size_t to keep min()
and avoid min_t().

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
---
 arch/sparc/include/asm/vio.h |  2 +-
 drivers/tty/vcc.c            | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/sparc/include/asm/vio.h b/arch/sparc/include/asm/vio.h
index 8a0c3c11c9ce..587fb7841096 100644
--- a/arch/sparc/include/asm/vio.h
+++ b/arch/sparc/include/asm/vio.h
@@ -284,7 +284,7 @@ struct vio_dring_state {
 	struct ldc_trans_cookie	cookies[VIO_MAX_RING_COOKIES];
 };
 
-#define VIO_TAG_SIZE		((int)sizeof(struct vio_msg_tag))
+#define VIO_TAG_SIZE		(sizeof(struct vio_msg_tag))
 #define VIO_VCC_MTU_SIZE	(LDC_PACKET_SIZE - VIO_TAG_SIZE)
 
 struct vio_vcc {
diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c
index 9cc569174c83..a39ed981bfd3 100644
--- a/drivers/tty/vcc.c
+++ b/drivers/tty/vcc.c
@@ -36,7 +36,7 @@ struct vcc_port {
 	 * and guarantee that any characters that the driver accepts will
 	 * be eventually sent, either immediately or later.
 	 */
-	int chars_in_buffer;
+	size_t chars_in_buffer;
 	struct vio_vcc buffer;
 
 	struct timer_list rx_timer;
@@ -385,7 +385,7 @@ static void vcc_tx_timer(struct timer_list *t)
 	struct vcc_port *port = from_timer(port, t, tx_timer);
 	struct vio_vcc *pkt;
 	unsigned long flags;
-	int tosend = 0;
+	size_t tosend = 0;
 	int rv;
 
 	spin_lock_irqsave(&port->lock, flags);
@@ -809,8 +809,8 @@ static ssize_t vcc_write(struct tty_struct *tty, const u8 *buf, size_t count)
 	struct vcc_port *port;
 	struct vio_vcc *pkt;
 	unsigned long flags;
-	int total_sent = 0;
-	int tosend = 0;
+	size_t total_sent = 0;
+	size_t tosend = 0;
 	int rv = -EINVAL;
 
 	port = vcc_get_ne(tty->index);
@@ -847,7 +847,7 @@ static ssize_t vcc_write(struct tty_struct *tty, const u8 *buf, size_t count)
 		 * hypervisor actually took it because we have it buffered.
 		 */
 		rv = ldc_write(port->vio.lp, pkt, (VIO_TAG_SIZE + tosend));
-		vccdbg("VCC: write: ldc_write(%d)=%d\n",
+		vccdbg("VCC: write: ldc_write(%zu)=%d\n",
 		       (VIO_TAG_SIZE + tosend), rv);
 
 		total_sent += tosend;
@@ -864,7 +864,7 @@ static ssize_t vcc_write(struct tty_struct *tty, const u8 *buf, size_t count)
 
 	vcc_put(port, false);
 
-	vccdbg("VCC: write: total=%d rv=%d", total_sent, rv);
+	vccdbg("VCC: write: total=%zu rv=%d", total_sent, rv);
 
 	return total_sent ? total_sent : rv;
 }
-- 
2.41.0

