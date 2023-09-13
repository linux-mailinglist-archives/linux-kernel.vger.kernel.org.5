Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F7979EF31
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 18:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbjIMQrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 12:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbjIMQrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 12:47:06 -0400
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE121BE7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 09:44:16 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id gSyJqOeao1XYugSyJqLbyP; Wed, 13 Sep 2023 18:44:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1694623454;
        bh=KhBqET0/GFce4q4wy/Li4fUXHKskJM4nNy8BipmRPzo=;
        h=From:To:Cc:Subject:Date;
        b=tY4NOT8kx5AWJLO9A13ip+OzfDc65GfRtGqE/jQh9Lho1C7UfalXDV70QsuL4sKhy
         4yXHIWD5tqQh4a/JGcTZURyVkemXF4U97i4ZlNN3pxo7Q4YfjN3mwF1FBDyljIqr/g
         bSk4uZQvtcvo4N5JfnOgTPZ829m0Oi7yV9FQZqh6cqegUZbFlnGAXH21ntRyImrIig
         eY/GbFTuqfc+pmZcRR0ak375ydz3SeXyAEn82DQipTzZJb9usXJWoEL2slYAAR+yW6
         l0QF/m3JX6tWSL6cLiXmEe4FeY+9KZthCFBo8Q/85Mnp4+zUuLXXlBgM1Vj+0kFUAS
         9xsUnjVwwiZgg==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 13 Sep 2023 18:44:14 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Kent Overstreet <kent.overstreet@linux.dev>,
        Brian Foster <bfoster@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-bcachefs@vger.kernel.org
Subject: [PATCH 1/2] bcachefs: Fix a potential in the error handling path of use-after-free inbch2_dev_add()
Date:   Wed, 13 Sep 2023 18:44:08 +0200
Message-Id: <3ab17a294fd2b5fcb180d44955b0d76a28af11cb.1694623395.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If __bch2_dev_attach_bdev() fails, bch2_dev_free() is called twice.
Once here and another time in the error handling path.

This leads to several use-after-free.

Remove the redundant call and only rely on the error handling path.

Fixes: 6a44735653d4 ("bcachefs: Improved superblock-related error messages")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 fs/bcachefs/super.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/bcachefs/super.c b/fs/bcachefs/super.c
index 29cd71445a94..7379325c428f 100644
--- a/fs/bcachefs/super.c
+++ b/fs/bcachefs/super.c
@@ -1617,10 +1617,8 @@ int bch2_dev_add(struct bch_fs *c, const char *path)
 	bch2_dev_usage_init(ca);
 
 	ret = __bch2_dev_attach_bdev(ca, &sb);
-	if (ret) {
-		bch2_dev_free(ca);
+	if (ret)
 		goto err;
-	}
 
 	ret = bch2_dev_journal_alloc(ca);
 	if (ret) {
-- 
2.34.1

