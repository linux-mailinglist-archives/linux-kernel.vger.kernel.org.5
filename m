Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B55047EDB87
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 07:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjKPG0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 01:26:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjKPG0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 01:26:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3039B199
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 22:26:03 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A5B1C433C7;
        Thu, 16 Nov 2023 06:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700115962;
        bh=LdQ7fpYx4XjHDzsyZXb0qCihyPciooXY4TAlO70WFe0=;
        h=From:To:Cc:Subject:Date:From;
        b=tjzg/XJu3pN7sLj7482nvRPWD4ZfXv+y3cwgmIn6dzesDklcub5lzV2vPAqSnq+xi
         5sZ7lQgMTzc2xmxBS6TyyrrJiYgw14NCfohsaxtFcZyGBdtI2aepFCjc6SiL1R5AWa
         7qSuKpJq3NNgR4vN4xPVMO2APRWkFgIiSBIrB0vXvcKmhfTw/bwSbELJZgnigeMgtH
         ojsdDCKgTnsOmXziWm7yNe61anSBtCITcLPKy1/W1jbUrXpqBaA6KMid+xG/03Gg7S
         vcvqH0+aXghk7vYHW3L9C9998PKLak/kDOGlwGBodDMS4ztHxM7QyZ4VgE36uIgXuP
         JognBF4pI0rWw==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH 1/3] f2fs: clean up w/ dotdot_name
Date:   Thu, 16 Nov 2023 14:25:54 +0800
Message-Id: <20231116062556.2451839-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just cleanup, no logic changes.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/namei.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index d0053b0284d8..a9360ee02da1 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -459,7 +459,6 @@ static int __recover_dot_dentries(struct inode *dir, nid_t pino)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
 	struct qstr dot = QSTR_INIT(".", 1);
-	struct qstr dotdot = QSTR_INIT("..", 2);
 	struct f2fs_dir_entry *de;
 	struct page *page;
 	int err = 0;
@@ -497,13 +496,13 @@ static int __recover_dot_dentries(struct inode *dir, nid_t pino)
 			goto out;
 	}
 
-	de = f2fs_find_entry(dir, &dotdot, &page);
+	de = f2fs_find_entry(dir, &dotdot_name, &page);
 	if (de)
 		f2fs_put_page(page, 0);
 	else if (IS_ERR(page))
 		err = PTR_ERR(page);
 	else
-		err = f2fs_do_add_link(dir, &dotdot, NULL, pino, S_IFDIR);
+		err = f2fs_do_add_link(dir, &dotdot_name, NULL, pino, S_IFDIR);
 out:
 	if (!err)
 		clear_inode_flag(dir, FI_INLINE_DOTS);
-- 
2.40.1

