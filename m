Return-Path: <linux-kernel+bounces-8938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EBF81BE55
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6936E1C24415
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4814E651B9;
	Thu, 21 Dec 2023 18:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iZOz0xdv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DA8BA5F
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 18:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703183749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FiI0FbwykV/2XbgOuJsaOX93jnuQZGsyNc8LlrDSdxY=;
	b=iZOz0xdvhazUGbDD/nkQ4ayAtlGnpXZBnWnzL0gh008WaAjCs/ptKU+lof1bjeEEnJT4H3
	m/04qiY03QGGFOPq+9Um1KjCZvu3EYR64rQmdOa8BsiMcU4UbcAkLwg4eDeQRQK3p7PEb3
	QlQ59oWVTbABhYd7X+p6qVYXgnw5aDw=
From: andrey.konovalov@linux.dev
To: Andrew Morton <akpm@linux-foundation.org>,
	Juntong Deng <juntong.deng@outlook.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>,
	Marco Elver <elver@google.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH mm 4/4] kasan: simplify kasan_complete_mode_report_info for tag-based modes
Date: Thu, 21 Dec 2023 19:35:40 +0100
Message-Id: <20231221183540.168428-4-andrey.konovalov@linux.dev>
In-Reply-To: <20231221183540.168428-1-andrey.konovalov@linux.dev>
References: <20231221183540.168428-1-andrey.konovalov@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Andrey Konovalov <andreyknvl@google.com>

memcpy the alloc/free tracks when collecting the information about a bad
access instead of copying fields one by one.

Fixes: 5d4c6ac94694 ("kasan: record and report more information")
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/report_tags.c | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/mm/kasan/report_tags.c b/mm/kasan/report_tags.c
index 688b9d70b04a..d15f8f580e2c 100644
--- a/mm/kasan/report_tags.c
+++ b/mm/kasan/report_tags.c
@@ -27,15 +27,6 @@ static const char *get_common_bug_type(struct kasan_report_info *info)
 	return "invalid-access";
 }
 
-#ifdef CONFIG_KASAN_EXTRA_INFO
-static void kasan_complete_extra_report_info(struct kasan_track *track,
-					 struct kasan_stack_ring_entry *entry)
-{
-	track->cpu = entry->track.cpu;
-	track->timestamp = entry->track.timestamp;
-}
-#endif /* CONFIG_KASAN_EXTRA_INFO */
-
 void kasan_complete_mode_report_info(struct kasan_report_info *info)
 {
 	unsigned long flags;
@@ -80,11 +71,8 @@ void kasan_complete_mode_report_info(struct kasan_report_info *info)
 			if (free_found)
 				break;
 
-			info->free_track.pid = entry->track.pid;
-			info->free_track.stack = entry->track.stack;
-#ifdef CONFIG_KASAN_EXTRA_INFO
-			kasan_complete_extra_report_info(&info->free_track, entry);
-#endif /* CONFIG_KASAN_EXTRA_INFO */
+			memcpy(&info->free_track, &entry->track,
+			       sizeof(info->free_track));
 			free_found = true;
 
 			/*
@@ -98,11 +86,8 @@ void kasan_complete_mode_report_info(struct kasan_report_info *info)
 			if (alloc_found)
 				break;
 
-			info->alloc_track.pid = entry->track.pid;
-			info->alloc_track.stack = entry->track.stack;
-#ifdef CONFIG_KASAN_EXTRA_INFO
-			kasan_complete_extra_report_info(&info->alloc_track, entry);
-#endif /* CONFIG_KASAN_EXTRA_INFO */
+			memcpy(&info->alloc_track, &entry->track,
+			       sizeof(info->alloc_track));
 			alloc_found = true;
 
 			/*
-- 
2.25.1


