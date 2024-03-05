Return-Path: <linux-kernel+bounces-91867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 767928717A5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CA291F220D5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8707F469;
	Tue,  5 Mar 2024 08:10:22 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CEE7F46B
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 08:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709626222; cv=none; b=f/u/876e5vWlPeyv9F3TZhRc60NGk2Dw1XabvrlE20nn1oCYY7kou5iB6vOFoEj0yuZGgsWs5Yqu8GW7wdKB3DssURaAjNmrGxfyUTndp/p9cP5QIEC1xZ5XnJiqnKosI963LA1WIKZSMsuS+yoBOz5B54ROSL8jCBq0SjT08Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709626222; c=relaxed/simple;
	bh=MFPOX5W0KpeQ4hbxT4c8+pC/ewoeFCjUJSuVSnBF+1Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Jvx07wHyu6ugkQeRlmK4381obB6jrOXvO+kj3PBjhstCzFv9LMIrhfKMSeAO0giQVuoo+ZUCI5plndzfmhtHgeYG/iBphKBU7/l0w32uWxSH2qjXh4ISAvzxBea/3kaTs2uoqD17NQaihTuzFfEhjpm4ngh5ZQdOMSfwBT5HebQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from localhost.localdomain (78.37.41.175) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 5 Mar
 2024 11:10:02 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
CC: Roman Smirnov <r.smirnov@omp.ru>, Sergey Shtylyov <s.shtylyov@omp.ru>,
	Karina Yankevich <k.yankevich@omp.ru>,
	<linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH] f2fs: Cast expression type to unsigned long in __count_extent_cache()
Date: Tue, 5 Mar 2024 11:09:43 +0300
Message-ID: <20240305080943.6922-1-r.smirnov@omp.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 03/05/2024 07:39:20
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 183946 [Mar 05 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.3
X-KSE-AntiSpam-Info: Envelope from: r.smirnov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 8 0.3.8 4a99897b35b48c45ee5c877607d26a2d9f419920
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info:
	d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;78.37.41.175:7.4.1,7.7.3;127.0.0.199:7.1.2;omp.ru:7.1.1
X-KSE-AntiSpam-Info: {cloud_iprep_silent}
X-KSE-AntiSpam-Info: ApMailHostAddress: 78.37.41.175
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 03/05/2024 07:45:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 3/5/2024 3:38:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

Cast expression type to unsigned long in __count_extent_cache()
to prevent integer overflow.

Found by Linux Verification Center (linuxtesting.org) with Svace.

Signed-off-by: Roman Smirnov <r.smirnov@omp.ru>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---
 fs/f2fs/shrinker.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/shrinker.c b/fs/f2fs/shrinker.c
index 83d6fb97dcae..bb86a06c5d5e 100644
--- a/fs/f2fs/shrinker.c
+++ b/fs/f2fs/shrinker.c
@@ -33,7 +33,7 @@ static unsigned long __count_extent_cache(struct f2fs_sb_info *sbi,
 {
 	struct extent_tree_info *eti = &sbi->extent_tree[type];
 
-	return atomic_read(&eti->total_zombie_tree) +
+	return (unsigned long)atomic_read(&eti->total_zombie_tree) +
 				atomic_read(&eti->total_ext_node);
 }
 
-- 
2.34.1


