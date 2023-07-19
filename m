Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5016275975F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 15:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjGSNu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 09:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGSNuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 09:50:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE63D19A
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 06:50:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2464D6162A
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 13:50:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24012C433C8;
        Wed, 19 Jul 2023 13:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689774652;
        bh=eTOECLHt5+G+o9Vzad3QTBIsWxNKNRHb3k78HAMje+8=;
        h=From:To:Cc:Subject:Date:From;
        b=Y2O5BFAoZ2CHTqSqwUJ+RPN9ykaUQawY0y4u8GAS36D4HWhlinDsm4+7QPOKx24q5
         bWywxYLgM+Fiz41q9cAkeu1U5vuXrCcRzNHMyhHzOIYVhax2+T6X2hdKhWBC2pULjp
         HKgjEr8Sk7U7FopdiTWnW25uU3rK6ZgfqF0JAHcTJpXL+jAQvXE1yRkMzb47E7QoBy
         GLvFDLiBTA6tMoTUTqUy7o/9trJJyc9K8tYBdSvnLg+sfIBUauYuw2HepkDS9pXALW
         FzC4BGe5kvZ9c5p+vO1vr2DqI3LlKEJ+zBQcOxyhAZxrs/C8NpFoZeaoQ/QvqM/0em
         d0Ux4ToiuYyAw==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH 1/2] f2fs: fix to update i_ctime in __f2fs_setxattr()
Date:   Wed, 19 Jul 2023 21:50:45 +0800
Message-Id: <20230719135047.2947030-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
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

generic/728       - output mismatch (see /media/fstests/results//generic/728.out.bad)
    --- tests/generic/728.out	2023-07-19 07:10:48.362711407 +0000
    +++ /media/fstests/results//generic/728.out.bad	2023-07-19 08:39:57.000000000 +0000
     QA output created by 728
    +Expected ctime to change after setxattr.
    +Expected ctime to change after removexattr.
     Silence is golden
    ...
    (Run 'diff -u /media/fstests/tests/generic/728.out /media/fstests/results//generic/728.out.bad'  to see the entire diff)
generic/729        1s

It needs to update i_ctime after {set,remove}xattr, fix it.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/xattr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 476b186b90a6..71bfa2391ab4 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -757,17 +757,17 @@ static int __f2fs_setxattr(struct inode *inode, int index,
 	if (index == F2FS_XATTR_INDEX_ENCRYPTION &&
 			!strcmp(name, F2FS_XATTR_NAME_ENCRYPTION_CONTEXT))
 		f2fs_set_encrypted_inode(inode);
-	f2fs_mark_inode_dirty_sync(inode, true);
 	if (!error && S_ISDIR(inode->i_mode))
 		set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_CP);
 
 same:
 	if (is_inode_flag_set(inode, FI_ACL_MODE)) {
 		inode->i_mode = F2FS_I(inode)->i_acl_mode;
-		inode->i_ctime = current_time(inode);
 		clear_inode_flag(inode, FI_ACL_MODE);
 	}
 
+	inode->i_ctime = current_time(inode);
+	f2fs_mark_inode_dirty_sync(inode, true);
 exit:
 	kfree(base_addr);
 	return error;
-- 
2.40.1

