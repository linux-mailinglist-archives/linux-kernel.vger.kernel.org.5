Return-Path: <linux-kernel+bounces-79942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FB28628DC
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 03:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F79A2821EB
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 02:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1ADE179BD;
	Sun, 25 Feb 2024 02:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mQAl7rg9"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D0D14290;
	Sun, 25 Feb 2024 02:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708828729; cv=none; b=cP7nhWJ0qmYicwVOLYF/Hx8hOb01kDLg0BjHL5v7zx9On3xdZILsRkTRHQ2jDmESOKv+o/ExcP1glDOpZxb9uV7qr5UVff8R2NbObz1lkcwi42zAoTJ0Ke6e84yGb6/FWHxhbLY8i40ZSIRzBD+qJGh7x5Dji99hhU+AOnlbNvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708828729; c=relaxed/simple;
	bh=kMbO4D6+stofxnjriibFLbcNaDrcicjpLGuvPqCK11g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dNYFV971j0KB0OF8iDGjH/lVnoP/0+6B2YTV/VOQkeIBpmWubLLmZwKtF6o6i6rEKJfEdmPzpPOkLAHjj3rwovb7tebRc9B9rE8gNONj4gm9tpYeH6jAAaeFW14Srzq7sGdiehcon2ojrQR/54oXeCB+42OuGIohQHVSho6fz5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mQAl7rg9; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708828726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3edXSLQswq3o2Ph2NSZVb78JLMRJ7gBJFLnjH1EUAXg=;
	b=mQAl7rg9h1+1IHylCVADyGyzkZr/GSbWxQva1XfNkPAt2v8iF8j36ZGPKMZcH3FpO2ZJlV
	mqAKIe3WpFCaH+SHL9OLToeuVfDRsT+zrbxzLd2tHXiJkI/pe5HnsEWbzu6H0vjzjfiHiD
	mwcKfh5u+5OFSgvOG5fAeL9IaTyy7HM=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	djwong@kernel.org,
	bfoster@redhat.com
Subject: [PATCH 13/21] bcachefs: Kill replicas_journal_res
Date: Sat, 24 Feb 2024 21:38:15 -0500
Message-ID: <20240225023826.2413565-14-kent.overstreet@linux.dev>
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

More dead code deletion

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/bcachefs/bcachefs.h |  2 --
 fs/bcachefs/replicas.c | 34 ----------------------------------
 fs/bcachefs/super.c    | 21 ---------------------
 3 files changed, 57 deletions(-)

