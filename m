Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233A87F28C3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 10:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbjKUJXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 04:23:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232964AbjKUJXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 04:23:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449081BC
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 01:23:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E493C433C7;
        Tue, 21 Nov 2023 09:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700558596;
        bh=Y5i+1euxXI4UCUqQ8X+2VuZ/t15K0hpOycDIDgEeERI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IH+7wSj9QouOREWdasm6QA3mhk9WhQXzBt0Q8x2nYkUJMCp92n6GV3It3p5TDM9RP
         YRzbU4o3CIcfbsVm6Z65o4m6XtIPzBbIKIWDZfMDyE7zAqnEAkPdvp8iF9ic5Cbhqf
         aZKZGqZjt9j/W6KMV+S9+Q1++LngSBSOz9VZiysDM6KhCYJ2OgAUJGRsVWO/1EP4ch
         pwwPnTBJoiu2M+AnPBSuBUTGhM468rDQ/eqjns03GJAfokrz73XaYrYvX/gz2jl6/L
         QTNTA6kFDUwHUiabdwYcDj2t4MS4vU7sjigNDMUwlS+o2ugv4bTnbOG5UZQJmOb/b0
         VbaBgCbr3yrtg==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 08/17] tty: goldfish: drop unneeded temporary variables
Date:   Tue, 21 Nov 2023 10:22:49 +0100
Message-ID: <20231121092258.9334-9-jirislaby@kernel.org>
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

We can pass 'buf' directly to goldfish_tty_rw() using simple (unsigned
long) cast. There is no need to obfuscate the code by another variable
with double casts.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/goldfish.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/goldfish.c b/drivers/tty/goldfish.c
index 4591f940b7a1..dccf6c6c69c6 100644
--- a/drivers/tty/goldfish.c
+++ b/drivers/tty/goldfish.c
@@ -128,16 +128,14 @@ static void goldfish_tty_rw(struct goldfish_tty *qtty,
 static void goldfish_tty_do_write(int line, const u8 *buf, unsigned int count)
 {
 	struct goldfish_tty *qtty = &goldfish_ttys[line];
-	unsigned long address = (unsigned long)(void *)buf;
 
-	goldfish_tty_rw(qtty, address, count, 1);
+	goldfish_tty_rw(qtty, (unsigned long)buf, count, 1);
 }
 
 static irqreturn_t goldfish_tty_interrupt(int irq, void *dev_id)
 {
 	struct goldfish_tty *qtty = dev_id;
 	void __iomem *base = qtty->base;
-	unsigned long address;
 	unsigned char *buf;
 	u32 count;
 
@@ -147,8 +145,7 @@ static irqreturn_t goldfish_tty_interrupt(int irq, void *dev_id)
 
 	count = tty_prepare_flip_string(&qtty->port, &buf, count);
 
-	address = (unsigned long)(void *)buf;
-	goldfish_tty_rw(qtty, address, count, 0);
+	goldfish_tty_rw(qtty, (unsigned long)buf, count, 0);
 
 	tty_flip_buffer_push(&qtty->port);
 	return IRQ_HANDLED;
-- 
2.42.1

