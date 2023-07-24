Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C01EC75E7ED
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbjGXBgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbjGXBgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:36:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD691981;
        Sun, 23 Jul 2023 18:32:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B858A60F7B;
        Mon, 24 Jul 2023 01:31:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D7CC433C7;
        Mon, 24 Jul 2023 01:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690162288;
        bh=ZGGjLoliyL7W6df1EKhsmbL/I57wCGM33k/RC200KKQ=;
        h=From:To:Cc:Subject:Date:From;
        b=lLMUBukyQLteWNasVKbk7YNDvVeBDGR1KWhgADg+7WZjMMXvMOHYWZTPhEkkbwrGw
         Hw5cJI6qwOr1OKJtqYo5SeQHDvofKTlcKakGB4+WqDGTXFth+ht6neg03v8J8pAcDp
         YbmBRKq+8LES173JAfOI0sdfi4MUTSg00VWcO1Pav7+rkYHcNoKAAmPVSXPkvCxCh3
         d51Y0G0gOC0pSeOfNNHb+22XraVDKlK46+X4T5Sm0kFUTufrLJbU62iQbRktvMc4py
         rKu/8wTE5JowErQbGXxYkNAgxlwyzxDZZtMOPpNFn0oRdatd3tYcrUVXQh+rhcgpzJ
         9Tvn3boA07kwA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Paulo Alcantara <pc@manguebit.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>, sfrench@samba.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org
Subject: [PATCH AUTOSEL 5.15] smb: client: fix warning in cifs_smb3_do_mount()
Date:   Sun, 23 Jul 2023 21:31:25 -0400
Message-Id: <20230724013125.2327560-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.121
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
 fs/cifs/cifsfs.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index c9481289266ca..b5ae209539ff1 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -848,11 +848,11 @@ struct dentry *
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
@@ -863,11 +863,9 @@ cifs_smb3_do_mount(struct file_system_type *fs_type,
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
@@ -910,10 +908,8 @@ cifs_smb3_do_mount(struct file_system_type *fs_type,
 
 	sb = sget(fs_type, cifs_match_super, cifs_set_super, flags, &mnt_data);
 	if (IS_ERR(sb)) {
-		root = ERR_CAST(sb);
 		cifs_umount(cifs_sb);
-		cifs_sb = NULL;
-		goto out;
+		return ERR_CAST(sb);
 	}
 
 	if (sb->s_root) {
@@ -944,13 +940,9 @@ cifs_smb3_do_mount(struct file_system_type *fs_type,
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

