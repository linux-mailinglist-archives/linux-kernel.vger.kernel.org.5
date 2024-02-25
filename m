Return-Path: <linux-kernel+bounces-79950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D42D58628E4
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 03:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E3882821A7
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 02:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AB81BC27;
	Sun, 25 Feb 2024 02:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GtMroGI9"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A4E1AADD
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 02:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708828737; cv=none; b=uHSpJWvLppPfH27zWvWv4jTvwzFxcqgBoDRBwv3MLFn1NUXosVsaknDIs0wtj4iM0kwrb/xvQ6nkB6AhQVuSmXcficRwcq8Tu4/6iEziSsu29o1mgQJ8xQUfQqk1FtDX9aY8P/rkmCu36Hf8WiqKLEgb36hKMv12/dP4nzWNMBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708828737; c=relaxed/simple;
	bh=ZgM0zLMZFwJYqyvB4tXh9kF50cWRp9rLDmexM/GbfvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K8yU1fKcLEbGn9XDBWPWkIu38RE4zMe6a8SXSZiIwvFM//iKmPd1u68cik4aNQGUplzIHJifeddR5mR0nXr2RC1Q+8UuSD2GXKUmfGnTQ25HEjOk5DZ3vPlw3MVx2TwqqTOXZgH9EyNkmWQqmcBVsp8R06yWlIYDqJEce7bJhuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GtMroGI9; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708828732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=weqtx2u84KusAKamrBTKZCBf70EK9pRqL6N4MsvPgW0=;
	b=GtMroGI9SLS2HtSssDe36Rm8zROfrOV84oqSilqNyQ2mrClrsaF9kMvGGXEIGcdMFQ+4ox
	yEVdD91npxWvtmF924xIjbT+LsABnJdd8Pk4fMKyoMRA3ZTxdonTPh4BrzJXvRlvxiIqHj
	JLCJDAQVT9YdZ0xYe8lCVAXTYVeoW0U=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	djwong@kernel.org,
	bfoster@redhat.com
Subject: [PATCH 19/21] bcachefs: Convert bch2_compression_stats_to_text() to new accounting
Date: Sat, 24 Feb 2024 21:38:21 -0500
Message-ID: <20240225023826.2413565-20-kent.overstreet@linux.dev>
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

We no longer have to walk the whole btree to calculate compression
stats.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/bcachefs/sysfs.c | 85 ++++++++++-----------------------------------
 1 file changed, 18 insertions(+), 67 deletions(-)

diff --git a/fs/bcachefs/sysfs.c b/fs/bcachefs/sysfs.c
index c86a93a8d8fc..287a0bf920db 100644
--- a/fs/bcachefs/sysfs.c
+++ b/fs/bcachefs/sysfs.c
@@ -22,6 +22,7 @@
 #include "buckets.h"
 #include "clock.h"
 #include "compress.h"
+#include "disk_accounting.h"
 #include "disk_groups.h"
 #include "ec.h"
 #include "inode.h"
@@ -256,63 +257,6 @@ static size_t bch2_btree_cache_size(struct bch_fs *c)
 
 static int bch2_compression_stats_to_text(struct printbuf *out, struct bch_fs *c)
 {
-	struct btree_trans *trans;
-	enum btree_id id;
-	struct compression_type_stats {
-		u64		nr_extents;
-		u64		sectors_compressed;
-		u64		sectors_uncompressed;
-	} s[BCH_COMPRESSION_TYPE_NR];
-	u64 compressed_incompressible = 0;
-	int ret = 0;
-
-	memset(s, 0, sizeof(s));
-
-	if (!test_bit(BCH_FS_started, &c->flags))
-		return -EPERM;
-
-	trans = bch2_trans_get(c);
-
-	for (id = 0; id < BTREE_ID_NR; id++) {
-		if (!btree_type_has_ptrs(id))
-			continue;
-
-		ret = for_each_btree_key(trans, iter, id, POS_MIN,
-					 BTREE_ITER_ALL_SNAPSHOTS, k, ({
-			struct bkey_ptrs_c ptrs = bch2_bkey_ptrs_c(k);
-			struct bch_extent_crc_unpacked crc;
-			const union bch_extent_entry *entry;
-			bool compressed = false, incompressible = false;
-
-			bkey_for_each_crc(k.k, ptrs, crc, entry) {
-				incompressible	|= crc.compression_type == BCH_COMPRESSION_TYPE_incompressible;
-				compressed	|= crc_is_compressed(crc);
-
-				if (crc_is_compressed(crc)) {
-					s[crc.compression_type].nr_extents++;
-					s[crc.compression_type].sectors_compressed += crc.compressed_size;
-					s[crc.compression_type].sectors_uncompressed += crc.uncompressed_size;
-				}
-			}
-
-			compressed_incompressible += compressed && incompressible;
-
-			if (!compressed) {
-				unsigned t = incompressible ? BCH_COMPRESSION_TYPE_incompressible : 0;
-
-				s[t].nr_extents++;
-				s[t].sectors_compressed += k.k->size;
-				s[t].sectors_uncompressed += k.k->size;
-			}
-			0;
-		}));
-	}
-
-	bch2_trans_put(trans);
-
-	if (ret)
-		return ret;
-
 	prt_str(out, "type");
 	printbuf_tabstop_push(out, 12);
 	prt_tab(out);
@@ -330,28 +274,35 @@ static int bch2_compression_stats_to_text(struct printbuf *out, struct bch_fs *c
 	prt_tab_rjust(out);
 	prt_newline(out);
 
-	for (unsigned i = 0; i < ARRAY_SIZE(s); i++) {
+	for (unsigned i = 1; i < BCH_COMPRESSION_TYPE_NR; i++) {
+		struct disk_accounting_key a = {
+			.type			= BCH_DISK_ACCOUNTING_compression,
+			.compression.type	= i,
+		};
+		struct bpos p = disk_accounting_key_to_bpos(&a);
+		u64 v[3];
+		bch2_accounting_mem_read(c, p, v, ARRAY_SIZE(v));
+
+		u64 nr_extents			= v[0];
+		u64 sectors_uncompressed	= v[1];
+		u64 sectors_compressed		= v[2];
+
 		bch2_prt_compression_type(out, i);
 		prt_tab(out);
 
-		prt_human_readable_u64(out, s[i].sectors_compressed << 9);
+		prt_human_readable_u64(out, sectors_compressed << 9);
 		prt_tab_rjust(out);
 
-		prt_human_readable_u64(out, s[i].sectors_uncompressed << 9);
+		prt_human_readable_u64(out, sectors_uncompressed << 9);
 		prt_tab_rjust(out);
 
-		prt_human_readable_u64(out, s[i].nr_extents
-				       ? div_u64(s[i].sectors_uncompressed << 9, s[i].nr_extents)
+		prt_human_readable_u64(out, nr_extents
+				       ? div_u64(sectors_uncompressed << 9, nr_extents)
 				       : 0);
 		prt_tab_rjust(out);
 		prt_newline(out);
 	}
 
-	if (compressed_incompressible) {
-		prt_printf(out, "%llu compressed & incompressible extents", compressed_incompressible);
-		prt_newline(out);
-	}
-
 	return 0;
 }
 
-- 
2.43.0


