Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90DB277DFB6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 12:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244284AbjHPK4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 06:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244113AbjHPKzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 06:55:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C23313E;
        Wed, 16 Aug 2023 03:55:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1FA864FFF;
        Wed, 16 Aug 2023 10:55:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10BB9C433CA;
        Wed, 16 Aug 2023 10:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692183344;
        bh=BTplnn7EuC4UzkRD7loDFaPokm16ysj8tGKZLoZSkcg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c9J1eLhh0K2OgPBGL5wyV4iSoeO+gbdgIACG7mORSBB0F22o1mGrxixfvTK6IAeyR
         I69Q5FEE7+0mT7rO2Dt7NNBTyuz+/YV7MWmILvGUs+udpxQ2trH1t/J6XDFC3NyOx2
         Zp2FeKR5epl64hLtMaHRdsZ3OKFDsjY+ASoC5a0TKHvr568gScFTDUfunBHJMYAliR
         Pv24rECuYbblzKJdin+FYYTxG7/+ud/cZk5URiB1SeSu8ZGR27xTV4lVIInSsZhf4J
         r2PJAZz+LIT9+rs8BnlDWaJXljdWHbRBGyPbfzfo2ajkSUrrPgxMwP3jhllf5exM9K
         NrwJvAwb2Q2IA==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 07/10] tty: tty_buffer: use __tty_insert_flip_string_flags() in tty_insert_flip_char()
Date:   Wed, 16 Aug 2023 12:55:27 +0200
Message-ID: <20230816105530.3335-8-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816105530.3335-1-jirislaby@kernel.org>
References: <20230816105530.3335-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use __tty_insert_flip_string_flags() for the slow path of
tty_insert_flip_char(). The former is generic enough, so there is no
reason to reimplement the injection once again.

So now we have a single function stuffing into tty buffers.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 Documentation/driver-api/tty/tty_buffer.rst |  3 ++-
 drivers/tty/tty_buffer.c                    | 26 ---------------------
 include/linux/tty_flip.h                    | 12 +++++++---
 3 files changed, 11 insertions(+), 30 deletions(-)

diff --git a/Documentation/driver-api/tty/tty_buffer.rst b/Documentation/driver-api/tty/tty_buffer.rst
index 774dc119c312..4b5ca1776d4f 100644
--- a/Documentation/driver-api/tty/tty_buffer.rst
+++ b/Documentation/driver-api/tty/tty_buffer.rst
@@ -15,11 +15,12 @@ Flip Buffer Management
 ======================
 
 .. kernel-doc:: drivers/tty/tty_buffer.c
-   :identifiers: tty_prepare_flip_string __tty_insert_flip_char
+   :identifiers: tty_prepare_flip_string
            tty_flip_buffer_push tty_ldisc_receive_buf
 
 .. kernel-doc:: include/linux/tty_flip.h
    :identifiers: tty_insert_flip_string_fixed_flag tty_insert_flip_string_flags
+           tty_insert_flip_char
 
 ----
 
diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index 4f84466498f7..e162318d6c31 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -343,32 +343,6 @@ size_t __tty_insert_flip_string_flags(struct tty_port *port, const u8 *chars,
 }
 EXPORT_SYMBOL(__tty_insert_flip_string_flags);
 
-/**
- * __tty_insert_flip_char   -	add one character to the tty buffer
- * @port: tty port
- * @ch: character
- * @flag: flag byte
- *
- * Queue a single byte @ch to the tty buffering, with an optional flag. This is
- * the slow path of tty_insert_flip_char().
- */
-int __tty_insert_flip_char(struct tty_port *port, u8 ch, u8 flag)
-{
-	struct tty_buffer *tb;
-	bool flags = flag != TTY_NORMAL;
-
-	if (!__tty_buffer_request_room(port, 1, flags))
-		return 0;
-
-	tb = port->buf.tail;
-	if (tb->flags)
-		*flag_buf_ptr(tb, tb->used) = flag;
-	*char_buf_ptr(tb, tb->used++) = ch;
-
-	return 1;
-}
-EXPORT_SYMBOL(__tty_insert_flip_char);
-
 /**
  * tty_prepare_flip_string	-	make room for characters
  * @port: tty port
diff --git a/include/linux/tty_flip.h b/include/linux/tty_flip.h
index efd03d9c11f8..af4fce98f64e 100644
--- a/include/linux/tty_flip.h
+++ b/include/linux/tty_flip.h
@@ -15,7 +15,6 @@ size_t __tty_insert_flip_string_flags(struct tty_port *port, const u8 *chars,
 				      size_t size);
 size_t tty_prepare_flip_string(struct tty_port *port, u8 **chars, size_t size);
 void tty_flip_buffer_push(struct tty_port *port);
-int __tty_insert_flip_char(struct tty_port *port, u8 ch, u8 flag);
 
 /**
  * tty_insert_flip_string_fixed_flag - add characters to the tty buffer
@@ -55,7 +54,14 @@ static inline size_t tty_insert_flip_string_flags(struct tty_port *port,
 	return __tty_insert_flip_string_flags(port, chars, flags, true, size);
 }
 
-
+/**
+ * tty_insert_flip_char - add one character to the tty buffer
+ * @port: tty port
+ * @ch: character
+ * @flag: flag byte
+ *
+ * Queue a single byte @ch to the tty buffering, with an optional flag.
+ */
 static inline size_t tty_insert_flip_char(struct tty_port *port, u8 ch, u8 flag)
 {
 	struct tty_buffer *tb = port->buf.tail;
@@ -68,7 +74,7 @@ static inline size_t tty_insert_flip_char(struct tty_port *port, u8 ch, u8 flag)
 		*char_buf_ptr(tb, tb->used++) = ch;
 		return 1;
 	}
-	return __tty_insert_flip_char(port, ch, flag);
+	return __tty_insert_flip_string_flags(port, &ch, &flag, false, 1);
 }
 
 static inline size_t tty_insert_flip_string(struct tty_port *port,
-- 
2.41.0

