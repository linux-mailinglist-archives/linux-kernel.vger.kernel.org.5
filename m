Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBA4777440
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234873AbjHJJSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234857AbjHJJSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:18:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2C72D78;
        Thu, 10 Aug 2023 02:16:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 636C0654EB;
        Thu, 10 Aug 2023 09:16:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DB56C433CA;
        Thu, 10 Aug 2023 09:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691658993;
        bh=xfPu/5q4FMx3T2+9l5i48yWip85zm4W4RMAqgP0eBJ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b1pVqjVZ22u/45Ud58HE/Kjhd4wjIWPClNGk/jaVo/jnjNTBFAMjANjcuOdqvrvEg
         SlNCzjhTgcVrkss3g26Bv52/3S92Pj7L7UNmzv3XksGBIf7wNZSu+x9ob0nQokI69S
         y76GOTACwKOVJsazUaCBjN2Ln/Eg9iWDk9Jk2MYcyTAbPCW2E9B25pE0IrO72E5KeF
         B1qGHPcF0XO7yh+MrnsIb8NfkILERqvgLnyVxMzgMyUC1Lv5K//PHbZ9Uu46ViuQOX
         NX8V+10hmFER5vcFjPguOZAgXO/QOZp4fH2Ar+gRndAFpYLf5BNXPJZeYeLfapKEcB
         1ycEN3Z1WCPDQ==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 32/36] tty: hvc: convert counts to size_t
Date:   Thu, 10 Aug 2023 11:15:06 +0200
Message-ID: <20230810091510.13006-33-jirislaby@kernel.org>
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

Unify the type of tty_operations::write() counters with the 'count'
parameter. I.e. use size_t for them.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org
---
 drivers/tty/hvc/hvc_console.c |  2 +-
 drivers/tty/hvc/hvcs.c        |  6 +++---
 drivers/tty/hvc/hvsi.c        | 10 +++++-----
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index e93e8072ec86..959fae54ca39 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -500,7 +500,7 @@ static ssize_t hvc_write(struct tty_struct *tty, const u8 *buf, size_t count)
 {
 	struct hvc_struct *hp = tty->driver_data;
 	unsigned long flags;
-	int rsize, written = 0;
+	size_t rsize, written = 0;
 
 	/* This write was probably executed during a tty close. */
 	if (!hp)
diff --git a/drivers/tty/hvc/hvcs.c b/drivers/tty/hvc/hvcs.c
index 1de91fa23b04..d29fdfe9d93d 100644
--- a/drivers/tty/hvc/hvcs.c
+++ b/drivers/tty/hvc/hvcs.c
@@ -1263,8 +1263,8 @@ static ssize_t hvcs_write(struct tty_struct *tty, const u8 *buf, size_t count)
 	unsigned int unit_address;
 	const unsigned char *charbuf;
 	unsigned long flags;
-	int total_sent = 0;
-	int tosend = 0;
+	size_t total_sent = 0;
+	size_t tosend = 0;
 	int result = 0;
 
 	/*
@@ -1299,7 +1299,7 @@ static ssize_t hvcs_write(struct tty_struct *tty, const u8 *buf, size_t count)
 	unit_address = hvcsd->vdev->unit_address;
 
 	while (count > 0) {
-		tosend = min_t(unsigned, count,
+		tosend = min_t(size_t, count,
 			       (HVCS_BUFF_LEN - hvcsd->chars_in_buffer));
 		/*
 		 * No more space, this probably means that the last call to
diff --git a/drivers/tty/hvc/hvsi.c b/drivers/tty/hvc/hvsi.c
index c57bd85aa488..a94068bce76f 100644
--- a/drivers/tty/hvc/hvsi.c
+++ b/drivers/tty/hvc/hvsi.c
@@ -909,8 +909,8 @@ static ssize_t hvsi_write(struct tty_struct *tty, const u8 *source,
 {
 	struct hvsi_struct *hp = tty->driver_data;
 	unsigned long flags;
-	int total = 0;
-	int origcount = count;
+	size_t total = 0;
+	size_t origcount = count;
 
 	spin_lock_irqsave(&hp->lock, flags);
 
@@ -928,7 +928,7 @@ static ssize_t hvsi_write(struct tty_struct *tty, const u8 *source,
 	 * will see there is no room in outbuf and return.
 	 */
 	while ((count > 0) && (hvsi_write_room(tty) > 0)) {
-		int chunksize = min_t(int, count, hvsi_write_room(tty));
+		size_t chunksize = min_t(size_t, count, hvsi_write_room(tty));
 
 		BUG_ON(hp->n_outbuf < 0);
 		memcpy(hp->outbuf + hp->n_outbuf, source, chunksize);
@@ -952,8 +952,8 @@ static ssize_t hvsi_write(struct tty_struct *tty, const u8 *source,
 	spin_unlock_irqrestore(&hp->lock, flags);
 
 	if (total != origcount)
-		pr_debug("%s: wanted %i, only wrote %i\n", __func__, origcount,
-			total);
+		pr_debug("%s: wanted %zu, only wrote %zu\n", __func__,
+			 origcount, total);
 
 	return total;
 }
-- 
2.41.0

