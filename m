Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49ED877DFB2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 12:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244252AbjHPK4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 06:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243981AbjHPKzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 06:55:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B801985;
        Wed, 16 Aug 2023 03:55:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9436B64FFF;
        Wed, 16 Aug 2023 10:55:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA42CC433CA;
        Wed, 16 Aug 2023 10:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692183338;
        bh=9arzAMjp1tDpddEsEvYS7yWfWPnFC38pD7wPryrXV6U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hT8HrzQeM68z30dQTxo3lwOP5IVFa8Qpw7BkhH9n5VQ1wdhNg7B0l2G5ErRaksiB8
         dyWdcDZQJ9WwY1+ZPDSlGWvZ+Jby/Grqg4WAiOYsoD4Fg+T1p78qCzRdi7T0W7/wpf
         qApSVv1AiAfQIHjIigToM5IUug0a7cqSmBKxahdVGUPoak+HYBPEKdzUWCwLj7/Flx
         f+BA11qP3+D93tK7+EcqR7tL1ND5RcyjMLxSnU4g3BqUJgr8u+30fp8Z0jmRFZkiay
         nk4f76YgGYE45glBqTujPXb5HWTgAQGmtRUgXwTrYnqwwW7uJlZcG06/20qcBOyuyl
         f3ij3RvGKbP2A==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 03/10] tty: tty_buffer: unify tty_insert_flip_string_{fixed_flag,flags}()
Date:   Wed, 16 Aug 2023 12:55:23 +0200
Message-ID: <20230816105530.3335-4-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816105530.3335-1-jirislaby@kernel.org>
References: <20230816105530.3335-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

They both do the same except for flags. One mem-copies the flags from
the caller, the other mem-sets to one flag given by the caller. This can
be unified with a simple if in the unified function.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 Documentation/driver-api/tty/tty_buffer.rst |  6 +-
 drivers/tty/tty_buffer.c                    | 70 +++++----------------
 include/linux/tty_flip.h                    | 46 ++++++++++++--
 3 files changed, 61 insertions(+), 61 deletions(-)

diff --git a/Documentation/driver-api/tty/tty_buffer.rst b/Documentation/driver-api/tty/tty_buffer.rst
index a39d4781e0d2..774dc119c312 100644
--- a/Documentation/driver-api/tty/tty_buffer.rst
+++ b/Documentation/driver-api/tty/tty_buffer.rst
@@ -15,10 +15,12 @@ Flip Buffer Management
 ======================
 
 .. kernel-doc:: drivers/tty/tty_buffer.c
-   :identifiers: tty_prepare_flip_string tty_insert_flip_string_fixed_flag
-           tty_insert_flip_string_flags __tty_insert_flip_char
+   :identifiers: tty_prepare_flip_string __tty_insert_flip_char
            tty_flip_buffer_push tty_ldisc_receive_buf
 
+.. kernel-doc:: include/linux/tty_flip.h
+   :identifiers: tty_insert_flip_string_fixed_flag tty_insert_flip_string_flags
+
 ----
 
 Other Functions
diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index c94df1a2d7f8..94a88dc05a54 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -303,82 +303,42 @@ int tty_buffer_request_room(struct tty_port *port, size_t size)
 }
 EXPORT_SYMBOL_GPL(tty_buffer_request_room);
 
-/**
- * tty_insert_flip_string_fixed_flag - add characters to the tty buffer
- * @port: tty port
- * @chars: characters
- * @flag: flag value for each character
- * @size: size
- *
- * Queue a series of bytes to the tty buffering. All the characters passed are
- * marked with the supplied flag.
- *
- * Returns: the number added.
- */
-int tty_insert_flip_string_fixed_flag(struct tty_port *port, const u8 *chars,
-				      u8 flag, size_t size)
+int __tty_insert_flip_string_flags(struct tty_port *port, const u8 *chars,
+				   const u8 *flags, bool mutable_flags,
+				   size_t size)
 {
+	bool need_flags = mutable_flags || flags[0] != TTY_NORMAL;
 	int copied = 0;
-	bool flags = flag != TTY_NORMAL;
 
 	do {
 		int goal = min_t(size_t, size - copied, TTY_BUFFER_PAGE);
-		int space = __tty_buffer_request_room(port, goal, flags);
+		int space = __tty_buffer_request_room(port, goal, need_flags);
 		struct tty_buffer *tb = port->buf.tail;
 
 		if (unlikely(space == 0))
 			break;
-		memcpy(char_buf_ptr(tb, tb->used), chars, space);
-		if (tb->flags)
-			memset(flag_buf_ptr(tb, tb->used), flag, space);
-		tb->used += space;
-		copied += space;
-		chars += space;
-		/* There is a small chance that we need to split the data over
-		 * several buffers. If this is the case we must loop.
-		 */
-	} while (unlikely(size > copied));
-	return copied;
-}
-EXPORT_SYMBOL(tty_insert_flip_string_fixed_flag);
 
