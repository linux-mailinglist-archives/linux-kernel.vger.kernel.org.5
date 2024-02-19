Return-Path: <linux-kernel+bounces-71404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE4D85A4B0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3750A280E9A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52C1364A0;
	Mon, 19 Feb 2024 13:34:26 +0000 (UTC)
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97AA36132
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 13:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708349666; cv=none; b=h+me0FDY32gpEw1JrE0LfJ89JrGT7YUiWvaU9WZaqun9nWqLY5ufwYkjtMEp6qlaKbgtGnwWdFsRFkEh0HquyDvEZaaazNydSJI4QhfFahLl59hmzkod4GRwxa21O6uQOrlZA2PgjDqNDRMvBxYtTnhG2vrCCN6WKaHtc5FLiSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708349666; c=relaxed/simple;
	bh=JdvEpaaOt3u/5AIfoJOsMaPAQSgTKumQbch/+eRQXfg=;
	h=Subject:MIME-Version:Content-Type:From:Date:Message-Id:To:Cc; b=DCdsEkzL8gL5dDcyPCfIEqwLLQV92lN1lP9Vq/6fCnjMI6eIG7YvlXroFnahP/FDJMFZa3FtbUkNJ4JVzNt3uDhE+JFVHKQZILLto6DxmysMlPDE+fXANMyMCSMrsTqFnJYltxW0jX1tzypt5u2AzD0yYx7yR6nRZQnkVuCC2T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Subject: [PATCH 0/3] mm/zsmalloc: fix and optimize objects/page migration
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIAL5Y02UC/w3LwQqDMAwA0F+RnBdogjC6v0m6oIFaodEdJv67Pb7DuyCsuwV8pgu6/Tx8bwP0mq
 Cs0hZD/w4DJ54TU0adMf6b1LoX3Hzpchhmzm9iJtVEMKZKGGqXVtZx21nrfT9qY+S9agAAAA==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <zhouchengming@bytedance.com>
Date: Mon, 19 Feb 2024 13:33:50 +0000
Message-Id: <20240219-b4-szmalloc-migrate-v1-0-34cd49c6545b@bytedance.com>
To: nphamcs@gmail.com, yosryahmed@google.com, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Minchan Kim <minchan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, hannes@cmpxchg.org
Cc: linux-mm@kvack.org, Chengming Zhou <zhouchengming@bytedance.com>, linux-kernel@vger.kernel.org
X-Migadu-Flow: FLOW_OUT

Hello,

This series is to fix and optimize the zsmalloc objects/page migration.

patch 01 fix the empty migrate_write_lock() when !CONFIG_COMPACTION.
patch 02 remove the migrate_write_lock_nested() in objects migration.
patch 03 remove the unused zspage->isolated counter in page migration.

Thanks for review and comments!

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
Chengming Zhou (3):
      mm/zsmalloc: fix migrate_write_lock() when !CONFIG_COMPACTION
      mm/zsmalloc: remove migrate_write_lock_nested()
      mm/zsmalloc: remove unused zspage->isolated

 mm/zsmalloc.c | 63 ++++++++---------------------------------------------------
 1 file changed, 8 insertions(+), 55 deletions(-)
---
base-commit: 9951769060d8f5eb001acaca67c1439d2cfe1c6b
change-id: 20240219-b4-szmalloc-migrate-92971221bb01

Best regards,
-- 
Chengming Zhou <zhouchengming@bytedance.com>

