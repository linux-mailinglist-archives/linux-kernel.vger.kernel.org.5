Return-Path: <linux-kernel+bounces-72435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6277585B32B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A4591F21FA4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E3A59B6E;
	Tue, 20 Feb 2024 06:53:18 +0000 (UTC)
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59CF1EB48
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 06:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708411997; cv=none; b=ebhlbADiwPOgeUWKwy/1VwesLx5t2q8icvQiqwGar3iCiIFgatcK7u+MpTzdSPJ08UIPxhVjypsEZn5fWaDmJH82yyW0sUaQIkUbGXReaVpR8K9+5ykAGFa1qiE4u0DlAvz00NvFwTJgY54q6Zq3/sfKjdbY1kWDfsWsZzcbUbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708411997; c=relaxed/simple;
	bh=GQWspwGCFRIlLWu+jB/4L2Vh7hNigRDA/nhdzUelvTs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hwEAgGZG+z1k3r/SNRElcXA3j6YrGzqP4ZFNNtQCEv0Eny9r1dBwMEjFSTqqLOahQmf7DTLB8wwILRne1WBEzKOUzR6DNDo+Ki8UR3+STamMi/m3FRk86QgxlaiTVSFKcGyYVu6CxIb1qyEymzNGoufnoWoA/7X9kTTH9xwnm/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <zhouchengming@bytedance.com>
Date: Tue, 20 Feb 2024 06:53:01 +0000
Subject: [PATCH 2/3] mm/zsmalloc: remove_zspage() don't need fullness parameter
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240220-b4-zsmalloc-cleanup-v1-2-5c5ee4ccdd87@bytedance.com>
References: <20240220-b4-zsmalloc-cleanup-v1-0-5c5ee4ccdd87@bytedance.com>
In-Reply-To: <20240220-b4-zsmalloc-cleanup-v1-0-5c5ee4ccdd87@bytedance.com>
To: nphamcs@gmail.com, Andrew Morton <akpm@linux-foundation.org>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 hannes@cmpxchg.org, yosryahmed@google.com, Minchan Kim <minchan@kernel.org>
Cc: Chengming Zhou <zhouchengming@bytedance.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708411986; l=2152;
 i=zhouchengming@bytedance.com; s=20231204; h=from:subject:message-id;
 bh=GQWspwGCFRIlLWu+jB/4L2Vh7hNigRDA/nhdzUelvTs=;
 b=JNIzIQ9Lci0B3n2FEPHyXk1U9Zo0P03ME5cMyqjBhp3RwTxfdYX46ff3p2X/QxYJ6NhSNNcY7
 4xNL7yvbvQYC/xjoY/qcI71XYnv5VeaKzisgJeRm5rlJnnYxTN/4tk/
X-Developer-Key: i=zhouchengming@bytedance.com; a=ed25519;
 pk=xFTmRtMG3vELGJBUiml7OYNdM393WOMv0iWWeQEVVdA=
X-Migadu-Flow: FLOW_OUT

We must remove_zspage() from its current fullness list, then use
insert_zspage() to update its fullness and insert to new fullness list.
Obviously, remove_zspage() doesn't need the fullness parameter.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 mm/zsmalloc.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index a6653915bf17..c39fac9361d7 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -687,10 +687,10 @@ static void insert_zspage(struct size_class *class,
  * This function removes the given zspage from the freelist identified
  * by <class, fullness_group>.
  */
-static void remove_zspage(struct size_class *class,
-				struct zspage *zspage,
-				int fullness)
+static void remove_zspage(struct size_class *class, struct zspage *zspage)
 {
+	int fullness = zspage->fullness;
+
 	VM_BUG_ON(list_empty(&class->fullness_list[fullness]));
 
 	list_del_init(&zspage->list);
@@ -716,7 +716,7 @@ static int fix_fullness_group(struct size_class *class, struct zspage *zspage)
 	if (newfg == currfg)
 		goto out;
 
-	remove_zspage(class, zspage, currfg);
+	remove_zspage(class, zspage);
 	insert_zspage(class, zspage, newfg);
 out:
 	return newfg;
@@ -878,7 +878,7 @@ static void free_zspage(struct zs_pool *pool, struct size_class *class,
 		return;
 	}
 
-	remove_zspage(class, zspage, ZS_INUSE_RATIO_0);
+	remove_zspage(class, zspage);
 	__free_zspage(pool, class, zspage);
 }
 
@@ -1609,7 +1609,7 @@ static struct zspage *isolate_src_zspage(struct size_class *class)
 		zspage = list_first_entry_or_null(&class->fullness_list[fg],
 						  struct zspage, list);
 		if (zspage) {
-			remove_zspage(class, zspage, fg);
+			remove_zspage(class, zspage);
 			return zspage;
 		}
 	}
@@ -1626,7 +1626,7 @@ static struct zspage *isolate_dst_zspage(struct size_class *class)
 		zspage = list_first_entry_or_null(&class->fullness_list[fg],
 						  struct zspage, list);
 		if (zspage) {
-			remove_zspage(class, zspage, fg);
+			remove_zspage(class, zspage);
 			return zspage;
 		}
 	}

-- 
b4 0.10.1

