Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEFD17BCAD6
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 02:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234191AbjJHAt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 20:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234248AbjJHAtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 20:49:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65EA9127;
        Sat,  7 Oct 2023 17:49:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BFC4C433C7;
        Sun,  8 Oct 2023 00:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696726152;
        bh=YSqk6uf3kTBJZkCEE/8o30l4PRDcEDdtxojiJBqVoWI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fJr75mhFhyow91UT55KH+URFsfLbIN1dAbnXmy6s225tuw6ONJzCOJhCs+QCDMgW5
         mOx+SGVXERK7IxekhX4QzoWyWQAVj9GnbO1F8Id5z7Pc8ZqjkCyOEVkQEY5Yyo9xEu
         8jJtzwPEdcgdhn4gHtyzi7gVns1eM2G0k+7qfqzQsGQvRufzCzyRHLPp8UO2hgOi/K
         nKRNLMguxl6IqJRo1m7raN6mU/pOsX31QqmNCTIoZ3el8nIk0gvb1XsMapXCWn37Yl
         zzDoiPUx4KDco0r5UGkZePPs7uveiwJL2JJPeJvxFMOkwx2X4tobNw5KRjlgLimrQd
         P//vAuLRhF/jg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jeff Layton <jlayton@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Sasha Levin <sashal@kernel.org>, miklos@szeredi.hu,
        linux-unionfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 10/18] overlayfs: set ctime when setting mtime and atime
Date:   Sat,  7 Oct 2023 20:48:44 -0400
Message-Id: <20231008004853.3767621-10-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231008004853.3767621-1-sashal@kernel.org>
References: <20231008004853.3767621-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.6
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit 03dbab3bba5f009d053635c729d1244f2c8bad38 ]

Nathan reported that he was seeing the new warning in
setattr_copy_mgtime pop when starting podman containers. Overlayfs is
trying to set the atime and mtime via notify_change without also
setting the ctime.

POSIX states that when the atime and mtime are updated via utimes() that
we must also update the ctime to the current time. The situation with
overlayfs copy-up is analogies, so add ATTR_CTIME to the bitmask.
notify_change will fill in the value.

Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Acked-by: Christian Brauner <brauner@kernel.org>
Acked-by: Amir Goldstein <amir73il@gmail.com>
Message-Id: <20230913-ctime-v1-1-c6bc509cbc27@kernel.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/copy_up.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 986d37a4c2750..ab32c6b28d400 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -337,7 +337,7 @@ static int ovl_set_timestamps(struct ovl_fs *ofs, struct dentry *upperdentry,
 {
 	struct iattr attr = {
 		.ia_valid =
-		     ATTR_ATIME | ATTR_MTIME | ATTR_ATIME_SET | ATTR_MTIME_SET,
+		     ATTR_ATIME | ATTR_MTIME | ATTR_ATIME_SET | ATTR_MTIME_SET | ATTR_CTIME,
 		.ia_atime = stat->atime,
 		.ia_mtime = stat->mtime,
 	};
-- 
2.40.1

