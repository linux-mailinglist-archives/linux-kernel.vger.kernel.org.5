Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67FFB7773FB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234452AbjHJJP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbjHJJPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:15:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8837268F;
        Thu, 10 Aug 2023 02:15:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6041160AC5;
        Thu, 10 Aug 2023 09:15:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BC83C433C9;
        Thu, 10 Aug 2023 09:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691658915;
        bh=CZajqdlnuQLGSP8OF/sy5Bc8OOCBVj4Sq5gOsBqQoXk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hP5xy9qQ0AuzPgNRFk/u13wTsSjqQGH8sSq/aE6ItLhz+9knE/bvXWsQ/d12UqgMS
         ZIjQ6vXmCzXMn4dLwNluDurewPvlTCvnT1NY21d1JSuwyCx2q6TJQSqCRAYXfNO8Yb
         WFksH3YKG3qx0PJ2LzxUMX9R4jDLuvbLPgcgVv8OiwtEfYa6iPj3Bgu5y0UVipOaSt
         ombYXIapoPPS2dtlyzC7ve/Ph7IsLfXpyFzri0ZlnKWiSLI9h/Uy6h671NAOsqKfzx
         e0yXjrVBw4/Cf+IYKZJkcQC8cX1VzLy4ztHBRzXmN713yxlJS625pX8HDdt+1E1Q4M
         p7Z46HzH4gdew==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 01/36] tty: xtensa/iss: drop unneeded tty_operations hooks
Date:   Thu, 10 Aug 2023 11:14:35 +0200
Message-ID: <20230810091510.13006-2-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230810091510.13006-1-jirislaby@kernel.org>
References: <20230810091510.13006-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All ::flush_chars(), ::hangup(), and ::wait_until_sent() from struct
tty_operations are optional. There is no need to provide them with
empty bodies.

tty_operations::put_char() needs not be provided if it is the same as
tty_operations::write(tty, &ch, 1).

So drop all of them.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/platforms/iss/console.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/arch/xtensa/platforms/iss/console.c b/arch/xtensa/platforms/iss/console.c
index 10b79d3c74e0..b40b73809dd8 100644
--- a/arch/xtensa/platforms/iss/console.c
+++ b/arch/xtensa/platforms/iss/console.c
@@ -82,32 +82,12 @@ static void rs_poll(struct timer_list *unused)
 		mod_timer(&serial_timer, jiffies + SERIAL_TIMER_VALUE);
 }
 
-
-static int rs_put_char(struct tty_struct *tty, unsigned char ch)
-{
-	return rs_write(tty, &ch, 1);
-}
-
-static void rs_flush_chars(struct tty_struct *tty)
-{
-}
-
 static unsigned int rs_write_room(struct tty_struct *tty)
 {
 	/* Let's say iss can always accept 2K characters.. */
 	return 2 * 1024;
 }
 
-static void rs_hangup(struct tty_struct *tty)
-{
-	/* Stub, once again.. */
-}
-
-static void rs_wait_until_sent(struct tty_struct *tty, int timeout)
-{
-	/* Stub, once again.. */
-}
-
 static int rs_proc_show(struct seq_file *m, void *v)
 {
 	seq_printf(m, "serinfo:1.0 driver:0.1\n");
@@ -118,11 +98,7 @@ static const struct tty_operations serial_ops = {
 	.open = rs_open,
 	.close = rs_close,
 	.write = rs_write,
-	.put_char = rs_put_char,
-	.flush_chars = rs_flush_chars,
 	.write_room = rs_write_room,
-	.hangup = rs_hangup,
-	.wait_until_sent = rs_wait_until_sent,
 	.proc_show = rs_proc_show,
 };
 
-- 
2.41.0

