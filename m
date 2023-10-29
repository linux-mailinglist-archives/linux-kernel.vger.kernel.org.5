Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A8E7DAEE9
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 23:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjJ2Wy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 18:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbjJ2Wyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 18:54:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B76BC;
        Sun, 29 Oct 2023 15:54:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE1C1C433C9;
        Sun, 29 Oct 2023 22:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698620091;
        bh=s61gcXUtn3NWoLkgZKF0zvKXI2kt2JLE4CJokH3+oms=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lx/Lw5XJbODWc7QIL+Ix/CdvE6m+XeyGCEQiaquNGvM1Q6xDJigiEmr6t2cSMquLP
         bj/RdOt1+FZw1EvfYVF9WlCTyuz56+wLQNftAgLwDoOBupbALO4PqfiI9kAY3s1auk
         yntMWq2ZG3xSu4TWXtQn3d2Z4gq0gX7+jXIwl3YJPSw3DQc3WiQVDYuyPo35Ur/uj4
         KzO9RE8b4KJCHZ2jTMaSZC1FYBT38wV5dvdLojyhAxPewXAzpWMwt1q6axV0hUv24v
         wyuzl9OaEGWRM75u82GKv6qFoQR5myhYPl2PYtaGvPHupRu4jkg4WbnlirJPTO2r5W
         DEPGqPikh1i6g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Sasha Levin <sashal@kernel.org>, ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.5 04/52] fs/ntfs3: Use kvmalloc instead of kmalloc(... __GFP_NOWARN)
Date:   Sun, 29 Oct 2023 18:52:51 -0400
Message-ID: <20231029225441.789781-4-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029225441.789781-1-sashal@kernel.org>
References: <20231029225441.789781-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.9
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit fc471e39e38fea6677017cbdd6d928088a59fc67 ]

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/attrlist.c | 15 +++++++++++++--
 fs/ntfs3/bitmap.c   |  3 ++-
 fs/ntfs3/super.c    |  2 +-
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/fs/ntfs3/attrlist.c b/fs/ntfs3/attrlist.c
index 42631b31adf17..7c01735d1219d 100644
--- a/fs/ntfs3/attrlist.c
+++ b/fs/ntfs3/attrlist.c
@@ -52,7 +52,8 @@ int ntfs_load_attr_list(struct ntfs_inode *ni, struct ATTRIB *attr)
 
 	if (!attr->non_res) {
 		lsize = le32_to_cpu(attr->res.data_size);
-		le = kmalloc(al_aligned(lsize), GFP_NOFS | __GFP_NOWARN);
+		/* attr is resident: lsize < record_size (1K or 4K) */
+		le = kvmalloc(al_aligned(lsize), GFP_KERNEL);
 		if (!le) {
 			err = -ENOMEM;
 			goto out;
@@ -80,7 +81,17 @@ int ntfs_load_attr_list(struct ntfs_inode *ni, struct ATTRIB *attr)
 		if (err < 0)
 			goto out;
 
-		le = kmalloc(al_aligned(lsize), GFP_NOFS | __GFP_NOWARN);
+		/* attr is nonresident.
+		 * The worst case:
+		 * 1T (2^40) extremely fragmented file.
+		 * cluster = 4K (2^12) => 2^28 fragments
+		 * 2^9 fragments per one record => 2^19 records
+		 * 2^5 bytes of ATTR_LIST_ENTRY per one record => 2^24 bytes.
+		 *
+		 * the result is 16M bytes per attribute list.
+		 * Use kvmalloc to allocate in range [several Kbytes - dozen Mbytes]
+		 */
+		le = kvmalloc(al_aligned(lsize), GFP_KERNEL);
 		if (!le) {
 			err = -ENOMEM;
 			goto out;
diff --git a/fs/ntfs3/bitmap.c b/fs/ntfs3/bitmap.c
index 107e808e06eae..d66055e30aff9 100644
--- a/fs/ntfs3/bitmap.c
+++ b/fs/ntfs3/bitmap.c
@@ -659,7 +659,8 @@ int wnd_init(struct wnd_bitmap *wnd, struct super_block *sb, size_t nbits)
 		wnd->bits_last = wbits;
 
 	wnd->free_bits =
-		kcalloc(wnd->nwnd, sizeof(u16), GFP_NOFS | __GFP_NOWARN);
+		kvmalloc_array(wnd->nwnd, sizeof(u16), GFP_KERNEL | __GFP_ZERO);
+
 	if (!wnd->free_bits)
 		return -ENOMEM;
 
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 1a02072b6b0e1..d3c78e2a49cbe 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -1369,7 +1369,7 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	}
 
 	bytes = inode->i_size;
-	sbi->def_table = t = kmalloc(bytes, GFP_NOFS | __GFP_NOWARN);
+	sbi->def_table = t = kvmalloc(bytes, GFP_KERNEL);
 	if (!t) {
 		err = -ENOMEM;
 		goto put_inode_out;
-- 
2.42.0

