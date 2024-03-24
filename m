Return-Path: <linux-kernel+bounces-112848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F73887EFA
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 094D91C210A1
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 21:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9651619474;
	Sun, 24 Mar 2024 21:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="MDvrdjyr"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9744D749A
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 21:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711314298; cv=none; b=thfiXCGgHcK9u/1iye4zy0RTANUxFEcACMnGl8PXaf4gGwlKRlGKmz8NLXFS5ZaxRc1us825l3QCIEvDi7Kjd2Rqob7mcuZRjH3VzlJydjC65ffiQZZYyXhycnbC0aP5i1XsJhkOkFrE/TmMSsMiVSmzfqMBYBAPpjQjqvtnaag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711314298; c=relaxed/simple;
	bh=xfUJdPfiPihU1FhEtoNbvUg9pbrRKL2nYHQCaQrLOgg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gnc+2/HyFkKH0t4cUptYCH/vY/12slpw5kYPodrVzS24C/vTzOGwloaRMF4pIpjv7nAz8T3WG3CCP72xj9VulF/84unqltZqqxz/ELpmXTTD17j+nHIhvYHbI75jM0gZtOtAQH0prQjrrWC9W/ML6xFeZUT092vcgXXukdVL0gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=MDvrdjyr; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-42a0ba5098bso25644171cf.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 14:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1711314294; x=1711919094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H/e3ZJBIRlaFRfZGVB5Bn/R7HM/dB89XQuSLzZy4Kjo=;
        b=MDvrdjyrn6Nh5hgzqBc/EVn5dVwED+63wgNcW3M3uZ/ybQ4GpBwtFM+UGrbeMQMpob
         X62aXNxKFMIvB8whkZk630v01aJImVmIvbcpbxXBaT5j9PRiaibqSGAgiTNdVXe6WtX0
         oGVmNTix7SV2ArYq12Ximj/W9+D4VyR24Q+p/ciwLrYhrmBaaSbZ0fTydamnW+MNugCZ
         YDIHT9hfWirwInLJbMseZWWfx13JqdjIpre7S0tc1w8cVE1tcSm65axttMd+C2NJPter
         TVkxZX1XERnDP+TD+ojhVhFjcAKTzUELgM4wEnARDz9gcG/its5KhtErB1QZGkeKZz6z
         RncQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711314294; x=1711919094;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H/e3ZJBIRlaFRfZGVB5Bn/R7HM/dB89XQuSLzZy4Kjo=;
        b=qNB0D8VSokKVTFewQvgH+QJZnZdnqKhvTyJ/jGlFYMmQ2ZmAahPgpKBDhTy3fGQgba
         pdtmdrfq6lI2aAujbfVP/nAvnQgmuEWInhd8pkBOi9sc2pph50i3B3MD8A49M7Lx1Bs/
         qrZ0fQXnu+eE2WQ9d0RZHm9A+BQiVo0r5VnYw/75RSsuynjA8wK4PzJqtxWO9pRUj/fI
         U7vwimS0lZKHqv+jlGBt4jjNPMIY43LhBzjVi2Ub58MncgOgcMtIF24Hde0IxUuxBLm2
         zYSBGmuLrX9nN+DwN1jJ16z+uEA5fJ0xJ60H3q1RhEjRjd8v/pWXQ8/dckFDYT3ReSpO
         e5ww==
X-Forwarded-Encrypted: i=1; AJvYcCU5KL+JrGezFwj23t7DuvZgiVRbBdgqjNDbrcR3UC2KFBXtxCsPngRdgVj3qD3hTjEQutPS2btVsQyn+ZOAv2WJ3mxhA2gwuUuakAi1
X-Gm-Message-State: AOJu0YwRC2L9o+BgHRJgsrFSB8M5hpxKokKEkjk8X1ZlO5g8gw6WlCAd
	ExMSTrGxOTI2OKqxX9Rh0bFPHV2ALXU6JwO6b5p3+ti4mhVDHr2h1AI7gka50GY=
X-Google-Smtp-Source: AGHT+IGNExr7L3QsItNVJAVJsqzbgVpSn2HCkqM9zXFxcJ0uA6chC1PR5+hBIS7f1AT1DGZ1cg9w/Q==
X-Received: by 2002:ac8:7f89:0:b0:430:dca8:dd47 with SMTP id z9-20020ac87f89000000b00430dca8dd47mr5598250qtj.47.1711314294228;
        Sun, 24 Mar 2024 14:04:54 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:16be])
        by smtp.gmail.com with ESMTPSA id bb28-20020a05622a1b1c00b0042f376886d2sm1314173qtb.36.2024.03.24.14.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 14:04:53 -0700 (PDT)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Zhongkun He <hezhongkun.hzk@bytedance.com>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Barry Song <21cnbao@gmail.com>,
	Chris Li <chrisl@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm: zswap: fix data loss on SWP_SYNCHRONOUS_IO devices
Date: Sun, 24 Mar 2024 17:04:47 -0400
Message-ID: <20240324210447.956973-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Zhongkun He reports data corruption when combining zswap with zram.

The issue is the exclusive loads we're doing in zswap. They assume
that all reads are going into the swapcache, which can assume
authoritative ownership of the data and so the zswap copy can go.

However, zram files are marked SWP_SYNCHRONOUS_IO, and faults will try
to bypass the swapcache. This results in an optimistic read of the
swap data into a page that will be dismissed if the fault fails due to
races. In this case, zswap mustn't drop its authoritative copy.

Link: https://lore.kernel.org/all/CACSyD1N+dUvsu8=zV9P691B9bVq33erwOXNTmEaUbi9DrDeJzw@mail.gmail.com/
Reported-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
Fixes: b9c91c43412f ("mm: zswap: support exclusive loads")
Cc: stable@vger.kernel.org	[6.5+]
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Tested-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
---
 mm/zswap.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 535c907345e0..41a1170f7cfe 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1622,6 +1622,7 @@ bool zswap_load(struct folio *folio)
 	swp_entry_t swp = folio->swap;
 	pgoff_t offset = swp_offset(swp);
 	struct page *page = &folio->page;
+	bool swapcache = folio_test_swapcache(folio);
 	struct zswap_tree *tree = swap_zswap_tree(swp);
 	struct zswap_entry *entry;
 	u8 *dst;
@@ -1634,7 +1635,20 @@ bool zswap_load(struct folio *folio)
 		spin_unlock(&tree->lock);
 		return false;
 	}
-	zswap_rb_erase(&tree->rbroot, entry);
+	/*
+	 * When reading into the swapcache, invalidate our entry. The
+	 * swapcache can be the authoritative owner of the page and
+	 * its mappings, and the pressure that results from having two
+	 * in-memory copies outweighs any benefits of caching the
+	 * compression work.
+	 *
+	 * (Most swapins go through the swapcache. The notable
+	 * exception is the singleton fault on SWP_SYNCHRONOUS_IO
+	 * files, which reads into a private page and may free it if
+	 * the fault fails. We remain the primary owner of the entry.)
+	 */
+	if (swapcache)
+		zswap_rb_erase(&tree->rbroot, entry);
 	spin_unlock(&tree->lock);
 
 	if (entry->length)
@@ -1649,9 +1663,10 @@ bool zswap_load(struct folio *folio)
 	if (entry->objcg)
 		count_objcg_event(entry->objcg, ZSWPIN);
 
-	zswap_entry_free(entry);
-
-	folio_mark_dirty(folio);
+	if (swapcache) {
+		zswap_entry_free(entry);
+		folio_mark_dirty(folio);
+	}
 
 	return true;
 }
-- 
2.44.0


