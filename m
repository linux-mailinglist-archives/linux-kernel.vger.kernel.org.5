Return-Path: <linux-kernel+bounces-79946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A77B68628DF
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 03:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54E14282225
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 02:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA38C2D6;
	Sun, 25 Feb 2024 02:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P1ACEzCo"
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C3E1805A
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 02:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708828734; cv=none; b=lPuBQpE6jLSUlAlRu1ujxBHZAPCLrF6pg+o7ZH+NQDfROtniHKy65/XVRAjU7kcolynZk+fl8ThgdQ4ty34gaCvJjCCvRdVcjqQOvQS4yXF0/s87ompN4JuFkam1f38axuss/0d9TpT5l3H51/nn6kntqBCySYbFrGEgwcM2VMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708828734; c=relaxed/simple;
	bh=9aDC/MHLqlfI7ZdF71omQwXEoDMiNVdOwQThfvn1sVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uJ5Eq7O7GcmmxHyz9HTMRzbB/MNwSJK6aUV6RiROo1lkSaaW0Ia9tqNk1o2YTUd8VBLffQWSKzlsGgLC0yir3c7fZKbb598TMMXimLpaHsy/3hYItvMotOrLCb/gW/F1+D5lUZig4A/W7xIE+3NygmxUBKwumFY13PKjJiUHKxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=P1ACEzCo; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708828730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DZ05Q5mbXYgDagN6r2B0XGx91E8emllsAKskdvguQ3M=;
	b=P1ACEzCotmgZtAdngBcAlZDwiID3fTZ23wEWyAp6dqymLfSg0PrfkPjzlmAqAK6csR0B4E
	mJVmcwwKGucTeMgN+bOT4aqQmHfnSfYgVYLffQCwjGTHCGwi3erHybuFlhHDg6UBMT/VLD
	nKLa/tn48WNpIGD2S25xiBzDYmsdnLk=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	djwong@kernel.org,
	bfoster@redhat.com
Subject: [PATCH 17/21] bcachefs: Eytzinger accumulation for accounting keys
Date: Sat, 24 Feb 2024 21:38:19 -0500
Message-ID: <20240225023826.2413565-18-kent.overstreet@linux.dev>
In-Reply-To: <20240225023826.2413565-1-kent.overstreet@linux.dev>
References: <20240225023826.2413565-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The btree write buffer takes as input keys from the journal, sorts them,
deduplicates them, and flushes them back to the btree in sorted order.

The disk space accounting rewrite is moving accounting to normal btree
keys, with update (in this case deltas) accumulated in the write buffer
and then flushed to the btree; but this is going to increase the number
of keys handled by the write buffer by perhaps as much as a factor of
3x-5x.

The overhead from copying around and sorting this many keys would cause
a significant performance regression, but: there is huge locality in
updates to accounting keys that we can take advantage of.

Instead of appending accounting keys to the list of keys to be sorted,
this patch adds an eytzinger search tree of recently seen accounting
keys. We look up the accounting key in the eytzinger search tree and
apply the delta directly, adding it if it doesn't exist, and
periodically prune the eytzinger tree of unused entries.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/bcachefs/btree_write_buffer.c       | 54 +++++++++++++++++++++++++-
 fs/bcachefs/btree_write_buffer.h       | 50 ++++++++++++++++++++++--
 fs/bcachefs/btree_write_buffer_types.h |  2 +
 fs/bcachefs/journal_io.c               | 13 +++++--
 4 files changed, 110 insertions(+), 9 deletions(-)

diff --git a/fs/bcachefs/btree_write_buffer.c b/fs/bcachefs/btree_write_buffer.c
index 002a0762fc85..13f5f63e22b7 100644
--- a/fs/bcachefs/btree_write_buffer.c
+++ b/fs/bcachefs/btree_write_buffer.c
@@ -531,6 +531,29 @@ static void bch2_btree_write_buffer_flush_work(struct work_struct *work)
 	bch2_write_ref_put(c, BCH_WRITE_REF_btree_write_buffer);
 }
 
+static void wb_accounting_sort(struct btree_write_buffer *wb)
+{
+	eytzinger0_sort(wb->accounting.data, wb->accounting.nr,
+			sizeof(wb->accounting.data[0]),
+			wb_key_cmp, NULL);
+}
+
+int bch2_accounting_key_to_wb_slowpath(struct bch_fs *c, enum btree_id btree,
+				       struct bkey_i_accounting *k)
+{
+	struct btree_write_buffer *wb = &c->btree_write_buffer;
+	struct btree_write_buffered_key new = { .btree = btree };
+
+	bkey_copy(&new.k, &k->k_i);
+
+	int ret = darray_push(&wb->accounting, new);
+	if (ret)
+		return ret;
+
+	wb_accounting_sort(wb);
+	return 0;
+}
+
 int bch2_journal_key_to_wb_slowpath(struct bch_fs *c,
 			     struct journal_keys_to_wb *dst,
 			     enum btree_id btree, struct bkey_i *k)
