Return-Path: <linux-kernel+bounces-72931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB4185BAD5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 984B8287950
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D52667C67;
	Tue, 20 Feb 2024 11:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="g0nQyEhc"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2FB67A17
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 11:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708429486; cv=none; b=VurmfXDYNqtW2V41oi9gokSJPKzf8Vj/wuXjKW0aaep3ucnCK6vBaoYzMtvzWxMRIamDyr0dr4HVeI5SQ/W/eE8nQ9bNpH6uR1zed4YYWvYVEmTw6QQupQ0pzz80oaP5up5yPNxHwQac1ebDqdWpQO8baE7hgi1ORj+/2TC5Eyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708429486; c=relaxed/simple;
	bh=BFuh+CfNDOzD1S00lsGqAqSSiu2o1MPg0aixlXGfmos=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V8nLM7uMa30viyjX1cqaCIWpunU2mX+KDLcm05XJAZ5FuAnhQtGkvX/mocAaSp0uqSq5/SemC+t4TBfwnc2eyN6PUOfHHnLfr4C259BaCgJDO1ktBfu6S+/GEUPzR9G1zooI1tgAkb+lkz3oVeCIig2QDl8vxjpFl10VZ6a0C2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=g0nQyEhc; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708429482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=frGjyVgHupGD7XyoLjuBNXl6egeagHTj4tQawTxfLDk=;
	b=g0nQyEhc0uv+uyH42ziPQ1j9bhr8hQRZCCD1pT3uRaE0h01LgIKi7xFEjBfKNbh47w5tba
	emvlznq1s+LOnT3Lw9TXWIogMbzkBgFeeOLy8fgJ2ioyd72Q8p+oL3w56Dqvf7WbgzC07F
	xS30vIqd5dGOK4fSMvu6DsMCjzJH//c=
From: Chengming Zhou <chengming.zhou@linux.dev>
Date: Tue, 20 Feb 2024 11:44:30 +0000
Subject: [PATCH RESEND 2/3] mm/zsmalloc: remove_zspage() don't need fullness parameter
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240220-b4-zsmalloc-cleanup-v1-2-b7e9cbab9541@linux.dev>
References: <20240220-b4-zsmalloc-cleanup-v1-0-b7e9cbab9541@linux.dev>
In-Reply-To: <20240220-b4-zsmalloc-cleanup-v1-0-b7e9cbab9541@linux.dev>
To: hannes@cmpxchg.org, Andrew Morton <akpm@linux-foundation.org>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 nphamcs@gmail.com, yosryahmed@google.com, Minchan Kim <minchan@kernel.org>
Cc: linux-mm@kvack.org, Chengming Zhou <zhouchengming@bytedance.com>, linux-kernel@vger.kernel.org
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708429476; l=2152;
 i=chengming.zhou@linux.dev; s=20240220; h=from:subject:message-id;
 bh=GQWspwGCFRIlLWu+jB/4L2Vh7hNigRDA/nhdzUelvTs=;
 b=HfKohdQBHsp+yH25vS97QDG5EljLYcLDRXNqctQwnwKj01ORLuWu4tU2UdBSKwG84P3sebhh0
 +EDf/e7QoXHDzKOZQ3ztPMFYVZxHPOhdOxb/wSKcAv5ObGPWQggBTCa
X-Developer-Key: i=chengming.zhou@linux.dev; a=ed25519;
 pk=5+68Wfci+T30FoQos5RH+hfToF6SlC+S9LMPSPBFWuw=
X-Migadu-Flow: FLOW_OUT

From: Chengming Zhou <zhouchengming@bytedance.com>

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

