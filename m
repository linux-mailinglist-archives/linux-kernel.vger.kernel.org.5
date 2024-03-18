Return-Path: <linux-kernel+bounces-106783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D197887F3BC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 00:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5377A1F21D79
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 23:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2AA15B5C1;
	Mon, 18 Mar 2024 23:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NfdtKb8o"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6D85B5BA
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 23:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710802830; cv=none; b=YdmaIbtZg8j//FhVGohUzKbvYW9TTTAmRaCl9WnrJ2kwjIg2bsidXFlKb9ulqOuQHSeCLfuMwnkTpExANtP2HQPJ/LxHHS0aGAnxySyWMJtljAcNtswFv+mYFNisox/+kio+ZHp/UebRFyMAnKdOT4IEGnppjT247c/f3WBvDEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710802830; c=relaxed/simple;
	bh=iXPDNt/ffCuZbdvPw6wGnbnzoeSbxLSd4hIuaAw9CuY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lSDZ2qVoeqN4+EdZELG9hO/OvENN4/WlMOdaZonVXpYApCL6vXKVGXtrwIVtBeIOEemC1I6ua2H0zqvN0+nD+4YdGpwUGaqa2dn+lqQ3aduRslkNYf06+k+ODgiStNYo+jrQ1d5HeHYQkdg1nDg8YuDGsx0vnZ6OHY3rMYth7CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NfdtKb8o; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e6b5432439so4757802b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 16:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710802828; x=1711407628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=knuy5c2qliqG2FNwU48/FMhWrEftpX+A/MIcSa4Nh2w=;
        b=NfdtKb8ooyQ/2w6r/cd9jwE6SCE0JH/dmcQAGDt18vJAFgldyeyhbqWPRRQ6GvpA6h
         7OvWKPGEW6FljcOueXOrwuFKpxhhorBN8MPXWJj69wJnC1OqkLLwE0Jh7r2GoRZuNaFb
         bs+4PbZmiU9OlFrDg3Xi8kxAEpLT7zhl20S4y894Xcfl9xbCqeVU1cSGGaev+Gr+8OSz
         gKu6oZboPbh+IFCOg67t9Z+aFlFPTWupzp96Py4m/XL5uKK18m7o5n7+yVmzMcfbearX
         gkpt/Mnx+Ae/nNtObo11LYvlDEJhFkmVpR1bYXtW4/msGalCCTCY8Lwwa32jwNRTVnn7
         /Pmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710802828; x=1711407628;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=knuy5c2qliqG2FNwU48/FMhWrEftpX+A/MIcSa4Nh2w=;
        b=cffHbbGHeXJ1Pn0M30xY1Kq7yeNxcBQhQOq09Qzzjx4f9Rm2XhgZ2DQIwieo0WDRuV
         fEc3BIEa/t+bExrEPkz+X/Z78tzaSur/REGT8DjMg8fuSG3pa0vzh6fS7+kXw8zcKTa9
         ILJADUrmBBLKDzos9M8FJfP+Ajz5MQYIFrOIyR2Ro3RcXzATjYVSfeCzwELD5/fIFddK
         cR/lXj+re5AwemSsTTyO79srKkIP9poaFY8qcy9xj8xNLyVYNKUHiFJXMc121jKSJ2bl
         ufWSy3NSrn79SZQTOjSz6vBZb50hrpfaa0FyHkkrjZ9uWv5TY6svZ9avzQgoWBmaiIsK
         5pwg==
X-Gm-Message-State: AOJu0YyF32A4fHXQ+A7Tad5ZuxwUraGVH8z8nzQiQyF6EnMqGvmgm6Mj
	9JSJuDUkOo/N6RjSZPaLyVc0SZM+0Lz6/cFN08qOxbVImh2A/mxk2Fr4TeFd
X-Google-Smtp-Source: AGHT+IHxIS7qqMu/AV+b4ZDO7WewVppVr5aFkxSfYheo9LVfPDhWqAZqjjgxqqHnrCAER4FsTQcTvw==
X-Received: by 2002:a05:6a00:80dd:b0:6e6:cf40:2d66 with SMTP id ei29-20020a056a0080dd00b006e6cf402d66mr12171635pfb.6.1710802827997;
        Mon, 18 Mar 2024 16:00:27 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id b19-20020aa78713000000b006e6c3753786sm8422856pfo.41.2024.03.18.16.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 16:00:27 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: hannes@cmpxchg.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	akpm@linux-foundation.org,
	chrisl@kernel.org,
	v-songbaohua@oppo.com,
	linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	ira.weiny@intel.com,
	syzbot+adbc983a1588b7805de3@syzkaller.appspotmail.com
Subject: [PATCH] mm: zswap: fix kernel BUG in sg_init_one
Date: Tue, 19 Mar 2024 12:00:13 +1300
Message-Id: <20240318230013.87543-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

sg_init_one() relies on linearly mapped low memory for the safe
utilization of virt_to_page(). Consequently, we have two choices:
either employ kmap_to_page() alongside sg_set_page(), or resort to
copying high memory contents to a temporary buffer residing in low
memory. However, considering the introduction of the WARN_ON_ONCE
in commit ef6e06b2ef870 ("highmem: fix kmap_to_page() for
kmap_local_page() addresses"), which specifically addresses high
memory concerns, it appears that memcpy remains the sole viable
option.

Reported-and-tested-by: syzbot+adbc983a1588b7805de3@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/000000000000bbb3d80613f243a6@google.com/
Fixes: 270700dd06ca ("mm/zswap: remove the memcpy if acomp is not sleepable")
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 mm/zswap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 9dec853647c8..17bf6d87b274 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1080,7 +1080,8 @@ static void zswap_decompress(struct zswap_entry *entry, struct page *page)
 	mutex_lock(&acomp_ctx->mutex);
 
 	src = zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
-	if (acomp_ctx->is_sleepable && !zpool_can_sleep_mapped(zpool)) {
+	if ((acomp_ctx->is_sleepable && !zpool_can_sleep_mapped(zpool)) ||
+	    !virt_addr_valid(src)) {
 		memcpy(acomp_ctx->buffer, src, entry->length);
 		src = acomp_ctx->buffer;
 		zpool_unmap_handle(zpool, entry->handle);
@@ -1094,7 +1095,7 @@ static void zswap_decompress(struct zswap_entry *entry, struct page *page)
 	BUG_ON(acomp_ctx->req->dlen != PAGE_SIZE);
 	mutex_unlock(&acomp_ctx->mutex);
 
-	if (!acomp_ctx->is_sleepable || zpool_can_sleep_mapped(zpool))
+	if (src != acomp_ctx->buffer)
 		zpool_unmap_handle(zpool, entry->handle);
 }
 
-- 
2.34.1


