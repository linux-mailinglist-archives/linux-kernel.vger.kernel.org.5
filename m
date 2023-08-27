Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8A3789BE5
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 09:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjH0Hnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 03:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjH0HmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 03:42:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F2EF4;
        Sun, 27 Aug 2023 00:42:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BBD4F60B41;
        Sun, 27 Aug 2023 07:42:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25FA6C433CA;
        Sun, 27 Aug 2023 07:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693122130;
        bh=jX9aHUSm9nTvHXnHEHmBe0tcNjSA8sOFEuNsmzdQNwo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J+soQlmd+OabFixLvWTQudHl+CQlsaqR4V6E6Zb4MbbsknyizMuLhoR8CzFsz5zzJ
         xRpbra7jyZckgelcSxbQKw1kC1HNO1faFPpGLBKf+It35YzUWXeVaIDpwuD7gMBn19
         E0tgrfiayfIOTUMK6P6yV7QTtHt4seHL6+whAxIsLyjj5Lz9X0YpxOLW9rh9sS44kP
         BBiqrCNdd0FFTaIbrsACp9QcNz7NJQqfblbTmUrtReXsSolqReGSoLkwrzv1efgjpN
         u6owlneeetVb3EJ65BMXM9134jVQbfaPDqV4Ma/N5aGIRIHNDFkCblAV7tEo9IdudC
         HqICQyNqPu7Eg==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH v2 13/14] tty: n_tty: extract ECHO_OP processing to a separate function
Date:   Sun, 27 Aug 2023 09:41:46 +0200
Message-ID: <20230827074147.2287-14-jirislaby@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230827074147.2287-1-jirislaby@kernel.org>
References: <20230827074147.2287-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__process_echoes() contains ECHO_OPs processing. It is stuffed in a
while loop and the whole function is barely readable. Separate it to a
new function: n_tty_process_echo_ops().

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/n_tty.c | 194 ++++++++++++++++++++++----------------------
 1 file changed, 98 insertions(+), 96 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index bd6cd28f734f..edf59f6fc669 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -582,6 +582,100 @@ static ssize_t process_output_block(struct tty_struct *tty,
 	return i;
 }
 
+static int n_tty_process_echo_ops(struct tty_struct *tty, size_t *tail,
+				  int space)
+{
+	struct n_tty_data *ldata = tty->disc_data;
+	u8 op;
+
+	/*
+	 * Since add_echo_byte() is called without holding output_lock, we
+	 * might see only portion of multi-byte operation.
+	 */
+	if (MASK(ldata->echo_commit) == MASK(*tail + 1))
+		return -ENODATA;
+
+	/*
+	 * If the buffer byte is the start of a multi-byte operation, get the
+	 * next byte, which is either the op code or a control character value.
+	 */
+	op = echo_buf(ldata, *tail + 1);
+
+	switch (op) {
+	case ECHO_OP_ERASE_TAB: {
+		unsigned int num_chars, num_bs;
+
+		if (MASK(ldata->echo_commit) == MASK(*tail + 2))
+			return -ENODATA;
+
+		num_chars = echo_buf(ldata, *tail + 2);
+
+		/*
+		 * Determine how many columns to go back in order to erase the
+		 * tab. This depends on the number of columns used by other
+		 * characters within the tab area. If this (modulo 8) count is
+		 * from the start of input rather than from a previous tab, we
+		 * offset by canon column. Otherwise, tab spacing is normal.
+		 */
+		if (!(num_chars & 0x80))
+			num_chars += ldata->canon_column;
+		num_bs = 8 - (num_chars & 7);
+
+		if (num_bs > space)
+			return -ENOSPC;
+
+		space -= num_bs;
+		while (num_bs--) {
+			tty_put_char(tty, '\b');
+			if (ldata->column > 0)
+				ldata->column--;
+		}
+		*tail += 3;
+		break;
+	}
+	case ECHO_OP_SET_CANON_COL:
+		ldata->canon_column = ldata->column;
+		*tail += 2;
+		break;
+
+	case ECHO_OP_MOVE_BACK_COL:
+		if (ldata->column > 0)
+			ldata->column--;
+		*tail += 2;
+		break;
+
+	case ECHO_OP_START:
+		/* This is an escaped echo op start code */
+		if (!space)
+			return -ENOSPC;
+
+		tty_put_char(tty, ECHO_OP_START);
+		ldata->column++;
+		space--;
+		*tail += 2;
+		break;
+
+	default:
+		/*
+		 * If the op is not a special byte code, it is a ctrl char
+		 * tagged to be echoed as "^X" (where X is the letter
+		 * representing the control char). Note that we must ensure
+		 * there is enough space for the whole ctrl pair.
+		 */
+		if (space < 2)
+			return -ENOSPC;
+
+		tty_put_char(tty, '^');
+		tty_put_char(tty, op ^ 0100);
+		ldata->column += 2;
+		space -= 2;
+		*tail += 2;
+		break;
+	}
+
+	return space;
+}
+
 /**
  * __process_echoes	-	write pending echo characters
  * @tty: terminal device
@@ -617,104 +711,12 @@ static size_t __process_echoes(struct tty_struct *tty)
 	while (MASK(ldata->echo_commit) != MASK(tail)) {
 		c = echo_buf(ldata, tail);
 		if (c == ECHO_OP_START) {
-			u8 op;
-			bool space_left = true;
-
-			/*
-			 * Since add_echo_byte() is called without holding
-			 * output_lock, we might see only portion of multi-byte
-			 * operation.
-			 */
-			if (MASK(ldata->echo_commit) == MASK(tail + 1))
+			int ret = n_tty_process_echo_ops(tty, &tail, space);
+			if (ret == -ENODATA)
 				goto not_yet_stored;
