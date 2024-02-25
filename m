Return-Path: <linux-kernel+bounces-79937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 714E28628D6
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 03:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DC22281CF1
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 02:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5245A13FF2;
	Sun, 25 Feb 2024 02:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CHg59nt2"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AA5EEC6
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 02:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708828726; cv=none; b=qmHV2z7ERKCqGCUnnRSioFbzab83i+m6QFOPcUHuwLttmkd8h67Q0wrSJNbUVM8ZcQadRK/Y+vf7bxI+Z4E+4C1x0PXv+gwInEUgrhnY58f1DdMyARH57vjOestvbrGemDlCWiNwysSuU+/wABBsT07CR/Bh1z14xHCo/ilHdaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708828726; c=relaxed/simple;
	bh=u2DvZcMqKB6og8Lq7jawbKRlhTvu+07YR4ER+eXC/KI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VCHbipdlgS7elrLoTJ7ObypNXCz+xGuwy/dRxDmMt/+SMA+DPy+9dfDdU4pB0jrIu+RxwFlkwa+Ysil/R7umr+t3qJQcN8mDW7lnU89tXl30Z/8d5+YkpRBrvH9pn1mBJ+CjPWRbAciDvgdt4SbT8zi7qfk7rv24S1zcjZrNIro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CHg59nt2; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708828722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sochMrpvNfdQFlEjZm/ljf2msW7UTBhTHpI35Xx9Jzs=;
	b=CHg59nt2Qc17U0pd3Uar1bIzO02xmb907r29R+H1Ixq3v6WI/2XSZIJLjqKNjZ6nEm1rxD
	RhcM4nF1wtBLX7jXN0JoWApSoWtOFmwradLNdJ5wZqB+gnt8Bbs4UbGeDAU1nq6dOFNBYL
	gVrJR7dzjGlV4CQotVij2gybSgRaPH4=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	djwong@kernel.org,
	bfoster@redhat.com
Subject: [PATCH 09/21] bcachefs: Kill writing old accounting to journal
Date: Sat, 24 Feb 2024 21:38:11 -0500
Message-ID: <20240225023826.2413565-10-kent.overstreet@linux.dev>
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

More ripping out of the old disk space accounting.

Note that the new disk space accounting is incompatible with the old,
and writing out old style disk space accounting with the new code is
infeasible.

This means upgrading and downgrading past this version requires
regenerating accounting.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/bcachefs/sb-clean.c | 45 ------------------------------------------
 1 file changed, 45 deletions(-)

diff --git a/fs/bcachefs/sb-clean.c b/fs/bcachefs/sb-clean.c
index a7f2cc774492..1af2785653f6 100644
--- a/fs/bcachefs/sb-clean.c
+++ b/fs/bcachefs/sb-clean.c
@@ -175,25 +175,6 @@ void bch2_journal_super_entries_add_common(struct bch_fs *c,
 					   struct jset_entry **end,
 					   u64 journal_seq)
 {
-	percpu_down_read(&c->mark_lock);
-
-	if (!journal_seq) {
-		for (unsigned i = 0; i < ARRAY_SIZE(c->usage); i++)
-			bch2_fs_usage_acc_to_base(c, i);
-	} else {
-		bch2_fs_usage_acc_to_base(c, journal_seq & JOURNAL_BUF_MASK);
-	}
-
-	{
-		struct jset_entry_usage *u =
-			container_of(jset_entry_init(end, sizeof(*u)),
-				     struct jset_entry_usage, entry);
-
-		u->entry.type	= BCH_JSET_ENTRY_usage;
-		u->entry.btree_id = BCH_FS_USAGE_inodes;
-		u->v		= cpu_to_le64(c->usage_base->b.nr_inodes);
-	}
-
 	{
 		struct jset_entry_usage *u =
 			container_of(jset_entry_init(end, sizeof(*u)),
@@ -204,32 +185,6 @@ void bch2_journal_super_entries_add_common(struct bch_fs *c,
 		u->v		= cpu_to_le64(atomic64_read(&c->key_version));
 	}
 
-	for (unsigned i = 0; i < BCH_REPLICAS_MAX; i++) {
-		struct jset_entry_usage *u =
-			container_of(jset_entry_init(end, sizeof(*u)),
-				     struct jset_entry_usage, entry);
-
-		u->entry.type	= BCH_JSET_ENTRY_usage;
-		u->entry.btree_id = BCH_FS_USAGE_reserved;
-		u->entry.level	= i;
-		u->v		= cpu_to_le64(c->usage_base->persistent_reserved[i]);
-	}
-
-	for (unsigned i = 0; i < c->replicas.nr; i++) {
-		struct bch_replicas_entry_v1 *e =
-			cpu_replicas_entry(&c->replicas, i);
-		struct jset_entry_data_usage *u =
-			container_of(jset_entry_init(end, sizeof(*u) + e->nr_devs),
-				     struct jset_entry_data_usage, entry);
-
-		u->entry.type	= BCH_JSET_ENTRY_data_usage;
-		u->v		= cpu_to_le64(c->usage_base->replicas[i]);
-		unsafe_memcpy(&u->r, e, replicas_entry_bytes(e),
-			      "embedded variable length struct");
-	}
-
-	percpu_up_read(&c->mark_lock);
-
 	for (unsigned i = 0; i < 2; i++) {
 		struct jset_entry_clock *clock =
 			container_of(jset_entry_init(end, sizeof(*clock)),
-- 
2.43.0


