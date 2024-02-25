Return-Path: <linux-kernel+bounces-79947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1648E8628E0
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 03:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6BE8281396
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 02:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF30E14F98;
	Sun, 25 Feb 2024 02:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Fjr7jqpM"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9599C18AE0
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 02:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708828734; cv=none; b=QdPqLjNS3TcLf2fDJokjw5n95CQIO+hPp7h6oEWDhxBW50lk1L816wWTSnzKQRlNoyNxbJzmYXogHevkfCZXqSYTgpV3rF/ird/wSZ/Od3/Co0MItdlyT/EJS4uKfTb1YTLCVrFHZk1IBd04X+rUv/2Yjgs9/3ZeTnnkpXRD4Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708828734; c=relaxed/simple;
	bh=CmRGISWqMl8OiQ/BrO+n0lHBIFvE2WpEgm7l++MU4x8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g6eD9dEd/0VH6o5k3WmfBRWknQ+mmGtpZi6Lnqq0war1rb9tiz9s3Oyf91di5yWbZzi2vUYq4YsBitcBf0cU5ZcVic1qnZU3rfgaq5/JG8l+19KQBEqXfRkVBZXqpRX9ll9GJhILWR9u8r3vJdVIPB18iOCvYV44odaZavU2qCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Fjr7jqpM; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708828731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KXqi/mUCPqaAmwNVCa/3pdqBU+XG+a15SZVPhvlslXA=;
	b=Fjr7jqpM1bfxbQZzfZEw2oEx+fC+2/tR+Hk4GtDWSMFSObqBrFPYCYyAx61DeCqFrB6BZV
	YN7kJt77NuFYbQv/Gjdssy8I0Qgx7U/GxmGEPG6PLtg35t0Z+WhBuwcXEv2NBjtttB3jDj
	B90A2do5+NkUf/ZfYL5c0dg/sNAKUlE=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	djwong@kernel.org,
	bfoster@redhat.com
Subject: [PATCH 18/21] bcachefs: bch_acct_compression
Date: Sat, 24 Feb 2024 21:38:20 -0500
Message-ID: <20240225023826.2413565-19-kent.overstreet@linux.dev>
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

This adds per-compression-type accounting of compressed and uncompressed
size as well as number of extents - meaning we can now see compression
ratio (without walking the whole filesystem).

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/bcachefs/buckets.c                | 45 ++++++++++++++++++++++++----
 fs/bcachefs/disk_accounting.c        |  4 +++
 fs/bcachefs/disk_accounting_format.h |  8 ++++-
 3 files changed, 51 insertions(+), 6 deletions(-)

