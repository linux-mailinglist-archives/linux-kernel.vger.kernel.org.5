Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B957F28AB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 10:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbjKUJXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 04:23:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbjKUJXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 04:23:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A14C1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 01:23:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DB03C433CA;
        Tue, 21 Nov 2023 09:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700558585;
        bh=mTUBCg9Yy/6tTejWqtj99Kn79h3uid57bb+Gyj0JwX8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YiCF7hYQDFJ7iZfFuIc0whqlPUrb5gJbYUxDcESqiskN1TNAL55wg+KmOhTb8VpUk
         /9zSCYWOyK7dKNuVCYzbuMKlBIpesIQ1wqDe0Ac5LaRPZZUNbP8ATRclwuvKseiO3h
         sr9wY7zH3J6s62Tng2++B0rSi8xfhhWQxw+IlCMxsng8k5fl9HEmc6mtCMODBipFUe
         d8uzTK8zPrYYH0nKfhzMQrMbMbBq58MxL0MhrbWEjvSxuVsJVFZgyoAgNlGeLPIdWO
         j/4tCayQOZttxL3FwOoKxfCGfZ456y4zkP0C77Sh+u4w3WFmJ0TdJdQZO7yp/0dyd4
         b7ZbqzonWr9jA==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Jan Kara <jack@suse.com>
Subject: [PATCH 01/17] tty: deprecate tty_write_message()
Date:   Tue, 21 Nov 2023 10:22:42 +0100
Message-ID: <20231121092258.9334-2-jirislaby@kernel.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231121092258.9334-1-jirislaby@kernel.org>
References: <20231121092258.9334-1-jirislaby@kernel.org>
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

tty_write_message() has only one user: quotas. In particular, there the
use depends on CONFIG_PRINT_QUOTA_WARNING. And that is deprecated and
marked as BROKEN already too.

So make tty_write_message() dependent on that very config option. This
action in fact drops tty_write_message() from the vmlinux binary. Good
riddance.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Jan Kara <jack@suse.com>
---
 drivers/tty/tty_io.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 06414e43e0b5..ee5a90f9adb5 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1047,6 +1047,7 @@ static ssize_t iterate_tty_write(struct tty_ldisc *ld, struct tty_struct *tty,
 	return ret;
 }
 
+#ifdef CONFIG_PRINT_QUOTA_WARNING
 /**
  * tty_write_message - write a message to a certain tty, not just the console.
  * @tty: the destination tty_struct
@@ -1057,6 +1058,8 @@ static ssize_t iterate_tty_write(struct tty_ldisc *ld, struct tty_struct *tty,
  * needed.
  *
  * We must still hold the BTM and test the CLOSING flag for the moment.
+ *
+ * This function is DEPRECATED, do not use in new code.
  */
 void tty_write_message(struct tty_struct *tty, char *msg)
 {
@@ -1069,6 +1072,7 @@ void tty_write_message(struct tty_struct *tty, char *msg)
 		tty_write_unlock(tty);
 	}
 }
+#endif
 
 static ssize_t file_tty_write(struct file *file, struct kiocb *iocb, struct iov_iter *from)
 {
-- 
2.42.1

