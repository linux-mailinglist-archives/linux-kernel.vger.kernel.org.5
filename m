Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA342777410
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234789AbjHJJQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234502AbjHJJPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:15:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B4D2D44;
        Thu, 10 Aug 2023 02:15:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91192654CA;
        Thu, 10 Aug 2023 09:15:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E59C7C433C7;
        Thu, 10 Aug 2023 09:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691658933;
        bh=2EzU32teHPEFx7Xv34ToEm1KLNnvf7toM6OFIjfeOoE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bhih7r29/qbhXewjgFbenYyT2i/Tk03ucby90aVLjhlaoZrLz8LpZkRP2L5VcQYLh
         3vtkYBuHxJedegGll/7s1c/Qtcz6EltHJCDHB7zQslfc3WtealRYEAgdyQDctrIf0N
         6LwlnIjBpp+G1xiFV1Tt8jhhCreNIiX118NFPuRoDE4DWGz+8psZb+WiOTiIy2uOS4
         SYPJBvVdds3uSRCIoeEFQ9+DmB5bXIV6hkjuzvh5XTeNM110dnJ0at/pWAesI+zHM8
         sZDrriZUpIswXpybKFATqtWuBBPuQaX0VDFfa0tNi37zdUoCYZttaUtLTxzVtZLPbX
         30pE8pE83t3xQ==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 11/36] tty: switch receive_buf() counts to size_t
Date:   Thu, 10 Aug 2023 11:14:45 +0200
Message-ID: <20230810091510.13006-12-jirislaby@kernel.org>
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

'size_t' is what receive_buf() expects and returns while handling count.
So switch to 'size_t'.

This renders both local 'count' and 'rcvd' in flush_to_ldisc() to be
size_t too.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/tty_buffer.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index 42464c37125a..7182dab60fac 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -502,12 +502,12 @@ static void lookahead_bufs(struct tty_port *port, struct tty_buffer *head)
 	}
 }
 
-static int
-receive_buf(struct tty_port *port, struct tty_buffer *head, int count)
+static size_t
+receive_buf(struct tty_port *port, struct tty_buffer *head, size_t count)
 {
 	u8 *p = char_buf_ptr(head, head->read);
 	const u8 *f = NULL;
-	int n;
+	size_t n;
 
 	if (head->flags)
 		f = flag_buf_ptr(head, head->read);
@@ -539,7 +539,7 @@ static void flush_to_ldisc(struct work_struct *work)
 	while (1) {
 		struct tty_buffer *head = buf->head;
 		struct tty_buffer *next;
-		int count, rcvd;
+		size_t count, rcvd;
 
 		/* Ldisc or user is trying to gain exclusive access */
 		if (atomic_read(&buf->priority))
-- 
2.41.0

