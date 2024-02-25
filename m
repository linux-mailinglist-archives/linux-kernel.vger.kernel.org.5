Return-Path: <linux-kernel+bounces-79943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 756578628DD
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 03:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FEA0282247
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 02:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD1B18EBF;
	Sun, 25 Feb 2024 02:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xf2Xkblz"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3814017756
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 02:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708828732; cv=none; b=goeLBd3I6gfBv+ar/1ETvfT37Ekl3UKqdSKWeK9rzixhc8ggmnzhfmuxjrTVW3shYWvbDVuMxkdGTXGRyEs15K5bNdTB+IkLgaji+C3SQ8FvKN8j+TLXKcyoU2liwdYV476f/VB/o7ZJznCDw7G1NIECtg2fSDzJklyFR9gJTl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708828732; c=relaxed/simple;
	bh=8Dzr04OBJMHQlzrTPGyog2ZCPLnWs2SakI+yYoIZVac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mJyIUkcdrgnTcMGprniKIt0HNThF1cywJ38RhTZoeoDzHOwPtBlhNhRg6Xch7RASXNAMR7sAMyO+ICluQZO0Z8i3yPmbPU+sZorCsmdyfpOdWROHcTSd393qAkNxOqcHe28YmBcn+zSacwZeveCQOyzNbY/A2hBmVD8n8jzbPZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xf2Xkblz; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708828728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y3FpSQO+5DeuDSgLy4pK3aklIcBNM9sDCfco3eXxsBU=;
	b=xf2Xkblz2aGS8hwBJXBPOzrrYlK07lSAMxX8n8o5PQQs8pqo7kZxNeCbl8l4YxHUTwjU4D
	CKMJpJCYI2oY55RXahByj51h/1LiFp8t5V8mhhNFeyU/a55ugr0omICPqdcmsDQRUoc1sW
	puYGne+ebIvnIdlMhYYEkyM+2zQMIw8=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	djwong@kernel.org,
	bfoster@redhat.com
Subject: [PATCH 15/21] bcachefs: Convert bch2_replicas_gc2() to new accounting
Date: Sat, 24 Feb 2024 21:38:17 -0500
Message-ID: <20240225023826.2413565-16-kent.overstreet@linux.dev>
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

bch2_replicas_gc2() is used for garbage collection superblock replicas
entries that are empty - this converts it to the new accounting scheme.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/bcachefs/replicas.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/fs/bcachefs/replicas.c b/fs/bcachefs/replicas.c
index cba5ba44cfd8..18137abb1857 100644
--- a/fs/bcachefs/replicas.c
+++ b/fs/bcachefs/replicas.c
@@ -2,6 +2,7 @@
 
 #include "bcachefs.h"
 #include "buckets.h"
+#include "disk_accounting.h"
 #include "journal.h"
 #include "replicas.h"
 #include "super-io.h"
@@ -425,8 +426,6 @@ int bch2_replicas_gc_start(struct bch_fs *c, unsigned typemask)
  */
 int bch2_replicas_gc2(struct bch_fs *c)
 {
-	return 0;
-#if 0
 	struct bch_replicas_cpu new = { 0 };
 	unsigned i, nr;
 	int ret = 0;
@@ -456,20 +455,26 @@ int bch2_replicas_gc2(struct bch_fs *c)
 		struct bch_replicas_entry_v1 *e =
 			cpu_replicas_entry(&c->replicas, i);
 
-		if (e->data_type == BCH_DATA_journal ||
-		    c->usage_base->replicas[i] ||
-		    percpu_u64_get(&c->usage[0]->replicas[i]) ||
-		    percpu_u64_get(&c->usage[1]->replicas[i]) ||
-		    percpu_u64_get(&c->usage[2]->replicas[i]) ||
-		    percpu_u64_get(&c->usage[3]->replicas[i]))
+		struct disk_accounting_key k = {
+			.type = BCH_DISK_ACCOUNTING_replicas,
+		};
+
+		memcpy(&k.replicas, e, replicas_entry_bytes(e));
+
+		u64 v = 0;
+		bch2_accounting_mem_read(c, disk_accounting_key_to_bpos(&k), &v, 1);
+
+		if (e->data_type == BCH_DATA_journal || v)
 			memcpy(cpu_replicas_entry(&new, new.nr++),
 			       e, new.entry_size);
 	}
 
 	bch2_cpu_replicas_sort(&new);
 
-	ret =   bch2_cpu_replicas_to_sb_replicas(c, &new) ?:
-		replicas_table_update(c, &new);
+	ret = bch2_cpu_replicas_to_sb_replicas(c, &new);
+
+	if (!ret)
+		swap(c->replicas, new);
 
 	kfree(new.entries);
 
@@ -481,7 +486,6 @@ int bch2_replicas_gc2(struct bch_fs *c)
 	mutex_unlock(&c->sb_lock);
 
 	return ret;
-#endif
 }
 
 /* Replicas tracking - superblock: */
-- 
2.43.0


