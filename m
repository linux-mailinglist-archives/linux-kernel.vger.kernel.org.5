Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1F0789BD9
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 09:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjH0HnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 03:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjH0HmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 03:42:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA4EF4;
        Sun, 27 Aug 2023 00:42:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9A6060FC9;
        Sun, 27 Aug 2023 07:42:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D9F3C433C7;
        Sun, 27 Aug 2023 07:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693122121;
        bh=UPP1F3AsoDhSyC4YTKa+HgIocJf1wBb278Az2y/3Rl4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h6iI0rKksbWmCyHGUbFA8gIm7zM9LDp7wCiA44Bju7JRmZXgJYmd0kjCHIdGfpABh
         xQ9f+DYAEyddEd+imBFjQ0oonH9bcInc531hou75rL3mnH73zFA5v7nrJ9jwLGBlCn
         kMIpQ3R8sbBoIhdhkkY88RJUXWNCHPxHWJJAnThk0Adrd4ven2auAY8Q4FkUdNSiLb
         UF9x25Md2ClnaCo+J+K1rqtUwbIhqDl2TEjao0YzzdZkHpbLey9CdGLRDusnSSBitP
         07CDpH/fyEQEg33RfW5t4fuQzfcVkm/+6gG2+eOI2AEOpKCUOIA2WCEe9+aLgUmeZL
         TEuHoELk8l/eA==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH v2 07/14] tty: n_tty: move canon handling to a separate function
Date:   Sun, 27 Aug 2023 09:41:40 +0200
Message-ID: <20230827074147.2287-8-jirislaby@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230827074147.2287-1-jirislaby@kernel.org>
References: <20230827074147.2287-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

n_tty_receive_char_special() is already complicated enough. Split the
canon handling to a separate function: n_tty_receive_char_canon().

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/n_tty.c | 158 ++++++++++++++++++++++++--------------------
 1 file changed, 87 insertions(+), 71 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 07b6a013b5ab..0149dc9dd0b1 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1262,6 +1262,91 @@ static bool n_tty_receive_char_flow_ctrl(struct tty_struct *tty, unsigned char c
 	return true;
 }
 
