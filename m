Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71F677DFB4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 12:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244268AbjHPK4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 06:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244007AbjHPKzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 06:55:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1477F1984;
        Wed, 16 Aug 2023 03:55:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A64B064FFF;
        Wed, 16 Aug 2023 10:55:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08249C433C7;
        Wed, 16 Aug 2023 10:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692183341;
        bh=bQUbntuVjuhv84eUfQ4u1fCZj9wEJvWe7HvkbIm42oc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UbbghvJxgjg9AwRxAtkDuW2q2OsKG4Lt4NHz3/3X0C+UX4aSUTaD3hHyV6Jbi0uYs
         P2fzsf/jZuWL94dJ6yAcdV32YHPXmkSrpr9rlQbpEUsKOnaX48p68s2aCxiRLs8Ztg
         IXDM9qZ6uw1z6VIWYvdsFs6Ewd0JKwupS79yZkoFtoSvE9gXaTl0DxS6RFxoE9W8Wh
         5RvxbKfnfQvd2VFT+rbGecTZe1aDIZAY0o52rfrqrcVjTgDb7S50QeTG7dP8UwkiLB
         JfnfrjeFeQ13j4PArnwiN5loY6FGB4WQbnh7b4BgqdJmeXSD2fY4qe0/c3fR0dlsb8
         3WH1OwVcGynTQ==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 05/10] tty: tty_buffer: switch insert functions to size_t
Date:   Wed, 16 Aug 2023 12:55:25 +0200
Message-ID: <20230816105530.3335-6-jirislaby@kernel.org>
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

All the functions accept size_t as a size argument. They finally return
the same size (or less). It is quite unexpected that they return a
signed value and can confuse users to check for negative values.

Instead, return the same size_t as accepted to make clear we return
values >= 0, where zero in fact means failure.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/tty_buffer.c | 12 ++++++------
 include/linux/tty_flip.h | 24 ++++++++++++------------
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index c101b4ab737e..598891e53031 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -303,16 +303,16 @@ int tty_buffer_request_room(struct tty_port *port, size_t size)
 }
 EXPORT_SYMBOL_GPL(tty_buffer_request_room);
 
-int __tty_insert_flip_string_flags(struct tty_port *port, const u8 *chars,
-				   const u8 *flags, bool mutable_flags,
-				   size_t size)
+size_t __tty_insert_flip_string_flags(struct tty_port *port, const u8 *chars,
+				      const u8 *flags, bool mutable_flags,
+				      size_t size)
 {
 	bool need_flags = mutable_flags || flags[0] != TTY_NORMAL;
-	int copied = 0;
+	size_t copied = 0;
 
 	do {
-		int goal = min_t(size_t, size - copied, TTY_BUFFER_PAGE);
-		int space = __tty_buffer_request_room(port, goal, need_flags);
+		size_t goal = min_t(size_t, size - copied, TTY_BUFFER_PAGE);
+		size_t space = __tty_buffer_request_room(port, goal, need_flags);
 		struct tty_buffer *tb = port->buf.tail;
 
 		if (unlikely(space == 0))
diff --git a/include/linux/tty_flip.h b/include/linux/tty_flip.h
index 8b781f709605..569747364ae5 100644
--- a/include/linux/tty_flip.h
+++ b/include/linux/tty_flip.h
@@ -10,9 +10,9 @@ struct tty_ldisc;
 int tty_buffer_set_limit(struct tty_port *port, int limit);
 unsigned int tty_buffer_space_avail(struct tty_port *port);
 int tty_buffer_request_room(struct tty_port *port, size_t size);
-int __tty_insert_flip_string_flags(struct tty_port *port, const u8 *chars,
-				   const u8 *flags, bool mutable_flags,
-				   size_t size);
+size_t __tty_insert_flip_string_flags(struct tty_port *port, const u8 *chars,
+				      const u8 *flags, bool mutable_flags,
+				      size_t size);
 int tty_prepare_flip_string(struct tty_port *port, u8 **chars, size_t size);
 void tty_flip_buffer_push(struct tty_port *port);
 int __tty_insert_flip_char(struct tty_port *port, u8 ch, u8 flag);
@@ -29,9 +29,9 @@ int __tty_insert_flip_char(struct tty_port *port, u8 ch, u8 flag);
  *
  * Returns: the number added.
  */
-static inline int tty_insert_flip_string_fixed_flag(struct tty_port *port,
-						    const u8 *chars, u8 flag,
-						    size_t size)
+static inline size_t tty_insert_flip_string_fixed_flag(struct tty_port *port,
+						       const u8 *chars, u8 flag,
+						       size_t size)
 {
 	return __tty_insert_flip_string_flags(port, chars, &flag, false, size);
 }
@@ -48,15 +48,15 @@ static inline int tty_insert_flip_string_fixed_flag(struct tty_port *port,
  *
  * Returns: the number added.
  */
-static inline int tty_insert_flip_string_flags(struct tty_port *port,
-					       const u8 *chars, const u8 *flags,
-					       size_t size)
+static inline size_t tty_insert_flip_string_flags(struct tty_port *port,
+						  const u8 *chars,
+						  const u8 *flags, size_t size)
 {
 	return __tty_insert_flip_string_flags(port, chars, flags, true, size);
 }
 
 
-static inline int tty_insert_flip_char(struct tty_port *port, u8 ch, u8 flag)
+static inline size_t tty_insert_flip_char(struct tty_port *port, u8 ch, u8 flag)
 {
 	struct tty_buffer *tb = port->buf.tail;
 	int change;
@@ -71,8 +71,8 @@ static inline int tty_insert_flip_char(struct tty_port *port, u8 ch, u8 flag)
 	return __tty_insert_flip_char(port, ch, flag);
 }
 
-static inline int tty_insert_flip_string(struct tty_port *port,
-		const u8 *chars, size_t size)
+static inline size_t tty_insert_flip_string(struct tty_port *port,
+					    const u8 *chars, size_t size)
 {
 	return tty_insert_flip_string_fixed_flag(port, chars, TTY_NORMAL, size);
 }
-- 
2.41.0

