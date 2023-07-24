Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67DF475E945
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbjGXBuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbjGXBr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:47:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894454EC8;
        Sun, 23 Jul 2023 18:40:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D95160F0B;
        Mon, 24 Jul 2023 01:23:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DEF2C433CB;
        Mon, 24 Jul 2023 01:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690161797;
        bh=TUIGnMRQyP3Tbk6uTBFpwvFdEI75vkiy6WmBX3JOVoA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AUcwXdTRiq6kqo9BCz7lvH4GTcnAiT+cDSJqnywBNzOUqzXsXS5NWSQ6SCzSOle53
         0SolF/RtjEJsFOS7hx9nkGMAj8zAEz6c5qNiKkMnTerNFAA45NwVAYCnYAJDX76soo
         10wqA/c+inzXbjKdzHEpA6SpxMkngU2Yrs4aO3veJJadbzl2H/KOyVAIHfxzCgSb2X
         +dYLoPLGmsYOvfKqWbDrfAJjJ1iR07TH7uiIGLNYCmzCLOJECx4veTjb3yiFij9jjm
         1ogB4h+mYon4EqjP5R5pPaiHjJ/776q93hLqtQfzU5id2kyhALB5ILlIB2YKuvcfgj
         g1W8zkOCrwaqA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Sasha Levin <sashal@kernel.org>, miklos@szeredi.hu,
        linux-unionfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 34/41] ovl: check type and offset of struct vfsmount in ovl_entry
Date:   Sun, 23 Jul 2023 21:21:07 -0400
Message-Id: <20230724012118.2316073-34-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724012118.2316073-1-sashal@kernel.org>
References: <20230724012118.2316073-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.40
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit f723edb8a532cd26e1ff0a2b271d73762d48f762 ]

Porting overlayfs to the new amount api I started experiencing random
crashes that couldn't be explained easily. So after much debugging and
reasoning it became clear that struct ovl_entry requires the point to
struct vfsmount to be the first member and of type struct vfsmount.

During the port I added a new member at the beginning of struct
ovl_entry which broke all over the place in the form of random crashes
and cache corruptions. While there's a comment in ovl_free_fs() to the
effect of "Hack! Reuse ofs->layers as a vfsmount array before freeing
it" there's no such comment on struct ovl_entry which makes this easy to
trip over.

Add a comment and two static asserts for both the offset and the type of
pointer in struct ovl_entry.

Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/ovl_entry.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
index e1af8f6606984..a479680a5ccd8 100644
--- a/fs/overlayfs/ovl_entry.h
+++ b/fs/overlayfs/ovl_entry.h
@@ -32,6 +32,7 @@ struct ovl_sb {
 };
 
 struct ovl_layer {
+	/* ovl_free_fs() relies on @mnt being the first member! */
 	struct vfsmount *mnt;
 	/* Trap in ovl inode cache */
 	struct inode *trap;
@@ -42,6 +43,14 @@ struct ovl_layer {
 	int fsid;
 };
 
+/*
+ * ovl_free_fs() relies on @mnt being the first member when unmounting
+ * the private mounts created for each layer. Let's check both the
+ * offset and type.
+ */
+static_assert(offsetof(struct ovl_layer, mnt) == 0);
+static_assert(__same_type(typeof_member(struct ovl_layer, mnt), struct vfsmount *));
+
 struct ovl_path {
 	const struct ovl_layer *layer;
 	struct dentry *dentry;
-- 
2.39.2

