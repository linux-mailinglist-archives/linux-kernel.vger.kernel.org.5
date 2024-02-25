Return-Path: <linux-kernel+bounces-79944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2013E8628DE
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 03:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFF452819D8
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 02:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F641AADB;
	Sun, 25 Feb 2024 02:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t5Uq6mW9"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0E317BBB
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 02:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708828732; cv=none; b=aaa47r7CRweTWVCw1cg+Up3mMUj+FvtoBi0dK+lljd0wX3Bsp5YVmGOP2nfBskhk0WdKdCIsRXDmIfSBZfbZLbrDlfhQ3GKn0PudWWUE4xqkJ8Ax75cKIe7gDb0AscvBZig8wUOQBFGHW3IxOyvo3EIC/Ssu4KRD4qnsHYZqEFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708828732; c=relaxed/simple;
	bh=693nN94qUSbbDkqHrUPV8kMgo4OMZv7SWEQcI8AOyfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HPDPzzRrjxFQG2bayNX7etKnCs0ChDJsEaGuBnXa1I6GOPjZxspUE4QuXiIbxlifzcYgpQI+6OmF0x71YvEiOBPSkYpT1S6G1aRprIFz/xjxVVbsVs+Dw0JiGaok093q8yjevgHwzNy/KYISfOU+B8nYRtQfySClTisrpfjSaic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=t5Uq6mW9; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708828729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qtt8N3DTXT8YcoliwHPFpPxKQXIz9TTQtDYUciFTLnM=;
	b=t5Uq6mW9GG3Iozxg1JY5qA7lforHDcbj+wg4MIkQsFH4ck90PVZ93xMlSgL4eMlDl2woyi
	EvPtgsLVWvtMuqILOQqRjhSeb3Dmsvw1RAoitJjHJDyZJ4aMCg5VZlKRoiFlMU1RXMTgZb
	bE7B3hd9Ir4lBJC32mIPIaOweIf8fqk=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	djwong@kernel.org,
	bfoster@redhat.com
Subject: [PATCH 16/21] bcachefs: bch2_verify_accounting_clean()
Date: Sat, 24 Feb 2024 21:38:18 -0500
Message-ID: <20240225023826.2413565-17-kent.overstreet@linux.dev>
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

Verify that the in-memory accounting verifies the on-disk accounting
after a clean shutdown.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/bcachefs/disk_accounting.c | 27 +++++++++++++++++++++++++++
 fs/bcachefs/disk_accounting.h |  4 +++-
 fs/bcachefs/super.c           |  1 +
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/fs/bcachefs/disk_accounting.c b/fs/bcachefs/disk_accounting.c
index 2884615adc1e..8d7b6ab66e71 100644
--- a/fs/bcachefs/disk_accounting.c
+++ b/fs/bcachefs/disk_accounting.c
@@ -513,6 +513,33 @@ int bch2_dev_usage_init(struct bch_dev *ca, bool gc)
 	return ret;
 }
 
+void bch2_verify_accounting_clean(struct bch_fs *c)
+{
+	bch2_trans_run(c,
+		for_each_btree_key(trans, iter,
+				   BTREE_ID_accounting, POS_MIN,
+				   BTREE_ITER_ALL_SNAPSHOTS, k, ({
+			u64 v[BCH_ACCOUNTING_MAX_COUNTERS];
+			struct bkey_s_c_accounting a = bkey_s_c_to_accounting(k);
+			unsigned nr = bch2_accounting_counters(k.k);
+
+			bch2_accounting_mem_read(c, k.k->p, v, nr);
+
+			if (memcmp(a.v->d, v, nr * sizeof(u64))) {
+				struct printbuf buf = PRINTBUF;
+
+				bch2_bkey_val_to_text(&buf, c, k);
+				prt_str(&buf, " in mem");
+				for (unsigned j = 0; j < nr; j++)
+					prt_printf(&buf, " %llu", v[j]);
+
+				WARN(1, "accounting mismatch: %s", buf.buf);
+				printbuf_exit(&buf);
+			}
+			0;
+		})));
+}
+
 void bch2_accounting_free(struct bch_accounting_mem *acc)
 {
 	darray_exit(&acc->k);
diff --git a/fs/bcachefs/disk_accounting.h b/fs/bcachefs/disk_accounting.h
index 70ac67f4a3cb..a0cf7a0b84a7 100644
--- a/fs/bcachefs/disk_accounting.h
+++ b/fs/bcachefs/disk_accounting.h
@@ -164,7 +164,7 @@ static inline void bch2_accounting_mem_read_counters(struct bch_fs *c, unsigned
 {
 	memset(v, 0, sizeof(*v) * nr);
 
-	struct bch_accounting_mem *acc = &c->accounting[0];
+	struct bch_accounting_mem *acc = &c->accounting[gc];
 	if (unlikely(idx >= acc->k.nr))
 		return;
 
@@ -194,6 +194,8 @@ int bch2_accounting_read(struct bch_fs *);
 int bch2_dev_usage_remove(struct bch_fs *, unsigned);
 int bch2_dev_usage_init(struct bch_dev *, bool);
 
+void bch2_verify_accounting_clean(struct bch_fs *c);
+
 void bch2_accounting_free(struct bch_accounting_mem *);
 void bch2_fs_accounting_exit(struct bch_fs *);
 
diff --git a/fs/bcachefs/super.c b/fs/bcachefs/super.c
index 6617c8912e51..201d7767e478 100644
--- a/fs/bcachefs/super.c
+++ b/fs/bcachefs/super.c
@@ -355,6 +355,7 @@ void bch2_fs_read_only(struct bch_fs *c)
 		BUG_ON(atomic_long_read(&c->btree_key_cache.nr_dirty));
 		BUG_ON(c->btree_write_buffer.inc.keys.nr);
 		BUG_ON(c->btree_write_buffer.flushing.keys.nr);
+		bch2_verify_accounting_clean(c);
 
 		bch_verbose(c, "marking filesystem clean");
 		bch2_fs_mark_clean(c);
-- 
2.43.0


