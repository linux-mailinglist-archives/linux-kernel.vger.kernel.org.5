Return-Path: <linux-kernel+bounces-152888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D80CA8AC5C8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ACC41F221C3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BC84F5ED;
	Mon, 22 Apr 2024 07:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="cxDrZ2ES"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82044D9EA
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 07:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713771788; cv=none; b=Cr3nxJrFv9Qv7NQF4CcurfAf6DJLhQ65xi7ReyThljSWaX9CeGKiPgdWNfhdDnrlibKHOCWW2mXM+cb23BcOENqhTd0CGj1KZXlhhOw4HDwetofOkDhknxSTDaTrgOrQeNLGhgDN08vTo9hgdyNNeYx6ea6JphrOCxVZsWSgJVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713771788; c=relaxed/simple;
	bh=3Oj9v8fKAeuQ0Snq0CF75spBnzuIUdmlULeL8Toft80=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ae7iNt5aqaifVU/bzAjXxRygwuJqprN3FdThIdQvcEt04m+HxAzTCvXW1VH8N8Atik6RTVd1ADwVn9H2QnU9b27Nte4Xu8lhes067IhkNzpk/G9FqiJ5RQwDyrymfiD5x9p7O4j2cgAFiFYncCBJQuW3/Wchwz0G5564+kMZKak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=cxDrZ2ES; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e4bf0b3e06so39388395ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 00:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713771785; x=1714376585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8v4Ayhiua6xBQPRLdZqElV8SuuukGuSIp7AWQ+b83kM=;
        b=cxDrZ2ESNLuYQ0nbcTG/tvKkWormhzfi/7K/8sRe1STdM5sum1C5ZUCzela5AOeU7c
         hdCFydD/Cf/FqfQVn0m1RMUEOcuhocTC7u0pZRnMmS5cAG9JgBZXIK3RUlk/t/Pfw3iJ
         XRQtXbizGEzIW+42qewepdMEBBlcPUyNru2RAleneqCijkdZvgOKLVmWwnOJksCRmu35
         dw1Cy7SPXDv7n2nMDJ6k6hHqLHCuPRI1zJYfqnmDSWPAscqWuHQ7D7+2XVkn0aDyU2WI
         Lam6Rf4Cz6suMvNZ0MIMJtiNqoFIqS2xJ4sOnc61tvDuhMRPGsh0wXLqkUYjTCAXJzxX
         LHtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713771785; x=1714376585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8v4Ayhiua6xBQPRLdZqElV8SuuukGuSIp7AWQ+b83kM=;
        b=NjuQdN1sve4m7Obq4vCqcux7JauugeLEIcsjw2v6ZMaORJqUTaPzXN3zoKAYGMtIg5
         fk2W3xKYQyNIMc+oGnLWqqT00/P4YV3cUvrODkMMPJ7cTWHKldFsMtuWl/5bF+kMYAhZ
         XR4u/xAAlIslVmAkxoZy3HMCI0o2rraxssv3xUuoHTjJs8yhUWY8xlqhPVLdzH9jGEQ6
         QdzRUdD+QDkOaxc0xnu86oB2+wQ+7qh7g0tejKSIZXp2cIrfWAneqXZvoHHzsyjyXkFg
         dqjMTmnuKh7JipQ+sYn9MFiJ16650nD616wXOwagk6G9HU69V41p7tv3PB6S/hw459tS
         hwsg==
X-Gm-Message-State: AOJu0YwsoJwPKi99VwE8/V1VT4IubBxse3+yarWtnI5/kkS2iKl/Z5bV
	FirWU51K5zbS19jQ5zgwx0dFlkKzYwzDWRr0ubH9yZAbo1j3BUnAhd+XbSt82Y/CkVXCsf7gFNR
	1
