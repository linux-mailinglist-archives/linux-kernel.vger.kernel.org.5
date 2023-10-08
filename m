Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD327BCB48
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 02:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234238AbjJHAyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 20:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344306AbjJHAxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 20:53:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC2A26AD;
        Sat,  7 Oct 2023 17:51:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05603C4167D;
        Sun,  8 Oct 2023 00:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696726247;
        bh=YyfUth6wYtBqZbQ3zXY8oAjRt7Q3DhLoD/Yttggwqe4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jWeoxmzRHnausWiLV8VIoaiitWKphq7IFvurMByjXwfQPJmz1a+QFvzZt4bqgYag/
         jxeiXJrMrp/tLFgTnOD+3/mVGr5HHsYqSrjLglbKJH+LaTZ/pVrx90/8KSlpT1PAW/
         f6HNT5JWCxwu0v1b7KXNzf+6krHq+1Nj8cvAxGW7ImXM2YQ03DLrI8NqDhyMmA8SWR
         X1XtE1b5NmmhzyeRYdUwXqZm9TKlkxwvdABT7va44TqJltf30qem1ZItH8+wNxOXMO
         jrmixLqAcWmXZI+GsIZzL4sqsnbK3QXUF7c8u2tXg9Vjt9vLLjoG2j0p9A7inFDzWn
         9TxLG3SzGKQWg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jeff Layton <jlayton@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Sasha Levin <sashal@kernel.org>, miklos@szeredi.hu,
        linux-unionfs@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 5/8] overlayfs: set ctime when setting mtime and atime
Date:   Sat,  7 Oct 2023 20:50:35 -0400
Message-Id: <20231008005039.3768522-5-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231008005039.3768522-1-sashal@kernel.org>
References: <20231008005039.3768522-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.295
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
index 3d7a700350c1d..debcac35a51dc 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -195,7 +195,7 @@ static int ovl_set_timestamps(struct dentry *upperdentry, struct kstat *stat)
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

