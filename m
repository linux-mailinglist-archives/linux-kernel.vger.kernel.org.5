Return-Path: <linux-kernel+bounces-79934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9ED68628D4
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 03:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AD78B2135F
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 02:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B60EEDE;
	Sun, 25 Feb 2024 02:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="d2sSfVLe"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E6FA94D
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 02:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708828723; cv=none; b=j1xCyMinpPAJAlF/D013XSifeQFrhKLIm07PK9/KcVucrEL0v0gvtPwYnyDe0V1zTDhFP91BsyUyKEhQI+hXmpWw9vrJUaw6z5AT/67t+JiIFabOU1WnDAliyaBYkoD7/8gCQNwyu/p3UPJ86bD4wzMnkLoPOQ38L+ilfREmilI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708828723; c=relaxed/simple;
	bh=p7O3MH5Pv6ZYytgnV2uzMgTPCfEDxUNuHv6Bvd2aaxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lfg3S5hYDoSZHJyK+kTNZTm6PR8Oa1tGglSfvWp/inlbYsjR7JxTsm922S0kcV8D1upAKcSVcjdejJ81ydHbbnSYczkolvOetsrBsAB6YinTI56W20LszvMzS6pz/NtHUbv8o+axsr0am2ag5TEKnwOdgX0WmRptjrilwUj0kMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=d2sSfVLe; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708828719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LpqGNmxVz4nH/s+HZrDUNHReRjWltPhY2a8VCj1nHDg=;
	b=d2sSfVLeCn+Z852b+5f+xPu13H2zmwi9gFUfGFrtsmTCSf3LTon4K8IJSM6bwVmCNw2lG7
	7Sa57u1Vi3FPOp77P/As+QRnYkx0/cljMXy1JBdts1G3Af1FVHyF97qPKePgv03wwEZxPy
	djVNmYb5U+qdpDcb2mbbph7W50k1YXc=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	djwong@kernel.org,
	bfoster@redhat.com
Subject: [PATCH 06/21] bcachefs: Kill bch2_fs_usage_initialize()
Date: Sat, 24 Feb 2024 21:38:08 -0500
Message-ID: <20240225023826.2413565-7-kent.overstreet@linux.dev>
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

Deleting code for the old disk accounting scheme.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/bcachefs/buckets.c  | 29 -----------------------------
 fs/bcachefs/buckets.h  |  2 --
 fs/bcachefs/recovery.c |  2 --
 3 files changed, 33 deletions(-)

diff --git a/fs/bcachefs/buckets.c b/fs/bcachefs/buckets.c
index 7540486ae266..054c4c8d9c1b 100644
--- a/fs/bcachefs/buckets.c
+++ b/fs/bcachefs/buckets.c
@@ -38,35 +38,6 @@ static inline struct bch_fs_usage *fs_usage_ptr(struct bch_fs *c,
 			    : c->usage[journal_seq & JOURNAL_BUF_MASK]);
 }
 
-void bch2_fs_usage_initialize(struct bch_fs *c)
-{
-	percpu_down_write(&c->mark_lock);
-	struct bch_fs_usage *usage = c->usage_base;
-
-	for (unsigned i = 0; i < ARRAY_SIZE(c->usage); i++)
-		bch2_fs_usage_acc_to_base(c, i);
-
-	for (unsigned i = 0; i < BCH_REPLICAS_MAX; i++)
-		usage->b.reserved += usage->persistent_reserved[i];
-
-	for (unsigned i = 0; i < c->replicas.nr; i++) {
-		struct bch_replicas_entry_v1 *e =
-			cpu_replicas_entry(&c->replicas, i);
-
-		fs_usage_data_type_to_base(&usage->b, e->data_type, usage->replicas[i]);
-	}
-
-	for_each_member_device(c, ca) {
-		struct bch_dev_usage dev = bch2_dev_usage_read(ca);
-
-		usage->b.hidden += (dev.d[BCH_DATA_sb].buckets +
-				  dev.d[BCH_DATA_journal].buckets) *
-			ca->mi.bucket_size;
-	}
-
-	percpu_up_write(&c->mark_lock);
-}
-
 void bch2_dev_usage_read_fast(struct bch_dev *ca, struct bch_dev_usage *usage)
 {
 	memset(usage, 0, sizeof(*usage));
diff --git a/fs/bcachefs/buckets.h b/fs/bcachefs/buckets.h
index f9a1d24c997b..4e14615c770e 100644
--- a/fs/bcachefs/buckets.h
+++ b/fs/bcachefs/buckets.h
@@ -316,8 +316,6 @@ void bch2_dev_usage_update_m(struct bch_fs *, struct bch_dev *,
 int bch2_update_replicas(struct bch_fs *, struct bkey_s_c,
 			 struct bch_replicas_entry_v1 *, s64);
 
-void bch2_fs_usage_initialize(struct bch_fs *);
-
 int bch2_check_bucket_ref(struct btree_trans *, struct bkey_s_c,
 			  const struct bch_extent_ptr *,
 			  s64, enum bch_data_type, u8, u8, u32);
diff --git a/fs/bcachefs/recovery.c b/fs/bcachefs/recovery.c
index 5a0ab3920382..4936b18e5a58 100644
--- a/fs/bcachefs/recovery.c
+++ b/fs/bcachefs/recovery.c
@@ -426,8 +426,6 @@ static int journal_replay_early(struct bch_fs *c,
 		}
 	}
 
-	bch2_fs_usage_initialize(c);
-
 	return 0;
 }
 
-- 
2.43.0


