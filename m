Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F1477DFE3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 13:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244388AbjHPLAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 07:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244391AbjHPLAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 07:00:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4642D6B;
        Wed, 16 Aug 2023 03:59:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0443D665E0;
        Wed, 16 Aug 2023 10:58:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5805EC433C8;
        Wed, 16 Aug 2023 10:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692183522;
        bh=a18DAd2O+Ntjms6YOLNrKnYz9YereskZXRqhxKQrNgo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qPujYQe6FLaM0F8DYuJ2dozF5tYFbdAhGvzFaneHvFPvqNHC8fFHlWsFZXfFM2PSN
         PnFLQq8pjEyQ8IE7tmsD6a+u6Y2EoEPcYjE70F2pD756R/RimAXzgz92qh2fQXYdP4
         mRRrlW3uT3O09Q8qCWMANZkfzOfbqncz4W+cczzAMTtl8uZJf0ojXFq4u5u0zcynf9
         oPpDcraOMHKSqMQ8oyWY+NaHwzI4tr/euw1kwTyqvgYFmlonBhU74Trc18eM5eUZhb
         IEvFRkPSyFl03roLQzF2HwvWN+Ofqmlv3acQRKnhL5B9WOdgq3agz82bo1Qliu1ypJ
         /UdsjsPyrrjsA==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 07/14] tty: n_tty: move canon handling to a separate function
Date:   Wed, 16 Aug 2023 12:58:15 +0200
Message-ID: <20230816105822.3685-12-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816105822.3685-1-jirislaby@kernel.org>
References: <20230816105822.3685-1-jirislaby@kernel.org>
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
index 9e0ef5294b52..ae80d57c9f97 100644
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
2.41.0

