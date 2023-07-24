Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7702175E7E8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbjGXBgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbjGXBfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:35:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269D749F4;
        Sun, 23 Jul 2023 18:32:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B73060F73;
        Mon, 24 Jul 2023 01:31:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C33EC433C8;
        Mon, 24 Jul 2023 01:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690162284;
        bh=tYVVUQ5QvJhxCcxzi5B1Xh2p7sB0q7I0ozxtNFjT9EI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aiCXqkRd9gciCJEPx41WuDDB7RJJVJOuKG3FG13x5ux6sCe6oSdfh61yHaw6yaN5m
         Fc9eIW0aMvu1nbUCT6Zxlu/fEB4y8BpC8rZwtLtJrCb0eRm7opQJqFJAvbw2CCQo7e
         Ite0WZz/EsFHp42TwUfhd8wFGgfyxAF7AAzP5aHhhshtHEuTQgq68/pKe3cUIQ4c6m
         Az4RRTNf3WuepVVOuKipCKHTKhWdWZEzJNHEwLXabY2bWRY9rypcNUhic9nLik3VZ0
         zNC7C0YMNi4LgWkmJJ+7btNIN41scT44DPInlmOiC3JhSzZ1qLIZ9BpXCEIAcXZIMN
         ZFOUzlsiEsVPg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Paulo Alcantara <pc@manguebit.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.1 2/3] smb: client: fix warning in cifs_smb3_do_mount()
Date:   Sun, 23 Jul 2023 21:31:18 -0400
Message-Id: <20230724013119.2327427-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724013119.2327427-1-sashal@kernel.org>
References: <20230724013119.2327427-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.40
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paulo Alcantara <pc@manguebit.com>

[ Upstream commit 12c30f33cc6769bf411088a2872843c4f9ea32f9 ]

This fixes the following warning reported by kernel test robot

  fs/smb/client/cifsfs.c:982 cifs_smb3_do_mount() warn: possible
  memory leak of 'cifs_sb'

Link: https://lore.kernel.org/all/202306170124.CtQqzf0I-lkp@intel.com/
Signed-off-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsfs.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index 078df1e2dd18a..18d66497c42d1 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -883,11 +883,11 @@ struct dentry *
 cifs_smb3_do_mount(struct file_system_type *fs_type,
 	      int flags, struct smb3_fs_context *old_ctx)
 {
-	int rc;
-	struct super_block *sb = NULL;
-	struct cifs_sb_info *cifs_sb = NULL;
 	struct cifs_mnt_data mnt_data;
+	struct cifs_sb_info *cifs_sb;
+	struct super_block *sb;
 	struct dentry *root;
+	int rc;
 
 	/*
 	 * Prints in Kernel / CIFS log the attempted mount operation
@@ -898,11 +898,9 @@ cifs_smb3_do_mount(struct file_system_type *fs_type,
 	else
 		cifs_info("Attempting to mount %s\n", old_ctx->UNC);
 
-	cifs_sb = kzalloc(sizeof(struct cifs_sb_info), GFP_KERNEL);
-	if (cifs_sb == NULL) {
-		root = ERR_PTR(-ENOMEM);
-		goto out;
-	}
+	cifs_sb = kzalloc(sizeof(*cifs_sb), GFP_KERNEL);
+	if (!cifs_sb)
+		return ERR_PTR(-ENOMEM);
 
 	cifs_sb->ctx = kzalloc(sizeof(struct smb3_fs_context), GFP_KERNEL);
 	if (!cifs_sb->ctx) {
@@ -945,10 +943,8 @@ cifs_smb3_do_mount(struct file_system_type *fs_type,
 
 	sb = sget(fs_type, cifs_match_super, cifs_set_super, flags, &mnt_data);
 	if (IS_ERR(sb)) {
-		root = ERR_CAST(sb);
 		cifs_umount(cifs_sb);
-		cifs_sb = NULL;
-		goto out;
+		return ERR_CAST(sb);
 	}
 
 	if (sb->s_root) {
@@ -979,13 +975,9 @@ cifs_smb3_do_mount(struct file_system_type *fs_type,
 	deactivate_locked_super(sb);
 	return root;
 out:
-	if (cifs_sb) {
-		if (!sb || IS_ERR(sb)) {  /* otherwise kill_sb will handle */
-			kfree(cifs_sb->prepath);
-			smb3_cleanup_fs_context(cifs_sb->ctx);
-			kfree(cifs_sb);
-		}
-	}
+	kfree(cifs_sb->prepath);
+	smb3_cleanup_fs_context(cifs_sb->ctx);
+	kfree(cifs_sb);
 	return root;
 }
 
-- 
2.39.2

