Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0339B8068C2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 08:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377095AbjLFHjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 02:39:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235240AbjLFHim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 02:38:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368A210F0
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 23:38:03 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE21DC43397;
        Wed,  6 Dec 2023 07:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701848279;
        bh=l5iN5w+Qmzs518Y0sHzrhIhEOFTWt8IKcNzWere7ujs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KMB/hg4vc99E3LPXhipYInLEwv756k+4acAyRvlgOyp7K+2MwUqdj5ijXC5Jd2FTk
         LolnDSwT7/SLuC54yJ1USxMMKpYHWOGU0fQH1cdfeFA3EoHVwsJkfsQeY4QnsQYryN
         Cj40z6Ejac+7sDp+EV4NiWA/egZ+50VfPkRt3ealLf6ZsuYewnNT1cKIrI8CVZo5PR
         S6+Cmrvqg+PZ4qVVVGri5UpQ41POlA0ciY6AvR+uL4knwJ8KfKiWsFyjAsaf6dqvM5
         TiFb244I5413Jk6p0Iz7SyXz78awwr4AKWiQo5EFFSqSx9Cu0oygGrPpz8Du1IGxFK
         UDXpeVs+OCBcg==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 20/27] tty: n_hdlc: convert to u8 and size_t
Date:   Wed,  6 Dec 2023 08:37:05 +0100
Message-ID: <20231206073712.17776-21-jirislaby@kernel.org>
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

Note u8 is already both passed in and expected on output.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/n_hdlc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
index a670419efe79..1615f074ab86 100644
--- a/drivers/tty/n_hdlc.c
+++ b/drivers/tty/n_hdlc.c
@@ -109,8 +109,8 @@
 
 struct n_hdlc_buf {
 	struct list_head  list_item;
-	int		  count;
-	char		  buf[];
+	size_t		  count;
+	u8		  buf[];
 };
 
 struct n_hdlc_buf_list {
@@ -263,9 +263,9 @@ static int n_hdlc_tty_open(struct tty_struct *tty)
  */
 static void n_hdlc_send_frames(struct n_hdlc *n_hdlc, struct tty_struct *tty)
 {
-	register int actual;
 	unsigned long flags;
 	struct n_hdlc_buf *tbuf;
+	ssize_t actual;
 
 check_again:
 
@@ -281,7 +281,7 @@ static void n_hdlc_send_frames(struct n_hdlc *n_hdlc, struct tty_struct *tty)
 
 	tbuf = n_hdlc_buf_get(&n_hdlc->tx_buf_list);
 	while (tbuf) {
-		pr_debug("sending frame %p, count=%d\n", tbuf, tbuf->count);
+		pr_debug("sending frame %p, count=%zu\n", tbuf, tbuf->count);
 
 		/* Send the next block of data to device */
 		set_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
@@ -521,9 +521,9 @@ static ssize_t n_hdlc_tty_write(struct tty_struct *tty, struct file *file,
 				const u8 *data, size_t count)
 {
 	struct n_hdlc *n_hdlc = tty->disc_data;
-	int error = 0;
 	DECLARE_WAITQUEUE(wait, current);
 	struct n_hdlc_buf *tbuf;
+	ssize_t error = 0;
 
 	pr_debug("%s() called count=%zd\n", __func__, count);
 
-- 
2.43.0

