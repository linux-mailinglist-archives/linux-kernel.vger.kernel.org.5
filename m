Return-Path: <linux-kernel+bounces-37485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B93283B0AF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F39A1C21F15
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C3F12A144;
	Wed, 24 Jan 2024 18:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3AUQSOO"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A927765D
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 18:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706119767; cv=none; b=JsUqHxOGqW8lPGdMucainFZ1xuT+B+5ccRRhhZfoVUTDMzpSZhQozvDj5vYlrPKizz/OsbmIIwDwSeTpjH5WKmAIlDEsGm330JNTaBL2gXUO/uLf1I5y+winibIcxHKPm29WKrwfNfZkVzoqRob7fPOO6/GOx8o/259+nBBMIrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706119767; c=relaxed/simple;
	bh=ZV+YkJZfjWL//Vz4cZuqrA+67OhgqysL4TH4AfPrKGk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e+sPN/yZU7sIn14w9YQ6X+QpSzWNOuB1sGejpnsVE6YqzFc0cT61rZa/LtSmxcBBM4RNtWzjz5YtCLH2rVzfbe/tLjV6N51SfojHzZgyf1HzFefoAe5RfCr8lyAdLBnub8mA+7ZB1iM5O1NPhcnkAsuekW3fwZ6rVjV08fa7fK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V3AUQSOO; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5100cb238bcso2573286e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 10:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706119764; x=1706724564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EdyPrU/kftC7g2TetwPRn8BZd+pMyQ31/waG2MZ70eg=;
        b=V3AUQSOOmevtPkDIBWn7kKNUuDhYr4wXbMp/2eXHEV5s+t3SbblyYv5dX4iOUB25i8
         r/Q9hhT6o7P3Os979n3ZRgOLsZVoFAGIp8rGS0zhzrjrlFweYUqwOHQkSyH6c3XKIn8k
         psKp8G7385JXa6YKoxGqO/8QqRVzl09nHWPa3NSfWhZfzeASnYEMnaCn2GYwv+lxdKO5
         RQVdS7J7yoqGKVNLLqVDjo85QMUSlmIz9C9qtgkZ+WdOQCP/M2lVXgLwDHAbFTfBC60r
         vFVBjb9YPMYsv2XgfxFnC0YCC/qxXYYRDg1nplhq7HmaYHlssIz0C1iYUEETsQSaLWao
         ZZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706119764; x=1706724564;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EdyPrU/kftC7g2TetwPRn8BZd+pMyQ31/waG2MZ70eg=;
        b=A007ypdQlzzbwSC4wFgrW/ubtYCtJH6nXp1/v3xPO75zMFZHEeJjEZiXb8uc0p5Fl7
         +lHwHUCDBy3HnKIsyHn8dq9gfBrFBVcK0E0tNmfD84HBHoyrjAPNLpkvsMN2QRAh5w0D
         KzbAEoDTIfktEUsPB28iFxUUD/njeg2dpapDInmYZf4FrthjveGg3357SmEzL+dYU39n
         aAyoFuLhbCgSAbDHeWfPDdW1MdsDuRmAUMpYaTc+t8SgtOvbmNvUmMefwRrFLbB76ll/
         2CUq3mTKjuvqUXgFnqtg+NdL0WV4pl2PE7I+wM7LO/g6GdrXwAtp9AFLstht2STkQvqI
         9AVg==
X-Gm-Message-State: AOJu0YxDv7NjcKTwruSh/4+B7lvosG9jF1I3OS8Ldk+/F+VMbxAwsbiL
	7TH7iz4j4ZiFVm2f96yIoWQLtmCnKWimv7CnlY5XUWYwWeaW9J3I
X-Google-Smtp-Source: AGHT+IGkK18t89+7YQVmHl4m0O5voMg4iJZPus7HbZc07bHDSR04jyOEsVNs5kZm+nCJmsSsbw2r8g==
X-Received: by 2002:a05:6512:10c5:b0:50e:b1b1:430c with SMTP id k5-20020a05651210c500b0050eb1b1430cmr4238981lfg.116.1706119763525;
        Wed, 24 Jan 2024 10:09:23 -0800 (PST)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id k16-20020a05651239d000b0050eaec14596sm2656667lfu.39.2024.01.24.10.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 10:09:23 -0800 (PST)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Baoquan He <bhe@redhat.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dave Chinner <david@fromorbit.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH 1/2] mm: vmalloc: Improve description of vmap node layer
