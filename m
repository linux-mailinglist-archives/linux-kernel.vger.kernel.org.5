Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21EF88068C9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 08:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377045AbjLFHkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 02:40:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377059AbjLFHjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 02:39:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A9E1716
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 23:38:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3078FC4339A;
        Wed,  6 Dec 2023 07:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701848287;
        bh=CuMXbzKLOxjnPUoex4ZYwcWf9IxiWz4OFePxU/919ps=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PWa6/T75Q9LLltQqWa4mzFG2zRFvKVqVDayW1IWCDOzJuVsKoGAhCO85bXCVgDM9/
         +71J9LEskRkNhk0UZuNU9PsGwL0F3lJWGCb3729I86mVgysgMALJ+GomntIr26LCgw
         Jw/6uscQGdkOYxEowDhdfypDc6oTfTVp6+EjgGYI2E5Ok7kIe9ieLGKwiLFFXLdIuL
         BJmAsoFMLamiX7jYl7z9zjBcQtqBeJDFkq5I2lJrWbYm67Yrm94l8KRFAGMsds2bn3
         k+rrLipxL9RQc2wQcDG5d1q3rrfhkwu3ZhMaIKp81SRwOmqC+l1clYHyO8DiHB3XSY
         WclYGuCqlCGlQ==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
Subject: [PATCH 24/27] tty: srmcons: convert to u8 and size_t
Date:   Wed,  6 Dec 2023 08:37:09 +0100
Message-ID: <20231206073712.17776-25-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231206073712.17776-1-jirislaby@kernel.org>
References: <20231206073712.17776-1-jirislaby@kernel.org>
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

Switch character types to u8 and sizes to size_t. To conform to
characters/sizes in the rest of the tty layer.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: linux-alpha@vger.kernel.org
---
 arch/alpha/kernel/srmcons.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/alpha/kernel/srmcons.c b/arch/alpha/kernel/srmcons.c
index 42deea53beab..feaf89f6936b 100644
--- a/arch/alpha/kernel/srmcons.c
+++ b/arch/alpha/kernel/srmcons.c
@@ -53,7 +53,7 @@ srmcons_do_receive_chars(struct tty_port *port)
 	do {
 		result.as_long = callback_getc(0);
 		if (result.bits.status < 2) {
-			tty_insert_flip_char(port, (char)result.bits.c, 0);
+			tty_insert_flip_char(port, (u8)result.bits.c, 0);
 			count++;
 		}
 	} while((result.bits.status & 1) && (++loops < 10));
@@ -89,7 +89,7 @@ srmcons_receive_chars(struct timer_list *t)
 
 /* called with callback_lock held */
 static void
-srmcons_do_write(struct tty_port *port, const char *buf, int count)
+srmcons_do_write(struct tty_port *port, const u8 *buf, size_t count)
 {
 	size_t c;
 	srmcons_result result;
@@ -131,7 +131,7 @@ srmcons_write(struct tty_struct *tty, const u8 *buf, size_t count)
 	unsigned long flags;
 
 	spin_lock_irqsave(&srmcons_callback_lock, flags);
-	srmcons_do_write(tty->port, (const char *) buf, count);
+	srmcons_do_write(tty->port, buf, count);
 	spin_unlock_irqrestore(&srmcons_callback_lock, flags);
 
 	return count;
-- 
2.43.0

