Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88D977742B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234662AbjHJJR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234644AbjHJJQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:16:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B304D3ABA;
        Thu, 10 Aug 2023 02:16:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 940BA654E3;
        Thu, 10 Aug 2023 09:16:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9CF4C433BD;
        Thu, 10 Aug 2023 09:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691658965;
        bh=CVFOtvonh6meYc8HrCladmLIao6ps5X4Ijcg1YpOOr8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hK2KkwV3BNAlyj3EAEWxUYhari6Nob9fTpmXvyB+udVapc04cylMees/Syyzoua15
         B49vyYQm1vQ92N+/lrN8yPqKMOuVJkXomem9ei3w7cASUlLAQmJ/azRI72j8+K7D3D
         Etz1qAi03bKTD/L2QDWY0LI4oTWBUjTT2aCMdw2Zm7DVlD0RDF+8Ww47m9fmFbfmwK
         dx9CeoA+MJkuG1tjzpV/LYgdWEbrfgwLHUIgGZIuNRAIo77PFs3BcsnGKYiOLuwMjq
         O6pLf1dZ2kY+prE7YBLbthCwD9WVxPr9FwDsc42dQUIlXMbvTa+DSw7fo3sD9caTRa
         SkkodOsBwG3FQ==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 21/36] tty: don't pass write() to do_tty_write()
Date:   Thu, 10 Aug 2023 11:14:55 +0200
Message-ID: <20230810091510.13006-22-jirislaby@kernel.org>
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

write() passed to do_tty_write() is always ld->ops->write(). Instead,
align with iterate_tty_read() and pass the whole ld instead. This makes
the code easier to follow as it is clear what the write is. And also the
function signature is more readable.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/tty_io.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 54036a20a102..ea5041fbbf28 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -961,11 +961,8 @@ int tty_write_lock(struct tty_struct *tty, bool ndelay)
  * Split writes up in sane blocksizes to avoid
  * denial-of-service type attacks
  */
-static inline ssize_t do_tty_write(
-	ssize_t (*write)(struct tty_struct *, struct file *, const unsigned char *, size_t),
-	struct tty_struct *tty,
-	struct file *file,
-	struct iov_iter *from)
+static inline ssize_t do_tty_write(struct tty_ldisc *ld, struct tty_struct *tty,
+				   struct file *file, struct iov_iter *from)
 {
 	size_t count = iov_iter_count(from);
 	ssize_t ret, written = 0;
@@ -1022,7 +1019,7 @@ static inline ssize_t do_tty_write(
 		if (copy_from_iter(tty->write_buf, size, from) != size)
 			break;
 
-		ret = write(tty, file, tty->write_buf, size);
+		ret = ld->ops->write(tty, file, tty->write_buf, size);
 		if (ret <= 0)
 			break;
 
@@ -1093,7 +1090,7 @@ static ssize_t file_tty_write(struct file *file, struct kiocb *iocb, struct iov_
 	if (!ld->ops->write)
 		ret = -EIO;
 	else
-		ret = do_tty_write(ld->ops->write, tty, file, from);
+		ret = do_tty_write(ld, tty, file, from);
 	tty_ldisc_deref(ld);
 	return ret;
 }
-- 
2.41.0

