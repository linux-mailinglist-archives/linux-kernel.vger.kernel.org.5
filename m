Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B27975E7E0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjGXBgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbjGXBfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:35:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E175346BB;
        Sun, 23 Jul 2023 18:32:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2EAA760F64;
        Mon, 24 Jul 2023 01:31:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 120AEC433C8;
        Mon, 24 Jul 2023 01:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690162277;
        bh=xjRhSRMp6VdciOc6tWlcw99tdKKtP7C1wSFs+qZqTk8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rkwfZ0t/sY2ALqrnPzSUbkBKJGynEEZY7cLilmAnqH0/zDyDB3UU1puWuo81hv2BY
         mn2lEV77TSl0UyQzM+X2EzruauYNhCBboR34eysFwRPKtCTfHWwbJU7WoDwl5kMLJN
         pohHnPV0tofFRES8Hi3fjA9NYAZxlOqfA5ndaoTouAzFw7irwzoz/KdHg/s92jRDmN
         Q0rs6HnJ+jvCYDZpkT7bgNcbNbZdHXqMS3Ro7N+0+cqjcXmBxlTdFcxrnzv12sQfPC
         TzsphlQw3OzmRxzs5xyEN2FEK22g28R/do5reOOfuCYCD9EtFuRpfMiIrFLMwMviwY
         ssl+ATwqIu8ww==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Paulo Alcantara <pc@manguebit.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.4 3/4] smb: client: fix warning in cifs_smb3_do_mount()
Date:   Sun, 23 Jul 2023 21:31:10 -0400
Message-Id: <20230724013111.2327251-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724013111.2327251-1-sashal@kernel.org>
References: <20230724013111.2327251-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.5
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
index 43a4d8603db34..30b03938f6d1d 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -884,11 +884,11 @@ struct dentry *
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
 
 	if (cifsFYI) {
 		cifs_dbg(FYI, "%s: devname=%s flags=0x%x\n", __func__,
@@ -897,11 +897,9 @@ cifs_smb3_do_mount(struct file_system_type *fs_type,
 		cifs_info("Attempting to mount %s\n", old_ctx->source);
 	}
 
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
@@ -938,10 +936,8 @@ cifs_smb3_do_mount(struct file_system_type *fs_type,
 
 	sb = sget(fs_type, cifs_match_super, cifs_set_super, flags, &mnt_data);
 	if (IS_ERR(sb)) {
-		root = ERR_CAST(sb);
 		cifs_umount(cifs_sb);
-		cifs_sb = NULL;
-		goto out;
+		return ERR_CAST(sb);
 	}
 
 	if (sb->s_root) {
@@ -972,13 +968,9 @@ cifs_smb3_do_mount(struct file_system_type *fs_type,
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

