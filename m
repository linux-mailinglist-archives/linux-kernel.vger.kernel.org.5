Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E419D752F98
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 04:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234555AbjGNCxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 22:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234425AbjGNCxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 22:53:40 -0400
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689D42D48
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 19:53:38 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VnK1FF._1689303214;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VnK1FF._1689303214)
          by smtp.aliyun-inc.com;
          Fri, 14 Jul 2023 10:53:35 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     hsiangkao@linux.alibaba.com, chao@kernel.org, huyue2@coolpad.com,
        linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, alexl@redhat.com
Subject: [PATCH v4 3/3] erofs-utils: mkfs: enable xattr name filter
Date:   Fri, 14 Jul 2023 10:53:30 +0800
Message-Id: <20230714025330.42950-4-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230714025330.42950-1-jefflexu@linux.alibaba.com>
References: <20230714025330.42950-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce "-Exattr-name-filter" option to enable the xattr name bloom
filter feature.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 include/erofs/config.h   |  1 +
 include/erofs/internal.h |  1 +
 lib/xattr.c              | 74 +++++++++++++++++++++++++++++++---------
 mkfs/main.c              |  7 ++++
 4 files changed, 67 insertions(+), 16 deletions(-)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index 8f52d2c..c51f0cd 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -53,6 +53,7 @@ struct erofs_configure {
 	bool c_ignore_mtime;
 	bool c_showprogress;
 	bool c_extra_ea_name_prefixes;
+	bool c_xattr_name_filter;
 
 #ifdef HAVE_LIBSELINUX
 	struct selabel_handle *sehnd;
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index ab964d4..1d7ef73 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -133,6 +133,7 @@ EROFS_FEATURE_FUNCS(fragments, incompat, INCOMPAT_FRAGMENTS)
 EROFS_FEATURE_FUNCS(dedupe, incompat, INCOMPAT_DEDUPE)
 EROFS_FEATURE_FUNCS(xattr_prefixes, incompat, INCOMPAT_XATTR_PREFIXES)
 EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
+EROFS_FEATURE_FUNCS(xattr_filter, compat, COMPAT_XATTR_FILTER)
 
 #define EROFS_I_EA_INITED	(1 << 0)
 #define EROFS_I_Z_INITED	(1 << 1)
diff --git a/lib/xattr.c b/lib/xattr.c
index 7d7dc54..a5d9fc5 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -18,6 +18,7 @@
 #include "erofs/cache.h"
 #include "erofs/io.h"
 #include "erofs/fragments.h"
+#include "erofs/xxhash.h"
 #include "liberofs_private.h"
 
 #define EA_HASHTABLE_BITS 16
@@ -26,6 +27,7 @@ struct xattr_item {
 	struct xattr_item *next_shared_xattr;
 	const char *kvbuf;
 	unsigned int hash[2], len[2], count;
+	unsigned int name_filter_bit;
 	int shared_xattr_id;
 	u8 prefix;
 	struct hlist_node node;
@@ -101,7 +103,8 @@ static unsigned int put_xattritem(struct xattr_item *item)
 }
 
 static struct xattr_item *get_xattritem(u8 prefix, char *kvbuf,
-					unsigned int len[2])
+					unsigned int len[2],
+					unsigned int name_filter_bit)
 {
 	struct xattr_item *item;
 	unsigned int hash[2], hkey;
@@ -133,40 +136,59 @@ static struct xattr_item *get_xattritem(u8 prefix, char *kvbuf,
 	item->hash[1] = hash[1];
 	item->shared_xattr_id = -1;
 	item->prefix = prefix;
+	item->name_filter_bit = name_filter_bit;
 	hash_add(ea_hashtable, &item->node, hkey);
 	return item;
 }
 
-static bool match_prefix(const char *key, u8 *index, u16 *len)
+static unsigned int erofs_xattr_calc_name_filter_bit(u8 prefix, const char *key,
+						     unsigned int len)
+{
+	if (!cfg.c_xattr_name_filter)
+		return 0;
+	return xxh32(key, len, EROFS_XATTR_FILTER_SEED + prefix) &
+			(EROFS_XATTR_FILTER_BITS - 1);
+}
+
+static bool match_short_prefix(const char *key, u8 *index, u16 *len)
 {
 	struct xattr_prefix *p;
-	struct ea_type_node *tnode;
 
-	list_for_each_entry(tnode, &ea_name_prefixes, list) {
-		p = &tnode->type;
+	for (p = xattr_types; p < xattr_types + ARRAY_SIZE(xattr_types); ++p) {
 		if (p->prefix && !strncmp(p->prefix, key, p->prefix_len)) {
 			*len = p->prefix_len;
-			*index = tnode->index;
+			*index = p - xattr_types;
 			return true;
 		}
 	}
-	for (p = xattr_types; p < xattr_types + ARRAY_SIZE(xattr_types); ++p) {
+	return false;
+}
+
+static bool match_prefix(const char *key, u8 *index, u16 *len)
+{
+	struct xattr_prefix *p;
+	struct ea_type_node *tnode;
+
+	list_for_each_entry(tnode, &ea_name_prefixes, list) {
+		p = &tnode->type;
 		if (p->prefix && !strncmp(p->prefix, key, p->prefix_len)) {
 			*len = p->prefix_len;
-			*index = p - xattr_types;
+			*index = tnode->index;
 			return true;
 		}
 	}
-	return false;
+
+	return match_short_prefix(key, index, len);
 }
 
 static struct xattr_item *parse_one_xattr(const char *path, const char *key,
 					  unsigned int keylen)
 {
 	ssize_t ret;
-	u8 prefix;
-	u16 prefixlen;
+	u8 prefix, o_prefix;
+	u16 prefixlen, o_prefixlen;
 	unsigned int len[2];
+	unsigned int bit = 0;
 	char *kvbuf;
 
 	erofs_dbg("parse xattr [%s] of %s", path, key);
@@ -176,6 +198,13 @@ static struct xattr_item *parse_one_xattr(const char *path, const char *key,
 
 	DBG_BUGON(keylen < prefixlen);
 
+	if (cfg.c_xattr_name_filter) {
+		if (!match_short_prefix(key, &o_prefix, &o_prefixlen))
+			return ERR_PTR(-ENODATA);
+		bit = erofs_xattr_calc_name_filter_bit(o_prefix,
+				key + o_prefixlen, keylen - o_prefixlen);
+	}
+
 	/* determine length of the value */
 #ifdef HAVE_LGETXATTR
 	ret = lgetxattr(path, key, NULL, 0);
@@ -216,7 +245,7 @@ static struct xattr_item *parse_one_xattr(const char *path, const char *key,
 			len[1] = ret;
 		}
 	}
-	return get_xattritem(prefix, kvbuf, len);
+	return get_xattritem(prefix, kvbuf, len, bit);
 }
 
 static struct xattr_item *erofs_get_selabel_xattr(const char *srcpath,
@@ -226,7 +255,7 @@ static struct xattr_item *erofs_get_selabel_xattr(const char *srcpath,
 	if (cfg.sehnd) {
 		char *secontext;
 		int ret;
-		unsigned int len[2];
+		unsigned int bit, len[2];
 		char *kvbuf, *fspath;
 
 		if (cfg.mount_point)
@@ -260,7 +289,8 @@ static struct xattr_item *erofs_get_selabel_xattr(const char *srcpath,
 		}
 		sprintf(kvbuf, "selinux%s", secontext);
 		freecon(secontext);
-		return get_xattritem(EROFS_XATTR_INDEX_SECURITY, kvbuf, len);
+		bit = erofs_xattr_calc_name_filter_bit(EROFS_XATTR_INDEX_SECURITY, "selinux", len[0]);
+		return get_xattritem(EROFS_XATTR_INDEX_SECURITY, kvbuf, len, bit);
 	}
 #endif
 	return NULL;
@@ -408,7 +438,7 @@ static int erofs_droid_xattr_set_caps(struct erofs_inode *inode)
 {
 	const u64 capabilities = inode->capabilities;
 	char *kvbuf;
-	unsigned int len[2];
+	unsigned int bit, len[2];
 	struct vfs_cap_data caps;
 	struct xattr_item *item;
 
@@ -430,7 +460,8 @@ static int erofs_droid_xattr_set_caps(struct erofs_inode *inode)
 	caps.data[1].inheritable = 0;
 	memcpy(kvbuf + len[0], &caps, len[1]);
 
-	item = get_xattritem(EROFS_XATTR_INDEX_SECURITY, kvbuf, len);
+	bit = erofs_xattr_calc_name_filter_bit(EROFS_XATTR_INDEX_SECURITY, "capability", len[0]);
+	item = get_xattritem(EROFS_XATTR_INDEX_SECURITY, kvbuf, len, bit);
 	if (IS_ERR(item))
 		return PTR_ERR(item);
 	if (!item)
@@ -754,6 +785,17 @@ char *erofs_export_xattr_ibody(struct list_head *ixattrs, unsigned int size)
 	header = (struct erofs_xattr_ibody_header *)buf;
 	header->h_shared_count = 0;
 
+	if (cfg.c_xattr_name_filter) {
+		u32 name_filter = 0;
+
+		list_for_each_entry_safe(node, n, ixattrs, list) {
+			struct xattr_item *const item = node->item;
+			name_filter |= 1UL << item->name_filter_bit;
+		}
+		name_filter = EROFS_XATTR_FILTER_DEFAULT & ~name_filter;
+		header->h_name_filter = cpu_to_le32(name_filter);
+	}
+
 	p = sizeof(struct erofs_xattr_ibody_header);
 	list_for_each_entry_safe(node, n, ixattrs, list) {
 		struct xattr_item *const item = node->item;
diff --git a/mkfs/main.c b/mkfs/main.c
index ac208e5..7db7847 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -241,6 +241,13 @@ handle_fragment:
 				return -EINVAL;
 			cfg.c_dedupe = true;
 		}
+
+		if (MATCH_EXTENTED_OPT("xattr-name-filter", token, keylen)) {
+			if (vallen)
+				return -EINVAL;
+			cfg.c_xattr_name_filter = true;
+			erofs_sb_set_xattr_filter();
+		}
 	}
 	return 0;
 }
-- 
2.19.1.6.gb485710b

