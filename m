Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAA477DFB5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 12:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244274AbjHPK4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 06:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244019AbjHPKzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 06:55:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41C81984;
        Wed, 16 Aug 2023 03:55:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3EF8F64143;
        Wed, 16 Aug 2023 10:55:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86644C433C9;
        Wed, 16 Aug 2023 10:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692183342;
        bh=K3LGKa2ZBj92Ono8nsGKS9bVk7dhEAszS/T9RyhEzzI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mx/BgIO79cD7ufaBwQj8Hv3NtIscu7Y6hpXUH1fjtmWcrSLr57lIy5Ele1K+Jy9WG
         RC/772MpwV/7JIli+WSTF9UuGdAFFBfFCdMQ+ynGF9FmpPdwVCNWHMJFU5kBwUTep4
         GLdPZgRdwVAnq9NEugJ3kbF5sV0+Jafzv8dUpBro8SJnYonKH4OIpFkUgOQDkFqj9W
         KjPyG97VMQnvj8YaVnWrjX4xVDKuhjxNJoEoAQksm3CwOdWNpXtqfKVux74SWgi93Y
         O3Q5Q9Ya1ARrY3mxqzgcLOqebIOiBiR3G91NPqrMbCy556JgvyhsEoSNGsvth92eZb
         JzCmfDcgGRSYA==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 06/10] tty: tty_buffer: let tty_prepare_flip_string() return size_t
Date:   Wed, 16 Aug 2023 12:55:26 +0200
Message-ID: <20230816105530.3335-7-jirislaby@kernel.org>
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

The same as in the previous patch, tty_prepare_flip_string() accepts
size_t as an size argument. It returns the same size (or less). It is
unexpected that it returns a signed value and can confuse users to check
for negative values.

Instead, return the same size_t as accepted to make clear we return
values >= 0, where zero in fact means failure.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/tty_buffer.c | 5 +++--
 include/linux/tty_flip.h | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index 598891e53031..4f84466498f7 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -383,9 +383,9 @@ EXPORT_SYMBOL(__tty_insert_flip_char);
  * Returns: the length available and buffer pointer (@chars) to the space which
  * is now allocated and accounted for as ready for normal characters.
  */
-int tty_prepare_flip_string(struct tty_port *port, u8 **chars, size_t size)
+size_t tty_prepare_flip_string(struct tty_port *port, u8 **chars, size_t size)
 {
-	int space = __tty_buffer_request_room(port, size, false);
+	size_t space = __tty_buffer_request_room(port, size, false);
 
 	if (likely(space)) {
 		struct tty_buffer *tb = port->buf.tail;
@@ -395,6 +395,7 @@ int tty_prepare_flip_string(struct tty_port *port, u8 **chars, size_t size)
 			memset(flag_buf_ptr(tb, tb->used), TTY_NORMAL, space);
 		tb->used += space;
 	}
+
 	return space;
 }
 EXPORT_SYMBOL_GPL(tty_prepare_flip_string);
diff --git a/include/linux/tty_flip.h b/include/linux/tty_flip.h
index 569747364ae5..efd03d9c11f8 100644
--- a/include/linux/tty_flip.h
+++ b/include/linux/tty_flip.h
@@ -13,7 +13,7 @@ int tty_buffer_request_room(struct tty_port *port, size_t size);
 size_t __tty_insert_flip_string_flags(struct tty_port *port, const u8 *chars,
 				      const u8 *flags, bool mutable_flags,
 				      size_t size);
-int tty_prepare_flip_string(struct tty_port *port, u8 **chars, size_t size);
+size_t tty_prepare_flip_string(struct tty_port *port, u8 **chars, size_t size);
 void tty_flip_buffer_push(struct tty_port *port);
 int __tty_insert_flip_char(struct tty_port *port, u8 ch, u8 flag);
 
-- 
2.41.0

