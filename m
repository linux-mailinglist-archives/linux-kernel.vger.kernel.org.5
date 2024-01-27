Return-Path: <linux-kernel+bounces-40978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2537E83E931
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 03:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA2D41F23C30
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 02:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1093611C80;
	Sat, 27 Jan 2024 02:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="e4TNW933"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B4AB66B
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 02:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706320886; cv=none; b=d3wcLpv2W3ixbCA0gwLhkUQcw6Clri+qBafqFetPC7lT0LYuCuHr4IqHQnmlfz1ujhemqiwVeCIYI7oMZ9yVSxwgfyl8dC0pW35jfUjVvSRCs0IF3i8MrDIK4UsMdaRFmCSrRpj5w/wyyPpQje2TRKrKcegw94RiNrzK1LWWmRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706320886; c=relaxed/simple;
	bh=I17n2kJwfLP73JxpOT/4Z+XY1RSDVWFd3kwZEjsB2hg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M+Cr9ORewhsSHXuENRgU3kjxLLRcqEPyWFBAB/ajI5ambAfUNafYkeuoFsHrj9L9k5LGUyxfWEBq4Uls/Y2bsv2HzWYnnV32S83xHYky+AlCvSGao3cXZtHkuL3lYUIwBLIzBJPXhVoaXt0r/pU74V2ckHujJeCBCT2c2m+cnno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=e4TNW933; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706320882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dhcmLJc/KPpam9Xa9GT9+fmxCdezLGqepV5bOxUHdOE=;
	b=e4TNW933G9qVxjcf4lFEpCbSzgbDfoyYa5dvenGHsJ1R4Ve4VK4GP6sJbrTurD0dHHvbJ3
	/9Yexwkkli1xL4W2Gy9bLSBa9o+ftgDxjUS8PB2K4ORVChldBDvjSZtGznD6UEgMkAPXjP
	NrCoucg4nB873RTeBqqvhqP5E4bLUdg=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-fsdevel@vgerkernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	peterz@infradead.org,
	boqun.feng@gmail.com,
	linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/4] pktcdvd: kill mutex_lock_nested() usage
Date: Fri, 26 Jan 2024 21:01:06 -0500
Message-ID: <20240127020111.487218-3-kent.overstreet@linux.dev>
In-Reply-To: <20240127020111.487218-1-kent.overstreet@linux.dev>
References: <20240127020111.487218-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Unecessary, we're not actually taking nested locks of the same type.

Cc: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 drivers/block/pktcdvd.c  |  8 ++++----
 fs/pipe.c                | 10 +---------
 include/linux/lockdep.h  |  3 +++
 kernel/locking/lockdep.c |  6 ++++++
 4 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index d56d972aadb3..2eb68a624fda 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -332,7 +332,7 @@ static ssize_t device_map_show(const struct class *c, const struct class_attribu
 {
 	int n = 0;
 	int idx;
-	mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
+	mutex_lock(&ctl_mutex);
 	for (idx = 0; idx < MAX_WRITERS; idx++) {
 		struct pktcdvd_device *pd = pkt_devs[idx];
 		if (!pd)
@@ -2639,7 +2639,7 @@ static int pkt_setup_dev(dev_t dev, dev_t* pkt_dev)
 	struct pktcdvd_device *pd;
 	struct gendisk *disk;
 
-	mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
+	mutex_lock(&ctl_mutex);
 
 	for (idx = 0; idx < MAX_WRITERS; idx++)
 		if (!pkt_devs[idx])
@@ -2729,7 +2729,7 @@ static int pkt_remove_dev(dev_t pkt_dev)
 	int idx;
 	int ret = 0;
 
-	mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
+	mutex_lock(&ctl_mutex);
 
 	for (idx = 0; idx < MAX_WRITERS; idx++) {
 		pd = pkt_devs[idx];
@@ -2780,7 +2780,7 @@ static void pkt_get_status(struct pkt_ctrl_command *ctrl_cmd)
 {
 	struct pktcdvd_device *pd;
 
-	mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
+	mutex_lock(&ctl_mutex);
 
 	pd = pkt_find_dev_from_minor(ctrl_cmd->dev_index);
 	if (pd) {
diff --git a/fs/pipe.c b/fs/pipe.c
index 50c8a8596b52..abe171566015 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -78,14 +78,6 @@ static unsigned long pipe_user_pages_soft = PIPE_DEF_BUFFERS * INR_OPEN_CUR;
 
 #define cmp_int(l, r)		((l > r) - (l < r))
 
-#ifdef CONFIG_PROVE_LOCKING
-static int pipe_lock_cmp_fn(const struct lockdep_map *a,
-			    const struct lockdep_map *b)
-{
-	return cmp_int((unsigned long) a, (unsigned long) b);
-}
-#endif
-
 void pipe_lock(struct pipe_inode_info *pipe)
 {
 	if (pipe->files)
@@ -824,7 +816,7 @@ struct pipe_inode_info *alloc_pipe_info(void)
 		pipe->nr_accounted = pipe_bufs;
 		pipe->user = user;
 		mutex_init(&pipe->mutex);
-		lock_set_cmp_fn(&pipe->mutex, pipe_lock_cmp_fn, NULL);
+		lock_set_cmp_fn_ptr_order(&pipe->mutex);
 		return pipe;
 	}
 
diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 08b0d1d9d78b..e0b121f96c80 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -391,6 +391,7 @@ extern int lockdep_is_held(const void *);
 #endif /* !LOCKDEP */
 
 #ifdef CONFIG_PROVE_LOCKING
+int lockdep_ptr_order_cmp_fn(const struct lockdep_map *, const struct lockdep_map *);
 void lockdep_set_lock_cmp_fn(struct lockdep_map *, lock_cmp_fn, lock_print_fn);
 
 #define lock_set_cmp_fn(lock, ...)	lockdep_set_lock_cmp_fn(&(lock)->dep_map, __VA_ARGS__)
@@ -398,6 +399,8 @@ void lockdep_set_lock_cmp_fn(struct lockdep_map *, lock_cmp_fn, lock_print_fn);
 #define lock_set_cmp_fn(lock, ...)	do { } while (0)
 #endif
 
+#define lock_set_cmp_fn_ptr_order(lock)	lock_set_cmp_fn(lock, lockdep_ptr_order_cmp_fn);
+
 enum xhlock_context_t {
 	XHLOCK_HARD,
 	XHLOCK_SOFT,
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 151bd3de5936..5630be7f5cb2 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -4919,6 +4919,12 @@ struct lock_class_key __lockdep_no_validate__;
 EXPORT_SYMBOL_GPL(__lockdep_no_validate__);
 
 #ifdef CONFIG_PROVE_LOCKING
+int lockdep_ptr_order_cmp_fn(const struct lockdep_map *a,
+			     const struct lockdep_map *b)
+{
+	return cmp_int((unsigned long) a, (unsigned long) b);
+}
+
 void lockdep_set_lock_cmp_fn(struct lockdep_map *lock, lock_cmp_fn cmp_fn,
 			     lock_print_fn print_fn)
 {
-- 
2.43.0