X-Google-Smtp-Source: AGHT+IH5FapWr2NsqZRBiIrj5e5+IahI/4Uza3UkvKorGF9IdyGMaix/CVDPSu/65IlIfj7nO5mHKw==
X-Received: by 2002:a17:902:c40c:b0:1e4:2b90:7282 with SMTP id k12-20020a170902c40c00b001e42b907282mr13198963plk.14.1713771785215;
        Mon, 22 Apr 2024 00:43:05 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.11])
        by smtp.gmail.com with ESMTPSA id e11-20020a170902784b00b001e0bae4490fsm7595634pln.154.2024.04.22.00.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 00:43:04 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	virtualization@lists.linux.dev
Cc: mst@redhat.com,
	david@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	akpm@linux-foundation.org,
	zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v2 1/4] virtio_balloon: separate vm events into a function
Date: Mon, 22 Apr 2024 15:42:51 +0800
Message-Id: <20240422074254.1440457-2-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240422074254.1440457-1-pizhenwei@bytedance.com>
References: <20240422074254.1440457-1-pizhenwei@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All the VM events related statistics have dependence on
'CONFIG_VM_EVENT_COUNTERS', once any stack variable is required by any
VM events in future, we would have codes like:
 #ifdef CONFIG_VM_EVENT_COUNTERS
      unsigned long foo;
 #endif
      ...
 #ifdef CONFIG_VM_EVENT_COUNTERS
      foo = events[XXX] + events[YYY];
      update_stat(vb, idx++, VIRTIO_BALLOON_S_XXX, foo);
 #endif

Separate vm events into a single function, also remove
'CONFIG_VM_EVENT_COUNTERS' from 'update_balloon_stats'.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/virtio/virtio_balloon.c | 44 ++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 15 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 1f5b3dd31fcf..59fe157e5722 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -316,34 +316,48 @@ static inline void update_stat(struct virtio_balloon *vb, int idx,
 
 #define pages_to_bytes(x) ((u64)(x) << PAGE_SHIFT)
 
-static unsigned int update_balloon_stats(struct virtio_balloon *vb)
+/* Return the number of entries filled by vm events */
+static inline unsigned int update_balloon_vm_stats(struct virtio_balloon *vb,
+						   unsigned int start)
 {
+#ifdef CONFIG_VM_EVENT_COUNTERS
 	unsigned long events[NR_VM_EVENT_ITEMS];
-	struct sysinfo i;
-	unsigned int idx = 0;
-	long available;
-	unsigned long caches;
+	unsigned int idx = start;
 
 	all_vm_events(events);
-	si_meminfo(&i);
-
-	available = si_mem_available();
-	caches = global_node_page_state(NR_FILE_PAGES);
-
-#ifdef CONFIG_VM_EVENT_COUNTERS
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_SWAP_IN,
-				pages_to_bytes(events[PSWPIN]));
+		    pages_to_bytes(events[PSWPIN]));
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_SWAP_OUT,
-				pages_to_bytes(events[PSWPOUT]));
+		    pages_to_bytes(events[PSWPOUT]));
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_MAJFLT, events[PGMAJFAULT]);
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_MINFLT, events[PGFAULT]);
+
 #ifdef CONFIG_HUGETLB_PAGE
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_HTLB_PGALLOC,
 		    events[HTLB_BUDDY_PGALLOC]);
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_HTLB_PGFAIL,
 		    events[HTLB_BUDDY_PGALLOC_FAIL]);
-#endif
-#endif
+#endif /* CONFIG_HUGETLB_PAGE */
+
+	return idx - start;
+#else /* CONFIG_VM_EVENT_COUNTERS */
+
+	return 0;
+#endif /* CONFIG_VM_EVENT_COUNTERS */
+}
+
+static unsigned int update_balloon_stats(struct virtio_balloon *vb)
+{
+	struct sysinfo i;
+	unsigned int idx = 0;
+	long available;
+	unsigned long caches;
+
+	idx += update_balloon_vm_stats(vb, idx);
+
+	si_meminfo(&i);
+	available = si_mem_available();
+	caches = global_node_page_state(NR_FILE_PAGES);
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_MEMFREE,
 				pages_to_bytes(i.freeram));
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_MEMTOT,
-- 
2.34.1


