Return-Path: <linux-kernel+bounces-39865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F5A83D6D3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A6B91C277AF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD2650A8A;
	Fri, 26 Jan 2024 08:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hZaTYq6y"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59C150A83
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 08:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706259564; cv=none; b=VRQvrlpPCdj9MXviaVch/Ry/aXRRpqbktkNIQlKPFeBguuZQ4EiSJ2OJw+gxwhKNu4l57gfLX2XCClZchBkmK6mby2EtXfkJcmuJPVpqSOD2K0ugkQ7y9Ol8GuNYNjRbDwq5h0+kfzsFVR6chSKV542PPPQKbuatypjzFPtLm6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706259564; c=relaxed/simple;
	bh=836H8CGuHwNWoT8y45F3p7ZGOUU+Or9lzM4KtbucyVI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sShKV55zVqHWYp90qLU3hOTarktDtTC1HVazSczblP+6lL0RPqFRCsXRdBvmT8KvoVF/39VGccGfx2/MsMCvMR/1t1Tq36zPCbrwI4fa8RH6OJG3xziO9lzFEoOcwQpWkMZCNxaEYJuGIuV+NN3fvRH4yFG+qSb0uGjG4quzhvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hZaTYq6y; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706259559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UEiYHt6EA6JI2A3oFzAKFbfq5nte6C1ofdfTW06tbP8=;
	b=hZaTYq6yORpyB61XP6FMuKwBdf5riISYuB3djvq9huZIB+zXVjpCYtDIbBToipBg9QPfet
	CYsKkoucQO52QVjWiED1IvybA9EJBl5Or/kkOqLNp40LRro9eS0hDb+jFjPzQfPdSiwIyM
	+RiZki+Mn0KsyOk3pt7xvKYoflnmRGE=
From: Yajun Deng <yajun.deng@linux.dev>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH] mm/mmap: use SZ_{8M, 128M} helper macro
Date: Fri, 26 Jan 2024 16:59:05 +0800
Message-Id: <20240126085905.2835513-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use SZ_{8M, 128M} macro intead of the number in init_user_reserve and
reserve_mem_notifier.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 mm/mmap.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 476de5daf598..f90924b2a6d2 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3845,7 +3845,7 @@ static int init_user_reserve(void)
 
 	free_kbytes = K(global_zone_page_state(NR_FREE_PAGES));
 
-	sysctl_user_reserve_kbytes = min(free_kbytes / 32, 1UL << 17);
+	sysctl_user_reserve_kbytes = min(free_kbytes / 32, SZ_128M);
 	return 0;
 }
 subsys_initcall(init_user_reserve);
@@ -3866,7 +3866,7 @@ static int init_admin_reserve(void)
 
 	free_kbytes = K(global_zone_page_state(NR_FREE_PAGES));
 
-	sysctl_admin_reserve_kbytes = min(free_kbytes / 32, 1UL << 13);
+	sysctl_admin_reserve_kbytes = min(free_kbytes / 32, SZ_8M);
 	return 0;
 }
 subsys_initcall(init_admin_reserve);
@@ -3898,12 +3898,12 @@ static int reserve_mem_notifier(struct notifier_block *nb,
 	case MEM_ONLINE:
 		/* Default max is 128MB. Leave alone if modified by operator. */
 		tmp = sysctl_user_reserve_kbytes;
-		if (0 < tmp && tmp < (1UL << 17))
+		if (tmp > 0 && tmp < SZ_128M)
 			init_user_reserve();
 
 		/* Default max is 8MB.  Leave alone if modified by operator. */
 		tmp = sysctl_admin_reserve_kbytes;
-		if (0 < tmp && tmp < (1UL << 13))
+		if (tmp > 0 && tmp < SZ_8M)
 			init_admin_reserve();
 
 		break;
-- 
2.25.1


