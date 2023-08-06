Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676CA771325
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 03:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjHFB1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 21:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHFB1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 21:27:00 -0400
Received: from smtp01.aussiebb.com.au (smtp01.aussiebb.com.au [121.200.0.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEAC2109
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 18:26:58 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id 78E4110030F
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 11:26:52 +1000 (AEST)
X-Virus-Scanned: Debian amavisd-new at smtp01.aussiebb.com.au
Received: from smtp01.aussiebb.com.au ([127.0.0.1])
        by localhost (smtp01.aussiebb.com.au [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3lmYV9Gsp3gr for <linux-kernel@vger.kernel.org>;
        Sun,  6 Aug 2023 11:26:52 +1000 (AEST)
Received: by smtp01.aussiebb.com.au (Postfix, from userid 116)
        id 6E7C01003BD; Sun,  6 Aug 2023 11:26:52 +1000 (AEST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
Received: from donald.themaw.net (2403-580e-4b40-0-7968-2232-4db8-a45e.ip6.aussiebb.net [IPv6:2403:580e:4b40:0:7968:2232:4db8:a45e])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id E6F9C10028C;
        Sun,  6 Aug 2023 11:26:49 +1000 (AEST)
Subject: [PATCH] kernfs: fix missing kernfs_iattr_rwsem locking
From:   Ian Kent <raven@themaw.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Imran Khan <imran.f.khan@oracle.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Minchan Kim <minchan@kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>
Date:   Sun, 06 Aug 2023 09:26:49 +0800
Message-ID: <169128520941.68052.15749253469930138901.stgit@donald.themaw.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the kernfs_iattr_rwsem was introduced a case was missed.

The update of the kernfs directory node child count was also protected
by the kernfs_rwsem and needs to be included in the change so that the
child count (and so the inode n_link attribute) does not change while
holding the rwsem for read.

Fixes: 9caf696142 (kernfs: Introduce separate rwsem to protect inode
attributes)

Signed-off-by: Ian Kent <raven@themaw.net>
Reviewed-By: Imran Khan <imran.f.khan@oracle.com>
Acked-by: Miklos Szeredi <mszeredi@redhat.com>
Cc: Anders Roxell <anders.roxell@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Eric Sandeen <sandeen@sandeen.net>
---
 fs/kernfs/dir.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 5a1a4af9d3d2..bf243015834e 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -383,9 +383,11 @@ static int kernfs_link_sibling(struct kernfs_node *kn)
 	rb_insert_color(&kn->rb, &kn->parent->dir.children);
 
 	/* successfully added, account subdir number */
+	down_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
 	if (kernfs_type(kn) == KERNFS_DIR)
 		kn->parent->dir.subdirs++;
 	kernfs_inc_rev(kn->parent);
+	up_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
 
 	return 0;
 }
@@ -408,9 +410,11 @@ static bool kernfs_unlink_sibling(struct kernfs_node *kn)
 	if (RB_EMPTY_NODE(&kn->rb))
 		return false;
 
+	down_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
 	if (kernfs_type(kn) == KERNFS_DIR)
 		kn->parent->dir.subdirs--;
 	kernfs_inc_rev(kn->parent);
+	up_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
 
 	rb_erase(&kn->rb, &kn->parent->dir.children);
 	RB_CLEAR_NODE(&kn->rb);


