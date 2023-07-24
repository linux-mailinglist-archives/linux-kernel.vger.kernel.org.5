Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD0275E8F7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbjGXBpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbjGXBnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:43:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0756F3ABD;
        Sun, 23 Jul 2023 18:38:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B07661010;
        Mon, 24 Jul 2023 01:33:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96CE1C433C7;
        Mon, 24 Jul 2023 01:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690162436;
        bh=lil0d26Owi00aeY6pak3p99Jo1UguuDGeW+kSLNMn6I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iRskuLycG3P3vJ1w9Bcn1wd78M5K3025m0YVupVF/tnawf2OpFdWR56bu6oGRvrUZ
         GztTYA2H1foFjBm5sw3NZJcSDStQMoJGKHlNygJAHKiueefKhzLlwE+lYRAeWfHNPC
         p6lCmMEwvt/ADN2lMcyuxh7HW5lZU6yLHBb7nyw9aojFRMRR1ebOx2lOgxBQH/Y8cN
         tIhVQlFDzdJeOcipZMNheCWuFfasukThO8DUKL3R83zOB98NqryUmzjLLZDOQAXhTi
         XrOVeTur80y5n0X1ZgmlRUV1ULyZMDkZlirzjgelVAikMHtWNhsbVfexlMoWKCPm5r
         dAc3LwXNt5TBg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.15 21/24] fs/ntfs3: Mark ntfs dirty when on-disk struct is corrupted
Date:   Sun, 23 Jul 2023 21:33:22 -0400
Message-Id: <20230724013325.2332084-21-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724013325.2332084-1-sashal@kernel.org>
References: <20230724013325.2332084-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.121
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

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit e0f363a98830e8d7d70fbaf91c07ae0b7c57aafe ]

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/fsntfs.c  | 2 +-
 fs/ntfs3/index.c   | 6 ++++++
 fs/ntfs3/ntfs_fs.h | 2 ++
 fs/ntfs3/record.c  | 6 ++++++
 4 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index 3c823613de97d..0ae70010b01d3 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -154,7 +154,7 @@ int ntfs_fix_post_read(struct NTFS_RECORD_HEADER *rhdr, size_t bytes,
 	/* Check errors. */
 	if ((fo & 1) || fo + fn * sizeof(short) > SECTOR_SIZE || !fn-- ||
 	    fn * SECTOR_SIZE > bytes) {
-		return -EINVAL; /* Native chkntfs returns ok! */
+		return -E_NTFS_CORRUPT;
 	}
 
 	/* Get fixup pointer. */
diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index 1ae3b310869d6..a74812e2da083 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -1044,6 +1044,12 @@ int indx_read(struct ntfs_index *indx, struct ntfs_inode *ni, CLST vbn,
 	*node = in;
 
 out:
+	if (err == -E_NTFS_CORRUPT) {
+		ntfs_inode_err(&ni->vfs_inode, "directory corrupted");
+		ntfs_set_state(ni->mi.sbi, NTFS_DIRTY_ERROR);
+		err = -EINVAL;
+	}
+
 	if (ib != in->index)
 		kfree(ib);
 
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index e571e7643596e..f4ec920616582 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -54,6 +54,8 @@ enum utf16_endian;
 #define E_NTFS_NONRESIDENT		556
 /* NTFS specific error code about punch hole. */
 #define E_NTFS_NOTALIGNED		557
+/* NTFS specific error code when on-disk struct is corrupted. */
+#define E_NTFS_CORRUPT			558
 
 
 /* sbi->flags */
diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index 3d222b1c8f038..938fc286963f2 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -180,6 +180,12 @@ int mi_read(struct mft_inode *mi, bool is_mft)
 	return 0;
 
 out:
+	if (err == -E_NTFS_CORRUPT) {
+		ntfs_err(sbi->sb, "mft corrupted");
+		ntfs_set_state(sbi, NTFS_DIRTY_ERROR);
+		err = -EINVAL;
+	}
+
 	return err;
 }
 
-- 
2.39.2

