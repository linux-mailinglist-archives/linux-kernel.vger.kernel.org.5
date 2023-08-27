Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA0A789BDD
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 09:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjH0Hn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 03:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjH0HmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 03:42:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DC5F4;
        Sun, 27 Aug 2023 00:42:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C735E61CA0;
        Sun, 27 Aug 2023 07:42:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28934C433C9;
        Sun, 27 Aug 2023 07:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693122127;
        bh=63LcCuzG5n4Fcz6e1TjSCi8/ZXp3+7GT2s2UYtM/GHw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VtHiLTge2oBH8fjOWD4/Ef289LtCFhzr01fT1kjXF4dfj+iQoKBEBNj/ymoYW70bk
         ra3g5ekSbgdlcXscpZmzM5IczXMltkQS2P809iSZyD6QHDQL4P5SLCJaUp5CE8r1dw
         jDJLhIpl49Z3wNsp2/KHzQEYZKM1+EdZ7e5CVMa4S9FUnkI75OIEhHHh1+cHIXoEt7
         Qkk7fRjXPKEGIT5V8otbaE2Xa82KKtNMTHNbDqKg9FDO3DBVAfm6ORHrjor+UnatG5
         fEqfEYKgwORWssAKwk9IMxWBg8E3gkLzLYZcThnbAVcgr74PWBwhNKbOVc+Btm/e1E
         9Q+27kRAT+9Bw==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH v2 11/14] tty: n_tty: use u8 for chars and flags
Date:   Sun, 27 Aug 2023 09:41:44 +0200
Message-ID: <20230827074147.2287-12-jirislaby@kernel.org>
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

Unify with the tty layer and use u8 for both chars and flags.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/n_tty.c | 72 ++++++++++++++++++++++-----------------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index e722065b2db4..cf42b8b4ad2e 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -109,9 +109,9 @@ struct n_tty_data {
 	unsigned char push:1;
 
 	/* shared by producer and consumer */
-	char read_buf[N_TTY_BUF_SIZE];
+	u8 read_buf[N_TTY_BUF_SIZE];
 	DECLARE_BITMAP(read_flags, N_TTY_BUF_SIZE);
-	unsigned char echo_buf[N_TTY_BUF_SIZE];
+	u8 echo_buf[N_TTY_BUF_SIZE];
 
 	/* consumer-published */
 	size_t read_tail;
@@ -136,23 +136,23 @@ static inline size_t read_cnt(struct n_tty_data *ldata)
 	return ldata->read_head - ldata->read_tail;
 }
 
-static inline unsigned char read_buf(struct n_tty_data *ldata, size_t i)
+static inline u8 read_buf(struct n_tty_data *ldata, size_t i)
 {
 	return ldata->read_buf[MASK(i)];
 }
 
-static inline unsigned char *read_buf_addr(struct n_tty_data *ldata, size_t i)
+static inline u8 *read_buf_addr(struct n_tty_data *ldata, size_t i)
 {
 	return &ldata->read_buf[MASK(i)];
 }
 
-static inline unsigned char echo_buf(struct n_tty_data *ldata, size_t i)
+static inline u8 echo_buf(struct n_tty_data *ldata, size_t i)
 {
 	smp_rmb(); /* Matches smp_wmb() in add_echo_byte(). */
 	return ldata->echo_buf[MASK(i)];
 }
 
-static inline unsigned char *echo_buf_addr(struct n_tty_data *ldata, size_t i)
+static inline u8 *echo_buf_addr(struct n_tty_data *ldata, size_t i)
 {
 	return &ldata->echo_buf[MASK(i)];
 }
@@ -303,7 +303,7 @@ static void n_tty_check_unthrottle(struct tty_struct *tty)
  *  * n_tty_receive_buf()/producer path:
  *	caller holds non-exclusive %termios_rwsem
  */