diff --git a/fs/bcachefs/buckets.c b/fs/bcachefs/buckets.c
index 506bb580bff4..6078b67e51cf 100644
--- a/fs/bcachefs/buckets.c
+++ b/fs/bcachefs/buckets.c
@@ -503,6 +503,7 @@ static int __trigger_extent(struct btree_trans *trans,
 		: BCH_DATA_user;
 	s64 dirty_sectors = 0;
 	int ret = 0;
+	u64 compression_acct[3] = { 1, 0, 0 };
 
 	struct disk_accounting_key acc = {
 		.type			= BCH_DISK_ACCOUNTING_replicas,
@@ -511,6 +512,10 @@ static int __trigger_extent(struct btree_trans *trans,
 		.replicas.nr_required	= 1,
 	};
 
+	struct disk_accounting_key compression_key = {
+		.type			= BCH_DISK_ACCOUNTING_compression,
+	};
+
 	bkey_for_each_ptr_decode(k.k, ptrs, p, entry) {
 		s64 disk_sectors;
 		ret = bch2_trigger_pointer(trans, btree_id, level, k, p, &disk_sectors, flags);
@@ -519,12 +524,13 @@ static int __trigger_extent(struct btree_trans *trans,
 
 		bool stale = ret > 0;
 
+		if (p.ptr.cached && stale)
+			continue;
+
 		if (p.ptr.cached) {
-			if (!stale) {
-				ret = bch2_mod_dev_cached_sectors(trans, p.ptr.dev, disk_sectors, gc);
-				if (ret)
-					return ret;
-			}
+			ret = bch2_mod_dev_cached_sectors(trans, p.ptr.dev, disk_sectors, gc);
+			if (ret)
+				return ret;
 		} else if (!p.has_ec) {
 			dirty_sectors	       += disk_sectors;
 			acc.replicas.devs[acc.replicas.nr_devs++] = p.ptr.dev;
@@ -540,6 +546,26 @@ static int __trigger_extent(struct btree_trans *trans,
 			 */
 			acc.replicas.nr_required = 0;
 		}
+
+		if (compression_key.compression.type &&
+		    compression_key.compression.type != p.crc.compression_type) {
+			if (flags & BTREE_TRIGGER_OVERWRITE)
+				bch2_u64s_neg(compression_acct, 3);
+
+			ret = bch2_disk_accounting_mod(trans, &compression_key, compression_acct, 2, gc);
+			if (ret)
+				return ret;
+
+			compression_acct[0] = 1;
+			compression_acct[1] = 0;
+			compression_acct[2] = 0;
+		}
+
+		compression_key.compression.type = p.crc.compression_type;
+		if (p.crc.compression_type) {
+			compression_acct[1] += p.crc.uncompressed_size;
+			compression_acct[2] += p.crc.compressed_size;
+		}
 	}
 
 	if (acc.replicas.nr_devs) {
@@ -548,6 +574,15 @@ static int __trigger_extent(struct btree_trans *trans,
 			return ret;
 	}
 
+	if (compression_key.compression.type) {
+		if (flags & BTREE_TRIGGER_OVERWRITE)
+			bch2_u64s_neg(compression_acct, 3);
+
+		ret = bch2_disk_accounting_mod(trans, &compression_key, compression_acct, 3, gc);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
diff --git a/fs/bcachefs/disk_accounting.c b/fs/bcachefs/disk_accounting.c
index 8d7b6ab66e71..dc020d651d0a 100644
--- a/fs/bcachefs/disk_accounting.c
+++ b/fs/bcachefs/disk_accounting.c
@@ -5,6 +5,7 @@
 #include "btree_update.h"
 #include "btree_write_buffer.h"
 #include "buckets.h"
+#include "compress.h"
 #include "disk_accounting.h"
 #include "error.h"
 #include "journal_io.h"
@@ -91,6 +92,9 @@ void bch2_accounting_key_to_text(struct printbuf *out, struct disk_accounting_ke
 	case BCH_DISK_ACCOUNTING_dev_stripe_buckets:
 		prt_printf(out, "dev=%u", k->dev_stripe_buckets.dev);
 		break;
+	case BCH_DISK_ACCOUNTING_compression:
+		bch2_prt_compression_type(out, k->compression.type);
+		break;
 	}
 }
 
diff --git a/fs/bcachefs/disk_accounting_format.h b/fs/bcachefs/disk_accounting_format.h
index e06a42f0d578..75bfc9bce79f 100644
--- a/fs/bcachefs/disk_accounting_format.h
+++ b/fs/bcachefs/disk_accounting_format.h
@@ -95,7 +95,8 @@ static inline bool data_type_is_hidden(enum bch_data_type type)
 	x(persistent_reserved,	1)		\
 	x(replicas,		2)		\
 	x(dev_data_type,	3)		\
-	x(dev_stripe_buckets,	4)
+	x(dev_stripe_buckets,	4)		\
+	x(compression,		5)
 
 enum disk_accounting_type {
 #define x(f, nr)	BCH_DISK_ACCOUNTING_##f	= nr,
@@ -120,6 +121,10 @@ struct bch_dev_stripe_buckets {
 	__u8			dev;
 };
 
+struct bch_acct_compression {
+	__u8			type;
+};
+
 struct disk_accounting_key {
 	union {
 	struct {
@@ -130,6 +135,7 @@ struct disk_accounting_key {
 		struct bch_replicas_entry_v1	replicas;
 		struct bch_dev_data_type	dev_data_type;
 		struct bch_dev_stripe_buckets	dev_stripe_buckets;
+		struct bch_acct_compression	compression;
 		};
 	};
 		struct bpos			_pad;
-- 
2.43.0


