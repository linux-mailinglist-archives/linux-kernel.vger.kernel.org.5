Return-Path: <linux-kernel+bounces-79949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9778628E3
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 03:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E0111F21750
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 02:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF04A1B968;
	Sun, 25 Feb 2024 02:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ABOfH9pg"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56ED8DDAD
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 02:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708828737; cv=none; b=OiDg+RUw5hItsuZG5UpjNvFwHS3+YWGaYjZVUdpKcFY7GZVGCdEQ4whF5azB6AEDhulLv+prQsBS7t5sOCtiiQmcshVIaEDXjSrolQKb7Y7PI9yJkRwS9oKqfAVLNN9qbQVYeh0Nsh6GrHGIhK43LG93fuydIAcIpLrDVJtccgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708828737; c=relaxed/simple;
	bh=DfA9FVN9BLpGyKYVyfilqkfCwE9P2RiMXuov2SLCyRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bafr9GcwVPQwgu0ZPjxVC1jvFBY+WgOFGf4SefzrFTzOegpk7BZMYjuqumfGoiENJMT5rtI5SXVGEXauTAHmHW8shBkM3IQvoEvJW2bMjFsx0Hq1lO2jCXcme9pNJnYb0BVBODuEW4525x+4/IpnK/yUqNr6DMQ30RyJDabzSns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ABOfH9pg; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708828733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R05PvZLs8g3ZOV6GSh50wBEFv8JbV+JIgM3xfyBtfwY=;
	b=ABOfH9pgrb1Dn5VORYxI5KNr7K0saesLc8gSTUBUt1urNenkobzD64qE8QGOxt8XhmFwp6
	4uk5NdJ08DMgkYwbothiJa4mlww9zk2RIBSiZLMd4iLL9u6pQlTm16HgnAv8jPtQmxAjCS
	IkUZ+qEOfB/dlGkaO9MjJJfoP/JeWWc=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	djwong@kernel.org,
	bfoster@redhat.com
Subject: [PATCH 21/21] bcachefs: bch2_fs_usage_base_to_text()
Date: Sat, 24 Feb 2024 21:38:23 -0500
Message-ID: <20240225023826.2413565-22-kent.overstreet@linux.dev>
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
 fs/bcachefs/sysfs.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/fs/bcachefs/sysfs.c b/fs/bcachefs/sysfs.c
index 10470cef30f0..27aca70cb385 100644
--- a/fs/bcachefs/sysfs.c
+++ b/fs/bcachefs/sysfs.c
@@ -205,6 +205,7 @@ read_attribute(disk_groups);
 read_attribute(has_data);
 read_attribute(alloc_debug);
 read_attribute(accounting);
+read_attribute(usage_base);
 
 #define x(t, n, ...) read_attribute(t);
 BCH_PERSISTENT_COUNTERS()
@@ -329,6 +330,20 @@ static void bch2_btree_wakeup_all(struct bch_fs *c)
 	seqmutex_unlock(&c->btree_trans_lock);
 }
 
+static void bch2_fs_usage_base_to_text(struct printbuf *out, struct bch_fs *c)
+{
+	struct bch_fs_usage_base b = {};
+
+	acc_u64s_percpu(&b.hidden, &c->usage->hidden, sizeof(b) / sizeof(u64));
+
+	prt_printf(out, "hidden:\t\t%llu\n",	b.hidden);
+	prt_printf(out, "btree:\t\t%llu\n",	b.btree);
+	prt_printf(out, "data:\t\t%llu\n",	b.data);
+	prt_printf(out, "cached:\t%llu\n",	b.cached);
+	prt_printf(out, "reserved:\t\t%llu\n",	b.reserved);
+	prt_printf(out, "nr_inodes:\t%llu\n",	b.nr_inodes);
+}
+
 SHOW(bch2_fs)
 {
 	struct bch_fs *c = container_of(kobj, struct bch_fs, kobj);
@@ -417,6 +432,9 @@ SHOW(bch2_fs)
 	if (attr == &sysfs_accounting)
 		bch2_fs_accounting_to_text(out, c);
 
+	if (attr == &sysfs_usage_base)
+		bch2_fs_usage_base_to_text(out, c);
+
 	return 0;
 }
 
@@ -630,6 +648,7 @@ struct attribute *bch2_fs_internal_files[] = {
 
 	&sysfs_disk_groups,
 	&sysfs_accounting,
+	&sysfs_usage_base,
 	NULL
 };
 
-- 
2.43.0


