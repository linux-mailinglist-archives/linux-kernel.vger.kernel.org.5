Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51BE7F28B0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 10:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbjKUJXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 04:23:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbjKUJXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 04:23:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576FE116
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 01:23:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7DF2C433C8;
        Tue, 21 Nov 2023 09:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700558587;
        bh=NJRodWQw+P7zL14JGGfRqGN5XnSMc52Tx2CPIuB6IKU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tkyjypYt3IQbbl2DgXKlWlx+F+UoQfxwd8yzxqY0lHe6HGCuSS2oSFNfqX0nS0vfq
         k8B39ggdcyrEdbx3PbFrpLi2043eD+f4YrGXcroBXXw/mv86qoPx/L8OYvI32DH2it
         gTbTxLv/4+uDEvWTAN79xoW+KA0MdM68GsjAnc3iJtNw0CCeoWx9Dt7TSKnSSGIfwh
         8IMnaus9PxGkEu3vMi9C7V7sMzUpBstBXg0xDPGzfG99gFRM4Hvhtmtd8jpRPIbKao
         UVYfeEuYQjaF6c5L/907W8wtaig9AKQbP1K7nJF99oQNhH2q1/4QLjyL0q2mF52PWu
         PQHM2ZbN5Dnfw==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 02/17] tty: remove unneeded mbz from tiocsti()
Date:   Tue, 21 Nov 2023 10:22:43 +0100
Message-ID: <20231121092258.9334-3-jirislaby@kernel.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231121092258.9334-1-jirislaby@kernel.org>
References: <20231121092258.9334-1-jirislaby@kernel.org>
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

'mbz' in tiocsti() is used only to pass TTY_NORMAL to
tty_ldisc_ops::receive_buf(). But that can be achieved easier by simply
passing NULL to ::receive_buf().

So drop this 'mbz'.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/tty_io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index ee5a90f9adb5..005d91c63707 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2280,7 +2280,7 @@ static bool tty_legacy_tiocsti __read_mostly = IS_ENABLED(CONFIG_LEGACY_TIOCSTI)
  */
 static int tiocsti(struct tty_struct *tty, char __user *p)
 {
-	char ch, mbz = 0;
+	char ch;
 	struct tty_ldisc *ld;
 
 	if (!tty_legacy_tiocsti && !capable(CAP_SYS_ADMIN))
@@ -2296,7 +2296,7 @@ static int tiocsti(struct tty_struct *tty, char __user *p)
 		return -EIO;
 	tty_buffer_lock_exclusive(tty->port);
 	if (ld->ops->receive_buf)
-		ld->ops->receive_buf(tty, &ch, &mbz, 1);
+		ld->ops->receive_buf(tty, &ch, NULL, 1);
 	tty_buffer_unlock_exclusive(tty->port);
 	tty_ldisc_deref(ld);
 	return 0;
-- 
2.42.1