Date: Wed, 24 Jan 2024 19:09:19 +0100
Message-Id: <20240124180920.50725-1-urezki@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds extra explanation of recently added vmap
node layer based on community feedback. No functional change.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 60 ++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 46 insertions(+), 14 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 257981e37936..b8be601b056d 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -765,9 +765,10 @@ static struct rb_root free_vmap_area_root = RB_ROOT;
 static DEFINE_PER_CPU(struct vmap_area *, ne_fit_preload_node);
 
 /*
- * An effective vmap-node logic. Users make use of nodes instead
- * of a global heap. It allows to balance an access and mitigate
- * contention.
+ * This structure defines a single, solid model where a list and
+ * rb-tree are part of one entity protected by the lock. Nodes are
+ * sorted in ascending order, thus for O(1) access to left/right
+ * neighbors a list is used as well as for sequential traversal.
  */
 struct rb_list {
 	struct rb_root root;
@@ -775,16 +776,23 @@ struct rb_list {
 	spinlock_t lock;
 };
 
+/*
+ * A fast size storage contains VAs up to 1M size. A pool consists
+ * of linked between each other ready to go VAs of certain sizes.
+ * An index in the pool-array corresponds to number of pages + 1.
+ */
+#define MAX_VA_SIZE_PAGES 256
+
 struct vmap_pool {
 	struct list_head head;
 	unsigned long len;
 };
 
 /*
- * A fast size storage contains VAs up to 1M size.
+ * An effective vmap-node logic. Users make use of nodes instead
+ * of a global heap. It allows to balance an access and mitigate
+ * contention.
  */
-#define MAX_VA_SIZE_PAGES 256
-
 static struct vmap_node {
 	/* Simple size segregated storage. */
 	struct vmap_pool pool[MAX_VA_SIZE_PAGES];
@@ -803,6 +811,11 @@ static struct vmap_node {
 	unsigned long nr_purged;
 } single;
 
+/*
+ * Initial setup consists of one single node, i.e. a balancing
+ * is fully disabled. Later on, after vmap is initialized these
+ * parameters are updated based on a system capacity.
+ */
 static struct vmap_node *vmap_nodes = &single;
 static __read_mostly unsigned int nr_vmap_nodes = 1;
 static __read_mostly unsigned int vmap_zone_size = 1;
@@ -2048,7 +2061,12 @@ decay_va_pool_node(struct vmap_node *vn, bool full_decay)
 			}
 		}
 
-		/* Attach the pool back if it has been partly decayed. */
+		/*
+		 * Attach the pool back if it has been partly decayed.
+		 * Please note, it is supposed that nobody(other contexts)
+		 * can populate the pool therefore a simple list replace
+		 * operation takes place here.
+		 */
 		if (!full_decay && !list_empty(&tmp_list)) {
 			spin_lock(&vn->pool_lock);
 			list_replace_init(&tmp_list, &vn->pool[i].head);
@@ -2257,16 +2275,14 @@ struct vmap_area *find_vmap_area(unsigned long addr)
 	 * An addr_to_node_id(addr) converts an address to a node index
 	 * where a VA is located. If VA spans several zones and passed
 	 * addr is not the same as va->va_start, what is not common, we
-	 * may need to scan an extra nodes. See an example:
+	 * may need to scan extra nodes. See an example:
 	 *
-	 *      <--va-->
+	 *      <----va---->
 	 * -|-----|-----|-----|-----|-
 	 *     1     2     0     1
 	 *
-	 * VA resides in node 1 whereas it spans 1 and 2. If passed
-	 * addr is within a second node we should do extra work. We
-	 * should mention that it is rare and is a corner case from
-	 * the other hand it has to be covered.
+	 * VA resides in node 1 whereas it spans 1, 2 an 0. If passed
+	 * addr is within 2 or 0 nodes we should do extra work.
 	 */
 	i = j = addr_to_node_id(addr);
 	do {
@@ -2289,6 +2305,9 @@ static struct vmap_area *find_unlink_vmap_area(unsigned long addr)
 	struct vmap_area *va;
 	int i, j;
 
+	/*
+	 * Check the comment in the find_vmap_area() about the loop.
+	 */
 	i = j = addr_to_node_id(addr);
 	do {
 		vn = &vmap_nodes[i];
@@ -4882,7 +4901,20 @@ static void vmap_init_nodes(void)
 	int i, n;
 
 #if BITS_PER_LONG == 64
-	/* A high threshold of max nodes is fixed and bound to 128. */
+	/*
+	 * A high threshold of max nodes is fixed and bound to 128,
+	 * thus a scale factor is 1 for systems where number of cores
+	 * are less or equal to specified threshold.
+	 *
+	 * As for NUMA-aware notes. For bigger systems, for example
+	 * NUMA with multi-sockets, where we can end-up with thousands
+	 * of cores in total, a "sub-numa-clustering" should be added.
+	 *
+	 * In this case a NUMA domain is considered as a single entity
+	 * with dedicated sub-nodes in it which describe one group or
+	 * set of cores. Therefore a per-domain purging is supposed to
+	 * be added as well as a per-domain balancing.
+	 */
 	n = clamp_t(unsigned int, num_possible_cpus(), 1, 128);
 
 	if (n > 1) {
-- 
2.39.2


