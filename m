Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B148F80BC62
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 18:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbjLJRcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 12:32:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbjLJRcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 12:32:16 -0500
Received: from smtp.smtpout.orange.fr (smtp-24.smtpout.orange.fr [80.12.242.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61C2106
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 09:32:22 -0800 (PST)
Received: from pop-os.home ([92.140.202.140])
        by smtp.orange.fr with ESMTPA
        id CNfArZE5YMO0QCNfArYiy3; Sun, 10 Dec 2023 18:32:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1702229541;
        bh=7R7swsMSVHfAzgaVMpMek+u6m1tMZkWO2VT0rabXWAg=;
        h=From:To:Cc:Subject:Date;
        b=ae4o7v/MuPampl5degm+HCMI8B3Q9AJOxB0cLwF+02eFNh3cGN6E/yK0yk8qorsVS
         5n1FzNxiqP9Xy37TozLxocH4ry3B4R0ro3DpLtZQuNGbJHpxGzkUMSMJYM2/V+ixVW
         sWvxJNPdjuGMVvoF6/GiKgnG7j6jLSqo2uDNiLiJ4O6DBWAqQn4tbXHgWMTdWntZKY
         bxsYpx9Iey7sfoa8q2e6z7q0k0zdGBMOVrsNy3XDbOoQu32013IjbGMZG0YZ0ocNup
         bUux/Wl5JUJfbUwCYJl8r83RDDA0gxmhVsMwtdtTHihaJBvX/nhbPLXoyepiTkW5/G
         qg/Hi8SfyuI+w==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 10 Dec 2023 18:32:21 +0100
X-ME-IP: 92.140.202.140
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] eventfd: Remove usage of the deprecated ida_simple_xx() API
Date:   Sun, 10 Dec 2023 18:32:18 +0100
Message-Id: <575dcecd51097dd30c5515f9f0ed92076b4ef403.1702229520.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ida_alloc() and ida_free() should be preferred to the deprecated
ida_simple_get() and ida_simple_remove().

This is less verbose.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 fs/eventfd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/eventfd.c b/fs/eventfd.c
index 16bea05a7c78..ad8186d47ba7 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -82,7 +82,7 @@ EXPORT_SYMBOL_GPL(eventfd_signal_mask);
 static void eventfd_free_ctx(struct eventfd_ctx *ctx)
 {
 	if (ctx->id >= 0)
-		ida_simple_remove(&eventfd_ida, ctx->id);
+		ida_free(&eventfd_ida, ctx->id);
 	kfree(ctx);
 }
 
@@ -395,7 +395,7 @@ static int do_eventfd(unsigned int count, int flags)
 	init_waitqueue_head(&ctx->wqh);
 	ctx->count = count;
 	ctx->flags = flags;
-	ctx->id = ida_simple_get(&eventfd_ida, 0, 0, GFP_KERNEL);
+	ctx->id = ida_alloc(&eventfd_ida, GFP_KERNEL);
 
 	flags &= EFD_SHARED_FCNTL_FLAGS;
 	flags |= O_RDWR;
-- 
2.34.1

