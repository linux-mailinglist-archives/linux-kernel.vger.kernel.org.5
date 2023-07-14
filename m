Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1247E752F96
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 04:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234556AbjGNCxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 22:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbjGNCxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 22:53:39 -0400
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E9B2D5D
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 19:53:37 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VnK8Oac_1689303213;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VnK8Oac_1689303213)
          by smtp.aliyun-inc.com;
          Fri, 14 Jul 2023 10:53:33 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     hsiangkao@linux.alibaba.com, chao@kernel.org, huyue2@coolpad.com,
        linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, alexl@redhat.com
Subject: [PATCH v4 2/3] erofs-utils: update on-disk format for xattr name filter
Date:   Fri, 14 Jul 2023 10:53:29 +0800
Message-Id: <20230714025330.42950-3-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230714025330.42950-1-jefflexu@linux.alibaba.com>
References: <20230714025330.42950-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,LONGWORDS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The xattr name bloom filter feature is going to be introduced to speed
up the negative xattr lookup, e.g. system.posix_acl_[access|default]
lookup when running "ls -lR" workload.

There are some commonly used extended attributes (n) and the total
number of these is approximately 30.

	trusted.overlay.opaque
	trusted.overlay.redirect
	trusted.overlay.origin
	trusted.overlay.impure
	trusted.overlay.nlink
	trusted.overlay.upper
	trusted.overlay.metacopy
	trusted.overlay.protattr
	user.overlay.opaque
	user.overlay.redirect
	user.overlay.origin
	user.overlay.impure
	user.overlay.nlink
	user.overlay.upper
	user.overlay.metacopy
	user.overlay.protattr
	security.evm
	security.ima
	security.selinux
	security.SMACK64
	security.SMACK64IPIN
	security.SMACK64IPOUT
	security.SMACK64EXEC
	security.SMACK64TRANSMUTE
	security.SMACK64MMAP
	security.apparmor
	security.capability
	system.posix_acl_access
	system.posix_acl_default
	user.mime_type

Given the number of bits of the bloom filter (m) is 32, the optimal
value for the number of the hash functions (k) is 1 (ln2 * m/n = 0.74).

The single hash function is implemented as:

	xxh32(name, strlen(name), EROFS_XATTR_FILTER_SEED + index)

where `index` represents the index of corresponding predefined short name
prefix, while `name` represents the name string after stripping the above
predefined name prefix.

The constant magic number EROFS_XATTR_FILTER_SEED, i.e. 0x25BBE08F, is
used to give a better spread when mapping these 30 extended attributes
into 32-bit bloom filter as:

	bit  0: security.ima
	bit  1:
	bit  2: trusted.overlay.nlink
	bit  3:
	bit  4: user.overlay.nlink
	bit  5: trusted.overlay.upper
	bit  6: user.overlay.origin
	bit  7: trusted.overlay.protattr
	bit  8: security.apparmor
	bit  9: user.overlay.protattr
	bit 10: user.overlay.opaque
	bit 11: security.selinux
	bit 12: security.SMACK64TRANSMUTE
	bit 13: security.SMACK64
	bit 14: security.SMACK64MMAP
	bit 15: user.overlay.impure
	bit 16: security.SMACK64IPIN
	bit 17: trusted.overlay.redirect
	bit 18: trusted.overlay.origin
	bit 19: security.SMACK64IPOUT
	bit 20: trusted.overlay.opaque
	bit 21: system.posix_acl_default
	bit 22:
	bit 23: user.mime_type
	bit 24: trusted.overlay.impure
	bit 25: security.SMACK64EXEC
	bit 26: user.overlay.redirect
	bit 27: user.overlay.upper
	bit 28: security.evm
	bit 29: security.capability
	bit 30: system.posix_acl_access
	bit 31: trusted.overlay.metacopy, user.overlay.metacopy

h_name_filter is introduced to the on-disk per-inode xattr header to
place the corresponding xattr name filter, where bit value 1 indicates
non-existence for compatibility.

This feature is indicated by EROFS_FEATURE_COMPAT_XATTR_FILTER
compatible feature bit.

Reserve one byte in on-disk superblock as the on-disk format for xattr
name filter may change in the future.  With this flag we don't need
bothering these compatible bits again at that time.

Suggested-by: Alexander Larsson <alexl@redhat.com>
Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 include/erofs_fs.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/erofs_fs.h b/include/erofs_fs.h
index 3697882..1789a37 100644
--- a/include/erofs_fs.h
+++ b/include/erofs_fs.h
@@ -14,6 +14,7 @@
 
 #define EROFS_FEATURE_COMPAT_SB_CHKSUM          0x00000001
 #define EROFS_FEATURE_COMPAT_MTIME              0x00000002
+#define EROFS_FEATURE_COMPAT_XATTR_FILTER	0x00000004
 
 /*
  * Any bits that aren't in EROFS_ALL_FEATURE_INCOMPAT should
@@ -82,7 +83,8 @@ struct erofs_super_block {
 	__u8 xattr_prefix_count;	/* # of long xattr name prefixes */
 	__le32 xattr_prefix_start;	/* start of long xattr prefixes */
 	__le64 packed_nid;	/* nid of the special packed inode */
-	__u8 reserved2[24];
+	__u8 xattr_filter_reserved; /* reserved for xattr name filter */
+	__u8 reserved2[23];
 };
 
 /*
@@ -201,7 +203,7 @@ struct erofs_inode_extended {
  * for read-only fs, no need to introduce h_refcount
  */
 struct erofs_xattr_ibody_header {
-	__le32 h_reserved;
+	__le32 h_name_filter;		/* bit value 1 indicates not-present */
 	__u8   h_shared_count;
 	__u8   h_reserved2[7];
 	__le32 h_shared_xattrs[0];      /* shared xattr id array */
@@ -222,6 +224,12 @@ struct erofs_xattr_ibody_header {
 #define EROFS_XATTR_LONG_PREFIX		0x80
 #define EROFS_XATTR_LONG_PREFIX_MASK	0x7f
 
+#define EROFS_XATTR_NAME_LEN_MAX	UCHAR_MAX
+
+#define EROFS_XATTR_FILTER_BITS		32
+#define EROFS_XATTR_FILTER_DEFAULT	UINT32_MAX
+#define EROFS_XATTR_FILTER_SEED		0x25BBE08F
+
 /* xattr entry (for both inline & shared xattrs) */
 struct erofs_xattr_entry {
 	__u8   e_name_len;      /* length of name */
-- 
2.19.1.6.gb485710b