@@ -600,11 +623,35 @@ void bch2_journal_keys_to_write_buffer_start(struct bch_fs *c, struct journal_ke
 
 	bch2_journal_pin_add(&c->journal, seq, &dst->wb->pin,
 			     bch2_btree_write_buffer_journal_flush);
+
+	darray_for_each(wb->accounting, i)
+		memset(&i->k.v, 0, bkey_val_bytes(&i->k.k));
 }
 
-void bch2_journal_keys_to_write_buffer_end(struct bch_fs *c, struct journal_keys_to_wb *dst)
+int bch2_journal_keys_to_write_buffer_end(struct bch_fs *c, struct journal_keys_to_wb *dst)
 {
 	struct btree_write_buffer *wb = &c->btree_write_buffer;
+	unsigned live_accounting_keys = 0;
+	int ret = 0;
+
+	darray_for_each(wb->accounting, i)
+		if (!bch2_accounting_key_is_zero(bkey_i_to_s_c_accounting(&i->k))) {
+			i->journal_seq = dst->seq;
+			live_accounting_keys++;
+			ret = __bch2_journal_key_to_wb(c, dst, i->btree, &i->k);
+			if (ret)
+				break;
+		}
+
+	if (live_accounting_keys * 2 < wb->accounting.nr) {
+		struct btree_write_buffered_key *dst = wb->accounting.data;
+
+		darray_for_each(wb->accounting, src)
+			if (!bch2_accounting_key_is_zero(bkey_i_to_s_c_accounting(&src->k)))
+				*dst++ = *src;
+		wb->accounting.nr = dst - wb->accounting.data;
+		wb_accounting_sort(wb);
+	}
 
 	if (!dst->wb->keys.nr)
 		bch2_journal_pin_drop(&c->journal, &dst->wb->pin);
@@ -617,6 +664,8 @@ void bch2_journal_keys_to_write_buffer_end(struct bch_fs *c, struct journal_keys
 	if (dst->wb == &wb->flushing)
 		mutex_unlock(&wb->flushing.lock);
 	mutex_unlock(&wb->inc.lock);
+
+	return ret;
 }
 
 static int bch2_journal_keys_to_write_buffer(struct bch_fs *c, struct journal_buf *buf)
@@ -640,7 +689,7 @@ static int bch2_journal_keys_to_write_buffer(struct bch_fs *c, struct journal_bu
 	buf->need_flush_to_write_buffer = false;
 	spin_unlock(&c->journal.lock);
 out:
-	bch2_journal_keys_to_write_buffer_end(c, &dst);
+	ret = bch2_journal_keys_to_write_buffer_end(c, &dst) ?: ret;
 	return ret;
 }
 
@@ -672,6 +721,7 @@ void bch2_fs_btree_write_buffer_exit(struct bch_fs *c)
 	BUG_ON((wb->inc.keys.nr || wb->flushing.keys.nr) &&
 	       !bch2_journal_error(&c->journal));
 
+	darray_exit(&wb->accounting);
 	darray_exit(&wb->sorted);
 	darray_exit(&wb->flushing.keys);
 	darray_exit(&wb->inc.keys);
diff --git a/fs/bcachefs/btree_write_buffer.h b/fs/bcachefs/btree_write_buffer.h
index eebcd2b15249..828e2deaaa3d 100644
--- a/fs/bcachefs/btree_write_buffer.h
+++ b/fs/bcachefs/btree_write_buffer.h
@@ -3,6 +3,8 @@
 #define _BCACHEFS_BTREE_WRITE_BUFFER_H
 
 #include "bkey.h"
+#include "disk_accounting.h"
+#include <linux/eytzinger.h>
 
 static inline bool bch2_btree_write_buffer_should_flush(struct bch_fs *c)
 {
@@ -29,16 +31,45 @@ struct journal_keys_to_wb {
 	u64				seq;
 };
 
+static inline int wb_key_cmp(const void *_l, const void *_r)
+{
+	const struct btree_write_buffered_key *l = _l;
+	const struct btree_write_buffered_key *r = _r;
+
+	return cmp_int(l->btree, r->btree) ?: bpos_cmp(l->k.k.p, r->k.k.p);
+}
+
+int bch2_accounting_key_to_wb_slowpath(struct bch_fs *,
+			      enum btree_id, struct bkey_i_accounting *);
+
+static inline int bch2_accounting_key_to_wb(struct bch_fs *c,
+			     enum btree_id btree, struct bkey_i_accounting *k)
+{
+	struct btree_write_buffer *wb = &c->btree_write_buffer;
+	struct btree_write_buffered_key search;
+	search.btree = btree;
+	search.k.k.p = k->k.p;
+
+	unsigned idx = eytzinger0_find(wb->accounting.data, wb->accounting.nr,
+			sizeof(wb->accounting.data[0]),
+			wb_key_cmp, &search);
+
+	if (idx >= wb->accounting.nr)
+		return bch2_accounting_key_to_wb_slowpath(c, btree, k);
+
+	struct bkey_i_accounting *dst = bkey_i_to_accounting(&wb->accounting.data[idx].k);
+	bch2_accounting_accumulate(dst, accounting_i_to_s_c(k));
+	return 0;
+}
+
 int bch2_journal_key_to_wb_slowpath(struct bch_fs *,
 			     struct journal_keys_to_wb *,
 			     enum btree_id, struct bkey_i *);
 
-static inline int bch2_journal_key_to_wb(struct bch_fs *c,
+static inline int __bch2_journal_key_to_wb(struct bch_fs *c,
 			     struct journal_keys_to_wb *dst,
 			     enum btree_id btree, struct bkey_i *k)
 {
-	EBUG_ON(!dst->seq);
-
 	if (unlikely(!dst->room))
 		return bch2_journal_key_to_wb_slowpath(c, dst, btree, k);
 
@@ -51,8 +82,19 @@ static inline int bch2_journal_key_to_wb(struct bch_fs *c,
 	return 0;
 }
 
+static inline int bch2_journal_key_to_wb(struct bch_fs *c,
+			     struct journal_keys_to_wb *dst,
+			     enum btree_id btree, struct bkey_i *k)
+{
+	EBUG_ON(!dst->seq);
+
+	return k->k.type == KEY_TYPE_accounting
+		? bch2_accounting_key_to_wb(c, btree, bkey_i_to_accounting(k))
+		: __bch2_journal_key_to_wb(c, dst, btree, k);
+}
+
 void bch2_journal_keys_to_write_buffer_start(struct bch_fs *, struct journal_keys_to_wb *, u64);
-void bch2_journal_keys_to_write_buffer_end(struct bch_fs *, struct journal_keys_to_wb *);
+int bch2_journal_keys_to_write_buffer_end(struct bch_fs *, struct journal_keys_to_wb *);
 
 int bch2_btree_write_buffer_resize(struct bch_fs *, size_t);
 void bch2_fs_btree_write_buffer_exit(struct bch_fs *);
diff --git a/fs/bcachefs/btree_write_buffer_types.h b/fs/bcachefs/btree_write_buffer_types.h
index 5f248873087c..d39d163c6ea9 100644
--- a/fs/bcachefs/btree_write_buffer_types.h
+++ b/fs/bcachefs/btree_write_buffer_types.h
@@ -52,6 +52,8 @@ struct btree_write_buffer {
 	struct btree_write_buffer_keys	inc;
 	struct btree_write_buffer_keys	flushing;
 	struct work_struct		flush_work;
+
+	DARRAY(struct btree_write_buffered_key) accounting;
 };
 
 #endif /* _BCACHEFS_BTREE_WRITE_BUFFER_TYPES_H */
diff --git a/fs/bcachefs/journal_io.c b/fs/bcachefs/journal_io.c
index b37b75ccd602..3ea2be99d411 100644
--- a/fs/bcachefs/journal_io.c
+++ b/fs/bcachefs/journal_io.c
@@ -1815,7 +1815,8 @@ static int bch2_journal_write_prep(struct journal *j, struct journal_buf *w)
 			jset_entry_for_each_key(i, k) {
 				ret = bch2_journal_key_to_wb(c, &wb, i->btree_id, k);
 				if (ret) {
-					bch2_fs_fatal_error(c, "-ENOMEM flushing journal keys to btree write buffer");
+					bch2_fs_fatal_error(c, "error flushing journal keys to btree write buffer: %s",
+							    bch2_err_str(ret));
 					bch2_journal_keys_to_write_buffer_end(c, &wb);
 					return ret;
 				}
@@ -1825,8 +1826,14 @@ static int bch2_journal_write_prep(struct journal *j, struct journal_buf *w)
 		}
 	}
 
-	if (wb.wb)
-		bch2_journal_keys_to_write_buffer_end(c, &wb);
+	if (wb.wb) {
+		ret = bch2_journal_keys_to_write_buffer_end(c, &wb);
+		if (ret) {
+			bch2_fs_fatal_error(c, "error flushing journal keys to btree write buffer: %s",
+					    bch2_err_str(ret));
+			return ret;
+		}
+	}
 
 	spin_lock(&c->journal.lock);
 	w->need_flush_to_write_buffer = false;
-- 
2.43.0


