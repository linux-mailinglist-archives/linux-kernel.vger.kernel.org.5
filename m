Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A5977742E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234749AbjHJJRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234824AbjHJJQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:16:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519383C3F;
        Thu, 10 Aug 2023 02:16:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3351E654D7;
        Thu, 10 Aug 2023 09:16:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B769C433CB;
        Thu, 10 Aug 2023 09:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691658969;
        bh=Vi6KT4QvtAHnTvdxRC1kSrINmrad6wcc2VnvldKgNCM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HbLcLcbMjKnUNqaPuBZZUMEwHGFvDqs9XGZjASj/LBarP5KVCd12b0Gky97IyA/BW
         AgTNXQUjFq/1WI39fUT6DH2SIpHrTBkqFD+fnoNCwESmbr0j8tuIrfRkBHmw6mKwKP
         UX6t3WeeYKv9i2gTxbn3JqffoZu+XRnPL0kro0Ce3Xh8GyPUlkiLt/CK2lJrL+EqrQ
         LMYeecs1fCEIeOW+BDd4rTw7oIg9Rp27U0ozGPvX5wutI+tUeDKNbuTvYkJRPf7lci
         OVMzhbQHDbZmlCmk7bijx6RmI6Gl+8Pgi0+ldkdrrIWO40cjCkx6rAhV5+CAl0awj+
         KPCNih4MJXidw==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 24/36] tty: use ssize_t for iterate_tty_read() returned type
Date:   Thu, 10 Aug 2023 11:14:58 +0200
Message-ID: <20230810091510.13006-25-jirislaby@kernel.org>
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

tty_read() is supposed to return ssize_t. It takes the return value from
iterate_tty_read(). That currently returns int. On the top of that,
iterate_tty_write() already returns ssize_t. So switch
iterate_tty_read() to ssize_t too, so that all three are consistent.

This means 'i' in tty_read() changes its type too. And while changing
that, rename this generic 'i' to more dedicated 'ret'.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/tty_io.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 0cf1277e260b..e8248773e3f0 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -843,13 +843,13 @@ static void tty_update_time(struct tty_struct *tty, bool mtime)
  * data or clears the cookie. The cookie may be something that the
  * ldisc maintains state for and needs to free.
  */
-static int iterate_tty_read(struct tty_ldisc *ld, struct tty_struct *tty,
-		struct file *file, struct iov_iter *to)
+static ssize_t iterate_tty_read(struct tty_ldisc *ld, struct tty_struct *tty,
+				struct file *file, struct iov_iter *to)
 {
-	int retval = 0;
 	void *cookie = NULL;
 	unsigned long offset = 0;
 	char kernel_buf[64];
+	ssize_t retval = 0;
 	size_t count = iov_iter_count(to);
 
 	do {
@@ -912,11 +912,11 @@ static int iterate_tty_read(struct tty_ldisc *ld, struct tty_struct *tty,
  */
 static ssize_t tty_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	int i;
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
 	struct tty_struct *tty = file_tty(file);
 	struct tty_ldisc *ld;
+	ssize_t ret;
 
 	if (tty_paranoia_check(tty, inode, "tty_read"))
 		return -EIO;
@@ -929,15 +929,15 @@ static ssize_t tty_read(struct kiocb *iocb, struct iov_iter *to)
 	ld = tty_ldisc_ref_wait(tty);
 	if (!ld)
 		return hung_up_tty_read(iocb, to);
-	i = -EIO;
+	ret = -EIO;
 	if (ld->ops->read)
-		i = iterate_tty_read(ld, tty, file, to);
+		ret = iterate_tty_read(ld, tty, file, to);
 	tty_ldisc_deref(ld);
 
-	if (i > 0)
+	if (ret > 0)
 		tty_update_time(tty, false);
 
-	return i;
+	return ret;
 }
 
 void tty_write_unlock(struct tty_struct *tty)
-- 
2.41.0

