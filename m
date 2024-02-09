Return-Path: <linux-kernel+bounces-59305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBE384F4F3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 13:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 250FEB21D66
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 12:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE2C3219F;
	Fri,  9 Feb 2024 12:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wR6BtmIv"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5293F20311
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 12:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707480051; cv=none; b=VC+UzzpePF4FtojxCJilu07tM2sIZxkKMbW6IxxdgootLIE/MyOz7wkX5yPeE4aV+5Bk273sUKQriQPt3/v0qjJCZGk2zbgRYCaNZ4XP1NeV39cx6njlxeJO6VYizrYsTP7/jDmsTz1zn4luGtKeosTI15aeZsf4e4msahap7+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707480051; c=relaxed/simple;
	bh=KEBYIrTh33UwK7TabHpZdff+4ImJ7WjKDWafJZ2lFVU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qKgjBCvrKt7ZkU+nheUQHexUr8nckZtqlIkRuEh7KajL54BQkRR+JqgAS/3OcfVYHcdKAh4GG0QHw754wODjpL6QZ5nDF0lsUXuY/4cJfFVp1HOmYMv2zxulqmr9Hx24yrBYoXf36qfJZ7eDzQv6kIUZjthZBxmcpPhoxMS/R0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wR6BtmIv; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707480043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H8vjJet6cEqjnm/AF8gtjZ0cWAGZljlA0TlT1cQYzHE=;
	b=wR6BtmIvXYaNDb25zKYBYPeL0CPBfaQZ6v/7Gr9UKiDDQsSWzzxx4NdEmrRZKajRv9ME6N
	YsugFwG1wpt+u3qF0D4YGlMz3v4TtSyRVvNUgXu4jBEGgLtudbwWMSYJdnGOcP8klAr4e6
	uQsskjmJ2Pdx40q3SmNvSRxSqYIGhG8=
From: chengming.zhou@linux.dev
To: willy@infradead.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	chengming.zhou@linux.dev,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH RFC 1/1] mm/swap: queue reclaimable folio to local rotate batch when !folio_test_lru()
Date: Fri,  9 Feb 2024 11:59:50 +0000
Message-Id: <20240209115950.3885183-2-chengming.zhou@linux.dev>
In-Reply-To: <20240209115950.3885183-1-chengming.zhou@linux.dev>
References: <20240209115950.3885183-1-chengming.zhou@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Chengming Zhou <zhouchengming@bytedance.com>

All LRU move interfaces have a problem that it has no effect if the
folio is isolated from LRU (in cpu batch or isolated by shrinker).
Since it can't move/change folio LRU status when it's isolated, mostly
just clear the folio flag and do nothing in this case.

In our case, a written back and reclaimable folio won't be rotated to
the tail of inactive list, since it's still in cpu lru_add batch. It
may cause the delayed reclaim of this folio and evict other folios.

This patch changes to queue the reclaimable folio to cpu rotate batch
even when !folio_test_lru(), hoping it will likely be handled after
the lru_add batch which will put folio on the LRU list first, so
will be rotated to the tail successfully when handle rotate batch.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 mm/swap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index cd8f0150ba3a..d304731e47cf 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -236,7 +236,8 @@ static void folio_batch_add_and_move(struct folio_batch *fbatch,
 
 static void lru_move_tail_fn(struct lruvec *lruvec, struct folio *folio)
 {
-	if (!folio_test_unevictable(folio)) {
+	if (!folio_test_locked(folio) && !folio_test_dirty(folio) &&
+	    !folio_test_unevictable(folio) && !folio_test_active(folio)) {
 		lruvec_del_folio(lruvec, folio);
 		folio_clear_active(folio);
 		lruvec_add_folio_tail(lruvec, folio);
@@ -254,7 +255,7 @@ static void lru_move_tail_fn(struct lruvec *lruvec, struct folio *folio)
 void folio_rotate_reclaimable(struct folio *folio)
 {
 	if (!folio_test_locked(folio) && !folio_test_dirty(folio) &&
-	    !folio_test_unevictable(folio) && folio_test_lru(folio)) {
+	    !folio_test_unevictable(folio) && !folio_test_active(folio)) {
 		struct folio_batch *fbatch;
 		unsigned long flags;
 
-- 
2.40.1


