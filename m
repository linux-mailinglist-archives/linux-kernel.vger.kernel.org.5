Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65546777438
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234021AbjHJJSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234802AbjHJJRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:17:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029F54683;
        Thu, 10 Aug 2023 02:16:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76496654D8;
        Thu, 10 Aug 2023 09:16:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDB11C433CA;
        Thu, 10 Aug 2023 09:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691658988;
        bh=mVyIZxSUZFmJlHVQlPsIoDxqmnEnvFNf08lke1pNFls=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MrYoPv9MeoxK/aq+w+EfBvuzqJ2nmenAAJIlpNu+Y6Ju6iXb9+iEQ5TrbiVdQVd+6
         anx2OIM/ktLdpNjMZotpt9/4ofB6W5HwXsvJxJOId3OnkO2j8ivGwZtTP3AyN3Q9/y
         G37iMdZWXe48FHYNWKz+DS50wMm198fcCMbNoVmpQCdXv74ZDFgzhmIMc7/Y52Dxlq
         jyn71TVVT5iIqkiR+3Mq5Rw0mc39L3edjVu1T6tKnHqzibsrDqCANUdHlw7ee8OCby
         xI1WzxcpX0jHnnPWMjn2p8WoTgfC1cP+S6E5xr894NnJBIJvLnB+FEDe5WL9LcAX9f
         SNoiJO/2nfxWA==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 30/36] tty: audit: unify to u8
Date:   Thu, 10 Aug 2023 11:15:04 +0200
Message-ID: <20230810091510.13006-31-jirislaby@kernel.org>
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

Somewhere, we use 'char', somewhere 'unsigned char'. Unify to 'u8' as
the rest of the tty layer does.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/tty.h       | 4 ++--
 drivers/tty/tty_audit.c | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/tty.h b/drivers/tty/tty.h
index e31cd9f281de..50862f98273e 100644
--- a/drivers/tty/tty.h
+++ b/drivers/tty/tty.h
@@ -101,13 +101,13 @@ extern int tty_ldisc_autoload;
 #ifdef CONFIG_AUDIT
 void tty_audit_add_data(const struct tty_struct *tty, const void *data,
 			size_t size);
-void tty_audit_tiocsti(const struct tty_struct *tty, char ch);
+void tty_audit_tiocsti(const struct tty_struct *tty, u8 ch);
 #else
 static inline void tty_audit_add_data(const struct tty_struct *tty,
 				      const void *data, size_t size)
 {
 }
-static inline void tty_audit_tiocsti(const struct tty_struct *tty, char ch)
+static inline void tty_audit_tiocsti(const struct tty_struct *tty, u8 ch)
 {
 }
 #endif
diff --git a/drivers/tty/tty_audit.c b/drivers/tty/tty_audit.c
index 24d010589379..1d81eeefb068 100644
--- a/drivers/tty/tty_audit.c
+++ b/drivers/tty/tty_audit.c
@@ -17,7 +17,7 @@ struct tty_audit_buf {
 	dev_t dev;		/* The TTY which the data is from */
 	bool icanon;
 	size_t valid;
-	unsigned char *data;	/* Allocated size N_TTY_BUF_SIZE */
+	u8 *data;		/* Allocated size N_TTY_BUF_SIZE */
 };
 
 static struct tty_audit_buf *tty_audit_buf_ref(void)
@@ -59,7 +59,7 @@ static void tty_audit_buf_free(struct tty_audit_buf *buf)
 }
 
 static void tty_audit_log(const char *description, dev_t dev,
-			  const unsigned char *data, size_t size)
+			  const u8 *data, size_t size)
 {
 	struct audit_buffer *ab;
 	pid_t pid = task_pid_nr(current);
@@ -134,7 +134,7 @@ void tty_audit_fork(struct signal_struct *sig)
 /*
  *	tty_audit_tiocsti	-	Log TIOCSTI
  */
-void tty_audit_tiocsti(const struct tty_struct *tty, char ch)
+void tty_audit_tiocsti(const struct tty_struct *tty, u8 ch)
 {
 	dev_t dev;
 
-- 
2.41.0

