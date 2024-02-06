Return-Path: <linux-kernel+bounces-55438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C581284BCB5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BC3E284A35
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592801095A;
	Tue,  6 Feb 2024 18:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YrjHuDDO"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C565DF5A
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 18:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707242939; cv=none; b=o1ayYBWFq1CADTn5XIB8DwnGcuL19Vqx1CDvWv79FGl5AaV/7xmQ2U+O+BJFktWBd/7P5nDOuf+j4E0oAfzO2O/Ft2c+MBMV4LKTaG0IpiZonXDRqinvsd9dDnMAQfiBag97oGJq+7NNBijTmRBhg2jQbmZV4Cn75FJ+xR0BjNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707242939; c=relaxed/simple;
	bh=vLJFxU6b1pO+fC/tdopN/qTyNi4/3U8xVhcMlyIaSOA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tUdD3ojTk7lLNeMjMTrHdxbh4xa3TfK7Mum7Pfy55xTyw1CsDrMyIfLVs+Et1FhFspAdYItoCdlO+mvl0Ac6qv44rXBSM38eKLY/s4frC7lBkihlcu4sdJl2KT4R152+8qA+QUlCjJ0NnvrkMK/wpyQX0AUPK6PPmq86mNHjtHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YrjHuDDO; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7810827e54eso353532385a.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 10:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707242937; x=1707847737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GVfn3yVJysCN6urYRnVBYjglKBmxv1NsB7G+hjAd4ic=;
        b=YrjHuDDORwCij76vS0FoGOjoDGtZHKF9yKZI4HMgMKxsG901CXryhcsHJuFVXdTgAf
         WISIf3VnHYOCP6KaEM0F+My0uMX6KX1EZZu6HDNaXh96A2so+o5svMzQ65y9CImSviFZ
         YjzOQh2IeEUe9RWw+m457S+HsJg49iwfnNz3PP6X96DhGWyGduWD8+t79cubcyO7wtq0
         ixObR0oUGrccMKAgNzw8mfIOBj4hoR7AmCgQV+o4fCu+kYHiN5eFrw+ykDYoz8rhMNO/
         4ht4jjBq10DrC9Whg8oncgAqvbdgtdSZFV1T04dDWO6cvcA3fybY/J1EAS6FcpnRIK+W
         FeCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707242937; x=1707847737;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GVfn3yVJysCN6urYRnVBYjglKBmxv1NsB7G+hjAd4ic=;
        b=rt64TTQmJu3xxnQjSQ+AGyeeqa9LDAGpVOYAZHxdbL2sdwdsP4BZsdqFccmcHoAEZg
         4aNdO6f/PnmJQNBG9Bb6PIUORPRWsDHHdyiElYKRzpTXmIsCohxeaMLwnQ4X8sec/N2f
         CZ6gKW/M7TF5AS4IqlMsQJ4OSPgqlogZYxI75qTwxmW9/P8Nw/HzRTGkbyq7C4ImW9SB
         PifiMp5K848hkh7vEpeaPJNxUd9rvfG6jarj4puFZVJ9clQi3O6RVxp5z/HHa8eBK4Gw
         R+5QPcSJRtEuHnX+PrGCxb+SWg3LFOQXDWa7scFMbT8ejr3g2TmZY1i53DXqVqzz+MV/
         VE2A==
X-Gm-Message-State: AOJu0Yy1WT+O6pveqb5MYOG7Bdiik9IhOKMogDajCoN1HPMZ13pLVSX1
	Crtrrn2DFThSQ8XbUvoBqoCkcQa/IsVSF784lDzGeTwukp8jeQEJ
