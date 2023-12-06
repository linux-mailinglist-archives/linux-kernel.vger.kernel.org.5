Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B33F8068BF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 08:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377052AbjLFHjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 02:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232286AbjLFHid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 02:38:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BC71FD0
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 23:37:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 583B9C433CB;
        Wed,  6 Dec 2023 07:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701848275;
        bh=omxGS8CIFs5M7dlqv12y1t6jFG26IXkN60+x4JAd2q0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AyP9uT8U/FSUMpRhl+seVa3V0u89PJEz2UC/GoWxJuLZmYd3IyetkvpzjZYP838MQ
         zl/zeIm0Xdpq3LUfZKSocGVcgFiBB2du6R+vn6bDMITmq8HWV2G+3/vtalpS4+nvJz
         liMLJ89JXKDw4A4mJxtFdRN48LfOPkLu6Pi5XxWw6AqbgM9oQW3CDPs1reX/hEAgOV
         Sc/D2/S4fAI4OeXmHGtcXHF7WjOQV4IPWTCw8rF64I7zJuXqkTzg/l+YxuGnuXr53b
         AoQdeYGFwo7EYQ871WP8HMph/blBA68qHlGIeqWszOzzGEjp+9HTOdrpgybCZA+wI0
         dxa9bPoNGZpyw==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 17/27] tty: moxa: convert to u8 and size_t
Date:   Wed,  6 Dec 2023 08:37:02 +0100
Message-ID: <20231206073712.17776-18-jirislaby@kernel.org>
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
 drivers/tty/moxa.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/moxa.c b/drivers/tty/moxa.c
index bf3f87ba3a92..ebaada8db929 100644
--- a/drivers/tty/moxa.c
+++ b/drivers/tty/moxa.c
@@ -514,7 +514,7 @@ static void MoxaPortLineCtrl(struct moxa_port *, bool, bool);
 static void MoxaPortFlowCtrl(struct moxa_port *, int, int, int, int, int);
 static int MoxaPortLineStatus(struct moxa_port *);
 static void MoxaPortFlushData(struct moxa_port *, int);
-static int MoxaPortWriteData(struct tty_struct *, const unsigned char *, int);
+static ssize_t MoxaPortWriteData(struct tty_struct *, const u8 *, size_t);
 static int MoxaPortReadData(struct moxa_port *);
 static unsigned int MoxaPortTxQueue(struct moxa_port *);
 static int MoxaPortRxQueue(struct moxa_port *);
@@ -1933,10 +1933,10 @@ static void MoxaPortFlushData(struct moxa_port *port, int mode)
  *
  *      Function 20:    Write data.
  *      Syntax:
- *      int  MoxaPortWriteData(int port, unsigned char * buffer, int length);
+ *      ssize_t  MoxaPortWriteData(int port, u8 *buffer, size_t length);
  *           int port           : port number (0 - 127)
- *           unsigned char * buffer     : pointer to write data buffer.
- *           int length         : write data length
+ *           u8 *buffer         : pointer to write data buffer.
+ *           size_t length      : write data length
  *
  *           return:    0 - length      : real write data length
  *
@@ -2163,11 +2163,12 @@ static int MoxaPortLineStatus(struct moxa_port *port)
 	return val;
 }
 
-static int MoxaPortWriteData(struct tty_struct *tty, const u8 *buffer, int len)
+static ssize_t MoxaPortWriteData(struct tty_struct *tty, const u8 *buffer,
+				 size_t len)
 {
 	struct moxa_port *port = tty->driver_data;
 	void __iomem *baseAddr, *ofsAddr, *ofs;
-	unsigned int c, total;
+	size_t c, total;
 	u16 head, tail, tx_mask, spage, epage;
 	u16 pageno, pageofs, bufhead;
 
@@ -2224,8 +2225,8 @@ static int MoxaPortWriteData(struct tty_struct *tty, const u8 *buffer, int len)
 static int MoxaPortReadData(struct moxa_port *port)
 {
 	struct tty_struct *tty = port->port.tty;
-	unsigned char *dst;
 	void __iomem *baseAddr, *ofsAddr, *ofs;
+	u8 *dst;
 	unsigned int count, len, total;
 	u16 tail, rx_mask, spage, epage;
 	u16 pageno, pageofs, bufhead, head;
-- 
2.43.0

