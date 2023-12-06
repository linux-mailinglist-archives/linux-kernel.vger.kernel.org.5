Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B26368068C3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 08:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376845AbjLFHja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 02:39:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376742AbjLFHiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 02:38:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92722110
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 23:38:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 531E7C433C9;
        Wed,  6 Dec 2023 07:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701848281;
        bh=kDcj/obqX+Hi8m/kqT3v8vxYxZC41xF3arHR+tQ9eys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jGBST3C5fev0tTfqKBcXCSSmiediXRM76ze4uONt5GZWQcCB6hVifuHbmioYvB5Vp
         8kgZBqCGZsy/SjSIlZXKFIk71KUUxc/LlB0GE70myk0WVBI+hqP/frkIQ0jV0UVsBd
         P/frzHjXu9fyLVSMIduUQjSW1w/88/yvFa+yVlX+zIc13kCn94HRUXYwl/uf2AoeNT
         Ij4itpLT3YlHJW1uuCf37jTGQwHZ/vnzeq5/2Suc6ZSdfsEgNSkoa4nsilnsTxsMLH
         ctiDTTSVV52TL7UJNF5V7364YYJiKfi2XO7T4NWOhQHIBRZqitSYPRxSr7KoaXA1oA
         GCDJ66oRoxdTA==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 21/27] tty: nozomi: convert to u8 and size_t
Date:   Wed,  6 Dec 2023 08:37:06 +0100
Message-ID: <20231206073712.17776-22-jirislaby@kernel.org>
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
---
 drivers/tty/nozomi.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/nozomi.c b/drivers/tty/nozomi.c
index b247341bd12f..e28a921c1637 100644
--- a/drivers/tty/nozomi.c
+++ b/drivers/tty/nozomi.c
@@ -783,11 +783,10 @@ static int receive_data(enum port_type index, struct nozomi *dc)
 			tty_insert_flip_char(&port->port, buf[0], TTY_NORMAL);
 			size = 0;
 		} else if (size < RECEIVE_BUF_MAX) {
-			size -= tty_insert_flip_string(&port->port,
-					(char *)buf, size);
+			size -= tty_insert_flip_string(&port->port, buf, size);
 		} else {
-			i = tty_insert_flip_string(&port->port,
-					(char *)buf, RECEIVE_BUF_MAX);
+			i = tty_insert_flip_string(&port->port, buf,
+						   RECEIVE_BUF_MAX);
 			size -= i;
 			offset += i;
 		}
@@ -1584,10 +1583,10 @@ static void ntty_hangup(struct tty_struct *tty)
 static ssize_t ntty_write(struct tty_struct *tty, const u8 *buffer,
 			  size_t count)
 {
-	int rval = -EINVAL;
 	struct nozomi *dc = get_dc_by_tty(tty);
 	struct port *port = tty->driver_data;
 	unsigned long flags;
+	size_t rval;
 
 	if (!dc || !port)
 		return -ENODEV;
-- 
2.43.0

