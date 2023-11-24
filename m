Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96287F6BED
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 07:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjKXGEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 01:04:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjKXGER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 01:04:17 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03554D71;
        Thu, 23 Nov 2023 22:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=t2zwzPnF/uf/2oUVGi0n4GR0yi2cLzOWPO2ZTLid9cY=; b=bzl/4PNtx7A7UmHIJuWGbYesMX
        3YBns84+Z3wUeS19etV4FUGGskdaoSPZZ35wqX46z7gSRPDYGO09ETLKALzHsMUpqgLREz9q0zQAe
        08WzGcqFC7Bi49RK/90zKSBklXfKYhGySNc+hKFExGVBZsrUs7s7izI6Vx+kZsSWNygX4FXQjNjNV
        vZZRweGyBQIBWerpNK4ZPB/B9VGGWObgYRhBcuhAax6GJ0tWuYJl+0TEWJ6uCI6d8b4JKlHvG7Czz
        +oj0fsYCrvfQ/CbVELuI3K5rNQoGe8TU4fdy36JTMIo7YLRuP7p//WL91yRdqbr+nP0QBvbH5ClMg
        Au1GWXRw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1r6PIc-002Ptf-25;
        Fri, 24 Nov 2023 06:04:22 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/21] coda_flag_children(): cope with dentries turning negative
Date:   Fri, 24 Nov 2023 06:04:03 +0000
Message-Id: <20231124060422.576198-2-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231124060422.576198-1-viro@zeniv.linux.org.uk>
References: <20231124060200.GR38156@ZenIV>
 <20231124060422.576198-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

->d_lock on parent does not stabilize ->d_inode of child.
We don't do much with that inode in there, but we need
at least to avoid struct inode getting freed under us...

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/coda/cache.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/coda/cache.c b/fs/coda/cache.c
index 3b8c4513118f..bfbc03c6b632 100644
--- a/fs/coda/cache.c
+++ b/fs/coda/cache.c
@@ -92,13 +92,16 @@ static void coda_flag_children(struct dentry *parent, int flag)
 {
 	struct dentry *de;
 
+	rcu_read_lock();
 	spin_lock(&parent->d_lock);
 	list_for_each_entry(de, &parent->d_subdirs, d_child) {
+		struct inode *inode = d_inode_rcu(de);
 		/* don't know what to do with negative dentries */
-		if (d_inode(de) ) 
-			coda_flag_inode(d_inode(de), flag);
+		if (inode)
+			coda_flag_inode(inode, flag);
 	}
 	spin_unlock(&parent->d_lock);
+	rcu_read_unlock();
 	return; 
 }
 
-- 
2.39.2

