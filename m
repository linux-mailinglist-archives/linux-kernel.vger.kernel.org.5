Return-Path: <linux-kernel+bounces-79935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA898628D5
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 03:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51D821F21720
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 02:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82FBFBF7;
	Sun, 25 Feb 2024 02:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cuC2Dm84"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D472C2ED
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 02:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708828724; cv=none; b=HjutlcGvtjMndjEZ69koehMyq90wBSddx/xGMsnFBAMQl9kuleJV2U47r2FRWVkZLHPqBesGF/cIQbd7WeYHY6OzGLv89M9ud72+NVrKWxGQ6j3rLDOYmgZUZQqatbdTTvMFoeOjTsRI4t7HLWVb3+lexKbcM9Gs5RjxsvI2vRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708828724; c=relaxed/simple;
	bh=6mSrCXsXi3Y+WGJ2l3uOvmTKcFFx9GJUElF7uHdTim4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EakVbCqyHE9YLeWw2lR6JB9IqR528TVCtnqrtWWk+w8shWm54ctr6OLQxAp0j9/OFWsxU2kB7862geToq9obEKqD7v+1yplf+w0ZOuV20e9zmzuxUf7a9/CmBxXeDZYln0Fu1ilPIGjHIG7maD8F3o8jPtybbs9TN+tQivzjHSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cuC2Dm84; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708828720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YboY8McwKZ8bbD5v2MLi4a2lKe9cbZ9uUy04W0G/mjo=;
	b=cuC2Dm84QZNf9uWwz0FZ7YV3pOrzRtNt9Hw0gOtM7PYFz1pDsv20+1XBSvVcWihPqreTth
	K90XUlAFGmpHfZZDqSr+M45J26yZ46f1vJJNdPY6gd2ts/hEd29xg2yTb9d32jq5lLDGYP
	+EzpRuwWfP3QR4318kESDtCr2PM6SJM=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	djwong@kernel.org,
	bfoster@redhat.com
Subject: [PATCH 07/21] bcachefs: Convert bch2_ioctl_fs_usage() to new accounting
Date: Sat, 24 Feb 2024 21:38:09 -0500
Message-ID: <20240225023826.2413565-8-kent.overstreet@linux.dev>
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

This converts bch2_ioctl_fs_usage() to read from the new disk
accounting, via bch2_fs_replicas_usage_read().

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/bcachefs/chardev.c | 68 ++++++++++++-------------------------------
 1 file changed, 19 insertions(+), 49 deletions(-)

diff --git a/fs/bcachefs/chardev.c b/fs/bcachefs/chardev.c
index 992939152f01..13ea852be153 100644
--- a/fs/bcachefs/chardev.c
+++ b/fs/bcachefs/chardev.c
@@ -5,6 +5,7 @@
 #include "bcachefs_ioctl.h"
 #include "buckets.h"
 #include "chardev.h"
+#include "disk_accounting.h"
 #include "journal.h"
 #include "move.h"
 #include "recovery.h"
@@ -500,11 +501,11 @@ static long bch2_ioctl_data(struct bch_fs *c,
 static long bch2_ioctl_fs_usage(struct bch_fs *c,
 				struct bch_ioctl_fs_usage __user *user_arg)
 {
-	struct bch_ioctl_fs_usage *arg = NULL;
-	struct bch_replicas_usage *dst_e, *dst_end;
-	struct bch_fs_usage_online *src;
-	u32 replica_entries_bytes;
+	struct bch_ioctl_fs_usage arg;
+	struct bch_fs_usage_online *src = NULL;
+	darray_char replicas = {};
 	unsigned i;
+	u32 replica_entries_bytes;
 	int ret = 0;
 
 	if (!test_bit(BCH_FS_started, &c->flags))
@@ -513,9 +514,16 @@ static long bch2_ioctl_fs_usage(struct bch_fs *c,
 	if (get_user(replica_entries_bytes, &user_arg->replica_entries_bytes))
 		return -EFAULT;
 
-	arg = kzalloc(size_add(sizeof(*arg), replica_entries_bytes), GFP_KERNEL);
-	if (!arg)
-		return -ENOMEM;
+	ret   = bch2_fs_replicas_usage_read(c, &replicas) ?:
+		(replica_entries_bytes < replicas.nr ? -ERANGE : 0) ?:
+		copy_to_user_errcode(&user_arg->replicas, replicas.data, replicas.nr);
+	if (ret)
+		goto err;
+
+	arg.capacity		= c->capacity;
+	arg.used		= bch2_fs_sectors_used(c, src);
+	arg.online_reserved	= src->online_reserved;
+	arg.replica_entries_bytes = replicas.nr;
 
 	src = bch2_fs_usage_read(c);
 	if (!src) {
@@ -523,52 +531,14 @@ static long bch2_ioctl_fs_usage(struct bch_fs *c,
 		goto err;
 	}
 
-	arg->capacity		= c->capacity;
-	arg->used		= bch2_fs_sectors_used(c, src);
-	arg->online_reserved	= src->online_reserved;
-
 	for (i = 0; i < BCH_REPLICAS_MAX; i++)
-		arg->persistent_reserved[i] = src->u.persistent_reserved[i];
-
-	dst_e	= arg->replicas;
-	dst_end = (void *) arg->replicas + replica_entries_bytes;
-
-	for (i = 0; i < c->replicas.nr; i++) {
-		struct bch_replicas_entry_v1 *src_e =
-			cpu_replicas_entry(&c->replicas, i);
-
-		/* check that we have enough space for one replicas entry */
-		if (dst_e + 1 > dst_end) {
-			ret = -ERANGE;
-			break;
-		}
-
-		dst_e->sectors		= src->u.replicas[i];
-		dst_e->r		= *src_e;
-
-		/* recheck after setting nr_devs: */
-		if (replicas_usage_next(dst_e) > dst_end) {
-			ret = -ERANGE;
-			break;
-		}
-
-		memcpy(dst_e->r.devs, src_e->devs, src_e->nr_devs);
-
-		dst_e = replicas_usage_next(dst_e);
-	}
-
-	arg->replica_entries_bytes = (void *) dst_e - (void *) arg->replicas;
-
+		arg.persistent_reserved[i] = src->u.persistent_reserved[i];
 	percpu_up_read(&c->mark_lock);
-	kfree(src);
-
-	if (ret)
-		goto err;
 
-	ret = copy_to_user_errcode(user_arg, arg,
-			sizeof(*arg) + arg->replica_entries_bytes);
+	ret = copy_to_user_errcode(user_arg, &arg, sizeof(arg));
 err:
-	kfree(arg);
+	darray_exit(&replicas);
+	kfree(src);
 	return ret;
 }
 
-- 
2.43.0


