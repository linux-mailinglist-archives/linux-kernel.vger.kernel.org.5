Return-Path: <linux-kernel+bounces-79948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 867508628E1
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 03:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 438792822D4
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 02:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107751B815;
	Sun, 25 Feb 2024 02:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dFpkOyJp"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3948F5256
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 02:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708828736; cv=none; b=T+csMglcWtcULjv8IjuQZ3wbJkVi/3sW1gVtk3uLdGarQZNFMGDi9qcaz2x6H0kl7MlZcl7f4DD/ztCWTK6yzI798d4yWaRo4Wa494VosLOWU/e0IQXFH29yWon08i+bK2gw9iPEe7PYlg5kwRhioqSZkJphxHiKhbtB2CNI8Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708828736; c=relaxed/simple;
	bh=d8WYXNqXDWpZE4u+quG0FNl5y/ZGCmEc/dORUsz9M60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ibvo9H8HwoFwj+SxxnoXCwWpmu87ojTXMgztXW4YULMRbcEuZvHut7ZBkZbBwJCrUe5v1+k3/qrt+ZXiQOzBbc1d3J+yQKe1sFyl1+URBaCaxx9wKhujT9inSnbLEVmo9qh4/raUEdxcrdeL55/tLZpvOjECESK15LK9H9RP2DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dFpkOyJp; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708828732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=njdVxTl+tyjYoQarlLc40yxm4EXppgie2qLf5Ju2emw=;
	b=dFpkOyJpE+vAWCrCeqjmgO4KjuyA+cNXR4K91DVMXSDUhtYjTvtg6YwMCkRtaUGjncIAsx
	KVLX5Brz3u8mgYUCbdcLe11heCjIT0PwXC0u2vfVqvnYCX5qsnu+oB+a9z3fHp9fGTSoyx
	WNE/5CtIf30n9gMB+JkKbtfWeKAW9Nc=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	djwong@kernel.org,
	bfoster@redhat.com
Subject: [PATCH 20/21] bcachefs: bch2_fs_accounting_to_text()
Date: Sat, 24 Feb 2024 21:38:22 -0500
Message-ID: <20240225023826.2413565-21-kent.overstreet@linux.dev>
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

Helper to show raw accounting in sysfs, mainly for debugging.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/bcachefs/disk_accounting.c | 26 ++++++++++++++++++++++++++
 fs/bcachefs/disk_accounting.h |  1 +
 fs/bcachefs/sysfs.c           |  5 +++++
 3 files changed, 32 insertions(+)

diff --git a/fs/bcachefs/disk_accounting.c b/fs/bcachefs/disk_accounting.c
index dc020d651d0a..9d6ca2ea307b 100644
--- a/fs/bcachefs/disk_accounting.c
+++ b/fs/bcachefs/disk_accounting.c
@@ -286,6 +286,32 @@ int bch2_fs_replicas_usage_read(struct bch_fs *c, darray_char *usage)
 	return ret;
 }
 
+void bch2_fs_accounting_to_text(struct printbuf *out, struct bch_fs *c)
+{
+	struct bch_accounting_mem *acc = &c->accounting[0];
+
+	percpu_down_read(&c->mark_lock);
+	out->atomic++;
+
+	eytzinger0_for_each(i, acc->k.nr) {
+		struct disk_accounting_key acc_k;
+		bpos_to_disk_accounting_key(&acc_k, acc->k.data[i].pos);
+
+		bch2_accounting_key_to_text(out, &acc_k);
+
+		u64 v[BCH_ACCOUNTING_MAX_COUNTERS];
+		bch2_accounting_mem_read_counters(c, i, v, ARRAY_SIZE(v), false);
+
+		prt_str(out, ":");
+		for (unsigned j = 0; j < acc->k.data[i].nr_counters; j++)
+			prt_printf(out, " %llu", v[j]);
+		prt_newline(out);
+	}
+
+	--out->atomic;
+	percpu_up_read(&c->mark_lock);
+}
+
 static int accounting_write_key(struct btree_trans *trans, struct bpos pos, u64 *v, unsigned nr_counters)
 {
 	struct bkey_i_accounting *a = bch2_trans_kmalloc(trans, sizeof(*a) + sizeof(*v) * nr_counters);
diff --git a/fs/bcachefs/disk_accounting.h b/fs/bcachefs/disk_accounting.h
index a0cf7a0b84a7..c4a8b9cce6ba 100644
--- a/fs/bcachefs/disk_accounting.h
+++ b/fs/bcachefs/disk_accounting.h
@@ -186,6 +186,7 @@ static inline void bch2_accounting_mem_read(struct bch_fs *c, struct bpos p,
 }
 
 int bch2_fs_replicas_usage_read(struct bch_fs *, darray_char *);
+void bch2_fs_accounting_to_text(struct printbuf *, struct bch_fs *);
 
 int bch2_accounting_gc_done(struct bch_fs *);
 
diff --git a/fs/bcachefs/sysfs.c b/fs/bcachefs/sysfs.c
index 287a0bf920db..10470cef30f0 100644
--- a/fs/bcachefs/sysfs.c
+++ b/fs/bcachefs/sysfs.c
@@ -204,6 +204,7 @@ read_attribute(disk_groups);
 
 read_attribute(has_data);
 read_attribute(alloc_debug);
+read_attribute(accounting);
 
 #define x(t, n, ...) read_attribute(t);
 BCH_PERSISTENT_COUNTERS()
@@ -413,6 +414,9 @@ SHOW(bch2_fs)
 	if (attr == &sysfs_disk_groups)
 		bch2_disk_groups_to_text(out, c);
 
+	if (attr == &sysfs_accounting)
+		bch2_fs_accounting_to_text(out, c);
+
 	return 0;
 }
 
@@ -625,6 +629,7 @@ struct attribute *bch2_fs_internal_files[] = {
 	&sysfs_internal_uuid,
 
 	&sysfs_disk_groups,
+	&sysfs_accounting,
 	NULL
 };
 
-- 
2.43.0


