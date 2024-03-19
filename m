Return-Path: <linux-kernel+bounces-107318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7762387FB00
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A56C21C21BF3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC3A7E58D;
	Tue, 19 Mar 2024 09:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6W15cES"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4588A7E564
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 09:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710841310; cv=none; b=LxxzAXvdRWx88Eh+X7xH4UfhtdTfLQTpbDccgghWcK4qcgxymDyauc8e0xh/a/pA6AmEv9BUzlTufY3JgJw8sRv7H+TZ/d2/Hf2RoZJkaGi4qQbPZoio5CNGymeMN45MoXhz0EP0YOAT3txIIFD/wWwtwUlYQk2wtmCcgTptHDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710841310; c=relaxed/simple;
	bh=Q4MsXeGz7gjwSGkOMZ96Ds7ueS0MczucwPZ2yMN5ZlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WBqn9OqwA/QRZjcF1+4noe+ZE3hS2WMRzPipfiry8Y5WA270w3HzRalSgVdKGdkHehE335fiOPmL8ZYXQMQqMzuonNkw7Y9IlWoMRV8TSm+KWFGrfpOEkCaH7fnxAvgr0HLPWlVID1Z3n7T73vYEM1RymzyLcCxXEz1DnTxSyVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6W15cES; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e73e8bdea2so890818b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 02:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710841308; x=1711446108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+IPrpGzoHpDGCt5ZLHs8DWvQZcRMV24wjwQMoVjv/9U=;
        b=L6W15cESoM73hfcFlhUFEryUyBW6KiP8toxFpsdApH2pwoWtmiyb4NP3v91gsCmgip
         3662Ds+zatXKoyIbhMdfIQ6QmwZsvhdwuNuDyeKaZVgZyNhXKZkOUoxneTaspgbtnAsX
         Nbus7JgBHGWSkZOt6uS+HpYeFJ93mQ/8BVdXm8IqWKoDn1ewp1CuZ/Y/zYnuhWD5TP8j
         Q36aOZadM+4eiKeA21lk5qYTinA9uuH2f59oiuuHO4gqTwR+FT3Hd1KkQT97GkYiUS49
         EsGtT/hJKQrO++C4hc4xIIJAGVRrZCYBSsJVFbTYOKu4feVTgcwZwvIOAdQSkqEdW7s3
         qudA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710841308; x=1711446108;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+IPrpGzoHpDGCt5ZLHs8DWvQZcRMV24wjwQMoVjv/9U=;
        b=Gx9ol9fMr40CKUefnhYyDqp8XwapQ3KkGbzHwkHCB+qIXaNzmpVSu6OAO0QS9tZu/B
         m3OmahA1aVQWQePNFRoaC/O3MB+ZRybx9ERKk9ZeLd8IZVSaKT1tNTxkAmm9fTeCeWwK
         xLhR0H8Qs3YpKZLNea6cAs/+SjkCaj11sFx/0tiEY7i4Vvvyf5XD6sk/YZaVVB+Z29gs
         6ilmIIuj9QBNT84IT6Skl+TLGGUk0T6izLqs/1gaQAnOHkKVvaigHOsLiHAR6Z7QS5ND
         beDI6gM9HXMFGuYh1cPr7vYpswQ6G3L/mow1/c8vmqIndLW/thWdEZjm/+WpsPAUO/yr
         6/xw==
X-Forwarded-Encrypted: i=1; AJvYcCXD/Z2XiUMI5MrZBn3XKzTILWyJMRvgMYR6C/8up2AJw1Dy+yPVt/7JCplS2cw/SXFC2e6fmCLM/g2SbZXGMPeJ8qbgKBAAEPK4vN0r
X-Gm-Message-State: AOJu0Yx4db1Gq6O22Z1N0uVkLRCwmNLSTUS7Q5mNWQThGOb3vkB6uA1a
	u+5oMYTn+6vqxs16nt56Gx8Sr387Wo9a4/ST2ip+QYq2NppEM0E6
X-Google-Smtp-Source: AGHT+IH9clmpXo+eDYRjLfrDjT4vum1cmIxLp7ORYVYCH84rdbd4eGTduRgvmmpEsgUtIio/VDV/8g==
X-Received: by 2002:a05:6a00:9389:b0:6e6:a1ff:3661 with SMTP id ka9-20020a056a00938900b006e6a1ff3661mr19465566pfb.31.1710841308559;
        Tue, 19 Mar 2024 02:41:48 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id i185-20020a62c1c2000000b006e583a649b4sm9708761pfg.210.2024.03.19.02.41.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 19 Mar 2024 02:41:48 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH 4/4] mm/filemap: optimize filemap folio adding
