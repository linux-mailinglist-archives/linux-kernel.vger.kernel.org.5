Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1704E7F547A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 00:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344178AbjKVXZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 18:25:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344564AbjKVXZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 18:25:36 -0500
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21251AB
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 15:25:31 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700695530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+xIe2DoE21qrt9LSNcAUwIwIwHsNrxaH9AQLMP04McM=;
        b=o3CvX/g1Mo37OAG87L/6Vu3aVXW2glLs+ZCCGUrP4H0SA8cPtcuDyYy22kVuLNkWtpIA9Q
        /HbvDCodA7ny8mu2ew1QagbLzcTglJHQRpbARFoW4RvMBKCAQNlLos+/qEMrNpU12NLKky
        vaSlk3dtsvcNkFHaJ0XGnT1dL407Frk=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH 6/7] bcachefs: shrinker.to_text() methods
Date:   Wed, 22 Nov 2023 18:25:11 -0500
Message-ID: <20231122232515.177833-7-kent.overstreet@linux.dev>
In-Reply-To: <20231122232515.177833-1-kent.overstreet@linux.dev>
References: <20231122232515.177833-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds shrinker.to_text() methods for our shrinkers and hooks them up
to our existing to_text() functions.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/bcachefs/btree_cache.c     | 13 +++++++++++++
 fs/bcachefs/btree_key_cache.c | 14 ++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/fs/bcachefs/btree_cache.c b/fs/bcachefs/btree_cache.c
index 47e7770d0583..aab279dff944 100644
--- a/fs/bcachefs/btree_cache.c
+++ b/fs/bcachefs/btree_cache.c
@@ -13,6 +13,7 @@
 
 #include <linux/prefetch.h>
 #include <linux/sched/mm.h>
+#include <linux/seq_buf.h>
 
 const char * const bch2_btree_node_flags[] = {
 #define x(f)	#f,
@@ -392,6 +393,17 @@ static unsigned long bch2_btree_cache_count(struct shrinker *shrink,
 	return btree_cache_can_free(bc);
 }
 
+static void bch2_btree_cache_shrinker_to_text(struct seq_buf *s, struct shrinker *shrink)
+{
+	struct bch_fs *c = shrink->private_data;
+	char *cbuf;
+	size_t buflen = seq_buf_get_buf(s, &cbuf);
+	struct printbuf out = PRINTBUF_EXTERN(cbuf, buflen);
+
+	bch2_btree_cache_to_text(&out, c);
+	seq_buf_commit(s, out.pos);
+}
+
 void bch2_fs_btree_cache_exit(struct bch_fs *c)
 {
 	struct btree_cache *bc = &c->btree_cache;
@@ -478,6 +490,7 @@ int bch2_fs_btree_cache_init(struct bch_fs *c)
 	bc->shrink = shrink;
 	shrink->count_objects	= bch2_btree_cache_count;
 	shrink->scan_objects	= bch2_btree_cache_scan;
+	shrink->to_text		= bch2_btree_cache_shrinker_to_text;
 	shrink->seeks		= 4;
 	shrink->private_data	= c;
 	shrinker_register(shrink);
diff --git a/fs/bcachefs/btree_key_cache.c b/fs/bcachefs/btree_key_cache.c
index 4402cf068c56..e14e9b4cd029 100644
--- a/fs/bcachefs/btree_key_cache.c
+++ b/fs/bcachefs/btree_key_cache.c
@@ -13,6 +13,7 @@
 #include "trace.h"
 
 #include <linux/sched/mm.h>
+#include <linux/seq_buf.h>
 
 static inline bool btree_uses_pcpu_readers(enum btree_id id)
 {
@@ -1028,6 +1029,18 @@ void bch2_fs_btree_key_cache_init_early(struct btree_key_cache *c)
 	INIT_LIST_HEAD(&c->freed_nonpcpu);
 }
 
+static void bch2_btree_key_cache_shrinker_to_text(struct seq_buf *s, struct shrinker *shrink)
+{
+	struct bch_fs *c = shrink->private_data;
+	struct btree_key_cache *bc = &c->btree_key_cache;
+	char *cbuf;
+	size_t buflen = seq_buf_get_buf(s, &cbuf);
+	struct printbuf out = PRINTBUF_EXTERN(cbuf, buflen);
+
+	bch2_btree_key_cache_to_text(&out, bc);
+	seq_buf_commit(s, out.pos);
+}
+
 int bch2_fs_btree_key_cache_init(struct btree_key_cache *bc)
 {
 	struct bch_fs *c = container_of(bc, struct bch_fs, btree_key_cache);
@@ -1051,6 +1064,7 @@ int bch2_fs_btree_key_cache_init(struct btree_key_cache *bc)
 	shrink->seeks		= 0;
 	shrink->count_objects	= bch2_btree_key_cache_count;
 	shrink->scan_objects	= bch2_btree_key_cache_scan;
+	shrink->to_text		= bch2_btree_key_cache_shrinker_to_text;
 	shrink->private_data	= c;
 	shrinker_register(shrink);
 	return 0;
-- 
2.42.0

