Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E2377A83F
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 17:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjHMP6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 11:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjHMP6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 11:58:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13EE1FDD;
        Sun, 13 Aug 2023 08:58:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF6BF632D0;
        Sun, 13 Aug 2023 15:52:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03A4EC433C8;
        Sun, 13 Aug 2023 15:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691941951;
        bh=lPKiRxULJ3zdiTdicFoPNAzKKlpAdAWv0t9uO+0e9l0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MQLVmDF5HI6F4G9Vr6qSBw+TWvNPlEY23JPqGXfHTQpRVVDS8nk/N+UbM7TdKKb9A
         N31Zp4yq1PEudF9BGavX6DLXUlzw6RRuQe2jLAwlarAwWkbj0J0vxtHumhHQyfD91b
         iBHMHIVF9yzUJUJKCvV6o0C7RTtGdnMDnWnkCV+FoD7OhFA2gZv8mAIi66/NjmHnBd
         bJgiJ79jn+tFiL2z0512tzYJ/ZJMao947dUNq+rNp2fYSs9ellb1LQnoqBYgpsGXh2
         fkxAx/tI92ZgS6gfIIbTkqRDq5U0iBJw63DWRPIfkdOuqhkv3U14XfYUmguNZ7jBk7
         gVNq9tngHoE1g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Eric Snowberg <eric.snowberg@oracle.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, miklos@szeredi.hu,
        amir73il@gmail.com, linux-unionfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 45/54] ovl: Always reevaluate the file signature for IMA
Date:   Sun, 13 Aug 2023 11:49:24 -0400
Message-Id: <20230813154934.1067569-45-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230813154934.1067569-1-sashal@kernel.org>
References: <20230813154934.1067569-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.10
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
index ae1058fbfb5b2..8c60da7b4afd8 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -2052,7 +2052,7 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
 		ovl_trusted_xattr_handlers;
 	sb->s_fs_info = ofs;
 	sb->s_flags |= SB_POSIXACL;
-	sb->s_iflags |= SB_I_SKIP_SYNC;
+	sb->s_iflags |= SB_I_SKIP_SYNC | SB_I_IMA_UNVERIFIABLE_SIGNATURE;
 
 	err = -ENOMEM;
 	root_dentry = ovl_get_root(sb, upperpath.dentry, oe);
-- 
2.40.1