Date: Tue, 19 Mar 2024 17:27:33 +0800
Message-ID: <20240319092733.4501-5-ryncsn@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240319092733.4501-1-ryncsn@gmail.com>
References: <20240319092733.4501-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

Instead of doing multiple tree walks, do one optimism range check
with lock hold, and exit if raced with another insertion. If a shadow
exists, check it with a new xas_get_order helper before releasing the
lock to avoid redundant tree walks for getting its order.

Drop the lock and do the allocation only if a split is needed.

In the best case, it only need to walk the tree once. If it needs
to alloc and split, 3 walks are issued (One for first ranced
conflict check and order retrieving, one for the second check after
allocation, one for the insert after split).

Testing with 4k pages, in an 8G cgroup, with 20G brd as block device:

fio -name=cached --numjobs=16 --filename=/mnt/test.img \
  --buffered=1 --ioengine=mmap --rw=randread --time_based \
  --ramp_time=30s --runtime=5m --group_reporting

Before:
bw (  MiB/s): min=  790, max= 3665, per=100.00%, avg=2499.17, stdev=20.64, samples=8698
iops        : min=202295, max=938417, avg=639785.81, stdev=5284.08, samples=8698

After (+4%):
bw (  MiB/s): min=  451, max= 3868, per=100.00%, avg=2599.83, stdev=23.39, samples=8653
iops        : min=115596, max=990364, avg=665556.34, stdev=5988.20, samples=8653

Test result with THP (do a THP randread then switch to 4K page in hope it
issues a lot of splitting):

fio -name=cached --numjobs=16 --filename=/mnt/test.img \
  --buffered=1 --ioengine mmap -thp=1 --readonly \
  --rw=randread --random_distribution=random \
  --time_based --runtime=5m --group_reporting

fio -name=cached --numjobs=16 --filename=/mnt/test.img \
  --buffered=1 --ioengine mmap --readonly \
  --rw=randread --random_distribution=random \
  --time_based --runtime=5s --group_reporting

Before:
bw (  KiB/s): min=28071, max=62359, per=100.00%, avg=53542.44, stdev=179.77, samples=9520
iops        : min= 7012, max=15586, avg=13379.39, stdev=44.94, samples=9520
bw (  MiB/s): min= 2457, max= 6193, per=100.00%, avg=3923.21, stdev=82.48, samples=144
iops        : min=629220, max=1585642, avg=1004340.78, stdev=21116.07, samples=144

After (+-0.0%):
bw (  KiB/s): min=30561, max=63064, per=100.00%, avg=53635.82, stdev=177.21, samples=9520
iops        : min= 7636, max=15762, avg=13402.82, stdev=44.29, samples=9520
bw (  MiB/s): min= 2449, max= 6145, per=100.00%, avg=3914.68, stdev=81.15, samples=144
iops        : min=627106, max=1573156, avg=1002158.11, stdev=20774.77, samples=144

The performance is better (+4%) for 4K cached read and unchanged for THP.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/filemap.c | 127 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 76 insertions(+), 51 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 6bbec8783793..c1484bcdbddb 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -848,12 +848,77 @@ void replace_page_cache_folio(struct folio *old, struct folio *new)
 }
 EXPORT_SYMBOL_GPL(replace_page_cache_folio);
 
