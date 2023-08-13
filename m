Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8412677A975
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 18:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbjHMQNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 12:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233306AbjHMQMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 12:12:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09AB30CD;
        Sun, 13 Aug 2023 09:11:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D002A61022;
        Sun, 13 Aug 2023 16:11:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E0AC433C7;
        Sun, 13 Aug 2023 16:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691943070;
        bh=S17R4XdwtPlDKk7mV1DbWLo33kEhrihEBc9yDssDvUM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BZic1dck37A0LCWK+hG+qmslKc9gEspspAxtqq8rX9ltVtrLRHEc/IsBSIobLQxxG
         vkIWCcLCqKfMpfZAixfu67g9MUHgz7dm27u6rl6Vae8+3Qk/Ff4dERKcdrrBfIVc8v
         1EXwAf/Y5HSayfcsShL7NZhiLmyuUIZvMVpd9mmDHb8r73ali5ac/t73s4AcFpyCR7
         myV5iLh2RGYCtjOA5TlOMmAWN6olAsd+/KVWD64BwJ/PoLOGjAfbuJGqYrfZAvbsmK
         cylULAnI8qAlEuewmKWupvVdrojT9bCcPQQfNNK8uui0k+u3pr/yjlxk0qm8XojyH7
         jpn3jsfiLK4KQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Eric Snowberg <eric.snowberg@oracle.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, miklos@szeredi.hu,
        amir73il@gmail.com, linux-unionfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 20/25] ovl: Always reevaluate the file signature for IMA
Date:   Sun, 13 Aug 2023 12:09:31 -0400
Message-Id: <20230813160936.1082758-20-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230813160936.1082758-1-sashal@kernel.org>
References: <20230813160936.1082758-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.190
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Snowberg <eric.snowberg@oracle.com>

[ Upstream commit 18b44bc5a67275641fb26f2c54ba7eef80ac5950 ]

Commit db1d1e8b9867 ("IMA: use vfs_getattr_nosec to get the i_version")
partially closed an IMA integrity issue when directly modifying a file
on the lower filesystem.  If the overlay file is first opened by a user
and later the lower backing file is modified by root, but the extended
attribute is NOT updated, the signature validation succeeds with the old
original signature.

Update the super_block s_iflags to SB_I_IMA_UNVERIFIABLE_SIGNATURE to
force signature reevaluation on every file access until a fine grained
solution can be found.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 5d7df839902df..e0384095ca960 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -2028,7 +2028,7 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
 	sb->s_xattr = ovl_xattr_handlers;
 	sb->s_fs_info = ofs;
 	sb->s_flags |= SB_POSIXACL;
-	sb->s_iflags |= SB_I_SKIP_SYNC;
+	sb->s_iflags |= SB_I_SKIP_SYNC | SB_I_IMA_UNVERIFIABLE_SIGNATURE;
 
 	err = -ENOMEM;
 	root_dentry = ovl_get_root(sb, upperpath.dentry, oe);
-- 
2.40.1

