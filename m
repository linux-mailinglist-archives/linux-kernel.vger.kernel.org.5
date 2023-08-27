Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F637789BEB
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 09:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbjH0Hnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 03:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjH0HmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 03:42:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A977AFA;
        Sun, 27 Aug 2023 00:42:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42E1E61CA0;
        Sun, 27 Aug 2023 07:42:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ECECC433C8;
        Sun, 27 Aug 2023 07:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693122131;
        bh=ZZzrW8bCe0Cteehk6ZqBfbcWjR/I+i/gq8lRg9vf2WA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tql1LjTU7g8mlHtwTYYEgppjz13KzJg8CbOAzJOH+03SYjSO9+Iz7BtC4MuNdrnTs
         e33fCxrt6+lclkxrvnRTpzFpQfvp9ec/armE5l2HHPMWdYEqNO5ikL1EfhpPOreD7x
         ARgZ67Ge+TESVhsXvDq1k1cWEhBcjLjlYfmtvQu4D6gMxK6XFQnjurO7X0dQpc8I8M
         OWIOQ/IH1TFpCkoo3g1D5B2caUkVGW4I1OlBoPNAtlYQk2CjSIYpejIvpeR4hAbmlV
         SxqqwBxdivqNicLDA85awptDjZ6Sv0xF+++OOam1n2XRBJPLosQvoGbYwLSxGtXZOh
         2ZkGjZSLo45wQ==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH v2 14/14] tty: n_tty: deduplicate copy code in n_tty_receive_buf_real_raw()
Date:   Sun, 27 Aug 2023 09:41:47 +0200
Message-ID: <20230827074147.2287-15-jirislaby@kernel.org>
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

The code is duplicated to perform the copy twice -- to handle buffer
wrap-around. Instead of the duplication, roll this into the loop.

(And add some blank lines around to have the code a bit more readable.)

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/n_tty.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index edf59f6fc669..6c9a408d67cd 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1528,19 +1528,18 @@ n_tty_receive_buf_real_raw(const struct tty_struct *tty, const u8 *cp,
 			   size_t count)
 {
 	struct n_tty_data *ldata = tty->disc_data;
-	size_t n, head;
-
-	head = MASK(ldata->read_head);
-	n = min(count, N_TTY_BUF_SIZE - head);
-	memcpy(read_buf_addr(ldata, head), cp, n);
-	ldata->read_head += n;
-	cp += n;
-	count -= n;
-
-	head = MASK(ldata->read_head);
-	n = min(count, N_TTY_BUF_SIZE - head);
-	memcpy(read_buf_addr(ldata, head), cp, n);
-	ldata->read_head += n;
+
+	/* handle buffer wrap-around by a loop */
+	for (unsigned int i = 0; i < 2; i++) {
+		size_t head = MASK(ldata->read_head);
+		size_t n = min(count, N_TTY_BUF_SIZE - head);
+
+		memcpy(read_buf_addr(ldata, head), cp, n);
+
+		ldata->read_head += n;
+		cp += n;
+		count -= n;
+	}
 }
 
 static void
-- 
2.42.0