+static int __split_add_folio_locked(struct xa_state *xas, struct folio *folio,
+				    pgoff_t index, gfp_t gfp, void **shadowp)
+{
+	void *entry, *shadow, *alloced_shadow = NULL;
+	int order, alloced_order = 0;
+
+	gfp &= GFP_RECLAIM_MASK;
+	for (;;) {
+		shadow = NULL;
+		order = 0;
+
+		xas_for_each_conflict(xas, entry) {
+			if (!xa_is_value(entry))
+				return -EEXIST;
+			shadow = entry;
+		}
+
+		if (shadow) {
+			if (shadow == xas_reload(xas)) {
+				order = xas_get_order(xas);
+				if (order && order > folio_order(folio)) {
+					/* entry may have been split before we acquired lock */
+					if (shadow != alloced_shadow || order != alloced_order)
+						goto unlock;
+					xas_split(xas, shadow, order);
+					xas_reset(xas);
+				}
+				order = 0;
+			}
+			if (shadowp)
+				*shadowp = shadow;
+		}
+
+		xas_store(xas, folio);
+		/* Success, return with mapping locked */
+		if (!xas_error(xas))
+			return 0;
+unlock:
+		/*
+		 * Unlock path, if errored, return unlocked.
+		 * If allocation needed, alloc and retry.
+		 */
+		xas_unlock_irq(xas);
+		if (order) {
+			if (unlikely(alloced_order))
+				xas_destroy(xas);
+			xas_split_alloc(xas, shadow, order, gfp);
+			if (!xas_error(xas)) {
+				alloced_shadow = shadow;
+				alloced_order = order;
+			}
+			goto next;
+		}
+		/* xas_nomem result checked by xas_error below */
+		xas_nomem(xas, gfp);
+next:
+		xas_lock_irq(xas);
+		if (xas_error(xas))
+			return xas_error(xas);
+
+		xas_reset(xas);
+	}
+}
+
 noinline int __filemap_add_folio(struct address_space *mapping,
 		struct folio *folio, pgoff_t index, gfp_t gfp, void **shadowp)
 {
 	XA_STATE(xas, &mapping->i_pages, index);
 	bool huge = folio_test_hugetlb(folio);
 	long nr;
+	int ret;
 
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 	VM_BUG_ON_FOLIO(folio_test_swapbacked(folio), folio);
@@ -863,70 +928,30 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 	xas_set_order(&xas, index, folio_order(folio));
 	nr = folio_nr_pages(folio);
 
-	gfp &= GFP_RECLAIM_MASK;
 	folio_ref_add(folio, nr);
 	folio->mapping = mapping;
 	folio->index = xas.xa_index;
 
-	do {
-		unsigned int order = xa_get_order(xas.xa, xas.xa_index);
-		void *entry, *old = NULL;
-
-		if (order > folio_order(folio)) {
-			xas_split_alloc(&xas, xa_load(xas.xa, xas.xa_index),
-					order, gfp);
-			if (xas_error(&xas))
-				goto error;
-		}
-		xas_lock_irq(&xas);
-		xas_for_each_conflict(&xas, entry) {
-			old = entry;
-			if (!xa_is_value(entry)) {
-				xas_set_err(&xas, -EEXIST);
-				goto unlock;
-			}
-		}
-
-		if (old) {
-			if (shadowp)
-				*shadowp = old;
-			/* entry may have been split before we acquired lock */
-			order = xa_get_order(xas.xa, xas.xa_index);
-			if (order > folio_order(folio)) {
-				/* How to handle large swap entries? */
-				BUG_ON(shmem_mapping(mapping));
-				xas_split(&xas, old, order);
-				xas_reset(&xas);
-			}
-		}
-
-		xas_store(&xas, folio);
-		if (xas_error(&xas))
-			goto unlock;
-
+	xas_lock_irq(&xas);
+	ret = __split_add_folio_locked(&xas, folio, index, gfp, shadowp);
+	if (likely(!ret)) {
 		mapping->nrpages += nr;
-
-		/* hugetlb pages do not participate in page cache accounting */
 		if (!huge) {
 			__lruvec_stat_mod_folio(folio, NR_FILE_PAGES, nr);
 			if (folio_test_pmd_mappable(folio))
 				__lruvec_stat_mod_folio(folio,
 						NR_FILE_THPS, nr);
 		}
-unlock:
 		xas_unlock_irq(&xas);
-	} while (xas_nomem(&xas, gfp));
-
-	if (xas_error(&xas))
-		goto error;
+		trace_mm_filemap_add_to_page_cache(folio);
+	} else {
+		xas_unlock_irq(&xas);
+		folio->mapping = NULL;
+		/* Leave page->index set: truncation relies upon it */
+		folio_put_refs(folio, nr);
+	}
 
-	trace_mm_filemap_add_to_page_cache(folio);
-	return 0;
-error:
-	folio->mapping = NULL;
-	/* Leave page->index set: truncation relies upon it */
-	folio_put_refs(folio, nr);
-	return xas_error(&xas);
+	return ret;
 }
 ALLOW_ERROR_INJECTION(__filemap_add_folio, ERRNO);
 
-- 
2.43.0


