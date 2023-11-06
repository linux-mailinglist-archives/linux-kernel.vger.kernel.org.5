Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181E17E2EA4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 22:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbjKFVHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 16:07:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbjKFVHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 16:07:38 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379CDD75
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 13:07:35 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1699304853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zy0aCNS0BNbBR2t/Vy2pLfxqa358VYw0pvvR05rDg/o=;
        b=fB6LLMePAfBS6UsMHNPaGN1Jp491bueVhdT9MO5Poa+tLrJXPOEbHESi9XjdXfPX/nq8zj
        Fy5eumkd+lH2QB7p1YFdETnX/II5LCSnAhWuUVcUYv7/qIdiCOtb7HjraMrTj8Onso/pFF
        8V6YPGa9VHUK4pQ7Z8bTiw/rrkZDsDboZE5aHm9OAHBj6hEONNlfwJmLTQOEuO5tHZ4Ibd
        2s7hOSONf4fJKU6NKS/5aKD3l74gjI7t+EO4KqcJGlM4vno/UySNkR8p03mQiQU+G++tBt
        Jp5KQMn8Zh5hLvxc83e7nKW1IBu9K1liHOM3+eSpb8DCl6UIFszPphqlTi8Z8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1699304853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zy0aCNS0BNbBR2t/Vy2pLfxqa358VYw0pvvR05rDg/o=;
        b=HbiGHTBfFOaOEt2JUlfzI0MJAMvgqI0KgYMKg369AG+/tYwBccrxc0M4/aXxi7/3czo/64
        Krv9JHZCFJytrADA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v2 2/9] printk: ringbuffer: Clarify special lpos values
Date:   Mon,  6 Nov 2023 22:13:23 +0106
Message-Id: <20231106210730.115192-3-john.ogness@linutronix.de>
In-Reply-To: <20231106210730.115192-1-john.ogness@linutronix.de>
References: <20231106210730.115192-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For empty line records, no data blocks are created. Instead,
these valid records are identified by special logical position
values (in fields of @prb_desc.text_blk_lpos).

Currently the macro NO_LPOS is used for empty line records.
This name is confusing because it does not imply _why_ there is
no data block.

Rename NO_LPOS to EMPTY_LINE_LPOS so that it is clear why there
is no data block.

Also add comments explaining the use of EMPTY_LINE_LPOS as well
as clarification to the values used to represent data-less
blocks.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk_ringbuffer.c | 20 ++++++++++++++++----
 kernel/printk/printk_ringbuffer.h | 16 +++++++++++++++-
 2 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index 94eede5356ac..43d77db435c5 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -1034,9 +1034,13 @@ static char *data_alloc(struct printk_ringbuffer *rb, unsigned int size,
 	unsigned long next_lpos;
 
 	if (size == 0) {
-		/* Specify a data-less block. */
-		blk_lpos->begin = NO_LPOS;
-		blk_lpos->next = NO_LPOS;
+		/*
+		 * Data blocks are not created for empty lines. Instead, the
+		 * reader will recognize these special lpos values and handle
+		 * it appropriately.
+		 */
+		blk_lpos->begin = EMPTY_LINE_LPOS;
+		blk_lpos->next = EMPTY_LINE_LPOS;
 		return NULL;
 	}
 
@@ -1214,10 +1218,18 @@ static const char *get_data(struct prb_data_ring *data_ring,
 
 	/* Data-less data block description. */
 	if (BLK_DATALESS(blk_lpos)) {
-		if (blk_lpos->begin == NO_LPOS && blk_lpos->next == NO_LPOS) {
+		/*
+		 * Records that are just empty lines are also valid, even
+		 * though they do not have a data block. For such records
+		 * explicitly return empty string data to signify success.
+		 */
+		if (blk_lpos->begin == EMPTY_LINE_LPOS &&
+		    blk_lpos->next == EMPTY_LINE_LPOS) {
 			*data_size = 0;
 			return "";
 		}
+
+		/* Data lost, invalid, or otherwise unavailable. */
 		return NULL;
 	}
 
diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
index 3374a5a3303e..5c09061433f3 100644
--- a/kernel/printk/printk_ringbuffer.h
+++ b/kernel/printk/printk_ringbuffer.h
@@ -127,8 +127,22 @@ enum desc_state {
 #define DESC_SV(id, state)	(((unsigned long)state << DESC_FLAGS_SHIFT) | id)
 #define DESC_ID_MASK		(~DESC_FLAGS_MASK)
 #define DESC_ID(sv)		((sv) & DESC_ID_MASK)
+
+/*
+ * Special data block logical position values (for fields of
+ * @prb_desc.text_blk_lpos).
+ *
+ * - Bit0 is used to identify if the record has no data block. (Implemented in
+ *   the LPOS_DATALESS() macro.)
+ *
+ * - Bit1 specifies the reason for not having a data block.
+ *
+ * These special values could never be real lpos values because of the
+ * meta data and alignment padding of data blocks. (See to_blk_size() for
+ * details.)
+ */
 #define FAILED_LPOS		0x1
-#define NO_LPOS			0x3
+#define EMPTY_LINE_LPOS		0x3
 
 #define FAILED_BLK_LPOS	\
 {				\
-- 
2.39.2