-/**
- * tty_insert_flip_string_flags	-	add characters to the tty buffer
- * @port: tty port
- * @chars: characters
- * @flags: flag bytes
- * @size: size
- *
- * Queue a series of bytes to the tty buffering. For each character the flags
- * array indicates the status of the character.
- *
- * Returns: the number added.
- */
-int tty_insert_flip_string_flags(struct tty_port *port, const u8 *chars,
-				 const u8 *flags, size_t size)
-{
-	int copied = 0;
+		memcpy(char_buf_ptr(tb, tb->used), chars, space);
 
-	do {
-		int goal = min_t(size_t, size - copied, TTY_BUFFER_PAGE);
-		int space = tty_buffer_request_room(port, goal);
-		struct tty_buffer *tb = port->buf.tail;
+		if (mutable_flags) {
+			memcpy(flag_buf_ptr(tb, tb->used), flags, space);
+			flags += space;
+		} else if (tb->flags) {
+			memset(flag_buf_ptr(tb, tb->used), flags[0], space);
+		}
 
-		if (unlikely(space == 0))
-			break;
-		memcpy(char_buf_ptr(tb, tb->used), chars, space);
-		memcpy(flag_buf_ptr(tb, tb->used), flags, space);
 		tb->used += space;
 		copied += space;
 		chars += space;
-		flags += space;
+
 		/* There is a small chance that we need to split the data over
 		 * several buffers. If this is the case we must loop.
 		 */
 	} while (unlikely(size > copied));
+
 	return copied;
 }
-EXPORT_SYMBOL(tty_insert_flip_string_flags);
+EXPORT_SYMBOL(__tty_insert_flip_string_flags);
 
 /**
  * __tty_insert_flip_char   -	add one character to the tty buffer
diff --git a/include/linux/tty_flip.h b/include/linux/tty_flip.h
index d33aed2172c7..8b781f709605 100644
--- a/include/linux/tty_flip.h
+++ b/include/linux/tty_flip.h
@@ -10,14 +10,52 @@ struct tty_ldisc;
 int tty_buffer_set_limit(struct tty_port *port, int limit);
 unsigned int tty_buffer_space_avail(struct tty_port *port);
 int tty_buffer_request_room(struct tty_port *port, size_t size);
-int tty_insert_flip_string_flags(struct tty_port *port, const u8 *chars,
-				 const u8 *flags, size_t size);
-int tty_insert_flip_string_fixed_flag(struct tty_port *port, const u8 *chars,
-				      u8 flag, size_t size);
+int __tty_insert_flip_string_flags(struct tty_port *port, const u8 *chars,
+				   const u8 *flags, bool mutable_flags,
+				   size_t size);
 int tty_prepare_flip_string(struct tty_port *port, u8 **chars, size_t size);
 void tty_flip_buffer_push(struct tty_port *port);
 int __tty_insert_flip_char(struct tty_port *port, u8 ch, u8 flag);
 
+/**
+ * tty_insert_flip_string_fixed_flag - add characters to the tty buffer
+ * @port: tty port
+ * @chars: characters
+ * @flag: flag value for each character
+ * @size: size
+ *
+ * Queue a series of bytes to the tty buffering. All the characters passed are
+ * marked with the supplied flag.
+ *
+ * Returns: the number added.
+ */
+static inline int tty_insert_flip_string_fixed_flag(struct tty_port *port,
+						    const u8 *chars, u8 flag,
+						    size_t size)
+{
+	return __tty_insert_flip_string_flags(port, chars, &flag, false, size);
+}
+
+/**
+ * tty_insert_flip_string_flags - add characters to the tty buffer
+ * @port: tty port
+ * @chars: characters
+ * @flags: flag bytes
+ * @size: size
+ *
+ * Queue a series of bytes to the tty buffering. For each character the flags
+ * array indicates the status of the character.
+ *
+ * Returns: the number added.
+ */
+static inline int tty_insert_flip_string_flags(struct tty_port *port,
+					       const u8 *chars, const u8 *flags,
+					       size_t size)
+{
+	return __tty_insert_flip_string_flags(port, chars, flags, true, size);
+}
+
+
 static inline int tty_insert_flip_char(struct tty_port *port, u8 ch, u8 flag)
 {
 	struct tty_buffer *tb = port->buf.tail;
-- 
2.41.0

