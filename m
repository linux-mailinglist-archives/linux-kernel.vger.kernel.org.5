Return-Path: <linux-kernel+bounces-45707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BE6843472
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 04:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA8B2B23C21
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 03:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E0810A16;
	Wed, 31 Jan 2024 03:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fiVEZcoi"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E551079B
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 03:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706671194; cv=none; b=Ob17OMRxbuI2Fga2QzVGYGT2IN9rycktM4/5MI0/oJYkziBSwgO+BueP//dQzi3M8alUJAHeNeQTCaYKrN/JGAzqwb0klc+wGryWH39GmB6V0esr6qHEvSEVhHnZox2UY1SuqBf0mMFrvur9JumfjEFMaDrLggEysk/WAKy5Jh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706671194; c=relaxed/simple;
	bh=rTqgrUM/f3lW+qEBuBNBmq/CllB8SiNYN3i5kJu39P8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oEkci+CLdHLX131wNWPwitFVESKweUByQvqticw4lII0RkDgd8t+Nhft9wkoEA5ZU594LfXPaWJ10IRFFrLstM9gNVGrKo/c2oGFYPhX6/z4LHUknnpol5FIeX27obij3GafzuJGwTwinnXa2FnJSEcIRmwh1pVN8atvHi/zneg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fiVEZcoi; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706671189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Zz364JoMX9h2N5yV5c7OrViie26VfXvY+e5Im09K4k4=;
	b=fiVEZcoirkHU005RRkF9Yqx4zJ7jWfTNJ1Gvjw9OI5phD40jJwwGqgSEIIm5PjQ3m3I3fb
	ML0iMug8p1/f4yXd4ctCoFgjPTnvKKnndHOY2XSVb08y826pzQDGm2UPflfgTdv+xJPet8
	OCr0oQeszoukVsmtiJ3u7lE61EoFshI=
From: Yajun Deng <yajun.deng@linux.dev>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH v2] mm/mmap: use SZ_{8K, 128K} helper macro
Date: Wed, 31 Jan 2024 11:19:13 +0800
Message-Id: <20240131031913.2058597-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use SZ_{8K, 128K} helper macro instead of the number in init_user_reserve
and reserve_mem_notifier. This is more readable.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
v2: use the right helper macro.
v1: https://lore.kernel.org/all/20240126085905.2835513-1-yajun.deng@linux.dev/
---
 mm/mmap.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 7000c14a039f..6722368a48dd 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3847,7 +3847,7 @@ static int init_user_reserve(void)
 
 	free_kbytes = K(global_zone_page_state(NR_FREE_PAGES));
 
-	sysctl_user_reserve_kbytes = min(free_kbytes / 32, 1UL << 17);
+	sysctl_user_reserve_kbytes = min(free_kbytes / 32, SZ_128K);
 	return 0;
 }
 subsys_initcall(init_user_reserve);
@@ -3868,7 +3868,7 @@ static int init_admin_reserve(void)
 
 	free_kbytes = K(global_zone_page_state(NR_FREE_PAGES));
 
-	sysctl_admin_reserve_kbytes = min(free_kbytes / 32, 1UL << 13);
+	sysctl_admin_reserve_kbytes = min(free_kbytes / 32, SZ_8K);
 	return 0;
 }
 subsys_initcall(init_admin_reserve);
@@ -3900,12 +3900,12 @@ static int reserve_mem_notifier(struct notifier_block *nb,
 	case MEM_ONLINE:
 		/* Default max is 128MB. Leave alone if modified by operator. */
 		tmp = sysctl_user_reserve_kbytes;
-		if (0 < tmp && tmp < (1UL << 17))
+		if (tmp > 0 && tmp < SZ_128K)
 			init_user_reserve();
 
 		/* Default max is 8MB.  Leave alone if modified by operator. */
 		tmp = sysctl_admin_reserve_kbytes;
-		if (0 < tmp && tmp < (1UL << 13))
+		if (tmp > 0 && tmp < SZ_8K)
 			init_admin_reserve();
 
 		break;
-- 
2.25.1


