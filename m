Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D1D75437A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 21:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236197AbjGNTzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 15:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjGNTzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 15:55:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857632D57;
        Fri, 14 Jul 2023 12:55:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22F7A61DD5;
        Fri, 14 Jul 2023 19:55:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6458C433C8;
        Fri, 14 Jul 2023 19:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689364546;
        bh=4eYy/RPZgv0m+5eHPp+58x2nFqjssKzUOUyMAbEfScE=;
        h=Date:From:To:Cc:Subject:From;
        b=tCBNcnwoV548sdT0f8HZLQhORDA5TZLjjEBAKisdwOskMPLt52VVFHvYNfrY3K7eO
         PZbwa3r9Dcvs4Gr2ywmFdREIinQ6NehbJsM/pNeZf/vKgxXfJ2af3PaqRrE/N/qbtv
         nDFBOVhg9V5RbvhbwWI+AXkclXKA8BX9W1cBTJtkQtGv+nrrqF/Bt3d9Qv+C1fYDXB
         NhUYnz2/NT41gaOWvJdzh+3h4UX8VXZ5dNuI5R0B6hbcfb5DkqjJnFKCNm4FRuesHf
         ofvIVefVak++dRHk037OuQeX+rrMVVfhwl6qMJQ/kWwvv2iw2ACpbcynp0xqwcGmjr
         wsHUo6ZjnObPQ==
Date:   Fri, 14 Jul 2023 13:56:37 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Bob Copeland <me@bobcopeland.com>
Cc:     linux-karma-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] fs: omfs: Use flexible-array member in struct
 omfs_extent
Message-ID: <ZLGodUeD307GlINN@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory for 'struct omfs_extent' and a 'e_extent_count' number of extent
entries is indirectly allocated through 'bh->b_data', which is a pointer
to data within the page. This implies that the member 'e_entry'
(which is the start of extent entries) functions more like an array than
a single object of type 'struct omfs_extent_entry'.

So we better turn this object into a proper array, in this case a
flexible-array member, and with that, fix the following
-Wstringop-overflow warning seen after building s390 architecture with
allyesconfig (GCC 13):

fs/omfs/file.c: In function 'omfs_grow_extent':
include/linux/fortify-string.h:57:33: warning: writing 16 bytes into a region of size 0 [-Wstringop-overflow=]
   57 | #define __underlying_memcpy     __builtin_memcpy
      |                                 ^
include/linux/fortify-string.h:648:9: note: in expansion of macro '__underlying_memcpy'
  648 |         __underlying_##op(p, q, __fortify_size);                        \
      |         ^~~~~~~~~~~~~
include/linux/fortify-string.h:693:26: note: in expansion of macro '__fortify_memcpy_chk'
  693 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
      |                          ^~~~~~~~~~~~~~~~~~~~
fs/omfs/file.c:170:9: note: in expansion of macro 'memcpy'
  170 |         memcpy(terminator, entry, sizeof(struct omfs_extent_entry));
      |         ^~~~~~
In file included from fs/omfs/omfs.h:8,
                 from fs/omfs/file.c:11:
fs/omfs/omfs_fs.h:80:34: note: at offset 16 into destination object 'e_entry' of size 16
   80 |         struct omfs_extent_entry e_entry;       /* start of extent entries */
      |                                  ^~~~~~~

There are some binary differences before and after changes, but this are
expected due to the change in the size of 'struct omfs_extent' and the
necessary adjusments.

This helps with the ongoing efforts to globally enable
-Wstringop-overflow.

Link: https://github.com/KSPP/linux/issues/330
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 fs/omfs/file.c    | 12 ++++++------
 fs/omfs/omfs_fs.h |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/omfs/file.c b/fs/omfs/file.c
index de8f57ee39ec..6b580b9da8e3 100644
--- a/fs/omfs/file.c
+++ b/fs/omfs/file.c
@@ -14,7 +14,7 @@ static u32 omfs_max_extents(struct omfs_sb_info *sbi, int offset)
 {
 	return (sbi->s_sys_blocksize - offset -
 		sizeof(struct omfs_extent)) /
-		sizeof(struct omfs_extent_entry) + 1;
+		sizeof(struct omfs_extent_entry);
 }
 
 void omfs_make_empty_table(struct buffer_head *bh, int offset)
@@ -24,8 +24,8 @@ void omfs_make_empty_table(struct buffer_head *bh, int offset)
 	oe->e_next = ~cpu_to_be64(0ULL);
 	oe->e_extent_count = cpu_to_be32(1),
 	oe->e_fill = cpu_to_be32(0x22),
-	oe->e_entry.e_cluster = ~cpu_to_be64(0ULL);
-	oe->e_entry.e_blocks = ~cpu_to_be64(0ULL);
+	oe->e_entry[0].e_cluster = ~cpu_to_be64(0ULL);
+	oe->e_entry[0].e_blocks = ~cpu_to_be64(0ULL);
 }
 
 int omfs_shrink_inode(struct inode *inode)
@@ -68,7 +68,7 @@ int omfs_shrink_inode(struct inode *inode)
 
 		last = next;
 		next = be64_to_cpu(oe->e_next);
-		entry = &oe->e_entry;
+		entry = oe->e_entry;
 
 		/* ignore last entry as it is the terminator */
 		for (; extent_count > 1; extent_count--) {
@@ -117,7 +117,7 @@ static int omfs_grow_extent(struct inode *inode, struct omfs_extent *oe,
 			u64 *ret_block)
 {
 	struct omfs_extent_entry *terminator;
-	struct omfs_extent_entry *entry = &oe->e_entry;
+	struct omfs_extent_entry *entry = oe->e_entry;
 	struct omfs_sb_info *sbi = OMFS_SB(inode->i_sb);
 	u32 extent_count = be32_to_cpu(oe->e_extent_count);
 	u64 new_block = 0;
@@ -245,7 +245,7 @@ static int omfs_get_block(struct inode *inode, sector_t block,
 
 		extent_count = be32_to_cpu(oe->e_extent_count);
 		next = be64_to_cpu(oe->e_next);
-		entry = &oe->e_entry;
+		entry = oe->e_entry;
 
 		if (extent_count > max_extents)
 			goto out_brelse;
diff --git a/fs/omfs/omfs_fs.h b/fs/omfs/omfs_fs.h
index caecb3d5a344..1ff6b9e41297 100644
--- a/fs/omfs/omfs_fs.h
+++ b/fs/omfs/omfs_fs.h
@@ -77,7 +77,7 @@ struct omfs_extent {
 	__be64 e_next;			/* next extent table location */
 	__be32 e_extent_count;		/* total # extents in this table */
 	__be32 e_fill;
-	struct omfs_extent_entry e_entry;	/* start of extent entries */
+	struct omfs_extent_entry e_entry[];	/* start of extent entries */
 };
 
 #endif
-- 
2.34.1

