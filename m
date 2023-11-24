Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19A77F6C27
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 07:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbjKXGKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 01:10:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbjKXGJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 01:09:40 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3478619B3;
        Thu, 23 Nov 2023 22:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Cet6Nt7zHt9dF+avtU3X4iivMWHATqCMWAfCRcJL1cU=; b=wVhX3ODBvSIZDQuNZLMmjsbO65
        vP/bNlyV2VhaieRId7MaWGpKvBGwmR5ksCX1JhYy8W1q0mTQNeRXinTRxCn++ns/E178TZXypQSNH
        lacVubiRsJxVm9Hc42qJEVuAsDjAiTM9uQfv5cPZP01ZNKnORGjCnMCQdUbO6LEm+zfCWeF1wp43g
        i9Nlib//RInFqLYm8izX/nm6YWIejLfbMoleepbyY9AgjS+NiDW5ebAOhhQLQw219Kft3STGEgx3y
        JN8wW4eqqlGks+cMsAzJyQ2wACRIYIqtEpLBeYeyt/KYjOVK5Sfxs6TR2fOVOYwhsb1Cp3M3RONvs
        yj0VmMiw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1r6PKu-002Q0M-2d;
        Fri, 24 Nov 2023 06:06:44 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/20] ovl: stop using d_alloc_anon()/d_instantiate_anon()
Date:   Fri, 24 Nov 2023 06:06:26 +0000
Message-Id: <20231124060644.576611-2-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231124060644.576611-1-viro@zeniv.linux.org.uk>
References: <20231124060553.GA575483@ZenIV>
 <20231124060644.576611-1-viro@zeniv.linux.org.uk>
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

From: Amir Goldstein <amir73il@gmail.com>

Commit f9c34674bc60 ("vfs: factor out helpers d_instantiate_anon() and
d_alloc_anon()") was introduced so overlayfs could initialize a non-dir
disconnected overlay dentry before overlay inode is attached to it.

Since commit ("0af950f57fef ovl: move ovl_entry into ovl_inode"), all
ovl_obtain_alias() can do is set DCACHE_OP_*REVALIDATE flags in ->d_flags
and OVL_E_UPPER_ALIAS flag in ->d_fsdata.

The DCACHE_OP_*REVALIDATE flags and OVL_E_UPPER_ALIAS flag are irrelevant
for a disconnected non-dir dentry, so it is better to use d_obtain_alias()
instead of open coding it.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/overlayfs/export.c | 23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
index 7e16bbcad95e..9e316d5f936e 100644
--- a/fs/overlayfs/export.c
+++ b/fs/overlayfs/export.c
@@ -289,7 +289,6 @@ static struct dentry *ovl_obtain_alias(struct super_block *sb,
 {
 	struct dentry *lower = lowerpath ? lowerpath->dentry : NULL;
 	struct dentry *upper = upper_alias ?: index;
-	struct dentry *dentry;
 	struct inode *inode = NULL;
 	struct ovl_entry *oe;
 	struct ovl_inode_params oip = {
@@ -320,27 +319,7 @@ static struct dentry *ovl_obtain_alias(struct super_block *sb,
 	if (upper)
 		ovl_set_flag(OVL_UPPERDATA, inode);
 
-	dentry = d_find_any_alias(inode);
-	if (dentry)
-		goto out_iput;
-
-	dentry = d_alloc_anon(inode->i_sb);
-	if (unlikely(!dentry))
-		goto nomem;
-
-	if (upper_alias)
-		ovl_dentry_set_upper_alias(dentry);
-
-	ovl_dentry_init_reval(dentry, upper, OVL_I_E(inode));
-
-	return d_instantiate_anon(dentry, inode);
-
-nomem:
-	dput(dentry);
-	dentry = ERR_PTR(-ENOMEM);
-out_iput:
-	iput(inode);
-	return dentry;
+	return d_obtain_alias(inode);
 }
 
 /* Get the upper or lower dentry in stack whose on layer @idx */
-- 
2.39.2

