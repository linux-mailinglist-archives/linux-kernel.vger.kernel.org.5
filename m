Return-Path: <linux-kernel+bounces-43719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3BB84185C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC22C1C22E05
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CEF23611D;
	Tue, 30 Jan 2024 01:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="2Xb3lWu0"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1B52CCD5
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 01:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706578488; cv=none; b=h45+XpJjQXZ1Z8Nxt0oyYmpbBpK/PgUySkn5pXdCdEmfY89tZjFR3PxwRE+78UVC6d8l96t6q17MkYfmEaWZVLlZc5ws5xR1dY5oONAfAqA53lWj/hRJw6NNW0Ko5HbvdrfSOKNJ1NsvKrHSZR+MvG8j1a1g8HX8EMBnoMt6MvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706578488; c=relaxed/simple;
	bh=pjKF8tIho/v+IEph4zer3wh/eDSGzR3EZwX8YiJO+eM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZxReijmo/VpGGJdKFHPJtUbCRD7wxo5zI8abAnjsKJJK0gg/BZOFA80dAJGg/eacOu2c0mMHhV7MnpT2TdZ5RxpZIR0rrMeX8KSEcWtzIeNWJib1ANIcR/uyw3eU3nVShxXbD5B0Ra3l10nlr3Sv96UImeTVpx1Hfx6cjfs/Hmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=2Xb3lWu0; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-78405c9a152so63222985a.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 17:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1706578484; x=1707183284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pt4QpYqiCKtezqoZ60BQzd+DA/EH8n3ps/uzvBONghI=;
        b=2Xb3lWu0d4Zc4Y43nYe4ADjKg6/D7FK72J9crEkBZCOcPymT+cRsCsrkzLlvFICOJL
         PXEhe1K1RV6STzuwSrnG7MemEIhi0XqesiXzg6RFLJs76tsy322j3jhSJrlsvwYFWwLP
         AGwY9hdwdLJgrQj/Xc4YkdmRk5LSnxAX1Rb3BdPbsAJUF+4mtgWoaa6foT/8chFBB/5D
         K45ZsjkXvMiCTtqTPhEztQpd4IehJGo8YJdqxECR41ayO5jOI4YAAIsOwNA27s8Wil/P
         NfKwOURFGrZkUDbZyDl63t348tp9Q8g60pOtiqwt5ilwvKmzn1ih35Z0Blprs7EOyY7Y
         tU3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706578484; x=1707183284;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pt4QpYqiCKtezqoZ60BQzd+DA/EH8n3ps/uzvBONghI=;
        b=lEpQqtXoCbxZV5qsWP4Sbp677BM/FmpmGDcbbE5so1AonEcWevjqC7rBU7e9rzxPAS
         i5xTRp5u6EBebNUSlE1tJan3s0jAAqdcI8YNtLe+q6Gi8zVsz+6lnDcXOw5llbsdQw1J
         oxEtWyk4nuTm9iEhWL+Vr6FYzsfkpak8ragm7fPL6frmN0Fk7YHWDVzkQmOvndICGrIu
         Mra1X1th1mtcXpvgssSefgLkHDpVJsmq1CKFk9gfIoCpVV5IAGb1UrLmD1Fudv1O559r
         ZvLXXgQCJtp3pvrKkaYSOzqN8TAMqznLsXSICqeaeLFdbwgCAXvb9Us76Kka4Jf5JjX1
         BrJw==
X-Gm-Message-State: AOJu0YzLpAGRaAHXORCjtwKMf+f+U6rrwYkq/aO9aonOkap02myv06V4
	pEdBMxRhJM2EqotXs7O2NLGJ4aNIPAgrQhIoTxZAM9owHb3Cd0fvuUuc5DRMmx32+S5ePyGUKY3
	a
X-Google-Smtp-Source: AGHT+IEdaB1qwTqKaziaa6HRsPa2jrEC3sjEOrMYISc8fAwH2/VeWWl0i2SKtM6XAG5+P7O3eNWenA==
X-Received: by 2002:a05:620a:1663:b0:783:de7c:e880 with SMTP id d3-20020a05620a166300b00783de7ce880mr5760345qko.6.1706578484027;
        Mon, 29 Jan 2024 17:34:44 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id s18-20020ae9f712000000b00783f8693df1sm1799849qkg.37.2024.01.29.17.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 17:34:43 -0800 (PST)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nhat Pham <nphamcs@gmail.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm: zswap: fix objcg use-after-free in entry destruction
Date: Mon, 29 Jan 2024 20:34:38 -0500
Message-ID: <20240130013438.565167-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the per-memcg LRU universe, LRU removal uses entry->objcg to
determine which list count needs to be decreased. Drop the objcg
reference after updating the LRU, to fix a possible use-after-free.

Fixes: a65b0e7607cc ("zswap: make shrinking memcg-aware")
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/zswap.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index de68a5928527..7f88b3a77e4a 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -522,10 +522,6 @@ static struct zpool *zswap_find_zpool(struct zswap_entry *entry)
  */
 static void zswap_free_entry(struct zswap_entry *entry)
 {
-	if (entry->objcg) {
-		obj_cgroup_uncharge_zswap(entry->objcg, entry->length);
-		obj_cgroup_put(entry->objcg);
-	}
 	if (!entry->length)
 		atomic_dec(&zswap_same_filled_pages);
 	else {
@@ -534,6 +530,10 @@ static void zswap_free_entry(struct zswap_entry *entry)
 		atomic_dec(&entry->pool->nr_stored);
 		zswap_pool_put(entry->pool);
 	}
+	if (entry->objcg) {
+		obj_cgroup_uncharge_zswap(entry->objcg, entry->length);
+		obj_cgroup_put(entry->objcg);
+	}
 	zswap_entry_cache_free(entry);
 	atomic_dec(&zswap_stored_pages);
 	zswap_update_total_size();
-- 
2.43.0


