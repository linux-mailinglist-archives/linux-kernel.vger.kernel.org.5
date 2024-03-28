Return-Path: <linux-kernel+bounces-123013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9722289010C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7A6D1C2894B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA509823CB;
	Thu, 28 Mar 2024 14:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBBd7TTy"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF878120F
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 14:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711634618; cv=none; b=a49VFkhijz7roLAoIXaSs3qyXtlxnv2AXLzEOc3Nk5TIzi92wg4KRugAFAQ7++ZOuOovTC0ZqQkc4GLlYDff4RbmRy5hUuSKEBnNVUoWH9/yKgM4Xb0OnL3m6zF1zvCg2sk3B5eIaeMCt5cvipYbzw4v4AmGbQqd3KGiBBWht9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711634618; c=relaxed/simple;
	bh=yM9aPo/s0eyi45xjJmKqarJpERpyQjDXGMRi+Rxa/qI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UFZXNLks98qwilNJ3hkM4ZurjrVyKHcY4iX0uDZrMGS4XowlpGF3WZ1JHU9Rd+zNBCBdDOhk8Z0ZVvb0tc7rOdMSOf0s72g7WEgVhjFwpTjMwB8YIUWWP870lZbQegFDNKox/Fx4axHQOdxsXGYr/26FauFD+p8DAueoeq1vlBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UBBd7TTy; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-515caffe2b5so598275e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 07:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711634613; x=1712239413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CT8V/kdc5WB0TlbNcLxd5k9ElfIfxe6B6M2YsC8jwN0=;
        b=UBBd7TTyrPHhXtcJ2Txz/XqJD0oUugflXim/6TOQnDPdgPouVH+4lLlBou7pE7r3lC
         Sr9m4vzVqe8F4v3CMYloH9kf/f6V4yrJ0bCfhxravk3Q1kPGIgrxPJVM4Kxi1HtDsVCG
         BQkQ/nKvjrurzEsTHpJVyiCmtvrm6uzQ/qy7y4WblRKDyXlspZDZXGYVyvTtTxGmBgwW
         k3KlMtGjwkAxLxd5na84LZtEVXZpa5nr3GW6hZj2Op3zLjf7fshUkizMlog9AYWY/uuV
         60XaDobhl6N3GHpSgbYA2AKIBqqkqlv7Bgv0Sa6a705QpHAeqDkxn7ndRzzQoq155sI8
         0wZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711634613; x=1712239413;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CT8V/kdc5WB0TlbNcLxd5k9ElfIfxe6B6M2YsC8jwN0=;
        b=Y7UDH2wk2D6fEI4+MIZtGg611SE9+VcMbdRk2GMy/2r3w11ZWB3WHfCiYwaF0Fd3v0
         LnvqPV+9ZFEl9dLkwAsgSxzPxmEWli2Za7WrFJ80IEe/oyr4Me3i8F4Whtw7n2BFwDeN
         kzFrP2AHBpNTB84PI/umQAYLNFxUJPMhzh2sKlOvrkBgsuqurZbGL5xLdDYOLf2ON0Nw
         cf7CLNehvszuIGiytDkzLF7O/P1wxAPWVCqgrNCwT/hoyFyhnb+xaNRcCiZufxS8uy9Y
         Xcue0hhzg8VMu5caNuuUgTIwNaZBr1Jd0BKjO5sgz5N+jpBNzIozZPJqiBx5mRoR8rl8
         TIkg==
X-Gm-Message-State: AOJu0Ywy1hwvmgGW/5YAqXWoBJqP48CWC4LYbeDI7micqRyxFNQjB5oS
	NrrK6rYyJK0nqUG/fdWyzETFNtlGTthFIpxJ1wVOEhZnezhLQzZO
X-Google-Smtp-Source: AGHT+IFyy/sTknXNnqXo3qvpynipBRIV+fdDh3Ha8NkvdICnl6zBVEGiRqQMVGRtOenfauY1oMWr8Q==
X-Received: by 2002:a05:6512:478:b0:515:920e:eedb with SMTP id x24-20020a056512047800b00515920eeedbmr2349894lfd.39.1711634612800;
        Thu, 28 Mar 2024 07:03:32 -0700 (PDT)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id q26-20020ac25a1a000000b00513da68c536sm221607lfn.152.2024.03.28.07.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 07:03:32 -0700 (PDT)
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
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Jens Axboe <axboe@kernel.dk>,
	Omar Sandoval <osandov@fb.com>
Subject: [PATCH 1/1] mm: vmalloc: Fix lockdep warning
Date: Thu, 28 Mar 2024 15:03:30 +0100
Message-Id: <20240328140330.4747-1-urezki@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A lockdep reports a possible deadlock in the find_vmap_area_exceed_addr_lock()
function:

