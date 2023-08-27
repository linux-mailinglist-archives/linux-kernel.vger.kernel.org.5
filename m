Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27684789BE0
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 09:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjH0Hni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 03:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjH0HmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 03:42:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8BCFA;
        Sun, 27 Aug 2023 00:42:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43C4260FC9;
        Sun, 27 Aug 2023 07:42:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1764C433C8;
        Sun, 27 Aug 2023 07:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693122128;
        bh=I7T8JzUTvFtmo5xlDYAkNBZGkmHty16AkdRBOY1GVgU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QSiV2OusxS+1LP/ke2ER4BXxgUfA9AS8ibKGapUCWxc09FyhVdx4pfCkoqNJDbku2
         vqYrbcyyUWf8O/sL9tmwS5fmaN5SbWaImRWCx/fkRasROyl8kOAAEufcHZpW1c8sp9
         MfRo2CTjF+m+/JdOmzWjJLdp4jEfLV6X0Wyx3Q6hqhkfwv5X5rCsdc2epDiECmVqFU
         LrTDO96E6gxHQ/qcKw9Zvw/eTFvH77rCgzc0xWEREjaRe2sGUo482/YAx/zOf/3ng2
         l8Ek2FOvSkT2YsahiXimvJ652TtU+V4eSo76DHSovrSH/FpLz7JsZEauVMOB3PVp4V
         cBI789+mx2+FA==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH v2 12/14] tty: n_tty: unify counts to size_t
Date:   Sun, 27 Aug 2023 09:41:45 +0200
Message-ID: <20230827074147.2287-13-jirislaby@kernel.org>
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
index cf42b8b4ad2e..bd6cd28f734f 100644
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
2.42.0