-			/*
-			 * If the buffer byte is the start of a multi-byte
-			 * operation, get the next byte, which is either the
-			 * op code or a control character value.
-			 */
-			op = echo_buf(ldata, tail + 1);
-
-			switch (op) {
-			case ECHO_OP_ERASE_TAB: {
-				unsigned int num_chars, num_bs;
-
-				if (MASK(ldata->echo_commit) == MASK(tail + 2))
-					goto not_yet_stored;
-				num_chars = echo_buf(ldata, tail + 2);
-
-				/*
-				 * Determine how many columns to go back
-				 * in order to erase the tab.
-				 * This depends on the number of columns
-				 * used by other characters within the tab
-				 * area.  If this (modulo 8) count is from
-				 * the start of input rather than from a
-				 * previous tab, we offset by canon column.
-				 * Otherwise, tab spacing is normal.
-				 */
-				if (!(num_chars & 0x80))
-					num_chars += ldata->canon_column;
-				num_bs = 8 - (num_chars & 7);
-
-				if (num_bs > space) {
-					space_left = false;
-					break;
-				}
-				space -= num_bs;
-				while (num_bs--) {
-					tty_put_char(tty, '\b');
-					if (ldata->column > 0)
-						ldata->column--;
-				}
-				tail += 3;
-				break;
-			}
-			case ECHO_OP_SET_CANON_COL:
-				ldata->canon_column = ldata->column;
-				tail += 2;
-				break;
-
-			case ECHO_OP_MOVE_BACK_COL:
-				if (ldata->column > 0)
-					ldata->column--;
-				tail += 2;
-				break;
-
-			case ECHO_OP_START:
-				/* This is an escaped echo op start code */
-				if (!space) {
-					space_left = false;
-					break;
-				}
-				tty_put_char(tty, ECHO_OP_START);
-				ldata->column++;
-				space--;
-				tail += 2;
-				break;
-
-			default:
-				/*
-				 * If the op is not a special byte code,
-				 * it is a ctrl char tagged to be echoed
-				 * as "^X" (where X is the letter
-				 * representing the control char).
-				 * Note that we must ensure there is
-				 * enough space for the whole ctrl pair.
-				 *
-				 */
-				if (space < 2) {
-					space_left = false;
-					break;
-				}
-				tty_put_char(tty, '^');
-				tty_put_char(tty, op ^ 0100);
-				ldata->column += 2;
-				space -= 2;
-				tail += 2;
-			}
-
-			if (!space_left)
+			if (ret < 0)
 				break;
+			space = ret;
 		} else {
 			if (O_OPOST(tty)) {
 				int retval = do_output_char(c, tty, space);
-- 
2.42.0