============================================
WARNING: possible recursive locking detected
6.9.0-rc1-00060-ged3ccc57b108-dirty #6140 Not tainted
--------------------------------------------
drgn/455 is trying to acquire lock:
ffff0000c00131d0 (&vn->busy.lock/1){+.+.}-{2:2}, at: find_vmap_area_exceed_addr_lock+0x64/0x124

but task is already holding lock:
ffff0000c0011878 (&vn->busy.lock/1){+.+.}-{2:2}, at: find_vmap_area_exceed_addr_lock+0x64/0x124

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&vn->busy.lock/1);
  lock(&vn->busy.lock/1);

 *** DEADLOCK ***

indeed it can happen if the find_vmap_area_exceed_addr_lock()
gets called concurrently because it tries to acquire two nodes
locks. It was done to prevent removing a lowest VA found on a
previous step.

To address this a lowest VA is found first without holding a
node lock where it resides. As a last step we check if a VA
still there because it can go away, if removed, proceed with
next lowest.

Fixes: 53becf32aec1 ("mm: vmalloc: support multiple nodes in vread_iter")
Tested-by: Jens Axboe <axboe@kernel.dk>
Tested-by: Omar Sandoval <osandov@fb.com>
Reported-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 74 +++++++++++++++++++++++++++++++---------------------
 1 file changed, 44 insertions(+), 30 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index e94ce4562805..a5a5dfc3843e 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -989,6 +989,27 @@ unsigned long vmalloc_nr_pages(void)
 	return atomic_long_read(&nr_vmalloc_pages);
 }
 
+static struct vmap_area *__find_vmap_area(unsigned long addr, struct rb_root *root)
+{
+	struct rb_node *n = root->rb_node;
+
+	addr = (unsigned long)kasan_reset_tag((void *)addr);
+
+	while (n) {
+		struct vmap_area *va;
+
+		va = rb_entry(n, struct vmap_area, rb_node);
+		if (addr < va->va_start)
+			n = n->rb_left;
+		else if (addr >= va->va_end)
+			n = n->rb_right;
+		else
+			return va;
+	}
+
+	return NULL;
+}
+
 /* Look up the first VA which satisfies addr < va_end, NULL if none. */
 static struct vmap_area *
 __find_vmap_area_exceed_addr(unsigned long addr, struct rb_root *root)
@@ -1025,47 +1046,40 @@ __find_vmap_area_exceed_addr(unsigned long addr, struct rb_root *root)
 static struct vmap_node *
 find_vmap_area_exceed_addr_lock(unsigned long addr, struct vmap_area **va)
 {
-	struct vmap_node *vn, *va_node = NULL;
-	struct vmap_area *va_lowest;
+	unsigned long va_start_lowest;
+	struct vmap_node *vn;
 	int i;
 
-	for (i = 0; i < nr_vmap_nodes; i++) {
+repeat:
+	for (i = 0, va_start_lowest = 0; i < nr_vmap_nodes; i++) {
 		vn = &vmap_nodes[i];
 
 		spin_lock(&vn->busy.lock);
-		va_lowest = __find_vmap_area_exceed_addr(addr, &vn->busy.root);
-		if (va_lowest) {
-			if (!va_node || va_lowest->va_start < (*va)->va_start) {
-				if (va_node)
-					spin_unlock(&va_node->busy.lock);
-
-				*va = va_lowest;
-				va_node = vn;
-				continue;
-			}
-		}
+		*va = __find_vmap_area_exceed_addr(addr, &vn->busy.root);
+
+		if (*va)
+			if (!va_start_lowest || (*va)->va_start < va_start_lowest)
+				va_start_lowest = (*va)->va_start;
 		spin_unlock(&vn->busy.lock);
 	}
 
-	return va_node;
-}
-
-static struct vmap_area *__find_vmap_area(unsigned long addr, struct rb_root *root)
-{
-	struct rb_node *n = root->rb_node;
+	/*
+	 * Check if found VA exists, it might it is gone away.
+	 * In this case we repeat the search because a VA has
+	 * been removed concurrently thus we need to proceed
+	 * with next one what is a rare case.
+	 */
+	if (va_start_lowest) {
+		vn = addr_to_node(va_start_lowest);
 
-	addr = (unsigned long)kasan_reset_tag((void *)addr);
+		spin_lock(&vn->busy.lock);
+		*va = __find_vmap_area(va_start_lowest, &vn->busy.root);
 
-	while (n) {
-		struct vmap_area *va;
+		if (*va)
+			return vn;
 
-		va = rb_entry(n, struct vmap_area, rb_node);
-		if (addr < va->va_start)
-			n = n->rb_left;
-		else if (addr >= va->va_end)
-			n = n->rb_right;
-		else
-			return va;
+		spin_unlock(&vn->busy.lock);
+		goto repeat;
 	}
 
 	return NULL;
-- 
2.39.2


