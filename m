Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48F9277DFEA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 13:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244318AbjHPLAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 07:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244397AbjHPLAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 07:00:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0F3211E;
        Wed, 16 Aug 2023 04:00:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77A6C665DB;
        Wed, 16 Aug 2023 10:58:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF279C433C7;
        Wed, 16 Aug 2023 10:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692183520;
        bh=AQezLToqhD9r/UVRfPRanWBqyjKP7YFO2T4TPQp9hao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VDAIkAn654zc8SmFZedhk/DUTO72cPdZu6fJ/zJq7cjegJIBmHVF/NMwTPdQaGbqW
         k8/QqtDGOQaVJbBZXlMaoaiGnAaHnlsYLN1aagH5o0LZv1YwGUti70tgImw8v2vPNb
         AIeS+6JX4VJHBV75mrhIo/Vg/P1NXGI1dm1AvllwasdUgcjZv48idxYrGd/wInrDDZ
         tajo4o7P29kDRbNFZvpiZRiZZcjK6uhIsaM1wllDuqMJCDfWCFO2t/m4Mxs0/m5SIO
         I6D96InzvrQ6o7920Abm4K8wzGHPlh2qO6/JTs8oeTndkU571OTn7TwYsQ7/PD5tjU
         KSQThGCQ9b43Q==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 06/14] tty: n_tty: use MASK() for masking out size bits
Date:   Wed, 16 Aug 2023 12:58:14 +0200
Message-ID: <20230816105822.3685-11-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816105822.3685-1-jirislaby@kernel.org>
References: <20230816105822.3685-1-jirislaby@kernel.org>
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

In n_tty, there is already a macro to mask out top bits from ring buffer
counters. It is MASK() added some time ago. So use it more in the code
to make it more readable.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/n_tty.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 0b6eeeb94920..9e0ef5294b52 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -138,23 +138,23 @@ static inline size_t read_cnt(struct n_tty_data *ldata)
 
 static inline unsigned char read_buf(struct n_tty_data *ldata, size_t i)
 {
-	return ldata->read_buf[i & (N_TTY_BUF_SIZE - 1)];
+	return ldata->read_buf[MASK(i)];
 }
 
 static inline unsigned char *read_buf_addr(struct n_tty_data *ldata, size_t i)
 {
-	return &ldata->read_buf[i & (N_TTY_BUF_SIZE - 1)];
+	return &ldata->read_buf[MASK(i)];
 }
 
 static inline unsigned char echo_buf(struct n_tty_data *ldata, size_t i)
 {
 	smp_rmb(); /* Matches smp_wmb() in add_echo_byte(). */
-	return ldata->echo_buf[i & (N_TTY_BUF_SIZE - 1)];
+	return ldata->echo_buf[MASK(i)];
 }
 
 static inline unsigned char *echo_buf_addr(struct n_tty_data *ldata, size_t i)
 {
-	return &ldata->echo_buf[i & (N_TTY_BUF_SIZE - 1)];
+	return &ldata->echo_buf[MASK(i)];
 }
 
 /* If we are not echoing the data, perhaps this is a secret so erase it */
@@ -1359,7 +1359,7 @@ static void n_tty_receive_char_special(struct tty_struct *tty, unsigned char c,
 				put_tty_queue(c, ldata);
 
 handle_newline:
-			set_bit(ldata->read_head & (N_TTY_BUF_SIZE - 1), ldata->read_flags);
+			set_bit(MASK(ldata->read_head), ldata->read_flags);
 			put_tty_queue(c, ldata);
 			smp_store_release(&ldata->canon_head, ldata->read_head);
 			kill_fasync(&tty->fasync, SIGIO, POLL_IN);
@@ -1505,14 +1505,14 @@ n_tty_receive_buf_real_raw(const struct tty_struct *tty, const u8 *cp,
 	struct n_tty_data *ldata = tty->disc_data;
 	size_t n, head;
 
-	head = ldata->read_head & (N_TTY_BUF_SIZE - 1);
+	head = MASK(ldata->read_head);
 	n = min_t(size_t, count, N_TTY_BUF_SIZE - head);
 	memcpy(read_buf_addr(ldata, head), cp, n);
 	ldata->read_head += n;
 	cp += n;
 	count -= n;
 
-	head = ldata->read_head & (N_TTY_BUF_SIZE - 1);
+	head = MASK(ldata->read_head);
 	n = min_t(size_t, count, N_TTY_BUF_SIZE - head);
 	memcpy(read_buf_addr(ldata, head), cp, n);
 	ldata->read_head += n;
@@ -1779,8 +1779,7 @@ static void n_tty_set_termios(struct tty_struct *tty, const struct ktermios *old
 			ldata->canon_head = ldata->read_tail;
 			ldata->push = 0;
 		} else {
-			set_bit((ldata->read_head - 1) & (N_TTY_BUF_SIZE - 1),
-				ldata->read_flags);
+			set_bit(MASK(ldata->read_head - 1), ldata->read_flags);
 			ldata->canon_head = ldata->read_head;
 			ldata->push = 1;
 		}
@@ -1941,7 +1940,7 @@ static bool copy_from_read_buf(const struct tty_struct *tty,
 	size_t n;
 	bool is_eof;
 	size_t head = smp_load_acquire(&ldata->commit_head);
-	size_t tail = ldata->read_tail & (N_TTY_BUF_SIZE - 1);
+	size_t tail = MASK(ldata->read_tail);
 
 	n = min(head - ldata->read_tail, N_TTY_BUF_SIZE - tail);
 	n = min(*nr, n);
@@ -2004,7 +2003,7 @@ static bool canon_copy_from_read_buf(const struct tty_struct *tty,
 	canon_head = smp_load_acquire(&ldata->canon_head);
 	n = min(*nr, canon_head - ldata->read_tail);
 
-	tail = ldata->read_tail & (N_TTY_BUF_SIZE - 1);
+	tail = MASK(ldata->read_tail);
 	size = min_t(size_t, tail + n, N_TTY_BUF_SIZE);
 
 	n_tty_trace("%s: nr:%zu tail:%zu n:%zu size:%zu\n",
@@ -2465,7 +2464,7 @@ static unsigned long inq_canon(struct n_tty_data *ldata)
 	nr = head - tail;
 	/* Skip EOF-chars.. */
 	while (MASK(head) != MASK(tail)) {
-		if (test_bit(tail & (N_TTY_BUF_SIZE - 1), ldata->read_flags) &&
+		if (test_bit(MASK(tail), ldata->read_flags) &&
 		    read_buf(ldata, tail) == __DISABLED_CHAR)
 			nr--;
 		tail++;
-- 
2.41.0