-static inline void put_tty_queue(unsigned char c, struct n_tty_data *ldata)
+static inline void put_tty_queue(u8 c, struct n_tty_data *ldata)
 {
 	*read_buf_addr(ldata, ldata->read_head) = c;
 	ldata->read_head++;
@@ -377,7 +377,7 @@ static void n_tty_flush_buffer(struct tty_struct *tty)
  * character. We use this to correctly compute the on-screen size of the
  * character when printing.
  */
-static inline int is_utf8_continuation(unsigned char c)
+static inline int is_utf8_continuation(u8 c)
 {
 	return (c & 0xc0) == 0x80;
 }
@@ -390,7 +390,7 @@ static inline int is_utf8_continuation(unsigned char c)
  * Returns: true if the utf8 character @c is a multibyte continuation character
  * and the terminal is in unicode mode.
  */
-static inline int is_continuation(unsigned char c, const struct tty_struct *tty)
+static inline int is_continuation(u8 c, const struct tty_struct *tty)
 {
 	return I_IUTF8(tty) && is_utf8_continuation(c);
 }
@@ -414,7 +414,7 @@ static inline int is_continuation(unsigned char c, const struct tty_struct *tty)
  * Locking: should be called under the %output_lock to protect the column state
  * and space left in the buffer.
  */
-static int do_output_char(unsigned char c, struct tty_struct *tty, int space)
+static int do_output_char(u8 c, struct tty_struct *tty, int space)
 {
 	struct n_tty_data *ldata = tty->disc_data;
 	int	spaces;
@@ -488,7 +488,7 @@ static int do_output_char(unsigned char c, struct tty_struct *tty, int space)
  * Locking: %output_lock to protect column state and space left (also, this is
  *called from n_tty_write() under the tty layer write lock).
  */
-static int process_output(unsigned char c, struct tty_struct *tty)
+static int process_output(u8 c, struct tty_struct *tty)
 {
 	struct n_tty_data *ldata = tty->disc_data;
 	int	space, retval;
@@ -524,12 +524,12 @@ static int process_output(unsigned char c, struct tty_struct *tty)
  * called from n_tty_write() under the tty layer write lock).
  */
 static ssize_t process_output_block(struct tty_struct *tty,
-				    const unsigned char *buf, unsigned int nr)
+				    const u8 *buf, unsigned int nr)
 {
 	struct n_tty_data *ldata = tty->disc_data;
 	int	space;
 	int	i;
-	const unsigned char *cp;
+	const u8 *cp;
 
 	mutex_lock(&ldata->output_lock);
 
@@ -542,7 +542,7 @@ static ssize_t process_output_block(struct tty_struct *tty,
 		nr = space;
 
 	for (i = 0, cp = buf; i < nr; i++, cp++) {
-		unsigned char c = *cp;
+		u8 c = *cp;
 
 		switch (c) {
 		case '\n':
@@ -609,7 +609,7 @@ static size_t __process_echoes(struct tty_struct *tty)
 	struct n_tty_data *ldata = tty->disc_data;
 	int	space, old_space;
 	size_t tail;
-	unsigned char c;
+	u8 c;
 
 	old_space = space = tty_write_room(tty);
 
@@ -617,7 +617,7 @@ static size_t __process_echoes(struct tty_struct *tty)
 	while (MASK(ldata->echo_commit) != MASK(tail)) {
 		c = echo_buf(ldata, tail);
 		if (c == ECHO_OP_START) {
-			unsigned char op;
+			u8 op;
 			bool space_left = true;
 
 			/*
@@ -818,7 +818,7 @@ static void flush_echoes(struct tty_struct *tty)
  *
  * Add a character or operation byte to the echo buffer.
  */
-static inline void add_echo_byte(unsigned char c, struct n_tty_data *ldata)
+static inline void add_echo_byte(u8 c, struct n_tty_data *ldata)
 {
 	*echo_buf_addr(ldata, ldata->echo_head) = c;
 	smp_wmb(); /* Matches smp_rmb() in echo_buf(). */
@@ -889,7 +889,7 @@ static void echo_erase_tab(unsigned int num_chars, int after_tab,
  *
  * This variant does not treat control characters specially.
  */
-static void echo_char_raw(unsigned char c, struct n_tty_data *ldata)
+static void echo_char_raw(u8 c, struct n_tty_data *ldata)
 {
 	if (c == ECHO_OP_START) {
 		add_echo_byte(ECHO_OP_START, ldata);
@@ -910,7 +910,7 @@ static void echo_char_raw(unsigned char c, struct n_tty_data *ldata)
  * This variant tags control characters to be echoed as "^X" (where X is the
  * letter representing the control char).
  */
-static void echo_char(unsigned char c, const struct tty_struct *tty)
+static void echo_char(u8 c, const struct tty_struct *tty)
 {
 	struct n_tty_data *ldata = tty->disc_data;
 
@@ -948,7 +948,7 @@ static inline void finish_erasing(struct n_tty_data *ldata)
  * Locking: n_tty_receive_buf()/producer path:
  *	caller holds non-exclusive %termios_rwsem
  */
-static void eraser(unsigned char c, const struct tty_struct *tty)
+static void eraser(u8 c, const struct tty_struct *tty)
 {
 	struct n_tty_data *ldata = tty->disc_data;
 	enum { ERASE, WERASE, KILL } kill_type;
@@ -1188,7 +1188,7 @@ static void n_tty_receive_overrun(const struct tty_struct *tty)
  * 	caller holds non-exclusive %termios_rwsem
  */
 static void n_tty_receive_parity_error(const struct tty_struct *tty,
-				       unsigned char c)
+				       u8 c)
 {
 	struct n_tty_data *ldata = tty->disc_data;
 
@@ -1206,7 +1206,7 @@ static void n_tty_receive_parity_error(const struct tty_struct *tty,
 }
 
 static void
-n_tty_receive_signal_char(struct tty_struct *tty, int signal, unsigned char c)
+n_tty_receive_signal_char(struct tty_struct *tty, int signal, u8 c)
 {
 	isig(signal, tty);
 	if (I_IXON(tty))
@@ -1218,7 +1218,7 @@ n_tty_receive_signal_char(struct tty_struct *tty, int signal, unsigned char c)
 		process_echoes(tty);
 }
 
-static bool n_tty_is_char_flow_ctrl(struct tty_struct *tty, unsigned char c)
+static bool n_tty_is_char_flow_ctrl(struct tty_struct *tty, u8 c)
 {
 	return c == START_CHAR(tty) || c == STOP_CHAR(tty);
 }
@@ -1238,7 +1238,7 @@ static bool n_tty_is_char_flow_ctrl(struct tty_struct *tty, unsigned char c)
  * Returns true if @c is consumed as flow-control character, the character
  * must not be treated as normal character.
  */
-static bool n_tty_receive_char_flow_ctrl(struct tty_struct *tty, unsigned char c,
+static bool n_tty_receive_char_flow_ctrl(struct tty_struct *tty, u8 c,
 					 bool lookahead_done)
 {
 	if (!n_tty_is_char_flow_ctrl(tty, c))
@@ -1354,7 +1354,7 @@ static bool n_tty_receive_char_canon(struct tty_struct *tty, u8 c)
 	return false;
 }
 
-static void n_tty_receive_char_special(struct tty_struct *tty, unsigned char c,
+static void n_tty_receive_char_special(struct tty_struct *tty, u8 c,
 				       bool lookahead_done)
 {
 	struct n_tty_data *ldata = tty->disc_data;
@@ -1423,7 +1423,7 @@ static void n_tty_receive_char_special(struct tty_struct *tty, unsigned char c,
  *	caller holds non-exclusive %termios_rwsem
  *	publishes canon_head if canonical mode is active
  */
-static void n_tty_receive_char(struct tty_struct *tty, unsigned char c)
+static void n_tty_receive_char(struct tty_struct *tty, u8 c)
 {
 	struct n_tty_data *ldata = tty->disc_data;
 
@@ -1445,7 +1445,7 @@ static void n_tty_receive_char(struct tty_struct *tty, unsigned char c)
 	put_tty_queue(c, ldata);
 }
 
-static void n_tty_receive_char_closing(struct tty_struct *tty, unsigned char c,
+static void n_tty_receive_char_closing(struct tty_struct *tty, u8 c,
 				       bool lookahead_done)
 {
 	if (I_ISTRIP(tty))
@@ -1465,7 +1465,7 @@ static void n_tty_receive_char_closing(struct tty_struct *tty, unsigned char c,
 }
 
 static void
-n_tty_receive_char_flagged(struct tty_struct *tty, unsigned char c, char flag)
+n_tty_receive_char_flagged(struct tty_struct *tty, u8 c, u8 flag)
 {
 	switch (flag) {
 	case TTY_BREAK:
@@ -1479,13 +1479,13 @@ n_tty_receive_char_flagged(struct tty_struct *tty, unsigned char c, char flag)
 		n_tty_receive_overrun(tty);
 		break;
 	default:
-		tty_err(tty, "unknown flag %d\n", flag);
+		tty_err(tty, "unknown flag %u\n", flag);
 		break;
 	}
 }
 
 static void
-n_tty_receive_char_lnext(struct tty_struct *tty, unsigned char c, char flag)
+n_tty_receive_char_lnext(struct tty_struct *tty, u8 c, u8 flag)
 {
 	struct n_tty_data *ldata = tty->disc_data;
 
@@ -1505,7 +1505,7 @@ static void n_tty_lookahead_flow_ctrl(struct tty_struct *tty, const u8 *cp,
 				      const u8 *fp, size_t count)
 {
 	struct n_tty_data *ldata = tty->disc_data;
-	unsigned char flag = TTY_NORMAL;
+	u8 flag = TTY_NORMAL;
 
 	ldata->lookahead_count += count;
 
@@ -1562,7 +1562,7 @@ static void
 n_tty_receive_buf_closing(struct tty_struct *tty, const u8 *cp, const u8 *fp,
 			  int count, bool lookahead_done)
 {
-	char flag = TTY_NORMAL;
+	u8 flag = TTY_NORMAL;
 
 	while (count--) {
 		if (fp)
@@ -1955,7 +1955,7 @@ static inline int input_available_p(const struct tty_struct *tty, int poll)
  *		read_tail published
  */
 static bool copy_from_read_buf(const struct tty_struct *tty,
-				      unsigned char **kbp,
+				      u8 **kbp,
 				      size_t *nr)
 
 {
@@ -1968,7 +1968,7 @@ static bool copy_from_read_buf(const struct tty_struct *tty,
 	n = min(head - ldata->read_tail, N_TTY_BUF_SIZE - tail);
 	n = min(*nr, n);
 	if (n) {
-		unsigned char *from = read_buf_addr(ldata, tail);
+		u8 *from = read_buf_addr(ldata, tail);
 		memcpy(*kbp, from, n);
 		is_eof = n == 1 && *from == EOF_CHAR(tty);
 		tty_audit_add_data(tty, from, n);
@@ -2010,7 +2010,7 @@ static bool copy_from_read_buf(const struct tty_struct *tty,
  *	read_tail published
  */
 static bool canon_copy_from_read_buf(const struct tty_struct *tty,
-				     unsigned char **kbp,
+				     u8 **kbp,
 				     size_t *nr)
 {
 	struct n_tty_data *ldata = tty->disc_data;
@@ -2229,7 +2229,7 @@ static ssize_t n_tty_read(struct tty_struct *tty, struct file *file, u8 *kbuf,
 	while (nr) {
 		/* First test for status change. */
 		if (packet && tty->link->ctrl.pktstatus) {
-			unsigned char cs;
+			u8 cs;
 			if (kb != kbuf)
 				break;
 			spin_lock_irq(&tty->link->ctrl.lock);
-- 
2.42.0