X-Google-Smtp-Source: AGHT+IGL0WmHhYtgOpTaS5LrzQhDiax3sgFnCfWdJYij4bZqe7hOr9v4rEs98j5t0MqBd4pusEJz9w==
X-Received: by 2002:a05:620a:3956:b0:785:53ab:9d07 with SMTP id qs22-20020a05620a395600b0078553ab9d07mr3821813qkn.58.1707242936748;
        Tue, 06 Feb 2024 10:08:56 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUTBdxwgDZtkc1xm7cEiIvYQT4+U0qYkwHHctgvx4pBrsQfWSjOeJFE6Wbqq0vXR1VQsv3NGmsx2sqLqPoNjG/rAbIKCvCHqDmwUEPByImfRkpiDb5KA17tvpFTxAKFvEzFEIlLbM8SYRN/3G0a9sjIw7hAR97MTUyuvjqaAO9vO6NurtQOIbPt/T4S0a+NvXBiMkqJypU4uNjY8qrt8SBygS/0tR2BbA==
Received: from localhost (fwdproxy-nao-002.fbsv.net. [2a03:2880:23ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id q27-20020a05620a0c9b00b00783ddf9b9d5sm1118937qki.91.2024.02.06.10.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 10:08:56 -0800 (PST)
From: Nhat Pham <nphamcs@gmail.com>
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org,
	chengming.zhou@linux.dev,
	yosryahmed@google.com,
	linux-mm@kvack.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] mm/swap_state: update zswap LRU's protection range with the folio locked
Date: Tue,  6 Feb 2024 10:08:55 -0800
Message-Id: <20240206180855.3987204-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a folio is swapped in, the protection size of the corresponding
zswap LRU is incremented, so that the zswap shrinker is more
conservative with its reclaiming action. This field is embedded within
the struct lruvec, so updating it requires looking up the folio's memcg
and lruvec. However, currently this lookup can happen after the folio is
unlocked, for instance if a new folio is allocated, and
swap_read_folio() unlocks the folio before returning. In this scenario,
there is no stability guarantee for the binding between a folio and its
memcg and lruvec:

* A folio's memcg and lruvec can be freed between the lookup and the
  update, leading to a UAF.
* Folio migration can clear the now-unlocked folio's memcg_data, which
  directs the zswap LRU protection size update towards the root memcg
  instead of the original memcg. This was recently picked up by the
  syzbot thanks to a warning in the inlined folio_lruvec() call.

Move the zswap LRU protection range update above the swap_read_folio()
call, and only when a new page is allocated, to prevent this.

Reported-by: syzbot+17a611d10af7d18a7092@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/000000000000ae47f90610803260@google.com/
Fixes: b5ba474f3f51 ("zswap: shrink zswap pool based on memory pressure")
Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/swap_state.c | 10 ++++++----
 mm/zswap.c      |  1 +
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/mm/swap_state.c b/mm/swap_state.c
index e671266ad772..7255c01a1e4e 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -680,9 +680,10 @@ struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 	/* The page was likely read above, so no need for plugging here */
 	folio = __read_swap_cache_async(entry, gfp_mask, mpol, ilx,
 					&page_allocated, false);
-	if (unlikely(page_allocated))
+	if (unlikely(page_allocated)) {
+		zswap_folio_swapin(folio);
 		swap_read_folio(folio, false, NULL);
-	zswap_folio_swapin(folio);
+	}
 	return folio;
 }
 
@@ -855,9 +856,10 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
 	/* The folio was likely read above, so no need for plugging here */
 	folio = __read_swap_cache_async(targ_entry, gfp_mask, mpol, targ_ilx,
 					&page_allocated, false);
-	if (unlikely(page_allocated))
+	if (unlikely(page_allocated)) {
+		zswap_folio_swapin(folio);
 		swap_read_folio(folio, false, NULL);
-	zswap_folio_swapin(folio);
+	}
 	return folio;
 }
 
diff --git a/mm/zswap.c b/mm/zswap.c
index 4aea03285532..8c548f73d52e 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -827,6 +827,7 @@ void zswap_folio_swapin(struct folio *folio)
 	struct lruvec *lruvec;
 
 	if (folio) {
+		VM_WARN_ON_ONCE(!folio_test_locked(folio));
 		lruvec = folio_lruvec(folio);
 		atomic_long_inc(&lruvec->zswap_lruvec_state.nr_zswap_protected);
 	}

base-commit: 91f3daa1765ee4e0c89987dc25f72c40f07af34d
-- 
2.39.3