diff --git a/fs/bcachefs/bcachefs.h b/fs/bcachefs/bcachefs.h
index 2e7c4d10c951..22dc455cb436 100644
--- a/fs/bcachefs/bcachefs.h
+++ b/fs/bcachefs/bcachefs.h
@@ -768,9 +768,7 @@ struct bch_fs {
 	struct mutex		replicas_gc_lock;
 
 	struct journal_entry_res btree_root_journal_res;
-	struct journal_entry_res replicas_journal_res;
 	struct journal_entry_res clock_journal_res;
-	struct journal_entry_res dev_usage_journal_res;
 
 	struct bch_disk_groups_cpu __rcu *disk_groups;
 
diff --git a/fs/bcachefs/replicas.c b/fs/bcachefs/replicas.c
index 6dca705eaf1f..427dc6711427 100644
--- a/fs/bcachefs/replicas.c
+++ b/fs/bcachefs/replicas.c
@@ -342,32 +342,6 @@ static int replicas_table_update(struct bch_fs *c,
 	goto out;
 }
 
-static unsigned reserve_journal_replicas(struct bch_fs *c,
-				     struct bch_replicas_cpu *r)
-{
-	struct bch_replicas_entry_v1 *e;
-	unsigned journal_res_u64s = 0;
-
-	/* nr_inodes: */
-	journal_res_u64s +=
-		DIV_ROUND_UP(sizeof(struct jset_entry_usage), sizeof(u64));
-
-	/* key_version: */
-	journal_res_u64s +=
-		DIV_ROUND_UP(sizeof(struct jset_entry_usage), sizeof(u64));
-
-	/* persistent_reserved: */
-	journal_res_u64s +=
-		DIV_ROUND_UP(sizeof(struct jset_entry_usage), sizeof(u64)) *
-		BCH_REPLICAS_MAX;
-
-	for_each_cpu_replicas_entry(r, e)
-		journal_res_u64s +=
-			DIV_ROUND_UP(sizeof(struct jset_entry_data_usage) +
-				     e->nr_devs, sizeof(u64));
-	return journal_res_u64s;
-}
-
 noinline
 static int bch2_mark_replicas_slowpath(struct bch_fs *c,
 				struct bch_replicas_entry_v1 *new_entry)
@@ -401,10 +375,6 @@ static int bch2_mark_replicas_slowpath(struct bch_fs *c,
 		ret = bch2_cpu_replicas_to_sb_replicas(c, &new_r);
 		if (ret)
 			goto err;
-
-		bch2_journal_entry_res_resize(&c->journal,
-				&c->replicas_journal_res,
-				reserve_journal_replicas(c, &new_r));
 	}
 
 	if (!new_r.entries &&
@@ -974,9 +944,5 @@ void bch2_fs_replicas_exit(struct bch_fs *c)
 
 int bch2_fs_replicas_init(struct bch_fs *c)
 {
-	bch2_journal_entry_res_resize(&c->journal,
-			&c->replicas_journal_res,
-			reserve_journal_replicas(c, &c->replicas));
-
 	return replicas_table_update(c, &c->replicas);
 }
diff --git a/fs/bcachefs/super.c b/fs/bcachefs/super.c
index 30b41c8de309..89c481831608 100644
--- a/fs/bcachefs/super.c
+++ b/fs/bcachefs/super.c
@@ -221,22 +221,6 @@ struct bch_fs *bch2_uuid_to_fs(__uuid_t uuid)
 	return c;
 }
 
-static void bch2_dev_usage_journal_reserve(struct bch_fs *c)
-{
-	unsigned nr = 0, u64s =
-		((sizeof(struct jset_entry_dev_usage) +
-		  sizeof(struct jset_entry_dev_usage_type) * BCH_DATA_NR)) /
-		sizeof(u64);
-
-	rcu_read_lock();
-	for_each_member_device_rcu(c, ca, NULL)
-		nr++;
-	rcu_read_unlock();
-
-	bch2_journal_entry_res_resize(&c->journal,
-			&c->dev_usage_journal_res, u64s * nr);
-}
-
 /* Filesystem RO/RW: */
 
 /*
@@ -940,7 +924,6 @@ static struct bch_fs *bch2_fs_alloc(struct bch_sb *sb, struct bch_opts opts)
 	bch2_journal_entry_res_resize(&c->journal,
 			&c->btree_root_journal_res,
 			BTREE_ID_NR * (JSET_KEYS_U64s + BKEY_BTREE_PTR_U64s_MAX));
-	bch2_dev_usage_journal_reserve(c);
 	bch2_journal_entry_res_resize(&c->journal,
 			&c->clock_journal_res,
 			(sizeof(struct jset_entry_clock) / sizeof(u64)) * 2);
@@ -1680,8 +1663,6 @@ int bch2_dev_remove(struct bch_fs *c, struct bch_dev *ca, int flags)
 
 	mutex_unlock(&c->sb_lock);
 	up_write(&c->state_lock);
-
-	bch2_dev_usage_journal_reserve(c);
 	return 0;
 err:
 	if (ca->mi.state == BCH_MEMBER_STATE_rw &&
@@ -1791,8 +1772,6 @@ int bch2_dev_add(struct bch_fs *c, const char *path)
 	bch2_write_super(c);
 	mutex_unlock(&c->sb_lock);
 
-	bch2_dev_usage_journal_reserve(c);
-
 	ret = bch2_dev_usage_init(ca);
 	if (ret)
 		goto err_late;
-- 
2.43.0


