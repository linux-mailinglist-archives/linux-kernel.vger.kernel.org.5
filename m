Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D3C806891
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 08:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbjLFHhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 02:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbjLFHhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 02:37:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333281BD
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 23:37:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 716DFC433C8;
        Wed,  6 Dec 2023 07:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701848246;
        bh=Ukprb5PhFT14ziQTaeRyUiVmJt5daqc4bA2YTTuvN/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kiAJ9ZnE/0SeG1sPJvu0yDeIk03vlZgnsyPIvBWLB/dZkKeBDmpFrWHdF+UP1kY7m
         2VNKVqzoYMUWrSQWfaRGJGJZXCI3nQBk8Qn2995h/XH6urPfqfYrIsPwFcIjxclOoO
         biA0KnckEXwumf6gSpT8yFSfuCKveraUROgSExoeaDxiqmttgut/FemNlEDDKHAmTA
         LVs8XrPkktWJ4cNxqj9JJFm779q80TgTtFOYWeUzIVETVHhF+RUAhJkntmgd9+W8uC
         j/ZKtNJESRei9Fe1qkHqyUWBSwf8HQdXSqDtz59fe7I5LOj71emfG2gxWaMOZlxScx
         UM+QMEBLnk8pg==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 03/27] tty: switch tty_port::xmit_* to u8
Date:   Wed,  6 Dec 2023 08:36:48 +0100
Message-ID: <20231206073712.17776-4-jirislaby@kernel.org>
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

Both xmit_buf and xmit_fifo of struct tty_port should be u8. To conform
to characters in the rest of the tty layer.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/tty_port.c   | 2 +-
 include/linux/tty_port.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index ef72d2e4b928..14cca33d2269 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -247,7 +247,7 @@ int tty_port_alloc_xmit_buf(struct tty_port *port)
 	/* We may sleep in get_zeroed_page() */
 	mutex_lock(&port->buf_mutex);
 	if (port->xmit_buf == NULL) {
-		port->xmit_buf = (unsigned char *)get_zeroed_page(GFP_KERNEL);
+		port->xmit_buf = (u8 *)get_zeroed_page(GFP_KERNEL);
 		if (port->xmit_buf)
 			kfifo_init(&port->xmit_fifo, port->xmit_buf, PAGE_SIZE);
 	}
diff --git a/include/linux/tty_port.h b/include/linux/tty_port.h
index 3276311a7f38..1b861f2100b6 100644
--- a/include/linux/tty_port.h
+++ b/include/linux/tty_port.h
@@ -114,8 +114,8 @@ struct tty_port {
 	unsigned char		console:1;
 	struct mutex		mutex;
 	struct mutex		buf_mutex;
-	unsigned char		*xmit_buf;
-	DECLARE_KFIFO_PTR(xmit_fifo, unsigned char);
+	u8			*xmit_buf;
+	DECLARE_KFIFO_PTR(xmit_fifo, u8);
 	unsigned int		close_delay;
 	unsigned int		closing_wait;
 	int			drain_delay;
-- 
2.43.0

