Return-Path: <linux-kernel+bounces-118186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4607C88B591
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 00:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 778B21C3BDF3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB6C84A26;
	Mon, 25 Mar 2024 23:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VxI7pGjc"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19EA8529B
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 23:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711410627; cv=none; b=ne0jXDpCCgUJyv5qGt1IDXr7zmscQ1MzXD4l5cexhPwIsPnRL+25uK+M0dx731FGYtangESIvdeEC7uflixPG8sNeIiPHt5C4rIhj2HmCwsTQT/EO8GpQ/iZ2duwJjH+kXwsL7h7AJXYn/nO5+iXVPGoZDo44Hwz5lnXU0IBSBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711410627; c=relaxed/simple;
	bh=etnStzb5dr7nTQEyqbOx6RG6Z1pSCvmhvSaa+izLU2U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H+XG/9sAvxoPykaYXndY42QRlk+ctdnPeFfWPZ20fseks0SvEXPqwAD2NzZyGZd4ohbbI6eNbB8GG5xl2A7IfkeknBj4hUEQcPjkgnARRZ5Rzza1KHL98yETiX12ZbNhtI8n8mkjYVGgizQgXArHHzGhIrKAQxcbrlOIthiqwHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VxI7pGjc; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60cd073522cso90178107b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 16:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711410625; x=1712015425; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dd0Yn1LXqAraa72sbpCkcMKeXtgN9BdSqsW0A73YyKg=;
        b=VxI7pGjcjYhioSrcG2qVE/9DFD6rkzzKii1IIJyxUhqeeDn/zxovXsPm0NSL6LYHxl
         O3upUhYB9CAj81qc0pPHosgD5xB7VzP0bprB3lF1FG31d6hDgJ6oaFmgDj3uoLxR70hb
         O4gldPeGSVo9hapDHQbvsH3ulgLki/AwOolj5J8Rrq1u4qm4xH/smhN95jBMXGPyzHPA
         VGSrOwAf3lLAgf3smZKOCYbEiN0CxNHa2ZV3lh1feRMTUy5E9OHWNYuy3nOi0+H/Cfb9
         Lh6xVO5urrBCpWU3VA+0EPlsucF0TNq/ef7Dj22WxPP0nR4elw58voywjZotUh+ynH8h
         6W2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711410625; x=1712015425;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dd0Yn1LXqAraa72sbpCkcMKeXtgN9BdSqsW0A73YyKg=;
        b=eaMa5ldOXc6zuDEHiE0M2sM/7lyI8l4XP+6FXUUFBCDRwAqimcdeHP8qU1YFdMqGrn
         LX+ikQqRCcipFxXTY0/dM2KrDbJ2msZW9ZXPTMkeEQXfjP/pVRgSHdnKs+BvSIR7OvRM
         rBirIz+JO/xilIyWPdd9ukyJw/Dqk25wX9NattIe9SOdJ8Hp9VxaEsg0NFEEESTWlrYX
         S7b2gdDUAE4L8DnPaGUNoK4+fWfF8Bm5gVNAigbkXDJqy0/7ueMo0JxvY6q81cfYl5cR
         UKcIo6v/79O/MTJ154RM0xjCaTNrsNh3I51VJ4Wz8IaZXPMt/+QjrO9DshYmYzWw4ugT
         XvWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXovWg+wVnLrIbrO6Raf5sKIZbpgIIhrseIEDSIan5wnCHVRHjEO4ql4BHadJhxwa5L/FFc9q+1Sn+wmHcTYlGG24wlYiL4vsRZTFiz
X-Gm-Message-State: AOJu0YzhyG7xVk12F8EgG53nOwXKMhO4sDtAbdfB0JEO3N6oBJ2Xrrif
	2FBffV+sWP1a7KkpOgdlN8yPscR05ESE1IhBvBD4Bwpcf2gcknnDlav5FWG0NAxu61PSGouvgUF
	vADSkOusIPoDap7mFQw==
X-Google-Smtp-Source: AGHT+IHM4PjIMqVasHvxcW/NHELy1n3EZw0GsOSiULCSozqmucZP5yLYhHluyhz301rMxFhkk5EZKcifeTwjvilx
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a0d:fe44:0:b0:611:a84c:fef2 with SMTP
 id o65-20020a0dfe44000000b00611a84cfef2mr165827ywf.10.1711410624906; Mon, 25
 Mar 2024 16:50:24 -0700 (PDT)
Date: Mon, 25 Mar 2024 23:50:11 +0000
In-Reply-To: <20240325235018.2028408-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240325235018.2028408-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240325235018.2028408-4-yosryahmed@google.com>
Subject: [RFC PATCH 3/9] mm: zswap: refactor limit checking from zswap_store()
From: Yosry Ahmed <yosryahmed@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

Refactor limit and acceptance threshold checking outside of
zswap_store(). This code will be moved around in a following patch, so
it would be cleaner to move a function call around.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/zswap.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index ff1975afb7e3d..6b890c8590ef7 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1415,6 +1415,21 @@ static void zswap_fill_page(void *ptr, unsigned long value)
 	memset_l(page, value, PAGE_SIZE / sizeof(unsigned long));
 }
 
+static bool zswap_check_limit(void)
+{
+	unsigned long cur_pages = zswap_total_pages();
+	unsigned long thr = zswap_accept_thr_pages();
+	unsigned long max_pages = zswap_max_pages();
+
+	if (cur_pages >= max_pages) {
+		zswap_pool_limit_hit++;
+		zswap_pool_reached_full = true;
+	} else if (zswap_pool_reached_full && cur_pages <= thr) {
+		zswap_pool_reached_full = false;
+	}
+	return !zswap_pool_reached_full;
+}
+
 bool zswap_store(struct folio *folio)
 {
 	swp_entry_t swp = folio->swap;
@@ -1422,7 +1437,6 @@ bool zswap_store(struct folio *folio)
 	struct xarray *tree = swap_zswap_tree(swp);
 	struct obj_cgroup *objcg = NULL;
 	struct mem_cgroup *memcg = NULL;
-	unsigned long max_pages, cur_pages;
 	struct zswap_entry *entry;
 
 	VM_WARN_ON_ONCE(!folio_test_locked(folio));
@@ -1446,22 +1460,8 @@ bool zswap_store(struct folio *folio)
 		mem_cgroup_put(memcg);
 	}
 
-	/* Check global limits */
-	cur_pages = zswap_total_pages();
-	max_pages = zswap_max_pages();
-
-	if (cur_pages >= max_pages) {
-		zswap_pool_limit_hit++;
-		zswap_pool_reached_full = true;
+	if (!zswap_check_limit())
 		goto reject;
-	}
-
-	if (zswap_pool_reached_full) {
-		if (cur_pages > zswap_accept_thr_pages())
-			goto reject;
-		else
-			zswap_pool_reached_full = false;
-	}
 
 	/* allocate entry */
 	entry = zswap_entry_cache_alloc(GFP_KERNEL, folio_nid(folio));
-- 
2.44.0.396.g6e790dbe36-goog


