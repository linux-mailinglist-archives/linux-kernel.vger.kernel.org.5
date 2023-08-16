Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70B577DFF2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 13:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244422AbjHPLBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 07:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244468AbjHPLAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 07:00:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112E52D48;
        Wed, 16 Aug 2023 04:00:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86D276656C;
        Wed, 16 Aug 2023 10:58:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFBBEC433C9;
        Wed, 16 Aug 2023 10:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692183530;
        bh=+zvqivP6B2y0YeXRf8c57g1f5SNCFX/cX6fgmE5cuY4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=biso20wzFk+X31qi9sul3aKfAn3WRDRjz5AzXSQ3A2Fczgf4tkpNAaBsC7BsTgfPf
         VfWxp6lpH1f5uKl8126yaZac6ILwe9ke/CyDPLbazFpbFZBlsTl9F7gAXVlm9ErKnV
         AuIPjJaX/Eld/w94rHfHxqlUZbyIar3f6j+4P3aMXHyx+hxVMX8RkEF8nnbpcM+mYL
         WsKLUfY0sEr+Byr4/GKy0YWlMatyhtxDSgFFFd3tas7W19QQTtZQc+YZLXXVoVXwfm
         kidp4WlGhhJig1OoTh8dYbmsF0Vc1GqM27AD2Df8+lG2QehwW67dIwDp8hN5iblkSH
         lAB9OHDnvU0yw==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 12/14] tty: n_tty: unify counts to size_t
Date:   Wed, 16 Aug 2023 12:58:20 +0200
Message-ID: <20230816105822.3685-17-jirislaby@kernel.org>
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

Some count types are already 'size_t' for a long time. Some were
switched to 'size_t' recently. Unify the rest with those now.

This allows for some min_t()s to become min()s. And make one min()
an explicit min_t() as we are comparing signed 'room' to unsigned
'count'.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/n_tty.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 4c2f77996ad3..11becd2dda2d 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1523,27 +1523,27 @@ static void n_tty_lookahead_flow_ctrl(struct tty_struct *tty, const u8 *cp,
 
 static void
 n_tty_receive_buf_real_raw(const struct tty_struct *tty, const u8 *cp,
-			   int count)
+			   size_t count)
 {
 	struct n_tty_data *ldata = tty->disc_data;
 	size_t n, head;
 
 	head = MASK(ldata->read_head);
-	n = min_t(size_t, count, N_TTY_BUF_SIZE - head);
+	n = min(count, N_TTY_BUF_SIZE - head);
 	memcpy(read_buf_addr(ldata, head), cp, n);
 	ldata->read_head += n;
 	cp += n;
 	count -= n;
 
 	head = MASK(ldata->read_head);
-	n = min_t(size_t, count, N_TTY_BUF_SIZE - head);
+	n = min(count, N_TTY_BUF_SIZE - head);
 	memcpy(read_buf_addr(ldata, head), cp, n);
 	ldata->read_head += n;
 }
 
 static void
 n_tty_receive_buf_raw(struct tty_struct *tty, const u8 *cp, const u8 *fp,
-		      int count)
+		      size_t count)
 {
 	struct n_tty_data *ldata = tty->disc_data;
 	u8 flag = TTY_NORMAL;
@@ -1560,7 +1560,7 @@ n_tty_receive_buf_raw(struct tty_struct *tty, const u8 *cp, const u8 *fp,
 
 static void
 n_tty_receive_buf_closing(struct tty_struct *tty, const u8 *cp, const u8 *fp,
-			  int count, bool lookahead_done)
+			  size_t count, bool lookahead_done)
 {
 	u8 flag = TTY_NORMAL;
 
@@ -1573,7 +1573,7 @@ n_tty_receive_buf_closing(struct tty_struct *tty, const u8 *cp, const u8 *fp,
 }
 
 static void n_tty_receive_buf_standard(struct tty_struct *tty, const u8 *cp,
-				       const u8 *fp, int count,
+				       const u8 *fp, size_t count,
 				       bool lookahead_done)
 {
 	struct n_tty_data *ldata = tty->disc_data;
@@ -1612,11 +1612,11 @@ static void n_tty_receive_buf_standard(struct tty_struct *tty, const u8 *cp,
 }
 
 static void __receive_buf(struct tty_struct *tty, const u8 *cp, const u8 *fp,
-			  int count)
+			  size_t count)
 {
 	struct n_tty_data *ldata = tty->disc_data;
 	bool preops = I_ISTRIP(tty) || (I_IUCLC(tty) && L_IEXTEN(tty));
-	size_t la_count = min_t(size_t, ldata->lookahead_count, count);
+	size_t la_count = min(ldata->lookahead_count, count);
 
 	if (ldata->real_raw)
 		n_tty_receive_buf_real_raw(tty, cp, count);
@@ -1687,11 +1687,11 @@ static void __receive_buf(struct tty_struct *tty, const u8 *cp, const u8 *fp,
  */
 static size_t
 n_tty_receive_buf_common(struct tty_struct *tty, const u8 *cp, const u8 *fp,
-			 int count, bool flow)
+			 size_t count, bool flow)
 {
 	struct n_tty_data *ldata = tty->disc_data;
-	size_t rcvd = 0;
-	int room, n, overflow;
+	size_t n, rcvd = 0;
+	int room, overflow;
 
 	down_read(&tty->termios_rwsem);
 
@@ -1724,7 +1724,7 @@ n_tty_receive_buf_common(struct tty_struct *tty, const u8 *cp, const u8 *fp,
 		} else
 			overflow = 0;
 
-		n = min(count, room);
+		n = min_t(size_t, count, room);
 		if (!n)
 			break;
 
@@ -1954,9 +1954,8 @@ static inline int input_available_p(const struct tty_struct *tty, int poll)
  *		caller holds non-exclusive %termios_rwsem;
  *		read_tail published
  */
-static bool copy_from_read_buf(const struct tty_struct *tty,
-				      u8 **kbp,
-				      size_t *nr)
+static bool copy_from_read_buf(const struct tty_struct *tty, u8 **kbp,
+			       size_t *nr)
 
 {
 	struct n_tty_data *ldata = tty->disc_data;
@@ -2009,8 +2008,7 @@ static bool copy_from_read_buf(const struct tty_struct *tty,
  *	caller holds non-exclusive %termios_rwsem;
  *	read_tail published
  */
-static bool canon_copy_from_read_buf(const struct tty_struct *tty,
-				     u8 **kbp,
+static bool canon_copy_from_read_buf(const struct tty_struct *tty, u8 **kbp,
 				     size_t *nr)
 {
 	struct n_tty_data *ldata = tty->disc_data;
-- 
2.41.0