+static bool n_tty_receive_char_canon(struct tty_struct *tty, u8 c)
+{
+	struct n_tty_data *ldata = tty->disc_data;
+
+	if (c == ERASE_CHAR(tty) || c == KILL_CHAR(tty) ||
+	    (c == WERASE_CHAR(tty) && L_IEXTEN(tty))) {
+		eraser(c, tty);
+		commit_echoes(tty);
+
+		return true;
+	}
+
+	if (c == LNEXT_CHAR(tty) && L_IEXTEN(tty)) {
+		ldata->lnext = 1;
+		if (L_ECHO(tty)) {
+			finish_erasing(ldata);
+			if (L_ECHOCTL(tty)) {
+				echo_char_raw('^', ldata);
+				echo_char_raw('\b', ldata);
+				commit_echoes(tty);
+			}
+		}
+
+		return true;
+	}
+
+	if (c == REPRINT_CHAR(tty) && L_ECHO(tty) && L_IEXTEN(tty)) {
+		size_t tail = ldata->canon_head;
+
+		finish_erasing(ldata);
+		echo_char(c, tty);
+		echo_char_raw('\n', ldata);
+		while (MASK(tail) != MASK(ldata->read_head)) {
+			echo_char(read_buf(ldata, tail), tty);
+			tail++;
+		}
+		commit_echoes(tty);
+
+		return true;
+	}
+
+	if (c == '\n') {
+		if (L_ECHO(tty) || L_ECHONL(tty)) {
+			echo_char_raw('\n', ldata);
+			commit_echoes(tty);
+		}
+		goto handle_newline;
+	}
+
+	if (c == EOF_CHAR(tty)) {
+		c = __DISABLED_CHAR;
+		goto handle_newline;
+	}
+
+	if ((c == EOL_CHAR(tty)) ||
+	    (c == EOL2_CHAR(tty) && L_IEXTEN(tty))) {
+		/*
+		 * XXX are EOL_CHAR and EOL2_CHAR echoed?!?
+		 */
+		if (L_ECHO(tty)) {
+			/* Record the column of first canon char. */
+			if (ldata->canon_head == ldata->read_head)
+				echo_set_canon_col(ldata);
+			echo_char(c, tty);
+			commit_echoes(tty);
+		}
+		/*
+		 * XXX does PARMRK doubling happen for
+		 * EOL_CHAR and EOL2_CHAR?
+		 */
+		if (c == (unsigned char) '\377' && I_PARMRK(tty))
+			put_tty_queue(c, ldata);
+
+handle_newline:
+		set_bit(MASK(ldata->read_head), ldata->read_flags);
+		put_tty_queue(c, ldata);
+		smp_store_release(&ldata->canon_head, ldata->read_head);
+		kill_fasync(&tty->fasync, SIGIO, POLL_IN);
+		wake_up_interruptible_poll(&tty->read_wait, EPOLLIN | EPOLLRDNORM);
+		return true;
+	}
+
+	return false;
+}
+
 static void n_tty_receive_char_special(struct tty_struct *tty, unsigned char c,
 				       bool lookahead_done)
 {
@@ -1296,77 +1381,8 @@ static void n_tty_receive_char_special(struct tty_struct *tty, unsigned char c,
 	} else if (c == '\n' && I_INLCR(tty))
 		c = '\r';
 
-	if (ldata->icanon) {
-		if (c == ERASE_CHAR(tty) || c == KILL_CHAR(tty) ||
-		    (c == WERASE_CHAR(tty) && L_IEXTEN(tty))) {
-			eraser(c, tty);
-			commit_echoes(tty);
-			return;
-		}
-		if (c == LNEXT_CHAR(tty) && L_IEXTEN(tty)) {
-			ldata->lnext = 1;
-			if (L_ECHO(tty)) {
-				finish_erasing(ldata);
-				if (L_ECHOCTL(tty)) {
-					echo_char_raw('^', ldata);
-					echo_char_raw('\b', ldata);
-					commit_echoes(tty);
-				}
-			}
-			return;
-		}
-		if (c == REPRINT_CHAR(tty) && L_ECHO(tty) && L_IEXTEN(tty)) {
-			size_t tail = ldata->canon_head;
-
-			finish_erasing(ldata);
-			echo_char(c, tty);
-			echo_char_raw('\n', ldata);
-			while (MASK(tail) != MASK(ldata->read_head)) {
-				echo_char(read_buf(ldata, tail), tty);
-				tail++;
-			}
-			commit_echoes(tty);
-			return;
-		}
-		if (c == '\n') {
-			if (L_ECHO(tty) || L_ECHONL(tty)) {
-				echo_char_raw('\n', ldata);
-				commit_echoes(tty);
-			}
-			goto handle_newline;
-		}
-		if (c == EOF_CHAR(tty)) {
-			c = __DISABLED_CHAR;
-			goto handle_newline;
-		}
-		if ((c == EOL_CHAR(tty)) ||
-		    (c == EOL2_CHAR(tty) && L_IEXTEN(tty))) {
-			/*
-			 * XXX are EOL_CHAR and EOL2_CHAR echoed?!?
-			 */
-			if (L_ECHO(tty)) {
-				/* Record the column of first canon char. */
-				if (ldata->canon_head == ldata->read_head)
-					echo_set_canon_col(ldata);
-				echo_char(c, tty);
-				commit_echoes(tty);
-			}
-			/*
-			 * XXX does PARMRK doubling happen for
-			 * EOL_CHAR and EOL2_CHAR?
-			 */
-			if (c == (unsigned char) '\377' && I_PARMRK(tty))
-				put_tty_queue(c, ldata);
-
-handle_newline:
-			set_bit(MASK(ldata->read_head), ldata->read_flags);
-			put_tty_queue(c, ldata);
-			smp_store_release(&ldata->canon_head, ldata->read_head);
-			kill_fasync(&tty->fasync, SIGIO, POLL_IN);
-			wake_up_interruptible_poll(&tty->read_wait, EPOLLIN | EPOLLRDNORM);
-			return;
-		}
-	}
+	if (ldata->icanon && n_tty_receive_char_canon(tty, c))
+		return;
 
 	if (L_ECHO(tty)) {
 		finish_erasing(ldata);
-- 
2.42.0

