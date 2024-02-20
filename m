Return-Path: <linux-kernel+bounces-72920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E53185BABA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE9C11F21C4F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE8467E85;
	Tue, 20 Feb 2024 11:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hx+4yBZK"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECA867E63
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 11:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708429051; cv=none; b=iItn5yb8Q4/NHhsWZWkhCWr+y/pb7guT3CShhnUMNuw8FVkNDLmZh+6vNvZGukzRssC8oCxmcnBqiCQUGBoCQg7O64uC8M7PqFa2Hn5JBVatsbsrZ5jvtL/Sds9Cs4dqIG4R98UkS/1ZodrheEJhONkfBEJoBBSlketTVaJHQBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708429051; c=relaxed/simple;
	bh=uHWg+XOhrK0zRFBt8wOq8bp9H9v8n5Lcorw+sL8Z3+E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mUNfXNj6RSVKWFKA6tNWLg5dN0v8jN85/NQMRlVESATL8B/eoSqakM+UeyZwJqtHGfoamevkoAsl+ANOGZSpgQTfpvITwV8XtJCs+oEtKV9I8xiPkDEMQmEPjh8vXdS9yjYvLnYwrN9jTFJV9oUDvnXV1t5nzNSjci30Q10graI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hx+4yBZK; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708429047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kzQqWreho0C7h7BUSKhkqs4L21k4ROBRD+6NpEqJHvk=;
	b=hx+4yBZK6F1f+K+KobCMKspcH9mU4c02Ya7/2WJ8h1KS2L4WAHusTpcx6exILhAFInTUL7
	SjK2RjNlhSZnKKiORgS17ixwOUfDdrDWC12dFCue+HGWSq6lKKLAGf7WKDev6RYIaevBYL
	y+iI/Zos7kTYfT5NxuryApctqyk8JNc=
From: Chengming Zhou <chengming.zhou@linux.dev>
Date: Tue, 20 Feb 2024 11:36:58 +0000
Subject: [PATCH RESEND 1/3] mm/zsmalloc: fix migrate_write_lock() when !CONFIG_COMPACTION
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240219-b4-szmalloc-migrate-v1-1-fc21039bed7b@linux.dev>
References: <20240219-b4-szmalloc-migrate-v1-0-fc21039bed7b@linux.dev>
In-Reply-To: <20240219-b4-szmalloc-migrate-v1-0-fc21039bed7b@linux.dev>
To: hannes@cmpxchg.org, Sergey Senozhatsky <senozhatsky@chromium.org>, Minchan Kim <minchan@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, nphamcs@gmail.com, yosryahmed@google.com
Cc: linux-mm@kvack.org, Chengming Zhou <zhouchengming@bytedance.com>, linux-kernel@vger.kernel.org
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708429041; l=2263;
 i=chengming.zhou@linux.dev; s=20240220; h=from:subject:message-id;
 bh=UHSVodPnpBiivncRsTV1Arftl0WePz5UFf9WpjK+7+4=;
 b=163nW1R+RMQ+orBAqT5aCtZHUFeStvc1n+OYnymxXb76UYU7LE63Rfti+6qmooU5Daaopmvrh
 ZVuF8XTU4yRCV6oUXqz5lv+X9XhHDAJCUFRaebMIpUHJhvKi7iKCv4M
X-Developer-Key: i=chengming.zhou@linux.dev; a=ed25519;
 pk=5+68Wfci+T30FoQos5RH+hfToF6SlC+S9LMPSPBFWuw=
X-Migadu-Flow: FLOW_OUT

From: Chengming Zhou <zhouchengming@bytedance.com>

migrate_write_lock() is a empty function when !CONFIG_COMPACTION, in
which case zs_compact() can be triggered from shrinker reclaim context.
(Maybe it's better to rename it to zs_shrink()?)

And zspage map object users rely on this migrate_read_lock() so object
won't be migrated elsewhere.

Fix it by always implementing the migrate_write_lock() related functions.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 mm/zsmalloc.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index c937635e0ad1..64d5533fa5d8 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -278,18 +278,15 @@ static bool ZsHugePage(struct zspage *zspage)
 static void migrate_lock_init(struct zspage *zspage);
 static void migrate_read_lock(struct zspage *zspage);
 static void migrate_read_unlock(struct zspage *zspage);
-
-#ifdef CONFIG_COMPACTION
 static void migrate_write_lock(struct zspage *zspage);
 static void migrate_write_lock_nested(struct zspage *zspage);
 static void migrate_write_unlock(struct zspage *zspage);
+
+#ifdef CONFIG_COMPACTION
 static void kick_deferred_free(struct zs_pool *pool);
 static void init_deferred_free(struct zs_pool *pool);
 static void SetZsPageMovable(struct zs_pool *pool, struct zspage *zspage);
 #else
-static void migrate_write_lock(struct zspage *zspage) {}
-static void migrate_write_lock_nested(struct zspage *zspage) {}
-static void migrate_write_unlock(struct zspage *zspage) {}
 static void kick_deferred_free(struct zs_pool *pool) {}
 static void init_deferred_free(struct zs_pool *pool) {}
 static void SetZsPageMovable(struct zs_pool *pool, struct zspage *zspage) {}
@@ -1725,7 +1722,6 @@ static void migrate_read_unlock(struct zspage *zspage) __releases(&zspage->lock)
 	read_unlock(&zspage->lock);
 }
 
-#ifdef CONFIG_COMPACTION
 static void migrate_write_lock(struct zspage *zspage)
 {
 	write_lock(&zspage->lock);
@@ -1741,6 +1737,7 @@ static void migrate_write_unlock(struct zspage *zspage)
 	write_unlock(&zspage->lock);
 }
 
+#ifdef CONFIG_COMPACTION
 /* Number of isolated subpage for *page migration* in this zspage */
 static void inc_zspage_isolation(struct zspage *zspage)
 {

-- 
b4 0.10.1

