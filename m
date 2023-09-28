Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD307B1EEE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 15:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbjI1NtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 09:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbjI1Ns7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 09:48:59 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA52995;
        Thu, 28 Sep 2023 06:48:56 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vt1qcol_1695908932;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vt1qcol_1695908932)
          by smtp.aliyun-inc.com;
          Thu, 28 Sep 2023 21:48:53 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     huyue2@coolpad.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] erofs: update documentation
Date:   Thu, 28 Sep 2023 21:48:52 +0800
Message-Id: <20230928134852.31118-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 - update new features like bloom filter and DEFLATE.

 - add documentation for the long xattr name prefixes, which was
   landed upstream since v6.4.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
changes: fix minor grammar issues
v1: https://lore.kernel.org/all/20230928131600.84701-1-jefflexu@linux.alibaba.com/
---
 Documentation/filesystems/erofs.rst | 40 ++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
index 4654ee57c1d5..f200d7874495 100644
--- a/Documentation/filesystems/erofs.rst
+++ b/Documentation/filesystems/erofs.rst
@@ -58,12 +58,14 @@ Here are the main features of EROFS:
 
  - Support extended attributes as an option;
 
+ - Support a bloom filter that speeds up negative extended attribute lookups;
+
  - Support POSIX.1e ACLs by using extended attributes;
 
  - Support transparent data compression as an option:
-   LZ4 and MicroLZMA algorithms can be used on a per-file basis; In addition,
-   inplace decompression is also supported to avoid bounce compressed buffers
-   and page cache thrashing.
+   LZ4, MicroLZMA and DEFLATE algorithms can be used on a per-file basis; In
+   addition, inplace decompression is also supported to avoid bounce compressed
+   buffers and unnecessary page cache thrashing.
 
  - Support chunk-based data deduplication and rolling-hash compressed data
    deduplication;
@@ -268,6 +270,38 @@ details.)
 
 By the way, chunk-based files are all uncompressed for now.
 
+Long extended attribute name prefixes
+-------------------------------------
+There are use cases where extended attributes with different values can have
+only a few common prefixes (such as overlayfs xattrs).  The predefined prefixes
+work inefficiently in both image size and runtime performance in such cases.
+
+The long xattr name prefixes feature is introduced to address this issue.  The
+overall idea is that, apart from the existing predefined prefixes, the xattr
+entry could also refer to user-specified long xattr name prefixes, e.g.
+"trusted.overlay.".
+
+When referring to a long xattr name prefix, the highest bit (bit 7) of
+erofs_xattr_entry.e_name_index is set, while the lower bits (bit 0-6) as a whole
+represent the index of the referred long name prefix among all long name
+prefixes.  Therefore, only the trailing part of the name apart from the long
+xattr name prefix is stored in erofs_xattr_entry.e_name, which could be empty if
+the full xattr name matches exactly as its long xattr name prefix.
+
+All long xattr prefixes are stored one by one in the packed inode as long as
+the packed inode is valid, or in the meta inode otherwise.  The
+xattr_prefix_count (of the on-disk superblock) indicates the total number of
+long xattr name prefixes, while (xattr_prefix_start * 4) indicates the start
+offset of long name prefixes in the packed/meta inode.  Note that, long extended
+attribute name prefixes are disabled if xattr_prefix_count is 0.
+
+Each long name prefix is stored in the format: ALIGN({__le16 len, data}, 4),
+where len represents the total size of the data part.  The data part is actually
+represented by 'struct erofs_xattr_long_prefix', where base_index represents the
+index of the predefined xattr name prefix, e.g. EROFS_XATTR_INDEX_TRUSTED for
+"trusted.overlay." long name prefix, while the infix string keeps the string
+after stripping the short prefix, e.g. "overlay." for the example above.
+
 Data compression
 ----------------
 EROFS implements fixed-sized output compression which generates fixed-sized
-- 
2.19.1.6.gb485710b

