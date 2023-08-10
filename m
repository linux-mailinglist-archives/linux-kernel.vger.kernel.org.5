Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9DA77742C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234739AbjHJJRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234698AbjHJJQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:16:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9DA3C2A;
        Thu, 10 Aug 2023 02:16:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9BC5654E7;
        Thu, 10 Aug 2023 09:16:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0843EC433C9;
        Thu, 10 Aug 2023 09:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691658968;
        bh=IB0hueHyK3s8u1ECn26OKi6iqqaceaJXgBWW7btEaaE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mHZNMbwj1MnnCeLdtrTf2s66/O+j1ggY1IbheoYNwEcnUUm+JSEeKXMRteP92DE0Z
         LaY+LvVx3ezt3aEDnMZwQWGdLbS/fCzdqvz9r6Erh4uE+abQgpjNfE98FTjmc+CDYp
         TMHcQ83ltUAgE//QVPeBJ4G6ADWdVAxb9adOlRYC2ZYp+60oLS5TcVEi+ild20GZbK
         HGhSwPcKiePICG68ciE3i+YDeF/Deu9BtmccXrUkPQY14+keD1EcXkTtRoBybYzBPt
         5Q28/mpbRyCLx+b8Leh2fxsTYc4+og4ipG/cIrKrF02bVdqcnrLrba3KtWZxEtqyrU
         erEVLq1ebyaXg==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 23/36] tty: use min() in iterate_tty_write()
Date:   Thu, 10 Aug 2023 11:14:57 +0200
Message-ID: <20230810091510.13006-24-jirislaby@kernel.org>
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

It simplifies the code. The "price" is we have to unify 'chunk' to be
size_t the same as 'count' is. But that change is actually correct.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/tty_io.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 846460c02c58..0cf1277e260b 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -964,9 +964,8 @@ int tty_write_lock(struct tty_struct *tty, bool ndelay)
 static ssize_t iterate_tty_write(struct tty_ldisc *ld, struct tty_struct *tty,
 				 struct file *file, struct iov_iter *from)
 {
-	size_t count = iov_iter_count(from);
+	size_t chunk, count = iov_iter_count(from);
 	ssize_t ret, written = 0;
-	unsigned int chunk;
 
 	ret = tty_write_lock(tty, file->f_flags & O_NDELAY);
 	if (ret < 0)
@@ -1010,10 +1009,7 @@ static ssize_t iterate_tty_write(struct tty_ldisc *ld, struct tty_struct *tty,
 
 	/* Do the write .. */
 	for (;;) {
-		size_t size = count;
-
-		if (size > chunk)
-			size = chunk;
+		size_t size = min(chunk, count);
 
 		ret = -EFAULT;
 		if (copy_from_iter(tty->write_buf, size, from) != size)
-- 
2.41.0

